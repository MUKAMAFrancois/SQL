
drop table if exists workerz;

create table workerz (
worker_id serial primary key,
worker_name varchar(30),
worker_email varchar(50),
is_married boolean,
date_of_birth date,
salary integer,
nationality varchar(15)
);

INSERT INTO workerz (
    worker_name, 
    worker_email, 
    is_married, 
    date_of_birth, 
    salary, 
    nationality
) 
VALUES 
    ('Alice Johnson', 'alice.j@example.com', true,  '1985-05-12', 75000, 'USA'),
    ('Mateo Rossi',   'm.rossi@example.it',  false, '1992-08-24', 62000, 'Italy'),
    ('Yuki Tanaka',   'y.tanaka@corp.jp',    true,  '1978-11-30', 95000, 'Japan'),
    ('Amara Diop',    'amara.diop@web.sn',   false, '1995-02-15', 54000, 'Senegal'),
    ('Sven Nilsson',  'sven.n@nordic.se',    true,  '1988-07-03', 82000, 'Sweden'),
    ('Elena Petrova', 'e.petrova@mail.ru',   false, '1990-12-10', 68000, 'Russia'),
    ('Carlos Ruiz',   'c.ruiz@pilar.es',     true,  '1983-04-21', 71000, 'Spain');


-- select * from workerz where salary > 70000 order by salary desc;


-- =========================================================

