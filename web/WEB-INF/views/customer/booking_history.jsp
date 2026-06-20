<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"/>
<meta charset="utf-8" />
<title>Auto Wash Pro - Lịch Sử Rửa Xe</title>

<!-- Global CSS & Tailwind Config -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css?v=4" />
<script src="${pageContext.request.contextPath}/assets/js/tailwind-config.js?v=4"></script>
<script src="https://cdn.tailwindcss.com"></script>

<!-- Icons (Lucide) -->
<script src="https://unpkg.com/lucide@latest"></script>

<script>
    function switchTab(tabId) {
        document.querySelectorAll('.tab-content').forEach(el => el.classList.add('hidden'));
        document.querySelectorAll('.tab-btn').forEach(el => {
            el.classList.remove('border-[#00d4ff]', 'text-white');
            el.classList.add('border-transparent', 'text-text-muted');
        });
        
        document.getElementById(tabId).classList.remove('hidden');
        document.getElementById('btn-' + tabId).classList.add('border-[#00d4ff]', 'text-white');
        document.getElementById('btn-' + tabId).classList.remove('border-transparent', 'text-text-muted');
    }
</script>
</head>
<body class="m-0 min-h-screen bg-bg-primary text-white font-sans antialiased selection:bg-[#00d4ff] selection:text-black w-full overflow-x-hidden">

    <!-- Desktop Sidebar -->
    <aside class="hidden md:flex flex-col w-64 glass-panel border-r border-border-glass fixed h-full z-10 left-0 top-0">
        <a href="${pageContext.request.contextPath}/account/dashboard" class="p-6 flex items-center gap-3 hover:opacity-80 transition-opacity">
            <i data-lucide="droplets" class="text-[#00d4ff] w-8 h-8"></i>
            <span class="text-xl font-display font-bold tracking-tight text-white">AUTOWASH<span class="text-[#00d4ff]">PRO</span></span>
        </a>
        
        <nav class="flex-1 px-4 py-4 space-y-2 mt-4">
            <a href="${pageContext.request.contextPath}/account/dashboard" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Tổng quan</span>
            </a>
            <a href="${pageContext.request.contextPath}/bookings" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="calendar-plus" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Đặt lịch dịch vụ</span>
            </a>
            <a href="${pageContext.request.contextPath}/customer/booking_history" class="flex items-center gap-3 px-4 py-3 bg-[#00d4ff]/10 text-[#00d4ff] rounded-xl border border-[#00d4ff]/20 transition-colors shadow-[0_0_10px_rgba(0,212,255,0.1)]">
                <i data-lucide="history" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Lịch Sử Rửa Xe</span>
            </a>
            <a href="${pageContext.request.contextPath}/customer/loyalty" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="award" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Loyalty Program</span>
            </a>
            <a href="${pageContext.request.contextPath}/account/profile" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="user" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Hồ sơ cá nhân</span>
            </a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 md:ml-64 relative min-h-screen bg-bg-primary">
        <!-- App Bar / Header -->
        <header class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center justify-between gap-3">
            <div class="flex items-center gap-3">
                <button onclick="history.back()" class="w-10 h-10 shrink-0 flex items-center justify-center hover:bg-bg-surface-hover rounded-full transition-colors text-white" aria-label="Quay lại">
                    <i data-lucide="arrow-left" class="w-5 h-5"></i>
                </button>
                <h1 class="text-lg md:text-2xl font-display font-bold truncate text-white">Lịch Sử Hoạt Động</h1>
            </div>
            
            <div class="hidden sm:flex flex-col items-end">
                <span class="text-xs text-text-muted">Tổng số lượt rửa</span>
                <span class="text-lg font-bold text-[#00d4ff]">12</span>
            </div>
        </header>

        <div class="px-4 md:px-8 py-8 max-w-4xl mx-auto space-y-6">
            
            <!-- Tabs -->
            <div class="flex border-b border-border-glass">
                <button id="btn-tab-upcoming" onclick="switchTab('tab-upcoming')" class="tab-btn px-6 py-4 font-display font-semibold text-white border-b-2 border-[#00d4ff] transition-colors flex items-center gap-2">
                    Lịch Sắp Tới
                    <!-- Badge for upcoming count -->
                    <span class="w-5 h-5 rounded-full bg-[#00d4ff] text-black text-xs flex items-center justify-center">2</span>
                </button>
                <button id="btn-tab-history" onclick="switchTab('tab-history')" class="tab-btn px-6 py-4 font-display font-semibold text-text-muted border-b-2 border-transparent hover:text-gray-300 transition-colors">
                    Đã Hoàn Thành
                </button>
            </div>

            <!-- Tab 1: Upcoming Bookings -->
            <div id="tab-upcoming" class="tab-content space-y-4">
                
                <!-- Mock Upcoming Card 1 -->
                <article class="glass-panel p-5 sm:p-6 rounded-2xl border-l-4 border-l-amber-500 shadow-lg hover:-translate-y-1 transition-transform relative overflow-hidden">
                    <div class="absolute -right-10 -top-10 w-32 h-32 bg-amber-500/10 rounded-full blur-2xl"></div>
                    <div class="flex flex-col sm:flex-row justify-between gap-4">
                        <div class="space-y-3">
                            <div class="flex items-center gap-2">
                                <span class="px-2.5 py-1 rounded bg-amber-500/20 text-amber-500 text-xs font-bold uppercase">Chờ Phục Vụ</span>
                                <span class="text-text-muted text-sm font-medium">Mã Đặt: #BK-8429</span>
                            </div>
                            
                            <h3 class="font-display font-bold text-xl text-white">Vệ Sinh Nội Thất Cao Cấp</h3>
                            
                            <div class="grid grid-cols-2 gap-x-8 gap-y-2 text-sm">
                                <div class="flex items-center gap-2 text-gray-300">
                                    <i data-lucide="calendar" class="w-4 h-4 text-text-muted"></i> 24/06/2026
                                </div>
                                <div class="flex items-center gap-2 text-gray-300">
                                    <i data-lucide="clock" class="w-4 h-4 text-text-muted"></i> 14:00 - 15:00
                                </div>
                                <div class="flex items-center gap-2 text-gray-300 col-span-2">
                                    <i data-lucide="car" class="w-4 h-4 text-text-muted"></i> Mazda 3 - <span class="font-semibold">30F-123.45</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="flex flex-col items-start sm:items-end justify-between border-t sm:border-t-0 sm:border-l border-border-glass pt-4 sm:pt-0 sm:pl-6 mt-2 sm:mt-0">
                            <div class="text-xl font-display font-bold text-[#00d4ff]">250.000<span class="text-sm font-sans font-normal text-text-muted">Ä'</span></div>
                            <div class="flex gap-2 mt-4">
                                <button class="px-4 py-2 rounded-lg bg-bg-surface hover:bg-red-500/20 text-red-400 border border-red-500/30 text-sm font-semibold transition-colors">
                                    Hủy Lịch
                                </button>
                                <button class="px-4 py-2 rounded-lg bg-bg-surface border border-border-glass hover:bg-bg-surface-hover text-white text-sm font-semibold transition-colors">
                                    Chi Tiết
                                </button>
                            </div>
                        </div>
                    </div>
                </article>

                <!-- Mock Upcoming Card 2 -->
                <article class="glass-panel p-5 sm:p-6 rounded-2xl border-l-4 border-l-accent-cyan shadow-lg hover:-translate-y-1 transition-transform relative overflow-hidden">
                    <div class="absolute -right-10 -top-10 w-32 h-32 bg-[#00d4ff]/10 rounded-full blur-2xl"></div>
                    <div class="flex flex-col sm:flex-row justify-between gap-4">
                        <div class="space-y-3">
                            <div class="flex items-center gap-2">
                                <span class="px-2.5 py-1 rounded bg-[#00d4ff]/20 text-[#00d4ff] text-xs font-bold uppercase animate-pulse">Đang Xử Lý</span>
                                <span class="text-text-muted text-sm font-medium">Mã Đặt: #BK-8435</span>
                            </div>
                            
                            <h3 class="font-display font-bold text-xl text-white">Rửa Bọt Tuyết Siêu Cấp</h3>
                            
                            <div class="grid grid-cols-2 gap-x-8 gap-y-2 text-sm">
                                <div class="flex items-center gap-2 text-gray-300">
                                    <i data-lucide="calendar" class="w-4 h-4 text-text-muted"></i> Hôm nay
                                </div>
                                <div class="flex items-center gap-2 text-gray-300">
                                    <i data-lucide="clock" class="w-4 h-4 text-text-muted"></i> 10:30 - 11:00
                                </div>
                                <div class="flex items-center gap-2 text-gray-300 col-span-2">
                                    <i data-lucide="car" class="w-4 h-4 text-text-muted"></i> Honda CR-V - <span class="font-semibold">51H-987.65</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="flex flex-col items-start sm:items-end justify-between border-t sm:border-t-0 sm:border-l border-border-glass pt-4 sm:pt-0 sm:pl-6 mt-2 sm:mt-0">
                            <div class="text-xl font-display font-bold text-[#00d4ff]">150.000<span class="text-sm font-sans font-normal text-text-muted">Ä'</span></div>
                            <div class="flex gap-2 mt-4">
                                <button class="px-6 py-2 rounded-lg bg-[#00d4ff] text-black font-semibold text-sm transition-colors hover:bg-white w-full sm:w-auto text-center">
                                    Xem Camera
                                </button>
                            </div>
                        </div>
                    </div>
                </article>

            </div>

            <!-- Tab 2: Past Wash History -->
            <div id="tab-history" class="tab-content hidden space-y-4">
                
                <!-- History Card 1 -->
                <article class="glass-panel p-5 rounded-2xl flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
                    <div class="flex items-start gap-4 w-full">
                        <div class="w-12 h-12 rounded-full bg-success/10 flex items-center justify-center shrink-0 border border-success/30">
                            <i data-lucide="check-circle" class="w-6 h-6 text-success"></i>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between">
                                <h3 class="font-display font-bold text-lg text-white">Phủ Ceramic CÆ¡ Bản</h3>
                                <span class="text-success text-sm font-bold">+150 điểm</span>
                            </div>
                            <div class="text-sm text-text-muted mt-1 flex flex-wrap gap-x-4 gap-y-1">
                                <span><i data-lucide="calendar" class="w-3.5 h-3.5 inline"></i> 15/06/2026</span>
                                <span><i data-lucide="car" class="w-3.5 h-3.5 inline"></i> 30F-123.45</span>
                            </div>
                        </div>
                    </div>
                    <div class="text-right w-full sm:w-auto border-t sm:border-none border-border-glass pt-3 sm:pt-0">
                        <div class="font-bold text-lg">350.000Ä'</div>
                        <button class="text-[#00d4ff] text-sm hover:underline mt-1">Đánh giá dịch vụ</button>
                    </div>
                </article>

                <!-- History Card 2 -->
                <article class="glass-panel p-5 rounded-2xl flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 opacity-70">
                    <div class="flex items-start gap-4 w-full">
                        <div class="w-12 h-12 rounded-full bg-red-500/10 flex items-center justify-center shrink-0 border border-red-500/30">
                            <i data-lucide="x-circle" class="w-6 h-6 text-red-500"></i>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between">
                                <h3 class="font-display font-bold text-lg text-white">Rửa Bọt Tuyết</h3>
                                <span class="text-red-400 text-sm font-semibold border border-red-500/50 px-2 py-0.5 rounded">Đã hủy</span>
                            </div>
                            <div class="text-sm text-text-muted mt-1 flex flex-wrap gap-x-4 gap-y-1">
                                <span><i data-lucide="calendar" class="w-3.5 h-3.5 inline"></i> 02/06/2026</span>
                                <span><i data-lucide="car" class="w-3.5 h-3.5 inline"></i> 51H-987.65</span>
                            </div>
                        </div>
                    </div>
                    <div class="text-right w-full sm:w-auto border-t sm:border-none border-border-glass pt-3 sm:pt-0">
                        <button class="px-4 py-2 rounded-lg bg-bg-surface hover:bg-bg-surface-hover text-white text-sm font-semibold transition-colors border border-border-glass">
                            Đặt lại
                        </button>
                    </div>
                </article>

                <div class="flex justify-center mt-6">
                    <button class="flex items-center gap-2 text-text-muted hover:text-white transition-colors">
                        <i data-lucide="loader" class="w-4 h-4 animate-spin hidden"></i> Tải thêm lịch sử
                    </button>
                </div>

            </div>

        </div>
    </main>

<script>
    lucide.createIcons();
</script>
</body>
</html>






