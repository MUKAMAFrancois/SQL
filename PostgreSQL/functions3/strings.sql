## Lecture: String Functions in PostgreSQL

### 1. String Functions

PostgreSQL provides a variety of functions to manipulate and query string data. These functions allow you to perform a wide range of operations on text and character data. Here, we will cover some of the most commonly used string functions with real-world examples and explanations.

#### `length()`

The `length()` function returns the number of characters in a string.

- **Syntax:**
  ```sql
  SELECT length(string);
  ```

- **Example:**
  ```sql
  SELECT length('PostgreSQL') AS string_length;
  ```

  - **Explanation:**
    - This query returns the length of the string 'PostgreSQL', which is 10.

#### `lower()`

The `lower()` function converts a string to lowercase.

- **Syntax:**
  ```sql
  SELECT lower(string);
  ```

- **Example:**
  ```sql
  SELECT lower('PostgreSQL') AS lower_string;
  ```

  - **Explanation:**
    - This query converts the string 'PostgreSQL' to lowercase, resulting in 'postgresql'.

#### `upper()`

The `upper()` function converts a string to uppercase.

- **Syntax:**
  ```sql
  SELECT upper(string);
  ```

- **Example:**
  ```sql
  SELECT upper('PostgreSQL') AS upper_string;
  ```

  - **Explanation:**
    - This query converts the string 'PostgreSQL' to uppercase, resulting in 'POSTGRESQL'.

#### `substring()`

The `substring()` function extracts a substring from a string.

- **Syntax:**
  ```sql
  SELECT substring(string FROM start FOR length);
  ```

- **Example:**
  ```sql
  SELECT substring('PostgreSQL' FROM 1 FOR 4) AS substring;
  ```

  - **Explanation:**
    - This query extracts a substring from the string 'PostgreSQL', starting at position 1 for 4 characters, resulting in 'Post'.

#### `position()`

The `position()` function returns the position of a substring within a string.

- **Syntax:**
  ```sql
  SELECT position(substring IN string);
  ```

- **Example:**
  ```sql
  SELECT position('gre' IN 'PostgreSQL') AS position;
  ```

  - **Explanation:**
    - This query returns the position of the substring 'gre' within the string 'PostgreSQL', which is 6.

#### `trim()`

The `trim()` function removes leading and trailing whitespace from a string.

- **Syntax:**
  ```sql
  SELECT trim(string);
  ```

- **Example:**
  ```sql
  SELECT trim('   PostgreSQL   ') AS trimmed_string;
  ```

  - **Explanation:**
    - This query removes the leading and trailing whitespace from the string '   PostgreSQL   ', resulting in 'PostgreSQL'.

#### `concat()`

The `concat()` function concatenates two or more strings.

- **Syntax:**
  ```sql
  SELECT concat(string1, string2, ...);
  ```

- **Example:**
  ```sql
  SELECT concat('Post', 'gre', 'SQL') AS concatenated_string;
  ```

  - **Explanation:**
    - This query concatenates the strings 'Post', 'gre', and 'SQL', resulting in 'PostgreSQL'.

#### `replace()`

The `replace()` function replaces all occurrences of a substring within a string with another substring.

- **Syntax:**
  ```sql
  SELECT replace(string, old_substring, new_substring);
  ```

- **Example:**
  ```sql
  SELECT replace('Hello, World!', 'World', 'PostgreSQL') AS replaced_string;
  ```

  - **Explanation:**
    - This query replaces all occurrences of the substring 'World' with 'PostgreSQL' in the string 'Hello, World!', resulting in 'Hello, PostgreSQL!'.

### Real-World Example: Managing User Data

Let s consider a table `users` that stores information about users, including their full name and email address:

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);
```

1. **Insert Sample Data:**
   ```sql
   INSERT INTO users (full_name, email) VALUES 
   ('Alice Smith', 'alice.smith@example.com'),
   ('Bob Johnson', 'bob.johnson@example.com'),
   ('Charlie Brown', 'charlie.brown@example.com');
   ```

2. **Get the Length of Each Full Name:**
   ```sql
   SELECT full_name, length(full_name) AS name_length
   FROM users;
   ```

   - **Explanation:**
     - This query retrieves the full name of each user and its length.

3. **Convert Full Names to Lowercase:**
   ```sql
   SELECT full_name, lower(full_name) AS lower_name
   FROM users;
   ```

   - **Explanation:**
     - This query converts the full name of each user to lowercase.

4. **Extract the First Name from Full Names:**
   ```sql
   SELECT full_name, substring(full_name FROM 1 FOR position(' ' IN full_name) - 1) AS first_name
   FROM users;
   ```

   - **Explanation:**
     - This query extracts the first name from the full name of each user. It assumes that the first name ends before the first space character.

5. **Concatenate First Name and Last Name:**
   ```sql
   SELECT full_name, concat(substring(full_name FROM 1 FOR position(' ' IN full_name) - 1), ' ', substring(full_name FROM position(' ' IN full_name) + 1)) AS reconstructed_name
   FROM users;
   ```

   - **Explanation:**
     - This query concatenates the first name and last name from the full name of each user to reconstruct the full name. It assumes that the first name ends before the first space character and the last name starts after the first space character.

6. **Replace Domain in Email Addresses:**
   ```sql
   SELECT email, replace(email, 'example.com', 'mydomain.com') AS new_email
   FROM users;
   ```

   - **Explanation:**
     - This query replaces the domain 'example.com' with 'mydomain.com' in the email address of each user.

By mastering these string functions, you can effectively store, query, and manipulate text data in PostgreSQL, enabling you to handle complex string-related operations in your database.