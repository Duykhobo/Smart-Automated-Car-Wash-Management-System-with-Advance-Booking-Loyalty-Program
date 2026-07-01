<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
    <title>Auto Wash Pro - Đặt Lịch Dịch Vụ</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
    <style>
            /* Sửa lỗi Tailwind peer-checked không ăn cho thẻ con */
            input[name="service"]:checked + div h3 {
                color: #ffffff !important;
            }
            input[name="service"]:checked + div .radio-outer {
                border-color: #00d4ff !important;
            }
            input[name="service"]:checked + div .radio-inner {
                opacity: 1 !important;
            }

            input[name="date"]:checked + div span:first-child {
                color: rgba(0, 0, 0, 0.7) !important;
            }
            input[name="date"]:checked + div span:last-child {
                color: black !important;
            }

            input[name="time"]:checked + div span {
                color: #00d4ff !important;
            }
        </style>

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
                <a href="${pageContext.request.contextPath}/vehicles" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                    <i data-lucide="car" class="w-5 h-5"></i>
                    <span class="font-medium text-sm">Quản lý xe</span>
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

                <!-- User Tier Badge -->
                <div class="hidden sm:flex items-center gap-2 px-3 py-1.5 rounded-full ${badgeClass}">
                    <i data-lucide="star" class="w-4 h-4"></i>
                    <span class="text-xs font-bold tracking-wide uppercase">${tierName} TIER</span>
                </div>
            </header>

            <div class="px-4 md:px-8 py-8 max-w-3xl mx-auto space-y-8">

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

                <form id="bookingForm" action="${pageContext.request.contextPath}/customer/booking_history" method="POST" class="space-y-8" onsubmit="return validateForm()">

                    <input type="hidden" name="bookingId" value="${bookingInfo.bookingId}">
                    <input type="hidden" name="action" value="update">

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
                                                <div class="vehicle-option px-4 py-3 rounded-lg cursor-pointer hover:bg-white/10 transition-colors flex items-center justify-between group" data-value="${v.vehicleId}" data-text="${v.licensePlate} <c:if test="${not empty v.brand}">- ${v.brand}</c:if>" ${v.licensePlate == bookingInfo.licensePlate ? 'data-default="true"' : ''}>
                                                    <span class="text-gray-300 group-hover:text-white font-medium transition-colors">${v.licensePlate} <c:if test="${not empty v.brand}"><span class="text-text-muted text-sm ml-1 font-normal">- ${v.brand}</span></c:if></span>
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
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <c:choose>
                                <c:when test="${not empty services}">
                                    <c:forEach var="service" items="${services}" varStatus="status">
                                        <label class="block relative cursor-pointer group">
                                            <input type="radio" name="service" value="${service.serviceId}" data-price="${service.basePrice}" class="peer sr-only" ${service.serviceId == bookingInfo.serviceId ? 'checked' : ''}>
                                            <div class="glass-panel p-5 min-h-[100px] rounded-2xl border-2 border-transparent peer-checked:border-[#00d4ff] peer-checked:bg-[#00d4ff]/5 transition-all flex flex-col justify-between gap-3 hover:-translate-y-1">
                                                <div class="flex items-start justify-between">
                                                    <h3 class="font-display font-bold text-base md:text-lg text-gray-300 peer-checked:text-white leading-snug">${service.name}</h3>
                                                    <div class="radio-outer w-5 h-5 rounded-full border-2 border-gray-600 peer-checked:border-[#00d4ff] flex items-center justify-center shrink-0">
                                                        <div class="radio-inner w-2.5 h-2.5 rounded-full bg-[#00d4ff] opacity-0 peer-checked:opacity-100 transition-opacity"></div>
                                                    </div>
                                                </div>
                                                <div class="flex items-end justify-between mt-auto">
                                                    <div class="font-bold text-[#00d4ff] text-lg md:text-xl">
                                                        <fmt:formatNumber value="${service.basePrice}" pattern="#,###"/> đ
                                                    </div>
                                                </div>
                                                <c:if test="${not empty service.inactiveFromDate}">
                                                    <div class="text-xs text-amber-500 bg-amber-500/10 p-2 rounded-lg mt-2 flex items-start gap-1.5 border border-amber-500/20">
                                                        <i data-lucide="alert-circle" class="w-3.5 h-3.5 shrink-0 mt-0.5"></i>
                                                        <span>Dịch vụ này sẽ ngưng hoạt động từ <fmt:formatDate value="${service.inactiveFromDate}" pattern="dd/MM/yyyy HH:mm" /></span>
                                                    </div>
                                                </c:if>
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
                            <span class="text-xs text-text-muted bg-bg-surface px-2 py-1 rounded border border-border-glass">Tối đa ${maxBookingDays} ngày (${tierName})</span>
                        </div>

                        <!-- Date Horizontal Scroll -->
                        <div class="flex gap-3 overflow-x-auto hide-scrollbar pb-2 snap-x">
                            <fmt:formatDate value="${bookingInfo.bookingDate}" pattern="yyyy-MM-dd" var="bDate" />
                            <c:forEach var="date" items="${dynamicDays}" varStatus="status">
                                <!-- In a real app, next7Days list size depends on tier logic in the backend -->
                                <c:set var="dayOfWeek" value="${date.dayOfWeek.value}" />
                                <c:choose>
                                    <c:when test="${dayOfWeek == 7}"><c:set var="dayName" value="CN" /></c:when>
                                    <c:otherwise><c:set var="dayName" value="T${dayOfWeek + 1}" /></c:otherwise>
                                </c:choose>
                                <c:set var="isWeekend" value="${dayOfWeek == 6 || dayOfWeek == 7}" />

                                <label class="cursor-pointer shrink-0 snap-start transition-transform group">
                                    <input type="radio" name="date" value="${date}" onchange="fetchSlots(this.value)" class="peer sr-only" ${date == bDate ? 'checked' : ''}>
                                    <div class="w-16 h-[80px] rounded-2xl glass-panel border-2 border-transparent peer-checked:bg-[#00d4ff] peer-checked:text-black peer-checked:shadow-[0_0_15px_rgba(0,212,255,0.4)] flex flex-col items-center justify-center gap-1.5 transition-all group-hover:-translate-y-1">
                                        <span class="text-xs ${isWeekend ? 'text-red-400' : 'text-text-muted'} peer-checked:text-black/70 font-semibold uppercase">${dayName}</span>
                                        <span class="text-xl font-bold ${isWeekend ? 'text-red-400' : 'text-white'} peer-checked:text-black">${date.dayOfMonth}</span>
                                    </div>
                                </label>
                            </c:forEach>
                        </div>

                        <!-- Time Slots Grid (AJAX Rendered) -->
                        <div id="timeSlotsContainer" class="grid grid-cols-3 sm:grid-cols-4 gap-3 mt-4">
                            <!-- Javascript will populate this -->
                        </div>
                        <div class="flex flex-wrap items-center gap-4 mt-3 text-xs text-text-muted">
                            <div class="flex items-center gap-1.5"><div class="w-3 h-3 rounded bg-bg-primary border border-border-glass opacity-50"></div><span>Đã qua / Đã đầy</span></div>
                            <div class="flex items-center gap-1.5"><div class="w-3 h-3 rounded bg-[#00d4ff]/20 border border-[#00d4ff]"></div><span>Đang chọn</span></div>
                            <div class="flex items-center gap-1.5"><div class="w-3 h-3 rounded bg-amber-500/20 border border-amber-500"></div><span>Sắp hết chỗ</span></div>
                            <div class="flex items-center gap-1.5"><i data-lucide="zap" class="w-3.5 h-3.5 text-amber-400"></i><span>Slot ưu tiên</span></div>
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
                    <span class="text-xs md:text-sm text-text-muted font-medium uppercase tracking-wider">Tổng Thanh Toán (Tại quầy)</span>
                    <span id="totalPriceDisplay" class="text-xl md:text-2xl font-display font-bold text-[#00d4ff]">0 <span class="text-sm text-text-muted font-sans font-normal">đ</span></span>
                </div>
                <button type="submit" form="bookingForm" class="btn-glow bg-[#00d4ff] hover:bg-white text-black font-bold px-8 h-12 md:h-14 rounded-xl transition-all text-sm md:text-base flex items-center justify-center shadow-[0_0_20px_rgba(0,212,255,0.3)]">
                    CẬP NHẬT LỊCH HẸN
                </button>
            </div>
        </div>

        <fmt:formatDate value="${bookingInfo.scheduledTime}" pattern="HH:mm" var="formattedOldTime" />
        <script>
            const oldTime = '${formattedOldTime}'; // Lấy giờ cũ (ví dụ: "09:00")
            lucide.createIcons();

            function fetchSlots(dateStr) {
                const container = document.getElementById('timeSlotsContainer');
                container.innerHTML = '<div class="col-span-3 sm:col-span-4 text-center py-6"><i data-lucide="loader" class="w-6 h-6 animate-spin mx-auto text-[#00d4ff]"></i><p class="text-text-muted text-sm mt-2">Đang tìm slot trống...</p></div>';
                lucide.createIcons();

                fetch(`${pageContext.request.contextPath}/api/slots?date=` + dateStr)
                        .then(res => res.json())
                        .then(data => {
                            container.innerHTML = '';
                            // Setup today's date checking
                            const now = new Date();
                            const todayStr = now.getFullYear() + "-" + String(now.getMonth() + 1).padStart(2, '0') + "-" + String(now.getDate()).padStart(2, '0');
                            const isToday = (dateStr === todayStr);
                            const currentMinutes = now.getHours() * 60 + now.getMinutes();

                            data.forEach((slot, index) => {
                                let isPast = slot.isPast;
                                let isFull = slot.currentBooked >= slot.maxCapacity;
                                let isFastFilling = slot.nearlyFull;

                                // Mock priority slot for 09:00 and 15:00
                                let isPriority = (slot.time === '09:00' || slot.time === '15:00');

                                let disabled = isPast || isFull;

                                let bgClass = disabled ? 'bg-bg-primary' : 'hover:border-[#00d4ff]/50';
                                let borderClass = disabled ? 'border-border-glass' : 'border-border-glass';
                                let textClass = disabled ? 'text-gray-500' : 'text-gray-300';

                                if (!disabled && isFastFilling) {
                                    bgClass = 'bg-amber-500/10 hover:border-amber-500/50 peer-checked:bg-amber-500/20';
                                    borderClass = 'border-amber-500/30 peer-checked:border-amber-500';
                                    textClass = 'text-amber-500 peer-checked:text-amber-400';
                                } else if (!disabled) {
                                    bgClass += ' peer-checked:bg-[#00d4ff]/20';
                                    borderClass += ' peer-checked:border-[#00d4ff]';
                                    textClass += ' peer-checked:text-[#00d4ff]';
                                }

                                let html = `
                                <label class="transition-transform group relative \${disabled ? 'opacity-40 cursor-not-allowed' : 'cursor-pointer'}">
                                    <input type="radio" name="time" class="peer sr-only" value="\${slot.time}" \${disabled ? 'disabled' : ''} \${slot.time === oldTime ? 'checked' : ''}>
                                    <div class="h-12 rounded-xl glass-panel border \${borderClass} \${bgClass} flex items-center justify-center transition-all \${isPriority ? 'priority-slot' : ''}">
                                        <span class="font-bold text-sm \${textClass} flex items-center gap-1.5">
                                            \${isPriority ? '<i data-lucide="zap" class="w-3.5 h-3.5 text-amber-400"></i>' : ''}
                                            \${disabled ? (isFull ? '<i data-lucide="lock" class="w-3.5 h-3.5"></i>' : '<i data-lucide="clock" class="w-3.5 h-3.5"></i>') : ''}
                                            <span class="\${disabled && !isFull ? 'line-through' : ''}">\${slot.time}</span>
                                        </span>
                                    </div>
                                    \${isFastFilling && !disabled ? '<span class="absolute -top-1 -right-1 flex h-3 w-3"><span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-400 opacity-75"></span><span class="relative inline-flex rounded-full h-3 w-3 bg-red-500"></span></span>' : ''}
                                </label>
                            `;
                                container.insertAdjacentHTML('beforeend', html);
                            });
                            lucide.createIcons();
                        })
                        .catch(err => {
                            console.error(err);
                            container.innerHTML = '<div class="col-span-3 sm:col-span-4 text-center py-4 text-red-400">Lỗi tải dữ liệu. Vui lòng thử lại.</div>';
                        });
            }

            document.addEventListener("DOMContentLoaded", () => {
                const checkedDate = document.querySelector('input[name="date"]:checked');
                if (checkedDate) {
                    fetchSlots(checkedDate.value);
                }

                // Setup price update logic
                const serviceRadios = document.querySelectorAll('input[name="service"]');
                const priceDisplay = document.getElementById('totalPriceDisplay');

                function updatePrice() {
                    const selectedService = document.querySelector('input[name="service"]:checked');
                    if (selectedService) {
                        const price = parseInt(selectedService.getAttribute('data-price')) || 0;
                        priceDisplay.innerHTML = new Intl.NumberFormat('vi-VN').format(price) + ' <span class="text-sm text-text-muted font-sans font-normal">đ</span>';
                    }
                }

                serviceRadios.forEach(radio => {
                    radio.addEventListener('change', updatePrice);
                });

                // Initialize price on load
                updatePrice();

                // Custom Select Logic for Vehicles
                const selectContainer = document.getElementById('vehicleSelectContainer');
                const trigger = document.getElementById('vehicleSelectTrigger');
                const dropdown = document.getElementById('vehicleSelectDropdown');
                const triggerText = document.getElementById('vehicleSelectText');
                const triggerIcon = document.getElementById('vehicleSelectIcon');
                const hiddenInput = document.getElementById('vehicleIdInput');
                const options = document.querySelectorAll('.vehicle-option');

                if (trigger && dropdown) {
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
                        });

                        // Auto-select default
                        if (option.getAttribute('data-default') === 'true' && !hiddenInput.value) {
                            option.click();
                        }
                    });

                    // If no default was found, pick the first one
                    if (!hiddenInput.value && options.length > 0) {
                        options[0].click();
                    } else if (options.length === 0) {
                        triggerText.innerHTML = "Chưa có xe nào";
                    }
                }
            });

            function validateForm() {
                const selectedTime = document.querySelector('input[name="time"]:checked');
                if (!selectedTime) {
                    showJSToast('error', "Vui lòng chọn một múi giờ trống trước khi cập nhật!");
                    return false;
                }
                return true;
            }
        </script>
        <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>






