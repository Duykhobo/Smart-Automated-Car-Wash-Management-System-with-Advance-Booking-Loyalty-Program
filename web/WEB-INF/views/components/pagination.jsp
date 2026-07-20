<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${param.totalPages > 1}">
    <div class="flex items-center justify-center sm:justify-end gap-1.5 mt-6 w-full">
        <!-- Prev -->
        <a href="${param.url}page=${param.currentPage - 1}" 
           class="w-9 h-9 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center text-text-muted hover:text-white hover:bg-white/10 transition-all ${param.currentPage <= 1 ? 'pointer-events-none opacity-40' : ''}">
            <i data-lucide="chevron-left" class="w-4 h-4"></i>
        </a>
        
        <!-- Pagination Logic: 1 ... 4 5 6 ... 10 -->
        <c:set var="startPage" value="${param.currentPage - 2}" />
        <c:set var="endPage" value="${param.currentPage + 2}" />
        
        <c:if test="${startPage < 1}">
            <c:set var="startPage" value="1" />
            <c:set var="endPage" value="${startPage + 4}" />
        </c:if>
        
        <c:if test="${endPage > param.totalPages}">
            <c:set var="endPage" value="${param.totalPages}" />
            <c:set var="startPage" value="${endPage - 4 > 0 ? endPage - 4 : 1}" />
        </c:if>
        
        <c:if test="${startPage > 1}">
            <a href="${param.url}page=1" class="w-9 h-9 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center text-text-muted hover:text-white hover:bg-white/10 transition-all font-medium text-sm">1</a>
            <c:if test="${startPage > 2}">
                <span class="w-9 h-9 flex items-center justify-center text-text-muted">...</span>
            </c:if>
        </c:if>
        
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <c:choose>
                <c:when test="${i == param.currentPage}">
                    <span class="w-9 h-9 rounded-xl bg-gradient-to-r from-[#00d4ff]/20 to-[#00d4ff]/10 border border-[#00d4ff]/50 flex items-center justify-center text-[#00d4ff] font-bold text-sm shadow-[0_0_15px_rgba(0,212,255,0.2)]">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="${param.url}page=${i}" class="w-9 h-9 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center text-text-muted hover:text-white hover:bg-white/10 transition-all font-medium text-sm">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        
        <c:if test="${endPage < param.totalPages}">
            <c:if test="${endPage < param.totalPages - 1}">
                <span class="w-9 h-9 flex items-center justify-center text-text-muted">...</span>
            </c:if>
            <a href="${param.url}page=${param.totalPages}" class="w-9 h-9 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center text-text-muted hover:text-white hover:bg-white/10 transition-all font-medium text-sm">${param.totalPages}</a>
        </c:if>

        <!-- Next -->
        <a href="${param.url}page=${param.currentPage + 1}" 
           class="w-9 h-9 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center text-text-muted hover:text-white hover:bg-white/10 transition-all ${param.currentPage >= param.totalPages ? 'pointer-events-none opacity-40' : ''}">
            <i data-lucide="chevron-right" class="w-4 h-4"></i>
        </a>
    </div>
</c:if>
