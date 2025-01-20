-- Active: 1737121311446@@127.0.0.1@3306@company
-- https://youtu.be/Ww71knvhQ-s

-- Window functions in MySQL are powerful tools used to perform calculations across a set of rows that are related to the current row. Unlike aggregate functions that return a single result for a group of rows, window functions allow you to return results for each row while still providing information about the group as a whole.

-- Key Features of Window Functions:
-- Over Clause: Window functions use an OVER() clause to define the window or the set of rows the function will operate on. It can include partitioning and ordering of the rows.

-- Types of Window Functions:

-- Aggregate Functions: Functions like SUM(), AVG(), and COUNT(), when used in a window context.
-- Ranking Functions: Functions like ROW_NUMBER(), RANK(), and DENSE_RANK() to assign a unique rank to rows based on specified criteria.
-- Analytic Functions: Functions such as LEAD() and LAG() to access data from subsequent or preceding rows in the result set.
-- Partitioning: You can partition the data into subsets for calculations using the PARTITION BY clause within the OVER() function, allowing for calculations over that specific subset.

-- Ordering: You can define the order of rows within each partition using the ORDER BY clause, which affects the result of certain functions.

-- RANK, ROW_NUMBER, RANK, DENSE_RANK, LEAD, LAG

CREATE TABLE EMployeeDetails(
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_name VARCHAR(100) NOT NULL,
    salary INT NOT NULL,
    CHECK (salary>0)
);

INSERT INTO employeedetails(emp_name,dept_name,salary) VALUES('George','IT',4590);

INSERT INTO EmployeeDetails (emp_name, dept_name, salary) VALUES  
('Patrick S.', 'Marketing', 55000),  
('Bob Ana', 'Sales', 60000);


INSERT INTO EmployeeDetails (emp_name, dept_name, salary) VALUES
('Alice Johnson', 'Marketing', 60000),
('Bob Smith', 'Sales', 55000),
('Charlie Brown', 'IT', 70000),
('David Wilson', 'HR', 50000),
('Eva Green', 'Finance', 75000),
('Frank White', 'Operations', 48000),
('Grace Lee', 'Engineering', 80000),
('Henry Adams', 'Customer Service', 45000),
('Isabella Martinez', 'Legal', 90000),
('James Taylor', 'Research', 67000),
('Katherine Scott', 'IT', 72000),
('Liam Thompson', 'Sales', 58000),
('Mia Clark', 'Marketing', 62000),
('Noah Lewis', 'Finance', 77000),
('Olivia Young', 'HR', 52000),
('Peter King', 'Operations', 50000);

SELECT * FROM EmployeeDetails;


-- 1. Maximum salary in each department.
select ed.*,
max(salary) over(PARTITION BY dept_name) as 'Maximum Salary In Department'
from employeedetails ed;

-- 2. row Number
select ed.*,
ROW_NUMBER() OVER(PARTITION BY ed.dept_name) as 'Row Number (Number of Records)'
from employeedetails ed;

-- 3. first two employees from each department will join a club

SELECT * FROM (
    select ed.*,
    ROW_NUMBER() OVER(PARTITION BY ed.dept_name ORDER BY ed.emp_name ASC) as RowNumber
    from employeedetails ed
) y WHERE y.RowNumber<3;


--4. What is the rank of each employee based on their salary within their department?

SELECT ed.*,
RANK() OVER( PARTITION BY ed.dept_name ORDER BY ed.salary DESC ) AS 'Salary Department Rank'
from employeedetails ed;

-- 5. fetch the top 3 employees in each department earning the max salary.

SELECT * FROM (
    SELECT ed.*,
    RANK() OVER(PARTITION BY ed.dept_name ORDER BY ed.salary DESC) as departmentNameSalaryRank
    FROM employeedetails ed
) y where y.departmentNameSalaryRank <4;


-- 6. What are the top 3 highest salaries across the entire table?


-- SELECT * FROM (
--     SELECT ed.*,
--     DENSE_RANK() OVER(ORDER BY ed.salary DESC) AS rankBySalary
--     FROM employeedetails ed ORDER BY ed.salary DESC
-- ) y WHERE y.rankBySalary <=3;

-- dense rank does not skip any number while ranking.

SELECT ed.*,
DENSE_RANK() OVER(ORDER BY ed.salary DESC) AS rankBySalary
FROM employeedetails ed ORDER BY ed.salary DESC


-- 7. What is the average salary within each department and how does each employee's salary compare to that average?

SELECT ed.*,
AVG(ed.salary) OVER(PARTITION BY ed.dept_name) AS DepartmentAvg,
salary- AVG(ed.salary) OVER (PARTITION BY ed.dept_name) AS Avg_Salary_Difference
 FROM employeedetails ed;


 -- What is the salary of each employee compared to the maximum salary in their department?

 SELECT *,
 MAX(salary) OVER(PARTITION BY dept_name) AS max_dept_salary,
 salary-MAX(salary) OVER(PARTITION BY dept_name) AS salary_max_dept_difference
 FROM employeedetails;

-- Find the cumulative sum of salaries for each department.

-- SELECT *,
-- SUM(salary) OVER(PARTITION BY dept_name ORDER BY dept_name ASC) AS 'Cummulative Salaries'
-- FROM employeedetails;


-- LAG AND LEAD

select e.*,
lag(e.salary) over (PARTITION BY dept_name ORDER BY emp_id) as prev_emp_salary
from employeedetails e;

-- We can specify what number  to skip and what number to replace Null.

select e.*,
lag(e.salary,1,0) over (PARTITION BY dept_name ORDER BY emp_id) as prev_emp_salary
from employeedetails e; -- even by default one record is skuipped.

-- example

select e.*,
    lag(salary) over (PARTITION BY dept_name order by emp_id ) as prev_emp_salary,
    case when e.salary >lag(salary) over (PARTITION BY dept_name) then 'Higher than previous employee'

        when e.salary <lag(salary) over (PARTITION BY dept_name) then 'Lower than previous employee'

        when e.salary = lag(salary) over (PARTITION BY dept_name) then 'Same as previous employee'
    end

from employeedetails e;

-- What is the difference in salary between each employee and the previous employee based on salary order?

select * ,
salary - lag(salary,1,0) over (PARTITION BY dept_name ORDER BY salary desc) as 'Lag Salary Difference'
from employeedetails;

-- Determine the total number of employees in each department.

SELECT   
    emp_id,  
    emp_name,  
    dept_name,  
    COUNT(*) OVER (PARTITION BY dept_name) AS total_employees_in_department  
FROM   
    EmployeeDetails;

-- Determine the highest salary for the last three employees added to the company.
SELECT *, max(salary) over () as max_salary_in_last3 from (
    select * from employeedetails ORDER BY emp_id DESC LIMIT 3) as last3;

--Which employees have salaries above the average salary of all employees?


SELECT * 
FROM EmployeeDetails 
WHERE salary > (SELECT AVG(salary) FROM EmployeeDetails);


SELECT *,
AVG(salary) OVER() AS 'AVG Salary',
CASE WHEN salary > AVG(salary) over() THEN 'Higher AVG'
else 'Below AVG'
END AS AVG_Grouping
 FROM employeedetails
