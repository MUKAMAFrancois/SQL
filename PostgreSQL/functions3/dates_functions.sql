## Lecture: Date Functions in PostgreSQL (with Type Casting)

### 1. Date Functions

PostgreSQL offers a rich set of functions to manipulate and query date and time values. These functions can help you perform a wide range of operations on date and time data. Here, we will cover some of the most commonly used date functions with real-world examples and explanations, including type casting to avoid errors.

#### `current_date`

The `current_date` function returns the current date.

- **Syntax:**
  ```sql
  SELECT current_date;
  ```

- **Example:**
  ```sql
  SELECT current_date AS today;
  ```

  - **Explanation:**
    - This query returns the current date as "today".

#### `current_time`

The `current_time` function returns the current time.

- **Syntax:**
  ```sql
  SELECT current_time;
  ```

- **Example:**
  ```sql
  SELECT current_time AS now;
  ```

  - **Explanation:**
    - This query returns the current time as "now".

#### `current_timestamp`

The `current_timestamp` function returns the current date and time.

- **Syntax:**
  ```sql
  SELECT current_timestamp;
  ```

- **Example:**
  ```sql
  SELECT current_timestamp AS now;
  ```

  - **Explanation:**
    - This query returns the current date and time as "now".

#### `age()`

The `age()` function returns the interval between two timestamps.

- **Syntax:**
  ```sql
  SELECT age(timestamp1, timestamp2);
  ```

- **Example:**
  ```sql
  SELECT age('2023-07-01'::timestamp, '1990-07-01'::timestamp) AS age_difference;
  ```

  - **Explanation:**
    - This query calculates the interval between '2023-07-01' and '1990-07-01', returning the age difference.

#### `date_part()`

The `date_part()` function extracts a specified part of a date or timestamp.

- **Syntax:**
  ```sql
  SELECT date_part('part', timestamp);
  ```

- **Example:**
  ```sql
  SELECT date_part('year', '2023-07-01'::date) AS year;
  ```

  - **Explanation:**
    - This query extracts the year part from the date '2023-07-01', returning 2023.

#### `date_trunc()`

The `date_trunc()` function truncates a timestamp to the specified precision.

- **Syntax:**
  ```sql
  SELECT date_trunc('precision', timestamp);
  ```

- **Example:**
  ```sql
  SELECT date_trunc('month', '2023-07-01 15:30:00'::timestamp) AS truncated_date;
  ```

  - **Explanation:**
    - This query truncates the timestamp '2023-07-01 15:30:00' to the beginning of the month, returning '2023-07-01 00:00:00'.

#### `now()`

The `now()` function returns the current date and time.

- **Syntax:**
  ```sql
  SELECT now();
  ```

- **Example:**
  ```sql
  SELECT now() AS current_datetime;
  ```

  - **Explanation:**
    - This query returns the current date and time as "current_datetime".

#### `extract()`

The `extract()` function retrieves a specified part of a date.

- **Syntax:**
  ```sql
  SELECT extract(field FROM source);
  ```

- **Example:**
  ```sql
  SELECT extract(day FROM '2023-07-01'::date) AS day;
  ```

  - **Explanation:**
    - This query extracts the day part from the date '2023-07-01', returning 1.

#### `interval`

The `interval` function adds or subtracts a specified interval from a date.

- **Syntax:**
  ```sql
  SELECT date + interval 'value unit';
  ```

- **Example:**
  ```sql
  SELECT '2023-07-01'::date + interval '1 month' AS new_date;
  ```

  - **Explanation:**
    - This query adds one month to the date '2023-07-01', resulting in '2023-08-01'.

### Real-World Example: Managing Employee Data

Let s consider a table `employees` that stores information about employees, including their date of birth and date of joining:

```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    date_of_joining DATE NOT NULL
);
```

1. **Insert Sample Data:**
   ```sql
   INSERT INTO employees (name, date_of_birth, date_of_joining) VALUES 
   ('Alice', '1990-05-15', '2015-07-01'),
   ('Bob', '1985-10-20', '2010-08-15'),
   ('Charlie', '1975-12-30', '2005-02-20');
   ```

2. **Calculate Employee Age:**
   ```sql
   SELECT name, age(current_date, date_of_birth) AS age
   FROM employees;
   ```

   - **Explanation:**
     - This query calculates the age of each employee based on their date of birth.

3. **Calculate Years of Service:**
   ```sql
   SELECT name, age(current_date, date_of_joining) AS years_of_service
   FROM employees;
   ```

   - **Explanation:**
     - This query calculates the years of service for each employee based on their date of joining.

4. **Extract Year and Month of Joining:**
   ```sql
   SELECT name, date_part('year', date_of_joining) AS joining_year, date_part('month', date_of_joining) AS joining_month
   FROM employees;
   ```

   - **Explanation:**
     - This query extracts the year and month from the date of joining for each employee.

5. **Truncate Date of Joining to the Beginning of the Year:**
   ```sql
   SELECT name, date_trunc('year', date_of_joining) AS truncated_joining_date
   FROM employees;
   ```

   - **Explanation:**
     - This query truncates the date of joining to the beginning of the year for each employee.

6. **Add One Year to Date of Joining:**
   ```sql
   SELECT name, date_of_joining + interval '1 year' AS new_joining_date
   FROM employees;
   ```

   - **Explanation:**
     - This query adds one year to the date of joining for each employee.

