-- Create the sales_data table
CREATE TABLE sales_data (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    sale_amount DECIMAL(10,2),
    sale_date DATE,
    region VARCHAR(50)
);

-- Insert sample data
INSERT INTO sales_data VALUES
(1, 'John Smith', 'Electronics', 1500.00, '2024-01-15', 'North'),
(2, 'Mary Johnson', 'Clothing', 2300.50, '2024-01-15', 'South'),
(3, 'Bob Wilson', 'Electronics', 1800.75, '2024-01-16', 'East'),
(4, 'Sarah Brown', 'Home Goods', 950.25, '2024-01-16', 'West'),
(5, 'Mike Davis', 'Clothing', 3200.00, '2024-01-17', 'North'),
(1, 'John Smith', 'Electronics', 2100.00, '2024-01-17', 'North'),
(2, 'Mary Johnson', 'Clothing', 1700.50, '2024-01-18', 'South'),
(3, 'Bob Wilson', 'Electronics', 2900.75, '2024-01-18', 'East'),
(4, 'Sarah Brown', 'Home Goods', 1150.25, '2024-01-19', 'West'),
(5, 'Mike Davis', 'Clothing', 2800.00, '2024-01-19', 'North'),
(6, 'Lisa Chen', 'Electronics', 1600.00, '2024-01-20', 'East'),
(7, 'Tom Harris', 'Home Goods', 2200.50, '2024-01-20', 'South'),
(8, 'Emma White', 'Clothing', 1900.75, '2024-01-21', 'West'),
(9, 'James Lee', 'Electronics', 2700.25, '2024-01-21', 'North'),
(10, 'Amy Garcia', 'Home Goods', 1800.00, '2024-01-21', 'South');


-- Questions:

/*
1. Find departments that have a total sales amount greater than $5000.
2. Show the regions that have more than 3 sales transactions.
3. List employees who have made multiple sales with an average sale amount exceeding $2000.
4. Find departments that have at least 2 employees with individual sales above $2500.
5. Show the sale dates where the total daily sales exceed $4000, and display the number of transactions for those days.

*/


-- 1. Find departments that have a total sales amount greater than $5000.

select  
department,
SUM(sale_amount) AS Department_Total_Sales
from sales_data
group by department
having Department_Total_Sales >5000;

-- 2. Show the regions that have more than 3 sales transactions.

select 
region,
count(*) AS sales_counts
from sales_data
group by region
having sales_counts >3;


-- 3. List employees who have made multiple sales with an average sale amount exceeding $2000.

select 
emp_name,
count(sale_date) AS sale_counts,
round(avg(sale_amount),2) AS Avg_Sales_Amount
from sales_data
group by emp_name
having Avg_Sales_Amount > 2000 and sale_counts>1;


-- 4. Find departments that have at least 2 employees with individual sales above $2500.
SELECT
department,
COUNT(DISTINCT emp_id) AS EmployeesCount
FROM sales_data
WHERE sale_amount > 2500
GROUP BY department
HAVING EmployeesCount >= 2;

-- 5. Show the sale dates where the total daily sales exceed $4000, and display the number of transactions for those days.

select 
sale_date,
sum(sale_amount) As DailySales,
count(sale_amount) AS NumberTransactions
from sales_data
group by sale_date
having DailySales >4000;