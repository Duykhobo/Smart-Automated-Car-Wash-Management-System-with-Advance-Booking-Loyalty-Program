// Initialize Lucide Icons
            lucide.createIcons();

            // Simple sticky navbar effect
            window.addEventListener('scroll', () => {
                const nav = document.querySelector('nav');
                if (window.scrollY > 20) {
                    nav.classList.add('bg-bg-primary/90', 'backdrop-blur-xl', 'border-border-glass', 'shadow-lg');
                    nav.classList.remove('glass-panel');
                } else {
                    nav.classList.add('glass-panel');
                    nav.classList.remove('bg-bg-primary/90', 'backdrop-blur-xl', 'border-border-glass', 'shadow-lg');
                }
            });