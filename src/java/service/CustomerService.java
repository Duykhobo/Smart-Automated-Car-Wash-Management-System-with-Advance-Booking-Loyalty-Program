package service;

import dao.CustomerDAO;
import dto.Customer;
import utils.ValidationUtil;

public class CustomerService {
    private CustomerDAO customerDAO;

    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }

    public Customer getCustomerByAccountId(int accountId) {
        return customerDAO.getCustomerByAccountId(accountId);
    }

    /**
     * Cập nhật thông tin profile của khách hàng.
     * @return Customer đã được cập nhật thành công, hoặc null nếu không có sự thay đổi.
     * @throws Exception chứa câu báo lỗi (errorMessage) nếu validation thất bại.
     */
    public Customer updateProfile(int accountId, String fullname, String email, String avatarPath) throws Exception {
        Customer customer = customerDAO.getCustomerByAccountId(accountId);
        if (customer == null) {
            throw new Exception("Không tìm thấy thông tin khách hàng.");
        }
        
        int customerId = customer.getCustomerId();
        
        if (ValidationUtil.isAnyEmpty(fullname)) {
            throw new Exception("Không được để trống");
        }
        
        if (customer.getFullName().equalsIgnoreCase(fullname) && 
            (customer.getEmail() == null ? email == null : customer.getEmail().equalsIgnoreCase(email)) && avatarPath == null) {
            // Không có sự thay đổi
            return customer;
        }
        
        if (!ValidationUtil.isValidName(fullname)) {
            throw new Exception("Tên không hợp lệ! Vui lòng nhập lại tên.");
        }
        
        if (email != null && !email.trim().isEmpty()) {
            if (!ValidationUtil.isValidEmail(email)) {
                throw new Exception("Email không hợp lệ!!Vui lòng nhập lại");
            }
        }
        
        if (customerDAO.isEmailExists(customerId, email)) {
            throw new Exception("Email đã tồn tại");
        }
        
        int updateResult = customerDAO.updateProfile(customerId, fullname, email, avatarPath);
        if (updateResult > 0) {
            return customerDAO.getCustomerByAccountId(accountId);
        } else {
            throw new Exception("Đã xảy ra lỗi hệ thống, vui lòng thử lại sau!");
        }
    }
}
