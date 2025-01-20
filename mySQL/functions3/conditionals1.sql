-- 1. CASE Statement =========================

-- The CASE statement is a conditional expression that allows you to implement if-else-like logic in SQL. It’s typically used in SELECT, WHERE, and ORDER BY clauses.


-- Syntax
CASE 
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE default_result
END

------------------------
SELECT 
    Name,
    Salary,
    CASE
        WHEN Salary > 50000 THEN 'High'
        WHEN Salary BETWEEN 30000 AND 50000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees;

-- 2. IF STATEMENT : A procedural construct used within stored programs (e.g., stored procedures or functions).

IF condition THEN
    statements;
[ELSEIF condition THEN
    statements;]
[ELSE
    statements;]
END IF;



-- A stored procedure is a function that is kept in database and used for later.

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


-- calling
CALL CalculateBonus(120000, @bonus);
SELECT @bonus AS bonus_amount;



-- IF function() : A shorthand function for conditional expressions in SELECT queries.

IF(condition, value_if_true, value_if_false)

-- Classifying products as Expensive or Affordable based on price.
SELECT 
    product_id,
    name,
    price,
    IF(price > 50, 'Expensive', 'Affordable') AS price_category
FROM products;


