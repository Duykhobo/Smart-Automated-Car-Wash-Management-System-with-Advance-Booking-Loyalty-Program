<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
                <p class="text-text-muted">Cấu hình mã khuyến mãi và hạng thành viên tích điểm.</p>
            </div>
            
            <button onclick="document.getElementById('createRewardModal').classList.remove('hidden')" class="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-[#00d4ff] to-blue-500 text-black rounded-xl hover:opacity-90 transition-opacity font-bold shadow-[0_0_15px_rgba(0,212,255,0.3)]">
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
                    <p class="text-2xl font-display font-bold text-white"><fmt:formatNumber value="${activeVouchers != null ? activeVouchers : 0}" type="number" maxFractionDigits="0"/></p>
                </div>
            </div>
            <div class="glass-panel p-5 rounded-2xl border border-border-glass bg-bg-surface flex items-center gap-4">
                <div class="w-12 h-12 rounded-full bg-amber-500/10 flex items-center justify-center">
                    <i data-lucide="arrow-right-left" class="w-6 h-6 text-amber-400"></i>
                </div>
                <div>
                    <p class="text-text-muted text-xs uppercase tracking-wider mb-1">Lượt Đổi Tháng Này</p>
                    <p class="text-2xl font-display font-bold text-white"><fmt:formatNumber value="${redeemedThisMonth != null ? redeemedThisMonth : 0}" type="number" maxFractionDigits="0"/></p>
                </div>
            </div>
            <div class="glass-panel p-5 rounded-2xl border border-[#00d4ff]/20 bg-[#00d4ff]/5 flex items-center gap-4">
                <div class="w-12 h-12 rounded-full bg-[#00d4ff]/10 flex items-center justify-center">
                    <i data-lucide="coins" class="w-6 h-6 text-[#00d4ff]"></i>
                </div>
                <div>
                    <p class="text-[#00d4ff]/70 text-xs uppercase tracking-wider mb-1">Tổng Điểm Đã Tiêu</p>
                    <p class="text-2xl font-display font-bold text-[#00d4ff]"><fmt:formatNumber value="${totalPointsSpent != null ? totalPointsSpent : 0}" type="number" maxFractionDigits="0"/> <span class="text-sm font-sans font-normal">pts</span></p>
                </div>
            </div>
        </div>

        <!-- BẢNG 1: CẤU HÌNH HẠNG THÀNH VIÊN (LOYALTY TIERS) -->
        <div class="glass-panel rounded-2xl bg-bg-surface border border-border-glass overflow-hidden mb-8">
            <div class="p-5 border-b border-border-glass bg-black/10">
                <h3 class="font-bold text-white text-lg flex items-center gap-2">
                    <i data-lucide="crown" class="w-5 h-5 text-[#00d4ff]"></i> Cấu Hình Hạng Thành Viên
                </h3>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm">
                    <thead class="bg-black/20 text-text-muted border-b border-border-glass">
                        <tr>
                            <th class="px-6 py-4 font-medium">Tên Hạng</th>
                            <th class="px-6 py-4 font-medium">Số lượt rửa tối thiểu</th>
                            <th class="px-6 py-4 font-medium">Chi tiêu tối thiểu</th>
                            <th class="px-6 py-4 font-medium">Hệ số tích lũy điểm</th>
                            <th class="px-6 py-4 font-medium">Số ngày đặt lịch trước tối đa</th>
                            <th class="px-6 py-4 font-medium text-right">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-border-glass text-slate-300">
                        <c:forEach var="tier" items="${tierList}">
                            <tr class="hover:bg-white/[0.02] transition-colors">
                                <td class="px-6 py-4 font-bold text-white">
                                    <c:choose>
                                        <c:when test="${tier.tierName eq 'Platinum'}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-[#00d4ff]/20 text-[#00d4ff] border border-[#00d4ff]/40 shadow-[0_0_10px_rgba(0,212,255,0.2)]">
                                                <i data-lucide="crown" class="w-3 h-3"></i> Platinum
                                            </span>
                                        </c:when>
                                        <c:when test="${tier.tierName eq 'Gold'}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-amber-500/20 text-amber-400 border border-amber-500/40 shadow-[0_0_10px_rgba(245,158,11,0.2)]">
                                                <i data-lucide="star" class="w-3 h-3"></i> Gold
                                            </span>
                                        </c:when>
                                        <c:when test="${tier.tierName eq 'Silver'}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-slate-500/20 text-slate-300 border border-slate-500/40">
                                                <i data-lucide="shield" class="w-3 h-3"></i> Silver
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-medium bg-slate-800 text-slate-400 border border-slate-700">
                                                <i data-lucide="user" class="w-3 h-3"></i> Member (Mặc định)
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4">${tier.minWashes} lượt</td>
                                <td class="px-6 py-4"><fmt:formatNumber value="${tier.minSpend}" type="number" pattern="#,##0"/>đ</td>
                                <td class="px-6 py-4 text-emerald-400 font-bold">+<fmt:formatNumber value="${tier.pointsModifier * 100}" type="number" pattern="#,##0"/>%</td>
                                <td class="px-6 py-4">${tier.maxBookingDays} ngày</td>
                                <td class="px-6 py-4 text-right">
                                    <button class="px-3 py-1.5 rounded-lg bg-white/5 text-slate-300 hover:bg-white/10 hover:text-white text-xs font-medium transition-colors border border-border-glass"
                                            onclick="openEditTierModal(${tier.tierId}, '${tier.tierName}', ${tier.minWashes}, ${tier.minSpend}, ${tier.pointsModifier}, ${tier.maxBookingDays})">
                                        Cấu hình
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- BẢNG 2: VOUCHER STORE (CHỈ HIỂN THỊ) -->
        <div class="glass-panel rounded-2xl bg-bg-surface border border-border-glass overflow-hidden">
            <div class="p-5 border-b border-border-glass flex justify-between items-center bg-black/10">
                <h3 class="font-bold text-white text-lg">Danh sách Voucher (Store)</h3>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm whitespace-nowrap lg:whitespace-normal">
                    <thead class="hidden lg:table-header-group bg-black/20 text-text-muted border-b border-border-glass whitespace-nowrap">
                        <tr>
                            <th class="px-6 py-4 font-medium">Tên Quà Tặng / Loại</th>
                            <th class="px-6 py-4 font-medium">Mô Tả</th>
                            <th class="px-6 py-4 font-medium">Điểm Quy Đổi</th>
                            <th class="px-6 py-4 font-medium">Trạng thái</th>
                            <th class="px-6 py-4 font-medium text-right">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-border-glass">
                        <c:forEach var="reward" items="${rewardsList}">
                        <!-- Dynamic Row -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0 ${not reward.isActive ? 'opacity-60' : ''}">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-2">Mã Code:</span>
                                <div class="inline-flex lg:flex items-center gap-3 align-top">
                                    <c:choose>
                                        <c:when test="${reward.isActive}">
                                            <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-[#00d4ff] to-blue-500 flex items-center justify-center shadow-[0_0_10px_rgba(0,212,255,0.2)]">
                                                <i data-lucide="${not empty reward.imageIcon ? reward.imageIcon : 'tag'}" class="w-5 h-5 text-black"></i>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-10 h-10 rounded-xl bg-slate-700 flex items-center justify-center border border-slate-600">
                                                <i data-lucide="${not empty reward.imageIcon ? reward.imageIcon : 'tag'}" class="w-5 h-5 text-slate-400"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div>
                                        <div class="font-mono font-bold tracking-wider text-base ${reward.isActive ? 'text-white' : 'text-slate-300 line-through'}">${reward.rewardType}</div>
                                        <div class="text-xs text-text-muted">${reward.rewardName} - ${reward.description}</div>
                                    </div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Mức Giảm:</span>
                                <span class="${reward.isActive ? 'text-emerald-400' : 'text-slate-400'} font-bold">
                                    <c:choose>
                                        <c:when test="${reward.discountPercent > 0}">
                                            -<fmt:formatNumber value="${reward.discountPercent}" maxFractionDigits="0"/>%
                                        </c:when>
                                        <c:when test="${reward.rewardType == 'FREE_WASH'}">100%</c:when>
                                        <c:when test="${reward.rewardType == '10_PERCENT_OFF'}">-10%</c:when>
                                        <c:when test="${reward.rewardType == '20_PERCENT_OFF'}">-20%</c:when>
                                        <c:otherwise>Xem chi tiết</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 font-display font-bold ${reward.isActive ? 'text-amber-400' : 'text-slate-400'}">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 font-sans font-normal">Điểm Quy Đổi:</span>
                                <fmt:formatNumber value="${reward.pointsCost}" type="number" maxFractionDigits="0"/> <span class="text-xs font-sans font-normal ${reward.isActive ? 'text-amber-400/70' : ''}">pts</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 ${reward.isActive ? 'text-slate-300' : 'text-slate-400'}">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Giới hạn:</span>
                                Không giới hạn
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Trạng thái:</span>
                                <c:choose>
                                    <c:when test="${reward.isActive}">
                                        <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-400"></span> Active
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-red-500/10 text-red-400 border border-red-500/20">
                                            <i data-lucide="x-circle" class="w-3 h-3"></i> Tạm ngưng
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="flex lg:table-cell justify-between items-center px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <div class="flex items-center justify-end gap-2">
                                    <c:choose>
                                        <c:when test="${reward.isActive}">
                                            <button onclick="openEditModal(${reward.rewardId}, '${reward.rewardName}', '${reward.rewardType}', ${reward.pointsCost}, '${reward.description}', '${reward.imageIcon}', ${reward.discountPercent})" class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center transition-colors">
                                                <i data-lucide="edit-3" class="w-4 h-4"></i>
                                            </button>
                                            <form action="${pageContext.request.contextPath}/admin/loyalty/reward" method="POST" class="inline">
                                                <input type="hidden" name="action" value="toggle">
                                                <input type="hidden" name="rewardId" value="${reward.rewardId}">
                                                <input type="hidden" name="isActive" value="false">
                                                <button type="button" onclick="showGlobalConfirmModal('Tạm ngưng Voucher', 'Bạn có chắc chắn muốn ngưng phát hành Voucher này?', 'Ngưng phát hành', function(){this.closest('form').submit();}.bind(this))" class="w-8 h-8 rounded-lg text-text-muted hover:text-red-400 flex items-center justify-center transition-colors">
                                                    <i data-lucide="trash-2" class="w-4 h-4"></i>
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/admin/loyalty/reward" method="POST" class="inline">
                                                <input type="hidden" name="action" value="toggle">
                                                <input type="hidden" name="rewardId" value="${reward.rewardId}">
                                                <input type="hidden" name="isActive" value="true">
                                                <button type="submit" class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center transition-colors" title="Kích hoạt lại">
                                                    <i data-lucide="power" class="w-4 h-4"></i>
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Voucher History Table -->
        <div class="mt-8">
            <div class="flex items-center gap-3 mb-4">
                <i data-lucide="history" class="w-6 h-6 text-[#00d4ff]"></i>
                <h2 class="text-xl font-display font-bold text-white">Lịch sử Đổi & Sử dụng Voucher</h2>
            </div>
            
            <div class="glass-panel border border-border-glass rounded-2xl overflow-hidden shadow-[0_4px_30px_rgba(0,0,0,0.3)]">
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse min-w-[800px]">
                        <thead>
                            <tr class="bg-black/40 border-b border-border-glass text-text-muted text-xs uppercase tracking-wider font-display">
                                <th class="px-6 py-4 font-semibold w-1/4">Khách Hàng</th>
                                <th class="px-6 py-4 font-semibold">Mã Voucher</th>
                                <th class="px-6 py-4 font-semibold text-center">Giảm Giá</th>
                                <th class="px-6 py-4 font-semibold">Trạng Thái</th>
                                <th class="px-6 py-4 font-semibold text-right">Ngày Đổi</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-border-glass text-sm">
                            <c:choose>
                                <c:when test="${empty voucherHistory}">
                                    <tr>
                                        <td colspan="5" class="px-6 py-8 text-center text-text-muted">
                                            Chưa có khách hàng nào đổi Voucher.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="vh" items="${voucherHistory}">
                                        <tr class="hover:bg-white/[0.02] transition-colors group">
                                            <td class="px-6 py-4">
                                                <div class="font-bold text-white group-hover:text-[#00d4ff] transition-colors"><c:out value="${vh.customerName}" /></div>
                                                <div class="text-text-muted text-xs mt-0.5"><c:out value="${vh.customerEmail}" /></div>
                                            </td>
                                            <td class="px-6 py-4">
                                                <span class="font-mono text-amber-400 font-bold tracking-wider"><c:out value="${vh.voucherCode}" /></span>
                                            </td>
                                            <td class="px-6 py-4 text-center text-text-muted">
                                                <c:choose>
                                                    <c:when test="${vh.discountPercent > 0}">Giảm <fmt:formatNumber value="${vh.discountPercent}" maxFractionDigits="0"/>%</c:when>
                                                    <c:otherwise><c:out value="${vh.rewardType}"/></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4">
                                                <c:choose>
                                                    <c:when test="${vh.status == 'Unused'}">
                                                        <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-green-500/10 text-green-400 border border-green-500/20">
                                                            <span class="w-1.5 h-1.5 rounded-full bg-green-400"></span> Chưa dùng
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${vh.status == 'Used'}">
                                                        <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-gray-500/10 text-gray-400 border border-gray-500/20">
                                                            <span class="w-1.5 h-1.5 rounded-full bg-gray-400"></span> Đã dùng
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-red-500/10 text-red-400 border border-red-500/20">
                                                            <span class="w-1.5 h-1.5 rounded-full bg-red-400"></span> Hết hạn
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 text-right font-mono text-text-muted whitespace-nowrap">
                                                <fmt:formatDate value="${vh.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination Component -->
                <div class="px-6 py-4 border-t border-border-glass flex items-center justify-between text-sm bg-black/20">
                    <div class="text-text-muted">
                        <c:choose>
                            <c:when test="${totalRecords == 0}">Không có kết quả nào</c:when>
                            <c:otherwise>
                                Hiển thị <span class="text-white font-medium">${(currentPage - 1) * 10 + 1}-${currentPage * 10 > totalRecords ? totalRecords : currentPage * 10}</span> trong <span class="text-white font-medium">${totalRecords}</span> Voucher
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <jsp:include page="../components/pagination.jsp">
                        <jsp:param name="currentPage" value="${currentPage}" />
                        <jsp:param name="totalPages" value="${totalPages}" />
                        <jsp:param name="url" value="?" />
                    </jsp:include>
                </div>
            </div>
        </div>
    </main>

    <!-- Create Reward Modal -->
    <div id="createRewardModal" class="hidden fixed inset-0 z-50 flex items-center justify-center p-4">
        <!-- Backdrop -->
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="document.getElementById('createRewardModal').classList.add('hidden')"></div>
        
        <!-- Modal Content -->
        <div class="relative bg-bg-surface border border-border-glass rounded-2xl w-full max-w-md shadow-2xl overflow-hidden flex flex-col max-h-[90vh]">
            <!-- Modal Header -->
            <div class="px-6 py-4 border-b border-border-glass flex justify-between items-center bg-black/20">
                <h3 class="text-xl font-bold text-white font-display">Tạo Voucher Mới</h3>
                <button type="button" onclick="document.getElementById('createRewardModal').classList.add('hidden')" class="text-text-muted hover:text-white transition-colors">
                    <i data-lucide="x" class="w-5 h-5"></i>
                </button>
            </div>
            
            <!-- Modal Body (Scrollable) -->
            <div class="p-6 overflow-y-auto">
                <form id="createRewardForm" action="${pageContext.request.contextPath}/admin/loyalty/reward" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="add">
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Tên Voucher <span class="text-red-400">*</span></label>
                        <input type="text" name="rewardName" required placeholder="VD: Giảm 50K Phủ Ceramic..." 
                               class="w-full px-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Mã tham chiếu (RewardType)</label>
                        <input type="text" name="rewardType" placeholder="VD: DISCOUNT_50K" 
                               class="w-full px-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Điểm Quy Đổi <span class="text-red-400">*</span></label>
                        <input type="number" name="pointsCost" required min="1" placeholder="VD: 500" 
                               class="w-full px-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Mức giảm giá (%)</label>
                        <input type="number" name="discountPercent" min="0" max="100" step="1" placeholder="VD: 15" 
                               class="w-full px-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Mô tả chi tiết</label>
                        <textarea name="description" rows="3" placeholder="Điều kiện áp dụng..." 
                                  class="w-full px-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors resize-none"></textarea>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Icon hiển thị (Lucide name)</label>
                        <div class="relative">
                            <input type="text" name="imageIcon" placeholder="VD: tag, percent, gift" value="ticket"
                                   class="w-full pl-10 pr-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                            <i data-lucide="image" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-text-muted"></i>
                        </div>
                    </div>
                </form>
            </div>
            
            <!-- Modal Footer -->
            <div class="px-6 py-4 border-t border-border-glass bg-black/20 flex justify-end gap-3 shrink-0">
                <button type="button" onclick="document.getElementById('createRewardModal').classList.add('hidden')" class="px-4 py-2 rounded-xl border border-border-glass text-text-muted hover:text-white transition-colors">
                    Hủy
                </button>
                <button type="submit" form="createRewardForm" class="px-6 py-2 rounded-xl bg-[#00d4ff]/10 border border-[#00d4ff]/30 text-[#00d4ff] font-bold hover:bg-[#00d4ff]/20 transition-colors">
                    Tạo Voucher
                </button>
            </div>
        </div>
    </div>

    <!-- Edit Reward Modal -->
    <div id="editRewardModal" class="hidden fixed inset-0 z-50 flex items-center justify-center p-4">
        <!-- Backdrop -->
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="document.getElementById('editRewardModal').classList.add('hidden')"></div>
        
        <!-- Modal Content -->
        <div class="relative bg-bg-surface border border-border-glass rounded-2xl w-full max-w-md shadow-2xl overflow-hidden flex flex-col max-h-[90vh]">
            <!-- Modal Header -->
            <div class="px-6 py-4 border-b border-border-glass flex justify-between items-center bg-black/20">
                <h3 class="text-xl font-bold text-white font-display">Sửa thông tin Voucher</h3>
                <button type="button" onclick="document.getElementById('editRewardModal').classList.add('hidden')" class="text-text-muted hover:text-white transition-colors">
                    <i data-lucide="x" class="w-5 h-5"></i>
                </button>
            </div>
            
            <!-- Modal Body (Scrollable) -->
            <div class="p-6 overflow-y-auto">
                <form id="editRewardForm" action="${pageContext.request.contextPath}/admin/loyalty/reward" method="POST" class="space-y-4">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="rewardId" id="editRewardId">
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Tên Voucher <span class="text-red-400">*</span></label>
                        <input type="text" name="rewardName" id="editRewardName" required 
                               class="w-full px-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Mã tham chiếu (RewardType)</label>
                        <input type="text" name="rewardType" id="editRewardType" 
                               class="w-full px-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Điểm Quy Đổi <span class="text-red-400">*</span></label>
                        <input type="number" name="pointsCost" id="editPointsCost" required min="1" 
                               class="w-full px-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Mức giảm giá (%)</label>
                        <input type="number" name="discountPercent" id="editDiscountPercent" min="0" max="100" step="1" 
                               class="w-full px-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Mô tả chi tiết</label>
                        <textarea name="description" id="editDescription" rows="3" 
                                  class="w-full px-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors resize-none"></textarea>
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-text-muted mb-1">Icon hiển thị (Lucide name)</label>
                        <div class="relative">
                            <input type="text" name="imageIcon" id="editImageIcon" 
                                   class="w-full pl-10 pr-4 py-2.5 bg-black/20 border border-border-glass rounded-xl text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                            <i data-lucide="image" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-text-muted"></i>
                        </div>
                    </div>
                </form>
            </div>
            
            <!-- Modal Footer -->
            <div class="px-6 py-4 border-t border-border-glass bg-black/20 flex justify-end gap-3 shrink-0">
                <button type="button" onclick="document.getElementById('editRewardModal').classList.add('hidden')" class="px-4 py-2 rounded-xl border border-border-glass text-text-muted hover:text-white transition-colors">
                    Hủy
                </button>
                <button type="submit" form="editRewardForm" class="px-6 py-2 rounded-xl bg-amber-500/10 border border-amber-500/30 text-amber-400 font-bold hover:bg-amber-500/20 transition-colors">
                    Lưu Thay Đổi
                </button>
            </div>
        </div>
    </div>

    <script>
        function openEditModal(id, name, type, points, desc, icon, discountPercent) {
            document.getElementById('editRewardId').value = id;
            document.getElementById('editRewardName').value = name;
            document.getElementById('editRewardType').value = type;
            document.getElementById('editPointsCost').value = points;
            document.getElementById('editDescription').value = desc !== 'null' ? desc : '';
            document.getElementById('editImageIcon').value = icon;
            document.getElementById('editDiscountPercent').value = discountPercent > 0 ? discountPercent : '';
            
            document.getElementById('editRewardModal').classList.remove('hidden');
        }
    </script>

<jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <!-- Edit Tier Modal (Cấu hình Hạng thẻ - Đồng bộ) -->
    <div id="editTierModal" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm hidden transition-all">
        <div class="glass-panel w-full max-w-md bg-bg-surface border border-border-glass rounded-2xl p-6 relative shadow-[0_0_50px_rgba(0,0,0,0.8)]">
            <h3 class="text-xl font-display font-bold text-white mb-4 flex items-center gap-2">
                <i data-lucide="settings" class="w-5 h-5 text-[#00d4ff]"></i> Thay đổi mốc hạng thẻ
            </h3>
            
            <form action="${pageContext.request.contextPath}/admin/loyalty" method="POST">
                <input type="hidden" name="action" value="update_tier">
                <input type="hidden" id="editTierId" name="tierId">
                
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm text-text-muted mb-1 font-medium">Hạng Thành Viên</label>
                        <input type="text" id="editTierName" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-slate-400 font-bold outline-none" readonly>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Số lượt rửa tối thiểu</label>
                            <input type="number" id="editMinWashes" name="minWashes" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
                        </div>
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Chi tiêu tối thiểu (VND)</label>
                            <input type="number" id="editMinSpend" name="minSpend" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
                        </div>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Hệ số cộng điểm thưởng</label>
                            <input type="number" id="editPointsModifier" name="pointsModifier" step="0.01" min="0" max="1" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
                            <span class="text-[10px] text-text-muted mt-1 block">Ví dụ: 0.1 = +10% điểm</span>
                        </div>
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Số ngày đặt lịch trước</label>
                            <input type="number" id="editMaxBookingDays" name="maxBookingDays" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
                        </div>
                    </div>
                </div>
                
                <div class="mt-6 flex gap-3 justify-end">
                    <button type="button" onclick="closeEditTierModal()" class="px-4 py-2 bg-white/5 hover:bg-white/10 text-slate-300 rounded-xl text-sm font-medium transition-colors border border-border-glass">Huỷ</button>
                    <button type="submit" class="px-4 py-2 bg-[#00d4ff] hover:bg-cyan-400 text-black font-semibold rounded-xl text-sm transition-colors">Lưu Cấu Hình</button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />

    <!-- Mobile Bottom Navigation -->
    <jsp:include page="/WEB-INF/views/components/admin_bottom_nav.jsp">
        <jsp:param name="activeMenu" value="loyalty" />
    </jsp:include>
    
    <script>
        lucide.createIcons();

        function openEditTierModal(id, name, washes, spend, modifier, days) {
            document.getElementById('editTierId').value = id;
            document.getElementById('editTierName').value = name;
            document.getElementById('editMinWashes').value = washes;
            document.getElementById('editMinSpend').value = spend;
            document.getElementById('editPointsModifier').value = modifier;
            document.getElementById('editMaxBookingDays').value = days;
            
            document.getElementById('editTierModal').classList.remove('hidden');
        }

        function closeEditTierModal() {
            document.getElementById('editTierModal').classList.add('hidden');
        }
    </script>
</body>
</html>