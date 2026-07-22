<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Quản lý xe - AutoWashPro</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
    
</head>

<body class="m-0 min-h-screen bg-bg-primary text-white font-sans antialiased w-full overflow-x-hidden">

    <!-- Desktop Sidebar -->
    <jsp:include page="/WEB-INF/views/components/customer_sidebar.jsp">
    <jsp:param name="activeMenu" value="vehicles" />
</jsp:include>

    <main class="flex-1 md:ml-64 relative min-h-screen pb-[120px] md:pb-8 bg-bg-primary">
        <header class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center justify-between">
            <div class="flex items-center gap-4">
                <a href="${pageContext.request.contextPath}/account/dashboard" class="md:hidden w-10 h-10 rounded-full bg-white/5 border border-border-glass flex items-center justify-center text-text-muted hover:text-white hover:bg-white/10 transition-colors">
                    <i data-lucide="arrow-left" class="w-5 h-5"></i>
                </a>
                <h1 class="text-lg md:text-2xl font-display font-bold truncate text-white">Quản lý xe</h1>
            </div>
            <button type="button" onclick="openCarModal('add')" class="hidden md:flex items-center gap-2 bg-[#00d4ff] text-black px-4 py-2 rounded-xl font-bold hover:bg-cyan-300 transition-colors shadow-[0_0_15px_rgba(0,212,255,0.3)]">
                <i data-lucide="plus" class="w-4 h-4"></i> Thêm xe mới
            </button>
        </header>

        <div class="px-4 md:px-8 py-8 max-w-4xl mx-auto space-y-6">
            
            <% String successMsg=(String) session.getAttribute("SUCCESS"); String errorMsg=(String) session.getAttribute("ERROR"); if (successMsg !=null) { %>
            <div class="p-4 text-sm text-emerald-400 bg-emerald-900/30 rounded-xl border border-emerald-800 flex items-center gap-3">
                <i data-lucide="check-circle" class="w-5 h-5"></i> <%= successMsg %>
            </div>
            <% session.removeAttribute("SUCCESS"); } %>
            <% if (errorMsg !=null) { %>
            <div class="p-4 text-sm text-red-400 bg-red-900/30 rounded-xl border border-red-800 flex items-center gap-3">
                <i data-lucide="alert-circle" class="w-5 h-5"></i> <%= errorMsg %>
            </div>
            <% session.removeAttribute("ERROR"); } %>

            <section class="grid grid-cols-1 gap-4">
                <c:choose>
                    <c:when test="${empty LISTCARS}">
                        <div class="text-center py-16 glass-panel rounded-2xl border border-dashed border-border-glass">
                            <div class="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center mx-auto mb-4 text-text-muted">
                                <i data-lucide="car" class="w-8 h-8"></i>
                            </div>
                            <h3 class="text-lg font-bold text-white mb-2">Chưa có phương tiện nào</h3>
                            <p class="text-text-muted text-sm mb-6 max-w-sm mx-auto">Hãy thêm xe của bạn để có thể đặt lịch rửa xe và sử dụng các dịch vụ chăm sóc tốt nhất.</p>
                            <button type="button" onclick="openCarModal('add')" class="md:hidden inline-flex items-center gap-2 bg-[#00d4ff] text-black px-6 py-3 rounded-xl font-bold hover:bg-cyan-300 transition-colors shadow-[0_0_15px_rgba(0,212,255,0.3)]">
                                <i data-lucide="plus" class="w-5 h-5"></i> Thêm xe ngay
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="car" items="${LISTCARS}">
                            <article class="glass-panel p-5 rounded-2xl hover:bg-white/5 transition-colors border border-transparent hover:border-[#00d4ff]/30 group relative overflow-hidden flex flex-col md:flex-row items-start md:items-center justify-between gap-4">
                                <c:if test="${car.isDefault}">
                                    <div class="absolute top-0 right-0">
                                        <div class="w-16 h-16 bg-[#00d4ff]/20 transform rotate-45 translate-x-8 -translate-y-8"></div>
                                        <i data-lucide="star" class="absolute top-2 right-2 w-4 h-4 text-[#00d4ff] fill-[#00d4ff] drop-shadow-[0_0_5px_rgba(0,212,255,0.8)]"></i>
                                    </div>
                                </c:if>
                                
                                <div class="flex items-center gap-5 z-10 w-full md:w-auto">
                                    <div class="w-20 h-20 bg-black/40 rounded-xl flex items-center justify-center shrink-0 overflow-hidden border border-border-glass">
                                        <c:choose>
                                            <c:when test="${not empty car.imageUrl}">
                                                <img src="${pageContext.request.contextPath}/assets/uploads/${car.imageUrl}" alt="${car.brand}" class="w-full h-full object-cover">
                                            </c:when>
                                            <c:otherwise>
                                                <i data-lucide="car-front" class="w-8 h-8 text-text-muted"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="flex flex-col gap-1">
                                        <div class="flex items-center gap-2">
                                            <h2 class="text-white font-display font-bold text-xl uppercase"><c:out value="${car.licensePlate}" /></h2>
                                            <c:if test="${car.isDefault}">
                                                <span class="text-[10px] bg-[#00d4ff]/20 text-[#00d4ff] px-2 py-0.5 rounded uppercase font-bold border border-[#00d4ff]/30 hidden md:inline-block">Mặc định</span>
                                            </c:if>
                                        </div>
                                        <div class="flex items-center flex-wrap gap-2 text-sm">
                                            <span class="text-text-muted font-medium"><c:out value="${car.brand}" /> <c:out value="${car.model}" /></span>
                                            <span class="text-border-glass">•</span>
                                            <span class="text-gray-300"><c:out value="${car.color}" /></span>
                                            <span class="text-border-glass">•</span>
                                            <span class="text-gray-300 capitalize"><c:out value="${car.vehicleTypeName}" /></span>
                                        </div>
                                        <c:if test="${car.isDefault}">
                                            <span class="text-[10px] bg-[#00d4ff]/20 text-[#00d4ff] px-2 py-0.5 rounded uppercase font-bold border border-[#00d4ff]/30 md:hidden w-max mt-1">Mặc định</span>
                                        </c:if>
                                    </div>
                                </div>
                                
                                <div class="flex items-center gap-2 w-full md:w-auto justify-end z-10 pt-4 md:pt-0 border-t border-border-glass md:border-t-0 mt-2 md:mt-0">
                                    <c:if test="${not car.isDefault}">
                                        <form action="${pageContext.request.contextPath}/vehicles/action" method="POST" class="inline" onsubmit="event.preventDefault(); var form = this; showGlobalConfirmModal('Xác nhận', 'Đặt xe ${car.licensePlate} làm mặc định?', 'Đồng ý', function() { form.submit(); });" data-auto-validate="true">
                                            <input type="hidden" name="action" value="setDefault">
                                            <input type="hidden" name="vehicleId" value="<c:out value='${car.vehicleId}'/>">
                                            <button type="submit" class="w-10 h-10 flex items-center justify-center rounded-xl bg-yellow-500/10 text-yellow-500 hover:bg-yellow-500 hover:text-black border border-yellow-500/20 transition-all" title="Đặt làm mặc định">
                                                <i data-lucide="star" class="w-4 h-4"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                    
                                    <button type="button"
                                        data-id="<c:out value='${car.vehicleId}'/>"
                                        data-plate="<c:out value='${car.licensePlate}'/>"
                                        data-brand="<c:out value='${car.brand}'/>"
                                        data-model="<c:out value='${car.model}'/>"
                                        data-typeid="<c:out value='${car.vehicleTypeId}'/>"
                                        data-color="<c:out value='${car.color}'/>"
                                        onclick="openCarModalFromButton(this)"
                                        class="w-10 h-10 flex items-center justify-center rounded-xl bg-white/5 text-white hover:bg-[#00d4ff] hover:text-black border border-border-glass hover:border-[#00d4ff] transition-all"
                                        title="Chỉnh sửa">
                                        <i data-lucide="pencil" class="w-4 h-4"></i>
                                    </button>
                                    
                                    <form action="${pageContext.request.contextPath}/vehicles/action" method="POST" class="inline" onsubmit="event.preventDefault(); var form = this; showGlobalConfirmModal('Xác nhận', 'Bạn có chắc chắn muốn xóa xe ${car.licensePlate} không?', 'Xóa xe', function() { form.submit(); });" data-auto-validate="true">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="vehicleId" value="<c:out value='${car.vehicleId}'/>">
                                        <button type="submit" class="w-10 h-10 flex items-center justify-center rounded-xl bg-red-500/10 text-red-400 hover:bg-red-500 hover:text-white border border-red-500/20 transition-all" title="Xóa">
                                            <i data-lucide="trash-2" class="w-4 h-4"></i>
                                        </button>
                                    </form>
                                </div>
                            </article>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </section>
            
            <c:if test="${not empty LISTCARS}">
                <button type="button" onclick="openCarModal('add')" class="md:hidden flex items-center justify-center gap-3 w-full p-4 mt-6 rounded-2xl border-2 border-dashed border-[#00d4ff]/50 hover:border-[#00d4ff] hover:bg-[#00d4ff]/10 text-[#00d4ff] transition-all font-bold text-base">
                    <i data-lucide="plus" class="w-5 h-5"></i> Thêm xe mới
                </button>
            </c:if>

        </div>
    </main>

    <!-- Mobile Bottom Navigation -->
    <jsp:include page="/WEB-INF/views/components/customer_bottom_nav.jsp">
    <jsp:param name="activeMenu" value="vehicles" />
</jsp:include>

    <!-- Car Modal Wrapper -->
    <div id="carModal" class="fixed inset-0 z-50 hidden items-center justify-center bg-black/80 backdrop-blur-md px-4">
        <div class="relative glass-panel bg-[#0b0f1a]/90 w-full max-w-md mx-auto rounded-3xl shadow-2xl overflow-hidden transform scale-95 opacity-0 transition-all duration-300 max-h-[90vh] flex flex-col border border-border-glass" id="carModalContent">
            
            <div class="flex items-center justify-between p-5 border-b border-border-glass shrink-0 bg-white/5">
                <h3 class="text-xl font-display font-bold text-white" id="carModalTitle">Thêm xe mới</h3>
                <button type="button" onclick="closeCarModal()" class="text-text-muted hover:text-white hover:bg-white/10 p-2 rounded-xl transition-colors">
                    <i data-lucide="x" class="w-5 h-5"></i>
                </button>
            </div>

            <form action="${pageContext.request.contextPath}/vehicles/action" method="POST" enctype="multipart/form-data" class="p-6 space-y-5 overflow-y-auto custom-scrollbar" novalidate onsubmit="return validateCarForm()" data-auto-validate="true">
                <div id="formError" class="hidden p-4 bg-red-500/10 border border-red-500/20 text-red-400 text-sm rounded-xl mb-4 flex items-start gap-3">
                    <i data-lucide="alert-circle" class="w-5 h-5 shrink-0 mt-0.5"></i>
                    <span id="formErrorText">Lỗi</span>
                </div>
                
                <input type="hidden" name="action" id="modalAction" value="add">
                <input type="hidden" name="vehicleId" id="modalVehicleId" value="">

                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium ml-1">Biển số xe *</label>
                    <input type="text" id="modalPlate" name="licensePlate" placeholder="VD: 51H-123.45" required class="w-full bg-black/20 border border-border-glass text-white rounded-xl px-4 py-3 focus:outline-none focus:border-[#00d4ff] focus:shadow-[0_0_10px_rgba(0,212,255,0.1)] transition-all placeholder:text-gray-600 uppercase">
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium ml-1">Hãng xe *</label>
                        <select id="modalBrand" name="brand" required class="custom-select" data-create="true" placeholder="Chọn hoặc nhập hãng xe">
                            <option value="">Chọn hãng</option>
                            <option value="Toyota">Toyota</option>
                            <option value="Honda">Honda</option>
                            <option value="Hyundai">Hyundai</option>
                            <option value="Kia">Kia</option>
                            <option value="Mazda">Mazda</option>
                            <option value="Ford">Ford</option>
                            <option value="Mitsubishi">Mitsubishi</option>
                            <option value="VinFast">VinFast</option>
                            <option value="Suzuki">Suzuki</option>
                            <option value="Mercedes-Benz">Mercedes-Benz</option>
                            <option value="BMW">BMW</option>
                            <option value="Audi">Audi</option>
                        </select>
                    </div>
                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium ml-1">Dòng xe *</label>
                        <select id="modalModel" name="model" required class="custom-select" data-create="true" placeholder="Chọn hoặc nhập dòng xe">
                            <option value="">Chọn dòng xe</option>
                            <option value="Vios">Vios</option>
                            <option value="City">City</option>
                            <option value="Mazda 3">Mazda 3</option>
                            <option value="Cerato">Cerato</option>
                            <option value="CX-5">CX-5</option>
                            <option value="CR-V">CR-V</option>
                            <option value="Ranger">Ranger</option>
                            <option value="Everest">Everest</option>
                            <option value="Santa Fe">Santa Fe</option>
                            <option value="Tucson">Tucson</option>
                            <option value="Accent">Accent</option>
                            <option value="Fadil">Fadil</option>
                            <option value="Camry">Camry</option>
                            <option value="Innova">Innova</option>
                            <option value="Xpander">Xpander</option>
                        </select>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium ml-1">Loại xe *</label>
                        <select id="modalType" name="vehicleTypeId" class="custom-select" placeholder="Chọn loại xe">
                            <c:forEach var="vType" items="${vehicleTypes}">
                                <option value="${vType.vehicleTypeId}">${vType.typeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="space-y-1.5">
                        <label class="text-gray-300 text-sm font-medium ml-1">Màu sắc *</label>
                        <select id="modalColor" name="color" required class="custom-select" data-create="true" placeholder="Chọn hoặc nhập màu">
                            <option value="">Chọn màu sắc</option>
                            <option value="Trắng">Trắng</option>
                            <option value="Đen">Đen</option>
                            <option value="Bạc">Bạc</option>
                            <option value="Xám">Xám</option>
                            <option value="Đỏ">Đỏ</option>
                            <option value="Xanh dương">Xanh dương</option>
                            <option value="Xanh lá">Xanh lá</option>
                            <option value="Nâu">Nâu</option>
                            <option value="Vàng">Vàng</option>
                        </select>
                    </div>
                </div>

                <div class="space-y-1.5">
                    <label class="text-gray-300 text-sm font-medium ml-1">Hình ảnh xe (Tuỳ chọn)</label>
                    <input type="file" id="modalImage" name="carImage" accept="image/*" class="w-full bg-black/20 border border-border-glass text-white rounded-xl px-4 py-2.5 file:mr-4 file:py-2 file:px-4 file:rounded-xl file:border-0 file:text-sm file:font-semibold file:bg-[#00d4ff]/10 file:text-[#00d4ff] hover:file:bg-[#00d4ff] hover:file:text-black transition-all cursor-pointer">
                </div>

                <div class="pt-6 flex gap-3 shrink-0">
                    <button type="button" onclick="closeCarModal()" class="flex-1 px-4 py-3 rounded-xl border border-border-glass text-white font-semibold hover:bg-white/5 transition-colors">
                        Hủy
                    </button>
                    <button type="submit" class="flex-1 px-4 py-3 rounded-xl bg-[#00d4ff] text-black font-bold hover:bg-cyan-300 shadow-[0_0_15px_rgba(0,212,255,0.3)] transition-all">
                        Lưu thông tin
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/customer/manage_cars.js?v=2"></script>
    <jsp:include page="/WEB-INF/views/components/confirm_modal.jsp" />
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>