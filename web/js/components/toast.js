// web/js/components/toast.js

// Universal Toast Function using Toastify
window.showToast = function(message, type = 'success') {
    const isSuccess = (type === 'success');
    const iconName = isSuccess ? 'check' : 'x';
    const titleText = isSuccess ? 'Th\u00e0nh c\u00f4ng!' : 'L\u1ed7i!';
    const className = isSuccess ? 'toastify-glass success' : 'toastify-glass error';

    Toastify({
        text: "",
        duration: 4000,
        newWindow: true,
        close: false,
        gravity: "top", 
        position: "right",
        stopOnFocus: true,
        className: className,
        node: (() => {
            const div = document.createElement("div");
            div.style.display = 'flex';
            div.style.alignItems = 'center';
            div.style.gap = '16px';
            div.style.width = '100%';
            
            div.innerHTML = 
                '<div class="toastify-icon-container">' +
                    '<i data-lucide="' + iconName + '" style="width: 20px; height: 20px;"></i>' +
                '</div>' +
                '<div style="display: flex; flex-direction: column;">' +
                    '<span style="font-weight: 700; font-size: 1.125rem;">' + titleText + '</span>' +
                    '<span style="font-size: 0.875rem; color: #d1d5db; margin-top: 2px;">' + message + '</span>' +
                '</div>';
            return div;
        })(),
    }).showToast();
    
    if (typeof lucide !== 'undefined' && lucide.createIcons) {
        lucide.createIcons();
    }
};

// Alias for old signatures to prevent ReferenceError across the project
window.showJSToast = function(type, message) {
    window.showToast(message, type);
};
