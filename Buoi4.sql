--Tinh tong cua 2 so a va b
DECLARE @a int=5, @b int=10, @tong int
SET @tong=@a+@b
--SELECT @tong
print N'Tổng của 2 số a và b là: '+ CAST(@tong AS nvarchar(9))

--Tinh luong trung binh cua nhan vien
DECLARE @luongTB float
SELECT @luongTB=AVG(LUONG)
FROM NHANVIEN
SELECT @luongTB

--Hien thi ho ten nhan vien o hcm
DECLARE @NV_HCM TABLE (
	MANV nvarchar(9),
	HONV nvarchar(15),
	TENLOT nvarchar(15),
	TENNV nvarchar(15)
)
/*INSERT INTO @NV_HCM 
	SELECT HONV, TENLOT, TENNV
	FROM NHANVIEN
	WHERE DCHI LIKE N'%HCM'*/
INSERT INTO @NV_HCM VALUES ('005',N'lê',N'văn',N'tám')
UPDATE @NV_HCM SET HONV=N'Lâm' WHERE MANV='005'
SELECT * FROM @NV_HCM

--TINH DIEN TICH CUA HINH CHU NHAT KHI BIET CHIEU DAI, CHIEU RONG
BEGIN
	DECLARE @chieudai int =10, @chieurong int =5, @dientich int
	SET @dientich=@chieudai*@chieurong;
	SELECT @dientich
END

--Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) 
--có số thân nhân nhiều hơn số thân nhân của Lê Quỳnh Như
BEGIN
	DECLARE @NV_TN TABLE (
	MANV nvarchar(9),
	HONV nvarchar(15),
	TENLOT nvarchar(15),
	TENNV nvarchar(15)
)
INSERT INTO @NV_TN
	SELECT b.MA_NVIEN, HONV, TENLOT, TENNV
	FROM NHANVIEN a, THANNHAN b
	WHERE a.MANV=b.MA_NVIEN
	GROUP BY b.MA_NVIEN, HONV, TENLOT, TENNV
	HAVING COUNT(TENTN) >
		(SELECT COUNT(TENTN)
		FROM NHANVIEN a, THANNHAN b
		WHERE a.MANV=b.MA_NVIEN
			AND a.HONV =N'Lê'
			AND a.TENLOT =N'Quỳnh'
			AND a.TENNV =N'Như'
		)
	SELECT * FROM @NV_TN
END

--Với các công việc trung bình mất trên 20 giờ, 
--liệt kê tên công việc và số nhân viên tham gia của từng công việc
BEGIN
	DECLARE @CV_TG TABLE (
		MADA int,
		STT int,
		TEN_CONG_VIEC nvarchar(50),
		SoNV int
	)
	INSERT INTO @CV_TG 
		SELECT b.MADA, b.STT,a.TEN_CONG_VIEC, COUNT(b.MA_NVIEN)
		FROM CONGVIEC a, PHANCONG b
		WHERE a.MADA=b.MADA
			AND a.STT =b.STT
		GROUP BY b.MADA, b.STT,a.TEN_CONG_VIEC
		HAVING AVG(THOIGIAN) > 20
	SELECT * FROM @CV_TG
END

INSERT INTO PHONGBAN (TENPHG) VALUES ('Kinhdoanh'),('DIEUHANH'),()
update phongban set TRPHG='001' where MAPHG=1
update NHANVIEN set MA_NQL='001' where MANV=1
primary key(bcdjn,bcueh)