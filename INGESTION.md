# INGESTION.md — Adding events (and going nationwide)

The app reads its master event list from the **`public.events`** Supabase table
(world-readable, admin-write). This doc is the playbook for filling that table —
expanded nationwide. The catalog currently contains **149 verified events** through October 31, 2026, combining competitive series with organized dual-sport, ADV, training, charity, camping, and club rides.

## The event row

One row per event. `event_key` is the primary key and **must** match the app's slug
formula so per-user data (status/notes/bike) lines up:

```
event_key = start_date + "-" + title (strip non-alphanumerics, first 10 chars)
```

e.g. `2026-06-14` + `Reading Hare Scramble` → `2026-06-14-ReadingHar`.

| column        | type   | notes                                              |
|---------------|--------|----------------------------------------------------|
| `event_key`   | text   | PK, slug as above. Unique per event.               |
| `start_date`  | date   | `YYYY-MM-DD`. Drives calendar + sorting.           |
| `dates_label` | text   | Human range, e.g. `Fri–Sun · Jun 26–28`.           |
| `short_label` | text   | Compact, e.g. `Jun 26–28`. Used in dropdowns.      |
| `title`       | text   | Event name.                                        |
| `club`        | text   | Host / series, e.g. `ECEA / DVTR`.                 |
| `type`        | text   | one of: `ds en hs fun gncc mx` (see app legend).   |
| `loc`         | text   | Venue + city + state.                              |
| `lat` / `lng` | float  | Decimal degrees. Approximate for "venue TBA".      |
| `drive`       | text   | Estimate, e.g. `~2.25 hr`. Parsed by the radius filter. |
| `intel`       | text   | The blurb shown on the card.                       |
| `link`        | text   | Signup / info URL.                                 |
| `linktxt`     | text   | CTA label, e.g. `Pre-Enter`.                       |
| `state`       | text   | 2-letter, e.g. `PA`. Powers the region filter.     |
| `region`      | text   | Grouping, e.g. `Mid-Atlantic`, `Southeast`.        |

> `type` currently has 6 values. If nationwide series need more (trials, flat track,
> GP), add the type to the app's `TYPE` map + legend + CSS color classes
> in `index.html` first, then use it here.

## How to add events

Append rows to `events-seed.sql` (re-runnable upsert) **or** insert ad hoc in the
Supabase SQL editor:

```sql
insert into public.events (event_key, start_date, dates_label, short_label, title,
  club, type, loc, lat, lng, drive, intel, link, linktxt, state, region)
values ('2026-07-04-SomethingN','2026-07-04','Sat · Jul 4','Jul 4','Something National',
  'AMA','ds','Somewhere, ST',00.0000,-00.0000,'~5 hr','Blurb.','https://...','Sign Up','ST','Region')
on conflict (event_key) do update set start_date=excluded.start_date /* …other cols… */;
```

The client cannot write to `events` (RLS allows select only). Inserts run via the SQL
editor or a service-role key — never ship the service-role key in `index.html`.

## National source coverage

The July 2026 nationwide pass used the source ladder below across every US region
and added the durable calendars to the in-app Source Directory. Organizer and
series pages are preferred; aggregators are discovery leads that should be checked
against the host whenever possible.

- [x] **AMA hub** — Find-an-Event, national DS/ADV series, district/charter finder
- [x] **Race series** — enduro / hare scramble / cross-country / GNCC by region
- [x] **DS/ADV aggregators** — USDualSports, RiderPlanet, ADVrider Rally Central, BDRs
- [x] **Clubs & promoters** — the orgs that actually host, found via the series
- [ ] **Off-road parks** — pay-to-ride venues; still needs a systematic national pass
- [x] **Signup platforms** — Moto-Tally, Webscorer, etc. (where dates get posted)
- [ ] **Regional Facebook groups** — last-minute / unsanctioned ride calls; not
  treated as verified unless an organizer publishes a stable date and location

Covered regions: Northeast, Mid-Atlantic, Southeast, Gulf Coast, Appalachia,
Midwest, Great Lakes, Plains, Texas, Mountain West, Southwest, California, and
Pacific Northwest.

For each found event: geocode the venue → build the row → upsert. Keep `drive`
honest (it feeds the radius filter); for far/national events a rough hour estimate is fine.
