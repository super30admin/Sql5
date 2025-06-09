# Sql5

1 Problem 1 : Report Contiguos Dates		(https://leetcode.com/problems/report-contiguous-dates/ )

A system is running one task every day. Every task is independent of the previous tasks. The tasks can fail or succeed.

Write a solution to report the period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.

period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded. Interval of days are retrieved as start_date and end_date.

Return the result table ordered by start_date.
________________________________________________________________________________________________________________________
WITH A AS (
  SELECT fail_date AS d, 'failed' AS st FROM Failed WHERE fail_date BETWEEN '2019-01-01' AND '2019-12-31'
  UNION ALL
  SELECT success_date, 'succeeded' FROM Succeeded WHERE success_date BETWEEN '2019-01-01' AND '2019-12-31'
),
B AS (
  SELECT st, d,
         ROW_NUMBER() OVER (ORDER BY d)
         - ROW_NUMBER() OVER (PARTITION BY st ORDER BY d) AS grp
  FROM A
)
SELECT st AS period_state, MIN(d) start_date, MAX(d) end_date
FROM B
GROUP BY st, grp
ORDER BY start_date;



________________________________________________________________________________________________________________________
2 Problem 2 : Student Report By Geography		(https://leetcode.com/problems/students-report-by-geography/ )

A school has students from Asia, Europe, and America.

Write a solution to pivot the continent column in the Student table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia, and Europe, respectively.

The test cases are generated so that the student number from America is not less than either Asia or Europe.


________________________________________________________________________________________________________________________

WITH c AS (
  SELECT
    name,
    continent,
    ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS rn
  FROM Student
)
SELECT
  MAX(CASE WHEN continent='America' THEN name END) AS America,
  MAX(CASE WHEN continent='Asia' THEN name END)    AS Asia,
  MAX(CASE WHEN continent='Europe' THEN name END)  AS Europe
FROM c
GROUP BY rn
ORDER BY rn;




________________________________________________________________________________________________________________________

3 Problem 3 : Average Salary Department vs Company		(https://leetcode.com/problems/average-salary-departments-vs-company/description/ )

Find the comparison result (higher/lower/same) of the average salary of employees in a department to the company's average salary.

Return the result table in any order.
________________________________________________________________________________________________________________________

WITH C AS (
  SELECT pay_month,
         AVG(salary) OVER (PARTITION BY NULL) company_avg,
         AVG(salary) OVER (PARTITION BY department_id) dept_avg
  FROM Salary
)
SELECT pay_month,
       department_id,
       CASE
         WHEN dept_avg >  company_avg THEN 'higher'
         WHEN dept_avg <  company_avg THEN 'lower'
         ELSE 'same'
       END AS comparison
FROM C
GROUP BY pay_month, department_id, company_avg, dept_avg
ORDER BY pay_month, department_id;






________________________________________________________________________________________________________________________

4 Problem 4 : Game Play Analysis I		(https://leetcode.com/problems/game-play-analysis-i/ )

Write a solution to find the first login date for each player.

Return the result table in any order.

________________________________________________________________________________________________________________________


SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;





________________________________________________________________________________________________________________________
