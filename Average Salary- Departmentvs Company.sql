With CompanyAverage as
(
    select s.pay_date, avg(s.amount) as c_average from Salary s
    join Employee e on s.employee_id = e.employee_id
    group by s.pay_date
),
DepartmentAverage as(
    select s.pay_date as pay_date, e.department_id as department_id, avg(s.amount) as d_average from salary s
    join employee e on e.employee_id = s.employee_id
    group by s.pay_date, e.department_id
)
select Date_Format(da.pay_date, '%Y-%m') as pay_month, da.department_id,
( Case  when ca.c_average > da.d_average Then 'lower'
        when ca.c_average < da.d_average Then 'higher'
        else 'same'
    End ) as comparison
    from CompanyAverage ca join DepartmentAverage da
    on ca.pay_date = da.pay_date
    group by pay_month, department_id;
