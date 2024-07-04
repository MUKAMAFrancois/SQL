-- Joins are used to combine rows from two or more tables 
-- based on a related column between them. They are essential for querying data from multiple tables in a relational database.



-- 1. Inner Join
-- An inner join returns rows that have matching values in both tables.

SELECT columns
FROM table1
INNER JOIN table2
ON table1.column = table2.column;




-- 2.Left Join (Left Outer Join)
-- A left join returns all rows from the left table and the matched rows from the right table. 
-- If no match is found, NULL values are returned for columns from the right table.

SELECT columns
FROM table1
LEFT JOIN table2
ON table1.column = table2.column;






-- 3.Right Join (Right Outer Join)
-- A right join returns all rows from the right table and the matched rows from the left table.
--  If no match is found, NULL values are returned for columns from the left table.

SELECT columns
FROM table1
RIGHT JOIN table2
ON table1.column = table2.column;






-- 4. Full Outer Join
-- A full outer join returns all rows when there is a match in either left or right table. 
-- Rows without a match in one of the tables will contain NULL values for columns from that table.

SELECT columns
FROM table1
FULL OUTER JOIN table2
ON table1.column = table2.column;



-- 5. Cross Join
-- A cross join returns the Cartesian product of the two tables,
--  meaning it returns all possible combinations of rows.

/*



A CROSS JOIN, also known as a Cartesian product,
is a type of join operation that produces a result set which combines each row
from the first table with each row from the second table. 
In other words, it creates all possible combinations of rows from both tables.

Role of CROSS JOIN:

Generating combinations: It's useful when you need to create all possible pairings between two sets of data.
Creating test data: It can be used to quickly generate a large amount of sample data.
Solving certain types of problems: In some scenarios, you might need all combinations to perform calculations or analysis.
Creating a numbers or date table: It can be used to generate a series of numbers or dates.

However, it's important to use CROSS JOIN carefully, as the result set can become very large very quickly. For example, if you CROSS JOIN a table with 1,000 rows to another table with 1,000 rows, the result will have 1,000,000 rows.

*/

SELECT columns
FROM table1
CROSS JOIN table2;


SELECT employees.first_name, employees.last_name, departments.name AS department
FROM employees
CROSS JOIN departments;

-- Explanation:

-- This query pairs every employee with every department, resulting in a combination of every employee and every department.



SELECT a.columns, b.columns
FROM table a
INNER JOIN table b
ON a.column = b.column;







-- 6.Self Join
-- A self join is a regular join but the table is joined with itself.

-- ex:

SELECT e1.first_name AS employee, e2.first_name AS manager
FROM employees e1
INNER JOIN employees e2 ON e1.manager_id = e2.id;
