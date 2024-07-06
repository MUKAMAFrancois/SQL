
/* 1.

Write a SQL query to make a join with three tables CompanyEmployees,
departments and locations to find the name, including first_name and last_name,
 jobs, department name and ID, 
of the employees working in London.

*/

select 
 emp.employee_id,
 emp.first_name || ' ' || emp.last_name AS "Employer Names",
 emp.email,
 emp.salary,
 emp.department_id,
 dpt.department_name,
 emp.job_id,
 dpt.manager_id,
 lct.city,
 COALESCE(lct.state_province,'UnAvailable') AS "State Province",
 lct.country_id
 
 FROM companyemployees AS emp
 LEFT JOIN departments AS dpt
 ON emp.department_id=dpt.department_id
 LEFT JOIN locations as lct
 ON dpt.location_id = lct.location_id
 WHERE lct.city='London';


