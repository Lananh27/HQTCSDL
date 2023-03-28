-- Lab 1
USE master
CREATE DATABASE QLBanHang
USE QLBanHang
CREATE TABLE SanPham
(
   masp nchar (10) PRIMARY KEY,
   mahangsx nchar (10) NOT NULL,
   tensp nvarchar (20) NOT NULL,
   soluong int NOT NULL,
   mausac nvarchar (20) NOT NULL,
   giaban money NOT NULL,
   donvitinh nchar (10) NOT NULL,
   mota nvarchar (max)  NOT NULL
)
CREATE TABLE Hangsx
(
   Mahangsx nchar (10) PRIMARY KEY,
   Tenhang nvarchar (20) NOT NULL,
   Diachi nvarchar (20) NOT NULL,
   Sodt nvarchar (20) NOT NULL,
   email nvarchar (30) NOT NULL
)
CREATE TABLE Nhap
(
   Sohdn nchar (10) NOT NULL,
   Masp nchar (10) NOT NULL,
   Manv nchar (10) NOT NULL,
   Ngaynhap date NOT NULL,
   soluongN int NOT NULL,
   dongiaN money NOT NULL,
   CONSTRAINT pk_1 PRIMARY KEY (Sohdn, Masp)
)
CREATE TABLE Xuat
( 
   Sohdx nchar (10) NOT NULL,
   Masp nchar (10) NOT NULL,
   Manv nchar (10) NOT NULL,
   Ngayxuat date NOT NULL,
   soluongX int NOT NULL,
   CONSTRAINT pk_2 PRIMARY KEY (Sohdx, Masp)
)
CREATE TABLE Nhanvien
(
   Manv nchar (10) PRIMARY KEY,
   Tennv nvarchar (20) NOT NULL,
   Gioitinh nchar (10) NOT NULL,
   Diachi nvarchar (30) NOT NULL,
   Sodt nvarchar (20) NOT NULL,
   email nvarchar (30) NOT NULL,
   Phong nvarchar (30) NOT NULL
)
ALTER TABLE SanPham
ADD
   CONSTRAINT fk_1 FOREIGN KEY (mahangsx) REFERENCES Hangsx (mahangsx)
   ON DELETE CASCADE
   ON UPDATE CASCADE
ALTER TABLE Nhap
ADD
   CONSTRAINT fk_2 FOREIGN KEY (Masp) REFERENCES Sanpham (masp),
   CONSTRAINT fk_3 FOREIGN KEY (Manv) REFERENCES Nhanvien (manv) 
   ON DELETE CASCADE
   ON UPDATE CASCADE
ALTER TABLE Xuat
ADD
   CONSTRAINT fk_4 FOREIGN KEY (Masp) REFERENCES Sanpham (masp),
   CONSTRAINT fk_5 FOREIGN KEY (Manv) REFERENCES Nhanvien (manv)
   ON DELETE CASCADE
   ON UPDATE CASCADE
INSERT INTO Hangsx
VALUES ('H01',N'SamSung',N'Korea',011-08271717,N'ss@gmail.com.kr'),
       ('H02',N'OPPO',N'China',081-08626262,N'oppo@gmail.com.cn'),
	   ('H03',N'Vinfone',N'Việt Nam',084-098262626,N'vf@gmail.com.vn')
INSERT INTO Nhanvien
VALUES ('NV01',N'Nguyễn Thị Thu',N'Nữ',N'Hà Nội','0982626521',N'thu@gmail.com',N'Kế toán'),
       ('NV02',N'Nguyễn Văn Nam',N'Nam',N'Bắc Ninh','0972525252',N'nam@gmail.com',N'Vật tư'),
	   ('NV03',N'Trần Hòa Bình',N'Nữ',N'Hà Nội','0328388388',N'hb@gmail.com',N'Kế toán')
INSERT INTO Sanpham
VALUES ('SP01','H02','F1 Plus','100',N'Xám','7000000',N'Chiếc',N'Hàng cận cao cấp'),
       ('SP02','H01','Galaxy Note11','50',N'Đỏ','19000000',N'Chiếc',N'Hàng cao cấp'),
	   ('SP03','H02','F3 lite','200',N'Nâu','3000000',N'Chiếc',N'Hàng phổ thông'),
	   ('SP04','H03','Vjoy3','200',N'Xám','1500000',N'Chiếc',N'Hàng phổ thông'),
	   ('SP05','H01','Galaxy V21','500',N'Nâu','8000000',N'Chiếc',N'Hàng cận cao cấp')
INSERT INTO Nhap
VALUES ('N01','SP02','NV01','02-05-2019','10','17000000'),
       ('N02','SP01','NV02','04-07-2020','30','6000000'),
	   ('N03','SP04','NV02','05-17-2020','20','1200000'),
	   ('N04','SP01','NV03','03-22-2020','10','6200000'),
	   ('N05','SP05','NV01','07-07-2020','20','7000000')
INSERT INTO Xuat
VALUES ('X01','SP03','NV02','06-14-2020','5'),
       ('X01','SP01','NV03','03-05-2019','3'),
	   ('X03','SP02','NV01','12-12-2020','1'),
	   ('X04','SP03','NV02','06-02-2020','2'),
	   ('X05','SP05','NV01','05-18-2020','1')

--Lab 2
-- 1
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
-- 2
SELECT Sanpham.Masp, Sanpham.Tensp, Hangsx.Tenhang, Sanpham.Soluong, Sanpham.Masp, Sanpham.Mausac, Sanpham.Giaban, Sanpham.Donvitinh, Sanpham.Mota
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
ORDER BY Sanpham.Giaban DESC
-- 3
SELECT Sanpham.tensp AS N'Tên sản phẩm của hãng samsung '
	FROM Sanpham,Hangsx
	WHERE Hangsx.Tenhang  = 'samsung' 
-- 4
SELECT * FROM Nhanvien
WHERE Gioitinh = 'Nữ' AND Phong = 'Kế Toán'
-- 5
SELECT Nhap.Sohdn, Sanpham.Masp, Sanpham.Tensp, Hangsx.Tenhang, Nhap.SoluongN, Nhap.DongiaN, Nhap.SoluongN*Nhap.DongiaN AS tiennhap, Sanpham.Mausac, Sanpham.Donvitinh, Nhap.Ngaynhap, Nhanvien.Tennv, Nhanvien.Phong
FROM Nhap
JOIN Sanpham ON Nhap.Masp = Sanpham.Masp
JOIN Hangsx ON Sanpham.Mahangsx= Hangsx.Mahangsx
JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
ORDER BY Nhap.Sohdn ASC;
-- 6
SELECT Xuat.Sohdx, Sanpham.Masp,Sanpham.Tensp,Hangsx.Tenhang,Xuat.SoluongX,Sanpham.Giaban,Xuat.SoluongX*Sanpham.Giaban AS tienxuat, Sanpham.Mausac, Sanpham.Donvitinh,Xuat.Ngayxuat,Nhanvien.Tennv,Nhanvien.Phong
FROM Xuat
INNER JOIN Sanpham ON Xuat.Masp=Sanpham.Masp
INNER JOIN Hangsx ON Sanpham.Mahangsx=Hangsx.Mahangsx
INNER JOIN Nhanvien ON Xuat.Manv=Nhanvien.Manv
WHERE MONTH(Xuat.Ngayxuat) = 10 AND YEAR(Xuat.Ngayxuat) = 2018
ORDER BY Xuat.Sohdx ASC;

--7
SELECT sohdn, Sanpham.Masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong
FROM Nhap INNER JOIN Sanpham ON Nhap.Masp = Sanpham.Masp
          INNER JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
          INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
WHERE Tenhang = 'Samsung' AND YEAR(Ngaynhap) = 2017
--8
SELECT TOP 10 *
FROM Xuat
WHERE YEAR(Ngayxuat) = 2018
ORDER BY soluongX DESC

-- 9
SELECT TOP 10 Masp, Tensp, giaban
FROM Sanpham
ORDER BY giaban DESC

-- 10

SELECT masp, tensp, soluong, mausac, giaban, donvitinh, mota
FROM Sanpham JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
WHERE Tenhang = 'Samsung' AND giaban BETWEEN 100000.0 AND 50000000.0


--11
SELECT SUM(soluongN*dongiaN) AS 'Tổng tiền đã nhập'
FROM Sanpham JOIN NHAP ON Sanpham.Masp = nhap.Masp
               JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
WHERE YEAR(Ngaynhap) = 2020 AND Tenhang = 'Samsung'


--12
SELECT SUM(soluongX*giaban) AS 'Tổng tiền đã xuất'
FROM Xuat JOIN Sanpham ON Xuat.Masp = Sanpham.Masp
WHERE Ngayxuat = '2/9/2018'

--13
SELECT Sohdn , Ngaynhap
FROM Nhap 
WHERE YEAR(Ngaynhap) = 2018 AND soluongN*dongiaN = (
SELECT MAX(soluongN*dongiaN)
FROM Nhap
WHERE YEAR(Ngaynhap) = 2018)


--14
SELECT TOP 10 Tenhang, Mausac, Soluong
FROM Sanpham JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
               JOIN Nhap ON Sanpham.Masp = Nhap.Masp
WHERE YEAR(Ngaynhap) = 2019 
ORDER BY soluongN

--15
SELECT Sanpham.Masp, Tensp
FROM Sanpham JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
               JOIN Xuat ON Sanpham.Masp = Xuat.Masp
WHERE Tenhang = 'Samsung' AND Manv = 'NV01'

--16
SELECT Nhap.Sohdn, Masp, SoluongN, Ngaynhap
FROM Nhap JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
WHERE Masp = 'SP02' AND Nhap.Manv = 'NV02'

--17
SELECT Nhanvien.manv,tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.Manv = Xuat.Manv
WHERE Masp = 'SP02' AND NGAYXUAT = '03-02-2020'
SELECT *
FROM XUAT