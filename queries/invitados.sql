-- Cuentas invitadas. El correo termina en @invitado.ecoscan.
-- No borra nada. Sirve para ver cuántos invitados hay.

select id, name, email, created_at
from users
where email like '%@invitado.ecoscan'
order by created_at desc;
