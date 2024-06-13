package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/SubmitDonationServlet")
public class SubmitDonationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String boardIdStr = request.getParameter("boardId");
        String totalAmountStr = request.getParameter("totalAmount");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (boardIdStr == null || totalAmountStr == null || user == null) {
            response.sendRedirect("Funding/fundingList.jsp");
            return;
        }

        int boardId = Integer.parseInt(boardIdStr);
        double totalAmount = Double.parseDouble(totalAmountStr);

        String dbURL = "jdbc:mysql://localhost:3306/User";
        String dbUser = "root";
        String dbPass = "wjdtjgus04";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            conn.setAutoCommit(false);

            // 1. Update the amountRaised in the board table
            String updateBoardSql = "UPDATE board SET amountRaised = amountRaised + ? WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateBoardSql)) {
                stmt.setDouble(1, totalAmount);
                stmt.setInt(2, boardId);
                stmt.executeUpdate();
            }

            // 2. Calculate and update the achievementRate in the board table
            String updateRateSql = "UPDATE board SET achievementRate = (amountRaised / targetAmount) * 100 WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateRateSql)) {
                stmt.setInt(1, boardId);
                stmt.executeUpdate();
            }
            
         // 2. Calculate and update the achievementRate in the board table
            String updateCountSql = "UPDATE board SET sponsorCount = sponsorCount+1 WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateCountSql)) {
                stmt.setInt(1, boardId);
                stmt.executeUpdate();
            }

            // 3. Insert the sponsorship information into the sponsorship table
            String insertSponsorshipSql = "INSERT INTO sponsorship (boardId, userId, sponsorName, phoneNumber, address, amount, paymentMethod, sponsorDate) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
            try (PreparedStatement stmt = conn.prepareStatement(insertSponsorshipSql)) {
                stmt.setInt(1, boardId);
                stmt.setString(2, user.getId());
                stmt.setString(3, user.getName());
                stmt.setString(4, user.getPhoneNumber());
                stmt.setString(5, user.getAddress());
                stmt.setDouble(6, totalAmount);
                stmt.setString(7, "카드"); // 예시로 "카드"로 설정, 실제로는 다른 방식으로 받아야 함
                stmt.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("Funding/fundingList.jsp");
    }
}