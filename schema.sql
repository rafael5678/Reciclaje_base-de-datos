-- EcoScan para Supabase / Postgres.
-- Mañana: pega esto en el SQL Editor de Supabase.

create table if not exists users (
    id bigint generated always as identity primary key,
    name text not null,
    email text not null unique,
    password_hash text not null,
    created_at timestamptz not null default now()
);

create table if not exists scans (
    id bigint generated always as identity primary key,
    user_id bigint not null references users(id) on delete cascade,
    material_code text not null,
    object_name text not null,
    confidence double precision not null,
    separated_well boolean not null default true,
    points integer not null default 10,
    weight_kg double precision not null default 0,
    co2_kg double precision not null default 0,
    created_at timestamptz not null default now()
);

create index if not exists idx_scans_user on scans (user_id, created_at desc);
