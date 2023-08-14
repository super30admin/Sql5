with cte as (
select fail_date dates, 'failed' as status from failed
where fail_date between '2019-01-01' and '2019-12-31'
union
select success_date dates, 'succeeded' as status from succeeded
where success_date between '2019-01-01' and '2019-12-31'
),
cte2 as(
   select dates, status,(row_number() over (order by dates) - dense_rank() over (partition by status order by dates)) grp
from cte)

select status as period_state, min(dates) as start_date, max(dates) as end_date
from cte2
group by grp,status
order by start_date