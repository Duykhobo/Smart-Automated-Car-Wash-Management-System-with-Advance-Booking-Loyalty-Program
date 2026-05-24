<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login - AutoWashPro</title>
        <!-- Tạm thời dùng CSS inline đơn giản để test luồng chức năng, sau này sẽ áp dụng Global CSS của sếp -->
        <style>
            body { font-family: Arial, sans-serif; background-color: #121826; color: white; display: flex; justify-content: center; align-items: center; height: 100vh; }
            .login-box { background-color: #1F2937; padding: 30px; border-radius: 10px; width: 300px; text-align: center;}
            input { width: 90%; padding: 10px; margin: 10px 0; border-radius: 5px; border: none; background: #0f172a; color: white; }
            button { width: 100%; padding: 10px; background-color: #00D4FF; color: black; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
            .error { color: #EF4444; font-size: 0.9em; margin-bottom: 10px;}
            .success { color: #10B981; font-size: 0.9em; margin-bottom: 10px;}
        </style>
    </head>
    <body>
        <div class="login-box">
            <h2>Đăng Nhập</h2>
            
            <%-- Hiển thị thông báo thành công (từ trang Đăng Ký chuyển sang) --%>
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="success"><%= request.getAttribute("successMessage") %></div>
            <% } %>

            <%-- Hiển thị thông báo lỗi --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="error"><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <form action="login" method="POST">
                <input type="text" name="phone" placeholder="Số điện thoại" value="${phone != null ? phone : ''}" required />
                <input type="password" name="password" placeholder="Mật khẩu" required />
                <button type="submit">Đăng Nhập</button>
            </form>
            <p style="font-size: 13px; margin-top: 20px;">Chưa có tài khoản? <a href="register.jsp" style="color: #00D4FF;">Đăng ký ngay</a></p>
        </div>
    </body>
</html>
