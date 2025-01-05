WITH cte1 AS (
    SELECT 
        e.department_id, 
        AVG(s.amount) AS department_avg, 
        DATE_FORMAT(s.pay_date, '%Y-%m') AS pay_month 
    FROM 
        salary s
    JOIN 
        employee e ON s.employee_id = e.employee_id 
    GROUP BY 
        e.department_id, 
        pay_month
),
cte2 AS (
    SELECT 
        AVG(s.amount) AS company_avg, 
        DATE_FORMAT(s.pay_date, '%Y-%m') AS pay_month 
    FROM 
        salary s
    GROUP BY 
        pay_month
)
SELECT 
    cte1.pay_month, 
    cte1.department_id, 
    CASE 
        WHEN cte1.department_avg > cte2.company_avg THEN 'higher' 
        WHEN cte1.department_avg < cte2.company_avg THEN 'lower' 
        ELSE 'same' 
    END AS comparison
FROM 
    cte1
JOIN 
    cte2 ON cte1.pay_month = cte2.pay_month;