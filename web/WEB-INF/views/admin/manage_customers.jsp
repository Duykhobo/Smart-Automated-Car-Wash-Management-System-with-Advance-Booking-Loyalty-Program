<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản lý Khách Hàng - AutoWash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
</head>
<body class="bg-bg-primary text-text-primary antialiased overflow-x-hidden selection:bg-[#00d4ff] selection:text-black flex">

    <!-- Sidebar Component -->
    <jsp:include page="/WEB-INF/views/components/admin_sidebar.jsp">
        <jsp:param name="activeMenu" value="customers" />
    </jsp:include>

    <!-- Main Content -->
    <main class="flex-1 p-4 md:p-8 overflow-y-auto pb-[100px] md:pb-8">
        <!-- Header -->
        <header class="flex justify-between items-center mb-8">
            <div>
                <h2 class="text-3xl font-display font-bold text-white mb-1">Khách Hàng & Loyalty</h2>
                <p class="text-text-muted">Quản lý danh sách thành viên, hạng thẻ và lịch sử tích điểm.</p>
            </div>
            
            <div class="flex items-center gap-4">
                <div class="relative">
                    <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-text-muted"></i>
                    <input type="text" placeholder="Tìm tên, SĐT, biển số..." class="pl-10 pr-4 py-2 bg-bg-surface border border-border-glass rounded-xl text-sm focus:outline-none focus:border-[#00d4ff] text-white w-64 transition-all">
                </div>
                <button class="flex items-center gap-2 px-4 py-2 bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30 rounded-xl hover:bg-[#00d4ff]/20 transition-colors text-sm font-medium">
                    <i data-lucide="download" class="w-4 h-4"></i>
                    Xuất Excel
                </button>
            </div>
        </header>

        <!-- Stats Overview -->
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
            <div class="glass-panel p-4 rounded-xl border border-border-glass bg-bg-surface text-center">
                <p class="text-text-muted text-xs uppercase tracking-wider mb-1">Tổng Thành Viên</p>
                <p class="text-2xl font-display font-bold text-white">1,245</p>
            </div>
            <div class="glass-panel p-4 rounded-xl border border-border-glass bg-bg-surface text-center">
                <p class="text-text-muted text-xs uppercase tracking-wider mb-1">Khách Mới (Tháng)</p>
                <p class="text-2xl font-display font-bold text-emerald-400">+124</p>
            </div>
            <div class="glass-panel p-4 rounded-xl border border-amber-500/20 bg-amber-500/5 text-center">
                <p class="text-amber-500/70 text-xs uppercase tracking-wider mb-1">Hội Viên Gold/Platinum</p>
                <p class="text-2xl font-display font-bold text-amber-400">18%</p>
            </div>
            <div class="glass-panel p-4 rounded-xl border border-[#00d4ff]/20 bg-[#00d4ff]/5 text-center">
                <p class="text-[#00d4ff]/70 text-xs uppercase tracking-wider mb-1">Tổng Điểm Đã Cấp</p>
                <p class="text-2xl font-display font-bold text-[#00d4ff]">452K</p>
            </div>
        </div>

        <!-- Data Table -->
        <div class="glass-panel rounded-2xl bg-bg-surface border border-border-glass overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm whitespace-nowrap lg:whitespace-normal">
                    <thead class="hidden lg:table-header-group bg-black/20 text-text-muted border-b border-border-glass whitespace-nowrap">
                        <tr>
                            <th class="px-6 py-4 font-medium">Khách hàng</th>
                            <th class="px-6 py-4 font-medium">Liên hệ</th>
                            <th class="px-6 py-4 font-medium">Biển số xe</th>
                            <th class="px-6 py-4 font-medium">Hạng thẻ</th>
                            <th class="px-6 py-4 font-medium">Điểm khả dụng</th>
                            <th class="px-6 py-4 font-medium">Lượt rửa</th>
                            <th class="px-6 py-4 font-medium text-right">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-border-glass">
                        <!-- Row 1: Platinum -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-2">Khách hàng:</span>
                                <div class="inline-flex lg:flex items-center gap-3 align-top">
                                    <div class="w-10 h-10 rounded-full bg-gradient-to-br from-cyan-300 to-[#00d4ff] flex items-center justify-center font-bold text-black shadow-[0_0_10px_rgba(0,212,255,0.3)]">
                                        P
                                    </div>
                                    <div class="font-medium text-white">Phạm Văn Đồng</div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Liên hệ:</span>
                                <div class="inline-block align-top">
                                    <div>0901 123 456</div>
                                    <div class="text-xs text-text-muted">dongpv@gmail.com</div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Biển số xe:</span>
                                <div class="inline-flex lg:flex flex-col gap-1 align-top">
                                    <span class="px-2 py-0.5 bg-white/10 rounded text-xs font-mono w-max">51H-999.99</span>
                                    <span class="px-2 py-0.5 bg-white/10 rounded text-xs font-mono w-max">51K-123.45</span>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Hạng thẻ:</span>
                                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-[#00d4ff]/20 text-[#00d4ff] border border-[#00d4ff]/40 shadow-[0_0_10px_rgba(0,212,255,0.2)]">
                                    <i data-lucide="crown" class="w-3 h-3"></i> Platinum
                                </span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 font-display font-bold text-white">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 font-sans font-normal">Điểm khả dụng:</span>
                                12,450 <span class="text-xs font-sans font-normal text-[#00d4ff]">pts</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Lượt rửa:</span>
                                45 lượt
                            </td>
                            <td class="flex lg:table-cell items-center gap-3 px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <button class="px-3 py-1.5 rounded-lg bg-white/5 text-slate-300 hover:bg-white/10 hover:text-white text-xs font-medium transition-colors border border-border-glass">
                                    Lịch sử điểm
                                </button>
                            </td>
                        </tr>

                        <!-- Row 2: Gold -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-2">Khách hàng:</span>
                                <div class="inline-flex lg:flex items-center gap-3 align-top">
                                    <div class="w-10 h-10 rounded-full bg-gradient-to-br from-amber-300 to-amber-600 flex items-center justify-center font-bold text-black shadow-[0_0_10px_rgba(245,158,11,0.3)]">
                                        T
                                    </div>
                                    <div class="font-medium text-white">Trần Lệ Xuân</div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Liên hệ:</span>
                                <div class="inline-block align-top">
                                    <div>0912 345 678</div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Biển số xe:</span>
                                <span class="px-2 py-0.5 bg-white/10 rounded text-xs font-mono w-max">29A-678.90</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Hạng thẻ:</span>
                                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-amber-500/20 text-amber-400 border border-amber-500/40 shadow-[0_0_10px_rgba(245,158,11,0.2)]">
                                    <i data-lucide="star" class="w-3 h-3"></i> Gold
                                </span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 font-display font-bold text-white">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 font-sans font-normal">Điểm khả dụng:</span>
                                4,200 <span class="text-xs font-sans font-normal text-amber-400">pts</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Lượt rửa:</span>
                                18 lượt
                            </td>
                            <td class="flex lg:table-cell items-center gap-3 px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <button class="px-3 py-1.5 rounded-lg bg-white/5 text-slate-300 hover:bg-white/10 hover:text-white text-xs font-medium transition-colors border border-border-glass">
                                    Lịch sử điểm
                                </button>
                            </td>
                        </tr>

                        <!-- Row 3: Silver -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-2">Khách hàng:</span>
                                <div class="inline-flex lg:flex items-center gap-3 align-top">
                                    <div class="w-10 h-10 rounded-full bg-gradient-to-br from-slate-400 to-slate-200 flex items-center justify-center font-bold text-slate-800">
                                        N
                                    </div>
                                    <div class="font-medium text-white">Nguyễn Khắc Nhu</div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Liên hệ:</span>
                                <div class="inline-block align-top">
                                    <div>0987 654 321</div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Biển số xe:</span>
                                <span class="px-2 py-0.5 bg-white/10 rounded text-xs font-mono w-max">60B-112.23</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Hạng thẻ:</span>
                                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-slate-500/20 text-slate-300 border border-slate-500/40">
                                    <i data-lucide="shield" class="w-3 h-3"></i> Silver
                                </span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 font-display font-bold text-white">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 font-sans font-normal">Điểm khả dụng:</span>
                                1,850 <span class="text-xs font-sans font-normal text-slate-400">pts</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Lượt rửa:</span>
                                6 lượt
                            </td>
                            <td class="flex lg:table-cell items-center gap-3 px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <button class="px-3 py-1.5 rounded-lg bg-white/5 text-slate-300 hover:bg-white/10 hover:text-white text-xs font-medium transition-colors border border-border-glass">
                                    Lịch sử điểm
                                </button>
                            </td>
                        </tr>
                        
                        <!-- Row 4: Member -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-2">Khách hàng:</span>
                                <div class="inline-flex lg:flex items-center gap-3 align-top">
                                    <div class="w-10 h-10 rounded-full bg-slate-800 border border-slate-600 flex items-center justify-center font-bold text-slate-300">
                                        L
                                    </div>
                                    <div class="font-medium text-white">Lý Hải</div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Liên hệ:</span>
                                <div class="inline-block align-top">
                                    <div>0933 445 566</div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Biển số xe:</span>
                                <span class="px-2 py-0.5 bg-white/10 rounded text-xs font-mono w-max">61C-445.56</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Hạng thẻ:</span>
                                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-medium bg-slate-800 text-slate-400 border border-slate-700">
                                    <i data-lucide="user" class="w-3 h-3"></i> Member
                                </span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 font-display font-bold text-white">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 font-sans font-normal">Điểm khả dụng:</span>
                                120 <span class="text-xs font-sans font-normal text-slate-400">pts</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Lượt rửa:</span>
                                1 lượt
                            </td>
                            <td class="flex lg:table-cell items-center gap-3 px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <button class="px-3 py-1.5 rounded-lg bg-white/5 text-slate-300 hover:bg-white/10 hover:text-white text-xs font-medium transition-colors border border-border-glass">
                                    Lịch sử điểm
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Pagination -->
            <div class="px-6 py-4 border-t border-border-glass flex items-center justify-between text-sm">
                <div class="text-text-muted">Hiển thị <span class="text-white font-medium">1-10</span> trong <span class="text-white font-medium">1,245</span> kết quả</div>
                <div class="flex items-center gap-2">
                    <button class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white disabled:opacity-50"><i data-lucide="chevron-left" class="w-4 h-4"></i></button>
                    <button class="w-8 h-8 rounded bg-[#00d4ff]/20 border border-[#00d4ff]/30 flex items-center justify-center text-[#00d4ff] font-medium">1</button>
                    <button class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white font-medium">2</button>
                    <button class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white font-medium">...</button>
                    <button class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white font-medium">125</button>
                    <button class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white"><i data-lucide="chevron-right" class="w-4 h-4"></i></button>
                </div>
            </div>
        </div>
    </main>
<jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />

    <!-- Mobile Bottom Navigation -->
    <jsp:include page="/WEB-INF/views/components/admin_bottom_nav.jsp">
        <jsp:param name="activeMenu" value="customers" />
    </jsp:include>
</body>
</html>
