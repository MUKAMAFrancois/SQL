
create table Employeez (
    empID int AUTO_INCREMENT PRIMARY key,
    empName varchar(100) not null,
    deptName varchar(50),
    salary decimal(10,2)
    check (salary>0)
);

INSERT INTO Employeez (empName, deptName, salary) VALUES  
('Alice Johnson', 'Human Resources', 60000.00),  
('Bob Smith', 'Technology', 70000.00),  
('Charlie Brown', 'Finance', 80000.00),  
('Diana Prince', 'Marketing', 75000.00),  
('Ethan Hunt', 'Technology', 95000.00),  
('Fiona Glenanne', 'Finance', 72000.00),  
('George Washington', 'Operations', 85000.00),  
('Hannah Montana', 'Sales', 50000.00),  
('Ivy League', 'Marketing', 68000.00),  
('Jack Sparrow', 'Technology', 90000.00),  
('Kate Hudson', 'Human Resources', 62000.00),  
('Laura Croft', 'Sales', 57000.00),  
('Mickey Mouse', 'Operations', 92000.00),  
('Nancy Drew', 'Finance', 78000.00),  
('Oliver Twist', 'Marketing', 61000.00),  
('Paul Atreides', 'Research', 80000.00);