<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Global Confirm Modal -->
<div id="globalConfirmModal" class="fixed inset-0 z-[100] flex items-center justify-center hidden opacity-0 transition-opacity duration-300">
    <!-- Backdrop -->
    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="hideGlobalConfirmModal()"></div>
    <!-- Modal Content -->
    <div class="relative w-full max-w-md bg-bg-surface border border-[#00d4ff]/20 rounded-2xl shadow-2xl p-6 transform scale-95 transition-transform duration-300" id="globalConfirmModalContent">
        <div class="flex items-center justify-center w-12 h-12 mx-auto mb-4 bg-red-500/20 rounded-full border border-red-500/30">
            <i data-lucide="alert-triangle" class="w-6 h-6 text-red-500"></i>
        </div>
        <h3 id="globalConfirmTitle" class="text-xl font-display font-bold text-center text-white mb-2">Xác nhận</h3>
        <p id="globalConfirmMessage" class="text-center text-gray-300 mb-6 text-sm">Bạn có chắc chắn không?</p>
        <div class="flex gap-3">
            <button onclick="hideGlobalConfirmModal()" class="flex-1 px-4 py-2 bg-transparent hover:bg-white/5 border border-white/10 text-white rounded-lg font-semibold transition-colors">
                Quay lại
            </button>
            <button id="globalConfirmBtn" class="flex-1 px-4 py-2 bg-red-500 hover:bg-red-600 text-white rounded-lg font-semibold transition-colors shadow-[0_0_15px_rgba(239,68,68,0.3)]">
                Xác nhận
            </button>
        </div>
    </div>
</div>

<script>
    let globalConfirmCallback = null;

    function showGlobalConfirmModal(title, message, confirmBtnText, callback) {
        document.getElementById('globalConfirmTitle').innerText = title;
        document.getElementById('globalConfirmMessage').innerText = message;
        document.getElementById('globalConfirmBtn').innerText = confirmBtnText || 'Xác nhận';
        
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
</script>
