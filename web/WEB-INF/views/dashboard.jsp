<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta charset="utf-8" />
<title>Auto Wash Pro - Dashboard</title>
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
<body class="bg-bg-primary text-white font-sans antialiased selection:bg-btn-primary selection:text-black">

<div class="flex h-screen overflow-hidden bg-bg-primary">

    <!-- Desktop Sidebar (Tự động hiển thị trên máy tính, ẩn trên mobile) -->
    <aside class="hidden md:flex flex-col w-64 border-r border-gray-800 bg-[#121826]">
        <a href="${pageContext.request.contextPath}/home" class="p-6 flex items-center gap-3 hover:opacity-80 transition-opacity">
            <div class="w-10 h-10 bg-btn-primary rounded-xl flex items-center justify-center text-black font-bold text-xl">A</div>
            <span class="font-bold text-xl tracking-wider text-btn-primary">AUTOWASH</span>
        </a>
        
        <nav class="flex-1 px-4 py-4 space-y-2">
            <a href="${pageContext.request.contextPath}/account/dashboard" class="flex items-center gap-3 px-4 py-3 bg-btn-primary/10 text-btn-primary rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                <span class="font-medium">Trang chủ</span>
            </a>
            <a href="${pageContext.request.contextPath}/bookings" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                <span class="font-medium">Đặt lịch</span>
            </a>
            <a href="#" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7"></path></svg>
                <span class="font-medium">Ưu đãi</span>
            </a>
            <a href="${pageContext.request.contextPath}/account/profile" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                <span class="font-medium">Hồ sơ cá nhân</span>
            </a>
        </nav>
    </aside>

    <!-- Main Content Area -->
    <main class="flex-1 overflow-y-auto pb-24 md:pb-8">
        <div class="max-w-4xl mx-auto p-6 md:p-8 space-y-8">
            
            <!-- Header -->
            <header class="flex flex-col gap-1 mt-4 md:mt-0">
                <p class="text-gray-400 text-sm md:text-base font-normal">Chào buổi sáng,</p>
                <h1 class="text-white text-2xl md:text-3xl font-bold">${sessionScope.USER.fullName}</h1>
            </header>

            <!-- Membership Card -->
            <section aria-labelledby="membership-card-title" class="relative w-full max-w-md rounded-2xl overflow-hidden bg-gradient-to-br from-gray-800 to-gray-900 border border-gray-700 shadow-xl p-6">
                <div class="absolute inset-0 opacity-10 bg-[radial-gradient(ellipse_at_center,_var(--tw-gradient-stops))] from-amber-400 via-transparent to-transparent"></div>
                
                <div class="relative z-10 flex flex-col gap-6">
                    <div class="flex justify-between items-start">
                        <h2 id="membership-card-title" class="text-gray-300 text-sm font-medium tracking-wide">Auto Wash Pro</h2>
                        <div class="text-right">
                            <span class="text-white text-sm font-normal">Hạng </span>
                            <span class="text-amber-400 font-bold text-lg drop-shadow-[0_0_8px_rgba(251,191,36,0.5)]">VÀNG</span>
                        </div>
                    </div>
                    
                    <div class="flex flex-col mt-2">
                        <p class="text-gray-400 text-sm">Điểm tích lũy hiện tại</p>
                        <p class="text-white text-4xl font-bold tracking-tight">2,450 <span class="text-lg font-normal text-amber-400">pts</span></p>
                    </div>

                    <div class="mt-4 flex flex-col gap-3">
                        <div class="w-full bg-gray-700 h-2 rounded-full overflow-hidden" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="58">
                            <div class="bg-amber-400 h-full rounded-full shadow-[0_0_10px_rgba(251,191,36,0.8)]" style="width: 58%"></div>
                        </div>
                        <p class="text-gray-400 text-xs md:text-sm text-center">Còn 1,550 điểm nữa để lên hạng <span class="text-[#00d4ff] font-semibold">Bạch Kim</span></p>
                    </div>
                </div>
            </section>

            <!-- Upcoming Appointments -->
            <section aria-labelledby="upcoming-appointments-title" class="flex flex-col gap-4 max-w-2xl">
                <div class="flex justify-between items-center">
                    <h2 id="upcoming-appointments-title" class="text-white font-semibold text-lg md:text-xl">Lịch hẹn sắp tới</h2>
                    <a href="#" class="text-btn-primary text-sm font-semibold hover:underline">Xem tất cả</a>
                </div>
                
                <div class="flex flex-col gap-4">
                    <!-- Appointment Card 1 -->
                    <article class="flex items-center justify-between p-4 bg-gray-800 rounded-xl border border-gray-700 hover:border-gray-600 transition-colors">
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 bg-btn-primary/10 rounded-xl flex items-center justify-center shrink-0">
                                <svg class="w-6 h-6 text-btn-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                            </div>
                            <div class="flex flex-col">
                                <h3 class="text-white font-semibold text-base">Gói Rửa Tiêu Chuẩn</h3>
                                <p class="text-gray-400 text-sm">10:00 AM, Ngày 24/05</p>
                            </div>
                        </div>
                        <div class="px-3 py-1 bg-amber-500/10 border border-amber-500/20 rounded-full shrink-0">
                            <span class="text-amber-500 text-xs md:text-sm font-medium">Đang chờ</span>
                        </div>
                    </article>

                    <!-- Appointment Card 2 -->
                    <article class="flex items-center justify-between p-4 bg-gray-800 rounded-xl border border-gray-700 hover:border-gray-600 transition-colors">
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 bg-btn-primary/10 rounded-xl flex items-center justify-center shrink-0">
                                <svg class="w-6 h-6 text-btn-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                            </div>
                            <div class="flex flex-col">
                                <h3 class="text-white font-semibold text-base">Gói Rửa Tiêu Chuẩn</h3>
                                <p class="text-gray-400 text-sm">10:00 AM, Ngày 24/05</p>
                            </div>
                        </div>
                        <div class="px-3 py-1 bg-green-500/10 border border-green-500/20 rounded-full shrink-0">
                            <span class="text-green-400 text-xs md:text-sm font-medium">Hoàn Thành</span>
                        </div>
                    </article>
                </div>
            </section>
        </div>
    </main>

    <!-- Mobile Bottom Navigation (Chỉ hiện trên điện thoại, ẩn trên máy tính) -->
    <nav class="md:hidden fixed bottom-0 left-0 w-full bg-gray-900 border-t border-gray-800 z-50 px-2 py-2" style="padding-bottom: env(safe-area-inset-bottom);" aria-label="Điều hướng chính Mobile">
        <div class="flex justify-around items-center h-14">
            <a href="${pageContext.request.contextPath}/account/dashboard" class="flex flex-col items-center gap-1 w-16 text-btn-primary">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"><path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"></path></svg>
                <span class="text-[10px] font-medium">Trang chủ</span>
            </a>
            <a href="${pageContext.request.contextPath}/bookings" class="flex flex-col items-center gap-1 w-16 text-gray-400 hover:text-white transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                <span class="text-[10px] font-medium">Đặt lịch</span>
            </a>
            <a href="#" class="flex flex-col items-center gap-1 w-16 text-gray-400 hover:text-white transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7"></path></svg>
                <span class="text-[10px] font-medium">Ưu đãi</span>
            </a>
            <a href="${pageContext.request.contextPath}/account/profile" class="flex flex-col items-center gap-1 w-16 text-gray-400 hover:text-white transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                <span class="text-[10px] font-medium">Hồ sơ</span>
            </a>
        </div>
    </nav>

</div>
</body>
</html>
