# Write your MySQL query statement below
WITH CTE AS (
SELECT player_id,event_date, DENSE_RANK() OVER(PARTITION BY  player_id ORDER BY event_date ) as 'rnk' FROM Activity
)

SELECT player_id, event_date as first_login FROM CTE 
WHERE rnk =1;