-- Dueño de un salón. owner_id apunta a users.id.

select c.id, c.name, u.name as owner_name, u.email
from classrooms c
join users u on u.id = c.owner_id
where c.id = 0;
