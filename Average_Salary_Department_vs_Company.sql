with CTE as (
select 
DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
e.department_id,
avg(s.amount) as department_salary
from Salary s left join Employee e
on s.employee_id = e.employee_id 
group by 1,2 order by 2
)

,
CTE2 as (
select * from CTE left join
(select 
DATE_FORMAT(pay_date, '%Y-%m') AS pay_monthh,
avg(amount) as 'company_salary'
from Salary
group by 1) T2
on CTE.pay_month = T2.pay_monthh
)

select pay_month,department_id,
case when department_salary > company_salary  then 'higher'
when department_salary < company_salary  then 'lower'
else 'same'
end as comparison
from CTE2