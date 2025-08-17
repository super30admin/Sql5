SELECT DISTINCT player_id, MIN(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS 'first_login' 
FROM activity;
