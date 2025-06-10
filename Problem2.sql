WITH first as(
    SELECT name as 'America', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk' From student WHERE continent = 'America'
),
second as(
    SELECT name as 'Asia', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk' From student WHERE continent = 'Asia'
),
third as(
    SELECT name as 'Europe', ROW_NUMBER() OVER(ORDER BY name) AS 'rnk' From student WHERE continent = 'Europe'
)

SELECT America , Asia , Europe FROM second RIGHT JOIN first on first.rnk = second.rnk LEFT JOIN third 
ON first.rnk = third.rnk;