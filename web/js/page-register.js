/**
 * Validate the registration form and prepare the submit button before form submission.
 * If validation fails, the submission is prevented and the function returns `false`. If validation succeeds, the submit button text is changed to "\u0110ang x\u1eed l\u00fd..." and the button is disabled shortly after to help prevent double submission.
 * @param {Event} event - The form submit event.
 * @returns {boolean} `true` if validation passed and submission may proceed, `false` if validation failed and submission was prevented.
 */
function handleRegister(event) {
    // 1. Ch\u1ea1y Validation Front-end
    if (!validateForm()) {
        event.preventDefault(); // Ch\u1eb7n submit n\u1ebfu form kh\u00f4ng h\u1ee3p l\u1ec7 (b\u00e1o \u0111\u1ecf)
        return false;
    }

    // Form h\u1ee3p l\u1ec7 -> \u0110\u1ec3 cho HTML t\u1ef1 submit l\u00ean Servlet!
    const submitBtn = document.querySelector('button[type="submit"]');
    submitBtn.innerText = "\u0110ang x\u1eed l\u00fd...";
    
    // D\u00f9ng setTimeout \u0111\u1ec3 tr\u00e1nh v\u00f4 hi\u1ec7u h\u00f3a n\u00fat ngay l\u1eadp t\u1ee9c trong lu\u1ed3ng \u0111\u1ed3ng b\u1ed9, 
    // tr\u00e1nh l\u00e0m tr\u00ecnh duy\u1ec7t d\u1eebng ho\u1eb7c t\u1eeb ch\u1ed1i g\u1eedi form \u0111i.
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
                showErrorInline(id, "H\u1ecd v\u00e0 T\u00ean ph\u1ea3i c\u00f3 \u00edt nh\u1ea5t 2 k\u00fd t\u1ef1.");
                return false;
            }
            break;
        case 'phone':
            if (!RegexConstants.PHONE_VN.test(val)) {
                showErrorInline(id, "S\u1ed1 \u0111i\u1ec7n tho\u1ea1i kh\u00f4ng h\u1ee3p l\u1ec7 (Ph\u1ea3i l\u00e0 \u0111\u1ea7u s\u1ed1 VN h\u1ee3p l\u1ec7 nh\u01b0 03, 09... v\u00e0 \u0111\u1ee7 10 s\u1ed1).");
                return false;
            }
            break;
        case 'plate':
            if (!RegexConstants.PLATE_VN.test(val.toUpperCase())) {
                showErrorInline(id, "Bi\u1ec3n s\u1ed1 xe kh\u00f4ng h\u1ee3p l\u1ec7 (VD chu\u1ea9n: 51F-12345, 29A1-123.45).");
                return false;
            }
            break;
        case 'password':
            if (!RegexConstants.PASSWORD_STRONG.test(val)) {
                showErrorInline(id, "M\u1eadt kh\u1ea9u ph\u1ea3i c\u00f3 \u00edt nh\u1ea5t 8 k\u00fd t\u1ef1, ch\u1ee9a ch\u1eef vi\u1ebft hoa v\u00e0 k\u00fd t\u1ef1 \u0111\u1eb7c bi\u1ec7t.");
                return false;
            }
            break;
        case 'confirm_password':
            const pwd = document.getElementById('password').value;
            if (val !== pwd || val === '') {
                showErrorInline(id, "X\u00e1c nh\u1eadn m\u1eadt kh\u1ea9u kh\u00f4ng kh\u1edbp!");
                return false;
            }
            break;
        case 'terms':
            if (!el.checked) {
                showErrorInline(id, "B\u1ea1n ph\u1ea3i \u0111\u1ed3ng \u00fd v\u1edbi \u0110i\u1ec1u kho\u1ea3n d\u1ecbch v\u1ee5.");
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
