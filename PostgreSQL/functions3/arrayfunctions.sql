## Lecture: Array Functions in PostgreSQL

### 1. Array Functions

-- PostgreSQL provides a comprehensive set of functions to work with array data types. 
-- These functions allow you to manipulate and query arrays stored in your database.
--  Here, we will cover some of the most 
-- commonly used array functions with real-world examples and explanations.

#### `array_append()`

The `array_append()` function appends an element to the end of an array.

- **Syntax:**
  ```sql
  SELECT array_append(array, element);
  ```

- **Example:**
  ```sql
  SELECT array_append('{1, 2, 3}', 4) AS new_array;
  ```

  - **Explanation:**
    - This query appends the number 4 to the array `{1, 2, 3}`, resulting in `{1, 2, 3, 4}`.

#### `array_cat()`

The `array_cat()` function concatenates two arrays.

- **Syntax:**
  ```sql
  SELECT array_cat(array1, array2);
  ```

- **Example:**
  ```sql
  SELECT array_cat('{1, 2, 3}', '{4, 5, 6}') AS concatenated_array;
  ```

  - **Explanation:**
    - This query concatenates the arrays `{1, 2, 3}` and `{4, 5, 6}`, resulting in `{1, 2, 3, 4, 5, 6}`.

#### `array_length()`

The `array_length()` function returns the length of an array.

- **Syntax:**
  ```sql
  SELECT array_length(array, dimension);
  ```

- **Example:**
  ```sql
  SELECT array_length('{1, 2, 3, 4}', 1) AS length;
  ```

  - **Explanation:**
    - This query returns the length of the array `{1, 2, 3, 4}`, which is 4. The `1` specifies the first dimension.

#### `unnest()`

The `unnest()` function expands an array to a set of rows.

- **Syntax:**
  ```sql
  SELECT unnest(array);
  ```

- **Example:**
  ```sql
  SELECT unnest('{1, 2, 3, 4}'::integer[]) AS element;
  ```

  - **Explanation:**
    - This query expands the array `{1, 2, 3, 4}` into a set of rows with each element as a separate row.

### Real-World Example: Managing Product Categories

Let s consider a table `products` that stores information about products, 
including their categories as an array:


CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    categories TEXT[] NOT NULL
);


-- 1. **Insert Sample Data:**
   
   INSERT INTO products (name, categories) VALUES 
   ('Laptop', '{"Electronics", "Computers"}'),
   ('Smartphone', '{"Electronics", "Mobile"}'),
   ('Tablet', '{"Electronics", "Computers", "Mobile"}');
   

-- 2. **Append a New Category to Products:**
   
   UPDATE products
   SET categories = array_append(categories, 'Gadgets')
   WHERE name = 'Laptop';
   

   - **Explanation:**
     - This query appends the category "Gadgets" to the categories of the product "Laptop".

-- 3. **Concatenate Category Arrays of Two Products:**
   
   SELECT array_cat(
       (SELECT categories FROM products WHERE name = 'Laptop'),
       (SELECT categories FROM products WHERE name = 'Smartphone')
   ) AS combined_categories;
   

   - **Explanation:**
     - This query concatenates the category arrays of "Laptop" and "Smartphone" into a single array.

4. **Get the Number of Categories for Each Product:**
   ```sql
   SELECT name, array_length(categories, 1) AS num_categories
   FROM products;
   ```

   - **Explanation:**
     - This query retrieves the product name and the number of categories for each product.

5. **Expand Categories into Rows:**
   ```sql
   SELECT name, unnest(categories) AS category
   FROM products;
   ```

   - **Explanation:**
     - This query expands the categories array into individual rows, showing each category for every product.

6. **Find Products Belonging to a Specific Category:**
   ```sql
   SELECT name
   FROM products
   WHERE 'Computers' = ANY(categories);
   ```

   - **Explanation:**
     - This query retrieves the names of products that belong to the "Computers" category using the `ANY` operator.
