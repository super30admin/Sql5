# Write your MySQL query statement below
WITH CTE AS(
    SELECT fail_date AS dat, 'failed' AS period_state, 
    RANK() OVER(ORDER BY fail_date) AS rnk 
    FROM Failed WHERE YEAR(fail_date) = 2019
    UNION ALL
    SELECT success_date AS dat, 'succeeded' AS period_state, 
    RANK() OVER(ORDER BY success_date) AS rnk 
    FROM Succeeded WHERE YEAR(success_date) = 2019
)
SELECT period_state, MIN(dat) AS start_date, MAX(dat) AS end_date 
FROM(
    SELECT *, (RANK() OVER(ORDER BY dat))- rnk AS group_rank 
    FROM CTE
    )b
GROUP BY period_state, group_rank
ORDER BY 2;
