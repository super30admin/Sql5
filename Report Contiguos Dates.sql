WITH CTE AS (
    SELECT fail_date AS 'dat', 'failed' AS period_state FROM Failed WHERE YEAR(fail_date) = 2019
    UNION ALL
    SELECT success_date AS 'dat', 'succeeded' AS period_state FROM Succeeded WHERE YEAR(success_date) = 2019
),
ACTE AS (
    SELECT dat, period_state, ROW_NUMBER() OVER (ORDER BY dat) AS 'rn_overall', ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY dat) AS 'rn_period' FROM CTE
),
ANCTE AS (
    SELECT dat, period_state, rn_overall - rn_period AS 'group_key' FROM ACTE
)
SELECT period_state, MIN(dat) AS 'start_date', MAX(dat) AS 'end_date' FROM ANCTE GROUP BY period_state, group_key ORDER BY start_date