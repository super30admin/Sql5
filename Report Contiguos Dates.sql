WITH cte1 AS (
  (SELECT fail_date AS dates, 'failed' AS status FROM Failed)
  UNION ALL
  (SELECT success_date AS dates, 'succeeded' AS status FROM Succeeded)
),
cte2 as (SELECT *, rank() over(partition by status order by dates) as rnk1, rank() over(order by dates) as rnk2
FROM cte1
WHERE dates BETWEEN '2019-01-01' AND '2019-12-31'
order by dates),
cte3 as (select *, (rnk2-rnk1) as rnk_diff
from cte2)

select status as period_state, min(dates) as start_date, max(dates) as end_date 
from cte3
group by status, rnk_diff