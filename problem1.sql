WITH all_dates AS (
  SELECT fail_date AS date, 'failed' AS state FROM Failed
  WHERE fail_date BETWEEN '2019-01-01' AND '2019-12-31'
  UNION ALL
  SELECT success_date AS date, 'succeeded' AS state FROM Succeeded
  WHERE success_date BETWEEN '2019-01-01' AND '2019-12-31'
),
date_with_rank AS (
  SELECT 
    date,
    state,
    ROW_NUMBER() OVER (PARTITION BY state ORDER BY date) AS rk
  FROM all_dates
),
grouped AS (
  SELECT 
    date,
    state,
    DATE_SUB(date, INTERVAL rk DAY) AS group_id
  FROM date_with_rank
)
SELECT 
  state AS period_state,
  MIN(date) AS start_date,
  MAX(date) AS end_date
FROM grouped
GROUP BY state, group_id
ORDER BY start_date;
