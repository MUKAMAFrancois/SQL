## Lecture: Aggregate Functions in PostgreSQL

### 1. Introduction to Aggregate Functions

Aggregate functions perform a calculation on a set of values and return a single value. They are commonly used with the `GROUP BY` clause to perform operations on groups of data.

### 2. Types of Aggregate Functions

#### `COUNT()`

The `COUNT()` function returns the number of input rows that match a specific condition.

- **Syntax:**
  ```sql
  SELECT COUNT(column_name)
  FROM table_name
  WHERE condition;
  ```

- **Example:**
  ```sql
  SELECT COUNT(*) AS total_orders
  FROM orders;
  ```

  - **Explanation:**
    - This query returns the total number of orders in the `orders` table.

#### `SUM()`

The `SUM()` function returns the total sum of a numeric column.

- **Syntax:**
  ```sql
  SELECT SUM(column_name)
  FROM table_name
  WHERE condition;
  ```

- **Example:**
  ```sql
  SELECT SUM(order_amount) AS total_sales
  FROM orders;
  ```

  - **Explanation:**
    - This query returns the total sales amount from the `orders` table.

#### `AVG()`

The `AVG()` function returns the average value of a numeric column.

- **Syntax:**
  ```sql
  SELECT AVG(column_name)
  FROM table_name
  WHERE condition;
  ```

- **Example:**
  ```sql
  SELECT AVG(order_amount) AS average_order
  FROM orders;
  ```

  - **Explanation:**
    - This query returns the average order amount from the `orders` table.

#### `MIN()`

The `MIN()` function returns the smallest value of a numeric column.

- **Syntax:**
  ```sql
  SELECT MIN(column_name)
  FROM table_name
  WHERE condition;
  ```

- **Example:**
  ```sql
  SELECT MIN(order_amount) AS smallest_order
  FROM orders;
  ```

  - **Explanation:**
    - This query returns the smallest order amount from the `orders` table.

#### `MAX()`

The `MAX()` function returns the largest value of a numeric column.

- **Syntax:**
  ```sql
  SELECT MAX(column_name)
  FROM table_name
  WHERE condition;
  ```

- **Example:**
  ```sql
  SELECT MAX(order_amount) AS largest_order
  FROM orders;
  ```

  - **Explanation:**
    - This query returns the largest order amount from the `orders` table.

### Real-World Example: Managing Order Data

Lets consider the `orders` table from the previous example to demonstrate the use of aggregate functions.

1. **Create Table:**

   ```sql
   CREATE TABLE orders (
       id SERIAL PRIMARY KEY,
       customer_name VARCHAR(100) NOT NULL,
       order_amount NUMERIC(10, 2) NOT NULL,
       discount NUMERIC(5, 2)
   );
   ```

2. **Insert Sample Data:**

   ```sql
   INSERT INTO orders (customer_name, order_amount, discount) VALUES 
   ('Alice', 150.00, 10.00),
   ('Bob', 200.00, NULL),
   ('Charlie', 300.00, 15.00),
   ('David', 50.00, 5.00),
   ('Eve', 400.00, 20.00);
   ```

3. **Calculate Total Sales:**

   ```sql
   SELECT SUM(order_amount) AS total_sales
   FROM orders;
   ```

   - **Explanation:**
     - This query calculates the total sales amount from all orders.

4. **Count Total Orders:**

   ```sql
   SELECT COUNT(*) AS total_orders
   FROM orders;
   ```

   - **Explanation:**
     - This query returns the total number of orders in the `orders` table.

5. **Find the Average Order Amount:**

   ```sql
   SELECT AVG(order_amount) AS average_order
   FROM orders;
   ```

   - **Explanation:**
     - This query calculates the average order amount from the `orders` table.

6. **Find the Smallest Order Amount:**

   ```sql
   SELECT MIN(order_amount) AS smallest_order
   FROM orders;
   ```

   - **Explanation:**
     - This query returns the smallest order amount from the `orders` table.

7. **Find the Largest Order Amount:**

   ```sql
   SELECT MAX(order_amount) AS largest_order
   FROM orders;
   ```

   - **Explanation:**
     - This query returns the largest order amount from the `orders` table.

### Using Aggregate Functions with `GROUP BY`

The `GROUP BY` clause groups rows that have the same values into summary rows, such as "find the number of customers in each country". 

- **Syntax:**
  ```sql
  SELECT column_name, aggregate_function(column_name)
  FROM table_name
  WHERE condition
  GROUP BY column_name;
  ```

- **Example:**
  ```sql
  SELECT customer_name, SUM(order_amount) AS total_spent
  FROM orders
  GROUP BY customer_name;
  ```

  - **Explanation:**
    - This query groups the orders by customer name and calculates the total amount spent by each customer.

### Real-World Example with `GROUP BY`

Let's consider the same `orders` table to demonstrate the use of aggregate functions with the `GROUP BY` clause.

1. **Calculate Total Sales by Customer:**

   ```sql
   SELECT customer_name, SUM(order_amount) AS total_spent
   FROM orders
   GROUP BY customer_name;
   ```

   - **Explanation:**
     - This query groups the orders by customer name and calculates the total amount spent by each customer.

2. **Count Orders by Customer:**

   ```sql
   SELECT customer_name, COUNT(*) AS order_count
   FROM orders
   GROUP BY customer_name;
   ```

   - **Explanation:**
     - This query groups the orders by customer name and counts the number of orders placed by each customer.

3. **Find the Average Order Amount by Customer:**

   ```sql
   SELECT customer_name, AVG(order_amount) AS average_order
   FROM orders
   GROUP BY customer_name;
   ```

   - **Explanation:**
     - This query groups the orders by customer name and calculates the average order amount for each customer.

