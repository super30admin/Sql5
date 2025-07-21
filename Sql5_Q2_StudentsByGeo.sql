with cte1 as
(
select 
    name as 'America'
    , row_number() over(order by name) as rnk
from student
where continent = 'America'
order by 1
)
, cte2 as
(
select
    name as 'Asia'
    , row_number() over(order by name) as rnk
from student
where continent = 'Asia'
order by 1
)
, cte3 as
(
select
    name as 'Europe'
    , row_number() over(order by name) as rnk
from student
where continent = 'Europe'
order by 1
)

select 
    cte1.America
    , cte2.Asia
    , cte3.Europe
from cte2 right join cte1 on cte1.rnk = cte2.rnk left join cte3 on cte1.rnk = cte3.rnk
