-- Average mark on each department
-- a) Ranking Functions

-- ROW_NUMBER(): Assigns a unique number to each row.
-- RANK(): Assigns a rank with gaps.
-- DENSE_RANK(): Assigns a rank without gaps.!!!!!!!!!!!

SELECT 
*,
CAST(AVG(marks)OVER (PARTITION BY department) AS DECIMAL(10,2)) AS avg_mark,-- Average mark on each department
RANK() OVER(PARTITION BY department ORDER BY marks DESC) AS ranking_in_dpt,
RANK() OVER(ORDER BY marks DESC) AS overall_ranking
FROM students;

-- [2]

select *,
row_number() OVER (ORDER BY marks DESC) as row_num
from students;


select *,
row_number() OVER (PARTITION BY department ORDER BY marks DESC) as row_num
from students;

-- Let's get the best two students from each department.


SELECT * FROM (
 SELECT *,
 DENSE_RANK() OVER(PARTITION BY department ORDER BY marks DESC) as dprnk
 FROM students)
 WHERE dprnk<3;


-- b) Offset Functions

-- LAG(): Accesses data from a previous row in the result set.
-- LEAD(): Accesses data from a subsequent row in the result set.

SELECT 
    date,
    stock_symbol,
    closing_price,
    LAG(closing_price) OVER (PARTITION BY stock_symbol ORDER BY date) AS previous_day_price,
    LEAD(closing_price) OVER (PARTITION BY stock_symbol ORDER BY date) AS next_day_price
FROM stock_prices;



-- c) Aggregate Window Functions
-- These are similar to regular aggregate functions but operate over a window.

-- SUM()
-- AVG()
-- COUNT()
-- MAX()
-- MIN()

SELECT 
    sale_date,
    salesperson,
    sale_amount,
    SUM(sale_amount) OVER (PARTITION BY salesperson ORDER BY sale_date) AS running_total,
    AVG(sale_amount) OVER (PARTITION BY salesperson ORDER BY sale_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS weekly_average
FROM sales;


-- d) Distribution Functions

-- PERCENT_RANK(): Calculates the relative rank of the current row.
-- CUME_DIST(): Calculates the cumulative distribution of a value.

SELECT 
    employee_name,
    department,
    salary,
    PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) AS salary_percent_rank,
    CUME_DIST() OVER (PARTITION BY department ORDER BY salary) AS salary_cume_dist
FROM employees;



SELECT *,

CAST(CUME_DIST() OVER(PARTITION BY department ORDER BY marks) AS DECIMAL(10,2)) AS cum_dist
FROM students;

-- e) First_value and Last_value
-- These functions return the first and last value in an ordered set of values.


SELECT 
    customer_id,
    purchase_date,
    purchase_amount,
    FIRST_VALUE(purchase_amount) OVER (PARTITION BY customer_id ORDER BY purchase_date) AS first_purchase_amount,
    LAST_VALUE(purchase_amount) OVER (PARTITION BY customer_id ORDER BY purchase_date 
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_purchase_amount
FROM purchases;


-- Frame Clause

-- The frame clause defines the set of rows constituting the window frame. Common options include:

-- ROWS BETWEEN n PRECEDING AND CURRENT ROW
-- ROWS BETWEEN CURRENT ROW AND n FOLLOWING
-- RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW


SELECT 
    visit_date,
    page_views,
    AVG(page_views) OVER (ORDER BY visit_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS weekly_moving_average,
    AVG(page_views) OVER (ORDER BY visit_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS monthly_moving_average
FROM website_traffic;