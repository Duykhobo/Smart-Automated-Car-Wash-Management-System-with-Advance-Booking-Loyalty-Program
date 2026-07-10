lucide.createIcons();

        function togglePassword(inputId, buttonElement) {
            const input = document.getElementById(inputId);
            const iconEye = buttonElement.querySelector('.icon-eye');
            const iconEyeOff = buttonElement.querySelector('.icon-eye-off');

            if (input.type === 'password') {
                input.type = 'text';
                iconEye.classList.add('hidden');
                iconEyeOff.classList.remove('hidden');
            } else {
                input.type = 'password';
                iconEye.classList.remove('hidden');
                iconEyeOff.classList.add('hidden');
            }
        }

        function validatePasswordForm(event) {
            const currentPass = document.getElementById('txtCurrentPassword').value;
            const newPass = document.getElementById('txtNewPassword').value;
            const confirmPass = document.getElementById('txtConfirmNewPassword').value;
            const errorAlert = document.getElementById('clientErrorAlert');
            const errorText = document.getElementById('clientErrorText');

            if (!currentPass || !newPass || !confirmPass) {
                errorText.textContent = "Vui l\u00f2ng \u0111i\u1ec1n \u0111\u1ea7y \u0111\u1ee7 c\u00e1c tr\u01b0\u1eddng b\u1eaft bu\u1ed9c.";
                errorAlert.classList.remove('hidden');
                event.preventDefault();
                return false;
            }

            if (newPass.length < 6) {
                errorText.textContent = "M\u1eadt kh\u1ea9u m\u1edbi ph\u1ea3i c\u00f3 \u00edt nh\u1ea5t 6 k\u00fd t\u1ef1.";
                errorAlert.classList.remove('hidden');
                event.preventDefault();
                return false;
            }

            if (newPass !== confirmPass) {
                errorText.textContent = "M\u1eadt kh\u1ea9u m\u1edbi v\u00e0 m\u1eadt kh\u1ea9u x\u00e1c nh\u1eadn kh\u00f4ng kh\u1edbp.";
                errorAlert.classList.remove('hidden');
                event.preventDefault();
                return false;
            }

            if (newPass === currentPass) {
                errorText.textContent = "M\u1eadt kh\u1ea9u m\u1edbi kh\u00f4ng \u0111\u01b0\u1ee3c gi\u1ed1ng v\u1edbi m\u1eadt kh\u1ea9u hi\u1ec7n t\u1ea1i.";
                errorAlert.classList.remove('hidden');
                event.preventDefault();
                return false;
            }

            errorAlert.classList.add('hidden');
            return true;
        }