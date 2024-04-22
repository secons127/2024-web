<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String i=request.getParameter("id");
String p=request.getParameter("pw");
String gen=request.getParameter("gender");
String[] inter=request.getParameterValues("inter");
String interStr="";
for(int j=0; j < inter.length; j++){
	
	interStr += inter[j]+", ";
}

String result=null;
if(i.equals("dong")){
	result="로그인 성공!";
} else {
	result="로그인 실패 ㅜ";
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%= request.getParameter("name") %>
<h1> <%= result %></h1>
관심사 : <%= interStr %>


</body>
</html>