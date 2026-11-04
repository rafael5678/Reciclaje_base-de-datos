# EcoScan — database

Schema for **Supabase (Postgres)**. The backend can also create these tables on boot when `DATABASE_URL` is set.

## How to apply it

1. Create the project in Supabase.
2. Open the SQL Editor and run `schema.sql`.
3. Copy the connection URI and set it on Render as `DATABASE_URL`.

If Render already has `DATABASE_URL`, backend `init_db()` creates or completes the same tables.

## Tables

| Table | Use |
|-------|-----|
| `users` | Accounts, guests, and classroom owners |
| `scans` | Waste history, points, photo |
| `classrooms` | Classrooms and invite seed |
| `classroom_members` | Membership and ranking |

## Relations

- A user has many scans (`scans.user_id` → `users.id`).
- A user may own classrooms (`classrooms.owner_id` → `users.id`).
- A classroom has many members (`classroom_members`).
- Deleting a user or classroom cascades in Postgres.

Indexes: `idx_scans_user` (history), `idx_members_user` (my classrooms).
