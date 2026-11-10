# Relaciones

- Un usuario tiene muchos escaneos.
- Borrar un usuario borra sus escaneos (`on delete cascade`).
- Un usuario puede crear salones.
- Un salón tiene muchos miembros. La clave es `(classroom_id, user_id)`.
- Un tiro de laboratorio pertenece a un usuario. No pisa `scans`.
