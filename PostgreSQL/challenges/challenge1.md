
**Each topic will have 5 questions using the CompanyEmployees, Departments, and Locations tables.**

## Topic 1: Basic Queries and Joins

1. List all employees (first name, last name) along with their department name and city.
2. Find the top 5 highest-paid employees and their job titles.
3. Calculate the average salary for each department, showing department name and average salary.
4. List all employees who work in the 'IT' department and are located in 'Southlake'.
5. Find all departments that don't have any employees.

## Topic 2: Aggregations and Group By

1. Count the number of employees in each department and order by count descending.
2. Calculate the total salary budget for each location, showing city and total salary.
3. Find the department with the highest average salary.
4. List all cities with more than 5 employees, along with the employee count.
5. Calculate the average tenure (in years) of employees for each job_id.

## Topic 3: Subqueries and CTEs

1. Find employees who earn more than the average salary of their department.
2. List departments where the manager's salary is below the department's average salary.
3. Find the employee(s) with the highest salary in each location.
4. List all employees who have the same job_id as the highest-paid employee.
5. Calculate the percentage of total salary each department represents.

## Topic 4: Window Functions

1. Rank employees within each department based on their salary.
2. Calculate a running total of salary within each department, ordered by hire_date.
3. Find the salary difference between each employee and the next highest-paid employee in their department.
4. Assign a dense rank to departments based on their average salary.
5. Calculate the median salary for each job_id.

## Topic 5: Advanced Joins and Set Operations

1. List all departments and their managers, including departments without managers.
2. Find all pairs of employees who work in the same department but have different managers.
3. List all locations along with the number of departments and total number of employees in each location.
4. Find all employees who have changed departments (assume the current department_id is their latest).
5. Create a report showing the salary distribution across cities, displaying the number of employees in salary ranges (0-5000, 5001-10000, 10001-15000, 15001+).
