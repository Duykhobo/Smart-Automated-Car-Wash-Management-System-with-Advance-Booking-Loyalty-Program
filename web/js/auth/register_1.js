function handleRegister(event) {
                const form = event.target;
                const phone = form.phone.value.trim();
                const password = form.password.value;
                const confirmPassword = form.confirm_password.value; // Fixed ID matching HTML
                const clientError = document.getElementById('clientError');
                const clientErrorText = document.getElementById('clientErrorText');

                let errors = [];

                if (phone.length !== 10 || !phone.startsWith('0')) {
                    errors.push("S\u1ed1 \u0111i\u1ec7n tho\u1ea1i kh\u00f4ng h\u1ee3p l\u1ec7 (ph\u1ea3i b\u1eaft \u0111\u1ea7u b\u1eb1ng 0 v\u00e0 g\u1ed3m 10 s\u1ed1).");
                }
                if (password.length < 6) {
                    errors.push("M\u1eadt kh\u1ea9u ph\u1ea3i c\u00f3 \u00edt nh\u1ea5t 6 k\u00fd t\u1ef1.");
                }
                if (password !== confirmPassword) {
                    errors.push("X\u00e1c nh\u1eadn m\u1eadt kh\u1ea9u kh\u00f4ng kh\u1edbp.");
                }
                if (!form.terms.checked) {
                    errors.push("B\u1ea1n ph\u1ea3i \u0111\u1ed3ng \u00fd v\u1edbi \u0110i\u1ec1u kho\u1ea3n d\u1ecbch v\u1ee5 v\u00e0 Ch\u00ednh s\u00e1ch b\u1ea3o m\u1eadt.");
                }

                if (errors.length > 0) {
                    clientErrorText.innerHTML = errors.join('<br>');
                    clientError.classList.remove('hidden');
                    event.preventDefault();
                    return false;
                }

                clientError.classList.add('hidden');
                return true;
            }