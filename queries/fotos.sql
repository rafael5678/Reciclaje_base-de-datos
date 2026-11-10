-- Escaneos con y sin foto. photo es bytea opcional.

select
    count(*) filter (where photo is not null) as with_photo,
    count(*) filter (where photo is null) as without_photo
from scans;
