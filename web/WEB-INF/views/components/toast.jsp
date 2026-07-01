<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

<style>
    .toastify-glass {
        background: rgba(10, 20, 40, 0.8) !important;
        backdrop-filter: blur(16px) !important;
        -webkit-backdrop-filter: blur(16px) !important;
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5) !important;
        border-radius: 12px !important;
        color: #fff !important;
        font-family: 'Inter', sans-serif !important;
        padding: 16px 24px !important;
        display: flex !important;
        align-items: center !important;
        gap: 16px !important;
        min-width: 300px !important;
        max-width: 450px !important;
    }
    
    .toastify-glass.success {
        border: 1px solid rgba(0, 212, 255, 0.3) !important;
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5), inset 0 0 10px rgba(0, 212, 255, 0.1) !important;
    }

    .toastify-glass.error {
        border: 1px solid rgba(239, 68, 68, 0.3) !important;
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5), inset 0 0 10px rgba(239, 68, 68, 0.1) !important;
    }
    
    .toastify-icon-container {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }
    
    .toastify-glass.success .toastify-icon-container {
        background: rgba(0, 212, 255, 0.2);
        border: 1px solid rgba(0, 212, 255, 0.4);
        color: #00d4ff;
    }

    .toastify-glass.error .toastify-icon-container {
        background: rgba(239, 68, 68, 0.2);
        border: 1px solid rgba(239, 68, 68, 0.4);
        color: #ef4444;
    }
</style>

<script>
    // Universal Toast Function using Toastify
    window.showToast = function(message, type = 'success') {
        const isSuccess = (type === 'success');
        const iconName = isSuccess ? 'check' : 'x';
        const titleText = isSuccess ? 'Thành công!' : 'Lỗi!';
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
</script>

<!-- Process Backend Session Toasts -->
<script>
    document.addEventListener("DOMContentLoaded", () => {
        let msgs = [];
        <c:if test="${not empty sessionScope.SUCCESS}">
            msgs.push({msg: '<c:out value="${sessionScope.SUCCESS}" />', type: 'success'});
            <c:remove var="SUCCESS" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.successMessage}">
            msgs.push({msg: '<c:out value="${sessionScope.successMessage}" />', type: 'success'});
            <c:remove var="successMessage" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.ERROR}">
            msgs.push({msg: '<c:out value="${sessionScope.ERROR}" />', type: 'error'});
            <c:remove var="ERROR" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
            msgs.push({msg: '<c:out value="${sessionScope.errorMessage}" />', type: 'error'});
            <c:remove var="errorMessage" scope="session" />
        </c:if>
        <c:if test="${not empty requestScope.ERROR}">
            msgs.push({msg: '<c:out value="${requestScope.ERROR}" />', type: 'error'});
            <c:remove var="ERROR" scope="request" />
        </c:if>
        <c:if test="${not empty requestScope.errorMessage}">
            msgs.push({msg: '<c:out value="${requestScope.errorMessage}" />', type: 'error'});
            <c:remove var="errorMessage" scope="request" />
        </c:if>

        msgs.forEach(t => showToast(t.msg, t.type));
    });
</script>
