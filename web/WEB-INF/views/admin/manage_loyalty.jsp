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
            
            <button onclick="showToast('Chức năng tạo Voucher do thành viên khác phát triển.', 'info')" class="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-[#00d4ff] to-blue-500 text-black rounded-xl hover:opacity-90 transition-opacity font-bold shadow-[0_0_15px_rgba(0,212,255,0.3)]">
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
                    <p class="text-2xl font-display font-bold text-white">${activeVouchersCount}</p>
                </div>
            </div>
            <div class="glass-panel p-5 rounded-2xl border border-border-glass bg-bg-surface flex items-center gap-4">
                <div class="w-12 h-12 rounded-full bg-amber-500/10 flex items-center justify-center">
                    <i data-lucide="arrow-right-left" class="w-6 h-6 text-amber-400"></i>
                </div>
                <div>
                    <p class="text-text-muted text-xs uppercase tracking-wider mb-1">Lượt Đổi Tháng Này</p>
                    <p class="text-2xl font-display font-bold text-white">${redemptionsThisMonth}</p>
                </div>
            </div>
            <div class="glass-panel p-5 rounded-2xl border border-[#00d4ff]/20 bg-[#00d4ff]/5 flex items-center gap-4">
                <div class="w-12 h-12 rounded-full bg-[#00d4ff]/10 flex items-center justify-center">
                    <i data-lucide="coins" class="w-6 h-6 text-[#00d4ff]"></i>
                </div>
                <div>
                    <p class="text-[#00d4ff]/70 text-xs uppercase tracking-wider mb-1">Tổng Điểm Đã Tiêu</p>
                    <p class="text-2xl font-display font-bold text-[#00d4ff]"><fmt:formatNumber value="${totalPointsSpent}" type="number" pattern="#,##0"/> <span class="text-sm font-sans font-normal">pts</span></p>
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
                <h3 class="font-bold text-white text-lg">Danh sách Voucher trong Cửa Hàng (Bạn của bạn phụ trách xử lý)</h3>
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
                        <c:forEach var="item" items="${rewardList}">
                            <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0 <c:if test='${not item.isIsActive()}'>opacity-60 grayscale</c:if>">
                                <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-2">Tên quà:</span>
                                    <div class="inline-flex lg:flex items-center gap-3 align-top">
                                        <div class="w-10 h-10 rounded-xl bg-gradient-to-br <c:choose><c:when test='${item.imageIcon eq "percent"}'>from-[#00d4ff] to-blue-500</c:when><c:when test='${item.imageIcon eq "tag"}'>from-amber-400 to-orange-500</c:when><c:otherwise>from-purple-500 to-pink-500</c:otherwise></c:choose> flex items-center justify-center shadow-[0_0_10px_rgba(0,212,255,0.2)]">
                                            <i data-lucide="${not empty item.imageIcon ? item.imageIcon : 'ticket'}" class="w-5 h-5 text-black"></i>
                                        </div>
                                        <div>
                                            <div class="font-bold text-white text-base">${item.rewardName}</div>
                                            <div class="text-xs text-text-muted font-mono tracking-wider">${item.rewardType}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-32">Mô Tả:</span>
                                    <span>${item.description}</span>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 font-display font-bold text-amber-400">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-32 font-sans font-normal">Điểm Quy Đổi:</span>
                                    <fmt:formatNumber value="${item.pointsCost}" type="number" pattern="#,##0"/> <span class="text-xs font-sans font-normal text-amber-400/70">pts</span>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-32">Trạng thái:</span>
                                    <c:choose>
                                        <c:when test="${item.isIsActive()}">
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
                                        <button class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center transition-colors border border-transparent hover:border-border-glass bg-white/5 hover:bg-white/10"
                                                onclick="showToast('Chức năng sửa Voucher thuộc quyền quản lý của thành viên khác.', 'info')">
                                            <i data-lucide="edit-3" class="w-4 h-4"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

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
                            <input type="number" id="editMinWashes" name="minWashes" class="w-full bg-bg-primary border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
                        </div>
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Chi tiêu tối thiểu (VND)</label>
                            <input type="number" id="editMinSpend" name="minSpend" class="w-full bg-bg-primary border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
                        </div>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Hệ số cộng điểm thưởng</label>
                            <input type="number" id="editPointsModifier" name="pointsModifier" step="0.01" min="0" max="1" class="w-full bg-bg-primary border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
                            <span class="text-[10px] text-text-muted mt-1 block">Ví dụ: 0.1 = +10% điểm</span>
                        </div>
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Số ngày đặt lịch trước</label>
                            <input type="number" id="editMaxBookingDays" name="maxBookingDays" class="w-full bg-bg-primary border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
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