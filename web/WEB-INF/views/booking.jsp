<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"/>
<meta charset="utf-8" />
<title>Auto Wash Pro - Đặt lịch dịch vụ</title>
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
        "card-bg": "#1f2937",
        "card-hover": "#374151"
      }
    }
  },
  plugins: []
}
</script>
<style>
    /* Hide scrollbar for Horizontal lists */
    .no-scrollbar::-webkit-scrollbar {
        display: none;
    }
    .no-scrollbar {
        -ms-overflow-style: none;
        scrollbar-width: none;
    }
</style>
</head>
<body class="m-0 min-h-screen bg-bg-primary text-white font-sans antialiased selection:bg-btn-primary selection:text-black w-full overflow-x-hidden">

    <!-- Desktop Sidebar -->
    <aside class="hidden md:flex flex-col w-64 border-r border-gray-800 bg-[#121826] fixed h-full z-10">
        <a href="home" class="p-6 flex items-center gap-3 hover:opacity-80 transition-opacity">
            <div class="w-10 h-10 bg-btn-primary rounded-xl flex items-center justify-center text-black font-bold text-xl">A</div>
            <span class="font-bold text-xl tracking-wider text-btn-primary">AUTOWASH</span>
        </a>
        
        <nav class="flex-1 px-4 py-4 space-y-2">
            <a href="dashboard" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
                <span class="font-medium">Trang chủ</span>
            </a>
            <a href="booking" class="flex items-center gap-3 px-4 py-3 bg-btn-primary/10 text-btn-primary rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                <span class="font-medium">Đặt lịch</span>
            </a>
            <a href="#" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v13m0-13V6a2 2 0 112 2h-2zm0 0V5.5A2.5 2.5 0 109.5 8H12zm-7 4h14M5 12a2 2 0 110-4h14a2 2 0 110 4M5 12v7a2 2 0 002 2h10a2 2 0 002-2v-7"></path></svg>
                <span class="font-medium">Ưu đãi</span>
            </a>
            <a href="profile" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                <span class="font-medium">Hồ sơ cá nhân</span>
            </a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 md:ml-64 relative min-h-screen pb-[120px] md:pb-32 bg-bg-primary">
        <!-- App Bar / Header -->
        <header class="sticky top-0 z-20 bg-bg-primary/80 backdrop-blur-md px-4 md:px-8 py-4 flex items-center gap-3 border-b border-btn-primary/20">
            <button onclick="history.back()" class="w-10 h-10 shrink-0 flex items-center justify-center hover:bg-gray-800/50 rounded-full transition-colors text-white" aria-label="Quay lại">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
            </button>
            <h1 class="text-lg md:text-xl font-bold truncate">Đặt lịch dịch vụ</h1>
        </header>

        <div class="px-4 md:px-8 py-6 max-w-2xl mx-auto space-y-8">
            
            <!-- Select Car -->
            <section class="space-y-3">
                <div class="flex items-center justify-between p-4 bg-card-bg rounded-xl border border-btn-primary/50 shadow-[0_4px_20px_rgba(0,212,255,0.05)]">
                    <div class="flex items-center gap-4">
                        <div class="w-10 h-10 flex items-center justify-center text-gray-300">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M8 7h8M8 11h8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>
                        </div>
                        <input type="text" value="51H-123.45" readonly class="bg-transparent text-btn-primary font-bold text-lg border-none outline-none w-28 p-0 cursor-default">
                    </div>
                    <button class="flex items-center gap-2 text-sm text-gray-400 hover:text-white transition-colors group">
                        Đổi xe
                        <svg class="w-4 h-4 text-gray-500 group-hover:text-white transition-colors" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M13 9l3 3m0 0l-3 3m3-3H8m13 0a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    </button>
                </div>
            </section>

            <!-- 1. Chọn Gói Dịch Vụ -->
            <section class="space-y-4">
                <h2 class="font-semibold text-lg">1. Chọn Gói Dịch Vụ</h2>
                <div class="space-y-3">
                    <!-- Standard Service (Unselected) -->
                    <label class="block relative cursor-pointer group">
                        <input type="radio" name="service" class="peer sr-only">
                        <div class="p-4 md:p-5 min-h-[80px] rounded-xl bg-card-bg border-2 border-transparent peer-checked:border-btn-primary peer-checked:bg-card-bg/80 transition-all shadow-md flex items-center justify-between gap-3">
                            <h3 class="font-medium text-sm md:text-base text-gray-300 peer-checked:text-white leading-snug">Rửa Bọt Tuyết Tiêu Chuẩn</h3>
                            <div class="font-bold text-sm md:text-[15px] whitespace-nowrap shrink-0">100.000 đ</div>
                        </div>
                    </label>

                    <!-- Premium Service (Selected) -->
                    <label class="block relative cursor-pointer group">
                        <input type="radio" name="service" class="peer sr-only" checked>
                        <div class="p-4 md:p-5 min-h-[80px] rounded-xl bg-card-bg border-2 border-transparent peer-checked:border-btn-primary peer-checked:bg-card-bg/80 transition-all shadow-md flex items-center justify-between gap-3">
                            <div class="flex flex-col gap-1.5">
                                <h3 class="font-medium text-sm md:text-base text-gray-300 peer-checked:text-white leading-snug">Rửa Ceramic Cấp Cao</h3>
                                <span class="bg-[#fbbf24] text-bg-primary text-[10px] md:text-[11px] font-bold px-2 py-0.5 rounded w-max">Khuyên dùng</span>
                            </div>
                            <div class="font-bold text-sm md:text-[15px] whitespace-nowrap shrink-0">350.000 đ</div>
                        </div>
                    </label>
                </div>
            </section>

            <!-- 2. Chọn Ngày & Giờ -->
            <section class="space-y-4">
                <h2 class="font-semibold text-lg">2. Chọn Ngày & Giờ</h2>
                
                <!-- Date Horizontal Scroll -->
                <div class="flex gap-3 overflow-x-auto no-scrollbar pb-2 snap-x">
                    <!-- Selected Date -->
                    <label class="cursor-pointer shrink-0 snap-start">
                        <input type="radio" name="date" class="peer sr-only" checked>
                        <div class="w-16 h-[72px] rounded-xl bg-card-bg border border-transparent peer-checked:bg-btn-primary peer-checked:text-black flex flex-col items-center justify-center gap-1.5 transition-all shadow-sm">
                            <span class="text-xs text-gray-400 peer-checked:text-black/80 font-medium">T2</span>
                            <span class="text-lg font-bold">25</span>
                        </div>
                    </label>
                    <!-- Unselected Dates -->
                    <label class="cursor-pointer shrink-0 snap-start">
                        <input type="radio" name="date" class="peer sr-only">
                        <div class="w-16 h-[72px] rounded-xl bg-card-bg border border-transparent peer-checked:bg-btn-primary peer-checked:text-black flex flex-col items-center justify-center gap-1.5 transition-all shadow-sm">
                            <span class="text-xs text-gray-400 peer-checked:text-black/80 font-medium">T3</span>
                            <span class="text-lg font-bold">26</span>
                        </div>
                    </label>
                    <label class="cursor-pointer shrink-0 snap-start">
                        <input type="radio" name="date" class="peer sr-only">
                        <div class="w-16 h-[72px] rounded-xl bg-card-bg border border-transparent peer-checked:bg-btn-primary peer-checked:text-black flex flex-col items-center justify-center gap-1.5 transition-all shadow-sm">
                            <span class="text-xs text-gray-400 peer-checked:text-black/80 font-medium">T4</span>
                            <span class="text-lg font-bold">27</span>
                        </div>
                    </label>
                    <label class="cursor-pointer shrink-0 snap-start">
                        <input type="radio" name="date" class="peer sr-only">
                        <div class="w-16 h-[72px] rounded-xl bg-card-bg border border-transparent peer-checked:bg-btn-primary peer-checked:text-black flex flex-col items-center justify-center gap-1.5 transition-all shadow-sm">
                            <span class="text-xs text-gray-400 peer-checked:text-black/80 font-medium">T5</span>
                            <span class="text-lg font-bold">28</span>
                        </div>
                    </label>
                    <label class="cursor-pointer shrink-0 snap-start hover:scale-105 active:scale-95 transition-transform">
                        <input type="radio" name="date" class="peer sr-only">
                        <div class="w-16 h-[72px] rounded-xl bg-card-bg border border-transparent peer-checked:bg-btn-primary peer-checked:text-black flex flex-col items-center justify-center gap-1.5 transition-all shadow-sm">
                            <span class="text-xs text-gray-400 peer-checked:text-black/80 font-medium">T6</span>
                            <span class="text-lg font-bold">29</span>
                        </div>
                    </label>
                    <label class="cursor-pointer shrink-0 snap-start hover:scale-105 active:scale-95 transition-transform">
                        <input type="radio" name="date" class="peer sr-only">
                        <div class="w-16 h-[72px] rounded-xl bg-card-bg border border-transparent peer-checked:bg-btn-primary peer-checked:text-black flex flex-col items-center justify-center gap-1.5 transition-all shadow-sm">
                            <span class="text-xs text-red-400/80 peer-checked:text-black/80 font-medium">T7</span>
                            <span class="text-lg font-bold text-red-400 peer-checked:text-black">30</span>
                        </div>
                    </label>
                    <label class="cursor-pointer shrink-0 snap-start hover:scale-105 active:scale-95 transition-transform">
                        <input type="radio" name="date" class="peer sr-only">
                        <div class="w-16 h-[72px] rounded-xl bg-card-bg border border-transparent peer-checked:bg-btn-primary peer-checked:text-black flex flex-col items-center justify-center gap-1.5 transition-all shadow-sm">
                            <span class="text-xs text-red-400/80 peer-checked:text-black/80 font-medium">CN</span>
                            <span class="text-lg font-bold text-red-400 peer-checked:text-black">31</span>
                        </div>
                    </label>
                </div>

                <!-- Time Slots Grid -->
                <div class="grid grid-cols-3 gap-3">
                    <label class="cursor-pointer hover:scale-105 active:scale-95 transition-transform group">
                        <input type="radio" name="time" class="peer sr-only" value="08:00">
                        <div class="h-10 rounded-lg bg-card-bg border border-transparent peer-checked:bg-btn-primary/10 peer-checked:border-btn-primary peer-checked:text-btn-primary peer-focus-visible:ring-2 peer-focus-visible:ring-btn-primary flex items-center justify-center transition-all shadow-sm group-hover:border-gray-500">
                            <span class="font-semibold text-sm">08:00</span>
                        </div>
                    </label>

                    <!-- Booked Slot 1 -->
                    <label class="cursor-not-allowed opacity-50 relative group" title="Khung giờ này đã có người đặt">
                        <input type="radio" name="time" class="peer sr-only" disabled>
                        <div class="h-10 rounded-lg bg-gray-800/50 border border-gray-700/50 text-gray-500 flex items-center justify-center transition-all overflow-hidden relative">
                            <!-- Đường gạch chéo chìm -->
                            <div class="absolute inset-0 w-full h-full opacity-30">
                                <svg class="w-full h-full text-red-500" preserveAspectRatio="none" viewBox="0 0 100 100">
                                    <line x1="0" y1="100" x2="100" y2="0" stroke="currentColor" stroke-width="1.5" />
                                </svg>
                            </div>
                            <span class="font-semibold text-sm relative z-10 decoration-red-500/50">09:00</span>
                        </div>
                    </label>

                    <label class="cursor-pointer hover:scale-105 active:scale-95 transition-transform group">
                        <input type="radio" name="time" class="peer sr-only" value="10:00" checked>
                        <div class="h-10 rounded-lg bg-card-bg border border-transparent peer-checked:bg-btn-primary/10 peer-checked:border-btn-primary peer-checked:text-btn-primary peer-focus-visible:ring-2 peer-focus-visible:ring-btn-primary flex items-center justify-center transition-all shadow-sm group-hover:border-gray-500">
                            <span class="font-semibold text-sm">10:00</span>
                        </div>
                    </label>

                    <label class="cursor-pointer hover:scale-105 active:scale-95 transition-transform group">
                        <input type="radio" name="time" class="peer sr-only" value="11:00">
                        <div class="h-10 rounded-lg bg-card-bg border border-transparent peer-checked:bg-btn-primary/10 peer-checked:border-btn-primary peer-checked:text-btn-primary peer-focus-visible:ring-2 peer-focus-visible:ring-btn-primary flex items-center justify-center transition-all shadow-sm group-hover:border-gray-500">
                            <span class="font-semibold text-sm">11:00</span>
                        </div>
                    </label>

                    <!-- Booked Slot 2 -->
                    <label class="cursor-not-allowed opacity-50 relative group" title="Khung giờ này đã có người đặt">
                        <input type="radio" name="time" class="peer sr-only" disabled>
                        <div class="h-10 rounded-lg bg-gray-800/50 border border-gray-700/50 text-gray-500 flex items-center justify-center transition-all overflow-hidden relative">
                            <!-- Đường gạch chéo chìm -->
                            <div class="absolute inset-0 w-full h-full opacity-30">
                                <svg class="w-full h-full text-red-500" preserveAspectRatio="none" viewBox="0 0 100 100">
                                    <line x1="0" y1="100" x2="100" y2="0" stroke="currentColor" stroke-width="1.5" />
                                </svg>
                            </div>
                            <span class="font-semibold text-sm relative z-10 decoration-red-500/50">13:00</span>
                        </div>
                    </label>

                    <label class="cursor-pointer hover:scale-105 active:scale-95 transition-transform group">
                        <input type="radio" name="time" class="peer sr-only" value="14:00">
                        <div class="h-10 rounded-lg bg-card-bg border border-transparent peer-checked:bg-btn-primary/10 peer-checked:border-btn-primary peer-checked:text-btn-primary peer-focus-visible:ring-2 peer-focus-visible:ring-btn-primary flex items-center justify-center transition-all shadow-sm group-hover:border-gray-500">
                            <span class="font-semibold text-sm">14:00</span>
                        </div>
                    </label>

                    <label class="cursor-pointer hover:scale-105 active:scale-95 transition-transform group">
                        <input type="radio" name="time" class="peer sr-only" value="15:00">
                        <div class="h-10 rounded-lg bg-card-bg border border-transparent peer-checked:bg-btn-primary/10 peer-checked:border-btn-primary peer-checked:text-btn-primary peer-focus-visible:ring-2 peer-focus-visible:ring-btn-primary flex items-center justify-center transition-all shadow-sm group-hover:border-gray-500">
                            <span class="font-semibold text-sm">15:00</span>
                        </div>
                    </label>

                    <label class="cursor-pointer hover:scale-105 active:scale-95 transition-transform group">
                        <input type="radio" name="time" class="peer sr-only" value="16:00">
                        <div class="h-10 rounded-lg bg-card-bg border border-transparent peer-checked:bg-btn-primary/10 peer-checked:border-btn-primary peer-checked:text-btn-primary peer-focus-visible:ring-2 peer-focus-visible:ring-btn-primary flex items-center justify-center transition-all shadow-sm group-hover:border-gray-500">
                            <span class="font-semibold text-sm">16:00</span>
                        </div>
                    </label>

                    <label class="cursor-pointer hover:scale-105 active:scale-95 transition-transform group">
                        <input type="radio" name="time" class="peer sr-only" value="17:00">
                        <div class="h-10 rounded-lg bg-card-bg border border-transparent peer-checked:bg-btn-primary/10 peer-checked:border-btn-primary peer-checked:text-btn-primary peer-focus-visible:ring-2 peer-focus-visible:ring-btn-primary flex items-center justify-center transition-all shadow-sm group-hover:border-gray-500">
                            <span class="font-semibold text-sm">17:00</span>
                        </div>
                    </label>
                </div>
            </section>

            <!-- Promo Code -->
            <section class="pt-4">
                <div class="flex items-center justify-between p-1.5 pl-4 bg-[#1a222c] rounded-lg border-none focus-within:ring-1 focus-within:ring-btn-primary transition-all">
                    <input type="text" placeholder="Nhập hoặc chọn mã..." class="bg-transparent border-none outline-none text-sm w-full text-white placeholder:text-gray-500 min-w-0">
                    <button class="px-4 py-2 text-btn-primary font-bold text-sm hover:opacity-80 transition-opacity whitespace-nowrap shrink-0">Áp dụng</button>
                </div>
            </section>
        </div>
    </main>

    <!-- Bottom Sticky Action Bar (Xác nhận) -->
    <div class="fixed bottom-0 left-0 md:left-64 right-0 bg-[#1e1e1e] shadow-[0_-4px_20px_rgba(0,0,0,0.4)] z-50 border-t border-gray-800/50">
        <div class="max-w-2xl mx-auto px-4 md:px-6 py-4 md:py-5 flex items-center justify-between gap-3" style="padding-bottom: calc(1rem + env(safe-area-inset-bottom));">
            <div class="flex flex-col gap-0.5 md:gap-1">
                <span class="text-xs md:text-[14px] text-gray-400">Tổng thanh toán</span>
                <span class="text-lg md:text-xl font-bold text-white">350.000 đ</span>
            </div>
            <button class="bg-btn-primary hover:bg-cyan-400 text-black font-bold px-6 h-12 md:h-[52px] min-w-[110px] md:min-w-[120px] rounded-xl shadow-[0_4px_16px_rgba(0,212,255,0.3)] transition-colors text-sm md:text-base flex items-center justify-center hover:scale-105 active:scale-95">
                XÁC NHẬN
            </button>
        </div>
    </div>

</body>
</html>
