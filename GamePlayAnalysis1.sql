# Approach 1:
SELECT player_id, MIN(event_date) AS first_login FROM Activity GROUP BY player_id;


# Approach 2: 
SELECT 
    player_id, 
    event_date AS first_login 
FROM (
    SELECT 
        player_id, 
        event_date, 
        RANK() OVER (PARTITION BY player_id ORDER BY event_date ASC) AS rnk 
    FROM Activity
) subquery
WHERE rnk = 1;


# Approach 3:
SELECT DISTINCT 
    player_id, 
    FIRST_VALUE(event_date) OVER (PARTITION BY player_id ORDER BY event_date ASC) AS first_login 
FROM Activity;


# Approach 4: 
SELECT DISTINCT 
    player_id, 
    LAST_VALUE(event_date) OVER (PARTITION BY player_id ORDER BY event_date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS first_login 
FROM Activity;
