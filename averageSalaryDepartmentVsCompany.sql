with cte as (
    select avg(amount) over(partition by date_format(pay_date, '%Y-%m')) 
    as comp_sal, 
    date_format(pay_date, '%Y-%m') as pay_month from salary),
acte as(
    select avg(amount) as emp_sal, date_format(pay_date, '%Y-%m') 
    as pay_month, 
    e.department_id from salary s join employee e 
    on e.employee_id = s.employee_id group by pay_month, e.department_id 
)

select distinct acte.pay_month, acte.department_id, (
    case 
    when comp_sal < emp_sal then 'higher'
    when comp_sal > emp_sal then 'lower'
    else 'same'
    end 
) as 'comparison' from cte join acte on cte.pay_month = acte.pay_month