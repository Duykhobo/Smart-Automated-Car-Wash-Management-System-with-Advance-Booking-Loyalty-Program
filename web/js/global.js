// web/js/global.js

// Global initialization logic
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Lucide icons globally
    if (typeof lucide !== 'undefined' && lucide.createIcons) {
        lucide.createIcons();
    }

    // Initialize Flatpickr globally
    if (typeof flatpickr !== 'undefined') {
        flatpickr(".flatpickr-date", {
            locale: "vn",
            dateFormat: "Y-m-d",
            allowInput: true,
            altInput: true,
            altFormat: "d/m/Y",
            placeholder: "Chọn ngày..."
        });
    }

    // Initialize TomSelect globally
    if (typeof TomSelect !== 'undefined') {
        document.querySelectorAll('.custom-select').forEach((el) => {
            new TomSelect(el, {
                create: el.hasAttribute('data-create') ? true : false,
                sortField: {
                    field: "text",
                    direction: "asc"
                },
                placeholder: el.getAttribute('placeholder') || 'Chọn một tùy chọn...'
            });
        });
    }
});
