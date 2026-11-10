-- Historial de un usuario. Igual que ScanRepository.list_by_user.
-- No cambia filas. El backend ya usa este orden.

select
    id,
    material_code,
    object_name,
    confidence,
    separated_well,
    points,
    weight_kg,
    co2_kg,
    created_at,
    (photo is not null) as has_photo
from scans
where user_id = 0 -- reemplaza por el id real
order by created_at desc, id desc;
