-- Solution for Leetcode problem AverageSalaryDepartmentvsCompany
WITH dept AS (
    SELECT  DATE_FORMAT(s.pay_date, '%Y-%m') as pay_month,
            e.department_id,
            AVG(s.amount) AS d_avg
    FROM salary s
    JOIN employee e
    ON s.employee_id = e.employee_id
    GROUP BY 1,2
),
comp AS(
    SELECT  DATE_FORMAT(pay_date, '%Y-%m') as pay_month,
            AVG(amount) AS c_avg
    FROM salary
    GROUP BY 1
)
SELECT  d.pay_month,
        d.department_id,
        CASE
            WHEN d.d_avg > c.c_avg THEN 'higher'
            WHEN d.d_avg < c.c_avg THEN 'lower'
            WHEN d.d_avg = c.c_avg THEN 'same'
        END AS comparison
FROM dept d
JOIN comp c
ON d.pay_month = c.pay_month;