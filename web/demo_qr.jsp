<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <title>AutoWash PRO - Quét QR Check-in</title>
        <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/jsqr@1.4.0/dist/jsQR.js"></script>
        <style>
            #qr-canvas {
                display: none;
            }

            #scanner-overlay {
                position: absolute;
                inset: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                pointer-events: none;
            }

            .scan-frame {
                width: 220px;
                height: 220px;
                border: 2px solid rgba(0, 212, 255, 0.6);
                border-radius: 16px;
                box-shadow: 0 0 0 9999px rgba(0, 0, 0, 0.55);
                position: relative;
            }

            .scan-frame::before,
            .scan-frame::after,
            .scan-frame .corner-br,
            .scan-frame .corner-bl {
                content: '';
                position: absolute;
                width: 28px;
                height: 28px;
                border-color: #00d4ff;
                border-style: solid;
            }

            .scan-frame::before {
                top: -2px;
                left: -2px;
                border-width: 3px 0 0 3px;
                border-radius: 14px 0 0 0;
            }

            .scan-frame::after {
                top: -2px;
                right: -2px;
                border-width: 3px 3px 0 0;
                border-radius: 0 14px 0 0;
            }

            .scan-frame .corner-bl {
                bottom: -2px;
                left: -2px;
                border-width: 0 0 3px 3px;
                border-radius: 0 0 0 14px;
            }

            .scan-frame .corner-br {
                bottom: -2px;
                right: -2px;
                border-width: 0 3px 3px 0;
                border-radius: 0 0 14px 0;
            }

            .scan-line {
                position: absolute;
                left: 8px;
                right: 8px;
                height: 2px;
                background: linear-gradient(90deg, transparent, #00d4ff, transparent);
                animation: scan 2s linear infinite;
            }

            @keyframes scan {
                0% {
                    top: 8px;
                }

                100% {
                    top: calc(100% - 8px);
                }
            }
        </style>
    </head>

    <body
        class="m-0 min-h-screen bg-bg-primary text-white font-sans antialiased selection:bg-[#00d4ff] selection:text-black w-full overflow-x-hidden relative">

        <div class="max-w-lg mx-auto px-4 py-8 space-y-6">

            <!-- Header -->
            <div class="flex items-center gap-3 mb-2">
                <div
                    class="w-10 h-10 rounded-xl bg-[#00d4ff]/10 border border-[#00d4ff]/30 flex items-center justify-center">
                    <i data-lucide="qr-code" class="w-5 h-5 text-[#00d4ff]"></i>
                </div>
                <div>
                    <h1 class="font-display text-xl font-bold text-white">QR Check-in</h1>
                    <p class="text-xs text-gray-500">Dành cho nhân viên · AutoWash PRO</p>
                </div>
            </div>

            <!-- Camera View -->
            <div class="glass-panel rounded-2xl overflow-hidden relative border border-border-glass">
                <div id="camera-placeholder"
                    class="flex flex-col items-center justify-center gap-4 py-16 px-8 text-center">
                    <div
                        class="w-16 h-16 rounded-full bg-[#00d4ff]/10 border border-[#00d4ff]/20 flex items-center justify-center">
                        <i data-lucide="camera" class="w-8 h-8 text-[#00d4ff]"></i>
                    </div>
                    <div>
                        <p class="text-white font-semibold">Bấm để bật Camera</p>
                        <p class="text-text-muted text-sm mt-1">Hướng camera vào mã QR trên phiếu đặt lịch của khách</p>
                    </div>
                    <button id="startBtn"
                        class="px-6 py-3 bg-[#00d4ff] text-black font-bold rounded-xl hover:bg-white transition-colors flex items-center justify-center gap-2 shadow-[0_0_20px_rgba(0,212,255,0.3)]"
                        onclick="startCamera()">
                        <i data-lucide="video" class="w-4 h-4"></i> Bật Camera
                    </button>
                </div>

                <div id="camera-view" class="hidden relative">
                    <video id="video" class="w-full rounded-t-2xl" autoplay muted playsinline></video>
                    <div id="scanner-overlay">
                        <div class="scan-frame">
                            <div class="scan-line"></div>
                            <div class="corner-bl"></div>
                            <div class="corner-br"></div>
                        </div>
                    </div>
                    <canvas id="qr-canvas"></canvas>
                    <div class="p-3 flex items-center justify-between">
                        <p class="text-xs text-gray-400 flex items-center gap-1">
                            <i data-lucide="scan-line" class="w-3.5 h-3.5 text-[#00d4ff]"></i>
                            <span id="scan-status">Đang tìm mã QR...</span>
                        </p>
                        <button onclick="stopCamera()"
                            class="px-4 py-2 bg-red-500/10 text-red-500 hover:bg-red-500 hover:text-white rounded-lg transition-colors flex items-center gap-1.5 font-semibold text-sm border border-red-500/30">
                            <i data-lucide="video-off" class="w-4 h-4"></i> Tắt Camera
                        </button>
                    </div>
                </div>
            </div>

            <!-- Manual Input -->
            <div class="glass-panel rounded-2xl p-4 border border-border-glass">
                <p class="text-xs text-text-muted font-medium uppercase tracking-wider mb-3">Hoặc nhập thủ công</p>
                <div class="flex gap-2">
                    <input id="manualId" type="text" placeholder="Nhập Booking ID..."
                        class="flex-1 bg-bg-surface border border-border-glass rounded-xl px-4 py-3 text-sm text-white placeholder:text-text-muted outline-none focus:border-[#00d4ff]/50 transition-colors">
                    <button onclick="processBookingId(document.getElementById('manualId').value)"
                        class="px-5 bg-[#00d4ff] text-black font-bold rounded-xl hover:bg-white transition-colors flex items-center justify-center gap-1.5 text-sm shadow-[0_0_20px_rgba(0,212,255,0.3)]">
                        <i data-lucide="search" class="w-4 h-4"></i> Tra
                    </button>
                </div>
            </div>

            <!-- Result Card -->
            <div id="result-card" class="hidden glass-panel rounded-2xl p-5 space-y-4 border border-border-glass"></div>

            <!-- Payment Confirm Modal -->
            <div id="payment-modal" class="hidden glass-panel rounded-2xl p-6 border border-amber-500/30 space-y-4">
                <div class="flex items-start gap-3">
                    <div class="w-10 h-10 rounded-full bg-amber-500/20 flex items-center justify-center shrink-0">
                        <i data-lucide="banknote" class="w-5 h-5 text-amber-400"></i>
                    </div>
                    <div>
                        <p class="font-semibold text-amber-400">Yêu cầu thanh toán tiền mặt</p>
                        <p class="text-sm text-text-muted mt-1">Khách thanh toán tại quầy</p>
                    </div>
                </div>
                <div id="payment-amount" class="text-center py-3 bg-amber-500/10 rounded-xl border border-amber-500/20">
                    <p class="text-xs text-text-muted uppercase tracking-wider">Số tiền cần thu</p>
                    <p class="text-3xl font-display font-bold text-amber-400 mt-1" id="payment-price">0 đ</p>
                </div>
                <div class="flex gap-3">
                    <button onclick="cancelPayment()"
                        class="flex-1 py-3 rounded-xl border border-border-glass text-text-muted hover:text-white hover:bg-bg-surface-hover transition-colors text-sm font-medium">
                        Hủy
                    </button>
                    <button onclick="confirmPayment()" id="confirmPayBtn"
                        class="flex-1 px-4 py-3 bg-[#00d4ff] text-black font-bold rounded-xl hover:bg-white transition-colors flex items-center justify-center gap-2 text-sm shadow-[0_0_20px_rgba(0,212,255,0.3)]">
                        <i data-lucide="check-circle" class="w-4 h-4"></i> Đã thu tiền → Check-in
                    </button>
                </div>
            </div>

            <!-- Log -->
            <div class="glass-panel rounded-2xl p-4 border border-border-glass">
                <div class="flex items-center justify-between mb-3">
                    <p class="text-xs text-text-muted font-medium uppercase tracking-wider flex items-center gap-1.5">
                        <i data-lucide="activity" class="w-3.5 h-3.5"></i> Lịch sử quét hôm nay
                    </p>
                    <button onclick="document.getElementById('log-list').innerHTML=''"
                        class="text-xs text-gray-500 hover:text-white transition-colors">Xóa</button>
                </div>
                <div id="log-list" class="space-y-1.5 max-h-48 overflow-y-auto text-xs">
                    <p class="text-text-muted text-center py-4">Chưa có lần quét nào</p>
                </div>
            </div>
        </div>

        <script>
            lucide.createIcons();

            let videoStream = null;
            let scanning = false;
            let currentBookingId = null;
            const ctx = '${pageContext.request.contextPath}';

            // ── Camera ──────────────────────────────────────────────
            async function startCamera() {
                try {
                    const stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } });
                    videoStream = stream;
                    const video = document.getElementById('video');
                    video.srcObject = stream;
                    document.getElementById('camera-placeholder').classList.add('hidden');
                    document.getElementById('camera-view').classList.remove('hidden');
                    scanning = true;
                    requestAnimationFrame(tick);
                } catch (e) {
                    showToast('Không thể truy cập camera: ' + e.message, 'error');
                }
            }

            function stopCamera() {
                scanning = false;
                if (videoStream) videoStream.getTracks().forEach(t => t.stop());
                videoStream = null;
                document.getElementById('camera-view').classList.add('hidden');
                document.getElementById('camera-placeholder').classList.remove('hidden');
            }

            function tick() {
                if (!scanning) return;
                const video = document.getElementById('video');
                if (video.readyState !== video.HAVE_ENOUGH_DATA) { requestAnimationFrame(tick); return; }

                const canvas = document.getElementById('qr-canvas');
                canvas.width = video.videoWidth;
                canvas.height = video.videoHeight;
                const ctx2d = canvas.getContext('2d');
                ctx2d.drawImage(video, 0, 0, canvas.width, canvas.height);
                const imageData = ctx2d.getImageData(0, 0, canvas.width, canvas.height);
                const code = jsQR(imageData.data, imageData.width, imageData.height, { inversionAttempts: 'dontInvert' });

                if (code) {
                    showToast('Đã nhận mã QR thành công!', 'success');
                    document.getElementById('scan-status').textContent = 'Đã quét! Đang xử lý...';
                    scanning = false;
                    processQRData(code.data);
                } else {
                    requestAnimationFrame(tick);
                }
            }

            // ── Process QR ──────────────────────────────────────────
            function processQRData(data) {
                // Support raw bookingId or JSON {"bookingId":123}
                let bookingId = null;
                data = data.trim();
                if (data.startsWith('{')) {
                    try {
                        const json = JSON.parse(data);
                        bookingId = json.bookingId;
                    } catch (e) {
                        console.error(e);
                    }
                }

                if (!bookingId) {
                    bookingId = data;
                }

                if (bookingId) processBookingId(bookingId);
                else showToast('QR không hợp lệ: ' + data, 'error');
            }

            function processBookingId(bookingId) {
                if (!bookingId) return;
                currentBookingId = bookingId;
                document.getElementById('result-card').innerHTML = '<div class="flex items-center gap-3 text-gray-400 py-2"><i data-lucide="loader" class="w-5 h-5 animate-spin text-[#00d4ff]"></i><span>Đang kiểm tra booking #' + bookingId + '...</span></div>';
                document.getElementById('result-card').classList.remove('hidden');
                document.getElementById('payment-modal').classList.add('hidden');
                lucide.createIcons();

                fetch(ctx + '/api/scan-qr', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'bookingId=' + encodeURIComponent(bookingId)
                })
                    .then(r => r.json())
                    .then(data => handleScanResult(data, bookingId))
                    .catch(e => { showResultError('Lỗi kết nối máy chủ'); addLog(bookingId, '❌ Lỗi kết nối'); });
            }

            function handleScanResult(data, bookingId) {
                if (data.status === 'require_payment') {
                    showPaymentModal(data.amount, bookingId);
                    document.getElementById('result-card').classList.add('hidden');
                    addLog(bookingId, '💵 Chờ thu tiền mặt');
                } else if (data.status === 'success') {
                    showResultSuccess(data.message);
                    addLog(bookingId, '✅ ' + data.message);
                    setTimeout(() => { if (scanning === false && videoStream) { scanning = true; requestAnimationFrame(tick); document.getElementById('scan-status').textContent = 'Đang tìm mã QR...'; } }, 3000);
                } else {
                    showResultError(data.message);
                    addLog(bookingId, '⛔ ' + data.message);
                    setTimeout(() => { if (videoStream) { scanning = true; requestAnimationFrame(tick); document.getElementById('scan-status').textContent = 'Đang tìm mã QR...'; } }, 3000);
                }
            }

            // ── Payment Modal ────────────────────────────────────────
            function showPaymentModal(amount, bookingId) {
                currentBookingId = bookingId;
                document.getElementById('payment-price').textContent = new Intl.NumberFormat('vi-VN').format(amount) + ' đ';
                document.getElementById('payment-modal').classList.remove('hidden');
            }

            function cancelPayment() {
                document.getElementById('payment-modal').classList.add('hidden');
                if (videoStream) { scanning = true; requestAnimationFrame(tick); }
            }

            function confirmPayment() {
                if (!currentBookingId) return;
                const btn = document.getElementById('confirmPayBtn');
                btn.disabled = true;
                btn.innerHTML = '<i data-lucide="loader" class="w-4 h-4 animate-spin"></i> Đang xử lý...';
                lucide.createIcons();

                fetch(ctx + '/api/scan-qr', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'bookingId=' + encodeURIComponent(currentBookingId) + '&confirmPayment=true'
                })
                    .then(r => r.json())
                    .then(data => {
                        document.getElementById('payment-modal').classList.add('hidden');
                        btn.disabled = false;
                        btn.innerHTML = '<i data-lucide="check-circle" class="w-4 h-4"></i> Đã thu tiền → Check-in';
                        lucide.createIcons();
                        handleScanResult(data, currentBookingId);
                    })
                    .catch(e => { showResultError('Lỗi kết nối'); btn.disabled = false; });
            }

            // ── UI Helpers ───────────────────────────────────────────
            function showResultSuccess(msg) {
                showToast("Quét QR và chuyển trạng thái thành công!", 'success');
                document.getElementById('result-card').classList.remove('hidden');
                document.getElementById('result-card').innerHTML = `
            <div class="flex items-start gap-3">
                <div class="w-10 h-10 rounded-full bg-green-500/20 flex items-center justify-center shrink-0 mt-0.5">
                    <i data-lucide="check-circle-2" class="w-5 h-5 text-green-400"></i>
                </div>
                <div>
                    <p class="font-semibold text-green-400">Thành công!</p>
                    <p class="text-sm text-gray-300 mt-1">\${msg}</p>
                </div>
            </div>`;
                lucide.createIcons();
            }

            function showResultError(msg) {
                document.getElementById('result-card').classList.remove('hidden');
                document.getElementById('result-card').innerHTML = `
            <div class="flex items-start gap-3">
                <div class="w-10 h-10 rounded-full bg-red-500/20 flex items-center justify-center shrink-0 mt-0.5">
                    <i data-lucide="x-circle" class="w-5 h-5 text-red-400"></i>
                </div>
                <div>
                    <p class="font-semibold text-red-400">Lỗi</p>
                    <p class="text-sm text-gray-300 mt-1">\${msg}</p>
                </div>
            </div>`;
                lucide.createIcons();
            }

            function addLog(bookingId, msg) {
                const list = document.getElementById('log-list');
                const empty = list.querySelector('p.text-text-muted');
                if (empty) empty.remove();
                const time = new Date().toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
                const item = document.createElement('div');
                item.className = 'flex items-center justify-between gap-2 py-1.5 border-b border-border-glass last:border-0';
                item.innerHTML = `<span class="text-gray-300">#\${bookingId} — \${msg}</span><span class="text-text-muted shrink-0">\${time}</span>`;
                list.prepend(item);
            }

            function showToast(msg, type) {
                const t = document.createElement('div');
                t.className = `fixed bottom-6 left-1/2 -translate-x-1/2 px-5 py-3 rounded-xl text-sm font-medium shadow-xl z-50 transition-all \${type === 'error' ? 'bg-red-500/90 text-white' : 'bg-green-500/90 text-white'}`;
                t.textContent = msg;
                document.body.appendChild(t);
                setTimeout(() => t.remove(), 3000);
            }
        </script>
    </body>

    </html>