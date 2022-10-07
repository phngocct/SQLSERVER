--Thứ tự nhập liệu: CHA TRƯỚC CON SAU
--BẢNG CHA (CHỨA KHÓA CHÍNH), BẢNG CON (CHỨA KHÓA NGOẠI)
--KHOA NGOẠI CHO PHÉP NULL
--KHI KHÓA CHÍNH CÓ 2 CỘT, KHÓA NGOẠI THAM CHIẾU ĐẾN KHÓA CHÍNH ĐÓ 
--CŨNG PHẢI CÓ 2 CỘT
--PHONGBAN => NHANVIEN => THANNHAN => DIADIEM_PHG =>DEAN =>CONGVIEC=> PHONGBAN
--B1: Tạo bảng PHONGBAN
CREATE TABLE PHONGBAN (
	MAPHG INT IDENTITY(1,1) PRIMARY KEY, --khóa chính tự tăng
	TENPHG nvarchar(15) NOT NULL UNIQUE, --tên phòng duy nhất
	TRPHG nvarchar(9), --trgphg tham chiếu đến NHANVIEN, nhưng sẽ thiết lập sau vì bảng NHANVIEN chưa được tạo
	NG_NHANCHUC date
) 
--B2: Nhập dữ liệu cho bảng PHONGBAN, chỉ nhập 2 cột (cột MAPHG k nhập vì nó tự tăng,
--cột TRPHG k nhập vì chưa tạo bảng NHANVIEN)
--Khi nhập dữ liệu cho bảng mà không nhập tất cả các cột phải chỉ rõ 
--nhập dữ liệu cho những cột nào
INSERT INTO PHONGBAN(TenPhg,NG_NHANCHUC)VALUES (N'Quản Lý',CAST(N'1971-06-19' AS Date)),
(N'Kinh doanh',CAST(N'1985-01-01' AS Date))
INSERT INTO PHONGBAN(TenPhg,NG_NHANCHUC)VALUES (N'Nhân sự',CAST(N'1971-06-19' AS Date)),
(N'Điều hành',CAST(N'1985-01-01' AS Date))
SELECT * FROM PHONGBAN
--B3: Tạo bảng NHANVIEN
CREATE TABLE NHANVIEN(
	MANV nvarchar(9) PRIMARY KEY, --khóa chính
	HONV nvarchar(15) NOT NULL,
	TENLOT nvarchar(15) NOT NULL,
	TENNV nvarchar(15) NOT NULL,
	NGSINH date NOT NULL,
	DCHI nvarchar(50) NOT NULL,
	PHAI nvarchar(3) NOT NULL,
	LUONG float NOT NULL,
	MA_NQL nvarchar(9), --khóa ngoại, tham chiếu đến bảng NHANVIEN, cùng kiểu manv
	PHG int --khóa ngoại, tham chiếu đến PHONGBAN, cùng kiểu với MAPHG
)
--B4: Thiết lập khóa ngoại cho bảng NHANVIEN
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NV_NV FOREIGN KEY(MA_NQL) REFERENCES NHANVIEN(MANV)
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NV_PB FOREIGN KEY(PHG) REFERENCES PHONGBAN(MAPHG)
--B5: Nhập liệu cho bảng NHANVIEN, k nhập cột MA_NQL,PHG
INSERT INTO NHANVIEN(Manv,HONV,TENLOT,Tennv,NGSINH,DCHI,PHAI,LUONG)
VALUES ('001',N'Lê',N'Quỳnh',N'Như',CAST(N'1967-02-01' AS Date),N'291 Hồ Văn Huê,Tp HCM',N'Nữ',43000)
INSERT INTO NHANVIEN(Manv,HONV,TENLOT,Tennv,NGSINH,DCHI,PHAI,LUONG)
VALUES ('006',N'Phạm',N'Văn',N'Vinh',CAST(N'1965-01-01' AS Date),N'45 Trưng Vương, Hà Nội',N'Nữ',55000)
--B6: Thiết lập khóa ngoại cho bảng PHONGBAN
ALTER TABLE PHONGBAN ADD CONSTRAINT FK_PB_NV FOREIGN KEY(TRPHG) REFERENCES NHANVIEN(MANV)
--B7:Sau khi nhập tất cả dữ liệu cho bảng NHANVIEN quay lại cập nhật MA_NQL
UPDATE NHANVIEN SET Ma_NQL='006' WHERE Manv='001'
--B8:Sau khi nhập tất cả dữ liệu cho bảng PHONGBAN quay lại cập nhật PHG
UPDATE NHANVIEN SET PHG=4 WHERE Manv='001'
--B9: Sau khi nhập tất cả dữ liệu cho bảng NHANVIEN, quay lại cập nhật TRPHG
UPDATE PHONGBAN SET TRPhg='006' WHERE MaPHG=1
--B10: Tạo bảng THANNHAN, thiết lập khóa chính, khóa ngoại, nhập liệu
--B11: Tạo bảng DIADIEM_PHG, thiết lập khóa chính, khóa ngoại, nhập liệu
CREATE TABLE DIADIEM_PHG(
	MAPHG int,
	DIADIEM nvarchar(15),
	PRIMARY KEY(MAPHG,DIADIEM), --thiet lap khóa chính 2 cột
	FOREIGN KEY(MAPHG) REFERENCES PHONGBAN(MAPHG) -- thiet lap khoa ngoai
)
--B12: Tạo bảng DEAN, thiết lập khóa chính(MADA, tự tăng IDENTITY(1,1), kiểu int),tên đề án UNIQUE, khóa ngoại, nhập liệu
--B13: Tạo bảng CONGVIEC, thiết lập khóa chính(MADA,STT), khóa ngoại(MADA), nhập liệu
--B14:Tạo bảng PHANCONG, thiết lập khóa chính(MANVIEN,MADA,STT), khóa ngoại1(MADA,STT),khóa ngoại 2(MA_NVIEN), nhập liệu
CREATE TABLE PHANCONG(
	MA_NVIEN nvarchar(9), --cung kieu MANV
	MADA int,
	STT int,
	THOIGIAN float,
	PRIMARY KEY(MA_NVIEN,MADA,STT),
	FOREIGN KEY(MA_NVIEN) REFERENCES NHANVIEN(MANV), -- thiet lap khoa ngoai1
	FOREIGN KEY(MADA,STT) REFERENCES CONGVIEC(MADA,STT) -- thiet lap khoa ngoai2
)