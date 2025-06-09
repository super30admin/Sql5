WITH companyAvg AS(
    SELECT date_format(pay_date, '%Y-%m') AS 'pay_month', AVG(amount) AS 'company_avg' FROM salary GROUP BY pay_month
),
deptAvg AS(
    SELECT date_format(pay_date, '%Y-%m') AS 'pay_month', department_id, AVG(amount) AS 'department_avg' FROM Salary JOIN Employee ON Salary.employee_id = employee.employee_id GROUP BY department_id, pay_month
)
SELECT deptAvg.pay_month, department_id, (
    CASE
        WHEN department_avg > company_avg THEN 'higher'
        WHEN department_avg < company_avg THEN 'lower'
        ELSE 'same'
    END
) AS 'comparison' FROM companyAvg JOIN deptAvg ON companyAvg.pay_month = deptAvg.pay_month