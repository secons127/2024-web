<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board List</title>
<style>
table {
   width: 100%;
   border-collapse: collapse;
}

th, td {
   border: 1px solid black;
   padding: 8px;
   text-align: left;
}

th {
   background-color: #f2f2f2;
}
</style>
</head>
<body>
   <h1>Board List</h1>
   <table>
      <tr>
         <th>ID</th>
         <th>User ID</th>
         <th>Product Name</th>
         <th>Creation Time</th>
         <th>Achievement Rate</th>
         <th>Remaining Days</th>
      </tr>
      <%
      ResultSet rs = (ResultSet) request.getAttribute("resultSet");
      if (rs != null) {
         while (rs.next()) {
            int id = rs.getInt("id");
            String userId = rs.getString("userId");
            String productName = rs.getString("productName");
            Timestamp creationTime = rs.getTimestamp("creationTime");
            BigDecimal achievementRate = rs.getBigDecimal("achievementRate");
            int remainingDays = rs.getInt("remainingDays");
      %>
      <tr>
         <td><%=id%></td>
         <td><%=userId%></td>
         <td><%=productName%></td>
         <td><%=creationTime%></td>
         <td><%=achievementRate%></td>
         <td><%=remainingDays%></td>
      </tr>
      <%
         }
      }
      %>
   </table>

   <div>
      <a href="fundingForm.jsp">Go to Funding Form</a> | 
      <a href="../main.jsp">Go to Main</a>
   </div>

   <div>
      <%
      int currentPage = (Integer) request.getAttribute("currentPage");
      int nOfPages = (Integer) request.getAttribute("nOfPages");

      if (currentPage > 1) {
      %>
         <a href="BoardListServlet?page=<%=currentPage - 1%>">&lt; Previous</a>
      <%
      }

      for (int i = 1; i <= nOfPages; i++) {
         if (i == currentPage) {
      %>
            <strong><%=i%></strong>
      <%
         } else {
      %>
            <a href="BoardListServlet?page=<%=i%>"><%=i%></a>
      <%
         }
      }

      if (currentPage < nOfPages) {
      %>
         <a href="BoardListServlet?page=<%=currentPage + 1%>">Next &gt;</a>
      <%
      }
      %>
   </div>
</body>
</html>

