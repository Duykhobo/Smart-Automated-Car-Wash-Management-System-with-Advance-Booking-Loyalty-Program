document.addEventListener('DOMContentLoaded', function () {
    var btnLogout = document.getElementById('btn-logout');
    if (btnLogout !== null) {
        btnLogout.addEventListener('click', function (event) {
            event.preventDefault(); 
            var confirmLogout = confirm("Bạn có chắc là muốn đăng xuất không ?");
            if (confirmLogout === true) {
                var logoutUrl = btnLogout.getAttribute('data-url');
                window.location.href = logoutUrl;
            }   
        });
    }
});