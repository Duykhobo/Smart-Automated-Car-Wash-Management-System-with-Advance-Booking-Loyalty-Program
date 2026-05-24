# Smart Automated Car Wash Management System (AutoWash Pro)

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white) ![JSP/Servlet](https://img.shields.io/badge/JSP%20%2F%20Servlet-007396?style=for-the-badge&logo=java&logoColor=white) ![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black) ![JUnit](https://img.shields.io/badge/JUnit5%20%2F%20Mockito-25A162?style=for-the-badge&logo=testing-library&logoColor=white)

Hệ thống quản lý dịch vụ rửa xe tự động tích hợp tính năng Đặt lịch trước (Advance Booking) và Chương trình khách hàng thân thiết (Loyalty Program). Dự án được thiết kế theo chuẩn kiến trúc MVC cấp doanh nghiệp, phục vụ cho đồ án môn học PRJ tại Đại học FPT (Học kỳ 4 - Summer 2026).

## 1. Tính Năng Nổi Bật

- **Xác thực & Bảo mật (Authentication & Security):** 
  - Quy trình đăng nhập và đăng ký được tối ưu hóa.
  - Bảo mật mật khẩu người dùng bằng thuật toán mã hóa SHA-256.
  - Quản lý phân quyền (Role-based Access Control) thông qua `Filter`, đảm bảo an ninh cho khu vực quản trị (Admin).
  
- **Kiến trúc Hệ thống (Architecture):**
  - Tuân thủ nghiêm ngặt mô hình MVC (Model - View - Controller).
  - Phân tách Business Logic vào `Service Layer` để tăng cường khả năng bảo trì và mở rộng mã nguồn.
  - Áp dụng mẫu thiết kế PRG (Post-Redirect-Get) trong định tuyến Servlet nhằm bảo mật URL và tránh trùng lặp dữ liệu.

- **Trải nghiệm Người dùng (UI/UX):**
  - Áp dụng ngôn ngữ thiết kế Dark Mode hiện đại.
  - Xây dựng bố cục Split-Screen đáp ứng (Responsive) tốt trên cả thiết bị di động và máy tính để bàn.

- **Chức năng Cốt lõi (Core Features):** 
  - Quản lý đặt lịch dịch vụ tự động hóa (Advance Booking).
  - Quản lý điểm thưởng, phân hạng thành viên và chính sách ưu đãi (Loyalty Program).

- **Kiểm thử & Tích hợp liên tục (Testing & CI/CD):**
  - Xây dựng hệ thống Unit Test và Integration Test sử dụng framework `JUnit` và `Mockito`.
  - Tích hợp luồng kiểm duyệt mã nguồn tự động qua `GitHub Actions`.

## 2. Công Nghệ Sử Dụng

- **Backend:** Java 8+, Servlet API, JSP (JavaServer Pages), JDBC.
- **Frontend:** HTML5, CSS3 (Vanilla), JavaScript.
- **Database:** Microsoft SQL Server.
- **Server:** Apache Tomcat 9.0.
- **Tooling:** NetBeans IDE, Visual Studio Code, Apache Ant.

## 3. Hướng Dẫn Cài Đặt

### Yêu cầu hệ thống
- Java Development Kit (JDK) 8 trở lên.
- Apache Tomcat 9.0+.
- Microsoft SQL Server.

### Thiết lập Cơ sở dữ liệu
1. Mở SQL Server Management Studio (SSMS).
2. Tạo cơ sở dữ liệu mới (Ví dụ: `AutoWashDB`).
3. Thực thi kịch bản SQL (`.sql`) được cung cấp trong thư mục dự án để khởi tạo cấu trúc bảng và dữ liệu mẫu.

### Thiết lập Dự án
1. Sao chép mã nguồn từ kho lưu trữ:
   ```bash
   git clone https://github.com/Duykhobo/Smart-Automated-Car-Wash-Management-System-with-Advance-Booking-Loyalty-Program.git
   ```
2. Mở thư mục dự án bằng NetBeans IDE.
3. Cấu hình thư viện phụ thuộc (Libraries):
   - Thêm JDBC Driver: `mssql-jdbc.jar`.
   - Cấu hình Servlet API: Thêm thư viện `Tomcat` tích hợp.
   - Cấu hình kiểm thử (Compile Tests): Thêm `mockito-core`, `byte-buddy`, `objenesis`, và `junit`.
4. Cập nhật thông tin kết nối CSDL (User, Password, Database Name, Port) tại lớp `DBContext.java` hoặc DAO tương ứng để phù hợp với môi trường cục bộ.

### Khởi chạy ứng dụng
1. Nhấp chuột phải vào dự án trong NetBeans, chọn **Clean and Build**.
2. Chọn **Run** để khởi động máy chủ Tomcat.
3. Truy cập ứng dụng qua đường dẫn mặc định: `http://localhost:8084/AutoWash/`

## 4. Đội Ngũ Phát Triển

- **Sinh viên thực hiện:** Thanh Duy, Thiên Quân, Minh Tân, Khánh Duy (Đại học FPT)
- **Học kỳ:** Semester 4 - Summer 2026
