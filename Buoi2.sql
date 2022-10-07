use quanly_duan
SELECT
FROM
WHERE

SELECT *
FROM NHAN_VIEN

select *
from NHAN_VIEN

select DINCT TEN_NV
from NHAN_VIEN

--Hien thi danh sach nhan vien nu o can tho
SELECT *
FROM NHAN_VIEN
WHERE GIOI_TINH LIKE N'nữ'
	AND DIA_CHI LIKE N'cần thơ'

SELECT Columns
FROM TableName
WHERE Conditions
GROUP BY Columns
HAVING Conditions
ORDER BY Columns ASC/DESC

--Viết câu truy vấn hiển thị số nhân viên của từng phòng ban, 
--chỉ hiển thị phòng ban có từ 2 nhân viên trở lên
--chỉ tính những nhân viên có lương >200
--(thao luan 2p)

SELECT MA_PHONG,COUNT(MA_NHANVIEN) AS 'Số Lượng'
FROM NHAN_VIEN
WHERE LUONG >200
GROUP BY MA_PHONG
HAVING COUNT(MA_NHANVIEN) >=2


--SELECT *
--FROM Table1, Table2
--WHERE Table1.Column=Table2.Column

--Hiển thị tên phòng ban mà nhân viên thuộc về
SELECT NHAN_VIEN.HO_NV, NHAN_VIEN.TEN_NV, PHONG_BAN.TEN_PHONG
FROM NHAN_VIEN, PHONG_BAN
WHERE NHAN_VIEN.MA_PHONG=PHONG_BAN.MA_PHONG

select NAM_SINH, DIA_CHI
from NHAN_VIEN
where HO_NV LIKE N'Lê Nguyễn'
AND TEN_NV LIKE N'Trang'

select *
from NHAN_VIEN
select *
from QUANLY_DUAN
select *
from DU_AN
select *
from PHONG_BAN
--1. Hiển thị tên nhân viên tham gia dự án với vai trò leader
SELECT HO_NV+ ' ' + TEN_NV AS 'HỌ VÀ TÊN'
FROM QUANLY_DUAN, NHAN_VIEN
WHERE VAI_TRO=N'Leader'
AND QUANLY_DUAN.MA_NHANVIEN=NHAN_VIEN.MA_NHANVIEN
--2. Hiển thị tên dự án có ít nhân viên tham gia hơn số nhân viên
--của dự án marketing
SELECT QUANLY_DUAN.MA_DUAN, DU_AN.TEN_DUAN
FROM DU_AN, QUANLY_DUAN
WHERE DU_AN.MA_DUAN= QUANLY_DUAN.MA_DUAN
GROUP BY QUANLY_DUAN.MA_DUAN, DU_AN.TEN_DUAN
HAVING COUNT (MA_NHANVIEN) <
	(SELECT COUNT(MA_NHANVIEN)
	FROM DU_AN, QUANLY_DUAN
	WHERE DU_AN.MA_DUAN= QUANLY_DUAN.MA_DUAN
	AND DU_AN.TEN_DUAN = N'marketing'
	)
--3. Hiển thị tên các dự án có số giờ nhỏ hơn 270
--4. Hiển thị tên phòng ban có bà trần thị bình làm trưởng phòng 


--C1
SELECT *
FROM NHAN_VIEN
WHERE MA_PHONG='PB004'
--C2
SELECT *
FROM NHAN_VIEN
WHERE Luong>900
--C3
SELECT *
FROM NHAN_VIEN
WHERE (Luong>1000 AND MA_PHONG='PB004')
     OR (Luong>800 AND MA_PHONG='PB004')
--C4
SELECT HO_NV+ ' ' + TEN_NV AS 'HỌ VÀ TÊN'
FROM NHAN_VIEN
WHERE DIA_CHI LIKE N'%Cần Thơ%'
--C5
SELECT HO_NV+ ' ' + TEN_NV AS 'HỌ VÀ TÊN'
FROM NHAN_VIEN
WHERE HO_NV LIKE N'N%'
--C6
SELECT NAM_SINH, DIA_CHI
FROM NHAN_VIEN
WHERE HO_NV=N'Huỳnh Trung'
	AND TEN_NV=N'Dũng'





