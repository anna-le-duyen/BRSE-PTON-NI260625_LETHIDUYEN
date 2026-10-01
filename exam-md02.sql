CREATE DATABASE QUANLYPHONGKHAM;
USE QUANLYPHONGKHAM;

-- Tạo bảng

CREATE TABLE BenhNhan(
benhnhan_id VARCHAR(10) PRIMARY KEY,
ho_ten VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
so_dien_thoai VARCHAR(15) NOT NULL,
dia_chi VARCHAR(200)
);

CREATE TABLE DichVu(
dichvu_id VARCHAR(10) PRIMARY KEY,
ten_dich_vu VARCHAR(150) NOT NULL UNIQUE,
gia_dich_vu DECIMAL(12,2) NOT NULL CHECK (gia_dich_vu > 0),
trang_thai VARCHAR(50) NOT NULL DEFAULT 'Hoạt động',
thoi_gian_uoc_tinh INT NOT NULL
);

CREATE TABLE PhieuKham(
phieukham_id INT PRIMARY KEY AUTO_INCREMENT,
benhnhan_id VARCHAR(10) NOT NULL,
dichvu_id VARCHAR(10) NOT NULL,
ngay_kham DATE NOT NULL,
ngay_tai_kham DATE,
tong_tien DECIMAL(12,2) DEFAULT 0,
FOREIGN KEY (benhnhan_id) REFERENCES BenhNhan(benhnhan_id),
FOREIGN KEY (dichvu_id) REFERENCES DichVu(dichvu_id)
);

CREATE TABLE HoaDon(
hoadon_id INT PRIMARY KEY AUTO_INCREMENT,
phieukham_id INT NOT NULL,
phuong_thuc_tt VARCHAR(50) NOT NULL,
ngay_tt DATE NOT NULL,
so_tien_tt DECIMAL(12,2) NOT NULL CHECK (so_tien_tt > 0),
FOREIGN KEY (phieukham_id) REFERENCES PhieuKham(phieukham_id)
);

-- Chèn dữ liệu 4 bảng
-- thêm bảng Bệnh Nhân
INSERT INTO BenhNhan (benhnhan_id, ho_ten, email, so_dien_thoai, dia_chi)
VALUES
('BN001','Nguyen Anh Tu','tu.nguyen@example.com','0912345678','Hanoi, Vietnam'),
('BN002','Tran Thi Mai','mai.tran@example.com','0923456789','Ho Chi Minh, Vietnam'),
('BN003','Le Minh Hoang','hoang.le@example.com','0934567890','Danang, Vietnam'),
('BN004','Pham Hoang Nam','nam.pham@example.com','0945678901','Hue, Vietnam'),
('BN005','Vu Minh Thu','thu.vu@example.com','0956789012','Hai Phong, Vietnam'),
('BN006','Nguyen Thi Lan','lan.nguyen@example.com','0967890123','Quang Ninh, Vietnam'),
('BN007','Bui Minh Tuan','tuan.bui@example.com','0978901234','Bac Giang, Vietnam'),
('BN008','Pham Quang Hieu','hieu.pham@example.com','0989012345','Quang Nam, Vietnam')
;

-- thêm bảng Dịch Vụ
INSERT INTO DichVu (dichvu_id, ten_dich_vu, gia_dich_vu, trang_thai, thoi_gian_uoc_tinh)
VALUES
('DV001','Khám tổng quát', 200.0,'Hoạt động', 30),
('DV002','Chụp X-Quang', 150.0,'Tạm ngưng', 15),
('DV003','Xét nghiệm máu', 300.0,'Hoạt động', 20),
('DV004','Siêu âm 4D', 400.0,'Hoạt động', 45),
('DV005','Khám chuyên khoa', 250.0,'Hoạt động', 30),
('DV006','Nội soi dạ dày', 500.0,'Hoạt động', 60),
('DV007','Khám mắt', 150.0,'Hoạt động', 20),
('DV008','Khám tai mũi họng', 200.0,'Tạm ngưng', 25)
;

-- thêm bảng Phiếu khám
INSERT INTO PhieuKham (phieukham_id, benhnhan_id, dichvu_id, ngay_kham, ngay_tai_kham, tong_tien)
VALUES
(1,'BN001','DV001','2026-09-01','2026-09-10',200.0),
(2,'BN002','DV002','2026-09-02','2026-09-11',150.0),
(3,'BN003','DV003','2026-09-03','2026-09-12',300.0),
(4,'BN004','DV004','2026-09-04','2026-09-13',400.0),
(5,'BN005','DV005','2026-09-05','2026-09-14',250.0),
(6,'BN006','DV006','2026-09-06','2026-09-15',500.0),
(7,'BN007','DV007','2026-09-07','2026-09-16',150.0),
(8,'BN008','DV008','2026-09-08','2026-09-17',200.0)
;

-- thêm bảng Hoá đơn
INSERT INTO HoaDon (hoadon_id, phieukham_id, phuong_thuc_tt, ngay_tt, so_tien_tt)
VALUES
(1,1,'Cash','2026-09-01',200.0),
(2,2,'Credit Card','2026-09-02',150.0),
(3,3,'Bank Transfer','2026-09-03',300.0),
(4,3,'Cash','2026-09-04',400.0),
(5,5,'Credit Card','2026-09-05',250.0),
(6,6,'Bank Transfer','2026-09-06',500.0),
(7,7,'Cash','2026-09-07',150.0),
(8,8,'Credit Card','2026-09-08',200.0)
;

-- UPDATE & DELETE 
SET SQL_SAFE_UPDATES = 0;

UPDATE Phieukham pk
JOIN Dichvu dv ON pk.dichvu_id = dv.dichvu_id
SET pk.tong_tien = dv.gia_dich_vu + 50.0
WHERE dv.trang_thai = 'Hoạt động'
AND pk.ngay_kham < CURDATE();

DELETE FROM Hoadon 
WHERE phuong_thuc_tt = 'Cash'
AND so_tien_tt < 200.0;

-- Phần 2 Truy vấn dữ liệu
-- Câu 1*: Lấy thông tin bệnh nhân, sắp xếp tăng

SELECT *
FROM Benhnhan
ORDER BY ho_ten ASC;

-- Câu 2*: Lấy thông tin dịch vụ, sắp xếp giảm
SELECT dichvu_id, ten_dich_vu, gia_dich_vu, thoi_gian_uoc_tinh
FROM Dichvu
ORDER BY gia_dich_vu DESC;

-- Câu 3*: Lấy thông tin bệnh nhân
SELECT bn.benhnhan_id, bn.ho_ten, pk.dichvu_id, pk.ngay_kham, pk.ngay_tai_kham
FROM benhnhan bn
JOIN phieukham pk ON bn.benhnhan_id = pk.benhnhan_id;

-- Câu 4*: Lấy danh sách bệnh nhân, sắp xếp giảm
SELECT bn.benhnhan_id, bn.ho_ten, hd.phuong_thuc_tt, hd.so_tien_tt
FROM Benhnhan bn
JOIN phieukham pk ON bn.benhnhan_id = pk.benhnhan_id
JOIN hoadon hd ON pk.phieukham_id = hd.phieukham_id
ORDER BY hd.so_tien_tt DESC;

-- Câu 5*: Lấy thông tin bệnh nhân vị trí thứ 2 đến thứ 4 , sắp xếp theo tên
SELECT *
FROM benhnhan bn
ORDER BY ho_ten ASC
LIMIT 3 OFFSET 1;

-- Câu 9*: Lấy danh sách các bệnh nhân tên Minh, Hà Nội
SELECT benhnhan_id, ho_ten, email, so_dien_thoai
FROM benhnhan
WHERE ho_ten LIKE '%Minh%' OR dia_chi LIKE '%Hanoi%'
ORDER BY ho_ten ASC;

-- Câu 10*: Lấy danh sách tất cả dịch vụ, sắp xếp giảm 
SELECT dichvu_id, ten_dich_vu, gia_dich_vu
FROM dichvu
ORDER BY gia_dich_vu DESC
LIMIT 3 OFFSET 2;


-- Phần 3: Tạo View
-- Câu 1: Tạo View lấy thông tin các dịch vụ bệnh nhân đã đăng ký, điều kiện ngày khám < 2026-09-08
CREATE VIEW dichvubenhnhan AS 
SELECT dv.dichvu_id, dv.ten_dich_vu, bn.benhnhan_id, bn.ho_ten
FROM dichvu dv
JOIN phieukham pk ON dv.dichvu_id = pk.dichvu_id 
JOIN benhnhan bn ON pk.benhnhan_id = bn.benhnhan_id
WHERE pk.ngay_kham < '2026-09-08';

SELECT *
FROM dichvubenhnhan;

-- Câu 2: Tạo View lấy thông tin bệnh nhân, phiếu khám, điều kiện. giá dịch vụ > 200.0
CREATE VIEW thongtinbenhnhan AS 
SELECT bn.benhnhan_id, bn.ho_ten, dv.dichvu_id, dv.gia_dich_vu
FROM benhnhan bn
JOIN phieukham pk ON bn.benhnhan_id = pk.benhnhan_id 
JOIN dichvu dv ON pk.dichvu_id = dv.dichvu_id
WHERE dv.gia_dich_vu > 200.0;

SELECT *
FROM thongtinbenhnhan;

-- Phần 4: Tạo Trigger
-- Câu 1: Tạo một trigger check_insert_phieukham
DELIMITER $$
CREATE TRIGGER check_insert_phieukham
BEFORE INSERT ON phieukham
FOR EACH ROW
BEGIN
	IF NEW.ngay_tai_kham < NEW.ngay_kham
        THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ngày tái khám không thể trước ngày khám được .!';
     END IF;
END $$
DELIMITER ;

-- Phần 5: Tạo Store Procedure

-- Câu 1: Viết store procedure có tên add_benhnhan để thêm mới bệnh nhân
DELIMITER $$
CREATE PROCEDURE add_benhnhan(
IN p_benhnhan_id VARCHAR(10),
IN p_ho_ten VARCHAR(100),
IN p_email VARCHAR(100),
IN p_so_dien_thoai VARCHAR(15),
IN p_dia_chi VARCHAR(200)
)
BEGIN 
	INSERT INTO benhnhan(benhnhan_id, ho_ten, email,so_dien_thoai,dia_chi)
    VALUES (p_benhnhan_id, p_ho_ten, p_email, p_so_dien_thoai, p_dia_chi);
END $$
DELIMITER ;
CALL add_benhnhan('BN010','Le Van A','a.le@example.com','0998886666','Hanoi');

SELECT *
FROM benhnhan

-- Câu 2: Viết store procedure có tên add_hoadon để thêm một thanh toán
DELIMITER $$
CREATE PROCEDURE add_hoadon(
IN p_phieukham_id INT,
IN p_phuong_thuc_tt VARCHAR(50),
IN p_so_tien_tt DECIMAL(12,2),
IN p_ngay_tt DATE
)
BEGIN 
	INSERT INTO hoadon(phieukham_id, phuong_thuc_tt,so_tien_tt,ngay_tt)
    VALUES (p_phieukham_id, p_phuong_thuc_tt,so_tien_tt,ngay_tt);
END $$
DELIMITER ;
CALL add_hoadon(1, 'Cash',200.0, '2026-10-01');

SELECT *
FROM hoadon