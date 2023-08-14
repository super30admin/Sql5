with cte as (
SELECT
  dept.pay_month,
  dept.department_id,
  dept.average_department,
  comp.average_company
FROM
  (SELECT
     DATE_FORMAT(s.pay_date, '%Y-%m') AS pay_month,
     e.department_id,
     AVG(s.amount) AS average_department
   FROM
     salary s
   JOIN
     employee e ON s.employee_id = e.employee_id
   GROUP BY
     1, 2) AS dept
JOIN
  (SELECT
     DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
     AVG(amount) AS average_company
   FROM
     salary
   GROUP BY
     1) AS comp ON dept.pay_month = comp.pay_month

)
select pay_month , department_id , CASE 
WHEN average_department >average_company  THEN 'higher'
WHEN average_department <average_company  THEN 'lower'
ELSE 'same'
END AS comparison
 from cte