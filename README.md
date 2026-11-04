# EcoScan — base de datos

Esquema para **Supabase (Postgres)**. El backend también puede crear estas tablas al arrancar si tiene `DATABASE_URL`.

## Cómo aplicarlo

1. Crea el proyecto en Supabase.
2. Abre SQL Editor y ejecuta `schema.sql`.
3. Copia la URI de conexión y configúrala en Render como `DATABASE_URL`.

Si Render ya tiene `DATABASE_URL`, `init_db()` del backend crea o completa las mismas tablas.

## Tablas

| Tabla | Uso |
|-------|-----|
| `users` | Cuentas, invitados y dueños de salón |
| `scans` | Historial de residuos, puntos, foto |
| `classrooms` | Salones y código de invitación |
| `classroom_members` | Miembros y ranking |

## Relaciones

- Un usuario tiene muchos escaneos (`scans.user_id` → `users.id`).
- Un usuario puede ser dueño de salones (`classrooms.owner_id` → `users.id`).
- Un salón tiene muchos miembros (`classroom_members`).
- Si se borra un usuario o un salón, Postgres borra en cascada lo que depende.

Índices: `idx_scans_user` (historial), `idx_members_user` (mis salones).
