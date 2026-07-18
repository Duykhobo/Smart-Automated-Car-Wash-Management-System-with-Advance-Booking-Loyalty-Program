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

import dao.RewardCatalogDAO;
import dao.VoucherDAO;
import dao.MemberTierDAO;
import dto.RewardCatalog;
import dto.VoucherHistoryDTO;
import dto.MemberTier;
import java.util.List;

/**
 * AdminLoyaltyServlet điều hướng trang Quản lý Voucher & Điểm.
 */
@WebServlet(name = "AdminLoyaltyServlet", urlPatterns = {"/admin/loyalty"})
public class AdminLoyaltyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
        String action = request.getParameter("action");
        MemberTierDAO tierDAO = new MemberTierDAO();
        
        if ("update_tier".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("tierId"));
                int minWashes = Integer.parseInt(request.getParameter("minWashes"));
                double minSpend = Double.parseDouble(request.getParameter("minSpend"));
                double modifier = Double.parseDouble(request.getParameter("pointsModifier"));
                int maxBookingDays = Integer.parseInt(request.getParameter("maxBookingDays"));
                
                MemberTier tier = new MemberTier(id, null, minWashes, minSpend, modifier, 0, maxBookingDays, null, null, null, null, null);
                boolean success = tierDAO.updateMemberTier(tier);
                
                if (success) {
                    request.getSession().setAttribute("successMessage", "Cập nhật hạng thành viên thành công!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Cập nhật hạng thành viên thất bại.");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Vui lòng nhập đúng định dạng số.");
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/loyalty");
    }
}