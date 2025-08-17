# Write your MySQL query statement below
SELECT r.player_id, r.event_date As first_login 
FROM(
    SELECT player_id, event_date, 
        DENSE_RANK() OVER(PARTITION BY player_id ORDER BY event_date ASC)
         AS rnk 
FROM Activity)r WHERE r.rnk = 1; 