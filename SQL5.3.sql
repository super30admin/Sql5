# Write your MySQL query statement below

SELECT 
  DATE_FORMAT(s.pay_date, '%Y-%m') AS pay_month,
  e.department_id, 
  IF(SUM(s.amount) / COUNT(e.department_id) > g.tsum / g.cnt, 'higher', 
    IF(SUM(s.amount) / COUNT(e.department_id) = g.tsum / g.cnt, 'same', 'lower')) AS comparison
FROM 
  Salary s 
  INNER JOIN Employee e ON s.employee_id = e.employee_id
  INNER JOIN (
    SELECT 
      SUM(amount) AS tsum, 
      DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
      COUNT(amount) AS cnt 
    FROM Salary 
    GROUP BY pay_month
  ) AS g ON g.pay_month = DATE_FORMAT(s.pay_date, '%Y-%m')
GROUP BY e.department_id, pay_month
ORDER BY pay_month DESC, e.department_id;