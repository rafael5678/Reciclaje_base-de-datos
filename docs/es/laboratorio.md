# Laboratorio

`lab_attempts` guarda cada tiro:

- `correct` si la caneca era la indicada
- `delta` 0 si acertó, -5 si falló
- el ranking hace `max(0, scan_points + sum(delta))`

No hay van ni ruta. Solo banco de separación.
