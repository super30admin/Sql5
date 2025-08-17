"""
  
Table: Salary
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| employee_id | int  |
| amount      | int  |
| pay_date    | date |
+-------------+------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the salary of an employee in one month.
employee_id is a foreign key (reference column) from the Employee table.
 
Table: Employee
+---------------+------+
| Column Name   | Type |
+---------------+------+
| employee_id   | int  |
| department_id | int  |
+---------------+------+
In SQL, employee_id is the primary key column for this table.
Each row of this table indicates the department of an employee.

Find the comparison result (higher/lower/same) of the average salary of employees in a department to the company's average salary.

Return the result table in any order.

The result format is in the following example.

Input: 
Salary table:
+----+-------------+--------+------------+
| id | employee_id | amount | pay_date   |
+----+-------------+--------+------------+
| 1  | 1           | 9000   | 2017/03/31 |
| 2  | 2           | 6000   | 2017/03/31 |
| 3  | 3           | 10000  | 2017/03/31 |
| 4  | 1           | 7000   | 2017/02/28 |
| 5  | 2           | 6000   | 2017/02/28 |
| 6  | 3           | 8000   | 2017/02/28 |
+----+-------------+--------+------------+
Employee table:
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
| 1           | 1             |
| 2           | 2             |
| 3           | 2             |
+-------------+---------------+
Output: 
+-----------+---------------+------------+
| pay_month | department_id | comparison |
+-----------+---------------+------------+
| 2017-02   | 1             | same       |
| 2017-03   | 1             | higher     |
| 2017-02   | 2             | same       |
| 2017-03   | 2             | lower      |
+-----------+---------------+------------+
  
"""

with company_salary as 
(
    select 
        date_format(s.pay_date, '%Y-%m') as pay_month, 
        avg(s.amount) as company_avg
    from 
        Salary s
    group by 
        date_format(s.pay_date, '%Y-%m')
),
department_salary as
(
    select 
        e.department_id, 
        avg(amount) as dept_avg, 
        date_format(pay_date, '%Y-%m') as pay_month
    from 
        Salary s join Employee e 
    on 
        s.employee_id = e.employee_id
    group by 
        e.department_id, pay_month
)

select 
    department_salary.pay_month, 
    department_id,
    case 
        when dept_avg > company_avg then 'higher'
        when dept_avg < company_avg then 'lower'
        else 'same'
    end as comparison
from 
    department_salary join company_salary
on 
    department_salary.pay_month = company_salary.pay_month
