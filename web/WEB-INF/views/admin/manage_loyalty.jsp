<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản lý Voucher & Điểm - AutoWash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
</head>
<body class="bg-bg-primary text-text-primary antialiased overflow-x-hidden selection:bg-[#00d4ff] selection:text-black flex">

    <!-- Sidebar Component -->
    <jsp:include page="/WEB-INF/views/components/admin_sidebar.jsp">
        <jsp:param name="activeMenu" value="loyalty" />
    </jsp:include>

    <!-- Main Content -->
    <main class="flex-1 p-4 md:p-8 overflow-y-auto pb-[100px] md:pb-8">
        <!-- Header -->
        <header class="flex justify-between items-center mb-8">
            <div>
                <h2 class="text-3xl font-display font-bold text-white mb-1">Voucher & Loyalty</h2>
                <p class="text-text-muted">Cấu hình mã khuyến mãi và quy đổi điểm thưởng.</p>
            </div>
            
            <button class="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-[#00d4ff] to-blue-500 text-black rounded-xl hover:opacity-90 transition-opacity font-bold shadow-[0_0_15px_rgba(0,212,255,0.3)]">
                <i data-lucide="plus" class="w-5 h-5"></i>
                Tạo Voucher Mới
            </button>
        </header>

        <!-- Stats Overview -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
            <div class="glass-panel p-5 rounded-2xl border border-border-glass bg-bg-surface flex items-center gap-4">
                <div class="w-12 h-12 rounded-full bg-emerald-500/10 flex items-center justify-center">
                    <i data-lucide="ticket" class="w-6 h-6 text-emerald-400"></i>
                </div>
                <div>
                    <p class="text-text-muted text-xs uppercase tracking-wider mb-1">Voucher Đang Active</p>
                    <p class="text-2xl font-display font-bold text-white">12</p>
                </div>
            </div>
            <div class="glass-panel p-5 rounded-2xl border border-border-glass bg-bg-surface flex items-center gap-4">
                <div class="w-12 h-12 rounded-full bg-amber-500/10 flex items-center justify-center">
                    <i data-lucide="arrow-right-left" class="w-6 h-6 text-amber-400"></i>
                </div>
                <div>
                    <p class="text-text-muted text-xs uppercase tracking-wider mb-1">Lượt Đổi Tháng Này</p>
                    <p class="text-2xl font-display font-bold text-white">345</p>
                </div>
            </div>
            <div class="glass-panel p-5 rounded-2xl border border-[#00d4ff]/20 bg-[#00d4ff]/5 flex items-center gap-4">
                <div class="w-12 h-12 rounded-full bg-[#00d4ff]/10 flex items-center justify-center">
                    <i data-lucide="coins" class="w-6 h-6 text-[#00d4ff]"></i>
                </div>
                <div>
                    <p class="text-[#00d4ff]/70 text-xs uppercase tracking-wider mb-1">Tổng Điểm Đã Tiêu</p>
                    <p class="text-2xl font-display font-bold text-[#00d4ff]">1.2M <span class="text-sm font-sans font-normal">pts</span></p>
                </div>
            </div>
        </div>

        <!-- Voucher Table -->
        <div class="glass-panel rounded-2xl bg-bg-surface border border-border-glass overflow-hidden">
            <div class="p-5 border-b border-border-glass flex justify-between items-center bg-black/10">
                <h3 class="font-bold text-white text-lg">Danh sách Voucher (Store)</h3>
                <div class="flex gap-2">
                    <button class="px-3 py-1.5 rounded-lg bg-white/10 text-white text-sm font-medium border border-white/20 hover:bg-white/20">Đang chạy</button>
                    <button class="px-3 py-1.5 rounded-lg bg-transparent text-text-muted text-sm font-medium hover:text-white">Đã hết hạn</button>
                </div>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm whitespace-nowrap lg:whitespace-normal">
                    <thead class="hidden lg:table-header-group bg-black/20 text-text-muted border-b border-border-glass whitespace-nowrap">
                        <tr>
                            <th class="px-6 py-4 font-medium">Mã Code</th>
                            <th class="px-6 py-4 font-medium">Mức Giảm</th>
                            <th class="px-6 py-4 font-medium">Điểm Quy Đổi</th>
                            <th class="px-6 py-4 font-medium">Giới hạn</th>
                            <th class="px-6 py-4 font-medium">Trạng thái</th>
                            <th class="px-6 py-4 font-medium text-right">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-border-glass">
                        
                        <!-- Row 1 -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-2">Mã Code:</span>
                                <div class="inline-flex lg:flex items-center gap-3 align-top">
                                    <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-[#00d4ff] to-blue-500 flex items-center justify-center shadow-[0_0_10px_rgba(0,212,255,0.2)]">
                                        <i data-lucide="tag" class="w-5 h-5 text-black"></i>
                                    </div>
                                    <div>
                                        <div class="font-mono font-bold text-white tracking-wider text-base">DISCOUNT50</div>
                                        <div class="text-xs text-text-muted">Giảm 50K cho dịch vụ Phủ Ceramic</div>
                                    </div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Mức Giảm:</span>
                                <span class="text-emerald-400 font-bold">-50,000đ</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 font-display font-bold text-amber-400">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 font-sans font-normal">Điểm Quy Đổi:</span>
                                500 <span class="text-xs font-sans font-normal text-amber-400/70">pts</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Giới hạn:</span>
                                <div class="inline-block align-top">
                                    <div class="w-24 bg-black/40 rounded-full h-1.5 mb-1 overflow-hidden">
                                        <div class="bg-[#00d4ff] h-1.5 rounded-full" style="width: 45%"></div>
                                    </div>
                                    <span class="text-xs">45/100 lượt</span>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Trạng thái:</span>
                                <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-400"></span> Active
                                </span>
                            </td>
                            <td class="flex lg:table-cell justify-between items-center px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <div class="flex items-center justify-end gap-2">
                                    <button class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center transition-colors">
                                        <i data-lucide="edit-3" class="w-4 h-4"></i>
                                    </button>
                                    <button class="w-8 h-8 rounded-lg text-text-muted hover:text-red-400 flex items-center justify-center transition-colors">
                                        <i data-lucide="trash-2" class="w-4 h-4"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>

                        <!-- Row 2 -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-2">Mã Code:</span>
                                <div class="inline-flex lg:flex items-center gap-3 align-top">
                                    <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-amber-400 to-orange-500 flex items-center justify-center shadow-[0_0_10px_rgba(245,158,11,0.2)]">
                                        <i data-lucide="percent" class="w-5 h-5 text-black"></i>
                                    </div>
                                    <div>
                                        <div class="font-mono font-bold text-white tracking-wider text-base">VIP20</div>
                                        <div class="text-xs text-text-muted">Giảm 20% tổng bill (Tối đa 100K)</div>
                                    </div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Mức Giảm:</span>
                                <span class="text-emerald-400 font-bold">-20%</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 font-display font-bold text-amber-400">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 font-sans font-normal">Điểm Quy Đổi:</span>
                                1000 <span class="text-xs font-sans font-normal text-amber-400/70">pts</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Giới hạn:</span>
                                Không giới hạn
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Trạng thái:</span>
                                <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-400"></span> Active
                                </span>
                            </td>
                            <td class="flex lg:table-cell justify-between items-center px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <div class="flex items-center justify-end gap-2">
                                    <button class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center transition-colors">
                                        <i data-lucide="edit-3" class="w-4 h-4"></i>
                                    </button>
                                    <button class="w-8 h-8 rounded-lg text-text-muted hover:text-red-400 flex items-center justify-center transition-colors">
                                        <i data-lucide="trash-2" class="w-4 h-4"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>

                        <!-- Row 3: Disabled -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0 opacity-60">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-2">Mã Code:</span>
                                <div class="inline-flex lg:flex items-center gap-3 align-top">
                                    <div class="w-10 h-10 rounded-xl bg-slate-700 flex items-center justify-center border border-slate-600">
                                        <i data-lucide="ticket" class="w-5 h-5 text-slate-400"></i>
                                    </div>
                                    <div>
                                        <div class="font-mono font-bold text-slate-300 tracking-wider text-base line-through">FREEWASH</div>
                                        <div class="text-xs text-text-muted">Miễn phí 1 lần rửa bọt tuyết</div>
                                    </div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Mức Giảm:</span>
                                <span class="text-slate-400 font-bold">100%</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 font-display font-bold text-slate-400">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 font-sans font-normal">Điểm Quy Đổi:</span>
                                3000 <span class="text-xs font-sans font-normal">pts</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-400">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Giới hạn:</span>
                                500/500 lượt (Hết)
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Trạng thái:</span>
                                <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-red-500/10 text-red-400 border border-red-500/20">
                                    <i data-lucide="x-circle" class="w-3 h-3"></i> Tạm ngưng
                                </span>
                            </td>
                            <td class="flex lg:table-cell justify-between items-center px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <div class="flex items-center justify-end gap-2">
                                    <button class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center transition-colors" title="Kích hoạt lại">
                                        <i data-lucide="power" class="w-4 h-4"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
<jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />

    <!-- Mobile Bottom Navigation -->
    <jsp:include page="/WEB-INF/views/components/admin_bottom_nav.jsp">
        <jsp:param name="activeMenu" value="loyalty" />
    </jsp:include>
</body>
</html>
