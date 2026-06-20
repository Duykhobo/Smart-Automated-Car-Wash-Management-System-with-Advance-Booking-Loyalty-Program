<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi" style="color-scheme: dark;">
    <head>
        <!-- Google Fonts (Vietnamese Supported) & Font Fallback -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body, .font-sans {
                font-family: 'Inter', sans-serif !important;
            }
            .font-display {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
            
            /* Force dark background for autofilled inputs */
            input:-webkit-autofill,
            input:-webkit-autofill:hover, 
            input:-webkit-autofill:focus, 
            input:-webkit-autofill:active {
                -webkit-box-shadow: 0 0 0 30px #0a1128 inset !important;
                -webkit-text-fill-color: white !important;
                transition: background-color 5000s ease-in-out 0s !important;
                color: white !important;
            }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta charset="UTF-8" />
        <title>Auto Wash Pro - Đăng Ký</title>
        <!-- Global CSS & Tailwind Config -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css?v=4" />
        <script src="${pageContext.request.contextPath}/assets/js/tailwind-config.js?v=4"></script>
        <script src="https://cdn.tailwindcss.com"></script>

        <!-- Icons (Lucide) -->
        <script src="https://unpkg.com/lucide@latest"></script>

        <style>
            /* Ẩn icon con mắt mặc định của trình duyệt Edge/IE */
            input[type="password"]::-ms-reveal,
            input[type="password"]::-ms-clear {
                display: none;
            }
        </style>
    </head>
    <body class="bg-bg-primary text-text-primary font-sans antialiased selection:bg-[#00d4ff] selection:text-black min-h-screen flex">

        <!-- Desktop Left Column (Brand) -->
        <div class="hidden lg:flex flex-col justify-center w-1/2 p-12 lg:p-24 bg-gradient-to-tr from-bg-primary to-[#0a1128] border-r border-border-glass relative overflow-hidden">
            <div class="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1601362840469-51e4d8d58785?auto=format&fit=crop&q=80')] bg-cover bg-center opacity-10"></div>
            <div class="absolute bottom-0 right-0 w-96 h-96 bg-[#00d4ff]/10 blur-[100px] rounded-full mix-blend-screen pointer-events-none"></div>

            <div class="relative z-10">
                <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-2 mb-12">
                    <i data-lucide="droplets" class="text-[#00d4ff] w-10 h-10"></i>
                    <h1 class="text-4xl font-display font-bold tracking-tight text-white">AUTOWASH<span class="text-[#00d4ff]">PRO</span></h1>
                </a>

                <h2 class="text-4xl font-display font-bold mb-6 text-white leading-tight">Đăng ký thành viên<br/><span class="text-[#00d4ff] glow-text">Chuẩn Pro</span></h2>
                <p class="text-text-muted text-lg leading-relaxed max-w-lg mb-12">
                    Trải nghiệm hệ thống đặt lịch tá»± động thông minh. Tích điểm nâng hạng để hưởng trọn ưu đãi độc quyền.
                </p>

                <div class="flex items-center gap-4 text-gray-300">
                    <div class="w-10 h-10 rounded-xl bg-bg-surface border border-border-glass flex items-center justify-center shrink-0">
                        <i data-lucide="clock" class="w-5 h-5 text-[#00d4ff]"></i>
                    </div>
                    <div>
                        <span class="font-bold text-white block">Đặt lịch siêu tốc</span>
                        <span class="text-sm text-text-muted">Chọn giờ, chọn gói, thanh toán trong 30s</span>
                    </div>
                </div>
                <div class="mt-6 flex items-center gap-4 text-gray-300">
                    <div class="w-10 h-10 rounded-xl bg-bg-surface border border-border-glass flex items-center justify-center shrink-0">
                        <i data-lucide="gift" class="w-5 h-5 text-amber-400"></i>
                    </div>
                    <div>
                        <span class="font-bold text-white block">Tích điểm đổi quà</span>
                        <span class="text-sm text-text-muted">Nhận ngay voucher khi hoàn thành lượt rửa</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column (Form) -->
        <div class="w-full lg:w-1/2 flex flex-col justify-center px-6 sm:px-12 md:px-24 py-12 relative overflow-y-auto bg-bg-primary">
            <a href="${pageContext.request.contextPath}/home" class="absolute top-8 left-6 sm:left-12 flex items-center gap-2 text-text-muted hover:text-white transition-colors font-medium text-sm group z-10">
                <i data-lucide="arrow-left" class="w-4 h-4 group-hover:-translate-x-1 transition-transform"></i>
                <span class="hidden sm:inline">Quay lại</span>
            </a>

            <!-- Mobile Logo -->
            <div class="flex lg:hidden items-center justify-center gap-2 mb-10 mt-8">
                <i data-lucide="droplets" class="text-[#00d4ff] w-8 h-8"></i>
                <h1 class="text-3xl font-display font-bold tracking-tight text-white">AUTOWASH<span class="text-[#00d4ff]">PRO</span></h1>
            </div>

            <div class="max-w-md w-full mx-auto mt-8 lg:mt-0 relative z-10">
                <h2 class="font-display text-3xl font-bold text-white mb-2">Đăng Ký Tài Khoản</h2>
                <p class="text-text-muted text-sm mb-8">Bắt đầu trải nghiệm dịch vụ chuẩn Pro ngay hôm nay.</p>

                <!-- Alerts -->
                <% if (request.getAttribute("errorMessage") != null) {%>
                <div id="serverAlert" class="bg-error/10 border border-error/20 text-error px-4 py-3 rounded-xl mb-6 text-sm flex items-center gap-3">
                    <i data-lucide="alert-circle" class="w-5 h-5 shrink-0"></i>
                    <%= request.getAttribute("errorMessage")%>
                </div>
                <% }%>

                <div id="clientError" class="bg-error/10 border border-error/20 text-error px-4 py-3 rounded-xl mb-6 text-sm flex items-start gap-3 hidden">
                    <i data-lucide="alert-circle" class="w-5 h-5 shrink-0 mt-0.5"></i>
                    <span id="clientErrorText"></span>
                </div>

                <form action="${pageContext.request.contextPath}/auth/register" method="POST" id="registerForm" novalidate onsubmit="return handleRegister(event)" class="space-y-4">

                    <div class="space-y-1 relative">
                        <label for="fullname" class="block text-gray-300 text-sm font-semibold mb-1">Họ và tên *</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <i data-lucide="user" class="w-5 h-5 text-text-muted"></i>
                            </div>
                            <input type="text" id="fullname" name="fullname" placeholder="Nhập họ và tên..." value="<c:out value='${user.fullName}'/>" required
                                   class="w-full bg-bg-surface border border-border-glass text-white rounded-xl pl-11 pr-4 py-3 focus:outline-none focus:ring-2 focus:ring-accent-cyan/50 focus:border-[#00d4ff] transition-all placeholder:text-gray-600">
                        </div>
                        <p class="text-error text-xs mt-1 empty:hidden" id="err-fullname"></p>
                    </div>

                    <div class="space-y-1 relative">
                        <label for="phone" class="block text-gray-300 text-sm font-semibold mb-1">Số điện thoại *</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <i data-lucide="phone" class="w-5 h-5 text-text-muted"></i>
                            </div>
                            <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại..." value="<c:out value='${user.phone}'/>" required
                                   class="w-full bg-bg-surface border border-border-glass text-white rounded-xl pl-11 pr-4 py-3 focus:outline-none focus:ring-2 focus:ring-accent-cyan/50 focus:border-[#00d4ff] transition-all placeholder:text-gray-600">
                        </div>
                        <p class="text-error text-xs mt-1 empty:hidden" id="err-phone"></p>
                    </div>

                    <div class="space-y-1 relative">
                        <label for="plate" class="block text-gray-300 text-sm font-semibold mb-1">Biển số xe *</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <i data-lucide="car-front" class="w-5 h-5 text-text-muted"></i>
                            </div>
                            <input type="text" id="plate" name="plate" placeholder="VD: 51H-123.45" value="<c:out value='${user.licensePlate}'/>" required oninput="this.value = this.value.toUpperCase()"
                                   class="w-full bg-bg-surface border border-border-glass text-white rounded-xl pl-11 pr-4 py-3 focus:outline-none focus:ring-2 focus:ring-accent-cyan/50 focus:border-[#00d4ff] transition-all placeholder:text-gray-600">
                        </div>
                        <p class="text-error text-xs mt-1 empty:hidden" id="err-plate"></p>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 pt-1">
                        <div class="space-y-1 relative">
                            <label class="text-gray-300 text-sm font-semibold mb-1">Mật Khẩu *</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <i data-lucide="lock" class="w-5 h-5 text-text-muted"></i>
                                </div>
                                <input type="password" id="password" name="password" placeholder="Mật khẩu..." required
                                       class="w-full bg-bg-surface border border-border-glass text-white rounded-xl pl-11 pr-10 py-3 focus:outline-none focus:ring-2 focus:ring-accent-cyan/50 focus:border-[#00d4ff] transition-all placeholder:text-gray-600">
                                <button type="button" onclick="togglePassword('password', this)" class="absolute right-3 top-1/2 -translate-y-1/2 text-text-muted hover:text-white transition-colors">
                                    <i data-lucide="eye" class="w-5 h-5"></i>
                                </button>
                            </div>
                            <p class="text-error text-xs mt-1 empty:hidden" id="err-password"></p>
                        </div>

                        <div class="space-y-1 relative">
                            <label class="text-gray-300 text-sm font-semibold mb-1">Xác Nhận *</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                    <i data-lucide="shield-check" class="w-5 h-5 text-text-muted"></i>
                                </div>
                                <input type="password" id="confirm_password" name="confirm_password" placeholder="Nhập lại..." required
                                       class="w-full bg-bg-surface border border-border-glass text-white rounded-xl pl-11 pr-10 py-3 focus:outline-none focus:ring-2 focus:ring-accent-cyan/50 focus:border-[#00d4ff] transition-all placeholder:text-gray-600">
                                <button type="button" onclick="togglePassword('confirm_password', this)" class="absolute right-3 top-1/2 -translate-y-1/2 text-text-muted hover:text-white transition-colors">
                                    <i data-lucide="eye" class="w-5 h-5"></i>
                                </button>
                            </div>
                            <p class="text-error text-xs mt-1 empty:hidden" id="err-confirm_password"></p>
                        </div>
                    </div>

                    <div class="pt-3">
                        <label class="flex items-start gap-3 cursor-pointer group">
                            <div class="relative flex items-center justify-center mt-0.5">
                                <input type="checkbox" id="terms" name="terms" required class="peer appearance-none w-5 h-5 border border-border-glass rounded bg-bg-surface checked:bg-[#00d4ff] checked:border-[#00d4ff] transition-colors cursor-pointer">
                                <i data-lucide="check" class="absolute w-3.5 h-3.5 text-black opacity-0 peer-checked:opacity-100 pointer-events-none"></i>
                            </div>
                            <span class="text-text-muted text-sm leading-relaxed select-none">
                                Tôi đồng ý với <a href="#" class="text-[#00d4ff] hover:text-white transition-colors">Điều khoản dịch vụ</a> và <a href="#" class="text-[#00d4ff] hover:text-white transition-colors">Chính sách bảo mật</a>
                            </span>
                        </label>
                        <p class="text-error text-xs mt-1 ml-8 empty:hidden" id="err-terms"></p>
                    </div>

                    <button type="submit" class="w-full mt-6 btn-glow bg-[#00d4ff] hover:bg-[#00b8e6] text-black font-bold text-base py-4 rounded-xl transition-all shadow-[0_4px_16px_rgba(0,212,255,0.3)] hover:shadow-[0_4px_24px_rgba(0,212,255,0.5)]">
                        Đăng Ký Tài Khoản
                    </button>
                </form>

                <div class="mt-8 pt-8 border-t border-border-glass text-center">
                    <p class="text-text-muted text-sm">
                        Bạn đã có tài khoản?
                        <a href="${pageContext.request.contextPath}/auth/login" class="text-[#00d4ff] font-bold hover:text-white transition-colors ml-1">Đăng nhập</a>
                    </p>
                </div>
            </div>

            <!-- Decorative Glow for Right Column -->
            <div class="absolute top-0 right-0 w-64 h-64 bg-[#00d4ff]/5 blur-[100px] rounded-full mix-blend-screen pointer-events-none"></div>
        </div>

        <!-- Scripts -->
        <script>
            lucide.createIcons();

            function togglePassword(inputId, btn) {
                const input = document.getElementById(inputId);
                if (input.type === 'password') {
                    input.type = 'text';
                    btn.innerHTML = '<i data-lucide="eye-off" class="w-5 h-5"></i>';
                } else {
                    input.type = 'password';
                    btn.innerHTML = '<i data-lucide="eye" class="w-5 h-5"></i>';
                }
                lucide.createIcons();
            }
        </script>
        <script src="${pageContext.request.contextPath}/js/constants.js" charset="UTF-8"></script>
        <script src="${pageContext.request.contextPath}/js/page-register.js" charset="UTF-8"></script>
        <script>
            function handleRegister(event) {
                const form = event.target;
                const phone = form.phone.value.trim();
                const password = form.password.value;
                const confirmPassword = form.confirm_password.value; // Fixed ID matching HTML
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






