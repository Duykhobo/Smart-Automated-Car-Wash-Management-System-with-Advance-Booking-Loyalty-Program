<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Không tìm thấy trang</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #0b0f1a; color: white; }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen">
    <div class="text-center p-8">
        <h1 class="text-9xl font-bold text-cyan-400 mb-4">404</h1>
        <h2 class="text-3xl font-semibold mb-6">Trang không tồn tại</h2>
        <p class="text-gray-400 mb-8 max-w-md mx-auto">Xin lỗi, trang bạn đang tìm kiếm không tồn tại hoặc đã bị gỡ bỏ.</p>
        <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-2 bg-cyan-400 text-black px-6 py-3 rounded-xl font-bold hover:bg-cyan-300 transition-colors">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
            Về trang chủ
        </a>
    </div>
</body>
</html>
