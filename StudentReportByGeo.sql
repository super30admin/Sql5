# Approach 1: 
WITH first AS (
    SELECT name AS America, 
           ROW_NUMBER() OVER (ORDER BY name) AS rnk 
    FROM student 
    WHERE continent = 'America'
),
second AS (
    SELECT name AS Asia, 
           ROW_NUMBER() OVER (ORDER BY name) AS rnk 
    FROM student 
    WHERE continent = 'Asia'
),
third AS (
    SELECT name AS Europe, 
           ROW_NUMBER() OVER (ORDER BY name) AS rnk 
    FROM student 
    WHERE continent = 'Europe'
)

SELECT America, 
       Asia, 
       Europe 
FROM second 
RIGHT JOIN first ON first.rnk = second.rnk 
LEFT JOIN third ON first.rnk = third.rnk;


# Approach 2: 
SELECT @as := @as + 1 AS asrank, name AS Asia 
FROM student 
WHERE continent = 'Asia' 
ORDER BY name;

SELECT @am := @am + 1 AS amrank, name AS America 
FROM student 
WHERE continent = 'America' 
ORDER BY name;

SELECT @eu := @eu + 1 AS eurank, name AS Europe 
FROM student 
WHERE continent = 'Europe' 
ORDER BY name;

SELECT America, Asia, Europe 
FROM (
    SELECT @as := @as + 1 AS asrank, name AS Asia 
    FROM student 
    WHERE continent = 'Asia' 
    ORDER BY name
) t1
RIGHT JOIN (
    SELECT @am := @am + 1 AS amrank, name AS America 
    FROM student 
    WHERE continent = 'America' 
    ORDER BY name
) t2
ON asrank = amrank
LEFT JOIN (
    SELECT @eu := @eu + 1 AS eurank, name AS Europe 
    FROM student 
    WHERE continent = 'Europe' 
    ORDER BY name
) t3
ON amrank = eurank;



