<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AutoWash Pro - Welcome</title>
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
    </head>
    
    <body class="login-page">
        
        <div class="login-container">
            <div class="glass-card">
                <div class="login-header">
                    <h2>Đăng Nhập Hệ Thống</h2>
                </div>
                
                <form action="#" method="POST">
                    <input type="text" class="form-control" placeholder="Số điện thoại" required>
                    <input type="password" class="form-control" placeholder="Mật khẩu" required>
                    
                    <button type="submit" class="btn-primary" style="margin-top: 20px;">Đăng Nhập</button>
                </form>
                
                <div class="login-footer">
                    <p>Chưa có tài khoản? <a href="#">Đăng ký ngay</a></p>
                </div>
            </div>
        </div>
        
    </body>
</html>