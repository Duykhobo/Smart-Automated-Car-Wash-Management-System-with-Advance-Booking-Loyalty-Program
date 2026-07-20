// web/js/admin_manage_bookings.js

document.addEventListener('DOMContentLoaded', function() {
    lucide.createIcons();
    
    // T\u1ef1 \u0111\u1ed9ng qu\u00e9t c\u1eadp nh\u1eadt m\u1ed7i 5 gi\u00e2y (ph\u00f9 h\u1ee3p cho POS t\u1ea1i qu\u1ea7y)
    setInterval(softRefreshAdmin, 5000);
});

// Auto-refetch logic for Admin Live Update (Pay at Counter flow)
function softRefreshAdmin() {
    // L\u1ea5y c\u00e1c tham s\u1ed1 filter hi\u1ec7n t\u1ea1i tr\u00ean URL (n\u1ebfu c\u00f3) \u0111\u1ec3 fetch \u0111\u00fang trang
    fetch(window.location.href)
        .then(res => res.text())
        .then(html => {
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            
            // T\u00ecm body c\u1ee7a b\u1ea3ng hi\u1ec7n t\u1ea1i v\u00e0 b\u1ea3ng m\u1edbi
            const newTableBody = doc.querySelector('tbody');
            const curTableBody = document.querySelector('tbody');
            
            // N\u1ebfu d\u1eef li\u1ec7u b\u1ea3ng c\u00f3 s\u1ef1 thay \u0111\u1ed5i (C\u00f3 booking m\u1edbi, ho\u1eb7c c\u00f3 thay \u0111\u1ed5i tr\u1ea1ng th\u00e1i)
            if (newTableBody && curTableBody && newTableBody.innerHTML !== curTableBody.innerHTML) {
                curTableBody.innerHTML = newTableBody.innerHTML;
                lucide.createIcons();
            }
        })
        .catch(err => console.error('Admin auto-refresh failed', err));
}
