## Lecture: Mathematical Functions in PostgreSQL

### 1. Mathematical Functions

PostgreSQL provides a wide array of mathematical functions that can be used to perform calculations and manipulate numeric data. Here we will cover some of the most commonly used functions with real-world examples and explanations.

#### `abs()`

The `abs()` function returns the absolute value of a number, removing any negative sign.

- **Syntax:**
  ```sql
  SELECT abs(value);
  ```

- **Example:**
  ```sql
  SELECT abs(-42) AS absolute_value;
  ```

  - **Explanation:**
    - This query returns the absolute value of -42, which is 42.

#### `round()`

The `round()` function rounds a numeric value to the nearest integer or to a specified number of decimal places.

- **Syntax:**
  ```sql
  SELECT round(value [, decimal_places]);
  ```

- **Example:**
  ```sql
  SELECT round(123.456) AS rounded_value;
  SELECT round(123.456, 1) AS rounded_value_one_decimal;
  ```

  - **Explanation:**
    - The first query rounds 123.456 to the nearest integer, resulting in 123.
    - The second query rounds 123.456 to one decimal place, resulting in 123.5.

#### `ceil()`

The `ceil()` function returns the smallest integer that is greater than or equal to the specified value.

- **Syntax:**
  ```sql
  SELECT ceil(value);
  ```

- **Example:**
  ```sql
  SELECT ceil(123.456) AS ceiling_value;
  ```

  - **Explanation:**
    - This query returns the smallest integer greater than or equal to 123.456, which is 124.

#### `floor()`

The `floor()` function returns the largest integer that is less than or equal to the specified value.

- **Syntax:**
  ```sql
  SELECT floor(value);
  ```

- **Example:**
  ```sql
  SELECT floor(123.456) AS floor_value;
  ```

  - **Explanation:**
    - This query returns the largest integer less than or equal to 123.456, which is 123.

#### `sqrt()`

The `sqrt()` function returns the square root of a number.

- **Syntax:**
  ```sql
  SELECT sqrt(value);
  ```

- **Example:**
  ```sql
  SELECT sqrt(16) AS square_root;
  ```

  - **Explanation:**
    - This query returns the square root of 16, which is 4.

#### `power()`

The `power()` function raises a number to the power of another number.

- **Syntax:**
  ```sql
  SELECT power(base, exponent);
  ```

- **Example:**
  ```sql
  SELECT power(2, 3) AS power_value;
  ```

  - **Explanation:**
    - This query raises 2 to the power of 3, resulting in 8.

#### `log()`

The `log()` function returns the natural logarithm (base e) of a number.

- **Syntax:**
  ```sql
  SELECT log(value);
  ```

- **Example:**
  ```sql
  SELECT log(10) AS natural_log;
  ```

  - **Explanation:**
    - This query returns the natural logarithm of 10.

#### `exp()`

The `exp()` function returns e raised to the power of a specified number.

- **Syntax:**
  ```sql
  SELECT exp(value);
  ```

- **Example:**
  ```sql
  SELECT exp(2) AS exponential_value;
  ```

  - **Explanation:**
    - This query returns e raised to the power of 2.

### Real-World Example: Managing Financial Data

-- Let s consider a table `transactions` that stores financial transactions for a company:

```sql
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    transaction_date DATE NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    description VARCHAR(255)
);
```

1. **Calculate the Absolute Value of Transactions:**
   ```sql
   SELECT id, amount, abs(amount) AS absolute_amount
   FROM transactions;
   ```

   - **Explanation:**
     - This query retrieves the transaction ID, amount, and the absolute value of the amount, which is useful for identifying the magnitude of transactions regardless of whether they are debits or credits.

2. **Round Transaction Amounts:**
   ```sql
   SELECT id, amount, round(amount, 1) AS rounded_amount
   FROM transactions;
   ```

   - **Explanation:**
     - This query retrieves the transaction ID, amount, and the amount rounded to one decimal place.

3. **Calculate Ceiling and Floor of Transaction Amounts:**
   ```sql
   SELECT id, amount, ceil(amount) AS ceiling_amount, floor(amount) AS floor_amount
   FROM transactions;
   ```

   - **Explanation:**
     - This query retrieves the transaction ID, amount, the ceiling value, and the floor value of each transaction amount.

4. **Calculate the Square Root of Positive Transaction Amounts:**
   ```sql
   SELECT id, amount, sqrt(amount) AS square_root
   FROM transactions
   WHERE amount > 0;
   ```

   - **Explanation:**
     - This query retrieves the transaction ID, amount, and the square root of the amount for transactions with positive amounts.

5. **Calculate Exponential Growth of Transaction Amounts:**
   ```sql
   SELECT id, amount, exp(amount) AS exponential_value
   FROM transactions;
   ```

   - **Explanation:**
     - This query retrieves the transaction ID, amount, and the exponential value of each transaction amount, which can be useful for financial modeling.
