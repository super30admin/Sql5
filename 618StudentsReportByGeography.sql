# Write your MySQL query statement below

select  
      MAX(CASE WHEN s.continent = 'America' THEN s.name END) as 'America'
    , MAX(CASE WHEN s.continent = 'Asia' THEN s.name END)as 'Asia'
    , MAX(CASE WHEN s.continent = 'Europe' THEN s.name END) as 'Europe'
FROM 
(select name, continent, row_number() over (partition by continent order by name) as 'rnk'
from Student) as s
group by s.rnk