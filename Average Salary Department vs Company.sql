# create a cte of (
# inner join Salary table with employee table 
# on basis of employee id )

# calcualte the compnay's average salary based
# on number of depts and total salary in each dept 
# --> create another cte table that calculates the above
# and produces columns like department_id | total_salary_dept

# create a new cte --> dept | avg salary of each dept
# group by dept and calc the avg by using the total amount and number of employees 

WITH cte1 AS (
    SELECT s.id, s.employee_id, s.amount, s.pay_date, e.department_id
    FROM Salary AS s
    INNER JOIN Employee AS e ON s.employee_id = e.employee_id
),
cte2 AS (
    SELECT DATE_FORMAT(pay_date, '%Y-%m') AS pay_month, AVG(amount) AS average_comp_salary
    FROM cte1
    GROUP BY pay_month
),
cte3 AS (
    SELECT DATE_FORMAT(pay_date, '%Y-%m') AS pay_month, department_id, AVG(amount) AS average_dept_salary
    FROM cte1
    GROUP BY pay_month, department_id
),
cte4 AS (
    SELECT cte2.pay_month, cte3.department_id, cte3.average_dept_salary, cte2.average_comp_salary
    FROM cte2
    INNER JOIN cte3 ON cte2.pay_month = cte3.pay_month
)

SELECT cte4.pay_month, cte4.department_id,
    (CASE
        WHEN average_dept_salary > average_comp_salary THEN 'higher'
        WHEN average_dept_salary < average_comp_salary THEN 'lower'
        ELSE 'same'
    END) AS comparison
FROM cte4;
