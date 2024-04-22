<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	String i=request.getParameter("id");
	String p=request.getParameter("pw");
%>
<h1> 너의 아이디는 <%= i %>이고, 암호는 <%= p %>이다. </h1>

<h1> 축하합니다~ 로그인 성공입니다! </h1>
</body>
</html>