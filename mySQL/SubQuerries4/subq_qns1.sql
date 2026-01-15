-- Active: 1737121311446@@127.0.0.1@3306@online_store
-- Create tables
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(10,2),
    stock INT,
    publication_date DATE
);

CREATE TABLE oders (
    order_id INT PRIMARY KEY,
    book_id INT,
    customer_id INT,
    order_date DATE,
    quantity INT,
    order_status VARCHAR(20),
    total_amount DECIMAL(10,2)
);

-- Insert sample data for books
INSERT INTO books VALUES
(1, 'The Lost City', 'Sarah Connor', 'Adventure', 24.99, 45, '2023-01-15'),
(2, 'Data Science Basics', 'John Smith', 'Educational', 49.99, 30, '2023-03-20'),
(3, 'Midnight Tales', 'Emma Wilson', 'Horror', 19.99, 60, '2023-02-10'),
(4, 'Cooking Masterclass', 'Chef Roberto', 'Cooking', 34.99, 25, '2023-04-05'),
(5, 'Python Programming', 'David Miller', 'Educational', 44.99, 35, '2023-01-30'),
(6, 'Summer Love', 'Lisa Chen', 'Romance', 14.99, 80, '2023-05-15'),
(7, 'History of Rome', 'Marcus Augustus', 'History', 29.99, 40, '2023-03-01'),
(8, 'Garden Design', 'Mary Johnson', 'Home & Garden', 27.99, 20, '2023-04-20'),
(9, 'Mystery Manor', 'James Black', 'Mystery', 21.99, 55, '2023-02-28'),
(10, 'Fitness Guide', 'Tom Harris', 'Health', 31.99, 30, '2023-05-01'),
(11, 'JavaScript Deep Dive', 'Alice Brown', 'Educational', 54.99, 25, '2023-03-15'),
(12, 'Poetry Collection', 'Robert Frost Jr.', 'Poetry', 16.99, 40, '2023-04-10'),
(13, 'Business Strategy', 'Michael Porter', 'Business', 39.99, 35, '2023-01-20'),
(14, 'Space Explorers', 'Neil Armstrong Jr.', 'Science Fiction', 22.99, 50, '2023-05-05'),
(15, 'Art History', 'Isabella Arte', 'Art', 45.99, 20, '2023-02-15');

-- Insert sample data for oders
INSERT INTO oders VALUES
(1, 3, 101, '2024-01-01', 2, 'Delivered', 39.98),
(2, 1, 102, '2024-01-02', 1, 'Delivered', 24.99),
(3, 5, 103, '2024-01-03', 3, 'Pending', 134.97),
(4, 2, 104, '2024-01-03', 1, 'Delivered', 49.99),
(5, 7, 105, '2024-01-04', 2, 'Shipped', 59.98),
(6, 4, 106, '2024-01-05', 1, 'Delivered', 34.99),
(7, 8, 107, '2024-01-06', 2, 'Cancelled', 55.98),
(8, 10, 108, '2024-01-07', 1, 'Delivered', 31.99),
(9, 12, 109, '2024-01-08', 3, 'Shipped', 50.97),
(10, 15, 110, '2024-01-09', 1, 'Pending', 45.99),
(11, 11, 111, '2024-01-10', 2, 'Delivered', 109.98),
(12, 6, 112, '2024-01-11', 4, 'Delivered', 59.96),
(13, 9, 113, '2024-01-12', 1, 'Pending', 21.99),
(14, 13, 114, '2024-01-13', 2, 'Shipped', 79.98),
(15, 14, 115, '2024-01-14', 3, 'Delivered', 68.97);



/*
1. Find all books that have a price higher than the average price of all books in the same genre.

2. List the titles of books that have never been ordered.

3. Find customers who have placed orders with total amounts greater than the average order amount.

4. List the books that have more units sold than the average quantity sold per book.

5. Find all orders that include books from the 'Educational' genre, and show the order details including book title.

6. Identify books that have both above-average price and above-average stock levels in their respective genres.

7. Find the customers who have ordered books written by 'John Smith' or 'David Miller', and show their total spending on these authors' books.

These questions will help you practice different types of subqueries including:
- Correlated subqueries
- Nested subqueries
- Subqueries in SELECT, FROM, and WHERE clauses
- Subqueries with aggregates
*/