--  Problem 1 : Report Contiguos Dates
with states as (
    select fail_date as day,'failed' as state from failed_date
    union all
    select success_date  as day, 'Succeeded' as state from Succeeded_date
),
states_with_row AS (
    Select row_number() over(partition by state order by day) as row_id,day,state from states)

select state as 'period_state',min(day) as 'start_date',max(day) as 'end_date' from states_with_row 
where day between "2019-01-01" AND "2019-12-31" group by state,date_sub(day,interval row_id day) order by start_date