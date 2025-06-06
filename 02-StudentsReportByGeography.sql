-- Sql5 Question 2 - Students Report By Geography (https://leetcode.com/problems/students-report-by-geography/)
-- Approach 1 : Using ROW_NUMBER() and JOIN
WITH first AS (
    SELECT name AS 'America', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk'
    FROM Student
    WHERE continent = 'America'
),
second AS (
    SELECT name AS 'Asia', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk'
    FROM Student
    WHERE continent = 'Asia'
),
third AS (
    SELECT name AS 'Europe', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk'
    FROM Student
    WHERE continent = 'Europe'
)
SELECT America, Asia, Europe
FROM second RIGHT JOIN first ON first.rnk = second.rnk
LEFT JOIN third ON first.rnk = third.rnk;

-- Approach 2 - Using session variables
SELECT America, Asia, Europe FROM (
    (SELECT @am := 1, @as := 1, @eu := 1)t1,
    (SELECT @as := @as + 1 AS 'asrnk', name AS 'Asia'
    FROM Student
    WHERE continent = 'Asia'
    ORDER BY Asia)t2
    RIGHT JOIN 
    (SELECT @am := @am + 1 AS 'amrnk', name AS 'America'
    FROM Student
    WHERE continent = 'America'
    ORDER BY America)t3 ON asrnk = amrnk
    LEFT JOIN
    (SELECT @eu := @eu + 1 AS 'eurnk', name AS 'Europe'
    FROM Student
    WHERE continent = 'Europe'
    ORDER BY Europe)t4 ON amrnk = eurnk 
);