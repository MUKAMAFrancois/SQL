CREATE TABLE Employees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    Names TEXT NOT NULL,
    Profile_Pic BLOB NOT NULL,
    Salary REAL DEFAULT 0.0,
    Company TEXT NOT NULL,
    Occupation TEXT NOT NULL,
    JoinedAt TEXT NOT NULL,
    EmployeeCity TEXT NOT NULL,
    TelephoneNumber TEXT NOT NULL
);



INSERT INTO Employees (Names, Profile_Pic, 
                        Salary, Company, 
                        Occupation, JoinedAt, 
                        EmployeeCity, TelephoneNumber)
                        
VALUES ('Alice Johnson', 'pic1', 50000, 'TechCorp', 'Engineer', '2021-01-15', 'New York', '123-456-7890'),
       ('Bob Smith', 'pic2', 60000, 'HealthInc', 'Doctor', '2019-03-22', 'San Francisco', '234-567-8901'),
       ('Charlie Rose', 'pic3', 45000, 'EduWorld', 'Teacher', '2020-05-30', 'Chicago', '345-678-9012'),
       ('Daisy Green', 'pic4', 70000, 'TechCorp', 'Manager', '2018-07-18', 'New York', '456-789-0123'),
       ('Edward Brown', 'pic5', 55000, 'HealthInc', 'Nurse', '2021-09-12', 'San Francisco', '567-890-1234'),
       ('Fiona White', 'pic6', 48000, 'EduWorld', 'Administrator', '2019-11-20', 'Chicago', '678-901-2345'),
       ('George Black', 'pic7', 51000, 'TechCorp', 'Developer', '2020-08-25', 'New York', '789-012-3456'),
       ('Hannah Blue', 'pic8', 62000, 'HealthInc', 'Pharmacist', '2017-12-05', 'San Francisco', '890-123-4567'),
       ('Ian Gray', 'pic9', 47000, 'EduWorld', 'Counselor', '2018-04-14', 'Chicago', '901-234-5678'),
       ('Jill Pink', 'pic10', 75000, 'TechCorp', 'CTO', '2021-02-27', 'New York', '012-345-6789');



-- #1. AGGREGATE FUNCTIONS

-- #1.1. COUNT-------

-- count all employees

SELECT COUNT(*) AS NumberOfEmployees
FROM Employees

--Count employees in each city

SELECT COUNT(*) AS EmployeesPerCity
FROM Employees
GROUP BY EmployeeCity





-- #1.2. SUM-----
--Calculate the total salary of all employees.

SELECT SUM(Salary) AS Total_Salaries
FROM Employees

-- calculate sum of salaries in each city

SELECT EmployeeCity, SUM(Salary) AS Salaries_per_City
FROM Employees
GROUP BY EmployeeCity

-- sum of salaries per each company

SELECT Company, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Company;




--#1.3. AVG-----------
-- Calculate the average salary of all employees.
SELECT AVG(Salary) AS AverageSalary
FROM Employees;

-- Calculate the average salary for each occupation.
SELECT Occupation, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Occupation;





--#1.4. MIN , MAX
-- Find the minimum salary among all employees.
SELECT MIN(Salary) AS MinimumSalary
FROM Employees;

-- Find the minimum salary in each company.
SELECT Company, MIN(Salary) AS MinimumSalary
FROM Employees
GROUP BY Company;

-- Find the maximum salary among all employees.
SELECT MAX(Salary) AS MaximumSalary
FROM Employees;

-- Find the maximum salary in each occupation.
SELECT Occupation, MAX(Salary) AS MaximumSalary
FROM Employees
GROUP BY Occupation;





-- 2.. Filtering Groups with HAVING
-- Filter groups to only include cities with an average salary greater than 50000.
SELECT EmployeeCity, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY EmployeeCity
HAVING AVG(Salary) > 50000;

-- Cities with more than 2 Employees

SELECT EmployeeCity,
COUNT(*) AS Employees_per_city
FROM Employees
GROUP BY EmployeeCity
HAVING COUNT(*)>2;



