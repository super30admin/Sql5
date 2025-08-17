WITH first AS (
    SELECT name AS 'America', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk' 
    FROM student 
    WHERE continent = 'America'
),
second AS (
    SELECT name AS 'Asia', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk' 
    FROM student 
    WHERE continent = 'Asia'
),
third AS (
    SELECT name AS 'Europe', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk' 
    FROM student 
    WHERE continent = 'Europe'
)
SELECT America, Asia, Europe 
FROM second 
RIGHT JOIN first ON first.rnk = second.rnk 
LEFT JOIN third ON first.rnk = third.rnk;
