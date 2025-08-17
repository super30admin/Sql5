# Write your MySQL query statement below
WITH CTE AS( 
    SELECT s.id,s.employee_id,s.amount,s.pay_date,e.department_id, AVG(s.amount) OVER(PARTITION BY s.pay_date) AS 'company_avg', AVG(s.amount) OVER(PARTITION BY s.pay_date, e.department_id) AS 'dept_avg'
    FROM salary s LEFT JOIN
    Employee e
    ON s.employee_id = e.employee_id
    ORDER BY s.id
)
-- SELECT * FROM CTE

SELECT DATE_FORMAT(pay_date, '%Y-%m')AS pay_month,department_id,
CASE

    WHEN dept_avg > company_avg THEN 'higher'
    WHEN dept_avg < company_avg THEN 'lower'
    ELSE 'same'
END    
 AS comparison
 FROM CTE
 GROUP BY department_id,pay_month
 ORDER BY department_id