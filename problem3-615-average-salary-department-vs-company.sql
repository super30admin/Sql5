-- window function

with cte as (
    select
        e.department_id,
        date_format(pay_date, '%Y-%m') as pay_month,
        case
            when
                avg(amount) over (partition by date_format(pay_date, '%Y-%m'))
                > avg(amount) over (partition by e.department_id, date_format(pay_date, '%Y-%m'))
                then 'lower'
            when
                avg(amount) over (partition by date_format(pay_date, '%Y-%m'))
                < avg(amount) over (partition by e.department_id, date_format(pay_date, '%Y-%m'))
                then 'higher'
            else
                'same'
        end as 'comparison'
    from salary as s
    inner join
        employee as e
        on s.employee_id = e.employee_id
)

select
    pay_month,
    department_id,
    comparison
from cte
group by pay_month, department_id, comparison
order by pay_month, department_id



--- with aggregation way

with cte_monthly_avg as (
    select
        date_format(pay_date, '%Y-%m') as pay_month,
        avg(amount) as avg_amount
    from
        salary
    group by date_format(pay_date, '%Y-%m')

),

cte_depart_monthly_avg as (
    select
        e.department_id,
        date_format(pay_date, '%Y-%m') as pay_month,
        avg(amount) as dpt_avg_salary
    from salary as s
    inner join
        employee as e
        on s.employee_id = e.employee_id
    group by date_format(pay_date, '%Y-%m'), e.department_id

)

select
    cdma.pay_month,
    cdma.department_id,
    case
        when cdma.dpt_avg_salary > cma.avg_amount then 'higher'
        when cdma.dpt_avg_salary < cma.avg_amount then 'lower'
        else 'same'
    end as comparison
from cte_depart_monthly_avg as cdma
inner join cte_monthly_avg as cma
    on cdma.pay_month = cma.pay_month