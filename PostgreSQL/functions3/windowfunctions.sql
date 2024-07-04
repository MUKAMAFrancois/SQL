## Lecture: Window Functions in PostgreSQL

### 1. Introduction to Window Functions

Window functions perform calculations across a set of table rows that are related to the current row. 
They allow you to apply aggregate and ranking functions over partitions of data without collapsing the result set.

### 2. Types of Window Functions

#### `ROW_NUMBER()`

The `ROW_NUMBER()` function assigns a unique sequential integer to rows within a partition of a result set.

- **Syntax:**
  ```sql
  SELECT ROW_NUMBER() OVER (PARTITION BY column_name ORDER BY column_name) AS row_num;
  ```

- **Example:**
  ```sql
  SELECT id, full_name, ROW_NUMBER() OVER (ORDER BY full_name) AS row_num
  FROM users;
  ```

  - **Explanation:**
    - This query assigns a unique row number to each user, ordered by their full name.

#### `RANK()`

The `RANK()` function assigns a rank to each row within the partition of a result set. If two or more rows have the same rank, the next rank will be skipped.

- **Syntax:**
  ```sql
  SELECT RANK() OVER (PARTITION BY column_name ORDER BY column_name) AS rank;
  ```

- **Example:**
  ```sql
  SELECT id, full_name, RANK() OVER (ORDER BY full_name) AS rank
  FROM users;
  ```

  - **Explanation:**
    - This query assigns a rank to each user, ordered by their full name. Tied ranks result in gaps.

#### `DENSE_RANK()`

The `DENSE_RANK()` function is similar to `RANK()`, but it does not skip ranks if there are ties.

- **Syntax:**
  ```sql
  SELECT DENSE_RANK() OVER (PARTITION BY column_name ORDER BY column_name) AS dense_rank;
  ```

- **Example:**
  ```sql
  SELECT id, full_name, DENSE_RANK() OVER (ORDER BY full_name) AS dense_rank
  FROM users;
  ```

  - **Explanation:**
    - This query assigns a dense rank to each user, ordered by their full name. Tied ranks do not result in gaps.

#### `NTILE()`

The `NTILE()` function divides the rows in the result set into a specified number of approximately equal groups.

- **Syntax:**
  ```sql
  SELECT NTILE(n) OVER (PARTITION BY column_name ORDER BY column_name) AS tile;
  ```

- **Example:**
  ```sql
  SELECT id, full_name, NTILE(3) OVER (ORDER BY full_name) AS tile
  FROM users;
  ```

  - **Explanation:**
    - This query divides the users into three tiles, ordered by their full name.

#### `LAG()`

The `LAG()` function provides access to a row at a specified physical offset before the current row within the partition.

- **Syntax:**
  ```sql
  SELECT LAG(column_name, offset) OVER (PARTITION BY column_name ORDER BY column_name) AS lag_value;
  ```

- **Example:**
  ```sql
  SELECT id, full_name, date_of_joining, LAG(date_of_joining, 1) OVER (ORDER BY date_of_joining) AS previous_date_of_joining
  FROM users;
  ```

  - **Explanation:**
    - This query retrieves the joining date of the previous user in the order of joining dates.

#### `LEAD()`

The `LEAD()` function provides access to a row at a specified physical offset after the current row within the partition.

- **Syntax:**
  ```sql
  SELECT LEAD(column_name, offset) OVER (PARTITION BY column_name ORDER BY column_name) AS lead_value;
  ```

- **Example:**
  ```sql
  SELECT id, full_name, date_of_joining, LEAD(date_of_joining, 1) OVER (ORDER BY date_of_joining) AS next_date_of_joining
  FROM users;
  ```

  - **Explanation:**
    - This query retrieves the joining date of the next user in the order of joining dates.

### Real-World Example: Managing Sales Data

Let s consider three tables: `books`, `authors`, and `book_sales` to demonstrate the use of window functions.

1. **Create Tables:**

   ```sql
   CREATE TABLE authors (
       id SERIAL PRIMARY KEY,
       name VARCHAR(100) NOT NULL
   );

   CREATE TABLE books (
       id SERIAL PRIMARY KEY,
       title VARCHAR(100) NOT NULL,
       author_id INTEGER REFERENCES authors(id)
   );

   CREATE TABLE book_sales (
       id SERIAL PRIMARY KEY,
       book_id INTEGER REFERENCES books(id),
       sale_date DATE NOT NULL,
       quantity INTEGER NOT NULL
   );
   ```

2. **Insert Sample Data:**

   ```sql
   INSERT INTO authors (name) VALUES 
   ('Author A'), ('Author B'), ('Author C');

   INSERT INTO books (title, author_id) VALUES 
   ('Book 1', 1), ('Book 2', 1), ('Book 3', 2), ('Book 4', 3);

   INSERT INTO book_sales (book_id, sale_date, quantity) VALUES 
   (1, '2023-01-01', 10), (1, '2023-01-02', 15),
   (2, '2023-01-01', 5), (3, '2023-01-03', 20),
   (4, '2023-01-01', 25), (4, '2023-01-04', 30);
   ```

3. **Calculate Cumulative Sales for Each Book:**

   ```sql
   SELECT book_id, sale_date, quantity,
          SUM(quantity) OVER (PARTITION BY book_id ORDER BY sale_date) AS cumulative_sales
   FROM book_sales;
   ```

   - **Explanation:**
     - This query calculates the cumulative sales for each book ordered by the sale date.

4. **Rank Books by Total Sales:**

   ```sql
   SELECT book_id, SUM(quantity) AS total_sales,
          RANK() OVER (ORDER BY SUM(quantity) DESC) AS sales_rank
   FROM book_sales
   GROUP BY book_id;
   ```

   - **Explanation:**
     - This query ranks books by their total sales.

5. **Find Previous Sale Quantity for Each Sale:**

   ```sql
   SELECT book_id, sale_date, quantity,
          LAG(quantity, 1) OVER (PARTITION BY book_id ORDER BY sale_date) AS previous_quantity
   FROM book_sales;
   ```

   - **Explanation:**
     - This query retrieves the quantity sold in the previous sale for each book.

