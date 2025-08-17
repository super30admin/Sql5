# Write your MySQL query statement below
with cte as
(
    select fail_date as dtId, "failed" as state
    , (DAYOFYEAR(fail_date)) as dayN, (row_number() over (order by fail_date)) as rowId
    , (DAYOFYEAR(fail_date)) - (row_number() over (order by fail_date)) as per_grp 
        from failed 
        where year(fail_date) = '2019'
    UNION ALL
    select success_date as dtId, "succeeded" as state 
    , (DAYOFYEAR(success_date)) as dayN, (row_number() over (order by success_date)) as rowId
    , (DAYOFYEAR(success_date)) - (row_number() over (order by success_date)) as per_grp 
        from succeeded 
        where year(success_date) = '2019' 
)

select state as 'period_state', min(dtId) as start_date, max(dtId) as end_date
 from cte
 group by per_grp, state
 order by 2



