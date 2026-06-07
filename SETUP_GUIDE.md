# Setup Guide — get rides.spencerflaherty.com live

Follow these in order. Total hands-on time ~25 min. Anywhere you see
`«something»`, that's a value you copy/paste. Tell me your two Supabase values
(Step 1) and I'll confirm the rest is wired right.

The app already works **right now** with no setup — open `index.html` in a
browser and everything saves locally to that one browser. The steps below
"upgrade" it to real accounts + cross-device sync.

---

## Step 1 — Create the Supabase project  (~5 min)

1. Go to **https://supabase.com** → **Start your project** → sign in (you can use Google).
2. **New project**
   - Name: `motorcycle-events`
   - Database password: make one up, **save it** (you rarely need it again).
   - Region: **East US (North Virginia)** — closest to you.
3. Wait ~2 minutes for it to finish provisioning.
4. Left sidebar → **Project Settings** (gear) → **API**. Copy these two:
   - **Project URL** → looks like `https://abcdwxyz.supabase.co`
   - **Project API keys → `anon` `public`** → a long string starting `eyJ...`
5. Open `index.html`, find the **CONFIG** block near the top of the `<script>`
   (lines are clearly marked `PASTE YOUR SUPABASE VALUES HERE`) and paste both in:
   ```js
   const SUPABASE_URL      = "https://abcdwxyz.supabase.co";
   const SUPABASE_ANON_KEY = "eyJ...your long anon key...";
   ```
   (The anon key is meant to be public — safe to ship in the page. Security comes
   from the SQL policies in Step 2.)

---

## Step 2 — Create the database tables  (~2 min)

1. Supabase left sidebar → **SQL Editor** → **New query**.
2. Open `supabase-setup.sql` (in this folder), copy the whole thing, paste it in.
3. Click **Run**. You should see "Success. No rows returned."
   - This makes 3 tables (`user_event_status`, `user_todos`, `user_profiles`)
     and locks each so a user only ever sees their own data.

---

## Step 3 — Turn on Google sign-in  (~10 min)

This is the fiddliest part. Two halves: make a Google credential, then paste it
into Supabase.

### 3a. Get your Supabase callback URL
- In Supabase → **Authentication** → **Providers** → **Google**.
- Note the **Callback URL (for OAuth)** shown there. It looks like:
  `https://abcdwxyz.supabase.co/auth/v1/callback`
- Keep this tab open.

### 3b. Make the Google OAuth credential
1. Go to **https://console.cloud.google.com**.
2. Top bar → project dropdown → **New Project** → name it `rides-app` → Create → select it.
3. Left menu → **APIs & Services** → **OAuth consent screen**:
   - User type: **External** → Create.
   - App name: `Off-Road Events`. User support email: your email.
   - Developer contact: your email. Save and continue through the screens.
   - On **Test users**, you can add your own email (or later click **Publish app**
     so anyone can sign in — needed since signups are open).
4. Left menu → **APIs & Services** → **Credentials** → **Create Credentials** →
   **OAuth client ID**:
   - Application type: **Web application**.
   - Name: `rides web`.
   - **Authorized JavaScript origins** → Add:
     - `https://rides.spencerflaherty.com`
   - **Authorized redirect URIs** → Add the Supabase callback from 3a:
     - `https://abcdwxyz.supabase.co/auth/v1/callback`
   - Create. A popup shows **Client ID** and **Client secret** — copy both.

### 3c. Paste into Supabase
- Back in Supabase → **Authentication → Providers → Google**:
  - Toggle **Enable** on.
  - Paste **Client ID** and **Client secret**.
  - Save.

---

## Step 4 — Auth URLs in Supabase  (~2 min)

- Supabase → **Authentication** → **URL Configuration**:
  - **Site URL**: `https://rides.spencerflaherty.com`
  - **Redirect URLs** → Add: `https://rides.spencerflaherty.com/**`
  - (For testing locally too, you can also add `http://localhost:3000/**`.)
- Email/password sign-in is on by default — nothing to do there. If you want to
  skip the confirm-email step while testing: **Authentication → Providers →
  Email** → turn **Confirm email** off (turn it back on for production if you like).

---

## Step 5 — Point the subdomain at GitHub Pages  (~5 min + DNS wait)

You want the app at **rides.spencerflaherty.com**. Two parts:

### 5a. Add the DNS record at GoDaddy
1. GoDaddy → your domains → **spencerflaherty.com** → **DNS**.
2. **Add** a record:
   - Type: **CNAME**
   - Name/Host: `rides`
   - Value/Points to: `spencerflaherty.github.io`
   - TTL: default (1 hour)
3. Save. (DNS can take 15 min–1 hr to take effect.)

### 5b. Publish the file to GitHub Pages
You have two options:

**Option A — same repo, new folder** (keeps your current site):
- Won't work cleanly for a *subdomain* — GitHub Pages serves one custom domain
  per repo. Use Option B.

**Option B — a small dedicated repo for the subdomain** (recommended):
1. On GitHub, create a new repo, e.g. `rides`.
2. Upload `index.html` (rename the app file to `index.html`) into it.
3. Repo → **Settings → Pages**:
   - Source: **Deploy from a branch** → `main` / root.
   - **Custom domain**: enter `rides.spencerflaherty.com` → Save.
   - Check **Enforce HTTPS** once it's available (takes a few min).
4. GitHub writes a `CNAME` file for you. Done.

Tell me your GitHub username and whether you want a new `rides` repo — I'll give
you the exact upload commands or a click-by-click.

---

## Step 6 — Test  (~3 min)

1. Visit **https://rides.spencerflaherty.com** (after DNS propagates).
2. You'll see the events with a login prompt on top — dismiss it; events still show.
3. Click **Sign in** → try Google, then sign out and try email/password.
4. Mark an event **Going**, add a **note**, add a **to-do**.
5. Reload → still there. Open it on your **phone**, sign in → same data. ✅

---

## What to send me
- Step 1: your **Project URL** + **anon key** (so I can confirm the config block).
- Step 5: your **GitHub username** + whether to make a `rides` repo.

Everything else (the SQL, the OAuth screens, the DNS record) you can do from the
steps above, but ping me at any point and I'll walk you through the exact screen.
