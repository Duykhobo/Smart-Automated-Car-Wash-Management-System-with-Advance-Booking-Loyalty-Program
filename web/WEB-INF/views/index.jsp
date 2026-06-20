<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <!-- Google Fonts (Vietnamese Supported) & Font Fallback -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <style>
            body,
            .font-sans {
                font-family: 'Inter', sans-serif !important;
            }

            .font-display {
                font-family: 'Be Vietnam Pro', sans-serif !important;
            }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta charset="UTF-8" />
        <title>Autowash Pro - Premium Car Wash</title>

        <!-- Global CSS & Tailwind Config -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css?v=4" />
        <script src="${pageContext.request.contextPath}/assets/js/tailwind-config.js?v=4"></script>
        <script src="https://cdn.tailwindcss.com"></script>

        <!-- Icons (Lucide) -->
        <script src="https://unpkg.com/lucide@latest"></script>

    </head>

    <body
        class="bg-bg-primary text-text-primary antialiased overflow-x-hidden selection:bg-[#00d4ff] selection:text-black">

        <!-- Floating Glass Navbar -->
        <nav
            class="fixed top-4 left-1/2 -translate-x-1/2 w-[95%] max-w-7xl z-50 glass-panel rounded-2xl px-6 py-4 flex items-center justify-between transition-all duration-300">
            <div class="flex items-center gap-2 cursor-pointer">
                <i data-lucide="droplets" class="text-[#00d4ff] w-8 h-8"></i>
                <span class="font-display font-bold text-xl tracking-wide text-white">AUTOWASH<span
                        class="text-[#00d4ff]">PRO</span></span>
            </div>

            <div class="hidden md:flex items-center gap-8">
                <a href="#services" class="text-text-muted hover:text-white transition-colors text-sm font-medium">Dịch
                    Vụ</a>
                <a href="#benefits" class="text-text-muted hover:text-white transition-colors text-sm font-medium">Đặc
                    Quyền</a>
                <a href="${pageContext.request.contextPath}/customer/loyalty"
                    class="text-text-muted hover:text-white transition-colors text-sm font-medium">Loyalty Program</a>
            </div>

            <div class="flex items-center gap-4">
                <a href="${pageContext.request.contextPath}/auth/login"
                    class="text-white hover:text-[#00d4ff] transition-colors text-sm font-medium hidden sm:block">Đăng
                    Nhập</a>
                <a href="${pageContext.request.contextPath}/auth/register"
                    class="btn-glow bg-[#00d4ff] text-black px-5 py-2.5 rounded-xl font-semibold text-sm">Đăng Ký
                    Ngay</a>
            </div>
        </nav>

        <main class="flex min-h-screen flex-col items-center justify-start relative w-full pt-20">

            <!-- Hero Section -->
            <section aria-labelledby="hero-title"
                class="flex w-full flex-col items-center justify-center px-6 py-32 md:py-48 relative min-h-[600px] md:min-h-[800px]">
                <!-- Background Image with Blur -->
                <div class="absolute inset-0 z-0">
                    <img src="https://images.unsplash.com/photo-1601362840469-51e4d8d58785?auto=format&fit=crop&q=80"
                        alt="Premium Car Wash" class="w-full h-full object-cover opacity-30" />
                    <div class="absolute inset-0 bg-gradient-to-t from-bg-primary via-bg-primary/80 to-transparent">
                    </div>
                    <div class="absolute inset-0 bg-gradient-to-b from-bg-primary via-transparent to-transparent"></div>
                </div>

                <!-- Hero Content -->
                <div class="relative z-10 flex w-full max-w-5xl flex-col items-center text-center gap-8 mt-10">
                    <div
                        class="inline-flex items-center gap-2 px-4 py-2 rounded-full border border-border-glass bg-bg-surface backdrop-blur-md mb-4 animate-pulse-slow">
                        <span class="w-2 h-2 rounded-full bg-[#00d4ff]"></span>
                        <span class="text-xs font-semibold tracking-widest text-[#00d4ff] uppercase">Công nghệ rửa xe
                            không chạm 5.0</span>
                    </div>

                    <h1 id="hero-title"
                        class="font-display font-bold text-transparent bg-clip-text bg-gradient-to-r from-white via-gray-200 to-gray-500 text-4xl md:text-6xl lg:text-7xl leading-tight md:leading-tight">
                        Trải Nghiệm Rửa Xe Chuẩn VIP <br /> <span class="text-[#00d4ff] glow-text">Không Chờ Đợi</span>
                    </h1>

                    <p class="font-sans font-normal text-text-muted text-base md:text-xl max-w-2xl leading-relaxed">
                        Hệ thống đặt lịch thông minh tích hợp Loyalty Program. Đặt lịch trước lên đến 14 ngày, tích
                        điểm đổi quà và tận hưởng đặc quyền ưu tiên.
                    </p>

                    <div class="flex flex-col sm:flex-row w-full max-w-md items-center justify-center gap-4 mt-8">
                        <a href="${pageContext.request.contextPath}/auth/register"
                            class="flex w-full sm:w-auto h-14 items-center justify-center gap-2 px-8 bg-[#00d4ff] hover:bg-cyan-400 text-black rounded-xl font-semibold text-base btn-glow">
                            Bắt Đầu Ngay <i data-lucide="arrow-right" class="w-5 h-5"></i>
                        </a>
                        <a href="#services"
                            class="flex w-full sm:w-auto h-14 items-center justify-center gap-2 px-8 bg-bg-surface hover:bg-bg-surface-hover border border-border-glass text-white rounded-xl font-semibold text-base transition-colors">
                            Xem Bảng Giá
                        </a>
                    </div>
                </div>

                <!-- Decorative Glow -->
                <div
                    class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-[#00d4ff]/10 rounded-full blur-[120px] -z-10">
                </div>
            </section>

            <!-- Dịch vụ nổi bật Section -->
            <section id="services" aria-labelledby="featured-services-title"
                class="flex w-full flex-col items-center gap-12 py-24 relative">
                <div class="w-full max-w-7xl px-6 flex flex-col md:flex-row justify-between items-end gap-6">
                    <div>
                        <p class="text-[#00d4ff] font-semibold text-sm tracking-widest uppercase mb-2">Bảng Giá</p>
                        <h2 id="featured-services-title" class="font-display font-bold text-white text-3xl md:text-5xl">
                            Dịch Vụ Nổi Bật</h2>
                    </div>
                    <p class="text-text-muted max-w-md text-sm md:text-base">Các gói dịch vụ được thiết kế tối ưu cho
                        từng loại xe, đảm bảo sạch sâu và bảo vệ lớp sơn.</p>
                </div>

                <div class="w-full max-w-7xl px-6 grid grid-cols-1 md:grid-cols-3 gap-6">
                    <!-- Card 1 -->
                    <article class="glass-panel p-8 rounded-3xl flex flex-col gap-6 group cursor-pointer">
                        <div class="flex justify-between items-start">
                            <div
                                class="p-3 bg-white/5 rounded-xl text-gray-300 group-hover:text-[#00d4ff] transition-colors">
                                <i data-lucide="car" class="w-8 h-8"></i>
                            </div>
                            <span class="text-text-muted text-sm font-medium">Bán chạy</span>
                        </div>
                        <div>
                            <h3 class="font-display font-bold text-2xl text-white mb-2">Rửa Bọt Tuyết</h3>
                            <p class="text-text-muted text-sm line-clamp-2">Rửa ngoài tiêu chuẩn, làm sạch sâu bụi bẩn
                                bằng bọt tuyết.</p>
                        </div>
                        <div class="text-3xl font-display font-bold text-[#00d4ff]">100.000<span
                                class="text-base text-text-muted font-sans font-normal">VND</span></div>
                        <ul class="flex flex-col gap-3 mt-4 border-t border-border-glass pt-6">
                            <li class="flex items-center gap-3 text-sm text-gray-300"><i data-lucide="check"
                                    class="w-4 h-4 text-success"></i> Xịt gầm</li>
                            <li class="flex items-center gap-3 text-sm text-gray-300"><i data-lucide="check"
                                    class="w-4 h-4 text-success"></i> Rửa bọt tuyết</li>
                            <li class="flex items-center gap-3 text-sm text-gray-300"><i data-lucide="check"
                                    class="w-4 h-4 text-success"></i> Lau khô vi sợi</li>
                        </ul>
                    </article>

                    <!-- Card 2 -->
                    <article
                        class="glass-panel p-8 rounded-3xl flex flex-col gap-6 group cursor-pointer relative overflow-hidden border-[#00d4ff]/30">
                        <div
                            class="absolute top-0 right-0 bg-[#00d4ff] text-black text-xs font-bold px-3 py-1 rounded-bl-xl z-10">
                            RECOMMENDED</div>
                        <div
                            class="absolute inset-0 bg-gradient-to-b from-accent-cyan/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity">
                        </div>
                        <div class="flex justify-between items-start relative z-10">
                            <div class="p-3 bg-[#00d4ff]/10 rounded-xl text-[#00d4ff]">
                                <i data-lucide="sparkles" class="w-8 h-8"></i>
                            </div>
                        </div>
                        <div class="relative z-10">
                            <h3 class="font-display font-bold text-2xl text-white mb-2">Vệ Sinh Nội Thất</h3>
                            <p class="text-text-muted text-sm line-clamp-2">Kết hợp rửa ngoài và hút bụi, lau chùi chi
                                tiết không gian bên trong.</p>
                        </div>
                        <div class="text-3xl font-display font-bold text-[#00d4ff] relative z-10">150.000<span
                                class="text-base text-text-muted font-sans font-normal">VND</span></div>
                        <ul class="flex flex-col gap-3 mt-4 border-t border-border-glass pt-6 relative z-10">
                            <li class="flex items-center gap-3 text-sm text-gray-300"><i data-lucide="check"
                                    class="w-4 h-4 text-success"></i> Bao gồm Rửa Bọt Tuyết</li>
                            <li class="flex items-center gap-3 text-sm text-gray-300"><i data-lucide="check"
                                    class="w-4 h-4 text-success"></i> Hút bụi toàn diện</li>
                            <li class="flex items-center gap-3 text-sm text-gray-300"><i data-lucide="check"
                                    class="w-4 h-4 text-success"></i> Lau dưỡng nhựa/da</li>
                        </ul>
                    </article>

                    <!-- Card 3 -->
                    <article class="glass-panel p-8 rounded-3xl flex flex-col gap-6 group cursor-pointer">
                        <div class="flex justify-between items-start">
                            <div
                                class="p-3 bg-white/5 rounded-xl text-gray-300 group-hover:text-amber-400 transition-colors">
                                <i data-lucide="shield" class="w-8 h-8"></i>
                            </div>
                        </div>
                        <div>
                            <h3 class="font-display font-bold text-2xl text-white mb-2">Phủ Ceramic Cao Cấp</h3>
                            <p class="text-text-muted text-sm line-clamp-2">Bảo vệ lớp sơn, chống bám nước và duy trì độ
                                bóng tối đa.</p>
                        </div>
                        <div class="text-3xl font-display font-bold text-amber-400">350.000<span
                                class="text-base text-text-muted font-sans font-normal">VND</span></div>
                        <ul class="flex flex-col gap-3 mt-4 border-t border-border-glass pt-6">
                            <li class="flex items-center gap-3 text-sm text-gray-300"><i data-lucide="check"
                                    class="w-4 h-4 text-amber-400"></i> Bao gồm Vệ Sinh Nội Thất</li>
                            <li class="flex items-center gap-3 text-sm text-gray-300"><i data-lucide="check"
                                    class="w-4 h-4 text-amber-400"></i> Tẩy ố sơn xe</li>
                            <li class="flex items-center gap-3 text-sm text-gray-300"><i data-lucide="check"
                                    class="w-4 h-4 text-amber-400"></i> Phủ Ceramic bảo vệ</li>
                        </ul>
                    </article>
                </div>
            </section>

            <!-- Đặc quyền thành viên Section -->
            <section id="benefits" aria-labelledby="member-benefits-title"
                class="flex w-full flex-col items-center gap-12 py-24 bg-gradient-to-b from-transparent to-[#0a0f1a] relative">
                <!-- Grid pattern background -->
                <div
                    class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGRlZnM+PHBhdHRlcm4gaWQ9ImdyaWQiIHdpZHRoPSI0MCIgaGVpZ2h0PSI0MCIgcGF0dGVyblVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHBhdGggZD0iTSAwIDEwIEwgNDAgMTAgTSAxMCAwIEwgMTAgNDAiIGZpbGw9Im5vbmUiIHN0cm9rZT0icmdiYSgyNTUsIDI1NSwgMjU1LCAwLjAyKSIgc3Ryb2tlLXdpZHRoPSIxIi8+PC9wYXR0ZXJuPjwvZGVmcz48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ1cmwoI2dyaWQpIi8+PC9zdmc+')] z-0">
                </div>

                <div class="w-full max-w-7xl px-6 text-center relative z-10 flex flex-col items-center">
                    <div class="inline-flex items-center justify-center p-3 bg-white/5 rounded-2xl mb-6">
                        <i data-lucide="award" class="w-8 h-8 text-[#00d4ff]"></i>
                    </div>
                    <h2 id="member-benefits-title" class="font-display font-bold text-white text-3xl md:text-5xl mb-4">
                        Đặc Quyền Hội Viên Loyalty
                    </h2>
                    <p class="text-text-muted max-w-2xl text-base md:text-lg">
                        Tích lũy điểm sau mỗi lần rửa xe để thăng hạng và mở khóa các đặc quyền đặt lịch trước và ưu
                        tiên phục vụ.
                    </p>
                </div>

                <div class="w-full max-w-7xl px-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 relative z-10">
                    <!-- Hạng Member -->
                    <article class="glass-panel p-6 rounded-2xl hover:-translate-y-2 transition-transform duration-300">
                        <div
                            class="w-12 h-12 rounded-xl bg-slate-800 flex items-center justify-center mb-4 border border-slate-600 shadow-[0_0_15px_rgba(71,85,105,0.3)]">
                            <i data-lucide="user" class="w-6 h-6 text-slate-300"></i>
                        </div>
                        <h3 class="text-slate-300 font-display font-bold text-xl mb-2">Member</h3>
                        <p class="text-sm text-text-muted mb-4 border-b border-border-glass pb-4">Thành viên mới đăng
                            ký.</p>
                        <ul class="flex flex-col gap-2">
                            <li class="flex items-start gap-2 text-sm text-gray-300"><i data-lucide="calendar-clock"
                                    class="w-4 h-4 mt-0.5 text-[#3b82f6]"></i> Đặt trước <b>7 ngày</b></li>
                            <li class="flex items-start gap-2 text-sm text-gray-300"><i data-lucide="coins"
                                    class="w-4 h-4 mt-0.5 text-[#3b82f6]"></i> Tích lũy 1x điểm</li>
                        </ul>
                    </article>

                    <!-- Hạng Silver -->
                    <article class="glass-panel p-6 rounded-2xl hover:-translate-y-2 transition-transform duration-300">
                        <div
                            class="w-12 h-12 rounded-xl bg-gradient-to-br from-slate-400 to-slate-200 flex items-center justify-center mb-4 shadow-[0_0_15px_rgba(148,163,184,0.4)]">
                            <i data-lucide="shield" class="w-6 h-6 text-slate-800"></i>
                        </div>
                        <h3 class="text-slate-200 font-display font-bold text-xl mb-2">Silver</h3>
                        <p class="text-sm text-text-muted mb-4 border-b border-border-glass pb-4">Đạt 1000 điểm tích
                            lũy.</p>
                        <ul class="flex flex-col gap-2">
                            <li class="flex items-start gap-2 text-sm text-gray-300"><i data-lucide="calendar-clock"
                                    class="w-4 h-4 mt-0.5 text-[#3b82f6]"></i> Đặt trước <b>10 ngày</b></li>
                            <li class="flex items-start gap-2 text-sm text-gray-300"><i data-lucide="coins"
                                    class="w-4 h-4 mt-0.5 text-[#3b82f6]"></i> Tích lũy 1.1x điểm</li>
                            <li class="flex items-start gap-2 text-sm text-gray-300"><i data-lucide="zap"
                                    class="w-4 h-4 mt-0.5 text-[#3b82f6]"></i> Ưu tiên xếp hàng mức 1</li>
                        </ul>
                    </article>

                    <!-- Hạng Gold -->
                    <article
                        class="glass-panel p-6 rounded-2xl border-amber-500/30 hover:-translate-y-2 transition-transform duration-300 relative overflow-hidden">
                        <div class="absolute -right-4 -top-4 w-24 h-24 bg-amber-500/10 rounded-full blur-2xl"></div>
                        <div
                            class="w-12 h-12 rounded-xl bg-gradient-to-br from-amber-300 to-amber-600 flex items-center justify-center mb-4 shadow-[0_0_20px_rgba(245,158,11,0.5)]">
                            <i data-lucide="star" class="w-6 h-6 text-amber-900"></i>
                        </div>
                        <h3 class="text-amber-400 font-display font-bold text-xl mb-2">Gold</h3>
                        <p class="text-sm text-text-muted mb-4 border-b border-border-glass pb-4">Đạt 3000 điểm tích
                            lũy.</p>
                        <ul class="flex flex-col gap-2 relative z-10">
                            <li class="flex items-start gap-2 text-sm text-gray-300"><i data-lucide="calendar-clock"
                                    class="w-4 h-4 mt-0.5 text-amber-500"></i> Đặt trước <b>12 ngày</b></li>
                            <li class="flex items-start gap-2 text-sm text-gray-300"><i data-lucide="coins"
                                    class="w-4 h-4 mt-0.5 text-amber-500"></i> Tích lũy 1.2x điểm</li>
                            <li class="flex items-start gap-2 text-sm text-gray-300"><i data-lucide="zap"
                                    class="w-4 h-4 mt-0.5 text-amber-500"></i> Ưu tiên xếp hàng mức 2</li>
                            <li class="flex items-start gap-2 text-sm text-gray-300"><i data-lucide="gift"
                                    class="w-4 h-4 mt-0.5 text-amber-500"></i> Tặng 1 lần hút bụi/tháng</li>
                        </ul>
                    </article>

                    <!-- Hạng Platinum -->
                    <article
                        class="glass-panel p-6 rounded-2xl border-[#00d4ff]/40 hover:-translate-y-2 transition-transform duration-300 relative overflow-hidden">
                        <div class="absolute -right-4 -top-4 w-24 h-24 bg-[#00d4ff]/20 rounded-full blur-2xl"></div>
                        <div
                            class="w-12 h-12 rounded-xl bg-gradient-to-br from-cyan-300 to-accent-cyan flex items-center justify-center mb-4 shadow-[0_0_25px_rgba(0,212,255,0.6)]">
                            <i data-lucide="crown" class="w-6 h-6 text-cyan-900"></i>
                        </div>
                        <h3 class="text-[#00d4ff] font-display font-bold text-xl mb-2">Platinum</h3>
                        <p class="text-sm text-text-muted mb-4 border-b border-border-glass pb-4">Đạt 8000 điểm tích
                            lũy.</p>
                        <ul class="flex flex-col gap-2 relative z-10">
                            <li class="flex items-start gap-2 text-sm text-white font-medium"><i
                                    data-lucide="calendar-clock" class="w-4 h-4 mt-0.5 text-[#00d4ff]"></i> Đặt trước
                                <b>14 ngày</b>
                            </li>
                            <li class="flex items-start gap-2 text-sm text-white"><i data-lucide="coins"
                                    class="w-4 h-4 mt-0.5 text-[#00d4ff]"></i> Tích lũy 1.3x điểm</li>
                            <li class="flex items-start gap-2 text-sm text-white font-medium"><i data-lucide="zap"
                                    class="w-4 h-4 mt-0.5 text-[#00d4ff]"></i> <b>Slot Ưu Tiên Cao Nhất</b></li>
                            <li class="flex items-start gap-2 text-sm text-white"><i data-lucide="gift"
                                    class="w-4 h-4 mt-0.5 text-[#00d4ff]"></i> Tặng 1 lần rửa VIP/tháng</li>
                        </ul>
                    </article>
                </div>
            </section>

            <!-- CTA Section -->
            <section aria-labelledby="cta-title"
                class="flex w-full flex-col items-center justify-center py-24 px-6 relative">
                <div
                    class="flex flex-col items-center gap-8 px-8 py-16 w-full max-w-5xl rounded-[2.5rem] border border-[#00d4ff]/20 bg-gradient-to-br from-[#0c1424] to-[#070b14] text-center relative overflow-hidden">
                    <!-- Glow effects -->
                    <div
                        class="absolute top-0 left-1/2 -translate-x-1/2 w-[80%] h-[1px] bg-gradient-to-r from-transparent via-accent-cyan to-transparent opacity-50">
                    </div>
                    <div
                        class="absolute -top-24 left-1/2 -translate-x-1/2 w-64 h-64 bg-[#00d4ff]/20 blur-[80px] rounded-full">
                    </div>

                    <div class="flex flex-col items-center gap-4 w-full relative z-10">
                        <h2 id="cta-title" class="font-display font-bold text-white text-3xl md:text-5xl">
                            Sẵn Sàng Chăm Sóc Xế Cưng?
                        </h2>
                        <p class="font-sans text-text-muted text-base md:text-xl max-w-2xl">
                            Tham gia Autowash Pro ngay hôm nay để trải nghiệm dịch vụ tự động đẳng cấp và nhận <span
                                class="text-[#00d4ff] font-semibold">200 điểm</span> khởi điểm.
                        </p>
                    </div>

                    <a href="${pageContext.request.contextPath}/auth/register"
                        class="relative z-10 flex h-14 md:h-16 items-center justify-center px-10 bg-[#00d4ff] text-black rounded-2xl font-bold text-base md:text-lg uppercase tracking-wide btn-glow hover:bg-[#00b8e6] transition-colors shadow-[0_4px_16px_rgba(0,212,255,0.3)] hover:shadow-[0_4px_24px_rgba(0,212,255,0.5)]">
                        Tạo Tài Khoản Miễn Phí <i data-lucide="arrow-right" class="w-5 h-5 ml-2"></i>
                    </a>
                </div>
            </section>

            <!-- Footer -->
            <footer
                class="w-full border-t border-border-glass py-10 px-6 flex flex-col md:flex-row items-center justify-between gap-4 mt-auto">
                <div class="flex items-center gap-2">
                    <i data-lucide="droplets" class="text-[#00d4ff] w-6 h-6"></i>
                    <span class="font-display font-bold text-lg text-white">AUTOWASH<span
                            class="text-[#00d4ff]">PRO</span></span>
                </div>
                <p class="text-text-muted text-sm">&copy; 2026 Autowash Pro. All rights reserved.</p>
            </footer>

        </main>

        <script>
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
        </script>
    </body>

    </html>