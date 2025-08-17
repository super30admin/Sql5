# Write your MySQL query statement below
WITH CTE AS (
    SELECT AVG(amount) AS 'average', date_format(pay_date, '%Y-%m') AS 'pay_month'
    FROM Salary GROUP BY pay_month
)

SELECT date_format(pay_date, '%Y-%m') AS 'pay_month', E.department_id AS department_id , (
    CASE 
        WHEN AVG(S.amount) = (SELECT average FROM CTE WHERE CTE.pay_month = date_format(pay_date, '%Y-%m') ) THEN 'same'
        WHEN AVG(S.amount) < (SELECT average FROM CTE WHERE CTE.pay_month = date_format(pay_date, '%Y-%m')) THEN 'lower'
        ELSE 'higher'
    END
) AS 'comparison', AVG(S.amount) AS amount
FROM Salary S JOIN Employee E ON S.employee_id = E.employee_id
GROUP BY pay_month, department_id;