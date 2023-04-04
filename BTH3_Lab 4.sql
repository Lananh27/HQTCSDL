--Lab 2
-- 1
CREATE VIEW view1 AS
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
SELECT* FROM view1;
go
go
CREATE VIEW view2 AS
SELECT Sanpham.Masp, Sanpham.Tensp, Hangsx.Tenhang, Sanpham.Soluong, Sanpham.Masp, Sanpham.Mausac, Sanpham.Giaban, Sanpham.Donvitinh, Sanpham.Mota
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
ORDER BY Sanpham.Giaban DESC;
go
go
CREATE VIEW view3 AS
SELECT Sanpham.tensp AS N'Tên sản phẩm của hãng samsung '
FROM Sanpham,Hangsx
WHERE Hangsx.Tenhang  = 'samsung' ;
go
go
CREATE VIEW view4 AS
SELECT * FROM Nhanvien
WHERE Gioitinh = 'Nữ' AND Phong = 'Kế Toán'
go
go
CREATE VIEW view5 AS
SELECT Nhap.Sohdn, Sanpham.Masp, Sanpham.Tensp, Hangsx.Tenhang, Nhap.SoluongN, Nhap.DongiaN, Nhap.SoluongN*Nhap.DongiaN AS tiennhap, Sanpham.Mausac, Sanpham.Donvitinh, Nhap.Ngaynhap, Nhanvien.Tennv, Nhanvien.Phong
FROM Nhap
JOIN Sanpham ON Nhap.Masp = Sanpham.Masp
JOIN Hangsx ON Sanpham.Mahangsx= Hangsx.Mahangsx
JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
ORDER BY Nhap.Sohdn ASC;
go
go
CREATE VIEW view6 AS
SELECT Xuat.Sohdx, Sanpham.Masp,Sanpham.Tensp,Hangsx.Tenhang,Xuat.SoluongX,Sanpham.Giaban,Xuat.SoluongX*Sanpham.Giaban AS tienxuat, Sanpham.Mausac, Sanpham.Donvitinh,Xuat.Ngayxuat,Nhanvien.Tennv,Nhanvien.Phong
FROM Xuat
INNER JOIN Sanpham ON Xuat.Masp=Sanpham.Masp
INNER JOIN Hangsx ON Sanpham.Mahangsx=Hangsx.Mahangsx
INNER JOIN Nhanvien ON Xuat.Manv=Nhanvien.Manv
WHERE MONTH(Xuat.Ngayxuat) = 10 AND YEAR(Xuat.Ngayxuat) = 2018
ORDER BY Xuat.Sohdx ASC;
go
go
CREATE VIEW view6 AS
SELECT sohdn, Sanpham.Masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong
FROM Nhap INNER JOIN Sanpham ON Nhap.Masp = Sanpham.Masp
          INNER JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
          INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
WHERE Tenhang = 'Samsung' AND YEAR(Ngaynhap) = 2017
go
go
CREATE VIEW view7 AS
SELECT TOP 10 *
FROM Xuat
WHERE YEAR(Ngayxuat) = 2018
ORDER BY soluongX DESC
go
go
CREATE VIEW view8 AS
SELECT TOP 10 Masp, Tensp, giaban
FROM Sanpham
ORDER BY giaban DESC
go
go
CREATE VIEW view9 AS
SELECT masp, tensp, soluong, mausac, giaban, donvitinh, mota
FROM Sanpham JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
WHERE Tenhang = 'Samsung' AND giaban BETWEEN 100000.0 AND 50000000.0
go
go
CREATE VIEW view10 AS
SELECT SUM(soluongN*dongiaN) AS 'Tổng tiền đã nhập'
FROM Sanpham JOIN NHAP ON Sanpham.Masp = nhap.Masp
               JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
WHERE YEAR(Ngaynhap) = 2020 AND Tenhang = 'Samsung'
go
go
CREATE VIEW view11 AS
SELECT SUM(soluongX*giaban) AS 'Tổng tiền đã xuất'
FROM Xuat JOIN Sanpham ON Xuat.Masp = Sanpham.Masp
WHERE Ngayxuat = '2/9/2018'
go
go
CREATE VIEW view12 AS
SELECT Sohdn , Ngaynhap
FROM Nhap 
WHERE YEAR(Ngaynhap) = 2018 AND soluongN*dongiaN = (
SELECT MAX(soluongN*dongiaN)
FROM Nhap
WHERE YEAR(Ngaynhap) = 2018)
go
go
CREATE VIEW view13 AS
SELECT TOP 10 Tenhang, Mausac, Soluong
FROM Sanpham JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
               JOIN Nhap ON Sanpham.Masp = Nhap.Masp
WHERE YEAR(Ngaynhap) = 2019 
ORDER BY soluongN
go
go
CREATE VIEW view14 AS
SELECT Sanpham.Masp, Tensp
FROM Sanpham JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
               JOIN Xuat ON Sanpham.Masp = Xuat.Masp
WHERE Tenhang = 'Samsung' AND Manv = 'NV01'
go
go
CREATE VIEW view15 AS
SELECT Nhap.Sohdn, Masp, SoluongN, Ngaynhap
FROM Nhap JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
WHERE Masp = 'SP02' AND Nhap.Manv = 'NV02'
go
go
CREATE VIEW view16 AS
SELECT Nhanvien.manv,tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.Manv = Xuat.Manv
WHERE Masp = 'SP02' AND NGAYXUAT = '03-02-2020'
SELECT *
FROM XUAT
go
go
CREATE VIEW view17 AS
SELECT Hangsx.tenhang, COUNT(Sanpham.masp) AS so_luong_sp
FROM Hangsx
JOIN Sanpham ON Hangsx.Mahangsx = Sanpham.Mahangsx
GROUP BY Hangsx.Tenhang
go
go
CREATE VIEW view18 AS
SELECT masp, SUM(soluongN * dongiaN) AS TongTienNhap
FROM Nhap
WHERE YEAR(Ngaynhap) = 2020
GROUP BY masp;
go
go
CREATE VIEW view19 AS
SELECT Sanpham.masp, Sanpham.tensp, SUM(Xuat.soluongX) as tong_soluong_xuat
FROM Sanpham
JOIN Xuat ON Sanpham.masp = Xuat.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Hangsx.tenhang = 'Samsung'
GROUP BY Sanpham.masp, Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000;
go
go
CREATE VIEW view20 AS
SELECT Nhanvien.Phong, COUNT(*) as SoLuongNamMoiPhong
FROM Nhanvien
WHERE Nhanvien.Gioitinh=N'Nam'
GROUP BY Nhanvien.Phong
go
go
CREATE VIEW view21 AS
SELECT Hangsx.tenhang, SUM(Nhap.soluongN) as TongSoLuongNhap
FROM Nhap
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang
go
go
CREATE VIEW view22 AS
SELECT Nhanvien.manv, Nhanvien.tennv, SUM(Xuat.soluongX * Sanpham.giaban) AS tongtienxuat
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
INNER JOIN Nhanvien ON Xuat.manv = Nhanvien.manv
WHERE YEAR(Xuat.ngayxuat) = 2018
GROUP BY Nhanvien.manv, Nhanvien.tennv
go
go
CREATE VIEW view23 AS
SELECT SUM(Nhap.soluongN * Nhap.dongiaN) as TongTienNhap, Nhanvien.Manv, Nhanvien.Tennv
FROM Nhap inner join Nhanvien on Nhap.Manv=Nhanvien.Manv
WHERE CONVERT(DATE, Nhap.Ngaynhap, 105) between  '2018-08-01' and'2018-08-31'
GROUP BY Nhanvien.Manv, Nhanvien.Tennv
HAVING SUM(Nhap.soluongN * Nhap.dongiaN) > 100000;
go
go
CREATE VIEW view24 AS
SELECT SanPham.masp, SanPham.tensp
FROM SanPham
WHERE SanPham.masp NOT IN (SELECT masp FROM Xuat)
go
go
CREATE VIEW view25 AS
SELECT DISTINCT SanPham.masp, SanPham.tensp
FROM Nhap inner join SanPham on Nhap.Masp=SanPham.masp inner join Xuat on SanPham.masp=Xuat.Masp
WHERE YEAR(Nhap.NgayNhap) = '2018' and YEAR(Xuat.NgayXuat) = '2018'
go
go
CREATE VIEW view26 AS
SELECT DISTINCT NhanVien.Manv, NhanVien.Tennv
FROM Nhap inner join Nhanvien on Nhap.Manv=Nhanvien.Manv inner join Xuat on Nhanvien.Manv=Xuat.Manv
go
go
CREATE VIEW view27 AS
SELECT Nhanvien.Manv, Nhanvien.Tennv, Nhanvien.Sodt, Nhanvien.Diachi, Nhanvien.email, Nhanvien.Gioitinh, Nhanvien.Phong
FROM Nhap inner join Nhanvien on Nhap.Manv=Nhanvien.Manv inner join Xuat on Nhanvien.Manv=Xuat.Manv
WHERE Nhap.Manv is null and Xuat.Manv is null