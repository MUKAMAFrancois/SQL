-- #### Data Types in SQLite

-- SQLite supports a variety of data types. Here are the most commonly used ones:



-- **1. Integer Types:**
-- - **`INTEGER`**
-- A signed integer. It can store values from -9223372036854775808 to 9223372036854775807.

-- **Example:**

CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY,
    Age INTEGER
);


-- **2. Floating-Point Types:**
-- - **`REAL`**: A floating-point number. It stores values as an 8-byte IEEE floating-point number.
-- **Example:**

CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY,
    Price REAL
);


-- **3. Text Types:**
-- - **`TEXT`**: A text string. SQLite uses the database encoding (UTF-8, UTF-16BE, or UTF-16LE) to store the string.
-- **Example:**

CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY,
    Username TEXT,
    Email TEXT
);


-- **4. Blob Types:**
-- - **`BLOB`**: A binary large object, used to store binary data (e.g., images, audio, video).

-- **Example:**

CREATE TABLE Files (
    FileID INTEGER PRIMARY KEY,
    FileData BLOB
);


-- **5. Date and Time Types:**
-- - SQLite does not have dedicated date/time types. 
-- Instead, dates and times can be stored as TEXT (ISO8601 strings), REAL (Julian day numbers), or INTEGER (Unix timestamps).

-- **Example:**


CREATE TABLE Events (
    EventID INTEGER PRIMARY KEY,
    EventName TEXT,
    EventDate TEXT -- ISO8601 string: "YYYY-MM-DD HH:MM:SS"
);


-- **6. Boolean Types:**
-- - SQLite does not have a separate boolean storage class. Instead, it uses `INTEGER` with 0 representing false and 1 representing true.
-- **Example:**

CREATE TABLE Tasks (
    TaskID INTEGER PRIMARY KEY,
    TaskName TEXT,
    IsCompleted INTEGER -- 0 for false, 1 for true
);


-- #### Example: Creating a Table with Various Data Types
-- Here is an example SQL script to create a `Users` table that uses different data types:


CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY,       -- Integer type
    Username TEXT NOT NULL,           -- Text type
    Email TEXT NOT NULL UNIQUE,       -- Text type with unique constraint
    Age INTEGER,                      -- Integer type
    Balance REAL DEFAULT 0.0,         -- Real type with default value
    ProfilePicture BLOB,              -- Blob type
    CreatedAt TEXT DEFAULT (datetime('now'))  -- Date/Time type with default value
);

