-- Join is a command that combines fields from two or more tables.
-- You can see how tables are connected on ERD: Entity Relationsl Database

/* Types of Joins


-- Joins in SQLite are used to combine rows
--  from two or more tables based on a related
-- column between them. There are several types of joins:

-- INNER JOIN
-- LEFT JOIN (or LEFT OUTER JOIN)
-- RIGHT JOIN (or RIGHT OUTER JOIN)
-- FULL JOIN (or FULL OUTER JOIN)
-- CROSS JOIN

*/

/*

consider three tables: Invoice(invoiceId,customerId,....)
                      Customers(customerId,.....supportEmpId(from employees))
                      Employees(empId,......)

*/

SELECT 
 e.firstName,
 e.lastName,
 e.employeeId,
 c.firstName,
 c.lastName,
 c.supportEmpId,
 i.customerId,
 i.total
from Invoice As i 
 INNER JOIN Customers As c 
  ON i.customerId=c.customerId
  INNER JOIN Employees AS e 
   ON c.supportEmpId = e.empId

ORDER BY i.total DESC
 LIMIT 10