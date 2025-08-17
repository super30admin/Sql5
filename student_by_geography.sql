# Using CTE
WITH CTEAM AS (
    SELECT 
        name AS 'America',
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS 'row_numAm'
    FROM Student
    WHERE continent = 'America'
),
CTEAS AS (
    SELECT 
        name AS 'Asia',
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS 'row_numAs'
    FROM Student 
    WHERE continent = 'Asia'
),
CTEEU AS (
    SELECT 
        name AS 'Europe',
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS 'row_numEu'
    FROM Student 
    WHERE continent = 'Europe'
)
SELECT CTEAM.America,  CTEAS.Asia, CTEEU.Europe
FROM 
    CTEAM 
LEFT JOIN 
    CTEAS ON CTEAM.row_numAm = CTEAS.row_numAs
LEFT JOIN 
    CTEEU ON CTEAM.row_numAm = CTEEU.row_numEu;

########## OR We caan aslo use  ################
    -- FROM CTEAS
    -- RIGHT JOIN CTEAM 
    -- ON CTEAM.row_numAm = CTEAS.row_numAs
    -- LEFT JOIN CTEEU 
    -- ON CTEAM.row_numAm = CTEEU.row_numEu
#################################################
# Using Subquery
SELECT Am.America, Asi.Asia, Eu.Europe
FROM (
    SELECT name AS 'America',
    ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS 'row_numAm'
    FROM Student
    WHERE continent = 'America'
) AS Am
LEFT JOIN (SELECT name AS 'Asia',
    ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS 'row_numAs'
    FROM Student
    WHERE continent = 'Asia') AS Asi
ON Am.row_numAm = Asi.row_numAs
LEFT JOIN (SELECT name AS 'Europe',
    ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS 'row_numEu'
    FROM Student
    WHERE continent = 'Europe'
) AS Eu
ON Am.row_numAm = Eu.row_numEu

# Uring Session Variable
SELECT America, Asia, Europe
FROM (SELECT @am := 0, @as := 0, @eu := 0)t,
(
    SELECT @am := @am+1 As 'rnk_am', name AS 'America'
FROM Student
WHERE continent = 'America'
ORDER BY America
)AS t1
LEFT JOIN 
(
    SELECT @as := @as +1 As 'rnk_as', name AS 'Asia'
FROM Student
WHERE continent  = 'Asia'
ORDER BY Asia
) AS t2
ON rnk_am = rnk_as
LEFT JOIN
(
    SELECT @eu := @eu + 1 AS 'rnk_eu', name AS 'Europe'
    FROM Student 
    WHERE continent = 'Europe'
    ORDER BY Europe
) AS t3
ON rnk_am = rnk_eu;
