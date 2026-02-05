# Supabase SQL Editor 指令汇总（Tenebralis Dream System / TenebralisApp）

> 目的：集中记录所有在 Supabase Dashboard → SQL Editor 中执行过的建表 / 扩展 / 函数 / 触发器 / RLS 策略等指令。
> 
> 使用方式：
> - 本文件按 Part 分段整理，便于对照产品需求与数据库演进。
> - 每个 Part 内会包含：目标、执行顺序、SQL（原样记录）、以及“可选增强/注意事项”（不改 SQL，只提供建议）。
> - 若他人自部署 Supabase，可按 Part 顺序在 SQL Editor 逐段执行。

---

## Part 1 - Core Identity & Settings（Profile + Setting）

### 目标
- 创建用户主档案表 `public.users`（对接 `auth.users`）。
- 创建用户设置表 `public.user_settings`。
- 新用户注册时自动初始化：插入 `public.users` 与 `public.user_settings`。
- 启用 RLS：用户只能操作自己的 profile 和 settings。

### SQL Editor 指令（按执行顺序，原样记录）

```sql
create table if not exists public.users (
  id uuid references auth.users(id) on delete cascade not null primary key,
  username text unique,
  display_name text,
  avatar_url text,
  bio text,
  system_level int default 1,
  exp_points bigint default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists public.user_settings (
  user_id uuid references public.users(id) on delete cascade not null primary key,
  ui_config jsonb default '{"theme_mode": "light", "primary_color": "#A0C4FF", "font_family": "System", "wallpaper_url": null}'::jsonb,
  system_preferences jsonb default '{"language": "zh_CN", "enable_notifications": true, "ai_personality_mode": "standard"}'::jsonb,
  updated_at timestamptz default now()
);

create extension if not exists moddatetime schema extensions;

create trigger handle_updated_at before update on public.users
  for each row execute procedure moddatetime (updated_at);

create trigger handle_settings_updated_at before update on public.user_settings
  for each row execute procedure moddatetime (updated_at);

alter table public.users enable row level security;
alter table public.user_settings enable row level security;

create policy "Users can operate on own profile only"
  on public.users for all
  using ( auth.uid() = id );

create policy "Settings are private"
  on public.user_settings for all
  using ( auth.uid() = user_id );

-- 1. 重新定义函数，显式设置 search_path 
-- 这将消除 Security Advisor 的警告并增强安全性
create or replace function public.handle_new_user()
returns trigger 
language plpgsql 
security definer 
set search_path = public
as $$
begin
  -- 使用 ON CONFLICT 防止重复插入导致的错误
  insert into public.users (id, username, display_name, avatar_url)
  values (
    new.id, 
    new.raw_user_meta_data->>'username', 
    coalesce(new.raw_user_meta_data->>'full_name', 'Dreamer'),
    new.raw_user_meta_data->>'avatar_url'
  )
  on conflict (id) do nothing;

  insert into public.user_settings (user_id)
  values (new.id)
  on conflict (user_id) do nothing;

  return new;
end;
$$;

-- 2. (可选) 重新绑定触发器（确保触发器使用的是最新定义的函数）
-- 这一步通常不是必须的，因为 create or replace 会直接更新函数体，但为了保险可以运行
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
```

### 可选增强 / 注意事项（不改上面的 SQL，仅供参考）
1. `RLS policy` 的 `for all using (...)`：
   - 严格来说，`INSERT` 往往更推荐同时写 `WITH CHECK (...)`（防止插入时绕过条件）。
   - 例如：
     - `USING (auth.uid() = id)` 用于 SELECT/UPDATE/DELETE
     - `WITH CHECK (auth.uid() = id)` 用于 INSERT/UPDATE 写入校验
   - 你当前写法在很多场景可工作，但后续如果遇到插入/更新异常或安全边界想更严谨，建议拆开。

2. `moddatetime` 扩展与 schema：
   - 你使用 `schema extensions`，需要确认 Supabase 项目里确实存在该 schema（Supabase 通常有 `extensions` schema）。

3. `security definer` 的新用户触发器函数：
   - 这是常见做法，但建议确保函数 `search_path` 安全（防止对象劫持）。后续可以考虑：
     - `create or replace function ... set search_path = public, extensions, pg_temp;`

4. `username` 唯一但可空：
   - Postgres 中 `unique` 对 `NULL` 允许多个（即多个 NULL 不冲突）。如果你希望 username 必填，需要加 `not null` 或在应用层保证。

5. 触发器幂等性：
   - 你对 `on_auth_user_created` 做了 `drop trigger if exists`，很好。
   - 但对 `handle_updated_at` 和 `handle_settings_updated_at` 没有 drop；重复执行可能会报“trigger 已存在”。
   - 后续如果你希望整段可重复执行，可以把这两个 trigger 也改成 drop+create 的模式（这里先仅提示，不改你的原始记录）。

---

## Part 2 - World System（Worlds + Identities + Save States）

### 目标
- 创建私有世界表 `public.worlds`（用户自建、不分享）。
- 创建世界身份表 `public.user_world_identities`（同世界多身份）。
- 创建世界存档表 `public.world_save_states`（多存档位 slot + chapter/stage）。
- 强隔离：每表带 `user_id`，并用复合外键 `(id, user_id)` 防止跨用户串联。
- AI 上下文注入友好：每层提供 `prompt_*_text` 文本字段用于直接注入；JSONB 仅承载结构化状态。

### SQL Editor 指令（按执行顺序，原样记录）

```sql
-- =========================================================
-- Part 2 - World System（worlds / identities / save states）
-- Goals:
-- - Private user-created worlds (no sharing)
-- - Strong user isolation: composite FK (id, user_id)
-- - AI prompt-friendly text fields (prompt_*_text)
-- - Multi-save slots + chapter/stage anchors
-- - No duplicate names (worlds per user; identities per world)
-- =========================================================

-- 0) Extension (already in Part1, safe to keep)
create extension if not exists moddatetime schema extensions;

-- 1) Worlds
create table if not exists public.worlds (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  name text not null,
  description text,
  status text not null default 'active', -- active/archived

  -- Prompt-friendly text (stable for LLM context injection)
  prompt_lore_text text,

  -- Structured configs (evolvable without breaking prompt)
  lore_json jsonb default '{}'::jsonb,
  rules_json jsonb default '{}'::jsonb,
  ai_context_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  -- Name uniqueness within user scope
  constraint worlds_user_name_unique unique (user_id, name),

  -- Composite uniqueness for strong isolation FK references
  constraint worlds_id_user_unique unique (id, user_id)
);

-- updated_at trigger (idempotent)
drop trigger if exists handle_worlds_updated_at on public.worlds;
create trigger handle_worlds_updated_at
  before update on public.worlds
  for each row execute procedure moddatetime (updated_at);

-- Helpful indexes
create index if not exists idx_worlds_user_updated_at
  on public.worlds (user_id, updated_at desc);

create index if not exists idx_worlds_user_status
  on public.worlds (user_id, status);



-- 2) User World Identities
create table if not exists public.user_world_identities (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  -- Important: world_id references worlds but with composite FK to enforce same user_id
  world_id uuid not null,

  identity_name text not null,
  is_active boolean not null default true,

  -- Prompt-friendly text
  prompt_identity_text text,

  -- Structured identity data
  role_data_json jsonb default '{}'::jsonb,
  persona_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  -- No duplicate identity name within a world
  constraint identities_world_name_unique unique (world_id, identity_name),

  -- Composite uniqueness for strong isolation FK references
  constraint identities_id_user_unique unique (id, user_id),

  -- Composite FK ensures the referenced world belongs to the same user_id
  constraint identities_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade
);

drop trigger if exists handle_identities_updated_at on public.user_world_identities;
create trigger handle_identities_updated_at
  before update on public.user_world_identities
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_identities_user_world
  on public.user_world_identities (user_id, world_id);



-- 3) World Save States (multi-slot)
create table if not exists public.world_save_states (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  world_id uuid not null,
  identity_id uuid not null,

  -- Multi-slot save
  slot int not null check (slot > 0),

  title text,
  summary text,

  -- Structured anchors for UI + stable prompt template injection
  chapter text,
  stage text,

  -- Prompt-friendly progress summary (stable for LLM)
  prompt_progress_text text,

  -- Full structured game state
  state_json jsonb not null default '{}'::jsonb,

  last_played_at timestamptz,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  -- Slot uniqueness per identity (multi saves)
  constraint save_identity_slot_unique unique (identity_id, slot),

  -- Composite FK ensures world belongs to same user_id
  constraint saves_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  -- Composite FK ensures identity belongs to same user_id
  constraint saves_identity_user_fk
    foreign key (identity_id, user_id)
    references public.user_world_identities (id, user_id)
    on delete cascade
);

drop trigger if exists handle_save_states_updated_at on public.world_save_states;
create trigger handle_save_states_updated_at
  before update on public.world_save_states
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_save_identity_last_played
  on public.world_save_states (identity_id, last_played_at desc);

create index if not exists idx_save_user_world
  on public.world_save_states (user_id, world_id);



-- 4) RLS enable
alter table public.worlds enable row level security;
alter table public.user_world_identities enable row level security;
alter table public.world_save_states enable row level security;

-- 5) RLS policies (strict: USING + WITH CHECK)
drop policy if exists "Worlds are private" on public.worlds;
create policy "Worlds are private"
  on public.worlds for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "World identities are private" on public.user_world_identities;
create policy "World identities are private"
  on public.user_world_identities for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "World save states are private" on public.world_save_states;
create policy "World save states are private"
  on public.world_save_states for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
```

### 可选增强 / 注意事项（不改上面的 SQL，仅供参考）
1. `gen_random_uuid()` 依赖扩展：
   - 若你的 Supabase 项目未默认开启 `pgcrypto`，可能需要：
     - `create extension if not exists pgcrypto;`
   - 部分 Supabase 项目已默认可用。

2. `moddatetime` 触发器与幂等性：
   - 本段对 `handle_worlds_updated_at / handle_identities_updated_at / handle_save_states_updated_at` 采用了 `drop trigger if exists`，可重复执行。

3. JSONB 与 prompt 文本的分工：
   - `prompt_*_text` 建议保持“可直接注入”的段落化文本，并控制长度。
   - `*_json` 用于结构化状态与可计算数据，方便后续任务/解锁/条件判断。

4. 唯一性范围：
   - `worlds`：同一 `user_id` 下 `name` 不允许重名。
   - `user_world_identities`：同一 `world_id` 下 `identity_name` 不允许重名。

---

## Part 3 - AI Interaction & NPC（NPC + Conversations + Messages）

### 目标
- 创建用户全局 NPC 表 `public.npcs`（跨世界复用）。
- 创建对话会话表 `public.conversations`：必须绑定 `save_id`（分支）与 `npc_id`（对话对象），并支持同一 `save_id + npc_id` 多会话线程（用 `thread_key`）。
- 创建消息流表 `public.conversation_messages`：按 `seq` 保序，支持导入导出稳定复现，并用 `metadata_json` 记录模型、token、工具调用等信息。
- 创建关系表 `public.user_npc_relationships`：关系随世界变化（`world_id` NOT NULL）。
- 强隔离：每表带 `user_id`，并使用复合外键 `(id, user_id)` 防止跨用户串联。

### SQL Editor 指令（按执行顺序，原样记录）

```sql
-- =========================================================
-- Part 3 - AI Interaction & NPC
-- Tables:
-- - npcs
-- - conversations
-- - conversation_messages
-- - user_npc_relationships
--
-- Key constraints:
-- - Strong isolation via user_id everywhere + composite FKs (id, user_id)
-- - conversations.save_id NOT NULL (branch-bound)
-- - conversations.npc_id  NOT NULL (all chats are with an NPC/assistant)
-- - allow multiple threads per (save_id, npc_id) using thread_key
-- - relationships are world-scoped (world_id NOT NULL)
-- =========================================================

-- Extensions
create extension if not exists moddatetime schema extensions;
create extension if not exists pgcrypto;

-- 1) NPCs (global per user)
create table if not exists public.npcs (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  name text not null,
  description text,

  -- Prompt-friendly NPC persona (direct LLM injection)
  prompt_npc_text text,

  -- Structured persona config
  persona_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  -- No duplicate npc name within same user
  constraint npcs_user_name_unique unique (user_id, name),

  -- Composite uniqueness for strong isolation FK references
  constraint npcs_id_user_unique unique (id, user_id)
);

drop trigger if exists handle_npcs_updated_at on public.npcs;
create trigger handle_npcs_updated_at
  before update on public.npcs
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_npcs_user_updated_at
  on public.npcs (user_id, updated_at desc);



-- 2) Conversations (thread container)
create table if not exists public.conversations (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  -- Branch-bound + NPC-bound
  save_id uuid not null,
  npc_id uuid not null,

  -- Allow multiple threads per (save_id, npc_id)
  thread_key text not null,

  title text,
  summary text,

  -- Optional: fixed context snapshot for export/import stability
  pinned_context_text text,

  last_message_at timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  -- Composite uniqueness for strong isolation FK references
  constraint conversations_id_user_unique unique (id, user_id),

  -- Composite FK: save belongs to same user
  constraint conversations_save_user_fk
    foreign key (save_id, user_id)
    references public.world_save_states (id, user_id)
    on delete cascade,

  -- Composite FK: npc belongs to same user
  constraint conversations_npc_user_fk
    foreign key (npc_id, user_id)
    references public.npcs (id, user_id)
    on delete cascade,

  -- Prevent accidental duplicate thread within same save+npc
  constraint conversations_thread_unique unique (user_id, save_id, npc_id, thread_key)
);

drop trigger if exists handle_conversations_updated_at on public.conversations;
create trigger handle_conversations_updated_at
  before update on public.conversations
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_conversations_user_save
  on public.conversations (user_id, save_id);

create index if not exists idx_conversations_user_npc
  on public.conversations (user_id, npc_id);

create index if not exists idx_conversations_last_message_at
  on public.conversations (user_id, last_message_at desc);



-- 3) Conversation Messages (message stream)
create table if not exists public.conversation_messages (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,
  conversation_id uuid not null,

  -- Message order within conversation (stable for export/import)
  seq int not null check (seq > 0),

  -- user/assistant/system/tool
  role text not null,

  content text not null,

  -- Model / token usage / tool calls / tracing etc.
  metadata_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),

  -- Composite FK ensures message belongs to same user's conversation
  constraint messages_conversation_user_fk
    foreign key (conversation_id, user_id)
    references public.conversations (id, user_id)
    on delete cascade,

  -- Ensure stable ordering without collisions
  constraint messages_conversation_seq_unique unique (conversation_id, seq),

  -- Role guard (prevents dirty data)
  constraint messages_role_check check (role in ('user','assistant','system','tool'))
);

create index if not exists idx_messages_conversation_seq
  on public.conversation_messages (conversation_id, seq);

create index if not exists idx_messages_user_created_at
  on public.conversation_messages (user_id, created_at desc);



-- 4) User-NPC relationships (world-scoped)
create table if not exists public.user_npc_relationships (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  -- world-scoped relationship (NOT NULL as per decision)
  world_id uuid not null,

  npc_id uuid not null,

  affinity int not null default 0,
  status text default 'neutral', -- neutral/friendly/close/...

  flags_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  -- Composite uniqueness for strong isolation FK references
  constraint relationships_id_user_unique unique (id, user_id),

  -- Composite FK: world belongs to same user
  constraint relationships_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  -- Composite FK: npc belongs to same user
  constraint relationships_npc_user_fk
    foreign key (npc_id, user_id)
    references public.npcs (id, user_id)
    on delete cascade,

  -- One relationship per (user, world, npc)
  constraint relationships_unique unique (user_id, world_id, npc_id)
);

drop trigger if exists handle_relationships_updated_at on public.user_npc_relationships;
create trigger handle_relationships_updated_at
  before update on public.user_npc_relationships
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_relationships_user_world
  on public.user_npc_relationships (user_id, world_id);

create index if not exists idx_relationships_user_npc
  on public.user_npc_relationships (user_id, npc_id);



-- 5) RLS enable
alter table public.npcs enable row level security;
alter table public.conversations enable row level security;
alter table public.conversation_messages enable row level security;
alter table public.user_npc_relationships enable row level security;

-- 6) RLS policies (strict: USING + WITH CHECK)
drop policy if exists "NPCs are private" on public.npcs;
create policy "NPCs are private"
  on public.npcs for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Conversations are private" on public.conversations;
create policy "Conversations are private"
  on public.conversations for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Conversation messages are private" on public.conversation_messages;
create policy "Conversation messages are private"
  on public.conversation_messages for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "NPC relationships are private" on public.user_npc_relationships;
create policy "NPC relationships are private"
  on public.user_npc_relationships for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
```

### 可选增强 / 注意事项（不改上面的 SQL，仅供参考）
1. `thread_key` 的生成规范（强烈建议写入客户端约定）：
   - 由客户端生成，并在同一会话线程生命周期内保持不变。
   - 导入导出时，可用 `(user_id, save_id, npc_id, thread_key)` 作为去重键。

2. `seq` 的维护策略：
   - 建议从 1 开始递增，并保持会话内唯一。
   - 相比仅依赖 `created_at`，`seq` 更利于导入导出时稳定复现顺序。

3. `metadata_json` 推荐结构（不强制）：
   - 可包含：`model`、`token_usage`、`latency_ms`、`tool_calls`、`tool_results`、`request_id/trace_id`。

4. 自动维护 `conversations.last_message_at`（可选增强）：
   - 可在 `conversation_messages` 插入后通过触发器更新 `conversations.last_message_at`，减少应用层漏更新风险。

5. 系统助手对话的实现建议：
   - 因为 `conversations.npc_id` NOT NULL，建议每个用户创建一个默认 NPC（如 `SystemAssistant`），所有系统/助手会话均绑定该 NPC。

---

## Part 4 - Tasks & Achievements（Tasks + Progress + Achievements）

### 目标
- 创建用户私有任务定义表：`public.tasks`（可选绑定 `world_id`，支持全局/世界任务）。
- 创建用户任务进度表：`public.user_tasks`（支持 `global` 与 `save` 两种进度作用域；用部分唯一索引保证不重复）。
- 创建用户私有成就定义表：`public.achievements`（可选绑定 `world_id`，支持全局/世界成就）。
- 创建用户成就进度/解锁表：`public.user_achievements`（同样支持 `global` 与 `save` 两种作用域；用部分唯一索引保证不重复）。
- 支持 AI 辅助判定：定义表提供 `prompt_*_text`（直接注入）与 `criteria_json`（结构化判定条件）；进度表提供 `evidence_json`（判定证据/引用）与 `last_evaluated_at`。
- 强隔离：每表带 `user_id`，并使用复合外键 `(id, user_id)` 防止跨用户串联。

### SQL Editor 指令（按执行顺序，原样记录）

```sql
-- =========================================================
-- Part 4 - Tasks & Achievements
-- Tables:
-- - tasks
-- - user_tasks
-- - achievements
-- - user_achievements
--
-- Key constraints:
-- - All definitions are per-user private (tasks/achievements include user_id)
-- - Definitions can optionally bind world_id (NULL = global definition)
-- - Progress supports scope_type: 'global' | 'save'
-- - Partial unique indexes prevent duplicate progress rows (esp. global with NULL save_id)
-- - Strong isolation via user_id everywhere + composite FKs (id, user_id)
-- =========================================================

create extension if not exists moddatetime schema extensions;
create extension if not exists pgcrypto;

-- 1) Tasks (private definitions)
create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  -- Optional world binding: NULL = global task definition
  world_id uuid,

  name text not null,
  description text,

  -- main/side/daily/system/etc.
  task_type text default 'side',

  -- Definition scope: what kind of progress rows it can have
  -- global: one progress per user
  -- save: one progress per save branch
  scope_type text not null check (scope_type in ('global','save')),

  -- Prompt-friendly text for direct injection into AI context
  prompt_task_text text,

  -- Structured criteria for AI/programmatic evaluation
  criteria_json jsonb default '{}'::jsonb,

  -- Optional reward structure
  reward_json jsonb default '{}'::jsonb,

  -- manual|ai|system_seed
  created_source text default 'manual',

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  -- No duplicate names within same user + same world scope
  -- (NULL world_id is allowed; uniqueness with NULL behaves as "multiple NULL allowed")
  constraint tasks_user_world_name_unique unique (user_id, world_id, name),

  -- Composite uniqueness for strong isolation FK references
  constraint tasks_id_user_unique unique (id, user_id),

  -- Composite FK ensures world belongs to same user when set
  constraint tasks_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade
);

drop trigger if exists handle_tasks_updated_at on public.tasks;
create trigger handle_tasks_updated_at
  before update on public.tasks
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_tasks_user_world
  on public.tasks (user_id, world_id);

create index if not exists idx_tasks_user_scope
  on public.tasks (user_id, scope_type);



-- 2) User task progress
create table if not exists public.user_tasks (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  task_id uuid not null,

  -- 'global' | 'save'
  scope_type text not null check (scope_type in ('global','save')),

  -- When scope_type='save' => save_id NOT NULL; when global => save_id MUST be NULL
  save_id uuid,

  -- not_started/in_progress/completed/claimed/failed
  status text not null default 'not_started',

  -- Structured progress tracking
  progress_json jsonb not null default '{}'::jsonb,

  -- Optional numeric cache for quick sorting/filtering
  progress_value numeric default 0,

  -- Evidence / citation for AI evaluation (why it is completed)
  evidence_json jsonb default '{}'::jsonb,
  last_evaluated_at timestamptz,

  completed_at timestamptz,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  -- Composite FK ensures task belongs to same user
  constraint user_tasks_task_user_fk
    foreign key (task_id, user_id)
    references public.tasks (id, user_id)
    on delete cascade,

  -- Composite FK ensures save belongs to same user (only meaningful for save scope)
  constraint user_tasks_save_user_fk
    foreign key (save_id, user_id)
    references public.world_save_states (id, user_id)
    on delete cascade,

  -- Scope/data consistency
  constraint user_tasks_scope_save_check check (
    (scope_type = 'global' and save_id is null)
    or
    (scope_type = 'save' and save_id is not null)
  )
);

drop trigger if exists handle_user_tasks_updated_at on public.user_tasks;
create trigger handle_user_tasks_updated_at
  before update on public.user_tasks
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_user_tasks_user_status
  on public.user_tasks (user_id, status);

create index if not exists idx_user_tasks_user_save
  on public.user_tasks (user_id, save_id);

create index if not exists idx_user_tasks_task
  on public.user_tasks (task_id);

-- Partial unique indexes to prevent duplicates
-- Global progress: exactly one row per (user, task)
create unique index if not exists uq_user_tasks_global
  on public.user_tasks (user_id, task_id)
  where scope_type = 'global';

-- Save progress: exactly one row per (user, task, save)
create unique index if not exists uq_user_tasks_save
  on public.user_tasks (user_id, task_id, save_id)
  where scope_type = 'save';



-- 3) Achievements (private definitions)
create table if not exists public.achievements (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  -- Optional world binding: NULL = global achievement
  world_id uuid,

  name text not null,
  description text,

  -- global|save
  scope_type text not null check (scope_type in ('global','save')),

  -- Prompt-friendly text
  prompt_achievement_text text,

  -- Structured criteria for evaluation
  criteria_json jsonb default '{}'::jsonb,

  -- manual|ai|system_seed
  created_source text default 'manual',

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  constraint achievements_user_world_name_unique unique (user_id, world_id, name),
  constraint achievements_id_user_unique unique (id, user_id),

  constraint achievements_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade
);

drop trigger if exists handle_achievements_updated_at on public.achievements;
create trigger handle_achievements_updated_at
  before update on public.achievements
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_achievements_user_world
  on public.achievements (user_id, world_id);

create index if not exists idx_achievements_user_scope
  on public.achievements (user_id, scope_type);



-- 4) User achievement progress / unlock
create table if not exists public.user_achievements (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  achievement_id uuid not null,

  scope_type text not null check (scope_type in ('global','save')),
  save_id uuid,

  -- locked/in_progress/unlocked
  status text not null default 'locked',

  progress_json jsonb not null default '{}'::jsonb,
  progress_value numeric default 0,

  evidence_json jsonb default '{}'::jsonb,
  last_evaluated_at timestamptz,

  unlocked_at timestamptz,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  constraint user_achievements_achievement_user_fk
    foreign key (achievement_id, user_id)
    references public.achievements (id, user_id)
    on delete cascade,

  constraint user_achievements_save_user_fk
    foreign key (save_id, user_id)
    references public.world_save_states (id, user_id)
    on delete cascade,

  constraint user_achievements_scope_save_check check (
    (scope_type = 'global' and save_id is null)
    or
    (scope_type = 'save' and save_id is not null)
  )
);

drop trigger if exists handle_user_achievements_updated_at on public.user_achievements;
create trigger handle_user_achievements_updated_at
  before update on public.user_achievements
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_user_achievements_user_status
  on public.user_achievements (user_id, status);

create index if not exists idx_user_achievements_user_save
  on public.user_achievements (user_id, save_id);

create index if not exists idx_user_achievements_achievement
  on public.user_achievements (achievement_id);

-- Partial unique indexes
create unique index if not exists uq_user_achievements_global
  on public.user_achievements (user_id, achievement_id)
  where scope_type = 'global';

create unique index if not exists uq_user_achievements_save
  on public.user_achievements (user_id, achievement_id, save_id)
  where scope_type = 'save';



-- 5) RLS enable
alter table public.tasks enable row level security;
alter table public.user_tasks enable row level security;
alter table public.achievements enable row level security;
alter table public.user_achievements enable row level security;

-- 6) RLS policies (strict: USING + WITH CHECK)
drop policy if exists "Tasks are private" on public.tasks;
create policy "Tasks are private"
  on public.tasks for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "User tasks are private" on public.user_tasks;
create policy "User tasks are private"
  on public.user_tasks for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Achievements are private" on public.achievements;
create policy "Achievements are private"
  on public.achievements for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "User achievements are private" on public.user_achievements;
create policy "User achievements are private"
  on public.user_achievements for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
```

### 可选增强 / 注意事项（不改上面的 SQL，仅供参考）
1. 关于 `unique(user_id, world_id, name)`：
   - Postgres 的 UNIQUE 对 `world_id = NULL` 会允许多个 NULL（即多个全局任务同名不会被阻止）。
   - 若你希望“全局任务名也不允许重名”，可追加一个部分唯一索引：
     - `create unique index ... on tasks(user_id, name) where world_id is null;`
   - achievements 同理。

2. AI 自动判定完成的推荐流程（应用层/Edge Function）：
   - 取当前上下文（world/identity/save 的 prompt_*_text + 最近对话 messages + 当前 user_tasks/user_achievements）。
   - 让 AI 输出结构化评估结果（例如：哪些 task_id 达成、更新哪些 progress_json）。
   - 写回 `status/progress_json/evidence_json/last_evaluated_at`。

3. `criteria_json` 建议统一 schema（渐进式即可）：
   - counter/flag/contains/regex 等少量类型就足够启动。

---

## Part 5 - Social & Economy（World Forum + Shop + Currency）

### 目标
- 创建世界内私有论坛：`public.forum_posts` + `public.forum_comments`（必须绑定 `world_id`）。
- 支持多来源作者：user / assistant / npc / identity / system / ai。
- NPC 发帖/评论需绑定 world 内 persona 映射：`public.world_npc_personas`（同一 world 下同一 npc 仅允许一个 persona）。
- 论坛管理字段：置顶/锁帖/仅 AI 可评论 等。
- 经济系统：新增 `public.currency_accounts`（余额账户）+ `public.currency_transactions`（流水），支持全局/世界可选货币。
- 商店与库存：`public.shop_items` + `public.user_inventory`，商品价格通过 `currency_code` 指向账户扣款（由应用层执行）。
- 强隔离：每表带 `user_id`，并使用复合外键 `(id, user_id)` 防止跨用户串联。

### SQL Editor 指令（按执行顺序，原样记录）

```sql
-- =========================================================
-- Part 5 - Social & Economy
-- Tables:
-- - world_npc_personas
-- - forum_posts
-- - forum_comments
-- - currency_accounts
-- - currency_transactions
-- - shop_items
-- - user_inventory
--
-- Key constraints:
-- - Forum is private within user's world (world_id NOT NULL)
-- - Multi-source authorship: user/assistant/npc/identity/system/ai
-- - NPC authorship requires world persona mapping (world_npc_personas)
-- - Currency supports global/world via scope_type + partial unique indexes
-- - Strong isolation via user_id everywhere + composite FKs (id, user_id)
-- =========================================================

create extension if not exists moddatetime schema extensions;
create extension if not exists pgcrypto;

-- ---------------------------------------------------------
-- 1) World NPC Personas (world-scoped persona mapping)
-- ---------------------------------------------------------
create table if not exists public.world_npc_personas (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid not null,
  npc_id uuid not null,

  -- World-specific persona for posting / narration
  prompt_persona_text text,
  persona_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  -- Composite uniqueness for strong isolation FK references
  constraint world_npc_personas_id_user_unique unique (id, user_id),

  -- Composite FK: world belongs to same user
  constraint world_npc_personas_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  -- Composite FK: npc belongs to same user
  constraint world_npc_personas_npc_user_fk
    foreign key (npc_id, user_id)
    references public.npcs (id, user_id)
    on delete cascade,

  -- One persona mapping per (user, world, npc)
  constraint world_npc_personas_unique unique (user_id, world_id, npc_id)
);

drop trigger if exists handle_world_npc_personas_updated_at on public.world_npc_personas;
create trigger handle_world_npc_personas_updated_at
  before update on public.world_npc_personas
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_world_npc_personas_user_world
  on public.world_npc_personas (user_id, world_id);

create index if not exists idx_world_npc_personas_user_npc
  on public.world_npc_personas (user_id, npc_id);



-- ---------------------------------------------------------
-- 2) Forum Posts (world-private)
-- ---------------------------------------------------------
create table if not exists public.forum_posts (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid not null,

  -- Multi-source authorship
  -- user|assistant|npc|identity|system|ai
  author_type text not null,

  -- Optional author pointers
  -- npc authorship MUST use world_npc_persona_id
  world_npc_persona_id uuid,
  identity_id uuid,

  title text not null,
  content text not null,

  -- Moderation / management
  is_pinned boolean not null default false,
  is_locked boolean not null default false,

  -- all|ai_only|user_only
  commenting_mode text not null default 'all'
    check (commenting_mode in ('all','ai_only','user_only')),

  visibility text not null default 'world'
    check (visibility in ('world','private','archived')),

  metadata_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  deleted_at timestamptz,

  constraint forum_posts_id_user_unique unique (id, user_id),

  constraint forum_posts_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  constraint forum_posts_identity_user_fk
    foreign key (identity_id, user_id)
    references public.user_world_identities (id, user_id)
    on delete set null,

  constraint forum_posts_world_npc_persona_user_fk
    foreign key (world_npc_persona_id, user_id)
    references public.world_npc_personas (id, user_id)
    on delete set null,

  -- Enforce npc authorship uses world persona mapping
  constraint forum_posts_author_check check (
    (author_type <> 'npc')
    or
    (author_type = 'npc' and world_npc_persona_id is not null)
  )
);

drop trigger if exists handle_forum_posts_updated_at on public.forum_posts;
create trigger handle_forum_posts_updated_at
  before update on public.forum_posts
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_forum_posts_user_world_created
  on public.forum_posts (user_id, world_id, created_at desc);

create index if not exists idx_forum_posts_user_world_pinned
  on public.forum_posts (user_id, world_id, is_pinned, created_at desc);



-- ---------------------------------------------------------
-- 3) Forum Comments
-- ---------------------------------------------------------
create table if not exists public.forum_comments (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid not null,

  post_id uuid not null,
  parent_comment_id uuid,

  -- user|assistant|npc|identity|system|ai
  author_type text not null,

  world_npc_persona_id uuid,
  identity_id uuid,

  content text not null,

  is_hidden boolean not null default false,
  metadata_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  deleted_at timestamptz,

  constraint forum_comments_id_user_unique unique (id, user_id),

  -- Post belongs to same user (composite FK)
  constraint forum_comments_post_user_fk
    foreign key (post_id, user_id)
    references public.forum_posts (id, user_id)
    on delete cascade,

  constraint forum_comments_parent_user_fk
    foreign key (parent_comment_id, user_id)
    references public.forum_comments (id, user_id)
    on delete set null,

  constraint forum_comments_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  constraint forum_comments_identity_user_fk
    foreign key (identity_id, user_id)
    references public.user_world_identities (id, user_id)
    on delete set null,

  constraint forum_comments_world_npc_persona_user_fk
    foreign key (world_npc_persona_id, user_id)
    references public.world_npc_personas (id, user_id)
    on delete set null,

  constraint forum_comments_author_check check (
    (author_type <> 'npc')
    or
    (author_type = 'npc' and world_npc_persona_id is not null)
  )
);

drop trigger if exists handle_forum_comments_updated_at on public.forum_comments;
create trigger handle_forum_comments_updated_at
  before update on public.forum_comments
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_forum_comments_post_created
  on public.forum_comments (post_id, created_at asc);

create index if not exists idx_forum_comments_user_world_created
  on public.forum_comments (user_id, world_id, created_at desc);



-- ---------------------------------------------------------
-- 4) Currency Accounts (balance snapshot)
-- ---------------------------------------------------------
create table if not exists public.currency_accounts (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  -- global|world
  scope_type text not null check (scope_type in ('global','world')),
  world_id uuid,

  currency_code text not null,
  balance bigint not null default 0,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  constraint currency_accounts_id_user_unique unique (id, user_id),

  constraint currency_accounts_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  constraint currency_accounts_scope_world_check check (
    (scope_type = 'global' and world_id is null)
    or
    (scope_type = 'world' and world_id is not null)
  )
);

drop trigger if exists handle_currency_accounts_updated_at on public.currency_accounts;
create trigger handle_currency_accounts_updated_at
  before update on public.currency_accounts
  for each row execute procedure moddatetime (updated_at);

-- Partial unique indexes
create unique index if not exists uq_currency_accounts_global
  on public.currency_accounts (user_id, currency_code)
  where scope_type = 'global';

create unique index if not exists uq_currency_accounts_world
  on public.currency_accounts (user_id, world_id, currency_code)
  where scope_type = 'world';

create index if not exists idx_currency_accounts_user_scope
  on public.currency_accounts (user_id, scope_type);



-- ---------------------------------------------------------
-- 5) Currency Transactions (ledger)
-- ---------------------------------------------------------
create table if not exists public.currency_transactions (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  account_id uuid not null,

  -- Optional: redundancy for reporting
  world_id uuid,

  amount bigint not null,

  -- task_reward|shop_purchase|manual_adjust|pomodoro_reward|...
  reason_type text,
  reason_ref text,

  metadata_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),

  constraint currency_transactions_id_user_unique unique (id, user_id),

  constraint currency_transactions_account_user_fk
    foreign key (account_id, user_id)
    references public.currency_accounts (id, user_id)
    on delete cascade,

  constraint currency_transactions_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete set null
);

create index if not exists idx_currency_transactions_user_created
  on public.currency_transactions (user_id, created_at desc);

create index if not exists idx_currency_transactions_account_created
  on public.currency_transactions (account_id, created_at desc);



-- ---------------------------------------------------------
-- 6) Shop Items
-- ---------------------------------------------------------
create table if not exists public.shop_items (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  -- NULL = global shop; NOT NULL = world shop
  world_id uuid,

  name text not null,
  description text,

  price_amount bigint not null default 0,
  price_currency_code text not null default 'dream_points',

  item_type text default 'consumable',
  item_payload_json jsonb default '{}'::jsonb,

  prompt_item_text text,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  constraint shop_items_id_user_unique unique (id, user_id),

  constraint shop_items_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  -- Unique within (user, world, name). Note: NULL world_id allows duplicates.
  constraint shop_items_user_world_name_unique unique (user_id, world_id, name)
);

drop trigger if exists handle_shop_items_updated_at on public.shop_items;
create trigger handle_shop_items_updated_at
  before update on public.shop_items
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_shop_items_user_world
  on public.shop_items (user_id, world_id);



-- ---------------------------------------------------------
-- 7) User Inventory
-- ---------------------------------------------------------
create table if not exists public.user_inventory (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid not null,

  item_id uuid not null,

  quantity bigint not null default 0,

  acquired_at timestamptz default now(),
  updated_at timestamptz default now(),

  metadata_json jsonb default '{}'::jsonb,

  constraint user_inventory_id_user_unique unique (id, user_id),

  constraint user_inventory_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  constraint user_inventory_item_user_fk
    foreign key (item_id, user_id)
    references public.shop_items (id, user_id)
    on delete cascade,

  -- One row per item per world
  constraint user_inventory_unique unique (user_id, world_id, item_id)
);

drop trigger if exists handle_user_inventory_updated_at on public.user_inventory;
create trigger handle_user_inventory_updated_at
  before update on public.user_inventory
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_user_inventory_user_world
  on public.user_inventory (user_id, world_id);



-- ---------------------------------------------------------
-- 8) RLS enable
-- ---------------------------------------------------------
alter table public.world_npc_personas enable row level security;
alter table public.forum_posts enable row level security;
alter table public.forum_comments enable row level security;
alter table public.currency_accounts enable row level security;
alter table public.currency_transactions enable row level security;
alter table public.shop_items enable row level security;
alter table public.user_inventory enable row level security;

-- ---------------------------------------------------------
-- 9) RLS policies
-- ---------------------------------------------------------
drop policy if exists "World NPC personas are private" on public.world_npc_personas;
create policy "World NPC personas are private"
  on public.world_npc_personas for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Forum posts are private" on public.forum_posts;
create policy "Forum posts are private"
  on public.forum_posts for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Forum comments are private" on public.forum_comments;
create policy "Forum comments are private"
  on public.forum_comments for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Currency accounts are private" on public.currency_accounts;
create policy "Currency accounts are private"
  on public.currency_accounts for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Currency transactions are private" on public.currency_transactions;
create policy "Currency transactions are private"
  on public.currency_transactions for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Shop items are private" on public.shop_items;
create policy "Shop items are private"
  on public.shop_items for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "User inventory is private" on public.user_inventory;
create policy "User inventory is private"
  on public.user_inventory for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
```

### 可选增强 / 注意事项（不改上面的 SQL，仅供参考）
1. 论坛发帖/评论权限（ACL）建议：
   - 因为你选择把权限存入 `worlds.rules_json / ai_context_json`，建议约定字段：
     - `forum_acl: { allow_user: true, allow_assistant: true, allow_npc: false, allow_identity: true }`
   - 插入 post/comment 前由应用层/Edge Function 读取规则并拦截。

2. `commenting_mode` 的执行建议：
   - `is_locked = true`：直接禁止新增评论。
   - `commenting_mode = 'ai_only'`：仅允许 `author_type in ('assistant','ai','system')`。

3. 关于 `unique(user_id, world_id, name)`（NULL world_id）：
   - 对 `world_id = NULL` 会允许多个 NULL。
   - 如需“全局商店 item 也不允许重名”，可追加部分唯一索引：
     - `create unique index ... on shop_items(user_id, name) where world_id is null;`

4. 扣款与一致性：
   - 本设计把“扣余额”放在应用层（更新 currency_accounts.balance + 写入 transactions）。
   - 若未来要强一致事务，可改为数据库函数（单事务完成扣款+写流水）。

---

## Part 6 - Personal Data Management（Notes + Calendar + Ledger + Media + Pomodoro）

### 目标
- 创建个人数据表：`public.user_notes`、`public.user_calendar`、`public.user_ledger`、`public.user_media`、`public.pomodoro_sessions`。
- 每条记录支持上下文绑定：`scope_type in ('global','world','save')`（严格三选一，配合 CHECK 约束）。
- 每条记录支持 AI 可见性：`ai_visibility in ('private','assistant','world_context','save_context')`。
- 支持后续注入 AI 上下文：按 scope/visibility 精准选择可见内容。
- 强隔离：每表带 `user_id`，并使用复合外键 `(id, user_id)` 关联 `worlds` / `world_save_states`。

### SQL Editor 指令（按执行顺序，原样记录）

```sql
-- =========================================================
-- Part 6 - Personal Data Management
-- Tables:
-- - user_notes
-- - user_calendar
-- - user_ledger
-- - user_media
-- - pomodoro_sessions
--
-- Key constraints:
-- - scope_type: global|world|save (strict)
-- - ai_visibility: private|assistant|world_context|save_context
-- - Strong isolation via user_id everywhere + composite FKs (id, user_id)
-- =========================================================

create extension if not exists moddatetime schema extensions;
create extension if not exists pgcrypto;

-- ---------------------------------------------------------
-- Shared conventions
-- scope_type rules:
-- - global: world_id IS NULL AND save_id IS NULL
-- - world:  world_id IS NOT NULL AND save_id IS NULL
-- - save:   save_id  IS NOT NULL (world_id optional)
-- ---------------------------------------------------------


-- 1) Notes
create table if not exists public.user_notes (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  scope_type text not null check (scope_type in ('global','world','save')),
  world_id uuid,
  save_id uuid,

  ai_visibility text not null default 'private'
    check (ai_visibility in ('private','assistant','world_context','save_context')),

  title text,
  content text not null,

  -- Optional: cached summary for prompt injection
  prompt_summary_text text,

  note_type text default 'memo',
  tags_json jsonb default '[]'::jsonb,
  metadata_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  deleted_at timestamptz,

  constraint user_notes_id_user_unique unique (id, user_id),

  constraint user_notes_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  constraint user_notes_save_user_fk
    foreign key (save_id, user_id)
    references public.world_save_states (id, user_id)
    on delete cascade,

  constraint user_notes_scope_check check (
    (scope_type = 'global' and world_id is null and save_id is null)
    or
    (scope_type = 'world' and world_id is not null and save_id is null)
    or
    (scope_type = 'save' and save_id is not null)
  )
);

drop trigger if exists handle_user_notes_updated_at on public.user_notes;
create trigger handle_user_notes_updated_at
  before update on public.user_notes
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_user_notes_user_scope
  on public.user_notes (user_id, scope_type, created_at desc);

create index if not exists idx_user_notes_user_world
  on public.user_notes (user_id, world_id, created_at desc);

create index if not exists idx_user_notes_user_save
  on public.user_notes (user_id, save_id, created_at desc);



-- 2) Calendar
create table if not exists public.user_calendar (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  scope_type text not null check (scope_type in ('global','world','save')),
  world_id uuid,
  save_id uuid,

  ai_visibility text not null default 'private'
    check (ai_visibility in ('private','assistant','world_context','save_context')),

  title text not null,
  description text,

  start_at timestamptz not null,
  end_at timestamptz,
  all_day boolean not null default false,

  timezone text,
  rrule text,

  location text,
  metadata_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  deleted_at timestamptz,

  constraint user_calendar_id_user_unique unique (id, user_id),

  constraint user_calendar_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  constraint user_calendar_save_user_fk
    foreign key (save_id, user_id)
    references public.world_save_states (id, user_id)
    on delete cascade,

  constraint user_calendar_scope_check check (
    (scope_type = 'global' and world_id is null and save_id is null)
    or
    (scope_type = 'world' and world_id is not null and save_id is null)
    or
    (scope_type = 'save' and save_id is not null)
  )
);

drop trigger if exists handle_user_calendar_updated_at on public.user_calendar;
create trigger handle_user_calendar_updated_at
  before update on public.user_calendar
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_user_calendar_user_start
  on public.user_calendar (user_id, start_at desc);

create index if not exists idx_user_calendar_user_scope
  on public.user_calendar (user_id, scope_type, start_at desc);



-- 3) Ledger
create table if not exists public.user_ledger (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  scope_type text not null check (scope_type in ('global','world','save')),
  world_id uuid,
  save_id uuid,

  ai_visibility text not null default 'private'
    check (ai_visibility in ('private','assistant','world_context','save_context')),

  -- income|expense|transfer
  direction text not null default 'expense'
    check (direction in ('income','expense','transfer')),

  amount numeric not null,
  currency_code text not null default 'CNY',

  category text,
  note text,
  occurred_at timestamptz not null default now(),

  metadata_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  deleted_at timestamptz,

  constraint user_ledger_id_user_unique unique (id, user_id),

  constraint user_ledger_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  constraint user_ledger_save_user_fk
    foreign key (save_id, user_id)
    references public.world_save_states (id, user_id)
    on delete cascade,

  constraint user_ledger_scope_check check (
    (scope_type = 'global' and world_id is null and save_id is null)
    or
    (scope_type = 'world' and world_id is not null and save_id is null)
    or
    (scope_type = 'save' and save_id is not null)
  )
);

drop trigger if exists handle_user_ledger_updated_at on public.user_ledger;
create trigger handle_user_ledger_updated_at
  before update on public.user_ledger
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_user_ledger_user_occurred
  on public.user_ledger (user_id, occurred_at desc);

create index if not exists idx_user_ledger_user_scope
  on public.user_ledger (user_id, scope_type, occurred_at desc);



-- 4) Media
create table if not exists public.user_media (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  scope_type text not null check (scope_type in ('global','world','save')),
  world_id uuid,
  save_id uuid,

  ai_visibility text not null default 'private'
    check (ai_visibility in ('private','assistant','world_context','save_context')),

  -- Storage reference
  storage_bucket text not null default 'user-media',
  storage_path text not null,

  mime_type text,
  size_bytes bigint,

  caption text,
  tags_json jsonb default '[]'::jsonb,

  metadata_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  deleted_at timestamptz,

  constraint user_media_id_user_unique unique (id, user_id),

  constraint user_media_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  constraint user_media_save_user_fk
    foreign key (save_id, user_id)
    references public.world_save_states (id, user_id)
    on delete cascade,

  constraint user_media_scope_check check (
    (scope_type = 'global' and world_id is null and save_id is null)
    or
    (scope_type = 'world' and world_id is not null and save_id is null)
    or
    (scope_type = 'save' and save_id is not null)
  )
);

drop trigger if exists handle_user_media_updated_at on public.user_media;
create trigger handle_user_media_updated_at
  before update on public.user_media
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_user_media_user_scope
  on public.user_media (user_id, scope_type, created_at desc);

create index if not exists idx_user_media_user_world
  on public.user_media (user_id, world_id, created_at desc);

create index if not exists idx_user_media_user_save
  on public.user_media (user_id, save_id, created_at desc);



-- 5) Pomodoro Sessions
create table if not exists public.pomodoro_sessions (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  scope_type text not null check (scope_type in ('global','world','save')),
  world_id uuid,
  save_id uuid,

  ai_visibility text not null default 'assistant'
    check (ai_visibility in ('private','assistant','world_context','save_context')),

  started_at timestamptz not null,
  ended_at timestamptz,
  duration_seconds int,

  focus_label text,
  note text,

  reward_points bigint default 0,

  metadata_json jsonb default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  deleted_at timestamptz,

  constraint pomodoro_sessions_id_user_unique unique (id, user_id),

  constraint pomodoro_sessions_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,

  constraint pomodoro_sessions_save_user_fk
    foreign key (save_id, user_id)
    references public.world_save_states (id, user_id)
    on delete cascade,

  constraint pomodoro_sessions_scope_check check (
    (scope_type = 'global' and world_id is null and save_id is null)
    or
    (scope_type = 'world' and world_id is not null and save_id is null)
    or
    (scope_type = 'save' and save_id is not null)
  )
);

drop trigger if exists handle_pomodoro_sessions_updated_at on public.pomodoro_sessions;
create trigger handle_pomodoro_sessions_updated_at
  before update on public.pomodoro_sessions
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_pomodoro_user_started
  on public.pomodoro_sessions (user_id, started_at desc);

create index if not exists idx_pomodoro_user_scope
  on public.pomodoro_sessions (user_id, scope_type, started_at desc);



-- 6) RLS enable
alter table public.user_notes enable row level security;
alter table public.user_calendar enable row level security;
alter table public.user_ledger enable row level security;
alter table public.user_media enable row level security;
alter table public.pomodoro_sessions enable row level security;

-- 7) RLS policies

drop policy if exists "Notes are private" on public.user_notes;
create policy "Notes are private"
  on public.user_notes for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Calendar is private" on public.user_calendar;
create policy "Calendar is private"
  on public.user_calendar for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Ledger is private" on public.user_ledger;
create policy "Ledger is private"
  on public.user_ledger for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Media is private" on public.user_media;
create policy "Media is private"
  on public.user_media for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Pomodoro sessions are private" on public.pomodoro_sessions;
create policy "Pomodoro sessions are private"
  on public.pomodoro_sessions for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
```

### 可选增强 / 注意事项（不改上面的 SQL，仅供参考）
1. `save` scope 下的 world 一致性：
   - 当前通过 `(save_id, user_id)` 外键保证 save 属于该 user。
   - 若你同时填了 `world_id`，建议在应用层保证 `world_id` 与 save 所属 world 一致；如需数据库强校验可用触发器实现（后续再加）。

2. AI 注入建议（应用层）：
   - 注入当前世界/存档上下文时，按 `ai_visibility` 过滤：
     - world 注入：包含 `assistant` 与 `world_context`（以及必要的 `save_context`）
     - save 注入：包含 `assistant` 与 `save_context`（以及必要的 `world_context`）
   - 对长文本（notes）建议优先使用 `prompt_summary_text`，避免 token 膨胀。

3. 媒体文件存储：
   - `user_media` 仅存元数据；实际文件放 Supabase Storage。

---

## Part 7 - Settings & Connections（api_connections）

### 目标
- 新增 `public.api_connections` 表，用于存储用户自定义的 API 连接信息。
- 明确禁止存储任何 API Key/Token（包括加密后的密文）；密钥仅保存在本地设备。
- 支持按连接粒度控制是否同步到数据库：`is_synced`。
- 目前支持 OpenAI-compatible `/v1` 接口；通过 `service_type + config_json/params_json` 预留未来 STT/TTS/生图等服务。

### SQL Editor 指令（按执行顺序，原样记录）

```sql
-- =========================================================
-- Part 7 - Settings & Connections (api_connections)
--
-- Requirements:
-- - DO NOT store any secret (api key / token) in database
-- - Only store URLs, non-sensitive parameters, prompts
-- - Each connection can be synced or local-only via is_synced
-- - Extendable to stt/tts/image later
-- =========================================================

create extension if not exists moddatetime schema extensions;
create extension if not exists pgcrypto;

create table if not exists public.api_connections (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  name text not null,

  -- openai_compat|stt|tts|image|custom
  service_type text not null default 'openai_compat',

  -- Example: https://api.openai.com/v1 or https://your-host/v1
  base_url text not null,

  -- Per-connection sync toggle
  is_synced boolean not null default true,
  is_active boolean not null default true,

  -- LLM defaults (optional)
  default_model text,

  -- User-controlled system prompt (optional)
  system_prompt text,

  -- Non-sensitive params (temperature, top_p, max_tokens, response_format, etc.)
  params_json jsonb not null default '{}'::jsonb,

  -- Optional: only non-sensitive header templates (MUST NOT include Authorization)
  headers_template_json jsonb not null default '{}'::jsonb,

  -- Optional: service-specific config without secrets
  config_json jsonb not null default '{}'::jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  constraint api_connections_user_name_unique unique (user_id, name),

  -- Basic URL check
  constraint api_connections_base_url_check
    check (base_url ~* '^https?://'),

  -- Prevent common secret headers from being stored (best-effort)
  constraint api_connections_headers_no_secrets_check
    check (
      not (headers_template_json ?| array['authorization','Authorization','AUTHORIZATION','x-api-key','X-API-KEY','x_api_key','api-key','Api-Key','API-KEY','bearer','Bearer','BEARER'])
    )
);

-- updated_at trigger (idempotent)
drop trigger if exists handle_api_connections_updated_at on public.api_connections;
create trigger handle_api_connections_updated_at
  before update on public.api_connections
  for each row execute procedure moddatetime (updated_at);

-- Indexes
create index if not exists idx_api_connections_user_active
  on public.api_connections (user_id, is_active);

create index if not exists idx_api_connections_user_service
  on public.api_connections (user_id, service_type);

-- RLS
alter table public.api_connections enable row level security;

drop policy if exists "API connections are private" on public.api_connections;
create policy "API connections are private"
  on public.api_connections for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
```

### 可选增强 / 注意事项（不改上面的 SQL，仅供参考）
1. 同步策略建议：
   - 若用户选择“不同步到数据库”，客户端应直接不创建该连接记录（仅本地保存）。
   - `is_synced=false` 可用于“已存在记录但用户决定停止同步”的标记，但不应在该表存储任何 secret。

2. 本地密钥存储建议：
   - iOS Keychain / Android Keystore / Flutter secure storage。

3. `headers_template_json` 的约束是 best-effort：
   - 仍建议在应用层二次校验（禁止写入 Authorization / x-api-key 等）。

---
