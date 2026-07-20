<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <title>${pageTitle} - AutoWash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
</head>

<body class="bg-bg-primary text-text-primary antialiased overflow-x-hidden selection:bg-[#00d4ff] selection:text-black">

    <!-- Floating Glass Navbar -->
    <nav class="fixed top-4 left-1/2 -translate-x-1/2 w-[95%] max-w-7xl z-50 glass-panel rounded-2xl px-6 py-4 flex items-center justify-between transition-all duration-300">
        <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2 cursor-pointer">
            <i data-lucide="droplets" class="text-[#00d4ff] w-8 h-8"></i>
            <span class="font-display font-bold text-xl tracking-wide text-white">AUTOWASH<span class="text-[#00d4ff]">PRO</span></span>
        </a>

        <div class="hidden md:flex items-center gap-8">
            <a href="${pageContext.request.contextPath}/#services" class="text-text-muted hover:text-white transition-colors text-sm font-medium">Dịch Vụ</a>
            <a href="${pageContext.request.contextPath}/#benefits" class="text-text-muted hover:text-white transition-colors text-sm font-medium">Đặc Quyền</a>
            <a href="${pageContext.request.contextPath}/loyalty" class="text-[#00d4ff] font-medium text-sm drop-shadow-[0_0_8px_rgba(0,212,255,0.6)]">Loyalty Program</a>
        </div>

        <div class="flex items-center gap-4">
            <c:choose>
                <c:when test="${not empty sessionScope.USER_ACCOUNT}">
                    <a href="${pageContext.request.contextPath}/account/dashboard" class="text-white hover:text-[#00d4ff] transition-colors text-sm font-medium hidden sm:block">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/auth/logout" class="btn-glow bg-red-500/20 text-red-400 border border-red-500/50 hover:bg-red-500/30 px-5 py-2.5 rounded-xl font-semibold text-sm transition-all">Đăng Xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/auth/login" class="text-white hover:text-[#00d4ff] transition-colors text-sm font-medium hidden sm:block">Đăng Nhập</a>
                    <a href="${pageContext.request.contextPath}/auth/register" class="btn-glow bg-[#00d4ff] text-black px-5 py-2.5 rounded-xl font-semibold text-sm">Đăng Ký Ngay</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <main class="flex min-h-screen flex-col items-center justify-start relative w-full pt-40 md:pt-48 pb-20 px-6">
        
        <!-- Header Text -->
        <div class="w-full max-w-5xl text-center mb-16">
            <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full border border-border-glass bg-bg-surface backdrop-blur-md mb-6">
                <i data-lucide="crown" class="w-4 h-4 text-amber-400"></i>
                <span class="text-xs font-semibold text-text-muted tracking-wider uppercase">Chương Trình Khách Hàng Thân Thiết</span>
            </div>
            <h1 class="text-4xl md:text-5xl font-display font-bold text-white mb-6 leading-tight">
                Rửa Càng Nhiều, <span class="text-transparent bg-clip-text bg-gradient-to-r from-amber-400 to-orange-500">Quà Càng To</span>
            </h1>
            <p class="text-text-muted max-w-2xl mx-auto text-lg">
                Hệ thống thăng hạng tích lũy thông minh. Trở thành khách VIP của AutoWash Pro để nhận các đặc quyền không giới hạn: Đặt lịch trước, giảm giá dịch vụ, rửa xe miễn phí.
            </p>
        </div>

        <!-- Tiers Grid -->
        <div class="w-full max-w-7xl grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            
            <!-- MEMBER -->
            <div class="glass-panel rounded-3xl p-8 flex flex-col relative overflow-hidden group hover:-translate-y-2 transition-all duration-300 border border-slate-500/30 hover:border-slate-400/50">
                <div class="absolute top-0 right-0 w-32 h-32 bg-slate-500/10 rounded-full blur-2xl group-hover:bg-slate-500/20 transition-all"></div>
                <div class="flex items-center gap-3 mb-4">
                    <div class="w-10 h-10 rounded-xl bg-slate-500/20 flex items-center justify-center border border-slate-500/30">
                        <i data-lucide="user" class="w-5 h-5 text-slate-300"></i>
                    </div>
                    <h3 class="text-xl font-display font-bold text-white">Member</h3>
                </div>
                <div class="mb-6">
                    <p class="text-text-muted text-sm mb-1">Điều kiện lên hạng:</p>
                    <p class="font-semibold text-white">Đăng ký tài khoản + 1 lần rửa</p>
                </div>
                <hr class="border-border-glass mb-6">
                <ul class="space-y-4 mb-8 flex-1">
                    <li class="flex items-start gap-3">
                        <i data-lucide="check" class="w-5 h-5 text-slate-400 shrink-0 mt-0.5"></i>
                        <span class="text-sm text-gray-300">Tích lũy: <strong class="text-white">1 điểm = 1.000 VNĐ</strong> chi tiêu</span>
                    </li>
                    <li class="flex items-start gap-3">
                        <i data-lucide="check" class="w-5 h-5 text-slate-400 shrink-0 mt-0.5"></i>
                        <span class="text-sm text-gray-300">Đặt lịch trước: <strong class="text-white">7 ngày</strong></span>
                    </li>
                </ul>
            </div>

            <!-- SILVER -->
            <div class="glass-panel rounded-3xl p-8 flex flex-col relative overflow-hidden group hover:-translate-y-2 transition-all duration-300 border border-zinc-300/30 hover:border-zinc-300/50 shadow-[0_0_30px_rgba(212,212,216,0.05)]">
                <div class="absolute top-0 right-0 w-32 h-32 bg-zinc-300/10 rounded-full blur-2xl group-hover:bg-zinc-300/20 transition-all"></div>
                <div class="flex items-center gap-3 mb-4">
                    <div class="w-10 h-10 rounded-xl bg-zinc-300/20 flex items-center justify-center border border-zinc-300/30">
                        <i data-lucide="award" class="w-5 h-5 text-zinc-300"></i>
                    </div>
                    <h3 class="text-xl font-display font-bold text-white">Silver</h3>
                </div>
                <div class="mb-6">
                    <p class="text-text-muted text-sm mb-1">Điều kiện lên hạng:</p>
                    <p class="font-semibold text-white">5 lần rửa <span class="text-text-muted font-normal text-xs mx-1">HOẶC</span> 2.000.000đ</p>
                </div>
                <hr class="border-border-glass mb-6">
                <ul class="space-y-4 mb-8 flex-1">
                    <li class="flex items-start gap-3">
                        <i data-lucide="check-circle-2" class="w-5 h-5 text-[#00d4ff] shrink-0 mt-0.5 drop-shadow-[0_0_5px_rgba(0,212,255,0.5)]"></i>
                        <span class="text-sm text-gray-300">Nhận thêm <strong class="text-[#00d4ff]">+10% Điểm</strong></span>
                    </li>
                    <li class="flex items-start gap-3">
                        <i data-lucide="check" class="w-5 h-5 text-zinc-300 shrink-0 mt-0.5"></i>
                        <span class="text-sm text-gray-300">Truy cập Slot Ưu tiên</span>
                    </li>
                    <li class="flex items-start gap-3">
                        <i data-lucide="check" class="w-5 h-5 text-zinc-300 shrink-0 mt-0.5"></i>
                        <span class="text-sm text-gray-300">Đặt lịch trước: <strong class="text-white">10 ngày</strong></span>
                    </li>
                </ul>
            </div>

            <!-- GOLD -->
            <div class="glass-panel rounded-3xl p-8 flex flex-col relative group hover:-translate-y-2 transition-all duration-300 border border-yellow-400/30 hover:border-yellow-400/60 shadow-[0_0_30px_rgba(250,204,21,0.1)] scale-105 z-10 bg-bg-surface/80 backdrop-blur-xl">
                <div class="absolute top-0 right-0 w-40 h-40 bg-yellow-400/10 rounded-full blur-3xl group-hover:bg-yellow-400/20 transition-all"></div>
                <!-- Popular Badge -->
                <div class="absolute top-0 inset-x-0 flex justify-center -translate-y-1/2">
                    <span class="bg-gradient-to-r from-yellow-400 to-amber-500 text-black text-[10px] font-bold uppercase tracking-widest py-1 px-4 rounded-full shadow-lg">Phổ biến nhất</span>
                </div>
                
                <div class="flex items-center gap-3 mb-4 mt-2">
                    <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-yellow-400/20 to-amber-500/20 flex items-center justify-center border border-yellow-400/40 shadow-[0_0_15px_rgba(250,204,21,0.2)]">
                        <i data-lucide="crown" class="w-6 h-6 text-yellow-400"></i>
                    </div>
                    <h3 class="text-2xl font-display font-bold text-transparent bg-clip-text bg-gradient-to-r from-yellow-300 to-amber-500">Gold</h3>
                </div>
                <div class="mb-6">
                    <p class="text-text-muted text-sm mb-1">Điều kiện lên hạng:</p>
                    <p class="font-semibold text-white">15 lần rửa <span class="text-text-muted font-normal text-xs mx-1">HOẶC</span> 6.000.000đ</p>
                </div>
                <hr class="border-border-glass mb-6">
                <ul class="space-y-4 mb-8 flex-1">
                    <li class="flex items-start gap-3">
                        <i data-lucide="check-circle-2" class="w-5 h-5 text-yellow-400 shrink-0 mt-0.5 drop-shadow-[0_0_5px_rgba(250,204,21,0.5)]"></i>
                        <span class="text-sm text-gray-300">Nhận thêm <strong class="text-yellow-400">+20% Điểm</strong></span>
                    </li>
                    <li class="flex items-start gap-3">
                        <i data-lucide="star" class="w-5 h-5 text-yellow-400 shrink-0 mt-0.5 fill-yellow-400/20"></i>
                        <span class="text-sm text-white font-medium">Miễn phí nâng cấp Wax (Hàng tháng)</span>
                    </li>
                    <li class="flex items-start gap-3">
                        <i data-lucide="check" class="w-5 h-5 text-yellow-400/70 shrink-0 mt-0.5"></i>
                        <span class="text-sm text-gray-300">Truy cập Slot Ưu tiên</span>
                    </li>
                    <li class="flex items-start gap-3">
                        <i data-lucide="check" class="w-5 h-5 text-yellow-400/70 shrink-0 mt-0.5"></i>
                        <span class="text-sm text-gray-300">Đặt lịch trước: <strong class="text-white">12 ngày</strong></span>
                    </li>
                </ul>
            </div>

            <!-- PLATINUM -->
            <div class="glass-panel rounded-3xl p-8 flex flex-col relative overflow-hidden group hover:-translate-y-2 transition-all duration-300 border border-purple-400/30 hover:border-purple-400/60 shadow-[0_0_30px_rgba(168,85,247,0.1)]">
                <div class="absolute top-0 right-0 w-32 h-32 bg-purple-400/10 rounded-full blur-2xl group-hover:bg-purple-400/20 transition-all"></div>
                <div class="flex items-center gap-3 mb-4">
                    <div class="w-10 h-10 rounded-xl bg-purple-500/20 flex items-center justify-center border border-purple-400/40 shadow-[0_0_15px_rgba(168,85,247,0.2)]">
                        <i data-lucide="gem" class="w-5 h-5 text-purple-400"></i>
                    </div>
                    <h3 class="text-xl font-display font-bold text-transparent bg-clip-text bg-gradient-to-r from-purple-300 to-fuchsia-400">Platinum</h3>
                </div>
                <div class="mb-6">
                    <p class="text-text-muted text-sm mb-1">Điều kiện lên hạng:</p>
                    <p class="font-semibold text-white">30 lần rửa <span class="text-text-muted font-normal text-xs mx-1">HOẶC</span> 15.000.000đ</p>
                </div>
                <hr class="border-border-glass mb-6">
                <ul class="space-y-4 mb-8 flex-1">
                    <li class="flex items-start gap-3">
                        <i data-lucide="check-circle-2" class="w-5 h-5 text-purple-400 shrink-0 mt-0.5 drop-shadow-[0_0_5px_rgba(168,85,247,0.5)]"></i>
                        <span class="text-sm text-gray-300">Nhận thêm <strong class="text-purple-400">+30% Điểm</strong></span>
                    </li>
                    <li class="flex items-start gap-3">
                        <i data-lucide="gift" class="w-5 h-5 text-purple-400 shrink-0 mt-0.5 fill-purple-400/20"></i>
                        <span class="text-sm text-white font-medium">Miễn phí 1 lần Rửa Xe (Hàng tháng)</span>
                    </li>
                    <li class="flex items-start gap-3">
                        <i data-lucide="check" class="w-5 h-5 text-purple-400/70 shrink-0 mt-0.5"></i>
                        <span class="text-sm text-gray-300">Truy cập Slot Ưu tiên tuyệt đối</span>
                    </li>
                    <li class="flex items-start gap-3">
                        <i data-lucide="check" class="w-5 h-5 text-purple-400/70 shrink-0 mt-0.5"></i>
                        <span class="text-sm text-gray-300">Đặt lịch trước: <strong class="text-white">14 ngày</strong></span>
                    </li>
                </ul>
            </div>

        </div>

        <!-- CTA Section -->
        <div class="mt-20 text-center flex flex-col items-center">
            <h2 class="text-2xl font-display font-bold text-white mb-4">Sẵn sàng để nhận đặc quyền?</h2>
            <p class="text-text-muted mb-8 max-w-md">Bắt đầu tích điểm ngay hôm nay để mở khóa những trải nghiệm chăm sóc xe đẳng cấp nhất.</p>
            <c:choose>
                <c:when test="${not empty sessionScope.USER_ACCOUNT}">
                    <a href="${pageContext.request.contextPath}/account/dashboard" class="btn-glow bg-[#00d4ff] text-black px-8 py-3.5 rounded-xl font-bold text-sm tracking-wide">XEM TIẾN TRÌNH CỦA BẠN</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/auth/register" class="btn-glow bg-[#00d4ff] text-black px-8 py-3.5 rounded-xl font-bold text-sm tracking-wide">THAM GIA NGAY MIỄN PHÍ</a>
                </c:otherwise>
            </c:choose>
        </div>

    </main>

    <script charset="UTF-8" src="https://unpkg.com/lucide@latest"></script>
</body>
</html>
