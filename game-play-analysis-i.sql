"""
  
Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
Write a solution to find the first login date for each player.

Return the result table in any order.

The result format is in the following example.

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
  
"""

-- method 1: using MIN function
select 
    distinct player_id, 
    min(event_date) over(partition by player_id order by event_date) as first_login
from 
    Activity 

  
-- method 2: using cte and RANK 
with cte as(
select 
    player_id, 
    event_date as first_login, 
    rank() over(partition by player_id order by event_date) as rnk
from 
    Activity 
)

select player_id, first_login from cte where rnk = 1

  
-- method 3: using first_value
with cte as(
select 
    distinct player_id, 
    first_value(event_date) over(partition by player_id order by event_date) as first_login
from 
    Activity 
)

select * from cte;


-- method 4: using last_value
select 
    distinct player_id, 
    last_value(event_date) over(partition by player_id order by event_date desc range between unbounded preceding and unbounded following ) as 'first_login'
from 
    Activity
