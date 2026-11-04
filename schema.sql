-- EcoScan schema v1 for Supabase / Postgres.
-- Paste this in the Supabase SQL editor (or let the backend create the tables).

-- Accounts. Email is unique; guests use @invitado.ecoscan.
create table if not exists users (
    id bigint generated always as identity primary key,
    name text not null,
    email text not null unique,
    password_hash text not null,
    created_at timestamptz not null default now()
);

-- Scanned waste. photo stores JPEG; points are computed by the backend.
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
    created_at timestamptz not null default now(),
    photo bytea
);

-- Lists a user's history ordered by date.
create index if not exists idx_scans_user on scans (user_id, created_at desc);

-- Classroom. code is internal; the live invite rotates in the backend.
create table if not exists classrooms (
    id bigint generated always as identity primary key,
    name text not null,
    code text not null unique,
    owner_id bigint not null references users(id) on delete cascade,
    created_at timestamptz not null default now()
);

-- A user cannot join the same classroom twice.
create table if not exists classroom_members (
    classroom_id bigint not null references classrooms(id) on delete cascade,
    user_id bigint not null references users(id) on delete cascade,
    joined_at timestamptz not null default now(),
    primary key (classroom_id, user_id)
);

-- Lists a user's classrooms without a full table scan.
create index if not exists idx_members_user on classroom_members (user_id);
comment on table users is 'App accounts, including guests.';
comment on column users.email is 'Unique login email.';
comment on column users.password_hash is 'PBKDF2 password hash.';
comment on column users.name is 'Display name.';
comment on column users.created_at is 'Account creation time.';
