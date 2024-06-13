package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.Service;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Service service = new Service();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 데이터베이스에서 회원 목록을 가져옴
        List<User> users = service.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("ManagerAccount/userManagement.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String userId = request.getParameter("userId");

        if ("delete".equals(action)) {
            // 회원 삭제 요청 처리
            service.deleteUser(userId);
        } else if ("update".equals(action)) {
            // 등급 변경 요청 처리
            String newGrade = request.getParameter("newGrade");
            service.updateUserGrade(userId, newGrade);
        }

        // 처리 후 회원 목록 페이지로 리다이렉트
        response.sendRedirect("UserManagementServlet");
    }
    }
