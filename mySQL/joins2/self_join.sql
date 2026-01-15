
-- ===========================
-- A self join is a join in which a table is joined with itself. It is useful when there is a relationship between rows in the same table, such as hierarchical data, comparisons within the same dataset, or looking for related data within a single table.


-- Example Scenario: Employee Hierarchy
-- Let’s assume we have an Employees table that stores details of employees, 
--including their ManagerID to indicate which employee is their manager.

-- drop table EmployeeHierarchy;

create table EmployeeHierarchy (
    emp_id int AUTO_INCREMENT PRIMARY key,
    name varchar(100) not null,
    manager_id int,
    position varchar(100) not null,
    salary DECIMAL(10,2),
    check (salary >0)
);



INSERT INTO EmployeeHierarchy (name, manager_id, position, salary) VALUES  
('Alice Johnson', NULL, 'CEO', 150000.00),  
('Bob Smith', 1, 'CTO', 120000.00),  
('Charlie Brown', 1, 'CFO', 110000.00),  
('Diana Prince', 2, 'IT Manager', 90000.00),  
('Ethan Hunt', 2, 'Systems Analyst', 70000.00),  
('Fiona Glenanne', null, 'Finance Manager', 95000.00),  
('George Washington', 1, 'COO', 115000.00),  
('Hannah Montana', 4, 'Lead Developer', 80000.00),  
('Ivy League', 4, 'Junior Developer', 60000.00),  
('Jack Sparrow', 5, 'Junior Analyst', 50000.00),  
('Kate Hudson', 5, 'Senior Analyst', 75000.00),  
('Laura Croft', 6, 'Accountant', 55000.00),  
('Mickey Mouse', null, 'Operations Manager', 92000.00),  
('Nancy Drew', 8, 'Intern', 30000.00),  
('Oliver Twist', 13, 'Intern', 30000.00);

select * from employeehierarchy;

-- We can achieve self join using ALIASES.

SELECT e.emp_id AS 'Employee ID',
e.name AS 'Employee Name',
e.position AS 'Job Position',
COALESCE(mng.name,'-') AS 'Manager Name'

FROM employeehierarchy e LEFT JOIN employeehierarchy mng ON e.manager_id = mng.emp_id;

-- Who are Managers?

SELECT e.emp_id AS 'Employee ID',
e.name AS 'Employee Name',
e.position AS 'Job Position'

FROM employeehierarchy e 
LEFT JOIN employeehierarchy mng ON 
e.manager_id = mng.emp_id WHERE e.manager_id IS NULL;

-- All employees excluding Managers.

SELECT e.emp_id AS 'Employee ID',
e.name AS 'Employee Name',
e.position AS 'Job Position',
mng.name AS 'Manager Name'

FROM employeehierarchy e 
LEFT JOIN employeehierarchy mng ON 
e.manager_id = mng.emp_id WHERE e.manager_id IS NOT NULL;


-- Find managers who have more than one employee



