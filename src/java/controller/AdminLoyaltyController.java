package controller;

import dao.MemberTierDAO;
import dao.RewardCatalogDAO;
import dto.MemberTier;
import dto.RewardCatalog;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.VoucherDAO;
import dto.VoucherHistoryDTO;
import java.util.HashMap;
import java.util.Map;



/**
 * AdminLoyaltyServlet điều hướng trang Quản lý Voucher & Điểm.
 */
@WebServlet(name = "AdminLoyaltyController", urlPatterns = {"/admin/loyalty"})
public class AdminLoyaltyController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        try {
            VoucherDAO voucherDAO = new VoucherDAO();
            RewardCatalogDAO rewardDAO = new RewardCatalogDAO();
            MemberTierDAO tierDAO = new MemberTierDAO();
            
            int activeVouchers = voucherDAO.getActiveVouchersCount();
            int redeemedThisMonth = voucherDAO.getRedeemedVouchersThisMonth();
            int totalPointsSpent = voucherDAO.getTotalPointsSpent();
            List<RewardCatalog> rewardsList = rewardDAO.getAllRewards();
            List<MemberTier> tiers = tierDAO.getAllTiers();
            
            request.setAttribute("activeVouchers", activeVouchers);
            request.setAttribute("redeemedThisMonth", redeemedThisMonth);
            request.setAttribute("totalPointsSpent", totalPointsSpent);
            request.setAttribute("rewardsList", rewardsList);
            request.setAttribute("tierList", tiers);
            
            // Pagination logic for Voucher History
            int page = 1;
            int recordsPerPage = 10;
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            int offset = (page - 1) * recordsPerPage;
            
            List<VoucherHistoryDTO> voucherHistory = voucherDAO.getVoucherHistory(recordsPerPage, offset);
            int totalRecords = voucherDAO.getTotalVouchersCount();
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
            
            request.setAttribute("voucherHistory", voucherHistory);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/manage_loyalty.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi tải dữ liệu loyalty");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String action = request.getParameter("action");
        MemberTierDAO tierDAO = new MemberTierDAO();
        
        Map<String, String> errors = new HashMap<>();

        if ("update_tier".equalsIgnoreCase(action)) {
            String tierIdStr = request.getParameter("tierId");
            String minWashesStr = request.getParameter("minWashes");
            String minSpendStr = request.getParameter("minSpend");
            String modifierStr = request.getParameter("pointsModifier");
            String maxBookingDaysStr = request.getParameter("maxBookingDays");

            int id = 0;
            int minWashes = 0;
            double minSpend = 0;
            double modifier = 0;
            int maxBookingDays = 0;

            try {
                id = Integer.parseInt(tierIdStr);
            } catch (NumberFormatException e) {
                errors.put("tierId", "ID không hợp lệ");
            }

            if (minWashesStr == null || minWashesStr.trim().isEmpty()) {
                errors.put("minWashes", "Không được để trống số lần rửa tối thiểu");
            } else {
                try {
                    minWashes = Integer.parseInt(minWashesStr);
                    if (minWashes < 0) errors.put("minWashes", "Số lần rửa không được âm");
                } catch (NumberFormatException e) {
                    errors.put("minWashes", "Số lần rửa không hợp lệ");
                }
            }

            if (minSpendStr == null || minSpendStr.trim().isEmpty()) {
                errors.put("minSpend", "Không được để trống tổng chi tiêu");
            } else {
                try {
                    minSpend = Double.parseDouble(minSpendStr);
                    if (minSpend < 0) errors.put("minSpend", "Tổng chi tiêu không được âm");
                } catch (NumberFormatException e) {
                    errors.put("minSpend", "Tổng chi tiêu không hợp lệ");
                }
            }

            if (modifierStr == null || modifierStr.trim().isEmpty()) {
                errors.put("pointsModifier", "Không được để trống hệ số điểm");
            } else {
                try {
                    modifier = Double.parseDouble(modifierStr);
                    if (modifier < 0) errors.put("pointsModifier", "Hệ số không được âm");
                } catch (NumberFormatException e) {
                    errors.put("pointsModifier", "Hệ số điểm không hợp lệ");
                }
            }

            if (maxBookingDaysStr == null || maxBookingDaysStr.trim().isEmpty()) {
                errors.put("maxBookingDays", "Không được để trống số ngày đặt lịch");
            } else {
                try {
                    maxBookingDays = Integer.parseInt(maxBookingDaysStr);
                    if (maxBookingDays < 0) errors.put("maxBookingDays", "Số ngày không được âm");
                } catch (NumberFormatException e) {
                    errors.put("maxBookingDays", "Số ngày không hợp lệ");
                }
            }

            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("errorMessage", "Vui lòng kiểm tra lại thông tin hạng thành viên!");
                request.setAttribute("action", action);
                request.setAttribute("tierId", tierIdStr);
                request.setAttribute("minWashes", minWashesStr);
                request.setAttribute("minSpend", minSpendStr);
                request.setAttribute("pointsModifier", modifierStr);
                request.setAttribute("maxBookingDays", maxBookingDaysStr);
                
                // Sticky Form cho Modal. JSP cần attribute này để tự động bật modal tương ứng khi load
                request.setAttribute("activeModal", "updateTierModal");
                
                // Gọi lại doGet để load data và forward
                doGet(request, response);
                return;
            }

            try {
                MemberTier tier = new MemberTier(id, null, minWashes, minSpend, modifier, 0, maxBookingDays, null, null, null, null, null);
                boolean success = tierDAO.updateMemberTier(tier);
                
                if (success) {
                    request.getSession().setAttribute("successMessage", "Cập nhật hạng thành viên thành công!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Cập nhật hạng thành viên thất bại.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/loyalty");
    }
}
