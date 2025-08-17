# Write your MySQL query statement below
WITH DepAndMonth AS(
    SELECT DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
s.employee_id, s.amount, s.pay_date, e.department_id
FROM salary s
LEFT JOIN employee e
ON s.employee_id = e. employee_id
),
AverageSalaries AS (
    
    SELECT pay_month, amount, department_id,
    AVG(amount) OVER (PARTITION BY pay_month) AS 'CompanyAverageSalary',
    AVG(amount) OVER (PARTITION BY pay_month, department_id) AS 'DepartmentAverage' 
    FROM DepAndMonth     
)

SELECT DISTINCTpay_month, department_id, CASE 
WHEN DepartmentAverage > CompanyAverageSalary THEN 'higher'
WHEN DepartmentAverage < CompanyAverageSalary THEN 'lower'
ELSE 'same' END AS comparison
FROM AverageSalaries
ORDER BY pay_month