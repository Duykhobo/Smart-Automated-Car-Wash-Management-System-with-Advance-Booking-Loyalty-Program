<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <!-- Google Fonts (Vietnamese Supported) & Font Fallback -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <style>
            body,
            .font-sans {
                font-family: 'Inter', sans-serif !important;
            }

            .font-display {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
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

            // Function to show Toast Notification
            function showToast(message) {
                // Handled globally now
            }

            document.addEventListener("DOMContentLoaded", () => {
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.has('success')) {
                    // Handled globally if passed in session
                }
            });
        </script>
        <style>
            /* Glassmorphism Toast */
        </style>
        <c:if test="${param.msg == 'UpdateError'}">
        <script>
            showJSToast('error', 'Cập nhật thất bại. Lỗi: ${param.err}');
        </script>
    </c:if>
</head>

    <body
        class="m-0 min-h-screen bg-bg-primary text-white font-sans antialiased selection:bg-[#00d4ff] selection:text-black w-full overflow-x-hidden relative">

        <!-- Modals injected at bottom -->

        <!-- Global toast included at bottom -->

        <!-- Desktop Sidebar -->
        <aside
            class="hidden md:flex flex-col w-64 glass-panel border-r border-border-glass fixed h-full z-10 left-0 top-0">
            <a href="${pageContext.request.contextPath}/account/dashboard"
               class="p-6 flex items-center gap-3 hover:opacity-80 transition-opacity">
                <i data-lucide="droplets" class="text-[#00d4ff] w-8 h-8"></i>
                <span class="text-xl font-display font-bold tracking-tight text-white">AUTOWASH<span
                        class="text-[#00d4ff]">PRO</span></span>
            </a>

            <nav class="flex-1 px-4 py-4 space-y-2 mt-4">
                <a href="${pageContext.request.contextPath}/account/dashboard"
                   class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                    <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
                    <span class="font-medium text-sm">Tổng quan</span>
                </a>
                <a href="${pageContext.request.contextPath}/bookings"
                   class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                    <i data-lucide="calendar-plus" class="w-5 h-5"></i>
                    <span class="font-medium text-sm">Đặt lịch dịch vụ</span>
                </a>
                <a href="${pageContext.request.contextPath}/customer/booking_history" class="flex items-center gap-3 px-4 py-3 bg-[#00d4ff]/10 text-[#00d4ff] rounded-xl border border-[#00d4ff]/20 transition-colors shadow-[0_0_10px_rgba(0,212,255,0.1)]">
                    <i data-lucide="history" class="w-5 h-5"></i>
                    <span class="font-medium text-sm">Lịch sử rửa xe</span>
                </a>
                <a href="${pageContext.request.contextPath}/vehicles" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                    <i data-lucide="car" class="w-5 h-5"></i>
                    <span class="font-medium text-sm">Quản lý xe</span>
                </a>
                <a href="${pageContext.request.contextPath}/customer/loyalty"
                   class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                    <i data-lucide="award" class="w-5 h-5"></i>
                    <span class="font-medium text-sm">Loyalty Program</span>
                </a>
                <a href="${pageContext.request.contextPath}/account/profile"
                   class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                    <i data-lucide="user" class="w-5 h-5"></i>
                    <span class="font-medium text-sm">Hồ sơ cá nhân</span>
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 md:ml-64 relative min-h-screen bg-bg-primary">
            <!-- App Bar / Header -->
            <header
                class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center justify-between gap-3">
                <div class="flex items-center gap-3">
                    <button onclick="history.back()"
                            class="w-10 h-10 shrink-0 flex items-center justify-center hover:bg-bg-surface-hover rounded-full transition-colors text-white"
                            aria-label="Quay lại">
                        <i data-lucide="arrow-left" class="w-5 h-5"></i>
                    </button>
                    <h1 class="text-lg md:text-2xl font-display font-bold truncate text-white">Lịch Sử Hoạt Động
                    </h1>
                </div>

                <div class="hidden sm:flex flex-col items-end">
                    <span class="text-xs text-text-muted">Tổng số lượt rửa</span>
                    <span class="text-lg font-bold text-[#00d4ff]"><c:out value="${customer.totalWashes}" /></span>
                </div>
            </header>

            <div class="px-4 md:px-8 py-8 max-w-4xl mx-auto space-y-6">

                <!-- Tabs & Actions -->
                <div class="flex flex-col sm:flex-row sm:items-center justify-between border-b border-border-glass gap-4 pb-2 sm:pb-0">
                    <div class="flex">
                        <button id="btn-tab-upcoming" onclick="switchTab('tab-upcoming')"
                                class="tab-btn px-6 py-4 font-display font-semibold text-white border-b-2 border-[#00d4ff] transition-colors flex items-center gap-2">
                            Lịch Sắp Tới
                            <!-- Badge for upcoming count -->
                            <c:if test="${not empty upcomingBookings and fn:length(upcomingBookings) > 0}">
                                <span class="w-5 h-5 rounded-full bg-[#00d4ff] text-black text-xs flex items-center justify-center">${fn:length(upcomingBookings)}</span>
                            </c:if>
                        </button>
                        <button id="btn-tab-history" onclick="switchTab('tab-history')"
                                class="tab-btn px-6 py-4 font-display font-semibold text-text-muted border-b-2 border-transparent hover:text-gray-300 transition-colors">
                            Đã Hoàn Thành
                        </button>
                    </div>
                    <!-- SEED DEMO DATA BUTTON -->
                    <a href="${pageContext.request.contextPath}/customer/seed_demo" class="px-4 py-2 bg-purple-500/20 text-purple-400 border border-purple-500/50 rounded-lg text-sm font-semibold hover:bg-purple-500 hover:text-white transition-colors flex items-center gap-2 self-start sm:self-auto mb-2 sm:mb-0">
                        <i data-lucide="database" class="w-4 h-4"></i> Tạo Dữ Liệu Mẫu
                    </a>
                </div>

                <!-- Tab 1: Upcoming Bookings -->
                <div id="tab-upcoming" class="tab-content space-y-4">

                    <c:choose>
                        <c:when test="${not empty upcomingBookings}">
                            <c:forEach var="booking" items="${upcomingBookings}">
                                <!-- Upcoming Card -->
                                <article class="glass-panel p-5 sm:p-6 rounded-2xl border-l-4 ${fn:toLowerCase(fn:trim(booking.status)) == 'pending' ? 'border-l-amber-500' : 'border-l-[#00d4ff]'} shadow-lg hover:-translate-y-1 transition-transform relative overflow-hidden">
                                    <div class="absolute -right-10 -top-10 w-32 h-32 ${fn:toLowerCase(fn:trim(booking.status)) == 'pending' ? 'bg-amber-500/10' : 'bg-[#00d4ff]/10'} rounded-full blur-2xl">
                                    </div>
                                    <div class="flex flex-col sm:flex-row justify-between gap-4">
                                        <div class="space-y-3 flex-1">
                                            <div class="flex flex-wrap items-center gap-2">
                                                <span class="px-2.5 py-1 rounded ${fn:toLowerCase(fn:trim(booking.status)) == 'pending' ? 'bg-amber-500/20 text-amber-500' : 'bg-[#00d4ff]/20 text-[#00d4ff]'} text-xs font-bold uppercase ${fn:toLowerCase(fn:trim(booking.status)) == 'in progress' ? 'animate-pulse' : ''}">
                                                    <c:out value="${booking.status}" />
                                                </span>
                                                <span class="text-text-muted text-sm font-medium">Mã Đặt: #<c:out value="${booking.bookingId}" /></span>

                                                <c:if test="${customer.tierStatus != 'Member'}">
                                                    <div class="px-3 py-1 rounded-full bg-gradient-to-r from-amber-500/20 to-yellow-300/10 border border-amber-500/30 text-amber-400 text-xs font-bold uppercase tracking-wide flex items-center gap-1.5 shadow-[0_0_10px_rgba(245,158,11,0.2)]">
                                                        <i data-lucide="sparkles" class="w-3.5 h-3.5"></i>
                                                        ✨ Đặc quyền <c:out value="${customer.tierStatus}" />
                                                    </div>
                                                </c:if>
                                            </div>

                                            <h3 class="font-display font-bold text-xl text-white">Lịch Chăm Sóc Xe
                                            </h3>

                                            <div class="grid grid-cols-2 gap-x-8 gap-y-2 text-sm mt-2">
                                                <div class="flex items-center gap-2 text-gray-300">
                                                    <i data-lucide="calendar" class="w-4 h-4 text-text-muted"></i>
                                                    <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy" />
                                                </div>
                                                <div class="flex items-center gap-2 text-gray-300">
                                                    <i data-lucide="clock" class="w-4 h-4 text-text-muted"></i>
                                                    <fmt:formatDate value="${booking.scheduledTime}" pattern="HH:mm" />
                                                </div>
                                                <div class="flex items-center gap-2 text-gray-300 col-span-2">
                                                    <i data-lucide="car" class="w-4 h-4 text-text-muted"></i>
                                                    Biển số: <span class="font-semibold"><c:out value="${booking.licensePlate}" /></span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="flex flex-col items-start sm:items-end justify-between border-t sm:border-t-0 sm:border-l border-border-glass pt-4 sm:pt-0 sm:pl-6 mt-2 sm:mt-0 min-w-[140px]">
                                            <div class="text-xl font-display font-bold text-[#00d4ff]"><fmt:formatNumber value="${booking.finalPrice}" pattern="#,###" /><span class="text-sm font-sans font-normal text-text-muted">VND</span></div>

                                            <!-- QR Code for Automated Check-in -->
                                            <div class="flex flex-col items-center justify-center mt-3 mb-2 p-2 bg-white rounded-lg shadow-[0_0_15px_rgba(255,255,255,0.2)]">
                                                <img src="https://api.qrserver.com/v1/create-qr-code/?size=80x80&data=${booking.bookingId}" alt="QR Code" class="w-16 h-16" />
                                                <span class="text-[10px] text-gray-800 font-bold mt-1 uppercase">Quét tại trạm</span>
                                            </div>

                                            <div class="flex gap-2 mt-auto w-full justify-between sm:justify-end">
                                                <c:if test="${booking.status == 'Pending'}">
                                                    <a href="${pageContext.request.contextPath}/customer/booking_history?action=edit&id=${booking.bookingId}" class="flex-1 sm:flex-none px-3 py-2 rounded-lg bg-bg-surface hover:bg-[#00d4ff]/20 text-[#00d4ff] border border-[#00d4ff]/30 text-sm font-semibold transition-colors text-center">
                                                        Sửa
                                                    </a>
                                                    <form action="${pageContext.request.contextPath}/BookingHistoryController" method="POST" class="flex-1 sm:flex-none m-0 p-0" id="cancelForm_${booking.bookingId}">
                                                        <input type="hidden" name="action" value="cancel" />
                                                        <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                        <button type="button" onclick="showGlobalConfirmModal('Hủy lịch hẹn', 'Bạn có chắc chắn muốn hủy lịch hẹn này không? Hành động này không thể hoàn tác và số suất sẽ được nhường cho người khác.', 'Xác nhận Hủy', function() { document.getElementById('cancelForm_${booking.bookingId}').submit(); })" class="w-full px-3 py-2 rounded-lg bg-bg-surface hover:bg-red-500/20 text-red-400 border border-red-500/30 text-sm font-semibold transition-colors text-center">
                                                            Hủy Lịch
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </article>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="p-8 glass-panel rounded-2xl text-center flex flex-col items-center justify-center border-dashed border-2 border-border-glass">
                                <div class="w-16 h-16 bg-bg-surface rounded-full flex items-center justify-center mb-4">
                                    <i data-lucide="calendar-x" class="w-8 h-8 text-text-muted"></i>
                                </div>
                                <p class="text-text-muted mb-4">Bạn chưa có lịch hẹn nào sắp tới.</p>
                                <a href="${pageContext.request.contextPath}/bookings" class="px-6 py-2 bg-[#00d4ff] text-black font-bold rounded-lg hover:bg-white transition-colors">Đăng Ký Ngay</a>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </div>

                <!-- Tab 2: Past Wash History -->
                <div id="tab-history" class="tab-content hidden space-y-4">

                    <c:choose>
                        <c:when test="${not empty historyBookings}">
                            <c:forEach var="booking" items="${historyBookings}">
                                <article class="glass-panel p-5 rounded-2xl flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 ${booking.status == 'Cancelled' || booking.status == 'No Show' ? 'opacity-70' : ''}">
                                    <div class="flex items-start gap-4 w-full">
                                        <div class="w-12 h-12 rounded-full ${booking.status == 'Completed' ? 'bg-success/10 border-success/30' : 'bg-red-500/10 border-red-500/30'} flex items-center justify-center shrink-0 border">
                                            <i data-lucide="${booking.status == 'Completed' ? 'check-circle' : 'x-circle'}" class="w-6 h-6 ${booking.status == 'Completed' ? 'text-success' : 'text-red-500'}"></i>
                                        </div>
                                        <div class="flex-1">
                                            <div class="flex items-center justify-between">
                                                <h3 class="font-display font-bold text-lg text-white">Dịch Vụ Rửa Xe</h3>
                                                <c:choose>
                                                    <c:when test="${booking.status == 'Completed'}">
                                                        <span class="text-success text-sm font-bold">+150 điểm</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-red-400 text-sm font-semibold border border-red-500/50 px-2 py-0.5 rounded">
                                                            <c:out value="${booking.status == 'Cancelled' ? 'Đã hủy' : 'Không đến'}" />
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="text-sm text-text-muted mt-1 flex flex-wrap gap-x-4 gap-y-1">
                                                <span><i data-lucide="calendar" class="w-3.5 h-3.5 inline"></i> <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy" /></span>
                                                <span><i data-lucide="car" class="w-3.5 h-3.5 inline"></i> <c:out value="${booking.licensePlate}" /></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-right w-full sm:w-auto border-t sm:border-none border-border-glass pt-3 sm:pt-0 flex flex-col items-end gap-2 min-w-[140px]">
                                        <div class="font-bold text-lg text-[#00d4ff]"><fmt:formatNumber value="${booking.finalPrice}" pattern="#,###" /><span class="text-sm font-sans font-normal text-text-muted">đ</span></div>
                                        <div class="flex items-center gap-2">
                                            <c:if test="${booking.status == 'Completed'}">
                                                <button class="text-text-muted text-sm hover:text-white transition-colors">Đánh giá</button>
                                            </c:if>
                                            <a href="${pageContext.request.contextPath}/bookings?serviceId=${booking.serviceId}&vehicleId=${booking.vehicleId}" class="px-4 py-2 rounded-lg bg-[#00d4ff]/10 hover:bg-[#00d4ff] text-[#00d4ff] hover:text-black text-sm font-semibold transition-colors border border-[#00d4ff]/30 flex items-center gap-1.5">
                                                <i data-lucide="rotate-cw" class="w-4 h-4"></i> Đặt lại
                                            </a>
                                        </div>
                                    </div>
                                </article>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="p-8 glass-panel rounded-2xl text-center flex flex-col items-center justify-center border-dashed border-2 border-border-glass">
                                <div class="w-16 h-16 bg-bg-surface rounded-full flex items-center justify-center mb-4">
                                    <i data-lucide="history" class="w-8 h-8 text-text-muted"></i>
                                </div>
                                <p class="text-text-muted">Bạn chưa có lịch sử đặt lịch nào.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${fn:length(historyBookings) > 5}">
                        <div class="flex justify-center mt-6">
                            <button class="flex items-center gap-2 text-text-muted hover:text-white transition-colors">
                                <i data-lucide="loader" class="w-4 h-4 animate-spin hidden"></i> Tải thêm lịch sử
                            </button>
                        </div>
                    </c:if>

                </div>

            </div>
        </main>

        <script>
            lucide.createIcons();
        </script>
        <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>

</html>