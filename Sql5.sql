# 1 Problem 1 : Report Contiguos Dates (https://leetcode.com/problems/report-contiguous-dates/ )

# Solution
with cte1 as
(
    select fail_date as tasked_date, 'failed' as period_state,
        rank() over(order by fail_date) as ranks
    from Failed
    where fail_date between '2019-01-01' and '2019-12-31'
union
    select success_date as tasked_date, 'succeeded' as period_state,
        rank() over(order by success_date) as ranks
    from Succeeded
    where success_date between '2019-01-01' and '2019-12-31'
), cte2 as
(
    select *, rank() over(order by tasked_date) as grp_rank, rank() over(order by tasked_date) - ranks as diff
    from cte1
)
select period_state, min(tasked_date ) as start_date, max(tasked_date) as end_date
from cte2
group by diff, period_state

# 2 Problem 2 : Student Report By Geography (https://leetcode.com/problems/students-report-by-geography/ )

# Solution
with cte as
(
    select 
        case when continent = 'America' then name else null end as 'America',
        case when continent = 'Asia' then name else null end as 'Asia',
        case when continent = 'Europe' then name else null end as 'Europe',
        row_number() over(partition by continent order by name) as row_num
    from Student
)
select min(America) as America, min(Asia) as Asia, min(Europe) as Europe
from cte
group by row_num

# 3 Problem 3 : Average Salary Department vs Company (https://leetcode.com/problems/average-salary-departments-vs-company/solution/ )

# Solution1
with cte1 as
(
    select date_format(s.pay_date, '%Y-%m') as pay_month, e.department_id, avg(s.amount) as avg_dept_salary
    from Salary s
    join Employee e
    on s.employee_id = e.employee_id
    group by pay_month, e.department_id
), 
cte2 as
(
    select date_format(pay_date, '%Y-%m') as pay_month, avg(amount) as avg_company_salary
    from Salary
    group by date_format(pay_date, '%Y-%m')
)
select c1.pay_month, c1.department_id,
    case 
        when c1.avg_dept_salary < c2.avg_company_salary then 'lower'
        when c1.avg_dept_salary = c2.avg_company_salary then 'same'
        else 'higher'
    end as comparison
from cte1 c1
join cte2 c2
on c1.pay_month = c2.pay_month

# Solution2
with cte as
(
    select date_format(s.pay_date, '%Y-%m') as pay_month, e.department_id, 
    avg(s.amount) over(partition by date_format(s.pay_date, '%Y-%m')) as avg_company_salary,
    avg(s.amount) over(partition by e.department_id, date_format(s.pay_date, '%Y-%m')) as avg_dept_salary
    from Salary s
    join Employee e
    on s.employee_id = e.employee_id
)
select pay_month, department_id,
    case 
        when avg_dept_salary < avg_company_salary then 'lower'
        when avg_dept_salary = avg_company_salary then 'same'
        else 'higher'
    end as comparison
from cte
group by department_id, pay_month 
order by pay_month desc

# 4 Problem 4 : Game Play Analysis I (https://leetcode.com/problems/game-play-analysis-i/ )

# Solution 1
select player_id, min(event_date) as first_login
from Activity
group by player_id

# Solution2
select distinct player_id, min(event_date) over(partition by player_id) as first_login
from Activity

# Solution3 (Row_number() and Rank() can be used as well instead of Dense_rank())
with cte as
(
    select player_id, event_date as first_login, 
    dense_rank() over(partition by player_id order by event_date) as ranks
    from Activity 
)
select player_id, first_login
from cte
where ranks = 1

# Solution4 (Row_number() and Rank() can be used as well instead of Dense_rank())
select a.player_id, a.event_date as first_login 
from (select b.player_id, b.event_date, 
    dense_rank() over(partition by b.player_id order by b.event_date) as ranks
    from Activity b) as a
where a.ranks = 1

# Solution5
select distinct(player_id), first_value(event_date) over(partition by player_id order by event_date) as first_login
from Activity

# Solution6
select distinct(player_id), 
last_value(event_date) over(partition by player_id order by event_date desc range between unbounded preceding and unbounded following) as first_login
from Activity

# Solution7
select distinct(player_id), 
last_value(event_date) over(partition by player_id order by event_date desc rows between unbounded preceding and unbounded following) as first_login
from Activity