# Smart Automated Car Wash Management System (AutoWash Pro)

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white) ![JSP/Servlet](https://img.shields.io/badge/JSP%20%2F%20Servlet-007396?style=for-the-badge&logo=java&logoColor=white) ![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black) ![HikariCP](https://img.shields.io/badge/HikariCP-Fastest%20Pool-2C2255?style=for-the-badge) ![Security](https://img.shields.io/badge/Security-OWASP%20Top%2010-green?style=for-the-badge)

Hệ thống quản lý dịch vụ rửa xe tự động cao cấp, tích hợp tính năng **Đặt lịch trước (Advance Booking)**, **Quét mã QR Check-in** và **Chương trình khách hàng thân thiết (Loyalty Program)**. Dự án được thiết kế theo chuẩn kiến trúc MVC cấp doanh nghiệp, phục vụ cho đồ án môn học PRJ tại Đại học FPT (Học kỳ 4 - Summer 2026).

## 1. Tính Năng Nổi Bật

### 🏎 Trải nghiệm Người dùng (UI/UX) Cao Cấp
- Xây dựng hệ thống UI theo phong cách **Glassmorphism** & **Dark Mode** hiện đại, sang trọng.
- Ứng dụng **Tailwind CSS** đem lại trải nghiệm **Responsive** hoàn hảo trên cả di động và Desktop.
- Hệ thống thông báo (Toast & Modal) và xử lý tương tác thời gian thực (Soft-Refresh) mượt mà không cần tải lại trang.

### 📅 Đặt Lịch & Quản Lý Dịch Vụ (Advance Booking & POS)
- **Luồng Đặt Lịch Thông Minh:** Tự động tính toán giá tiền dựa trên kích cỡ xe, linh hoạt áp dụng Voucher giảm giá.
- **QR Code Check-in:** Tự động tạo mã QR cho mỗi đơn hàng (Render tại Client-side giúp tối ưu băng thông). Tích hợp chức năng Scan QR tại quầy để Admin quét và nhận diện đơn hàng ngay lập tức.
- **Thanh toán tại quầy (Pay at Counter):** Luồng xử lý thanh toán linh hoạt và an toàn cho khách hàng.
- **Real-time POS Dashboard:** Bảng điều khiển dành cho nhân viên tự động cập nhật danh sách đơn hàng mới (Auto-Refetch) mỗi 5 giây mà không làm gián đoạn thao tác.

### 💎 Chương Trình Khách Hàng Thân Thiết (Loyalty Program)
- Tự động tích lũy điểm thưởng sau mỗi dịch vụ.
- Đổi điểm lấy các Voucher giảm giá (% hoặc trừ thẳng tiền).
- Hệ thống phân hạng thành viên (Silver, Gold, Platinum) với các đặc quyền riêng biệt.

### 🛡 Kiến Trúc & Bảo Mật Chuẩn Doanh Nghiệp (Enterprise Architecture)
- **Kiến trúc MVC Phân Tách Tuyệt Đối:** Mã nguồn JSP (View) hoàn toàn sạch sẽ, toàn bộ logic Javascript được bóc tách ra các file `.js` độc lập.
- **Tối ưu Hiệu năng:** Sử dụng **HikariCP Connection Pool** cho tốc độ truy xuất Database cực nhanh và chịu tải lớn.
- **Bảo mật OWASP Top 10:** 
  - Chống **SQL Injection** 100% bằng `PreparedStatement`.
  - Chống **XSS** với bộ mã hóa Unicode cho toàn bộ Script và JSTL `<c:out>`.
  - Bảo vệ Session bằng cơ chế tái tạo Session ID và cờ `HttpOnly`.
  - Mã hóa mật khẩu bảo mật chuẩn bằng **Salted SHA-256**.

## 2. Công Nghệ Sử Dụng

- **Backend:** Java 8+, Servlet API, JSP (JavaServer Pages), JSTL, JDBC.
- **Frontend:** HTML5, CSS3 (Tailwind CSS), JavaScript (Fetch API, Toastify, Lucide Icons, QRCode.js).
- **Database:** Microsoft SQL Server (Tích hợp Connection Pool HikariCP).
- **Server:** Apache Tomcat 9.0+.
- **IDE & Tooling:** NetBeans IDE / Visual Studio Code / Apache Ant.

## 3. Hướng Dẫn Cài Đặt Cho Đội Ngũ Phát Triển

### Yêu cầu hệ thống
- Java Development Kit (JDK) 8 trở lên.
- Apache Tomcat 9.0+.
- Microsoft SQL Server.

### Thiết lập Cơ sở dữ liệu
1. Mở SQL Server Management Studio (SSMS).
2. Tạo cơ sở dữ liệu mới (Ví dụ: `SmartCarWash`).
3. Thực thi kịch bản SQL (`database/init.sql` hoặc file tương đương) được cung cấp trong thư mục dự án để khởi tạo bảng và dữ liệu mẫu.

### Thiết lập Dự án & Kết nối
1. Sao chép mã nguồn từ kho lưu trữ:
   ```bash
   git clone https://github.com/Duykhobo/Smart-Automated-Car-Wash-Management-System-with-Advance-Booking-Loyalty-Program.git
   ```
2. Mở thư mục dự án bằng **NetBeans IDE**.
3. **Cấu hình Database riêng cho máy bạn:**
   - Tìm file `src/java/db.properties.example`, **copy** và **đổi tên** thành `db.properties`.
   - Mở file `db.properties` vừa tạo, thay đổi cấu hình truy cập (user, password) cho phù hợp với máy tính của bạn. *(File này đã được `.gitignore` nên rất an toàn).*
4. **Cấu hình thư viện phụ thuộc (Libraries):**
   - Đảm bảo dự án đã import `mssql-jdbc.jar` và `HikariCP` (Thường nằm sẵn trong thư mục `lib` hoặc `lib-test`).
   - Add Server `Apache Tomcat` vào Project.

### Khởi chạy ứng dụng
1. Trong NetBeans, nhấp chuột phải vào dự án, chọn **Clean and Build**.
2. Chọn **Run** để khởi động máy chủ Tomcat.
3. Truy cập ứng dụng qua đường dẫn: `http://localhost:8084/AutoWash/` *(Port có thể khác tùy máy)*.

### Tài khoản Demo 
- **Tài khoản Admin (Quản lý / POS):** 
  - **SĐT:** `0999999999`
  - **Mật khẩu:** `123`
- **Tài khoản Khách hàng:** Vui lòng đăng ký mới trực tiếp trên giao diện hệ thống.

## 4. Đội Ngũ Phát Triển

- **Sinh viên thực hiện:** Thanh Duy, Thiên Quân, Minh Tân, Khánh Duy (Đại học FPT)
- **Học kỳ:** Semester 4 - Summer 2026
