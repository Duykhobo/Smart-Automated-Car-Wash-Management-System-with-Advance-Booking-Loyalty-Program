package controller;

import dao.UserDAO;
import dto.Customer;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServletTest {

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private RequestDispatcher requestDispatcher;

    private RegisterServlet servlet;

    @Before
    public void setUp() {
        // Khởi tạo các biến @Mock
        MockitoAnnotations.openMocks(this);
        servlet = new RegisterServlet();
    }

    @Test
    public void testDoPost_Success() throws Exception {
        when(request.getParameter("fullname")).thenReturn("John Doe");
        when(request.getParameter("phone")).thenReturn("0888888888");
        when(request.getParameter("plate")).thenReturn("30A-12345");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getRequestDispatcher("login.jsp")).thenReturn(requestDispatcher);

        // Giả lập UserDAO
        try ( var mockedDAO = mockConstruction(UserDAO.class, (mock, context) -> {
            when(mock.checkUserExists("0888888888")).thenReturn(false);
            when(mock.registerCustomer(any(), any())).thenReturn(true);
        })) {
            servlet.doPost(request, response);

            verify(request).setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            verify(requestDispatcher).forward(request, response);
        }
    }

    @Test
    public void testDoPost_DuplicatePhone() throws Exception {
        when(request.getParameter("fullname")).thenReturn("John Doe");
        when(request.getParameter("phone")).thenReturn("0999999999");
        when(request.getParameter("plate")).thenReturn("30A-12345");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getRequestDispatcher("register.jsp")).thenReturn(requestDispatcher);

        try ( var mockedDAO = mockConstruction(UserDAO.class, (mock, context) -> {
            // Giả lập DB báo lỗi trùng SĐT
            when(mock.checkUserExists("0999999999")).thenReturn(true);
        })) {
            servlet.doPost(request, response);

            verify(request).setAttribute("errorMessage", "Số điện thoại này đã được đăng ký!");
            verify(request, atLeastOnce()).setAttribute(eq("user"), any(Customer.class));
            verify(requestDispatcher).forward(request, response);
        }
    }

    @Test
    public void testDoPost_SystemBusy() throws Exception {
        when(request.getParameter("fullname")).thenReturn("John Doe");
        when(request.getParameter("phone")).thenReturn("0777777777");
        when(request.getParameter("plate")).thenReturn("30A-12345");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getRequestDispatcher("register.jsp")).thenReturn(requestDispatcher);

        try ( var mockedDAO = mockConstruction(UserDAO.class, (mock, context) -> {
            when(mock.checkUserExists("0777777777")).thenReturn(false);
            // Giả lập Database chết hoặc Transaction lỗi (trả về false)
            when(mock.registerCustomer(any(), any())).thenReturn(false);
        })) {
            servlet.doPost(request, response);

            verify(request).setAttribute("errorMessage", "Hệ thống đang bận, vui lòng thử lại sau!");
            verify(requestDispatcher).forward(request, response);
        }
    }
}
