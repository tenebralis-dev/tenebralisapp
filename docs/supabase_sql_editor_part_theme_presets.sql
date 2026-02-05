-- =========================================================
-- Part X - UI Theme Presets (Custom global color schemes)
--
-- Goals:
-- - Store user-created global color presets
-- - RLS private per-user
-- - Support optional client-side sync (per preset) without storing secrets
--
-- Notes:
-- - This SQL is intended to be pasted into Supabase Dashboard -> SQL Editor.
-- - Keep consistent with other Parts: moddatetime trigger + RLS (USING + WITH CHECK).
-- =========================================================

create extension if not exists moddatetime schema extensions;
create extension if not exists pgcrypto;

create table if not exists public.ui_theme_presets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,

  name text not null,

  -- Example JSON:
  -- {
  --   "primary": "#6C63FF",
  --   "secondary": "#00D9FF",
  --   "background": "#0A0E21",
  --   "surface": "#1D1E33",
  --   "text": "#FFFFFF",
  --   "error": "#FF5252"
  -- }
  colors_json jsonb not null default '{}'::jsonb,

  -- Soft delete (helpful for multi-device sync); optional but recommended
  is_deleted boolean not null default false,

  created_at timestamptz default now(),
  updated_at timestamptz default now(),

  constraint ui_theme_presets_user_name_unique unique (user_id, name)
);

-- updated_at trigger (idempotent)
drop trigger if exists handle_ui_theme_presets_updated_at on public.ui_theme_presets;
create trigger handle_ui_theme_presets_updated_at
  before update on public.ui_theme_presets
  for each row execute procedure moddatetime (updated_at);

-- Helpful indexes
create index if not exists idx_ui_theme_presets_user_updated_at
  on public.ui_theme_presets (user_id, updated_at desc);

create index if not exists idx_ui_theme_presets_user_deleted
  on public.ui_theme_presets (user_id, is_deleted);

-- RLS
alter table public.ui_theme_presets enable row level security;

drop policy if exists "UI theme presets are private" on public.ui_theme_presets;
create policy "UI theme presets are private"
  on public.ui_theme_presets for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
