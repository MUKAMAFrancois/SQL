-- SQL request(s)​​​​​​‌​‌‌​‌​‌​‌‌‌​‌‌​​​​​​‌​‌​ below
SELECT 
 NAME AS "Track Name",
 COMPOSER AS Composer,
 UNITPRICE AS Price,
 CASE
  WHEN UNITPRICE<=0.99 THEN 'Budget'
  WHEN UNITPRICE BETWEEN 1.0 AND 1.49 THEN 'Regular'
  WHEN UNITPRICE BETWEEN 1.50 AND 1.99 THEN 'Premium'
  ELSE 'Exclusive'
 END AS PriceCategory
FROM Track
ORDER BY
 UNITPRICE;



--- Challenge 2

-- SQL request(s)​​​​​​‌​‌‌​‌​‌​‌‌‌‌‌‌‌​​‌​​‌‌‌‌ below
SELECT 
c.FIRSTNAME||' '||c.LASTNAME AS CustomerFullName,
substr(c.POSTALCODE,1,5) AS StandardizedPostalCode
FROM Customer AS c
WHERE c.COUNTRY = 'USA'
ORDER BY CustomerFullName


--- Challenge 3

SELECT 
    t.TRACKID AS "Track ID",
    t.NAME AS "Track Name",
    t.COMPOSER AS Composer,
    g.NAME AS Genre
FROM 
    Track AS t
JOIN 
    Genre AS g ON t.GENREID = g.GENREID
WHERE 
    t.TRACKID NOT IN (
        SELECT DISTINCT 
            li.TRACKID 
        FROM 
            InvoiceLine AS li
    )
ORDER BY "Track Name" ASC;
