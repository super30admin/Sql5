# Write your MySQL query statement below

select 
d.name as 'Department',
e1.name as 'Employee',
e1.salary as 'Salary'
from
Employee e1 inner join Department d on e1.departmentId = d.id
where
3 > (select count(distinct e2.salary) from employee e2 where e2.salary > e1.salary and e1.departmentId = e2.departmentId)









# With CTE as
# (
# select 
# d.name as 'Department',
# e.name as 'Employee',
# e.salary as 'Salary',
# dense_rank() over (PARTITION by d.name order by e.salary desc) as 'rankkk'
# from
# Employee e inner join Department d on e.departmentId = d.id
# )

# select Department,Employee,Salary from CTE
# where rankkk in (1,2,3)