<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="activeMenu" value="${param.activeMenu}" />

<nav class="md:hidden fixed bottom-0 left-0 w-full glass-panel border-t border-border-glass z-50 px-2 py-2"
    style="padding-bottom: env(safe-area-inset-bottom);"
    aria-label="Điều hướng chính Mobile">
    <div class="flex justify-around items-center h-14">
        <!-- Tổng quan -->
        <a href="${pageContext.request.contextPath}/account/dashboard"
            class="flex flex-col items-center gap-1 w-16 ${activeMenu == 'dashboard' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="layout-dashboard" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium">Tổng quan</span>
        </a>
        
        <!-- Đặt lịch -->
        <a href="${pageContext.request.contextPath}/bookings"
            class="flex flex-col items-center gap-1 w-16 ${activeMenu == 'bookings' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="calendar-plus" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium">Đặt lịch</span>
        </a>
        
        <!-- Lịch sử -->
        <a href="${pageContext.request.contextPath}/customer/booking_history"
            class="flex flex-col items-center gap-1 w-16 ${activeMenu == 'history' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="history" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium">Lịch sử</span>
        </a>
        
        <!-- Đổi quà -->
        <a href="${pageContext.request.contextPath}/customer/loyalty" 
            class="flex flex-col items-center gap-1 w-16 ${activeMenu == 'loyalty' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="award" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium">Đổi quà</span>
        </a>
        
        <!-- Hồ sơ -->
        <a href="${pageContext.request.contextPath}/account/profile"
            class="flex flex-col items-center gap-1 w-16 ${activeMenu == 'profile' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="user" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium">Hồ sơ</span>
        </a>
    </div>
</nav>
