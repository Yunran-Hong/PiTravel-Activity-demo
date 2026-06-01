create table if not exists public.travel_test_results (
  id uuid primary key default gen_random_uuid(),
  room_code text not null,
  user_name text not null,
  answers jsonb not null,
  result text not null,
  percent integer not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (room_code, user_name)
);

alter table public.travel_test_results enable row level security;

drop policy if exists "travel results are readable" on public.travel_test_results;
create policy "travel results are readable"
on public.travel_test_results
for select
to anon
using (true);

drop policy if exists "travel results can be inserted" on public.travel_test_results;
create policy "travel results can be inserted"
on public.travel_test_results
for insert
to anon
with check (true);

drop policy if exists "travel results can be updated" on public.travel_test_results;
create policy "travel results can be updated"
on public.travel_test_results
for update
to anon
using (true)
with check (true);

alter publication supabase_realtime add table public.travel_test_results;
