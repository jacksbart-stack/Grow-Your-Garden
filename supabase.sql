-- Run in Supabase SQL Editor. One garden per parent account.
create table if not exists public.gardens (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.gardens enable row level security;
create policy "Parents can read their own garden" on public.gardens for select to authenticated using (auth.uid() = user_id);
create policy "Parents can insert their own garden" on public.gardens for insert to authenticated with check (auth.uid() = user_id);
create policy "Parents can update their own garden" on public.gardens for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
