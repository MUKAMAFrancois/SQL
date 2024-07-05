## Lecture: Conditional Expressions in PostgreSQL

### 1. Introduction to Conditional Expressions

-- Conditional expressions allow you to implement logic within your SQL queries.
--  PostgreSQL provides various conditional expressions that can be used
-- to control the flow of data retrieval and manipulation.

### 2. Types of Conditional Expressions

#### `CASE`

The `CASE` expression is a versatile and widely used conditional expression in SQL. 
It allows you to create conditions and return specific values based on those conditions.

- **Syntax:**
  ```sql
  CASE 
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE default_result
  END
  ```

- **Example:**
  ```sql
  SELECT full_name,
         CASE
           WHEN age < 18 THEN 'Minor'
           WHEN age >= 18 AND age < 65 THEN 'Adult'
           ELSE 'Senior'
         END AS age_group
  FROM users;
  ```

  - **Explanation:**
    - This query classifies users into age groups: 
    'Minor', 'Adult', or 'Senior' based on their age.

#### `COALESCE`

The `COALESCE` function returns the first non-null value in a list of arguments.
-- COALESCE in PostgreSQL is a function that returns the first non-null value in a list of expressions.
--  It is very useful for handling null values in queries.

- **Syntax:**
  ```sql
  COALESCE(value1, value2, ..., valueN)
  ```

- **Example:**
  ```sql
  SELECT full_name, COALESCE(phone, 'N/A') AS phone
  FROM users;
  ```

  - **Explanation:**
    - This query returns the users phone number if it is not null; otherwise, it returns 'N/A'.

#### `NULLIF`

The `NULLIF` function returns null if two specified expressions are equal.
Otherwise, it returns the first expression.

- **Syntax:**
  ```sql
  NULLIF(value1, value2)
  ```

- **Example:**
  ```sql
  SELECT full_name, NULLIF(phone, '') AS phone
  FROM users;
  ```

  - **Explanation:**
    - This query returns null if the phone number is an empty string; otherwise, it returns the phone number.

#### `GREATEST` and `LEAST`

The `GREATEST` function returns the largest value from a list of expressions, while the `LEAST` function returns the smallest value.

- **Syntax:**
  ```sql
  GREATEST(value1, value2, ..., valueN)
  LEAST(value1, value2, ..., valueN)
  ```

- **Example:**
  ```sql
  SELECT full_name, GREATEST(score1, score2, score3) AS highest_score
  FROM users;
  ```

  - **Explanation:**
    - This query returns the highest score from three different score columns for each user.





### Real-World Example: Managing Order Data

Let s consider a table `orders` that stores information about customer orders, including the order amount and discount:

```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    order_amount NUMERIC(10, 2) NOT NULL,
    discount NUMERIC(5, 2)
);
```

1. **Insert Sample Data:**
   ```sql
   INSERT INTO orders (customer_name, order_amount, discount) VALUES 
   ('Alice', 150.00, 10.00),
   ('Bob', 200.00, NULL),
   ('Charlie', 300.00, 15.00);
   ```

2. **Calculate Final Order Amount with Discount:**
   ```sql
   SELECT customer_name, 
          order_amount,
          discount,
          order_amount - COALESCE(discount, 0) AS final_amount
   FROM orders;
   ```

   - **Explanation:**
     - This query calculates the final order amount by subtracting the discount from the order amount. If the discount is null, it uses 0 as the default value.

3. **Classify Orders Based on Amount:**
   ```sql
   SELECT customer_name, 
          order_amount,
          CASE
            WHEN order_amount < 100 THEN 'Small'
            WHEN order_amount >= 100 AND order_amount < 300 THEN 'Medium'
            ELSE 'Large'
          END AS order_size
   FROM orders;
   ```

   - **Explanation:**
     - This query classifies orders as 'Small', 'Medium', or 'Large' based on the order amount.

4. **Handle Null Discounts with `NULLIF`:**
   ```sql
   SELECT customer_name, 
          order_amount,
          NULLIF(discount, 0) AS valid_discount
   FROM orders;
   ```

   - **Explanation:**
     - This query returns null for discounts that are 0, otherwise it returns the actual discount value.

5. **Find the Largest and Smallest Order Amount:**
   ```sql
   SELECT customer_name, 
          order_amount,
          GREATEST(order_amount, 100) AS max_order_amount,
          LEAST(order_amount, 200) AS min_order_amount
   FROM orders;
   ```

   - **Explanation:**
     - This query returns the larger value between the order amount and 100 as the maximum order amount, and the smaller value between the order amount and 200 as the minimum order amount.

