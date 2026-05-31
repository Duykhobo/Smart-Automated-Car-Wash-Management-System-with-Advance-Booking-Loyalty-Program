-- =======================================================================
-- DỰ ÁN: AUTOWASH PRO (SMART AUTOMATED CAR WASH)
-- HỆ QUẢN TRỊ: SQL SERVER
-- PHIÊN BẢN: Đã chuẩn hóa (Khử Hardcode MemberTiers & Thêm Hãng Xe)
-- =======================================================================

IF DB_ID('SmartCarWash') IS NULL
BEGIN
    CREATE DATABASE SmartCarWash;
END
GO

USE SmartCarWash;
GO

-- =======================================================================
-- 1. DỌN DẸP BẢNG CŨ (Sắp xếp theo thứ tự Ràng buộc Khóa Ngoại)
-- =======================================================================
IF OBJECT_ID('dbo.PointLedger', 'U') IS NOT NULL DROP TABLE dbo.PointLedger;
IF OBJECT_ID('dbo.WashRecords', 'U') IS NOT NULL DROP TABLE dbo.WashRecords;
IF OBJECT_ID('dbo.Bookings', 'U') IS NOT NULL DROP TABLE dbo.Bookings;
IF OBJECT_ID('dbo.Vouchers', 'U') IS NOT NULL DROP TABLE dbo.Vouchers;
IF OBJECT_ID('dbo.Vehicles', 'U') IS NOT NULL DROP TABLE dbo.Vehicles;
IF OBJECT_ID('dbo.BookingSlotCapacity', 'U') IS NOT NULL DROP TABLE dbo.BookingSlotCapacity;
IF OBJECT_ID('dbo.Promotions', 'U') IS NOT NULL DROP TABLE dbo.Promotions;
IF OBJECT_ID('dbo.Services', 'U') IS NOT NULL DROP TABLE dbo.Services;
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users;
IF OBJECT_ID('dbo.MemberTiers', 'U') IS NOT NULL DROP TABLE dbo.MemberTiers;
GO

-- =======================================================================
-- 2. TẠO CÁC BẢNG DỮ LIỆU
-- =======================================================================
-- 0. BẢNG MEMBER_TIERS (Bảng từ điển hạng thành viên để khử hard-code)
CREATE TABLE MemberTiers (
    TierID INT IDENTITY(1,1) PRIMARY KEY,
    TierName VARCHAR(50) UNIQUE NOT NULL,
    MinWashes INT NOT NULL DEFAULT 0,
    MinSpend DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    PointsModifier DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    PriorityRank INT NOT NULL DEFAULT 1
);
GO

-- 1. BẢNG USERS
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL, 
    PasswordHash VARCHAR(256) NOT NULL,
    Role VARCHAR(20) NOT NULL CHECK (Role IN ('ADMIN', 'MANAGER', 'CUSTOMER')),
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

-- 2. BẢNG CUSTOMERS
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL UNIQUE, 
    FullName NVARCHAR(100) NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL,
    Email VARCHAR(100) NULL,
    TierID INT DEFAULT 1, -- Khóa ngoại trỏ đến MemberTiers (1 = Member mặc định)
    PointsBalance INT DEFAULT 0 CHECK (PointsBalance >= 0),
    TotalSpend DECIMAL(12,2) DEFAULT 0.00,
    TotalWashes INT DEFAULT 0,
    TierUpgradeDate DATETIME NULL,
    Avatar VARCHAR(255) NULL, 
    IsActive BIT DEFAULT 1, 
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Customers_Users FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Customers_Tiers FOREIGN KEY (TierID) REFERENCES MemberTiers(TierID)
);

-- 3. BẢNG VEHICLES (Bổ sung Brand, Model)
CREATE TABLE Vehicles (
    VehicleID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    LicensePlate VARCHAR(15) UNIQUE NOT NULL,
    Brand NVARCHAR(50) NULL, -- Hãng xe (Toyota, Mazda...)
    Model NVARCHAR(50) NULL, -- Dòng xe (CX-5, Vios...)
    VehicleType NVARCHAR(50) NULL, 
    Color NVARCHAR(50) NULL, -- Màu xe
    ImageURL VARCHAR(255) NULL,
    IsDefault BIT DEFAULT 0,
    IsActive BIT DEFAULT 1, 
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Vehicles_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 4. BẢNG SERVICES
CREATE TABLE Services (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    BasePrice DECIMAL(10,2) NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

-- 5. BẢNG PROMOTIONS
CREATE TABLE Promotions (
    PromoID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL,
    TargetTierID INT NULL, 
    DiscountPercent DECIMAL(5,2) NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Promotions_Tiers FOREIGN KEY (TargetTierID) REFERENCES MemberTiers(TierID)
);

-- 6. BẢNG BOOKING_SLOT_CAPACITY
CREATE TABLE BookingSlotCapacity (
    SlotID INT IDENTITY(1,1) PRIMARY KEY,
    SlotDate DATE NOT NULL,
    TimeSlot TIME NOT NULL,
    MaxCapacity INT DEFAULT 3,
    CurrentBooked INT DEFAULT 0,
    CONSTRAINT UQ_BookingSlotCapacity_Date_Time UNIQUE (SlotDate, TimeSlot),
    CONSTRAINT CHK_CurrentBooked CHECK (CurrentBooked <= MaxCapacity)
);

-- 7. BẢNG VOUCHERS
CREATE TABLE Vouchers (
    VoucherID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    VoucherCode VARCHAR(30) UNIQUE NOT NULL,
    RewardType VARCHAR(30) NULL,
    PointsCost INT NOT NULL,
    ExpiryDate DATETIME NOT NULL,
    Status VARCHAR(15) DEFAULT 'Unused' CHECK (Status IN ('Unused', 'Used', 'Expired')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Vouchers_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 8. BẢNG BOOKINGS
CREATE TABLE Bookings (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ServiceID INT NOT NULL,
    VehicleID INT NOT NULL, 
    VoucherID INT NULL, 
    BookingDate DATE NOT NULL,
    ScheduledTime TIME NOT NULL,
    OriginalPrice DECIMAL(10,2) NOT NULL,
    DiscountAmount DECIMAL(10,2) DEFAULT 0.00,
    FinalPrice DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Confirmed', 'InProgress', 'Completed', 'Cancelled', 'NoShow')),
    PriorityScore INT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Bookings_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    CONSTRAINT FK_Bookings_Services FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID),
    CONSTRAINT FK_Bookings_Vehicles FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    CONSTRAINT FK_Bookings_Vouchers FOREIGN KEY (VoucherID) REFERENCES Vouchers(VoucherID)
);

-- 9. BẢNG WASH_RECORDS
CREATE TABLE WashRecords (
    WashRecordID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT NOT NULL UNIQUE,
    ActualStartTime DATETIME NULL,
    ActualEndTime DATETIME NULL,
    LPRConfidenceScore DECIMAL(5,2) NULL,
    OperatorNotes NVARCHAR(256) NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_WashRecords_Bookings FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

-- 10. BẢNG POINT_LEDGER
CREATE TABLE PointLedger (
    LedgerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ReferenceType VARCHAR(20) NOT NULL CHECK (ReferenceType IN ('Accrual', 'Redemption', 'Expiration', 'Refund')),
    ReferenceID INT NULL,
    PointsChange INT NOT NULL,
    PointsRemaining INT DEFAULT 0,
    EarnedDate DATETIME NOT NULL,
    ExpiryDate DATETIME NOT NULL,
    IsExpired AS (CAST(CASE WHEN GETDATE() > ExpiryDate THEN 1 ELSE 0 END AS BIT)),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_PointLedger_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

-- =======================================================================
-- 3. INSERT DỮ LIỆU TỪ ĐIỂN MẶC ĐỊNH
-- =======================================================================
INSERT INTO MemberTiers (TierName, MinWashes, MinSpend, PointsModifier, PriorityRank) VALUES 
('Member', 0, 0, 0.00, 1),
('Silver', 5, 2000000, 0.10, 2),
('Gold', 15, 6000000, 0.30, 3),
('Platinum', 30, 15000000, 0.50, 4);
GO

-- =======================================================================
-- 4. TẠO INDEX ĐỂ TỐI ƯU HÓA TRUY VẤN
-- =======================================================================
CREATE NONCLUSTERED INDEX IX_Customers_Phone ON Customers(Phone);
CREATE NONCLUSTERED INDEX IX_Vehicles_LicensePlate ON Vehicles(LicensePlate);
CREATE NONCLUSTERED INDEX IX_Vehicles_CustomerID ON Vehicles(CustomerID);
CREATE NONCLUSTERED INDEX IX_Bookings_CustomerID ON Bookings(CustomerID);
CREATE NONCLUSTERED INDEX IX_Bookings_BookingDate ON Bookings(BookingDate);
CREATE NONCLUSTERED INDEX IX_Bookings_Status ON Bookings(Status);
CREATE NONCLUSTERED INDEX IX_Vouchers_CustomerID ON Vouchers(CustomerID);
CREATE NONCLUSTERED INDEX IX_PointLedger_Points ON PointLedger(CustomerID, ExpiryDate, PointsRemaining) WHERE PointsRemaining > 0;
GO

-- =======================================================================
-- 5. FUNCTIONS
-- =======================================================================

IF OBJECT_ID('dbo.fn_CalculatePriorityScore') IS NOT NULL DROP FUNCTION dbo.fn_CalculatePriorityScore;
GO
CREATE FUNCTION dbo.fn_CalculatePriorityScore(@TierID INT, @ScheduledTime TIME)
RETURNS INT
AS
BEGIN
    DECLARE @TierRank INT;
    SELECT @TierRank = PriorityRank FROM MemberTiers WHERE TierID = @TierID;
    IF @TierRank IS NULL SET @TierRank = 1;

    DECLARE @MinutesFromMidnight INT = DATEDIFF(MINUTE, '00:00:00', @ScheduledTime);
    RETURN (@TierRank * 1000) + (100000 - @MinutesFromMidnight);
END
GO

IF OBJECT_ID('dbo.fn_CalculateEarnedPoints') IS NOT NULL DROP FUNCTION dbo.fn_CalculateEarnedPoints;
GO
CREATE FUNCTION dbo.fn_CalculateEarnedPoints(@InvoiceAmount DECIMAL(10,2), @TierBonusModifier DECIMAL(5,2))
RETURNS INT
AS
BEGIN
    RETURN CAST(FLOOR(@InvoiceAmount / 1000.0) * (1.0 + @TierBonusModifier) AS INT);
END
GO

-- =======================================================================
-- 6. STORED PROCEDURES
-- =======================================================================

IF OBJECT_ID('dbo.sp_CreateBookingTransaction') IS NOT NULL DROP PROCEDURE dbo.sp_CreateBookingTransaction;
GO
CREATE PROCEDURE dbo.sp_CreateBookingTransaction
    @CustomerID INT, @ServiceID INT, @VehicleID INT, @VoucherID INT = NULL, 
    @BookingDate DATE, @ScheduledTime TIME, @OriginalPrice DECIMAL(10,2),
    @DiscountAmount DECIMAL(10,2), @FinalPrice DECIMAL(10,2),
    @DefaultMaxCapacity INT = 3 
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @CurrentBooked INT, @MaxCapacity INT, @SlotID INT;

        SELECT @SlotID = SlotID, @CurrentBooked = CurrentBooked, @MaxCapacity = MaxCapacity
        FROM BookingSlotCapacity WITH (UPDLOCK, ROWLOCK)
        WHERE SlotDate = @BookingDate AND TimeSlot = @ScheduledTime;

        IF @SlotID IS NULL
        BEGIN
            INSERT INTO BookingSlotCapacity (SlotDate, TimeSlot, MaxCapacity, CurrentBooked)
            VALUES (@BookingDate, @ScheduledTime, @DefaultMaxCapacity, 0);
            SET @SlotID = SCOPE_IDENTITY();
            SET @CurrentBooked = 0;
            SET @MaxCapacity = @DefaultMaxCapacity;
        END

        IF @CurrentBooked >= @MaxCapacity
        BEGIN
            RAISERROR('Khung giờ này đã đầy, vui lòng chọn giờ khác.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF @VoucherID IS NOT NULL
        BEGIN
            UPDATE Vouchers SET Status = 'Used', UpdatedAt = GETDATE()
            WHERE VoucherID = @VoucherID AND CustomerID = @CustomerID AND Status = 'Unused';
            IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Voucher không hợp lệ hoặc đã sử dụng.', 16, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END
        END

        UPDATE BookingSlotCapacity SET CurrentBooked = CurrentBooked + 1 WHERE SlotID = @SlotID;

        DECLARE @TierID INT;
        SELECT @TierID = TierID FROM Customers WHERE CustomerID = @CustomerID;
        DECLARE @PriorityScore INT = dbo.fn_CalculatePriorityScore(@TierID, @ScheduledTime);

        INSERT INTO Bookings (CustomerID, ServiceID, VehicleID, VoucherID, BookingDate, ScheduledTime, OriginalPrice, DiscountAmount, FinalPrice, Status, PriorityScore)
        VALUES (@CustomerID, @ServiceID, @VehicleID, @VoucherID, @BookingDate, @ScheduledTime, @OriginalPrice, @DiscountAmount, @FinalPrice, 'Pending', @PriorityScore);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_RedeemVoucherFIFO') IS NOT NULL DROP PROCEDURE dbo.sp_RedeemVoucherFIFO;
GO
CREATE PROCEDURE dbo.sp_RedeemVoucherFIFO
    @CustomerID INT, @RewardType VARCHAR(30), @PointsCost INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @CurrentBalance INT;
        
        -- Chống Race condition
        SELECT @CurrentBalance = PointsBalance FROM Customers WITH (UPDLOCK) WHERE CustomerID = @CustomerID;

        IF @CurrentBalance < @PointsCost
        BEGIN
            RAISERROR('Lỗi: Số dư điểm không đủ để đổi Voucher này.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        DECLARE @PointsToDeduct INT = @PointsCost, @LedgerID INT, @PointsRemaining INT;
        
        -- LOCAL Cursor trừ điểm FIFO
        DECLARE fifo_cursor CURSOR LOCAL FOR
        SELECT LedgerID, PointsRemaining FROM PointLedger
        WHERE CustomerID = @CustomerID AND ExpiryDate >= GETDATE() AND PointsRemaining > 0 ORDER BY ExpiryDate ASC; 

        OPEN fifo_cursor;
        FETCH NEXT FROM fifo_cursor INTO @LedgerID, @PointsRemaining;

        WHILE @@FETCH_STATUS = 0 AND @PointsToDeduct > 0
        BEGIN
            IF @PointsRemaining <= @PointsToDeduct
            BEGIN
                UPDATE PointLedger SET PointsRemaining = 0 WHERE LedgerID = @LedgerID;
                SET @PointsToDeduct = @PointsToDeduct - @PointsRemaining;
            END
            ELSE
            BEGIN
                UPDATE PointLedger SET PointsRemaining = PointsRemaining - @PointsToDeduct WHERE LedgerID = @LedgerID;
                SET @PointsToDeduct = 0;
            END
            FETCH NEXT FROM fifo_cursor INTO @LedgerID, @PointsRemaining;
        END
        CLOSE fifo_cursor;
        DEALLOCATE fifo_cursor;

        DECLARE @VoucherCode VARCHAR(30) = @RewardType + '-' + RIGHT(CAST(NEWID() AS VARCHAR(36)), 6);
        INSERT INTO Vouchers (CustomerID, VoucherCode, RewardType, PointsCost, ExpiryDate, Status)
        VALUES (@CustomerID, UPPER(@VoucherCode), @RewardType, @PointsCost, DATEADD(day, 30, GETDATE()), 'Unused');
        DECLARE @NewVoucherID INT = SCOPE_IDENTITY();

        UPDATE Customers SET PointsBalance = PointsBalance - @PointsCost, UpdatedAt = GETDATE() WHERE CustomerID = @CustomerID;

        INSERT INTO PointLedger (CustomerID, ReferenceType, ReferenceID, PointsChange, PointsRemaining, EarnedDate, ExpiryDate)
        VALUES (@CustomerID, 'Redemption', @NewVoucherID, -@PointsCost, 0, GETDATE(), GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO

IF OBJECT_ID('dbo.sp_MonthlyTierDowngrade') IS NOT NULL DROP PROCEDURE dbo.sp_MonthlyTierDowngrade;
GO
CREATE PROCEDURE dbo.sp_MonthlyTierDowngrade
AS
BEGIN
    SET NOCOUNT ON;
    CREATE TABLE #Rolling12MonthStats (CustomerID INT, Last12MonthsWashes INT, Last12MonthsSpend DECIMAL(12,2));
    
    INSERT INTO #Rolling12MonthStats (CustomerID, Last12MonthsWashes, Last12MonthsSpend)
    SELECT CustomerID, COUNT(BookingID), ISNULL(SUM(FinalPrice), 0)
    FROM Bookings WHERE Status = 'Completed' AND BookingDate >= DATEADD(month, -12, GETDATE()) GROUP BY CustomerID;

    UPDATE c
    SET 
        c.TierID = (
            SELECT TOP 1 TierID FROM MemberTiers 
            WHERE s.Last12MonthsWashes >= MinWashes OR s.Last12MonthsSpend >= MinSpend
            ORDER BY PriorityRank DESC
        ),
        c.UpdatedAt = GETDATE()
    FROM Customers c LEFT JOIN #Rolling12MonthStats s ON c.CustomerID = s.CustomerID
    WHERE (c.TierUpgradeDate IS NULL OR DATEDIFF(month, c.TierUpgradeDate, GETDATE()) >= 3) AND c.TierID <> 1;

    DROP TABLE #Rolling12MonthStats;
END
GO

-- =======================================================================
-- 7. TRIGGERS
-- =======================================================================

IF OBJECT_ID('dbo.trg_AutoUpgradeTier') IS NOT NULL DROP TRIGGER dbo.trg_AutoUpgradeTier;
GO
CREATE TRIGGER dbo.trg_AutoUpgradeTier
ON Bookings
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    IF UPDATE(Status)
    BEGIN
        -- 1. Lọc ra danh sách Booking vừa đổi thành 'Completed'
        SELECT 
            i.BookingID, 
            i.CustomerID, 
            i.FinalPrice,
            c.TierID,
            t.PointsModifier
        INTO #CompletedBookings
        FROM inserted i 
        INNER JOIN deleted d ON i.BookingID = d.BookingID
        INNER JOIN Customers c ON i.CustomerID = c.CustomerID
        INNER JOIN MemberTiers t ON c.TierID = t.TierID
        WHERE i.Status = 'Completed' AND d.Status <> 'Completed';

        IF NOT EXISTS (SELECT 1 FROM #CompletedBookings) RETURN;

        -- 2. Tính điểm bằng Set-based logic
        SELECT 
            BookingID,
            CustomerID,
            FinalPrice,
            CAST(FLOOR(FinalPrice / 1000.0) * (1.0 + PointsModifier) AS INT) AS EarnedPoints
        INTO #BookingPoints
        FROM #CompletedBookings;

        -- 3. Cập nhật Sổ cái điểm
        INSERT INTO PointLedger (CustomerID, ReferenceType, ReferenceID, PointsChange, PointsRemaining, EarnedDate, ExpiryDate)
        SELECT 
            CustomerID, 
            'Accrual', 
            BookingID, 
            EarnedPoints, 
            EarnedPoints, 
            GETDATE(), 
            DATEADD(YEAR, 1, GETDATE())
        FROM #BookingPoints
        WHERE EarnedPoints > 0;

        -- 4. Gom nhóm để UPDATE bản ghi Customer
        SELECT 
            CustomerID,
            COUNT(BookingID) AS AddedWashes,
            SUM(FinalPrice) AS AddedSpend,
            SUM(EarnedPoints) AS TotalEarnedPoints
        INTO #CustomerAgg
        FROM #BookingPoints
        GROUP BY CustomerID;

        -- 5. UPDATE Customers
        UPDATE c
        SET 
            c.PointsBalance = c.PointsBalance + a.TotalEarnedPoints,
            c.TotalWashes = c.TotalWashes + a.AddedWashes,
            c.TotalSpend = c.TotalSpend + a.AddedSpend,
            
            c.TierID = (
                SELECT TOP 1 t.TierID 
                FROM MemberTiers t
                WHERE (c.TotalWashes + a.AddedWashes) >= t.MinWashes OR (c.TotalSpend + a.AddedSpend) >= t.MinSpend
                ORDER BY t.PriorityRank DESC
            ),
            
            c.TierUpgradeDate = CASE 
                WHEN c.TierID <> (
                    SELECT TOP 1 t.TierID 
                    FROM MemberTiers t
                    WHERE (c.TotalWashes + a.AddedWashes) >= t.MinWashes OR (c.TotalSpend + a.AddedSpend) >= t.MinSpend
                    ORDER BY t.PriorityRank DESC
                ) THEN GETDATE() 
                ELSE c.TierUpgradeDate 
            END,
            c.UpdatedAt = GETDATE()
        FROM Customers c
        INNER JOIN #CustomerAgg a ON c.CustomerID = a.CustomerID;

        DROP TABLE #CompletedBookings;
        DROP TABLE #BookingPoints;
        DROP TABLE #CustomerAgg;
    END
END
GO
