-- ============================================================
--  Off-Road Events App — Supabase schema + security
--  Paste this whole file into Supabase → SQL Editor → Run.
--  Safe to re-run (uses IF NOT EXISTS / CREATE OR REPLACE).
-- ============================================================

-- 1) Per-user status + note + hidden, one row per (user, event) --------------
create table if not exists public.user_event_status (
  user_id    uuid not null references auth.users(id) on delete cascade,
  event_key  text not null,
  status     text check (status in ('going','signedup','maybe','notgoing')),
  note       text,
  hidden     boolean not null default false,
  updated_at timestamptz not null default now(),
  primary key (user_id, event_key)
);

-- 2) Custom user-created to-dos ---------------------------------------------
create table if not exists public.user_todos (
  id         uuid primary key default gen_random_uuid(),
  user_id    uuid not null references auth.users(id) on delete cascade,
  text       text not null,
  done       boolean not null default false,
  event_key  text,                       -- optional link to a master event
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
create index if not exists user_todos_user_idx on public.user_todos(user_id);

-- 3) Per-user profile / home location ---------------------------------------
create table if not exists public.user_profiles (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  home_label text,
  home_lat   double precision,
  home_lng   double precision,
  updated_at timestamptz not null default now()
);

-- ============================================================
--  Row Level Security — each user can only touch their own rows
-- ============================================================
alter table public.user_event_status enable row level security;
alter table public.user_todos          enable row level security;
alter table public.user_profiles       enable row level security;

-- user_event_status policies
drop policy if exists "own status select" on public.user_event_status;
create policy "own status select" on public.user_event_status
  for select using (auth.uid() = user_id);
drop policy if exists "own status write" on public.user_event_status;
create policy "own status write" on public.user_event_status
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- user_todos policies
drop policy if exists "own todos select" on public.user_todos;
create policy "own todos select" on public.user_todos
  for select using (auth.uid() = user_id);
drop policy if exists "own todos write" on public.user_todos;
create policy "own todos write" on public.user_todos
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- user_profiles policies
drop policy if exists "own profile select" on public.user_profiles;
create policy "own profile select" on public.user_profiles
  for select using (auth.uid() = user_id);
drop policy if exists "own profile write" on public.user_profiles;
create policy "own profile write" on public.user_profiles
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Done. Three tables, all locked to the logged-in user.
