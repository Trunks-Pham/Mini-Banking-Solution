CREATE DATABASE minibankingdata;

USE minibankingdata;

-- Bảng Tài Khoản Khách Hàng 
CREATE TABLE customerLogin (
     loginName VARCHAR(255) PRIMARY KEY ,  -- Tên đăng nhập (khóa chính) 
     password VARCHAR(255) NOT NULL ,  -- Mật khẩu
     accountStatus VARCHAR(255) DEFAULT 'Đang Hoạt Động'  -- Trạng thái tài khoản
);

-- Bảng Khách Hàng
CREATE TABLE customer (
    id VARCHAR(255) PRIMARY KEY, -- CCCD (khóa chính)
    name VARCHAR(255), -- Họ tên khách hàng
    dateOfBirth DATE, -- Ngày sinh
    gender VARCHAR(255), -- Giới tính
    email VARCHAR(255), -- Email
    phoneNumber VARCHAR(255), -- Số điện thoại
    address VARCHAR(255), -- Địa chỉ
    loginName VARCHAR(255) not null, -- Khóa phụ
    FOREIGN KEY (loginName) REFERENCES customerLogin(loginName)
);

-- Bảng Số Tài Khoản Khách Hàng
CREATE TABLE customerAccount (
    accountNumber VARCHAR(255) PRIMARY KEY, -- STK (khóa chính)
    id VARCHAR(255), -- CCCD (khóa phụ liên kết với bảng Khách hàng)
    balance DOUBLE DEFAULT 100000, -- Số dư
    dateCreated DATE NOT NULL DEFAULT NOW(), -- Ngày tạo
    status VARCHAR(255) DEFAULT 'Đang Hoạt Động', -- Trạng Thái
    FOREIGN KEY (id) REFERENCES customer(id)
);

-- Bảng Hủ Chi Tiêu
CREATE TABLE expenseJar (
    jarID INT AUTO_INCREMENT PRIMARY KEY, -- ID hủ (khóa chính)
    jarName VARCHAR(255), -- Tên hủ
    jarAmount DOUBLE DEFAULT 0, -- Số tiền của hủ
    jarDateCreated DATE DEFAULT NOW(), -- Ngày tạo hủ
    accountNumber VARCHAR(255), -- STK (khóa ngoại liên kết với bảng Số tài khoản của khách hàng)
    jarExpenseContent VARCHAR(255), -- Nội dung chi tiêu hủ
    FOREIGN KEY (accountNumber) REFERENCES customerAccount(accountNumber)
)AUTO_INCREMENT = 1 ;

-- Giao dịch hủ
CREATE TABLE jarTransaction (
    transactionID INT AUTO_INCREMENT PRIMARY KEY, -- ID Giao dịch (khóa chính)
    jarID INT, -- ID hủ (Khóa ngoại)
    jarTransactionName VARCHAR(255), -- Tên hủ giao dịch
    jarTransactionAmount DOUBLE, -- Số tiền giao dịch hủ
    jarTransactionDate DATETIME DEFAULT NOW(), -- Ngày giao dịch hủ
    FOREIGN KEY (jarID) REFERENCES expenseJar(jarID)
)AUTO_INCREMENT = 1 ;

-- Bảng Sổ Tiết Kiệm
CREATE TABLE savingsBook (
    savingsBookID INT AUTO_INCREMENT PRIMARY KEY, -- ID sổ tiết kiệm (khóa chính)
    accountNumber VARCHAR(255), -- STK (khóa ngoại liên kết với bảng Số tài khoản của khách hàng)
    savingsName VARCHAR(255), -- Tên sổ tiết kiệm
    savingsDate DATETIME DEFAULT NOW(),
    savingsTerm INT, -- Kỳ hạn tiết kiệm
    savingsAmount DOUBLE DEFAULT 1000000, -- Số tiền tiết kiệm
    interestRate DOUBLE, -- Lãi suất
    interestAmountPerTerm DOUBLE, -- Số tiền lãi suất kỳ
    FOREIGN KEY (accountNumber) REFERENCES customerAccount(accountNumber)
)AUTO_INCREMENT = 1 ;

-- Lãi suất theo kỳ hạn
CREATE TABLE interestRateByTerm (
	id INT AUTO_INCREMENT PRIMARY KEY, -- ID lãi suất theo kỳ hạn (khóa chính)
    month INT , -- Tháng 
    interestRate DOUBLE -- Lãi suất
) AUTO_INCREMENT = 1 ;

-- Bảng Giao Dịch 
CREATE TABLE transaction (
     transactionID INT AUTO_INCREMENT PRIMARY KEY ,  -- ID giao dịch (khóa chính)
     accountNumber VARCHAR(255) NOT NULL ,  -- STK (khóa ngoại liên kết với bảng Số tài khoản của khách hàng)
     transactionDate DATETIME NOT NULL DEFAULT now() ,  -- Ngày giao dịch (date time )
     transactionType VARCHAR(255) NOT NULL,  -- Loại giao dịch ( Chuyển(-), Gửi tiền (-), Gửi tiết kiệm (-) ,Rút Live(-), Rút Từ Sổ (+), Nhận(+))
     transactionAmount DOUBLE NOT NULL DEFAULT 1000 ,  -- Số tiền giao dịch
     transactionContent VARCHAR(255) NOT NULL ,  -- Nội dung giao dịch
     FOREIGN KEY (accountNumber) REFERENCES customerAccount(accountNumber)
)AUTO_INCREMENT =1 ;

-- Bảng Khách Hàng Phản Hồi
CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Khóa chính, tự động tăng
    customerID VARCHAR(255), -- Khóa phụ liên kết với bảng Customercustomer
    name VARCHAR(255) NOT NULL, -- Tên người gửi phản hồi
    email VARCHAR(255) NOT NULL, -- Email người gửi phản hồi
    subject VARCHAR(255) NOT NULL, -- Tiêu đề phản hồi
    message TEXT NOT NULL, -- Nội dung phản hồi
    createdAt DATETIME DEFAULT NOW(), -- Thời gian gửi phản hồi
	FOREIGN KEY (customerID) REFERENCES customer(id)
) AUTO_INCREMENT =1 ;

-- Bảng Khách Hàng Yêu Cầu Hỗ Trợ
CREATE TABLE contact (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Khóa chính, tự động tăng
    customerID VARCHAR(255) NOT NULL, -- Khóa phụ liên kết với bảng Customer
    name VARCHAR(255) NOT NULL, -- Tên người gửi phản hồi
    email VARCHAR(255) NOT NULL, -- Email người gửi phản hồi
    phone VARCHAR(255) NOT NULL, -- Số điện thoại người gửi
    content TEXT NOT NULL, -- Nội dung yêu cầu
    createdAt DATETIME DEFAULT NOW(), -- Thời gian gửi phản hồi
    FOREIGN KEY (customerID) REFERENCES customer(id)
)AUTO_INCREMENT = 1 ;