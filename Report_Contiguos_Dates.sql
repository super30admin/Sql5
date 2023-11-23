# Write your MySQL query statement below
with CTE as (
select 'failed' as period_state ,fail_date as 'date',
rank() over (order by fail_date) as rnk
from Failed
where fail_date between '2019-01-01' and  '2019-12-31'
union all
select 'succeeded' as period_state ,success_date as 'date' ,
rank() over (order by success_date) as rnk
from Succeeded
where success_date between '2019-01-01' and  '2019-12-31'
)

select period_state, min(date) as start_date, max(date) as end_date
from
(select *, (rank() over (order by date)) - rnk as group_rank from CTE) as b
group by period_state,group_rank