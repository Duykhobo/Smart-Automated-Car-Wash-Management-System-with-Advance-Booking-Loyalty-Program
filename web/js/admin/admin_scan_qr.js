lucide.createIcons();
        
        function simulateScan() {
            // Play a fake beep sound
            const audio = new Audio('https://assets.mixkit.co/sfx/preview/mixkit-software-interface-start-2574.mp3');
            audio.volume = 0.5;
            audio.play().catch(e => console.log("Audio play blocked by browser"));
            
            const resultCard = document.getElementById('scanResult');
            resultCard.classList.remove('translate-y-[150%]', 'opacity-0');
        }

        function closeResult() {
            const resultCard = document.getElementById('scanResult');
            resultCard.classList.add('translate-y-[150%]', 'opacity-0');
        }

        function confirmPayment() {
            closeResult();
            showToast("Th\u00e0nh c\u00f4ng", "\u0110\u00e3 thu ti\u1ec1n v\u00e0 chuy\u1ec3n tr\u1ea1ng th\u00e1i Booking sang Confirmed.", "success");
        }