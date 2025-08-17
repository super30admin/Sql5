
WITH CTE AS(SELECT f.fail_date AS 'Date','failed' AS status, RANK() OVER (ORDER BY f.fail_date) AS 'rnk'  FROM Failed f
WHERE YEAR(f.fail_date) = 2019
UNION
SELECT s.success_date AS 'Date','succeeded' AS status, RANK() OVER (ORDER BY s.success_date) AS 'rnk'  FROM Succeeded s
WHERE YEAR(s.success_date) = 2019
),
-- SELECT * FROM CTE  ORDER BY Date


CTE2 AS (
SELECT *, ROW_NUMBER() OVER(ORDER BY c.Date ) AS 'row_id'FROM CTE c 
ORDER BY c.Date
)

SELECT status AS 'period_state', MIN(Date) AS start_date, MAX(Date) AS end_date
FROM CTE2
GROUP BY status, (row_id - rnk)
ORDER BY start_date


