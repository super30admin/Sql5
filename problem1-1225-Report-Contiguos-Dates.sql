WITH combine_states AS (
  SELECT
    fail_date AS `date`,
    'failed' AS period_state
  FROM Failed
  where year(fail_date) = 2019

  UNION ALL

  SELECT
    success_date AS `date`,
    'succeeded' AS period_state
  FROM Succeeded
  where year(success_date) = 2019
)

, cte_based_on_state as (
 SELECT
    `date`,
    period_state,
    CASE
      WHEN LAG(period_state) OVER (ORDER BY date) = period_state THEN 0
      ELSE 1
    END AS state_change_flag
  FROM combine_states
  order by `date`
)

,grouped_rank AS (
  SELECT
    `date`,
    period_state,
    SUM(state_change_flag) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rnk
  FROM cte_based_on_state
)

select
period_state,
min(`date`) as start_date,
max(`date`) as end_date
from
grouped_rank
group by rnk