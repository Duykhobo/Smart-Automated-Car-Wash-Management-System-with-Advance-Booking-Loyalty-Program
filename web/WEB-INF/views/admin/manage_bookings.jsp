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
    <main class="flex-1 p-4 md:p-8 overflow-y-auto pb-[100px] md:pb-8">
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
                    
                    <input type="text" name="date" value="${currentDate}" class="flatpickr-date px-3 py-2 bg-black/20 border border-white/10 rounded-xl text-sm focus:outline-none focus:border-[#00d4ff] text-white transition-all cursor-pointer w-32">
                    
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
            <a href="?status=All&search=${encodedSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'All' || empty currentStatus ? 'bg-white/20 text-white border-white/30' : 'bg-white/10 text-white/70 border-white/10 hover:bg-white/20 hover:text-white'}">Tất cả</a>
            <a href="?status=Pending&search=${encodedSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'Pending' ? 'bg-orange-500/20 text-orange-400 border-orange-500/40' : 'bg-orange-500/5 text-orange-400/70 border-orange-500/10 hover:bg-orange-500/10 hover:text-orange-400'}">Chờ xử lý (Pending)</a>
            <a href="?status=Confirmed&search=${encodedSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'Confirmed' ? 'bg-blue-500/20 text-blue-400 border-blue-500/40' : 'bg-blue-500/5 text-blue-400/70 border-blue-500/10 hover:bg-blue-500/10 hover:text-blue-400'}">Đã xác nhận (Confirmed)</a>
            <a href="?status=InProgress&search=${encodedSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'InProgress' ? 'bg-[#00d4ff]/20 text-[#00d4ff] border-[#00d4ff]/40' : 'bg-[#00d4ff]/5 text-[#00d4ff]/70 border-[#00d4ff]/10 hover:bg-[#00d4ff]/10 hover:text-[#00d4ff]'}">Đang rửa (In Process)</a>
            <a href="?status=Completed&search=${encodedSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'Completed' ? 'bg-emerald-500/20 text-emerald-400 border-emerald-500/40' : 'bg-emerald-500/5 text-emerald-400/70 border-emerald-500/10 hover:bg-emerald-500/10 hover:text-emerald-400'}">Hoàn thành (Completed)</a>
            <a href="?status=Waitlisted&search=${encodedSearch}&date=${currentDate}" class="px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors border ${currentStatus eq 'Waitlisted' ? 'bg-purple-500/20 text-purple-400 border-purple-500/40' : 'bg-purple-500/5 text-purple-400/70 border-purple-500/10 hover:bg-purple-500/10 hover:text-purple-400'}">Hàng đợi (Waitlisted)</a>
        </div>

        <!-- Data Table -->
        <div class="glass-panel rounded-2xl overflow-hidden border border-white/10 shadow-[0_8px_32px_rgba(0,0,0,0.3)] relative">
            <div class="overflow-x-auto max-h-[60vh] custom-scrollbar">
                <table class="w-full text-sm text-left">
                    <thead class="text-xs text-text-muted uppercase bg-black/40 border-b border-white/10 sticky top-0 backdrop-blur-md z-10 shadow-sm">
                        <tr>
                            <th class="px-6 py-4 font-medium tracking-wider">Mã BK</th>
                            <th class="px-6 py-4 font-medium tracking-wider">Khách hàng</th>
                            <th class="px-6 py-4 font-medium tracking-wider">Biển số</th>
                            <th class="px-6 py-4 font-medium tracking-wider">Thời gian hẹn</th>
                            <th class="px-6 py-4 font-medium tracking-wider">Dịch vụ</th>
                            <th class="px-6 py-4 font-medium tracking-wider">Trạng thái</th>
                            <th class="px-6 py-4 font-medium text-right tracking-wider">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
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
                                    <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0">
                                        <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 font-mono text-slate-300">
                                            <span class="inline-block lg:hidden text-text-muted font-medium w-32">Mã Booking:</span>
                                            BK-${booking.bookingId}
                                        </td>
                                        <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                            <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Khách hàng:</span>
                                            <div class="inline-block align-top">
                                                <div class="font-medium text-white max-w-[150px] sm:max-w-[200px] truncate" title="${booking.customerName}">${booking.customerName}</div>
                                                <div class="text-xs text-text-muted">${booking.customerPhone}</div>
                                            </div>
                                        </td>
                                        <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                            <span class="inline-block lg:hidden text-text-muted font-medium w-32">Biển số:</span>
                                            <span class="px-2.5 py-1 bg-white/10 border border-white/20 rounded text-xs font-mono font-bold tracking-wider">${booking.vehiclePlate}</span>
                                        </td>
                                        <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                            <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Thời gian hẹn:</span>
                                            <div class="inline-block align-top text-white">
                                                <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy" /> - 
                                                <fmt:formatDate value="${booking.scheduledTime}" pattern="HH:mm" />
                                            </div>
                                        </td>
                                        <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4 text-slate-300">
                                            <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Dịch vụ:</span>
                                            <div class="inline-block align-top max-w-[200px] sm:max-w-xs truncate" title="${booking.serviceName}">${booking.serviceName}</div>
                                        </td>
                                        <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                            <span class="inline-block lg:hidden text-text-muted font-medium w-32">Trạng thái:</span>
                                            <jsp:include page="../components/status_badge.jsp">
                                                <jsp:param name="status" value="${booking.status}" />
                                            </jsp:include>
                                        </td>
                                        <td class="flex lg:table-cell items-center gap-3 px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                            <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                            <form method="POST" action="${pageContext.request.contextPath}/admin/update-booking-status" class="inline-block" id="updateForm_${booking.bookingId}">
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                <input type="hidden" name="currentFilterStatus" value="${currentStatus}" />
                                                <input type="hidden" name="currentFilterDate" value="${currentDate}" />
                                                <input type="hidden" name="currentSearch" value="${currentSearch}" />
                                                <input type="hidden" name="currentPage" value="${currentPage}" />
                                                <input type="hidden" name="newStatus" id="newStatus_${booking.bookingId}" value="" />
                                                <c:choose>
                                                    <c:when test="${booking.status eq 'Pending'}">
                                                        <button type="button" onclick="document.getElementById('newStatus_${booking.bookingId}').value='Confirmed'; showGlobalConfirmModal('Xác nhận Thu Tiền', 'Bạn xác nhận đã thu đủ tiền và muốn chuyển xe ${booking.vehiclePlate} sang trạng thái Đã xác nhận (Confirmed)?', 'Đồng ý', function() { document.getElementById('updateForm_${booking.bookingId}').submit(); })" class="px-3 py-1.5 rounded-lg bg-blue-500/10 text-blue-400 hover:bg-blue-500/20 text-xs font-medium transition-colors border border-blue-500/30">
                                                            Đã Thu Tiền (Confirm)
                                                        </button>
                                                        <button type="button" onclick="document.getElementById('newStatus_${booking.bookingId}').value='Cancelled'; showGlobalConfirmModal('Xác nhận Hủy', 'Bạn có chắc chắn muốn hủy lịch của xe ${booking.vehiclePlate}?', 'Hủy lịch', function() { document.getElementById('updateForm_${booking.bookingId}').submit(); })" class="px-3 py-1.5 rounded-lg bg-red-500/10 text-red-400 hover:bg-red-500/20 text-xs font-medium transition-colors border border-red-500/30 ml-2 mt-2 lg:mt-0">
                                                            Hủy
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${booking.status eq 'Confirmed'}">
                                                        <button type="button" onclick="document.getElementById('newStatus_${booking.bookingId}').value='InProgress'; showGlobalConfirmModal('Cho xe vào khoang', 'Xác nhận bắt đầu quá trình rửa cho xe ${booking.vehiclePlate}?', 'Bắt đầu rửa', function() { document.getElementById('updateForm_${booking.bookingId}').submit(); })" class="px-3 py-1.5 rounded-lg bg-[#00d4ff]/10 text-[#00d4ff] hover:bg-[#00d4ff]/20 text-xs font-medium transition-colors border border-[#00d4ff]/30">
                                                            Cho xe vào khoang
                                                        </button>
                                                        <button type="button" onclick="document.getElementById('newStatus_${booking.bookingId}').value='Cancelled'; showGlobalConfirmModal('Xác nhận Hủy', 'Bạn có chắc chắn muốn hủy lịch của xe ${booking.vehiclePlate}?', 'Hủy lịch', function() { document.getElementById('updateForm_${booking.bookingId}').submit(); })" class="px-3 py-1.5 rounded-lg bg-red-500/10 text-red-400 hover:bg-red-500/20 text-xs font-medium transition-colors border border-red-500/30 ml-2 mt-2 lg:mt-0">
                                                            Hủy
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${booking.status eq 'Waitlisted'}">
                                                        <button type="button" onclick="document.getElementById('newStatus_${booking.bookingId}').value='Cancelled'; showGlobalConfirmModal('Xác nhận Hủy', 'Bạn có chắc chắn muốn hủy chờ cho xe ${booking.vehiclePlate}?', 'Hủy', function() { document.getElementById('updateForm_${booking.bookingId}').submit(); })" class="px-3 py-1.5 rounded-lg bg-red-500/10 text-red-400 hover:bg-red-500/20 text-xs font-medium transition-colors border border-red-500/30">
                                                            Hủy (Waitlist)
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${booking.status eq 'InProgress'}">
                                                        <button type="button" onclick="document.getElementById('newStatus_${booking.bookingId}').value='Completed'; showGlobalConfirmModal('Xác nhận Hoàn thành', 'Bạn có chắc chắn xe ${booking.vehiclePlate} đã rửa xong? Hệ thống sẽ cộng điểm cho khách hàng.', 'Hoàn thành', function() { document.getElementById('updateForm_${booking.bookingId}').submit(); })" class="px-3 py-1.5 rounded-lg bg-emerald-500/10 text-emerald-400 hover:bg-emerald-500/20 text-xs font-medium transition-colors border border-emerald-500/30">
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
                <jsp:include page="../components/pagination.jsp">
                    <jsp:param name="currentPage" value="${currentPage}" />
                    <jsp:param name="totalPages" value="${totalPages}" />
                    <jsp:param name="url" value="?status=${currentStatus}&search=${encodedSearch}&date=${currentDate}&" />
                </jsp:include>
            </div>
        </div>
    </main>

    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/admin_manage_bookings.js?v=2"></script>
    <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />

    <!-- Mobile Bottom Navigation -->
    <jsp:include page="/WEB-INF/views/components/admin_bottom_nav.jsp">
        <jsp:param name="activeMenu" value="bookings" />
    </jsp:include>
</body>
</html>
