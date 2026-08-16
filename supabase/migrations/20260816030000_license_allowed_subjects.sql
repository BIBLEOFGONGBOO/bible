begin;

-- Paid License access is restricted to admin Sheet-assigned subjects.
-- allowed_subjects is NULL/empty = whole product (backward compatible);
-- a non-empty list restricts paid access to those subjects (case-insensitive).
alter table public.license_entitlements
  add column if not exists allowed_subjects jsonb not null default '[]'::jsonb;

-- PostgreSQL does not allow subqueries in CHECK constraints; the sync
-- function validates subject strings before writing instead.
alter table public.license_entitlements
  drop constraint if exists license_entitlements_allowed_subjects_check;

alter table public.license_entitlements
  add constraint license_entitlements_allowed_subjects_check
  check (jsonb_typeof(allowed_subjects) = 'array');

commit;
