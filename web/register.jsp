<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng Ký - AutoWash Pro</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <!-- 1. Global CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
        <!-- 2. Page Specific CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/page-register.css">
    </head>
    <body>
        <div class="split-layout">
            <!-- Cột Trái (Brand/Giới thiệu - Chỉ hiện trên Desktop) -->
            <div class="split-left">
                <div class="brand-content">
                    <h1>AutoWash Pro</h1>
                    <p>Đăng ký thành viên để trải nghiệm hệ thống quản lý và đặt lịch rửa xe thông minh. Hưởng trọn ưu đãi từ chương trình Loyalty.</p>
                </div>
            </div>

            <!-- Cột Phải (Form Đăng Ký) -->
            <div class="split-right">
        <div class="mobile-container">
            <a href="index.jsp" class="back-link">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                AutoWash Pro
            </a>

            <h2 class="page-title">Đăng Ký Tài Khoản</h2>
            <p class="subtitle">Bắt đầu trải nghiệm dịch vụ đặt lịch chuẩn Pro</p>

            <!-- Div hiển thị kết quả AJAX (ẩn mặc định) -->
            <!-- Hiển thị thông báo lỗi từ Backend (Servlet) -->
            <% if (request.getAttribute("errorMessage") != null) {%>
            <div id="serverAlert" class="error-msg" style="display: block; color: red;">
                <%= request.getAttribute("errorMessage")%>
            </div>
            <% }%>
            <form action="register" method="post" id="registerForm" onsubmit="return handleRegister(event)" novalidate>
                <div class="form-group">
                    <label for="fullname">Họ và Tên</label>
                    <input type="text" id="fullname" name="fullname" class="form-input"
                           value="${user.fullName}" required>
                    <span class="inline-error" id="err-fullname"></span>
                </div>

                <div class="form-group">
                    <label for="phone">Số Điện Thoại</label>
                    <input type="tel" id="phone" name="phone" class="form-input"
                           value="${user.phone}" required>
                    <span class="inline-error" id="err-phone"></span>
                </div>

                <div class="form-group">
                    <label for="plate">Biển Số Xe</label>
                    <input type="text" id="plate" name="plate" class="form-input"
                           value="${user.licensePlate}" required oninput="this.value = this.value.toUpperCase()">
                    <span class="inline-error" id="err-plate"></span>
                </div>

                <div class="form-group">
                    <label for="password">Mật Khẩu</label>
                    <div class="password-wrapper">
                        <input type="password" id="password" name="password" class="form-input" required>
                        <span class="toggle-password" onclick="togglePassword('password', this)">
                            <svg xmlns="http://www.w3.org/2000/svg" class="eye-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                        </span>
                    </div>
                    <span class="inline-error" id="err-password"></span>
                </div>

                <div class="form-group">
                    <label for="confirm_password">Xác Nhận Mật Khẩu</label>
                    <div class="password-wrapper">
                        <input type="password" id="confirm_password" name="confirm_password" class="form-input" required>
                        <span class="toggle-password" onclick="togglePassword('confirm_password', this)">
                            <svg xmlns="http://www.w3.org/2000/svg" class="eye-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                        </span>
                    </div>
                    <span class="inline-error" id="err-confirm_password"></span>
                </div>

                <div class="form-group terms-group">
                    <label class="checkbox-container">
                        <input type="checkbox" id="terms" name="terms" required>
                        <span class="terms-text">Tôi đồng ý với <a href="#">Điều khoản dịch vụ</a> và <a href="#">Chính sách bảo mật</a></span>
                    </label>
                    <span class="inline-error" id="err-terms"></span>
                </div>

                <!-- Client side general error message placeholder -->
                <div id="clientError" class="error-msg" style="display: none;"></div>

                <button type="submit" class="btn-primary-glow">Đăng Ký Tài Khoản</button>
            </form>

            <div class="login-link">
                Bạn đã có tài khoản? <a href="login">Đăng nhập</a>
            </div>
        </div>
        </div> <!-- End split-right -->
        </div> <!-- End split-layout -->

        <script src="${pageContext.request.contextPath}/js/constants.js" charset="UTF-8"></script>
        <script src="${pageContext.request.contextPath}/js/page-register.js" charset="UTF-8"></script>
    </body>
</html>
