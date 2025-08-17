#511. Game Play Analysis I
#If we swipe the min date to max date
SELECT player_id, MIN(event_date) as 'first_login'
FROM Activity
GROUP BY player_id;

SELECT DISTINCT player_id, MIN(event_date) OVER (PARTITION BY player_id Order by event_date) AS 'first_login'
FROM Activity;

SELECT DISTINCT player_id, MIN(event_date) OVER (PARTITION BY player_id) AS 'first_login'
FROM Activity;

#using RANK()
SELECT a.player_id, a.event_date AS 'first_login'
FROM (
    SELECT b.player_id, b.event_date, RANK() OVER(PARTITION BY b.player_id ORDER BY b.event_date) AS 'rnk'
    FROM Activity b
) a WHERE a.rnk =1;

#Using FIRST_VALUE()
SELECT DISTINCT a.player_id, FIRST_VALUE(a.event_date) OVER (PARTITION BY a.player_id ORDER BY a.event_date) AS 'first_login' FROM Activity a;

#Using LAST_VALUE() , RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUND FOLLOWING.
SELECT DISTINCT a.player_id, LAST_VALUE(a.event_date) OVER (PARTITION BY a.player_id ORDER BY a.event_date DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'first_login' FROM Activity a;

#Using DENSE_RANK()
SELECT a.player_id, a.event_date AS 'first_login'
FROM (
    SELECT b.player_id, b.event_date, DENSE_RANK() OVER(PARTITION BY b.player_id ORDER BY b.event_date) AS 'rnk'
    FROM Activity b
) a WHERE a.rnk =1;

#Using ROW_NUMBER()
SELECT a.player_id, a.event_date AS 'first_login'
FROM (
    SELECT b.player_id, b.event_date, ROW_NUMBER() OVER(PARTITION BY b.player_id ORDER BY b.event_date) AS 'rnk'
    FROM Activity b
) a WHERE a.rnk =1;

#512. Game Play Analysis II-----
# Write your MySQL query statement below
SELECT DISTINCT a.player_id, a.device_id
FROM Activity a
WHERE a.event_date IN (
    SELECT MIN(b.event_date)
FROM Activity b WHERE a.player_id = b.player_id);

# taking too much of time(time exceeded)
SELECT a.player_id, a.device_id
FROM Activity a WHERE a.event_date =(
    SELECT MIN(b.event_date) FROM Activity b WHERE a.player_id = b.player_id
);

#Using DENSE_RANK()
WITH CTE AS (
    SELECT player_id, device_id, DENSE_RANK() OVER(PARTITION BY player_id ORDER BY event_date) AS
    'rnk' FROM Activity)
SELECT player_id, device_id FROM CTE WHERE rnk = 1;

#Using FIRST_VALUE()
SELECT DISTINCT player_id, FIRST_VALUE(device_id) OVER(PARTITION BY player_id ORDER BY event_date) AS 'device_id'
FROM Activity;

#Using LAST_VALUE()
SELECT DISTINCT player_id, LAST_VALUE(device_id) OVER(PARTITION BY player_id ORDER BY event_date DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'device_id'
FROM Activity;

#1225. Report Contiguous Dates
# Write your MySQL query statement below
With CTE AS (SELECT fail_date AS 'dat','failed' AS period_state, rank() OVER(ORDER BY fail_date) AS 'rnk' FROM Failed
WHERE YEAR(fail_date) = 2019
UNION ALL
SELECT success_date AS 'dat', 'succeeded' AS period_state, rank() OVER(ORDER BY success_date) AS 'rnk' FROM Succeeded
WHERE YEAR(success_date) = 2019)

SELECT period_state, MIN(dat) AS 'start_date', MAX(dat) AS 'end_date' FROM (SELECT *,
(rank() OVER(ORDER BY dat )- rnk) AS 'group_rnk' FROM CTE) AS y 
GROUP BY group_rnk, period_state 
ORDER BY start_date;

#Alternative
With CTE AS (SELECT fail_date AS 'dat','failed' AS period_state, rank() OVER(ORDER BY fail_date) AS 'rnk' FROM Failed
WHERE YEAR(fail_date) = 2019
UNION ALL
SELECT success_date AS 'dat', 'succeeded' AS period_state, rank() OVER(ORDER BY success_date) AS 'rnk' FROM Succeeded
WHERE YEAR(success_date) = 2019)

SELECT period_state, MIN(dat) AS 'start_date', MAX(dat) AS 'end_date' FROM (SELECT *,
(rank() OVER(ORDER BY dat )- rnk) AS 'group_rnk' FROM CTE) AS y 
GROUP BY group_rnk, period_state 
ORDER BY 2;


#618. Students Report By Geography
SELECT 
    MAX(CASE WHEN continent = 'America' THEN name ELSE NULL END) AS America,
    MAX(CASE WHEN continent = 'Asia' THEN name ELSE NULL END) AS Asia,
    MAX(CASE WHEN continent = 'Europe' THEN name ELSE NULL END) AS Europe
FROM (
    SELECT
        name,
        continent,
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) as 'rnk'
    FROM Student
    WHERE continent IN ('America', 'Asia', 'Europe')
) AS RankedStudents
GROUP BY rnk;

#Alternative # Write your MySQL query statement below
SELECT America, Asia, Europe
FROM(
    SELECT ROW_NUMBER() OVER(ORDER BY name) euid, name as Europe FROM Student
    WHERE continent = 'Europe') eu
    RIGHT JOIN
    (SELECT ROW_NUMBER() OVER(ORDER BY name) amid, name as America FROM Student
    WHERE continent = 'America') am
    ON euid = amid
    LEFT JOIN
    (SELECT ROW_NUMBER() OVER(ORDER BY name) asid, name as Asia FROM Student
    WHERE continent = 'Asia') asia
    ON asid = amid

# 618. Students Report By Geography. Write your MySQL query statement below
SELECT dep_avg.month_year as pay_month, department_id,
CASE WHEN comp_avg.comp_sal > dep_avg.dep_sal THEN 'lower'
WHEN comp_avg.comp_sal < dep_avg.dep_sal THEN 'higher'
ELSE 'same' END as comparison
FROM
(
    SELECT date_format(pay_date, '%Y-%m') as month_year, avg(amount) as comp_sal 
    FROM Salary
    GROUP BY month_year
) comp_avg
JOIN
(
    SELECT date_format(pay_date,'%Y-%m') as month_year, department_id, avg(amount) as dep_sal
    FROM Salary s 
    JOIN Employee e ON s.employee_id = e.employee_id
    GROUP BY month_year, department_id
) dep_avg
ON comp_avg.month_year = dep_avg.month_year;
