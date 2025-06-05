WITH am_con AS (
    SELECT
        NAME AS America,
        ROW_NUMBER() OVER (ORDER BY name) AS rnk
    FROM Student
    WHERE continent = 'America'
),
eu_con AS (
    SELECT
        NAME AS Europe,
        ROW_NUMBER() OVER (ORDER BY name) AS rnk
    FROM Student
    WHERE continent = 'Europe'
),
as_con AS (
    SELECT
        NAME AS Asia,
        ROW_NUMBER() OVER (ORDER BY name) AS rnk
    FROM Student
    WHERE continent = 'Asia'
)

select
    am_con.America,
    as_con.Asia,
    eu_con.Europe
from
    am_con
left join
    eu_con
on am_con.rnk = eu_con.rnk
left join
    as_con
on am_con.rnk = as_con.rnk