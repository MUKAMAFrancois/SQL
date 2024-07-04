## Lecture: Constraints in PostgreSQL

### 1. Constraints

Constraints are rules applied to columns or tables to enforce data integrity and ensure that the data stored in the database adheres to specified rules. 
PostgreSQL supports several types of constraints, which we will cover in this lecture.

#### Primary Key

A primary key constraint uniquely identifies each row in a table. 
Each table can have only one primary key, which can consist of one or multiple columns. 

- **Single Column Primary Key:**
  
  CREATE TABLE departments (
      id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL
  );


  - **Explanation:**
    - The `id` column is defined as the primary key, which means it will have unique and non-null values.
    - The `SERIAL` data type automatically creates a sequence to generate unique values for the `id` column.

- **Composite Primary Key:**
  
  CREATE TABLE employee_projects (
      employee_id INT,
      project_id INT,
      PRIMARY KEY (employee_id, project_id)
  );
  

  - **Explanation:**
    - The combination of `employee_id` and `project_id` columns is defined as the primary key. This ensures that each pair of `employee_id` and `project_id` is unique in the table.

#### Foreign Key

A foreign key constraint ensures that values in a column or group of columns match values in a column or group of columns in another table. 
It enforces referential integrity between tables.

- **Example:**
  
  CREATE TABLE projects (
      id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      department_id INT,
      FOREIGN KEY (department_id) REFERENCES departments(id)
  );
  

  - **Explanation:**
    - The `department_id` column in the `projects` table is a foreign key that references the `id` column in the `departments` table. 
    This ensures that each `department_id` in the `projects` table matches an existing `id` in the `departments` table.

#### Unique

A unique constraint ensures that all values in a column or group of columns are unique across the rows in the table.

- **Single Column Unique Constraint:**
  
  CREATE TABLE employees (
      id SERIAL PRIMARY KEY,
      email VARCHAR(100) UNIQUE,
      first_name VARCHAR(50),
      last_name VARCHAR(50)
  );
  

  - **Explanation:**
    - The `email` column is defined as unique, which ensures that no two rows can have the same email address.

- **Composite Unique Constraint:**
  
  CREATE TABLE employee_contacts (
      employee_id INT,
      phone_number VARCHAR(15),
      UNIQUE (employee_id, phone_number)
  );
  

  - **Explanation:**
    - The combination of `employee_id` and `phone_number` columns must be unique, 
    ensuring that no employee can have the same phone number listed multiple times.

#### Not Null

A not null constraint ensures that a column cannot have a NULL value. It guarantees that a column must always have a value.

- **Example:**
  
  CREATE TABLE products (
      id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      price NUMERIC(10, 2) NOT NULL
  );
  

  - **Explanation:**
    - The `name` and `price` columns are defined as NOT NULL, 
    which ensures that every product must have a name and a price.

#### Check

A check constraint ensures that values in a column or group of columns satisfy a specific condition defined by an expression.

- **Example:**
  
  CREATE TABLE orders (
      id SERIAL PRIMARY KEY,
      order_date DATE NOT NULL,
      quantity INT NOT NULL,
      price NUMERIC(10, 2) NOT NULL,
      CHECK (quantity > 0),
      CHECK (price > 0)
  );
  

  - **Explanation:**
    - The first check constraint ensures that the `quantity` must be greater than 0.
    - The second check constraint ensures that the `price` must be greater than 0.

### Real-World Example: Managing an Online Store

1. **Creating the Database and Tables with Constraints:**
   
   CREATE DATABASE online_store;

   \c online_store

   CREATE TABLE customers (
       id SERIAL PRIMARY KEY,
       first_name VARCHAR(50) NOT NULL,
       last_name VARCHAR(50) NOT NULL,
       email VARCHAR(100) UNIQUE NOT NULL,
       registration_date DATE NOT NULL
   );

   CREATE TABLE products (
       id SERIAL PRIMARY KEY,
       name VARCHAR(100) NOT NULL,
       price NUMERIC(10, 2) NOT NULL CHECK (price > 0)
   );

   CREATE TABLE orders (
       id SERIAL PRIMARY KEY,
       customer_id INT NOT NULL,
       order_date DATE NOT NULL,
       total_price NUMERIC(10, 2) NOT NULL CHECK (total_price > 0),
       FOREIGN KEY (customer_id) REFERENCES customers(id)
   );

   CREATE TABLE order_items (
       order_id INT NOT NULL,
       product_id INT NOT NULL,
       quantity INT NOT NULL CHECK (quantity > 0),
       PRIMARY KEY (order_id, product_id),
       FOREIGN KEY (order_id) REFERENCES orders(id),
       FOREIGN KEY (product_id) REFERENCES products(id)
   );
   

2. **Inserting Data:**
   
   INSERT INTO customers (first_name, last_name, email, registration_date)
   VALUES ('Alice', 'Johnson', 'alice.johnson@example.com', '2023-01-05');

   INSERT INTO products (name, price)
   VALUES ('Laptop', 999.99), ('Smartphone', 499.99);

   INSERT INTO orders (customer_id, order_date, total_price)
   VALUES ((SELECT id FROM customers WHERE email = 'alice.johnson@example.com'), '2023-03-01', 1499.98);

   INSERT INTO order_items (order_id, product_id, quantity)
   VALUES 
   ((SELECT id FROM orders WHERE customer_id = (SELECT id FROM customers WHERE email = 'alice.johnson@example.com')), 
    (SELECT id FROM products WHERE name = 'Laptop'), 1),
   ((SELECT id FROM orders WHERE customer_id = (SELECT id FROM customers WHERE email = 'alice.johnson@example.com')), 
    (SELECT id FROM products WHERE name = 'Smartphone'), 1);
   
