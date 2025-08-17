with America as(
    select name, row_number() over (partition by continent order by name) as row_id
    from Student where continent = 'America'
),
Asia as (
    select name, row_number() over (partition by continent order by name) as row_id
    from Student where continent = 'Asia'
),
Europe as
(
    select name, row_number() over (partition by continent order by name) as row_id
    from Student where continent = 'Europe'
)

select a.name as America, aa.name as Asia, e.name as Europe
from America a left join Asia aa
on a.row_id = aa.row_id
left join Europe e
on a.row_id = e.row_id;