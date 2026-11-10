# Seguridad de datos

- `password_hash` es PBKDF2-HMAC-SHA256 con sal. No se selecciona en el API de login.
- `ECOSCAN_SECRET` firma sesiones. Vive en Render, no en este repo.
- `DATABASE_URL` tampoco se versiona.
