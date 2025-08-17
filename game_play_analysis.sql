# Write your MySQL query statement below
SELECT player_id, MIN(event_date) AS 'first_login' 
FROM Activity
GROUP BY player_id;
#Using Partition By ORDER BY
SELECT DISTINCT player_id, MIN(event_date) 
OVER(PARTITION BY player_id ORDER BY event_date) AS 'first_login'
FROM Activity;
# Above query can be written without over 
SELECT DISTINCT player_id, 
MIN(event_date) OVER(PARTITION BY player_id) AS'first_login'
FROM Activity
# Using RANK(), ROW_NUMBER
SELECT player_id, event_date AS'first_login', 
    RANK() OVER(PARTITION BY player_id ORDER BY event_date) AS 'rank'
    FROM Activity;
#Using CTE
WITH CTE AS(
    SELECT player_id, event_date AS'first_login', 
    ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) AS 'rank'
    FROM Activity
) 
SELECT CTE.player_id, CTE.first_login FROM CTE WHERE CTE.rank = 1;

# Using FIRST_VALUE 
SELECT DISTINCT player_id, FIRST_VALUE(event_date) 
OVER (PARTITION BY player_id ORDER by event_date) AS 'first_login'
FROM Activity

#We also have LAST_VALUE()
SELECT DISTINCT player_id,
LAST_VALUE(event_date) 
OVER(PARTITION BY player_id ORDER BY event_date 
DESC RANGE BETWEEN UNBOUNDED PRECEDING  AND UNBOUNDED FOLLOWING) AS 'first_login'
FROM Activity

# GAME PLAY ANALYSIS II
-- WITH CTE AS(
--     SELECT player_id, device_id, event_date, 
--     RANK() OVER(PARTITION BY player_id ORDER BY event_date)AS 'rank'
--     FROM Activity
-- )SELECT c.player_id, c.device_id FROM CTE c WHERE c.rank = 1;
