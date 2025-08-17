# Approach 1:

Select departmentSalary.pay_month, department_id, (
Case 
When department_avg>company_avg then “higher”
When department_avg<company_avg then “lower”
else 
“same”
End) as Comparison from (Select date_format(pay_date, ‘%y-%m’) as pay_month, department_id, avg(amount) as department_avg from Salary join Employee on salary.employee_id=employee.employee_id group by department_id,pay_month) as departmentSalary  join 
(Select date_format(Pay_date, ‘%y-%m’) as pay_month, avg(amount) as company_avg from salary group by pay_month) as companySalary on departmentSalary.pay_month=companySalary.pay_month;


# Approach 2: 

With departmentSalary as(
 Select date_format(pay_date, ‘%y-%m’) as pay_month, department_id, avg(amount) as department_avg from Salary join Employee on salary.employee_id=employee.employee_id group by department_id,pay_month) , 
companySalary as(
Select date_format(Pay_date, ‘%y-%m’) as pay_month, avg(amount) as company_avg from salary group by pay_month)

Select departmentSalary.pay_month, department_id, (
Case 
When department_avg>company_avg then “higher”
When department_avg<company_avg then “lower”
else 
“same”
End) as Comparison from departmentSalary join companySalary on departmentSalary.pay_month=companySalary.pay_month;

