lucide.createIcons();

let html5QrCode;
let isScanning = false;
let currentBookingId = null;

document.addEventListener('DOMContentLoaded', function() {
    html5QrCode = new Html5Qrcode("reader");
    startScanner();
});

function startScanner() {
    const config = { fps: 10 };
    
    html5QrCode.start(
        { facingMode: "environment" },
        config,
        onScanSuccess,
        onScanFailure
    ).then(() => {
        isScanning = true;
        document.getElementById('camera-fallback').style.display = 'none';
    }).catch((err) => {
        console.error("Lỗi mở camera: ", err);
        showToast("Không thể mở camera. Vui lòng cấp quyền truy cập trình duyệt.", "error");
    });
}

function onScanSuccess(decodedText, decodedResult) {
    if (!isScanning) return;
    
    isScanning = false;
    html5QrCode.pause(true);
    
    const audio = new Audio('https://assets.mixkit.co/sfx/preview/mixkit-software-interface-start-2574.mp3');
    audio.volume = 0.5;
    audio.play().catch(e => console.log("Audio play blocked by browser"));
    
    processQR(decodedText, false);
}

// NOTE: contextPath needs to be passed or derived, we use a relative path for the API
function processQR(code, forceConfirmPayment) {
    let bookingId = code.replace('BK-', '').trim();
    
    // Fetch directly from the API endpoint
    // Determine context path dynamically or assume relative /api/scan-qr works from /admin/scan
    let apiUrl = window.location.pathname.includes('/admin/scan') ? 
        '../api/scan-qr' : '/api/scan-qr';
        
    fetch(apiUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'bookingId=' + encodeURIComponent(bookingId) + '&confirmPayment=' + forceConfirmPayment
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'require_payment') {
            showPaymentCard(bookingId, data.amount, data.customerName, data.vehiclePlate, data.serviceName);
        } else if (data.status === 'success') {
            showToast(data.message, "success");
            setTimeout(resumeScanner, 3000);
        } else {
            showToast(data.message, "error");
            setTimeout(resumeScanner, 3000);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showToast("Không thể kết nối đến máy chủ.", "error");
        setTimeout(resumeScanner, 3000);
    });
}

function showPaymentCard(bookingId, amount, customerName, vehiclePlate, serviceName) {
    currentBookingId = bookingId;
    const resultCard = document.getElementById('scanResult');
    
    document.getElementById('displayBookingId').innerText = 'BK-' + bookingId;
    document.getElementById('displayCustomerName').innerText = customerName || 'Khách hàng';
    document.getElementById('displayVehiclePlate').innerText = vehiclePlate || 'Chưa rõ';
    document.getElementById('displayServiceName').innerText = serviceName || 'Dịch vụ';
    document.getElementById('displayAmount').innerText = new Intl.NumberFormat('vi-VN').format(amount) + ' VN\u0110';
    document.getElementById('confirmPaymentBtn').innerText = '\u0110\u00E3 Thu ' + new Intl.NumberFormat('vi-VN').format(amount) + ' VN\u0110 & Check-in';
    
    resultCard.classList.remove('translate-y-[150%]', 'opacity-0');
}

function closeResult() {
    const resultCard = document.getElementById('scanResult');
    resultCard.classList.add('translate-y-[150%]', 'opacity-0');
    resumeScanner();
}

function confirmPayment() {
    closeResult();
    processQR('BK-' + currentBookingId, true);
}

function resumeScanner() {
    const resultCard = document.getElementById('scanResult');
    resultCard.classList.add('translate-y-[150%]', 'opacity-0');
    if (html5QrCode && html5QrCode.getState() === 2) { 
        html5QrCode.resume();
        isScanning = true;
    }
}

function onScanFailure(error) {
    // ignore
}

function simulateScan() {
    onScanSuccess("BK-1", null);
}