
-- Using row number
WITH a AS (SELECT name AS 'America', ROW_NUMBER() OVER(ORDER BY name) AS rnk
 FROM Student WHERE continent = 'America' ORDER BY name),
b AS (SELECT name AS 'Asia', ROW_NUMBER() OVER(ORDER BY name) AS rnk FROM Student WHERE continent = 'Asia' ORDER BY name),
c AS (SELECT name AS 'Europe', ROW_NUMBER() OVER(ORDER BY name) AS rnk FROM Student WHERE continent = 'Europe' ORDER BY name)

SELECT a.America,b.Asia,c.Europe FROM a 
LEFT JOIN b ON a.rnk = b.rnk 
LEFT JOIN c ON a.rnk = c.rnk


-- Using session variable
SELECT America,Asia,Europe FROM
(SELECT @am := 0,@as := 0, @eu:=0) t1,
(SELECT @as := @as+1 AS 'rnk', name AS 'Asia' FROM Student WHERE continent = 'Asia' ORDER BY name) t2 RIGHT JOIN
(SELECT @am := @am+1 AS 'rnk', name AS 'America' FROM Student WHERE continent = 'America' ORDER BY name) t3 ON
t2.rnk = t3.rnk
LEFT JOIN (SELECT @eu := @eu+1 AS 'rnk', name AS 'Europe' FROM Student WHERE continent = 'Europe' ORDER BY name) t4 
ON t3.rnk = t4.rnk


