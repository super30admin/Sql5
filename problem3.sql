WITH stats AS (
  SELECT
    DATE_FORMAT(s.pay_date, '%Y-%m') AS pay_month,
    e.department_id,
    AVG(s.amount) OVER (PARTITION BY DATE_FORMAT(s.pay_date, '%Y-%m')) AS company_avg,
    AVG(s.amount) OVER (PARTITION BY DATE_FORMAT(s.pay_date, '%Y-%m'), e.department_id) AS dept_avg
  FROM Salary s
  JOIN Employee e ON s.employee_id = e.employee_id
)
SELECT
  pay_month,
  department_id,
  CASE
    WHEN dept_avg > company_avg THEN 'higher'
    WHEN dept_avg < company_avg THEN 'lower'
    ELSE 'same'
  END AS comparison
FROM stats
GROUP BY pay_month, department_id, dept_avg, company_avg
ORDER BY pay_month, department_id;
