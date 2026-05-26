package controller;

import dao.UserDAO;
import dto.User;
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
import javax.servlet.http.HttpSession;

public class LoginServletTest {

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private RequestDispatcher requestDispatcher;

    @Mock
    private HttpSession session;

    private LoginServlet servlet;

    @Before
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        servlet = new LoginServlet();
        when(request.getSession()).thenReturn(session);
        when(request.getRequestDispatcher(anyString())).thenReturn(requestDispatcher);
    }

    @Test
    public void testDoPost_MissingParams() throws Exception {
        // Edge case: Thiếu số điện thoại
        when(request.getParameter("phone")).thenReturn("");
        when(request.getParameter("password")).thenReturn("12345");

        servlet.doPost(request, response);

        verify(request).setAttribute("errorMessage", "Vui lòng nhập đầy đủ Số điện thoại và Mật khẩu!");
        verify(requestDispatcher).forward(request, response);
    }

    @Test
    public void testDoPost_SuccessCustomer() throws Exception {
        when(request.getParameter("phone")).thenReturn("0999999999");
        when(request.getParameter("password")).thenReturn("password123");

        User dummyUser = new User();
        dummyUser.setUsername("0999999999");
        dummyUser.setRole("Customer");

        try (MockedConstruction<UserService> mockedService = mockConstruction(UserService.class, (mock, context) -> {
            when(mock.processLogin(eq("0999999999"), anyString())).thenReturn(dummyUser);
        })) {
            servlet.doPost(request, response);

            verify(session).setAttribute("loggedInUser", dummyUser);
            verify(response).sendRedirect("home.jsp");
        }
    }

    @Test
    public void testDoPost_SuccessAdmin() throws Exception {
        when(request.getParameter("phone")).thenReturn("admin");
        when(request.getParameter("password")).thenReturn("admin123");

        User dummyUser = new User();
        dummyUser.setUsername("admin");
        dummyUser.setRole("Admin");

        try (MockedConstruction<UserService> mockedService = mockConstruction(UserService.class, (mock, context) -> {
            when(mock.processLogin(eq("admin"), anyString())).thenReturn(dummyUser);
        })) {
            servlet.doPost(request, response);

            verify(session).setAttribute("loggedInUser", dummyUser);
            verify(response).sendRedirect("admin/dashboard.jsp");
        }
    }

    @Test
    public void testDoPost_WrongCredentials() throws Exception {
        when(request.getParameter("phone")).thenReturn("0999999999");
        when(request.getParameter("password")).thenReturn("wrongpass");

        try (MockedConstruction<UserService> mockedService = mockConstruction(UserService.class, (mock, context) -> {
            // Service trả về null do sai mật khẩu
            when(mock.processLogin(anyString(), anyString())).thenReturn(null);
        })) {
            servlet.doPost(request, response);

            verify(request).setAttribute("errorMessage", "Số điện thoại hoặc Mật khẩu không chính xác!");
            verify(request).setAttribute("phone", "0999999999"); // Phải giữ lại SĐT trên UI
            verify(requestDispatcher).forward(request, response);
        }
    }
}
