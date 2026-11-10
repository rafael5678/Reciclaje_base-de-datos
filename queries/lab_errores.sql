-- Errores del laboratorio. delta = -5. No toca scans.

select piece_id, bin_id, created_at
from lab_attempts
where user_id = 0 and correct = false
order by created_at desc;
