/*SELECT date_format(pay_date, "%Y-%m") AS pay_month, AVG(salary) as "company_average"  FROM Salary
group by pay_month

SELECT date_format(s.pay_date, "%Y-%m") AS pay_month, AVG(s.amount) as "department_average"  FROM Salary s
INNER JOIN Department d on s.employeeId = d.employeeId
group by d.departmentId , pay_month
*/

SELECT  departmentId.pay_month , departmentSalary.departmentId, (
    CASE
        WHEN department_average > company_average THEN 'higer'
        WHEN department_average < company_average THEN 'lower'
        ELSE 'same'
    END ) AS 'comparision' FROM  (SELECT date_format(s.pay_date, "%Y-%m") AS pay_month, AVG(s.amount) as "department_average"  FROM Salary s
INNER JOIN Department d on s.employeeId = d.employeeId
group by d.departmentId , pay_month) AS departmentSalary
JOIN
(SELECT date_format(pay_date, "%Y-%m") AS pay_month, AVG(salary) as "company_average"  FROM Salary
group by pay_month) AS companySalary
ON departmentSalary.pay_month = companySalary.pay_month;
