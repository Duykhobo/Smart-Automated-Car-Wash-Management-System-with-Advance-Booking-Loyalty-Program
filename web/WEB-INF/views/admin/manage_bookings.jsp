<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
                <form method="GET" action="${pageContext.request.contextPath}/admin/bookings" class="flex items-center gap-3">
                    <div class="relative">
                        <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-text-muted"></i>
                        <input type="text" name="search" value="${currentSearch}" placeholder="Tìm biển số, SĐT..." class="pl-10 pr-4 py-2 bg-black/20 border border-white/10 rounded-xl text-sm focus:outline-none focus:border-[#00d4ff] text-white w-52 transition-all placeholder:text-gray-500">
                    </div>
                    
                    <input type="date" name="date" value="${currentDate}" style="color-scheme: dark;" class="px-3 py-2 bg-black/20 border border-white/10 rounded-xl text-sm focus:outline-none focus:border-[#00d4ff] text-white transition-all cursor-pointer">
                    
                    <input type="hidden" name="status" value="${currentStatus}">
                    
                    <button type="submit" class="flex items-center gap-2 px-4 py-2 bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/30 rounded-xl hover:bg-[#00d4ff]/20 transition-colors text-sm font-medium">
                        <i data-lucide="filter" class="w-4 h-4"></i>
                        Lọc
                    </button>
                    
                    <c:if test="${not empty currentDate or not empty currentSearch}">
                        <a href="${pageContext.request.contextPath}/admin/bookings?status=${currentStatus}" class="flex items-center gap-2 px-4 py-2 bg-red-500/10 text-red-400 border border-red-500/30 rounded-xl hover:bg-red-500/20 transition-colors text-sm font-medium">
                            <i data-lucide="x" class="w-4 h-4"></i>
                            Xóa lọc
                        </a>
                    </c:if>
                </form>
            </div>
        </header>

        <!-- Filters Strip -->
        <div class="flex gap-2 mb-6 overflow-x-auto pb-2">
            <a href="?status=All&search=${currentSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'All' || empty currentStatus ? 'bg-white/20 text-white border-white/30' : 'bg-white/10 text-white/70 border-white/10 hover:bg-white/20 hover:text-white'}">Tất cả</a>
            <a href="?status=Pending&search=${currentSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'Pending' ? 'bg-orange-500/20 text-orange-400 border-orange-500/40' : 'bg-orange-500/5 text-orange-400/70 border-orange-500/10 hover:bg-orange-500/10 hover:text-orange-400'}">Chờ xử lý (Pending)</a>
            <a href="?status=Confirmed&search=${currentSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'Confirmed' ? 'bg-blue-500/20 text-blue-400 border-blue-500/40' : 'bg-blue-500/5 text-blue-400/70 border-blue-500/10 hover:bg-blue-500/10 hover:text-blue-400'}">Đã xác nhận (Confirmed)</a>
            <a href="?status=InProgress&search=${currentSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'InProgress' ? 'bg-[#00d4ff]/20 text-[#00d4ff] border-[#00d4ff]/40' : 'bg-[#00d4ff]/5 text-[#00d4ff]/70 border-[#00d4ff]/10 hover:bg-[#00d4ff]/10 hover:text-[#00d4ff]'}">Đang rửa (In Process)</a>
            <a href="?status=Completed&search=${currentSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'Completed' ? 'bg-emerald-500/20 text-emerald-400 border-emerald-500/40' : 'bg-emerald-500/5 text-emerald-400/70 border-emerald-500/10 hover:bg-emerald-500/10 hover:text-emerald-400'}">Hoàn thành (Completed)</a>
            <a href="?status=Waitlisted&search=${currentSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'Waitlisted' ? 'bg-purple-500/20 text-purple-400 border-purple-500/40' : 'bg-purple-500/5 text-purple-400/70 border-purple-500/10 hover:bg-purple-500/10 hover:text-purple-400'}">Hàng đợi (Waitlisted)</a>
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
                        <c:choose>
                            <c:when test="${empty bookingList}">
                                <tr>
                                    <td colspan="7" class="px-6 py-8 text-center text-text-muted">
                                        Không có đơn đặt lịch nào.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="booking" items="${bookingList}">
                                    <tr class="hover:bg-white/[0.02] transition-colors">
                                        <td class="px-6 py-4 font-mono text-slate-300">BK-${booking.bookingId}</td>
                                        <td class="px-6 py-4">
                                            <div class="font-medium text-white">${booking.customerName}</div>
                                            <div class="text-xs text-text-muted">${booking.customerPhone}</div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="px-2.5 py-1 bg-white/10 border border-white/20 rounded text-xs font-mono font-bold tracking-wider">${booking.vehiclePlate}</span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="text-white">
                                                <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy" /> - 
                                                <fmt:formatDate value="${booking.scheduledTime}" pattern="HH:mm" />
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-slate-300">${booking.serviceName}</td>
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${booking.status eq 'Pending'}">
                                                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-orange-500/10 text-orange-400 border border-orange-500/20">
                                                        <span class="w-1.5 h-1.5 rounded-full bg-orange-400"></span> Pending
                                                    </span>
                                                </c:when>
                                                <c:when test="${booking.status eq 'Confirmed'}">
                                                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-blue-500/10 text-blue-400 border border-blue-500/20">
                                                        <i data-lucide="check" class="w-3 h-3"></i> Confirmed
                                                    </span>
                                                </c:when>
                                                <c:when test="${booking.status eq 'InProgress'}">
                                                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/20">
                                                        <span class="w-1.5 h-1.5 rounded-full bg-[#00d4ff] animate-pulse"></span> In Process
                                                    </span>
                                                </c:when>
                                                <c:when test="${booking.status eq 'Waitlisted'}">
                                                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-purple-500/10 text-purple-400 border border-purple-500/20">
                                                        <i data-lucide="clock" class="w-3 h-3"></i> Waitlisted
                                                    </span>
                                                </c:when>
                                                <c:when test="${booking.status eq 'No Show' || booking.status eq 'No-Show'}">
                                                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-red-500/10 text-red-400 border border-red-500/20">
                                                        <i data-lucide="user-x" class="w-3 h-3"></i> No-Show
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                                        <i data-lucide="check-circle" class="w-3 h-3"></i> ${booking.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 text-right">
                                            <form method="POST" action="${pageContext.request.contextPath}/admin/update-booking-status" class="inline-block">
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                <input type="hidden" name="currentFilterStatus" value="${currentStatus}" />
                                                <input type="hidden" name="currentFilterDate" value="${currentDate}" />
                                                <input type="hidden" name="currentSearch" value="${currentSearch}" />
                                                <input type="hidden" name="currentPage" value="${currentPage}" />
                                                
                                                <c:choose>
                                                    <c:when test="${booking.status eq 'Pending'}">
                                                        <input type="hidden" name="newStatus" value="Confirmed" />
                                                        <button type="submit" class="px-3 py-1.5 rounded-lg bg-blue-500/10 text-blue-400 hover:bg-blue-500/20 text-xs font-medium transition-colors border border-blue-500/30">
                                                            Đã Thu Tiền (Confirm)
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${booking.status eq 'Confirmed'}">
                                                        <input type="hidden" name="newStatus" value="InProgress" />
                                                        <button type="submit" class="px-3 py-1.5 rounded-lg bg-[#00d4ff]/10 text-[#00d4ff] hover:bg-[#00d4ff]/20 text-xs font-medium transition-colors border border-[#00d4ff]/30">
                                                            Cho xe vào khoang
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${booking.status eq 'InProgress'}">
                                                        <input type="hidden" name="newStatus" value="Completed" />
                                                        <button type="submit" class="px-3 py-1.5 rounded-lg bg-emerald-500/10 text-emerald-400 hover:bg-emerald-500/20 text-xs font-medium transition-colors border border-emerald-500/30">
                                                            Hoàn Thành
                                                        </button>
                                                    </c:when>
                                                </c:choose>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            
            <!-- Pagination -->
            <div class="px-6 py-4 border-t border-border-glass flex items-center justify-between text-sm">
                <div class="text-text-muted">
                    <c:choose>
                        <c:when test="${totalRecords == 0}">Không có kết quả nào</c:when>
                        <c:otherwise>
                            Hiển thị <span class="text-white font-medium">${(currentPage - 1) * 10 + 1}-${currentPage * 10 > totalRecords ? totalRecords : currentPage * 10}</span> trong <span class="text-white font-medium">${totalRecords}</span> kết quả
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${totalPages > 1}">
                    <div class="flex items-center gap-2">
                        <a href="?status=${currentStatus}&search=${currentSearch}&date=${currentDate}&page=${currentPage - 1}" class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white ${currentPage <= 1 ? 'pointer-events-none opacity-50' : ''}"><i data-lucide="chevron-left" class="w-4 h-4"></i></a>
                        
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="w-8 h-8 rounded bg-[#00d4ff]/20 border border-[#00d4ff]/30 flex items-center justify-center text-[#00d4ff] font-medium">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="?status=${currentStatus}&search=${currentSearch}&date=${currentDate}&page=${i}" class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white font-medium">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <a href="?status=${currentStatus}&search=${currentSearch}&date=${currentDate}&page=${currentPage + 1}" class="w-8 h-8 rounded bg-bg-primary border border-border-glass flex items-center justify-center text-text-muted hover:text-white ${currentPage >= totalPages ? 'pointer-events-none opacity-50' : ''}"><i data-lucide="chevron-right" class="w-4 h-4"></i></a>
                    </div>
                </c:if>
            </div>
        </div>
    </main>

    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/admin_manage_bookings.js?v=2"></script>
    <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>
