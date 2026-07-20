<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="activeMenu" value="${param.activeMenu}" />

<nav class="md:hidden fixed bottom-0 left-0 w-full glass-panel border-t border-border-glass z-50 px-0 py-2 overflow-x-auto no-scrollbar"
    style="padding-bottom: env(safe-area-inset-bottom);"
    aria-label="Điều hướng chính Mobile Admin">
    <div class="flex items-center justify-start gap-2 h-14 min-w-max px-4">
        <!-- Tổng quan -->
        <a href="${pageContext.request.contextPath}/admin/dashboard"
            class="flex flex-col items-center justify-center gap-1 w-[72px] px-1 ${activeMenu == 'dashboard' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="layout-dashboard" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium text-center leading-tight">Tổng quan</span>
        </a>
        
        <!-- Quét QR -->
        <a href="${pageContext.request.contextPath}/admin/scan" 
            class="flex flex-col items-center justify-center gap-1 w-[72px] px-1 ${activeMenu == 'scan' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="scan-line" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium text-center leading-tight">Quét QR</span>
        </a>
        
        <!-- Đặt lịch -->
        <a href="${pageContext.request.contextPath}/admin/bookings"
            class="flex flex-col items-center justify-center gap-1 w-[72px] px-1 ${activeMenu == 'bookings' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="calendar-check" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium text-center leading-tight">Đặt lịch</span>
        </a>
        
        <!-- Khách hàng -->
        <a href="${pageContext.request.contextPath}/admin/customers"
            class="flex flex-col items-center justify-center gap-1 w-[72px] px-1 ${activeMenu == 'customers' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="users" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium text-center leading-tight">Khách hàng</span>
        </a>
        
        <!-- Loyalty -->
        <a href="${pageContext.request.contextPath}/admin/loyalty" 
            class="flex flex-col items-center justify-center gap-1 w-[72px] px-1 ${activeMenu == 'loyalty' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="award" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium text-center leading-tight">Loyalty</span>
        </a>
        
        <!-- Dịch vụ -->
        <a href="${pageContext.request.contextPath}/admin/services" 
            class="flex flex-col items-center justify-center gap-1 w-[72px] px-1 ${activeMenu == 'services' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="list" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium text-center leading-tight">Dịch vụ</span>
        </a>

        <!-- Hệ thống -->
        <a href="${pageContext.request.contextPath}/admin/config" 
            class="flex flex-col items-center justify-center gap-1 w-[72px] px-1 ${activeMenu == 'config' ? 'text-[#00d4ff]' : 'text-text-muted hover:text-white transition-colors'}">
            <i data-lucide="settings" class="w-6 h-6"></i>
            <span class="text-[10px] font-medium text-center leading-tight">Hệ thống</span>
        </a>
    </div>
</nav>

<style>
/* Hide scrollbar for Chrome, Safari and Opera */
.no-scrollbar::-webkit-scrollbar {
  display: none;
}
/* Hide scrollbar for IE, Edge and Firefox */
.no-scrollbar {
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */
}
</style>
