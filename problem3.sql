--Problem 3

with cte1 as (
select substring(pay_date,1,7) as pay_month , avg(amount)as company_avg from salary group by pay_month 
),
cte2 as 
(
select substring(pay_date,1,7) as pay_month, department_id , avg(amount) as dept_avg 
    from salary join employee on salary.employee_id = employee.employee_id group by department_id , pay_month
)
Select cte1.pay_month as pay_month  , department_id,
case when dept_avg < company_avg then 'lower' 
     when company_avg < dept_avg then 'higher' 
     when company_avg = dept_avg then 'same' end as comparison
from cte1 join cte2 on cte1.pay_month = cte2.pay_month