SELECT DISTINCT player_id, FIRST_VALUE(event_date) OVER (PARTITION BY player_id ORDER BY event_date) AS 'first_login' FROM ACTIVITY 

