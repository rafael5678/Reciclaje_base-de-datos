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
comment on table users is 'Cuentas de EcoScan, también invitados.';
comment on column users.email is 'Correo único de inicio de sesión.';
comment on column users.password_hash is 'Hash PBKDF2 de la contraseña. Nunca se devuelve al cliente.';
comment on column users.name is 'Nombre visible. Puede llevar un espacio, como Rafael Calzada.';
comment on column users.created_at is 'Momento en que se creó la cuenta.';
comment on table scans is 'Historial de residuos clasificados.';
comment on column scans.user_id is 'Dueño del escaneo.';
comment on column scans.material_code is 'Código del catálogo: PET, HDPE, MLT, PAP, VID, MET, ORG o GEN.';
comment on column scans.object_name is 'Nombre del objeto de esa foto, no el del fondo.';
comment on column scans.confidence is 'Confianza del modelo, de 0 a 1.';
comment on column scans.separated_well is 'Si el usuario lo separó bien.';
comment on column scans.points is 'Puntos que calcula el backend, no un trigger SQL.';
comment on column scans.weight_kg is 'Peso de catálogo de ese material, en kg.';
comment on column scans.co2_kg is 'CO2 evitado si se separó bien, en kg.';
comment on column scans.photo is 'JPEG opcional. El historial puede existir sin foto.';
comment on column scans.created_at is 'Cuándo se guardó el escaneo.';
comment on table classrooms is 'Salones para el ranking del curso.';
comment on column classrooms.name is 'Nombre del salón.';
comment on column classrooms.code is 'Semilla estable. El código de invitación lo rota el backend.';
comment on column classrooms.owner_id is 'Usuario que creó el salón.';
comment on column classrooms.created_at is 'Cuándo se creó el salón.';
comment on table classroom_members is 'Classroom membership.';
comment on column classroom_members.classroom_id is 'Classroom being joined.';
comment on column classroom_members.user_id is 'Member user id.';
comment on column classroom_members.joined_at is 'When the member joined.';
comment on index idx_scans_user is 'Per-user scan history by date.';
comment on index idx_members_user is 'Classrooms for a given user.';

-- Lab throws. Ranking points move by delta; scan history stays untouched.
create table if not exists lab_attempts (
    id bigint generated always as identity primary key,
    user_id bigint not null references users(id) on delete cascade,
    piece_id text not null,
    bin_id text not null,
    correct boolean not null,
    delta integer not null,
    created_at timestamptz not null default now()
);

-- Lists lab throws for ranking without scanning the whole table.
create index if not exists idx_lab_attempts_user on lab_attempts (user_id, created_at desc);
