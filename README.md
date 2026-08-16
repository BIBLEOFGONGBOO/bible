# GongBoo Bible

GongBoo Bible is a static browser application backed by Supabase. The public
entry point is `index.html`, which redirects to `supabase/app/index.html`.

## Run the web app locally

No package installation or build step is required for the browser application.
Use an HTTP server rather than opening the HTML file directly, because the app
loads ES modules and JSON assets.

```powershell
python -m http.server 4173 --bind 127.0.0.1
```

Open <http://127.0.0.1:4173/> in a browser. To bypass the redirect while
debugging the app directly, open
<http://127.0.0.1:4173/supabase/app/>.

The checked-in browser configuration contains only the Supabase project URL and
publishable key. A network connection is required for Supabase and CDN-hosted
libraries. Do not put service-role keys or database passwords in browser files.

## Updating browser configuration

`supabase/app/supabase-config.js` is the browser runtime configuration. To
generate it from a local environment file, create an ignored `.env` file from
`.env.example`, set `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY`, then run:

```powershell
node scripts/configure_supabase_browser_app.mjs .env
```

Administrative import, migration, and backup scripts additionally require a
local `SUPABASE_SERVICE_ROLE_KEY` (or `SUPABASE_SECRET_KEY`) and any private
source-data paths noted in their individual scripts. Those credentials must
remain outside Git.

## Android wrapper

The Capacitor Android wrapper lives in `mobile/`. Its setup and build commands
are documented in [`mobile/README.md`](mobile/README.md).
