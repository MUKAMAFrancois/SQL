-- 1. calculates the difference between the total count of cities and the count of distinct cities in the STATION table.
SELECT   
    (SELECT COUNT(CITY) FROM STATION) -   
    (SELECT COUNT(DISTINCT CITY) FROM STATION) AS difference;

-- 2. 