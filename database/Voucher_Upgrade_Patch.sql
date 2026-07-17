-- 1. Thêm cột DiscountPercent vào bảng RewardCatalog nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'DiscountPercent' AND Object_ID = Object_ID(N'RewardCatalog'))
BEGIN
    ALTER TABLE RewardCatalog ADD DiscountPercent DECIMAL(5,2) DEFAULT 0.00;
END
GO

-- 2. Thêm cột DiscountPercent vào bảng Vouchers nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.columns WHERE Name = N'DiscountPercent' AND Object_ID = Object_ID(N'Vouchers'))
BEGIN
    ALTER TABLE Vouchers ADD DiscountPercent DECIMAL(5,2) DEFAULT 0.00;
END
GO

-- 3. Cập nhật Stored Procedure sp_RedeemVoucherFIFO
IF OBJECT_ID('dbo.sp_RedeemVoucherFIFO') IS NOT NULL 
    DROP PROCEDURE dbo.sp_RedeemVoucherFIFO;
GO

CREATE PROCEDURE dbo.sp_RedeemVoucherFIFO
    @CustomerID INT, @RewardType VARCHAR(30), @PointsCost INT, @DiscountPercent DECIMAL(5,2)
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
        INSERT INTO Vouchers (CustomerID, VoucherCode, RewardType, PointsCost, ExpiryDate, Status, DiscountPercent)
        VALUES (@CustomerID, UPPER(@VoucherCode), @RewardType, @PointsCost, DATEADD(day, 30, GETDATE()), 'Unused', @DiscountPercent);
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
