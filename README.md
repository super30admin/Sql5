# Sql5

## 1 Problem 1 : Report Contiguos Dates		(https://leetcode.com/problems/report-contiguous-dates/ )
<br>

with cte as (select fail_date as 'date', 'failed' as 'period_state'
from Failed
Union
select success_date as 'date', 'succeeded' as 'period_state'
from Succeeded
),
cte2 as (
select *, row_number() over(partition by period_state order by date) as rnk
from cte)

select period_state,
min(date) as start_date,
max(date) as end_date
from cte2
where date between '2019-01-01' and '2019-12-31'
group by date_sub(date, interval rnk day), period_state
order by start_date

### 

## 2 Problem 2 : Student Report By Geography		(https://leetcode.com/problems/students-report-by-geography/ )
with cteAm as (select name, row_number() over (order by name) as 'rnk' from Student where continent='America' ),
cteAs as (select name, row_number() over (order by name) as 'rnk' from Student where continent='Asia'),
cteEu as (select name, row_number() over (order by name) as 'rnk' from Student where continent='Europe')

select cteAm.name as America, cteAs.name as Asia, cteEu.name as Europe
from cteAs right join cteAm on cteAs.rnk=cteAm.rnk left join cteEu on cteAm.rnk=cteEu.rnk

<br>
with cteAm as(select rnk, America from (select @am:=0)t, (select @am:=@am+1 as 'rnk', name as America 
from student where continent='America' order by name)t2),

cteAs as(select rnk, Asia from (select @as:=0)t, (select @as:=@as+1 as 'rnk', name as Asia 
from student where continent='Asia' order by name)t2),

cteEu as(select rnk, Europe from (select @eu:=0)t, (select @eu:=@eu+1 as 'rnk', name as Europe 
from student where continent='Europe' order by name)t2)

select America, Asia, Europe
from cteAs  right join cteAm on cteAs.rnk=cteAm.rnk
            left join  cteEu on cteAm.rnk=cteEu.rnk


## 3 Problem 3 : Average Salary Department vs Company		(https://leetcode.com/problems/average-salary-departments-vs-company/solution/ )
<br>

### Solution Using Case When Statements

#Date_format(pay_date. '%mm-Y')
#avg(amount)
#Group BY pay_month, department_id
#from Salary s left join Employee e
#on s.employee_id=e.employee_id

with cte1 as
(select  DATE_FORMAT(pay_date, '%Y-%m') as pay_month,
        department_id,
        avg(amount) as avg_deptsalary
FROM Salary s left join Employee e on s.employee_id=e.employee_id
GROUP BY pay_month, department_id
),

cte2 as
(select DATE_FORMAT(pay_date, '%Y-%m') as pay_month,
        avg(amount) as avg_compsal
from Salary
group by pay_month )

select  cte1.pay_month,
        cte1.department_id,
case    when cte1.avg_deptsalary>cte2.avg_compsal then 'higher'
        when cte1.avg_deptsalary<cte2.avg_compsal then 'lower'
        else 'same' end as comparison
from cte1 left join cte2 on cte1.pay_month=cte2.pay_month

## 4 Problem 4 : Game Play Analysis I		(https://leetcode.com/problems/game-play-analysis-i/ )
<br>
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

### Solution 1 Using Group BY and Min
SELECT DISTINCT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id
<br>
### Solution 2 Using First Value Function
SELECT Distinct player_id, FIRST_VALUE(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS first_login
FROM Activity
