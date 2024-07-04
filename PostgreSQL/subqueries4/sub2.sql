## Lecture: Subquery Expressions in PostgreSQL

### 1. Introduction to Subqueries

A subquery is a query nested inside another query. Subqueries can be used in various ways, such as in the `SELECT` list, `WHERE` clause, `FROM` clause, etc. They help to break down complex queries and make them easier to understand and manage.

### 2. Types of Subqueries

#### Scalar Subqueries

A scalar subquery returns a single value (one row, one column). It is often used in the `SELECT` list or `WHERE` clause.

- **Syntax:**
  ```sql
  SELECT column_name, (SELECT scalar_column FROM another_table WHERE condition) AS scalar_value
  FROM table_name;
  ```

- **Example:**
  ```sql
  SELECT id, name, 
         (SELECT AVG(order_amount) 
          FROM orders 
          WHERE orders.customer_id = customers.id) AS average_order
  FROM customers;
  ```

  - **Explanation:**
    - This query retrieves the customer ID, name, and their average order amount from the `orders` table.

#### Column Subqueries

A column subquery returns a single column of data, which can be used in the `IN` or `NOT IN` clause.

- **Syntax:**
  ```sql
  SELECT column_name
  FROM table_name
  WHERE column_name IN (SELECT column_name FROM another_table WHERE condition);
  ```

- **Example:**
  ```sql
  SELECT name 
  FROM customers
  WHERE id IN (SELECT DISTINCT customer_id 
               FROM orders 
               WHERE order_amount > 100);
  ```

  - **Explanation:**
    - This query retrieves the names of customers who have placed orders with amounts greater than 100.

#### Row Subqueries

A row subquery returns a single row of data (multiple columns), which can be used with row comparison operators like `=`, `<`, `>`, etc.

- **Syntax:**
  ```sql
  SELECT column_name
  FROM table_name
  WHERE (column1, column2) = (SELECT column1, column2 FROM another_table WHERE condition);
  ```

- **Example:**
  ```sql
  SELECT id, name
  FROM customers
  WHERE (id, name) = (SELECT customer_id, customer_name 
                      FROM special_customers 
                      WHERE special_condition);
  ```

  - **Explanation:**
    - This query retrieves customers that match the specific condition in the `special_customers` table.

#### Table Subqueries

A table subquery returns a set of rows and columns and is often used in the `FROM` clause.

- **Syntax:**
  ```sql
  SELECT column_name
  FROM (SELECT column_name FROM another_table WHERE condition) AS subquery_alias;
  ```

- **Example:**
  ```sql
  SELECT sub.id, sub.name, sub.total_orders
  FROM (SELECT customer_id AS id, customer_name AS name, COUNT(*) AS total_orders 
        FROM orders 
        GROUP BY customer_id, customer_name) AS sub;
  ```

  - **Explanation:**
    - This query retrieves customer information and their total number of orders from a subquery.

### Real-World Example: Managing E-commerce Data

Lets consider a scenario with three tables: `customers`, `orders`, and `order_items` to demonstrate the use of subqueries.

1. **Create Tables:**

   ```sql
   CREATE TABLE customers (
       id SERIAL PRIMARY KEY,
       name VARCHAR(100) NOT NULL
   );

   CREATE TABLE orders (
       id SERIAL PRIMARY KEY,
       customer_id INTEGER REFERENCES customers(id),
       order_date DATE NOT NULL,
       order_amount NUMERIC(10, 2) NOT NULL
   );

   CREATE TABLE order_items (
       id SERIAL PRIMARY KEY,
       order_id INTEGER REFERENCES orders(id),
       product_name VARCHAR(100) NOT NULL,
       quantity INTEGER NOT NULL,
       price NUMERIC(10, 2) NOT NULL
   );
   ```

2. **Insert Sample Data:**

   ```sql
   INSERT INTO customers (name) VALUES 
   ('Alice'), ('Bob'), ('Charlie');

   INSERT INTO orders (customer_id, order_date, order_amount) VALUES 
   (1, '2023-01-01', 150.00),
   (2, '2023-01-02', 200.00),
   (1, '2023-01-03', 100.00),
   (3, '2023-01-04', 300.00);

   INSERT INTO order_items (order_id, product_name, quantity, price) VALUES 
   (1, 'Product A', 1, 50.00),
   (1, 'Product B', 2, 50.00),
   (2, 'Product C', 4, 50.00),
   (3, 'Product D', 1, 100.00),
   (4, 'Product E', 3, 100.00);
   ```

### Real-World Examples with Subqueries

#### Example 1: Find Customers with Orders Greater than Average

- **Query:**
  ```sql
  SELECT name
  FROM customers
  WHERE id IN (SELECT customer_id
               FROM orders
               WHERE order_amount > (SELECT AVG(order_amount) FROM orders));
  ```

- **Explanation:**
  - This query retrieves the names of customers who have placed orders with amounts greater than the average order amount.

#### Example 2: Find the Most Expensive Product in Each Order

- **Query:**
  ```sql
  SELECT order_id, product_name, price
  FROM order_items
  WHERE (order_id, price) IN (SELECT order_id, MAX(price)
                              FROM order_items
                              GROUP BY order_id);
  ```

- **Explanation:**
  - This query retrieves the most expensive product in each order.

#### Example 3: Calculate Total Sales for Each Customer

- **Query:**
  ```sql
  SELECT c.name, 
         (SELECT SUM(o.order_amount)
          FROM orders o
          WHERE o.customer_id = c.id) AS total_sales
  FROM customers c;
  ```

- **Explanation:**
  - This query calculates the total sales amount for each customer by summing the order amounts.

#### Example 4: List Orders with More Items than the Average

- **Query:**
  ```sql
  SELECT order_id, COUNT(*) AS item_count
  FROM order_items
  GROUP BY order_id
  HAVING COUNT(*) > (SELECT AVG(item_count)
                     FROM (SELECT COUNT(*) AS item_count
                           FROM order_items
                           GROUP BY order_id) AS subquery);
  ```

- **Explanation:**
  - This query lists orders that have more items than the average number of items per order.

### Conclusion

Subqueries are powerful tools in SQL that allow you to break down complex queries into manageable parts. By mastering scalar, column, row, and table subqueries, you can perform advanced data manipulation and retrieval tasks in PostgreSQL, enabling you to handle a wide range of real-world scenarios effectively.