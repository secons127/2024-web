<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, model.User, model.FundingBoard"%>
<%@ page session="true"%>
<%
    User user = (User)session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("Log/loginForm.jsp"); // 세션에 사용자 정보 없으면 로그인 페이지로 리다이렉트
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management Detail</title>
</head>
<body>
    <h1>User Management Detail</h1>
    <form>
        Nickname: <input type="text" name="nickName" value="<%=user.getName()%>" readonly><br>
        Password: <input type="password" name="password" value="<%=user.getPassword()%>" readonly><br>
        Phone Number: <input type="text" name="phoneNumber" value="<%=user.getPhoneNumber()%>" readonly><br>
        Address: <input type="text" name="address" value="<%=user.getAddress()%>" readonly><br>
        Payment Method: <input type="text" name="paymentMethod" value="<%=user.getPaymentMethod()%>" readonly><br>
        <button type="button" onclick="window.location.href='UserManagement.jsp'">변경</button>
        <button type="button" onclick="window.location.href='main.jsp'">메인으로 돌아가기</button>
    </form>
    
     <%

    String userId = user.getId();
    List<FundingBoard> myProjects = new ArrayList<>();

    String dbURL = "jdbc:mysql://localhost:3306/User";
    String dbUser = "root";
    String dbPass = "wjdtjgus04";

    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
        String sql = "SELECT * FROM board WHERE userId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    FundingBoard project = new FundingBoard(
                        rs.getString("userId"),
                        rs.getString("category"),
                        rs.getString("productName"),
                        rs.getString("startDate"),
                        rs.getString("endDate"),
                        rs.getString("paymentEndDate"),
                        rs.getDouble("targetAmount"),
                        rs.getString("selfIntroduction")
                    );
                    project.setId(rs.getInt("id"));
                    project.setAmountRaised(rs.getDouble("amountRaised"));
                    project.setRemainingDays(rs.getInt("remainingDays"));
                    project.setSponsorCount(rs.getInt("sponsorCount"));
                    project.setAchievementRate(rs.getDouble("achievementRate"));
                    project.setCreationTime(rs.getString("creationTime"));
                    myProjects.add(project);
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    %>
    <h2><%= user.getName() %>님의 펀딩 프로젝트</h2>
    <%
    if (myProjects.isEmpty()) {
    %>
    <p>작성한 프로젝트가 없습니다.</p>
    <%
    } else {
    %>
    <table>
        <thead>
            <tr>
                <th>제품명</th>
                <th>카테고리</th>
                <th>목표 금액</th>
                <th>시작일</th>
                <th>종료일</th>
                <th>상세보기</th>
            </tr>
        </thead>
        <tbody>
            <%
            for (FundingBoard project : myProjects) {
            %>
            <tr>
                <td><%= project.getProductName() %></td>
                <td><%= project.getCategory() %></td>
                <td><%= project.getTargetAmount() %>원</td>
                <td><%= project.getStartDate() %></td>
                <td><%= project.getEndDate() %></td>
                <td><a href="${pageContext.request.contextPath}/Funding/fundingDetail.jsp?id=<%= project.getId() %>">보기</a></td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <%
    }
    %>
    
    
</body>
</html>
