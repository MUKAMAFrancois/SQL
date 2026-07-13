create table workers (
worker_id smallint primary key,
worker_name varchar(30),
worker_email varchar(50),
is_married boolean,
date_of_birth date,
salary integer,
nationality varchar(15)
);


INSERT INTO workers (
    worker_id, 
    worker_name, 
    worker_email, 
    is_married, 
    date_of_birth, 
    salary, 
    nationality
) 
VALUES 
    (1, 'Alice Johnson', 'alice.j@example.com', true,  '1985-05-12', 75000, 'USA'),
    (2, 'Mateo Rossi',   'm.rossi@example.it',  false, '1992-08-24', 62000, 'Italy'),
    (3, 'Yuki Tanaka',   'y.tanaka@corp.jp',    true,  '1978-11-30', 95000, 'Japan'),
    (4, 'Amara Diop',    'amara.diop@web.sn',   false, '1995-02-15', 54000, 'Senegal'),
    (5, 'Sven Nilsson',  'sven.n@nordic.se',    true,  '1988-07-03', 82000, 'Sweden'),
    (6, 'Elena Petrova', 'e.petrova@mail.ru',   false, '1990-12-10', 68000, 'Russia'),
    (7, 'Carlos Ruiz',   'c.ruiz@pilar.es',     true,  '1983-04-21', 71000, 'Spain');
