select
 p.first_name,
 p.last_name,
 p.age,
 p.salary,
 t.id,
 t.name
from player as p
 inner join team as t
 on p.id=t.id;

