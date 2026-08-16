# License member management for Google Sheets

Development target only: Supabase project `yxudhflyxuztvzaiunva` (BIBLEOFGONGBOO). Never point these settings at the old production project.

## Installation

1. Create or open the new membership Google Sheet. Share it with the operating account (e.g. `budongsanedu@gmail.com`) as Editor.
2. In the Sheet choose **Extensions → Apps Script**, paste `Code.gs`, and save.
3. In **Project Settings → Script Properties**, add:
   - `LICENSE_SYNC_URL`: `https://yxudhflyxuztvzaiunva.supabase.co/functions/v1/license-member-sync`
   - `LICENSE_SYNC_SECRET`: the same secret value that is set as the Supabase Edge Function secret `LICENSE_SHEET_SYNC_SECRET` (never commit it).
   - `LICENSE_SYNC_TRIGGER_MINUTES` (optional): time-driven import interval, 5–60. Default 60.
   - Keep `LICENSE_SHEET_ID` / `LICENSE_SHEET_URL` in a private note for reference only; the script is container-bound to the Sheet, so it does not need the ID.
4. Set the matching secret on Supabase before using sync:
   `supabase secrets set LICENSE_SHEET_SYNC_SECRET=<value> --project-ref yxudhflyxuztvzaiunva`
   then deploy: `supabase functions deploy license-member-sync --project-ref yxudhflyxuztvzaiunva`.
5. Reload the spreadsheet and run **License Members → Initial setup**. Authorize the script when Google prompts.
6. Install automatic imports: **License Members → Install sync trigger** (creates a time-driven trigger; check with **Sync trigger status**, remove with **Remove sync trigger**).

## Columns

`LICENSE_MEMBERS` columns: `USER_ID, EMAIL, NAME, PRODUCTS, ALLOWED_SUBJECTS, START_DATE, EXPIRES_AT, PAYMENT, STATUS, SYNC_STATUS, LAST_SYNC, NOTE`.

- `PRODUCTS` is the final entitlement list: `REA`, `REA,INS`, `MOR,NOT`, or `ALL`.
  Removing a code and pushing the row marks that entitlement `inactive`.
- `ALLOWED_SUBJECTS` (optional) restricts a paid product to specific subjects:
  format `REA:Real Estate Law|Real Estate Finance; INS:General Insurance`.
  A product omitted from the cell keeps full product access. Empty cell = all subjects.
  The backend enforces this list server-side; the browser only displays it.
- Free users (no active entitlement) always receive exactly 20 sample questions; the limit is enforced by the `license-content` Edge Function regardless of client parameters.

## Testing safely

1. Run **Push selected rows** on one test member row and confirm `SYNC_STATUS` shows `OK`.
2. Confirm in Supabase that `license_entitlements.allowed_subjects` was written for that member.
3. Sign in as that member in the License app and verify only assigned subjects appear.

