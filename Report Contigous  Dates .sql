with cte as (select fail_date, rank() over( order by fail_date) as 'rnk', 'failed' as period_state from failed where year(fail_date)=2019
union
select success_date, rank() over(order by success_date) as 'rnk', 'succeeded' as period_state from succeeded where year(success_date)=2019)


select period_state,  min(fail_date) as 'start_date',max(fail_date) as 'end_date' 
from ( select *, (rank() over (order by fail_date) -rnk) as 'diff' from cte) as y 
group by diff, period_state order by start_date