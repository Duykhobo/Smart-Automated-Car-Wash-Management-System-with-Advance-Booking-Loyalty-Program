let globalConfirmCallback = null;

    function showGlobalConfirmModal(title, message, confirmBtnText, callback) {
        document.getElementById('globalConfirmTitle').innerText = title;
        document.getElementById('globalConfirmMessage').innerText = message;
        document.getElementById('globalConfirmBtn').innerText = confirmBtnText || 'X\u00e1c nh\u1eadn';
        
        globalConfirmCallback = callback;

        const modal = document.getElementById('globalConfirmModal');
        const content = document.getElementById('globalConfirmModalContent');
        
        modal.classList.remove('hidden');
        // Trigger reflow
        void modal.offsetWidth;
        
        modal.classList.remove('opacity-0');
        modal.classList.add('opacity-100');
        
        content.classList.remove('scale-95');
        content.classList.add('scale-100');
    }

    function hideGlobalConfirmModal() {
        const modal = document.getElementById('globalConfirmModal');
        const content = document.getElementById('globalConfirmModalContent');
        
        modal.classList.remove('opacity-100');
        modal.classList.add('opacity-0');
        
        content.classList.remove('scale-100');
        content.classList.add('scale-95');
        
        setTimeout(() => {
            modal.classList.add('hidden');
            globalConfirmCallback = null;
        }, 300);
    }

    document.getElementById('globalConfirmBtn').addEventListener('click', () => {
        if (globalConfirmCallback) {
            globalConfirmCallback();
        }
        hideGlobalConfirmModal();
    });