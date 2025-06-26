'''
3 Problem 3 : Average Salary Department vs Company (https://leetcode.com/problems/average-salary-departments-vs-company/description/ )
'''

WITH companyAvg AS (
    SELECT date_format(pay_date, '%Y-%m') AS 'pay_month', AVG(amount) AS 'CompanyAvg' FROM Salary GROUP BY pay_month),
deptAvg AS (
    SELECT date_format(pay_date, '%Y-%m') AS 'pay_month', department_id, AVG(amount) AS 'departmentAvg' FROM Salary JOIN Employee ON Salary.employee_id = Employee.employee_id GROUP BY department_id, pay_month
)
SELECT deptAvg.pay_month, department_id, (
    CASE
        WHEN departmentAvg > CompanyAvg THEN 'higher'
        WHEN departmentAvg < CompanyAvg THEN 'lower'
        ELSE 'same'
    END    
) AS 'comparison' FROM companyAvg JOIN deptAvg ON deptAvg.pay_month = companyAvg.pay_month