<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%@ page import="java.io.IOException" %>
<%
    
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <link rel="stylesheet" type="text/css" href="Headerstyles.css">
</head>
<body>

<div class="container">
    <div class="header">
        <h1><a href="#">TITLE</a></h1>
        <div class="nav">
            <ul>
                <li><a href="#">HOME</a></li>
                <li><a href="#">QNA</a></li>
                <li><a href="#">ABOUT</a></li>
                <li><a href="#">CONTACT</a></li>
                <% 
                // 세션이 유효하고 로그인 상태가 있는지 확인하고 링크 텍스트 결정
                if (session != null && session.getAttribute("user") != null) {
                %>
                    <li><a href="../Log/logout.jsp">LOGOUT</a></li>
                <% 
                } else {
                %>
                    <li><a href="../Log/loginForm.jsp">LOGIN</a></li>
                <% 
                }
                %>
            </ul>
        </div>
    </div>1
</div>

</body>
</html>




