-- Puntos de escaneo de un usuario. El ranking suma esto más lab_attempts.delta.

select coalesce(sum(points), 0) as scan_points
from scans
where user_id = 0;
