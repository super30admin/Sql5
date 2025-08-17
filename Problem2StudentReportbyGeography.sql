# Write your MySQL query statement below
WITH RankedStudents AS (
    SELECT name, continent, ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS 'rnk' FROM student
)

SELECT MAX(CASE WHEN continent = 'America' THEN name END) AS America,
    MAX(CASE WHEN continent = 'Asia' THEN name END) AS Asia,
    MAX(CASE WHEN continent = 'Europe' THEN name END) AS Europe
       FROM RankedStudents
       GROUP BY rnk
       ORDER BY rnk