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
String lo=(String) application.getAttribute("loginCheck");
 if(lo != null){
	 // 로그인 성공 --> 로그아웃 버튼
%>
	님, 환영!
	<form action="02logout.jsp">
		<button type="submit">로그아웃</button>
	</form>
<%
 }else{
	 // 처음이거나 로그인 실패 --> 빈 폼
%>
	<form method="post" action="02loginProcess.jsp">
		아이디 : <input type="text" name="id"><br>
		암호 : <input type="password" name="pw"><br>
		<input type="submit" value="로그인"> 
	</form>
<%
 }
%>



</body>
</html>