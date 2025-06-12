# Write your MySQL query statement below
WITH combined_status AS (

    SELECT 
        fail_date AS dat, 
        'failed' AS period_state
    FROM 
        Failed
    WHERE 
        YEAR(fail_date) = 2019

    UNION ALL

    SELECT 
        success_date AS dat, 
        'succeeded' AS period_state
    FROM 
        Succeeded
    WHERE 
        YEAR(success_date) = 2019
),
ranked_status AS (

    SELECT 
        dat,
        period_state,
        ROW_NUMBER() OVER (ORDER BY dat) AS row_num,
        RANK() OVER (PARTITION BY period_state ORDER BY dat) AS state_rank
    FROM 
        combined_status
),
grouped_status AS (
    -- Use the difference between row_num and state_rank as grouping key
    SELECT 
        dat,
        period_state,
        ROW_NUMBER() OVER (ORDER BY dat) - RANK() OVER (PARTITION BY period_state ORDER BY dat) AS grp
    FROM 
        combined_status
)

SELECT 
    period_state,
    MIN(dat) AS start_date,
    MAX(dat) AS end_date
FROM 
    grouped_status
GROUP BY 
    period_state, grp
ORDER BY 
    start_date;
