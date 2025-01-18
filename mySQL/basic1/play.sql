-- Active: 1737121311446@@127.0.0.1@3306@online_store
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dept_id INT,
    manager_id INT
);


-- Insert sample data for departments
INSERT INTO departments VALUES
(1, 'IT', 'New York'),
(2, 'HR', 'Chicago'),
(3, 'Finance', 'Boston'),
(4, 'Marketing', 'Miami'),
(5, 'Sales', 'Los Angeles');

-- Insert sample data for employees
INSERT INTO employees VALUES
(1, 'John', 'Doe', 1, 5),    -- IT Department
(2, 'Jane', 'Smith', 2, 5),  -- HR Department
(3, 'Bob', 'Johnson', 1, 5), -- IT Department
(4, 'Alice', 'Williams', 3, 6), -- Finance Department
(5, 'Mike', 'Brown', 2, NULL),  -- HR Department
(6, 'Sarah', 'Davis', NULL, NULL), -- No Department
(7, 'Tom', 'Wilson', NULL, 5);     -- No Department

select * from employees;

select d.dept_id,d.dept_name,d.location,e.emp_id,e.first_name,e.last_name,e.manager_id from departments d INNER JOIN employees e where d.dept_id = e.dept_id;


-- Returns all records from left table and matching from right
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;


select e.first_name,e.last_name,d.dept_name from employees e LEFT JOIN departments d on e.dept_id = d.dept_id 
UNION 
select e.first_name,e.last_name,d.dept_name from employees e RIGHT JOIN departments d on e.dept_id = d.dept_id;

select 
    e1.first_name,e1.last_name as employee,
    e2.first_name,e2.last_name as manager
from employees e1 INNER JOIN employees e2 on e1.emp_id = e2.manager_id;

-- Find employees without departments
SELECT e.first_name, e.last_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- Shows only employees with no department

SELECT d.dept_name as 'DEPARTMENT NAME',d.location AS 'DEPARTMENT LOCATION'
FROM employees e RIGHT JOIN departments d on d.dept_id = e.dept_id where e.dept_id is null;

 SELECT concat('Post', 'gre', 'SQL') AS concatenated_string;