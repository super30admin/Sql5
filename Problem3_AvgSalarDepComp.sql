# Write your MySQL query statement below
with compavgcte as (
select concat(year(pay_date),'-',lpad(month(pay_date),2,'0')) as pay_month,
avg(amount) as compavg
from salary
group by 1),
depavgcte as (select e.department_id,
concat(year(pay_date),'-',lpad(month(pay_date),2,'0')) as pay_month,
avg(amount) as depavg
from employee e 
inner join salary s on e.employee_id=s.employee_id
group by 1,2)

select d.pay_month,
d.department_id,
case when d.depavg > c.compavg then 'higher'
     when d.depavg = c.compavg then 'same'
     else 'lower' end as comparison
from depavgcte d inner join compavgcte c on d.pay_month=c.pay_month