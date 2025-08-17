"""
  
Table: Student
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
+-------------+---------+
This table may contain duplicate rows.
Each row of this table indicates the name of a student and the continent they came from.
 
A school has students from Asia, Europe, and America.

Write a solution to pivot the continent column in the Student table so that each name is sorted alphabetically and displayed underneath its corresponding continent. 
The output headers should be America, Asia, and Europe, respectively.

The test cases are generated so that the student number from America is not less than either Asia or Europe.

The result format is in the following example.

Input: 
Student table:
+--------+-----------+
| name   | continent |
+--------+-----------+
| Jane   | America   |
| Pascal | Europe    |
| Xi     | Asia      |
| Jack   | America   |
+--------+-----------+
Output: 
+---------+------+--------+
| America | Asia | Europe |
+---------+------+--------+
| Jack    | Xi   | Pascal |
| Jane    | null | null   |
+---------+------+--------+
  
"""


with america as(
select (@am:=@am+1) as id, name as America
from student s, (select @am:=0) b
where continent = 'America'
order by name
),
asia as(
select (@a:=@a+1) as id, name as Asia
from student s, (select @a:=0) b
where continent = 'Asia'
order by name
),
europe as(
select (@e:=@e+1) as id, name as Europe
from student s, (select @e:=0) b
where continent = 'Europe'
order by name
)

select 
    America, Asia, Europe
from 
    america a
left join 
    asia es
on 
    a.id = es.id
left join 
    europe e
on 
    a.id = e.id
