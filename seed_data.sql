USE SmartCarWash;
GO

-- 1. Thêm một số Gói Dịch Vụ mẫu
INSERT INTO Services (Name, BasePrice, IsActive) VALUES
(N'Rửa Bọt Tuyết Tiêu Chuẩn', 100000.00, 1),
(N'Rửa Bọt Tuyết Gầm + Xịt Gầm', 150000.00, 1),
(N'Rửa Chăm Sóc Cấp Cao (Ceramic)', 350000.00, 1),
(N'Vệ Sinh Nội Thất Toàn Diện', 500000.00, 1),
(N'Đánh Bóng Ngoại Thất Dọn Nhẹ', 800000.00, 1);
GO

-- 2. Đảm bảo Khách hàng đang test (userID = 1 hoặc tùy ID) có ít nhất 1 xe
-- Chú ý: Bạn hãy đảm bảo User và Customer đã tồn tại trước khi chạy đoạn này, hoặc thay ID tương ứng.
-- Nếu bạn đang đăng nhập bằng user MinhTân, CustomerID có thể là 1 hoặc 2.
-- Dưới đây là dữ liệu giả định thêm vào xe cho CustomerID = 1 (Bạn có thể sửa ID nếu cần).
IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = 1)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Vehicles WHERE LicensePlate = '51H-123.45')
    BEGIN
        INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleType, Color, IsDefault, IsActive)
        VALUES (1, '51H-123.45', N'Toyota', N'Vios', N'Sedan', N'Trắng', 1, 1);
    END
    
    IF NOT EXISTS (SELECT 1 FROM Vehicles WHERE LicensePlate = '30A-987.65')
    BEGIN
        INSERT INTO Vehicles (CustomerID, LicensePlate, Brand, Model, VehicleType, Color, IsDefault, IsActive)
        VALUES (1, '30A-987.65', N'Mazda', N'CX-5', N'SUV', N'Đỏ', 0, 1);
    END
END
GO
