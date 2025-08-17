"""
  
Table: Failed
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| fail_date    | date    |
+--------------+---------+
fail_date is the primary key (column with unique values) for this table.
This table contains the days of failed tasks.
 
Table: Succeeded
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| success_date | date    |
+--------------+---------+
success_date is the primary key (column with unique values) for this table.
This table contains the days of succeeded tasks.
 
A system is running one task every day. Every task is independent of the previous tasks. The tasks can fail or succeed.

Write a solution to report the period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.

period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded. 
Interval of days are retrieved as start_date and end_date.

Return the result table ordered by start_date.

The result format is in the following example.

Input: 
Failed table:
+-------------------+
| fail_date         |
+-------------------+
| 2018-12-28        |
| 2018-12-29        |
| 2019-01-04        |
| 2019-01-05        |
+-------------------+
Succeeded table:
+-------------------+
| success_date      |
+-------------------+
| 2018-12-30        |
| 2018-12-31        |
| 2019-01-01        |
| 2019-01-02        |
| 2019-01-03        |
| 2019-01-06        |
+-------------------+
Output: 
+--------------+--------------+--------------+
| period_state | start_date   | end_date     |
+--------------+--------------+--------------+
| succeeded    | 2019-01-01   | 2019-01-03   |
| failed       | 2019-01-04   | 2019-01-05   |
| succeeded    | 2019-01-06   | 2019-01-06   |
+--------------+--------------+--------------+
  
"""

with cte as
(
    select 
        fail_date as 'dat', "failed"  as period_state, 
        rank() over(order by fail_date) as rnk 
    from 
        Failed 
    where 
        year(fail_date) = "2019"
    union all
    select 
        success_date as 'dat',
        "succeeded" as period_state,
        rank() over(order by success_date) as rnk
    from 
        Succeeded 
    where 
        year(success_date) = "2019"
)

select 
    period_state, 
    min(dat) as start_date, 
    max(dat) as end_date
from 
(
    select 
        *, 
        (rank() over(order by dat) - rnk) as diff
    from 
        cte
) as y 
group by 
    diff, period_state 
order by 
    start_date
