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

function setTomSelectValue(elementId, value) {
    const el = document.getElementById(elementId);
    if (el && el.tomselect) {
        if (value) {
            el.tomselect.addOption({value: value, text: value});
            el.tomselect.setValue(value);
        } else {
            el.tomselect.clear();
        }
    } else if (el) {
        el.value = value;
    }
}

function openCarModalFromButton(button) {
    const id = button.getAttribute('data-id');
    const plate = button.getAttribute('data-plate');
    const brand = button.getAttribute('data-brand');
    const model = button.getAttribute('data-model');
    const typeId = button.getAttribute('data-typeid');
    const color = button.getAttribute('data-color');

    openCarModal('update', id, plate, brand, model, typeId, color);
}

function openCarModal(action, id = '', plate = '', brand = '', model = '', typeId = '1', color = '') {
    modalAction.value = action;
    formError.classList.add('hidden');

    if (action === 'update') {
        carModalTitle.textContent = 'Cập nhật xe';
        modalVehicleId.value = id;
        modalPlate.value = plate;
        
        setTomSelectValue('modalBrand', brand);
        setTomSelectValue('modalModel', model);
        setTomSelectValue('modalType', typeId);
        setTomSelectValue('modalColor', color);
    } else {
        carModalTitle.textContent = 'Thêm xe mới';
        modalVehicleId.value = '';
        modalPlate.value = '';
        
        setTomSelectValue('modalBrand', '');
        setTomSelectValue('modalModel', '');
        setTomSelectValue('modalType', '1');
        setTomSelectValue('modalColor', '');
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
        formErrorText.textContent = "Vui lòng nhập đầy đủ các trường bắt buộc (*).";
        formError.classList.remove('hidden');
        return false;
    }

    const plateRegex = /^[0-9]{2}[A-Z][0-9A-Z]?-[0-9]{4,5}$/;
    if (!plateRegex.test(modalPlate.value.trim().toUpperCase())) {
        formErrorText.textContent = "Biển số xe không hợp lệ (VD: 51H-12345).";
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