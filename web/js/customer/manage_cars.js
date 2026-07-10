lucide.createIcons();

        const carModal = document.getElementById('carModal');
        const carModalContent = document.getElementById('carModalContent');
        const carModalTitle = document.getElementById('carModalTitle');
        const modalPlate = document.getElementById('modalPlate');
        const modalType = document.getElementById('modalType');
        const modalBrand = document.getElementById('modalBrand');
        const modalModel = document.getElementById('modalModel');
        const modalColor = document.getElementById('modalColor');
        const modalAction = document.getElementById('modalAction');
        const modalVehicleId = document.getElementById('modalVehicleId');
        const formError = document.getElementById('formError');
        const formErrorText = document.getElementById('formErrorText');

        function openCarModalFromButton(button) {
            const id = button.getAttribute('data-id');
            const plate = button.getAttribute('data-plate');
            const brand = button.getAttribute('data-brand');
            const model = button.getAttribute('data-model');
            const typeId = button.getAttribute('data-typeid');
            const color = button.getAttribute('data-color');

            openCarModal('update', id, plate, brand, model, typeId, color);
        }

        function handleBrandChange() {
            const select = document.getElementById('modalBrandSelect');
            const inputOther = document.getElementById('modalBrandOther');
            const hiddenInput = document.getElementById('modalBrand');

            if (select.value === 'Kh\u00e1c') {
                inputOther.classList.remove('hidden');
                inputOther.required = true;
                hiddenInput.value = inputOther.value.trim();
            } else {
                inputOther.classList.add('hidden');
                inputOther.required = false;
                hiddenInput.value = select.value;
            }
        }

        function updateBrandHiddenValue() {
            const inputOther = document.getElementById('modalBrandOther');
            const hiddenInput = document.getElementById('modalBrand');
            hiddenInput.value = inputOther.value.trim();
        }

        function handleColorChange() {
            const select = document.getElementById('modalColorSelect');
            const inputOther = document.getElementById('modalColorOther');
            const hiddenInput = document.getElementById('modalColor');

            if (select.value === 'Kh\u00e1c') {
                inputOther.classList.remove('hidden');
                inputOther.required = true;
                hiddenInput.value = inputOther.value.trim();
            } else {
                inputOther.classList.add('hidden');
                inputOther.required = false;
                hiddenInput.value = select.value;
            }
        }

        function updateColorHiddenValue() {
            const inputOther = document.getElementById('modalColorOther');
            const hiddenInput = document.getElementById('modalColor');
            hiddenInput.value = inputOther.value.trim();
        }

        function openCarModal(action, id = '', plate = '', brand = '', model = '', typeId = '1', color = '') {
            modalAction.value = action;
            formError.classList.add('hidden');

            const selectBrand = document.getElementById('modalBrandSelect');
            const inputOtherBrand = document.getElementById('modalBrandOther');
            const hiddenInputBrand = document.getElementById('modalBrand');

            const selectColor = document.getElementById('modalColorSelect');
            const inputOtherColor = document.getElementById('modalColorOther');
            const hiddenInputColor = document.getElementById('modalColor');

            if (action === 'update') {
                carModalTitle.textContent = 'C\u1eadp nh\u1eadt xe';
                modalVehicleId.value = id;
                modalPlate.value = plate;
                modalModel.value = model;
                modalType.value = typeId;

                hiddenInputBrand.value = brand;
                let isKnownBrand = false;
                for (let option of selectBrand.options) {
                    if (option.value === brand && brand !== '') {
                        isKnownBrand = true;
                        break;
                    }
                }
                if (isKnownBrand) {
                    selectBrand.value = brand;
                    inputOtherBrand.classList.add('hidden');
                    inputOtherBrand.value = '';
                } else if (brand) {
                    selectBrand.value = 'Kh\u00e1c';
                    inputOtherBrand.classList.remove('hidden');
                    inputOtherBrand.value = brand;
                } else {
                    selectBrand.value = '';
                    inputOtherBrand.classList.add('hidden');
                    inputOtherBrand.value = '';
                }

                hiddenInputColor.value = color;
                let isKnownColor = false;
                for (let option of selectColor.options) {
                    if (option.value === color && color !== '') {
                        isKnownColor = true;
                        break;
                    }
                }
                if (isKnownColor) {
                    selectColor.value = color;
                    inputOtherColor.classList.add('hidden');
                    inputOtherColor.value = '';
                } else if (color) {
                    selectColor.value = 'Kh\u00e1c';
                    inputOtherColor.classList.remove('hidden');
                    inputOtherColor.value = color;
                } else {
                    selectColor.value = '';
                    inputOtherColor.classList.add('hidden');
                    inputOtherColor.value = '';
                }
            } else {
                carModalTitle.textContent = 'Th\u00eam xe m\u1edbi';
                modalVehicleId.value = '';
                modalPlate.value = '';
                modalModel.value = '';
                modalType.value = '1';

                selectBrand.value = '';
                inputOtherBrand.classList.add('hidden');
                inputOtherBrand.value = '';
                hiddenInputBrand.value = '';

                selectColor.value = '';
                inputOtherColor.classList.add('hidden');
                inputOtherColor.value = '';
                hiddenInputColor.value = '';
            }

            carModal.classList.remove('hidden');
            carModal.classList.add('flex');

            setTimeout(() => {
                carModalContent.classList.remove('scale-95', 'opacity-0');
                carModalContent.classList.add('scale-100', 'opacity-100');
            }, 10);
        }

        function closeCarModal() {
            carModalContent.classList.remove('scale-100', 'opacity-100');
            carModalContent.classList.add('scale-95', 'opacity-0');
            setTimeout(() => {
                carModal.classList.remove('flex');
                carModal.classList.add('hidden');
            }, 300);
        }

        function validateCarForm() {
            if (!modalPlate.value.trim() || !modalBrand.value.trim() || !modalModel.value.trim() || !modalColor.value.trim()) {
                formErrorText.textContent = "Vui l\u00f2ng nh\u1eadp \u0111\u1ea7y \u0111\u1ee7 c\u00e1c tr\u01b0\u1eddng b\u1eaft bu\u1ed9c (*).";
                formError.classList.remove('hidden');
                return false;
            }

            const plateRegex = /^[0-9]{2}[A-Z][0-9A-Z]?-[0-9]{4,5}$/;
            if (!plateRegex.test(modalPlate.value.trim().toUpperCase())) {
                formErrorText.textContent = "Bi\u1ec3n s\u1ed1 xe kh\u00f4ng h\u1ee3p l\u1ec7 (VD: 51H-12345).";
                formError.classList.remove('hidden');
                return false;
            }

            formError.classList.add('hidden');
            return true;
        }

        carModal.addEventListener('click', function (e) {
            if (e.target === carModal) {
                closeCarModal();
            }
        });