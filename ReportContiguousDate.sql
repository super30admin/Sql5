with cte as (
select 'succeeded' as period_state,
success_date as consider_date, rank() over (order by success_date) rnk
from Succeeded
where year(success_date) = '2019'
union all
select "failed" as period_state,
fail_date as consider_date, rank() over (order by fail_date) rnk
from Failed
where year(fail_date) = '2019'
)

select period_state, min(consider_date) 'start_date', max(consider_date) 'end_date'
from
(
select *,  rank() over( order by consider_date) - rnk 'group_rank'
from  cte
)
interm
group by period_state, group_rank
order by start_date