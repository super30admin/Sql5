WITH CTE as ( 
    SELECT
        DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
        department_id,
        AVG(amount) OVER PARTITION BY (pay_date) AS company_avg_amount,
        AVG(amount) OVER PARTITION BY (pay_date, department_id) AS department_avg_salary
    FROM
        Salary AS s
        JOIN Employee AS e ON s.employee_id = e.employee_id
)
SELECT DISTINCT
    pay_month,
    department_id,
    CASE
        WHEN department_avg_salary < company_avg_amount THEN 'lower'
        WHEN department_avg_salary = company_avg_amount THEN 'same'
        ELSE 'higher'
    END AS comparison
FROM
    CTE;
#-------------------Using SUbQuery-------------------
WITH department_avg_salary AS(
    SELECT DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
    department_id,
    AVG(amount) OVER PARTITION BY (pay_date) AS 
)