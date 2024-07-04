-- Arithmetic operators:
-- +,-,*,/,%, <>:NOT EQUAL

-- Logical Operators: AND,OR,NOT,IN,BETWEEN,LIKE


-- where the average of total is in range of 3.4 to 5.6
SELECT * 
 FROM Invoice
WHERE AVG(total) BETWEEN 3.4 AND 5.6
 ORDER BY invoiceDate;


-- where the billingCity is either one of specified values.
SELECT * 
 FROM Invoice
WHERE billingCity IN ('Atlanta','Brussels','Paris')
 ORDER BY invoiceDate;

-- where cities starts with 'D'

SELECT * 
 FROM Invoice
WHERE billingCity LIKE 'D%'
 ORDER BY invoiceDate;


-- where cities that have D in their names

SELECT * 
 FROM Invoice
WHERE billingCity LIKE '%D%'
 ORDER BY invoiceDate;

-- where cities ends with 'D'

SELECT * 
 FROM Invoice
WHERE billingCity LIKE '%D'
 ORDER BY invoiceDate;


-- how many invoices were billed on May 22,2012

SELECT * 
 FROM Invoice
WHERE DATE(invoiceDate)='2012-05-22'

-- invoices billed after June 12,2011 with total less than 5.9


SELECT * 
 FROM Invoice
WHERE DATE(invoiceDate)>'2011-06-12' AND  total<5.9
ORDER BY invoiceDate;

-- !!!!!!!  Remember order of the operators: PEMDAS : Parantheses, Exponent, Mult,Division,Add,Substract.






------IF THEN LOGIC WITH CASE--------------------

-- SYNtax
SELECT CASE
           WHEN condition1 THEN result1
           WHEN condition2 THEN result2
           ...
           ELSE resultN
       END AS column_name
FROM table_name;


-- Sales categories

select 
 invoiceDate,
 billingAdress,
 billingCity,
 total,
 CASE
  WHEN total<2.0 THEN 'Baseline'
  WHEN total BETWEEN 2.0 and 5.0 THEN 'Low Price'
  WHEN total BETWEEN 5.1 AND 10.0 THEN 'Good Price',
  ELSE 'Top performers'
  END AS PurchaseCategory -- temporal column
from Invoice
--  where PurchaseCategory='Top Performers'
 ORDER BY invoiceDate;




-- NOTE THAT CASES CAN BE NESTED! LOOK AT THIS EXAMPLE

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

INSERT INTO Employees (Names, Profile_Pic, Salary, Company, Occupation, JoinedAt, EmployeeCity, TelephoneNumber)
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



-- nested cases: Classify employees based on their company and occupation

SELECT Names,
       Company,
       Occupation,
       CASE
           WHEN Company = 'TechCorp' THEN
               CASE
                   WHEN Occupation = 'Engineer' THEN 'Tech Engineer'
                   WHEN Occupation = 'Manager' THEN 'Tech Manager'
                   ELSE 'Tech Staff'
               END
           WHEN Company = 'HealthInc' THEN 'Healthcare Professional'
           WHEN Company = 'EduWorld' THEN 'Education Staff'
           ELSE 'Other'
       END AS JobClassification
FROM Employees;


-- CASE Statement with Aggregate Functions
-- Calculate the total salary paid to "TechCorp" employees and classify the total amount.
SELECT Company,
       SUM(Salary) AS TotalSalary,
       CASE
           WHEN SUM(Salary) < 200000 THEN 'Low Budget'
           WHEN SUM(Salary) BETWEEN 200000 AND 400000 THEN 'Medium Budget'
           ELSE 'High Budget'
       END AS BudgetLevel
FROM Employees
WHERE Company = 'TechCorp';


--Example 3: CASE Statement in WHERE Clause
-- Select employees who are either from "TechCorp" with a high salary or from "EduWorld".

SELECT Names, Company, Salary
FROM Employees
WHERE (CASE
           WHEN Company = 'TechCorp' AND Salary > 60000 THEN 1
           WHEN Company = 'EduWorld' THEN 1
           ELSE 0
       END) = 1;









