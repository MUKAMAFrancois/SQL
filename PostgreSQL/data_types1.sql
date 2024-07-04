## Lecture: SQL Basics
-- https://www.postgresql.org/docs/current/datatype.html

### 3. SQL Basics

#### Data Types

PostgreSQL supports a wide range of data types, each suited for different kinds of data storage and manipulation. Understanding these data types is fundamental to using PostgreSQL effectively.

##### Numeric Types

1. **Integer Types:**
   - `smallint`: 2-byte integer, range: -32,768 to 32,767
   - `integer` or `int`: 4-byte integer, range: -2,147,483,648 to 2,147,483,647
   - `bigint`: 8-byte integer, range: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807

   **Examples:**
   
   CREATE TABLE numbers (
       small_number SMALLINT,
       medium_number INTEGER,
       large_number BIGINT
   );

   INSERT INTO numbers (small_number, medium_number, large_number)
   VALUES (12345, 123456789, 123456789012345);
   

2. **Floating Point Types:**
   - `real`: 4-byte floating-point number
   - `double precision`: 8-byte floating-point number

--    **Examples:**
   
   CREATE TABLE floats (
       real_number REAL,
       double_number DOUBLE PRECISION
   );

   INSERT INTO floats (real_number, double_number)
   VALUES (1.2345, 1.23456789012345);
   

3. **Serial Types:**
   - `serial`: Auto-incrementing integer (4 bytes)
   - `bigserial`: Auto-incrementing integer (8 bytes)

--    **Examples:**
   
   CREATE TABLE serial_numbers (
       id SERIAL PRIMARY KEY,
       big_id BIGSERIAL
   );

   INSERT INTO serial_numbers (big_id)
   VALUES (default), (default);
   

##### Character Types

1. **Fixed-length:**
   - `char(n)`: Fixed-length character type, space-padded.

   **Examples:**
   
   CREATE TABLE fixed_chars (
       code CHAR(5)
   );

   INSERT INTO fixed_chars (code)
   VALUES ('ABC');
   

2. **Variable-length:**
   - `varchar(n)`: Variable-length character type with a limit.
   - `text`: Variable-length character type without a limit.

   **Examples:**
   
   CREATE TABLE variable_chars (
       short_description VARCHAR(50),
       long_description TEXT
   );

   INSERT INTO variable_chars (short_description, long_description)
   VALUES ('Short description', 'This is a much longer description that goes beyond the typical limit.');
   

##### Date/Time Types

1. **Date and Time:**
   - `date`: Stores date values (year, month, day).
   - `time`: Stores time of day (no time zone).
   - `timestamp`: Stores date and time (no time zone).
   - `timestamptz`: Stores date and time with time zone.

   **Examples:**
   
   CREATE TABLE date_time_examples (
       event_date DATE,
       event_time TIME,
       event_timestamp TIMESTAMP,
       event_timestamptz TIMESTAMPTZ
   );

   INSERT INTO date_time_examples (event_date, event_time, event_timestamp, event_timestamptz)
   VALUES ('2024-07-02', '14:30:00', '2024-07-02 14:30:00', '2024-07-02 14:30:00+02');
   

2. **Interval:**
   - `interval`: Represents a time span.

   **Examples:**
   
   CREATE TABLE intervals (
       duration INTERVAL
   );

   INSERT INTO intervals (duration)
   VALUES (INTERVAL '2 days 3 hours 30 minutes');
   

##### Boolean Type

- `boolean`: Stores `TRUE`, `FALSE`, or `NULL`.

**Examples:**

CREATE TABLE booleans (
    is_active BOOLEAN,
    is_verified BOOLEAN
);

INSERT INTO booleans (is_active, is_verified)
VALUES (TRUE, FALSE);


##### Array Type

- `array`: Stores a collection of values of the same data type.

**Examples:**

CREATE TABLE arrays (
    int_array INT[],
    text_array TEXT[]
);

INSERT INTO arrays (int_array, text_array)
VALUES (ARRAY[1, 2, 3, 4, 5], ARRAY['first', 'second', 'third']);   


##### JSON and JSONB

1. **JSON:**
   - `json`: Textual JSON data.

   **Examples:**
   
   CREATE TABLE json_data (
       json_info JSON
   );

   INSERT INTO json_data (json_info)
   VALUES ('{"name": "John", "age": 30, "city": "New York"}');
   

2. **JSONB:**
   - `jsonb`: Binary JSON data, optimized for storage and query.

   **Examples:**
   
   CREATE TABLE jsonb_data (
       jsonb_info JSONB
   );

   INSERT INTO jsonb_data (jsonb_info)
   VALUES ('{"name": "Jane", "age": 25, "city": "San Francisco"}');
   

**Querying JSON/JSONB:**

SELECT json_info->>'name' AS name
FROM json_data;

SELECT jsonb_info->>'city' AS city
FROM jsonb_data;