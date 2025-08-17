# Write your MySQL query statement below

#APPROACH 1
# WITH cte AS(  
#   SELECT 
#   CASE WHEN continent = 'America' THEN @b := @b + 1 
#       WHEN continent = 'Asia' THEN @c := @c + 1
#       WHEN continent = 'Europe' THEN @d := @d + 1
#   END AS id,
#   continent, 
#   CASE
#     WHEN continent = 'America' THEN name
#     WHEN continent = 'Asia' THEN name
#     WHEN continent = 'Europe' THEN name
#   END AS name
#   FROM Student, (SELECT @b := 0, @c := 0, @d := 0 ) a
#   ORDER BY continent, name
# )

# SELECT
#     MAX(CASE WHEN continent = 'America' THEN name END) AS America,
#     MAX(CASE WHEN continent = 'Asia' THEN name END) AS Asia,
#     MAX(CASE WHEN continent = 'Europe' THEN name END) AS Europe
# FROM cte
# GROUP BY id
# ORDER BY id;

#APPROACH 2
WITH cte AS (
    SELECT
        name,
        continent,
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS row_num
    FROM Student
)

SELECT
    MAX(CASE WHEN continent = 'America' THEN name END) AS America,
    MAX(CASE WHEN continent = 'Asia' THEN name END) AS Asia,
    MAX(CASE WHEN continent = 'Europe' THEN name END) AS Europe
FROM cte
GROUP BY row_num
ORDER BY row_num;