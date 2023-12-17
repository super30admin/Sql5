# Write your MySQL query statement below

#APPROACH 1
SELECT 
    player_id, 
    MIN(event_date) AS first_login 
FROM 
    Activity
GROUP BY 
    player_id;

#APPRAOCH 2
# ROW_NUMBER can be replaced by RANK(), DENSE_RANK(), 
# WITH cte AS (
#     SELECT player_id, event_date, ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rnk
#     FROM Activity
# )

# SELECT player_id, event_date AS first_login FROM cte
# where rnk = 1;