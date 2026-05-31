# Smart Automated Car Wash Management System (AutoWash Pro)

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white) ![JSP/Servlet](https://img.shields.io/badge/JSP%20%2F%20Servlet-007396?style=for-the-badge&logo=java&logoColor=white) ![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black) ![HikariCP](https://img.shields.io/badge/HikariCP-Fastest%20Pool-2C2255?style=for-the-badge) ![Security](https://img.shields.io/badge/Security-OWASP%20Top%2010-green?style=for-the-badge)

Hệ thống quản lý dịch vụ rửa xe tự động tích hợp tính năng **Đặt lịch trước (Advance Booking)** và **Chương trình khách hàng thân thiết (Loyalty Program)**. Dự án được thiết kế theo chuẩn kiến trúc MVC cấp doanh nghiệp, phục vụ cho đồ án môn học PRJ tại Đại học FPT (Học kỳ 4 - Summer 2026).

## 1. Tính Năng Nổi Bật

- **Bảo mật chuẩn OWASP (Enterprise Security):** 
  - Chống lỗ hổng **SQL Injection** với 100% `PreparedStatement`.
  - Chống **XSS (Cross-Site Scripting)** trên toàn hệ thống bằng thẻ JSTL `<c:out>`.
  - Chống **RCE (Remote Code Execution)** thông qua cơ chế Whitelist khi người dùng Upload hình ảnh.
  - Chống **Session Hijacking** với cờ `HttpOnly` Cookie và **Session Fixation** bằng cơ chế cấp lại Session ID.
  - Bảo vệ dữ liệu bằng thuật toán mã hóa mật khẩu **Salted SHA-256**, tương thích ngược (Backward Compatibility) với dữ liệu cũ.
  - Quản lý phân quyền (Role-based Authorization) cực gắt thông qua `Filter`, chống truy cập trái phép vào khu vực Admin.

- **Kiến trúc Hệ thống (Architecture):**
  - Tuân thủ nghiêm ngặt mô hình **MVC** (Model - View - Controller).
  - Áp dụng **DAO Pattern** kết hợp **HikariCP Connection Pool** để tối ưu hóa hiệu năng truy xuất Database (Nhanh và chịu tải tốt hơn).
  - Phân tách Business Logic vào `Service Layer` để tăng cường khả năng bảo trì và mở rộng.
  - Quản lý cấu hình cơ sở dữ liệu an toàn qua file `db.properties` (Bảo vệ thông tin nhạy cảm).

- **Trải nghiệm Người dùng (UI/UX):**
  - Áp dụng ngôn ngữ thiết kế **Dark Mode** hiện đại, sang trọng (Glassmorphism).
  - Xây dựng bố cục **Responsive** bằng **Tailwind CSS**, đáp ứng mượt mà trên cả thiết bị di động và máy tính bàn.

- **Chức năng Cốt lõi (Core Features):** 
  - Quản lý hồ sơ phương tiện của khách hàng (Thêm/Sửa/Xóa/Mặc định).
  - Quản lý đặt lịch dịch vụ tự động hóa (Advance Booking). *(Đang phát triển)*
  - Quản lý điểm thưởng, phân hạng thành viên và chính sách ưu đãi (Loyalty Program).

## 2. Công Nghệ Sử Dụng

- **Backend:** Java 8+, Servlet API, JSP (JavaServer Pages), JSTL, JDBC.
- **Frontend:** HTML5, CSS3 (Tailwind CSS), JavaScript thuần.
- **Database:** Microsoft SQL Server (Tích hợp Connection Pool HikariCP).
- **Server:** Apache Tomcat 9.0+.
- **Tooling:** NetBeans IDE / Visual Studio Code / Apache Ant.

## 3. Hướng Dẫn Cài Đặt Cho Đội Ngũ Phát Triển

### Yêu cầu hệ thống
- Java Development Kit (JDK) 8 trở lên.
- Apache Tomcat 9.0+.
- Microsoft SQL Server.

### Thiết lập Cơ sở dữ liệu
1. Mở SQL Server Management Studio (SSMS).
2. Tạo cơ sở dữ liệu mới (Ví dụ: `SmartCarWash`).
3. Thực thi kịch bản SQL (`.sql`) được cung cấp trong thư mục dự án để khởi tạo cấu trúc bảng và dữ liệu mẫu.

### Thiết lập Dự án & Kết nối DB Bảo mật
1. Sao chép mã nguồn từ kho lưu trữ:
   ```bash
   git clone https://github.com/Duykhobo/Smart-Automated-Car-Wash-Management-System-with-Advance-Booking-Loyalty-Program.git
   ```
2. Mở thư mục dự án bằng **NetBeans IDE**.
3. **Cấu hình Database riêng cho máy bạn:**
   - Trong NetBeans, mở thư mục `src/java` hoặc `Source Packages/`.
   - Tìm file `db.properties.example`, **copy** và **đổi tên** bản copy thành `db.properties`.
   - Mở file `db.properties` vừa tạo, thay đổi `db.password` (và các thông tin khác nếu cần) cho đúng với máy tính của bạn.
   *(Lưu ý: File `db.properties` này đã được `.gitignore` ẩn đi, nên bạn thoải mái nhập mật khẩu mà không sợ bị lộ lên Github)*.
4. **Cấu hình thư viện phụ thuộc (Libraries):**
   - Đảm bảo dự án đã có file `mssql-jdbc.jar` và thư viện `HikariCP` (Thường nằm sẵn trong thư mục `lib`).
   - Add Server `Apache Tomcat` vào Project Properties.

### Khởi chạy ứng dụng
1. Nhấp chuột phải vào dự án trong NetBeans, chọn **Clean and Build**.
2. Chọn **Run** để khởi động máy chủ Tomcat.
3. Truy cập ứng dụng qua đường dẫn: `http://localhost:8084/AutoWash/`

## 4. Đội Ngũ Phát Triển

- **Sinh viên thực hiện:** Thanh Duy, Thiên Quân, Minh Tân, Khánh Duy (Đại học FPT)
- **Học kỳ:** Semester 4 - Summer 2026
