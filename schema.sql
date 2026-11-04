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
comment on table scans is 'Saved waste classifications.';
comment on column scans.user_id is 'Owner of the scan.';
comment on column scans.material_code is 'Catalog code such as PET or PAP.';
comment on column scans.object_name is 'Name of the object in the photo.';
comment on column scans.confidence is 'Model confidence from 0 to 1.';
comment on column scans.separated_well is 'Whether the user sorted it correctly.';
comment on column scans.points is 'Points awarded by the backend.';
comment on column scans.weight_kg is 'Catalog weight for this material.';
comment on column scans.co2_kg is 'Avoided CO2 if sorted well.';
comment on column scans.photo is 'Optional JPEG bytes.';
comment on column scans.created_at is 'When the scan was saved.';
comment on table classrooms is 'Class groups for ranking.';
comment on column classrooms.name is 'Classroom display name.';
comment on column classrooms.code is 'Stable seed for rotating invites.';
comment on column classrooms.owner_id is 'User who created the classroom.';
comment on column classrooms.created_at is 'Classroom creation time.';
comment on table classroom_members is 'Classroom membership.';
comment on column classroom_members.classroom_id is 'Classroom being joined.';
comment on column classroom_members.user_id is 'Member user id.';
comment on column classroom_members.joined_at is 'When the member joined.';
comment on index idx_scans_user is 'Per-user scan history by date.';
comment on index idx_members_user is 'Classrooms for a given user.';
-- users.email is unique. (1)
-- scans.photo is optional JPEG. (2)
-- classrooms.code is a stable invite seed. (3)
-- classroom_members uses a composite primary key. (4)
-- idx_scans_user speeds up history lists. (5)
-- idx_members_user speeds up my-classrooms queries. (6)
-- guest emails use @invitado.ecoscan. (7)
-- points are computed in the API, not in SQL. (8)
-- keep this file aligned with backend/app/database.py. (9)
-- ON DELETE CASCADE removes scans when a user is deleted. (10)
-- users.email is unique. (11)
-- scans.photo is optional JPEG. (12)
-- classrooms.code is a stable invite seed. (13)
-- classroom_members uses a composite primary key. (14)
-- idx_scans_user speeds up history lists. (15)
