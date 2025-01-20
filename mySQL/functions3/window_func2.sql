-- Create sample employee data
CREATE TABLE workers (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    manager_id INT,
    performance_score DECIMAL(3,2)
);

INSERT INTO workers VALUES
    (1, 'John Doe', 'IT', 75000, '2022-01-15', 5, 8.5),
    (2, 'Jane Smith', 'HR', 65000, '2022-02-01', 5, 9.0),
    (3, 'Bob Wilson', 'IT', 72000, '2022-03-15', 5, 7.5),
    (4, 'Alice Brown', 'Finance', 70000, '2022-04-01', 6, 8.0),
    (5, 'Mike Johnson', 'IT', 95000, '2021-06-01', NULL, 9.5),
    (6, 'Sarah Davis', 'Finance', 92000, '2021-07-15', NULL, 9.0),
    (7, 'Tom Harris', 'HR', 63000, '2022-08-01', 2, 7.8),
    (8, 'Lisa Anderson', 'IT', 71000, '2022-09-15', 5, 8.2),
    (9, 'James Wilson', 'Finance', 69000, '2022-10-01', 6, 8.7),
    (10, 'Emma Davis', 'HR', 67000, '2022-11-15', 2, 8.9);

select * from workers;


-- RANKING FUNCTIONS

-- RANK, DENSE_RANK, ROW_NUMBER
SELECT 
    emp_name,
    department,
    salary,
    RANK() OVER (ORDER BY salary DESC) as salary_rank,
    DENSE_RANK() OVER (ORDER BY salary DESC) as dense_salary_rank,
    ROW_NUMBER() OVER (ORDER BY salary DESC) as salary_row_num
FROM workers;

-- Ranking within departments
SELECT 
    emp_name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) as dept_salary_rank,
    RANK() OVER (ORDER BY salary DESC) as overall_salary_rank
FROM workers;


-- NTILE Function (Distribution):


-- Divide employees into quartiles by salary
SELECT 
    emp_name,
    salary,
    NTILE(4) OVER (ORDER BY salary DESC) as salary_quartile
FROM workers;

-- Divide into thirds by performance within department
SELECT 
    emp_name,
    department,
    performance_score,
    NTILE(3) OVER (
        PARTITION BY department 
        ORDER BY performance_score DESC
    ) as performance_tertile
FROM workers;


-- Aggregate Window Functions:

-- Running totals and averages
SELECT 
    emp_name,
    department,
    salary,
    SUM(salary) OVER (
        PARTITION BY department 
        ORDER BY hire_date
    ) as running_dept_salary_total,
    AVG(salary) OVER (
        PARTITION BY department 
        ORDER BY hire_date
    ) as running_dept_salary_avg
FROM workers;


-- Moving Average

-- Moving averages
SELECT 
    emp_name,
    hire_date,
    performance_score,
    AVG(performance_score) OVER (
        ORDER BY hire_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as moving_avg_score
FROM workers;


-- FIRST_VALUE, LAST_VALUE

SELECT *,
FIRST_VALUE(salary) OVER(ORDER BY salary DESC) AS HighestSalary,
salary- FIRST_VALUE(salary) OVER (ORDER BY salary DESC) AS SalaryDiffWithHighPay
FROM workers ORDER BY SalaryDiffWithHighPay;


-- salary gap in department

SELECT 
    emp_name,
    department,
    salary,
    FIRST_VALUE(salary) OVER (
        PARTITION BY department 
        ORDER BY salary DESC
    ) as highest_dept_salary,
    FIRST_VALUE(salary) OVER (
        PARTITION BY department 
        ORDER BY salary DESC
    ) - salary as salary_gap
FROM workers;

