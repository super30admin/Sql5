WITH CTE AS(SELECT player_id, event_date as 'first_login', RANK() OVER (PARTITION BY player_id order by event_date) as 'rnk' from activity)
Select player_id, first_login from CTE where rnk = 1