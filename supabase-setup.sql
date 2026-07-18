-- ============================================================
--  Off-Road Events App — Supabase schema + security
--  Paste this whole file into Supabase → SQL Editor → Run.
--  Safe to re-run (uses IF NOT EXISTS / CREATE OR REPLACE).
-- ============================================================

-- 0) Shared master event list — admin-writable, world-readable ---------------
--    The app reads this; rows are added via the SQL editor / service role only
--    (no client write policy). event_key matches the app's slug formula so it
--    lines up with user_event_status.event_key.
create table if not exists public.events (
  event_key   text primary key,
  start_date  date,
  dates_label text,          -- "Sun · Jun 14"
  short_label text,          -- "Jun 14"
  title       text not null,
  club        text,
  type        text,          -- ds | en | hs | fun | gncc | mx
  loc         text,
  lat         double precision,
  lng         double precision,
  drive       text,          -- "~2.25 hr"
  intel       text,          -- the sTxt blurb
  link        text,
  linktxt     text,
  state       text,          -- "PA"
  region      text,          -- "Mid-Atlantic"
  created_at  timestamptz not null default now()
);
create index if not exists events_start_idx on public.events(start_date);

-- 1) Per-user status + note + hidden + bike, one row per (user, event) --------
create table if not exists public.user_event_status (
  user_id    uuid not null references auth.users(id) on delete cascade,
  event_key  text not null,
  status     text check (status in ('going','signedup','maybe','notgoing')),
  note       text,
  hidden     boolean not null default false,
  bike_id    uuid,
  updated_at timestamptz not null default now(),
  primary key (user_id, event_key)
);
-- bike pairing (added here for existing installs; safe to re-run)
alter table public.user_event_status
  add column if not exists bike_id uuid;

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

-- 3) Per-user profile / home location + radius ------------------------------
create table if not exists public.user_profiles (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  home_label text,
  home_lat   double precision,
  home_lng   double precision,
  radius_mi  double precision,
  radius_hr  double precision,
  updated_at timestamptz not null default now()
);
-- radius columns (added here for existing installs; safe to re-run)
alter table public.user_profiles add column if not exists radius_mi double precision;
alter table public.user_profiles add column if not exists radius_hr double precision;

-- 4) Per-user garage of bikes -----------------------------------------------
create table if not exists public.user_bikes (
  id         uuid primary key default gen_random_uuid(),
  user_id    uuid not null references auth.users(id) on delete cascade,
  name       text not null,
  type       text,                       -- ds | en | hs | fun | gncc | adv | other
  notes      text,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
create index if not exists user_bikes_user_idx on public.user_bikes(user_id);

-- ============================================================
--  Row Level Security — each user can only touch their own rows
-- ============================================================
alter table public.events              enable row level security;
alter table public.user_event_status enable row level security;
alter table public.user_todos          enable row level security;
alter table public.user_profiles       enable row level security;
alter table public.user_bikes          enable row level security;

-- events: anyone (anon + signed-in) can read; nobody can write from the client.
-- Inserts/updates happen via the SQL editor or service_role, which bypass RLS.
drop policy if exists "events public read" on public.events;
create policy "events public read" on public.events
  for select using (true);

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

-- user_bikes policies
drop policy if exists "own bikes select" on public.user_bikes;
create policy "own bikes select" on public.user_bikes
  for select using (auth.uid() = user_id);
drop policy if exists "own bikes write" on public.user_bikes;
create policy "own bikes write" on public.user_bikes
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Done. Shared events (read-only) + four per-user tables locked to the user.
-- Seed the events table with events-seed.sql.
