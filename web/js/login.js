document.addEventListener("DOMContentLoaded", function() {
    const loginForm = document.getElementById("loginForm");

    if (loginForm) {
        loginForm.addEventListener("submit", function(event) {
            const phone = document.getElementById("phone").value.trim();
            const password = document.getElementById("password").value;
            const errorElement = document.getElementById("login-error"); // Thẻ hiển thị lỗi

            // Reset thông báo lỗi
            errorElement.textContent = "";

            // 1. Validate Phone
            if (!RegexConstants.PHONE_VN.test(phone)) {
                event.preventDefault(); // Chặn form submit lên Server
                errorElement.textContent = "Số điện thoại không hợp lệ (Ví dụ: 0912345678).";
                return;
            }

            // 2. Validate Password (Tùy chọn: Ở form Login thường chỉ check rỗng, 
            // nhưng nếu muốn ép định dạng thì xài dòng dưới)
            if (!RegexConstants.PASSWORD_STRONG.test(password)) {
                event.preventDefault();
                errorElement.textContent = "Mật khẩu phải từ 8 ký tự, có chữ hoa và ký tự đặc biệt.";
                return;
            }
        });
    }
});