# Write your MySQL query statement below
WITH cte AS (
    SELECT 
        fail_date AS dt, 
        'failed' AS period_state, 
        RANK() OVER (ORDER BY fail_date) AS rnk
    FROM Failed
    WHERE YEAR(fail_date) = 2019

    UNION ALL

    SELECT 
        success_date AS dt, 
        'succeeded' AS period_state, 
        RANK() OVER (ORDER BY success_date) AS rnk
    FROM Succeeded
    WHERE YEAR(success_date) = 2019
),
cte2 AS (
    SELECT 
        *, 
        (RANK() OVER (ORDER BY dt) - rnk) AS group_rank
    FROM cte
)
SELECT period_state, min(dt) as start_date,max(dt) as end_date
FROM cte2
group by group_rank, period_state
order by 2;
