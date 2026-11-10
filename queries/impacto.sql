-- Impacto de un usuario. Solo lectura. El API arma esto en Python.

select
    coalesce(sum(weight_kg), 0) as kg,
    coalesce(sum(co2_kg) filter (where separated_well), 0) as co2_kg
from scans
where user_id = 0;
