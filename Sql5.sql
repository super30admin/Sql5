#Sql5: 
#1 Problem 1 : Report Contiguos Dates (https://leetcode.com/problems/report-contiguous-dates/ )

WITH CTE AS(
SELECT fail_date as 'dat' , 'failed' As period_state , rank() OVER(ORDER by fail_date) as 'rnk' from failed
 WHERE YEAR(fail_date) = 2019
UNION ALL
SELECT success_date  as 'dat' , 'succeeded' As period_state, rank() OVER(ORDER by success_date) as 'rnk' from Succeeded 
WHERE YEAR(success_date) = 2019
)
SELECT period_state , MIN(dat) as start_date , MAx(dat) as end_date 
FROM (SELECt * , rank() OVER(order by dat) - rnk as  'diff' from CTE) as y group by diff, period_state ORDER BY start_date;


#2 Problem 2 : Student Report By Geography (https://leetcode.com/problems/students-report-by-geography/ )

WITH first as(
    SELECT name as 'America', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk' From student WHERE continent = 'America'
),
second as(
    SELECT name as 'Asia', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk' From student WHERE continent = 'Asia'
),
third as(
    SELECT name as 'Europe', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk' From student WHERE continent = 'Europe'
)

SELECT America , Asia , Europe FROM second RIGHT JOIN first on first.rnk = second.rnk LEFT JOIN third 
ON first.rnk = third.rnk;

#3 Problem 3 : Average Salary Department vs Company (https://leetcode.com/problems/average-salary-departments-vs-company/description/ )

# Write your MySQL query statement below
with CompanyAvg as (
select date_format(pay_date,'%Y-%m') as 'pay_month', AVG(amount) as 'CompanyAvg' from Salary group by pay_month
),
DeptAvg as(
    select date_format(pay_date,'%Y-%m') as 'pay_month', department_id, AVG(amount) as 'departmentAvg' from Salary join Employee on Salary.employee_id = Employee.employee_id group by department_id, pay_month 
) 

select DeptAvg.pay_month, department_id, (
    CASE
        WHEN DeptAvg.departmentAvg > CompanyAvg.CompanyAvg THEN 'higher'
        WHEN DeptAvg.departmentAvg < CompanyAvg.CompanyAvg THEN 'lower'
        ELSE 'same'
    END
) as 'comparison' from CompanyAvg join DeptAvg on DeptAvg.pay_month = CompanyAvg.pay_month;


$4 Problem 4 : Game Play Analysis I (https://leetcode.com/problems/game-play-analysis-i/ )

# Write your MySQL query statement below
select player_id, MIN(event_date) as 'first_login' from Activity group by player_id;