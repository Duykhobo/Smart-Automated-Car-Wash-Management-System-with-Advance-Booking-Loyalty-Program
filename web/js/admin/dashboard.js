lucide.createIcons();

        document.addEventListener('DOMContentLoaded', function() {
            const ctx = document.getElementById('revenueChart').getContext('2d');
            const gradient = ctx.createLinearGradient(0, 0, 0, 300);
            gradient.addColorStop(0, 'rgba(0, 212, 255, 0.5)'); 
            gradient.addColorStop(1, 'rgba(0, 212, 255, 0.0)');

            const mockData = {
                labels: typeof chartLabels !== 'undefined' ? chartLabels : [],
                datasets: [{
                    label: 'Doanh thu (VN\u0110)',
                    data: typeof chartData !== 'undefined' ? chartData : [],
                    borderColor: '#00d4ff',
                    backgroundColor: gradient,
                    borderWidth: 3,
                    pointBackgroundColor: '#070b14',
                    pointBorderColor: '#00d4ff',
                    pointBorderWidth: 2,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    fill: true,
                    tension: 0.4
                }]
            };

            new Chart(ctx, {
                type: 'line',
                data: mockData,
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: 'rgba(7, 11, 20, 0.9)',
                            titleColor: '#fff',
                            bodyColor: '#cbd5e1',
                            borderColor: 'rgba(255,255,255,0.1)',
                            borderWidth: 1,
                            padding: 10,
                            displayColors: false,
                            callbacks: {
                                label: function(context) {
                                    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(context.raw);
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: 'rgba(255, 255, 255, 0.05)', drawBorder: false },
                            ticks: { 
                                color: '#94a3b8',
                                callback: function(value) { 
                                    return new Intl.NumberFormat('vi-VN').format(value); 
                                }
                            }
                        },
                        x: {
                            grid: { display: false, drawBorder: false },
                            ticks: { color: '#94a3b8' }
                        }
                    }
                }
            });
        });

        function simulateLPR() {
            const plate = document.getElementById('licensePlate').value.toUpperCase();
            const btn = document.getElementById('lprSubmitBtn');
            const alertBox = document.getElementById('lprAlert');
            
            if (!plate) return;

            const originalBtnHtml = btn.innerHTML;
            btn.innerHTML = '<i data-lucide="loader" class="w-5 h-5 animate-spin"></i> \u0110ang x\u1eed l\u00fd...';
            lucide.createIcons();
            btn.disabled = true;
            btn.classList.add('opacity-70');
            alertBox.classList.add('hidden');

            setTimeout(() => {
                const isSuccess = Math.random() > 0.3; 
                alertBox.className = 'mt-4 p-3 rounded-lg text-sm text-center border';

                if(isSuccess) {
                    alertBox.classList.add('bg-success/20', 'text-success', 'border-success/30');
                    alertBox.innerHTML = '<div class="flex items-center justify-center gap-2"><i data-lucide="check-circle" class="w-4 h-4"></i> <strong>Th\u00e0nh c\u00f4ng!</strong> Xe ' + plate + ' \u0111\u00e3 v\u00e0o tr\u1ea1m. \u0110\u00e3 c\u1ed9ng 25 \u0111i\u1ec3m.</div>';
                    document.getElementById('licensePlate').value = '';
                } else {
                    alertBox.classList.add('bg-error/20', 'text-error', 'border-error/30');
                    alertBox.innerHTML = '<div class="flex items-center justify-center gap-2"><i data-lucide="alert-triangle" class="w-4 h-4"></i> <strong>L\u1ed7i:</strong> Kh\u00f4ng t\u00ecm th\u1ea5y l\u1ecbch cho xe ' + plate + '!</div>';
                }
                
                lucide.createIcons();
                alertBox.classList.remove('hidden');
                btn.innerHTML = originalBtnHtml;
                lucide.createIcons();
                btn.disabled = false;
                btn.classList.remove('opacity-70');
            }, 1000); 
        }