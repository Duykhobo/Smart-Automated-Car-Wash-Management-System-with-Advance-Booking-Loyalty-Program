<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản lý Dịch Vụ - AutoWash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
</head>
<body class="bg-bg-primary text-text-primary antialiased overflow-x-hidden selection:bg-[#00d4ff] selection:text-black flex">

    <!-- Sidebar Component -->
    <jsp:include page="/WEB-INF/views/components/admin_sidebar.jsp">
        <jsp:param name="activeMenu" value="services" />
    </jsp:include>

    <!-- Main Content -->
    <main class="flex-1 p-4 md:p-8 overflow-y-auto pb-[100px] md:pb-8">
        <!-- Header -->
        <header class="flex justify-between items-center mb-8">
            <div>
                <h2 class="text-3xl font-display font-bold text-white mb-1">Quản lý Dịch Vụ</h2>
                <p class="text-text-muted">Cập nhật bảng giá và các gói rửa xe cung cấp tại trạm.</p>
            </div>
            
            <button class="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-[#00d4ff] to-blue-500 text-black rounded-xl hover:opacity-90 transition-opacity font-bold shadow-[0_0_15px_rgba(0,212,255,0.3)]">
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
                            <th class="px-6 py-4 font-medium">Đơn Giá</th>
                            <th class="px-6 py-4 font-medium">Thời gian (Phút)</th>
                            <th class="px-6 py-4 font-medium text-center">Trạng Thái</th>
                            <th class="px-6 py-4 font-medium text-right">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-border-glass">
                        
                        <!-- Service 1 -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-3">Tên Dịch Vụ:</span>
                                <div class="inline-flex lg:flex items-center gap-4 align-top">
                                    <div class="w-12 h-12 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center">
                                        <i data-lucide="droplet" class="w-6 h-6 text-[#00d4ff]"></i>
                                    </div>
                                    <div>
                                        <div class="font-bold text-white text-base">Rửa Bọt Tuyết Tiêu Chuẩn</div>
                                        <div class="text-xs text-text-muted">Rửa ngoài, xịt gầm, lau khô</div>
                                    </div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Đơn Giá:</span>
                                <span class="font-display font-bold text-lg text-emerald-400">80,000đ</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Thời gian (Phút):</span>
                                <span class="inline-flex lg:flex items-center gap-1.5 text-slate-300 align-top">
                                    <i data-lucide="clock" class="w-4 h-4 text-text-muted"></i> 25 phút
                                </span>
                            </td>
                            <td class="flex justify-between lg:table-cell lg:text-center px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Trạng Thái:</span>
                                <!-- Toggle Switch -->
                                <label class="relative inline-flex items-center cursor-pointer">
                                  <input type="checkbox" checked class="sr-only peer">
                                  <div class="w-11 h-6 bg-slate-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-[#00d4ff]"></div>
                                </label>
                            </td>
                            <td class="flex lg:table-cell justify-between items-center px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <div class="flex items-center justify-end gap-2">
                                    <button class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center transition-colors">
                                        <i data-lucide="edit-3" class="w-4 h-4"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>

                        <!-- Service 2 -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-3">Tên Dịch Vụ:</span>
                                <div class="inline-flex lg:flex items-center gap-4 align-top">
                                    <div class="w-12 h-12 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center">
                                        <i data-lucide="spray-can" class="w-6 h-6 text-amber-400"></i>
                                    </div>
                                    <div>
                                        <div class="font-bold text-white text-base">Vệ Sinh Nội Thất Toàn Diện</div>
                                        <div class="text-xs text-text-muted">Hút bụi, lau taplo, giặt ghế da</div>
                                    </div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Đơn Giá:</span>
                                <span class="font-display font-bold text-lg text-emerald-400">350,000đ</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Thời gian (Phút):</span>
                                <span class="inline-flex lg:flex items-center gap-1.5 text-slate-300 align-top">
                                    <i data-lucide="clock" class="w-4 h-4 text-text-muted"></i> 90 phút
                                </span>
                            </td>
                            <td class="flex justify-between lg:table-cell lg:text-center px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Trạng Thái:</span>
                                <!-- Toggle Switch -->
                                <label class="relative inline-flex items-center cursor-pointer">
                                  <input type="checkbox" checked class="sr-only peer">
                                  <div class="w-11 h-6 bg-slate-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-[#00d4ff]"></div>
                                </label>
                            </td>
                            <td class="flex lg:table-cell justify-between items-center px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <div class="flex items-center justify-end gap-2">
                                    <button class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center transition-colors">
                                        <i data-lucide="edit-3" class="w-4 h-4"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>

                        <!-- Service 3 (Inactive) -->
                        <tr class="block lg:table-row hover:bg-white/[0.02] transition-colors border-b border-border-glass lg:border-none p-4 lg:p-0 opacity-60 grayscale">
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top mt-3">Tên Dịch Vụ:</span>
                                <div class="inline-flex lg:flex items-center gap-4 align-top">
                                    <div class="w-12 h-12 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center">
                                        <i data-lucide="sparkles" class="w-6 h-6 text-purple-400"></i>
                                    </div>
                                    <div>
                                        <div class="font-bold text-white text-base">Phủ Ceramic Cơ Bản</div>
                                        <div class="text-xs text-text-muted">Phủ bóng 1 lớp, chống nước</div>
                                    </div>
                                </div>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Đơn Giá:</span>
                                <span class="font-display font-bold text-lg text-emerald-400">1,200,000đ</span>
                            </td>
                            <td class="block lg:table-cell px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32 align-top">Thời gian (Phút):</span>
                                <span class="inline-flex lg:flex items-center gap-1.5 text-slate-300 align-top">
                                    <i data-lucide="clock" class="w-4 h-4 text-text-muted"></i> 180 phút
                                </span>
                            </td>
                            <td class="flex justify-between lg:table-cell lg:text-center px-2 lg:px-6 py-2 lg:py-4">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Trạng Thái:</span>
                                <!-- Toggle Switch -->
                                <label class="relative inline-flex items-center cursor-pointer">
                                  <input type="checkbox" class="sr-only peer">
                                  <div class="w-11 h-6 bg-slate-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-[#00d4ff]"></div>
                                </label>
                            </td>
                            <td class="flex lg:table-cell justify-between items-center px-2 lg:px-6 py-4 lg:text-right mt-2 lg:mt-0 border-t lg:border-none border-border-glass">
                                <span class="inline-block lg:hidden text-text-muted font-medium w-32">Thao tác:</span>
                                <div class="flex items-center justify-end gap-2">
                                    <button class="w-8 h-8 rounded-lg text-text-muted hover:text-white flex items-center justify-center transition-colors">
                                        <i data-lucide="edit-3" class="w-4 h-4"></i>
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
        <jsp:param name="activeMenu" value="services" />
    </jsp:include>
</body>
</html>
