-- Active: 1768501498990@@127.0.0.1@5433@postgres@public
create table books(
  id serial PRIMARY key,
  isbn varchar (50) UNIQUE,
  authors text[],
  publication_date date,
  topics_about text[],
  price NUMERIC(10,2)
);

insert into books(isbn, authors,publication_date, topics_about, price)
values ('12-bn-drt00$jg',array['Joseph','Patrick'], '2025-04-13', array['Philosophy', 'Self-Discovery'], 7800.3);


select * from books;


-- Renaming columns: ALTER method
-- ALTER TABLE books RENAME price TO "price ($)";


INSERT INTO books (isbn, authors, publication_date, topics_about, "price ($)")
VALUES 
  ('978-0-13-235088-4', ARRAY['Robert C. Martin'], '2008-08-11', ARRAY['Software Engineering', 'Clean Code', 'Programming'], 3500.00),
  ('978-0-201-63361-0', ARRAY['Erich Gamma', 'Richard Helm', 'Ralph Johnson', 'John Vlissides'], '1994-10-31', ARRAY['Design Patterns', 'Architecture', 'OOP'], 4250.50),
  ('978-0-596-00712-6', ARRAY['Kathy Sierra', 'Bert Bates'], '2005-02-09', ARRAY['Java', 'Programming', 'Education'], 2900.00),
  ('978-1-491-95035-7', ARRAY['Martin Kleppmann'], '2017-03-16', ARRAY['Distributed Systems', 'Databases', 'Data Engineering'], 4800.75),
  ('978-0-321-12742-6', ARRAY['Martin Fowler'], '2002-11-15', ARRAY['Software Architecture', 'Enterprise', 'Patterns'], 5100.20),
  ('978-1-617-29223-1', ARRAY['Raoul-Gabriel Urma', 'Mario Fusco', 'Alan Mycroft'], '2014-08-28', ARRAY['Java', 'Functional Programming'], 3100.40),
  ('978-0-134-19044-0', ARRAY['Ned Williams', 'Sarah Jenkins'], '2021-11-05', ARRAY['Cybersecurity', 'Network Security', 'Linux'], 3990.00),
  ('978-0-596-52068-7', ARRAY['Ben Forta'], '2007-08-24', ARRAY['SQL', 'Databases', 'Query Optimization'], 1850.10),
  ('978-1-119-05655-3', ARRAY['Michael Freeman', 'Joel Ross'], '2018-12-14', ARRAY['Data Science', 'R Programming', 'Data Visualization'], 4400.00),
  ('978-0-132-35613-8', ARRAY['Joshua Bloch'], '2018-01-08', ARRAY['Java', 'Programming Best Practices'], 3750.85);




