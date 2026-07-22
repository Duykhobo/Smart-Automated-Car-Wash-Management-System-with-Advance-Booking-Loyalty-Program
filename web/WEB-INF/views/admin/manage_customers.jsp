<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản lý Khách Hàng - AutoWash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
</head>
<body class="bg-bg-primary text-text-primary antialiased overflow-x-hidden flex">

    <!-- Sidebar Component -->
    <jsp:include page="/WEB-INF/views/components/admin_sidebar.jsp">
        <jsp:param name="activeMenu" value="customers" />
    </jsp:include>

    <!-- Main Content -->
    <main class="flex-1 p-4 md:p-8 overflow-y-auto pb-[120px] md:pb-8">
        <!-- Header -->
        <header class="flex flex-col md:flex-row md:justify-between items-start md:items-center gap-4 mb-8">
            <div>
                <h2 class="text-3xl font-display font-bold text-white mb-1">Khách Hàng & Loyalty</h2>
                <p class="text-text-muted">Quản lý danh sách thành viên, hạng thẻ và lịch sử tích điểm.</p>
            </div>
            
            <div class="flex flex-col sm:flex-row items-stretch sm:items-center gap-4 w-full md:w-auto">
                <form action="${pageContext.request.contextPath}/admin/customers" method="GET" class="relative">
                    <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-text-muted"></i>
                    <input type="text" name="search" value="<c:out value='${currentSearch}'/>" placeholder="Tìm tên, SĐT, biển số..." class="pl-10 pr-4 py-2.5 h-11 bg-slate-800 border border-border-glass rounded-xl text-sm focus:outline-none focus:border-[#00d4ff] text-white w-64 transition-all">
                </form>
                <button class="flex items-center gap-2 px-4 py-2.5 h-11 bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30 rounded-xl hover:bg-[#00d4ff]/20 transition-colors text-sm font-medium">
                    <i data-lucide="download" class="w-4 h-4"></i>
                    Xuất Excel
                </button>
            </div>
        </header>

        <!-- Stats Overview -->
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
            <div class="glass-panel p-4 rounded-xl border border-border-glass bg-bg-surface text-center">
                <p class="text-text-muted text-xs uppercase tracking-wider mb-1">Tổng Thành Viên</p>
                <p class="text-2xl font-display font-bold text-white">${totalMembers}</p>
            </div>
            <div class="glass-panel p-4 rounded-xl border border-border-glass bg-bg-surface text-center">
                <p class="text-text-muted text-xs uppercase tracking-wider mb-1">Khách Mới (Tháng)</p>
                <p class="text-2xl font-display font-bold text-emerald-400">+${newMembersThisMonth}</p>
            </div>
            <div class="glass-panel p-4 rounded-xl border border-amber-500/20 bg-amber-500/5 text-center">
                <p class="text-amber-500/70 text-xs uppercase tracking-wider mb-1">Hội Viên Gold/Platinum</p>
                <p class="text-2xl font-display font-bold text-amber-400">${goldPlatPercentage}%</p>
            </div>
            <div class="glass-panel p-4 rounded-xl border border-[#00d4ff]/20 bg-[#00d4ff]/5 text-center">
                <p class="text-[#00d4ff]/70 text-xs uppercase tracking-wider mb-1">Tổng Điểm Đã Cấp</p>
                <p class="text-2xl font-display font-bold text-[#00d4ff]"><fmt:formatNumber value="${totalPointsCapped}" type="number" pattern="#,##0"/></p>
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
                        <c:forEach var="cust" items="${customerList}">
                            <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0">
                                <td class="block lg:table-cell px-2 lg:px-6 py-2.5 h-11 lg:py-4">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32 align-top mt-2">Khách hàng:</span>
                                    <div class="inline-flex lg:flex items-center gap-3 align-top">
                                        <c:choose>
                                            <c:when test="${not empty cust.avatar}">
                                                <img src="${pageContext.request.contextPath}/${cust.avatar}" class="w-10 h-10 rounded-full object-cover shadow-[0_0_10px_rgba(0,212,255,0.3)]" alt="Avatar"/>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="w-10 h-10 rounded-full bg-gradient-to-br <c:choose><c:when test="${cust.tierStatus eq 'Platinum'}">from-cyan-300 to-[#00d4ff]</c:when><c:when test="${cust.tierStatus eq 'Gold'}">from-amber-300 to-amber-600</c:when><c:when test="${cust.tierStatus eq 'Silver'}">from-slate-400 to-slate-200</c:when><c:otherwise>from-slate-600 to-slate-800</c:otherwise></c:choose> flex items-center justify-center font-bold <c:choose><c:when test="${cust.tierStatus eq 'Member'}">text-slate-300</c:when><c:otherwise>text-black</c:otherwise></c:choose>">
                                                    ${cust.fullName.substring(0, 1).toUpperCase()}
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="font-medium text-white">${cust.fullName}</div>
                                    </div>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2.5 h-11 lg:py-4 text-slate-300">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32 align-top">Liên hệ:</span>
                                    <div class="inline-block align-top">
                                        <div>${cust.phone}</div>
                                        <div class="text-xs text-text-muted">${cust.email}</div>
                                    </div>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2.5 h-11 lg:py-4">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32 align-top">Biển số xe:</span>
                                    <div class="inline-flex lg:flex flex-col gap-1 align-top">
                                        <c:choose>
                                            <c:when test="${not empty cust.licensePlate}">
                                                <span class="px-2 py-0.5 bg-white/10 rounded text-xs font-mono w-max">${cust.licensePlate}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-xs text-text-muted">Chưa đăng ký xe</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2.5 h-11 lg:py-4">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32">Hạng thẻ:</span>
                                    <c:choose>
                                        <c:when test="${cust.tierStatus eq 'Platinum'}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-[#00d4ff]/20 text-[#00d4ff] border border-[#00d4ff]/40 shadow-[0_0_10px_rgba(0,212,255,0.2)]">
                                                <i data-lucide="crown" class="w-3 h-3"></i> Platinum
                                            </span>
                                        </c:when>
                                        <c:when test="${cust.tierStatus eq 'Gold'}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-amber-500/20 text-amber-400 border border-amber-500/40 shadow-[0_0_10px_rgba(245,158,11,0.2)]">
                                                <i data-lucide="star" class="w-3 h-3"></i> Gold
                                            </span>
                                        </c:when>
                                        <c:when test="${cust.tierStatus eq 'Silver'}">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-slate-500/20 text-slate-300 border border-slate-500/40">
                                                <i data-lucide="shield" class="w-3 h-3"></i> Silver
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-medium bg-slate-800 text-slate-400 border border-slate-700">
                                                <i data-lucide="user" class="w-3 h-3"></i> Member
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2.5 h-11 lg:py-4 font-display font-bold text-white">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32 font-sans font-normal">Điểm khả dụng:</span>
                                    <fmt:formatNumber value="${cust.pointsBalance}" type="number" pattern="#,##0"/> <span class="text-xs font-sans font-normal text-[#00d4ff]">pts</span>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2.5 h-11 lg:py-4 text-slate-300">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32">Lượt rửa:</span>
                                    ${cust.totalWashes} lượt
                                </td>
                                <td class="flex lg:table-cell items-center gap-3 px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32">Thao tác:</span>
                                    <a href="${pageContext.request.contextPath}/admin/loyalty/history?customerId=${cust.customerId}" class="whitespace-nowrap inline-flex items-center justify-center px-3 py-1.5 rounded-lg bg-white/5 text-slate-300 hover:bg-white/10 hover:text-white text-xs font-medium transition-colors border border-border-glass">
                                        Lịch sử điểm
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty customerList}">
                            <tr class="block lg:table-row border-b border-border-glass">
                                <td colspan="7" class="px-6 py-8 text-center text-text-muted">
                                    Không tìm thấy khách hàng nào khớp với tìm kiếm.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
            <!-- Pagination -->
            <div class="px-6 py-4 border-t border-border-glass flex items-center justify-between text-sm">
                <div class="text-text-muted">
                    Hiển thị <span class="text-white font-medium">${(currentPage - 1) * 10 + 1} - <c:choose><c:when test="${currentPage * 10 > totalRecords}">${totalRecords}</c:when><c:otherwise>${currentPage * 10}</c:otherwise></c:choose></span> trong <span class="text-white font-medium">${totalRecords}</span> kết quả
                </div>
                <div class="flex items-center gap-2">
                    <a href="?page=${currentPage - 1}&search=${encodedSearch}" class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white <c:if test='${currentPage == 1}'>pointer-events-none opacity-50</c:if>">
                        <i data-lucide="chevron-left" class="w-4 h-4"></i>
                    </a>
                    
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="w-8 h-8 rounded bg-[#00d4ff]/20 border border-[#00d4ff]/30 flex items-center justify-center text-[#00d4ff] font-medium">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?page=${i}&search=${encodedSearch}" class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white font-medium">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <a href="?page=${currentPage + 1}&search=${encodedSearch}" class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white <c:if test='${currentPage == totalPages}'>pointer-events-none opacity-50</c:if>">
                        <i data-lucide="chevron-right" class="w-4 h-4"></i>
                    </a>
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
    
    <script>
        lucide.createIcons();
    </script>
</body>
</html>