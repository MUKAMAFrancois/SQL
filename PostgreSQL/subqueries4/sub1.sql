Certainly. Subquery expressions are powerful tools in SQL that allow you to nest one query within another. 
The main types of subquery expressions in PostgreSQL are EXISTS, IN, ANY, SOME, and ALL. Lets dive into each with real-world examples.

1. EXISTS

The EXISTS subquery is used to check whether any rows are returned by the subquery.

-- Example scenario: Lets say we have an e-commerce database with 'customers' and 'orders' tables. We want to find customers who have placed at least one order.


CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

-- Insert some sample data
INSERT INTO customers (name, email) VALUES 
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Bob Johnson', 'bob@example.com');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES 
(1, '2023-01-15', 100.00),
(1, '2023-02-20', 150.00),
(2, '2023-03-10', 200.00);

-- Query to find customers who have placed at least one order
SELECT name, email
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id
);


This query will return John and Jane, but not Bob, as he hasnt placed any orders.

2. IN

The IN subquery is used to check whether a value matches any value in a list returned by a subquery.

Example: Find all orders placed by customers from a specific city.


-- Add city to customers table
ALTER TABLE customers ADD COLUMN city VARCHAR(50);
UPDATE customers SET city = 'New York' WHERE customer_id IN (1, 2);
UPDATE customers SET city = 'Los Angeles' WHERE customer_id = 3;

-- Query to find orders from customers in New York
SELECT o.order_id, o.order_date, o.total_amount
FROM orders o
WHERE o.customer_id IN (
    SELECT customer_id 
    FROM customers 
    WHERE city = 'New York'
);


-- This query will return all orders placed by John and Jane, who are from New York.

3. ANY / SOME

ANY and SOME are synonyms in PostgreSQL. They are used to compare a value to a set of values returned by a subquery.

Example: Find customers who have placed an order larger than the average order amount.


SELECT name, email
FROM customers c
WHERE c.customer_id = ANY (
    SELECT customer_id
    FROM orders
    WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
);


This query will return customers who have at least one order above the average order amount.

4. ALL

-- ALL is used to compare a value with every value returned by a subquery.
-- Example: Find customers whose all orders are larger than the average order amount.


SELECT name, email
FROM customers c
WHERE c.customer_id = ALL (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING MIN(total_amount) > (SELECT AVG(total_amount) FROM orders)
);


This query will return customers only if all of their orders are above the average order amount.

5. Scalar Subquery

-- A scalar subquery returns a single value and can be used in a SELECT clause.
-- Example: Show each order with the customers name and the difference from the average order amount.


SELECT 
    o.order_id,
    c.name AS customer_name,
    o.total_amount,
    o.total_amount - (SELECT AVG(total_amount) FROM orders) AS diff_from_avg
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id;


-- This query uses a scalar subquery to calculate the difference between each order's amount and the overall average order amount.

