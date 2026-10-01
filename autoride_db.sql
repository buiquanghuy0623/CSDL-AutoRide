-- ========================================================
-- AUTORIDE DATABASE OPTIMIZATION SCRIPT
-- ========================================================

CREATE DATABASE IF NOT EXISTS autoride_db;
USE autoride_db;

-- 1. BẢNG CARS (Giữ nguyên cấu trúc chuẩn)
CREATE TABLE IF NOT EXISTS Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL
);

-- 2. BẢNG RENTALS (Nâng cấp cấu trúc chuẩn hóa)
CREATE TABLE IF NOT EXISTS Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME,
    status ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'BOOKED',
    security_deposit DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    late_fee DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    damage_fee DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (car_id) REFERENCES Cars(car_id) ON DELETE RESTRICT
);

-- 3. BẢNG INSPECTIONS (Thêm mới để ghi nhận kiểm tra xe)
CREATE TABLE IF NOT EXISTS Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    damage_description TEXT,
    inspector_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id) ON DELETE RESTRICT
);

-- ========================================================
-- DML: KỊCH BẢN MÔ PHỎNG VẬN HÀNH THỰC TẾ
-- ========================================================

-- Bước 1: Thêm xe mẫu
INSERT INTO Cars (model_name, license_plate) 
VALUES ('Toyota Camry', '30A-123.45');

-- Bước 2: Khách "Nguyen Van A" đặt và nhận xe, đóng cọc 10.000.000 VNĐ (Trạng thái ACTIVE)
INSERT INTO Rentals (car_id, customer_name, rent_date, status, security_deposit) 
VALUES (1, 'Nguyen Van A', NOW(), 'ACTIVE', 10000000.00);

-- Bước 3: Khách trả xe trễ và bị vỡ đèn pha -> Tạo biên bản kiểm tra
INSERT INTO Inspections (rental_id, damage_description, inspector_name) 
VALUES (1, 'Vỡ đèn pha phía trước bên trái', 'Nhan Vien B');

-- Bước 4: Cập nhật hợp đồng trả xe (Ghi nhận hư hỏng 2.000.000 VNĐ, trạng thái COMPLETED)
UPDATE Rentals 
SET return_date = NOW(),
    status = 'COMPLETED',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = 1;

-- Bước 5: Truy vấn tính toán tiền thực tế hoàn trả cho khách hàng
SELECT 
    r.rental_id,
    r.customer_name,
    c.license_plate,
    r.security_deposit,
    r.late_fee,
    r.damage_fee,
    (r.security_deposit - r.late_fee - r.damage_fee) AS refund_amount,
    i.damage_description,
    r.status
FROM Rentals r
JOIN Cars c ON r.car_id = c.car_id
LEFT JOIN Inspections i ON r.rental_id = i.rental_id
WHERE r.rental_id = 1;
