# USING 2 CTE
WITH CTE AS (SELECT fail_date AS'dat','failed' AS status
FROM Failed WHERE YEAR(fail_Date) = '2019'
UNION ALL
SELECT success_date AS 'dat','succeeded' AS status
FROM Succeeded WHERE YEAR(success_date) = '2019')
, ACTE AS(
    SELECT dat, status ,
    RANK() OVER(PARTITION BY status ORDER BY dat) AS 'rnk',
    RANK() OVER (ORDER BY dat) AS 'group_rank'
    FROM CTE
)
SELECT a.status AS 'period_state',
MIN(a.dat) AS 'start_date',
MAX(a.dat) AS'end_date'
FROM ACTE a
GROUP BY (a.group_rank - rnk), period_state
ORDER BY start_date;

# Using one CTE 
WITH CTE AS (SELECT fail_date AS 'dat', 'failed' AS status, 
RANK() OVER (ORDER BY fail_date) AS 'rnk'
FROM Failed WHERE YEAR(fail_date) ='2019'
UNION ALL
SELECT success_date AS 'dat', 'succeeded' AS status, 
RANK() OVER (ORDER BY success_date) AS 'rnk'
FROM Succeeded WHERE YEAR(success_date) = '2019')

SELECT status AS 'period_state', 
MIN(dat)  AS 'start_date',
MAX(dat) AS 'end_date'
FROM (SELECT *,(RANK()OVER (ORDER BY dat) -rnk) AS diff 
    FROM CTE) AS temp
GROUP BY diff, period_state
ORDER BY start_date
