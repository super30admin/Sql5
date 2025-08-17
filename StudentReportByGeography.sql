with cte as 
    (select name as 'America', row_number() over (order by name) as 'rnk' from student 
    where continent='America' order by name),

cte1 as 
    (select name as 'Asia', row_number() over (order by name) as 'rnk' from student 
    where continent='Asia' order by name),

cte2  as (select name as 'Europe', row_number() over (order by name) as 'rnk' from student 
where continent='Europe' order by name)

select America, Asia , Europe from cte1 
    right join cte on cte.rnk=cte1.rnk 
    left join cte2 on cte.rnk=cte2.rnk;