-- =========================================================
-- HOTEL BOOKING MANAGEMENT SYSTEM
-- MySQL Mini Project - 2
-- =========================================================

-- 1. CREATE DATABASE
CREATE DATABASE hotel_booking_db;
USE hotel_booking_db;

-- 2. CREATE TABLES

-- Table 1: Hotels
-- Stores hotel information.
CREATE TABLE Hotels(
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_name VARCHAR(50),
    city VARCHAR(30),
    star_rating INT
);

-- Table 2: Rooms
-- Each hotel contains many rooms.
CREATE TABLE Rooms(
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT,
    room_number VARCHAR(10),
    room_type VARCHAR(20),
    price DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY(hotel_id) REFERENCES Hotels(hotel_id)
);

-- Table 3: Guests
-- Stores guest information.
CREATE TABLE Guests(
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(50),
    phone VARCHAR(15),
    city VARCHAR(30)
);

-- Table 4: Bookings
-- A guest can make multiple bookings.
CREATE TABLE Bookings(
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    booking_status VARCHAR(20),
    FOREIGN KEY(guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY(room_id) REFERENCES Rooms(room_id)
);

-- Table 5: Payments
-- Stores payment details for bookings.
CREATE TABLE Payments(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY(booking_id) REFERENCES Bookings(booking_id)
);

-- 3. INSERT DATA INTO HOTELS
INSERT INTO Hotels(hotel_name,city,star_rating)
VALUES
('Grand Palace','Chennai',5),
('Royal Inn','Bangalore',4),
('Blue Moon','Hyderabad',3);

-- 4. INSERT DATA INTO ROOMS
INSERT INTO Rooms(hotel_id,room_number,room_type,price,status)
VALUES
(1,'101','Standard',2500,'Available'),
(1,'102','Deluxe',4000,'Occupied'),
(1,'103','Suite',7000,'Occupied'),
(2,'201','Standard',2200,'Available'),
(2,'202','Deluxe',3800,'Occupied'),
(3,'301','Standard',1800,'Available'),
(3,'302','Suite',6000,'Occupied'),
(1,'104','Standard',2600,'Occupied'),
(2,'203','Standard',2300,'Available'),
(3,'303','Deluxe',3500,'Available');

-- 5. INSERT DATA INTO GUESTS
INSERT INTO Guests(guest_name,phone,city)
VALUES
('Rahul','9876543210','Chennai'),
('Priya','9876543211','Bangalore'),
('Arun','9876543212','Hyderabad'),
('Sneha','9876543213','Coimbatore'),
('Karthik','9876543214','Mumbai'),
('Meera','9876543215','Pune'),
('Vikram','9876543216','Mysore');

-- 6. INSERT DATA INTO BOOKINGS
INSERT INTO Bookings(guest_id,room_id,check_in,check_out,booking_status)
VALUES
(1,2,'2026-07-25','2026-07-30','Completed'),
(2,3,'2026-07-28','2026-08-02','Active'),
(3,5,'2026-07-29','2026-08-01','Active'),
(4,7,'2026-07-20','2026-07-22','Completed'),
(1,1,'2026-08-05','2026-08-08','Booked'),
(5,4,'2026-07-31','2026-08-03','Cancelled'),
(6,8,'2026-09-20','2026-09-27','Active'),
(7,9,'2026-09-22','2026-09-26','Active'),
(1,4,'2026-09-10','2026-09-12','Completed'),
(1,6,'2026-09-15','2026-09-18','Completed'),
(2,1,'2026-09-01','2026-09-04','Completed'),
(3,4,'2026-08-20','2026-08-23','Completed'),
(4,6,'2026-08-25','2026-08-28','Completed'),
(5,1,'2026-09-05','2026-09-07','Cancelled');

-- 7. INSERT DATA INTO PAYMENTS
INSERT INTO Payments(booking_id,amount,payment_status)
VALUES
(1,20000,'Paid'),
(2,35000,'Paid'),
(3,12000,'Pending'),
(4,15000,'Paid'),
(5,7500,'Pending'),
(6,0,'Refunded'),
(7,18200,'Paid'),
(8,10500,'Paid'),
(9,6600,'Paid'),
(10,5400,'Paid'),
(11,6900,'Paid'),
(12,6600,'Paid'),
(13,5400,'Paid'),
(14,0,'Refunded');

SHOW TABLES;
SELECT * FROM Hotels;
SELECT * FROM Rooms;
SELECT * FROM Guests;
SELECT * FROM Bookings;
SELECT * FROM Payments;

-- =========================================================
-- PRACTICE QUERIES
-- =========================================================

-- 1. Display available rooms.
SELECT r.room_number,
       r.room_type,
       r.price,
       h.hotel_name
FROM Rooms r
JOIN Hotels h
ON r.hotel_id = h.hotel_id
WHERE r.status = 'Available';

-- 2. Display guests staying today.
SELECT g.guest_name,
       h.hotel_name,
       r.room_number,
       b.check_in,
       b.check_out
FROM Guests g
JOIN Bookings b
ON g.guest_id = b.guest_id
JOIN Rooms r
ON b.room_id = r.room_id
JOIN Hotels h
ON r.hotel_id = h.hotel_id
WHERE CURDATE() BETWEEN b.check_in AND b.check_out
AND b.booking_status = 'Active';

-- 3. Calculate total revenue from paid bookings.
SELECT SUM(amount) AS Total_Revenue
FROM Payments
WHERE payment_status = 'Paid';

-- 4. Display bookings between two dates.
SELECT booking_id,
       guest_name,
       hotel_name,
       check_in,
       check_out
FROM Bookings
JOIN Guests
ON Bookings.guest_id = Guests.guest_id
JOIN Rooms
ON Bookings.room_id = Rooms.room_id
JOIN Hotels
ON Rooms.hotel_id = Hotels.hotel_id
WHERE check_in BETWEEN '2026-07-25' AND '2026-07-31';

-- 5. Find the most booked room type.
SELECT room_type,
       COUNT(*) AS Total_Bookings
FROM Rooms
JOIN Bookings
ON Rooms.room_id = Bookings.room_id
GROUP BY room_type
ORDER BY Total_Bookings DESC
LIMIT 1;

-- 6. Calculate occupancy rate.
SELECT ROUND(
           COUNT(CASE WHEN status = 'Occupied' THEN 1 END)
           * 100.0 / COUNT(*),
           2
       ) AS Occupancy_Rate
FROM Rooms;

-- 7. Display cancelled bookings.
SELECT booking_id,
       guest_name,
       hotel_name,
       room_number
FROM Bookings
JOIN Guests
ON Bookings.guest_id = Guests.guest_id
JOIN Rooms
ON Bookings.room_id = Rooms.room_id
JOIN Hotels
ON Rooms.hotel_id = Hotels.hotel_id
WHERE booking_status = 'Cancelled';

-- 8. Find customers with multiple bookings.
SELECT guest_name,
       COUNT(booking_id) AS Total_Bookings
FROM Guests
JOIN Bookings
ON Guests.guest_id = Bookings.guest_id
GROUP BY guest_name
HAVING COUNT(*) > 1;

-- 9. Display average room price.
SELECT AVG(price) AS Average_Room_Price
FROM Rooms;

-- 10. Find hotels with more than 100 rooms.
SELECT h.hotel_name,
       COUNT(r.room_id) AS Total_Rooms
FROM Hotels h
JOIN Rooms r
ON h.hotel_id = r.hotel_id
GROUP BY h.hotel_id, h.hotel_name
HAVING COUNT(r.room_id) > 100;

-- 11. Find the highest-paying guest.
SELECT g.guest_name,
       SUM(p.amount) AS Total_Paid
FROM Guests g
JOIN Bookings b
ON g.guest_id = b.guest_id
JOIN Payments p
ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Paid'
GROUP BY g.guest_id, g.guest_name
ORDER BY Total_Paid DESC
LIMIT 1;

-- 12. Display hotel-wise revenue.
SELECT h.hotel_name,
       SUM(p.amount) AS Revenue
FROM Hotels h
JOIN Rooms r
ON h.hotel_id = r.hotel_id
JOIN Bookings b
ON r.room_id = b.room_id
JOIN Payments p
ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Paid'
GROUP BY h.hotel_id, h.hotel_name;

-- 13. Find the most expensive room.
SELECT *
FROM Rooms
ORDER BY price DESC
LIMIT 1;

-- 14. Find guests who never booked a room.
SELECT *
FROM Guests
WHERE guest_id NOT IN (
    SELECT guest_id
    FROM Bookings
);

-- 15. Rank hotels by revenue.
SELECT h.hotel_name,
       SUM(p.amount) AS Revenue,
       RANK() OVER(
           ORDER BY SUM(p.amount) DESC
       ) AS Revenue_Rank
FROM Hotels h
JOIN Rooms r
ON h.hotel_id = r.hotel_id
JOIN Bookings b
ON r.room_id = b.room_id
JOIN Payments p
ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Paid'
GROUP BY h.hotel_id, h.hotel_name;
