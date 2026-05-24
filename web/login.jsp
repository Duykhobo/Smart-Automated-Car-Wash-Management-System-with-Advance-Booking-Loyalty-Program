<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - AutoWash Pro</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="split-layout">
        <!-- Cột Trái (Brand/Giới thiệu - Chỉ hiện trên Desktop) -->
        <div class="split-left">
            <div class="brand-content">
                <h1>AutoWash Pro</h1>
                <p>Trải nghiệm hệ thống quản lý và đặt lịch rửa xe thông minh số 1 hiện nay. Tiết kiệm thời gian, nâng tầm dịch vụ.</p>
            </div>
        </div>

        <!-- Cột Phải (Form Đăng Nhập) -->
        <div class="split-right">
            <div class="login-container">
                <!-- Back Link -->
                <a href="index" class="back-link">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    AutoWash Pro
                </a>

                <!-- Header -->
                <h2>Đăng Nhập Hệ Thống</h2>
                <p class="subtitle">Chào mừng bạn quay trở lại</p>

                <!-- Messages -->
                <% if (request.getAttribute("successMessage") != null) { %>
                    <div class="success"><%= request.getAttribute("successMessage") %></div>
                <% } %>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="error"><%= request.getAttribute("errorMessage") %></div>
                <% } %>

                <!-- Form -->
                <form action="login" method="POST">
                    <div class="form-group">
                        <div class="form-label">Số Điện Thoại</div>
                        <input type="text" name="phone" class="form-control" placeholder="Nhập số điện thoại..." value="${phone != null ? phone : ''}" required autocomplete="off" />
                    </div>

                    <div class="form-group">
                        <div class="form-label">
                            <span>Mật Khẩu</span>
                            <a href="#" class="forgot-pass">Quên mật khẩu?</a>
                        </div>
                        <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu..." required />
                    </div>

                    <button type="submit" class="btn-submit">Đăng Nhập</button>
                </form>

                <!-- Footer -->
                <div class="divider"></div>
                <div class="footer-text">
                    Bạn chưa có tài khoản? <a href="register">Đăng ký ngay</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
