

SELECT d.pay_month, department_id, 
(CASE WHEN d.department_avg > c.company_avg THEN 'higher'
WHEN d.department_avg < c.company_avg THEN 'lower'
ELSE 'same'
END) AS comparison
FROM
(SELECT avg(amount) AS department_avg, department_id,
DATE_FORMAT(s.pay_date,'%Y-%m') AS pay_month
FROM Salary s
LEFT JOIN Employee e
ON s.employee_id = e.employee_id
GROUP BY e.department_id, pay_month) d
JOIN
(SELECT avg(amount) AS company_avg, DATE_FORMAT(pay_date,'%Y-%m') AS pay_month 
FROM Salary
GROUP BY pay_month) c
ON d.pay_month = c.pay_month




-- Using CTE 
WITH d_avg AS (
SELECT avg(amount) AS department_avg, department_id,
DATE_FORMAT(s.pay_date,'%Y-%m') AS pay_month
FROM Salary s
LEFT JOIN Employee e
ON s.employee_id = e.employee_id
GROUP BY e.department_id, pay_month
),
c_avg AS (
SELECT avg(amount) AS company_avg, DATE_FORMAT(pay_date,'%Y-%m') AS pay_month 
FROM Salary
GROUP BY pay_month)

SELECT d.pay_month, department_id, 
(CASE WHEN d.department_avg > c.company_avg THEN 'higher'
WHEN d.department_avg < c.company_avg THEN 'lower'
ELSE 'same'
END) AS comparison
FROM
(SELECT * FROM d_avg) d
JOIN
(SELECT * FROM c_avg) c
ON d.pay_month = c.pay_month


 
-- OR 
WITH d_avg AS (
SELECT avg(amount) AS department_avg, department_id,
DATE_FORMAT(s.pay_date,'%Y-%m') AS pay_month
FROM Salary s
LEFT JOIN Employee e
ON s.employee_id = e.employee_id
GROUP BY e.department_id, pay_month
),
c_avg AS (
SELECT avg(amount) AS company_avg, DATE_FORMAT(pay_date,'%Y-%m') AS pay_month 
FROM Salary
GROUP BY pay_month)

SELECT a.pay_month, a.department_id, 
(CASE WHEN a.department_avg > a.company_avg THEN 'higher'
WHEN a.department_avg < a.company_avg THEN 'lower'
ELSE 'same'
END) AS comparison
FROM
(SELECT d.pay_month,d.department_id,d.department_avg,c.company_avg FROM d_avg d
JOIN c_avg c
ON d.pay_month = c.pay_month) a

