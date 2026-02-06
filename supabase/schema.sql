-- =========================================================
-- TenebralisApp - Database Baseline Schema
-- =========================================================
-- Source of truth: c:\dev\tenebralisapp\docs\supabase_sql_editor.md (Part 1 ~ Part 7)
--
-- Notes:
-- - This file is intended to be executed in Supabase SQL Editor or used as a baseline.
-- - Keep it idempotent: always prefer IF NOT EXISTS / DROP ... IF EXISTS.
-- - All business tables must have RLS enabled with USING + WITH CHECK.
-- =========================================================

-- Extensions
create extension if not exists moddatetime schema extensions;
create extension if not exists pgcrypto;

-- =========================================================
-- Part 1 - Core Identity & Settings
-- =========================================================
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

drop trigger if exists handle_updated_at on public.users;
create trigger handle_updated_at before update on public.users
  for each row execute procedure moddatetime (updated_at);

drop trigger if exists handle_settings_updated_at on public.user_settings;
create trigger handle_settings_updated_at before update on public.user_settings
  for each row execute procedure moddatetime (updated_at);

alter table public.users enable row level security;
alter table public.user_settings enable row level security;

drop policy if exists "Users can operate on own profile only" on public.users;
create policy "Users can operate on own profile only"
  on public.users for all
  using ( auth.uid() = id )
  with check ( auth.uid() = id );

drop policy if exists "Settings are private" on public.user_settings;
create policy "Settings are private"
  on public.user_settings for all
  using ( auth.uid() = user_id )
  with check ( auth.uid() = user_id );

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
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

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- =========================================================
-- Part 2 - World System
-- =========================================================
create table if not exists public.worlds (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  name text not null,
  description text,
  status text not null default 'active',
  prompt_lore_text text,
  lore_json jsonb default '{}'::jsonb,
  rules_json jsonb default '{}'::jsonb,
  ai_context_json jsonb default '{}'::jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint worlds_user_name_unique unique (user_id, name),
  constraint worlds_id_user_unique unique (id, user_id)
);

drop trigger if exists handle_worlds_updated_at on public.worlds;
create trigger handle_worlds_updated_at
  before update on public.worlds
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_worlds_user_updated_at
  on public.worlds (user_id, updated_at desc);

create index if not exists idx_worlds_user_status
  on public.worlds (user_id, status);

create table if not exists public.user_world_identities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid not null,
  identity_name text not null,
  is_active boolean not null default true,
  prompt_identity_text text,
  role_data_json jsonb default '{}'::jsonb,
  persona_json jsonb default '{}'::jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint identities_world_name_unique unique (world_id, identity_name),
  constraint identities_id_user_unique unique (id, user_id),
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

create table if not exists public.world_save_states (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid not null,
  identity_id uuid not null,
  slot int not null check (slot > 0),
  title text,
  summary text,
  chapter text,
  stage text,
  prompt_progress_text text,
  state_json jsonb not null default '{}'::jsonb,
  last_played_at timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint save_identity_slot_unique unique (identity_id, slot),
  constraint saves_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,
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

alter table public.worlds enable row level security;
alter table public.user_world_identities enable row level security;
alter table public.world_save_states enable row level security;

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

-- =========================================================
-- Part 3 - AI Interaction & NPC
-- =========================================================
create table if not exists public.npcs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  name text not null,
  description text,
  prompt_npc_text text,
  persona_json jsonb default '{}'::jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint npcs_user_name_unique unique (user_id, name),
  constraint npcs_id_user_unique unique (id, user_id)
);

drop trigger if exists handle_npcs_updated_at on public.npcs;
create trigger handle_npcs_updated_at
  before update on public.npcs
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_npcs_user_updated_at
  on public.npcs (user_id, updated_at desc);

create table if not exists public.conversations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  save_id uuid not null,
  npc_id uuid not null,
  thread_key text not null,
  title text,
  summary text,
  pinned_context_text text,
  last_message_at timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint conversations_id_user_unique unique (id, user_id),
  constraint conversations_save_user_fk
    foreign key (save_id, user_id)
    references public.world_save_states (id, user_id)
    on delete cascade,
  constraint conversations_npc_user_fk
    foreign key (npc_id, user_id)
    references public.npcs (id, user_id)
    on delete cascade,
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

create table if not exists public.conversation_messages (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  conversation_id uuid not null,
  seq int not null check (seq > 0),
  role text not null,
  content text not null,
  metadata_json jsonb default '{}'::jsonb,
  created_at timestamptz default now(),
  constraint messages_conversation_user_fk
    foreign key (conversation_id, user_id)
    references public.conversations (id, user_id)
    on delete cascade,
  constraint messages_conversation_seq_unique unique (conversation_id, seq),
  constraint messages_role_check check (role in ('user','assistant','system','tool'))
);

create index if not exists idx_messages_conversation_seq
  on public.conversation_messages (conversation_id, seq);

create index if not exists idx_messages_user_created_at
  on public.conversation_messages (user_id, created_at desc);

create table if not exists public.user_npc_relationships (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid not null,
  npc_id uuid not null,
  affinity int not null default 0,
  status text default 'neutral',
  flags_json jsonb default '{}'::jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint relationships_id_user_unique unique (id, user_id),
  constraint relationships_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,
  constraint relationships_npc_user_fk
    foreign key (npc_id, user_id)
    references public.npcs (id, user_id)
    on delete cascade,
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

alter table public.npcs enable row level security;
alter table public.conversations enable row level security;
alter table public.conversation_messages enable row level security;
alter table public.user_npc_relationships enable row level security;

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

-- =========================================================
-- Part 4 - Tasks & Achievements
-- =========================================================
create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid,
  name text not null,
  description text,
  task_type text default 'side',
  scope_type text not null check (scope_type in ('global','save')),
  prompt_task_text text,
  criteria_json jsonb default '{}'::jsonb,
  reward_json jsonb default '{}'::jsonb,
  created_source text default 'manual',
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint tasks_user_world_name_unique unique (user_id, world_id, name),
  constraint tasks_id_user_unique unique (id, user_id),
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

create table if not exists public.user_tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  task_id uuid not null,
  scope_type text not null check (scope_type in ('global','save')),
  save_id uuid,
  status text not null default 'not_started',
  progress_json jsonb not null default '{}'::jsonb,
  progress_value numeric default 0,
  evidence_json jsonb default '{}'::jsonb,
  last_evaluated_at timestamptz,
  completed_at timestamptz,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint user_tasks_task_user_fk
    foreign key (task_id, user_id)
    references public.tasks (id, user_id)
    on delete cascade,
  constraint user_tasks_save_user_fk
    foreign key (save_id, user_id)
    references public.world_save_states (id, user_id)
    on delete cascade,
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

create unique index if not exists uq_user_tasks_global
  on public.user_tasks (user_id, task_id)
  where scope_type = 'global';

create unique index if not exists uq_user_tasks_save
  on public.user_tasks (user_id, task_id, save_id)
  where scope_type = 'save';

create table if not exists public.achievements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid,
  name text not null,
  description text,
  scope_type text not null check (scope_type in ('global','save')),
  prompt_achievement_text text,
  criteria_json jsonb default '{}'::jsonb,
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

create table if not exists public.user_achievements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  achievement_id uuid not null,
  scope_type text not null check (scope_type in ('global','save')),
  save_id uuid,
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

create unique index if not exists uq_user_achievements_global
  on public.user_achievements (user_id, achievement_id)
  where scope_type = 'global';

create unique index if not exists uq_user_achievements_save
  on public.user_achievements (user_id, achievement_id, save_id)
  where scope_type = 'save';

alter table public.tasks enable row level security;
alter table public.user_tasks enable row level security;
alter table public.achievements enable row level security;
alter table public.user_achievements enable row level security;

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

-- =========================================================
-- Part 5 - Social & Economy
-- =========================================================
create table if not exists public.world_npc_personas (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid not null,
  npc_id uuid not null,
  prompt_persona_text text,
  persona_json jsonb default '{}'::jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint world_npc_personas_id_user_unique unique (id, user_id),
  constraint world_npc_personas_world_user_fk
    foreign key (world_id, user_id)
    references public.worlds (id, user_id)
    on delete cascade,
  constraint world_npc_personas_npc_user_fk
    foreign key (npc_id, user_id)
    references public.npcs (id, user_id)
    on delete cascade,
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

create table if not exists public.forum_posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid not null,
  author_type text not null,
  world_npc_persona_id uuid,
  identity_id uuid,
  title text not null,
  content text not null,
  is_pinned boolean not null default false,
  is_locked boolean not null default false,
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

create table if not exists public.forum_comments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  world_id uuid not null,
  post_id uuid not null,
  parent_comment_id uuid,
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

create table if not exists public.currency_accounts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
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

create unique index if not exists uq_currency_accounts_global
  on public.currency_accounts (user_id, currency_code)
  where scope_type = 'global';

create unique index if not exists uq_currency_accounts_world
  on public.currency_accounts (user_id, world_id, currency_code)
  where scope_type = 'world';

create index if not exists idx_currency_accounts_user_scope
  on public.currency_accounts (user_id, scope_type);

create table if not exists public.currency_transactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  account_id uuid not null,
  world_id uuid,
  amount bigint not null,
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

create table if not exists public.shop_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
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
  constraint shop_items_user_world_name_unique unique (user_id, world_id, name)
);

drop trigger if exists handle_shop_items_updated_at on public.shop_items;
create trigger handle_shop_items_updated_at
  before update on public.shop_items
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_shop_items_user_world
  on public.shop_items (user_id, world_id);

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
  constraint user_inventory_unique unique (user_id, world_id, item_id)
);

drop trigger if exists handle_user_inventory_updated_at on public.user_inventory;
create trigger handle_user_inventory_updated_at
  before update on public.user_inventory
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_user_inventory_user_world
  on public.user_inventory (user_id, world_id);

alter table public.world_npc_personas enable row level security;
alter table public.forum_posts enable row level security;
alter table public.forum_comments enable row level security;
alter table public.currency_accounts enable row level security;
alter table public.currency_transactions enable row level security;
alter table public.shop_items enable row level security;
alter table public.user_inventory enable row level security;

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

-- =========================================================
-- Part 6 - Personal Data Management
-- =========================================================
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

create table if not exists public.user_ledger (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  scope_type text not null check (scope_type in ('global','world','save')),
  world_id uuid,
  save_id uuid,
  ai_visibility text not null default 'private'
    check (ai_visibility in ('private','assistant','world_context','save_context')),
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

create table if not exists public.user_media (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  scope_type text not null check (scope_type in ('global','world','save')),
  world_id uuid,
  save_id uuid,
  ai_visibility text not null default 'private'
    check (ai_visibility in ('private','assistant','world_context','save_context')),
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

alter table public.user_notes enable row level security;
alter table public.user_calendar enable row level security;
alter table public.user_ledger enable row level security;
alter table public.user_media enable row level security;
alter table public.pomodoro_sessions enable row level security;

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

-- =========================================================
-- Part 7 - Settings & Connections
-- =========================================================

-- NOTE: legacy tables removed from this baseline:
-- - public.profiles
-- - public.chronicles
-- - public.relationships
-- - legacy public.worlds (creator_id/is_public/genre/settings/initial_state)
--
-- If you need to migrate existing data, do it in a dedicated migration script.

create table if not exists public.api_connections (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  name text not null,
  service_type text not null default 'openai_compat',
  base_url text not null,
  is_synced boolean not null default true,
  is_active boolean not null default true,
  default_model text,
  system_prompt text,
  params_json jsonb not null default '{}'::jsonb,
  headers_template_json jsonb not null default '{}'::jsonb,
  config_json jsonb not null default '{}'::jsonb,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  constraint api_connections_user_name_unique unique (user_id, name),
  constraint api_connections_base_url_check
    check (base_url ~* '^https?://'),
  constraint api_connections_headers_no_secrets_check
    check (
      not (headers_template_json ?| array['authorization','Authorization','AUTHORIZATION','x-api-key','X-API-KEY','x_api_key','api-key','Api-Key','API-KEY','bearer','Bearer','BEARER'])
    )
);

drop trigger if exists handle_api_connections_updated_at on public.api_connections;
create trigger handle_api_connections_updated_at
  before update on public.api_connections
  for each row execute procedure moddatetime (updated_at);

create index if not exists idx_api_connections_user_active
  on public.api_connections (user_id, is_active);

create index if not exists idx_api_connections_user_service
  on public.api_connections (user_id, service_type);

alter table public.api_connections enable row level security;

drop policy if exists "API connections are private" on public.api_connections;
create policy "API connections are private"
  on public.api_connections for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- (removed) legacy tables: chronicles / relationships / profiles / old worlds

-- =====================================================
-- 5. SAMPLE DATA (Optional - for testing)
-- =====================================================

-- Insert sample public worlds
INSERT INTO public.worlds (name, genre, description, is_public, settings, initial_state)
VALUES
    (
        '星际迷途',
        'sci-fi',
        '在遥远的未来，人类已经殖民了银河系。你是一名星际探险家，发现了一个神秘的信号来源...',
        TRUE,
        '{"system_prompt": "你是一个科幻世界的AI叙述者。场景设定在2487年的银河系。用富有想象力的语言描述未来科技和星际冒险。", "npcs": [{"key": "captain", "name": "舰长艾拉", "personality": "冷静理性，经验丰富"}, {"key": "ai", "name": "量子AI", "personality": "逻辑严密，偶尔幽默"}], "quests": [{"key": "signal", "title": "追踪神秘信号", "type": "main"}]}'::jsonb,
        '{"starting_location": "星际飞船 - 控制室", "opening_narrative": "你从冷冻休眠中醒来，警报声在控制室回荡。舰船AI的声音响起：「检测到未知信号源，距离当前位置3.7光年。」"}'::jsonb
    ),
    (
        '魔法学院',
        'fantasy',
        '欢迎来到艾德拉魔法学院，这里是培养年轻法师的圣地。作为一名新生，你将开启魔法之旅...',
        TRUE,
        '{"system_prompt": "你是一个奇幻魔法世界的AI叙述者。这是一个充满魔法的中世纪风格世界。描述要有魔法氛围和神秘感。", "npcs": [{"key": "master", "name": "大法师沃伦", "personality": "严厉但关心学生"}, {"key": "friend", "name": "学友艾米", "personality": "活泼开朗，好奇心强"}], "quests": [{"key": "first_spell", "title": "学习第一个咒语", "type": "main"}]}'::jsonb,
        '{"starting_location": "学院大门", "opening_narrative": "高耸的尖塔在晨雾中若隐若现，艾德拉魔法学院的大门缓缓打开。你深吸一口气，踏入了这个魔法的殿堂。"}'::jsonb
    ),
    (
        '都市传说',
        'modern',
        '繁华都市的背后，隐藏着不为人知的秘密。作为一名调查记者，你即将揭开惊人的真相...',
        TRUE,
        '{"system_prompt": "你是一个现代都市悬疑故事的AI叙述者。故事发生在一个虚构的现代大都市。营造悬疑和惊悚的氛围。", "npcs": [{"key": "informant", "name": "线人阿杰", "personality": "神秘，话少但可靠"}, {"key": "boss", "name": "主编李华", "personality": "务实，支持正义"}], "quests": [{"key": "investigate", "title": "调查失踪案", "type": "main"}]}'::jsonb,
        '{"starting_location": "报社办公室", "opening_narrative": "桌上的电话突然响起。对面传来一个沙哑的声音：「我有关于失踪案的线索，今晚十点，老地方见。」电话挂断了。"}'::jsonb
    )
ON CONFLICT DO NOTHING;

-- =====================================================
-- GRANT PERMISSIONS (Important for Supabase)
-- =====================================================
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated;
