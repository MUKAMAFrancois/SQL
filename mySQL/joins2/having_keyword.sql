-- Important Points about HAVING:

-- HAVING works only with GROUP BY
-- HAVING filters groups, not individual rows
-- HAVING can use aggregate functions (COUNT, SUM, AVG, etc.)
-- HAVING is processed after GROUP BY, WHERE is processed before
-- You can combine WHERE and HAVING in the same query



-- The key difference first:

-- WHERE filters individual rows before grouping
-- HAVING filters groups after GROUP BY aggregation

-- Create a sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    sale_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    seller_id INT,
    region VARCHAR(30)
);

-- Insert sample data
INSERT INTO sales VALUES
    (1, 'Laptop Pro', 'Electronics', '2024-01-01', 2, 1200.00, 1, 'North'),
    (2, 'Gaming Mouse', 'Electronics', '2024-01-01', 5, 50.00, 1, 'North'),
    (3, 'Office Chair', 'Furniture', '2024-01-02', 3, 200.00, 2, 'South'),
    (4, 'Laptop Pro', 'Electronics', '2024-01-02', 1, 1200.00, 3, 'East'),
    (5, 'Desk Lamp', 'Furniture', '2024-01-03', 4, 40.00, 2, 'South'),
    (6, 'Gaming Mouse', 'Electronics', '2024-01-03', 2, 50.00, 1, 'North'),
    (7, 'Laptop Pro', 'Electronics', '2024-01-04', 3, 1200.00, 3, 'East'),
    (8, 'Office Chair', 'Furniture', '2024-01-04', 2, 200.00, 2, 'South');

select * from sales;

---- 1.Find Products with Total Sales Above Threshold:

SELECT 
    product_name,
    COUNT(*) as times_sold,
    SUM(quantity) as total_units,
    SUM(quantity * unit_price) as total_revenue
FROM sales
GROUP BY product_name


---------=================\

SELECT 
    product_name,
    COUNT(*) as times_sold,
    SUM(quantity) as total_units,
    SUM(quantity * unit_price) as total_revenue
FROM sales
GROUP BY product_name
HAVING total_revenue > 5000;


-- 2. Find High-Performance Sellers:

SELECT 
    seller_id,
    COUNT(DISTINCT product_name) as products_sold,
    SUM(quantity * unit_price) as total_sales
FROM sales
GROUP BY seller_id
HAVING products_sold >= 2      -- Sellers who sell at least 2 different products
AND total_sales > 2000;       -- AND have sales over $2000



-- 3. Identify Popular Categories by Region
SELECT 
    region,
    category,
    COUNT(*) as transaction_count,
    SUM(quantity) as units_sold
FROM sales
GROUP BY region, category
HAVING units_sold > 5          -- Only regions/categories with more than 5 units sold
ORDER BY units_sold DESC;


-- 4. Compare with WHERE

-- Using WHERE and HAVING together
SELECT 
    category,
    COUNT(*) as sale_count,
    AVG(quantity * unit_price) as avg_transaction
FROM sales
WHERE sale_date >= '2024-01-02'    -- Filter individual rows first
GROUP BY category
HAVING avg_transaction > 500       -- Then filter the groups
ORDER BY avg_transaction DESC;

-- 5. Find Products with Consistent Sales

SELECT 
    product_name,
    COUNT(DISTINCT sale_date) as days_with_sales,
    AVG(quantity) as avg_daily_quantity
FROM sales
GROUP BY product_name
HAVING days_with_sales >= 2        -- Products sold on at least 2 different days
AND avg_daily_quantity > 1;        -- With average daily quantity > 1


-- 6. Regional Performance Analysis:

SELECT 
    region,
    COUNT(DISTINCT product_name) as unique_products,
    COUNT(*) as total_transactions,
    SUM(quantity * unit_price) as total_revenue
FROM sales
GROUP BY region
HAVING unique_products >= 2        -- Regions selling at least 2 unique products
AND total_transactions >= 3        -- With at least 3 transactions
AND total_revenue > 2000;         -- And revenue over $2000

select * from sales;
