-- Ranking de un salón. El orden final lo resuelve Python en el backend
-- porque combina scans.points con lab_attempts.delta.

select
    u.id,
    u.name,
    coalesce(sum(s.points), 0) as scan_points,
    coalesce((
        select sum(a.delta) from lab_attempts a where a.user_id = u.id
    ), 0) as lab_delta
from classroom_members m
join users u on u.id = m.user_id
left join scans s on s.user_id = u.id
where m.classroom_id = 0
group by u.id, u.name;
