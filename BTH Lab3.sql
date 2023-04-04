--1
SELECT Hangsx.tenhang, COUNT(Sanpham.masp) AS so_luong_sp
FROM Hangsx
JOIN Sanpham ON Hangsx.Mahangsx = Sanpham.Mahangsx
GROUP BY Hangsx.Tenhang
--2--
SELECT masp, SUM(soluongN * dongiaN) AS TongTienNhap
FROM Nhap
WHERE YEAR(Ngaynhap) = 2020
GROUP BY masp;
--3--
SELECT Sanpham.masp, Sanpham.tensp, SUM(Xuat.soluongX) as tong_soluong_xuat
FROM Sanpham
JOIN Xuat ON Sanpham.masp = Xuat.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Hangsx.tenhang = 'Samsung'
GROUP BY Sanpham.masp, Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000;
--4--
SELECT phong, COUNT(*) AS SoLuongNam
FROM Nhanvien
WHERE gioitinh = 'Nam'
GROUP BY phong
--5--
SELECT Hangsx.tenhang, SUM(Nhap.soluongN) as TongSoLuongNhap
FROM Nhap
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang
--6
SELECT Nhanvien.manv, Nhanvien.tennv, SUM(Xuat.soluongX * Sanpham.giaban) AS tongtienxuat
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
INNER JOIN Nhanvien ON Xuat.manv = Nhanvien.manv
WHERE YEAR(Xuat.ngayxuat) = 2018
GROUP BY Nhanvien.manv, Nhanvien.tennv
--7--
SELECT SUM(Nhap.soluongN * Nhap.dongiaN) as TongTienNhap, Nhanvien.Manv, Nhanvien.Tennv
FROM Nhap inner join Nhanvien on Nhap.Manv=Nhanvien.Manv
WHERE CONVERT(DATE, Nhap.Ngaynhap, 105) between  '2018-08-01' and'2018-08-31'
GROUP BY Nhanvien.Manv, Nhanvien.Tennv
HAVING SUM(Nhap.soluongN * Nhap.dongiaN) > 100000;
---Câu 8---
SELECT SanPham.masp, SanPham.tensp
FROM SanPham
WHERE SanPham.masp NOT IN (SELECT masp FROM Xuat)
---Câu 9---
SELECT DISTINCT SanPham.masp, SanPham.tensp
FROM Nhap inner join SanPham on Nhap.Masp=SanPham.masp inner join Xuat on SanPham.masp=Xuat.Masp
WHERE YEAR(Nhap.NgayNhap) = '2018' and YEAR(Xuat.NgayXuat) = '2018'
---Câu 10---
SELECT DISTINCT NhanVien.Manv, NhanVien.Tennv
FROM Nhap inner join Nhanvien on Nhap.Manv=Nhanvien.Manv inner join Xuat on Nhanvien.Manv=Xuat.Manv
---Câu 11---
SELECT Nhanvien.Manv, Nhanvien.Tennv, Nhanvien.Sodt, Nhanvien.Diachi, Nhanvien.email, Nhanvien.Gioitinh, Nhanvien.Phong
FROM Nhap inner join Nhanvien on Nhap.Manv=Nhanvien.Manv inner join Xuat on Nhanvien.Manv=Xuat.Manv
WHERE Nhap.Manv is null and Xuat.Manv is null