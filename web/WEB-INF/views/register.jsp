<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta charset="utf-8" />
<title>Auto Wash Pro - Đăng Ký</title>
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<!-- Tailwind CDN -->
<script src="https://cdn.tailwindcss.com"></script>
<style>
    /* Ẩn icon con mắt mặc định của trình duyệt Edge/IE */
    input[type="password"]::-ms-reveal,
    input[type="password"]::-ms-clear {
        display: none;
    }
</style>
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
<body class="bg-bg-primary text-white font-sans antialiased selection:bg-btn-primary selection:text-black min-h-screen flex">

    <!-- Desktop Left Column (Brand) -->
    <div class="hidden lg:flex flex-col justify-center w-1/2 p-12 lg:p-24 bg-[radial-gradient(ellipse_at_bottom_left,_var(--tw-gradient-stops))] from-gray-800 via-[#0b0f1a] to-[#0b0f1a] border-r border-gray-800 relative overflow-hidden">
        <div class="absolute inset-0 bg-btn-primary/5 blur-[100px] rounded-full mix-blend-screen pointer-events-none"></div>
        <div class="relative z-10">
            <h1 class="text-5xl font-bold mb-6 tracking-tight"><span class="text-btn-primary">AutoWash</span> Pro</h1>
            <p class="text-gray-400 text-lg leading-relaxed max-w-lg">
                Đăng ký thành viên để trải nghiệm hệ thống quản lý và đặt lịch rửa xe thông minh. Hưởng trọn ưu đãi từ chương trình Loyalty.
            </p>
            
            <div class="mt-12 flex items-center gap-4 text-gray-500">
                <svg class="w-8 h-8 text-btn-primary/50" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path></svg>
                <span class="font-medium text-gray-400">Đặt lịch siêu tốc</span>
            </div>
            <div class="mt-4 flex items-center gap-4 text-gray-500">
                <svg class="w-8 h-8 text-btn-primary/50" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"></path></svg>
                <span class="font-medium text-gray-400">Tích điểm đổi quà</span>
            </div>
        </div>
    </div>

    <!-- Right Column (Form) -->
    <div class="w-full lg:w-1/2 flex flex-col justify-center px-6 sm:px-12 md:px-24 py-12 relative overflow-y-auto">
        <a href="${pageContext.request.contextPath}/home" class="absolute top-8 left-6 sm:left-12 flex items-center gap-2 text-gray-400 hover:text-white transition-colors font-medium text-sm group">
            <svg class="w-5 h-5 group-hover:-translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
            <span class="hidden sm:inline">Quay lại</span>
        </a>

        <div class="max-w-md w-full mx-auto mt-8 lg:mt-0">
            <h2 class="text-3xl font-bold text-white mb-2">Đăng Ký Tài Khoản</h2>
            <p class="text-gray-400 text-sm mb-8">Bắt đầu trải nghiệm dịch vụ chuẩn Pro</p>

            <!-- Alerts -->
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div id="serverAlert" class="bg-red-500/10 border border-red-500/20 text-red-400 px-4 py-3 rounded-xl mb-6 text-sm flex items-center gap-2">
                    <svg class="w-5 h-5 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <div id="clientError" class="bg-red-500/10 border border-red-500/20 text-red-400 px-4 py-3 rounded-xl mb-6 text-sm items-center gap-2 hidden">
                <svg class="w-5 h-5 shrink-0 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                <span id="clientErrorText"></span>
            </div>

            <form action="${pageContext.request.contextPath}/auth/register" method="POST" id="registerForm" novalidate onsubmit="return handleRegister(event)" class="space-y-4">
                
                <div class="space-y-1">
                    <label for="fullname" class="block text-gray-300 text-sm font-medium mb-2">Họ và tên *</label>
                    <input type="text" id="fullname" name="fullname" placeholder="Nhập họ và tên..." value="<c:out value='${user.fullName}'/>" required 
                           class="w-full bg-gray-800/50 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all placeholder:text-gray-600">
                    <p class="text-red-400 text-xs mt-1 empty:hidden" id="err-fullname"></p>
                </div>

                <div class="space-y-1">
                    <label for="phone" class="block text-gray-300 text-sm font-medium mb-2">Số điện thoại *</label>
                    <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại..." value="<c:out value='${user.phone}'/>" required 
                           class="w-full bg-gray-800/50 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all placeholder:text-gray-600">
                    <p class="text-red-400 text-xs mt-1 empty:hidden" id="err-phone"></p>
                </div>

                <div class="space-y-1">
                    <label for="plate" class="block text-gray-300 text-sm font-medium mb-2">Biển số xe *</label>
                    <input type="text" id="plate" name="plate" placeholder="VD: 51H-123.45" value="<c:out value='${user.licensePlate}'/>" required oninput="this.value = this.value.toUpperCase()"
                           class="w-full bg-gray-800/50 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all placeholder:text-gray-600">
                    <p class="text-red-400 text-xs mt-1 empty:hidden" id="err-plate"></p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="space-y-1 relative">
                        <label class="text-gray-300 text-sm font-medium">Mật Khẩu</label>
                        <div class="relative">
                            <input type="password" id="password" name="password" placeholder="Mật khẩu..." required 
                                   class="w-full bg-gray-800/50 border border-gray-700 text-white rounded-xl px-4 py-3 pr-10 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all placeholder:text-gray-600">
                            <button type="button" onclick="togglePassword('password', this)" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-300">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                            </button>
                        </div>
                        <p class="text-red-400 text-xs mt-1 empty:hidden" id="err-password"></p>
                    </div>

                    <div class="space-y-1 relative">
                        <label class="text-gray-300 text-sm font-medium">Xác Nhận</label>
                        <div class="relative">
                            <input type="password" id="confirm_password" name="confirm_password" placeholder="Nhập lại..." required 
                                   class="w-full bg-gray-800/50 border border-gray-700 text-white rounded-xl px-4 py-3 pr-10 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all placeholder:text-gray-600">
                            <button type="button" onclick="togglePassword('confirm_password', this)" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-300">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>
                            </button>
                        </div>
                        <p class="text-red-400 text-xs mt-1 empty:hidden" id="err-confirm_password"></p>
                    </div>
                </div>

                <div class="pt-2">
                    <label class="flex items-start gap-3 cursor-pointer group">
                        <div class="relative flex items-center justify-center mt-1">
                            <input type="checkbox" id="terms" name="terms" required class="peer appearance-none w-5 h-5 border-2 border-gray-600 rounded bg-gray-800 checked:bg-btn-primary checked:border-btn-primary transition-colors cursor-pointer">
                            <svg class="absolute w-3 h-3 text-black opacity-0 peer-checked:opacity-100 pointer-events-none" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"></path></svg>
                        </div>
                        <span class="text-gray-400 text-sm leading-relaxed select-none">
                            Tôi đồng ý với <a href="#" class="text-btn-primary hover:underline">Điều khoản dịch vụ</a> và <a href="#" class="text-btn-primary hover:underline">Chính sách bảo mật</a>
                        </span>
                    </label>
                    <p class="text-red-400 text-xs mt-1 ml-8 empty:hidden" id="err-terms"></p>
                </div>

                <button type="submit" class="w-full mt-6 bg-btn-primary hover:bg-cyan-400 text-black font-bold text-base py-4 rounded-xl shadow-[0_4px_16px_rgba(0,212,255,0.3)] hover:shadow-[0_4px_24px_rgba(0,212,255,0.5)] transition-all hover:scale-[1.02] active:scale-[0.98]">
                    Đăng Ký Tài Khoản
                </button>
            </form>

            <div class="mt-8 pt-8 border-t border-gray-800 text-center">
                <p class="text-gray-400 text-sm">
                    Bạn đã có tài khoản? 
                    <a href="${pageContext.request.contextPath}/auth/login" class="text-btn-primary font-bold hover:underline ml-1">Đăng nhập</a>
                </p>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        function togglePassword(inputId, btn) {
            const input = document.getElementById(inputId);
            if (input.type === 'password') {
                input.type = 'text';
                btn.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.29 3.29m0 0a10.05 10.05 0 015.15-2.261m5.858.908a9.97 9.97 0 013.029 1.563c1.274 4.057-2.515 7-7 7z" /></svg>';
            } else {
                input.type = 'password';
                btn.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>';
            }
        }
    </script>
    <script src="${pageContext.request.contextPath}/js/constants.js" charset="UTF-8"></script>
    <script src="${pageContext.request.contextPath}/js/page-register.js" charset="UTF-8"></script>
    <script>
        function handleRegister(event) {
            const form = event.target;
            const phone = form.phone.value.trim();
            const password = form.password.value;
            const confirmPassword = form.confirmPassword.value;
            const clientError = document.getElementById('clientError');
            const clientErrorText = document.getElementById('clientErrorText');
            
            let errors = [];
            
            if (phone.length !== 10 || !phone.startsWith('0')) {
                errors.push("Số điện thoại không hợp lệ (phải bắt đầu bằng 0 và gồm 10 số).");
            }
            if (password.length < 6) {
                errors.push("Mật khẩu phải có ít nhất 6 ký tự.");
            }
            if (password !== confirmPassword) {
                errors.push("Xác nhận mật khẩu không khớp.");
            }
            
            if (errors.length > 0) {
                clientErrorText.innerHTML = errors.join('<br>');
                clientError.classList.remove('hidden');
                event.preventDefault();
                return false;
            }
            
            clientError.classList.add('hidden');
            return true;
        }
    </script>
</body>
</html>
