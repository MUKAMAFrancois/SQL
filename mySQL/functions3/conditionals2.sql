-- Create tables for our e-commerce example
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    shipping_method VARCHAR(20),
    discount_applied DECIMAL(5,2),
    region VARCHAR(20)
);

INSERT INTO orders VALUES
    (1, 101, '2024-01-15', 150.00, 'paid', 'express', 10.00, 'North'),
    (2, 102, '2024-01-15', 65.50, 'pending', 'standard', NULL, 'South'),
    (3, 103, '2024-01-16', 230.00, 'paid', 'standard', 20.00, 'East'),
    (4, 104, '2024-01-16', 45.00, 'failed', 'express', NULL, 'West'),
    (5, 105, '2024-01-17', 550.00, 'paid', 'express', 50.00, 'North');


INSERT INTO orders VALUES  
    (6, 106, '2024-01-18', 75.00, 'paid', 'standard', NULL, 'East'),  
    (7, 107, '2024-01-19', 130.00, 'pending', 'express', 5.00, 'West'),  
    (8, 108, '2024-01-20', 320.00, 'failed', 'standard', NULL, 'North'),  
    (9, 109, '2024-01-20', 20.00, 'paid', 'express', NULL, 'South'),  
    (10, 110, '2024-01-21', 400.00, 'paid', 'mobile', 40.00, 'East'),  
    (11, 111, '2024-01-21', 85.50, 'paid', 'standard', NULL, 'West'),  
    (12, 112, '2024-01-22', 150.00, 'pending', 'express', 10.00, 'North'),  
    (13, 113, '2024-01-23', 199.99, 'failed', 'mobile', NULL, 'South'),  
    (14, 114, '2024-01-23', 320.00, 'paid', 'express', 30.00, 'East'),  
    (15, 115, '2024-01-24', 240.00, 'paid', 'standard', NULL, 'West');

SELECT * FROM orders;


-- 1. Categorize orders by the amount.

SELECT *,
CASE 
    WHEN total_amount <= 50 THEN 'Lowest'
    WHEN total_amount BETWEEN 51 AND 100 THEN 'Medium'
    ELSE 'Higher'
END AS 'Total Amount Catgory'
 FROM orders;


-- SHipping method categorization

SELECT *,
CASE shipping_method 
    WHEN 'express' THEN '1st Priority'
    WHEN 'standard' THEN '2nd Priority'
    ELSE '3rd Priority'
END AS 'Shipping Method Categorization'
FROM orders;


-- 3. IF statements (simple IF statement)

SELECT *,
IF (discount_applied IS NULL, 'No Discount', 'Discounted') as 'Discount status',
IF (total_amount <150, 'Low Amount','Higher Amount') as 'Amount Status'
FROM orders;


-- Nested IF statements

SELECT *,
IF (payment_status = 'paid',
    IF (total_amount > 200, 'Higher payment','regular payment'),
    'unpaid'
)
 FROM orders;

--4. coalsce. it handles null values

select ord.order_id,
ord.order_date,
ord.total_amount, 
ord.discount_applied,
ord.total_amount - COALESCE(ord.discount_applied,0) as final_amount

from orders ord;


-- Multiple conditions , complex logical conditions

-- -> Order status

-- A. Order status with multiple conditions
SELECT 
    order_id,
    total_amount,
    payment_status,
    CASE 
        WHEN payment_status = 'failed' THEN 'Requires Attention'
        WHEN payment_status = 'pending' AND total_amount > 100 THEN 'High Value Pending'
        WHEN payment_status = 'paid' AND shipping_method = 'express' THEN 'Priority Completed'
        WHEN payment_status = 'paid' THEN 'Regular Completed'
        ELSE 'Review Needed'
    END as order_status
FROM orders;

-- B. Shipping cost calculator.



