document.addEventListener('DOMContentLoaded', function () {
    var btnLogout = document.getElementById('btn-logout');
    if (btnLogout !== null) {
        btnLogout.addEventListener('click', function (event) {
            event.preventDefault(); 
            if (typeof showGlobalConfirmModal === 'function') {
                showGlobalConfirmModal('\u0110\u0103ng xu\u1ea5t', 'B\u1ea1n c\u00f3 ch\u1eafc l\u00e0 mu\u1ed1n \u0111\u0103ng xu\u1ea5t kh\u00f4ng?', '\u0110\u0103ng xu\u1ea5t', function() {
                    var logoutUrl = btnLogout.getAttribute('data-url');
                    window.location.href = logoutUrl;
                });
            } else {
                // Fallback just in case
                if (confirm("B\u1ea1n c\u00f3 ch\u1eafc l\u00e0 mu\u1ed1n \u0111\u0103ng xu\u1ea5t kh\u00f4ng?")) {
                    var logoutUrl = btnLogout.getAttribute('data-url');
                    window.location.href = logoutUrl;
                }
            }
        });
    }
});