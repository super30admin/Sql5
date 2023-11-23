# Write your MySQL query statement below


select America,Asia,Europe from

(select row_number() over (order by name) as rna, name as America from Student where continent = "America") t1
left join
(select row_number() over (order by name) as rnas, name as Asia from Student where continent = "Asia") t2
on t1.rna = t2.rnas
left join
(select row_number() over (order by name) as rne, name as Europe from Student where continent = "Europe") t3
on t1.rna = t3.rne
