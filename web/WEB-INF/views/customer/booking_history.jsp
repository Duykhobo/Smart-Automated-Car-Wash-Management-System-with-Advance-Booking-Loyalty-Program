<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <title>Auto Wash Pro - Lịch Sử Rửa Xe</title>
                    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
                    <style>
                        /* Glassmorphism Toast */
                    </style>

                </head>

                <body
                    class="m-0 min-h-screen bg-bg-primary text-white font-sans antialiased w-full overflow-x-hidden relative">

                    <!-- Modals injected at bottom -->

                    <!-- Global toast included at bottom -->

                    <!-- Desktop Sidebar -->
                    <jsp:include page="/WEB-INF/views/components/customer_sidebar.jsp">
    <jsp:param name="activeMenu" value="history" />
</jsp:include>

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
                                <h1 class="text-lg md:text-2xl font-display font-bold truncate text-white">Lịch Sử Hoạt
                                    Động
                                </h1>
                            </div>

                            <div class="hidden sm:flex flex-col items-end">
                                <span class="text-xs text-text-muted">Tổng số lượt rửa</span>
                                <span class="text-lg font-bold text-[#00d4ff]">
                                    <c:out value="${customer.totalWashes}" />
                                </span>
                            </div>
                        </header>

                        <div class="px-4 md:px-8 py-8 max-w-4xl mx-auto space-y-6">

                            <!-- Tabs & Actions -->
                            <div
                                class="flex flex-col sm:flex-row sm:items-center justify-between border-b border-border-glass gap-4 pb-2 sm:pb-0">
                                <div class="flex">
                                    <button id="btn-tab-upcoming" onclick="switchTab('tab-upcoming')"
                                        class="tab-btn px-6 py-4 font-display font-semibold text-white border-b-2 border-[#00d4ff] transition-colors flex items-center gap-2">
                                        Lịch Sắp Tới
                                        <!-- Badge for upcoming count -->
                                        <c:if test="${not empty upcomingBookings and fn:length(upcomingBookings) > 0}">
                                            <span
                                                class="w-5 h-5 rounded-full bg-[#00d4ff] text-black text-xs flex items-center justify-center">${fn:length(upcomingBookings)}</span>
                                        </c:if>
                                    </button>
                                    <button id="btn-tab-history" onclick="switchTab('tab-history')"
                                        class="tab-btn px-6 py-4 font-display font-semibold text-text-muted border-b-2 border-transparent hover:text-gray-300 transition-colors">
                                        Lịch Sử
                                    </button>
                                </div>
                            </div>

                            <!-- Tab 1: Upcoming Bookings -->
                            <div id="tab-upcoming" class="tab-content space-y-4">

                                <c:choose>
                                    <c:when test="${not empty upcomingBookings}">
                                        <c:forEach var="booking" items="${upcomingBookings}">
                                            <!-- Upcoming Card -->
                                            <article
                                                class="glass-panel p-5 sm:p-6 rounded-2xl border-l-4 ${fn:toLowerCase(fn:trim(booking.status)) == 'pending' ? 'border-l-amber-500' : 'border-l-[#00d4ff]'} shadow-lg hover:-translate-y-1 transition-transform relative overflow-hidden">
                                                <div
                                                    class="absolute -right-10 -top-10 w-32 h-32 ${fn:toLowerCase(fn:trim(booking.status)) == 'pending' ? 'bg-amber-500/10' : 'bg-[#00d4ff]/10'} rounded-full blur-2xl">
                                                </div>
                                                <div class="flex flex-col sm:flex-row justify-between gap-4">
                                                    <div class="space-y-3 flex-1">
                                                        <div class="flex flex-wrap items-center gap-2">
                                                            <span
                                                                class="px-2.5 py-1 rounded ${fn:toLowerCase(fn:trim(booking.status)) == 'pending' ? 'bg-amber-500/20 text-amber-500' : 'bg-[#00d4ff]/20 text-[#00d4ff]'} text-xs font-bold uppercase ${fn:toLowerCase(fn:trim(booking.status)) == 'in progress' || fn:toLowerCase(fn:trim(booking.status)) == 'inprogress' ? 'animate-pulse' : ''}">
                                                                <c:out value="${booking.status}" />
                                                            </span>
                                                            <span class="text-text-muted text-sm font-medium">Mã Đặt: #
                                                                <c:out value="BOOKINGID-${booking.bookingId}" />
                                                            </span>

                                                            <c:if test="${customer.tierStatus != 'Member'}">
                                                                <div
                                                                    class="px-3 py-1 rounded-full bg-gradient-to-r from-amber-500/20 to-yellow-300/10 border border-amber-500/30 text-amber-400 text-xs font-bold uppercase tracking-wide flex items-center gap-1.5 shadow-[0_0_10px_rgba(245,158,11,0.2)]">
                                                                    <i data-lucide="sparkles" class="w-3.5 h-3.5"></i>
                                                                    ✨ Đặc quyền
                                                                    <c:out value="${customer.tierStatus}" />
                                                                </div>
                                                            </c:if>
                                                        </div>

                                                        <h3 class="font-display font-bold text-xl text-white">Lịch Chăm
                                                            Sóc Xe
                                                        </h3>

                                                        <div class="grid grid-cols-2 gap-x-8 gap-y-2 text-sm mt-2">
                                                            <div class="flex items-center gap-2 text-gray-300">
                                                                <i data-lucide="calendar"
                                                                    class="w-4 h-4 text-text-muted"></i>
                                                                <fmt:formatDate value="${booking.bookingDate}"
                                                                    pattern="dd/MM/yyyy" />
                                                            </div>
                                                            <div class="flex items-center gap-2 text-gray-300">
                                                                <i data-lucide="clock"
                                                                    class="w-4 h-4 text-text-muted"></i>
                                                                <fmt:formatDate value="${booking.scheduledTime}"
                                                                    pattern="HH:mm" />
                                                            </div>
                                                            <div
                                                                class="flex items-center gap-2 text-gray-300 col-span-2">
                                                                <i data-lucide="car"
                                                                    class="w-4 h-4 text-text-muted"></i>
                                                                Biển số: <span class="font-semibold">
                                                                    <c:out value="${booking.licensePlate}" />
                                                                </span>
                                                            </div>
                                                            <div class="flex items-center gap-2 text-gray-300 col-span-2 mt-1 pt-2 border-t border-border-glass">
                                                                <i data-lucide="edit-3" class="w-3.5 h-3.5 text-text-muted"></i>
                                                                <span class="text-xs text-text-muted">Đặt lúc:</span> 
                                                                <span class="text-xs">
                                                                    <fmt:formatDate value="${booking.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                                </span>
                                                            </div>
                                                            <c:if test="${not empty booking.actualStartTime}">
                                                                <div class="flex items-center gap-2 text-[#00d4ff] col-span-2">
                                                                    <i data-lucide="log-in" class="w-3.5 h-3.5"></i>
                                                                    <span class="text-xs">Check-in:</span> 
                                                                    <span class="text-xs font-semibold">
                                                                        <fmt:formatDate value="${booking.actualStartTime}" pattern="dd/MM/yyyy HH:mm" />
                                                                    </span>
                                                                </div>
                                                            </c:if>
                                                        </div>

                                                        
                                                    </div>

                                                    <div
                                                        class="flex flex-col items-start sm:items-end justify-center gap-4 h-full border-t sm:border-t-0 sm:border-l border-border-glass pt-4 sm:pt-0 sm:pl-6 mt-2 sm:mt-0 min-w-[140px]">
                                                        <div class="text-xl font-display font-bold text-[#00d4ff]">
                                                            <fmt:formatNumber value="${booking.finalPrice}"
                                                                pattern="#,###" /><span
                                                                class="text-sm font-sans font-normal text-text-muted">VND</span>
                                                        </div>

                                                        <c:if test="${booking.status == 'Pending' || booking.status == 'Waitlisted'}">
                                                            <!-- Client-side QR Code Gen -->
                                                            <div onclick="openQrModal('BK-${booking.bookingId}')" class="flex flex-col items-center justify-center mt-3 mb-2 p-3 bg-white rounded-xl shadow-[0_0_20px_rgba(0,212,255,0.15)] border border-[#00d4ff]/30 relative overflow-hidden group cursor-pointer hover:scale-105 transition-transform duration-300" title="Nhấn để phóng to">
                                                                <div class="absolute inset-0 bg-gradient-to-tr from-[#00d4ff]/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
                                                                <div class="qr-container w-20 h-20" data-code="BK-${booking.bookingId}"></div>
                                                                <span class="text-[10px] text-[#0891b2] font-bold mt-2 uppercase tracking-wider bg-[#00d4ff]/10 px-3 py-1 rounded-full border border-[#00d4ff]/20">Quét tại quầy</span>
                                                            </div>
                                                        </c:if>

                                                        <div
                                                            class="flex gap-2 mt-auto w-full justify-between sm:justify-end">
                                                            <c:if
                                                                test="${booking.status == 'Pending' || booking.status == 'Waitlisted'}">
                                                                <a href="${pageContext.request.contextPath}/customer/booking_history?action=edit&id=${booking.bookingId}"
                                                                    class="flex-1 sm:flex-none px-3 py-2 rounded-lg bg-bg-surface hover:bg-[#00d4ff]/20 text-[#00d4ff] border border-[#00d4ff]/30 text-sm font-semibold transition-colors text-center">
                                                                    Sửa
                                                                </a>
                                                                <form
                                                                    action="${pageContext.request.contextPath}/BookingHistoryController"
                                                                    method="POST" class="flex-1 sm:flex-none m-0 p-0"
                                                                    id="cancelForm_${booking.bookingId}" data-auto-validate="true">
                                                                    <input type="hidden" name="action" value="cancel" />
                                                                    <input type="hidden" name="bookingId"
                                                                        value="${booking.bookingId}" />
                                                                    <button type="button"
                                                                        onclick="showGlobalConfirmModal('Hủy lịch hẹn', 'Bạn có chắc chắn muốn hủy lịch hẹn này không? Hành động này không thể hoàn tác và số suất sẽ được nhường cho người khác.', 'Xác nhận Hủy', function() { document.getElementById('cancelForm_${booking.bookingId}').submit(); })"
                                                                        class="w-full px-3 py-2 rounded-lg bg-bg-surface hover:bg-red-500/20 text-red-400 border border-red-500/30 text-sm font-semibold transition-colors text-center">
                                                                        Hủy Lịch
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            <!-- Live Tracking Stepper -->
                                                        <div class="mt-6 pt-5 border-t border-border-glass">
                                                            <div class="flex items-center justify-between relative">
                                                                <!-- Progress Line Background -->
                                                                <div class="absolute left-0 top-4 w-full h-1 bg-white/10 rounded-full z-0"></div>
                                                                
                                                                <c:set var="status" value="${fn:toLowerCase(fn:trim(booking.status))}" />
                                                                <c:set var="step1" value="${status == 'pending' || status == 'confirmed' || status == 'in progress' || status == 'inprogress' || status == 'completed' ? 'active' : ''}" />
                                                                <c:set var="step2" value="${status == 'confirmed' || status == 'in progress' || status == 'inprogress' || status == 'completed' ? 'active' : ''}" />
                                                                <c:set var="step3" value="${status == 'in progress' || status == 'inprogress' || status == 'completed' ? 'active' : ''}" />
                                                                <c:set var="step4" value="${status == 'completed' ? 'active' : ''}" />

                                                                <!-- Line fill -->
                                                                <c:set var="lineWidth" value="0%" />
                                                                <c:if test="${step2 == 'active'}"><c:set var="lineWidth" value="33%" /></c:if>
                                                                <c:if test="${step3 == 'active'}"><c:set var="lineWidth" value="66%" /></c:if>
                                                                <c:if test="${step4 == 'active'}"><c:set var="lineWidth" value="100%" /></c:if>
                                                                
                                                                <div class="absolute left-0 top-4 h-1 bg-[#00d4ff] rounded-full z-0 transition-all duration-1000 shadow-[0_0_10px_rgba(0,212,255,0.5)]" style="width: ${lineWidth}"></div>

                                                                <!-- Steps -->
                                                                <div class="relative z-10 flex flex-col items-center gap-2">
                                                                    <div class="w-8 h-8 rounded-full ${step1 == 'active' ? 'bg-[#00d4ff] text-black shadow-[0_0_15px_rgba(0,212,255,0.4)]' : 'bg-slate-800 text-slate-500 border border-slate-600'} flex items-center justify-center font-bold text-sm transition-colors"><i data-lucide="check-circle-2" class="w-4 h-4"></i></div>
                                                                    <span class="text-[10px] uppercase font-bold tracking-wider ${step1 == 'active' ? 'text-[#00d4ff]' : 'text-slate-500'}">Chờ duyệt</span>
                                                                </div>
                                                                <div class="relative z-10 flex flex-col items-center gap-2">
                                                                    <div class="w-8 h-8 rounded-full ${step2 == 'active' ? 'bg-[#00d4ff] text-black shadow-[0_0_15px_rgba(0,212,255,0.4)]' : 'bg-slate-800 text-slate-500 border border-slate-600'} flex items-center justify-center font-bold text-sm transition-colors"><i data-lucide="map-pin" class="w-4 h-4"></i></div>
                                                                    <span class="text-[10px] uppercase font-bold tracking-wider ${step2 == 'active' ? 'text-[#00d4ff]' : 'text-slate-500'}">Tới trạm</span>
                                                                </div>
                                                                <div class="relative z-10 flex flex-col items-center gap-2">
                                                                    <div class="w-8 h-8 rounded-full ${step3 == 'active' ? 'bg-[#00d4ff] text-black shadow-[0_0_15px_rgba(0,212,255,0.4)]' : 'bg-slate-800 text-slate-500 border border-slate-600'} flex items-center justify-center font-bold text-sm transition-colors ${status == 'in progress' || status == 'inprogress' ? 'animate-pulse' : ''}"><i data-lucide="spray-can" class="w-4 h-4"></i></div>
                                                                    <span class="text-[10px] uppercase font-bold tracking-wider ${step3 == 'active' ? 'text-[#00d4ff]' : 'text-slate-500'}">Đang rửa</span>
                                                                </div>
                                                                <div class="relative z-10 flex flex-col items-center gap-2">
                                                                    <div class="w-8 h-8 rounded-full ${step4 == 'active' ? 'bg-[#00d4ff] text-black shadow-[0_0_15px_rgba(0,212,255,0.4)]' : 'bg-slate-800 text-slate-500 border border-slate-600'} flex items-center justify-center font-bold text-sm transition-colors"><i data-lucide="star" class="w-4 h-4"></i></div>
                                                                    <span class="text-[10px] uppercase font-bold tracking-wider ${step4 == 'active' ? 'text-[#00d4ff]' : 'text-slate-500'}">Xong</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                            </article>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div
                                            class="p-8 glass-panel rounded-2xl text-center flex flex-col items-center justify-center border-dashed border-2 border-border-glass">
                                            <div
                                                class="w-16 h-16 bg-bg-surface rounded-full flex items-center justify-center mb-4">
                                                <i data-lucide="calendar-x" class="w-8 h-8 text-text-muted"></i>
                                            </div>
                                            <p class="text-text-muted mb-4">Bạn chưa có lịch hẹn nào sắp tới.</p>
                                            <a href="${pageContext.request.contextPath}/bookings"
                                                class="px-6 py-2 bg-[#00d4ff] text-black font-bold rounded-lg hover:bg-white transition-colors">Đăng
                                                Ký Ngay</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                            </div>

                            <!-- Tab 2: Past Wash History -->
                            <div id="tab-history" class="tab-content hidden space-y-4">

                                <c:choose>
                                    <c:when test="${not empty historyBookings}">
                                        <c:forEach var="booking" items="${historyBookings}">
                                            <article
                                                class="glass-panel p-5 rounded-2xl flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 ${booking.status == 'Cancelled' || booking.status == 'No Show' ? 'opacity-70' : ''}">
                                                <div class="flex items-start gap-4 w-full">
                                                    <c:set var="iconColor" value="text-amber-500" />
                                                    <c:set var="iconBg" value="bg-amber-500/10 border-amber-500/30" />
                                                    <c:set var="iconName" value="clock" />

                                                    <c:if test="${booking.status == 'Completed'}">
                                                        <c:set var="iconColor" value="text-success" />
                                                        <c:set var="iconBg" value="bg-success/10 border-success/30" />
                                                        <c:set var="iconName" value="check-circle" />
                                                    </c:if>
                                                    <c:if
                                                        test="${booking.status == 'Cancelled' || booking.status == 'No Show'}">
                                                        <c:set var="iconColor" value="text-red-500" />
                                                        <c:set var="iconBg" value="bg-red-500/10 border-red-500/30" />
                                                        <c:set var="iconName" value="x-circle" />
                                                    </c:if>
                                                    <c:if test="${booking.status == 'InProgress'}">
                                                        <c:set var="iconColor" value="text-[#00d4ff]" />
                                                        <c:set var="iconBg"
                                                            value="bg-[#00d4ff]/10 border-[#00d4ff]/30" />
                                                        <c:set var="iconName" value="settings" />
                                                    </c:if>

                                                    <div
                                                        class="w-12 h-12 rounded-full ${iconBg} flex items-center justify-center shrink-0 border">
                                                        <i data-lucide="${iconName}" class="w-6 h-6 ${iconColor}"></i>
                                                    </div>
                                                    <div class="flex-1">
                                                        <div class="flex items-center justify-between">
                                                            <h3 class="font-display font-bold text-lg text-white">Dịch
                                                                Vụ Rửa Xe</h3>
                                                            <jsp:include page="../components/status_badge.jsp">
                                                                <jsp:param name="status" value="${booking.status}" />
                                                            </jsp:include>
                                                        </div>
                                                        <div
                                                            class="text-sm text-text-muted mt-1 flex flex-wrap gap-x-4 gap-y-1">
                                                            <span><i data-lucide="calendar"
                                                                    class="w-3.5 h-3.5 inline"></i>
                                                                <fmt:formatDate value="${booking.bookingDate}"
                                                                    pattern="dd/MM/yyyy" />
                                                            </span>
                                                            <span><i data-lucide="car" class="w-3.5 h-3.5 inline"></i>
                                                                <c:out value="${booking.licensePlate}" />
                                                            </span>
                                                        </div>
                                                        <div class="text-xs text-text-muted mt-3 pt-2 border-t border-border-glass flex flex-col gap-1.5 w-full">
                                                            <div class="flex items-center gap-2">
                                                                <i data-lucide="edit-3" class="w-3.5 h-3.5"></i>
                                                                <span class="w-16">Đặt lúc:</span>
                                                                <span><fmt:formatDate value="${booking.createdAt}" pattern="dd/MM/yyyy HH:mm" /></span>
                                                            </div>
                                                            <c:if test="${not empty booking.actualStartTime}">
                                                                <div class="flex items-center gap-2 text-blue-400">
                                                                    <i data-lucide="log-in" class="w-3.5 h-3.5"></i>
                                                                    <span class="w-16 text-text-muted">Check-in:</span>
                                                                    <span><fmt:formatDate value="${booking.actualStartTime}" pattern="dd/MM/yyyy HH:mm" /></span>
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${not empty booking.actualEndTime}">
                                                                <div class="flex items-center gap-2 text-success">
                                                                    <i data-lucide="check-circle-2" class="w-3.5 h-3.5"></i>
                                                                    <span class="w-16 text-text-muted">Xong lúc:</span>
                                                                    <span><fmt:formatDate value="${booking.actualEndTime}" pattern="dd/MM/yyyy HH:mm" /></span>
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${booking.status == 'Cancelled' and not empty booking.updatedAt}">
                                                                <div class="flex items-center gap-2 text-red-400">
                                                                    <i data-lucide="x-circle" class="w-3.5 h-3.5"></i>
                                                                    <span class="w-16 text-text-muted">Hủy lúc:</span>
                                                                    <span><fmt:formatDate value="${booking.updatedAt}" pattern="dd/MM/yyyy HH:mm" /></span>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div
                                                    class="text-right w-full sm:w-auto border-t sm:border-none border-border-glass pt-3 sm:pt-0 flex flex-col items-end gap-2 min-w-[140px]">
                                                    <div class="font-bold text-lg text-[#00d4ff]">
                                                        <fmt:formatNumber value="${booking.finalPrice}"
                                                            pattern="#,###" /><span
                                                            class="text-sm font-sans font-normal text-text-muted">đ</span>
                                                    </div>
                                                    <div class="flex items-center gap-2">
                                                        <c:if test="${booking.status == 'Completed'}">
                                                            <button
                                                                class="text-text-muted text-sm hover:text-white transition-colors">Đánh
                                                                giá</button>
                                                        </c:if>
                                                        <a href="${pageContext.request.contextPath}/bookings?vehicleId=${booking.vehicleId}&services=${booking.serviceIdsStr}"
                                                            class="px-4 py-2 rounded-lg bg-[#00d4ff]/10 hover:bg-[#00d4ff] text-[#00d4ff] hover:text-black text-sm font-semibold transition-colors border border-[#00d4ff]/30 flex items-center gap-1.5">
                                                            <i data-lucide="rotate-cw" class="w-4 h-4"></i> Đặt lại
                                                        </a>
                                                    </div>
                                                </div>
                                            </article>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div
                                            class="p-8 glass-panel rounded-2xl text-center flex flex-col items-center justify-center border-dashed border-2 border-border-glass">
                                            <div
                                                class="w-16 h-16 bg-bg-surface rounded-full flex items-center justify-center mb-4">
                                                <i data-lucide="history" class="w-8 h-8 text-text-muted"></i>
                                            </div>
                                            <p class="text-text-muted">Bạn chưa có lịch sử đặt lịch nào.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <c:if test="${totalPages > 1}">
                                    <div class="flex justify-center items-center gap-2 mt-8">
                                        <!-- Previous Page -->
                                        <c:if test="${currentPage > 1}">
                                            <a href="?page=${currentPage - 1}" class="p-2 glass-panel rounded-lg text-text-muted hover:text-[#00d4ff] hover:border-[#00d4ff]/30 transition-all flex items-center justify-center">
                                                <i data-lucide="chevron-left" class="w-5 h-5"></i>
                                            </a>
                                        </c:if>
                                        
                                        <!-- Page Numbers -->
                                        <div class="flex gap-2">
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <a href="?page=${i}" class="w-10 h-10 flex items-center justify-center rounded-lg transition-all ${currentPage == i ? 'bg-[#00d4ff]/20 text-[#00d4ff] border border-[#00d4ff]/30 font-bold shadow-[0_0_10px_rgba(0,212,255,0.2)]' : 'glass-panel text-text-muted hover:text-white hover:border-white/20'}">
                                                    ${i}
                                                </a>
                                            </c:forEach>
                                        </div>

                                        <!-- Next Page -->
                                        <c:if test="${currentPage < totalPages}">
                                            <a href="?page=${currentPage + 1}" class="p-2 glass-panel rounded-lg text-text-muted hover:text-[#00d4ff] hover:border-[#00d4ff]/30 transition-all flex items-center justify-center">
                                                <i data-lucide="chevron-right" class="w-5 h-5"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </c:if>

                            </div>

                        </div>
                    </main>

    <jsp:include page="/WEB-INF/views/components/customer_bottom_nav.jsp">
    <jsp:param name="activeMenu" value="history" />
</jsp:include>


                    <!-- QR Code Zoom Modal -->
                    <div id="qrModal" class="fixed inset-0 z-[100] hidden items-center justify-center bg-black/80 backdrop-blur-sm opacity-0 transition-opacity duration-300" onclick="closeQrModal()">
                        <div class="bg-white p-8 rounded-2xl shadow-[0_0_30px_rgba(0,212,255,0.3)] border border-[#00d4ff]/30 scale-95 transition-transform duration-300" id="qrModalContent" onclick="event.stopPropagation()">
                            <h3 class="text-xl font-bold text-center text-slate-800 mb-6">Mã QR Check-in</h3>
                            <div id="qrModalCanvas" class="flex justify-center mb-6 min-w-[250px] min-h-[250px] bg-white p-2 rounded-xl"></div>
                            <div class="text-center text-sm text-slate-500 mb-4 font-mono font-bold tracking-wider" id="qrModalId"></div>
                            <button onclick="closeQrModal()" class="w-full py-3 bg-gradient-to-r from-cyan-400 to-[#00d4ff] text-black font-bold rounded-xl hover:from-cyan-300 hover:to-cyan-400 transition-all shadow-[0_0_15px_rgba(0,212,255,0.4)]">Đóng lại</button>
                        </div>
                    </div>

                    <script>
                        function openQrModal(code) {
                            const modal = document.getElementById('qrModal');
                            const modalContent = document.getElementById('qrModalContent');
                            const qrCanvas = document.getElementById('qrModalCanvas');
                            const idLabel = document.getElementById('qrModalId');
                            
                            qrCanvas.innerHTML = '';
                            idLabel.innerText = code;
                            
                            new QRCode(qrCanvas, {
                                text: code,
                                width: 250,
                                height: 250,
                                colorDark : "#0f172a",
                                colorLight : "#ffffff",
                                correctLevel : QRCode.CorrectLevel.H
                            });
                            
                            modal.classList.remove('hidden');
                            modal.classList.add('flex');
                            
                            // Trigger reflow for animation
                            void modal.offsetWidth;
                            
                            modal.classList.remove('opacity-0');
                            modalContent.classList.remove('scale-95');
                            modalContent.classList.add('scale-100');
                        }
                        
                        function closeQrModal() {
                            const modal = document.getElementById('qrModal');
                            const modalContent = document.getElementById('qrModalContent');
                            
                            modal.classList.add('opacity-0');
                            modalContent.classList.remove('scale-100');
                            modalContent.classList.add('scale-95');
                            
                            setTimeout(() => {
                                modal.classList.remove('flex');
                                modal.classList.add('hidden');
                            }, 300);
                        }
                    </script>

                    <!-- QRCode.js Library -->
                    <script charset="UTF-8" src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js?v=2"></script>
                    <!-- Tách file JS riêng -->
                    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/customer_booking_history.js?v=2"></script>

                                                    <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
                    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
                </body>

                </html>