# Write your MySQL query statement below

with company_cte as (
    
    select 
        date_format(pay_date, '%Y-%m') as pay_month,
        avg(amount) as company_avg
    from 
        salary
    group by pay_month
    order by pay_month asc
),

# select * from company_cte

dept_cte as (
    
    select 
        date_format(sal.pay_date, '%Y-%m') as pay_month,
        emp.department_id as department_id,
        avg(sal.amount) as dept_avg
    from 
        Salary sal inner join Employee emp
    on 
        sal.employee_id = emp.employee_id
    group by department_id, pay_month
    order by pay_month asc
)

# select * from dept_cte

select 
    company_cte.pay_month as pay_month,
    dept_cte.department_id as department_id,
    (
        
        case 
            when dept_cte.dept_avg > company_cte.company_avg then 'higher'
            when dept_cte.dept_avg < company_cte.company_avg then 'lower'
            else 'same'
        end
        
    ) as comparison
from 
    company_cte inner join dept_cte
on 
    company_cte.pay_month = dept_cte.pay_month
order by department_id asc