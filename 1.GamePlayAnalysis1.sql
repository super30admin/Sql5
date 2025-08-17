# 1. Group By Clause
SELECT player_id,
       MIN(event_date) AS first_login
FROM
    Activity 
GROUP BY player_id
ORDER BY player_id;

# 2. Partition By clause

SELECT DISTINCT player_id, MIN(event_date) OVER (PARTITION BY player_id) AS first_login
FROM Activity;

# 3. Using Rank Function

WITH CTE AS (
    
    SELECT player_id, 
           event_date AS first_login,
           DENSE_RANK() OVER (PARTITION BY player_id ORDER BY event_date) AS 'rank_date'
    FROM Activity
    
)

SELECT player_id, first_login 
FROM CTE
WHERE rank_date = 1

# 4. First Value Function -- Window Function

SELECT DISTINCT player_id,
       FIRST_VALUE(event_date) OVER (PARTITION BY player_id ORDER BY event_date) AS first_login 
FROM Activity

# 5. Last Value Function -- Window Function

# Notes
# 5.1. First Value function goes and pick up the first value from the partition row.
# 5.2. Last Value function should also behave like First Value function and should pick up the last
# value from the the partition row but IT DOES-NOT. 

# We need to specify the range b/w unbounded preceding and following. Last Value function itself
# isnt capable to pick up the last value.


SELECT DISTINCT player_id,
       LAST_VALUE(event_date) OVER (PARTITION BY player_id 
                                    ORDER BY event_date DESC
                                    RANGE BETWEEN 
                                        UNBOUNDED PRECEDING  AND 
                                        UNBOUNDED FOLLOWING) AS first_login 
FROM Activity