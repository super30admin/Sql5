with id_table as(select *, row_number() over(partition by continent order by name) as id
from Student),
cte1 as(select * 
from id_table
where continent = 'America'),
cte2 as (select * 
from id_table
where continent = 'Europe'),
cte3 as(select * 
from id_table
where continent = 'Asia')

select cte1.name as America, cte3.name as Asia, cte2.name as Europe
from cte1
left join cte2 on cte1.id = cte2.id
left join cte3 on cte1.id = cte3.id

