// web/js/customer_booking_history.js

document.addEventListener('DOMContentLoaded', function() {
    lucide.createIcons();

    // Auto-switch to history tab if page parameter is present
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('page')) {
        switchTab('tab-history');
    }

    renderQRCodes();
    
    // Re-render after soft refresh modifies DOM
    const observer = new MutationObserver(function(mutations) {
        renderQRCodes();
    });
    
    const upcomingTab = document.getElementById('tab-upcoming');
    if (upcomingTab) {
        observer.observe(upcomingTab, { childList: true, subtree: true });
    }

    // Start auto-refresh
    setInterval(softRefresh, 5000);
});

function switchTab(tabId) {
    // Hide all tabs
    document.querySelectorAll('.tab-content').forEach(function (el) {
        el.classList.add('hidden');
    });

    // Show the selected tab
    document.getElementById(tabId).classList.remove('hidden');

    // Reset all buttons styling
    document.querySelectorAll('.tab-btn').forEach(function (el) {
        el.classList.remove('text-white', 'border-[#00d4ff]');
        el.classList.add('text-text-muted', 'border-transparent');
    });

    // Set active styling for the clicked button
    var activeBtn = document.getElementById('btn-' + tabId);
    if (activeBtn) {
        activeBtn.classList.remove('text-text-muted', 'border-transparent');
        activeBtn.classList.add('text-white', 'border-[#00d4ff]');
    }
}

function softRefresh() {
    fetch(window.location.href)
        .then(res => res.text())
        .then(html => {
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');

            const tabs = ['tab-upcoming', 'tab-history'];
            let hasChanges = false;

            tabs.forEach(tabId => {
                const newContent = doc.getElementById(tabId);
                const curContent = document.getElementById(tabId);
                if (newContent && curContent && newContent.innerHTML !== curContent.innerHTML) {
                    curContent.innerHTML = newContent.innerHTML;
                    hasChanges = true;
                }
            });

            if (hasChanges) {
                lucide.createIcons();
            }
        })
        .catch(err => console.error('Soft refresh failed', err));
}

function renderQRCodes() {
    if (typeof QRCode === 'undefined') return;
    
    document.querySelectorAll('.qr-container').forEach(el => {
        if (el.innerHTML.trim() === '') {
            new QRCode(el, {
                text: el.dataset.code,
                width: 80,
                height: 80,
                colorDark : "#000000", // Black
                colorLight : "#ffffff",
                correctLevel : QRCode.CorrectLevel.H
            });
        }
    });
}
