# Write your MySQL query statement below
WITH CTE AS (SELECT fail_date AS 'dates', 'failed' AS period_state, rank() OVER(ORDER BY fail_date) AS 'rnk'
    FROM Failed WHERE YEAR(fail_date) = 2019
    UNION ALL
    SELECT success_date AS 'dates', 'succeeded' AS period_state, rank() OVER(ORDER BY success_date) AS 'rnk'
    FROM Succeeded WHERE YEAR(success_date) = 2019
)
SELECT period_state, min(dates) AS 'start_date', max(dates) AS 'end_date' FROM (
    SELECT *, (rank() OVER(ORDER BY dates) -rnk) AS grnk FROM CTE
) AS rndom GROUP BY grnk, period_state ORDER BY start_date;