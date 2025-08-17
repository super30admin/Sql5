WITH first AS (
    SELECT name AS America, 
           ROW_NUMBER() OVER (ORDER BY name) AS rnk
    FROM Student
    WHERE continent = 'America'
),
second AS (
    SELECT name AS Asia, 
           ROW_NUMBER() OVER (ORDER BY name) AS rnk
    FROM Student
    WHERE continent = 'Asia'
),
third AS (
    SELECT name AS Europe, 
           ROW_NUMBER() OVER (ORDER BY name) AS rnk
    FROM Student
    WHERE continent = 'Europe'
)
SELECT 
    f.America,
    s.Asia,
    t.Europe
FROM 
    first f
LEFT JOIN second s ON f.rnk = s.rnk
LEFT JOIN third t ON f.rnk = t.rnk
ORDER BY f.rnk;
