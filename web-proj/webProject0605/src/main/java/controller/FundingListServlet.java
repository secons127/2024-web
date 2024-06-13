package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import dao.Service;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.FundingBoard;

@WebServlet("/FundingListServlet")
public class FundingListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int RECORDS_PER_PAGE = 10;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "jdbc:mysql://localhost:3306/User";
        String username = "root";
        String password = "wjdtjgus04";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
            stmt = conn.createStatement();
            int start = (page - 1) * RECORDS_PER_PAGE;
            String sql = "SELECT * FROM board LIMIT " + start + ", " + RECORDS_PER_PAGE;
            rs = stmt.executeQuery(sql);

            // Set the currentPage attribute
            request.setAttribute("currentPage", page);

            // Calculate the number of pages
            String countSql = "SELECT COUNT(*) FROM board";
            ResultSet countRs = stmt.executeQuery(countSql);
            countRs.next();
            int rowCount = countRs.getInt(1);
            int nOfPages = (rowCount + RECORDS_PER_PAGE - 1) / RECORDS_PER_PAGE;
            request.setAttribute("nOfPages", nOfPages);

            // Store the result set in the request scope
            request.setAttribute("resultSet", rs);

            request.getRequestDispatcher("boardList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
