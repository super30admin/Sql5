# Write your MySQL query statement below
with cte as(
select fail_date as 'dat','failed' as period_state,rank() over(order by fail_date) as rnk 
from failed
where year(fail_date)=2019
union 
select success_date  as 'dat','succeeded' as period_state,
rank() over(order by success_date) as rnk
from Succeeded
where year(success_date)=2019
order by dat)

select period_state,min(dat) as start_date,
max(dat) as end_date
from (select *, rank() over(order by dat)-rnk as 'diff' from cte) as Y
group by diff, period_state
order by start_date;
