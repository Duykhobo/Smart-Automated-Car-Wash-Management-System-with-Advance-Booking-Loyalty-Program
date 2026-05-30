<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý xe - AutoWashPro</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Inter', 'sans-serif'], },
                    colors: { 'btn-primary': '#00d4ff', }
                }
            }
        }
    </script>
    <style>
        body { background-color: #0b0f1a; color: white; }
    </style>
</head>
<body class="flex min-h-screen">

    <!-- Sidebar -->
    <aside class="w-64 bg-black/40 border-r border-gray-800 hidden md:flex flex-col">
        <a href="${pageContext.request.contextPath}/home" class="p-6 flex items-center gap-3 hover:opacity-80 transition-opacity">
            <div class="w-10 h-10 bg-btn-primary rounded-xl flex items-center justify-center">
                <svg class="w-6 h-6 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path></svg>
            </div>
            <span class="text-xl font-bold tracking-tight text-white">AutoWash<span class="text-btn-primary">Pro</span></span>
        </a>

        <nav class="flex-1 px-4 py-6 space-y-2">
            <a href="${pageContext.request.contextPath}/account/dashboard" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
                <span class="font-medium">Tổng quan</span>
            </a>
            <a href="${pageContext.request.contextPath}/bookings" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                <span class="font-medium">Lịch đặt</span>
            </a>
            <a href="${pageContext.request.contextPath}/vehicles" class="flex items-center gap-3 px-4 py-3 bg-btn-primary/10 text-btn-primary rounded-xl transition-colors">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16V6a1 1 0 00-1-1H4a1 1 0 00-1 1v10a1 1 0 001 1h1m8-1a1 1 0 01-1 1H9m4-1V8a1 1 0 011-1h2.586a1 1 0 01.707.293l3.414 3.414a1 1 0 01.293.707V16a1 1 0 01-1 1h-1m-6-1a1 1 0 001 1h1M5 17a2 2 0 104 0m-4 0a2 2 0 114 0m6 0a2 2 0 104 0m-4 0a2 2 0 114 0"></path></svg>
                <span class="font-medium">Quản lý xe</span>
            </a>
            <a href="${pageContext.request.contextPath}/account/profile" class="flex items-center gap-3 px-4 py-3 text-gray-400 hover:text-white hover:bg-gray-800 rounded-xl transition-colors">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                <span class="font-medium">Tài khoản</span>
            </a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 overflow-y-auto pb-24 md:pb-0">
        <div class="max-w-4xl mx-auto p-4 md:p-8">
            
            <header class="flex items-center justify-between mb-8">
                <div>
                    <h1 class="text-2xl md:text-3xl font-bold text-white tracking-tight">Danh sách xe của bạn</h1>
                    <p class="text-gray-400 mt-1 text-sm md:text-base">Quản lý các phương tiện để đặt lịch rửa nhanh chóng</p>
                </div>
            </header>

            <% 
                String successMsg = (String) session.getAttribute("SUCCESS");
                String errorMsg = (String) session.getAttribute("ERROR");
                if (successMsg != null) { 
            %>
                <div class="p-4 mb-4 text-sm text-green-400 bg-green-900/30 rounded-xl border border-green-800">
                    <%= successMsg %>
                </div>
            <% session.removeAttribute("SUCCESS"); } %>
            <% if (errorMsg != null) { %>
                <div class="p-4 mb-4 text-sm text-red-400 bg-red-900/30 rounded-xl border border-red-800">
                    <%= errorMsg %>
                </div>
            <% session.removeAttribute("ERROR"); } %>

            <section class="grid grid-cols-1 gap-4">
                <c:choose>
                    <c:when test="${empty LISTCARS}">
                        <div class="text-center py-12 bg-gray-800/50 rounded-2xl border border-gray-700 border-dashed">
                            <svg class="w-16 h-16 text-gray-500 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19 17l.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                            <p class="text-gray-400">Bạn chưa thêm chiếc xe nào.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="car" items="${LISTCARS}">
                            <article class="flex items-center justify-between p-4 bg-gray-800 border-2 border-transparent hover:border-gray-600 rounded-2xl transition-transform hover:-translate-y-1 cursor-pointer relative overflow-hidden">
                                <c:if test="${car.isDefault}">
                                    <div class="absolute top-0 right-0 w-16 h-16 overflow-hidden">
                                        <div class="absolute top-0 right-0 w-16 h-16 bg-btn-primary/20 transform rotate-45 translate-x-8 -translate-y-8"></div>
                                        <svg class="absolute top-2 right-2 w-4 h-4 text-btn-primary drop-shadow-[0_0_5px_rgba(0,212,255,0.8)]" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                                    </div>
                                </c:if>
                                <div class="flex items-center gap-4 z-10">
                                    <div class="w-16 h-16 bg-gray-700 rounded-xl flex items-center justify-center shrink-0 overflow-hidden">
                                        <c:choose>
                                            <c:when test="${not empty car.imageUrl}">
                                                <img src="${pageContext.request.contextPath}/assets/uploads/${car.imageUrl}" alt="${car.brand}" class="w-full h-full object-cover">
                                            </c:when>
                                            <c:otherwise>
                                                <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h8M8 11h8m-9 4h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v6a2 2 0 002 2z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l-2 2v2a1 1 0 001 1h16a1 1 0 001-1v-2l-2-2"></path></svg>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="flex flex-col items-start gap-1">
                                        <h2 class="text-gray-300 font-bold text-lg md:text-xl leading-none">${car.licensePlate}</h2>
                                        <p class="text-gray-400 text-sm">${car.brand} ${car.model} • ${car.color} • <span class="capitalize">${car.vehicleType}</span></p>
                                    </div>
                                </div>
                                <div class="flex items-center gap-1 md:gap-3 z-10 shrink-0">
                                    <c:if test="${not car.isDefault}">
                                        <form action="${pageContext.request.contextPath}/vehicles/action" method="POST" class="inline" onsubmit="return confirm('Đặt xe ${car.licensePlate} làm mặc định?');">
                                            <input type="hidden" name="action" value="setDefault">
                                            <input type="hidden" name="vehicleId" value="${car.vehicleId}">
                                            <button type="submit" class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-yellow-500/20 text-gray-400 hover:text-yellow-500 transition-colors" aria-label="Đặt làm mặc định" title="Đặt làm mặc định">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path></svg>
                                            </button>
                                        </form>
                                    </c:if>
                                    <button onclick="openCarModal('update', '${car.vehicleId}', '${car.licensePlate}', '${car.brand}', '${car.model}', '${car.vehicleType}', '${car.color}')" class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-gray-700 text-gray-400 hover:text-white transition-colors focus:outline-none focus:ring-2 focus:ring-btn-primary" aria-label="Chỉnh sửa">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path></svg>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/vehicles/action" method="POST" class="inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa xe ${car.licensePlate} không?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="vehicleId" value="${car.vehicleId}">
                                        <button type="submit" class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-red-500/20 text-gray-400 hover:text-red-500 transition-colors" aria-label="Xóa">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                        </button>
                                    </form>
                                </div>
                            </article>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Add Car Button -->
            <button type="button" onclick="openCarModal('add')" class="flex items-center justify-center gap-3 w-full p-4 mt-6 rounded-2xl border-2 border-dashed border-btn-primary/50 hover:border-btn-primary hover:bg-btn-primary/5 text-btn-primary transition-all font-bold text-base shadow-sm hover:shadow-[0_0_15px_rgba(0,212,255,0.1)] focus:outline-none focus:ring-2 focus:ring-btn-primary">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
                <span>Thêm xe mới</span>
            </button>
        </div>
    </main>

    <!-- Car Modal -->
    <div id="carModal" class="fixed inset-0 z-50 hidden items-center justify-center">
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm transition-opacity" onclick="closeCarModal()"></div>
        
        <div class="relative bg-[#1f2937] w-full max-w-md mx-4 rounded-2xl shadow-2xl border border-gray-700 overflow-hidden transform scale-95 opacity-0 transition-all duration-300 max-h-[90vh] flex flex-col" id="carModalContent">
            <div class="flex items-center justify-between p-5 border-b border-gray-800 shrink-0">
                <h3 class="text-xl font-bold text-white" id="carModalTitle">Thêm xe mới</h3>
                <button type="button" onclick="closeCarModal()" class="text-gray-400 hover:text-white hover:bg-gray-700 p-2 rounded-xl transition-colors focus:outline-none focus:ring-2 focus:ring-btn-primary">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                </button>
            </div>
            
            <form action="${pageContext.request.contextPath}/vehicles/action" method="POST" enctype="multipart/form-data" class="p-5 space-y-4 overflow-y-auto" novalidate onsubmit="return validateCarForm()">
                <div id="formError" class="hidden p-3 bg-red-900/30 border border-red-800 text-red-400 text-sm rounded-xl mb-4"></div>
                <input type="hidden" name="action" id="modalAction" value="add">
                <input type="hidden" name="vehicleId" id="modalVehicleId" value="">
                
                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium">Biển số xe *</label>
                    <input type="text" id="modalPlate" name="licensePlate" placeholder="VD: 51H-123.45" required 
                           class="w-full bg-gray-800 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all placeholder:text-gray-500 uppercase">
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium">Hãng xe *</label>
                        <input type="text" id="modalBrand" name="brand" placeholder="VD: Honda" required 
                               class="w-full bg-gray-800 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all">
                    </div>
                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium">Dòng xe *</label>
                        <input type="text" id="modalModel" name="model" placeholder="VD: Civic" required 
                               class="w-full bg-gray-800 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all">
                    </div>
                </div>
                
                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium">Loại xe *</label>
                        <select id="modalType" name="vehicleType" class="w-full bg-gray-800 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all appearance-none cursor-pointer">
                            <option value="sedan">Sedan (4 chỗ)</option>
                            <option value="suv">SUV (7 chỗ)</option>
                            <option value="hatchback">Hatchback</option>
                            <option value="pickup">Bán tải</option>
                        </select>
                    </div>
                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium">Màu sắc *</label>
                        <input type="text" id="modalColor" name="color" placeholder="VD: Trắng" required 
                               class="w-full bg-gray-800 border border-gray-700 text-white rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-btn-primary/50 focus:border-btn-primary transition-all">
                    </div>
                </div>

                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium">Hình ảnh xe</label>
                    <input type="file" id="modalImage" name="carImage" accept="image/*"
                           class="w-full bg-gray-800 border border-gray-700 text-white rounded-xl px-4 py-2.5 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-btn-primary/10 file:text-btn-primary hover:file:bg-btn-primary/20 transition-all cursor-pointer">
                </div>

                <div class="pt-4 flex gap-3 shrink-0">
                    <button type="button" onclick="closeCarModal()" class="flex-1 px-4 py-3 rounded-xl border border-gray-600 text-white font-semibold hover:bg-gray-700 transition-colors focus:outline-none focus:ring-2 focus:ring-gray-500">
                        Hủy
                    </button>
                    <button type="submit" class="flex-1 px-4 py-3 rounded-xl bg-btn-primary text-black font-bold hover:bg-cyan-400 shadow-[0_4px_16px_rgba(0,212,255,0.2)] transition-all focus:outline-none focus:ring-2 focus:ring-btn-primary">
                        Lưu thông tin
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const carModal = document.getElementById('carModal');
        const carModalContent = document.getElementById('carModalContent');
        const carModalTitle = document.getElementById('carModalTitle');
        const modalPlate = document.getElementById('modalPlate');
        const modalType = document.getElementById('modalType');
        const modalBrand = document.getElementById('modalBrand');
        const modalModel = document.getElementById('modalModel');
        const modalColor = document.getElementById('modalColor');
        const modalAction = document.getElementById('modalAction');
        const modalVehicleId = document.getElementById('modalVehicleId');
        const formError = document.getElementById('formError');

        function openCarModal(action, id = '', plate = '', brand = '', model = '', type = 'sedan', color = '') {
            modalAction.value = action;
            formError.classList.add('hidden');
            
            if (action === 'update') {
                carModalTitle.textContent = 'Cập nhật xe';
                modalVehicleId.value = id;
                modalPlate.value = plate;
                modalBrand.value = brand;
                modalModel.value = model;
                modalType.value = type;
                modalColor.value = color;
            } else {
                carModalTitle.textContent = 'Thêm xe mới';
                modalVehicleId.value = '';
                modalPlate.value = '';
                modalBrand.value = '';
                modalModel.value = '';
                modalType.value = 'sedan';
                modalColor.value = '';
            }
            
            carModal.classList.remove('hidden');
            carModal.classList.add('flex');
            
            setTimeout(() => {
                carModalContent.classList.remove('scale-95', 'opacity-0');
                carModalContent.classList.add('scale-100', 'opacity-100');
            }, 10);
        }

        function closeCarModal() {
            carModalContent.classList.remove('scale-100', 'opacity-100');
            carModalContent.classList.add('scale-95', 'opacity-0');
            
            setTimeout(() => {
                carModal.classList.add('hidden');
                carModal.classList.remove('flex');
            }, 300);
        }

        function validateCarForm() {
            if (!modalPlate.value.trim() || !modalBrand.value.trim() || !modalModel.value.trim() || !modalColor.value.trim()) {
                formError.textContent = "Vui lòng nhập đầy đủ các trường bắt buộc (*).";
                formError.classList.remove('hidden');
                return false;
            }
            formError.classList.add('hidden');
            return true;
        }

        carModal.addEventListener('click', function(e) {
            if (e.target === carModal) {
                closeCarModal();
            }
        });
    </script>
</body>
</html>
