
SELECT *,

CAST(CUME_DIST() OVER(PARTITION BY department ORDER BY marks) AS DECIMAL(10,2)) AS cum_dist
FROM students;