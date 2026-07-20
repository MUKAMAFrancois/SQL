create DATABASE IF NOT EXISTS relationships;
use relationships;

-- one to many relationship

CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);


CREATE TABLE employees(
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50) not null,
    dept_id int,

    Foreign Key (dept_id) REFERENCES departments(dept_id) on delete set null
);

-- Seed Data
INSERT INTO departments (dept_name) VALUES ('Data Science'), ('DevOps');
INSERT INTO employees (emp_name, dept_id) VALUES 
('Placide', 1), 
('Mukama', 1), 
('Alice', 2);

-- many to many relationship

create Table students(
    student_id int AUTO_INCREMENT PRIMARY key,
    student_name VARCHAR(60) not null
);

create table courses(
    course_id int AUTO_INCREMENT PRIMARY key,
    course_name VARCHAR(70) not null
);

create table student_course_junction(
    student_id int,
    course_id int,
    enrolled_at TIMESTAMP DEFAULT(CURRENT_TIMESTAMP),

    Foreign Key (student_id) REFERENCES students(student_id) on DELETE CASCADE,

    Foreign Key (course_id) REFERENCES courses(course_id) on DELETE CASCADE
);

-- Seed Data
INSERT INTO students (student_name) VALUES ('John'), ('Sarah');
INSERT INTO courses (course_name) VALUES ('Machine Learning 101'), ('Docker Deep Dive');

-- Enrollement

insert into student_course_junction(student_id, course_id) VALUES(1,1),(1,2),(2,1),(2,2);

-- showing a student with their enrolled courses.

SELECT st.student_id, st.student_name, c.course_name
from student_course_junction as junc
join students as st on junc.student_id = st.student_id
join courses as c on junc.course_id = c.course_id

order by st.student_id



-- ############ JOINS #############

create table authors( 
    author_id int AUTO_INCREMENT PRIMARY KEY,
    author_name varchar(50) not null
    );

create table books ( 
    book_id int AUTO_INCREMENT PRIMARY key,
    book_title VARCHAR(80) UNIQUE,
    bk_author_id int,
    price DECIMAL(10,2),

    Foreign Key (bk_author_id) REFERENCES authors(author_id) on DELETE CASCADE
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO authors (author_name) VALUES ('Aristotle'), ('Christopher Bishop'), ('Richard McElreath');

INSERT INTO books (book_title, bk_author_id, price) VALUES 
('De Anima', 1, 25.00),
('Pattern Recognition and Machine Learning', 2, 85.00),
('Statistical Rethinking', 3, 75.00),
('The Metaphysics', 1, 30.00),
('Placeholder Unauthored Book', NULL, 15.00); -- Book with no author


INSERT INTO customers (customer_name, email) VALUES ('Placide', 'placide@test.com'), ('Eric', 'eric@test.com'), ('Alex', 'alex@test.com');
INSERT INTO orders (customer_id, order_date, amount) VALUES 
(1, '2026-07-10', 110.00), -- Placide bought something
(2, '2026-07-12', 75.00);   -- Eric bought something
-- Alex has no orders yet!

select bks.book_id, bks.book_title, auth.author_name
from books bks 
inner join authors auth on bks.bk_author_id = auth.author_id

ORDER BY bks.book_id

select * from books bk
INNER join authors auth on bk.bk_author_id = auth.author_id

-- full join.

select bk.book_title, auth.author_name from books bk left join authors auth on bk.bk_author_id = auth.author_id

UNION

select bk.book_title,auth.author_name from books bk RIGHT JOIN authors auth on bk.bk_author_id = auth.author_id

-- ## self-join  

select bk1.book_id,bk1.book_title, auth.author_name, bk2.price   from books bk1
inner join books bk2 on bk1.bk_author_id = bk2.bk_author_id
INNER JOIN authors auth on bk1.bk_author_id = auth.author_id