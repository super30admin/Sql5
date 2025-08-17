WITH CTE AS(
    SELECT fail_date AS 'date', 'failed' AS 'period_state', 
    rank() OVER (ORDER BY fail_date) AS 'rnk' FROM failed 
    WHERE YEAR(fail_date) = 2019
    UNION
    SELECT success_date AS 'date', 'succeeded' AS 'period_state', 
    rank() OVER (ORDER BY success_date) AS 'rnk' FROM succeeded
    WHERE YEAR(success_date) = 2019)

SELECT period_state, MIN(date) AS 'start_date', MAX(date) AS 'end_date'
FROM (SELECT *, (rank() OVER (ORDER BY date) - rnk) AS 'diff' FROM CTE) AS y GROUP BY diff, period_state ORDER BY start_date