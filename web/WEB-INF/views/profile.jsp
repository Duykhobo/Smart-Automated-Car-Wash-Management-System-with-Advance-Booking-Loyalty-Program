<%@page import="dto.Customer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
    <meta charset="utf-8" />
    <title>Hồ Sơ Cá Nhân - Auto Wash Pro</title>
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

    <main class="flex-1 md:ml-64 relative min-h-screen pb-[120px] md:pb-32 bg-bg-primary">
        <header class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center gap-3">
            <h1 class="text-lg md:text-2xl font-display font-bold truncate text-white ml-2 md:ml-0">Hồ Sơ Của Bạn</h1>
        </header>

        <div class="px-4 md:px-8 py-8 max-w-3xl mx-auto space-y-6">

            <!-- Profile Overview Header -->
            <section class="glass-panel rounded-3xl p-6 md:p-8 flex flex-col md:flex-row items-center gap-6 md:gap-8 border-t border-t-white/10 relative overflow-hidden">
                <div class="absolute top-0 right-0 w-64 h-64 bg-[#00d4ff]/10 rounded-full blur-3xl pointer-events-none -mr-32 -mt-32"></div>
                
                <div class="relative group cursor-pointer shrink-0">
                    <div class="w-28 h-28 md:w-36 md:h-36 rounded-full overflow-hidden border-4 border-bg-surface bg-bg-primary flex items-center justify-center transition-transform group-hover:scale-105 shadow-[0_0_20px_rgba(0,212,255,0.2)] relative z-10">
                        <c:choose>
                            <c:when test="${not empty customer.avatar}">
                                <img src="${pageContext.request.contextPath}/${customer.avatar}" alt="Avatar" class="w-full h-full object-cover">
                            </c:when>
                            <c:otherwise>
                                <i data-lucide="user" class="w-12 h-12 text-text-muted"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <!-- Nút thay đổi ảnh đại diện (hiện khi di chuột) -->
                    <div class="absolute inset-0 bg-black/60 rounded-full opacity-0 group-hover:opacity-100 flex flex-col items-center justify-center transition-opacity z-20" onclick="openProfileModal()">
                        <i data-lucide="camera" class="w-6 h-6 text-white mb-1"></i>
                        <span class="text-[10px] font-bold text-white uppercase tracking-wider">Cập nhật</span>
                    </div>
                </div>

                <div class="flex flex-col items-center md:items-start text-center md:text-left z-10 flex-1 w-full">
                    <div class="inline-flex items-center gap-2 px-3 py-1 bg-white/5 border border-white/10 rounded-full mb-3">
                        <i data-lucide="crown" class="w-3.5 h-3.5 text-amber-500"></i>
                        <span class="text-[10px] font-bold text-white uppercase tracking-widest">${not empty customer.tierStatus ? customer.tierStatus : 'MEMBER'}</span>
                    </div>
                    <h2 class="text-2xl md:text-4xl font-display font-bold text-white mb-2">
                        <c:out value="${customer.fullName}" />
                    </h2>
                    <div class="flex flex-col sm:flex-row items-center gap-3 sm:gap-6 text-text-muted font-medium w-full justify-center md:justify-start">
                        <span class="flex items-center gap-2 bg-black/20 px-3 py-1.5 rounded-lg border border-border-glass w-full sm:w-auto justify-center"><i data-lucide="phone" class="w-4 h-4 text-[#00d4ff]"></i> <c:out value="${customer.phone}" /></span>
                        <c:if test="${not empty customer.email}">
                            <span class="flex items-center gap-2 bg-black/20 px-3 py-1.5 rounded-lg border border-border-glass w-full sm:w-auto justify-center"><i data-lucide="mail" class="w-4 h-4 text-[#00d4ff]"></i> <c:out value="${customer.email}" /></span>
                        </c:if>
                    </div>
                </div>
            </section>

            <!-- Stats -->
            <section class="grid grid-cols-2 gap-4">
                <article class="glass-panel flex flex-col items-center justify-center p-6 border-b-2 border-b-[#00d4ff]/50 rounded-2xl hover:-translate-y-1 transition-transform group">
                    <div class="w-10 h-10 rounded-full bg-[#00d4ff]/10 flex items-center justify-center mb-3 group-hover:bg-[#00d4ff]/20 transition-colors">
                        <i data-lucide="wallet" class="w-5 h-5 text-[#00d4ff]"></i>
                    </div>
                    <p class="text-text-muted text-xs md:text-sm mb-1 font-medium uppercase tracking-widest">Tổng chi tiêu</p>
                    <p class="text-white text-xl md:text-3xl font-display font-bold">
                        <fmt:formatNumber value="${customer.totalSpend}" type="number" maxFractionDigits="0"/> <span class="text-base text-text-muted font-sans font-normal ml-1">VND</span>
                    </p>
                </article>
                <article class="glass-panel flex flex-col items-center justify-center p-6 border-b-2 border-b-amber-500/50 rounded-2xl hover:-translate-y-1 transition-transform group">
                    <div class="w-10 h-10 rounded-full bg-amber-500/10 flex items-center justify-center mb-3 group-hover:bg-amber-500/20 transition-colors">
                        <i data-lucide="car" class="w-5 h-5 text-amber-500"></i>
                    </div>
                    <p class="text-text-muted text-xs md:text-sm mb-1 font-medium uppercase tracking-widest">Số lần rửa</p>
                    <p class="text-white text-xl md:text-3xl font-display font-bold">
                        <c:out value="${customer.totalWashes}" /> <span class="text-base text-text-muted font-sans font-normal ml-1">lần</span>
                    </p>
                </article>
            </section>

            <!-- Actions List -->
            <section class="space-y-4">
                <h3 class="font-display font-bold text-lg text-white ml-2">Cài đặt Tài khoản</h3>
                <nav class="flex flex-col gap-3">
                    <a href="${pageContext.request.contextPath}/vehicles" class="flex items-center justify-between p-4 glass-panel hover:bg-white/5 border border-transparent hover:border-[#00d4ff]/30 rounded-2xl transition-all group">
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 bg-bg-primary rounded-xl flex items-center justify-center border border-border-glass group-hover:border-[#00d4ff]/50 transition-colors shadow-inner">
                                <i data-lucide="car-front" class="w-5 h-5 text-text-muted group-hover:text-[#00d4ff] transition-colors"></i>
                            </div>
                            <span class="font-bold text-white text-base">Quản lý xe</span>
                        </div>
                        <i data-lucide="chevron-right" class="w-5 h-5 text-text-muted group-hover:text-[#00d4ff] transition-transform group-hover:translate-x-1"></i>
                    </a>

                    <a href="${pageContext.request.contextPath}/customer/booking_history" class="flex items-center justify-between p-4 glass-panel hover:bg-white/5 border border-transparent hover:border-[#00d4ff]/30 rounded-2xl transition-all group">
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 bg-bg-primary rounded-xl flex items-center justify-center border border-border-glass group-hover:border-[#00d4ff]/50 transition-colors shadow-inner">
                                <i data-lucide="receipt" class="w-5 h-5 text-text-muted group-hover:text-[#00d4ff] transition-colors"></i>
                            </div>
                            <span class="font-bold text-white text-base">Lịch sử giao dịch</span>
                        </div>
                        <i data-lucide="chevron-right" class="w-5 h-5 text-text-muted group-hover:text-[#00d4ff] transition-transform group-hover:translate-x-1"></i>
                    </a>

                    <a href="${pageContext.request.contextPath}/account/payment-methods" class="flex items-center justify-between p-4 glass-panel hover:bg-white/5 border border-transparent hover:border-[#00d4ff]/30 rounded-2xl transition-all group">
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 bg-bg-primary rounded-xl flex items-center justify-center border border-border-glass group-hover:border-[#00d4ff]/50 transition-colors shadow-inner">
                                <i data-lucide="credit-card" class="w-5 h-5 text-text-muted group-hover:text-[#00d4ff] transition-colors"></i>
                            </div>
                            <span class="font-bold text-white text-base">Phương thức thanh toán</span>
                        </div>
                        <i data-lucide="chevron-right" class="w-5 h-5 text-text-muted group-hover:text-[#00d4ff] transition-transform group-hover:translate-x-1"></i>
                    </a>

                    <a href="${pageContext.request.contextPath}/account/change-password" class="flex items-center justify-between p-4 glass-panel hover:bg-white/5 border border-transparent hover:border-[#00d4ff]/30 rounded-2xl transition-all group">
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 bg-bg-primary rounded-xl flex items-center justify-center border border-border-glass group-hover:border-[#00d4ff]/50 transition-colors shadow-inner">
                                <i data-lucide="key-round" class="w-5 h-5 text-text-muted group-hover:text-[#00d4ff] transition-colors"></i>
                            </div>
                            <span class="font-bold text-white text-base">Đổi mật khẩu</span>
                        </div>
                        <i data-lucide="chevron-right" class="w-5 h-5 text-text-muted group-hover:text-[#00d4ff] transition-transform group-hover:translate-x-1"></i>
                    </a>
                </nav>

                <form action="${pageContext.request.contextPath}/auth/logout" method="post" class="mt-8 pt-4">
                    <button type="submit" class="flex items-center justify-center gap-3 w-full p-4 rounded-2xl border border-rose-500/30 bg-rose-500/10 hover:bg-rose-500 hover:border-rose-500 text-rose-500 hover:text-white transition-all font-bold text-base shadow-lg group">
                        <i data-lucide="log-out" class="w-5 h-5 transition-transform group-hover:-translate-x-1 group-hover:scale-110"></i>
                        <span>Đăng xuất</span>
                    </button>
                </form>
            </section>
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

    <!-- Profile Edit Modal -->
    <div id="profileModal" class="fixed inset-0 z-50 hidden items-center justify-center p-4">
        <!-- Backdrop -->
        <div class="absolute inset-0 bg-[#070b14]/80 backdrop-blur-md transition-opacity" onclick="closeProfileModal()"></div>

        <!-- Modal Content -->
        <div class="relative glass-panel w-full max-w-md rounded-3xl border border-white/10 shadow-[0_0_50px_rgba(0,0,0,0.5)] overflow-hidden transform scale-95 opacity-0 transition-all duration-300" id="profileModalContent">
            <!-- Header -->
            <div class="flex items-center justify-between p-6 border-b border-white/5 relative bg-gradient-to-r from-[#00d4ff]/10 to-transparent">
                <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-[#00d4ff] to-blue-500"></div>
                <h3 class="text-xl font-display font-bold text-white flex items-center gap-2"><i data-lucide="user-pen" class="w-5 h-5 text-[#00d4ff]"></i> Chỉnh Sửa Hồ Sơ</h3>
                <button type="button" onclick="closeProfileModal()" class="text-text-muted hover:text-white hover:bg-white/10 p-2 rounded-full transition-colors">
                    <i data-lucide="x" class="w-5 h-5"></i>
                </button>
            </div>

            <!-- Body Form -->
            <form action="${pageContext.request.contextPath}/CustomerProfileServlet" method="POST" enctype="multipart/form-data" class="p-6 space-y-5">
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="bg-rose-500/10 border border-rose-500/30 text-rose-400 px-4 py-3 rounded-xl text-sm flex items-start gap-3">
                        <i data-lucide="alert-circle" class="w-5 h-5 shrink-0 mt-0.5"></i>
                        <c:out value="${sessionScope.errorMessage}" />
                    </div>
                </c:if>
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 px-4 py-3 rounded-xl text-sm flex items-start gap-3">
                        <i data-lucide="check-circle-2" class="w-5 h-5 shrink-0 mt-0.5"></i>
                        <c:out value="${sessionScope.successMessage}" />
                    </div>
                </c:if>

                <!-- Avatar Upload -->
                <div class="flex flex-col items-center gap-3 mb-2">
                    <label for="avatarUpload" class="w-24 h-24 rounded-full border-2 border-dashed border-border-glass flex items-center justify-center bg-bg-primary hover:border-[#00d4ff] transition-colors cursor-pointer group overflow-hidden relative shadow-inner">
                        <c:choose>
                            <c:when test="${not empty customer.avatar}">
                                <img id="avatarPreview" src="${pageContext.request.contextPath}/${customer.avatar}" alt="Avatar" class="w-full h-full object-cover">
                            </c:when>
                            <c:otherwise>
                                <img id="avatarPreview" src="" alt="Avatar" class="w-full h-full object-cover hidden">
                                <i id="avatarPlaceholder" data-lucide="image-plus" class="w-8 h-8 text-text-muted group-hover:text-[#00d4ff] transition-colors absolute"></i>
                            </c:otherwise>
                        </c:choose>
                        <div class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                            <i data-lucide="upload" class="w-6 h-6 text-white"></i>
                        </div>
                        <input type="file" id="avatarUpload" name="avatarUpload" accept="image/*" class="hidden" onchange="previewAvatar(event)">
                    </label>
                    <span class="text-xs text-text-muted font-medium bg-black/20 px-3 py-1 rounded-full border border-border-glass">Nhấn vào ảnh để thay đổi</span>
                </div>

                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium ml-1">Họ và Tên</label>
                    <input type="text" name="txtfullname" value="<c:out value='${customer.fullName}'/>" required class="w-full bg-black/20 border border-border-glass text-white rounded-xl px-4 py-3 focus:outline-none focus:border-[#00d4ff] focus:shadow-[0_0_10px_rgba(0,212,255,0.1)] transition-all">
                </div>

                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium ml-1">Số điện thoại</label>
                    <div class="relative">
                        <input type="tel" name="phone" value="<c:out value='${customer.phone}'/>" required readonly class="w-full bg-black/30 border border-border-glass text-text-muted rounded-xl px-4 py-3 pl-11 focus:outline-none cursor-not-allowed" title="Không thể thay đổi số điện thoại">
                        <i data-lucide="lock" class="w-4 h-4 text-text-muted absolute left-4 top-1/2 -translate-y-1/2"></i>
                    </div>
                </div>

                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium ml-1">Email (Tùy chọn)</label>
                    <input type="email" name="email" value="<c:out value='${customer.email}'/>" placeholder="Nhập email của bạn..." class="w-full bg-black/20 border border-border-glass text-white rounded-xl px-4 py-3 focus:outline-none focus:border-[#00d4ff] focus:shadow-[0_0_10px_rgba(0,212,255,0.1)] transition-all placeholder:text-gray-600">
                </div>

                <!-- Footer / Actions -->
                <div class="pt-4 flex gap-3">
                    <button type="button" onclick="closeProfileModal()" class="flex-1 px-4 py-3.5 rounded-xl border border-border-glass text-white font-bold hover:bg-white/5 transition-colors">
                        Hủy
                    </button>
                    <button type="submit" class="flex-1 px-4 py-3.5 rounded-xl btn-glow bg-[#00d4ff] hover:bg-white text-black font-bold shadow-[0_0_20px_rgba(0,212,255,0.3)] transition-all flex items-center justify-center gap-2">
                        <i data-lucide="save" class="w-4 h-4"></i> Lưu thay đổi
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        lucide.createIcons();

        const profileModal = document.getElementById('profileModal');
        const profileModalContent = document.getElementById('profileModalContent');

        function openProfileModal() {
            profileModal.classList.remove('hidden');
            profileModal.classList.add('flex');

            setTimeout(() => {
                profileModalContent.classList.remove('scale-95', 'opacity-0');
                profileModalContent.classList.add('scale-100', 'opacity-100');
            }, 10);
        }

        function closeProfileModal() {
            profileModalContent.classList.remove('scale-100', 'opacity-100');
            profileModalContent.classList.add('scale-95', 'opacity-0');

            setTimeout(() => {
                profileModal.classList.remove('flex');
                profileModal.classList.add('hidden');
            }, 300);
        }

        function previewAvatar(event) {
            const reader = new FileReader();
            reader.onload = function () {
                const preview = document.getElementById('avatarPreview');
                const placeholder = document.getElementById('avatarPlaceholder');
                preview.src = reader.result;
                preview.classList.remove('hidden');
                if (placeholder) placeholder.classList.add('hidden');
            }
            if (event.target.files[0]) {
                reader.readAsDataURL(event.target.files[0]);
            }
        }

        <c:if test="${not empty sessionScope.errorMessage or not empty sessionScope.successMessage}">
            openProfileModal();
        </c:if>
    </script>

    <c:remove var="errorMessage" scope="session" />
    <c:remove var="successMessage" scope="session" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>