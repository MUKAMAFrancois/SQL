/*

Open the database learnsql and answer the following:

## Topic 1: Basic Queries and Joins

1. List all employees (first name, last name) along with their department name and city.
2. Find the top 5 highest-paid employees and their job titles.
3. Calculate the average salary for each department, showing department name and average salary.
4. List all employees who work in the 'IT' department and are located in 'Southlake'.
5. Find all departments that don't have any employees.

*/



--1.

select 
emp.first_name,
emp.last_name,
dpt.department_name,
lct.city
 from companyemployees emp 
 LEFT JOIN departments dpt 
 ON emp.department_id=dpt.department_id
 LEFT JOIN locations lct
 ON dpt.location_id=lct.location_id;


--2. 

select 
 emp.employee_id,
 emp.first_name AS "First Name",
 emp.last_name As "Last Name",
 emp.phone_number As "Telephone",
 emp.hire_date AS "Hired At",
 emp.salary
from companyemployees emp
ORDER BY emp.salary DESC LIMIT 5;


--3.

SELECT 
    dpt.department_name,
    CAST(AVG(emp.salary) AS DECIMAL(10,2)) AS "Department AVG Salary"
FROM companyemployees emp
LEFT JOIN departments dpt 
ON emp.department_id = dpt.department_id
LEFT JOIN locations lct
ON dpt.location_id = lct.location_id
GROUP BY dpt.department_name
ORDER BY "Department AVG Salary" DESC;



--4. 

select 
emp.employee_id,
emp.first_name,
emp.last_name,
dpt.department_name,
lct.city

 from companyemployees emp 
 LEFT JOIN departments dpt 
 ON emp.department_id=dpt.department_id
 LEFT JOIN locations lct
 ON dpt.location_id=lct.location_id
 WHERE dpt.department_name='IT' AND lct.city='Southlake'
 ORDER BY emp.employee_id;


--5. 


select 
dpt.department_name

 from companyemployees emp 
 LEFT JOIN departments dpt 
 ON emp.department_id=dpt.department_id
 LEFT JOIN locations lct
 ON dpt.location_id=lct.location_id
 WHERE emp.employee_id IS NULL;
