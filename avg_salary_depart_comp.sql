CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    department_id INT
);

CREATE TABLE salary (
    id INT PRIMARY KEY,
    employee_id INT,
    amount DECIMAL(10, 2),
    pay_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

-- Insert values into the employee table
INSERT INTO employee (employee_id, department_id) VALUES
(1, 1),
(2, 2),
(3, 2);

-- Insert values into the salary table
INSERT INTO salary (id, employee_id, amount, pay_date) VALUES
(1, 1, 9000.00, '2017-03-31'),
(2, 2, 6000.00, '2017-03-31'),
(3, 3, 10000.00, '2017-03-31'),
(4, 1, 7000.00, '2017-02-28'),
(5, 2, 6000.00, '2017-02-28'),
(6, 3, 8000.00, '2017-02-28');

# date in year-month formant
SELECT date_format(pay_date, '%Y -%m') AS 'pay_month' FROM salary;

# Company Salary Table
SELECT date_format(pay_date, '%Y -%m') AS 'pay_month', 
AVG(amount) AS 'comp_avg' 
FROM salary GROUP BY pay_month; 

# Department_salary table
SELECT department_id, 
date_format(pay_date, '%Y-%m') AS 'pay_month',
AVG(amount) AS 'depart_avg'
FROM salary
JOIN employee
ON salary.employee_id = employee.employee_id
GROUP BY department_id, pay_month;

# Actual Query
 WITH comp_salary AS( SELECT date_format(pay_date,'%Y-%m') AS 'pay_month',
 AVG (amount) AS 'comp_avg_salary'
 FROM salary
 GROUP BY pay_month
),
depart_salary AS(
 SELECT date_format(pay_date,'%Y-%m') AS 'pay_month',
 AVG (amount) AS 'depart_avg_salary',
 department_id
 FROM salary
 JOIN employee
 ON salary.employee_id = employee.employee_id
 GROUP BY department_id, pay_month
)
SELECT depart_salary.pay_month, 
department_id , 
(CASE
WHEN depart_avg_salary > comp_avg_salary THEN 'higher'
WHEN depart_avg_salary < comp_avg_salary THEN 'lower'
ELSE 'same'
END
 ) AS 'comparison'
FROM comp_salary 
JOIN depart_salary
ON comp_salary. pay_month = depart_salary.pay_month;
