<%@page import="dto.User"%>
<%@page import="dto.Customer"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="utils.AppConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta charset="utf-8" />
        <title>Auto Wash Pro - Đổi mật khẩu</title>
        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <!-- Tailwind CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            /** @type {import('tailwindcss').Config} */
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {
                            sans: ['Inter', 'sans-serif']
                        },
                        colors: {
                            "bg-primary": "#0b0f1a",
                            "btn-primary": "#00d4ff",
                            "colors-accents-green": "#10b981",
                            "error": "#ef4444"
                        }
                    }
                },
                plugins: []
            }
        </script>
    </head>
    <body class="bg-bg-primary text-white font-sans antialiased selection:bg-btn-primary selection:text-black">

        <%
            // Safe session and customer resolution
            Customer cus = (Customer) request.getAttribute("customer");
            if (cus == null) {
                User uAccount = (User) session.getAttribute(AppConstants.SESSION_USER_ACCOUNT);
                if (uAccount != null) {
                    CustomerDAO cDao = new CustomerDAO();
                    cus = cDao.getCustomerByAccountId(uAccount.getUserId());
                }
            }
        %>

        <div class="flex h-screen overflow-hidden bg-bg-primary">

            <!-- Desktop Sidebar (Tự động hiển thị trên máy tính, ẩn trên mobile) -->
            <aside class="hidden md:flex flex-col w-64 border-r border-gray-800 bg-[#121826]">
                <a href="${pageContext.request.contextPath}/home" class="p-6 flex items-center gap-3 hover:opacity-80 transition-opacity">
                    <div class="w-10 h-10 bg-btn-primary rounded-xl flex items-center justify-center text-black font-bold text-xl">A</div>
                    <span class="font-bold text-xl tracking-wider text-btn-primary">AUTOWASH</span>
                </a>

                <nav class="flex-1 px-4 py-4 space-y-2">
                    <a href="${pageContext.request.contextPath}/account/dashboard" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                        <span class="font-medium">Trang chủ</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/bookings" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                        <span class="font-medium">Đặt lịch</span>
                    </a>
                    <a href="#" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7"></path></svg>
                        <span class="font-medium">Ưu đãi</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/account/profile" class="flex items-center gap-3 px-4 py-3 bg-btn-primary/10 text-btn-primary rounded-xl transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                        <span class="font-medium">Hồ sơ cá nhân</span>
                    </a>
                </nav>
            </aside>

            <!-- Main Content Area -->
            <main class="flex-1 overflow-y-auto pb-24 md:pb-8">
                <div class="max-w-xl mx-auto p-6 md:p-8 space-y-8 mt-4 md:mt-0">

                    <!-- Back Button -->
                    <a href="${pageContext.request.contextPath}/account/profile" class="inline-flex items-center gap-2 text-gray-400 hover:text-white hover:text-btn-primary transition-colors font-medium text-sm group">
                        <svg class="w-5 h-5 group-hover:-translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                        </svg>
                        <span>Quay lại hồ sơ cá nhân</span>
                    </a>

                    <!-- Profile Header (Short version matching context) -->
                    <section class="flex flex-col items-center gap-4 text-center">
                        <div class="w-16 h-16 rounded-full bg-btn-primary/10 border border-btn-primary/20 flex items-center justify-center text-btn-primary shadow-[0_0_15px_rgba(0,212,255,0.1)]">
                            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                            </svg>
                        </div>

                        <div class="flex flex-col gap-1">
                            <h1 class="text-2xl md:text-3xl font-bold text-white tracking-tight">Đổi Mật Khẩu</h1>
                            <% if (cus != null) {%>
                            <p class="text-gray-400 text-sm">Tài khoản: <span class="text-gray-300 font-semibold"><%= cus.getFullName()%></span> (<%= cus.getPhone()%>)</p>
                            <% } else { %>
                            <p class="text-gray-400 text-sm">Cập nhật mật khẩu bảo mật cho tài khoản của bạn</p>
                            <% } %>
                        </div>
                    </section>

                    <!-- Form Card -->
                    <div class="bg-[#121826] border border-gray-800 rounded-2xl shadow-xl overflow-hidden p-6 md:p-8">

                        <!-- Client-side validation dynamic error alert (hidden by default) -->
                        <div id="clientErrorAlert" class="hidden bg-red-500/10 border border-red-500/20 text-red-400 px-4 py-3 rounded-xl text-sm mb-6 flex items-center gap-2">
                            <svg class="w-5 h-5 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            <span id="clientErrorText"></span>
                        </div>

                        <!-- Backend response status notifications -->
                        <%
                            // Supports request attributes or session attributes (flexible depending on servlet design)
                            String error = (String) request.getAttribute("errorMessage");
                            if (error == null) {
                                error = (String) session.getAttribute("ERROR");
                                if (error != null) {
                                    session.removeAttribute("ERROR");
                                }
                            }

                            String success = (String) request.getAttribute("successMessage");
                            if (success == null) {
                                success = (String) session.getAttribute("SUCCESS");
                                if (success != null) {
                                    session.removeAttribute("SUCCESS");
                                }
                            }
                        %>

                        <% if (error != null) {%>
                        <div class="bg-red-500/10 border border-red-500/20 text-red-400 px-4 py-3 rounded-xl text-sm mb-6 flex items-center gap-2">
                            <svg class="w-5 h-5 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            <span><%= error%></span>
                        </div>
                        <% } %>

                        <% if (success != null) {%>
                        <div class="bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 px-4 py-3 rounded-xl text-sm mb-6 flex items-center gap-2">
                            <svg class="w-5 h-5 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            <span><%= success%></span>
                        </div>
                        <% }%>

                        <!-- Form action triggers POST to change-password servlet. 
                             Developers can map a servlet/controller to "/account/change-password" or adjust this action url. -->
                        <form action="${pageContext.request.contextPath}/account/change-password" method="POST" class="space-y-6" onsubmit="return validateForm();">

                            <!-- Nhập mật khẩu cũ -->
                            <div class="space-y-1.5">
                                <label class="text-gray-300 text-sm font-medium">Nhập mật khẩu cũ *</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-gray-500">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                                        </svg>
                                    </div>
                                    <input type="password" id="oldPassword" name="txtCurrentPassword" required placeholder="Nhập mật khẩu cũ..."
                                           class="w-full bg-gray-800/50 border border-gray-700 text-white rounded-xl pl-11 pr-11 py-3.5 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary focus:bg-gray-800/80 transition-all placeholder:text-gray-600">
                                    <button type="button" onclick="togglePassword('oldPassword', this)" class="absolute inset-y-0 right-0 pr-3.5 flex items-center text-gray-500 hover:text-gray-300 focus:outline-none" aria-label="Hiện mật khẩu">
                                        <svg class="w-5 h-5 eye-open" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                        </svg>
                                        <svg class="w-5 h-5 eye-closed hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l18 18"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <!-- Mật khẩu mới -->
                            <div class="space-y-1.5">
                                <div class="flex justify-between items-center">
                                    <label class="text-gray-300 text-sm font-medium">Mật khẩu mới *</label>
                                    <span class="text-xs text-gray-500">Tối thiểu 6 ký tự</span>
                                </div>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-gray-500">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                                        </svg>
                                    </div>
                                    <input type="password" id="newPassword" name="txtNewPassword" required placeholder="Nhập mật khẩu mới..."
                                           class="w-full bg-gray-800/50 border border-gray-700 text-white rounded-xl pl-11 pr-11 py-3.5 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary focus:bg-gray-800/80 transition-all placeholder:text-gray-600">
                                    <button type="button" onclick="togglePassword('newPassword', this)" class="absolute inset-y-0 right-0 pr-3.5 flex items-center text-gray-500 hover:text-gray-300 focus:outline-none" aria-label="Hiện mật khẩu">
                                        <svg class="w-5 h-5 eye-open" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                        </svg>
                                        <svg class="w-5 h-5 eye-closed hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l18 18"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <!-- Nhập lại mật khẩu mới -->
                            <div class="space-y-1.5">
                                <label class="text-gray-300 text-sm font-medium">Nhập lại mật khẩu mới *</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-gray-500">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
                                        </svg>
                                    </div>
                                    <input type="password" id="confirmPassword" name="txtConfirmNewPassword" required placeholder="Nhập lại mật khẩu mới..."
                                           class="w-full bg-gray-800/50 border border-gray-700 text-white rounded-xl pl-11 pr-11 py-3.5 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary focus:bg-gray-800/80 transition-all placeholder:text-gray-600">
                                    <button type="button" onclick="togglePassword('confirmPassword', this)" class="absolute inset-y-0 right-0 pr-3.5 flex items-center text-gray-500 hover:text-gray-300 focus:outline-none" aria-label="Hiện mật khẩu">
                                        <svg class="w-5 h-5 eye-open" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                        </svg>
                                        <svg class="w-5 h-5 eye-closed hidden" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l18 18"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="pt-4 flex gap-4">
                                <a href="${pageContext.request.contextPath}/account/profile" class="flex-1 px-4 py-3.5 rounded-xl border border-gray-700 text-white text-center font-semibold hover:bg-gray-800 transition-colors focus:outline-none focus:ring-2 focus:ring-gray-600">
                                    Hủy
                                </a>
                                <button type="submit" class="flex-1 px-4 py-3.5 rounded-xl bg-btn-primary text-black font-bold hover:bg-cyan-400 shadow-[0_4px_16px_rgba(0,212,255,0.2)] hover:shadow-[0_4px_24px_rgba(0,212,255,0.4)] hover:scale-[1.01] active:scale-[0.99] transition-all focus:outline-none focus:ring-2 focus:ring-btn-primary focus:ring-offset-2 focus:ring-offset-gray-900">
                                    Xác nhận đổi mật khẩu
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>

            <!-- Mobile Bottom Navigation (Chỉ hiện trên điện thoại, ẩn trên máy tính) -->
            <nav class="md:hidden fixed bottom-0 left-0 w-full bg-gray-900 border-t border-gray-800 z-50 px-2 py-2" style="padding-bottom: env(safe-area-inset-bottom);" aria-label="Điều hướng chính Mobile">
                <div class="flex justify-around items-center h-14">
                    <a href="${pageContext.request.contextPath}/account/dashboard" class="flex flex-col items-center gap-1 w-16 text-gray-400 hover:text-white transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                        <span class="text-[10px] font-medium">Trang chủ</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/bookings" class="flex flex-col items-center gap-1 w-16 text-gray-400 hover:text-white transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                        <span class="text-[10px] font-medium">Đặt lịch</span>
                    </a>
                    <a href="#" class="flex flex-col items-center gap-1 w-16 text-gray-400 hover:text-white transition-colors">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7"></path></svg>
                        <span class="text-[10px] font-medium">Ưu đãi</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/account/profile" class="flex flex-col items-center gap-1 w-16 text-btn-primary">
                        <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path></svg>
                        <span class="text-[10px] font-medium">Hồ sơ</span>
                    </a>
                </div>
            </nav>

        </div>

        <!-- Custom client scripts for visual toggling and validation -->
        <script>
            // Toggles password field input type between password and text
            function togglePassword(inputId, button) {
                const input = document.getElementById(inputId);
                const eyeOpen = button.querySelector('.eye-open');
                const eyeClosed = button.querySelector('.eye-closed');

                if (input.type === 'password') {
                    input.type = 'text';
                    eyeOpen.classList.add('hidden');
                    eyeClosed.classList.remove('hidden');
                    button.setAttribute('aria-label', 'Ẩn mật khẩu');
                } else {
                    input.type = 'password';
                    eyeOpen.classList.remove('hidden');
                    eyeClosed.classList.add('hidden');
                    button.setAttribute('aria-label', 'Hiện mật khẩu');
                }
            }

            // High-quality client-side form validation before submitting to server
            function validateForm() {
                const oldPassword = document.getElementById('oldPassword').value.trim();
                const newPassword = document.getElementById('newPassword').value.trim();
                const confirmPassword = document.getElementById('confirmPassword').value.trim();

                const clientErrorAlert = document.getElementById('clientErrorAlert');
                const clientErrorText = document.getElementById('clientErrorText');

                // Clear previous client error messages
                clientErrorAlert.classList.add('hidden');
                clientErrorText.textContent = '';

                // 1. Check for empty fields
                if (oldPassword === '' || newPassword === '' || confirmPassword === '') {
                    showClientError("Vui lòng điền đầy đủ tất cả các trường thông tin.");
                    return false;
                }

                // 2. Enforce minimum length of 6 characters
                if (newPassword.length < 6) {
                    showClientError("Mật khẩu mới phải có ít nhất 6 ký tự.");
                    return false;
                }

                // 3. Prevent using the old password as the new password
                if (newPassword === oldPassword) {
                    showClientError("Mật khẩu mới không được giống với mật khẩu cũ hiện tại.");
                    return false;
                }

                // 4. Ensure new passwords match
                if (newPassword !== confirmPassword) {
                    showClientError("Nhập lại mật khẩu mới không khớp. Vui lòng nhập chính xác.");
                    return false;
                }

                return true;
            }

            function showClientError(message) {
                const clientErrorAlert = document.getElementById('clientErrorAlert');
                const clientErrorText = document.getElementById('clientErrorText');

                clientErrorText.textContent = message;
                clientErrorAlert.classList.remove('hidden');

                // Smoothly focus the user's attention on the error
                clientErrorAlert.scrollIntoView({behavior: 'smooth', block: 'center'});
            }
        </script>
    </body>
</html>
