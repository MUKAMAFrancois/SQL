/*
 Let's consider a scenario where we have an employees table in a company database.
This table contains information about employees, 
including their ID, name, and their manager's ID (which is also an employee ID).

*/

CREATE TABLE Company(
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(50),
    company_location VARCHAR(30)
);

CREATE TABLE Employees(
    emp_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    company_id INT NOT NULL,
    manager_id INT,
    FOREIGN KEY (company_id) REFERENCES Company(company_id)
)





-- Sample data for the Company table
INSERT INTO Company (company_name, company_location) VALUES
    ('Apple Inc.', 'Cupertino, CA'),
    ('Microsoft Corporation', 'Redmond, WA'),
    ('Amazon.com, Inc.', 'Seattle, WA'),
    ('Google LLC', 'Mountain View, CA'),
    ('Facebook, Inc.', 'Menlo Park, CA'),
    ('IBM Corporation', 'Armonk, NY'),
    ('Walmart Inc.', 'Bentonville, AR'),
    ('Exxon Mobil Corporation', 'Irving, TX'),
    ('The Coca-Cola Company', 'Atlanta, GA'),
    ('General Electric Company', 'Boston, MA');


INSERT INTO Employees (emp_id, first_name, last_name, company_id, manager_id) VALUES
    (101, 'John', 'Doe', 1, 105),
    (102, 'Jane', 'Smith', 1, 105),
    (103, 'Michael', 'Johnson', 2, 107),
    (104, 'Emily', 'Brown', 2, 107),
    (105, 'David', 'Lee', 1, NULL),
    (106, 'Sarah', 'Davis', 3, 109),
    (107, 'Christopher', 'Wilson', 2, NULL),
    (108, 'Jessica', 'Taylor', 3, 109),
    (109, 'Mark', 'Anderson', 3, NULL),
    (110, 'Olivia', 'Thompson', 4, 105);




SELECT 
    emp.first_name|| ' ' || emp.last_name AS "Employer Names",
    manager.first_name|| ' '|| manager.last_name AS "Manager"
FROM employees AS emp
 INNER JOIN employees AS manager
    ON emp.emp_id=manager.manager_id;