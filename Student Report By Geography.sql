# Write your MySQL query statement below
SELECT America, Asia, Europe
FROM
    (SELECT @am:=0, @as:=0, @eu:=0) t,
    (SELECT @as:= @as +1 AS row_asid, name AS Asia FROM Student WHERE continent = 'Asia' ORDER BY Asia) AS t1 
    RIGHT JOIN 
    (SELECT @am:= @am +1 AS row_amid, name AS America FROM Student WHERE continent = 'America' ORDER BY America) AS t2 
    ON row_asid = row_amid
    LEFT JOIN
    (SELECT @eu:= @eu +1 AS row_euid, name AS Europe FROM Student WHERE continent = 'Europe' ORDER BY Europe) AS t3 
    ON row_amid = row_euid

