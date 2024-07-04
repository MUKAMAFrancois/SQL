## Lecture: JSON Functions in PostgreSQL

### 1. JSON Functions

PostgreSQL provides robust support for storing and querying JSON (JavaScript Object Notation) data. JSON functions allow you to manipulate and query JSON data stored in your database. Here, we will cover some of the most commonly used JSON functions with real-world examples and explanations.

#### `json_array_length()`

The `json_array_length()` function returns the number of elements in a JSON array.

- **Syntax:**
  ```sql
  SELECT json_array_length(json_data);
  ```

- **Example:**
  ```sql
  SELECT json_array_length('[{"name": "Alice"}, {"name": "Bob"}, {"name": "Charlie"}]') AS array_length;
  ```

  - **Explanation:**
    - This query returns the number of elements in the JSON array, which is 3.

#### `json_object_keys()`

The `json_object_keys()` function returns the set of keys in the outermost JSON object as a set of text.

- **Syntax:**
  ```sql
  SELECT json_object_keys(json_data);
  ```

- **Example:**
  ```sql
  SELECT json_object_keys('{"name": "Alice", "age": 30, "city": "New York"}') AS keys;
  ```

  - **Explanation:**
    - This query returns the keys of the JSON object: "name", "age", and "city".

#### `json_extract_path_text()`

The `json_extract_path_text()` function extracts the value associated with the specified path (keys) from a JSON document as text.

- **Syntax:**
  ```sql
  SELECT json_extract_path_text(json_data, 'key1', 'key2', ...);
  ```

- **Example:**
  ```sql
  SELECT json_extract_path_text('{"name": "Alice", "details": {"age": 30, "city": "New York"}}', 'details', 'city') AS city;
  ```

  - **Explanation:**
    - This query extracts the value of the "city" key within the "details" object, which is "New York".

### Real-World Example: Managing User Profiles

Let s consider a table `user_profiles` that stores JSON data representing user profiles:

```sql
CREATE TABLE user_profiles (
    id SERIAL PRIMARY KEY,
    profile JSON NOT NULL
);
```

1. **Insert Sample Data:**
   ```sql
   INSERT INTO user_profiles (profile) VALUES 
   ('{"name": "Alice", "age": 30, "hobbies": ["reading", "traveling"]}'),
   ('{"name": "Bob", "age": 25, "hobbies": ["sports", "music"]}'),
   ('{"name": "Charlie", "age": 35, "hobbies": ["cooking", "gardening"]}');
   ```

2. **Retrieve the Length of the Hobbies Array:**
   ```sql
   SELECT id, json_array_length(profile -> 'hobbies') AS hobbies_count
   FROM user_profiles;
   ```

   - **Explanation:**
     - This query retrieves the user ID and the number of hobbies for each user by using the `json_array_length()` function on the "hobbies" array.

3. **Retrieve the Keys in the JSON Object:**
   ```sql
   SELECT id, json_object_keys(profile) AS keys
   FROM user_profiles;
   ```

   - **Explanation:**
     - This query retrieves the user ID and the keys of the JSON object for each user by using the `json_object_keys()` function.

4. **Extract Specific Values from JSON Data:**
   ```sql
   SELECT id, json_extract_path_text(profile, 'name') AS name, json_extract_path_text(profile, 'age') AS age
   FROM user_profiles;
   ```

   - **Explanation:**
     - This query retrieves the user ID, name, and age from the JSON profile data by using the `json_extract_path_text()` function.

5. **Retrieve Users from a Specific City (Extended Example):**
   - Let's extend the `user_profiles` table to include city information:
     ```sql
     INSERT INTO user_profiles (profile) VALUES 
     ('{"name": "Alice", "age": 30, "details": {"city": "New York"}}'),
     ('{"name": "Bob", "age": 25, "details": {"city": "Los Angeles"}}'),
     ('{"name": "Charlie", "age": 35, "details": {"city": "Chicago"}}');
     ```

   - Now, we can query users from a specific city:
     ```sql
     SELECT id, json_extract_path_text(profile, 'name') AS name
     FROM user_profiles
     WHERE json_extract_path_text(profile, 'details', 'city') = 'New York';
     ```

   - **Explanation:**
     - This query retrieves the user ID and name of users who live in "New York" by using the `json_extract_path_text()` function to access the "city" key within the "details" object.
