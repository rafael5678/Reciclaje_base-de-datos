-- Salones de un usuario. Usa idx_members_user.

select
    c.id,
    c.name,
    c.code,
    c.owner_id,
    c.created_at,
    m.joined_at
from classroom_members m
join classrooms c on c.id = m.classroom_id
where m.user_id = 0
order by m.joined_at desc;
