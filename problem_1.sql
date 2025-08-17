--Report Contiguos Dates

WITH CTE AS (
    SELECT fail_date AS 'dat', 'failed' AS period_state, rank() OVER (ORDER BY fail_date) AS 'rnk'
    FROM Failed
    WHERE YEAR(fail_date)=2019
    UNION ALL
    SELECT success_date AS 'dat', 'succeeded' AS period_state, rank() OVER (ORDER BY success_date) AS 'rnk'
    FROM Succeeded
    WHERE YEAR(success_date)=2019;
)
SELECT period_state, MIN(dat) AS 'start_date', MAX(dat) AS 'end_date'
FROM (
    SELECT *, (RANK() OVER (ORDER BY dat) - rnk) AS 'group_rnk'
    FROM CTE
) AS y
GROUP BY group_rnk, period_state
ORDER BY start_date;