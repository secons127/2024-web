<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.User" %>
<%
Object usersObject = request.getAttribute("users");
List<User> users;
if (usersObject instanceof List<?>) {
    @SuppressWarnings("unchecked")
    List<User> tempList = (List<User>) usersObject;
    users = tempList;
} else {
    users = new ArrayList<User>();
    System.out.println("빈 users 객체"); // 빈 리스트 초기화
}
%>

<html>
<head>
    <title>User Management</title>
</head>
<body>
    <h1>회원 관리</h1>
    <table border="1">
        <tr>
            <th>이름</th>
            <th>ID</th>
            <th>전화번호</th>
            <th>등급</th>
            <th>관리</th>
        </tr>
        <% for (User user : users) { %>
            <tr>
                <td><%= user.getName() %></td>
                <td><%= user.getId() %></td>
                <td><%= user.getPhoneNumber() %></td>
                <td><%= user.isAccessPermission() %></td>
                <td>
                    <form action="UserManagementServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="userId" value="<%= user.getId() %>">
                        <button type="submit">삭제</button>
                    </form>
                    <form action="UserManagementServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="userId" value="<%= user.getId() %>">
                        <select name="newGrade">
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="C">C</option>
                            <option value="Manager">Manager</option>
                        </select>
                        <button type="submit">등급 변경</button>
                    </form>
                </td>
            </tr>
        <% } %>
    </table>
    <a href="managerMain.jsp">관리자 메인 페이지로 돌아가기</a>
</body>
</html>