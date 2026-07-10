<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quét Mã QR Check-in - AutoWash Pro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
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
<body class="bg-bg-primary text-text-primary antialiased overflow-hidden selection:bg-[#00d4ff] selection:text-black flex h-screen">

    <!-- Sidebar Component -->
    <jsp:include page="/WEB-INF/views/components/admin_sidebar.jsp">
        <jsp:param name="activeMenu" value="scan" />
    </jsp:include>

    <!-- Main Content (Full height for scanner) -->
    <main class="flex-1 relative flex flex-col items-center justify-center bg-black">
        
        <!-- Camera Viewport (Simulated) -->
        <div class="absolute inset-0 z-0">
            <!-- Fallback background if camera not active -->
            <div class="w-full h-full bg-slate-900 flex items-center justify-center">
                <p class="text-slate-500 font-medium">Đang khởi động Camera...</p>
            </div>
        </div>

        <!-- Scanner Overlay -->
        <div class="absolute inset-0 z-10 flex flex-col pointer-events-none">
            <!-- Top bar -->
            <div class="h-24 bg-black/60 backdrop-blur-sm p-6 flex justify-between items-start pointer-events-auto">
                <div>
                    <h2 class="text-2xl font-display font-bold text-white mb-1">Check-in Điện Tử</h2>
                    <p class="text-slate-300 text-sm">Hướng camera vào mã QR của khách hàng</p>
                </div>
                <button onclick="simulateScan()" class="px-4 py-2 bg-[#00d4ff]/20 text-[#00d4ff] rounded-xl border border-[#00d4ff]/40 hover:bg-[#00d4ff]/30 transition-colors font-medium text-sm flex items-center gap-2">
                    <i data-lucide="scan-line" class="w-4 h-4"></i> Giả lập quét
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
        <div id="scanResult" class="absolute bottom-8 left-1/2 -translate-x-1/2 w-full max-w-md bg-bg-surface border border-border-glass rounded-2xl shadow-2xl p-6 z-50 transform translate-y-[150%] transition-transform duration-500 ease-out opacity-0 pointer-events-auto">
            
            <div class="flex justify-between items-start mb-4">
                <div class="flex items-center gap-2">
                    <div class="w-8 h-8 rounded-full bg-emerald-500/20 flex items-center justify-center">
                        <i data-lucide="check" class="w-5 h-5 text-emerald-400"></i>
                    </div>
                    <div>
                        <h3 class="text-emerald-400 font-bold">Mã Hợp Lệ</h3>
                        <p class="text-xs text-text-muted font-mono">BK-10208</p>
                    </div>
                </div>
                <button onclick="closeResult()" class="text-text-muted hover:text-white">
                    <i data-lucide="x" class="w-5 h-5"></i>
                </button>
            </div>

            <div class="bg-black/20 rounded-xl p-4 mb-4">
                <div class="flex justify-between mb-2">
                    <span class="text-slate-400 text-sm">Khách hàng:</span>
                    <span class="text-white font-medium">Trần Văn Tèo</span>
                </div>
                <div class="flex justify-between mb-2">
                    <span class="text-slate-400 text-sm">Biển số:</span>
                    <span class="text-white font-mono font-bold bg-white/10 px-2 rounded">51H-123.45</span>
                </div>
                <div class="flex justify-between mb-4 border-b border-border-glass pb-4">
                    <span class="text-slate-400 text-sm">Dịch vụ:</span>
                    <span class="text-white text-sm text-right">Rửa Bọt Tuyết Tiêu Chuẩn<br><span class="text-xs text-text-muted">Hút bụi nội thất</span></span>
                </div>
                
                <div class="flex justify-between items-end">
                    <span class="text-slate-400">Tổng phải thu:</span>
                    <span class="text-4xl font-display font-bold text-amber-400">120K</span>
                </div>
            </div>

            <div class="flex gap-3">
                <button onclick="closeResult()" class="flex-1 py-3 rounded-xl bg-bg-surface-hover text-white border border-border-glass hover:bg-white/5 transition-colors font-medium">
                    Hủy Bỏ
                </button>
                <button onclick="confirmPayment()" class="flex-[2] py-3 rounded-xl bg-emerald-500 hover:bg-emerald-400 text-black font-bold transition-colors shadow-[0_0_15px_rgba(16,185,129,0.3)]">
                    Đã Thu 120K & Check-in
                </button>
            </div>
        </div>
    </main>

    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/admin/admin_scan_qr.js?v=2"></script>
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>
