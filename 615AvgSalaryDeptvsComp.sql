# Write your MySQL query statement below
with cte as
( 
    select e.department_id, s.id, s.employee_id, LEFT(s.pay_date,7) as pay_month
    , avg(s.amount) over (partition by month(s.pay_date)) as company_avg_sal
    , avg(s.amount) over (partition by month(s.pay_date), e.department_id) as dept_sal
    from Salary s, Employee e
    where e.employee_id = s.employee_id
)
select pay_month, department_id
, (CASE WHEN dept_sal < company_avg_sal THEN 'lower' WHEN dept_sal > company_avg_sal THEN 'higher' ELSE 'same' END) as 'comparison'
from cte
group by department_id, pay_month
