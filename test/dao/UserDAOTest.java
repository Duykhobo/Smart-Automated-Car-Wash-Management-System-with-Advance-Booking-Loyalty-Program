package dao;

import dto.Customer;
import dto.User;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UserDAOTest {

    private UserDAO userDAO;
    private final String TEST_PHONE = "0999999999";

    @Before
    public void setUp() {
        userDAO = new UserDAO();
        // Xóa sạch dữ liệu test cũ (nếu có) trước khi bắt đầu test
        cleanUpTestData();
    }

    @After
    public void tearDown() {
        // Dọn rác sau khi test xong
        cleanUpTestData();
    }

    private void cleanUpTestData() {
        // Xóa Customer trước, User sau (để tránh lỗi Khóa ngoại)
        String sqlDeleteCustomer = "DELETE FROM Customers WHERE UserID IN (SELECT UserID FROM Users WHERE Username = ?)";
        String sqlDeleteUser = "DELETE FROM Users WHERE Username = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement psCus = conn.prepareStatement(sqlDeleteCustomer);
             PreparedStatement psUser = conn.prepareStatement(sqlDeleteUser)) {
            
            psCus.setString(1, TEST_PHONE);
            psCus.executeUpdate();

            psUser.setString(1, TEST_PHONE);
            psUser.executeUpdate();
        } catch (Exception e) {
            // Ignored
        }
    }

    @Test
    public void testCheckUserExists_NotFound() {
        // Test 1: SĐT chưa tồn tại
        boolean exists = userDAO.checkUserExists("0000000000"); // SĐT rác
        Assert.assertFalse("SĐT không tồn tại phải trả về false", exists);
    }

    @Test
    public void testRegisterCustomer_Success() {
        // Test 2: Đăng ký thành công
        User user = new User();
        user.setUsername(TEST_PHONE);
        user.setPasswordHash("hashed_password_abc");
        user.setRole("Customer");

        Customer cus = new Customer();
        cus.setFullName("Test User");
        cus.setPhone(TEST_PHONE);
        cus.setLicensePlate("99A-99999");

        boolean isSuccess = userDAO.registerCustomer(user, cus);
        Assert.assertTrue("Đăng ký với dữ liệu chuẩn phải thành công (true)", isSuccess);

        // Kiểm tra xem dữ liệu có thực sự chui vào DB không
        boolean isExistNow = userDAO.checkUserExists(TEST_PHONE);
        Assert.assertTrue("Sau khi đăng ký xong, kiểm tra lại phải thấy user trong DB", isExistNow);
    }

    @Test
    public void testRegisterCustomer_DuplicatePhone() {
        // Test 3: Cố tình đăng ký trùng SĐT
        // Chạy lần 1 để bơm data vào
        User user = new User();
        user.setUsername(TEST_PHONE);
        user.setPasswordHash("hash1");
        user.setRole("Customer");

        Customer cus = new Customer();
        cus.setFullName("Test 1");
        cus.setPhone(TEST_PHONE);
        cus.setLicensePlate("11A-11111");

        userDAO.registerCustomer(user, cus);

        // Chạy lần 2 với cùng SĐT
        User user2 = new User();
        user2.setUsername(TEST_PHONE);
        user2.setPasswordHash("hash2");
        user2.setRole("Customer");

        Customer cus2 = new Customer();
        cus2.setFullName("Test 2");
        cus2.setPhone(TEST_PHONE);
        cus2.setLicensePlate("22A-22222");

        boolean isSuccess2 = userDAO.registerCustomer(user2, cus2);
        Assert.assertFalse("Đăng ký trùng SĐT phải trả về false", isSuccess2);
    }

    @Test
    public void testLogin_Success() {
        // Tạo user để test
        User user = new User();
        user.setUsername(TEST_PHONE);
        user.setPasswordHash("login_hash_123");
        user.setRole("Customer");
        Customer cus = new Customer();
        cus.setFullName("Login Test");
        cus.setPhone(TEST_PHONE);
        cus.setLicensePlate("99L-99999");
        userDAO.registerCustomer(user, cus);

        // Đăng nhập với đúng pass
        User loggedInUser = userDAO.login(TEST_PHONE, "login_hash_123");
        Assert.assertNotNull("Đăng nhập với đúng tài khoản/mật khẩu phải trả về User", loggedInUser);
        Assert.assertEquals(TEST_PHONE, loggedInUser.getUsername());
        Assert.assertEquals("Customer", loggedInUser.getRole());
    }

    @Test
    public void testLogin_WrongPassword() {
        User loggedInUser = userDAO.login(TEST_PHONE, "wrong_hash");
        Assert.assertNull("Đăng nhập sai mật khẩu phải trả về null", loggedInUser);
    }

    @Test
    public void testLogin_UserNotFound() {
        User loggedInUser = userDAO.login("0000000000", "any_hash");
        Assert.assertNull("Đăng nhập bằng tài khoản không tồn tại phải trả về null", loggedInUser);
    }
}
