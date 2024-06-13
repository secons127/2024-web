package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/SubmitSponsorshipServlet")
public class SubmitSponsorshipServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int boardId = Integer.parseInt(request.getParameter("boardId"));
        String userId = request.getParameter("userId");
        String sponsorName = request.getParameter("sponsorName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        double amount = Double.parseDouble(request.getParameter("amount"));
        double additionalAmount = request.getParameter("additionalAmount").isEmpty() ? 0 : Double.parseDouble(request.getParameter("additionalAmount"));
        String paymentMethod = request.getParameter("paymentMethod");

        String dbURL = "jdbc:mysql://localhost:3306/User";
        String dbUser = "root";
        String dbPass = "wjdtjgus04";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            // 후원 정보 삽입
            try (PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO Sponsorship (boardId, userId, sponsorName, phoneNumber, address, amount, additionalAmount, paymentMethod) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")) {
                stmt.setInt(1, boardId);
                stmt.setString(2, userId);
                stmt.setString(3, sponsorName);
                stmt.setString(4, phoneNumber);
                stmt.setString(5, address);
                stmt.setDouble(6, amount);
                stmt.setDouble(7, additionalAmount);
                stmt.setString(8, paymentMethod);
                stmt.executeUpdate();
            }

            // `sponsorCount` 업데이트
            try (PreparedStatement stmt = conn.prepareStatement(
                "UPDATE board SET sponsorCount = sponsorCount + 1 WHERE id = ?")) {
                stmt.setInt(1, boardId);
                stmt.executeUpdate();
            }

            // `achievementRate` 업데이트
            try (PreparedStatement stmt = conn.prepareStatement(
                "UPDATE board SET achievementRate = (SELECT SUM(amount + additionalAmount) FROM Sponsorship WHERE boardId = ?) / targetAmount * 100 WHERE id = ?")) {
                stmt.setInt(1, boardId);
                stmt.setInt(2, boardId);
                stmt.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/Funding/fundingList.jsp");
    }
}


