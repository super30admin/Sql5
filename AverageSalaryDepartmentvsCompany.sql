WITH CTE1 as (
    SELECT date_format(pay_date, '%Y-%m') as 'pay_month', E.department_id, avg(S.amount) as DeptAVG
    FROM SALARY S
    LEFT JOIN Employee E
    on E.employee_id = S.employee_id
    group by pay_month, E.department_id
), 
CTE2 as (
    SELECT date_format(pay_date, '%Y-%m') as 'pay_month', avg(amount) as Company_avg
    FROM Salary S
    Group by Pay_month
),
CTE3 as (
    SELECT c1.pay_month, c1.department_id, C1.DeptAVG, C2.Company_avg
    FROM CTE1 as c1
    join CTE2 as C2
    on C1.pay_month = C2.pay_month
)


SELECT pay_month, department_id, (
    CASE
    when DeptAVG > Company_avg then "higher"
    when DeptAVG < Company_avg then "lower"
    ELSE "same"
    END
) as comparison
FROM CTE3