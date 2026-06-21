-- =======================================================================
-- FILE: SeedData.sql
-- MÔ TẢ: Thêm dữ liệu mẫu (Seed Data) cho hệ thống AutoWash Pro để Demo
-- =======================================================================
USE SmartCarWash;
GO

-- 1. THÊM SERVICES (DỊCH VỤ RỬA XE)
IF NOT EXISTS (SELECT 1 FROM Services)
BEGIN
    INSERT INTO Services (Name, BasePrice, IsActive) VALUES 
    (N'Rửa Bọt Tuyết Tiêu Chuẩn', 100000.00, 1),
    (N'Rửa Xe Cao Cấp + Phủ Ceramic', 250000.00, 1),
    (N'Vệ Sinh Nội Thất Toàn Diện', 350000.00, 1),
    (N'Tẩy Ố Kính + Đánh Bóng Sơn', 500000.00, 1);
END
GO

-- 2. THÊM USERS & CUSTOMERS (MẬT KHẨU MẶC ĐỊNH LÀ 123456 -> SHA256: 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92)
IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = 'admin')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role) 
    VALUES ('admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'ADMIN');
END

IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = 'manager')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role) 
    VALUES ('manager', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'MANAGER');
END

IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = 'customer_silver')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role) 
    VALUES ('customer_silver', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'CUSTOMER');
    DECLARE @UID1 INT = SCOPE_IDENTITY();
    
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@UID1, N'Khách Hàng Silver', '0901111111', 'silver@gmail.com', 2, 250, 2500000, 6);
    
    DECLARE @CID1 INT = SCOPE_IDENTITY();
    INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleType, Color, IsDefault)
    VALUES (@CID1, '51G-111.11', 'Toyota', 'Vios', 'Sedan', 'White', 1);
END

IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = 'customer_gold')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role) 
    VALUES ('customer_gold', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'CUSTOMER');
    DECLARE @UID2 INT = SCOPE_IDENTITY();
    
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@UID2, N'Khách Hàng Gold', '0902222222', 'gold@gmail.com', 3, 1000, 7000000, 16);
    
    DECLARE @CID2 INT = SCOPE_IDENTITY();
    INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleType, Color, IsDefault)
    VALUES (@CID2, '51H-222.22', 'Mazda', 'CX-5', 'SUV', 'Red', 1);
END
GO

-- 3. THÊM PROMOTIONS
IF NOT EXISTS (SELECT 1 FROM Promotions)
BEGIN
    INSERT INTO Promotions (Title, Description, TargetTierID, DiscountPercent, StartDate, EndDate) VALUES
    (N'Ưu Đãi Đặc Quyền Silver', N'Giảm giá 10% cho khách hàng hạng Silver tháng này.', 2, 10.00, GETDATE(), DATEADD(month, 1, GETDATE())),
    (N'Ngày Hội Tri Ân Khách VIP', N'Giảm 20% cho khách hàng hạng Platinum và Gold.', 3, 20.00, GETDATE(), DATEADD(day, 7, GETDATE()));
END
GO

-- 4. THÊM VOUCHERS CHO KHÁCH HÀNG (LẤY 1 KHÁCH HÀNG VÍ DỤ)
DECLARE @CID_VOUCHER INT;
SELECT TOP 1 @CID_VOUCHER = CustomerID FROM Customers WHERE Phone = '0901111111';

IF @CID_VOUCHER IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Vouchers WHERE CustomerID = @CID_VOUCHER)
BEGIN
    INSERT INTO Vouchers (CustomerID, VoucherCode, RewardType, PointsCost, ExpiryDate, Status) VALUES
    (@CID_VOUCHER, 'FREE-111111', 'Free Wash', 500, DATEADD(month, 1, GETDATE()), 'Unused'),
    (@CID_VOUCHER, 'DISC-222222', 'Discount 20%', 300, DATEADD(day, 15, GETDATE()), 'Unused');
END
GO

-- 5. THÊM BOOKINGS (LỊCH SỬ ĐẶT LỊCH) VÀ WASH RECORDS ĐỂ DEMO THỐNG KÊ
DECLARE @CID_BOOKING INT;
SELECT TOP 1 @CID_BOOKING = CustomerID FROM Customers WHERE Phone = '0902222222';
DECLARE @VID_BOOKING INT;
SELECT TOP 1 @VID_BOOKING = VehicleID FROM Vehicles WHERE CustomerID = @CID_BOOKING;

IF @CID_BOOKING IS NOT NULL AND @VID_BOOKING IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Bookings WHERE CustomerID = @CID_BOOKING)
BEGIN
    -- Một lịch hẹn sắp tới (Pending)
    EXEC sp_CreateBookingTransaction 
        @CustomerID = @CID_BOOKING, 
        @ServiceID = 2, 
        @VehicleID = @VID_BOOKING, 
        @BookingDate = CAST(GETDATE() + 1 AS DATE), 
        @ScheduledTime = '10:00:00', 
        @OriginalPrice = 250000.00, 
        @DiscountAmount = 0, 
        @FinalPrice = 250000.00;

    -- Một lịch sử đã hoàn thành (Completed) ngày hôm qua
    INSERT INTO Bookings (CustomerID, ServiceID, VehicleID, BookingDate, ScheduledTime, OriginalPrice, DiscountAmount, FinalPrice, Status)
    VALUES (@CID_BOOKING, 1, @VID_BOOKING, CAST(GETDATE() - 1 AS DATE), '14:30:00', 100000.00, 0, 100000.00, 'Completed');
    
    DECLARE @COMPLETED_BOOKING_ID INT = SCOPE_IDENTITY();
    
    -- Thêm WashRecord cho lịch sử đã hoàn thành
    INSERT INTO WashRecords (BookingID, ActualStartTime, ActualEndTime, LPRConfidenceScore, OperatorNotes)
    VALUES (@COMPLETED_BOOKING_ID, DATEADD(minute, 5, GETDATE()-1), DATEADD(minute, 35, GETDATE()-1), 99.5, N'Xe sạch, không trầy xước.');
END
GO

PRINT 'Thêm dữ liệu mẫu thành công!';
