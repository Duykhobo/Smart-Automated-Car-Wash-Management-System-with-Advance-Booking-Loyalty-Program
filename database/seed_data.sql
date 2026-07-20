-- =======================================================================
-- FILE: seed_data.sql
-- MÔ TẢ: Thêm dữ liệu mẫu (Seed Data) cho hệ thống AutoWash Pro để Demo
-- =======================================================================
USE SmartCarWash;
GO

-- 1. THÊM SERVICES (DỊCH VỤ RỬA XE)
IF NOT EXISTS (SELECT 1 FROM Services)
BEGIN
    INSERT INTO Services (Name, BasePrice, DurationMinutes, IsActive, ServiceType) VALUES 
    (N'Rửa xe ngoài (demi)', 70000.00, 30, 1, 'Main'),
    (N'Rửa xe tiêu chuẩn', 100000.00, 45, 1, 'Main'),
    (N'Rửa xe cao cấp (Wax bóng)', 200000.00, 60, 1, 'Main'),
    (N'Vệ sinh nội thất', 350000.00, 90, 1, 'Addon'),
    (N'Tẩy ố kính', 150000.00, 30, 1, 'Addon'),
    (N'Khử mùi dàn lạnh', 100000.00, 20, 1, 'Addon');
END

IF NOT EXISTS (SELECT 1 FROM ServicePrices)
BEGIN
    -- Dịch vụ 1: Rửa xe ngoài
    INSERT INTO ServicePrices (ServiceID, VehicleSize, Price) VALUES (1, 'SEDAN', 70000), (1, 'SUV', 80000), (1, 'XLARGE', 90000);
    
    -- Dịch vụ 2: Rửa xe tiêu chuẩn
    INSERT INTO ServicePrices (ServiceID, VehicleSize, Price) VALUES (2, 'SEDAN', 100000), (2, 'SUV', 110000), (2, 'XLARGE', 120000);
    
    -- Dịch vụ 3: Rửa xe cao cấp
    INSERT INTO ServicePrices (ServiceID, VehicleSize, Price) VALUES (3, 'SEDAN', 200000), (3, 'SUV', 250000), (3, 'XLARGE', 300000);
    
    -- Dịch vụ 4: Vệ sinh nội thất
    INSERT INTO ServicePrices (ServiceID, VehicleSize, Price) VALUES (4, 'SEDAN', 350000), (4, 'SUV', 400000), (4, 'XLARGE', 450000);
    
    -- Dịch vụ 5: Tẩy ố kính
    INSERT INTO ServicePrices (ServiceID, VehicleSize, Price) VALUES (5, 'SEDAN', 150000), (5, 'SUV', 180000), (5, 'XLARGE', 200000);
    
    -- Dịch vụ 6: Khử mùi dàn lạnh
    INSERT INTO ServicePrices (ServiceID, VehicleSize, Price) VALUES (6, 'SEDAN', 100000), (6, 'SUV', 120000), (6, 'XLARGE', 150000);
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
-- 1.5. THÊM VEHICLE TYPES
IF NOT EXISTS (SELECT 1 FROM VehicleTypes)
BEGIN
    INSERT INTO VehicleTypes (TypeName, VehicleSize) VALUES 
    (N'Sedan (4 chỗ)', 'SEDAN'),
    (N'Hatchback', 'SEDAN'),
    (N'SUV (7 chỗ)', 'SUV'),
    (N'CUV (5-7 chỗ)', 'SUV'),
    (N'Bán tải', 'XLARGE'),
    (N'MPV', 'XLARGE');
END
GO

-- 2. THÊM USERS VÀ CUSTOMERS (KÈM VEHICLES)
IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = 'customer_silver')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role) 
    VALUES ('customer_silver', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'CUSTOMER');
    DECLARE @UID1 INT = SCOPE_IDENTITY();
    
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@UID1, N'Khách Hàng Silver', '0901111111', 'silver@gmail.com', 2, 250, 2500000, 6);
    
    DECLARE @CID1 INT = SCOPE_IDENTITY();
    INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleTypeID, Color, IsDefault)
    VALUES (@CID1, '51G-11111', 'Toyota', 'Vios', 1, 'White', 1);
END

IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = 'customer_gold')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role) 
    VALUES ('customer_gold', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'CUSTOMER');
    DECLARE @UID2 INT = SCOPE_IDENTITY();
    
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@UID2, N'Khách Hàng Gold', '0902222222', 'gold@gmail.com', 3, 1000, 7000000, 16);
    
    DECLARE @CID2 INT = SCOPE_IDENTITY();
    INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleTypeID, Color, IsDefault)
    VALUES (@CID2, '51H-22222', 'Mazda', 'CX-5', 3, 'Red', 1);
END
GO

IF NOT EXISTS (SELECT 1 FROM Users WHERE Username = 'customer_platinum')
BEGIN
    INSERT INTO Users (Username, PasswordHash, Role) 
    VALUES ('customer_platinum', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'CUSTOMER');
    DECLARE @UID3 INT = SCOPE_IDENTITY();
    
    INSERT INTO Customers (UserID, FullName, Phone, Email, TierID, PointsBalance, TotalSpend, TotalWashes)
    VALUES (@UID3, N'Khách Hàng Platinum', '0903333333', 'platinum@gmail.com', 4, 15000, 15000000, 35);
    
    DECLARE @CID3 INT = SCOPE_IDENTITY();
    INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleTypeID, Color, IsDefault)
    VALUES (@CID3, '51I-33333', 'Ford', 'Ranger', 5, 'Black', 1);
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
    INSERT INTO Vouchers (CustomerID, VoucherCode, RewardType, PointsCost, ExpiryDate, Status, DiscountPercent) VALUES
    (@CID_VOUCHER, 'FREE-111111', 'FREE_WASH', 3000, DATEADD(month, 1, GETDATE()), 'Unused', 100.00),
    (@CID_VOUCHER, 'DISC-222222', '20_PERCENT_OFF', 600, DATEADD(day, 15, GETDATE()), 'Unused', 20.00);
END
GO



PRINT N'Thêm dữ liệu mẫu thành công!';

-- 6. THÊM SYSTEM CONFIG (CẤU HÌNH HỆ THỐNG)
IF NOT EXISTS (SELECT 1 FROM SystemConfig)
BEGIN
    INSERT INTO SystemConfig (ConfigKey, ConfigValue, Description) VALUES
    ('MinAdvanceBookingMinutes', '60', N'Thời gian đặt trước tối thiểu (phút)'),
    ('MinCancellationMinutes', '120', N'Thời gian hủy lịch tối thiểu (phút)'),
    ('OpeningHour', '8', N'Giờ mở cửa (0-23)'),
    ('ClosingHour', '22', N'Giờ đóng cửa (0-23)'),
    ('PointsPerCurrencyUnit', '1', N'Tỷ lệ quy đổi: 1,000 VND = ? Điểm'),
    ('VehicleMultiplier_SEDAN', '1.0', N'Hệ số giá cho xe SEDAN (Chuẩn)'),
    ('VehicleMultiplier_SUV', '1.2', N'Hệ số giá cho xe SUV'),
    ('VehicleMultiplier_XLARGE', '1.5', N'Hệ số giá cho xe XLARGE (Bán tải, xe lớn)');
END
GO

-- 7. THÊM REWARD CATALOG (QUÀ TẶNG)
IF NOT EXISTS (SELECT 1 FROM RewardCatalog)
BEGIN
    INSERT INTO RewardCatalog (RewardName, Description, PointsCost, RewardType, ImageIcon, DiscountPercent) VALUES
    (N'Voucher Giảm 10%', N'Áp dụng cho mọi dịch vụ rửa xe', 300, '10_PERCENT_OFF', 'percent', 10.00),
    (N'Voucher Giảm 20%', N'Áp dụng cho mọi dịch vụ rửa xe', 600, '20_PERCENT_OFF', 'tag', 20.00),
    (N'Rửa Xe Miễn Phí', N'Miễn phí 1 lần rửa xe tiêu chuẩn', 3000, 'FREE_WASH', 'droplets', 100.00);
END
GO