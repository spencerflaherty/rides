-- ============================================================
--  Off-Road Events — seed the shared public.events table
--  Run AFTER supabase-setup.sql. Safe to re-run (upsert on event_key).
--  event_key matches the app slug formula: start + '-' + title
--  stripped of non-alphanumerics, first 10 chars.
--  Add new events by appending rows here (or insert directly) — see INGESTION.md.
-- ============================================================

insert into public.events
  (event_key, start_date, dates_label, short_label, title, club, type, loc, lat, lng, drive, intel, link, linktxt, state, region)
values
  ('2026-06-14-ReadingHar','2026-06-14','Sun · Jun 14','Jun 14','Reading Hare Scramble','ECEA / RORR','hs','Maple Grove Raceway, Mohnton, PA',40.2247,-75.9560,'~2.25 hr','Pre-entry open via Moto-Tally. New trail / venue for 2026. Beginner "C" class.','https://moto-tally.com/ecea/ecea/PreEntry.aspx','Pre-Enter','PA','Mid-Atlantic'),
  ('2026-06-20-MichauxDua','2026-06-20','Sat · Jun 20','Jun 20','Michaux Dual Sport','ECEA / DVTR','ds','Shippensburg Fairgrounds, PA',40.0506,-77.5180,'~2 hr','Oldest dual sport in the country; sells out in minutes.','https://dvtrailriders.org','DVTR Info','PA','Mid-Atlantic'),
  ('2026-06-21-ShotgunEnd','2026-06-21','Sun · Jun 21','Jun 21','Shotgun Enduro','ECEA / HMDR','en','Ryan Twp Grove, Barnsville, PA',40.8323,-76.0119,'~2.75 hr','Old-school rock run in Delano. Sold out in 2025 — would need fast pre-entry.','https://moto-tally.com/ECEA/Enduro/PreEntry.aspx','Pre-Enter','PA','Mid-Atlantic'),
  ('2026-06-26-SnowshoeGN','2026-06-26','Fri–Sun · Jun 26–28','Jun 26–28','Snowshoe GNCC','GNCC · Rd 9','gncc','Snowshoe Mtn Resort, WV',38.4115,-79.9962,'~4 hr','"Toughest, most unique race on the whole GNCC tour." Not a first-event pick.','https://gnccracing.com/events','Series Info','WV','Mid-Atlantic'),
  ('2026-06-28-OxBoHareSc','2026-06-28','Sun · Jun 28','Jun 28','OxBo Hare Scramble','ECEA / SPER','hs','Tower City, PA',40.5895,-76.5536,'~2.5 hr','Fast, flowy, rocky. Pre-entry open. Youth event the day before.','https://moto-tally.com/ecea/ecea/PreEntry.aspx','Pre-Enter','PA','Mid-Atlantic'),
  ('2026-07-17-304DetourD','2026-07-17','Fri–Sun · Jul 17–19','Jul 17–19','304 Detour Dual Sport','FDSR','ds','Bunner Ridge Rd, Fairmont, WV',39.5028,-80.0989,'~3.5 hr','Club-guided easy loop + ~85 mi hard loop. Watch for ride details and the FDSR Facebook group.','https://www.facebook.com/groups/700876140116042','FDSR Group','WV','Mid-Atlantic'),
  ('2026-07-19-FoggyMount','2026-07-19','Sun · Jul 19','Jul 19','Foggy Mountain Enduro','ECEA / DVTR','en','PA mountains — venue TBA',41.05,-77.50,'~3–4 hr','Pennsylvania mountain riding. Location not yet posted — watch Moto-Tally / ECEA.','https://moto-tally.com/ECEA/Enduro/PreEntry.aspx','Watch','PA','Mid-Atlantic'),
  ('2026-08-01-QuarryRunD','2026-08-01','Sat–Sun · Aug 1–2','Aug 1–2','Quarry Run Dual Sport','Bear Creek Sportsmen · Hancock Fire Dept','ds','Hancock Firemen''s Field, 180 Park St, Hancock, NY',41.9509,-75.2792,'~4.5 hr','Two mandatory days with nearly 100 miles per day of private-property single-track, two-track, dirt and paved connectors. Street-legal bike, license, insurance, route-sheet holder and odometer required; knobbies strongly recommended.','https://www.eventbrite.com/e/2026-quarry-run-tickets-1986220739700','Register','NY','Northeast'),
  ('2026-08-01-Copperhead','2026-08-01','Sat–Sun · Aug 1–2','Aug 1–2','Copperhead National Dual Sport','Beta AMA National DS · HVMC','ds','Hocking Valley Motorcycle Club, 13121 Jake Tom Rd, Logan, OH',39.5276,-82.3163,'~6.5 hr','More than 80 miles each day with abundant single-track and challenging hero sections. Single-day or two-day entry; street-legal bike and AMA membership required.','https://hockingvalleymc.com/dual-sport/','Register','OH','Midwest'),
  ('2026-08-09-ThreeSprin','2026-08-09','Sun · Aug 9','Aug 9','Three Springs Enduro','ECEA / GMER','en','8418 Ashman St, Three Springs, PA',40.1973,-77.9930,'~2.5 hr','"Teetering on the edge." Enduro signup opens closer to the date.','https://moto-tally.com/ECEA/Enduro/PreEntry.aspx','Pre-Enter','PA','Mid-Atlantic'),
  ('2026-08-23-HighSteaks','2026-08-23','Sun · Aug 23','Aug 23','High Steaks Hare Scramble','ECEA / DVTR','hs','399 Halstead Rd, Clifford, PA',41.6420,-75.5860,'~3.75 hr','Great NE-PA woods racing. Borderline on the 4-hr ring.','https://moto-tally.com/ecea/ecea/PreEntry.aspx','Pre-Enter','PA','Mid-Atlantic'),
  ('2026-08-30-BeehiveEnd','2026-08-30','Sun · Aug 30','Aug 30','Beehive Enduro','ECEA / CDR · DER','en','9544 Noble St, Mauricetown, NJ',39.2698,-74.9921,'~3 hr','"Back in the sand." South-Jersey sandy enduro.','https://moto-tally.com/ECEA/Enduro/PreEntry.aspx','Pre-Enter','NJ','Mid-Atlantic'),
  ('2026-09-05-HighMounta','2026-09-05','Sat · Sep 5','Sep 5','High Mountain Fun Day','ECEA / HMDR','fun','142 Cabin Lane, Sugarloaf, PA',40.9890,-76.0680,'~3 hr','"Wallow in the Hollow" — a no-pressure family fun ride, not a race.','https://ecea.org/events/2026/26-special-hmdr-fun','Event Page','PA','Mid-Atlantic'),
  ('2026-09-13-MichauxEnd','2026-09-13','Sun · Sep 13','Sep 13','Michaux Enduro','ECEA / SPER','en','1975 Birch Run Rd, Biglerville, PA',40.0600,-77.2700,'~1.75 hr','Runs in Michaux State Forest — the closest event all year. Pre-entry opens closer to the date on Moto-Tally.','https://moto-tally.com/ECEA/Enduro/PreEntry.aspx','Sign Up','PA','Mid-Atlantic'),
  ('2026-09-20-MoonshineE','2026-09-20','Sun · Sep 20','Sep 20','Moonshine Enduro','ECEA / VFTR · RORR','en','Fern Glen, PA',40.9700,-76.0600,'~3 hr','NE-PA enduro. Signup opens closer to the date.','https://moto-tally.com/ECEA/Enduro/PreEntry.aspx','Pre-Enter','PA','Mid-Atlantic'),
  ('2026-09-27-FallBrawlH','2026-09-27','Sun · Sep 27','Sep 27','Fall Brawl Hare Scramble','ECEA / MMC','hs','New Jersey — venue TBA',40.20,-74.70,'~3 hr','Fall racing in NJ. Location not yet posted — watch ECEA.','https://moto-tally.com/ecea/ecea/PreEntry.aspx','Watch','NJ','Mid-Atlantic'),
  ('2026-10-02-MasonDixon','2026-10-02','Fri–Sun · Oct 2–4','Oct 2–4','Mason-Dixon GNCC','GNCC · Rd 11','gncc','Mathews Farm, Mount Morris, PA',39.7300,-80.1800,'~3.5 hr','The in-range GNCC. Amateur racing runs — more approachable than Snowshoe.','https://gnccracing.com/events','Series Info','PA','Mid-Atlantic'),
  ('2026-10-03-Shenandoah','2026-10-03','Sat–Sun · Oct 3–4','Oct 3–4','Shenandoah 500 Dual Sport','Beta AMA National Dual Sport','ds','Mount Solon, VA',38.3457,-79.0664,'~3 hr','A premier AMA National Dual Sport in the Shenandoah Valley — scenic backroads + two-track, exactly the DRZ wheelhouse.','https://www.google.com/search?q=Shenandoah+500+dual+sport+2026+registration','Find Signup','VA','Mid-Atlantic'),
  ('2026-10-11-RORRDualSp','2026-10-11','Sun · Oct 11','Oct 11','RORR Dual Sport','ECEA / RORR','ds','PA — venue TBA (Reading area)',40.30,-76.00,'~2.25 hr','ECEA bills it as "basically an enduro" — a meatier dual sport.','https://ecea.org/events/2026/26-ds-rorr','Event Page','PA','Mid-Atlantic'),
  ('2026-10-18-SaharaSand','2026-10-18','Sun · Oct 18','Oct 18','Sahara Sands Hare Scramble','ECEA / PBER · SJER','hs','Eagleswood Township, NJ',39.6600,-74.3100,'~3.25 hr','"Almost desert racing" — deep coastal sand.','https://moto-tally.com/ecea/ecea/PreEntry.aspx','Pre-Enter','NJ','Mid-Atlantic'),
  ('2026-10-25-ScrubPineE','2026-10-25','Sun · Oct 25','Oct 25','Scrub Pine Enduro','ECEA / OCCR','en','Brendan T. Byrne Forest, Vincentown, NJ',39.8800,-74.5800,'~3 hr','Pine Barrens enduro. Signup opens closer to the date.','https://moto-tally.com/ECEA/Enduro/PreEntry.aspx','Pre-Enter','NJ','Mid-Atlantic'),
  ('2026-10-31-HammerRunN','2026-10-31','Sat–Sun · Oct 31–Nov 1','Oct 31–Nov 1','Hammer Run National Dual Sport','ECEA / TCSMC · AMA National DS','ds','Port Elizabeth, NJ',39.3120,-74.9810,'~3.25 hr','A two-day AMA National Dual Sport — solid street-legal DRZ ride to close out the season.','https://ecea.org/events/2026/26-ds-tcsmc','Event Page','NJ','Mid-Atlantic'),
  ('2026-11-15-PineBarons','2026-11-15','Sun · Nov 15','Nov 15','Pine Barons Enduro','ECEA / PBER','en','1555 Route 532, Woodland Twp, NJ',39.7800,-74.5500,'~3 hr','Last ECEA points enduro of the year in the pines before winter.','https://moto-tally.com/ECEA/Enduro/PreEntry.aspx','Pre-Enter','NJ','Mid-Atlantic')
on conflict (event_key) do update set
  start_date  = excluded.start_date,
  dates_label = excluded.dates_label,
  short_label = excluded.short_label,
  title       = excluded.title,
  club        = excluded.club,
  type        = excluded.type,
  loc         = excluded.loc,
  lat         = excluded.lat,
  lng         = excluded.lng,
  drive       = excluded.drive,
  intel       = excluded.intel,
  link        = excluded.link,
  linktxt     = excluded.linktxt,
  state       = excluded.state,
  region      = excluded.region;

-- 23 events seeded. The app reads these on load.
