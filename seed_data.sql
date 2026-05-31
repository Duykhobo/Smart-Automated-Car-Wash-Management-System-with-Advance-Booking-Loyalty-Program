USE SmartCarWash;
GO

-- =======================================================================
-- SEED DATA - DỮ LIỆU MẪU CHO DEMO
-- =======================================================================

-- 1. THÊM GÓI DỊCH VỤ MẪU
IF NOT EXISTS (SELECT 1 FROM Services)
BEGIN
    INSERT INTO Services (Name, BasePrice, IsActive) VALUES
    (N'Rửa Bọt Tuyết Tiêu Chuẩn', 100000.00, 1),
    (N'Rửa Bọt Tuyết Gầm + Xịt Gầm', 150000.00, 1),
    (N'Rửa Chăm Sóc Cấp Cao (Ceramic)', 350000.00, 1),
    (N'Vệ Sinh Nội Thất Toàn Diện', 500000.00, 1),
    (N'Đánh Bóng Ngoại Thất Dọn Nhẹ', 800000.00, 1),
    (N'Phủ Nano Kính Chống Bám Nước', 250000.00, 1),
    (N'Khử Mùi Ozone Nội Thất', 200000.00, 1);
    PRINT N'Đã thêm dữ liệu Services mẫu.'
END
GO

-- 2. THÊM CHƯƠNG TRÌNH KHUYẾN MÃI MẪU (Promotions)
IF NOT EXISTS (SELECT 1 FROM Promotions)
BEGIN
    INSERT INTO Promotions (Title, Description, TargetTierID, DiscountPercent, StartDate, EndDate, IsActive) VALUES
    (N'Giảm giá mùa mưa', N'Giảm 10% cho tất cả khách hàng trong tháng này.', NULL, 10.00, GETDATE(), DATEADD(month, 1, GETDATE()), 1),
    (N'Tri ân hạng Vàng', N'Giảm 20% cho khách hàng hạng Gold trở lên.', 3, 20.00, GETDATE(), DATEADD(month, 2, GETDATE()), 1),
    (N'Đặc quyền Platinum', N'Khách hàng Platinum được giảm 30% mọi dịch vụ.', 4, 30.00, GETDATE(), DATEADD(year, 1, GETDATE()), 1);
    PRINT N'Đã thêm dữ liệu Promotions mẫu.'
END
GO

-- 3. THÊM TÀI KHOẢN ADMIN MẪU (NẾU CHƯA CÓ)
-- Lưu ý: Mật khẩu đã được mã hóa. Admin này dùng để test giao diện Quản trị.
IF NOT EXISTS (SELECT 1 FROM Users WHERE Role = 'ADMIN')
BEGIN
    -- Tạo tài khoản admin với sđt: 0999999999
    INSERT INTO Users (Username, PasswordHash, Role, IsActive) 
    VALUES ('0999999999', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'ADMIN', 1);
    
    DECLARE @AdminUserID INT = SCOPE_IDENTITY();
    
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@AdminUserID, N'Quản Trị Viên', '0999999999', 'admin@autowash.com', 4, 9999, 50000000.00, 100);
    
    PRINT N'Đã tạo tài khoản Admin (SĐT: 0999999999).'
END
GO

-- 4. THÊM MỘT VÀI XE CHO KHÁCH HÀNG ĐẦU TIÊN ĐỂ TEST
DECLARE @FirstCustomerID INT;
SELECT TOP 1 @FirstCustomerID = CustomerID FROM Customers WHERE Role = 'CUSTOMER' OR UserID = 1;

IF @FirstCustomerID IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Vehicles WHERE CustomerID = @FirstCustomerID)
    BEGIN
        INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleType, Color, IsDefault, IsActive)
        VALUES 
        (@FirstCustomerID, '51H-123.45', N'Toyota', N'Vios', N'Sedan', N'Trắng', 1, 1),
        (@FirstCustomerID, '30A-987.65', N'Mazda', N'CX-5', N'SUV', N'Đỏ', 0, 1),
        (@FirstCustomerID, '61B-555.55', N'Ford', N'Ranger', N'Bán tải', N'Đen', 0, 1);
        
        PRINT N'Đã thêm xe mẫu cho khách hàng ID: ' + CAST(@FirstCustomerID AS VARCHAR);
    END
END
GO
