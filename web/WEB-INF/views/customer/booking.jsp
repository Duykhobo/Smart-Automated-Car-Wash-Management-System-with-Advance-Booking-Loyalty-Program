<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Auto Wash Pro - Đặt Lịch Dịch Vụ</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
    <style>
    /* Sửa lỗi Tailwind peer-checked không ăn cho thẻ con */
    input[type="radio"][name="services"]:checked + div h3 { color: #ffffff !important; }
    input[type="radio"][name="services"]:checked + div .radio-outer { border-color: #00d4ff !important; }
    input[type="radio"][name="services"]:checked + div .radio-inner { opacity: 1 !important; }
    
    input[type="checkbox"][name="services"]:checked + div h3 { color: #ffffff !important; }
    input[type="checkbox"][name="services"]:checked + div .checkbox-outer { border-color: #fbbf24 !important; background-color: #fbbf24 !important; }
    input[type="checkbox"][name="services"]:checked + div .checkbox-icon { opacity: 1 !important; }
    
    input[name="date"]:checked + div span:first-child { color: rgba(0, 0, 0, 0.7) !important; }
    input[name="date"]:checked + div span:last-child { color: black !important; }

    input[name="time"]:checked + div span { color: #00d4ff !important; }

    /* Custom thin scrollbar cho khung chọn ngày */
    .custom-scrollbar::-webkit-scrollbar {
        height: 6px;
    }
    .custom-scrollbar::-webkit-scrollbar-track {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 10px;
    }
    .custom-scrollbar::-webkit-scrollbar-thumb {
        background: rgba(0, 212, 255, 0.3);
        border-radius: 10px;
    }
    .custom-scrollbar::-webkit-scrollbar-thumb:hover {
        background: rgba(0, 212, 255, 0.6);
    }
    .custom-scrollbar {
        scrollbar-width: thin;
        scrollbar-color: rgba(0, 212, 255, 0.3) rgba(255, 255, 255, 0.05);
    }
</style>

</head>
<body class="m-0 min-h-screen bg-bg-primary text-white font-sans antialiased w-full overflow-x-hidden">

    <!-- Desktop Sidebar -->
    <jsp:include page="/WEB-INF/views/components/customer_sidebar.jsp">
    <jsp:param name="activeMenu" value="bookings" />
</jsp:include>

    <!-- Main Content -->
    <main class="flex-1 md:ml-64 relative min-h-screen pb-[140px] md:pb-32 bg-bg-primary">
        <!-- App Bar / Header -->
        <header class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center justify-between gap-3">
            <div class="flex items-center gap-3">
                <button onclick="history.back()" class="w-10 h-10 shrink-0 flex items-center justify-center hover:bg-bg-surface-hover rounded-full transition-colors text-white" aria-label="Quay lại">
                    <i data-lucide="arrow-left" class="w-5 h-5"></i>
                </button>
                <h1 class="text-lg md:text-2xl font-display font-bold truncate text-white max-w-[60%] sm:max-w-full">Đặt Lịch Rửa Xe</h1>
            </div>
            
            <!-- User Tier Badge -->
            <div class="hidden sm:flex items-center gap-2 px-3 py-1.5 rounded-full ${badgeClass}">
                <i data-lucide="star" class="w-4 h-4"></i>
                <span class="text-xs font-bold tracking-wide uppercase">${tierName} TIER</span>
            </div>
        </header>

        <div class="px-4 md:px-8 py-8 max-w-3xl mx-auto space-y-8 w-full overflow-hidden">
            
            <!-- Tier Perks Banner -->
            <div class="glass-panel p-4 rounded-2xl flex items-start sm:items-center gap-4 border-l-4 ${bannerBorder} shadow-lg">
                <div class="w-10 h-10 rounded-full ${bannerBg} flex items-center justify-center shrink-0">
                    <i data-lucide="info" class="w-5 h-5 ${bannerIcon}"></i>
                </div>
                <div>
                    <h4 class="font-display font-bold ${bannerText} text-sm">Đặc Quyền Hạng ${tierName}</h4>
                    <p class="text-text-muted text-xs sm:text-sm mt-1">Bạn có thể đặt lịch trước tối đa <strong class="text-white">${maxBookingDays} ngày</strong> và truy cập các <span class="text-[#00d4ff] font-semibold">Slot Ưu Tiên</span>.</p>
                </div>
            </div>

            <form id="bookingForm" action="${pageContext.request.contextPath}/checkout" method="POST" class="space-y-8" data-auto-validate="true">
            
            <!-- Select Car -->
            <section class="space-y-4">
                <h2 class="font-display font-bold text-xl text-white flex items-center gap-2">
                    <i data-lucide="car-front" class="w-5 h-5 text-[#00d4ff]"></i> 1. Chọn Xe Của Bạn
                </h2>
                
                <!-- Custom UI Select -->
                <div class="relative" id="vehicleSelectContainer">
                    <input type="hidden" name="vehicleId" id="vehicleIdInput" value="">
                    
                    <!-- Trigger -->
                    <div id="vehicleSelectTrigger" class="glass-panel p-2 rounded-xl border border-border-glass cursor-pointer hover:border-[#00d4ff]/50 transition-all flex items-center justify-between px-4 py-3 md:py-4">
                        <div class="flex items-center gap-3">
                            <i data-lucide="car" class="w-5 h-5 text-[#00d4ff]"></i>
                            <span id="vehicleSelectText" class="text-text-muted font-medium text-base md:text-lg">Đang tải danh sách xe...</span>
                        </div>
                        <i data-lucide="chevron-down" id="vehicleSelectIcon" class="w-5 h-5 text-text-muted transition-transform duration-300"></i>
                    </div>

                    <!-- Dropdown Options -->
                    <div id="vehicleSelectDropdown" class="absolute top-full left-0 w-full mt-2 glass-panel rounded-xl border border-border-glass overflow-hidden shadow-2xl opacity-0 invisible transition-all duration-300 transform -translate-y-2 z-50">
                        <div class="max-h-60 overflow-y-auto hide-scrollbar flex flex-col p-1.5 gap-1">
                            <c:choose>
                                <c:when test="${not empty vehicles}">
                                    <c:forEach var="v" items="${vehicles}">
                                        <div class="vehicle-option px-4 py-3 rounded-lg cursor-pointer hover:bg-white/10 transition-colors flex items-center justify-between group" data-value="${v.vehicleId}" data-size="${v.vehicleSize}" data-type="${v.vehicleTypeName}" data-text="${v.licensePlate} <c:if test="${not empty v.brand}">- ${v.brand}</c:if>" ${(not empty param.vehicleId and param.vehicleId eq v.vehicleId) or (empty param.vehicleId and v.isDefault) ? 'data-default="true"' : ''}>
                                            <span class="text-gray-300 group-hover:text-white font-medium transition-colors">${v.licensePlate} <c:if test="${not empty v.brand}"><span class="text-text-muted text-sm ml-1 font-normal">- ${v.brand}</span></c:if> <span class="text-xs ml-2 bg-[#00d4ff]/10 text-[#00d4ff] px-2 py-0.5 rounded border border-[#00d4ff]/20">${v.vehicleTypeName}</span></span>
                                            <i data-lucide="check" class="w-4 h-4 text-[#00d4ff] opacity-0 transition-opacity check-icon"></i>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="px-4 py-3 text-text-muted text-sm text-center">Chưa có xe nào. Vui lòng thêm xe ở trang Hồ Sơ.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Chọn Gói Dịch Vụ -->
            <section class="space-y-4">
                <h2 class="font-display font-bold text-xl text-white flex items-center gap-2">
                    <i data-lucide="sparkles" class="w-5 h-5 text-[#00d4ff]"></i> 2. Chọn Gói Dịch Vụ
                </h2>
                <h3 class="text-[#00d4ff] text-xs font-bold uppercase tracking-wider mb-3">Gói Chính (Chọn 1)</h3>
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
                    <c:choose>
                        <c:when test="${not empty services}">
                            <c:set var="mainHasChecked" value="false" />
                            <c:forEach var="service" items="${services}" varStatus="status">
                                <c:if test="${service.serviceType == 'Main' or empty service.serviceType}">
                                    <c:set var="searchPattern" value=",${service.serviceId}," />
                                    <c:set var="paramServicesStr" value=",${param.services}," />
                                    <c:set var="isChecked" value="${not empty param.services and paramServicesStr.contains(searchPattern)}" />
                                    <c:if test="${isChecked}"><c:set var="mainHasChecked" value="true" /></c:if>
                                    
                                    <label class="block relative cursor-pointer group">
                                        <input type="radio" name="services" value="${service.serviceId}" data-base-price="${initialPrices[service.serviceId]}" data-duration="${service.durationMinutes}" class="peer sr-only main-service" ${isChecked or (empty param.services and status.first) ? 'checked' : ''}>
                                        <div class="glass-panel p-4 md:p-5 rounded-2xl border border-border-glass cursor-pointer hover:border-[#00d4ff]/50 transition-all flex flex-col h-full group">
                                            <div class="flex items-center justify-between mb-3">
                                                <h3 class="font-bold text-gray-300 text-sm md:text-base">${service.name}</h3>
                                                <div class="radio-outer w-5 h-5 rounded-full border border-border-glass flex items-center justify-center shrink-0 transition-colors">
                                                    <div class="radio-inner w-2.5 h-2.5 rounded-full bg-[#00d4ff] opacity-0 transition-opacity"></div>
                                                </div>
                                            </div>
                                            <div class="mt-auto flex items-center justify-between">
                                                <div class="text-[#00d4ff] font-semibold text-lg service-price-display" data-sid="${service.serviceId}">
                                                    <fmt:formatNumber value="${initialPrices[service.serviceId]}" type="number" maxFractionDigits="0" /> đ
                                                </div>
                                                <div class="text-text-muted text-xs md:text-sm flex items-center gap-1.5 bg-black/20 px-2.5 py-1 rounded-full">
                                                    <i data-lucide="clock" class="w-3.5 h-3.5"></i> ${service.durationMinutes}p
                                                </div>
                                            </div>
                                            <c:if test="${not empty service.inactiveFromDate}">
                                                <div class="text-xs text-amber-500 bg-amber-500/10 p-2 rounded-lg mt-2 flex items-start gap-1.5 border border-amber-500/20">
                                                    <i data-lucide="alert-circle" class="w-3.5 h-3.5 shrink-0 mt-0.5"></i>
                                                    <span>Ngưng hoạt động từ <fmt:formatDate value="${service.inactiveFromDate}" pattern="dd/MM/yyyy HH:mm" /></span>
                                                </div>
                                            </c:if>
                                        </div>
                                    </label>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-gray-400 italic">Không có gói chính nào đang hoạt động.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <c:set var="hasAddon" value="false" />
                <c:forEach var="s" items="${services}">
                    <c:if test="${s.serviceType == 'Addon'}"><c:set var="hasAddon" value="true" /></c:if>
                </c:forEach>
                
                <c:if test="${hasAddon}">
                <h3 class="text-amber-400 text-xs font-bold uppercase tracking-wider mb-3">Dịch Vụ Thêm (Tùy chọn)</h3>
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <c:forEach var="service" items="${services}" varStatus="status">
                        <c:if test="${service.serviceType == 'Addon'}">
                            <c:set var="searchPattern" value=",${service.serviceId}," />
                            <c:set var="paramServicesStr" value=",${param.services}," />
                            <label class="block relative cursor-pointer group">
                                <input type="checkbox" name="services" value="${service.serviceId}" data-base-price="${initialPrices[service.serviceId]}" data-duration="${service.durationMinutes}" class="peer sr-only addon-service" ${(not empty param.services and paramServicesStr.contains(searchPattern)) ? 'checked' : ''}>
                                <div class="glass-panel p-4 md:p-5 rounded-2xl border border-border-glass cursor-pointer hover:border-amber-400/50 transition-all flex flex-col h-full group">
                                    <div class="flex items-center justify-between mb-3">
                                        <h3 class="font-bold text-gray-300 text-sm md:text-base">${service.name}</h3>
                                        <div class="checkbox-outer w-5 h-5 rounded border border-border-glass flex items-center justify-center shrink-0 transition-colors">
                                            <i data-lucide="check" class="checkbox-icon w-3.5 h-3.5 text-black opacity-0 transition-opacity"></i>
                                        </div>
                                    </div>
                                    <div class="mt-auto flex items-center justify-between">
                                        <div class="text-[#00d4ff] font-semibold text-lg service-price-display" data-sid="${service.serviceId}">
                                            <fmt:formatNumber value="${initialPrices[service.serviceId]}" type="number" maxFractionDigits="0" /> đ
                                        </div>
                                        <div class="text-text-muted text-xs md:text-sm flex items-center gap-1.5 bg-black/20 px-2.5 py-1 rounded-full">
                                            <i data-lucide="clock" class="w-3.5 h-3.5"></i> ${service.durationMinutes}p
                                        </div>
                                    </div>
                                    <c:if test="${not empty service.inactiveFromDate}">
                                        <div class="text-xs text-amber-500 bg-amber-500/10 p-2 rounded-lg mt-2 flex items-start gap-1.5 border border-amber-500/20">
                                            <i data-lucide="alert-circle" class="w-3.5 h-3.5 shrink-0 mt-0.5"></i>
                                            <span>Ngưng hoạt động từ <fmt:formatDate value="${service.inactiveFromDate}" pattern="dd/MM/yyyy HH:mm" /></span>
                                        </div>
                                    </c:if>
                                </div>
                            </label>
                        </c:if>
                    </c:forEach>
                </div>
                </c:if>
            </section>

            <!-- Chọn Ngày & Giờ -->
            <section class="space-y-4">
                <div class="flex items-center justify-between">
                    <h2 class="font-display font-bold text-xl text-white flex items-center gap-2">
                        <i data-lucide="calendar" class="w-5 h-5 text-[#00d4ff]"></i> 3. Chọn Ngày & Giờ
                    </h2>
                    <span class="text-xs text-text-muted bg-bg-surface px-2 py-1 rounded border border-border-glass">Tối đa ${maxBookingDays} ngày (${tierName})</span>
                </div>
                
                <!-- Date Horizontal Scroll -->
                <div class="flex gap-3 overflow-x-auto custom-scrollbar pb-3">
                    <c:forEach var="date" items="${dynamicDays}" varStatus="status">
                        <!-- In a real app, next7Days list size depends on tier logic in the backend -->
                        <c:set var="dayOfWeek" value="${date.dayOfWeek.value}" />
                        <c:choose>
                            <c:when test="${dayOfWeek == 7}"><c:set var="dayName" value="CN" /></c:when>
                            <c:otherwise><c:set var="dayName" value="T${dayOfWeek + 1}" /></c:otherwise>
                        </c:choose>
                        <c:set var="isWeekend" value="${dayOfWeek == 6 || dayOfWeek == 7}" />
                        
                        <label class="cursor-pointer shrink-0 transition-transform group select-none">
                            <input type="radio" name="date" value="${date}" onchange="fetchSlots(this.value)" class="peer sr-only" ${status.first ? 'checked' : ''}>
                            <div class="w-16 h-[80px] rounded-2xl glass-panel border-2 border-transparent peer-checked:bg-[#00d4ff] peer-checked:text-black peer-checked:shadow-[0_0_15px_rgba(0,212,255,0.4)] flex flex-col items-center justify-center gap-1.5 transition-all group-hover:-translate-y-1">
                                <span class="text-xs ${isWeekend ? 'text-red-400' : 'text-text-muted'} peer-checked:text-black/70 font-semibold uppercase">${dayName}</span>
                                <span class="text-xl font-bold ${isWeekend ? 'text-red-400' : 'text-white'} peer-checked:text-black">${date.dayOfMonth}</span>
                            </div>
                        </label>
                    </c:forEach>
                </div>

                <!-- Time Slots Grid (AJAX Rendered) -->
                <div id="timeSlotsContainer" class="grid grid-cols-2 min-[400px]:grid-cols-3 sm:grid-cols-4 gap-2 sm:gap-3 mt-4 w-full">
                    <!-- Javascript will populate this -->
                </div>
                <div class="flex flex-wrap items-center gap-4 mt-3 text-xs text-text-muted">
                    <div class="flex items-center gap-1.5"><div class="w-3 h-3 rounded bg-bg-primary border border-border-glass opacity-50"></div><span>Đã qua / Đã đầy</span></div>
                    <div class="flex items-center gap-1.5"><div class="w-3 h-3 rounded bg-[#00d4ff]/20 border border-[#00d4ff]"></div><span>Đang chọn</span></div>
                    <div class="flex items-center gap-1.5"><div class="w-3 h-3 rounded bg-amber-500/20 border border-amber-500"></div><span>Sắp hết chỗ</span></div>
                    <div class="flex items-center gap-1.5"><i data-lucide="zap" class="w-3.5 h-3.5 text-amber-400"></i><span>Slot ưu tiên</span></div>
                    <div class="flex items-center gap-1.5"><div class="w-3 h-3 rounded bg-violet-500/20 border border-violet-500"></div><span>Danh sách chờ</span></div>
                </div>
            </section>

            <!-- Promo Code -->
            <section class="pt-6 border-t border-border-glass">
                <h2 class="font-display font-bold text-base text-white mb-3">Mã Khuyến Mãi / Voucher</h2>
                <div class="flex items-center justify-between p-2 pl-4 glass-panel rounded-xl focus-within:border-[#00d4ff] focus-within:shadow-[0_0_15px_rgba(0,212,255,0.2)] transition-all">
                    <input type="text" name="voucherCode" id="voucherCode" placeholder="Nhập mã voucher..." class="bg-transparent border-none outline-none text-sm w-full text-white placeholder:text-gray-500 min-w-0 uppercase" oninput="this.value = this.value.toUpperCase()">
                    <button type="button" id="btnApplyVoucher" class="px-3 sm:px-5 py-2.5 bg-bg-surface-hover hover:bg-white text-white hover:text-black rounded-lg font-bold text-sm transition-colors whitespace-nowrap shrink-0">Áp dụng</button>
                </div>
            </section>
            
            </form>
        </div>
    </main>

    <!-- Bottom Sticky Action Bar (Xác nhận) -->
    <div class="fixed bottom-0 left-0 md:left-64 right-0 glass-panel border-t border-border-glass z-50 bg-[#070b14]/90 backdrop-blur-xl">
        <div class="max-w-3xl mx-auto px-4 md:px-8 py-4 md:py-5 flex items-center justify-between gap-2 md:gap-4" style="padding-bottom: calc(1.5rem + env(safe-area-inset-bottom));">
            <div class="flex flex-col gap-1">
                <span id="timeRangeDisplay" class="text-xs text-[#00d4ff] font-medium hidden">Thời gian: --:-- đến --:--</span>
                <span class="text-xs md:text-sm text-text-muted font-medium uppercase tracking-wider">Tổng Thanh Toán (Tại quầy)</span>
                <span id="totalPriceDisplay" class="text-xl md:text-2xl font-display font-bold text-[#00d4ff]">0 <span class="text-sm text-text-muted font-sans font-normal">đ</span></span>
            </div>
            <button type="submit" form="bookingForm" id="submitBookingBtn" class="btn-glow bg-[#00d4ff] hover:bg-white text-black font-bold px-4 sm:px-8 h-12 md:h-14 rounded-xl transition-all text-sm md:text-base flex items-center justify-center shadow-[0_0_20px_rgba(0,212,255,0.3)]">
                XÁC NHẬN ĐẶT LỊCH
            </button>
        </div>
    </div>

<script>
    var servicePricesData = ${empty servicePricesJson ? 'null' : servicePricesJson};
    lucide.createIcons();

    function fetchSlots(dateStr) {
        const container = document.getElementById('timeSlotsContainer');
        container.innerHTML = '<div class="col-span-2 min-[400px]:col-span-3 sm:col-span-4 text-center py-6"><i data-lucide="loader" class="w-6 h-6 animate-spin mx-auto text-[#00d4ff]"></i><p class="text-text-muted text-sm mt-2">Đang tìm slot trống...</p></div>';
        lucide.createIcons();

        // Calculate total duration
        let currentDuration = 30;
        const selectedServices = document.querySelectorAll('input[name="services"]:checked');
        if (selectedServices.length > 0) {
            currentDuration = 0;
            selectedServices.forEach(selected => {
                currentDuration += parseInt(selected.getAttribute('data-duration')) || 0;
            });
        }

        fetch(`${pageContext.request.contextPath}/api/slots?date=` + dateStr + '&duration=' + currentDuration)
            .then(res => res.json())
            .then(data => {
                container.innerHTML = '';
                const now = new Date();
                const todayStr = now.getFullYear() + "-" + String(now.getMonth() + 1).padStart(2, '0') + "-" + String(now.getDate()).padStart(2, '0');
                
                data.forEach((slot, index) => {
                    let isPast = slot.isPast;
                    let isFull = slot.currentBooked >= slot.maxCapacity;
                    let isFastFilling = slot.nearlyFull;
                    let isPriority = (slot.time === '09:00' || slot.time === '15:00');

                    let disabled = isPast;
                    
                    let bgClass, borderClass, textClass;
                    
                    if (disabled) {
                        bgClass = 'bg-bg-primary';
                        borderClass = 'border-border-glass';
                        textClass = 'text-gray-500';
                    } else if (isFull) {
                        bgClass = 'bg-violet-500/10 hover:border-violet-400/60 peer-checked:bg-violet-500/20';
                        borderClass = 'border-violet-500/30 peer-checked:border-violet-400';
                        textClass = 'text-violet-400 peer-checked:text-violet-300';
                    } else if (isFastFilling) {
                        bgClass = 'bg-amber-500/10 hover:border-amber-500/50 peer-checked:bg-amber-500/20';
                        borderClass = 'border-amber-500/30 peer-checked:border-amber-500';
                        textClass = 'text-amber-500 peer-checked:text-amber-400';
                    } else {
                        bgClass = 'hover:border-[#00d4ff]/50 peer-checked:bg-[#00d4ff]/20';
                        borderClass = 'border-border-glass peer-checked:border-[#00d4ff]';
                        textClass = 'text-gray-300 peer-checked:text-[#00d4ff]';
                    }

                    let html = `
                        <label class="transition-transform group relative select-none \${disabled ? 'opacity-40 cursor-not-allowed' : 'cursor-pointer'}" data-is-full="\${isFull}">
                            <input type="radio" name="time" class="peer sr-only" value="\${slot.time}" \${disabled ? 'disabled' : ''} data-waitlist="\${isFull}">
                            <div class="h-12 rounded-xl glass-panel border \${borderClass} \${bgClass} flex items-center justify-center transition-all \${isPriority && !isFull ? 'priority-slot' : ''}">
                                <span class="font-bold text-sm \${textClass} flex items-center gap-1.5">
                                    \${isPast ? '<i data-lucide="clock" class="w-3.5 h-3.5"></i>' : ''}
                                    \${isFull && !isPast ? '<i data-lucide="users" class="w-3.5 h-3.5"></i>' : ''}
                                    \${isPriority && !isFull ? '<i data-lucide="zap" class="w-3.5 h-3.5 text-amber-400"></i>' : ''}
                                    <span class="\${isPast ? 'line-through' : ''}">\${slot.time}</span>
                                </span>
                            </div>
                            \${isFull && !isPast ? '<span class="absolute -top-1 -right-1 bg-violet-500 text-white text-[9px] font-bold px-1 py-0.5 rounded leading-none">CHỜ</span>' : ''}
                            \${isFastFilling && !disabled && !isFull ? '<span class="absolute -top-1 -right-1 flex h-3 w-3"><span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-400 opacity-75"></span><span class="relative inline-flex rounded-full h-3 w-3 bg-red-500"></span></span>' : ''}
                        </label>
                    `;
                    container.insertAdjacentHTML('beforeend', html);
                });
                
                container.querySelectorAll('input[name="time"]').forEach(radio => {
                    radio.addEventListener('change', updateSubmitButton);
                });
                lucide.createIcons();
            })
            .catch(err => {
                console.error(err);
                container.innerHTML = '<div class="col-span-3 sm:col-span-4 text-center py-4 text-red-400">Lỗi tải dữ liệu. Vui lòng thử lại.</div>';
            });
    }

    function updateSubmitButton() {
        const selectedTime = document.querySelector('input[name="time"]:checked');
        const submitBtn = document.getElementById('submitBookingBtn');
        if (!submitBtn) return;
        
        if (selectedTime && selectedTime.getAttribute('data-waitlist') === 'true') {
            submitBtn.innerHTML = `<i data-lucide="clock" class="w-4 h-4 mr-2"></i> ĐĂNG KÝ DANH SÁCH CHỜ`;
            submitBtn.classList.remove('bg-[#00d4ff]', 'hover:bg-white', 'shadow-[0_0_20px_rgba(0,212,255,0.3)]');
            submitBtn.classList.add('bg-violet-500', 'hover:bg-violet-400', 'shadow-[0_0_20px_rgba(139,92,246,0.4)]');
            lucide.createIcons();
        } else {
            submitBtn.innerHTML = 'XÁC NHẬN ĐẶT LỊCH';
            submitBtn.classList.add('bg-[#00d4ff]', 'hover:bg-white', 'shadow-[0_0_20px_rgba(0,212,255,0.3)]');
            submitBtn.classList.remove('bg-violet-500', 'hover:bg-violet-400', 'shadow-[0_0_20px_rgba(139,92,246,0.4)]');
        }
    }

    document.addEventListener("DOMContentLoaded", () => {
        const checkedDate = document.querySelector('input[name="date"]:checked');
        if (checkedDate) {
            fetchSlots(checkedDate.value);
        }

        // Setup price and duration update logic
        const serviceCheckboxes = document.querySelectorAll('input[name="services"]');
        const priceDisplay = document.getElementById('totalPriceDisplay');

        let appliedRewardType = null;
        let appliedDiscountPercent = 0;
        
        function updatePrice() {
            // Xác định Kích cỡ Xe hiện tại
            let currentVehicleSize = 'SEDAN';
            const vehicleId = document.getElementById('vehicleIdInput')?.value;
            
            if (vehicleId) {
                const selectedVehicleOption = document.querySelector(`.vehicle-option[data-value="\${vehicleId}"]`);
                if (selectedVehicleOption) {
                    currentVehicleSize = (selectedVehicleOption.getAttribute('data-size') || '').trim();
                    if (!currentVehicleSize) {
                        // Fallback logic in case Java class wasn't recompiled
                        const typeName = selectedVehicleOption.getAttribute('data-type') || '';
                        const lowerText = typeName.normalize('NFD').replace(/[\u0300-\u036f]/g, "").toLowerCase();
                        if (lowerText.includes('ban tai') || lowerText.includes('mpv') || lowerText.includes('pickup')) {
                            currentVehicleSize = 'XLARGE';
                        } else if (lowerText.includes('suv') || lowerText.includes('cuv')) {
                            currentVehicleSize = 'SUV';
                        } else {
                            currentVehicleSize = 'SEDAN';
                        }
                    }
                }
            }

            let totalPrice = 0;
            let totalDuration = 0;
            
            // Cập nhật giá hiển thị trên UI cho từng Service Card
            serviceCheckboxes.forEach(checkbox => {
                let sid = checkbox.value;
                let basePrice = parseInt(checkbox.getAttribute('data-base-price')) || 0;
                let actualPrice = basePrice;
                
                if (servicePricesData && servicePricesData[sid] && servicePricesData[sid][currentVehicleSize]) {
                    actualPrice = servicePricesData[sid][currentVehicleSize];
                }
                
                // Cập nhật giá thật vào dataset để dùng tính Total
                checkbox.setAttribute('data-actual-price', actualPrice);
                
                // Update UI Card
                const priceDisplayEl = document.querySelector(`.service-price-display[data-sid="\${sid}"]`);
                if (priceDisplayEl) {
                    priceDisplayEl.innerHTML = new Intl.NumberFormat('vi-VN').format(actualPrice) + ' đ';
                }

                // Cộng thẳng vào tổng nếu checkbox đang được chọn
                if (checkbox.checked) {
                    totalPrice += actualPrice;
                    totalDuration += parseInt(checkbox.getAttribute('data-duration')) || 0;
                }
            });

            
            // Voucher logic
            let discountAmount = 0;
            if (appliedDiscountPercent > 0) {
                discountAmount = totalPrice * (appliedDiscountPercent / 100.0);
            } else if (appliedRewardType && appliedRewardType.endsWith('_PERCENT_OFF')) {
                let percent = parseFloat(appliedRewardType.replace('_PERCENT_OFF', ''));
                if (!isNaN(percent)) {
                    discountAmount = totalPrice * (percent / 100.0);
                }
            } else if (appliedRewardType && appliedRewardType.startsWith('PERCENT_')) {
                let percent = parseFloat(appliedRewardType.replace('PERCENT_', ''));
                if (!isNaN(percent)) {
                    discountAmount = totalPrice * (percent / 100.0);
                }
            } else if (appliedRewardType === 'FREE_WASH') {
                discountAmount = totalPrice; // Miễn phí hoàn toàn
            }
            
            let finalPrice = totalPrice - discountAmount;
            if (finalPrice < 0) finalPrice = 0;

            if (priceDisplay) {
                let displayHTML = '';
                if (discountAmount > 0) {
                    displayHTML += '<span class="text-sm text-text-muted line-through mr-2">' + new Intl.NumberFormat('vi-VN').format(totalPrice) + ' đ</span>';
                }
                displayHTML += new Intl.NumberFormat('vi-VN').format(finalPrice) + ' <span class="text-sm text-text-muted font-sans font-normal">đ</span>';
                priceDisplay.innerHTML = displayHTML;
            }
            
            window.currentGlobalDuration = totalDuration;
            updateTimeRangeDisplay();
        }

        function updateTimeRangeDisplay() {
            const timeRangeDisplay = document.getElementById('timeRangeDisplay');
            if (!timeRangeDisplay) return;

            const selectedTime = document.querySelector('input[name="time"]:checked');
            const duration = window.currentGlobalDuration || 0;
            
            if (!selectedTime || duration === 0) {
                timeRangeDisplay.classList.add('hidden');
                return;
            }

            const startTime = selectedTime.value;
            const [hours, minutes] = startTime.split(':').map(Number);
            
            const endDate = new Date();
            endDate.setHours(hours);
            endDate.setMinutes(minutes + duration);

            const endHours = String(endDate.getHours()).padStart(2, '0');
            const endMinutes = String(endDate.getMinutes()).padStart(2, '0');
            const endTime = endHours + ':' + endMinutes;

            timeRangeDisplay.innerHTML = 'Thời gian dự kiến: ' + startTime + ' - ' + endTime + ' (' + duration + ' phút)';
            timeRangeDisplay.classList.remove('hidden');
        }

        serviceCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', () => {
                updatePrice();
                const checkedDate = document.querySelector('input[name="date"]:checked');
                if (checkedDate) {
                    fetchSlots(checkedDate.value);
                }
            });
        });

        // Add event delegation for dynamically loaded time slots
        document.getElementById('timeSlotsContainer').addEventListener('change', function(e) {
            if(e.target && e.target.name === 'time') {
                updateTimeRangeDisplay();
            }
        });

        // Initialize price on load
        updatePrice();

        // Voucher Apply Button Logic
        const btnApplyVoucher = document.getElementById('btnApplyVoucher');
        const voucherInput = document.getElementById('voucherCode');
        
        if (btnApplyVoucher && voucherInput) {
            voucherInput.addEventListener('keydown', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault(); // Prevent form submit
                    btnApplyVoucher.click();
                }
            });

            btnApplyVoucher.addEventListener('click', function() {
                const code = voucherInput.value.trim();
                if (!code) {
                    showToast('Vui lòng nhập mã Voucher', 'error');
                    return;
                }
                
                btnApplyVoucher.disabled = true;
                voucherInput.readOnly = true;
                btnApplyVoucher.innerHTML = '<i data-lucide="loader" class="w-4 h-4 animate-spin"></i>';
                lucide.createIcons();
                
                fetch('${pageContext.request.contextPath}/api/apply-voucher?code=' + encodeURIComponent(code))
                    .then(res => res.json())
                    .then(data => {
                        if (data.valid) {
                            showToast(data.message, 'success');
                            appliedRewardType = data.rewardType;
                            appliedDiscountPercent = data.discountPercent || 0;
                            voucherInput.classList.add('border', 'border-green-500', 'text-green-400');
                            updatePrice();
                        } else {
                            showToast(data.message, 'error');
                            appliedRewardType = null;
                            appliedDiscountPercent = 0;
                            voucherInput.classList.remove('border-green-500', 'text-green-400');
                            updatePrice();
                        }
                    })
                    .catch(err => {
                        showToast('Lỗi kết nối máy chủ', 'error');
                    })
                    .finally(() => {
                        if (appliedRewardType) {
                            // Keep locked if success
                            btnApplyVoucher.disabled = true;
                            voucherInput.readOnly = true;
                            btnApplyVoucher.classList.replace('bg-bg-surface-hover', 'bg-green-500/20');
                            btnApplyVoucher.classList.replace('hover:bg-white', 'text-green-400');
                            btnApplyVoucher.innerHTML = '<i data-lucide="check" class="w-4 h-4 mr-1 inline"></i>Đã áp dụng';
                        } else {
                            // Unlock if failed
                            btnApplyVoucher.disabled = false;
                            voucherInput.readOnly = false;
                            btnApplyVoucher.innerHTML = 'Áp dụng';
                        }
                        if(typeof lucide !== 'undefined' && lucide.createIcons) lucide.createIcons();
                    });
            });
        }

        // Custom Select Logic for Vehicles
        const selectContainer = document.getElementById('vehicleSelectContainer');
        const trigger = document.getElementById('vehicleSelectTrigger');
        const dropdown = document.getElementById('vehicleSelectDropdown');
        const triggerText = document.getElementById('vehicleSelectText');
        const triggerIcon = document.getElementById('vehicleSelectIcon');
        const hiddenInput = document.getElementById('vehicleIdInput');
        const options = document.querySelectorAll('.vehicle-option');

        if(trigger && dropdown) {
            // Toggle dropdown
            trigger.addEventListener('click', (e) => {
                e.stopPropagation(); 
                const isExpanded = dropdown.classList.contains('opacity-100');
                if (isExpanded) {
                    closeDropdown();
                } else {
                    dropdown.classList.remove('opacity-0', 'invisible', '-translate-y-2');
                    dropdown.classList.add('opacity-100', 'visible', 'translate-y-0');
                    trigger.classList.add('border-[#00d4ff]', 'bg-white/5');
                    triggerIcon.classList.add('rotate-180');
                }
            });

            // Close when click outside
            document.addEventListener('click', (e) => {
                if (!selectContainer.contains(e.target)) {
                    closeDropdown();
                }
            });

            function closeDropdown() {
                dropdown.classList.remove('opacity-100', 'visible', 'translate-y-0');
                dropdown.classList.add('opacity-0', 'invisible', '-translate-y-2');
                trigger.classList.remove('border-[#00d4ff]', 'bg-white/5');
                triggerIcon.classList.remove('rotate-180');
            }

            // Select an option
            options.forEach(option => {
                option.addEventListener('click', () => {
                    // Remove active from all
                    options.forEach(opt => opt.querySelector('.check-icon').classList.remove('opacity-100'));
                    
                    // Add active to selected
                    option.querySelector('.check-icon').classList.add('opacity-100');
                    
                    // Update trigger text and hidden input
                    triggerText.innerHTML = option.getAttribute('data-text');
                    triggerText.classList.remove('text-text-muted');
                    triggerText.classList.add('text-white', 'font-bold');
                    hiddenInput.value = option.getAttribute('data-value');
                    
                    closeDropdown();
                    updatePrice(); // Re-calc price due to car size change
                });
                
                // Auto-select default
                if(option.getAttribute('data-default') === 'true' && !hiddenInput.value) {
                    option.click();
                }
            });

            // If no default was found, pick the first one
            if(!hiddenInput.value && options.length > 0) {
                options[0].click();
            } else if (options.length === 0) {
                triggerText.innerHTML = "Chưa có xe nào";
            }
        }
    });

        // Remove submitBookingMock and add real form validation & loading state
        const bookingForm = document.getElementById('bookingForm');
        if (bookingForm) {
            bookingForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                const selectedTime = document.querySelector('input[name="time"]:checked');
                const vehicleId = document.getElementById('vehicleIdInput').value;
                const selectedServices = document.querySelectorAll('input[name="services"]:checked');
                
                if (!vehicleId) {
                    showToast('Vui lòng chọn hoặc thêm phương tiện trước khi đặt lịch.', 'error');
                    return;
                }
                
                if (selectedServices.length === 0) {
                    showToast('Vui lòng chọn ít nhất một dịch vụ!', 'error');
                    return;
                }
                
                if (!selectedTime) {
                    showToast('Vui lòng chọn một khung giờ để đặt lịch.', 'error');
                    return;
                }

                // Show loading state
                const btn = document.getElementById('submitBookingBtn');
                const originalText = btn.innerHTML;
                if (btn) {
                    btn.innerHTML = '<i data-lucide="loader" class="w-5 h-5 animate-spin mr-2 inline"></i> Đang xử lý...';
                    btn.disabled = true;
                    if(typeof lucide !== 'undefined') lucide.createIcons();
                }

                const formData = new FormData(bookingForm);
                fetch('${pageContext.request.contextPath}/checkout', {
                    method: 'POST',
                    headers: {
                        'Accept': 'application/json',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: new URLSearchParams(formData)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showToast(data.message, 'success');
                        setTimeout(() => {
                            window.location.href = '${pageContext.request.contextPath}/customer/booking_history';
                        }, 1500);
                    } else {
                        showToast(data.message, 'error');
                        if (btn) {
                            btn.innerHTML = originalText;
                            btn.disabled = false;
                            if(typeof lucide !== 'undefined') lucide.createIcons();
                        }
                    }
                })
                .catch(error => {
                    showToast('Có lỗi xảy ra khi kết nối với máy chủ.', 'error');
                    if (btn) {
                        btn.innerHTML = originalText;
                        btn.disabled = false;
                        if(typeof lucide !== 'undefined') lucide.createIcons();
                    }
                });
            });
        }
</script>
    <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>




