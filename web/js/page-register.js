function handleRegister(event) {
    // 1. Chạy Validation Front-end
    if (!validateForm()) {
        event.preventDefault(); // Chặn submit nếu form không hợp lệ (báo đỏ)
        return false;
    }

    // Form hợp lệ -> Để cho HTML tự submit lên Servlet!
    const submitBtn = document.querySelector('button[type="submit"]');
    submitBtn.innerText = "Đang xử lý...";
    
    // Dùng setTimeout để tránh vô hiệu hóa nút ngay lập tức trong luồng đồng bộ, 
    // tránh làm trình duyệt dừng hoặc từ chối gửi form đi.
    setTimeout(() => {
        submitBtn.disabled = true;
    }, 10);

    return true;
}

document.addEventListener("DOMContentLoaded", function () {
    const fields = ['fullname', 'phone', 'plate', 'password', 'confirm_password', 'terms'];

    fields.forEach(id => {
        const el = document.getElementById(id);
        if (el) {
            // Validate on blur (when focus is lost)
            el.addEventListener('blur', () => {
                validateField(id);
            });
            // Clear error on input
            el.addEventListener('input', () => {
                clearErrorInline(id);
            });
            // Checkbox uses change event
            if (el.type === 'checkbox') {
                el.addEventListener('change', () => {
                    validateField(id);
                });
            }
        }
    });
});

function showErrorInline(id, msg) {
    const el = document.getElementById(id);
    const errSpan = document.getElementById('err-' + id);
    if (errSpan) {
        errSpan.innerText = msg;
        errSpan.style.display = 'block';
    }
    if (el) {
        el.style.borderColor = 'var(--danger-color, #ef4444)';
    }
}

function clearErrorInline(id) {
    const el = document.getElementById(id);
    const errSpan = document.getElementById('err-' + id);
    if (errSpan) {
        errSpan.style.display = 'none';
    }
    if (el) {
        el.style.borderColor = 'var(--border-color)';
    }
}

function validateField(id) {
    const el = document.getElementById(id);
    if (!el)
        return true;

    const val = el.value.trim();

    switch (id) {
        case 'fullname':
            if (val.length < 2) {
                showErrorInline(id, "Họ và Tên phải có ít nhất 2 ký tự.");
                return false;
            }
            break;
        case 'phone':
            if (!RegexConstants.PHONE_VN.test(val)) {
                showErrorInline(id, "Số điện thoại không hợp lệ (Phải là đầu số VN hợp lệ như 03, 09... và đủ 10 số).");
                return false;
            }
            break;
        case 'plate':
            if (!RegexConstants.PLATE_VN.test(val.toUpperCase())) {
                showErrorInline(id, "Biển số xe không hợp lệ (VD chuẩn: 51F-12345, 29A1-123.45).");
                return false;
            }
            break;
        case 'password':
            if (!RegexConstants.PASSWORD_STRONG.test(val)) {
                showErrorInline(id, "Mật khẩu phải có ít nhất 8 ký tự, chứa chữ viết hoa và ký tự đặc biệt.");
                return false;
            }
            break;
        case 'confirm_password':
            const pwd = document.getElementById('password').value;
            if (val !== pwd || val === '') {
                showErrorInline(id, "Xác nhận mật khẩu không khớp!");
                return false;
            }
            break;
        case 'terms':
            if (!el.checked) {
                showErrorInline(id, "Bạn phải đồng ý với Điều khoản dịch vụ.");
                return false;
            }
            break;
    }

    clearErrorInline(id);
    return true;
}

function validateForm() {
    const fields = ['fullname', 'phone', 'plate', 'password', 'confirm_password', 'terms'];
    let isValid = true;

    fields.forEach(id => {
        if (!validateField(id)) {
            isValid = false;
        }
    });

    return isValid;
}

function togglePassword(inputId, iconEl) {
    const input = document.getElementById(inputId);
    if (input.type === "password") {
        input.type = "text";
        iconEl.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="eye-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" /></svg>`;
    } else {
        input.type = "password";
        iconEl.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" class="eye-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" /></svg>`;
    }
}
