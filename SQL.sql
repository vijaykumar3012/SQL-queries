DROP DATABASE empdb;

CREATE DATABASE empdb;

USE empdb;

-- Before Constraints and Normalization
CREATE TABLE Employee
(
    id int,
	first_name varchar(50),
    last_name varchar(50),
    department varchar(50),
    country varchar(50),
	email varchar(50),
    contact_no varchar(80),
    salary DECIMAL(10,2),
    hire_date DATE
);

DESC Employee;

-- Single Insert
INSERT INTO Employee (id,first_name,last_name,department,country,email,contact_no,salary,hire_date) 
VALUES (1,'John','Doe','IT','USA','johndoe@gmail.com','+41 9854752365',50000,'2025-12-31');

Select * FROM Employee;

-- BULK INSERT
INSERT INTO Employee (id, first_name, last_name, department, country, email,contact_no, salary, hire_date) VALUES 
(2,'Alice', 'Johnson', 'HR','United States' ,'johndoe@gmail.com','+41 975428365' ,null, '2025-12-31'),
(3,'Jane', null,'Information Technology',null , 'janesmith@gmail.com','+1 9854752365,012345789', 70000.00, '2024-11-30'),
(1,'Jane', 'marry','Finance', null ,'janesmarry@gmail.com','0123456789', -30000.00, '2024-11-30');
Select * FROM Employee;

DROP TABLE Employee;

-- After Contraints 
CREATE TABLE Employee
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name varchar(50) not null,
    last_name varchar(50) not null,
    department varchar(50) not null,
    country varchar(50) not null,
	email varchar(50) unique not null,
	contact_no varchar(80),
    salary DECIMAL(10,2) DEFAULT 0.00,
    hire_date DATE,
    CHECK (salary >= 0)
);

-- Bulk Insert
INSERT INTO Employee (first_name, last_name, department, country, email,contact_no, salary, hire_date) VALUES 
('John', 'Doe', 'IT','USA', 'johndoe@gmail.com','+41 9854752365', 50000.00, '2025-12-31'),
('Jane', 'Smith', 'HR','United States','janesmith@gmail.com','+41 975428365', 60000.00, '2024-11-30'),
('Alice', 'Johnson','Finance','RUS','alicejohnson@gmail.com','+1 9854752365,012345789', 55000.00, '2023-10-15'),
('Bob', 'Brown', 'IT','Russia', 'bobbrown@gmail.com','0123456789', 62000.00, '2022-09-10'),
('Charlie', 'Davis', 'HR','India', 'charliedavis@gmail.com','9876543210', 58000.00, '2021-08-20');

SELECT * FROM Employee;

-- Safe Update
UPDATE Employee SET email = 'johndoeUpdate@gmail.com' where Id=1;

-- Safe Delete
DELETE  FROM Employee where Id=1;

DELETE FROM Employee;

SELECT * FROM Employee;

DROP TABLE Employee;

-- Normalization
-- Divides the large table into small tables, then link them with relationship for primary key and foregin key 
-- APT
-- 1NF Atomic Value
-- 2NF No Partial Dependnecy - All Columns in Table belongs to primary key
-- 3NF No Transitive Dependency  

USE empdb;

CREATE TABLE Department 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

INSERT INTO Department (name) VALUES ('Information Technology'),('Devops'),('Testing'),('HR'),('Accounts');

CREATE TABLE Country 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    short_name CHAR(3) NOT NULL
);

DESC Country;

INSERT INTO Country (name,short_name) VALUES ('India','IND'),('United States','USA'),('Russia','RUS'),('China','CHN');

SELECT * FROM Department;

SELECT * FROM Country;

CREATE TABLE Employee
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name varchar(50) not null,
    last_name varchar(50) not null,
	email varchar(50) unique not null,
	landline varchar(80),
    mobile varchar(80),
    salary DECIMAL(10,2) DEFAULT 0.00,
    hire_date DATE,
	department VARCHAR(100) NOT NULL, 
    country VARCHAR(100) NOT NULL, 
	department_id int not null,
    country_id int not null,
    FOREIGN KEY (department_id) REFERENCES Department(id),
    FOREIGN KEY(country_id) REFERENCES Country(id),
    CHECK (salary >= 0)
);

SHOW Tables;

-- 1NF & 2NF
INSERT INTO Employee (first_name, last_name, email, landline, mobile, salary, hire_date, department, country, department_id, country_id)
 VALUES
('John', 'Doe', 'johndoe@gmail.com', '+41 9854752365', NULL, 50000.00, '2025-12-31', 'Information Technology', 'United States', 1, 2),
('Jane', 'Smith', 'janesmith@gmail.com', '+41 975428365', '+1 9876543210', 60000.00, '2024-11-30', 'HR', 'United States', 2, 2),
('Alice', 'Johnson', 'alicejohnson@gmail.com', NULL, '+1 9854752365', 55000.00, '2023-10-15', 'Finance', 'Russia', 3, 3),
('Bob', 'Brown', 'bobbrown@gmail.com', '0123456789', NULL, 62000.00, '2022-09-10', 'Information Technology', 'Russia', 1, 3),
('Charlie', 'Davis', 'charliedavis@gmail.com', NULL, '9876543210', 58000.00, '2021-08-20', 'HR', 'India', 2, 1);

SELECT * FROM Employee;

-- 3NF  Redundant and transitive dependency

-- ALter Table
ALTER TABLE Employee DROP COLUMN department,DROP COLUMN Country;

DESC Employee;

ALTER TABLE Employee MODIFY country_id INT NULL;

DESC Employee;

SELECT * FROM Employee;

INSERT INTO Employee (first_name, last_name, email, landline, mobile, salary, hire_date, department_id, country_id) VALUES
('Diana', 'Prince', 'dianaprince@gmail.com', '+41 1234567890', '+1 2345678901', 70000.00, '2023-05-15', 1, NULL),
('Bruce', 'Wayne', 'brucewayne@gmail.com', NULL, '+1 9876543210', 80000.00, '2024-06-10', 2, NULL),
('Clark', 'Kent', 'clarkkent@gmail.com', '+1 2345678910', NULL, 75000.00, '2025-07-20', 3, NULL),
('Tony', 'Stark', 'tonystark@gmail.com', NULL, '+1 1122334455', 90000.00, '2023-03-22', 1, NULL),
('Steve', 'Rogers', 'steverogers@gmail.com', '+1 2233445566', NULL, 65000.00, '2022-08-30', 2, NULL);

-- Verify the data inserted
SELECT * FROM Employee;

SELECT * FROM Employee where id=2;

SELECT * FROM Employee where first_name='tony' and last_name='stark';

SELECT * FROM Employee where first_name='tony' or last_name='mark';

SELECT CONCAT(first_name,' ',last_name) as Full_Name,email,hire_date as Joined_Date from Employee;


-- JOINS
SELECT e.first_name,e.last_name,e.email,e.hire_date,e.country_id from Employee as e;

-- Inner Join
SELECT e.first_name,e.last_name,e.email,e.hire_date,e.country_id,c.id,c.name as country 
from Employee as e 
inner join country as c ON e.country_id = c.id;

-- Left Join
SELECT e.first_name,e.last_name,e.email,e.hire_date,e.country_id,c.id,c.name as country 
from Employee as e 
left outer join country as c ON e.country_id = c.id;

-- Right Join
SELECT e.first_name,e.last_name,e.email,e.hire_date,e.country_id,c.id,c.name as country 
from Employee as e 
right outer join country as c ON e.country_id = c.id;

-- Cross Join
SELECT e.first_name,e.last_name,e.email,e.hire_date,e.country_id,c.id,c.name as country 
from Employee as e 
cross join country as c;

-- --------------------------------------------------------------------

-- Inner Join
SELECT 
e.first_name,e.last_name,e.email,e.hire_date,
e.country_id,c.id,c.name as country,
e.department_id,d.id,d.name as department 
from Employee as e 
inner join country as c ON e.country_id = c.id 
inner join department as d ON e.department_id=d.id;

-- Left Join
SELECT 
e.first_name,e.last_name,e.email,e.hire_date,
e.country_id,c.id,c.name as country,
e.department_id,d.id,d.name as department 
from Employee as e 
left outer join country as c ON e.country_id = c.id 
left outer join department as d ON e.department_id=d.id;

-- Right Join
SELECT 
e.first_name,e.last_name,e.email,e.hire_date,
e.country_id,c.id,c.name as country,
e.department_id,d.id,d.name as department 
from Employee as e 
right outer join country as c ON e.country_id = c.id 
right outer join department as d ON e.department_id=d.id;

-- Cross Join
SELECT 
e.first_name,e.last_name,e.email,e.hire_date,
e.country_id,c.id,c.name as country,
e.department_id,d.id,d.name as department 
from Employee as e 
cross join country as c 
cross join department as d;

-- --------------------------------------------------------------------

-- Inner Join
SELECT 
e.first_name,e.last_name,e.email,e.hire_date,
c.name as country,
d.name as department 
from Employee as e 
inner join country as c ON e.country_id = c.id 
inner join department as d ON e.department_id=d.id;

-- Left Join
SELECT 
e.first_name,e.last_name,e.email,e.hire_date,
c.name as country,
d.name as department 
from Employee as e 
left outer join country as c ON e.country_id = c.id 
left outer join department as d ON e.department_id=d.id;

-- Right Join
SELECT 
e.first_name,e.last_name,e.email,e.hire_date,
c.name as country,
d.name as department 
from Employee as e 
right outer join country as c ON e.country_id = c.id 
right outer join department as d ON e.department_id=d.id;

-- Cross Join
SELECT 
e.first_name,e.last_name,e.email,e.hire_date,
c.name as country,
d.name as department 
from Employee as e 
cross join country as c 
cross join department as d;

-- DISTINCT 
SELECT DISTINCT(department_id)from Employee;

SELECT DISTINCT(e.department_id),d.name from Employee as e inner join department as d ON e.department_id=d.id;

-- ORDER BY
SELECT * FROM Employee ORDER BY(salary);

SELECT * FROM Employee ORDER BY(salary) DESC;

-- FORMATE
SELECT CONCAT(first_name,' ',last_name) as full_name, salary from Employee;

SELECT CONCAT(first_name,' ',last_name) as full_name, FORMAT(salary,0) as salary from Employee;

-- View
CREATE VIEW EmployeeView AS 
SELECT id, first_name, last_name, email, department_id, country_id
FROM Employee;

SELECT * FROM EmployeeView;

CREATE VIEW EmployeeDetails AS 
SELECT e.id, e.first_name, e.last_name, e.email, d.name as department, c.name as country
FROM Employee as e 
inner join department as d ON e.department_id = d.id
inner join country as c ON e.country_id = c.id;

SELECT * FROM EmployeeDetails;

DROP VIEW EmployeeView;
DROP VIEW EmployeeDetails;

SELECT * FROM Employee where id=2;

-- Store Procedure 
DELIMITER //

CREATE PROCEDURE SelectEmployeeById(
    IN p_id INT
)
BEGIN
    SELECT * FROM Employee WHERE id = p_id;
END //

DELIMITER ;

CALL SelectEmployeeById(5);

DELIMITER //
CREATE PROCEDURE InsertEmployee(
    IN p_first_name VARCHAR(50), IN p_last_name VARCHAR(50), IN p_email VARCHAR(50),
    IN p_landline VARCHAR(80), IN p_mobile VARCHAR(80), IN p_salary DECIMAL(10,2),
    IN p_hire_date DATE, IN p_department_id INT, IN p_country_id INT
)
BEGIN
    INSERT INTO Employee (
        first_name, last_name, email, landline, mobile, salary, hire_date, department_id, country_id
    ) VALUES (
        p_first_name, p_last_name, p_email, p_landline, p_mobile, p_salary, p_hire_date, p_department_id, p_country_id
    );
END //
DELIMITER ;


CALL InsertEmployee('John', 'Cena', 'john@example.com', NULL, '123456789', 80000.00, '2024-06-05', 1, 1);

SELECT * FROM Employee;

DROP PROCEDURE IF EXISTS SelectEmployeeById;
DROP PROCEDURE IF EXISTS InsertEmployee;

-- Functions

-- String Functions:

SELECT * FROM employee;

SELECT CONCAT(first_name,' ',last_name,",", salary) AS emp_name_salary FROM employee;

SELECT UPPER(first_name) AS uppercase_name FROM employee;

SELECT LOWER(first_name) AS lowercase_name FROM employee;

SELECT SUBSTRING(first_name,3) AS short_name FROM employee;

SELECT first_name,LENGTH(first_name) AS name_length FROM employee;

SELECT CONCAT(first_name,' ',last_name) as full_name,LENGTH(CONCAT(first_name,' ',last_name)) AS name_length FROM employee;

SELECT CONCAT(first_name,' ',last_name) as full_name,LENGTH(CONCAT(first_name,last_name)) AS name_length FROM employee;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 101, '2024-03-01', 50.90),
(2, 102, '2024-03-02', 75.50),
(3, 103, '2024-03-03', 100.70),
(4, 101, '2024-03-04', 120.20),
(5, 102, '2024-03-05', 90.20);

-- DROP TABLE orders;

SELECT * FROM orders;

-- Aggregate Functions:
SELECT COUNT(*) AS total_orders FROM orders;

SELECT SUM(total_amount) FROM orders;

SELECT AVG(total_amount) FROM orders;

SELECT MAX(total_amount) as Max_Bill_Amount FROM orders;

SELECT MIN(total_amount) as Min_Bill_Amount FROM orders;



-- Date Functions:
SELECT NOW() AS current_date_time;

SELECT * FROM orders;

SELECT DATE_FORMAT(order_date, '%Y-%m-%d') AS formatted_date FROM orders;

SELECT DATE_FORMAT(order_date, '%d-%m-%Y') AS formatted_date FROM orders;


-- Math Functions:
SELECT order_id, customer_id, total_amount FROM orders;

SELECT order_id, customer_id, ROUND(total_amount) FROM orders;

-- Returns the smallest integer greater than or equal to a number.
SELECT order_id, customer_id,CEIL(total_amount) FROM orders;

-- Returns the largest integer less than or equal to a number.
SELECT order_id, customer_id,FLOOR(total_amount) FROM orders;

-- Group By
SELECT * FROM orders;

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

SELECT customer_id,COUNT(*) AS total_orders, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;
  