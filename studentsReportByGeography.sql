
with amcte as(
    select name as 'America', row_number() over(order by name) rnk 
    from Student where continent = 'America'
),
ascte as(
    select name as 'Asia' , row_number() over(order by name) as rnk 
    from Student where continent = 'Asia'
),
eucte as(
    select name as 'Europe', row_number() over(order by name) as rnk 
    from Student where continent = 'Europe'
)
-- select * from amcte
select America, Asia, Europe from ascte asia right join amcte am 
on asia.rnk = am.rnk left join eucte eu 
on am.rnk = eu.rnk