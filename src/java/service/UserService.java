package service;

import dao.UserDAO;
import dto.Customer;
import dto.User;
import utils.HashUtil;

public class UserService {
    private UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    // Constructor dùng để chích (inject) Mock DAO khi chạy Unit Test
    public UserService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    /**
     * Xử lý nghiệp vụ Đăng ký tài khoản
     * @return 1 nếu thành công, 0 nếu bị trùng SĐT, -1 nếu lỗi hệ thống
     */
    public int processRegistration(String fullName, String phone, String licensePlate, String rawPassword) {
        if (userDAO.checkUserExists(phone)) {
            return 0; // Báo trùng SĐT
        }

        String hashedPass = HashUtil.hashPassword(rawPassword);

        User user = new User();
        user.setUsername(phone);
        user.setPasswordHash(hashedPass);
        user.setRole("Customer");

        Customer cus = new Customer();
        cus.setFullName(fullName);
        cus.setPhone(phone);
        cus.setLicensePlate(licensePlate);

        boolean isSuccess = userDAO.registerCustomer(user, cus);
        return isSuccess ? 1 : -1; // 1 = Thành công, -1 = Lỗi hệ thống
    }

    /**
     * Xử lý nghiệp vụ Đăng nhập
     * @return User object nếu đúng thông tin, null nếu sai.
     */
    public User processLogin(String phone, String rawPassword) {
        if (phone == null || phone.trim().isEmpty() || rawPassword == null || rawPassword.trim().isEmpty()) {
            return null;
        }
        
        String hashedPass = HashUtil.hashPassword(rawPassword);
        return userDAO.login(phone, hashedPass);
    }
}
