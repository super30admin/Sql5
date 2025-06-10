WITH companyAvg as(
    Select date_format(pay_date,'%Y-%m') as 'pay_month',
    AVG(amount) as 'companyavg' from salary group by pay_month
),
deptAvg as(
    Select date_format(pay_date,'%Y-%m') as 'pay_month',
    department_id, AVG(amount) as 'deptavg' from salary join employee
    ON salary.employee_id = employee.employee_id
    group by department_id, pay_month
)
SELECT deptAvg.pay_month, department_id,
(
    CASE
        WHEN deptavg>companyavg THEN 'higher'
        WHEN deptavg<companyavg THEN 'lower'
        ELSE 'same'
    END
) as 'comparison' from companyAvg JOIN deptAvg ON
deptAvg.pay_month = companyAvg.pay_month