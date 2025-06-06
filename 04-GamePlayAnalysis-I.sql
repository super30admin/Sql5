-- Sql5 Question 4 - Game Play Analysis I (https://leetcode.com/problems/game-play-analysis-i/ )
-- Approach 1 : Using MIN and GROUP BY
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;
-- Approach 2 : Using RANK
SELECT a.player_id, a.event_date AS 'first_login' FROM (SELECT b.player_id, b.event_date, RANK() OVER(PARTITION BY b.player_id ORDER BY b.event_date) AS 'rnk' FROM Activity b) AS a WHERE a.rnk = 1;