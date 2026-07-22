<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
    <title>Hệ Thống Đang Bảo Trì - Auto Wash Pro</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@500;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-primary: #070b14;
            --bg-surface: #131b2f;
            --text-primary: #f8fafc;
            --text-muted: #94a3b8;
            --accent-primary: #00d4ff;
        }
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-primary);
            color: var(--text-primary);
        }
        .font-display {
            font-family: 'Outfit', sans-serif;
        }
        .blob-1 {
            position: absolute;
            top: 20%;
            left: 20%;
            width: 300px;
            height: 300px;
            background: rgba(0, 212, 255, 0.1);
            border-radius: 50%;
            filter: blur(80px);
            animation: float 10s ease-in-out infinite;
        }
        .blob-2 {
            position: absolute;
            bottom: 20%;
            right: 20%;
            width: 400px;
            height: 400px;
            background: rgba(16, 185, 129, 0.05);
            border-radius: 50%;
            filter: blur(100px);
            animation: float 12s ease-in-out infinite reverse;
        }
        @keyframes float {
            0% { transform: translate(0, 0); }
            50% { transform: translate(20px, -20px); }
            100% { transform: translate(0, 0); }
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4 relative overflow-hidden">
    <div class="blob-1 pointer-events-none"></div>
    <div class="blob-2 pointer-events-none"></div>

    <div class="relative z-10 max-w-md w-full bg-slate-900/50 backdrop-blur-2xl border border-slate-700/50 rounded-3xl p-8 md:p-10 text-center shadow-2xl">
        <div class="w-24 h-24 bg-[#00d4ff]/10 rounded-full flex items-center justify-center mx-auto mb-6">
            <i data-lucide="settings" class="w-12 h-12 text-[#00d4ff] animate-[spin_4s_linear_infinite]"></i>
        </div>
        
        <h1 class="text-3xl font-display font-bold text-white mb-4">Đang Bảo Trì!</h1>
        <p class="text-text-muted mb-8 text-lg">
            Hệ thống Auto Wash Pro đang được nâng cấp để mang lại trải nghiệm tốt hơn. Vui lòng quay lại sau ít phút!
        </p>

        <a href="https://zalo.me" target="_blank" rel="noopener noreferrer" class="inline-flex items-center justify-center w-full py-4 bg-white/5 hover:bg-white/10 border border-white/10 rounded-xl text-white font-medium transition-all">
            <i data-lucide="message-circle" class="w-5 h-5 mr-2"></i>
            Liên hệ Hỗ trợ (Zalo)
        </a>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>
