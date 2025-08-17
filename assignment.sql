Problem 4 : Game Play Analysis I

# Write your MySQL query statement below
select player_id, first_login from (select player_id, event_date as first_login, 
rank() over(partition by player_id order by event_date) as rnk from Activity) as tble
where rnk = 1 
group by player_id

Problem 3 : Average Salary Department vs Company

select distinct left(pay_date, 7) as pay_month, department_id, case
                        when dept_avg > month_avg then 'higher'
                        when dept_avg = month_avg then 'same'
                        when dept_avg < month_avg then 'lower'
                        end as comparison
from (select s.pay_date, e.department_id, avg(s.amount) over(partition by s.pay_date) 
      as month_avg, avg(s.amount) over (partition by s.pay_date, e.department_id)
      as dept_avg from Salary s inner join Employee e on s.employee_id = e.employee_id)
as cte

Problem 2 : Student Report By Geography

with cte1 as (select name as America, row_number() over(order by name) as rnk from student
    where continent = 'America')
, cte2 as (select name as Asia, row_number() over(order by name) as rnk from student
    where continent = 'Asia')
, cte3 as (select name as Europe, row_number() over(order by name)as rnk from student
    where continent = 'Europe')

select America, Asia, Europe from cte1 a left join cte2 b on a.rnk = b.rnk left join
cte3 c on a.rnk = c.rnk

Problem 1 : Report Contiguos Dates

with cte as (
    select fail_date as date, 'failed' as period_state, rank() over(order by fail_date) as rnk
    from failed where year(fail_date) = '2019'
    union 
    select success_date as date, 'succeeded' as period_state, rank() 
    over(order by success_date) as rnk
    from Succeeded where year(success_date) = 2019
)

select period_state, min(date) as start_date, max(date) as end_date 
from (select *, (rank() over(order by date) - rnk) as diff from cte)
as temp
group by period_state, diff
order by start_date
