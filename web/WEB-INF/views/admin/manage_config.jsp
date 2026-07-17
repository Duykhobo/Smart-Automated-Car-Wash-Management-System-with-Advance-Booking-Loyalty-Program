<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Cấu Hình Hệ Thống - AutoWash Pro</title>
        <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
    </head>
    <body class="bg-bg-primary text-text-primary antialiased overflow-x-hidden selection:bg-[#00d4ff] selection:text-black flex">

        <!-- Sidebar Component -->
        <jsp:include page="/WEB-INF/views/components/admin_sidebar.jsp">
            <jsp:param name="activeMenu" value="config" />
        </jsp:include>

    <!-- Main Content -->
    <main class="flex-1 p-4 md:p-8 overflow-y-auto pb-[100px] md:pb-8">
        <!-- Header -->
        <header class="flex justify-between items-center mb-8">
            <div>
                <h2 class="text-3xl font-display font-bold text-white mb-1">Cấu Hình Hệ Thống</h2>
                <p class="text-text-muted">Quản lý các tham số vận hành chung của trạm rửa xe.</p>
            </div>
            
            <button type="submit" form="configForm" class="flex items-center gap-2 px-6 py-2.5 bg-[#00d4ff] text-black rounded-xl hover:bg-cyan-400 transition-colors font-bold shadow-[0_0_15px_rgba(0,212,255,0.3)]">
                <i data-lucide="save" class="w-5 h-5"></i>
                Lưu Thay Đổi
            </button>
        </header>

        <form id="configForm" method="POST" action="${pageContext.request.contextPath}/admin/config" class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            
            <!-- Settings Panel: Vận Hành Trạm -->
            <div class="glass-panel p-6 rounded-2xl border border-border-glass bg-bg-surface">
                <div class="flex items-center gap-3 mb-6 border-b border-border-glass pb-4">
                    <div class="w-10 h-10 rounded-full bg-blue-500/10 flex items-center justify-center">
                        <i data-lucide="factory" class="w-5 h-5 text-blue-400"></i>
                    </div>
                    <h3 class="text-xl font-bold text-white">Vận Hành Trạm</h3>
                </div>

                <div class="space-y-6">
                    <!-- Giờ hoạt động -->
                    <div>
                        <label class="block text-sm font-medium text-slate-300 mb-2">Giờ Mở/Đóng Cửa</label>
                        <div class="flex items-center gap-4">
                            <input type="time" name="OpeningHour" value="${empty configs['OpeningHour'] ? '07' : (configs['OpeningHour'].length() == 1 ? '0'.concat(configs['OpeningHour']) : configs['OpeningHour'])}:00" class="flex-1 bg-black/40 border border-border-glass rounded-xl px-4 py-2 text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                            <span class="text-text-muted">đến</span>
                            <input type="time" name="ClosingHour" value="${empty configs['ClosingHour'] ? '21' : (configs['ClosingHour'].length() == 1 ? '0'.concat(configs['ClosingHour']) : configs['ClosingHour'])}:00" class="flex-1 bg-black/40 border border-border-glass rounded-xl px-4 py-2 text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                        </div>
                        <p class="text-xs text-text-muted mt-2">Hệ thống Booking sẽ khóa các khung giờ ngoài khoảng thời gian này.</p>
                    </div>

                    <!-- Sức chứa -->
                    <div>
                        <label class="block text-sm font-medium text-slate-300 mb-2">Sức Chứa Tối Đa (Slot / Khung Giờ)</label>
                        <input type="number" name="MaxSlotCapacity" value="${empty configs['MaxSlotCapacity'] ? '3' : configs['MaxSlotCapacity']}" min="1" max="10" class="w-full bg-black/40 border border-border-glass rounded-xl px-4 py-2 text-white focus:outline-none focus:border-[#00d4ff] transition-colors">
                        <p class="text-xs text-text-muted mt-2">Số lượng xe tối đa có thể phục vụ trong cùng một khung giờ 30 phút.</p>
                    </div>
                    
                    <!-- Thời gian giữ chỗ -->
                    <div>
                        <label class="block text-sm font-medium text-slate-300 mb-2">Thời Gian Giữ Chỗ (Grace Period)</label>
                        <select name="GracePeriodMinutes" class="custom-select">
                            <option value="5" ${configs['GracePeriodMinutes'] == '5' ? 'selected' : ''}>5 phút</option>
                            <option value="10" ${configs['GracePeriodMinutes'] == '10' ? 'selected' : ''}>10 phút</option>
                            <option value="15" ${empty configs['GracePeriodMinutes'] || configs['GracePeriodMinutes'] == '15' ? 'selected' : ''}>15 phút</option>
                            <option value="30" ${configs['GracePeriodMinutes'] == '30' ? 'selected' : ''}>30 phút</option>
                        </select>
                        <p class="text-xs text-text-muted mt-2">Nếu khách đến trễ quá thời gian này, Booking sẽ tự động chuyển sang No-Show.</p>
                    </div>
                </div>
            </div>

                    <!-- Settings Panel: Vận Hành Trạm -->
                    <div class="glass-panel p-6 rounded-2xl border border-border-glass bg-bg-surface">
                        <div class="flex items-center gap-3 mb-6 border-b border-border-glass pb-4">
                            <div class="w-10 h-10 rounded-full bg-blue-500/10 flex items-center justify-center">
                                <i data-lucide="factory" class="w-5 h-5 text-blue-400"></i>
                            </div>
                            <h3 class="text-xl font-bold text-white">Vận Hành Trạm</h3>
                        </div>

                    <div class="space-y-6">
                        <div>
                            <label class="block text-sm font-medium text-slate-300 mb-2">Tỷ lệ quy đổi điểm (Điểm / VNĐ)</label>
                            <div class="flex items-center gap-2">
                                <span class="text-white font-medium">1,000đ</span>
                                <i data-lucide="arrow-right" class="w-4 h-4 text-text-muted"></i>
                                <input type="number" name="PointsPerCurrencyUnit" value="${empty configs['PointsPerCurrencyUnit'] ? '1' : configs['PointsPerCurrencyUnit']}" class="w-24 bg-black/40 border border-border-glass rounded-xl px-4 py-2 text-center text-white focus:outline-none focus:border-[#00d4ff]">
                                <span class="text-text-muted">điểm</span>
                            </div>
                        </div>
                    </div>

                        <div class="border-t border-border-glass pt-4">
                            <label class="block text-sm font-medium text-slate-300 mb-3">Hệ số cộng điểm theo Hạng</label>
                            <div class="space-y-3">
                                <div class="flex items-center justify-between">
                                    <span class="text-slate-400 text-sm">Silver</span>
                                    <input type="number" name="Multiplier_Silver" value="${empty configs['Multiplier_Silver'] ? '1.1' : configs['Multiplier_Silver']}" step="0.1" class="w-24 bg-black/40 border border-border-glass rounded-lg px-3 py-1.5 text-center text-white text-sm focus:outline-none focus:border-[#00d4ff]">
                                </div>
                                <div class="flex items-center justify-between">
                                    <span class="text-amber-400 text-sm font-medium">Gold</span>
                                    <input type="number" name="Multiplier_Gold" value="${empty configs['Multiplier_Gold'] ? '1.2' : configs['Multiplier_Gold']}" step="0.1" class="w-24 bg-black/40 border border-amber-500/30 rounded-lg px-3 py-1.5 text-center text-white text-sm focus:outline-none focus:border-amber-400">
                                </div>
                                <div class="flex items-center justify-between">
                                    <span class="text-[#00d4ff] text-sm font-bold">Platinum</span>
                                    <input type="number" name="Multiplier_Platinum" value="${empty configs['Multiplier_Platinum'] ? '1.3' : configs['Multiplier_Platinum']}" step="0.1" class="w-24 bg-black/40 border border-[#00d4ff]/30 rounded-lg px-3 py-1.5 text-center text-white text-sm focus:outline-none focus:border-[#00d4ff]">
                                </div>
                            </div>
                        </div>

                        <!-- Settings Panel: Danger Zone -->
                        <div class="glass-panel p-6 rounded-2xl border border-red-500/20 bg-red-500/5">
                            <div class="flex items-center gap-3 mb-4">
                                <div class="w-10 h-10 rounded-full bg-red-500/10 flex items-center justify-center">
                                    <i data-lucide="alert-triangle" class="w-5 h-5 text-red-500"></i>
                                </div>
                                <h3 class="text-xl font-bold text-red-400">Danger Zone</h3>
                            </div>

                            <div class="flex items-center justify-between p-4 bg-black/40 rounded-xl border border-red-500/20">
                                <div>
                                    <p class="font-medium text-white">Chế độ Bảo Trì (Maintenance Mode)</p>
                                    <p class="text-xs text-slate-400 mt-1">Khóa toàn bộ chức năng đặt lịch của khách hàng. Chỉ bật khi trạm gặp sự cố.</p>
                                </div>
                                <!-- Toggle Switch -->
                                <label class="relative inline-flex items-center cursor-pointer">
                                    <input type="checkbox" name="MaintenanceMode" value="on" class="sr-only peer" ${config['MaintenanceMode'] == 'on' ? 'checked' : ''}>
                                    <div class="w-11 h-6 bg-slate-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-red-500"></div>
                                </label>
                            </div>
                        </div>
                        <!-- Toggle Switch -->
                        <label class="relative inline-flex items-center cursor-pointer">
                          <input type="checkbox" name="MaintenanceMode" value="true" ${configs['MaintenanceMode'] == 'true' ? 'checked' : ''} class="sr-only peer">
                          <div class="w-11 h-6 bg-slate-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-red-500"></div>
                        </label>
                    </div>
                </div>
            </form>

        </form>
    </main>
<jsp:include page="/WEB-INF/views/components/toast.jsp" />

    <!-- Mobile Bottom Navigation -->
    <jsp:include page="/WEB-INF/views/components/admin_bottom_nav.jsp">
        <jsp:param name="activeMenu" value="config" />
    </jsp:include>
</body>
</html>
