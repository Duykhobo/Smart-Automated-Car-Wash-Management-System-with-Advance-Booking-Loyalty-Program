<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta charset="utf-8" />
<title>Auto Wash Pro - Hồ sơ cá nhân</title>
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
        <a href="${pageContext.request.contextPath}/home" class="p-6 flex items-center gap-3 hover:opacity-80 transition-opacity">
            <div class="w-10 h-10 bg-btn-primary rounded-xl flex items-center justify-center text-black font-bold text-xl">A</div>
            <span class="font-bold text-xl tracking-wider text-btn-primary">AUTOWASH</span>
        </a>
        
        <nav class="flex-1 px-4 py-4 space-y-2">
            <a href="${pageContext.request.contextPath}/account/dashboard" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                <span class="font-medium">Trang chủ</span>
            </a>
            <a href="${pageContext.request.contextPath}/bookings" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                <span class="font-medium">Đặt lịch</span>
            </a>
            <a href="#" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7"></path></svg>
                <span class="font-medium">Ưu đãi</span>
            </a>
            <a href="${pageContext.request.contextPath}/account/profile" class="flex items-center gap-3 px-4 py-3 bg-btn-primary/10 text-btn-primary rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                <span class="font-medium">Hồ sơ cá nhân</span>
            </a>
        </nav>
    </aside>

    <!-- Main Content Area -->
    <main class="flex-1 overflow-y-auto pb-24 md:pb-8">
        <div class="max-w-2xl mx-auto p-6 md:p-8 space-y-8 mt-4 md:mt-0">
            
            <!-- Profile Header -->
            <section class="flex flex-col items-center gap-4 text-center">
                <div class="relative group cursor-pointer">
                    <div class="w-24 h-24 md:w-32 md:h-32 rounded-full overflow-hidden border-4 border-gray-800 bg-gray-700 flex items-center justify-center transition-transform group-hover:scale-105 shadow-[0_0_20px_rgba(0,212,255,0.15)]">
                        <!-- Default Avatar Icon -->
                        <svg class="w-12 h-12 md:w-16 md:h-16 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path></svg>
                    </div>
                    <!-- Nút thay đổi ảnh đại diện (ẩn, hiện khi di chuột) -->
                    <div class="absolute inset-0 bg-black/50 rounded-full opacity-0 group-hover:opacity-100 flex items-center justify-center transition-opacity">
                        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
                    </div>
                </div>
                
                <div class="flex flex-col gap-1">
                    <h1 class="text-2xl md:text-3xl font-bold text-white tracking-tight">Nguyễn Văn A</h1>
                    <p class="text-gray-400 font-medium">0901234567</p>
                </div>

                <button onclick="openProfileModal()" class="flex items-center gap-2 px-5 py-2 mt-2 bg-gray-800 hover:bg-gray-700 border border-gray-700 rounded-full transition-colors text-btn-primary font-semibold text-sm focus:outline-none focus:ring-2 focus:ring-btn-primary">
                    <span>Chỉnh sửa hồ sơ</span>
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path></svg>
                </button>
            </section>

            <!-- Stats -->
            <section class="grid grid-cols-2 gap-4" aria-label="Thống kê tài khoản">
                <article class="flex flex-col items-center justify-center p-5 bg-[#1a222c] border border-gray-800 rounded-2xl shadow-lg">
                    <p class="text-gray-400 text-xs md:text-sm mb-1">Tổng chi tiêu</p>
                    <p class="text-white text-xl md:text-2xl font-bold">3.500.000đ</p>
                </article>
                <article class="flex flex-col items-center justify-center p-5 bg-[#1a222c] border border-gray-800 rounded-2xl shadow-lg">
                    <p class="text-gray-400 text-xs md:text-sm mb-1">Số lần rửa</p>
                    <p class="text-white text-xl md:text-2xl font-bold">15 <span class="text-base font-normal">lần</span></p>
                </article>
            </section>

            <!-- Actions List -->
            <section class="flex flex-col gap-3" aria-label="Danh sách chức năng">
                <nav class="flex flex-col gap-3" aria-label="Điều hướng hồ sơ">
                    <a href="${pageContext.request.contextPath}/vehicles" class="flex items-center justify-between p-4 bg-gray-800 hover:bg-gray-700 border border-transparent hover:border-gray-600 rounded-2xl transition-all group shadow-md">
                        <div class="flex items-center gap-4">
                            <div class="w-10 h-10 bg-gray-700 rounded-xl flex items-center justify-center group-hover:bg-btn-primary/20 transition-colors">
                                <svg class="w-5 h-5 text-gray-300 group-hover:text-btn-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z"></path></svg>
                            </div>
                            <span class="font-semibold text-white text-base">Quản lý xe</span>
                        </div>
                        <svg class="w-5 h-5 text-gray-500 group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
                    </a>

                    <a href="#" class="flex items-center justify-between p-4 bg-gray-800 hover:bg-gray-700 border border-transparent hover:border-gray-600 rounded-2xl transition-all group shadow-md">
                        <div class="flex items-center gap-4">
                            <div class="w-10 h-10 bg-gray-700 rounded-xl flex items-center justify-center group-hover:bg-btn-primary/20 transition-colors">
                                <svg class="w-5 h-5 text-gray-300 group-hover:text-btn-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path></svg>
                            </div>
                            <span class="font-semibold text-white text-base">Lịch sử giao dịch</span>
                        </div>
                        <svg class="w-5 h-5 text-gray-500 group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
                    </a>

                    <a href="#" class="flex items-center justify-between p-4 bg-gray-800 hover:bg-gray-700 border border-transparent hover:border-gray-600 rounded-2xl transition-all group shadow-md">
                        <div class="flex items-center gap-4">
                            <div class="w-10 h-10 bg-gray-700 rounded-xl flex items-center justify-center group-hover:bg-btn-primary/20 transition-colors">
                                <svg class="w-5 h-5 text-gray-300 group-hover:text-btn-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path></svg>
                            </div>
                            <span class="font-semibold text-white text-base">Phương thức thanh toán</span>
                        </div>
                        <svg class="w-5 h-5 text-gray-500 group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
                    </a>

                    <a href="#" class="flex items-center justify-between p-4 bg-gray-800 hover:bg-gray-700 border border-transparent hover:border-gray-600 rounded-2xl transition-all group shadow-md">
                        <div class="flex items-center gap-4">
                            <div class="w-10 h-10 bg-gray-700 rounded-xl flex items-center justify-center group-hover:bg-btn-primary/20 transition-colors">
                                <svg class="w-5 h-5 text-gray-300 group-hover:text-btn-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
                            </div>
                            <span class="font-semibold text-white text-base">Cài đặt</span>
                        </div>
                        <svg class="w-5 h-5 text-gray-500 group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
                    </a>
                </nav>

                <form action="${pageContext.request.contextPath}/auth/logout" method="post" class="mt-4">
                    <button type="submit" class="flex items-center justify-center gap-3 w-full p-4 rounded-2xl border-2 border-dashed border-red-500/50 hover:border-red-500 text-red-500 hover:bg-red-500/10 transition-all font-bold text-base shadow-md">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path></svg>
                        <span>Đăng xuất</span>
                    </button>
                </form>
            </section>
        </div>
    </main>

    <!-- Mobile Bottom Navigation (Chỉ hiện trên điện thoại, ẩn trên máy tính) -->
    <nav class="md:hidden fixed bottom-0 left-0 w-full bg-gray-900 border-t border-gray-800 z-50 px-2 py-2" style="padding-bottom: env(safe-area-inset-bottom);" aria-label="Điều hướng chính Mobile">
        <div class="flex justify-around items-center h-14">
            <a href="${pageContext.request.contextPath}/account/dashboard" class="flex flex-col items-center gap-1 w-16 text-gray-400 hover:text-white transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                <span class="text-[10px] font-medium">Trang chủ</span>
            </a>
            <a href="${pageContext.request.contextPath}/bookings" class="flex flex-col items-center gap-1 w-16 text-gray-400 hover:text-white transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                <span class="text-[10px] font-medium">Đặt lịch</span>
            </a>
            <a href="#" class="flex flex-col items-center gap-1 w-16 text-gray-400 hover:text-white transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7"></path></svg>
                <span class="text-[10px] font-medium">Ưu đãi</span>
            </a>
            <a href="${pageContext.request.contextPath}/account/profile" class="flex flex-col items-center gap-1 w-16 text-btn-primary">
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path></svg>
                <span class="text-[10px] font-medium">Hồ sơ</span>
            </a>
        </div>
    </nav>

</div>
    <!-- Profile Edit Modal -->
    <div id="profileModal" class="fixed inset-0 z-[60] hidden items-center justify-center">
        <!-- Backdrop -->
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm transition-opacity" onclick="closeProfileModal()"></div>
        
        <!-- Modal Content -->
        <div class="relative bg-[#1f2937] w-full max-w-md mx-4 rounded-2xl shadow-2xl border border-gray-700 overflow-hidden transform scale-95 opacity-0 transition-all duration-300" id="profileModalContent">
            <!-- Header -->
            <div class="flex items-center justify-between p-5 border-b border-gray-800">
                <h3 class="text-xl font-bold text-white">Cập nhật hồ sơ cá nhân</h3>
                <button type="button" onclick="closeProfileModal()" class="text-gray-400 hover:text-white hover:bg-gray-700 p-2 rounded-xl transition-colors focus:outline-none focus:ring-2 focus:ring-btn-primary">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                </button>
            </div>
            
            <!-- Body Form -->
            <form action="updateProfile" method="POST" class="p-5 space-y-4">
                
                <!-- Avatar Upload (Mock) -->
                <div class="flex flex-col items-center gap-3 mb-6">
                    <div class="w-20 h-20 rounded-full border-2 border-dashed border-gray-600 flex items-center justify-center bg-gray-800 hover:border-btn-primary hover:text-btn-primary transition-colors cursor-pointer group focus-within:ring-2 focus-within:ring-btn-primary" tabindex="0">
                        <svg class="w-8 h-8 text-gray-500 group-hover:text-btn-primary transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
                    </div>
                    <span class="text-xs text-gray-400">Nhấn để thay đổi ảnh</span>
                </div>

                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium">Họ và Tên</label>
                    <input type="text" name="fullname" value="Nguyễn Văn A" required 
                           class="w-full bg-gray-800 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all">
                </div>
                
                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium">Số điện thoại</label>
                    <input type="tel" name="phone" value="0901234567" required readonly
                           class="w-full bg-gray-800 border border-gray-700 text-gray-400 rounded-xl px-4 py-3 focus:outline-none cursor-not-allowed opacity-70" title="Không thể thay đổi số điện thoại">
                </div>
                
                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium">Email (Tùy chọn)</label>
                    <input type="email" name="email" placeholder="Nhập email..." 
                           class="w-full bg-gray-800 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all placeholder:text-gray-500">
                </div>

                <!-- Footer / Actions -->
                <div class="pt-4 flex gap-3">
                    <button type="button" onclick="closeProfileModal()" class="flex-1 px-4 py-3 rounded-xl border border-gray-600 text-white font-semibold hover:bg-gray-700 transition-colors focus:outline-none focus:ring-2 focus:ring-gray-500">
                        Hủy
                    </button>
                    <button type="submit" class="flex-1 px-4 py-3 rounded-xl bg-btn-primary text-black font-bold hover:bg-cyan-400 shadow-[0_4px_16px_rgba(0,212,255,0.2)] hover:shadow-[0_4px_20px_rgba(0,212,255,0.4)] transition-all focus:outline-none focus:ring-2 focus:ring-btn-primary focus:ring-offset-2 focus:ring-offset-gray-900">
                        Lưu thay đổi
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const profileModal = document.getElementById('profileModal');
        const profileModalContent = document.getElementById('profileModalContent');

        function openProfileModal() {
            profileModal.classList.remove('hidden');
            profileModal.classList.add('flex');
            
            setTimeout(() => {
                profileModalContent.classList.remove('scale-95', 'opacity-0');
                profileModalContent.classList.add('scale-100', 'opacity-100');
            }, 10);
        }

        function closeProfileModal() {
            profileModalContent.classList.remove('scale-100', 'opacity-100');
            profileModalContent.classList.add('scale-95', 'opacity-0');
            
            setTimeout(() => {
                profileModal.classList.remove('flex');
                profileModal.classList.add('hidden');
            }, 300);
        }
    </script>
</body>
</html>
