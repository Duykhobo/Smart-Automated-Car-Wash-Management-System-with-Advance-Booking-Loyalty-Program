<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta charset="utf-8" />
<title>Autowash Pro</title>
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
        "bg-primary": "var(--bg-primary)",
        "btn-primary": "var(--btn-primary)",
        "error": "var(--error)"
      }
    }
  },
  plugins: []
}
</script>
<style>
  /* Hide scrollbar for horizontal scroll on mobile */
  .hide-scrollbar::-webkit-scrollbar { display: none; }
  .hide-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
</style>
</head>
<body class="bg-[#0b0f1a] text-white">

<main class="flex min-h-screen flex-col items-center justify-start relative w-full overflow-x-hidden">

<!-- Hero Section -->
<section aria-labelledby="hero-title" class="flex w-full flex-col items-center justify-end px-6 py-20 md:py-32 relative min-h-[480px] md:min-h-[600px] bg-cover bg-center" style="background-image: url('https://images.unsplash.com/photo-1601362840469-51e4d8d58785?auto=format&fit=crop&q=80');">
    <!-- Gradient Overlay -->
    <div class="absolute inset-0 bg-gradient-to-t from-[#0b0f1a] via-[#0b0f1a]/80 to-transparent"></div>
    
    <div class="relative z-10 flex w-full max-w-5xl flex-col items-center text-center gap-6">
        <div class="flex flex-col items-center md:items-center gap-4 w-full">
            <p class="font-sans font-bold text-[#00d4ff] text-xs md:text-sm tracking-widest uppercase">AUTOWASH PRO</p>
            <h1 id="hero-title" class="font-sans font-bold text-white text-3xl md:text-5xl lg:text-6xl leading-tight md:leading-tight">
                Trải nghiệm rửa xe chuẩn VIP<br class="hidden md:block"/> Không chờ đợi
            </h1>
            <p class="font-sans font-semibold text-gray-300 text-sm md:text-lg max-w-2xl mt-2 drop-shadow-md">
                Đặt lịch thông minh, tích điểm đổi quà và tận hưởng đặc quyền.
            </p>
        </div>
        
        <div class="flex flex-col sm:flex-row w-full max-w-md items-center justify-center gap-4 mt-4">
            <button onclick="window.location.href='${pageContext.request.contextPath}/auth/register'" type="button" class="flex h-14 items-center justify-center gap-2.5 px-8 w-full sm:w-auto bg-[#00d4ff] hover:bg-cyan-400 rounded-xl shadow-[0px_4px_24px_#00d4ff66] font-sans font-semibold text-base text-[#121826] transition-all hover:scale-105 active:scale-95 focus:outline-none focus:ring-2 focus:ring-btn-primary focus:ring-offset-2 focus:ring-offset-[#0b0f1a]">
                Đăng ký ngay
            </button>
            <button onclick="window.location.href='${pageContext.request.contextPath}/auth/login'" type="button" class="flex h-14 items-center justify-center gap-2.5 px-8 w-full sm:w-auto rounded-xl border border-solid border-gray-600 hover:bg-white/10 hover:border-gray-400 font-sans font-semibold text-base text-white bg-transparent transition-all hover:scale-105 active:scale-95 focus:outline-none focus:ring-2 focus:ring-white/50 focus:ring-offset-2 focus:ring-offset-[#0b0f1a]">
                Đăng nhập
            </button>
        </div>
    </div>
</section>

<!-- Dịch vụ nổi bật Section -->
<section aria-labelledby="featured-services-title" class="flex w-full flex-col items-center gap-8 py-16 md:py-24 bg-gray-800">
    <div class="w-full max-w-6xl px-6 text-center md:text-left">
        <h2 id="featured-services-title" class="font-sans font-bold text-white text-2xl md:text-3xl">
            Dịch vụ nổi bật
        </h2>
    </div>
    
    <div class="w-full max-w-6xl px-6 flex md:grid md:grid-cols-3 gap-6 overflow-x-auto md:overflow-visible hide-scrollbar snap-x snap-mandatory" aria-label="Danh sách dịch vụ nổi bật">
        <!-- Card 1 -->
        <article class="flex flex-col min-w-[280px] md:min-w-0 w-full items-start justify-center gap-5 p-6 md:p-8 bg-gray-800 rounded-2xl border border-solid border-gray-700 snap-start hover:border-gray-500 transition-colors">
            <div class="flex items-center justify-between w-full gap-4">
                <h3 class="font-sans font-normal text-white text-lg md:text-xl">Rửa Bọt Tuyết<br>Tiêu Chuẩn</h3>
                <p class="font-sans font-bold text-[#00d4ff] text-lg whitespace-nowrap">100.000 vnđ</p>
            </div>
            <ul class="flex flex-col gap-3 w-full">
                <li class="flex items-center gap-2"><span class="font-sans font-medium text-gray-300 text-sm md:text-base">✓ Xịt gầm</span></li>
                <li class="flex items-center gap-2"><span class="font-sans font-medium text-gray-300 text-sm md:text-base">✓ Rửa bọt tuyết</span></li>
                <li class="flex items-center gap-2"><span class="font-sans font-medium text-gray-300 text-sm md:text-base">✓ Hút bụi</span></li>
            </ul>
        </article>
        
        <!-- Card 2 -->
        <article class="flex flex-col min-w-[280px] md:min-w-0 w-full items-start justify-center gap-5 p-6 md:p-8 bg-gray-800 rounded-2xl border border-solid border-gray-700 snap-start hover:border-gray-500 transition-colors">
            <div class="flex items-center justify-between w-full gap-4">
                <h3 class="font-sans font-normal text-white text-lg md:text-xl">Vệ sinh<br>nội thất</h3>
                <p class="font-sans font-bold text-[#00d4ff] text-lg whitespace-nowrap">150.000 vnđ</p>
            </div>
            <ul class="flex flex-col gap-3 w-full">
                <li class="flex items-center gap-2"><span class="font-sans font-medium text-gray-300 text-sm md:text-base">✓ Xịt gầm</span></li>
                <li class="flex items-center gap-2"><span class="font-sans font-medium text-gray-300 text-sm md:text-base">✓ Rửa bọt tuyết</span></li>
                <li class="flex items-center gap-2"><span class="font-sans font-medium text-gray-300 text-sm md:text-base">✓ Hút bụi</span></li>
            </ul>
        </article>

        <!-- Card 3 -->
        <article class="flex flex-col min-w-[280px] md:min-w-0 w-full items-start justify-center gap-5 p-6 md:p-8 bg-gray-800 rounded-2xl border border-solid border-amber-400 snap-start shadow-[0px_0px_20px_rgba(251,191,36,0.1)] hover:shadow-[0px_0px_30px_rgba(251,191,36,0.2)] transition-shadow">
            <div class="flex items-center justify-between w-full gap-4">
                <h3 class="font-sans font-normal text-white text-lg md:text-xl">Rửa Ceramic<br>Cấp Cao</h3>
                <p class="font-sans font-bold text-[#00d4ff] text-lg whitespace-nowrap">350.000 vnđ</p>
            </div>
            <ul class="flex flex-col gap-3 w-full">
                <li class="flex items-center gap-2"><span class="font-sans font-medium text-gray-300 text-sm md:text-base">✓ Xịt gầm</span></li>
                <li class="flex items-center gap-2"><span class="font-sans font-medium text-gray-300 text-sm md:text-base">✓ Rửa bọt tuyết</span></li>
                <li class="flex items-center gap-2"><span class="font-sans font-medium text-gray-300 text-sm md:text-base">✓ Hút bụi</span></li>
            </ul>
        </article>
    </div>
</section>

<!-- Đặc quyền thành viên Section -->
<section aria-labelledby="member-benefits-title" class="flex w-full flex-col items-center gap-8 py-16 md:py-24 bg-gray-800">
    <div class="w-full max-w-6xl px-6 text-center md:text-left">
        <h2 id="member-benefits-title" class="font-sans font-bold text-white text-2xl md:text-3xl">
            Đặc quyền thành viên
        </h2>
    </div>
    
    <div class="w-full max-w-6xl px-6 grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- Hạng Bạc -->
        <article class="flex items-center md:items-start gap-4 p-6 w-full bg-[#1a222c] rounded-2xl hover:-translate-y-1 transition-transform">
            <div class="w-14 h-14 rounded-xl overflow-hidden shadow-[0px_4px_16px_#94a3b84c] flex-shrink-0 bg-gradient-to-b from-slate-400 to-white flex items-center justify-center">
                <!-- SVG Icon Thay thế cho img/image.svg -->
                <svg class="w-7 h-7 text-gray-800" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
            </div>
            <div class="flex flex-col gap-2 flex-1">
                <h3 class="text-slate-200 font-sans font-bold text-lg">Hạng BẠC</h3>
                <p class="font-sans font-normal text-gray-400 text-sm leading-relaxed">
                    +10% Điểm<br>Đặt lịch trước 10 ngày
                </p>
            </div>
        </article>

        <!-- Hạng Vàng -->
        <article class="flex items-center md:items-start gap-4 p-6 w-full bg-[#1a222c] border border-amber-500/30 rounded-2xl hover:-translate-y-1 transition-transform">
            <div class="w-14 h-14 rounded-xl overflow-hidden shadow-[0px_4px_24px_#f59e0b66] flex-shrink-0 bg-gradient-to-b from-amber-600 to-amber-300 flex items-center justify-center">
                <svg class="w-7 h-7 text-amber-900" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
            </div>
            <div class="flex flex-col gap-2 flex-1">
                <h3 class="text-amber-400 font-sans font-bold text-lg">Hạng VÀNG</h3>
                <p class="font-sans font-normal text-gray-400 text-sm leading-relaxed">
                    +20% Điểm<br>Đặt lịch trước 12 ngày<br>Nâng cấp free
                </p>
            </div>
        </article>

        <!-- Hạng Bạch Kim -->
        <article class="flex items-center md:items-start gap-4 p-6 w-full bg-[#1a222c] border border-[#00d4ff]/30 rounded-2xl hover:-translate-y-1 transition-transform">
            <div class="w-14 h-14 rounded-xl overflow-hidden shadow-[0px_4px_32px_#00d4ff99] flex-shrink-0 bg-gradient-to-b from-[#00d4ff] to-white flex items-center justify-center">
                <svg class="w-7 h-7 text-cyan-900" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
            </div>
            <div class="flex flex-col gap-2 flex-1">
                <h3 class="text-[#00d4ff] font-sans font-bold text-lg">Hạng BẠCH KIM</h3>
                <p class="font-sans font-normal text-white text-sm leading-relaxed">
                    +30% Điểm<br>Đặt lịch trước 14 ngày<br>Tặng 1 lần rửa/tháng
                </p>
            </div>
        </article>
    </div>
</section>

<!-- CTA Section -->
<section aria-labelledby="cta-title" class="flex w-full flex-col items-center justify-center py-20 px-6 bg-gray-800">
    <div class="flex flex-col items-center gap-8 px-8 py-12 md:py-16 w-full max-w-4xl rounded-[2rem] border border-solid border-slate-700 shadow-[0px_8px_32px_#00000080] bg-gradient-to-r from-slate-900 to-slate-800 text-center">
        <div class="flex flex-col items-center gap-4 w-full">
            <h2 id="cta-title" class="font-sans font-bold text-white text-2xl md:text-4xl">
                Sẵn sàng chăm sóc xế cưng?
            </h2>
            <p class="font-sans font-normal text-gray-400 text-base md:text-lg max-w-xl">
                Đăng ký tài khoản ngay hôm nay để nhận voucher giảm 20% cho lần rửa đầu tiên.
            </p>
        </div>
        
        <button onclick="window.location.href='${pageContext.request.contextPath}/auth/register'" type="button" class="flex h-14 md:h-16 items-center justify-center px-10 w-full sm:w-auto bg-[#00d4ff] hover:bg-cyan-400 hover:scale-105 active:scale-95 transition-all rounded-2xl shadow-[0px_4px_24px_#00d4ff66] focus:outline-none focus:ring-2 focus:ring-btn-primary focus:ring-offset-2 focus:ring-offset-gray-900">
            <span class="font-sans font-bold text-[#1e1e1e] text-base md:text-lg tracking-wide uppercase">
                TẠO TÀI KHOẢN MIỄN PHÍ
            </span>
        </button>
    </div>
</section>

</main>
</body>
</html>
