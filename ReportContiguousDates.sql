WITH union_cte
    AS (
        SELECT 
            fail_date as 'dat',
            'failed' as 'status'
            FROM   
                Failed
            WHERE YEAR(fail_date) = 2019
        UNION ALL
        SELECT 
            success_date as 'dat'
            'succeeded' as 'status'
        FROM
            Succeeded
        WHERE YEAR(fail_date) = 2019
    )

rn_cte AS (
    SELECT *,
    (ROW_NUMBER() OVER (ORDER BY date)) - (ROW_NUMBER() OVER (PARTITION BY status ORDER BY date)) AS group_id
    FROM union_cte
)
SELECT
    status AS period_state,
    MIN(date) AS start_date,
    MAX(date) AS end_date
FROM rn_cte
GROUP BY period_state, group_id
ORDER BY start_date;