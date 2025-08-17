# Write your MySQL query statement below
WITH CTE AS (
SELECT name as America, ROW_NUMBER() OVER(ORDER BY name) AS 'rank' FROM Student WHERE continent = 'America'),
CTE2 AS (
SELECT name as Asia , ROW_NUMBER() OVER(ORDER BY name) AS 'rank' FROM Student WHERE continent = 'Asia'),
CTE3 AS (
SELECT name as Europe, ROW_NUMBER() OVER(ORDER BY name) AS 'rank' FROM Student WHERE continent = 'Europe')

SELECT America, Asia, Europe FROM
CTE LEFT JOIN CTE2 ON CTE.rank = CTE2.rank
LEFT JOIN CTE3 ON CTE.rank = CTE3.rank;