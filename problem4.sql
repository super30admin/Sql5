# Write your MySQL query statement below
-- select player_id,event_date as first_login
-- from (
--     select player_id,event_date,
--     rank() over (partition by player_id order by event_date) as second_login 
--     from Activity ) t
-- where second_login=1;

-- select distinct(player_id), min(event_date) over(partition by player_id) as 'first_login'
-- from activity;

-- select player_id,min(event_date) as 'first_login'
-- from activity
-- group by player_id;

select distinct(player_id), first_value(event_date) over(partition by player_id order by event_date) as 'first_login'
from activity;

