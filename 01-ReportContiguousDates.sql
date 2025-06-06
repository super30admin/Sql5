-- Sql5 Question 1 - Report Contiguous Dates (https://leetcode.com/problems/report-contiguous-dates/)
-- Creating a CTE where we combine failed and succeeded tables and rank both failed and succeeded separately by date
WITH CTE AS (
    SELECT fail_date AS 'dat', 'failed' AS period_state, RANK() OVER(ORDER BY fail_date) AS 'rnk'
    FROM failed
    WHERE YEAR(fail_date) = 2019
    UNION ALL
    SELECT success_date AS 'dat', 'succeeded' AS period_state, RANK() OVER(ORDER BY success_date) AS 'rnk'
    FROM succeeded
    WHERE YEAR(success_date) = 2019 
),
-- Labelled ranks the above CTE table by date regardless of fail or success, which is basically group rank and also finds difference between group rank and rnk. If difference is same they belong to same interval, basically meaning they are continuous
labelled AS (
    SELECT *, RANK() OVER(ORDER BY dat) - rnk AS grp FROM CTE
)
-- Final Output by giving the period_state, minimum date from labelled as start_date and maximum date from labelled as end_date while grouping them by success and failure and also by difference between group rank and rnk
SELECT period_state, MIN(dat) AS start_date, MAX(dat) AS end_date
FROM labelled
GROUP BY period_state, grp;