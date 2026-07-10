<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản lý Đặt Lịch - AutoWash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
</head>
<body class="bg-bg-primary text-text-primary antialiased overflow-x-hidden selection:bg-[#00d4ff] selection:text-black flex">

    <!-- Sidebar Component -->
    <jsp:include page="/WEB-INF/views/components/admin_sidebar.jsp">
        <jsp:param name="activeMenu" value="bookings" />
    </jsp:include>

    <!-- Main Content -->
    <main class="flex-1 p-4 md:p-8 overflow-y-auto">
        <!-- Header -->
        <header class="flex justify-between items-center mb-8">
            <div>
                <h2 class="text-3xl font-display font-bold text-white mb-1">Quản lý Đặt Lịch</h2>
                <p class="text-text-muted">Xem và xử lý các lịch hẹn rửa xe của khách hàng.</p>
            </div>
            
            <div class="flex items-center gap-4">
                <div class="relative">
                    <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-text-muted"></i>
                    <input type="text" placeholder="Tìm biển số, SĐT..." class="pl-10 pr-4 py-2 bg-bg-surface border border-border-glass rounded-xl text-sm focus:outline-none focus:border-[#00d4ff] text-white w-64 transition-all">
                </div>
                <button class="flex items-center gap-2 px-4 py-2 bg-bg-surface border border-border-glass rounded-xl hover:bg-white/5 transition-colors text-sm">
                    <i data-lucide="filter" class="w-4 h-4"></i>
                    Lọc
                </button>
            </div>
        </header>

        <!-- Filters Strip -->
        <div class="flex gap-2 mb-6 overflow-x-auto pb-2">
            <button class="px-4 py-1.5 rounded-full bg-white/10 text-white border border-white/20 text-sm font-medium whitespace-nowrap hover:bg-white/20">Tất cả</button>
            <button class="px-4 py-1.5 rounded-full bg-orange-500/10 text-orange-400 border border-orange-500/30 text-sm font-medium whitespace-nowrap">Chờ xử lý (Pending)</button>
            <button class="px-4 py-1.5 rounded-full bg-blue-500/10 text-blue-400 border border-blue-500/30 hover:bg-blue-500/20 text-sm font-medium whitespace-nowrap">Đã xác nhận (Confirmed)</button>
            <button class="px-4 py-1.5 rounded-full bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30 hover:bg-[#00d4ff]/20 text-sm font-medium whitespace-nowrap">Đang rửa (In Process)</button>
            <button class="px-4 py-1.5 rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/30 hover:bg-emerald-500/20 text-sm font-medium whitespace-nowrap">Hoàn thành (Completed)</button>
            <button class="px-4 py-1.5 rounded-full bg-purple-500/10 text-purple-400 border border-purple-500/30 hover:bg-purple-500/20 text-sm font-medium whitespace-nowrap">Hàng đợi (Waitlisted)</button>
        </div>

        <!-- Data Table -->
        <div class="glass-panel rounded-2xl bg-bg-surface border border-border-glass overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm whitespace-nowrap">
                    <thead class="bg-black/20 text-text-muted border-b border-border-glass">
                        <tr>
                            <th class="px-6 py-4 font-medium">Mã Booking</th>
                            <th class="px-6 py-4 font-medium">Khách hàng</th>
                            <th class="px-6 py-4 font-medium">Biển số</th>
                            <th class="px-6 py-4 font-medium">Thời gian hẹn</th>
                            <th class="px-6 py-4 font-medium">Dịch vụ</th>
                            <th class="px-6 py-4 font-medium">Trạng thái</th>
                            <th class="px-6 py-4 font-medium text-right">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-border-glass">
                        
                        <!-- Row 1: Pending -->
                        <tr class="hover:bg-white/[0.02] transition-colors">
                            <td class="px-6 py-4 font-mono text-slate-300">BK-10206</td>
                            <td class="px-6 py-4">
                                <div class="font-medium text-white">Trần Văn Tèo</div>
                                <div class="text-xs text-text-muted">0901234567</div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-2.5 py-1 bg-white/10 border border-white/20 rounded text-xs font-mono font-bold tracking-wider">51H-12345</span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="text-white">Hôm nay, 16:30</div>
                            </td>
                            <td class="px-6 py-4 text-slate-300">Rửa Bọt Tuyết + Hút Bụi</td>
                            <td class="px-6 py-4">
                                <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-orange-500/10 text-orange-400 border border-orange-500/20">
                                    <span class="w-1.5 h-1.5 rounded-full bg-orange-400"></span> Pending
                                </span>
                            </td>
                            <td class="px-6 py-4 text-right">
                                <button class="px-3 py-1.5 rounded-lg bg-blue-500/10 text-blue-400 hover:bg-blue-500/20 text-xs font-medium transition-colors border border-blue-500/30">
                                    Đã Thu Tiền (Confirm)
                                </button>
                            </td>
                        </tr>

                        <!-- Row 2: Confirmed -->
                        <tr class="hover:bg-white/[0.02] transition-colors">
                            <td class="px-6 py-4 font-mono text-slate-300">BK-10205</td>
                            <td class="px-6 py-4">
                                <div class="font-medium text-white">Lê Thị Na</div>
                                <div class="text-xs text-text-muted">0912345678</div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-2.5 py-1 bg-white/10 border border-white/20 rounded text-xs font-mono font-bold tracking-wider">29A-67890</span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="text-white">Hôm nay, 15:45</div>
                            </td>
                            <td class="px-6 py-4 text-slate-300">Phủ Ceramic Nhanh</td>
                            <td class="px-6 py-4">
                                <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-blue-500/10 text-blue-400 border border-blue-500/20">
                                    <i data-lucide="check" class="w-3 h-3"></i> Confirmed
                                </span>
                            </td>
                            <td class="px-6 py-4 text-right">
                                <button class="px-3 py-1.5 rounded-lg bg-[#00d4ff]/10 text-[#00d4ff] hover:bg-[#00d4ff]/20 text-xs font-medium transition-colors border border-[#00d4ff]/30">
                                    Cho xe vào khoang
                                </button>
                            </td>
                        </tr>

                        <!-- Row 3: In Process -->
                        <tr class="hover:bg-white/[0.02] transition-colors">
                            <td class="px-6 py-4 font-mono text-slate-300">BK-10204</td>
                            <td class="px-6 py-4">
                                <div class="font-medium text-white">Phạm Văn Đồng</div>
                                <div class="text-xs text-text-muted">0988777666</div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-2.5 py-1 bg-white/10 border border-white/20 rounded text-xs font-mono font-bold tracking-wider">60B-55566</span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="text-white">Hôm nay, 15:00</div>
                            </td>
                            <td class="px-6 py-4 text-slate-300">Vệ Sinh Nội Thất</td>
                            <td class="px-6 py-4">
                                <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/20">
                                    <span class="w-1.5 h-1.5 rounded-full bg-[#00d4ff] animate-pulse"></span> In Process
                                </span>
                            </td>
                            <td class="px-6 py-4 text-right">
                                <button class="px-3 py-1.5 rounded-lg bg-emerald-500/10 text-emerald-400 hover:bg-emerald-500/20 text-xs font-medium transition-colors border border-emerald-500/30">
                                    Hoàn Thành
                                </button>
                            </td>
                        </tr>

                        <!-- Row 4: Waitlisted -->
                        <tr class="hover:bg-white/[0.02] transition-colors">
                            <td class="px-6 py-4 font-mono text-slate-300">BK-10207</td>
                            <td class="px-6 py-4">
                                <div class="font-medium text-white">Ngô Tất Tố</div>
                                <div class="text-xs text-text-muted">0933111222</div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-2.5 py-1 bg-white/10 border border-white/20 rounded text-xs font-mono font-bold tracking-wider">61C-33344</span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="text-white">Hôm nay, 17:00</div>
                                <div class="text-xs text-purple-400">Đến sớm 1 tiếng</div>
                            </td>
                            <td class="px-6 py-4 text-slate-300">Rửa Cơ Bản</td>
                            <td class="px-6 py-4">
                                <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-purple-500/10 text-purple-400 border border-purple-500/20">
                                    <i data-lucide="clock" class="w-3 h-3"></i> Waitlisted
                                </span>
                            </td>
                            <td class="px-6 py-4 text-right">
                                <button class="w-8 h-8 rounded-lg bg-blue-500/10 text-blue-400 hover:bg-blue-500/20 flex items-center justify-center ml-auto transition-colors" title="Chuyển sang Confirmed">
                                    <i data-lucide="check" class="w-4 h-4"></i>
                                </button>
                            </td>
                        </tr>

                        <!-- Row 5: NoShow -->
                        <tr class="hover:bg-white/[0.02] transition-colors opacity-70">
                            <td class="px-6 py-4 font-mono text-slate-300">BK-10202</td>
                            <td class="px-6 py-4">
                                <div class="font-medium text-white">Trương Vô Kỵ</div>
                                <div class="text-xs text-text-muted">0977888999</div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-2.5 py-1 bg-white/10 border border-white/20 rounded text-xs font-mono font-bold tracking-wider">79A-88899</span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="text-white text-red-400">Hôm nay, 10:00</div>
                            </td>
                            <td class="px-6 py-4 text-slate-300">Rửa Bọt Tuyết</td>
                            <td class="px-6 py-4">
                                <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-red-500/10 text-red-400 border border-red-500/20">
                                    <i data-lucide="user-x" class="w-3 h-3"></i> No-Show
                                </span>
                            </td>
                            <td class="px-6 py-4 text-right">
                                <button class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center ml-auto transition-colors" title="Force Confirm">
                                    <i data-lucide="rotate-ccw" class="w-4 h-4"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Pagination -->
            <div class="px-6 py-4 border-t border-border-glass flex items-center justify-between text-sm">
                <div class="text-text-muted">Hiển thị <span class="text-white font-medium">1-10</span> trong <span class="text-white font-medium">45</span> kết quả</div>
                <div class="flex items-center gap-2">
                    <button class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white disabled:opacity-50"><i data-lucide="chevron-left" class="w-4 h-4"></i></button>
                    <button class="w-8 h-8 rounded bg-[#00d4ff]/20 border border-[#00d4ff]/30 flex items-center justify-center text-[#00d4ff] font-medium">1</button>
                    <button class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white font-medium">2</button>
                    <button class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white font-medium">3</button>
                    <button class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white"><i data-lucide="chevron-right" class="w-4 h-4"></i></button>
                </div>
            </div>
        </div>
    </main>

    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/admin_manage_bookings.js?v=2"></script>
    <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>
