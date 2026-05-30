<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta charset="utf-8" />
<title>Auto Wash Pro - Quản lý xe</title>
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<!-- Tailwind CDN -->
<script src="https://cdn.tailwindcss.com"></script>
<script>
/** @type {import('tailwindcss').Config} */
tailwind.config = {
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'sans-serif']
      },
      colors: {
        "bg-primary": "#0b0f1a",
        "btn-primary": "#00d4ff",
        "colors-accents-green": "#10b981",
        "error": "#ef4444"
      }
    }
  },
  plugins: []
}
</script>
</head>
<body class="bg-bg-primary text-white font-sans antialiased selection:bg-btn-primary selection:text-black">

<div class="flex h-screen overflow-hidden bg-bg-primary">

    <!-- Desktop Sidebar (Tự động hiển thị trên máy tính, ẩn trên mobile) -->
    <aside class="hidden md:flex flex-col w-64 border-r border-gray-800 bg-[#121826]">
        <a href="home" class="p-6 flex items-center gap-3 hover:opacity-80 transition-opacity">
            <div class="w-10 h-10 bg-btn-primary rounded-xl flex items-center justify-center text-black font-bold text-xl">A</div>
            <span class="font-bold text-xl tracking-wider text-btn-primary">AUTOWASH</span>
        </a>
        
        <nav class="flex-1 px-4 py-4 space-y-2">
            <a href="dashboard" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                <span class="font-medium">Trang chủ</span>
            </a>
            <a href="booking" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                <span class="font-medium">Đặt lịch</span>
            </a>
            <a href="#" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7"></path></svg>
                <span class="font-medium">Ưu đãi</span>
            </a>
            <a href="profile" class="flex items-center gap-3 px-4 py-3 bg-btn-primary/10 text-btn-primary rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                <span class="font-medium">Hồ sơ cá nhân</span>
            </a>
        </nav>
    </aside>

    <!-- Main Content Area -->
    <main class="flex-1 overflow-y-auto pb-24 md:pb-8">
        <div class="max-w-2xl mx-auto p-6 md:p-8 space-y-8 mt-4 md:mt-0">
            
            <!-- Header (Back button + Title) -->
            <header class="flex items-center justify-between">
                <!-- Nút quay lại sẽ nhảy về trang profile -->
                <button onclick="window.location.href='profile'" class="flex items-center justify-center w-10 h-10 rounded-full hover:bg-gray-800 transition-colors text-white" aria-label="Quay lại">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                </button>
                <h1 class="text-xl md:text-2xl font-bold text-white tracking-wide">Quản lý xe</h1>
                <div class="w-10 h-10"></div> <!-- Spacer for perfect centering -->
            </header>

            <!-- Car List -->
            <section class="flex flex-col gap-4" aria-label="Danh sách xe">
                
                <!-- Car 1 (Default) -->
                <article class="flex items-center justify-between p-4 bg-gray-800 border-2 border-btn-primary rounded-2xl shadow-[0_0_15px_rgba(0,212,255,0.1)] transition-transform hover:-translate-y-1 cursor-pointer">
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 bg-btn-primary/10 rounded-xl flex items-center justify-center shrink-0">
                            <!-- Icon xe SVG -->
                            <svg class="w-6 h-6 text-btn-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h8M8 11h8m-9 4h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v6a2 2 0 002 2z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l-2 2v2a1 1 0 001 1h16a1 1 0 001-1v-2l-2-2"></path></svg>
                        </div>
                        <div class="flex flex-col items-start gap-1">
                            <h2 class="text-white font-bold text-lg md:text-xl leading-none">51H-123.45</h2>
                            <span class="inline-flex items-center justify-center px-2 py-0.5 rounded bg-btn-primary/20 text-btn-primary text-xs font-bold uppercase tracking-wider mt-1">
                                Mặc định
                            </span>
                        </div>
                    </div>
                    <div class="flex items-center gap-1 md:gap-3">
                        <button onclick="openCarModal('edit', '51H-123.45', true)" class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-gray-700 text-gray-400 hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-btn-primary" aria-label="Chỉnh sửa">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path></svg>
                        </button>
                        <button class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-red-500/20 text-gray-400 hover:text-red-500 transition-colors" aria-label="Xóa">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                        </button>
                    </div>
                </article>

                <!-- Car 2 -->
                <article class="flex items-center justify-between p-4 bg-gray-800 border-2 border-transparent hover:border-gray-600 rounded-2xl transition-transform hover:-translate-y-1 cursor-pointer">
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 bg-gray-700 rounded-xl flex items-center justify-center shrink-0">
                            <!-- Icon xe SVG -->
                            <svg class="w-6 h-6 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h8M8 11h8m-9 4h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v6a2 2 0 002 2z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l-2 2v2a1 1 0 001 1h16a1 1 0 001-1v-2l-2-2"></path></svg>
                        </div>
                        <div class="flex flex-col items-start gap-1">
                            <h2 class="text-gray-300 font-bold text-lg md:text-xl leading-none">51A-999.99</h2>
                        </div>
                    </div>
                    <div class="flex items-center gap-1 md:gap-3">
                        <button onclick="openCarModal('edit', '51A-999.99', false)" class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-gray-700 text-gray-400 hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-btn-primary" aria-label="Chỉnh sửa">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path></svg>
                        </button>
                        <button class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-red-500/20 text-gray-400 hover:text-red-500 transition-colors" aria-label="Xóa">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                        </button>
                    </div>
                </article>

            </section>

            <!-- Add Car Button -->
            <button type="button" onclick="openCarModal('add')" class="flex items-center justify-center gap-3 w-full p-4 mt-6 rounded-2xl border-2 border-dashed border-btn-primary/50 hover:border-btn-primary hover:bg-btn-primary/5 text-btn-primary transition-all font-bold text-base shadow-sm hover:shadow-[0_0_15px_rgba(0,212,255,0.1)] focus:outline-none focus:ring-2 focus:ring-btn-primary">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
                <span>Thêm xe mới</span>
            </button>
            
        </div>
    </main>

</div>
    <!-- Car Modal -->
    <div id="carModal" class="fixed inset-0 z-50 hidden items-center justify-center">
        <!-- Backdrop -->
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm transition-opacity" onclick="closeCarModal()"></div>
        
        <!-- Modal Content -->
        <div class="relative bg-[#1f2937] w-full max-w-md mx-4 rounded-2xl shadow-2xl border border-gray-700 overflow-hidden transform scale-95 opacity-0 transition-all duration-300" id="carModalContent">
            <!-- Header -->
            <div class="flex items-center justify-between p-5 border-b border-gray-800">
                <h3 class="text-xl font-bold text-white" id="carModalTitle">Thêm xe mới</h3>
                <button type="button" onclick="closeCarModal()" class="text-gray-400 hover:text-white hover:bg-gray-700 p-2 rounded-xl transition-colors focus:outline-none focus:ring-2 focus:ring-btn-primary">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                </button>
            </div>
            
            <!-- Body Form -->
            <form action="updateCar" method="POST" class="p-5 space-y-4">
                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium">Biển số xe</label>
                    <input type="text" id="modalPlate" name="plate" placeholder="VD: 51H-123.45" required 
                           class="w-full bg-gray-800 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all placeholder:text-gray-500 uppercase">
                </div>
                
                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium">Loại xe</label>
                    <select id="modalType" name="type" class="w-full bg-gray-800 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all appearance-none cursor-pointer">
                        <option value="sedan">Sedan (4 chỗ)</option>
                        <option value="suv">SUV (7 chỗ)</option>
                        <option value="hatchback">Hatchback</option>
                        <option value="pickup">Bán tải</option>
                    </select>
                </div>
                
                <div class="pt-2">
                    <label class="flex items-center gap-3 cursor-pointer group w-max">
                        <div class="relative flex items-center justify-center mt-0.5">
                            <input type="checkbox" id="modalDefault" name="isDefault" class="peer appearance-none w-5 h-5 border-2 border-gray-600 rounded bg-gray-800 checked:bg-btn-primary checked:border-btn-primary transition-colors cursor-pointer focus:outline-none focus:ring-2 focus:ring-btn-primary/50">
                            <svg class="absolute w-3 h-3 text-black opacity-0 peer-checked:opacity-100 pointer-events-none" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"></path></svg>
                        </div>
                        <span class="text-gray-300 text-sm font-medium select-none group-hover:text-white transition-colors">Đặt làm xe mặc định</span>
                    </label>
                </div>

                <!-- Footer / Actions -->
                <div class="pt-4 flex gap-3">
                    <button type="button" onclick="closeCarModal()" class="flex-1 px-4 py-3 rounded-xl border border-gray-600 text-white font-semibold hover:bg-gray-700 transition-colors focus:outline-none focus:ring-2 focus:ring-gray-500">
                        Hủy
                    </button>
                    <button type="submit" class="flex-1 px-4 py-3 rounded-xl bg-btn-primary text-black font-bold hover:bg-cyan-400 shadow-[0_4px_16px_rgba(0,212,255,0.2)] hover:shadow-[0_4px_20px_rgba(0,212,255,0.4)] transition-all focus:outline-none focus:ring-2 focus:ring-btn-primary focus:ring-offset-2 focus:ring-offset-gray-900">
                        Lưu thông tin
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal Scripts -->
    <script>
        const carModal = document.getElementById('carModal');
        const carModalContent = document.getElementById('carModalContent');
        const carModalTitle = document.getElementById('carModalTitle');
        const modalPlate = document.getElementById('modalPlate');
        const modalDefault = document.getElementById('modalDefault');

        function openCarModal(mode, plate = '', isDefault = false) {
            carModal.classList.remove('hidden');
            carModal.classList.add('flex');
            
            setTimeout(() => {
                carModalContent.classList.remove('scale-95', 'opacity-0');
                carModalContent.classList.add('scale-100', 'opacity-100');
            }, 10);

            if (mode === 'edit') {
                carModalTitle.textContent = 'Cập nhật thông tin xe';
                modalPlate.value = plate;
                modalDefault.checked = isDefault;
            } else {
                carModalTitle.textContent = 'Thêm xe mới';
                modalPlate.value = '';
                modalDefault.checked = false;
            }
        }

        function closeCarModal() {
            carModalContent.classList.remove('scale-100', 'opacity-100');
            carModalContent.classList.add('scale-95', 'opacity-0');
            
            setTimeout(() => {
                carModal.classList.remove('flex');
                carModal.classList.add('hidden');
            }, 300);
        }
    </script>
</body>
</html>
