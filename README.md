# Sql5

1 Problem 1 : Report Contiguos Dates		(https://leetcode.com/problems/report-contiguous-dates/ )
Solution:

WITH CTE AS (
    SELECT  fail_date AS dat,'failed' AS period_state,
        RANK() OVER (ORDER BY fail_date) AS rnk
    FROM failed
    WHERE YEAR(fail_date) = 2019

    UNION ALL

    SELECT  success_date AS dat,'succeeded' AS period_state,
        RANK() OVER (ORDER BY success_date) AS rnk
    FROM succeeded
    WHERE YEAR(success_date) = 2019
),
CTE2 AS (
    SELECT *, RANK() OVER (ORDER BY dat) - rnk AS grp
    FROM CTE
)
SELECT period_state, MIN(dat) AS start_date, MAX(dat) AS end_date
FROM CTE2
GROUP BY period_state, grp
ORDER BY start_date;



2 Problem 2 : Student Report By Geography		(https://leetcode.com/problems/students-report-by-geography/ )
Solution:

# Write your MySQL query statement below
with cte as (Select name as 'America', Row_number() over(order by name) As 'rnk'
From student 
where continent = 'America'
order by America),

cte2 as (Select name as 'Asia', Row_number() over(order by name) As 'rnk'
From student 
where continent = 'Asia'
order by Asia),
 
 cte3 as (Select name as 'Europe', Row_number() over(order by name) As 'rnk'
From student 
where continent = 'Europe'
order by Europe)

Select America,Asia,Europe 
from cte2 c2
right join cte c1
on c1.rnk = c2.rnk
left join cte3 c3
on c1.rnk = c3.rnk

3 Problem 3 : Average Salary Department vs Company		(https://leetcode.com/problems/average-salary-departments-vs-company/description/ )
Solution:

# Write your MySQL query statement below
WITH companyAvg as(
SELECT date_format(pay_date, '%Y-%m') as 'pay_month' , AVG(amount) AS 'CompanyAvg' from salary GROUP BY pay_month
),
deptAvg AS(
SELECT date_format(pay_date, '%Y-%m') as 'pay_month', department_id  , AVG(amount) AS 'departmentAvg' FROM salary join
employee ON salary.employee_id = employee.employee_id GROUP BY department_id,pay_month
)

SELECT deptAvg.pay_month , department_id , (
    CASE
        WHEN departmentAvg > CompanyAvg THEN 'higher'
        WHEN departmentAvg < CompanyAvg THEN 'lower'
        ELSE 'same'
    END
) AS 'comparison' FROM companyAvg JOIN deptAvg ON deptAvg.pay_month = companyAvg.pay_month;

4 Problem 4 : Game Play Analysis I		(https://leetcode.com/problems/game-play-analysis-i/ )
Solution:

Select player_id, min(event_date) as first_login
from Activity
group by player_id 
