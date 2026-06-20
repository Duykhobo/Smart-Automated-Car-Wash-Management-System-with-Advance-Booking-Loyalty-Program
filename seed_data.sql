USE SmartCarWash;
GO

-- =======================================================================
-- SEED DATA - DỮ LIỆU MẪU ĐỂ TEST ĐẦY ĐỦ CÁC TÍNH NĂNG
-- =======================================================================

-- 1. XÓA SẠCH DỮ LIỆU CŨ NẾU CẦN (Tuỳ chọn - Hiện tại chỉ INSERT thêm nếu chưa có)

-- 2. THÊM GÓI DỊCH VỤ MẪU
IF NOT EXISTS (SELECT 1 FROM Services)
BEGIN
    INSERT INTO Services (Name, BasePrice, IsActive) VALUES
    (N'Rửa Bọt Tuyết Tiêu Chuẩn', 100000.00, 1),
    (N'Rửa Bọt Tuyết Gầm + Xịt Gầm', 150000.00, 1),
    (N'Rửa Chăm Sóc Cấp Cao (Ceramic)', 350000.00, 1),
    (N'Vệ Sinh Nội Thất Toàn Diện', 500000.00, 1),
    (N'Đánh Bóng Ngoại Thất Dọn Nhẹ', 800000.00, 1);
    PRINT N'Đã thêm dữ liệu Services mẫu.'
END
GO

-- 3. THÊM CHƯƠNG TRÌNH KHUYẾN MÃI MẪU
IF NOT EXISTS (SELECT 1 FROM Promotions)
BEGIN
    INSERT INTO Promotions (Title, Description, TargetTierID, DiscountPercent, StartDate, EndDate, IsActive) VALUES
    (N'Tri ân hạng Vàng', N'Giảm 20% cho khách hàng hạng Gold trở lên.', 3, 20.00, GETDATE(), DATEADD(month, 2, GETDATE()), 1),
    (N'Đặc quyền Platinum', N'Khách hàng Platinum được giảm 30% mọi dịch vụ.', 4, 30.00, GETDATE(), DATEADD(year, 1, GETDATE()), 1);
    PRINT N'Đã thêm dữ liệu Promotions mẫu.'
END
GO

-- 4. THÊM TÀI KHOẢN ADMIN ĐỂ TEST (Password: 123)
IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = '0999999999')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role, IsActive) 
    VALUES ('0999999999', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'ADMIN', 1);
    
    DECLARE @AdminUserID INT = SCOPE_IDENTITY();
    
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@AdminUserID, N'Quản Trị Viên (Admin)', '0999999999', 'admin@autowash.com', 4, 9999, 50000000.00, 100);
    PRINT N'Đã tạo tài khoản Admin (0999999999 / 123).'
END
GO

-- 5. THÊM TÀI KHOẢN KHÁCH HÀNG Ở CÁC HẠNG KHÁC NHAU (Password: 123)
-- Platinum (TierID = 4)
IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = '0900000004')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role, IsActive) VALUES ('0900000004', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'CUSTOMER', 1);
    DECLARE @PlatUserID INT = SCOPE_IDENTITY();
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@PlatUserID, N'Khách Hàng Platinum', '0900000004', 'plat@autowash.com', 4, 2000, 15000000.00, 35);
    
    INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleType, Color, IsDefault, IsActive)
    VALUES ((SELECT CustomerID FROM Customers WHERE UserID = @PlatUserID), '51H-999.99', N'Mercedes', N'S450', N'Sedan', N'Đen', 1, 1);
END
GO

-- Gold (TierID = 3)
IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = '0900000003')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role, IsActive) VALUES ('0900000003', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'CUSTOMER', 1);
    DECLARE @GoldUserID INT = SCOPE_IDENTITY();
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@GoldUserID, N'Khách Hàng Gold', '0900000003', 'gold@autowash.com', 3, 1000, 8000000.00, 20);
    
    INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleType, Color, IsDefault, IsActive)
    VALUES ((SELECT CustomerID FROM Customers WHERE UserID = @GoldUserID), '51H-888.88', N'Toyota', N'Camry', N'Sedan', N'Trắng', 1, 1);
END
GO

-- Silver (TierID = 2)
IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = '0900000002')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role, IsActive) VALUES ('0900000002', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'CUSTOMER', 1);
    DECLARE @SilvUserID INT = SCOPE_IDENTITY();
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@SilvUserID, N'Khách Hàng Silver', '0900000002', 'silver@autowash.com', 2, 500, 3000000.00, 8);
    
    INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleType, Color, IsDefault, IsActive)
    VALUES ((SELECT CustomerID FROM Customers WHERE UserID = @SilvUserID), '51H-777.77', N'Honda', N'City', N'Sedan', N'Bạc', 1, 1);
END
GO

-- Member (TierID = 1)
IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = '0900000001')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role, IsActive) VALUES ('0900000001', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'CUSTOMER', 1);
    DECLARE @MembUserID INT = SCOPE_IDENTITY();
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@MembUserID, N'Khách Hàng Thường', '0900000001', 'member@autowash.com', 1, 0, 0.00, 0);
    
    INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleType, Color, IsDefault, IsActive)
    VALUES ((SELECT CustomerID FROM Customers WHERE UserID = @MembUserID), '51H-666.66', N'Kia', N'Morning', N'Hatchback', N'Vàng', 1, 1);
END
GO

-- 6. TẠO SẴN MỘT VÀI SLOT CHO HÔM NAY ĐỂ TEST WAITLIST (MaxCapacity = 2 để nhanh đầy)
DECLARE @Today DATE = CAST(GETDATE() AS DATE);
IF NOT EXISTS (SELECT 1 FROM BookingSlotCapacity WHERE SlotDate = @Today AND TimeSlot = '08:00:00')
BEGIN
    INSERT INTO BookingSlotCapacity (SlotDate, TimeSlot, MaxCapacity, CurrentBooked)
    VALUES (@Today, '08:00:00', 2, 0),
           (@Today, '09:00:00', 2, 0),
           (@Today, '10:00:00', 2, 0);
    PRINT N'Đã tạo Slot cho ngày hôm nay để test Waitlist.'
END
GO
