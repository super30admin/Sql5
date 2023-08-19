/*
1. Maintain three session variables for each continent. Initialize them to 0.
2. Use the session variables to generate row numbers for each continent. We use the session variables to increment the row number for each row in the continent.
3. Use the row numbers to join the continents.
*/

select America, Asia, Europe from
(

    (SELECT @am := 0, @as := 0, @eu := 0) t, 
    (SELECT @as := @as + 1 as asid, name as Asia from student where continent = 'Asia' order by Asia) 
    as t1 right join 
    (SELECT @am := @am + 1 as amid, name as America from student where continent = 'America' order by America) as t2
    on t1.asid = t2.amid  left join 
    (
        SELECT @eu := @eu + 1 as euid, name as Europe from student where continent = 'Europe' order by Europe) as t3
    on t3.euid = t2.amid
)

