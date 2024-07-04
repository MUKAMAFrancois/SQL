/* Syntax */

CREATE TABLE  table_name(
    column1 data_type constraints
    column2 data_type constraints
    ....

);

--Example 1: Basic Table Creation

CREATE TABLE Students (
    StudentID INTEGER PRIMARY KEY,   -- Primary key
    FirstName TEXT NOT NULL,         -- First name cannot be null
    LastName TEXT NOT NULL,          -- Last name cannot be null
    EnrollmentDate TEXT              -- Enrollment date as a text field (ISO8601 format)
);




--Example 2: Table with Auto-Increment Primary Key

CREATE TABLE Courses (
    CourseID INTEGER PRIMARY KEY AUTOINCREMENT,  -- Auto-increment primary key
    CourseName TEXT NOT NULL,                    -- Course name cannot be null
    Credits INTEGER NOT NULL                     -- Number of credits cannot be null
);



--Example 3: Table with Foreign Key
/*
A foreign key is a column or a set of columns in one table that references 
the primary key columns in another table. It creates a link between the two tables.
*/


CREATE TABLE Registrations (
    RegistrationID INTEGER PRIMARY KEY AUTOINCREMENT,  -- Auto-increment primary key
    StudentID INTEGER NOT NULL,                        -- Foreign key referencing Students
    CourseID INTEGER NOT NULL,                         -- Foreign key referencing Courses
    RegistrationDate TEXT NOT NULL,                    -- Registration date as text
    FOREIGN KEY (StudentID) REFERENCES Students (StudentID),  -- Define foreign key
    FOREIGN KEY (CourseID) REFERENCES Courses (CourseID)      -- Define foreign key
);


