SELECT departmentSalary.pay_month, department_id, 
CASE 
    WHEN departmentAvg > companyAvg THEN 'higher'
    WHEN departmentAvg < companyAvg THEN 'lower'
    ELSE 'same'
END AS 'comparison'
FROM (
    SELECT date_format(pay_date, '%Y-%m') AS 'pay_month', department_id, AVG(amount) AS 'departmentAvg'
    FROM Salary JOIN Employee ON Salary.employee_id = Employee.employee_id
    GROUP BY department_id, pay_month
) AS departmentSalary 
JOIN (
    SELECT date_format(pay_date, '%Y-%m') AS 'pay_month', AVG(amount) AS 'companyAvg'
    FROM Salary 
    GROUP BY pay_month
) AS companySalary 
ON departmentSalary.pay_month = companySalary.pay_month;
