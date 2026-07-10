lucide.createIcons();

        function confirmRedeem(rewardId, rewardName, pointsCost) {
            document.getElementById('modalRewardId').value = rewardId;
            document.getElementById('modalRewardName').textContent = rewardName;
            document.getElementById('modalPointsCost').textContent = pointsCost;
            
            const modal = document.getElementById('redeemModal');
            const content = document.getElementById('redeemModalContent');
            
            modal.classList.remove('hidden');
            modal.classList.add('flex');
            
            // Trigger reflow
            void modal.offsetWidth;
            
            content.classList.remove('scale-95', 'opacity-0');
            content.classList.add('scale-100', 'opacity-100');
        }

        function closeRedeemModal() {
            const modal = document.getElementById('redeemModal');
            const content = document.getElementById('redeemModalContent');
            
            content.classList.remove('scale-100', 'opacity-100');
            content.classList.add('scale-95', 'opacity-0');
            
            setTimeout(() => {
                modal.classList.add('hidden');
                modal.classList.remove('flex');
            }, 300);
        }

        function copyVoucherCode(code) {
            navigator.clipboard.writeText(code).then(function() {
                showToast("\u0110\u00e3 copy m\u00e3 voucher: " + code, "success");
            }, function(err) {
                console.error('Kh\u00f4ng th\u1ec3 copy text: ', err);
                showToast("Kh\u00f4ng th\u1ec3 copy m\u00e3 voucher.", "error");
            });
        }