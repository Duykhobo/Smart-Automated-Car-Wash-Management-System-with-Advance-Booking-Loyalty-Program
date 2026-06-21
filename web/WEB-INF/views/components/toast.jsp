<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* Glassmorphism Toast */
    .glass-toast-success {
        background: rgba(10, 20, 40, 0.6);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border: 1px solid rgba(0, 212, 255, 0.3);
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5), inset 0 0 10px rgba(0, 212, 255, 0.1);
    }
    .glass-toast-error {
        background: rgba(40, 10, 10, 0.6);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border: 1px solid rgba(239, 68, 68, 0.3);
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5), inset 0 0 10px rgba(239, 68, 68, 0.1);
    }
</style>

<!-- Success Toast -->
<c:if test="${not empty sessionScope.successMessage}">
    <div id="globalSuccessToast" class="fixed top-24 left-1/2 transform -translate-x-1/2 translate-y-0 opacity-100 transition-all duration-500 z-50 pointer-events-none">
        <div class="glass-toast-success px-6 py-4 rounded-2xl flex items-center gap-3">
            <div class="w-10 h-10 rounded-full bg-[#00d4ff]/20 flex items-center justify-center shrink-0 border border-[#00d4ff]/40">
                <i data-lucide="check" class="w-6 h-6 text-[#00d4ff]"></i>
            </div>
            <div class="flex flex-col">
                <span class="font-display font-bold text-white text-lg">Thành công!</span>
                <span class="text-sm text-gray-300"><c:out value="${sessionScope.successMessage}" /></span>
            </div>
        </div>
    </div>
    <c:remove var="successMessage" scope="session" />
</c:if>

<!-- Error Toast -->
<c:if test="${not empty sessionScope.errorMessage}">
    <div id="globalErrorToast" class="fixed top-24 left-1/2 transform -translate-x-1/2 translate-y-0 opacity-100 transition-all duration-500 z-50 pointer-events-none">
        <div class="glass-toast-error px-6 py-4 rounded-2xl flex items-center gap-3">
            <div class="w-10 h-10 rounded-full bg-red-500/20 flex items-center justify-center shrink-0 border border-red-500/40">
                <i data-lucide="x" class="w-6 h-6 text-red-500"></i>
            </div>
            <div class="flex flex-col">
                <span class="font-display font-bold text-white text-lg">Lỗi!</span>
                <span class="text-sm text-gray-300"><c:out value="${sessionScope.errorMessage}" /></span>
            </div>
        </div>
    </div>
    <c:remove var="errorMessage" scope="session" />
</c:if>

<!-- Error Toast from Request Scope -->
<c:if test="${not empty requestScope.errorMessage}">
    <div id="globalReqErrorToast" class="fixed top-24 left-1/2 transform -translate-x-1/2 translate-y-0 opacity-100 transition-all duration-500 z-50 pointer-events-none">
        <div class="glass-toast-error px-6 py-4 rounded-2xl flex items-center gap-3">
            <div class="w-10 h-10 rounded-full bg-red-500/20 flex items-center justify-center shrink-0 border border-red-500/40">
                <i data-lucide="x" class="w-6 h-6 text-red-500"></i>
            </div>
            <div class="flex flex-col">
                <span class="font-display font-bold text-white text-lg">Lỗi!</span>
                <span class="text-sm text-gray-300"><c:out value="${requestScope.errorMessage}" /></span>
            </div>
        </div>
    </div>
    <c:remove var="errorMessage" scope="request" />
</c:if>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        // Auto hide toasts after 4 seconds
        const toasts = ['globalSuccessToast', 'globalErrorToast', 'globalReqErrorToast'];
        toasts.forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                setTimeout(() => {
                    el.classList.remove('translate-y-0', 'opacity-100');
                    el.classList.add('-translate-y-full', 'opacity-0');
                }, 4000);
            }
        });
        
        // ensure icons are rendered
        if(typeof lucide !== 'undefined' && lucide.createIcons) {
            lucide.createIcons();
        }
    });

    // --- DYNAMIC JS TOAST (For Client-side validations) ---
    function showJSToast(type, message) {
        let container = document.getElementById('jsToastContainer');
        if (!container) {
            container = document.createElement('div');
            container.id = 'jsToastContainer';
            container.className = 'fixed top-24 left-1/2 transform -translate-x-1/2 z-50 pointer-events-none flex flex-col gap-2';
            document.body.appendChild(container);
        }
        
        const toastId = 'toast_' + Date.now();
        let bgClass, iconClass, iconName, title;
        
        if (type === 'success') {
            bgClass = 'glass-toast-success';
            iconClass = 'bg-[#00d4ff]/20 border-[#00d4ff]/40 text-[#00d4ff]';
            iconName = 'check';
            title = 'Thành công!';
        } else {
            bgClass = 'glass-toast-error';
            iconClass = 'bg-red-500/20 border-red-500/40 text-red-500';
            iconName = 'x';
            title = 'Lỗi!';
        }

        const toastHtml = `
            <div id="${toastId}" class="${bgClass} px-6 py-4 rounded-2xl flex items-center gap-3 transition-all duration-500 transform -translate-y-full opacity-0 mb-2">
                <div class="w-10 h-10 rounded-full flex items-center justify-center shrink-0 border ${iconClass}">
                    <i data-lucide="${iconName}" class="w-6 h-6"></i>
                </div>
                <div class="flex flex-col">
                    <span class="font-display font-bold text-white text-lg">${title}</span>
                    <span class="text-sm text-gray-300">${message}</span>
                </div>
            </div>
        `;
        
        container.insertAdjacentHTML('beforeend', toastHtml);
        if(typeof lucide !== 'undefined' && lucide.createIcons) {
            lucide.createIcons();
        }
        
        const toastEl = document.getElementById(toastId);
        
        // Trigger animation
        requestAnimationFrame(() => {
            requestAnimationFrame(() => {
                toastEl.classList.remove('-translate-y-full', 'opacity-0');
                toastEl.classList.add('translate-y-0', 'opacity-100');
            });
        });
        
        // Auto remove
        setTimeout(() => {
            toastEl.classList.remove('translate-y-0', 'opacity-100');
            toastEl.classList.add('-translate-y-full', 'opacity-0');
            setTimeout(() => {
                if (toastEl.parentNode) toastEl.remove();
            }, 500);
        }, 4000);
    }
</script>
