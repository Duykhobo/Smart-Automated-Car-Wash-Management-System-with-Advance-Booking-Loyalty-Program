<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="activeMenu" value="${param.activeMenu}" />

<aside class="hidden md:flex flex-col w-64 glass-panel border-r border-border-glass fixed h-full z-10 left-0 top-0">
    <a href="${pageContext.request.contextPath}/account/dashboard" class="p-6 flex items-center gap-3 hover:opacity-80 transition-opacity">
        <i data-lucide="droplets" class="text-[#00d4ff] w-8 h-8"></i>
        <span class="text-xl font-display font-bold tracking-tight text-white">AUTOWASH<span class="text-[#00d4ff]">PRO</span></span>
    </a>
    
    <nav class="flex-1 px-4 py-4 space-y-2 mt-4">
        <!-- Tổng quan -->
        <a href="${pageContext.request.contextPath}/account/dashboard" class="flex items-center gap-3 px-4 py-3 rounded-xl transition-colors ${activeMenu == 'dashboard' ? 'bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/20 shadow-[0_0_10px_rgba(0,212,255,0.1)]' : 'text-text-muted hover:text-white hover:bg-bg-surface-hover'}">
            <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
            <span class="font-medium text-sm">Tổng quan</span>
        </a>
        
        <!-- Đặt lịch dịch vụ -->
        <a href="${pageContext.request.contextPath}/bookings" class="flex items-center gap-3 px-4 py-3 rounded-xl transition-colors ${activeMenu == 'bookings' ? 'bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/20 shadow-[0_0_10px_rgba(0,212,255,0.1)]' : 'text-text-muted hover:text-white hover:bg-bg-surface-hover'}">
            <i data-lucide="calendar-plus" class="w-5 h-5"></i>
            <span class="font-medium text-sm">Đặt lịch dịch vụ</span>
        </a>
        
        <!-- Lịch sử rửa xe -->
        <a href="${pageContext.request.contextPath}/customer/booking_history" class="flex items-center gap-3 px-4 py-3 rounded-xl transition-colors ${activeMenu == 'history' ? 'bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/20 shadow-[0_0_10px_rgba(0,212,255,0.1)]' : 'text-text-muted hover:text-white hover:bg-bg-surface-hover'}">
            <i data-lucide="history" class="w-5 h-5"></i>
            <span class="font-medium text-sm">Lịch sử rửa xe</span>
        </a>
        
        <!-- Quản lý xe -->
        <a href="${pageContext.request.contextPath}/vehicles" class="flex items-center gap-3 px-4 py-3 rounded-xl transition-colors ${activeMenu == 'vehicles' ? 'bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/20 shadow-[0_0_10px_rgba(0,212,255,0.1)]' : 'text-text-muted hover:text-white hover:bg-bg-surface-hover'}">
            <i data-lucide="car" class="w-5 h-5"></i>
            <span class="font-medium text-sm">Quản lý xe</span>
        </a>
        
        <!-- Cửa hàng đổi quà -->
        <a href="${pageContext.request.contextPath}/customer/loyalty" class="flex items-center gap-3 px-4 py-3 rounded-xl transition-colors ${activeMenu == 'loyalty' ? 'bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/20 shadow-[0_0_10px_rgba(0,212,255,0.1)]' : 'text-text-muted hover:text-white hover:bg-bg-surface-hover'}">
            <i data-lucide="award" class="w-5 h-5"></i>
            <span class="font-medium text-sm">Cửa hàng đổi quà</span>
        </a>

        <!-- Hồ sơ cá nhân -->
        <a href="${pageContext.request.contextPath}/account/profile" class="flex items-center gap-3 px-4 py-3 rounded-xl transition-colors ${activeMenu == 'profile' ? 'bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/20 shadow-[0_0_10px_rgba(0,212,255,0.1)]' : 'text-text-muted hover:text-white hover:bg-bg-surface-hover'}">
            <i data-lucide="user" class="w-5 h-5"></i>
            <span class="font-medium text-sm">Hồ sơ cá nhân</span>
        </a>
    </nav>
</aside>
