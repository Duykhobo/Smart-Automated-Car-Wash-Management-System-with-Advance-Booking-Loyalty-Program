package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RewardCatalogDAO;
import dao.VoucherDAO;
import dto.RewardCatalog;
import dto.VoucherHistoryDTO;
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
            
            int activeVouchers = voucherDAO.getActiveVouchersCount();
            int redeemedThisMonth = voucherDAO.getRedeemedVouchersThisMonth();
            int totalPointsSpent = voucherDAO.getTotalPointsSpent();
            List<RewardCatalog> rewardsList = rewardDAO.getAllRewards();
            
            request.setAttribute("activeVouchers", activeVouchers);
            request.setAttribute("redeemedThisMonth", redeemedThisMonth);
            request.setAttribute("totalPointsSpent", totalPointsSpent);
            request.setAttribute("rewardsList", rewardsList);
            
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
        doGet(request, response);
    }
}
