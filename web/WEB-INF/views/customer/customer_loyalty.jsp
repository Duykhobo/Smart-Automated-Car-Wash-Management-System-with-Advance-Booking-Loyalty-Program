<%@page import="utils.AppConstants" %>
<%@page import="dto.Customer" %>
<%@page import="dto.RewardCatalog" %>
<%@page import="dto.Voucher" %>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:if test="${empty sessionScope.USER}">
    <c:redirect url="/auth/login" />
</c:if>
<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Auto Wash Pro - Đổi Voucher</title>
    <jsp:include page="/WEB-INF/views/components/head_includes.jsp" />
</head>

<body class="m-0 min-h-screen bg-bg-primary text-text-primary font-sans antialiased w-full overflow-x-hidden">

    <div class="flex h-screen overflow-hidden bg-bg-primary">

        <!-- Desktop Sidebar -->
        <jsp:include page="/WEB-INF/views/components/customer_sidebar.jsp">
    <jsp:param name="activeMenu" value="loyalty" />
</jsp:include>

        <!-- Main Content Area -->
        <main class="flex-1 md:ml-64 relative min-h-screen bg-bg-primary overflow-y-auto pb-24 md:pb-8">
            <!-- App Bar / Header -->
            <header class="sticky top-0 z-20 glass-panel border-b border-border-glass px-4 md:px-8 py-4 flex items-center justify-between gap-3">
                <div class="flex items-center gap-3">
                    <h1 class="text-lg md:text-2xl font-display font-bold text-white truncate max-w-[60%] sm:max-w-full">Đổi Điểm Nhận Quà</h1>
                </div>

                <div class="flex items-center gap-3">
                    <div class="hidden sm:flex flex-col items-end mr-2">
                        <span class="text-xs text-text-muted">Xin chào,</span>
                        <span class="text-sm font-bold text-white">${sessionScope.CUSTOMER_INFO.fullName}</span>
                    </div>
                    <div class="w-10 h-10 rounded-full bg-[#00d4ff]/20 border border-[#00d4ff] flex items-center justify-center text-[#00d4ff] font-bold">
                        ${sessionScope.CUSTOMER_INFO.fullName.substring(0,1)}
                    </div>
                </div>
            </header>

            <div class="px-4 md:px-8 py-8 max-w-6xl mx-auto space-y-8 w-full overflow-hidden">


                <!-- Points Overview -->
                <section class="glass-panel rounded-2xl border border-border-glass p-6 md:p-8 flex flex-col md:flex-row items-center justify-between gap-6 relative overflow-hidden">
                    <div class="absolute -right-20 -top-20 w-64 h-64 bg-amber-500/10 rounded-full blur-3xl pointer-events-none"></div>
                    
                    <div class="flex items-center gap-6 z-10">
                        <div class="w-20 h-20 rounded-full bg-gradient-to-tr from-amber-400 to-amber-600 flex items-center justify-center shadow-lg shadow-amber-500/20">
                            <i data-lucide="gift" class="w-10 h-10 text-black"></i>
                        </div>
                        <div>
                            <p class="text-text-muted text-sm uppercase tracking-widest mb-1">Điểm hiện tại</p>
                            <div class="flex items-baseline gap-2">
                                <span class="text-5xl font-display font-bold text-white drop-shadow-md"><c:out value="${customer.pointsBalance}" /></span>
                                <span class="text-amber-400 font-bold text-xl">pts</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="flex flex-col items-center md:items-end text-center md:text-right z-10">
                        <span class="text-text-muted text-sm mb-1">Hạng thành viên</span>
                        <c:choose>
                              <c:when test="${customer.tierStatus == 'Silver'}">
                                  <span class="text-2xl font-display font-bold bg-gradient-to-r from-gray-200 via-gray-400 to-gray-200 text-transparent bg-clip-text uppercase tracking-widest bg-zinc-300/10 px-4 py-1 rounded-full border border-zinc-300/30 shadow-[0_0_20px_rgba(212,212,216,0.4)]">Silver</span>
                              </c:when>
                              <c:when test="${customer.tierStatus == 'Gold'}">
                                  <span class="text-2xl font-display font-bold bg-gradient-to-r from-yellow-200 via-yellow-400 to-yellow-600 text-transparent bg-clip-text uppercase tracking-widest bg-yellow-400/10 px-4 py-1 rounded-full border border-yellow-400/40 shadow-[0_0_20px_rgba(250,204,21,0.5)]">Gold</span>
                              </c:when>
                              <c:when test="${customer.tierStatus == 'Platinum'}">
                                  <span class="text-2xl font-display font-bold bg-gradient-to-r from-cyan-300 via-white to-purple-400 text-transparent bg-clip-text uppercase tracking-widest bg-purple-500/10 px-4 py-1 rounded-full border border-cyan-400/50 shadow-[0_0_25px_rgba(0,212,255,0.6)] animate-pulse">Platinum</span>
                              </c:when>
                            <c:otherwise>
                                <span class="text-2xl font-display font-bold text-slate-300 uppercase tracking-widest bg-slate-500/10 px-4 py-1 rounded-full border border-slate-500/20 shadow-[0_0_15px_rgba(148,163,184,0.1)]">Member</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Rewards Store -->
                    <section class="lg:col-span-2 flex flex-col gap-4">
                        <div class="flex items-center gap-3 mb-2">
                            <i data-lucide="store" class="w-6 h-6 text-[#00d4ff]"></i>
                            <h2 class="text-white font-display font-semibold text-xl">Cửa hàng Voucher</h2>
                        </div>
                        
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <c:choose>
                                <c:when test="${not empty activeRewards}">
                                    <c:forEach var="reward" items="${activeRewards}">
                                        <div class="glass-panel rounded-xl border border-border-glass p-5 flex flex-col h-full group hover:border-[#00d4ff]/50 transition-colors">
                                            <div class="flex justify-between items-start mb-4">
                                                <div class="w-12 h-12 rounded-lg bg-bg-surface flex items-center justify-center text-amber-400 border border-border-glass">
                                                    <c:choose>
                                                        <c:when test="${reward.rewardType == 'FREE_WASH'}"><i data-lucide="droplets" class="w-6 h-6"></i></c:when>
                                                        <c:when test="${reward.rewardType == 'UPGRADE_WAX'}"><i data-lucide="sparkles" class="w-6 h-6"></i></c:when>
                                                        <c:otherwise><i data-lucide="tag" class="w-6 h-6"></i></c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="bg-amber-400/10 text-amber-400 px-3 py-1 rounded-full text-xs font-bold font-display border border-amber-400/20">
                                                    <c:out value="${reward.pointsCost}" /> pts
                                                </div>
                                            </div>
                                            
                                            <h3 class="text-lg font-bold text-white mb-2"><c:out value="${reward.rewardName}" /></h3>
                                            <p class="text-text-muted text-sm flex-grow"><c:out value="${reward.description}" /></p>
                                            
                                            <div class="mt-6 pt-4 border-t border-border-glass">
                                                <c:choose>
                                                    <c:when test="${customer.pointsBalance >= reward.pointsCost}">
                                                        <button type="button" onclick="confirmRedeem(${reward.rewardId}, '${reward.rewardName}', ${reward.pointsCost})"
                                                                class="w-full bg-[#00d4ff] hover:bg-[#00d4ff]/90 text-black font-bold py-2.5 rounded-lg transition-colors flex items-center justify-center gap-2">
                                                            <i data-lucide="arrow-right-left" class="w-4 h-4"></i> Đổi Ngay
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button disabled class="w-full bg-bg-surface text-text-muted font-bold py-2.5 rounded-lg cursor-not-allowed border border-border-glass">
                                                            Thiếu điểm
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-span-1 sm:col-span-2 text-center p-8 glass-panel rounded-xl border-dashed border-2 border-border-glass">
                                        <p class="text-text-muted">Hiện tại không có voucher nào khả dụng.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </section>

                    <!-- User's Vouchers -->
                    <section class="flex flex-col gap-4">
                        <div class="flex items-center gap-3 mb-2">
                            <i data-lucide="ticket" class="w-6 h-6 text-amber-400"></i>
                            <h2 class="text-white font-display font-semibold text-xl">Voucher Của Bạn</h2>
                        </div>
                        
                        <div class="glass-panel rounded-xl border border-border-glass p-5 flex flex-col gap-4 h-full min-h-[300px]">
                            <c:choose>
                                <c:when test="${not empty userVouchers}">
                                    <c:forEach var="v" items="${userVouchers}">
                                        <div class="bg-bg-surface border border-border-glass rounded-lg p-4 flex flex-col relative overflow-hidden group">
                                            <!-- Decorative edge -->
                                            <div class="absolute top-0 left-0 bottom-0 w-1 bg-amber-400"></div>
                                            
                                            <div class="flex justify-between items-start mb-2 pl-2">
                                                <h4 class="text-white font-bold text-sm truncate">
                                                    <c:choose>
                                                        <c:when test="${v.discountPercent > 0}">Giảm <fmt:formatNumber value="${v.discountPercent}" maxFractionDigits="0"/>%</c:when>
                                                        <c:when test="${v.rewardType == 'FREE_WASH'}">Miễn Phí</c:when>
                                                        <c:when test="${v.rewardType == '10_PERCENT_OFF'}">Giảm 10%</c:when>
                                                        <c:when test="${v.rewardType == '20_PERCENT_OFF'}">Giảm 20%</c:when>
                                                        <c:otherwise><c:out value="${v.rewardType}" /></c:otherwise>
                                                    </c:choose>
                                                </h4>
                                                <span class="text-xs text-text-muted"><fmt:formatDate value="${v.expiryDate}" pattern="dd/MM/yyyy" /></span>
                                            </div>
                                            
                                            <div class="bg-bg-primary border border-dashed border-border-glass rounded p-2 text-center mt-2 pl-2 cursor-pointer hover:bg-white/5 transition-colors" onclick="copyVoucherCode('${v.voucherCode}')" title="Bấm để copy">
                                                <span class="font-mono text-amber-400 font-bold tracking-widest select-all" id="code-${v.voucherCode}">
                                                    <c:out value="${v.voucherCode}" />
                                                </span>
                                            </div>
                                            <p class="text-[10px] text-center text-text-muted mt-2 pl-2">Sử dụng mã này khi Đặt lịch</p>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="flex-1 flex flex-col items-center justify-center text-center opacity-50">
                                        <i data-lucide="ticket" class="w-12 h-12 mb-3 text-text-muted"></i>
                                        <p class="text-sm">Bạn chưa có voucher nào.<br>Hãy tích điểm để đổi quà nhé!</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </section>
                </div>
            </div>
        </main>

        <!-- Mobile Bottom Navigation (Chỉ hiện trên điện thoại) -->
        <jsp:include page="/WEB-INF/views/components/customer_bottom_nav.jsp">
    <jsp:param name="activeMenu" value="loyalty" />
</jsp:include>
    </div>

    <!-- Redeem Confirmation Modal -->
    <div id="redeemModal" class="fixed inset-0 z-[100] hidden items-center justify-center p-4">
        <!-- Backdrop -->
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeRedeemModal()"></div>
        
        <!-- Modal Content -->
        <div class="relative bg-bg-surface border border-border-glass rounded-2xl w-full max-w-md shadow-2xl overflow-hidden transform scale-95 opacity-0 transition-all duration-300" id="redeemModalContent">
            <!-- Header decorative -->
            <div class="h-2 bg-gradient-to-r from-amber-400 to-orange-500 w-full"></div>
            
            <div class="p-6 md:p-8">
                <div class="w-16 h-16 bg-amber-500/10 rounded-full flex items-center justify-center mx-auto mb-4 border border-amber-500/20">
                    <i data-lucide="arrow-right-left" class="w-8 h-8 text-amber-400"></i>
                </div>
                
                <h3 class="text-xl font-display font-bold text-white text-center mb-2">Xác Nhận Đổi Voucher</h3>
                <p class="text-text-muted text-center text-sm mb-6">Bạn có chắc chắn muốn dùng <span id="modalPointsCost" class="font-bold text-amber-400"></span> điểm để đổi lấy <span id="modalRewardName" class="font-bold text-white"></span>?</p>
                
                <form action="${pageContext.request.contextPath}/voucher/redeem" method="POST" class="flex flex-col sm:flex-row gap-3 mt-6" data-auto-validate="true">
                    <input type="hidden" name="rewardId" id="modalRewardId" value="">
                    
                    <button type="button" onclick="closeRedeemModal()"
                            class="flex-1 py-3 px-4 bg-transparent border border-border-glass hover:bg-white/5 text-white font-semibold rounded-xl transition-colors">
                        Hủy
                    </button>
                    <button type="submit"
                            class="flex-1 py-3 px-4 bg-gradient-to-r from-amber-400 to-orange-500 hover:from-amber-500 hover:to-orange-600 text-black font-bold rounded-xl transition-all shadow-[0_0_15px_rgba(245,158,11,0.3)]">
                        Xác Nhận Đổi
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script charset="UTF-8" src="https://unpkg.com/lucide@latest"></script>
    <script charset="UTF-8" src="${pageContext.request.contextPath}/js/customer/customer_loyalty.js?v=2"></script>
    <jsp:include page="/WEB-INF/views/components/toast.jsp" />
</body>
</html>
