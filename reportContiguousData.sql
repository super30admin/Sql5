
WITH CTE AS (
    select fail_date, 'failed' as period_state, rank() over(order by fail_date) as 'rnk' from failed where 
    year(fail_date) = '2019'
    union
    select success_date, 'succeeded' as period_state, rank() over(order by success_date) as 'rnk' from succeeded where 
    year(success_date) = '2019'
),
acte as (
    select period_state, fail_date as 'day', rnk, rank() over(order by fail_date) as 'grp_rnk'  from cte
)
-- select * from acte
select period_state, min(day) as start_date, max(day) as end_date from acte group by (grp_rnk - rnk), period_state order by start_date; 