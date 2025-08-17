-- SELECT
--     player_id, MIN(event_date) AS first_login
-- FROM 
--     Activity
-- GROUP BY player_id

#-------------Using Partition By------------------
SELECT 
    DISTINCT player_id,
    MIN(event_date) OVER(PARTITION BY player_id) AS 'first_login'
FROM
    Activity;