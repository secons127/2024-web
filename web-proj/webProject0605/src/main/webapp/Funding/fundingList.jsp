<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board List</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/design/fundingList.css">
</head>
<body>
   <div class="container">
      <h1>Funding List</h1>
      
      <!-- 검색 폼 -->
      <form action="fundingList.jsp" method="get">
         <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" value="<%= request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "" %>">
         <button type="submit">검색</button>
      </form>

      <div class="funding-list">
         <%
         // Database connection parameters
         String url = "jdbc:mysql://localhost:3306/User";
         String username = "root";
         String password = "wjdtjgus04";

         Connection conn = null;
         Statement stmt = null;
         ResultSet rs = null;

         // 페이징 관련 변수
         int currentPage = 1;
         int recordsPerPage = 10;
         if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
         }
         int startRecord = (currentPage - 1) * recordsPerPage;

         int totalRecords = 0;
         int totalPages = 0;

         String searchKeyword = request.getParameter("searchKeyword");

         try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
            stmt = conn.createStatement();

            // 검색 조건에 따른 전체 레코드 수를 계산
            String countSql = "SELECT COUNT(*) FROM board";
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                countSql += " WHERE productName LIKE '%" + searchKeyword + "%'";
            }
            ResultSet countRs = stmt.executeQuery(countSql);
            if (countRs.next()) {
               totalRecords = countRs.getInt(1);
            }
            totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

            // 검색 조건에 따른 페이징 쿼리
            String sql = "SELECT * FROM board";
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                sql += " WHERE productName LIKE '%" + searchKeyword + "%'";
            }
            sql += " LIMIT " + startRecord + ", " + recordsPerPage;
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
               int id = rs.getInt("id");
               String userId = rs.getString("userId");
               String productName = rs.getString("productName");
               Timestamp creationTime = rs.getTimestamp("creationTime");
               BigDecimal achievementRate = rs.getBigDecimal("achievementRate");
               int remainingDays = rs.getInt("remainingDays");
               int amountRaised = rs.getInt("amountRaised");
         %>
         <div class="funding-card">
            <div class="image-placeholder"></div>
            <div class="category"><%= userId %></div>
            <div class="title"><a href="fundingDetail.jsp?id=<%= id %>&userId=<%= userId %>&productName=<%= productName %>"><%= productName %></a></div>
            <div class="description">Creation Time: <%= creationTime %></div>
            <div class="funding-info">
               <div class="percentage"><%= achievementRate %>%</div>
               <div class="amount"><%= amountRaised %>원</div>
               <div class="days-left"><%= remainingDays %>일 남음</div>
            </div>
         </div>
         <%
            }
         } catch (Exception e) {
            e.printStackTrace();
         } finally {
            if (rs != null)
               try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null)
               try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null)
               try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
         }
         %>
      </div>
      <div class="pagination">
         <% 
         for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
         %>
            <strong><%= i %></strong>
         <% } else { %>
            <a href="?page=<%= i %>&searchKeyword=<%= searchKeyword %>"><%= i %></a>
         <% }
         } %>
      </div>
   </div>
</body>
</html>



