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
    <title>500 - Lỗi máy chủ</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #0b0f1a; color: white; }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen">
    <div class="text-center p-8">
        <h1 class="text-9xl font-bold text-red-500 mb-4">500</h1>
        <h2 class="text-3xl font-semibold mb-6">Lỗi hệ thống</h2>
        <p class="text-gray-400 mb-8 max-w-md mx-auto">Rất tiếc, đã có lỗi xảy ra trên hệ thống của chúng tôi. Vui lòng thử lại sau.</p>
        <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-2 bg-red-500 text-white px-6 py-3 rounded-xl font-bold hover:bg-red-400 transition-colors">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
            Về trang chủ
        </a>
    </div>
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>






