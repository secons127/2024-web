<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Form</title>
</head>
<body>
<%@ page session="true" %>

<%
    User user = (User)session.getAttribute("user");
    ServletContext context = getServletContext();
    String savedId = (String) context.getAttribute("savedId");
    String savedPassword = (String) context.getAttribute("savedPassword");
    
    if (user == null) {
%>
    <div class="wrapper">
        <form method="post" action="${pageContext.request.contextPath}/UserLoginServlet">
            <h1>로그인</h1>
            <div class="input-box">
                <input type="text" name="id" placeholder="사용자 아이디" value="<%= savedId != null ? savedId : "" %>"><i class='bx bxs-user'></i>
                <br>
                <input type="password" name="password" placeholder="비밀번호" value="<%= savedPassword != null ? savedPassword : "" %>" required><i class='bx bxs-lock-alt'></i><br>
            </div>    
            <div class="remember-forgot">
                <label><input type="checkbox" name="remember">로그인 기억하기</label>
                <a href="#">비밀번호를 잊으셨나요?</a>
            </div>
            <button type="submit" class="btn">로그인</button>
            
          
            
            <div class="register-link">
                <p>계정이 없으신가요?<a href="loginRegister.jsp">회원가입</a></p>
            </div>
        </form>
    </div>
<% 
    } else {
        response.sendRedirect("../main.jsp");
    }
%>
</body>
</html>