<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Lịch sử tích lũy điểm - AutoWash Pro</title>
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
            <div class="flex items-center gap-3">
                <a href="${pageContext.request.contextPath}/admin/customers" class="w-10 h-10 rounded-xl glass-panel bg-bg-surface border border-border-glass flex items-center justify-center hover:bg-bg-surface-hover transition-colors">
                    <i data-lucide="arrow-left" class="w-5 h-5 text-text-muted"></i>
                </a>
                <div>
                    <h2 class="text-3xl font-display font-bold text-white mb-1">Lịch sử điểm: ${cust.fullName}</h2>
                    <p class="text-text-muted">Số điện thoại: ${cust.phone} | Hạng hiện tại: ${cust.tierStatus}</p>
                </div>
            </div>
        </header>

        <!-- Customer Summary Card -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="glass-panel p-5 rounded-2xl border border-border-glass bg-bg-surface">
                <p class="text-text-muted text-xs uppercase tracking-wider mb-1 font-medium">Điểm hiện tại</p>
                <h3 class="text-3xl font-display font-bold text-[#00d4ff]"><fmt:formatNumber value="${cust.pointsBalance}" type="number" pattern="#,##0"/> <span class="text-sm font-sans font-normal">pts</span></h3>
            </div>
            <div class="glass-panel p-5 rounded-2xl border border-border-glass bg-bg-surface">
                <p class="text-text-muted text-xs uppercase tracking-wider mb-1 font-medium">Hạng thành viên</p>
                <h3 class="text-3xl font-display font-bold text-white">${cust.tierStatus}</h3>
            </div>
            <div class="glass-panel p-5 rounded-2xl border border-border-glass bg-bg-surface">
                <p class="text-text-muted text-xs uppercase tracking-wider mb-1 font-medium">Tổng tiền đã chi</p>
                <h3 class="text-3xl font-display font-bold text-emerald-400"><fmt:formatNumber value="${cust.totalSpend}" type="number" pattern="#,##0"/> ₫</h3>
            </div>
            <div class="glass-panel p-5 rounded-2xl border border-border-glass bg-bg-surface">
                <p class="text-text-muted text-xs uppercase tracking-wider mb-1 font-medium">Tổng số ca rửa</p>
                <h3 class="text-3xl font-display font-bold text-white">${cust.totalWashes} lượt</h3>
            </div>
        </div>

        <!-- Ledger Table -->
        <div class="glass-panel rounded-2xl bg-bg-surface border border-border-glass overflow-hidden">
            <div class="p-5 border-b border-border-glass bg-black/10">
                <h3 class="font-bold text-white text-lg">Sổ cái lịch sử biến động điểm</h3>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm whitespace-nowrap">
                    <thead class="bg-black/20 text-text-muted border-b border-border-glass">
                        <tr>
                            <th class="px-6 py-4 font-medium">ID Sổ cái</th>
                            <th class="px-6 py-4 font-medium">Loại phát sinh</th>
                            <th class="px-6 py-4 font-medium">Tham chiếu</th>
                            <th class="px-6 py-4 font-medium">Thay đổi điểm</th>
                            <th class="px-6 py-4 font-medium">Số dư sau GD</th>
                            <th class="px-6 py-4 font-medium">Ngày thực hiện</th>
                            <th class="px-6 py-4 font-medium">Hạn sử dụng</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-border-glass text-slate-300">
                        <c:forEach var="log" items="${historyList}">
                            <tr class="hover:bg-white/[0.02] transition-colors">
                                <td class="px-6 py-4 font-mono">#LD-${log.ledgerId}</td>
                                <td class="px-6 py-4">
                                    <c:choose>
                                        <c:when test="${log.referenceType eq 'Accrual'}">
                                            <span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                                Tích điểm (Accrual)
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-500/10 text-red-400 border border-red-500/20">
                                                Tiêu điểm (Redemption)
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 font-medium text-white">
                                    <c:choose>
                                        <c:when test="${log.referenceType eq 'Accrual'}">
                                            Lịch rửa xe: #BK-${log.referenceId}
                                        </c:when>
                                        <c:otherwise>
                                            Đổi Voucher: #VC-${log.referenceId}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 font-bold ${log.referenceType eq 'Accrual' ? 'text-emerald-400' : 'text-red-400'}">
                                    ${log.referenceType eq 'Accrual' ? '+' : '-'}<fmt:formatNumber value="${log.pointsChange}" type="number" pattern="#,##0"/> pts
                                </td>
                                <td class="px-6 py-4 text-white font-bold"><fmt:formatNumber value="${log.pointsRemaining}" type="number" pattern="#,##0"/> pts</td>
                                <td class="px-6 py-4">
                                    <fmt:formatDate value="${log.earnedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td class="px-6 py-4">
                                    <c:choose>
                                        <c:when test="${not empty log.expiryDate}">
                                            <fmt:formatDate value="${log.expiryDate}" pattern="dd/MM/yyyy"/>
                                            <c:if test="${log.isIsExpired()}">
                                                <span class="ml-2 text-xs text-red-400 font-bold bg-red-500/10 px-1.5 py-0.5 rounded">Đã hết hạn</span>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-text-muted">Vô thời hạn</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty historyList}">
                            <tr>
                                <td colspan="7" class="px-6 py-8 text-center text-text-muted">
                                    Khách hàng này chưa phát sinh giao dịch điểm nào.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <!-- Mobile Bottom Navigation -->
    <jsp:include page="/WEB-INF/views/components/admin_bottom_nav.jsp">
        <jsp:param name="activeMenu" value="customers" />
    </jsp:include>
    
    <script>
        lucide.createIcons();
    </script>
</body>
</html>