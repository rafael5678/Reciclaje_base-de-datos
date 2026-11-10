-- Cuántos escaneos hay por código de catálogo.
-- Los códigos viven en el backend, no en una tabla de materiales.

select material_code, count(*) as n
from scans
group by material_code
order by n desc, material_code;
