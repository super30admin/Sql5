-- Sql5 Question 3 - Average Salary Departments vs Company (https://leetcode.com/problems/average-salary-departments-vs-company/description/)
-- Finding the avergae salary of company
WITH companyavg AS(
    SELECT date_format(pay_date, '%Y-%m') AS 'pay_month', AVG(amount) AS 'CompanyAvg'
    FROM Salary
    GROUP BY pay_month
),
-- Finding the average salary of employees in a department
deptAvg AS(
    SELECT date_format(pay_date, '%Y-%m') AS 'pay_month', department_id, AVG(amount) AS
    'departmentAvg'
    FROM Salary
    JOIN Employee 
    ON Salary.employee_id = Employee.employee_id
    GROUP BY department_id, pay_month
)
-- Comparing the results of companyAvg and deptAvg CTEs and returning the result
SELECT deptAvg.pay_month AS 'pay_month', department_id, 
(CASE 
    WHEN departmentAvg > CompanyAvg THEN 'higher'
    WHEN departmentAvg < CompanyAvg THEN 'lower'
    ELSE 'same'
    END
) AS 'comparison'
FROM companyAvg JOIN deptAvg 
ON companyAvg.pay_month = deptAvg.pay_month;