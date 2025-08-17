select comp.pay_month, dep.department_id,(
case
    when depsalary > compsalary then 'higher'
    when depsalary < compsalary then 'lower'
    else 'same' 
end
) as comparison from 
(select date_format(pay_date,'%Y-%m') as 'pay_month' ,employee_id, avg(amount)as 'compsalary' 
 from salary group by pay_month) as comp
  join 
  (select date_format(pay_date,'%Y-%m') as 'pay_month', e.department_id, avg(amount) as 'depsalary' 
  from salary s join employee e on s.employee_id=e.employee_id group by e.department_id , pay_month) as dep
  on  dep.pay_month = comp.pay_month;