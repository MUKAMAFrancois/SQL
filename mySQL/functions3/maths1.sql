-- First, let's create a sample table to demonstrate these functions
CREATE TABLE math_examples (
    num1 DECIMAL(10,2),
    num2 DECIMAL(10,2)
);

INSERT INTO math_examples VALUES 
    (-23.45, 2),
    (15.791, 3),
    (144, 2),
    (2, 8),
    (100, 0.5);


1. Basic Arithmetic Functions:

-- ABS() - Absolute value
SELECT 
    num1,
    ABS(num1) as absolute_value
FROM math_examples;
-- Example: ABS(-23.45) = 23.45

-- ROUND() - Rounds a number
SELECT 
    num1,
    ROUND(num1) as rounded_number,           -- Rounds to integer
    ROUND(num1, 1) as rounded_one_decimal    -- Rounds to 1 decimal place
FROM math_examples;
-- Example: ROUND(15.791, 1) = 15.8

-- CEIL() and FLOOR()
SELECT 
    num1,
    CEIL(num1) as ceiling,    -- Rounds up to nearest integer
    FLOOR(num1) as floor     -- Rounds down to nearest integer
FROM math_examples;
-- Example: CEIL(15.791) = 16, FLOOR(15.791) = 15


2. Power and Root Functions:

-- POWER() or POW() - Raises a number to specified power
SELECT 
    num1,
    num2,
    POWER(num1, num2) as power_result
FROM math_examples;
-- Example: POWER(2, 8) = 256

-- SQRT() - Square root
SELECT 
    num1,
    SQRT(ABS(num1)) as square_root    -- Using ABS to handle negative numbers
FROM math_examples;
-- Example: SQRT(144) = 12


3. Logarithmic Functions:

-- LOG() - Natural logarithm
SELECT 
    num1,
    LOG(ABS(num1)) as natural_log
FROM math_examples
WHERE num1 > 0;
-- Example: LOG(100) ≈ 4.605

-- LOG10() - Base-10 logarithm
SELECT 
    num1,
    LOG10(ABS(num1)) as log_base_10
FROM math_examples
WHERE num1 > 0;
-- Example: LOG10(100) = 2

-- LOG2() - Base-2 logarithm
SELECT 
    num1,
    LOG2(ABS(num1)) as log_base_2
FROM math_examples
WHERE num1 > 0;
-- Example: LOG2(8) = 3


4. Trigonometric Functions:

-- SIN(), COS(), TAN()
SELECT 
    PI() as pi,
    SIN(PI()/2) as sine_90_degrees,
    COS(PI()) as cosine_180_degrees,
    TAN(PI()/4) as tangent_45_degrees;

-- ASIN(), ACOS(), ATAN() - Inverse trig functions
SELECT 
    ASIN(1) as arcsin_1,
    ACOS(-1) as arccos_minus_1,
    ATAN(1) as arctan_1;


5. Rounding and Sign Functions:

-- TRUNCATE() - Truncates without rounding
SELECT 
    num1,
    TRUNCATE(num1, 1) as truncated_1_decimal,
    TRUNCATE(num1, 0) as truncated_integer
FROM math_examples;
-- Example: TRUNCATE(15.791, 1) = 15.7

-- SIGN() - Returns -1, 0, or 1
SELECT 
    num1,
    SIGN(num1) as number_sign
FROM math_examples;
-- Returns: -1 for negative, 0 for zero, 1 for positive


6. Additional Mathematical Functions:

-- MOD() - Modulo operation
SELECT 
    17,
    MOD(17, 5) as remainder;  -- Returns 2

-- RAND() - Random number between 0 and 1
SELECT 
    RAND() as random_number,
    FLOOR(RAND() * 100) as random_0_to_99;

-- DEGREES() and RADIANS() - Conversion
SELECT 
    180 as degrees,
    RADIANS(180) as in_radians,
    DEGREES(PI()) as in_degrees;


7. Combining Functions:

-- Complex calculations
SELECT 
    num1,
    ROUND(SQRT(ABS(num1)), 2) as rounded_sqrt,
    POWER(ROUND(num1, 0), 2) as rounded_squared
FROM math_examples;

-- Statistical calculations
SELECT 
    COUNT(*) as count,
    ROUND(AVG(num1), 2) as average,
    ROUND(STD(num1), 2) as standard_deviation,
    ROUND(VARIANCE(num1), 2) as variance
FROM math_examples;


-- Key Points to Remember:
-- 1. Always handle potential NULL values
-- 2. Consider using ABS() with SQRT() to avoid errors with negative numbers
-- 3. Be careful with precision in floating-point calculations
-- 4. Use appropriate rounding for financial calculations
-- 5. Consider performance when using complex mathematical functions on large datasets
