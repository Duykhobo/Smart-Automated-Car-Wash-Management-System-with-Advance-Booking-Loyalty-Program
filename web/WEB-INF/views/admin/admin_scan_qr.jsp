<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quét Mã QR Check-in - AutoWash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
    <script src="https://unpkg.com/html5-qrcode"></script>
    <style>
        /* Custom animation for QR Scanner line */
        @keyframes scan-line {
            0% { top: 10%; }
            50% { top: 90%; }
            100% { top: 10%; }
        }
        .animate-scan {
            animation: scan-line 2s linear infinite;
        }
    </style>
</head>
<body class="bg-bg-primary text-text-primary antialiased overflow-hidden flex h-screen">

    <!-- Sidebar Component -->
    <jsp:include page="/WEB-INF/views/components/admin_sidebar.jsp">
        <jsp:param name="activeMenu" value="scan" />
    </jsp:include>

    <!-- Main Content (Full height for scanner) -->
    <main class="flex-1 relative flex flex-col items-center justify-center bg-black">
        
        <!-- Camera Viewport -->
        <div class="absolute inset-0 z-0 bg-black">
            <!-- Fallback background if camera not active -->
            <div id="camera-fallback" class="absolute inset-0 z-10 bg-slate-900 flex items-center justify-center">
                <p class="text-slate-500 font-medium">Đang khởi động Camera...</p>
            </div>
            <div id="reader" style="width: 100%; height: 100%; object-fit: cover;"></div>
        </div>

        <!-- Scanner Overlay -->
        <div class="absolute inset-0 z-10 flex flex-col pointer-events-none">
            <!-- Top bar -->
            <div class="h-24 bg-black/60 backdrop-blur-sm p-4 md:p-6 flex justify-between items-center md:items-start pointer-events-auto">
                <div class="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 w-full md:w-auto">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="md:hidden w-10 h-10 shrink-0 rounded-full bg-white/10 flex items-center justify-center text-white hover:bg-white/20 border border-white/20 backdrop-blur-md">
                        <i data-lucide="chevron-left" class="w-6 h-6"></i>
                    </a>
                    <div>
                        <h2 class="text-lg md:text-2xl font-display font-bold text-white mb-0.5 md:mb-1">Check-in Điện Tử</h2>
                        <p class="text-slate-300 text-[10px] md:text-sm">Hướng camera vào mã QR của khách hàng</p>
                    </div>
                </div>
                <button onclick="simulateScan()" class="px-3 md:px-4 py-2.5 h-11 bg-[#00d4ff]/20 text-[#00d4ff] rounded-xl border border-[#00d4ff]/40 hover:bg-[#00d4ff]/30 transition-colors font-medium text-xs md:text-sm flex items-center gap-2 whitespace-nowrap shrink-0">
                    <i data-lucide="scan-line" class="w-4 h-4"></i> <span class="hidden sm:inline">Giả lập quét</span><span class="sm:hidden">Demo</span>
                </button>
            </div>

            <!-- Middle section with transparent cutout -->
            <div class="flex-1 flex">
                <div class="flex-1 bg-black/60 backdrop-blur-sm"></div>
                <!-- Cutout frame -->
                <div class="w-72 h-72 sm:w-96 sm:h-96 relative border-2 border-white/20 rounded-3xl overflow-hidden">
                    <!-- Corner brackets -->
                    <div class="absolute top-0 left-0 w-8 h-8 border-t-4 border-l-4 border-[#00d4ff] rounded-tl-3xl"></div>
                    <div class="absolute top-0 right-0 w-8 h-8 border-t-4 border-r-4 border-[#00d4ff] rounded-tr-3xl"></div>
                    <div class="absolute bottom-0 left-0 w-8 h-8 border-b-4 border-l-4 border-[#00d4ff] rounded-bl-3xl"></div>
                    <div class="absolute bottom-0 right-0 w-8 h-8 border-b-4 border-r-4 border-[#00d4ff] rounded-br-3xl"></div>
                    
                    <!-- Scanning line -->
                    <div class="absolute w-full h-0.5 bg-[#00d4ff] shadow-[0_0_15px_#00d4ff] animate-scan z-20"></div>
                </div>
                <div class="flex-1 bg-black/60 backdrop-blur-sm"></div>
            </div>

            <!-- Bottom bar -->
            <div class="h-32 bg-black/60 backdrop-blur-sm flex items-center justify-center pointer-events-auto">
                <div class="flex gap-4">
                    <button class="w-14 h-14 rounded-full bg-white/10 flex items-center justify-center text-white hover:bg-white/20 border border-white/20 backdrop-blur-md">
                        <i data-lucide="flashlight" class="w-6 h-6"></i>
                    </button>
                    <button class="w-14 h-14 rounded-full bg-white/10 flex items-center justify-center text-white hover:bg-white/20 border border-white/20 backdrop-blur-md">
                        <i data-lucide="switch-camera" class="w-6 h-6"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Result Card (Hidden by default, shown after scan) -->
        <div id="scanResult" class="absolute bottom-8 left-1/2 -translate-x-1/2 w-full max-w-md bg-[#0f172a] border border-slate-700 rounded-2xl shadow-[0_0_50px_rgba(0,0,0,0.8)] p-6 z-50 transform translate-y-[150%] transition-transform duration-500 ease-out opacity-0 pointer-events-auto">
            
            <div class="flex justify-between items-start mb-4">
                <div class="flex items-center gap-2">
                    <div class="w-8 h-8 rounded-full bg-emerald-500/20 flex items-center justify-center border border-emerald-500/30">
                        <i data-lucide="check" class="w-5 h-5 text-emerald-400"></i>
                    </div>
                    <div>
                        <h3 class="text-emerald-400 font-bold text-lg shadow-sm">Yêu cầu thanh toán tiền mặt</h3>
                        <p class="text-xs text-slate-400 font-mono mt-0.5" id="displayBookingId">BK-...</p>
                    </div>
                </div>
                <button onclick="closeResult()" class="text-slate-400 hover:text-white transition-colors bg-white/5 hover:bg-white/10 rounded-lg p-1.5">
                    <i data-lucide="x" class="w-5 h-5"></i>
                </button>
            </div>

            <div class="bg-black/40 border border-white/5 rounded-xl p-5 mb-5 shadow-inner">
                <div class="flex justify-between mb-3 items-center">
                    <span class="text-slate-400 text-sm font-medium">Khách hàng:</span>
                    <span class="text-white font-bold" id="displayCustomerName">...</span>
                </div>
                <div class="flex justify-between mb-3 items-center">
                    <span class="text-slate-400 text-sm font-medium">Biển số:</span>
                    <span class="text-[#00d4ff] font-mono font-bold bg-[#00d4ff]/10 border border-[#00d4ff]/20 px-3 py-1 rounded-lg" id="displayVehiclePlate">...</span>
                </div>
                <div class="flex justify-between mb-5 border-b border-slate-800 pb-5 items-start">
                    <span class="text-slate-400 text-sm font-medium mt-0.5">Dịch vụ:</span>
                    <span class="text-white text-sm text-right leading-relaxed max-w-[65%]" id="displayServiceName">...</span>
                </div>
                
                <div class="flex justify-between items-end bg-gradient-to-r from-amber-500/5 to-transparent p-3 rounded-lg border-l-2 border-amber-500">
                    <span class="text-amber-500/80 font-medium mb-1">Tổng phải thu:</span>
                    <span class="text-4xl font-display font-bold text-amber-400 drop-shadow-md" id="displayAmount">0đ</span>
                </div>
            </div>

            <div class="flex gap-3">
                <button onclick="closeResult()" class="flex-1 py-3.5 rounded-xl bg-slate-800 text-slate-300 border border-slate-700 hover:bg-slate-700 hover:text-white transition-all font-semibold shadow-lg">
                    Hủy Bỏ
                </button>
                <button id="confirmPaymentBtn" onclick="confirmPayment()" class="flex-[2] py-3.5 rounded-xl bg-gradient-to-r from-emerald-500 to-emerald-400 hover:from-emerald-400 hover:to-emerald-300 text-slate-900 font-extrabold transition-all shadow-[0_0_20px_rgba(16,185,129,0.4)] hover:shadow-[0_0_30px_rgba(16,185,129,0.6)] hover:-translate-y-0.5">
                    Đã Thu & Check-in
                </button>
            </div>
        </div>
    </main>

    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/admin/admin_scan_qr.js?v=4"></script>
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>
