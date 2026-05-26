package controller;

import dao.UserDAO;
import dto.Customer;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.MockedConstruction;
import service.UserService;

import static org.mockito.Mockito.*;
import static org.mockito.ArgumentMatchers.*;

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

        // Giả lập UserService
        try (MockedConstruction<UserService> mockedService = mockConstruction(UserService.class, (mock, context) -> {
            when(mock.processRegistration(anyString(), anyString(), anyString(), anyString())).thenReturn(1); // 1 = Thành công
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

        try (MockedConstruction<UserService> mockedService = mockConstruction(UserService.class, (mock, context) -> {
            // Giả lập DB báo lỗi trùng SĐT (0 = Trùng SĐT)
            when(mock.processRegistration(anyString(), anyString(), anyString(), anyString())).thenReturn(0);
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

        try (MockedConstruction<UserService> mockedService = mockConstruction(UserService.class, (mock, context) -> {
            // Giả lập hệ thống bận (-1 = Lỗi)
            when(mock.processRegistration(anyString(), anyString(), anyString(), anyString())).thenReturn(-1);
        })) {
            servlet.doPost(request, response);

            verify(request).setAttribute("errorMessage", "Hệ thống đang bận, vui lòng thử lại sau!");
            verify(requestDispatcher).forward(request, response);
        }
    }
}
