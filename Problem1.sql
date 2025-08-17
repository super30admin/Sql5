/*
1. We rank the success and fail dates in ascending order. We use union all to combine the two tables along with the corresponding period_states.
2. Rank over the consider_date as well to get the group_rank. Dates consecutive to each other will have the same group_rank.
3. The minimum date in each group will give the start_date and the maximum date in each group will give the end_date of that period_state.
*/


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