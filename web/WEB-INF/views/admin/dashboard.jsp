<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Admin Dashboard - AutoWash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-bg-primary text-text-primary antialiased overflow-x-hidden selection:bg-[#00d4ff] selection:text-black flex">

    <!-- Sidebar Component -->
    <jsp:include page="/WEB-INF/views/components/admin_sidebar.jsp">
        <jsp:param name="activeMenu" value="dashboard" />
    </jsp:include>

    <!-- Main Content -->
    <main class="flex-1 p-4 md:p-8 overflow-y-auto pb-[100px] md:pb-8">
        <!-- Header -->
        <header class="flex justify-between items-center mb-8">
            <div>
                <h2 class="text-3xl font-display font-bold text-white mb-1">Dashboard</h2>
                <p class="text-text-muted">Giám sát hoạt động trạm rửa xe tự động hôm nay.</p>
            </div>
            <div class="flex items-center gap-4">
                <button class="w-10 h-10 rounded-full glass-panel bg-bg-surface border border-border-glass flex items-center justify-center hover:bg-bg-surface-hover transition-colors">
                    <i data-lucide="bell" class="text-text-muted w-5 h-5"></i>
                </button>
            </div>
        </header>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <!-- Doanh Thu -->
            <div class="glass-panel p-6 relative overflow-hidden group rounded-2xl bg-bg-surface border border-border-glass">
                <div class="absolute top-0 right-0 w-32 h-32 bg-[#00d4ff]/10 rounded-full -mr-10 -mt-10 blur-2xl group-hover:bg-[#00d4ff]/20 transition-all"></div>
                <div class="flex justify-between items-start mb-4">
                    <div>
                        <p class="text-text-muted text-sm font-medium mb-1">Doanh Thu (Tháng này)</p>
                        <h3 class="text-3xl font-display font-bold text-white"><fmt:formatNumber value="${revenueThisMonth}" type="number" pattern="#,##0"/> ₫</h3>
                    </div>
                    <div class="w-12 h-12 rounded-xl bg-[#00d4ff]/20 flex items-center justify-center border border-[#00d4ff]/30 text-[#00d4ff]">
                        <i data-lucide="wallet" class="w-6 h-6"></i>
                    </div>
                </div>
                <div class="flex items-center gap-2 text-sm">
                    <span class="${revenueGrowth >= 0 ? 'text-success bg-success/10' : 'text-red-400 bg-red-400/10'} px-2 py-0.5 rounded flex items-center gap-1">
                        <i data-lucide="${revenueGrowth >= 0 ? 'trending-up' : 'trending-down'}" class="w-3 h-3"></i> <fmt:formatNumber value="${revenueGrowth}" type="number" pattern="+#,##0.0;-#,##0.0"/>%
                    </span>
                    <span class="text-text-muted">so với tháng trước</span>
                </div>
            </div>

            <!-- Khách Hàng -->
            <div class="glass-panel p-6 relative overflow-hidden group rounded-2xl bg-bg-surface border border-border-glass">
                <div class="absolute top-0 right-0 w-32 h-32 bg-purple-500/10 rounded-full -mr-10 -mt-10 blur-2xl group-hover:bg-purple-500/20 transition-all"></div>
                <div class="flex justify-between items-start mb-4">
                    <div>
                        <p class="text-text-muted text-sm font-medium mb-1">Tổng Lượt Rửa (Hôm nay)</p>
                        <h3 class="text-3xl font-display font-bold text-white">${washesToday} <span class="text-lg font-sans font-normal text-text-muted">lượt</span></h3>
                    </div>
                    <div class="w-12 h-12 rounded-xl bg-purple-500/20 flex items-center justify-center border border-purple-500/30 text-purple-400">
                        <i data-lucide="car" class="w-6 h-6"></i>
                    </div>
                </div>
                <div class="flex items-center gap-2 text-sm">
                    <span class="${washesGrowth >= 0 ? 'text-success bg-success/10' : 'text-red-400 bg-red-400/10'} px-2 py-0.5 rounded flex items-center gap-1">
                        <i data-lucide="${washesGrowth >= 0 ? 'trending-up' : 'trending-down'}" class="w-3 h-3"></i> <c:if test="${washesGrowth > 0}">+</c:if>${washesGrowth} lượt
                    </span>
                    <span class="text-text-muted">so với hôm qua</span>
                </div>
            </div>

            <!-- Đặt Lịch -->
            <div class="glass-panel p-6 relative overflow-hidden group rounded-2xl bg-bg-surface border border-border-glass">
                <div class="absolute top-0 right-0 w-32 h-32 bg-amber-500/10 rounded-full -mr-10 -mt-10 blur-2xl group-hover:bg-amber-500/20 transition-all"></div>
                <div class="flex justify-between items-start mb-4">
                    <div>
                        <p class="text-text-muted text-sm font-medium mb-1">Booking Chờ Xử Lý</p>
                        <h3 class="text-3xl font-display font-bold text-white">${pendingBookings}</h3>
                    </div>
                    <div class="w-12 h-12 rounded-xl bg-amber-500/20 flex items-center justify-center border border-amber-500/30 text-amber-400">
                        <i data-lucide="clock" class="w-6 h-6"></i>
                    </div>
                </div>
                <div class="flex items-center gap-2 text-sm">
                    <span class="text-text-muted">Cần chuẩn bị khoang rửa</span>
                </div>
            </div>
        </div>

        <!-- Biểu Đồ & LPR Mock -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            
            <!-- Chart Section -->
            <div class="lg:col-span-2 glass-panel p-6 rounded-2xl bg-bg-surface border border-border-glass">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-lg font-display font-bold text-white">Biểu Đồ Doanh Thu (7 Ngày Gần Nhất)</h3>
                    <select class="custom-select w-36">
                        <option>7 Ngày qua</option>
                        <option>Tháng này</option>
                    </select>
                </div>
                <div class="h-72 w-full relative">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>

            <!-- LPR Mock Form Section -->
            <div class="glass-panel p-6 rounded-2xl bg-bg-surface border border-border-glass border-l-4 border-l-[#00d4ff] flex flex-col">
                <div class="mb-6 flex items-center gap-3">
                    <div class="w-10 h-10 rounded-xl bg-[#00d4ff]/20 flex items-center justify-center text-[#00d4ff]">
                        <i data-lucide="camera" class="w-5 h-5"></i>
                    </div>
                    <div>
                        <h3 class="text-lg font-display font-bold text-white">Giả Lập Cổng LPR</h3>
                        <p class="text-xs text-text-muted">Test luồng xe vào trạm</p>
                    </div>
                </div>

                <form id="lprMockForm" class="flex flex-col flex-1" onsubmit="event.preventDefault(); simulateLPR();">
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-slate-300 mb-2">Biển số xe nhận diện được:</label>
                        <input type="text" id="licensePlate" placeholder="VD: 51H-123.45" class="w-full bg-bg-primary border border-border-glass text-white text-lg font-mono text-center rounded-xl p-3 focus:border-glow outline-none placeholder-slate-600 transition-all uppercase shadow-inner" required>
                    </div>
                    
                    <div class="mb-6 p-4 rounded-xl bg-white/5 border border-border-glass">
                        <p class="text-sm text-text-muted mb-2 flex items-center gap-1"><i data-lucide="info" class="w-4 h-4"></i> Luồng hoạt động:</p>
                        <ul class="text-xs text-text-muted list-disc list-inside space-y-1">
                            <li>Tìm Booking PENDING của biển số này.</li>
                            <li>Đổi trạng thái Booking -> COMPLETED.</li>
                            <li>Lưu lịch sử WashRecord.</li>
                            <li>Trừ Voucher & Cộng điểm Loyalty tự động.</li>
                        </ul>
                    </div>

                    <button type="submit" id="lprSubmitBtn" class="mt-auto w-full py-3 px-4 bg-[#00d4ff] hover:bg-cyan-400 text-black font-semibold rounded-xl shadow-[0_4px_15px_rgba(0,212,255,0.3)] transition-all flex justify-center items-center gap-2 btn-glow">
                        <i data-lucide="car" class="w-5 h-5"></i>
                        Xác Nhận Xe Vào Trạm
                    </button>
                    
                    <!-- Alert Message -->
                    <div id="lprAlert" class="hidden mt-4 p-3 rounded-lg text-sm text-center border"></div>
                </form>
            </div>
        </div>
    </main>

    <script>
        const chartLabels = ${chartLabels};
        const chartData = ${chartData};
    </script>
    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/admin/dashboard.js?v=3"></script>
    <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />

    <!-- Mobile Bottom Navigation -->
    <jsp:include page="/WEB-INF/views/components/admin_bottom_nav.jsp">
        <jsp:param name="activeMenu" value="dashboard" />
    </jsp:include>
</body>
</html>
