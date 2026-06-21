<%@page import="utils.AppConstants" %>
    <%@page import="dto.Customer" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                    <c:if test="${empty sessionScope.USER}">
                        <c:redirect url="/auth/login" />
                    </c:if>
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
                        <meta name="viewport"
                            content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
                        <meta charset="utf-8" />
                        <title>Auto Wash Pro - Dashboard</title>
                        <!-- Global CSS & Tailwind Config -->
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css?v=4" />
                        <script src="${pageContext.request.contextPath}/assets/js/tailwind-config.js?v=4"></script>
                        <script src="https://cdn.tailwindcss.com"></script>
                        <!-- Icons (Lucide) -->
                        <script src="https://unpkg.com/lucide@latest"></script>
                    </head>

                    <body
                        class="m-0 min-h-screen bg-bg-primary text-text-primary font-sans antialiased selection:bg-[#00d4ff] selection:text-black w-full overflow-x-hidden">

                        <div class="flex h-screen overflow-hidden bg-bg-primary">

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
                                        class="flex items-center gap-3 px-4 py-3 bg-[#00d4ff]/10 text-[#00d4ff] rounded-xl border border-[#00d4ff]/20 transition-colors shadow-[0_0_10px_rgba(0,212,255,0.1)]">
                                        <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
                                        <span class="font-medium text-sm">Tổng quan</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/bookings"
                                        class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                                        <i data-lucide="calendar-plus" class="w-5 h-5"></i>
                                        <span class="font-medium text-sm">Đặt lịch dịch vụ</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/customer/booking_history"
                                        class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                                        <i data-lucide="history" class="w-5 h-5"></i>
                                        <span class="font-medium text-sm">Lịch sử rửa xe</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/vehicles"
                                        class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
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

                            <!-- Main Content Area -->
                            <main
                                class="flex-1 md:ml-64 relative min-h-screen bg-bg-primary overflow-y-auto pb-24 md:pb-8">
                                <!-- App Bar / Header -->
                                <header
                                    class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center justify-between gap-3">
                                    <div class="flex items-center gap-3">
                                        <h1 class="text-lg md:text-2xl font-display font-bold text-white">Dashboard</h1>
                                    </div>

                                    <div class="flex items-center gap-3">
                                        <div class="hidden sm:flex flex-col items-end mr-2">
                                            <span class="text-xs text-text-muted">Xin chào,</span>
                                            <span
                                                class="text-sm font-bold text-white">${sessionScope.USER.fullName}</span>
                                        </div>
                                        <div
                                            class="w-10 h-10 rounded-full bg-[#00d4ff]/20 border border-[#00d4ff] flex items-center justify-center text-[#00d4ff] font-bold">
                                            ${sessionScope.USER.fullName.substring(0,1)}
                                        </div>
                                    </div>
                                </header>

                                <div class="px-4 md:px-8 py-8 max-w-4xl mx-auto space-y-8">
                                    <% String errMsg=(String)
                                        session.getAttribute(utils.AppConstants.SESSION_MSG_ERROR); if (errMsg !=null) {
                                        %>
                                        <div
                                            class="bg-error/10 border border-error/20 text-error p-4 rounded-xl flex items-center gap-3">
                                            <i data-lucide="alert-circle" class="w-5 h-5 shrink-0"></i>
                                            <span><strong>Lá»—i:</strong>
                                                <%= errMsg %>
                                            </span>
                                        </div>
                                        <% session.removeAttribute(utils.AppConstants.SESSION_MSG_ERROR); } %>

                                            <!-- Membership Card -->
                                            <section aria-labelledby="membership-card-title"
                                                class="relative w-full max-w-md rounded-2xl overflow-hidden bg-gradient-to-br from-bg-primary to-[#0a1128] border border-border-glass shadow-2xl p-6 group">

                                                <!-- Gradient Overlay -->
                                                <div
                                                    class="absolute inset-0 z-0 bg-gradient-to-t from-bg-primary via-transparent to-transparent">
                                                </div>
                                                <div
                                                    class="absolute inset-0 opacity-20 bg-[radial-gradient(ellipse_at_center,_var(--tw-gradient-stops))] from-amber-400 via-transparent to-transparent z-0">
                                                </div>

                                                <div class="relative z-10 flex flex-col gap-6">
                                                    <div class="flex justify-between items-start">
                                                        <div class="flex items-center gap-2">
                                                            <div
                                                                class="w-8 h-8 rounded-full bg-gradient-to-tr from-amber-400 to-amber-600 flex items-center justify-center shadow-lg">
                                                                <i data-lucide="crown" class="w-4 h-4 text-black"></i>
                                                            </div>
                                                            <h2 id="membership-card-title"
                                                                class="text-gray-200 text-sm font-semibold tracking-wider uppercase font-display">
                                                                Auto Wash Pro</h2>
                                                        </div>

                                                        <div class="text-right flex flex-col items-end">
                                                            <span
                                                                class="text-gray-300 text-xs font-medium uppercase tracking-wider mb-1">Hạng
                                                                Thành Viên</span>
                                                            <span
                                                                class="text-amber-400 font-extrabold text-xl uppercase tracking-widest drop-shadow-[0_0_10px_rgba(251,191,36,0.6)] font-display">
                                                                <c:out value="${customer.tierStatus}" />
                                                            </span>
                                                        </div>
                                                    </div>

                                                    <div class="flex flex-col mt-4">
                                                        <p class="text-gray-300 text-sm mb-1">Điểm tích lũy hiện tại</p>
                                                        <div class="flex items-baseline gap-2">
                                                            <p
                                                                class="text-white text-5xl font-display font-bold tracking-tighter drop-shadow-md">
                                                                <c:out value="${customer.pointsBalance}" />
                                                            </p>
                                                            <span
                                                                class="text-xl font-bold text-amber-400 drop-shadow-sm">pts</span>
                                                        </div>
                                                    </div>

                                                    <div
                                                        class="mt-4 pt-4 border-t border-border-glass flex items-center justify-between">
                                                        <div class="flex flex-col">
                                                            <span
                                                                class="text-text-muted text-xs uppercase tracking-wider mb-1">Tổng
                                                                chi tiêu</span>
                                                            <span class="text-white font-bold">
                                                                <c:out value="${customer.totalSpend}" /> VND
                                                            </span>
                                                        </div>
                                                        <div class="w-px h-8 bg-border-glass"></div>
                                                        <div class="flex flex-col text-right">
                                                            <span
                                                                class="text-text-muted text-xs uppercase tracking-wider mb-1">Số
                                                                lần rửa</span>
                                                            <span class="text-white font-bold">
                                                                <c:out value="${customer.totalWashes}" /> lần
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <c:if test="${not empty nextTierName}">
                                                        <div
                                                            class="mt-4 pt-4 border-t border-border-glass flex flex-col items-center justify-center">
                                                            <span class="text-gray-300 text-xs mb-1">Chỉ còn <strong
                                                                    class="text-amber-400">
                                                                    <c:out value="${spendToNextTier}" /> đ
                                                                </strong> để lên hạng <strong class="text-white">
                                                                    <c:out value="${nextTierName}" />
                                                                </strong></span>
                                                            <div
                                                                class="w-full bg-bg-surface rounded-full h-1.5 mt-2 overflow-hidden border border-border-glass">
                                                                <div class="bg-amber-400 h-1.5 rounded-full relative"
                                                                    style="width: ${tierProgressPercent}%">
                                                                    <div
                                                                        class="absolute inset-0 bg-white/20 animate-pulse">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </section>

                                            <!-- Upcoming Appointments -->
                                            <section aria-labelledby="upcoming-appointments-title"
                                                class="flex flex-col gap-4 max-w-2xl">
                                                <div class="flex justify-between items-center">
                                                    <h2 id="upcoming-appointments-title"
                                                        class="text-white font-display font-semibold text-lg md:text-xl">
                                                        Lịch hẹn sắp tới</h2>
                                                    <a href="${pageContext.request.contextPath}/customer/booking_history"
                                                        class="text-[#00d4ff] text-sm font-semibold hover:text-white transition-colors">Xem
                                                        tất cả</a>
                                                </div>

                                                <div class="flex flex-col gap-4">
                                                    <c:choose>
                                                        <c:when test="${not empty upcomingBooking}">
                                                            <article class="glass-panel p-5 sm:p-6 rounded-2xl border-l-4 ${fn:toLowerCase(fn:trim(upcomingBooking.status)) == 'pending' ? 'border-l-amber-500' : 'border-l-[#00d4ff]'} shadow-lg hover:-translate-y-1 transition-transform relative overflow-hidden">
                                                                <div class="absolute -right-10 -top-10 w-32 h-32 ${fn:toLowerCase(fn:trim(upcomingBooking.status)) == 'pending' ? 'bg-amber-500/10' : 'bg-[#00d4ff]/10'} rounded-full blur-2xl">
                                                                </div>
                                                                <div class="flex flex-col sm:flex-row justify-between gap-4">
                                                                    <div class="space-y-3 flex-1">
                                                                        <div class="flex flex-wrap items-center gap-2">
                                                                            <span class="px-2.5 py-1 rounded ${fn:toLowerCase(fn:trim(upcomingBooking.status)) == 'pending' ? 'bg-amber-500/20 text-amber-500' : 'bg-[#00d4ff]/20 text-[#00d4ff]'} text-xs font-bold uppercase ${fn:toLowerCase(fn:trim(upcomingBooking.status)) == 'in progress' ? 'animate-pulse' : ''}">
                                                                                <c:out value="${upcomingBooking.status}" />
                                                                            </span>
                                                                            <span class="text-text-muted text-sm font-medium">Mã Đặt: #<c:out value="${upcomingBooking.bookingId}" /></span>

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
                                                                                <fmt:formatDate value="${upcomingBooking.bookingDate}" pattern="dd/MM/yyyy" />
                                                                            </div>
                                                                            <div class="flex items-center gap-2 text-gray-300">
                                                                                <i data-lucide="clock" class="w-4 h-4 text-text-muted"></i>
                                                                                <fmt:formatDate value="${upcomingBooking.scheduledTime}" pattern="HH:mm" />
                                                                            </div>
                                                                            <div class="flex items-center gap-2 text-gray-300 col-span-2">
                                                                                <i data-lucide="car" class="w-4 h-4 text-text-muted"></i>
                                                                                Biển số: <span class="font-semibold"><c:out value="${upcomingBooking.licensePlate}" /></span>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="flex flex-col items-start sm:items-end justify-between border-t sm:border-t-0 sm:border-l border-border-glass pt-4 sm:pt-0 sm:pl-6 mt-2 sm:mt-0 min-w-[140px]">
                                                                        <div class="text-xl font-display font-bold text-[#00d4ff]"><fmt:formatNumber value="${upcomingBooking.finalPrice}" pattern="#,###" /><span class="text-sm font-sans font-normal text-text-muted">VND</span></div>
                                                                        
                                                                        <!-- QR Code for Automated Check-in -->
                                                                        <div class="flex flex-col items-center justify-center mt-3 mb-2 p-2 bg-white rounded-lg shadow-[0_0_15px_rgba(255,255,255,0.2)]">
                                                                            <img src="https://api.qrserver.com/v1/create-qr-code/?size=80x80&data=${upcomingBooking.bookingId}" alt="QR Code" class="w-16 h-16" />
                                                                            <span class="text-[10px] text-gray-800 font-bold mt-1 uppercase">Quét tại trạm</span>
                                                                        </div>

                                                                        <div class="flex gap-2 mt-auto w-full justify-between sm:justify-end">
                                                                            <a href="${pageContext.request.contextPath}/customer/booking_history" class="flex-1 sm:flex-none px-3 py-2 rounded-lg bg-bg-surface hover:bg-bg-surface-hover text-white border border-border-glass text-sm font-semibold transition-colors text-center">
                                                                                Chi Tiết
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </article>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div
                                                                class="p-8 glass-panel rounded-2xl text-center flex flex-col items-center justify-center border-dashed border-2 border-border-glass">
                                                                <div
                                                                    class="w-16 h-16 bg-bg-surface rounded-full flex items-center justify-center mb-4">
                                                                    <i data-lucide="calendar-x"
                                                                        class="w-8 h-8 text-text-muted"></i>
                                                                </div>
                                                                <p class="text-text-muted mb-4">Bạn chưa có lịch hẹn nào
                                                                    sắp tới.</p>
                                                                <a href="${pageContext.request.contextPath}/bookings"
                                                                    class="px-6 py-2 bg-[#00d4ff] text-black font-bold rounded-lg hover:bg-white transition-colors">Đăng
                                                                    Ký Ngay</a>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </section>
                                </div>
                            </main>

                            <!-- Mobile Bottom Navigation (Chỉ hiện trên điện thoại) -->
                            <nav class="md:hidden fixed bottom-0 left-0 w-full glass-panel border-t border-border-glass z-50 px-2 py-2"
                                style="padding-bottom: env(safe-area-inset-bottom);"
                                aria-label="Điều hướng chính Mobile">
                                <div class="flex justify-around items-center h-14">
                                    <a href="${pageContext.request.contextPath}/account/dashboard"
                                        class="flex flex-col items-center gap-1 w-16 text-[#00d4ff]">
                                        <i data-lucide="layout-dashboard" class="w-6 h-6"></i>
                                        <span class="text-[10px] font-medium">Tổng quan</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/bookings"
                                        class="flex flex-col items-center gap-1 w-16 text-text-muted hover:text-white transition-colors">
                                        <i data-lucide="calendar-plus" class="w-6 h-6"></i>
                                        <span class="text-[10px] font-medium">Đặt lịch</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/customer/booking_history"
                                        class="flex flex-col items-center gap-1 w-16 text-text-muted hover:text-white transition-colors">
                                        <i data-lucide="history" class="w-6 h-6"></i>
                                        <span class="text-[10px] font-medium">Lịch sử</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/account/profile"
                                        class="flex flex-col items-center gap-1 w-16 text-text-muted hover:text-white transition-colors">
                                        <i data-lucide="user" class="w-6 h-6"></i>
                                        <span class="text-[10px] font-medium">Hồ sơ</span>
                                    </a>
                                </div>
                            </nav>

                        </div>
                        <script>
                            lucide.createIcons();
                        </script>
                        <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>

                    </html>