WITH CTE1 AS(
    SELECT name AS 'America', ROW_NUMBER() OVER (ORDER BY name) as 'rnk' 
    FROM student WHERE continent = 'America'),
CTE2 AS(
    SELECT name AS 'Asia', ROW_NUMBER() OVER (ORDER BY name) as 'rnk' 
    FROM student WHERE continent = 'Asia'),
CTE3 AS(
    SELECT name AS 'Europe', ROW_NUMBER() OVER (ORDER BY name) as 'rnk' 
    FROM student WHERE continent = 'Europe')

SELECT America, Asia, Europe FROM CTE1 LEFT JOIN CTE2 USING (rnk) LEFT JOIN CTE3 USING (rnk)

-- Alternative approach using session variables
/* SELECT America, Asia, Europe FROM (
    (SELECT @am := 0, @as := 0, @eu := 0)t,
    (SELECT @as := @as + 1 AS 'asrnk', name AS 'Asia'FROM student WHERE continent = 'Asia' ORDER BY name)t2 RIGHT JOIN 
    (SELECT @am := @am + 1 AS 'amrnk', name AS 'America'FROM student WHERE continent = 'America' ORDER BY name)t1 ON asrnk = amrnk LEFT JOIN
    (SELECT @eu := @eu + 1 AS 'eurnk', name AS 'Europe'FROM student WHERE continent = 'Europe' ORDER BY name)t3 ON amrnk = eurnk) */