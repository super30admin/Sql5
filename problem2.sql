select min(America) as America, min(Asia) as Asia, min(Europe) as Europe from
(select
case when continent= "America" then name else null end as "America",
case when continent = "Asia" then name else null end as "Asia",
case when continent = "Europe" then name end as "Europe",
row_number() over (partition by continent order by name) as rnk
from student
) t1
group by rnk