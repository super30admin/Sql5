with master_table as
(
    select 
        fail_date as 'date'
        , 'failed' as period_state
    from 
        Failed
    where year(fail_date) = 2019
    union
    select 
        success_date as 'date'
        , 'succeeded' as period_state
    from 
        Succeeded
    where year(success_date) = 2019
)
, ranking_period_state as 
(
    select 
        date
        , period_state
        , rank() over(order by date) - rank() over(partition by period_state order by date) as diff
    from 
        master_table
)
select 
    period_state
    , min(date) as start_date
    , max(date) as end_date
from 
    ranking_period_state
group by 
    diff, period_state
order by start_date