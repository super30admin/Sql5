WITH cte AS (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY continent ORDER BY name) AS row_no
  FROM Student
),
cte1 AS (
  SELECT name AS America, row_no
  FROM cte
  WHERE continent = 'America'
),
cte2 AS (
  SELECT name AS Europe, row_no
  FROM cte
  WHERE continent = 'Europe'
),
cte3 AS (
  SELECT name AS Asia, row_no
  FROM cte
  WHERE continent = 'Asia'
)

SELECT cte1.America, cte3.Asia, cte2.Europe
FROM cte1
LEFT JOIN cte3 ON cte1.row_no = cte3.row_no
LEFT JOIN cte2 ON cte1.row_no = cte2.row_no;
