<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta charset="utf-8" />
<title>Auto Wash Pro - Đăng Nhập</title>
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<!-- Tailwind CDN -->
<script src="https://cdn.tailwindcss.com"></script>
<script>
/** @type {import('tailwindcss').Config} */
tailwind.config = {
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'sans-serif']
      },
      colors: {
        "bg-primary": "#0b0f1a",
        "btn-primary": "#00d4ff",
        "colors-accents-green": "#10b981",
        "error": "#ef4444"
      }
    }
  },
  plugins: []
}
</script>
</head>
<body class="bg-bg-primary text-white font-sans antialiased selection:bg-btn-primary selection:text-black min-h-screen flex">

    <!-- Desktop Left Column (Brand) -->
    <div class="hidden lg:flex flex-col justify-center w-1/2 p-12 lg:p-24 bg-[radial-gradient(ellipse_at_top_left,_var(--tw-gradient-stops))] from-gray-800 via-[#0b0f1a] to-[#0b0f1a] border-r border-gray-800 relative overflow-hidden">
        <div class="absolute inset-0 bg-btn-primary/5 blur-[100px] rounded-full mix-blend-screen pointer-events-none"></div>
        <div class="relative z-10">
            <h1 class="text-5xl font-bold mb-6 tracking-tight"><span class="text-btn-primary">AutoWash</span> Pro</h1>
            <p class="text-gray-400 text-lg leading-relaxed max-w-lg">
                Trải nghiệm hệ thống quản lý và đặt lịch rửa xe thông minh số 1 hiện nay. Tiết kiệm thời gian, nâng tầm dịch vụ.
            </p>
            
            <div class="mt-12 flex items-center gap-4 text-gray-500">
                <svg class="w-8 h-8 text-btn-primary/50" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                <span class="font-medium text-gray-400">Nhanh chóng & Tiện lợi</span>
            </div>
            <div class="mt-4 flex items-center gap-4 text-gray-500">
                <svg class="w-8 h-8 text-btn-primary/50" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                <span class="font-medium text-gray-400">Ưu đãi khách hàng VIP</span>
            </div>
        </div>
    </div>

    <!-- Right Column (Form) -->
    <div class="w-full lg:w-1/2 flex flex-col justify-center px-6 sm:px-12 md:px-24 py-12 relative">
        <a href="${pageContext.request.contextPath}/home" class="absolute top-8 left-6 sm:left-12 flex items-center gap-2 text-gray-400 hover:text-white transition-colors font-medium text-sm group">
            <svg class="w-5 h-5 group-hover:-translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
            <span class="hidden sm:inline">Quay lại trang chủ</span>
        </a>

        <div class="max-w-md w-full mx-auto mt-12 sm:mt-0">
            <h2 class="text-3xl font-bold text-white mb-2">Đăng Nhập</h2>
            <p class="text-gray-400 text-sm mb-8">Chào mừng bạn quay trở lại hệ thống</p>

            <!-- Alerts -->
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="bg-green-500/10 border border-green-500/20 text-green-400 px-4 py-3 rounded-xl mb-6 text-sm flex items-center gap-2">
                    <svg class="w-5 h-5 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <%= request.getAttribute("successMessage") %>
                </div>
            <% } %>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="bg-red-500/10 border border-red-500/20 text-red-400 px-4 py-3 rounded-xl mb-6 text-sm flex items-center gap-2">
                    <svg class="w-5 h-5 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/auth/login" method="POST" novalidate class="space-y-5">
                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium">Số Điện Thoại</label>
                    <input type="text" name="phone" placeholder="Nhập số điện thoại..." value="${phone != null ? phone : ''}" required autocomplete="off" 
                           class="w-full bg-gray-800/50 border border-gray-700 text-white rounded-xl px-4 py-3.5 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all placeholder:text-gray-600">
                </div>

                <div class="space-y-1.5">
                    <div class="flex items-center justify-between">
                        <label class="text-gray-300 text-sm font-medium">Mật Khẩu</label>
                        <a href="#" class="text-btn-primary text-xs font-semibold hover:underline">Quên mật khẩu?</a>
                    </div>
                    <input type="password" name="password" placeholder="Nhập mật khẩu..." required 
                           class="w-full bg-gray-800/50 border border-gray-700 text-white rounded-xl px-4 py-3.5 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all placeholder:text-gray-600">
                </div>

                <button type="submit" class="w-full bg-btn-primary hover:bg-cyan-400 text-black font-bold text-base py-4 rounded-xl shadow-[0_4px_16px_rgba(0,212,255,0.3)] hover:shadow-[0_4px_24px_rgba(0,212,255,0.5)] transition-all hover:scale-[1.02] active:scale-[0.98]">
                    Đăng Nhập
                </button>
            </form>

            <div class="mt-8 pt-8 border-t border-gray-800 text-center">
                <p class="text-gray-400 text-sm">
                    Bạn chưa có tài khoản? 
                    <a href="${pageContext.request.contextPath}/auth/register" class="text-btn-primary font-bold hover:underline ml-1">Đăng ký ngay</a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>
