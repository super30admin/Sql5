# Write your MySQL query statement below

select
player_id,
min(event_date) as first_login
from 
Activity
group by 1
order by player_id