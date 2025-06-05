with company_avg as 
(
    select 
        date_format(pay_date, '%Y-%m') as date_year
        , avg(amount) as company_avg
    from 
        Salary
    group by 1
)
, dept_avg_sal as
(
    select 
        date_format(s.pay_date, '%Y-%m') as date_year
        , e.department_id
        , avg(s.amount) as dept_avg
    from 
         Salary s join Employee e on s.employee_id = e.employee_id
    group by e.department_id, 1
)

select 
    d.date_year as pay_month
    , d.department_id
    , case when c.company_avg > d.dept_avg then 'lower'
        when c.company_avg = d.dept_avg then 'same'
        when c.company_avg < d.dept_avg then 'higher' end as comparison
from company_avg c join dept_avg_sal d on c.date_year = d.date_year
