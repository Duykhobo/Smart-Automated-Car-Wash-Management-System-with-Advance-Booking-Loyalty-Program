<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đã có lỗi xảy ra</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #0b0f1a; color: white; }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen p-4">
    <div class="bg-gray-800 rounded-2xl p-8 max-w-2xl w-full text-center border border-gray-700 shadow-xl">
        <div class="w-16 h-16 bg-red-500/20 text-red-500 rounded-full flex items-center justify-center mx-auto mb-6">
            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path></svg>
        </div>
        <h2 class="text-3xl font-bold mb-4">Đã có lỗi ngoại lệ xảy ra</h2>
        <p class="text-gray-400 mb-6">Hệ thống gặp sự cố trong quá trình xử lý yêu cầu của bạn.</p>
        
        <% if (exception != null) { %>
            <div class="bg-black/50 p-4 rounded-xl text-left overflow-auto max-h-48 mb-8 border border-gray-700">
                <p class="text-red-400 font-mono text-sm break-words"><%= exception.getMessage() %></p>
            </div>
        <% } %>

        <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-2 bg-gray-700 text-white px-6 py-3 rounded-xl font-bold hover:bg-gray-600 transition-colors">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
            Về trang chủ
        </a>
    </div>
</body>
</html>
