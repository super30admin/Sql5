WITH CTE AS 
(
    SELECT fail_date as 'dat', 'failed' as period_state, RANK() OVER(ORDER BY fail_date) as 'rnk' FROM failed
    where year(fail_date) = 2019
    union
    SELECT success_date as 'dat', 'succeeded' as period_state,RANK() OVER(ORDER BY succeeded_date) as 'rnk' as period_state FROM failed
    where year(fail_date) = 2019
)

WITH ACTE AS (

SELECT period_state, MIN(dat) as 'start_date',MAX(dat) as 'end_date' , RANK() over(Order by dat) as 'group_rank' - rnk as 'diff' FROM CTE

)
SELECT period_state, MIN(dat) as 'start_date',MAX(dat) as 'end_date' FROM ACTE GROUP BY diff,period_state