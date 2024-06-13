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
import model.FundingBoard;

@WebServlet("/FundingDetail")
public class FundingDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String userId = request.getParameter("userId");
        String productName = request.getParameter("productName");

        String dbURL = "jdbc:mysql://localhost:3306/User";
        String dbUser = "root";
        String dbPass = "wjdtjgus04";

        FundingBoard board = null;

        System.out.println("Connecting to database...");
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            System.out.println("Database connection successful");
            String sql = "SELECT * FROM board WHERE id = ? AND userId = ? AND productName = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, Integer.parseInt(id));
                stmt.setString(2, userId);
                stmt.setString(3, productName);
                System.out.println("Executing query: " + stmt);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        board = new FundingBoard();
                        board.setId(rs.getInt("id"));
                        board.setUserId(rs.getString("userId"));
                        board.setProductName(rs.getString("productName"));
                        board.setStartDate(rs.getString("startDate"));
                        board.setEndDate(rs.getString("endDate"));
                        board.setPaymentEndDate(rs.getString("paymentEndDate"));
                        board.setRemainingDays(rs.getInt("remainingDays"));
                        board.setTargetAmount(rs.getDouble("targetAmount"));
                        board.setSponsorCount(rs.getInt("sponsorCount"));
                        board.setAchievementRate(rs.getLong("achievementRate"));
                        System.out.println("Board data loaded: " + board);
                    } else {
                        System.out.println("No board found with given criteria");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("board", board);
        request.getRequestDispatcher("fundingDetail.jsp").forward(request, response);
    }
}

