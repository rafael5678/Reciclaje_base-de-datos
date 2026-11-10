-- Escaneos bien vs mal separados. Solo cuenta.

select
    count(*) filter (where separated_well) as well_sorted,
    count(*) filter (where not separated_well) as poorly_sorted
from scans
where user_id = 0;
