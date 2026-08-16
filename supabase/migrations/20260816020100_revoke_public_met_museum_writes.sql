begin;

revoke insert, update, delete, truncate, references, trigger
  on public.met_museum_objects
  from anon, authenticated;

commit;
