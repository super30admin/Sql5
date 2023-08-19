/*
1. Partition by department_id and month(pay_date) to get the average of department salary for each month. Partition by month(pay_date) to get the average of all department salaries for that month.
2. Compare the averages and return higher, lower or same
3. Use distinct to get unique pay_month and department_id combinations
*/
select distinct date_format(a.pay_date,"%Y-%m") pay_month, b.department_id, 
case when avg(amount) over(partition by department_id,month(pay_date)) > avg(amount) over(partition by month(pay_date)) then 'higher'
 when avg(amount) over(partition by department_id,month(pay_date)) < avg(amount) over(partition by month(pay_date)) then 'lower'
else 'same'
end comparison
from Salary a left join Employee b
on a.employee_id = b.employee_id