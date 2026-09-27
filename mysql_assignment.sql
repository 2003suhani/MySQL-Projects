-- MYSQL ASSIGNMENT

-- BANKING SCENARIO
CREATE DATABASE IF NOT EXISTS assignment_banking_db;
USE assignment_banking_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (name, city) VALUES
('Janani','Chennai'),
('Arun','Coimbatore'),
('Priya','Madurai'),
('Karthik','Salem');

INSERT INTO accounts (customer_id, account_type, balance) VALUES
(1,'Savings',50000),
(1,'Current',20000),
(2,'Savings',30000),
(3,'Savings',15000),
(4,'Current',40000);

-- BANKING QUESTIONS

-- 1
SELECT * FROM accounts WHERE balance > 20000;

-- 2
SELECT * FROM customers WHERE city = 'Chennai';

-- 3
SELECT * FROM accounts WHERE balance BETWEEN 20000 AND 50000;

-- 4
SELECT * FROM customers WHERE name LIKE 'J%';

-- 5
SELECT * FROM accounts WHERE account_type IN ('Savings','Current');

-- 6
SELECT * FROM accounts WHERE account_type <> 'Savings';

-- 7
SELECT * FROM customers WHERE name LIKE '%a%';

-- 8
SELECT * FROM accounts WHERE balance <= 30000;

-- 9
SELECT * FROM customers WHERE city <> 'Madurai';

-- 10
SELECT * FROM accounts WHERE balance NOT BETWEEN 10000 AND 40000;

-- 11
SELECT * FROM customers WHERE name LIKE '%i';

-- 12
SELECT * FROM accounts WHERE balance = 50000;

-- 13
SELECT * FROM customers WHERE city IN ('Chennai','Salem');

-- 14
SELECT * FROM accounts WHERE balance > 10000 AND balance < 40000;

-- 15
SELECT * FROM accounts WHERE account_type NOT IN ('Current');

-- 16
SELECT * FROM accounts ORDER BY balance DESC;

-- 17
SELECT * FROM customers ORDER BY name ASC;

-- 18
SELECT * FROM accounts
ORDER BY account_type ASC, balance DESC;

-- 19
SELECT SUM(balance) AS Total_Balance
FROM accounts;

-- 20
SELECT AVG(balance) AS Average_Balance
FROM accounts;

-- 21
SELECT MAX(balance) AS Maximum_Balance
FROM accounts;

-- 22
SELECT MIN(balance) AS Minimum_Balance
FROM accounts;

-- 23
SELECT COUNT(*) AS Total_Customers
FROM customers;

-- 24
SELECT account_type,
       SUM(balance) AS Total_Balance
FROM accounts
GROUP BY account_type;

-- 25
SELECT account_type,
       AVG(balance) AS Average_Balance
FROM accounts
GROUP BY account_type;

-- 26
SELECT account_type,
       AVG(balance) AS Average_Balance
FROM accounts
GROUP BY account_type
HAVING AVG(balance) > 20000;

-- 27
SELECT customer_id,
       COUNT(*) AS Total_Accounts
FROM accounts
GROUP BY customer_id;

-- 28
SELECT c.customer_id,
       c.name,
       COUNT(a.account_id) AS Total_Accounts
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(a.account_id) > 1;

-- 29
SELECT c.name,
       a.account_type,
       a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id;

-- 30
SELECT c.name,
       a.account_id,
       a.account_type,
       a.balance
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id;

-- 31
SELECT a.account_id,
       a.account_type,
       a.balance,
       c.name,
       c.city
FROM accounts a
JOIN customers c
ON a.customer_id = c.customer_id;

-- 32
SELECT c.name,
       a.account_type,
       a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
WHERE a.balance > 20000;

-- 33
SELECT c.name,
       SUM(a.balance) AS Total_Balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name;

-- 34
SELECT c.name,
       a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
ORDER BY a.balance DESC;

-- 35
SELECT c.city,
       COUNT(a.account_id) AS Total_Accounts
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.city;

-- 36
SELECT *
FROM accounts
WHERE balance > (SELECT AVG(balance) FROM accounts);

-- 37
SELECT *
FROM customers
WHERE customer_id IN (SELECT customer_id FROM accounts);

-- 38
SELECT *
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM accounts);

-- 39
SELECT *
FROM accounts
WHERE balance = (SELECT MAX(balance) FROM accounts);

-- 40
SELECT c.name,
       SUM(a.balance) AS Total_Balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(a.balance) > 40000;

-- RAILWAY RESERVATION SCENARIO
CREATE DATABASE IF NOT EXISTS assignment_railway_db;
USE assignment_railway_db;

CREATE TABLE trains (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(50),
    source VARCHAR(50),
    destination VARCHAR(50)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    train_id INT,
    passenger_name VARCHAR(50),
    fare DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (train_id) REFERENCES trains(train_id)
);

INSERT INTO trains (train_name, source, destination) VALUES
('Express1','Chennai','Madurai'),
('Express2','Coimbatore','Salem'),
('Express3','Madurai','Chennai');

INSERT INTO bookings (train_id, passenger_name, fare, status) VALUES
(1,'Janani',500,'Confirmed'),
(1,'Arun',500,'Waiting'),
(2,'Priya',300,'Confirmed'),
(3,'Karthik',450,'Cancelled'),
(2,'Meena',300,'Confirmed');

-- RAILWAY QUESTIONS

-- 41
SELECT * FROM bookings WHERE fare > 400;

-- 42
SELECT * FROM bookings WHERE status <> 'Confirmed';

-- 43
SELECT * FROM trains WHERE source = 'Chennai';

-- 44
SELECT * FROM bookings WHERE fare BETWEEN 300 AND 500;

-- 45
SELECT * FROM bookings WHERE passenger_name LIKE 'A%';

-- 46
SELECT t.train_name,
       b.passenger_name
FROM trains t
JOIN bookings b
ON t.train_id = b.train_id;

-- 47
SELECT t.train_name,
       COUNT(b.booking_id) AS Total_Bookings
FROM trains t
LEFT JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;

-- 48
SELECT t.train_name,
       COALESCE(SUM(b.fare),0) AS Total_Fare
FROM trains t
LEFT JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;

-- 49
SELECT *
FROM bookings
WHERE fare = (SELECT MAX(fare) FROM bookings);

-- 50
SELECT t.train_name,
       COUNT(b.booking_id) AS Total_Bookings
FROM trains t
JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name
HAVING COUNT(b.booking_id) > 1;

-- EMPLOYEE MANAGEMENT
CREATE DATABASE IF NOT EXISTS assignment_reporting_db;
USE assignment_reporting_db;

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    city VARCHAR(30),
    joining_date DATE
);

INSERT INTO Employee VALUES
(101,'John','IT',60000,'Chennai','2022-01-15'),
(102,'David','HR',45000,'Bangalore','2021-03-10'),
(103,'Smith','IT',70000,'Chennai','2020-07-12'),
(104,'Mary','Finance',55000,'Mumbai','2023-01-20'),
(105,'James','HR',48000,'Delhi','2022-05-05'),
(106,'Linda','Finance',65000,'Mumbai','2021-08-18');

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(30),
    marks INT
);

-- CUSTOMERS & ORDERS SAMPLE DATA
INSERT INTO Customers VALUES
(1,'Arun','Bangalore'),
(2,'Priya','Chennai'),
(3,'Karthik','Mysore'),
(4,'Meena','Mumbai'),
(5,'Rahul','Delhi');

INSERT INTO Orders VALUES
(101,1,3000,'2026-01-10'),
(102,1,2500,'2026-02-15'),
(103,1,1800,'2026-03-20'),
(104,1,2200,'2026-04-05'),
(105,2,4500,'2026-01-12'),
(106,2,3000,'2026-02-18'),
(107,3,1500,'2026-03-10'),
(108,3,2500,'2026-04-22'),
(109,4,6000,'2026-05-01'),
(110,5,2000,'2026-05-15');

-- STUDENTS SAMPLE DATA
INSERT INTO Students VALUES
(1,'Anu','CSE',85),
(2,'Ravi','CSE',78),
(3,'Meena','CSE',92),
(4,'Kiran','CSE',88),
(5,'Priya','CSE',76),
(6,'Arun','CSE',81),
(7,'Divya','ECE',72),
(8,'Rahul','ECE',80),
(9,'Sneha','ECE',75),
(10,'Vijay','ECE',90),
(11,'Neha','ECE',84),
(12,'Amit','ECE',69),
(13,'Kavya','ISE',95),
(14,'Rohan','ISE',88),
(15,'Suman','ISE',79),
(16,'Pooja','ISE',91);

-- EMPLOYEE QUESTIONS

-- 1
SELECT department,
       COUNT(*) AS Total_Employees
FROM Employee
GROUP BY department;

-- 2
SELECT department,
       AVG(salary) AS Average_Salary
FROM Employee
GROUP BY department;

-- 3
SELECT department,
       COUNT(*) AS Total_Employees
FROM Employee
GROUP BY department
HAVING COUNT(*) > 1;

-- 4
SELECT department,
       MAX(salary) AS Highest_Salary
FROM Employee
GROUP BY department;

-- 5
SELECT department,
       MIN(salary) AS Lowest_Salary
FROM Employee
GROUP BY department;

-- 6
SELECT department,
       AVG(salary) AS Average_Salary
FROM Employee
GROUP BY department
HAVING AVG(salary) > 50000;

-- 7
SELECT department,
       SUM(salary) AS Total_Salary
FROM Employee
GROUP BY department;

-- 8
SELECT *
FROM Employee
ORDER BY salary DESC;

-- 9
SELECT *
FROM Employee
ORDER BY department ASC, salary DESC;

-- 10
SELECT city,
       COUNT(*) AS Total_Employees
FROM Employee
GROUP BY city
HAVING COUNT(*) > 1;

-- 11
SELECT city,
       SUM(salary) AS Total_Salary
FROM Employee
GROUP BY city;

-- 12
SELECT department,
       SUM(salary) AS Total_Salary
FROM Employee
GROUP BY department
ORDER BY Total_Salary DESC;

-- 13
SELECT department,
       COUNT(*) AS Employees_Above_50000
FROM Employee
WHERE salary > 50000
GROUP BY department;

-- 14
SELECT department,
       MAX(salary) - MIN(salary) AS Salary_Difference
FROM Employee
GROUP BY department;

-- 15
SELECT *
FROM Employee
ORDER BY salary DESC
LIMIT 3;

-- CUSTOMERS & ORDERS QUESTIONS

-- 16
SELECT c.customer_id,
       c.customer_name,
       COALESCE(SUM(o.amount),0) AS Total_Purchase
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 17
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS Total_Orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 3;

-- 18
SELECT c.customer_id,
       c.customer_name,
       AVG(o.amount) AS Average_Order
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 19
SELECT c.customer_id,
       c.customer_name,
       MAX(o.amount) AS Highest_Order
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 20
SELECT c.customer_id,
       c.customer_name,
       COALESCE(SUM(o.amount),0) AS Total_Purchase
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY Total_Purchase DESC;

-- 21
SELECT c.customer_id,
       c.customer_name,
       SUM(o.amount) AS Total_Purchase
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 10000;

-- 22
SELECT c.customer_name,
       COUNT(o.order_id) AS Total_Orders
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 23
SELECT c.customer_id,
       c.customer_name,
       SUM(o.amount) AS Total_Purchase
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY Total_Purchase DESC
LIMIT 1;

-- 24
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS Total_Orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY Total_Orders DESC
LIMIT 1;

-- 25
SELECT c.customer_id,
       c.customer_name,
       AVG(o.amount) AS Average_Order
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING AVG(o.amount) > 2000;

-- 26
SELECT c.customer_id,
       c.customer_name,
       SUM(o.amount) AS Total_Purchase
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY Total_Purchase DESC
LIMIT 5;

-- 27
SELECT c.customer_id,
       c.customer_name,
       MIN(o.amount) AS Minimum_Order
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 28
SELECT c.customer_id,
       c.customer_name,
       SUM(o.amount) AS Total_Purchase
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 5000;

-- 29
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS Total_Orders,
       COALESCE(SUM(o.amount),0) AS Total_Purchase
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 30
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS Total_Orders,
       SUM(o.amount) AS Total_Purchase
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 2
AND SUM(o.amount) > 8000;

-- STUDENTS QUESTIONS

-- 31
SELECT department,
       AVG(marks) AS Average_Marks
FROM Students
GROUP BY department;

-- 32
SELECT department,
       AVG(marks) AS Average_Marks
FROM Students
GROUP BY department
HAVING AVG(marks) > 75;

-- 33
SELECT department,
       MAX(marks) AS Highest_Mark
FROM Students
GROUP BY department;

-- 34
SELECT department,
       COUNT(*) AS Total_Students
FROM Students
GROUP BY department;

-- 35
SELECT department,
       COUNT(*) AS Total_Students
FROM Students
GROUP BY department
HAVING COUNT(*) > 5;

-- 36
SELECT department,
       AVG(marks) AS Average_Marks
FROM Students
GROUP BY department
ORDER BY Average_Marks DESC;

-- 37
SELECT department,
       AVG(marks) AS Average_Marks
FROM Students
GROUP BY department
ORDER BY Average_Marks DESC
LIMIT 3;

-- 38
SELECT department,
       AVG(marks) AS Average_Marks
FROM Students
GROUP BY department
HAVING AVG(marks) BETWEEN 70 AND 90;

-- 39
SELECT department,
       SUM(marks) AS Total_Marks
FROM Students
GROUP BY department;

-- 40
SELECT department,
       COUNT(*) AS Total_Students
FROM Students
GROUP BY department
ORDER BY Total_Students DESC;

-- 41
SELECT department,
       MIN(marks) AS Lowest_Mark
FROM Students
GROUP BY department;

-- 42
SELECT department,
       MAX(marks) AS Highest_Mark
FROM Students
GROUP BY department
HAVING MAX(marks) > 90;

-- 43
SELECT department,
       COUNT(*) AS Above_80
FROM Students
WHERE marks > 80
GROUP BY department;

-- 44
SELECT department,
       COUNT(*) AS Above_75
FROM Students
WHERE marks > 75
GROUP BY department
HAVING COUNT(*) > 3;

-- 45
SELECT department,
       MAX(marks) AS Highest_Mark
FROM Students
GROUP BY department
ORDER BY Highest_Mark DESC;
