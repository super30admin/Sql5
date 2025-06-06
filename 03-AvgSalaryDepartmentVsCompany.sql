-- 3 Problem 3 : Average Salary Department vs Company (https://leetcode.com/problems/average-salary-departments-vs-company/solution/ )

with companyavg as (
  select 
    date_format(pay_date, '%y-%m') as pay_month, 
    avg(amount) as companyavg 
  from salary 
  group by pay_month
),
deptavg as (
  select 
    date_format(pay_date, '%y-%m') as pay_month, 
    department_id, 
    avg(amount) as departmentavg 
  from salary 
  join employee on salary.employee_id = employee.employee_id 
  group by department_id, pay_month
)
select 
  deptavg.pay_month, 
  department_id, 
  case
    when departmentavg > companyavg then 'higher'
    when departmentavg < companyavg then 'lower'
    else 'same'
  end as comparison
from companyavg
join deptavg on deptavg.pay_month = companyavg.pay_month
