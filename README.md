# Smart Automated Car Wash Management System (AutoWash Pro)

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![JSP/Servlet](https://img.shields.io/badge/JSP%20%2F%20Servlet-007396?style=for-the-badge&logo=java&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black)
![JUnit](https://img.shields.io/badge/JUnit5%20%2F%20Mockito-25A162?style=for-the-badge&logo=testing-library&logoColor=white)

Hệ thống quản lý dịch vụ rửa xe thông minh tích hợp tính năng Đặt lịch trước (Advance Booking) và Chương trình khách hàng thân thiết (Loyalty Program). Dự án được thiết kế theo chuẩn kiến trúc MVC cấp doanh nghiệp dành cho môn học PRJ tại Đại học FPT (Học kỳ 4 - Summer 26).

## Tính năng nổi bật

- ** Xác thực & Bảo mật (Authentication & Security):** 
  - Đăng nhập/Đăng ký mượt mà.
  - Mật khẩu được mã hóa an toàn tuyệt đối với thuật toán SHA-256.
  - Phân quyền chặt chẽ bằng `Filter` (Bảo vệ trang Admin & chặn khách vãng lai).
- ** Kiến trúc MVC chuẩn mực:**
  - Tách biệt hoàn toàn Model (DAO) - View (JSP) - Controller (Servlet).
  - Tích hợp thêm **Service Layer** chuyên xử lý nghiệp vụ phức tạp (Business Logic).
  - Tối ưu URL theo chuẩn PRG (Post-Redirect-Get) để giấu đuôi `.jsp`.
- ** Giao diện hiện đại (Modern UI/UX):**
  - Giao diện Dark Mode chuyên nghiệp.
  - Bố cục Split-Screen (chia đôi màn hình) cực kỳ bắt mắt cho màn hình Desktop.
  - Hoàn toàn tương thích và co giãn mượt mà trên Mobile (Responsive).
- ** Tính năng cốt lõi (Core Features):** 
  - Hệ thống đặt lịch rửa xe tự động hóa (Advance Booking).
  - Tích điểm thành viên, hạng thẻ và ưu đãi (Loyalty Program).
- ** Tự động hóa kiểm thử (CI/CD & Testing):**
  - Phủ test toàn bộ các tầng logic với **JUnit** và **Mockito**.
  - Tích hợp **GitHub Actions** tự động chạy CI mỗi khi có commit mới.

## Công nghệ sử dụng

* **Backend:** Java 8+, Servlet API, JSP (JavaServer Pages), JDBC.
* **Frontend:** HTML5, Vanilla CSS3 (Custom Properties, Flexbox, Animations), JavaScript.
* **Database:** Microsoft SQL Server.
* **Server:** Apache Tomcat 9.0.
* **Tooling:** NetBeans IDE / VS Code, Apache Ant.

## Hướng dẫn cài đặt (Installation)

### 1. Chuẩn bị môi trường
- Cài đặt Java Development Kit (JDK 8 trở lên).
- Cài đặt Apache Tomcat 9.0+.
- Cài đặt MS SQL Server.

### 2. Cấu hình Cơ sở dữ liệu (Database)
1. Mở SQL Server Management Studio (SSMS).
2. Tạo Database mới (Ví dụ: `AutoWashDB`).
3. Mở thư mục dự án và chạy script SQL (file `.sql` có sẵn trong thư mục) để khởi tạo các bảng và dữ liệu mẫu.

### 3. Cấu hình Dự án
1. Clone dự án về máy: 
   ```bash
   git clone https://github.com/Duykhobo/Smart-Automated-Car-Wash-Management-System-with-Advance-Booking-Loyalty-Program.git
   ```
2. Mở dự án bằng NetBeans IDE.
3. Import thư viện (Add JAR/Folder):
   - Thêm bộ driver kết nối CSDL: `mssql-jdbc.jar`.
   - Cấu hình thư viện Tomcat (`servlet-api.jar`).
   - Cấu hình thư viện test (`mockito`, `junit`) trong mục **Compile Tests**.
4. Mở file `DBContext.java` hoặc lớp DAO tương ứng, cập nhật thông tin kết nối (User, Password, Database Name, Port) cho phù hợp với máy cá nhân.

### 4. Khởi chạy
- Chuột phải vào project trong NetBeans $\rightarrow$ Chọn **Clean and Build**.
- Chuột phải $\rightarrow$ Chọn **Run**. 
- Truy cập vào: `http://localhost:8084/AutoWash/` để trải nghiệm hệ thống.

## Tác giả

* **Sinh viên thực hiện:** Thanh Duy, Thiên Quân, Minh Tân, Khánh Duy (FPT University)
* **Khóa:** Semester 4 - Summer 2026
