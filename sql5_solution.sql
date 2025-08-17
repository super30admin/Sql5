-- Solution to Problem 1
WITH CTE AS (
    SELECT fail_date AS event_date, 'failed' AS 'period_state' 
    FROM Failed WHERE YEAR(fail_date) = 2019
    UNION
    SELECT success_date AS event_date, 'succeeded' AS 'period_state' 
    FROM Succeeded WHERE YEAR(success_date) = 2019
), 
CTE_rank AS (
    SELECT 
        event_date, period_state, 
        ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY event_date) AS 'rnum',
        RANK() OVER (ORDER BY event_date) AS 'rnk'
    FROM CTE 
)
SELECT period_state, MIN(event_date) AS start_date, MAX(event_date) AS end_date
FROM CTE_rank
GROUP BY period_state, (rnk - rnum)

-- Solution to Problem 2
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

-- Solution to Problem 2 (Use of session variable)
SELECT America, Asia, Europe FROM (
    (SELECT @am := 0, @as := 0, @eu := 0) t1,
    (SELECT @as := @as + 1 AS 'asrnk', name as 'Asia' FROM Student WHERE continent = 'Asia'
ORDER BY name) t2 RIGHT JOIN (
        SELECT @am := @am + 1 AS 'amrnk', name AS 'America' FROM Student WHERE continent = 'America'
ORDER BY name) t3 ON asrnk = amrnk LEFT JOIN (
    SELECT @eu := @eu + 1 AS 'eurnk', name AS 'Europe' FROM Student WHERE continent = 'Europe'
ORDER BY name) t4 ON amrnk = eurnk
)

-- Solution to Problem 3
WITH CTE_avg_sal AS (SELECT AVG(amount) AS 'avg_salary', MONTH(pay_date) AS 'mnt' FROM Salary GROUP BY mnt),
CTE_dept_avg_sal AS (
    SELECT AVG(s.amount) AS 'dept_avg_salary', MONTH(s.pay_date) as 'pay_month', s.pay_date, e.department_id 
    FROM Salary s RIGHT JOIN Employee e ON s.employee_id = e.employee_id
    GROUP BY e.department_id, pay_month
)
SELECT LEFT(t2.pay_date, 7) AS 'pay_month', t2.department_id,
    CASE 
        WHEN t2.dept_avg_salary > t1.avg_salary THEN 'higher'
        WHEN t2.dept_avg_salary = t1.avg_salary THEN 'same'
        ELSE 'lower'
    END AS 'comparison'
    FROM CTE_dept_avg_sal t2 LEFT JOIN CTE_avg_sal t1 ON t2.pay_month = t1.mnt

-- Solution to Problem 4
SELECT player_id, MIN(event_date) as 'First_login'
FROM Activity
GROUP BY player_id;




