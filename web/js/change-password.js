// Toggles password field input type between password and text
function togglePassword(inputId, button) {
    const input = document.getElementById(inputId);
    const eyeOpen = button.querySelector('.eye-open');
    const eyeClosed = button.querySelector('.eye-closed');

    if (input.type === 'password') {
        input.type = 'text';
        eyeOpen.classList.add('hidden');
        eyeClosed.classList.remove('hidden');
        button.setAttribute('aria-label', 'Ẩn mật khẩu');
    } else {
        input.type = 'password';
        eyeOpen.classList.remove('hidden');
        eyeClosed.classList.add('hidden');
        button.setAttribute('aria-label', 'Hiện mật khẩu');
    }
}

// Thêm validation khi người dùng rời khỏi ô input (blur)
document.addEventListener('DOMContentLoaded', function() {
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');
    const form = document.querySelector('form');
    const errorAlert = document.getElementById('clientErrorAlert');
    const errorText = document.getElementById('clientErrorText');

    let errorMessages = [];

    function showError(message) {
        // Ẩn lỗi server nếu có để tránh hiện 2 bảng lỗi cùng lúc
        const serverAlert = document.getElementById('serverErrorAlert');
        if (serverAlert) serverAlert.classList.add('hidden');

        // Chỉ thêm lỗi nếu chưa có trong mảng (tránh trùng lặp)
        if (!errorMessages.includes(message)) {
            errorMessages.push(message);
        }
        errorText.innerHTML = errorMessages.join('<br>');
        errorAlert.classList.remove('hidden');
    }

    function hideError() {
        errorAlert.classList.add('hidden');
        errorMessages = [];
        errorText.innerHTML = '';
    }

    function validateStrongPassword(input, fieldName) {
        if (input.value.length === 0) {
            showError(fieldName + window.ERR_MSG_EMPTY);
            input.classList.add('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/50');
            input.classList.remove('border-gray-700', 'focus:border-btn-primary', 'focus:ring-btn-primary/50');
            return false;
        }

        const strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[\\W_]).{8,}$");
        if (!strongRegex.test(input.value)) {
            showError(fieldName + window.ERR_MSG_STRONG);
            input.classList.add('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/50');
            input.classList.remove('border-gray-700', 'focus:border-btn-primary', 'focus:ring-btn-primary/50');
            return false;
        } else {
            input.classList.remove('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/50');
            input.classList.add('border-gray-700', 'focus:border-btn-primary', 'focus:ring-btn-primary/50');
            return true;
        }
    }

    function validateMatch() {
        if (newPassword.value.length >= 8 && confirmPassword.value.length > 0 && newPassword.value !== confirmPassword.value) {
            showError(window.ERR_MSG_MISMATCH);
            confirmPassword.classList.add('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/50');
            confirmPassword.classList.remove('border-gray-700', 'focus:border-btn-primary', 'focus:ring-btn-primary/50');
            return false;
        }
        return true;
    }

    function validateOldPassword(input) {
        if (input.value.length === 0) {
            showError(window.ERR_MSG_OLD_EMPTY);
            input.classList.add('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/50');
            input.classList.remove('border-gray-700', 'focus:border-btn-primary', 'focus:ring-btn-primary/50');
            return false;
        } else {
            input.classList.remove('border-red-500', 'focus:border-red-500', 'focus:ring-red-500/50');
            input.classList.add('border-gray-700', 'focus:border-btn-primary', 'focus:ring-btn-primary/50');
            return true;
        }
    }

    const oldPassword = document.getElementById('oldPassword');
    if (oldPassword) {
        oldPassword.addEventListener('blur', function() {
            hideError();
            validateOldPassword(this);
        });
    }

    newPassword.addEventListener('blur', function() {
        hideError();
        if(validateStrongPassword(this, window.FIELD_NEW_PWD)) {
            if (confirmPassword.value.length > 0) {
                validateMatch();
            }
        }
    });

    confirmPassword.addEventListener('blur', function() {
        hideError();
        if (validateStrongPassword(this, window.FIELD_CONFIRM_PWD)) {
            validateMatch();
        }
    });

    form.addEventListener('submit', function(e) {
        hideError();
        let isValid = true;
        
        if (oldPassword && !validateOldPassword(oldPassword)) isValid = false;
        if (!validateStrongPassword(newPassword, window.FIELD_NEW_PWD)) isValid = false;
        if (!validateStrongPassword(confirmPassword, window.FIELD_CONFIRM_PWD)) isValid = false;
        if (isValid && !validateMatch()) isValid = false;
        
        if (!isValid) {
            e.preventDefault();
        }
    });
});
