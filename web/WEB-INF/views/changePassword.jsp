<%@page import="dto.Customer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
    <meta charset="utf-8" />
    <title>Đổi Mật Khẩu - Auto Wash Pro</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
      body, .font-sans { font-family: 'Inter', sans-serif !important; }
      .font-display { font-family: 'Be Vietnam Pro', sans-serif !important; }
    </style>
    
    <!-- Global CSS & Tailwind -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css?v=5" />
    <script src="${pageContext.request.contextPath}/assets/js/tailwind-config.js?v=5"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>

<body class="m-0 min-h-screen bg-bg-primary text-white font-sans antialiased selection:bg-[#00d4ff] selection:text-black w-full overflow-x-hidden">

    <!-- Desktop Sidebar -->
    <aside class="hidden md:flex flex-col w-64 glass-panel border-r border-border-glass fixed h-full z-10 left-0 top-0">
        <a href="${pageContext.request.contextPath}/account/dashboard" class="p-6 flex items-center gap-3 hover:opacity-80 transition-opacity">
            <i data-lucide="droplets" class="text-[#00d4ff] w-8 h-8"></i>
            <span class="text-xl font-display font-bold tracking-tight text-white">AUTOWASH<span class="text-[#00d4ff]">PRO</span></span>
        </a>
        
        <nav class="flex-1 px-4 py-4 space-y-2 mt-4">
            <a href="${pageContext.request.contextPath}/account/dashboard" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Tổng quan</span>
            </a>
            <a href="${pageContext.request.contextPath}/bookings" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="calendar-plus" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Đặt lịch dịch vụ</span>
            </a>
            <a href="${pageContext.request.contextPath}/customer/booking_history" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="history" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Lịch sử rửa xe</span>
            </a>
            <a href="${pageContext.request.contextPath}/vehicles" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="car" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Quản lý xe</span>
            </a>
            <a href="${pageContext.request.contextPath}/customer/loyalty" class="flex items-center gap-3 px-4 py-3 text-text-muted hover:text-white hover:bg-bg-surface-hover rounded-xl transition-colors">
                <i data-lucide="award" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Loyalty Program</span>
            </a>
            <a href="${pageContext.request.contextPath}/account/profile" class="flex items-center gap-3 px-4 py-3 bg-[#00d4ff]/10 text-[#00d4ff] rounded-xl border border-[#00d4ff]/20 transition-colors shadow-[0_0_10px_rgba(0,212,255,0.1)]">
                <i data-lucide="user" class="w-5 h-5"></i>
                <span class="font-medium text-sm">Hồ sơ cá nhân</span>
            </a>
        </nav>
    </aside>

    <main class="flex-1 md:ml-64 relative min-h-screen pb-[120px] md:pb-8 bg-bg-primary">
        <header class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center gap-4">
            <a href="${pageContext.request.contextPath}/account/profile" class="w-10 h-10 rounded-full bg-white/5 border border-border-glass flex items-center justify-center text-text-muted hover:text-white hover:bg-white/10 transition-colors">
                <i data-lucide="arrow-left" class="w-5 h-5"></i>
            </a>
            <h1 class="text-lg md:text-2xl font-display font-bold truncate text-white">Đổi Mật Khẩu</h1>
        </header>

        <div class="px-4 md:px-8 py-8 max-w-xl mx-auto space-y-6">

            <div class="glass-panel rounded-3xl p-6 md:p-8 border-t border-t-white/10 relative overflow-hidden">
                <!-- Ambient glow -->
                <div class="absolute top-0 right-0 w-64 h-64 bg-[#00d4ff]/5 rounded-full blur-3xl pointer-events-none -mr-32 -mt-32"></div>
                
                <div class="text-center mb-8 relative z-10">
                    <div class="w-16 h-16 mx-auto rounded-full bg-[#00d4ff]/10 border border-[#00d4ff]/20 flex items-center justify-center text-[#00d4ff] mb-4 shadow-[0_0_15px_rgba(0,212,255,0.15)]">
                        <i data-lucide="shield-check" class="w-8 h-8"></i>
                    </div>
                    <h2 class="text-2xl font-display font-bold text-white mb-2">Bảo Mật Tài Khoản</h2>
                    <p class="text-text-muted text-sm">Vui lòng nhập mật khẩu cũ và tạo mật khẩu mới an toàn hơn.</p>
                </div>

                <form action="${pageContext.request.contextPath}/account/change-password" method="POST" class="space-y-5 relative z-10" novalidate onsubmit="return validatePasswordForm(event)">
                    
                    <div id="clientErrorAlert" class="hidden bg-rose-500/10 border border-rose-500/30 text-rose-400 px-4 py-3 rounded-xl text-sm flex items-start gap-3">
                        <i data-lucide="alert-circle" class="w-5 h-5 shrink-0 mt-0.5"></i>
                        <span id="clientErrorText"></span>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="bg-rose-500/10 border border-rose-500/30 text-rose-400 px-4 py-3 rounded-xl text-sm flex items-start gap-3">
                            <i data-lucide="alert-circle" class="w-5 h-5 shrink-0 mt-0.5"></i>
                            <c:out value="${errorMessage}" />
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty successMessage}">
                        <div class="bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 px-4 py-3 rounded-xl text-sm flex items-start gap-3">
                            <i data-lucide="check-circle-2" class="w-5 h-5 shrink-0 mt-0.5"></i>
                            <c:out value="${successMessage}" />
                        </div>
                    </c:if>

                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium ml-1">Mật khẩu hiện tại</label>
                        <div class="relative">
                            <input type="password" id="txtCurrentPassword" name="txtCurrentPassword" required placeholder="Nhập mật khẩu cũ..." class="w-full bg-black/20 border border-border-glass text-white rounded-xl px-4 py-3.5 pl-11 focus:outline-none focus:border-[#00d4ff] focus:shadow-[0_0_10px_rgba(0,212,255,0.1)] transition-all placeholder:text-gray-600">
                            <i data-lucide="lock" class="w-5 h-5 text-text-muted absolute left-4 top-1/2 -translate-y-1/2"></i>
                            <button type="button" onclick="togglePassword('txtCurrentPassword', this)" class="absolute right-4 top-1/2 -translate-y-1/2 text-text-muted hover:text-white transition-colors" title="Hiện mật khẩu">
                                <i data-lucide="eye" class="w-5 h-5 icon-eye"></i>
                                <i data-lucide="eye-off" class="w-5 h-5 icon-eye-off hidden"></i>
                            </button>
                        </div>
                    </div>

                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium ml-1">Mật khẩu mới</label>
                        <div class="relative">
                            <input type="password" id="txtNewPassword" name="txtNewPassword" required placeholder="Tạo mật khẩu mới..." class="w-full bg-black/20 border border-border-glass text-white rounded-xl px-4 py-3.5 pl-11 focus:outline-none focus:border-[#00d4ff] focus:shadow-[0_0_10px_rgba(0,212,255,0.1)] transition-all placeholder:text-gray-600">
                            <i data-lucide="key-round" class="w-5 h-5 text-text-muted absolute left-4 top-1/2 -translate-y-1/2"></i>
                            <button type="button" onclick="togglePassword('txtNewPassword', this)" class="absolute right-4 top-1/2 -translate-y-1/2 text-text-muted hover:text-white transition-colors" title="Hiện mật khẩu">
                                <i data-lucide="eye" class="w-5 h-5 icon-eye"></i>
                                <i data-lucide="eye-off" class="w-5 h-5 icon-eye-off hidden"></i>
                            </button>
                        </div>
                    </div>

                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium ml-1">Xác nhận mật khẩu mới</label>
                        <div class="relative">
                            <input type="password" id="txtConfirmNewPassword" name="txtConfirmNewPassword" required placeholder="Nhập lại mật khẩu mới..." class="w-full bg-black/20 border border-border-glass text-white rounded-xl px-4 py-3.5 pl-11 focus:outline-none focus:border-[#00d4ff] focus:shadow-[0_0_10px_rgba(0,212,255,0.1)] transition-all placeholder:text-gray-600">
                            <i data-lucide="check-square" class="w-5 h-5 text-text-muted absolute left-4 top-1/2 -translate-y-1/2"></i>
                            <button type="button" onclick="togglePassword('txtConfirmNewPassword', this)" class="absolute right-4 top-1/2 -translate-y-1/2 text-text-muted hover:text-white transition-colors" title="Hiện mật khẩu">
                                <i data-lucide="eye" class="w-5 h-5 icon-eye"></i>
                                <i data-lucide="eye-off" class="w-5 h-5 icon-eye-off hidden"></i>
                            </button>
                        </div>
                    </div>

                    <div class="pt-6">
                        <button type="submit" class="w-full px-4 py-4 rounded-xl btn-glow bg-[#00d4ff] hover:bg-white text-black font-bold shadow-[0_0_20px_rgba(0,212,255,0.3)] transition-all flex items-center justify-center gap-2 text-base">
                            <i data-lucide="save" class="w-5 h-5"></i> Cập Nhật Mật Khẩu
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <!-- Mobile Bottom Navigation -->
    <nav class="md:hidden fixed bottom-0 left-0 right-0 glass-panel border-t border-border-glass z-40 pb-safe">
        <div class="flex items-center justify-around p-2">
            <a href="${pageContext.request.contextPath}/account/dashboard" class="flex flex-col items-center gap-1 p-2 text-text-muted hover:text-white">
                <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
                <span class="text-[10px] font-medium">Tổng quan</span>
            </a>
            <a href="${pageContext.request.contextPath}/bookings" class="flex flex-col items-center gap-1 p-2 text-text-muted hover:text-white">
                <i data-lucide="calendar-plus" class="w-5 h-5"></i>
                <span class="text-[10px] font-medium">Đặt lịch</span>
            </a>
            <a href="${pageContext.request.contextPath}/customer/loyalty" class="flex flex-col items-center gap-1 p-2 text-text-muted hover:text-white">
                <i data-lucide="award" class="w-5 h-5"></i>
                <span class="text-[10px] font-medium">Loyalty</span>
            </a>
            <a href="${pageContext.request.contextPath}/account/profile" class="flex flex-col items-center gap-1 p-2 text-[#00d4ff]">
                <i data-lucide="user" class="w-5 h-5 drop-shadow-[0_0_8px_rgba(0,212,255,0.5)]"></i>
                <span class="text-[10px] font-medium">Cá nhân</span>
            </a>
        </div>
    </nav>

    <script>
        lucide.createIcons();

        function togglePassword(inputId, buttonElement) {
            const input = document.getElementById(inputId);
            const iconEye = buttonElement.querySelector('.icon-eye');
            const iconEyeOff = buttonElement.querySelector('.icon-eye-off');

            if (input.type === 'password') {
                input.type = 'text';
                iconEye.classList.add('hidden');
                iconEyeOff.classList.remove('hidden');
            } else {
                input.type = 'password';
                iconEye.classList.remove('hidden');
                iconEyeOff.classList.add('hidden');
            }
        }

        function validatePasswordForm(event) {
            const currentPass = document.getElementById('txtCurrentPassword').value;
            const newPass = document.getElementById('txtNewPassword').value;
            const confirmPass = document.getElementById('txtConfirmNewPassword').value;
            const errorAlert = document.getElementById('clientErrorAlert');
            const errorText = document.getElementById('clientErrorText');

            if (!currentPass || !newPass || !confirmPass) {
                errorText.textContent = "Vui lòng điền đầy đủ các trường bắt buộc.";
                errorAlert.classList.remove('hidden');
                event.preventDefault();
                return false;
            }

            if (newPass.length < 6) {
                errorText.textContent = "Mật khẩu mới phải có ít nhất 6 ký tự.";
                errorAlert.classList.remove('hidden');
                event.preventDefault();
                return false;
            }

            if (newPass !== confirmPass) {
                errorText.textContent = "Mật khẩu mới và mật khẩu xác nhận không khớp.";
                errorAlert.classList.remove('hidden');
                event.preventDefault();
                return false;
            }

            if (newPass === currentPass) {
                errorText.textContent = "Mật khẩu mới không được giống với mật khẩu hiện tại.";
                errorAlert.classList.remove('hidden');
                event.preventDefault();
                return false;
            }

            errorAlert.classList.add('hidden');
            return true;
        }
    </script>
    
    <c:remove var="errorMessage" scope="session" />
    <c:remove var="successMessage" scope="session" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>
