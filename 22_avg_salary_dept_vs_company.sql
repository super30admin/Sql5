WITH CTE AS(
    SELECT DATE_FORMAT(pay_date, '%Y-%m') AS 'pay_month', department_id,
    AVG(amount) AS 'dept' FROM salary INNER JOIN Employee
    USING (employee_id) GROUP BY department_id, pay_month),
    CTE2 AS(
        SELECT DATE_FORMAT(pay_date, '%Y-%m') AS 'pay_month', AVG(amount)
        AS 'comp' FROM salary INNER JOIN Employee
        USING (employee_id) GROUP BY pay_month)

SELECT c.pay_month, c.department_id, (
    CASE
        WHEN c.dept < a.comp THEN "lower"
        WHEN c.dept = a.comp THEN "same"
        ELSE "higher"
    END
) AS 'comparison' FROM CTE c LEFT JOIN CTE2 a USING (pay_month)