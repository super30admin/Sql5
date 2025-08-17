WITH CTE AS (SELECT player_id,event_date,  MIN(event_date) OVER (PARTITION BY player_id) AS 'first_login' from
Activity)

SELECT DISTINCT player_id, first_login FROM CTE