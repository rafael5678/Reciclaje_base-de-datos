# Puntos

`scans.points` lo escribe el backend al guardar el escaneo.
`lab_attempts.delta` ajusta el ranking: 0 o -5.
El total visible es `max(0, suma de scans + suma de delta)`.
No hay trigger SQL que recálcule esto.
