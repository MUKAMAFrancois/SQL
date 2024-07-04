
-- 1. INSERT; 29th June 2024



-- syntax:

INSERT INTO Table_name(column1, column2,...)
VALUES (value1,value2,...);

-- example1:

CREATE TABLE Students(
    studentID INTEGER PRIMARY KEY AUTOINCREMENT,
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    marks REAL DEFAULT 0.0,
    Age INTEGER NOT NULL

);

INSERT INTO Students(firstName,lastName,marks,Age) -- studnetID will be auto generated!
VALUES ('John','Peter',89.6,17),
        ('Ivy','Violette',90.8,18),
        ('Isabelle','Tasha',99.2,16),
        ('Eric','Tonny',93.3,20);




--2. QUERRYING DATA


-- get all : SELECT * FROM Students;

-- syntax:
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-- ex2:

SELECT 
firstName,lastName
FROM Students
WHERE marks>=90.0;

-- ex3: MULTIPLE CONDITIONS
SELECT 
firstName, lastName
FROM Students
WHERE marks>90.0 AND Age>18;





--3. UPDATE

-- syntax:
UPDATE Table_Name
SET column1 = value1, column2=value2,..
WHERE condition;

--ex4:

UPDATE Students
SET lastName='Violetta'
WHERE firstName='Ivy';





-- 4. Deleting Data (DELETE)

--syntax:

DELETE FROM Table_Name
WHERE condition;

--ex5:
DELETE FROM Students
WHERE firstName='John' AND lastName='Peter';








--5. Sorting Results with ORDER BY

-- SYNTAX

SELECT column1, column2, ...
FROM table_name
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;

-- ex6:
SELECT *
FROM Students
ORDER BY marks DESC;


--The LIMIT clause is used to specify the number of records to return.
-- SYNTAX
SELECT column1, column2, ...
FROM table_name
LIMIT number_of_records OFFSET offset_value;

--ex7: Retrieve first 3 students
SELECT firstName, lastName, marks
FROM Students
LIMIT 3;

-- ex8: Retrieve first 5 students in marks starting to count from 10th value ( offset is 9)

SELECT firstName, lastName, marks
FROM Students
ORDER BY marks
LIMIT 5 OFFSET 9


