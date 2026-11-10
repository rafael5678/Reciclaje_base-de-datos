# Data security

- `password_hash` is PBKDF2-HMAC-SHA256 with salt. Login never returns it.
- `ECOSCAN_SECRET` signs sessions. Keep it on Render.
- Do not commit `DATABASE_URL`.
