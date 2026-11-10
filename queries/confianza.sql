-- Confianza media de los escaneos de un usuario. No cambia filas.

select round(avg(confidence)::numeric, 3) as confidence_avg
from scans
where user_id = 0;
