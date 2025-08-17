# Write your MySQL query statement belows
with cte1 as(
select name as America, row_number()over(order by name) as rnk
from Student 
where continent = 'America' 
),
cte2 as(
    select name as Asia, row_number()over(order by name) as rnk
from Student 
where continent = 'Asia' 
),
cte3 as 
(
select name as Europe, row_number()over(order by name) as rnk
from Student 
where continent = 'Europe' )

select cte1.America, cte2.Asia,cte3.Europe
from cte2
right join cte1
on cte2.rnk=cte1.rnk
left join cte3 
on cte1.rnk=cte3.rnk