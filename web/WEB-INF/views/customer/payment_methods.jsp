<%@page import="dto.Customer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Phương thức thanh toán - Auto Wash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
    
</head>

<body class="m-0 min-h-screen bg-bg-primary text-white font-sans antialiased w-full overflow-x-hidden">

    <!-- Desktop Sidebar -->
    <jsp:include page="/WEB-INF/views/components/customer_sidebar.jsp">
    <jsp:param name="activeMenu" value="dashboard" />
</jsp:include>

    <main class="flex-1 md:ml-64 relative min-h-screen pb-[120px] md:pb-8 bg-bg-primary">
        <header class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center gap-4">
            <a href="${pageContext.request.contextPath}/account/profile" class="w-10 h-10 rounded-full bg-white/5 border border-border-glass flex items-center justify-center text-text-muted hover:text-white hover:bg-white/10 transition-colors">
                <i data-lucide="arrow-left" class="w-5 h-5"></i>
            </a>
            <h1 class="text-lg md:text-2xl font-display font-bold truncate text-white">Thanh Toán & Ví</h1>
        </header>

        <div class="px-4 md:px-8 py-8 max-w-4xl mx-auto space-y-8">
            
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-2xl font-display font-bold text-white mb-1">Phương Thức Mặc Định</h2>
                    <p class="text-text-muted text-sm">Chọn phương thức thanh toán ưu tiên khi đặt lịch rửa xe.</p>
                </div>
            </div>

            <!-- Payment Options Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Cash Option -->
                <div class="glass-panel relative rounded-2xl overflow-hidden p-6 hover:bg-white/5 transition-colors group cursor-pointer border border-[#00d4ff]/50 bg-[#00d4ff]/5">
                    <div class="flex justify-between items-start mb-6">
                        <div class="w-12 h-12 bg-[#00d4ff]/20 rounded-xl flex items-center justify-center text-[#00d4ff]">
                            <i data-lucide="banknote" class="w-6 h-6"></i>
                        </div>
                        <span class="bg-[#00d4ff]/20 text-[#00d4ff] text-xs px-2 py-1 rounded font-bold border border-[#00d4ff]/30 flex items-center gap-1">
                            <i data-lucide="check-circle-2" class="w-3 h-3"></i> Đang chọn
                        </span>
                    </div>
                    <div class="space-y-1">
                        <h3 class="text-lg font-bold text-white">Tiền mặt tại trung tâm</h3>
                        <p class="text-sm text-text-muted">Thanh toán trực tiếp sau khi hoàn tất dịch vụ chăm sóc xe.</p>
                    </div>
                </div>

                <!-- Bank Transfer / QR Option -->
                <div class="glass-panel relative rounded-2xl overflow-hidden p-6 hover:bg-white/5 hover:border-border-glow transition-all group cursor-pointer border border-border-glass">
                    <div class="flex justify-between items-start mb-6">
                        <div class="w-12 h-12 bg-white/5 rounded-xl flex items-center justify-center text-white">
                            <i data-lucide="qr-code" class="w-6 h-6"></i>
                        </div>
                        <button class="hidden group-hover:block text-xs font-semibold text-[#00d4ff] bg-[#00d4ff]/10 px-3 py-1.5 rounded-lg border border-[#00d4ff]/30 transition-all hover:bg-[#00d4ff] hover:text-black">
                            Đặt làm mặc định
                        </button>
                    </div>
                    <div class="space-y-1">
                        <h3 class="text-lg font-bold text-white">Chuyển khoản / Quét QR</h3>
                        <p class="text-sm text-text-muted">Thanh toán tiện lợi qua Internet Banking của mọi ngân hàng.</p>
                    </div>
                </div>
            </div>

            <!-- E-Wallets Section -->
            <div class="mt-12">
                <h2 class="text-2xl font-display font-bold text-white mb-1">Cổng Thanh Toán Trực Tuyến</h2>
                <p class="text-text-muted text-sm mb-6">Hỗ trợ thanh toán nhanh chóng khi đặt lịch online (Advance Booking).</p>

                <div class="space-y-4">
                    <!-- VNPay -->
                    <div class="glass-panel rounded-2xl p-5 flex items-center justify-between hover:bg-white/5 transition-colors border border-border-glass">
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 rounded-xl bg-white flex items-center justify-center shadow-lg p-1 border-2 border-transparent">
                                <span class="font-bold text-[#005ba6] text-sm tracking-wide">VNPAY</span>
                            </div>
                            <div>
                                <h3 class="font-bold text-white text-base">Cổng thanh toán VNPAY</h3>
                                <p class="text-xs text-text-muted mt-0.5">Quét mã QR qua App Ngân hàng hoặc Thẻ ATM/Visa</p>
                            </div>
                        </div>
                        <div class="flex items-center gap-2 text-emerald-400 bg-emerald-400/10 px-3 py-1.5 rounded-lg border border-emerald-400/20">
                            <i data-lucide="shield-check" class="w-4 h-4"></i>
                            <span class="text-sm font-semibold hidden sm:inline">Hỗ trợ</span>
                        </div>
                    </div>
                    
                    <!-- MoMo Wallet -->
                    <div class="glass-panel rounded-2xl p-5 flex items-center justify-between hover:bg-white/5 transition-colors border border-border-glass">
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 rounded-xl bg-[#ae2070] flex items-center justify-center shadow-lg">
                                <span class="font-bold text-white text-sm">MoMo</span>
                            </div>
                            <div>
                                <h3 class="font-bold text-white text-base">Ví điện tử MoMo</h3>
                                <p class="text-xs text-text-muted mt-0.5">Thanh toán 1 chạm nhanh chóng bằng ứng dụng MoMo</p>
                            </div>
                        </div>
                        <div class="flex items-center gap-2 text-emerald-400 bg-emerald-400/10 px-3 py-1.5 rounded-lg border border-emerald-400/20">
                            <i data-lucide="shield-check" class="w-4 h-4"></i>
                            <span class="text-sm font-semibold hidden sm:inline">Hỗ trợ</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <!-- Mobile Bottom Navigation -->
    <jsp:include page="/WEB-INF/views/components/customer_bottom_nav.jsp">
    <jsp:param name="activeMenu" value="dashboard" />
</jsp:include>
<jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>
