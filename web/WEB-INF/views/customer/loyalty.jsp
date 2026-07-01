<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Loyalty Program - Auto Wash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
    
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
            <a href="${pageContext.request.contextPath}/bookings" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
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
            <a href="${pageContext.request.contextPath}/customer/loyalty" class="flex items-center gap-3 px-4 py-3 bg-[#00d4ff]/10 text-[#00d4ff] rounded-xl border border-[#00d4ff]/20 transition-colors shadow-[0_0_10px_rgba(0,212,255,0.1)]">
                <i data-lucide="award" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Loyalty Program</span>
            </a>
            <a href="${pageContext.request.contextPath}/account/profile" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="user" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Hồ sơ cá nhân</span>
            </a>
        </nav>
    </aside>

    <main class="flex-1 md:ml-64 relative min-h-screen pb-[120px] md:pb-32 bg-bg-primary">
        <header class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center justify-between gap-3">
            <div class="flex items-center gap-3">
                <button onclick="history.back()" class="w-10 h-10 shrink-0 flex items-center justify-center hover:bg-bg-surface-hover rounded-full transition-colors text-white" aria-label="Quay lại">
                    <i data-lucide="arrow-left" class="w-5 h-5"></i>
                </button>
                <h1 class="text-lg md:text-2xl font-display font-bold truncate text-white">Loyalty Program</h1>
            </div>
            
            <c:set var="badgeClass" value="badge-member" />
            <c:set var="badgeIcon" value="star" />
            <c:set var="tierLabel" value="MEMBER" />
            <c:if test="${not empty customer}">
                <c:set var="tierStatusUpper" value="${customer.tierStatus.toUpperCase()}" />
                <c:if test="${tierStatusUpper == 'SILVER'}">
                    <c:set var="badgeClass" value="badge-silver" />
                    <c:set var="tierLabel" value="SILVER" />
                </c:if>
                <c:if test="${tierStatusUpper == 'GOLD'}">
                    <c:set var="badgeClass" value="badge-gold" />
                    <c:set var="tierLabel" value="GOLD" />
                </c:if>
                <c:if test="${tierStatusUpper == 'PLATINUM'}">
                    <c:set var="badgeClass" value="badge-platinum" />
                    <c:set var="tierLabel" value="PLATINUM" />
                    <c:set var="badgeIcon" value="crown" />
                </c:if>
            </c:if>
            
            <div class="hidden sm:flex items-center gap-2 px-3 py-1.5 rounded-full ${badgeClass}">
                <i data-lucide="${badgeIcon}" class="w-4 h-4"></i>
                <span class="text-xs font-bold tracking-wide">${tierLabel} TIER</span>
            </div>
        </header>

        <div class="px-4 md:px-8 py-8 max-w-4xl mx-auto space-y-8">
            
            <!-- Hero Card: Current Tier & Points -->
            <div class="relative overflow-hidden rounded-3xl p-6 md:p-10 border border-amber-500/30 bg-gradient-to-br from-amber-900/40 via-bg-surface to-bg-primary shadow-[0_0_40px_rgba(245,158,11,0.1)] group">
                <div class="absolute top-0 right-0 -mr-16 -mt-16 w-64 h-64 bg-amber-500/10 rounded-full blur-3xl group-hover:bg-amber-500/20 transition-all duration-700"></div>
                
                <div class="relative z-10 flex flex-col md:flex-row md:items-end justify-between gap-6">
                    <div class="space-y-4">
                        <div class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full ${badgeClass} backdrop-blur-md">
                            <i data-lucide="${badgeIcon}" class="w-4 h-4"></i>
                            <span class="text-xs font-bold tracking-wide uppercase">${tierLabel} TIER</span>
                        </div>
                        <div>
                            <h2 class="text-4xl md:text-6xl font-display font-bold text-white mb-2">
                                <fmt:formatNumber value="${not empty customer ? customer.pointsBalance : 0}" type="number" maxFractionDigits="0" /> 
                                <span class="text-xl md:text-2xl text-amber-500 font-medium">AWP</span>
                            </h2>
                            <p class="text-text-muted text-sm md:text-base">Auto Wash Points hiện có</p>
                        </div>
                    </div>
                    
                    <div class="w-full md:w-1/2 space-y-3">
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-300 font-medium">Tiến trình lên hạng <span class="text-[#00d4ff] font-bold">${not empty nextTier ? nextTier : 'PLATINUM'}</span></span>
                            <span class="text-white font-bold"><fmt:formatNumber value="${not empty customer ? customer.totalSpend : 0}" type="number" maxFractionDigits="0"/> đ / <fmt:formatNumber value="${not empty targetSpend ? targetSpend : 5000000}" type="number" maxFractionDigits="0"/> đ</span>
                        </div>
                        <div class="h-3 w-full bg-black/50 rounded-full overflow-hidden border border-border-glass">
                            <div class="h-full bg-gradient-to-r from-amber-500 to-[#00d4ff] rounded-full shadow-[0_0_10px_rgba(0,212,255,0.5)] relative" style="width: ${not empty progressPercent ? progressPercent : 49}%">
                                <div class="absolute inset-0 bg-white/20 w-full h-full animate-[shimmer_2s_infinite]"></div>
                            </div>
                            <style>
                                @keyframes shimmer {
                                    0% { transform: translateX(-100%); }
                                    100% { transform: translateX(100%); }
                                }
                            </style>
                        </div>
                        <p class="text-xs text-text-muted text-right">
                            <c:choose>
                                <c:when test="${not empty nextTier and nextTier == 'MAX'}">
                                    Bạn đã đạt cấp độ cao nhất!
                                </c:when>
                                <c:otherwise>
                                    Còn <fmt:formatNumber value="${not empty spendNeeded ? spendNeeded : 2550000}" type="number" maxFractionDigits="0"/> đ nữa để thăng hạng
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Perks Summary -->
            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                <div class="glass-panel p-5 rounded-2xl border-t-2 border-t-[#00d4ff]/50 hover:-translate-y-1 transition-transform cursor-default">
                    <div class="w-10 h-10 rounded-full bg-[#00d4ff]/10 flex items-center justify-center mb-3">
                        <i data-lucide="zap" class="w-5 h-5 text-[#00d4ff]"></i>
                    </div>
                    <h3 class="font-bold text-white mb-1">Slot Ưu Tiên</h3>
                    <p class="text-sm text-text-muted">Được xếp vào luồng rửa xe nhanh không cần chờ đợi.</p>
                </div>
                <div class="glass-panel p-5 rounded-2xl border-t-2 border-t-amber-500/50 hover:-translate-y-1 transition-transform cursor-default">
                    <div class="w-10 h-10 rounded-full bg-amber-500/10 flex items-center justify-center mb-3">
                        <i data-lucide="calendar" class="w-5 h-5 text-amber-500"></i>
                    </div>
                    <h3 class="font-bold text-white mb-1">Đặt lịch xa hơn</h3>
                    <p class="text-sm text-text-muted">Đặt trước tối đa 12 ngày so với 7 ngày của thẻ thông thường.</p>
                </div>
                <div class="glass-panel p-5 rounded-2xl border-t-2 border-t-purple-500/50 hover:-translate-y-1 transition-transform cursor-default">
                    <div class="w-10 h-10 rounded-full bg-purple-500/10 flex items-center justify-center mb-3">
                        <i data-lucide="gift" class="w-5 h-5 text-purple-400"></i>
                    </div>
                    <h3 class="font-bold text-white mb-1">Quà tặng sinh nhật</h3>
                    <p class="text-sm text-text-muted">Nhận ngay 1 vé Rửa Bọt Tuyết Tiêu Chuẩn miễn phí.</p>
                </div>
            </div>

            <!-- Vouchers/Rewards -->
            <section class="space-y-4">
                <div class="flex items-center justify-between">
                    <h2 class="font-display font-bold text-xl text-white flex items-center gap-2">
                        <i data-lucide="ticket" class="w-5 h-5 text-rose-400"></i> Đổi Điểm Nhận Quà
                    </h2>
                    <a href="#" class="text-sm text-[#00d4ff] hover:underline">Xem tất cả</a>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- Voucher 1 -->
                    <div class="glass-panel rounded-2xl border border-border-glass overflow-hidden flex group hover:border-rose-500/50 transition-colors">
                        <div class="w-24 bg-gradient-to-br from-rose-500 to-orange-500 flex flex-col items-center justify-center border-r border-dashed border-white/20 p-2 text-center shrink-0">
                            <span class="text-2xl font-bold text-white leading-none">10%</span>
                            <span class="text-[10px] text-white/80 font-medium uppercase mt-1">Giảm giá</span>
                        </div>
                        <div class="p-4 flex-1 flex flex-col justify-between">
                            <div>
                                <h3 class="font-bold text-white line-clamp-1">Voucher Giảm 10% Tổng Bill</h3>
                                <p class="text-xs text-text-muted mt-1">Áp dụng cho mọi hóa đơn thanh toán. HSD: 30 ngày.</p>
                            </div>
                            <div class="flex items-center justify-between mt-4">
                                <span class="text-sm font-bold text-amber-400">500 AWP</span>
                                <form action="${pageContext.request.contextPath}/redeemVoucher" method="POST" class="m-0">
                                    <input type="hidden" name="rewardType" value="Voucher Giảm 10%">
                                    <input type="hidden" name="pointsCost" value="500">
                                    <button type="submit" class="px-4 py-1.5 bg-bg-surface hover:bg-[#00d4ff] hover:text-black text-white text-xs font-bold rounded-lg transition-colors border border-border-glass hover:border-[#00d4ff]">ĐỔI NGAY</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Voucher 2 -->
                    <div class="glass-panel rounded-2xl border border-border-glass overflow-hidden flex group hover:border-[#00d4ff]/50 transition-colors">
                        <div class="w-24 bg-gradient-to-br from-[#00d4ff] to-blue-600 flex flex-col items-center justify-center border-r border-dashed border-white/20 p-2 text-center shrink-0">
                            <span class="text-2xl font-bold text-white leading-none">FREE</span>
                            <span class="text-[10px] text-white/80 font-medium uppercase mt-1">Xịt Gầm</span>
                        </div>
                        <div class="p-4 flex-1 flex flex-col justify-between">
                            <div>
                                <h3 class="font-bold text-white line-clamp-1">Tặng Gói Xịt Gầm Tẩy Phèn</h3>
                                <p class="text-xs text-text-muted mt-1">Áp dụng kèm với các gói rửa xe cơ bản. HSD: 15 ngày.</p>
                            </div>
                            <div class="flex items-center justify-between mt-4">
                                <span class="text-sm font-bold text-amber-400">1,200 AWP</span>
                                <form action="${pageContext.request.contextPath}/redeemVoucher" method="POST" class="m-0">
                                    <input type="hidden" name="rewardType" value="Voucher Free Xịt Gầm">
                                    <input type="hidden" name="pointsCost" value="1200">
                                    <button type="submit" class="px-4 py-1.5 bg-bg-surface hover:bg-[#00d4ff] hover:text-black text-white text-xs font-bold rounded-lg transition-colors border border-border-glass hover:border-[#00d4ff]">ĐỔI NGAY</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <!-- Mobile Navigation Bar -->
    <nav class="md:hidden fixed bottom-0 left-0 right-0 glass-panel border-t border-border-glass z-50 pb-safe">
        <div class="flex items-center justify-around p-2">
            <a href="${pageContext.request.contextPath}/account/dashboard" class="flex flex-col items-center gap-1 p-2 text-text-muted hover:text-white">
                <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
                <span class="text-[10px] font-medium">Tổng quan</span>
            </a>
            <a href="${pageContext.request.contextPath}/bookings" class="flex flex-col items-center gap-1 p-2 text-text-muted hover:text-white">
                <i data-lucide="calendar-plus" class="w-5 h-5"></i>
                <span class="text-[10px] font-medium">Đặt lịch</span>
            </a>
            <a href="${pageContext.request.contextPath}/customer/loyalty" class="flex flex-col items-center gap-1 p-2 text-[#00d4ff]">
                <div class="relative">
                    <i data-lucide="award" class="w-5 h-5"></i>
                    <span class="absolute -top-1 -right-1 flex h-2 w-2">
                      <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-amber-400 opacity-75"></span>
                      <span class="relative inline-flex rounded-full h-2 w-2 bg-amber-500"></span>
                    </span>
                </div>
                <span class="text-[10px] font-medium">Loyalty</span>
            </a>
            <a href="${pageContext.request.contextPath}/account/profile" class="flex flex-col items-center gap-1 p-2 text-text-muted hover:text-white">
                <i data-lucide="user" class="w-5 h-5"></i>
                <span class="text-[10px] font-medium">Cá nhân</span>
            </a>
        </div>
    </nav>

    <script>
        lucide.createIcons();
    </script>
    <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>
