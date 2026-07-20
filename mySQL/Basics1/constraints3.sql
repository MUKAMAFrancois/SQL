-- Active: 1783963073183@@127.0.0.1@3306@lesson3

create database lesson3;

use lesson3;

CREATE DATABASE IF NOT EXISTS lesson_three;
USE lesson_three;

DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

create table departments(
    dep_id int AUTO_INCREMENT PRIMARY key,
    dep_name varchar(40) not null DEFAULT "IT" UNIQUE,

    CONSTRAINT department_allowed_names
        check (
            dep_name in ("IT", "Marketing", "Software", "Research", "AI")
        )
);

insert into departments (dep_name)
values("AI");

CREATE TABLE employees(
    emp_id int AUTO_INCREMENT PRIMARY key,
    department_id int,
    full_names varchar(50) not null,
    email varchar(50) not null unique,

    Foreign Key (department_id) REFERENCES departments(dep_id) on delete set null
);


create table salaries(
    employee_id int,
    from_date DATE DEFAULT "2024-01-01",
    end_date DATE DEFAULT(CURRENT_DATE),
    salary_amount DECIMAL(10,2),

    check (
        salary_amount > 0.0
    ),

    Foreign Key (employee_id) REFERENCES employees(emp_id)
);

---- iNSERTING VALUES


insert into employees(department_id,full_names,email)
values (3,"Andrew Katy", "Andrew@cmu.edu");

select * from employees;