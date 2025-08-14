create database data;
use data;
CREATE TABLE KhachHang (
    tendangnhap VARCHAR(50) PRIMARY KEY,
    matkhau VARCHAR(100) NOT NULL,
    hoten NVARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    dienthoai VARCHAR(20),
    diachi NVARCHAR(200),
    ngaydangky DATETIME DEFAULT GETDATE()
);
CREATE TABLE LoaiHang (
    maloai INT PRIMARY KEY,
    tenloai NVARCHAR(100) NOT NULL,
	tinhtrang nvarchar(50)
);
CREATE TABLE MatHang (
    mahang INT PRIMARY KEY,
    maloai INT NOT NULL,
    tenhang NVARCHAR(100) NOT NULL,
    donvitinh NVARCHAR(20),
    dongia DECIMAL(18,2) NOT NULL,
    soluongton INT DEFAULT 0,
    mota NVARCHAR(500),
    hinh NVARCHAR(255),
	tinhtrang nvarchar(50),
    FOREIGN KEY (maloai) REFERENCES LoaiHang(maloai)
);
CREATE TABLE DonHang (
    madonhang INT PRIMARY KEY IDENTITY(1,1),
    tendangnhap VARCHAR(50) NOT NULL,
    ngaydathang DATETIME DEFAULT GETDATE(),
    trangthai NVARCHAR(50) DEFAULT 'Chờ xử lý',
    tongtien DECIMAL(18,2),
    FOREIGN KEY (tendangnhap) REFERENCES KhachHang(tendangnhap)
);
CREATE TABLE QuanTriVien (
    tendangnhap VARCHAR(50) PRIMARY KEY,
    matkhau VARCHAR(100) NOT NULL,
    hoten NVARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    quyen NVARCHAR(50) DEFAULT 'admin'
);
CREATE TABLE NhaCC (
    mancc INT PRIMARY KEY,
    tenncc NVARCHAR(100) NOT NULL,
    diachi NVARCHAR(200),
    dienthoai VARCHAR(20),
    email VARCHAR(100)
);
CREATE TABLE NhapKho (
    sophieu INT PRIMARY KEY IDENTITY(1,1),
    mancc INT NOT NULL,
    ngaynhap DATETIME DEFAULT GETDATE(),
    tongtien DECIMAL(18,2),
    nguoinhap VARCHAR(50) NOT NULL,
    ghichu NVARCHAR(500),
    FOREIGN KEY (mancc) REFERENCES NhaCC(mancc),
    FOREIGN KEY (nguoinhap) REFERENCES QuanTriVien(tendangnhap)
);
CREATE TABLE CTNhap (
    sophieu INT NOT NULL,
    mahang INT NOT NULL,
    soluong INT NOT NULL,
    dongia DECIMAL(18,2) NOT NULL,
    thanhtien AS (soluong * dongia),
    PRIMARY KEY (sophieu, mahang),
    FOREIGN KEY (sophieu) REFERENCES NhapKho(sophieu),
    FOREIGN KEY (mahang) REFERENCES MatHang(mahang)
);
CREATE TABLE CTHoaDon (
    madonhang INT NOT NULL,
    mahang INT NOT NULL,
    soluong INT NOT NULL,
    dongia DECIMAL(18,2) NOT NULL,
    giamgia DECIMAL(18,2) DEFAULT 0,
    thanhtien AS (soluong * (dongia - giamgia)),
    PRIMARY KEY (madonhang, mahang),
    FOREIGN KEY (madonhang) REFERENCES DonHang(madonhang),
    FOREIGN KEY (mahang) REFERENCES MatHang(mahang)
);
