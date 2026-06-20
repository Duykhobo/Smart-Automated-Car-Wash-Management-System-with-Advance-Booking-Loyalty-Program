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
<title>Auto Wash Pro - Đặt Lịch Dịch Vụ</title>

<!-- Global CSS & Tailwind Config -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css?v=4" />
<script src="${pageContext.request.contextPath}/assets/js/tailwind-config.js?v=4"></script>
<script src="https://cdn.tailwindcss.com"></script>

<!-- Icons (Lucide) -->
<script src="https://unpkg.com/lucide@latest"></script>

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
            <a href="${pageContext.request.contextPath}/bookings" class="flex items-center gap-3 px-4 py-3 bg-[#00d4ff]/10 text-[#00d4ff] rounded-xl border border-[#00d4ff]/20 transition-colors shadow-[0_0_10px_rgba(0,212,255,0.1)]">
                <i data-lucide="calendar-plus" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Đặt lịch dịch vụ</span>
            </a>
            <a href="${pageContext.request.contextPath}/customer/booking_history" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="history" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Lịch sử rửa xe</span>
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
    <main class="flex-1 md:ml-64 relative min-h-screen pb-[120px] md:pb-32 bg-bg-primary">
        <!-- App Bar / Header -->
        <header class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center justify-between gap-3">
            <div class="flex items-center gap-3">
                <button onclick="history.back()" class="w-10 h-10 shrink-0 flex items-center justify-center hover:bg-bg-surface-hover rounded-full transition-colors text-white" aria-label="Quay lại">
                    <i data-lucide="arrow-left" class="w-5 h-5"></i>
                </button>
                <h1 class="text-lg md:text-2xl font-display font-bold truncate text-white">Đặt Lịch Rửa Xe</h1>
            </div>
            
            <!-- User Tier Badge (Mockup - to be replaced by dynamic JSTL) -->
            <div class="hidden sm:flex items-center gap-2 px-3 py-1.5 rounded-full badge-gold">
                <i data-lucide="star" class="w-4 h-4"></i>
                <span class="text-xs font-bold tracking-wide">GOLD TIER</span>
            </div>
        </header>

        <div class="px-4 md:px-8 py-8 max-w-3xl mx-auto space-y-8">
            
            <!-- Tier Perks Banner -->
            <div class="glass-panel p-4 rounded-2xl flex items-start sm:items-center gap-4 border-l-4 border-amber-500 shadow-[0_0_20px_rgba(245,158,11,0.05)]">
                <div class="w-10 h-10 rounded-full bg-amber-500/20 flex items-center justify-center shrink-0">
                    <i data-lucide="info" class="w-5 h-5 text-amber-500"></i>
                </div>
                <div>
                    <h4 class="font-display font-bold text-amber-400 text-sm">Đặc Quyền Hạng Gold</h4>
                    <p class="text-text-muted text-xs sm:text-sm mt-1">Bạn có thể đặt lịch trước tối đa <strong class="text-white">12 ngày</strong> và truy cập các <span class="text-[#00d4ff] font-semibold">Slot Ưu Tiên</span>.</p>
                </div>
            </div>

            <form id="bookingForm" action="<c:url value='/BookingController'/>" method="POST" class="space-y-8">
            
            <!-- Select Car -->
            <section class="space-y-4">
                <h2 class="font-display font-bold text-xl text-white flex items-center gap-2">
                    <i data-lucide="car-front" class="w-5 h-5 text-[#00d4ff]"></i> 1. Chọn Xe Của Bạn
                </h2>
                <div class="glass-panel p-2 rounded-xl focus-within:border-[#00d4ff] focus-within:shadow-[0_0_15px_rgba(0,212,255,0.2)] transition-all">
                    <div class="flex items-center gap-4 px-4 py-2 w-full">
                        <select name="vehicleId" class="bg-transparent text-white font-bold text-lg border-none outline-none w-full cursor-pointer appearance-none">
                            <c:choose>
                                <c:when test="${not empty vehicles}">
                                    <c:forEach var="v" items="${vehicles}">
                                        <option value="${v.vehicleId}" class="bg-bg-primary text-white" ${v.isDefault ? 'selected' : ''}>
                                            ${v.licensePlate} <c:if test="${not empty v.brand}">- ${v.brand}</c:if>
                                        </option>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <option value="" disabled selected class="bg-bg-primary text-gray-400">Chưa có xe nào</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                        <i data-lucide="chevron-down" class="w-5 h-5 text-text-muted pointer-events-none"></i>
                    </div>
                </div>
            </section>

            <!-- Chọn Gói Dịch Vụ -->
            <section class="space-y-4">
                <h2 class="font-display font-bold text-xl text-white flex items-center gap-2">
                    <i data-lucide="sparkles" class="w-5 h-5 text-[#00d4ff]"></i> 2. Chọn Gói Dịch Vụ
                </h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <c:choose>
                        <c:when test="${not empty services}">
                            <c:forEach var="service" items="${services}" varStatus="status">
                                <label class="block relative cursor-pointer group">
                                    <input type="radio" name="service" value="${service.serviceId}" class="peer sr-only" ${status.first ? 'checked' : ''}>
                                    <div class="glass-panel p-5 min-h-[100px] rounded-2xl border-2 border-transparent peer-checked:border-[#00d4ff] peer-checked:bg-[#00d4ff]/5 transition-all flex flex-col justify-between gap-3 hover:-translate-y-1">
                                        <div class="flex items-start justify-between">
                                            <h3 class="font-display font-bold text-base md:text-lg text-gray-300 peer-checked:text-white leading-snug">${service.name}</h3>
                                            <div class="w-5 h-5 rounded-full border-2 border-gray-600 peer-checked:border-[#00d4ff] flex items-center justify-center shrink-0">
                                                <div class="w-2.5 h-2.5 rounded-full bg-[#00d4ff] opacity-0 peer-checked:opacity-100 transition-opacity"></div>
                                            </div>
                                        </div>
                                        <div class="font-bold text-[#00d4ff] text-lg md:text-xl">
                                            <fmt:formatNumber value="${service.basePrice}" pattern="#,###"/> đ
                                        </div>
                                    </div>
                                </label>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-gray-400 italic">Không có dịch vụ nào đang hoạt động.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <!-- Chọn Ngày & Giờ -->
            <section class="space-y-4">
                <div class="flex items-center justify-between">
                    <h2 class="font-display font-bold text-xl text-white flex items-center gap-2">
                        <i data-lucide="calendar" class="w-5 h-5 text-[#00d4ff]"></i> 3. Chọn Ngày & Giờ
                    </h2>
                    <span class="text-xs text-text-muted bg-bg-surface px-2 py-1 rounded border border-border-glass">Tối đa 12 ngày (Gold)</span>
                </div>
                
                <!-- Date Horizontal Scroll -->
                <div class="flex gap-3 overflow-x-auto hide-scrollbar pb-2 snap-x">
                    <c:forEach var="date" items="${next7Days}" varStatus="status">
                        <!-- In a real app, next7Days list size depends on tier logic in the backend -->
                        <c:set var="dayOfWeek" value="${date.dayOfWeek.value}" />
                        <c:choose>
                            <c:when test="${dayOfWeek == 7}"><c:set var="dayName" value="CN" /></c:when>
                            <c:otherwise><c:set var="dayName" value="T${dayOfWeek + 1}" /></c:otherwise>
                        </c:choose>
                        <c:set var="isWeekend" value="${dayOfWeek == 6 || dayOfWeek == 7}" />
                        
                        <label class="cursor-pointer shrink-0 snap-start transition-transform group">
                            <input type="radio" name="date" value="${date}" class="peer sr-only" ${status.first ? 'checked' : ''}>
                            <div class="w-16 h-[80px] rounded-2xl glass-panel border-2 border-transparent peer-checked:bg-[#00d4ff] peer-checked:text-black peer-checked:shadow-[0_0_15px_rgba(0,212,255,0.4)] flex flex-col items-center justify-center gap-1.5 transition-all group-hover:-translate-y-1">
                                <span class="text-xs ${isWeekend ? 'text-red-400' : 'text-text-muted'} peer-checked:text-black/70 font-semibold uppercase">${dayName}</span>
                                <span class="text-xl font-bold ${isWeekend ? 'text-red-400' : 'text-white'} peer-checked:text-black">${date.dayOfMonth}</span>
                            </div>
                        </label>
                    </c:forEach>
                </div>

                <!-- Time Slots Grid -->
                <div class="grid grid-cols-3 sm:grid-cols-4 gap-3 mt-4">
                    <c:forEach var="time" items="${timeSlots}" varStatus="status">
                        <!-- Mocking a priority slot condition -->
                        <c:set var="isPriority" value="${status.index == 2 || status.index == 5}" />
                        
                        <label class="cursor-pointer transition-transform group relative">
                            <input type="radio" name="time" class="peer sr-only" value="${time}" ${status.first ? 'checked' : ''}>
                            <div class="h-12 rounded-xl glass-panel border border-border-glass peer-checked:bg-[#00d4ff]/20 peer-checked:border-[#00d4ff] peer-checked:text-[#00d4ff] flex items-center justify-center transition-all group-hover:border-[#00d4ff]/50 ${isPriority ? 'priority-slot' : ''}">
                                <span class="font-bold text-sm text-gray-300 peer-checked:text-[#00d4ff] flex items-center gap-1.5">
                                    <c:if test="${isPriority}"><i data-lucide="zap" class="w-3.5 h-3.5 text-amber-400"></i></c:if>
                                    ${time}
                                </span>
                            </div>
                        </label>
                    </c:forEach>
                </div>
                <div class="flex items-center gap-2 mt-2">
                    <i data-lucide="zap" class="w-4 h-4 text-amber-400"></i>
                    <span class="text-xs text-text-muted">Slot Ưu Tiên (Dành riêng cho hạng Silver trở lên)</span>
                </div>
            </section>

            <!-- Promo Code -->
            <section class="pt-6 border-t border-border-glass">
                <h2 class="font-display font-bold text-base text-white mb-3">Mã Khuyến Mãi / Voucher</h2>
                <div class="flex items-center justify-between p-2 pl-4 glass-panel rounded-xl focus-within:border-[#00d4ff] focus-within:shadow-[0_0_15px_rgba(0,212,255,0.2)] transition-all">
                    <input type="text" placeholder="Nhập mã voucher..." class="bg-transparent border-none outline-none text-sm w-full text-white placeholder:text-gray-500 min-w-0">
                    <button type="button" class="px-5 py-2.5 bg-bg-surface-hover hover:bg-white text-white hover:text-black rounded-lg font-bold text-sm transition-colors whitespace-nowrap shrink-0">Áp dụng</button>
                </div>
            </section>
            
            </form>
        </div>
    </main>

    <!-- Bottom Sticky Action Bar (Xác nhận) -->
    <div class="fixed bottom-0 left-0 md:left-64 right-0 glass-panel border-t border-border-glass z-50 bg-[#070b14]/90 backdrop-blur-xl">
        <div class="max-w-3xl mx-auto px-4 md:px-8 py-4 md:py-5 flex items-center justify-between gap-4" style="padding-bottom: calc(1rem + env(safe-area-inset-bottom));">
            <div class="flex flex-col gap-1">
                <span class="text-xs md:text-sm text-text-muted font-medium uppercase tracking-wider">Tổng Thanh Toán</span>
                <span class="text-xl md:text-2xl font-display font-bold text-[#00d4ff]">350.000 <span class="text-sm text-text-muted font-sans font-normal">đ</span></span>
            </div>
            <button type="submit" form="bookingForm" class="btn-glow bg-[#00d4ff] hover:bg-white text-black font-bold px-8 h-12 md:h-14 rounded-xl transition-all text-sm md:text-base flex items-center justify-center shadow-[0_0_20px_rgba(0,212,255,0.3)]">
                XÁC NHẬN ĐẶT LỊCH
            </button>
        </div>
    </div>

<script>
    lucide.createIcons();
</script>
</body>
</html>






