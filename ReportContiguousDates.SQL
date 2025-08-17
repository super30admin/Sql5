WITH CTE AS (
    SELECT fail_date as dateData, "failed" as period_state from failed 
    where fail_date between "2019-01-01" and "2019-12-31"
    Union all
    SELECT success_date as dateData, "succeeded" as period_state from Succeeded 
    where success_date between "2019-01-01" and "2019-12-31"
), 
CTE2 as (
    SELECT *, rank() over(partition by period_state order by datedata)as rnk, rank() over( order by datedata)as grp_rnk, rank() over(order by datedata) - rank() over(partition by period_state  order by datedata) as diff_rnk from CTE
)
SELECT period_state, MIN(dateData) as start_date, MAX(dateData) as end_date from CTE2
group by diff_rnk, period_state
order by start_date