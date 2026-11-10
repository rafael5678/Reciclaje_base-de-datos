-- Penalización del laboratorio. El ranking hace scan_points + esta suma.

select coalesce(sum(delta), 0) as lab_penalty
from lab_attempts
where user_id = 0;
