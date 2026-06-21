<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<!-- Google Fonts (Vietnamese Supported) & Font Fallback -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
  body, .font-sans { font-family: 'Inter', sans-serif !important; }
  .font-display { font-family: 'Be Vietnam Pro', sans-serif !important; }
</style>
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
        <div class="flex flex-col sm:flex-row items-center justify-center gap-4">
            <a href="javascript:history.back()" class="inline-flex items-center gap-2 bg-gray-800 text-white border border-gray-700 px-6 py-3 rounded-xl font-bold hover:bg-gray-700 transition-colors w-full sm:w-auto justify-center">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                Quay lại trang trước
            </a>
            <a href="${pageContext.request.contextPath}/account/dashboard" class="inline-flex items-center gap-2 bg-cyan-400 text-black px-6 py-3 rounded-xl font-bold hover:bg-cyan-300 transition-colors shadow-[0_0_15px_rgba(34,211,238,0.4)] w-full sm:w-auto justify-center">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                Về trang tổng quan
            </a>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>






