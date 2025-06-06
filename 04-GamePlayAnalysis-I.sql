-- Problem 4 : Game Play Analysis I	(https://leetcode.com/problems/game-play-analysis-i/ )

select player_id, min(event_date) as 'first_login' from activity group by player_id 
-- since this is group by it will return agg value as in one min 

select distinct player_id, min(event_date) over (partition by player_id) as 'first_login' from activity
-- for partition by one needs distinct because partition by returns all the rows, it will return 2 rows of player id 1 with same min date

select distinct player_id, first_value(event_date) over (partition by player_id order by event_date) 
as 'first_login' from activity
-- since we are using first_value, order by event date is important to pick 1st row

select a.player_id, a.event_date as 'first_login' from (
    select b.player_id, b.event_date, 
    rank() over (partition by b.player_id order by b.event_date) as 'rnk' from activity b
) a where a.rnk = 1
