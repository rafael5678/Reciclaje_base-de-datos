# EcoScan — base de datos

Esquema para **Supabase (Postgres)**. El backend también crea estas tablas al arrancar si existe `DATABASE_URL`.

## Cómo aplicarlo

1. Crea el proyecto en Supabase.
2. Abre el SQL Editor y ejecuta `schema.sql`.
3. Copia la URI y ponla en Render como `DATABASE_URL`.

Si Render ya tiene `DATABASE_URL`, `init_db()` del backend crea o completa las mismas tablas, incluida `lab_attempts`.

## Tablas

| Tabla | Uso |
|-------|-----|
| `users` | Cuentas, invitados y dueños de salón |
| `scans` | Historial, puntos, foto opcional |
| `classrooms` | Salones y semilla de invitación |
| `classroom_members` | Membresía y ranking |
| `lab_attempts` | Tiros del laboratorio (penalización) |

## Relaciones

- Un usuario tiene muchos escaneos (`scans.user_id` → `users.id`).
- Un usuario puede ser dueño de salones (`classrooms.owner_id` → `users.id`).
- Un salón tiene muchos miembros (`classroom_members`).
- Un usuario tiene muchos tiros de laboratorio (`lab_attempts`).
- Borrar un usuario o un salón hace cascade en Postgres.

Índices: `idx_scans_user`, `idx_members_user`, `idx_lab_attempts_user`.

Consultas de solo lectura en `queries/`. Códigos de catálogo en `reference/`. Textos en español e inglés en `docs/`.
