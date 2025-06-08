-- Method 1
WITH america AS (
    SELECT  name AS america,
            ROW_NUMBER() OVER(ORDER BY name) as rwn
    FROM student
    WHERE continent = 'America'
),
asia AS (
    SELECT  name AS asia,
            ROW_NUMBER() OVER(ORDER BY name) as rwn
    FROM student
    WHERE continent = 'Asia'
),
europe AS (
    SELECT  name AS europe,
            ROW_NUMBER() OVER(ORDER BY name) as rwn
    FROM student
    WHERE continent = 'Europe'
)
SELECT  am.america,
        a.asia,
        e.europe
FROM america am
LEFT JOIN asia a-- left join because the questions says that America has more number of students
ON am.rwn = a.rwn
LEFT JOIN europe e
ON am.rwn = e.rwn;


-- Method 2 - POSTGRES QUERY - In case it is not clear which country has more number of students (Works in Postgres not MySQL)
WITH america AS (
    SELECT  name AS america,
            ROW_NUMBER() OVER(ORDER BY name) as rwn
    FROM student
    WHERE continent = 'America'
),
asia AS (
    SELECT  name AS asia,
            ROW_NUMBER() OVER(ORDER BY name) as rwn
    FROM student
    WHERE continent = 'Asia'
),
europe AS (
    SELECT  name AS europe,
            ROW_NUMBER() OVER(ORDER BY name) as rwn
    FROM student
    WHERE continent = 'Europe'
)
SELECT  am.america,
        a.asia,
        e.europe
FROM america am
FULL JOIN asia a
ON am.rwn = a.rwn
FULL JOIN europe e
ON am.rwn = e.rwn;

-- Method 3 - Using the session variables isntead of window funtion ROW_NUMBER
SELECT  am.america,
        a.asia,
        e.europe
FROM (
    (SELECT @america := 0, @asia := 0, @europe := 0) sess_var,
    (SELECT  @america := @america + 1 AS rwn,
            name AS america
    FROM student
    WHERE continent = 'America'
    ORDER BY name) am
    LEFT JOIN 
    (SELECT  @asia := @asia + 1 AS rwn,
            name AS asia
    FROM student
    WHERE continent = 'Asia'
    ORDER BY name) a
    ON am.rwn = a.rwn
    LEFT JOIN 
    (SELECT  @europe := @europe + 1 AS rwn,
            name AS europe
    FROM student
    WHERE continent = 'Europe'
    ORDER BY name) e
    ON am.rwn = e.rwn
);