SELECT 
    ds.pay_month,
    ds.department_id,
    CASE
        WHEN ds.department_avg > cs.company_avg THEN 'higher'
        WHEN ds.department_avg < cs.company_avg THEN 'lower'
        ELSE 'same'
    END AS comparison
FROM (
    -- Calculate average salary per department per month
    SELECT 
        e.department_id,
        DATE_FORMAT(s.pay_date, '%Y-%m') AS pay_month,
        AVG(s.amount) AS department_avg
    FROM 
        salary s
    JOIN 
        employee e ON s.employee_id = e.employee_id
    GROUP BY 
        e.department_id, DATE_FORMAT(s.pay_date, '%Y-%m')
) AS ds
JOIN (
    -- Calculate company-wide average salary per month
    SELECT 
        DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
        AVG(amount) AS company_avg
    FROM 
        salary
    GROUP BY 
        DATE_FORMAT(pay_date, '%Y-%m')
) AS cs
ON 
    ds.pay_month = cs.pay_month;
