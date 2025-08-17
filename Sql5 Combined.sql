-- Sql5

-- 1 Problem 1 : Report Contiguos Dates		(https://leetcode.com/problems/report-contiguous-dates/ )

with CTE as(
    select fail_date as 'dat', 'failed' as 'period_state'
    , rank() over (order by fail_date) as 'rnk'
    from Failed
    where year(fail_date) = 2019

    UNION ALL

    select success_date as 'dat', 'succeeded' as 'period_state'
    , rank() over (order by success_date) as 'rnk'
    from Succeeded
    where year(success_date) = 2019
)

select period_state, min(dat) as 'start_date', max(dat) as 'end_date'
from (
    select *,(rank() over (order by dat)-rnk) as 'group_rank'
    from CTE
) as y
group by group_rank, period_state
order by start_date;
;

-- 2 Problem 2 : Student Report By Geography		(https://leetcode.com/problems/students-report-by-geography/ )

with first as(
select name as 'America',row_number() over (order by name) as rnk from Student where continent = 'America'
),
    
second as(    
select name as 'Asia', row_number() over (order by name) as rnk from Student where continent = 'Asia'
),
    
third as(    
select name as 'Europe', row_number() over (order by name) as rnk from Student where continent = 'Europe'
) 


select America, Asia, Europe
from first
left join second
on first.rnk = second.rnk
left join third
on second.rnk = third.rnk
;

-- 3 Problem 3 : Average Salary Department vs Company		(https://leetcode.com/problems/average-salary-departments-vs-company/solution/ )

with CompanySalary as(
select date_format(pay_date,'%Y-%m') as 'pay_month', avg(amount) as 'CompanyAvg' 
from Salary
group by pay_month
),

DeptSalary as(
select date_format(Salary.pay_date,'%Y-%m') as 'pay_month', Employee.department_id, avg(amount) as 'DeptAvg'
from Salary
join Employee
on Salary.employee_id = Employee.employee_id
group by pay_month, department_id
)

select DeptSalary.pay_month, department_id,(
    Case
        when DeptAvg > CompanyAvg then 'higher'
        when DeptAvg < CompanyAvg then 'lower'
        else 'same'
    End
) as 'comparison'
from DeptSalary
left join CompanySalary
on DeptSalary.pay_month = CompanySalary.pay_month
order by department_id, DeptSalary.pay_month;


-- 4 Problem 4 : Game Play Analysis I		(https://leetcode.com/problems/game-play-analysis-i/ )

select distinct player_id, min(event_date) over (partition by player_id) first_login
from activity