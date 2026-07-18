# AGENTS.md — Off-Road Events App

Living status doc for **rides.spencerflaherty.com** — a multi-user web app for
tracking off-road motorcycle events (status per event, notes, custom to-dos, a
per-user bike garage paired to events, calendar export, adjustable home base +
distance/drive-time radius). Single static `index.html` + Supabase (auth + DB),
served from GitHub Pages. Cost: $0.

## Rules for this file
- **Keep it current.** Update Status when something changes. No changelog.
- **Pointers, not copies.** Anything the site files already contain (features,
  data shape, styling, SQL schema) lives in those files — reference, don't paste.

## Status
✅ Live and fully working — Supabase auth (email/password + Google OAuth) and
Postgres are wired, DB + RLS are live, and the shared `public.events` table is
seeded with 149 nationwide events through October 2026, including competitive and
organized ADV/dual-sport/group rides. Past events and user-hidden events are
excluded from the list by default and can be revealed with the combined filter.
The custom domain serves the current build;
GitHub Pages HTTPS certificate repair/enforcement remains an infrastructure
follow-up.

## Map of files
- `index.html` — the app. Single file, no build step, Supabase via CDN. Source of
  truth for all behavior, data, and styling. Events load from the DB; the inline
  `FALLBACK_EVENTS` array is the offline/fetch-failure fallback only.
- `supabase-setup.sql` — DB schema + RLS policies (re-runnable). Tables: shared
  `events` (public read), per-user `user_event_status` (now incl. `bike_id`),
  `user_todos`, `user_profiles` (now incl. `radius_mi`/`radius_hr`), `user_bikes`.
- `events-seed.sql` — seeds/updates the shared `events` table (re-runnable upsert).
- `INGESTION.md` — event row schema + the workflow/source checklist for adding
  events (incl. the planned nationwide expansion). Read before crawling new events.
- `SETUP_GUIDE.md` — Spencer-facing setup walkthrough (Supabase, OAuth, DNS, Pages).
- `dualsport-events-report_2.html` — original static report; untouched reference.
- `CLAUDE.md` — pointer to this file.

## Architecture
Browser loads `index.html` → Supabase Auth + Postgres. Per-user rows are guarded by
RLS (`auth.uid() = user_id`); the shared `events` table is world-readable
(`select using (true)`) and admin-write only — clients never write events; inserts
run via the SQL editor / service role. No backend. The `sb_publishable_` key in the
page is public by design; RLS is the security boundary — never commit the secret /
`service_role` key. Event keys use a stable slug (`start + '-' + title`, stripped,
first 10 chars) shared between the table and per-user rows.

## Conventions
- App work goes in `index.html` only; leave `dualsport-events-report_2.html` as
  reference.
- Local preview: `python3 -m http.server` in this folder (or the `.claude/launch.json`
  server `rides`, port 4178).
