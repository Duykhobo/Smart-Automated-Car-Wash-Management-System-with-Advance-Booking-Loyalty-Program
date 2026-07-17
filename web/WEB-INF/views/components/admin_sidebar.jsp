<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    // Nhận param 'activeMenu' từ thẻ include để xử lý active state
    String activeMenu = request.getParameter("activeMenu");
    if (activeMenu == null) activeMenu = "dashboard";
%>

<!-- Sidebar (Left Menu) -->
<aside class="hidden md:flex w-64 glass-panel m-4 flex-col h-[calc(100vh-2rem)] sticky top-4 rounded-2xl bg-bg-surface border border-border-glass">
    <!-- Logo -->
    <div class="p-6 border-b border-border-glass flex items-center gap-3">
        <div class="w-10 h-10 rounded-full bg-gradient-to-tr from-[#00d4ff] to-blue-300 flex items-center justify-center shadow-[0_0_15px_rgba(0,212,255,0.4)]">
            <i data-lucide="droplets" class="text-black w-6 h-6"></i>
        </div>
        <div>
            <h1 class="text-xl font-display font-bold text-white tracking-wide">AUTOWASH<span class="text-[#00d4ff]">PRO</span></h1>
            <p class="text-xs text-text-muted">Admin Portal</p>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 p-4 space-y-2 overflow-y-auto">
        <a href="${pageContext.request.contextPath}/admin/dashboard" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all
           <%= "dashboard".equals(activeMenu) ? "bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30" : "text-text-muted hover:text-white hover:bg-white/5 border border-transparent" %>">
            <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
            <span class="font-medium">Tổng Quan</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/bookings" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all
           <%= "bookings".equals(activeMenu) ? "bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30" : "text-text-muted hover:text-white hover:bg-white/5 border border-transparent" %>">
            <i data-lucide="calendar-check" class="w-5 h-5"></i>
            <span class="font-medium">Quản lý Đặt Lịch</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/customers" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all
           <%= "customers".equals(activeMenu) ? "bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30" : "text-text-muted hover:text-white hover:bg-white/5 border border-transparent" %>">
            <i data-lucide="users" class="w-5 h-5"></i>
            <span class="font-medium">Khách Hàng</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/loyalty" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all
           <%= "loyalty".equals(activeMenu) ? "bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30" : "text-text-muted hover:text-white hover:bg-white/5 border border-transparent" %>">
            <i data-lucide="award" class="w-5 h-5"></i>
            <span class="font-medium">Loyalty & Voucher</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/services" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all
           <%= "services".equals(activeMenu) ? "bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30" : "text-text-muted hover:text-white hover:bg-white/5 border border-transparent" %>">
            <i data-lucide="list" class="w-5 h-5"></i>
            <span class="font-medium">Dịch Vụ</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/scan" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all
           <%= "scan".equals(activeMenu) ? "bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30" : "text-text-muted hover:text-white hover:bg-white/5 border border-transparent" %>">
            <i data-lucide="scan-line" class="w-5 h-5"></i>
            <span class="font-medium">Quét Mã QR</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/config" 
           class="flex items-center gap-3 px-4 py-3 rounded-xl transition-all
           <%= "config".equals(activeMenu) ? "bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30" : "text-text-muted hover:text-white hover:bg-white/5 border border-transparent" %>">
            <i data-lucide="settings" class="w-5 h-5"></i>
            <span class="font-medium">Hệ Thống</span>
        </a>
    </nav>

    <!-- User Profile -->
    <div class="p-4 border-t border-border-glass">
        <div class="flex items-center gap-3 px-4 py-2">
            <div class="w-10 h-10 rounded-full border border-border-glass bg-bg-surface-hover flex items-center justify-center">
                <i data-lucide="shield-check" class="w-5 h-5 text-success"></i>
            </div>
            <div>
                <p class="text-sm font-medium text-white">Quản Trị Viên</p>
                <a href="${pageContext.request.contextPath}/auth/logout" class="text-xs text-error hover:text-red-400">Đăng xuất</a>
            </div>
        </div>
    </div>
</aside>
