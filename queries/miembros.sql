-- Cuántos miembros tiene un salón. Usa la clave compuesta.

select count(*) as members
from classroom_members
where classroom_id = 0;
