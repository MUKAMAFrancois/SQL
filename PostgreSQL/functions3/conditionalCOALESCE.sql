-- COALESCE evaluates its arguments from left to right.
-- It returns the first non-NULL value it encounters.
-- Once it finds a non-NULL value, it stops checking the remaining arguments.

-- ex1: 
SELECT 
    CASE 
        WHEN email IS NOT NULL AND phone IS NOT NULL THEN email || ', ' || phone
        ELSE COALESCE(email, phone, 'No contact')
    END AS contact
FROM customers;



-- Here are some more examples and use cases for COALESCE in Postgre:

-- 1. Default values in SELECT statements:
   
   SELECT username, COALESCE(full_name, username) AS display_name
   FROM users;
   
--    This displays the full_name if available, otherwise falls back to the username.

-- 2. Handling NULL in calculations:
   
   SELECT product_name, 
          COALESCE(price, 0) * quantity AS total_value
   FROM inventory;
   
--    This ensures that even if price is NULL, the calculation does not result in NULL.

-- 3. Combining multiple columns:
   
   SELECT COALESCE(home_phone, cell_phone, work_phone, 'Unknown') AS contact_number
   FROM contacts;
   
   -- This selects the first available phone number from multiple columns.

-- 4. In WHERE clauses:
   
   SELECT *
   FROM orders
   WHERE COALESCE(shipping_date, current_date) <= current_date;
   
   -- This includes orders where shipping_date is NULL, treating them as if they were shipped today.

-- 5. Grouping with potential NULL values:
   
   SELECT COALESCE(department, 'Unassigned') AS dept, COUNT(*) AS employee_count
   FROM employees
   GROUP BY COALESCE(department, 'Unassigned');
   
   -- This ensures that employees with NULL department are grouped together under 'Unassigned'.

-- 6. In UPDATE statements:
   
   UPDATE products
   SET description = COALESCE(new_description, description, 'No description available');
   
-- This updates the description to new_description if it's not NULL, 
-- otherwise keeps the existing description, or sets a default if both are NULL.

