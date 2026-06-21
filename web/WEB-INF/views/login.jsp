<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi" style="color-scheme: dark;">
    <head>
<!-- Google Fonts (Vietnamese Supported) & Font Fallback -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
  body, .font-sans { font-family: 'Inter', sans-serif !important; }
  .font-display { font-family: 'Be Vietnam Pro', sans-serif !important; }
  
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
        <meta charset="utf-8" />
        <title>Auto Wash Pro - Đăng Nhập</title>
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
        <div class="hidden lg:flex flex-col justify-center w-1/2 p-12 lg:p-24 bg-gradient-to-br from-bg-primary to-[#0a1128] border-r border-border-glass relative overflow-hidden">
            <div class="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1601362840469-51e4d8d58785?auto=format&fit=crop&q=80')] bg-cover bg-center opacity-10"></div>
            <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-[#00d4ff]/10 blur-[100px] rounded-full mix-blend-screen pointer-events-none"></div>
            
            <div class="relative z-10">
                <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-2 mb-12">
                    <i data-lucide="droplets" class="text-[#00d4ff] w-10 h-10"></i>
                    <h1 class="text-4xl font-display font-bold tracking-tight text-white">AUTOWASH<span class="text-[#00d4ff]">PRO</span></h1>
                </a>
                
                <h2 class="text-4xl font-display font-bold mb-6 text-white leading-tight">Khởi đầu kỷ nguyên<br/>chăm sóc xe <span class="text-[#00d4ff] glow-text">thông minh</span></h2>
                <p class="text-text-muted text-lg leading-relaxed max-w-lg mb-12">
                    Hệ thống đặt lịch tự động tích hợp Loyalty Program. Đặt lịch trước 14 ngày, tích điểm đổi quà và tận hưởng đặc quyền ưu tiên.
                </p>

                <div class="flex items-center gap-4 text-gray-300">
                    <div class="w-10 h-10 rounded-xl bg-bg-surface border border-border-glass flex items-center justify-center shrink-0">
                        <i data-lucide="zap" class="w-5 h-5 text-amber-400"></i>
                    </div>
                    <div>
                        <span class="font-bold text-white block">Priority Slots</span>
                        <span class="text-sm text-text-muted">Đặc quyền xếp hàng ưu tiên cho hạng Silver+</span>
                    </div>
                </div>
                <div class="mt-6 flex items-center gap-4 text-gray-300">
                    <div class="w-10 h-10 rounded-xl bg-bg-surface border border-border-glass flex items-center justify-center shrink-0">
                        <i data-lucide="award" class="w-5 h-5 text-[#00d4ff]"></i>
                    </div>
                    <div>
                        <span class="font-bold text-white block">Loyalty Rewards</span>
                        <span class="text-sm text-text-muted">Tích điểm sau mỗi lần rửa, đổi voucher miễn phí</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column (Form) -->
        <div class="w-full lg:w-1/2 flex flex-col justify-center px-6 sm:px-12 md:px-24 py-12 relative bg-bg-primary">
            <a href="${pageContext.request.contextPath}/home" class="absolute top-8 left-6 sm:left-12 flex items-center gap-2 text-text-muted hover:text-white transition-colors font-medium text-sm group z-10">
                <i data-lucide="arrow-left" class="w-4 h-4 group-hover:-translate-x-1 transition-transform"></i>
                <span class="hidden sm:inline">Quay lại trang chủ</span>
            </a>

            <!-- Mobile Logo -->
            <div class="flex lg:hidden items-center justify-center gap-2 mb-10 mt-8">
                <i data-lucide="droplets" class="text-[#00d4ff] w-8 h-8"></i>
                <h1 class="text-3xl font-display font-bold tracking-tight text-white">AUTOWASH<span class="text-[#00d4ff]">PRO</span></h1>
            </div>

            <div class="max-w-md w-full mx-auto relative z-10">
                <h2 class="font-display text-3xl font-bold text-white mb-2">Đăng Nhập</h2>
                <p class="text-text-muted text-sm mb-8">Chào mừng bạn quay trở lại hệ thống</p>

                <!-- Alerts -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="bg-success/10 border border-success/20 text-success px-4 py-3 rounded-xl mb-6 text-sm flex items-center gap-3">
                        <i data-lucide="check-circle" class="w-5 h-5 shrink-0"></i>
                        <c:out value="${sessionScope.successMessage}" />
                        <c:remove var="successMessage" scope="session" />
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="bg-error/10 border border-error/20 text-error px-4 py-3 rounded-xl mb-6 text-sm flex items-center gap-3">
                        <i data-lucide="alert-circle" class="w-5 h-5 shrink-0"></i>
                        <c:out value="${errorMessage}" />
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/auth/login" method="POST" novalidate class="space-y-5">
                    <div class="space-y-2">
                        <label class="text-gray-300 text-sm font-semibold">Số Điện Thoại</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <i data-lucide="phone" class="w-5 h-5 text-text-muted"></i>
                            </div>
                            <input type="text" name="phone" placeholder="Nhập số điện thoại..." value="<c:out value='${phone}'/>" required autocomplete="off" 
                                   class="w-full bg-bg-surface border border-border-glass text-white rounded-xl pl-11 pr-4 py-3.5 focus:outline-none focus:ring-2 focus:ring-[#00d4ff]/50 focus:border-[#00d4ff] transition-all placeholder:text-gray-600">
                        </div>
                    </div>

                    <div class="space-y-2">
                        <div class="flex items-center justify-between">
                            <label class="text-gray-300 text-sm font-semibold">Mật Khẩu</label>
                            <a href="${pageContext.request.contextPath}/auth/forgot-password" class="text-[#00d4ff] text-xs font-semibold hover:text-white transition-colors">Quên mật khẩu?</a>
                        </div>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <i data-lucide="lock" class="w-5 h-5 text-text-muted"></i>
                            </div>
                            <input type="password" name="password" placeholder="Nhập mật khẩu..." required 
                                   class="w-full bg-bg-surface border border-border-glass text-white rounded-xl pl-11 pr-4 py-3.5 focus:outline-none focus:ring-2 focus:ring-[#00d4ff]/50 focus:border-[#00d4ff] transition-all placeholder:text-gray-600">
                        </div>
                    </div>

                    <button type="submit" class="w-full btn-glow bg-[#00d4ff] hover:bg-[#00b8e6] text-black font-bold text-base py-4 rounded-xl transition-all mt-4 shadow-[0_4px_16px_rgba(0,212,255,0.3)] hover:shadow-[0_4px_24px_rgba(0,212,255,0.5)]">
                        Đăng Nhập
                    </button>
                </form>

                <div class="mt-8 pt-8 border-t border-border-glass text-center">
                    <p class="text-text-muted text-sm">
                        Bạn chưa có tài khoản? 
                        <a href="${pageContext.request.contextPath}/auth/register" class="text-[#00d4ff] font-bold hover:text-white transition-colors ml-1">Đăng ký ngay</a>
                    </p>
                </div>
            </div>
            
            <!-- Decorative Glow for Right Column -->
            <div class="absolute bottom-0 right-0 w-64 h-64 bg-[#3b82f6]/5 blur-[100px] rounded-full mix-blend-screen pointer-events-none"></div>
        </div>

        <script>
            lucide.createIcons();
        </script>
        <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>






