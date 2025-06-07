# Write your MySQL query statement below
--Solution 1

with first as(
    select name as 'America', row_number() over(order by name) as 'rnk' 
    from student where continent ='America'
),
second as(
    select name as 'Asia', row_number() over(order by name)  as 'rnk' 
    from student where continent ='Asia'
),
third as(
    select name as 'Europe', row_number() over(order by name)  as 'rnk' 
    from student where continent ='Europe'
)

select America,Asia,Europe
from second right join first on first.rnk=second.rnk
left join third on first.rnk=third.rnk

--Solution 2 with session variables

select America,Asia,Europe from (
    (select @am:=0, @as:=0,@eu:=0)t1,
    (select @as:=@as+1 as 'asrnk',name as 'Asia' from student where continent='Asia' order by Asia)t2
    right join 
    (select @am:=@am+1 as 'amrnk',name as 'America' from student where continent='America' order by America)t3 on asrnk=amrnk
    left join
    (select @eu:=@eu+1 as 'eurnk',name as 'Europe' from student where continent='Europe' order by Europe)t4 on eurnk=amrnk
)