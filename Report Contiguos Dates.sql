WITH cte AS (
    SELECT  fail_date AS date,
            'failed' AS period_state,
            RANK() OVER(ORDER BY fail_date) rnk
    FROM failed
    WHERE fail_date BETWEEN '2019-01-01' AND '2019-12-31'
    UNION ALL
    SELECT  success_date AS date,
            'succeeded' AS period_state,
            RANK() OVER(ORDER BY success_date) rnk
    FROM succeeded
    WHERE success_date BETWEEN '2019-01-01' AND '2019-12-31'
)
SELECT  period_state,
        MIN(date) AS start_date,
        MAX(date) AS end_date
FROM (
    SELECT  *,
            RANK() OVER(ORDER BY date) main_rnk,
            RANK() OVER(ORDER BY date) - rnk AS group_col -- this is done to identify the difference between the ranks.
            -- which helps to group. All records with similar difference value is considered in same group.
    FROM cte
    ORDER BY date
) a
GROUP BY period_state, group_col;