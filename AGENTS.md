# AGENTS.md — Off-Road Events App

Living status doc for **rides.spencerflaherty.com** — a multi-user web app for
tracking off-road motorcycle events (status per event, notes, custom to-dos,
calendar export, per-user home/distance). Built on a single static `index.html`
+ Supabase (auth + DB), served from GitHub Pages. Cost: $0.

## Rules for this file
- **Keep it current.** Update the Status section whenever something ships or a
  pending item is resolved. Delete detail about completed work once it's done —
  don't keep a changelog here.
- **No duplication.** Anything the site files already contain (feature behavior,
  data shape, styling, SQL schema) lives in those files. This file only points
  to them. Don't re-describe the build.
- **Pointers, not copies.** Reference the file/line; don't paste its contents.

## Status (2026-06-07)
- ✅ Live at https://rides.spencerflaherty.com — GitHub Pages from the `rides`
  repo, DNS resolving. (HTTPS cert auto-provisions; enable "Enforce HTTPS" in
  repo Settings → Pages once available.)
- ✅ Supabase wired — URL + publishable key in the CONFIG block, `index.html:559`.
- ✅ DB live — 3 tables + row-level security (`supabase-setup.sql`).
- ✅ Auth working — email/password (email confirmation currently OFF) and Google
  OAuth (client accepted by Google; callback `…supabase.co/auth/v1/callback`).

## Map of files
- `index.html` — the app. Single file, no build step. Supabase via CDN. Source of
  truth for all app behavior, data, and styling.
- `supabase-setup.sql` — DB schema + RLS policies (already run). Re-runnable.
- `SETUP_GUIDE.md` — Spencer-facing setup walkthrough (Supabase, Google OAuth,
  DNS, Pages). Source of truth for the remaining manual steps.
- `dualsport-events-report_2.html` — original static report; untouched reference
  for events data + visual design.
- `CLAUDE.md` — pointer to this file.

## Architecture (one line)
Browser loads `index.html` → Supabase Auth (Google + email/password) + Postgres
(per-user rows guarded by RLS). The publishable key is public by design; RLS is
the security boundary. No backend.

## Local preview
`python3 -m http.server` in this folder, or the `.claude/launch.json` server
named `rides` (port 4178).

## Conventions
- App work goes in `index.html` only; leave `dualsport-events-report_2.html` as
  reference.
- Never commit the Supabase **secret** / `service_role` key. The `sb_publishable_`
  key in the page is the correct, public one.
