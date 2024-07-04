CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author_id INT REFERENCES authors(id)
);

CREATE TABLE book_sales (
    id SERIAL PRIMARY KEY,
    book_id INT REFERENCES books(id),
    sale_date DATE NOT NULL,
    quantity INT NOT NULL
);


SELECT 
 auth.name AS "Author Name",
 bk.title AS "Book Title",
 sales.quantity AS "Pages",
 sales.sale_date AS "Sold Date"
 FROM authors AS auth
 INNER JOIN books AS bk
 ON auth.id = bk.author_id
 INNER JOIN book_sales AS sales
 ON bk.id=sales.book_id
ORDER BY sales.sale_date;




SELECT 
 auth.name AS "Author Name",
 bk.title AS "Book Title",
 sales.quantity AS "Pages",
 sales.sale_date AS "Sold Date"
 FROM authors AS auth
 FULL OUTER JOIN books AS bk
 ON auth.id = bk.author_id
 FULL OUTER JOIN book_sales AS sales
 ON bk.id=sales.book_id
ORDER BY sales.sale_date;



SELECT 
 auth.name AS "Author Name",
 bk.title AS "Book Title",
 sales.quantity AS "Pages",
 sales.sale_date AS "Sold Date"
 FROM authors AS auth
 LEFT JOIN books AS bk
 ON auth.id = bk.author_id
 LEFT JOIN book_sales AS sales
 ON bk.id=sales.book_id
ORDER BY sales.sale_date;




SELECT 
 auth.name AS "Author Name",
 bk.title AS "Book Title",
 sales.quantity AS "Pages",
 sales.sale_date AS "Sold Date"
 FROM authors AS auth
 RIGHT JOIN books AS bk
 ON auth.id = bk.author_id
 RIGHT JOIN book_sales AS sales
 ON bk.id=sales.book_id
ORDER BY sales.sale_date;