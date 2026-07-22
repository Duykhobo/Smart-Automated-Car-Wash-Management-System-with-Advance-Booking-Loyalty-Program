<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản lý Dịch Vụ - AutoWash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
</head>
<body class="bg-bg-primary text-text-primary antialiased overflow-x-hidden flex">

    <!-- Sidebar Component -->
    <jsp:include page="/WEB-INF/views/components/admin_sidebar.jsp">
        <jsp:param name="activeMenu" value="services" />
    </jsp:include>

    <!-- Main Content -->
    <main class="flex-1 p-4 md:p-8 overflow-y-auto pb-[120px] md:pb-8 w-full overflow-x-hidden">
        <!-- Header -->
        <header class="flex flex-col md:flex-row md:justify-between items-start md:items-center gap-4 mb-8">
            <div>
                <h2 class="text-3xl font-display font-bold text-white mb-1">Quản lý Dịch Vụ</h2>
                <p class="text-text-muted">Cập nhật bảng giá và các gói rửa xe cung cấp tại trạm.</p>
            </div>
            
            <button onclick="openCreateModal()" class="flex items-center gap-2 px-4 py-2.5 h-11 bg-gradient-to-r from-[#00d4ff] to-blue-500 text-black rounded-xl hover:opacity-90 transition-opacity font-bold shadow-[0_0_15px_rgba(0,212,255,0.3)]">
                <i data-lucide="plus" class="w-5 h-5"></i>
                Thêm Dịch Vụ Mới
            </button>
        </header>

        <!-- Services Table -->
        <div class="glass-panel rounded-2xl bg-bg-surface border border-border-glass overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm whitespace-nowrap lg:whitespace-normal">
                    <thead class="hidden lg:table-header-group bg-black/20 text-text-muted border-b border-border-glass whitespace-nowrap">
                        <tr>
                            <th class="px-6 py-4 font-medium">Tên Dịch Vụ</th>
                            <th class="px-6 py-4 font-medium">Giá Cơ Bản</th>
                            <th class="px-6 py-4 font-medium">Bảng Giá Cỡ Xe (Sedan / SUV / XLarge)</th>
                            <th class="px-6 py-4 font-medium">Thời gian</th>
                            <th class="px-6 py-4 font-medium text-center">Trạng Thái</th>
                            <th class="px-6 py-4 font-medium text-right">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-border-glass">
                        
                        <c:forEach var="service" items="${serviceList}">
                            <c:set var="iconName" value="activity"/>
                            <c:set var="iconColor" value="text-[#00d4ff]"/>
                            
                            <c:if test="${service.name.toLowerCase().contains('tiêu chuẩn') || service.name.toLowerCase().contains('ngoài') }">
                                <c:set var="iconName" value="droplet"/>
                                <c:set var="iconColor" value="text-[#00d4ff]"/>
                            </c:if>
                            <c:if test="${service.name.toLowerCase().contains('nội thất') || service.name.toLowerCase().contains('vệ sinh')}">
                                <c:set var="iconName" value="spray-can"/>
                                <c:set var="iconColor" value="text-amber-400"/>
                            </c:if>
                            <c:if test="${service.name.toLowerCase().contains('ceramic') || service.name.toLowerCase().contains('cao cấp') || service.name.toLowerCase().contains('wax')}">
                                <c:set var="iconName" value="sparkles"/>
                                <c:set var="iconColor" value="text-purple-400"/>
                            </c:if>

                            <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0 <c:if test='${not service.isIsActive()}'>opacity-60 grayscale</c:if>">
                                <td class="block lg:table-cell px-2 lg:px-6 py-2.5 h-11 lg:py-4">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32 align-top mt-3">Tên Dịch Vụ:</span>
                                    <div class="inline-flex lg:flex items-center gap-4 align-top">
                                        <div class="w-12 h-12 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center">
                                            <i data-lucide="${iconName}" class="w-6 h-6 ${iconColor}"></i>
                                        </div>
                                        <div>
                                            <div class="font-bold text-white text-base">
                                                ${service.name}
                                                <c:choose>
                                                    <c:when test="${service.serviceType == 'Main'}">
                                                        <span class="ml-2 px-2 py-0.5 rounded text-[10px] uppercase font-bold bg-[#00d4ff]/20 text-[#00d4ff] align-middle">Gói Chính</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="ml-2 px-2 py-0.5 rounded text-[10px] uppercase font-bold bg-amber-500/20 text-amber-500 align-middle">Thêm</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="text-xs text-text-muted">Mã ID dịch vụ: #${service.serviceId}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2.5 h-11 lg:py-4">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32">Giá Cơ Bản:</span>
                                    <span class="font-display font-bold text-base text-slate-300">
                                        <fmt:formatNumber value="${service.basePrice}" type="number" pattern="#,##0"/>đ
                                    </span>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2.5 h-11 lg:py-4">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32">Bảng Giá Cỡ Xe:</span>
                                    <span class="font-display text-sm space-x-2">
                                        <span class="px-2 py-0.5 bg-[#00d4ff]/10 text-[#00d4ff] border border-[#00d4ff]/20 rounded text-xs">
                                            Sedan: <fmt:formatNumber value="${service.priceSedan}" type="number" pattern="#,##0"/>đ
                                        </span>
                                        <span class="px-2 py-0.5 bg-amber-500/10 text-amber-400 border border-amber-500/20 rounded text-xs">
                                            SUV: <fmt:formatNumber value="${service.priceSuv}" type="number" pattern="#,##0"/>đ
                                        </span>
                                        <span class="px-2 py-0.5 bg-purple-500/10 text-purple-400 border border-purple-500/20 rounded text-xs">
                                            XLarge: <fmt:formatNumber value="${service.priceXlarge}" type="number" pattern="#,##0"/>đ
                                        </span>
                                    </span>
                                </td>
                                <td class="block lg:table-cell px-2 lg:px-6 py-2.5 h-11 lg:py-4">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32 align-top">Thời gian:</span>
                                    <span class="inline-flex lg:flex items-center gap-1.5 text-slate-300 align-top">
                                        <i data-lucide="clock" class="w-4 h-4 text-text-muted"></i> ${service.durationMinutes} phút
                                    </span>
                                </td>
                                <td class="flex justify-between lg:table-cell lg:text-center px-2 lg:px-6 py-2.5 h-11 lg:py-4">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32">Trạng Thái:</span>
                                    
                                    <!-- Form đồng bộ để bật/tắt dịch vụ (Tải lại trang, Không AJAX) -->
                                    <form id="toggleForm_${service.serviceId}" action="${pageContext.request.contextPath}/admin/services" method="POST" class="inline" data-auto-validate="true">
                                        <input type="hidden" name="action" value="toggle">
                                        <input type="hidden" name="serviceId" value="${service.serviceId}">
                                        <input type="hidden" name="isActive" value="${not service.isIsActive()}">
                                        
                                        <label class="relative inline-flex items-center cursor-pointer">
                                          <input type="checkbox" <c:if test="${service.isIsActive()}">checked</c:if> class="sr-only peer" onchange="document.getElementById('toggleForm_${service.serviceId}').submit()">
                                          <div class="w-11 h-6 bg-slate-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-[#00d4ff]"></div>
                                        </label>
                                    </form>
                                </td>
                                <td class="flex lg:table-cell justify-between items-center px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                    <span class="inline-block lg:hidden text-text-muted font-medium w-full sm:w-32">Thao tác:</span>
                                    <div class="flex items-center justify-end gap-2">
                                        <button class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center transition-colors border border-transparent hover:border-border-glass bg-white/5 hover:bg-white/10" 
                                                onclick="openEditModal(${service.serviceId}, '${service.name.replace("'", "\\'")}', ${service.basePrice}, ${service.durationMinutes}, '${service.isIsActive()}', '${service.serviceType}')">
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

    <!-- Create Service Modal -->
    <div id="createServiceModal" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm hidden transition-all">
        <div class="glass-panel w-full max-w-lg bg-bg-surface border border-border-glass rounded-2xl p-6 relative shadow-[0_0_50px_rgba(0,0,0,0.8)]">
            <h3 class="text-xl font-display font-bold text-white mb-4 flex items-center gap-2">
                <i data-lucide="plus-circle" class="w-5 h-5 text-[#00d4ff]"></i> Thêm Dịch Vụ Mới
            </h3>
            
            <form action="${pageContext.request.contextPath}/admin/services" method="POST" data-auto-validate="true">
                <input type="hidden" name="action" value="create">
                
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm text-text-muted mb-1 font-medium">Tên Dịch Vụ</label>
                        <input type="text" name="name" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" placeholder="Ví dụ: Rửa Wax bóng cao cấp" required>
                    </div>
                    <div>
                        <label class="block text-sm text-text-muted mb-1 font-medium">Loại Dịch Vụ</label>
                        <select name="serviceType" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all cursor-pointer">
                            <option value="Main">Gói Chính (Chỉ chọn 1)</option>
                            <option value="Addon">Dịch Vụ Thêm (Tùy chọn)</option>
                        </select>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Giá Cơ Bản (VND)</label>
                            <input type="number" name="basePrice" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" placeholder="150000" required>
                        </div>
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Thời lượng (Phút)</label>
                            <input type="number" name="duration" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" placeholder="45" required>
                        </div>
                    </div>
                    
                    <div class="p-4 rounded-xl bg-white/5 border border-border-glass space-y-3">
                        <p class="text-xs text-[#00d4ff] font-bold uppercase tracking-wider">Thông tin tính giá</p>
                        <div class="text-sm text-slate-300">
                            Hệ thống sẽ tự động tính toán giá cho các cỡ xe SEDAN, SUV, và XLARGE dựa trên Giá Gốc và Cấu hình Hệ số cỡ xe.
                            <br>
                            <a href="${pageContext.request.contextPath}/admin/config" class="text-[#00d4ff] hover:underline mt-2 inline-block">Cấu hình Hệ số tại đây &rarr;</a>
                        </div>
                    </div>
                </div>
                
                <div class="mt-6 flex gap-3 justify-end">
                    <button type="button" onclick="closeCreateModal()" class="px-4 py-2.5 h-11 bg-white/5 hover:bg-white/10 text-slate-300 rounded-xl text-sm font-medium transition-colors border border-border-glass">Huỷ</button>
                    <button type="submit" class="px-4 py-2.5 h-11 bg-[#00d4ff] hover:bg-cyan-400 text-black font-semibold rounded-xl text-sm transition-colors">Tạo Mới</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit Service Modal -->
    <div id="editServiceModal" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm hidden transition-all">
        <div class="glass-panel w-full max-w-lg bg-bg-surface border border-border-glass rounded-2xl p-6 relative shadow-[0_0_50px_rgba(0,0,0,0.8)]">
            <h3 class="text-xl font-display font-bold text-white mb-4 flex items-center gap-2">
                <i data-lucide="edit-3" class="w-5 h-5 text-[#00d4ff]"></i> Chỉnh Sửa Dịch Vụ
            </h3>
            
            <form action="${pageContext.request.contextPath}/admin/services" method="POST" data-auto-validate="true">
                <input type="hidden" name="action" value="update">
                <input type="hidden" id="editServiceId" name="serviceId">
                
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm text-text-muted mb-1 font-medium">Tên Dịch Vụ</label>
                        <input type="text" id="editServiceName" name="name" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
                    </div>
                    <div>
                        <label class="block text-sm text-text-muted mb-1 font-medium">Loại Dịch Vụ</label>
                        <select name="serviceType" id="editServiceType" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all cursor-pointer">
                            <option value="Main">Gói Chính (Chỉ chọn 1)</option>
                            <option value="Addon">Dịch Vụ Thêm (Tùy chọn)</option>
                        </select>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Giá Cơ Bản (VND)</label>
                            <input type="number" id="editBasePrice" name="basePrice" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
                        </div>
                        <div>
                            <label class="block text-sm text-text-muted mb-1 font-medium">Thời gian (Phút)</label>
                            <input type="number" id="editDuration" name="duration" class="w-full bg-slate-800 border border-border-glass rounded-xl px-4 py-2.5 text-white focus:border-[#00d4ff] outline-none transition-all" required>
                        </div>
                    </div>
                    
                    <div class="p-4 rounded-xl bg-white/5 border border-border-glass space-y-3">
                        <p class="text-xs text-[#00d4ff] font-bold uppercase tracking-wider">Thông tin tính giá</p>
                        <div class="text-sm text-slate-300">
                            Hệ thống sẽ tự động tính toán giá cho các cỡ xe SEDAN, SUV, và XLARGE dựa trên Giá Gốc và Cấu hình Hệ số cỡ xe.
                            <br>
                            <a href="${pageContext.request.contextPath}/admin/config" class="text-[#00d4ff] hover:underline mt-2 inline-block">Cấu hình Hệ số tại đây &rarr;</a>
                        </div>
                    </div>
                    
                    <div class="flex items-center justify-between">
                        <label class="text-sm text-text-muted font-medium">Kích hoạt hoạt động</label>
                        <label class="relative inline-flex items-center cursor-pointer">
                            <input type="checkbox" id="editIsActive" name="isActive" class="sr-only peer">
                            <div class="w-11 h-6 bg-slate-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-[#00d4ff]"></div>
                        </label>
                    </div>
                </div>
                
                <div class="mt-6 flex gap-3 justify-end">
                    <button type="button" onclick="closeEditModal()" class="px-4 py-2.5 h-11 bg-white/5 hover:bg-white/10 text-slate-300 rounded-xl text-sm font-medium transition-colors border border-border-glass">Huỷ</button>
                    <button type="submit" class="px-4 py-2.5 h-11 bg-[#00d4ff] hover:bg-cyan-400 text-black font-semibold rounded-xl text-sm transition-colors">Lưu Thay Đổi</button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />

    <!-- Mobile Bottom Navigation -->
    <jsp:include page="/WEB-INF/views/components/admin_bottom_nav.jsp">
        <jsp:param name="activeMenu" value="services" />
    </jsp:include>
    
    <script>
        lucide.createIcons();

        function openCreateModal() {
            document.getElementById('createServiceModal').classList.remove('hidden');
        }

        function closeCreateModal() {
            document.getElementById('createServiceModal').classList.add('hidden');
        }

        function openEditModal(id, name, basePrice, duration, isActive, serviceType) {
            document.getElementById('editServiceId').value = id;
            document.getElementById('editServiceName').value = name;
            document.getElementById('editBasePrice').value = basePrice;
            document.getElementById('editDuration').value = duration;
            document.getElementById('editIsActive').checked = (isActive === 'true');
            document.getElementById('editServiceType').value = serviceType || 'Main';
            
            document.getElementById('editServiceModal').classList.remove('hidden');
        }

        function closeEditModal() {
            document.getElementById('editServiceModal').classList.add('hidden');
        }
    </script>
</body>
</html>