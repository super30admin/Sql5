--Student Report By Geography

--Using window funciton
WITH first AS ( 
    SELECT name AS 'America', row_number() OVER (ORDER BY name) AS 'rnk'
    FROM Student
    WHERE continent = 'America'
), 
second AS (
    SELECT name AS 'Asia', row_number() OVER (ORDER BY name) AS 'rnk'
    FROM Student
    WHERE continent = 'Asia'
), 
third AS (
    SELECT name AS 'Europe', row_number() OVER (ORDER BY name) AS 'rnk'
    FROM Student
    WHERE continent = 'Europe'
)
SELECT America, Asia, Europe
FROM first
LEFT JOIN second
ON first.rnk = second.rnk
LEFT JOIN third
ON second.rnk = third.rnk;

--Using session variables
SELECT America, Asia, Europe
FROM (
(
    SELECT @am :=0, @as :=0, @eu :=0
) t1,
(
    SELECT @as := @as +1 AS 'asrnk', name AS 'Asia'
    FROM Student
    WHERE continent = 'Asia'
    ORDER BY name
) t2 RIGHT JOIN
(
    SELECT @am := @am +1 AS 'amrnk', name AS 'America'
    FROM Student
    WHERE continent = 'America'
    ORDER BY name
) t3 ON asrnk = amrnk LEFT JOIN
(
    SELECT @am := @am +1 AS 'eurnk', name AS 'Europe'
    FROM Student
    WHERE continent = 'Europe'
    ORDER BY name
) t4 ON amrnk = eurnk
);