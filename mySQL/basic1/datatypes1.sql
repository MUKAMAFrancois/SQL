1. Numeric Types


Integer Types
TINYINT    -- -128 to 127 (or 0 to 255 if UNSIGNED)
SMALLINT   -- -32,768 to 32,767
MEDIUMINT  -- -8,388,608 to 8,388,607
INT        -- -2,147,483,648 to 2,147,483,647
BIGINT     -- -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807

-- Example table with different integer types
CREATE TABLE product_inventory (
    item_id INT PRIMARY KEY,
    quantity SMALLINT,
    total_sold MEDIUMINT,
    revenue BIGINT
);

-- Decimal/Float Types
DECIMAL(precision, scale)  -- Exact decimal numbers
FLOAT                     -- Approximate decimal numbers
DOUBLE                    -- Double precision floating point

-- Example with precise monetary values (always use DECIMAL for money)
CREATE TABLE transactions (
    transaction_id INT,
    amount DECIMAL(10,2),    -- 8 digits before decimal, 2 after (e.g., 12345678.90)
    approximate_value FLOAT  -- Less precise but uses less storage
);


-- 2. String Types


-- Fixed and Variable Length Strings
CHAR(size)      -- Fixed length string, max 255 characters
VARCHAR(size)   -- Variable length string, max 65,535 characters
TEXT            -- Variable length string, max 65,535 bytes
MEDIUMTEXT      -- Variable length string, max 16.7 million bytes
LONGTEXT        -- Variable length string, max 4.2GB

-- Example using different string types
CREATE TABLE user_content (
    username CHAR(20),           -- Fixed length for usernames
    email VARCHAR(255),          -- Variable length for emails
    bio TEXT,                   -- Longer text for user bios
    blog_post MEDIUMTEXT        -- Very long text for blog content
);


3. Date and Time Types


-- Date/Time Types
DATE            -- Format: 'YYYY-MM-DD'
TIME            -- Format: 'HH:MM:SS'
DATETIME        -- Format: 'YYYY-MM-DD HH:MM:SS'
TIMESTAMP       -- Like DATETIME but converts to UTC for storage
YEAR            -- 2 or 4 digit year

-- Example with various date/time fields
CREATE TABLE events (
    event_id INT,
    event_date DATE,
    start_time TIME,
    created_at DATETIME,
    last_updated TIMESTAMP,
    event_year YEAR
);

-- Example inserting date/time values
INSERT INTO events VALUES (
    1,
    '2025-01-17',
    '14:30:00',
    '2025-01-17 14:30:00',
    CURRENT_TIMESTAMP,
    2025
);


4. Boolean Type


-- Boolean (Actually stored as TINYINT(1))
BOOLEAN or BOOL    -- TRUE (1) or FALSE (0)

CREATE TABLE user_settings (
    user_id INT,
    is_active BOOLEAN,
    notifications_enabled BOOL
);

-- Example with boolean values
INSERT INTO user_settings VALUES (1, TRUE, FALSE);


5. Binary and BLOB Types


-- Binary Types
BINARY(n)      -- Fixed-length binary string
VARBINARY(n)   -- Variable-length binary string
BLOB           -- Binary Large Object
MEDIUMBLOB     -- Larger binary object
LONGBLOB       -- Very large binary object

-- Example storing binary data
CREATE TABLE documents (
    doc_id INT,
    file_name VARCHAR(255),
    content BLOB,
    large_content LONGBLOB
);


6. JSON Type (Added in MySQL 5.7+)


-- JSON Type
JSON    -- Stores JSON documents

CREATE TABLE user_preferences (
    user_id INT,
    preferences JSON
);

-- Example inserting and querying JSON
INSERT INTO user_preferences VALUES (
    1, 
    '{"theme": "dark", "language": "en", "notifications": {"email": true, "push": false}}'
);

-- Query JSON data
SELECT user_id, 
       JSON_EXTRACT(preferences, '$.theme') as theme,
       JSON_EXTRACT(preferences, '$.notifications.email') as email_notifications
FROM user_preferences;


-- Some important notes:
-- - MySQL doesn't have a native SERIAL type like PostgreSQL - instead, use AUTO_INCREMENT with INT
-- - MySQL doesn't have native ARRAY types - you can use JSON or normalized tables instead
-- - MySQL doesn't have INTERVAL as a data type - you can store intervals as INT/BIGINT representing seconds or use datetime arithmetic
-- - There's no JSONB type in MySQL (that's PostgreSQL) - MySQL's JSON type handles both storage and binary processing.