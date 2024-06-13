package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import dao.Service;
import java.io.IOException;

@WebServlet("/UpdateUserInfoServlet")
public class UpdateUserInfo extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Log/loginForm.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String field = request.getParameter("field");
        String newValue = request.getParameter("newValue");

        switch(field) {
            case "nickName":
                user.setName(newValue);
                break;
            case "password":
                user.setPassword(newValue);
                break;
            case "phoneNumber":
                user.setPhoneNumber(newValue);
                break;
            case "address":
                user.setAddress(newValue);
                break;
            case "paymentMethod":
                user.setPaymentMethod(newValue);
                break;
        }

        Service service = new Service();
        service.updateUser(user);

        session.setAttribute("user", user);
        response.sendRedirect("UserManagementDetail.jsp");
    }
}

