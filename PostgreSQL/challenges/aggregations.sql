/*
Open the database learnsql and answer the following:
## Topic 2: Aggregations and Group By

1. Count the number of employees in each department and order by count descending.
2. Calculate the total salary budget for each location, showing city and total salary.
3. Find the department with the highest average salary.
4. List all cities with more than 5 employees, along with the employee count.
5. Calculate the average tenure (in years) of employees for each job_id.
*/



--2.1

SELECT 
    dpt.department_name,
    COUNT(emp.employee_id) AS "Number of Employees"
FROM companyemployees emp
LEFT JOIN departments dpt 
ON emp.department_id = dpt.department_id
LEFT JOIN locations lct
ON dpt.location_id = lct.location_id
GROUP BY dpt.department_name
ORDER BY "Number of Employees" DESC;



--2.2


SELECT 
    lct.city,
    SUM(emp.salary) AS "Salary Per Location"
FROM companyemployees emp
LEFT JOIN departments dpt 
ON emp.department_id = dpt.department_id
LEFT JOIN locations lct
ON dpt.location_id = lct.location_id
GROUP BY lct.city
ORDER BY "Salary Per Location" DESC;



--2.3


SELECT 
    dpt.department_name,
    AVG(emp.salary) AS "Average Salary"
FROM companyemployees emp
LEFT JOIN departments dpt 
ON emp.department_id = dpt.department_id
LEFT JOIN locations lct
ON dpt.location_id = lct.location_id
GROUP BY dpt.department_name
ORDER BY "Average Salary" DESC
LIMIT 1;



--2.4.

SELECT 
    lct.city,
    COUNT(emp.employee_id) AS "No. Employees"
FROM companyemployees emp
LEFT JOIN departments dpt 
ON emp.department_id = dpt.department_id
LEFT JOIN locations lct
ON dpt.location_id = lct.location_id
GROUP BY lct.city
HAVING COUNT(emp.employee_id) > 5
ORDER BY "No. Employees" DESC;



--2.5


SELECT 
    job_id,
    CAST(AVG(EXTRACT(YEAR FROM age(CURRENT_DATE, hire_date))) AS DECIMAL(10,1)) AS "AVG years per Job_ID"
FROM companyemployees
GROUP BY job_id
ORDER BY "AVG years per Job_ID" DESC;






