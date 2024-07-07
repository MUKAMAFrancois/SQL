SELECT 
    employee_id, 
    first_name,
    last_name, 
    department_id, 
    salary, 
    avgDepartmentSalary,
    salary - avgDepartmentSalary AS salary_difference,
    ROUND((salary - avgDepartmentSalary) / avgDepartmentSalary * 100, 2) AS percent_above_avg
FROM (
    SELECT *,
     CAST(AVG(salary) OVER (PARTITION BY department_id) AS DECIMAL(10,2)) AS avgDepartmentSalary
    FROM companyemployees
) AS emp
WHERE avgDepartmentSalary < emp.salary
ORDER BY percent_above_avg DESC;