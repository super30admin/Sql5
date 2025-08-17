with CTE AS (
    SELECT *, row_number() over(partition by continent order by name) as row_no 
    from student
)

SELECT 
MIN(CASE WHEN continent = "America" then name ELSE NULL END) as America,
MIN(CASE WHEN Continent = "ASIA" then name ELSE NULL END) as ASIA,
MIN(CASE WHEN Continent = "Europe" then name ELSE NULL END) as Europe
FROM CTE
Group by row_no