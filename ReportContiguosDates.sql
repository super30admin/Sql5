# Write your MySQL query statement below
with cte as (select fail_date as 'dat' , 'failed' as period_state, rank() over (order by fail_date) as 'rnk' from failed where year(fail_date) = 2019
union all
select success_date as 'dat', 'succeeded' as period_state, rank() over (order by success_date) as 'rnk'  from succeeded where year(success_date) = 2019
)

select period_state, min(dat) as 'start_date', max(dat) as 'end_date' from (
    select * , (rank() over (order by dat) - rnk) as 'group_rank' from cte) as y 
    group by group_rank , period_state order by start_date;