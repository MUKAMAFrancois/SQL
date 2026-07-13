-- Active: 1783963073183@@127.0.0.1@3306@mysql


-- ================================================================
-- 1. NUMERIC TYPES
-- ================================================================

-- ----------------------------------------------------------------
-- 1.1 Integer Types
-- ----------------------------------------------------------------
-- MySQL has FIVE integer widths where Postgres has three
-- (smallint, integer, bigint). TINYINT and MEDIUMINT are MySQL-only.
--
--   TINYINT   : 1 byte,  -128 to 127                    (0 to 255 unsigned)              -- no PG equivalent
--   SMALLINT  : 2 bytes, -32,768 to 32,767               (0 to 65,535 unsigned)           -- matches PG smallint
--   MEDIUMINT : 3 bytes, -8,388,608 to 8,388,607          (0 to 16,777,215 unsigned)       -- no PG equivalent
--   INT       : 4 bytes, -2,147,483,648 to 2,147,483,647  (0 to 4,294,967,295 unsigned)     -- matches PG integer/int
--   BIGINT    : 8 bytes, ~-9.22 to 9.22 quintillion        (0 to ~1.84*10^19 unsigned)       -- matches PG bigint
--
-- MISSED: nearly every MySQL numeric type accepts an UNSIGNED
-- attribute, which drops negative values and doubles the positive
-- range. Postgres has no unsigned integer types at all.

CREATE TABLE numbers (
    tiny_number     TINYINT,
    small_number    SMALLINT,
    medium_number   MEDIUMINT,
    regular_number  INT,
    large_number    BIGINT,
    unsigned_number INT UNSIGNED       -- MySQL-only: 0 to 4,294,967,295, no negatives
);

INSERT INTO numbers (tiny_number, small_number, medium_number, regular_number, large_number, unsigned_number)
VALUES (100, 12345, 800000, 123456789, 123456789012345, 4000000000);

SELECT * FROM numbers;

-- ----------------------------------------------------------------
-- 1.2 Floating Point Types
-- ----------------------------------------------------------------
--   FLOAT  : 4 bytes, approximate     -- MySQL's equivalent of PG's `real`
--   DOUBLE : 8 bytes, approximate     -- equivalent of PG's `double precision`
--           (DOUBLE PRECISION also works as a synonym for DOUBLE)

CREATE TABLE floats (
    float_number  FLOAT,
    double_number DOUBLE
);

INSERT INTO floats (float_number, double_number)
VALUES (1.2345, 1.23456789012345);

SELECT * FROM floats;

-- MISSED: DECIMAL (a.k.a. NUMERIC -- they're synonyms in MySQL) is
-- the exact fixed-point type, essential for money and anywhere
-- floating-point rounding error is unacceptable.
-- DECIMAL(M, D): M = total significant digits, D = digits after
-- the decimal point.

CREATE TABLE decimals (
    price DECIMAL(10, 2)    -- up to 10 digits total, 2 after the decimal point
);

INSERT INTO decimals (price) VALUES (1999.99);
SELECT * FROM decimals;

-- ----------------------------------------------------------------
-- 1.3 Auto-Incrementing Numbers
-- ----------------------------------------------------------------
-- MySQL has no SERIAL / BIGSERIAL *types* the way Postgres does.
-- Instead you attach the AUTO_INCREMENT attribute to an integer
-- column, almost always the primary key.
--
-- MISSED: MySQL does have a `SERIAL` keyword, but it's only
-- shorthand for `BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE` --
-- not a distinct type the way Postgres' serial is.
--
-- VERIFIED GOTCHA: unlike Postgres, where a table can have several
-- independent serial/bigserial columns, MySQL allows only ONE
-- AUTO_INCREMENT column per table, and it must be a key. Trying to
-- declare two throws:
--   ERROR 1075 (42000): Incorrect table definition; there can be
--   only one auto column and it must be defined as a key
-- so the two ID styles below have to live in separate tables.

CREATE TABLE serial_numbers (
    id INT AUTO_INCREMENT PRIMARY KEY     -- idiomatic MySQL equivalent of PG's SERIAL
);
INSERT INTO serial_numbers VALUES (DEFAULT), (DEFAULT);
SELECT * FROM serial_numbers;

CREATE TABLE big_serial_numbers (
    big_id BIGINT AUTO_INCREMENT PRIMARY KEY   -- equivalent of PG's BIGSERIAL
);
INSERT INTO big_serial_numbers VALUES (DEFAULT), (DEFAULT);
SELECT * FROM big_serial_numbers;

-- ================================================================
-- 2. CHARACTER TYPES
-- ================================================================

-- ----------------------------------------------------------------
-- 2.1 Fixed-length
-- ----------------------------------------------------------------
-- CHAR(n): fixed-length, space-padded, max 255 characters -- same
-- concept as PG's char(n).

CREATE TABLE fixed_chars (
    code CHAR(5)
);

INSERT INTO fixed_chars (code) VALUES ('ABC');

-- VERIFIED: storage is padded to 5 bytes internally, but MySQL
-- strips trailing spaces automatically on retrieval by default, so
-- this reports 3, not 5.
SELECT code, LENGTH(code) FROM fixed_chars;

-- ----------------------------------------------------------------
-- 2.2 Variable-length
-- ----------------------------------------------------------------
-- VARCHAR(n): variable-length with a limit (max ~65,535 bytes,
-- shared across the whole row) -- same concept as PG's varchar(n).
--
-- MISSED: Postgres' single unlimited `text` type maps onto a whole
-- FAMILY of types in MySQL, sized by storage capacity rather than
-- an explicit length you choose:
--   TINYTEXT   : up to 255 bytes (~255 chars)
--   TEXT       : up to 65,535 bytes (~64 KB)        -- closest everyday match to PG's `text`
--   MEDIUMTEXT : up to 16,777,215 bytes (~16 MB)
--   LONGTEXT   : up to 4,294,967,295 bytes (~4 GB)
--
-- MISSED: for binary data, MySQL's answer to PG's `bytea` is a
-- parallel family with the same size tiers, storing raw bytes with
-- no character set/collation: TINYBLOB, BLOB, MEDIUMBLOB, LONGBLOB.

CREATE TABLE variable_chars (
    short_description VARCHAR(50),
    long_description  TEXT,          -- closest match to PG's unlimited `text`
    huge_document      LONGTEXT       -- for when TEXT's ~64KB cap isn't enough
);

INSERT INTO variable_chars (short_description, long_description)
VALUES ('Short description', 'This is a much longer description that goes beyond the typical limit.');

SELECT * FROM variable_chars;

-- MISSED: ENUM and SET -- MySQL-specific inline string types with
-- no direct Postgres equivalent (Postgres needs a separate
-- `CREATE TYPE ... AS ENUM` statement; MySQL defines the allowed
-- list right on the column).
--   ENUM: exactly one value from a fixed list, stored internally as
--         a small integer
--   SET : zero or more values from a fixed list of up to 64
--         members, stored internally as a bitmap

CREATE TABLE products (
    name VARCHAR(100),
    size ENUM('small', 'medium', 'large'),           -- pick exactly one
    tags SET('sale', 'new', 'clearance', 'featured')  -- pick zero or more
);

INSERT INTO products (name, size, tags) VALUES ('T-Shirt', 'medium', 'sale,new');
SELECT * FROM products;

-- ================================================================
-- 3. DATE/TIME TYPES
-- ================================================================

-- IMPORTANT GOTCHA: Postgres' timestamp / timestamptz naming does
-- NOT map cleanly onto MySQL's DATETIME / TIMESTAMP.
--
--   DATETIME  : no time zone conversion, stored exactly as entered
--               -- equivalent of PG's plain `timestamp`
--   TIMESTAMP : stored internally as UTC, converted to the
--               session's time_zone on retrieval -- closer in
--               spirit to PG's `timestamptz`, BUT with a much
--               smaller range: 1970-01-01 00:00:01 UTC to
--               2038-01-19 03:14:07 UTC (the 32-bit Unix epoch
--               limit, the "Y2038 problem").
--
-- Rule of thumb: reach for DATETIME by default; reach for
-- TIMESTAMP only when you specifically want UTC storage +
-- session-based conversion and the 2038 ceiling is fine.

CREATE TABLE date_time_examples (
    event_date      DATE,
    event_time      TIME,
    event_datetime  DATETIME,     -- equivalent of PG's `timestamp` (no tz)
    event_timestamp TIMESTAMP     -- closer to PG's `timestamptz`, smaller range, UTC-backed
);

INSERT INTO date_time_examples (event_date, event_time, event_datetime, event_timestamp)
VALUES ('2024-07-02', '14:30:00', '2024-07-02 14:30:00', '2024-07-02 14:30:00');

SELECT * FROM date_time_examples;

-- CORRECTED ASSUMPTION: older MySQL (pre-5.6.6) implicitly gave the
-- FIRST TIMESTAMP column in a table auto-init/auto-update behavior.
-- VERIFIED against 8.0.46: that legacy behavior is now OFF by
-- default (explicit_defaults_for_timestamp = ON), so a plain
-- TIMESTAMP column with no explicit default is just NULL until you
-- set it -- confirmed empirically, a bare TIMESTAMP column left out
-- of an INSERT comes back NULL, not "now". To get auto-populated
-- timestamps you opt in explicitly:

CREATE TABLE audit_example (
    id         INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                            -- set once, on insert
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  -- refreshed on every update
);

INSERT INTO audit_example (id) VALUES (1);
SELECT * FROM audit_example;
-- Verified: created_at and updated_at both populate with the
-- current time even though neither was given a value explicitly.

DO SLEEP(1);  -- pause so the timestamps below are visibly different, second-resolution
UPDATE audit_example SET id = 2 WHERE id = 1;
SELECT * FROM audit_example;
-- Verified: updated_at moved forward one second, created_at did not.

-- MISSED: YEAR -- a MySQL-only 1-byte type storing just a year
-- (1901-2155), with no Postgres equivalent.

CREATE TABLE year_example (
    graduation_year YEAR
);

INSERT INTO year_example (graduation_year) VALUES (2026);
SELECT * FROM year_example;

-- ----------------------------------------------------------------
-- Interval / duration
-- ----------------------------------------------------------------
-- IMPORTANT GOTCHA: MySQL has NO storable INTERVAL *type*.
-- Postgres' `interval` column type has no direct MySQL equivalent.
-- INTERVAL only exists in MySQL as an *expression* used inside date
-- arithmetic (DATE_ADD / DATE_SUB) -- you cannot declare a column
-- `duration INTERVAL`.
--
-- To store a duration in MySQL, pick one of:
--   (a) TIME     -- works up to +/-838:59:59, fine for most durations
--   (b) an INT storing a count of seconds/minutes -- no upper bound
--   (c) don't store it at all -- compute it on the fly with TIMESTAMPDIFF()

CREATE TABLE intervals (
    duration_as_time    TIME,   -- e.g. '51:30:00' for 2 days 3 hours 30 minutes
    duration_in_seconds INT     -- the same duration, as 185400 seconds
);

INSERT INTO intervals (duration_as_time, duration_in_seconds)
VALUES ('51:30:00', 185400);

SELECT * FROM intervals;

-- This is where MySQL's INTERVAL keyword actually lives -- as an
-- expression inside date arithmetic, not a column type:
SELECT DATE_ADD('2024-07-02 14:30:00', INTERVAL '2 3:30:00' DAY_SECOND) AS two_days_later;
-- Verified result: 2024-07-04 18:00:00
-- (2024-07-02 14:30 + 2 days 3:30:00 = 2024-07-04 18:00:00)

-- ================================================================
-- 4. BOOLEAN TYPE
-- ================================================================

-- IMPORTANT GOTCHA: MySQL has NO native boolean storage type.
-- BOOLEAN / BOOL are just aliases for TINYINT(1), and TRUE / FALSE
-- are themselves just aliases for 1 and 0.

CREATE TABLE booleans (
    is_active   BOOLEAN,    -- really TINYINT(1) under the hood
    is_verified BOOLEAN
);

INSERT INTO booleans (is_active, is_verified) VALUES (TRUE, FALSE);
SELECT * FROM booleans;
-- Verified result: is_active=1, is_verified=0

-- VERIFIED GOTCHA: nothing stops you from putting a non-boolean
-- value into a "BOOLEAN" column, because it's really just an
-- integer underneath. Postgres would reject this outright; MySQL
-- accepts it silently, no error or warning:
INSERT INTO booleans (is_active, is_verified) VALUES (5, -3);
SELECT * FROM booleans;
-- Verified result: the row (5, -3) is stored exactly as given

-- ================================================================
-- 5. ARRAY TYPE
-- ================================================================

-- IMPORTANT GOTCHA: MySQL has NO native array type at all -- there
-- is no INT[] or TEXT[] equivalent. Where you'd reach for an array
-- in Postgres, MySQL gives you two real options:
--   (a) store the collection as a JSON array in a JSON column
--       (fine for small, mostly-read lists)
--   (b) normalize it into a separate child table with a foreign
--       key back to the parent (the relationally "correct" way,
--       and the one that stays indexable/queryable as data grows)
--
-- Option (a) below, since it's the closer visual match to the
-- original example:

CREATE TABLE arrays (
    int_array  JSON,
    text_array JSON
);

INSERT INTO arrays (int_array, text_array)
VALUES ('[1, 2, 3, 4, 5]', '["first", "second", "third"]');

SELECT * FROM arrays;

-- Option (b), the normalized alternative, for reference:
-- CREATE TABLE parent (id INT AUTO_INCREMENT PRIMARY KEY);
-- CREATE TABLE parent_values (
--     parent_id INT,
--     value     INT,
--     FOREIGN KEY (parent_id) REFERENCES parent(id)
-- );

-- ================================================================
-- 6. JSON TYPE
-- ================================================================

-- MISSED CONTEXT: Postgres splits JSON into two types -- `json`
-- (stored as plain text, re-parsed on every read) and `jsonb`
-- (stored in a binary, indexable form). MySQL (5.7.8+) has only ONE
-- json type, and it behaves like Postgres' `jsonb`: MySQL
-- automatically converts stored JSON into an internal binary format
-- for efficient access, so there's no separate "text json" choice.

CREATE TABLE json_data (
    json_info JSON
);

INSERT INTO json_data (json_info)
VALUES ('{"name": "John", "age": 30, "city": "New York"}');

CREATE TABLE jsonb_data (
    jsonb_info JSON    -- MySQL's single JSON type covers the role of both PG's json and jsonb
);

INSERT INTO jsonb_data (jsonb_info)
VALUES ('{"name": "Jane", "age": 25, "city": "San Francisco"}');

-- Querying JSON: MySQL supports the same -> and ->> operators as
-- Postgres (-> returns JSON, ->> returns an unquoted scalar).

SELECT json_info->>'$.name' AS name
FROM json_data;

SELECT jsonb_info->>'$.city' AS city
FROM jsonb_data;

-- Equivalent using explicit functions instead of the -> / ->> shorthand:
SELECT JSON_UNQUOTE(JSON_EXTRACT(json_info, '$.name')) AS name
FROM json_data;

-- MISSED: JSON_TABLE() (8.0.4+) -- turns a JSON array/object
-- straight into relational rows and columns, useful whenever you
-- need to JOIN or aggregate over JSON data like a normal table.

SELECT jt.name, jt.age
FROM json_data,
     JSON_TABLE(
         json_info,
         '$' COLUMNS (
             name VARCHAR(50) PATH '$.name',
             age  INT         PATH '$.age'
         )
     ) AS jt;
-- Verified result: name='John', age=30

-- ================================================================
-- 7. BONUS: TYPES WITH NO POSTGRES COUNTERPART AT ALL
-- ================================================================

-- MISSED: BIT(n) -- stores exact bit values, up to 64 bits. Handy
-- for compact flag fields.

CREATE TABLE bit_flags (
    permissions BIT(8)
);

INSERT INTO bit_flags (permissions) VALUES (b'00000101');
SELECT permissions + 0 AS permissions_as_int FROM bit_flags;
-- Verified result: 5 (binary 00000101 = 4 + 1)

-- MISSED: spatial types -- MySQL ships spatial data types and
-- indexing in the core server (GEOMETRY, POINT, LINESTRING,
-- POLYGON, ...). Postgres needs the separate PostGIS extension for
-- equivalent functionality. Inserting requires a WKT constructor
-- like ST_GeomFromText() -- a bare string literal is rejected.

CREATE TABLE locations (
    name        VARCHAR(100),
    coordinates POINT    -- native spatial type, no extension required
);

INSERT INTO locations (name, coordinates)
VALUES ('Kigali', ST_GeomFromText('POINT(30.0619 -1.9441)'));

SELECT name, ST_AsText(coordinates) FROM locations;
-- Verified result: Kigali | POINT(30.0619 -1.9441)