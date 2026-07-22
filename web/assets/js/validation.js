/**
 * Validation Utils - Pure JavaScript
 * Handles inline error messages for forms.
 */

const ValidationUtils = {
    patterns: {
        email: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
        phone: /^0\d{9}$/,
        licensePlate: /^[0-9]{2}[A-Z][0-9A-Z]?-[0-9]{4,5}$/,
        name: /^[a-zA-Z\u00c0\u00c1\u00c2\u00c3\u00c8\u00c9\u00ca\u00cc\u00cd\u00d2\u00d3\u00d4\u00d5\u00d9\u00da\u0102\u0110\u0128\u0168\u01a0\u00e0\u00e1\u00e2\u00e3\u00e8\u00e9\u00ea\u00ec\u00ed\u00f2\u00f3\u00f4\u00f5\u00f9\u00fa\u0103\u0111\u0129\u0169\u01a1\u01af\u0102\u1ea0\u1ea2\u1ea4\u1ea6\u1ea8\u1eaa\u1eac\u1eae\u1eb0\u1eb2\u1eb4\u1eb6\u1eb8\u1eba\u1ebc\u1ec0\u1ec0\u1ec2\u01b0\u0103\u1ea1\u1ea3\u1ea5\u1ea7\u1ea9\u1eab\u1ead\u1eaf\u1eb1\u1eb3\u1eb5\u1eb7\u1eb9\u1ebb\u1ebd\u1ec1\u1ec1\u1ec3\u1ec4\u1ec6\u1ec8\u1eca\u1ecc\u1ece\u1ed0\u1ed2\u1ed4\u1ed6\u1ed8\u1eda\u1edc\u1ede\u1ee0\u1ee2\u1ee4\u1ee6\u1ee8\u1eea\u1ec5\u1ec7\u1ec9\u1ecb\u1ecd\u1ecf\u1ed1\u1ed3\u1ed5\u1ed7\u1ed9\u1edb\u1edd\u1edf\u1ee1\u1ee3\u1ee5\u1ee7\u1ee9\u1eeb\u1eec\u1eee\u1ef0\u1ef2\u1ef4\u00dd\u1ef6\u1ef8\u1eed\u1eef\u1ef1\u1ef3\u1ef5\u1ef7\u1ef9\s]+$/,
        voucherCode: /^[A-Z0-9_-]{3,30}$/,
        rewardType: /^[A-Z0-9_]{3,30}$/,
        rewardName: /^[a-zA-Z0-9\u00c0\u00c1\u00c2\u00c3\u00c8\u00c9\u00ca\u00cc\u00cd\u00d2\u00d3\u00d4\u00d5\u00d9\u00da\u0102\u0110\u0128\u0168\u01a0\u00e0\u00e1\u00e2\u00e3\u00e8\u00e9\u00ea\u00ec\u00ed\u00f2\u00f3\u00f4\u00f5\u00f9\u00fa\u0103\u0111\u0129\u0169\u01a1\u01af\u0102\u1ea0\u1ea2\u1ea4\u1ea6\u1ea8\u1eaa\u1eac\u1eae\u1eb0\u1eb2\u1eb4\u1eb6\u1eb8\u1eba\u1ebc\u1ec0\u1ec0\u1ec2\u01b0\u0103\u1ea1\u1ea3\u1ea5\u1ea7\u1ea9\u1eab\u1ead\u1eaf\u1eb1\u1eb3\u1eb5\u1eb7\u1eb9\u1ebb\u1ebd\u1ec1\u1ec1\u1ec3\u1ec4\u1ec6\u1ec8\u1eca\u1ecc\u1ece\u1ed0\u1ed2\u1ed4\u1ed6\u1ed8\u1eda\u1edc\u1ede\u1ee0\u1ee2\u1ee4\u1ee6\u1ee8\u1eea\u1ec5\u1ec7\u1ec9\u1ecb\u1ecd\u1ecf\u1ed1\u1ed3\u1ed5\u1ed7\u1ed9\u1edb\u1edd\u1edf\u1ee1\u1ee3\u1ee5\u1ee7\u1ee9\u1eeb\u1eec\u1eee\u1ef0\u1ef2\u1ef4\u00dd\u1ef6\u1ef8\u1eed\u1eef\u1ef1\u1ef3\u1ef5\u1ef7\u1ef9\s%\-&+,:()]{1,100}$/
    },

    /**
     * Show an error message directly below the input element
     * @param {HTMLElement} inputElement - The input field
     * @param {string} message - The error message to display
     */
    showError: function(inputElement, message) {
        this.clearError(inputElement); // Clear previous errors
        
        // Add red border to input
        inputElement.classList.add('border-red-500', 'focus:ring-red-500', 'focus:border-red-500');
        inputElement.classList.remove('border-gray-300', 'focus:ring-blue-500', 'focus:border-blue-500');
        
        // Create error message element
        const errorDiv = document.createElement('p');
        errorDiv.className = 'validation-error text-red-500 text-sm mt-1';
        errorDiv.innerText = message;
        
        // Insert after input element
        if (inputElement.nextSibling) {
            inputElement.parentNode.insertBefore(errorDiv, inputElement.nextSibling);
        } else {
            inputElement.parentNode.appendChild(errorDiv);
        }
    },

    /**
     * Clear the error message for a given input element
     * @param {HTMLElement} inputElement - The input field
     */
    clearError: function(inputElement) {
        inputElement.classList.remove('border-red-500', 'focus:ring-red-500', 'focus:border-red-500');
        
        const parent = inputElement.parentNode;
        const errorElements = parent.querySelectorAll('.validation-error');
        errorElements.forEach(el => el.remove());
    },

    /**
     * Clear all errors within a form
     * @param {HTMLElement} formElement - The form
     */
    clearAllErrors: function(formElement) {
        const inputs = formElement.querySelectorAll('input, select, textarea');
        inputs.forEach(input => this.clearError(input));
    },

    /**
     * Check if a value is empty
     */
    isEmpty: function(value) {
        return !value || value.trim() === '';
    },

    /**
     * Common validation methods
     */
    isValidEmail: function(email) {
        return this.patterns.email.test(email.trim());
    },

    isValidPhone: function(phone) {
        return this.patterns.phone.test(phone.trim());
    },

    isValidName: function(name) {
        return this.patterns.name.test(name.trim());
    },

    isValidLicensePlate: function(plate) {
        return this.patterns.licensePlate.test(plate.trim());
    },

    isValidVoucherCode: function(code) {
        return this.patterns.voucherCode.test(code.trim());
    },

    isValidRewardType: function(type) {
        return this.patterns.rewardType.test(type.trim());
    },

    isValidRewardName: function(name) {
        return this.patterns.rewardName.test(name.trim());
    },

    isValidPassword: function(password) {
        return password && password.trim().length >= 8;
    }
};

/**
 * Setup real-time validation on blur for inputs with specific data attributes
 * Example: <input data-validate="email" required>
 */
document.addEventListener('DOMContentLoaded', () => {
    const forms = document.querySelectorAll('form[data-auto-validate="true"]');
    
    forms.forEach(form => {
        const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
        
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                validateSingleInput(this);
            });
            input.addEventListener('input', function() {
                ValidationUtils.clearError(this);
            });
        });

        form.addEventListener('submit', function(e) {
            let isValid = true;
            
            inputs.forEach(input => {
                if (!validateSingleInput(input)) {
                    isValid = false;
                }
            });

            if (!isValid) {
                e.preventDefault();
                // Hi\u1ec3n th\u1ecb Toast Notification th\u00f4ng b\u00e1o l\u1ed7i t\u1ed5ng qu\u00e1t
                if (typeof window.showToast === 'function') {
                    window.showToast('Vui l\u00f2ng ki\u1ec3m tra l\u1ea1i c\u00e1c tr\u01b0\u1eddng th\u00f4ng tin m\u00e0u \u0111\u1ecf', 'error');
                }
            }
        });
    });
});

function validateSingleInput(input) {
    const val = input.value;
    const isRequired = input.hasAttribute('required');
    const validateType = input.getAttribute('data-validate');
    
    ValidationUtils.clearError(input);

    if (isRequired && ValidationUtils.isEmpty(val)) {
        ValidationUtils.showError(input, 'Tr\u01b0\u1eddng n\u00e0y kh\u00f4ng \u0111\u01b0\u1ee3c \u0111\u1ec3 tr\u1ed1ng');
        return false;
    }

    if (!ValidationUtils.isEmpty(val) && validateType) {
        switch (validateType) {
            case 'email':
                if (!ValidationUtils.isValidEmail(val)) {
                    ValidationUtils.showError(input, 'Email kh\u00f4ng h\u1ee3p l\u1ec7');
                    return false;
                }
                break;
            case 'phone':
                if (!ValidationUtils.isValidPhone(val)) {
                    ValidationUtils.showError(input, 'S\u1ed1 \u0111i\u1ec7n tho\u1ea1i ph\u1ea3i g\u1ed3m 10 s\u1ed1 v\u00e0 b\u1eaft \u0111\u1ea7u b\u1eb1ng 0');
                    return false;
                }
                break;
            case 'name':
                if (!ValidationUtils.isValidName(val)) {
                    ValidationUtils.showError(input, 'T\u00ean kh\u00f4ng h\u1ee3p l\u1ec7 (kh\u00f4ng ch\u1ee9a s\u1ed1, k\u00fd t\u1ef1 \u0111\u1eb7c bi\u1ec7t)');
                    return false;
                }
                break;
            case 'licensePlate':
                if (!ValidationUtils.isValidLicensePlate(val)) {
                    ValidationUtils.showError(input, 'Bi\u1ec3n s\u1ed1 xe kh\u00f4ng h\u1ee3p l\u1ec7 (VD: 59A-12345)');
                    return false;
                }
                break;
            case 'voucher':
                if (!ValidationUtils.isValidVoucherCode(val)) {
                    ValidationUtils.showError(input, 'M\u00e3 voucher kh\u00f4ng h\u1ee3p l\u1ec7 (Ch\u1eef IN HOA, s\u1ed1, d\u1ea5u - _, t\u1ed1i \u0111a 30 k\u00fd t\u1ef1)');
                    return false;
                }
                break;
            case 'rewardType':
                if (!ValidationUtils.isValidRewardType(val)) {
                    ValidationUtils.showError(input, 'M\u00e3 ph\u00e2n lo\u1ea1i kh\u00f4ng h\u1ee3p l\u1ec7 (Ch\u1ec9 ch\u1ee9a ch\u1eef IN HOA, s\u1ed1, d\u1ea5u _, t\u1ed1i \u0111a 30 k\u00fd t\u1ef1)');
                    return false;
                }
                break;
            case 'rewardName':
                if (!ValidationUtils.isValidRewardName(val)) {
                    ValidationUtils.showError(input, 'T\u00ean kh\u00f4ng h\u1ee3p l\u1ec7 (T\u1ed1i \u0111a 100 k\u00fd t\u1ef1, kh\u00f4ng ch\u1ee9a k\u00fd t\u1ef1 \u0111\u1eb7c bi\u1ec7t nguy hi\u1ec3m)');
                    return false;
                }
                break;
            case 'password':
                if (!ValidationUtils.isValidPassword(val)) {
                    ValidationUtils.showError(input, 'M\u1eadt kh\u1ea9u ph\u1ea3i c\u00f3 \u00edt nh\u1ea5t 8 k\u00fd t\u1ef1');
                    return false;
                }
                break;
            case 'confirm_password':
                const passInputId = input.getAttribute('data-match');
                if (passInputId) {
                    const passInput = document.getElementById(passInputId);
                    if (passInput && passInput.value !== val) {
                        ValidationUtils.showError(input, 'M\u1eadt kh\u1ea9u x\u00e1c nh\u1eadn kh\u00f4ng kh\u1edbp');
                        return false;
                    }
                }
                break;
            case 'number':
                const min = input.getAttribute('min');
                const max = input.getAttribute('max');
                const num = Number(val);
                if (isNaN(num)) {
                    ValidationUtils.showError(input, 'Vui l\u00f2ng nh\u1eadp m\u1ed9t s\u1ed1 h\u1ee3p l\u1ec7');
                    return false;
                }
                if (min !== null && num < Number(min)) {
                    ValidationUtils.showError(input, `Gi\u00e1 tr\u1ecb ph\u1ea3i l\u1edbn h\u01a1n ho\u1eb7c b\u1eb1ng ${min}`);
                    return false;
                }
                if (max !== null && num > Number(max)) {
                    ValidationUtils.showError(input, `Gi\u00e1 tr\u1ecb ph\u1ea3i nh\u1ecf h\u01a1n ho\u1eb7c b\u1eb1ng ${max}`);
                    return false;
                }
                break;
        }
    }
    return true;
}

/**
 * Toggle password visibility
 */
function togglePassword(inputId, btn) {
    const input = document.getElementById(inputId);
    if (!input) return;
    if (input.type === 'password') {
        input.type = 'text';
        btn.innerHTML = '<i data-lucide="eye-off" class="w-5 h-5"></i>';
    } else {
        input.type = 'password';
        btn.innerHTML = '<i data-lucide="eye" class="w-5 h-5"></i>';
    }
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
}
