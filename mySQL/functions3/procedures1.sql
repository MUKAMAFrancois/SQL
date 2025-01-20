-- Active: 1737121311446@@127.0.0.1@3306@college

-- A stored procedure is a set of SQL statements that can be stored in the database and executed as needed. They help in encapsulating complex logic, improving performance, and enhancing security

create table programmers(
    id int AUTO_INCREMENT PRIMARY key,
    name VARCHAR(50),
    marks DECIMAL,
    faculity VARCHAR(100),
    check (marks>0.0 AND marks <=100.0)
);



INSERT INTO programmers (name, marks, faculity) VALUES  
('Alice Johnson', 85.50, 'Computer Science'),  
('Bob Smith', 92.75, 'Information Technology'),  
('Charlie Brown', 76.20, 'Software Engineering'),  
('Diana Prince', 88.00, 'Computer Science'),  
('Ethan Hunt', 95.00, 'Information Systems'),  
('Fiona Green', 67.80, 'Software Engineering'),  
('George Clark', 78.90, 'Computer Science'),  
('Hannah Lee', 82.40, 'Information Technology'),  
('Ivan Drago', 89.10, 'Software Engineering'),  
('Julia Roberts', 70.00, 'Information Systems'),  
('Kevin Bacon', 91.50, 'Computer Science'),  
('Laura Croft', 84.00, 'Information Technology'),  
('Mike Wazowski', 62.30, 'Software Engineering'),  
('Nina Simone', 97.50, 'Computer Science'),  
('Oscar Wilde', 75.00, 'Information Systems'),  
('Paula Patton', 88.60, 'Information Technology');


-- 1. create a procedure that returns programmers in certain faculity;

DELIMITER //
CREATE PROCEDURE GetByFaculity(IN facl VARCHAR(100)) -- INPUT parameter

BEGIN
 SELECT * FROM programmers WHERE faculity = facl;
 END//
DELIMITER;

-- CALLING procedure

CALL GetByFaculity('Software Engineering');


-- example 2: creating a procedure for updating marks of a programmer

DELIMITER//
CREATE PROCEDURE UpdateMarks(IN mk DECIMAL, IN Id INT)
BEGIN
 UPDATE programmers SET marks = mk WHERE id = id;
 END //
 DELIMITER;

 -- CALL
 call UpdateMarks(90.3,1);


 -- ERROR HANDLING IN PROCEDURES
--  You can add error handling using the DECLARE statement.


DELIMITER //

CREATE PROCEDURE SafeupdateMarks(IN mk DECIMAL, IN Id INT)
BEGIN 
DECLARE programmerExist INT;

SELECT COUNT(*) INTO programmerExist FROM programmers WHERE id = Id;

IF programmerExist > 0 THEN 
    UPDATE programmers SET marks = mk WHERE id = Id;
    ELSE 
        SELECT 'Programmer does not exist!' AS Message;
END IF;
END //
DELIMITER;

-- CALLING SAFEUPDATEMARKS, say id that doesn't exist

CALL SafeupdateMarks(78.0,100);



---- IN and OUT

DELIMITER //

CREATE PROCEDURE CalculateBonus(IN sales_amount DECIMAL(10, 2), OUT bonus DECIMAL(10, 2))
BEGIN
    IF sales_amount > 100000 THEN
        SET bonus = sales_amount * 0.1;
    ELSEIF sales_amount BETWEEN 50000 AND 100000 THEN
        SET bonus = sales_amount * 0.05;
    ELSE
        SET bonus = 0;
    END IF;
END //

DELIMITER ;


-- CALLING 
CALL CalculateBonus(120000, @bonus);
SELECT @bonus AS bonus_amount;
