/** @type {import('tailwindcss').Config} */
window.tailwind = window.tailwind || {};
window.tailwind.config = {
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
        display: ['Be Vietnam Pro', 'sans-serif'],
      },
      colors: {
        "bg-primary": "#070b14",
        "bg-surface": "rgba(255, 255, 255, 0.03)",
        "bg-surface-hover": "rgba(255, 255, 255, 0.05)",
        "border-glass": "rgba(255, 255, 255, 0.08)",
        "border-glow": "rgba(0, 212, 255, 0.4)",
        "btn-primary": "#00d4ff",
        "text-primary": "#ffffff",
        "text-muted": "#94a3b8",
        "accent-cyan": "#00d4ff",
        "accent-blue": "#3b82f6",
        "error": "#ef4444",
        "success": "#10b981",
      },
      animation: {
        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
      }
    }
  },
  plugins: []
}
