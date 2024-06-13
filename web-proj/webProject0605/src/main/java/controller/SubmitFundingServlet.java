package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.FundingBoard;
import model.ProjectContent;
import model.ProjectProduct;
import model.User;

@WebServlet("/SubmitFundingServlet")
@MultipartConfig
public class SubmitFundingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션에서 사용자 정보 가져오기
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Log/loginForm.jsp");
            return;
        }

        // accessPermission 확인
        if (!"b".equals(user.getAccessPermission())) {
            request.setAttribute("errorMessage", "사업자가 아닙니다");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Funding/fundingForm.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // 폼 데이터 받기
        String userId = user.getId();
        String category = request.getParameter("category");
        String productName = request.getParameter("productName");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String paymentEndDate = request.getParameter("paymentEndDate");
        double targetAmount = Double.parseDouble(request.getParameter("targetAmount"));
        String selfIntroduction = request.getParameter("selfIntroduction");

        // FundingBoard 객체 생성
        FundingBoard fundingBoard = new FundingBoard(userId, category, productName, startDate, endDate, paymentEndDate, targetAmount, selfIntroduction);

        // 데이터베이스 연결
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/User", "root", "wjdtjgus04")) {
            // 프로젝트 정보 저장
            String projectSql = "INSERT INTO board (userId, category, productName, startDate, endDate, paymentEndDate, targetAmount, selfIntroduction) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement projectStatement = connection.prepareStatement(projectSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                projectStatement.setString(1, fundingBoard.getUserId());
                projectStatement.setString(2, fundingBoard.getCategory());
                projectStatement.setString(3, fundingBoard.getProductName());
                projectStatement.setString(4, fundingBoard.getStartDate());
                projectStatement.setString(5, fundingBoard.getEndDate());
                projectStatement.setString(6, fundingBoard.getPaymentEndDate());
                projectStatement.setDouble(7, fundingBoard.getTargetAmount());
                projectStatement.setString(8, fundingBoard.getSelfIntroduction());

                int affectedRows = projectStatement.executeUpdate();

                if (affectedRows > 0) {
                    // 프로젝트 ID 가져오기
                    try (var generatedKeys = projectStatement.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            long projectId = generatedKeys.getLong(1);

                            // 콘텐츠 저장
                            String[] titles = request.getParameterValues("title[]");
                            String[] subtitles = request.getParameterValues("subtitle[]");
                            String[] contents = request.getParameterValues("content[]");

                            String contentSql = "INSERT INTO project_contents (projectId, title, subtitle, content) VALUES (?, ?, ?, ?)";
                            try (PreparedStatement contentStatement = connection.prepareStatement(contentSql)) {
                                for (int i = 0; i < titles.length; i++) {
                                    contentStatement.setLong(1, projectId);
                                    contentStatement.setString(2, titles[i]);
                                    contentStatement.setString(3, subtitles[i]);
                                    contentStatement.setString(4, contents[i]);
                                    contentStatement.executeUpdate();
                                }
                            }

                            // 제품 정보 저장
                            String[] productNames = request.getParameterValues("productName[]");
                            String[] productPrices = request.getParameterValues("productPrice[]");
                            Part[] productImages = request.getParts().stream()
                                    .filter(part -> "productImage[]".equals(part.getName()))
                                    .toArray(Part[]::new);

                            String productSql = "INSERT INTO project_products (projectId, productName, productPrice, productImage) VALUES (?, ?, ?, ?)";
                            try (PreparedStatement productStatement = connection.prepareStatement(productSql)) {
                                for (int i = 0; i < productNames.length; i++) {
                                    productStatement.setLong(1, projectId);
                                    productStatement.setString(2, productNames[i]);
                                    productStatement.setInt(3, Integer.parseInt(productPrices[i]));
                                    if (productImages.length > i) {
                                        productStatement.setBinaryStream(4, productImages[i].getInputStream(), (int) productImages[i].getSize());
                                    } else {
                                        productStatement.setNull(4, java.sql.Types.BLOB);
                                    }
                                    productStatement.executeUpdate();
                                }
                            }

                            // 프로젝트 상세 페이지로 리다이렉트
                            response.sendRedirect(request.getContextPath() + "/FundingDetailServlet?boardId=" + projectId);
                            return;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 등록 후 펀딩 리스트 페이지로 이동
        response.sendRedirect(request.getContextPath() + "/Funding/fundingList.jsp");
    }
}
