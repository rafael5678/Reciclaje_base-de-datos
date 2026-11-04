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

-- Residuos escaneados. photo guarda el JPEG; points los calcula el backend.
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

-- Lista el historial de un usuario ordenado por fecha.
create index if not exists idx_scans_user on scans (user_id, created_at desc);

-- Salón de clase. code es el código interno; el de invitación rota en el backend.
create table if not exists classrooms (
    id bigint generated always as identity primary key,
    name text not null,
    code text not null unique,
    owner_id bigint not null references users(id) on delete cascade,
    created_at timestamptz not null default now()
);

-- Un usuario no entra dos veces al mismo salón.
create table if not exists classroom_members (
    classroom_id bigint not null references classrooms(id) on delete cascade,
    user_id bigint not null references users(id) on delete cascade,
    joined_at timestamptz not null default now(),
    primary key (classroom_id, user_id)
);

-- Lista los salones de un usuario sin recorrer toda la tabla.
create index if not exists idx_members_user on classroom_members (user_id);
