-- Using RANK
WITH CTE AS (SELECT player_id,event_date, RANK() OVER(PARTITION BY player_id ORDER BY event_date) as rnk 
FROM Activity)

SELECT player_id, event_date as first_login FROM CTE
WHERE rnk = 1

-- Using MIN
SELECT player_id,min(event_date) AS 'first_login' FROM Activity
GROUP BY player_id

-- Using MIN OVER()
SELECT DISTINCT player_id,MIN(event_date) OVER(PARTITION BY player_id) AS 'first_login' FROM Activity

-- Using FIRST_VALUE
SELECT DISTINCT a.player_id,
FIRST_VALUE(a.event_date) OVER(PARTITION BY a.player_id ORDER BY a.event_date) AS 'first_login' FROM Activity a

-- Using LAST_VALUE
SELECT DISTINCT a.player_id,
LAST_VALUE(a.event_date) OVER(PARTITION BY a.player_id ORDER BY a.event_date DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'first_login' FROM Activity a

