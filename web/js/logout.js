document.addEventListener('DOMContentLoaded', function () {
    var btnLogout = document.getElementById('btn-logout');
    if (btnLogout !== null) {
        btnLogout.addEventListener('click', function (event) {
            event.preventDefault(); 
            if (typeof showGlobalConfirmModal === 'function') {
                showGlobalConfirmModal('Đăng xuất', 'Bạn có chắc là muốn đăng xuất không?', 'Đăng xuất', function() {
                    var logoutUrl = btnLogout.getAttribute('data-url');
                    window.location.href = logoutUrl;
                });
            } else {
                // Fallback just in case
                if (confirm("Bạn có chắc là muốn đăng xuất không?")) {
                    var logoutUrl = btnLogout.getAttribute('data-url');
                    window.location.href = logoutUrl;
                }
            }
        });
    }
});