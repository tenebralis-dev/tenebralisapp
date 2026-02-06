# Global Memory Table Design (`public.global_memories`)

This document defines a dedicated table for long-term, user-level memory in Tenebralis Dream System.
It follows the existing database conventions in `docs/sql.md`:
- strict `user_id` isolation
- `jsonb` for extensibility
- `updated_at` trigger
- row-level security (RLS)

## 1) SQL (ready to run)

```sql
create extension if not exists moddatetime schema extensions;
create extension if not exists pgcrypto;

create table if not exists public.global_memories (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  -- Core memory payload
  memory_key text,
  content text not null,
  summary text,

  -- Used for filtering and prompt assembly
  memory_type text not null default 'fact'
    check (memory_type in (
      'identity','preference','habit','goal','relationship',
      'world_rule','event','schedule','emotion','fact','other'
    )),

  -- Aligned with existing visibility model
  ai_visibility text not null default 'assistant'
    check (ai_visibility in ('private','assistant','world_context','save_context')),

  -- Quality and ranking (0-100)
  importance_score numeric(5,2) not null default 50
    check (importance_score >= 0 and importance_score <= 100),
  confidence_score numeric(5,2) not null default 70
    check (confidence_score >= 0 and confidence_score <= 100),

  -- Traceability to source entities
  source_type text not null default 'manual'
    check (source_type in (
      'manual','conversation','note','calendar',
      'ledger','media','pomodoro','system','import'
    )),
  source_ref_json jsonb not null default '{}'::jsonb,

  -- Extensible fields
  tags_json jsonb not null default '[]'::jsonb,
  metadata_json jsonb not null default '{}'::jsonb,

  -- Memory lifecycle
  is_pinned boolean not null default false,
  is_archived boolean not null default false,
  recalled_count int not null default 0,
  last_recalled_at timestamptz,
  expires_at timestamptz,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  deleted_at timestamptz,

  constraint global_memories_id_user_unique unique (id, user_id),
  constraint global_memories_user_key_unique unique (user_id, memory_key)
);

drop trigger if exists handle_global_memories_updated_at on public.global_memories;
create trigger handle_global_memories_updated_at
  before update on public.global_memories
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_global_memories_user_active_rank
  on public.global_memories (user_id, is_pinned desc, importance_score desc, updated_at desc)
  where deleted_at is null and is_archived = false;

create index if not exists idx_global_memories_user_type
  on public.global_memories (user_id, memory_type, updated_at desc)
  where deleted_at is null;

create index if not exists idx_global_memories_user_visibility
  on public.global_memories (user_id, ai_visibility, updated_at desc)
  where deleted_at is null and is_archived = false;

create index if not exists idx_global_memories_tags_gin
  on public.global_memories using gin (tags_json);

alter table public.global_memories enable row level security;

drop policy if exists "Global memories are private" on public.global_memories;
create policy "Global memories are private"
  on public.global_memories for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
```

## 2) Field intent

- `id`: 记忆主键，使用 UUID。
- `user_id`: 用户主键，和 `users.id` 关联，用于用户级数据隔离。
- `memory_key`: 业务去重键，可选；建议用于固定语义记忆（如 `profile:favorite_color`）。
- `content`: 记忆正文，给 AI 注入时的核心文本。
- `summary`: 记忆摘要，用于 token 紧张时的短文本注入。
- `memory_type`: 记忆类型，用于分类过滤和 prompt 组装。
- `ai_visibility`: AI 可见范围，控制该记忆可被哪些上下文读取。
- `importance_score`: 重要度分数（0-100），用于召回排序优先级。
- `confidence_score`: 置信度分数（0-100），用于自动抽取记忆的可信度控制。
- `source_type`: 来源类型，标记记忆来自手动输入、对话、笔记等。
- `source_ref_json`: 来源引用信息，记录来源对象 ID（如 `conversation_id`、`message_id`）。
- `tags_json`: 标签数组，支持主题分类和多维检索。
- `metadata_json`: 扩展元数据，保留未来业务字段扩展。
- `is_pinned`: 是否置顶；置顶记忆在检索排序中优先。
- `is_archived`: 是否归档；归档后默认不参与常规召回。
- `recalled_count`: 被召回次数，用于记忆强化或衰减策略。
- `last_recalled_at`: 最近一次被召回时间，用于时间衰减和排序优化。
- `expires_at`: 过期时间；到期后可不再注入上下文。
- `created_at`: 创建时间。
- `updated_at`: 更新时间（由 trigger 自动维护）。
- `deleted_at`: 软删除时间；非空表示该条记忆已逻辑删除。

## 3) Typical retrieval query for chat context

```sql
select
  id,
  content,
  summary,
  memory_type,
  importance_score,
  confidence_score,
  tags_json
from public.global_memories
where user_id = auth.uid()
  and deleted_at is null
  and is_archived = false
  and ai_visibility in ('assistant','world_context','save_context')
  and (expires_at is null or expires_at > now())
order by
  is_pinned desc,
  importance_score desc,
  coalesce(last_recalled_at, updated_at) desc
limit 30;
```

Recommended rollout:
1. ship manual CRUD + retrieval first
2. then add auto-extraction from `conversation_messages` and `user_notes`
