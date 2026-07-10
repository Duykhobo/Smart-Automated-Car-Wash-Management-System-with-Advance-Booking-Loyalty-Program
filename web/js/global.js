// web/js/global.js

// Global initialization logic
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Lucide icons globally
    if (typeof lucide !== 'undefined' && lucide.createIcons) {
        lucide.createIcons();
    }
});
