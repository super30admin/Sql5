WITH CTE AS(
SELECT fail_date as 'dat' , 'failed' As period_state , rank() OVER(ORDER by fail_date) as 'rnk' from failed
 WHERE YEAR(fail_date) = 2019
UNION ALL
SELECT success_date  as 'dat' , 'succeeded' As period_state, rank() OVER(ORDER by success_date) as 'rnk' from Succeeded 
WHERE YEAR(success_date) = 2019
)
SELECT period_state , MIN(dat) as start_date , MAX(dat) as end_date FROM (SELECT * , rank() OVER(order by dat) - rnk as diff from CTE)as y
group by diff, period_state
order by start_date;