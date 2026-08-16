begin;

alter table public.met_museum_objects enable row level security;

revoke insert, update, delete, truncate, references, trigger
  on public.met_museum_objects
  from anon, authenticated;
grant select on public.met_museum_objects to anon, authenticated;

drop policy if exists "Authenticated users can browse Met museum catalog"
  on public.met_museum_objects;
drop policy if exists "Public can browse Met museum catalog"
  on public.met_museum_objects;

create policy "Public can browse Met museum catalog"
  on public.met_museum_objects
  for select
  to anon, authenticated
  using (true);

commit;
