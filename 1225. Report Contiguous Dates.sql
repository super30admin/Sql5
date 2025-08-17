# Write your MySQL query statement below


--Using ROW_NUMBER
WITH CTE AS (SELECT f.fail_date AS dat,'failed' AS period_state,ROW_NUMBER() OVER(ORDER BY f.fail_date) AS rn FROM Failed f 
WHERE year(f.fail_date) = '2019'
UNION
SELECT s.success_date AS dat,'succeeded' AS period_state, ROW_NUMBER() OVER(ORDER BY s.success_date) AS rn FROM Succeeded s 
WHERE year(s.success_date) = '2019')


SELECT period_state, MIN(dat) AS start_date,
MAX(dat) AS end_date FROM 
(SELECT *, ROW_NUMBER() OVER(Order by dat) AS 'grn' FROM CTE) a
GROUP BY (a.grn - rn),period_state
ORDER BY start_date


--Using RANK
WITH CTE AS(
    SELECT fail_date AS 'dat', 'failed' AS period_state, 
    RANK() OVER(ORDER BY fail_date) AS rnk FROM Failed
    WHERE year(fail_date) = 2019
    UNION ALL
    SELECT success_date AS 'dat','succeeded' AS period_state,
    RANK() OVER(ORDER BY success_date) AS rnk FROM Succeeded
    WHERE year(success_date) = 2019
)

SELECT period_state, MIN(dat) AS start_date, MAX(dat) AS end_date FROM
(SELECT period_state,dat, rnk, RANK() OVER(ORDER BY dat) AS grp_rnk  FROM CTE) a
GROUP BY (grp_rnk - rnk),period_state
ORDER BY start_date
