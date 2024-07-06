## Lecture: Basic SQL Commands

### 1. Basic SQL Commands

#### `CREATE`, `ALTER`, `DROP`


1. `CREATE`:
   - Creates new database objects
   - Examples:
     - `CREATE DATABASE`: Makes a new database
     - `CREATE TABLE`: Defines a new table
     - `CREATE INDEX`: Builds an index on a table column

-- Create a new database
CREATE DATABASE employee_management;

-- Create a new table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    hire_date DATE
);

-- Create an index
CREATE INDEX idx_employee_name ON employees(name);

2. `ALTER`:
   - Modifies existing database objects
   - Examples:
     - `ALTER DATABASE`: Changes database properties
     - `ALTER TABLE`: Modifies table structure (add/remove columns, change data types)
     - `ALTER INDEX`: Renames an index

-- Alter database properties
ALTER DATABASE employee_management SET timezone TO 'UTC';

-- Add a column to a table
ALTER TABLE employees ADD COLUMN department VARCHAR(50);


-- Change a column's data type
ALTER TABLE employees ALTER COLUMN name TYPE VARCHAR(150);

-- Rename an index
ALTER INDEX idx_employee_name RENAME TO idx_emp_name;
-- Rename column
ALTER TABLE books RENAME COLUMN cost TO "Cost ($)";

-- Rename a table name:

ALTER TABLE location RENAME TO Locations;

-- make a field nullable
ALTER TABLE Employees ALTER COLUMN manager_id DROP NOT NULL;

3. `DROP`:
   - Removes existing database objects
   - Examples:
     - `DROP DATABASE`: Deletes an entire database
     - `DROP TABLE`: Removes a table and all its data
     - `DROP INDEX`: Deletes an index

-- Drop a database (be very careful with this!)
DROP DATABASE employee_management;

-- Drop a table
DROP TABLE employees;

-- Drop an index
DROP INDEX idx_emp_name;



##### CREATE

- **Database:**
  ```sql
  CREATE DATABASE company_db;
  ```

- **Table:**
  
  CREATE TABLE employees (
      id SERIAL PRIMARY KEY,
      first_name VARCHAR(50),
      last_name VARCHAR(50),
      email VARCHAR(100) UNIQUE,
      hire_date DATE,
      salary NUMERIC(10, 2)  -- This means the salary column can store numbers with up to 10 digits in total, of which 2 are after the decimal point. For example:

--Valid: 12345678.90
  );
  

- **Index:**
  ```sql
  CREATE INDEX idx_last_name ON employees (last_name);
  ```

##### ALTER

- **Database:**
  ```sql
  ALTER DATABASE company_db SET timezone TO 'UTC';
  ```

- **Table:**
  ```sql
  ALTER TABLE employees
  ADD COLUMN department VARCHAR(50);
  ```

- **Index:**
  ```sql
  ALTER INDEX idx_last_name
  RENAME TO idx_emp_last_name;
  ```

##### DROP

- **Database:**
  ```sql
  DROP DATABASE company_db;
  ```

- **Table:**
  ```sql
  DROP TABLE employees;
  ```

- **Index:**
  ```sql
  DROP INDEX idx_emp_last_name;
  ```

#### `INSERT`, `UPDATE`, `DELETE`, `SELECT`

##### INSERT

- **Single Row:**
  ```sql
  INSERT INTO employees (first_name, last_name, email, hire_date, salary)
  VALUES ('John', 'Doe', 'john.doe@example.com', '2024-01-15', 60000.00);
  ```

- **Multiple Rows:**
  
  INSERT INTO employees (first_name, last_name, email, hire_date, salary)
  VALUES
  ('Jane', 'Smith', 'jane.smith@example.com', '2024-03-22', 65000.00),
  ('Sam', 'Brown', 'sam.brown@example.com', '2024-06-30', 70000.00);
  

##### UPDATE

- **Update Single Row:**
  
  UPDATE employees
  SET salary = 75000.00
  WHERE email = 'jane.smith@example.com';
  

- **Update Multiple Rows:**
  
  UPDATE employees
  SET salary = salary * 1.05
  WHERE hire_date < '2024-01-01';
  

##### DELETE

- **Delete Single Row:**
  
  DELETE FROM employees
  WHERE email = 'john.doe@example.com';
  

- **Delete Multiple Rows:**
  
  DELETE FROM employees
  WHERE salary < 65000.00;
  

##### SELECT

- **Select All Columns:**
  
  SELECT * FROM employees;
  

- **Select Specific Columns:**
  
  SELECT first_name, last_name, email FROM employees;
  

- **Select with Conditions:**
  
  SELECT first_name, last_name, salary
  FROM employees
  WHERE salary > 65000.00;
  

- **Select with Sorting:**
  
  SELECT first_name, last_name, salary
  FROM employees
  ORDER BY salary DESC;
  

- **Select with Aggregation:**
  
  SELECT department, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department;
  

### Real-World Examples

##### Example: Managing a Bookstore

1. **Creating the Database and Tables:**
   
   CREATE DATABASE bookstore_db;

   \c bookstore_db

   CREATE TABLE books (
       id SERIAL PRIMARY KEY,
       title VARCHAR(100),
       author VARCHAR(100),
       published_date DATE,
       price NUMERIC(8, 2)
   );

   CREATE TABLE customers (
       id SERIAL PRIMARY KEY,
       first_name VARCHAR(50),
       last_name VARCHAR(50),
       email VARCHAR(100) UNIQUE,
       registration_date DATE
   );

   CREATE TABLE orders (
       id SERIAL PRIMARY KEY,
       customer_id INTEGER REFERENCES customers(id),
       book_id INTEGER REFERENCES books(id),
       order_date DATE,
       quantity INTEGER,
       total_price NUMERIC(10, 2)
   );
   

2. **Inserting Data:**
   
   INSERT INTO books (title, author, published_date, price)
   VALUES
   ('The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10', 10.99),
   ('1984', 'George Orwell', '1949-06-08', 8.99);

   INSERT INTO customers (first_name, last_name, email, registration_date)
   VALUES
   ('Alice', 'Johnson', 'alice.johnson@example.com', '2023-01-05'),
   ('Bob', 'Smith', 'bob.smith@example.com', '2023-02-20');

   INSERT INTO orders (customer_id, book_id, order_date, quantity, total_price)
   VALUES
   ((SELECT id FROM customers WHERE email = 'alice.johnson@example.com'), (SELECT id FROM books WHERE title = 'The Great Gatsby'), '2023-03-01', 1, 10.99),
   ((SELECT id FROM customers WHERE email = 'bob.smith@example.com'), (SELECT id FROM books WHERE title = '1984'), '2023-03-15', 2, 17.98);
   

3. **Updating Data:**
   
   UPDATE books
   SET price = 9.99
   WHERE title = '1984';

   UPDATE customers
   SET email = 'alice.j@example.com'
   WHERE email = 'alice.johnson@example.com';
   

4. **Deleting Data:**
   
   DELETE FROM orders
   WHERE order_date < '2023-03-01';

   DELETE FROM customers
   WHERE email = 'bob.smith@example.com';
   

5. **Selecting Data:**
   
   SELECT * FROM books;

   SELECT first_name, last_name, email FROM customers;

   SELECT title, author, price FROM books
   WHERE price > 9.00;

   SELECT first_name, last_name, title, order_date, quantity
   FROM customers
   JOIN orders ON customers.id = orders.customer_id
   JOIN books ON orders.book_id = books.id
   WHERE order_date >= '2023-01-01'
   ORDER BY order_date DESC;
   

