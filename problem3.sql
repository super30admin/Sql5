with temp as (
            select s.pay_date, e.department_id,
                   avg(s.amount) over(partition by s.pay_date order by s.pay_date) avg_company_salary,
                   avg(s.amount) over(partition by e.department_id, s.pay_date order by s.pay_date) avg_dept_salary
            from salary s
            inner join employee e
            on s.employee_id = e.employee_id
            )
select date_format(pay_date,"%Y-%m") as pay_month,
       department_id, 
       case when avg_dept_salary > avg_company_salary then 'higher'
            when avg_dept_salary < avg_company_salary then 'lower'
            else 'same' end as comparison
from temp
group by pay_month,
       department_id
order by pay_date desc;
