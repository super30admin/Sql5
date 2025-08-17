--Average Salary Department vs Company

WITH departmentSalary AS (
    SELECT department_id, date_format(pay_date, '%Y-%M') AS pay_month, AVG(amount) AS department_average_salary
    FROM Salary
    JOIN Employee ON Salary.employee_id = Employee. employee_id
    GROUP BY department_id, pay_month
),
companySalary AS (
    SELECT date_format(pay_date, '%Y-%M') AS pay_month, AVG(amount) AS company_average_salary
    FROM Salary
    GROUP BY pay_month
)
SELECT departmentSalary.pay_month, department_id, (
    CASE
        WHEN department_average_salary > company_average_salary THEN 'higher'
        WHEN department_average_salary < company_average_salary THEN 'lower'
        ELSE 'same'
    END
) AS comparison
FROM departmentSalary
JOIN
companySalary ON departmentSalary.pay_month = companySalary.pay_month; 