USE SmartCarWash;
GO

-- 1. Cập nhật lại các hệ số mặc định theo đúng đề bài cho MemberTiers
UPDATE MemberTiers SET PointsModifier = 0.10 WHERE TierName = 'Silver';
UPDATE MemberTiers SET PointsModifier = 0.20 WHERE TierName = 'Gold';
UPDATE MemberTiers SET PointsModifier = 0.30 WHERE TierName = 'Platinum';
GO

-- 2. Thêm Config mặc định (nếu chưa có) vào SystemConfig
IF NOT EXISTS (SELECT 1 FROM SystemConfig WHERE ConfigKey = 'PointsPerCurrencyUnit')
BEGIN
    INSERT INTO SystemConfig (ConfigKey, ConfigValue, Description)
    VALUES ('PointsPerCurrencyUnit', '10000', N'Tỷ lệ quy đổi: 10,000 VND = ? Điểm');
END
GO

-- 3. Cập nhật lại Trigger Tính Điểm (đọc linh hoạt từ SystemConfig)
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

        -- Lấy tỷ lệ quy đổi điểm từ SystemConfig (Ví dụ cấu hình là 1,000đ = 1 điểm => tỷ lệ 1)
        DECLARE @PointsPerUnit DECIMAL(18,4) = 1;
        SELECT @PointsPerUnit = CAST(ConfigValue AS DECIMAL(18,4)) 
        FROM SystemConfig 
        WHERE ConfigKey = 'PointsPerCurrencyUnit';
        
        -- Kiểm tra tránh chia cho 0
        IF @PointsPerUnit <= 0 SET @PointsPerUnit = 1;

        -- 2. Tính điểm bằng Set-based logic
        -- Công thức: Điểm = FLOOR((FinalPrice / 1000.0) * PointsPerUnit) * (1.0 + PointsModifier)
        SELECT 
            BookingID,
            CustomerID,
            FinalPrice,
            CAST(FLOOR((FinalPrice / 1000.0) * @PointsPerUnit) * (1.0 + PointsModifier) AS INT) AS EarnedPoints
        INTO #BookingPoints
        FROM #CompletedBookings;

        -- 3. Cập nhật Sổ cái điểm (Chỉ lưu nếu EarnedPoints > 0)
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
            c.UpdatedAt = GETDATE()
        FROM Customers c
        INNER JOIN #CustomerAgg a ON c.CustomerID = a.CustomerID;

        DROP TABLE #CompletedBookings;
        DROP TABLE #BookingPoints;
        DROP TABLE #CustomerAgg;
    END
END
GO
