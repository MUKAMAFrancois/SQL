-- Active: 1737121311446@@127.0.0.1@3306@company

-- Create 'Customers' table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Country VARCHAR(50),
    Phone VARCHAR(15)
);

-- Create 'Orders' table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2),
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create 'Products' table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Create 'OrderDetails' table
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- ==========//

INSERT INTO Customers (Name, Email, Country, Phone) VALUES
('Alice Johnson', 'alice.johnson@example.com', 'USA', '1234567890'),
('Bob Smith', 'bob.smith@example.com', 'UK', '2345678901'),
('Charlie Lee', 'charlie.lee@example.com', 'Canada', '3456789012'),
('Diana Green', 'diana.green@example.com', 'Australia', '4567890123'),
('Eve Brown', 'eve.brown@example.com', 'USA', '5678901234');


INSERT INTO Products (Name, Category, Price) VALUES
('Laptop', 'Electronics', 899.99),
('Smartphone', 'Electronics', 499.99),
('Desk Chair', 'Furniture', 149.99),
('Coffee Table', 'Furniture', 199.99),
('Headphones', 'Electronics', 59.99);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status) VALUES
(1, '2025-01-01', 1349.96, 'Shipped'),
(2, '2025-01-02', 199.99, 'Pending'),
(3, '2025-01-03', 559.98, 'Delivered'),
(4, '2025-01-04', 299.98, 'Cancelled'),
(5, '2025-01-05', 499.99, 'Shipped');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),
(1, 3, 3),
(2, 4, 1),
(3, 2, 1),
(3, 5, 2),
(4, 3, 2),
(5, 2, 1);


-- JOINS

select * from Customers;

-- 1. Orders and Customers.

select cus.`CustomerID`, cus.`Name`, ord.`OrderDate`,ord.`TotalAmount`,ord.`Status`
from customers cus INNER JOIN orders AS ord ON cus.`CustomerID` = ord.`CustomerID`;


--2 .  Left Join: All Customers with their Orders

SELECT c.CustomerID, c.Name, o.OrderID, o.OrderDate, o.TotalAmount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;


-- 3. Right Join: All Orders with Customer Info

SELECT ord.`OrderID`,
    ord.`OrderDate`,
    ord.`TotalAmount`, 
    cust.`Name` AS 'Client Name', 
    cust.`Country`, 
    CONCAT(cust.`Email`, " , ",cust.`Phone`) AS Address
FROM orders ord RIGHT JOIN customers AS cust ON ord.`CustomerID` = cust.`CustomerID`;

-- 4. Full Outer Join (Emulated with UNION)

select
    cust.`CustomerID`, 
    cust.`Country`,
    cust.`Name`, 
    ord.`OrderDate`,
    ord.`Status`,
    ordt.`Quantity`, 
    ord.`TotalAmount`
from customers cust LEFT JOIN orders ord 
ON cust.`CustomerID` = ord.`CustomerID` 
LEFT JOIN orderdetails ordt 
ON ord.`OrderID` = ordt.`OrderID`

UNION

select
    cust.`CustomerID`, 
    cust.`Country`,
    cust.`Name`, 
    ord.`OrderDate`,
    ord.`Status`,
    ordt.`Quantity`, 
    ord.`TotalAmount`
from customers cust RIGHT JOIN orders ord 
ON cust.`CustomerID` = ord.`CustomerID` 
RIGHT JOIN orderdetails ordt 
ON ord.`OrderID` = ordt.`OrderID`;

