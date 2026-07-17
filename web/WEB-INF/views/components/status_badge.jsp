<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="statusLower" value="${fn:toLowerCase(fn:trim(param.status))}" />

<c:choose>
    <c:when test="${statusLower == 'pending'}">
        <span class="px-2.5 py-1 rounded-lg bg-amber-500/20 text-amber-500 border border-amber-500/30 text-[10px] sm:text-xs font-bold uppercase tracking-wider flex items-center gap-1.5 w-fit">
            <i data-lucide="clock" class="w-3.5 h-3.5"></i>
            Chờ duyệt
        </span>
    </c:when>
    <c:when test="${statusLower == 'waitlisted'}">
        <span class="px-2.5 py-1 rounded-lg bg-orange-500/20 text-orange-500 border border-orange-500/30 text-[10px] sm:text-xs font-bold uppercase tracking-wider flex items-center gap-1.5 w-fit">
            <i data-lucide="list-ordered" class="w-3.5 h-3.5"></i>
            Chờ xếp lịch
        </span>
    </c:when>
    <c:when test="${statusLower == 'confirmed'}">
        <span class="px-2.5 py-1 rounded-lg bg-blue-500/20 text-blue-400 border border-blue-500/30 text-[10px] sm:text-xs font-bold uppercase tracking-wider flex items-center gap-1.5 w-fit">
            <i data-lucide="calendar-check" class="w-3.5 h-3.5"></i>
            Tới trạm
        </span>
    </c:when>
    <c:when test="${statusLower == 'in progress' || statusLower == 'inprogress'}">
        <span class="px-2.5 py-1 rounded-lg bg-[#00d4ff]/20 text-[#00d4ff] border border-[#00d4ff]/30 text-[10px] sm:text-xs font-bold uppercase tracking-wider flex items-center gap-1.5 animate-pulse shadow-[0_0_10px_rgba(0,212,255,0.3)] w-fit">
            <i data-lucide="spray-can" class="w-3.5 h-3.5"></i>
            Đang rửa
        </span>
    </c:when>
    <c:when test="${statusLower == 'completed'}">
        <span class="px-2.5 py-1 rounded-lg bg-emerald-500/20 text-emerald-400 border border-emerald-500/30 text-[10px] sm:text-xs font-bold uppercase tracking-wider flex items-center gap-1.5 w-fit">
            <i data-lucide="check-circle-2" class="w-3.5 h-3.5"></i>
            Đã xong
        </span>
    </c:when>
    <c:when test="${statusLower == 'cancelled' || statusLower == 'canceled'}">
        <span class="px-2.5 py-1 rounded-lg bg-rose-500/20 text-rose-400 border border-rose-500/30 text-[10px] sm:text-xs font-bold uppercase tracking-wider flex items-center gap-1.5 w-fit">
            <i data-lucide="x-circle" class="w-3.5 h-3.5"></i>
            Đã hủy
        </span>
    </c:when>
    <c:when test="${statusLower == 'no show'}">
        <span class="px-2.5 py-1 rounded-lg bg-red-600/20 text-red-500 border border-red-600/30 text-[10px] sm:text-xs font-bold uppercase tracking-wider flex items-center gap-1.5 w-fit">
            <i data-lucide="user-x" class="w-3.5 h-3.5"></i>
            Không đến
        </span>
    </c:when>
    <c:otherwise>
        <span class="px-2.5 py-1 rounded-lg bg-gray-500/20 text-gray-400 border border-gray-500/30 text-[10px] sm:text-xs font-bold uppercase tracking-wider flex items-center gap-1.5 w-fit">
            <i data-lucide="help-circle" class="w-3.5 h-3.5"></i>
            <c:out value="${param.status}" />
        </span>
    </c:otherwise>
</c:choose>
