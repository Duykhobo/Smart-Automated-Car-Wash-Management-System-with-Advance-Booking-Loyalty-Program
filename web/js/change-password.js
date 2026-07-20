// Toggles password field input type between password and text
function togglePassword(inputId, button) {
    const input = document.getElementById(inputId);
    const eyeOpen = button.querySelector('.eye-open');
    const eyeClosed = button.querySelector('.eye-closed');

    if (input.type === 'password') {
        input.type = 'text';
        eyeOpen.classList.add('hidden');
        eyeClosed.classList.remove('hidden');
        button.setAttribute('aria-label', '\u1ea8n m\u1eadt kh\u1ea9u');
    } else {
        input.type = 'password';
        eyeOpen.classList.remove('hidden');
        eyeClosed.classList.add('hidden');
        button.setAttribute('aria-label', 'Hi\u1ec7n m\u1eadt kh\u1ea9u');
    }
}

// Th\u00eam validation khi ng\u01b0\u1eddi d\u00f9ng r\u1eddi kh\u1ecfi \u00f4 input (blur)
document.addEventListener('DOMContentLoaded', function() {
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');
    const form = document.querySelector('form');
    const errorAlert = document.getElementById('clientErrorAlert');
    const errorText = document.getElementById('clientErrorText');

    let errorMessages = [];

    function showError(message) {
        // \u1ea8n l\u1ed7i server n\u1ebfu c\u00f3 \u0111\u1ec3 tr\u00e1nh hi\u1ec7n 2 b\u1ea3ng l\u1ed7i c\u00f9ng l\u00fac
        const serverAlert = document.getElementById('serverErrorAlert');
        if (serverAlert) serverAlert.classList.add('hidden');

        // Ch\u1ec9 th\u00eam l\u1ed7i n\u1ebfu ch\u01b0a c\u00f3 trong m\u1ea3ng (tr\u00e1nh tr\u00f9ng l\u1eb7p)
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
