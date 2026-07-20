document.addEventListener("DOMContentLoaded", function() {
    const loginForm = document.getElementById("loginForm");

    if (loginForm) {
        loginForm.addEventListener("submit", function(event) {
            const phone = document.getElementById("phone").value.trim();
            const password = document.getElementById("password").value;
            const errorElement = document.getElementById("login-error"); // Th\u1ebb hi\u1ec3n th\u1ecb l\u1ed7i

            // Reset th\u00f4ng b\u00e1o l\u1ed7i
            errorElement.textContent = "";

            // 1. Validate Phone
            if (!RegexConstants.PHONE_VN.test(phone)) {
                event.preventDefault(); // Ch\u1eb7n form submit l\u00ean Server
                errorElement.textContent = "S\u1ed1 \u0111i\u1ec7n tho\u1ea1i kh\u00f4ng h\u1ee3p l\u1ec7 (V\u00ed d\u1ee5: 0912345678).";
                return;
            }

            // 2. Validate Password (T\u00f9y ch\u1ecdn: \u1ede form Login th\u01b0\u1eddng ch\u1ec9 check r\u1ed7ng, 
            // nh\u01b0ng n\u1ebfu mu\u1ed1n \u00e9p \u0111\u1ecbnh d\u1ea1ng th\u00ec x\u00e0i d\u00f2ng d\u01b0\u1edbi)
            if (!RegexConstants.PASSWORD_STRONG.test(password)) {
                event.preventDefault();
                errorElement.textContent = "M\u1eadt kh\u1ea9u ph\u1ea3i t\u1eeb 8 k\u00fd t\u1ef1, c\u00f3 ch\u1eef hoa v\u00e0 k\u00fd t\u1ef1 \u0111\u1eb7c bi\u1ec7t.";
                return;
            }
        });
    }
});