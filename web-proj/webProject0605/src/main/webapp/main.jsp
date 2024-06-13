<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.User"%>
<%@ page session="true"%>

<html>
<head>
<title>User Management</title>
</head>
<body>
<button onclick="window.location.href='UserManagementDetail.jsp'">회원정보</button>
	<button onclick="window.location.href='UserManagementDetail.jsp'">회원정보</button>
	<%
	User user = (User) session.getAttribute("user");
	if (user != null) {
	%>
	<!-- 세션에 'user' 객체가 있을 경우 로그아웃 버튼 표시 -->
	<button onclick="window.location.href='Log/logout.jsp'">로그아웃</button>
	<%
	} else {
	%>
	<!-- 세션에 'user' 객체가 없을 경우 로그인 버튼 표시 -->
	<button onclick="window.location.href='Log/loginForm.jsp'">로그인</button>
	<%
	}
	if (user != null && "Manager".equals(user.isAccessPermission())) {
	%>
	<button onclick="window.location.href='ManagerAccount/managerMain.jsp'">관리자
		페이지로 이동</button>
	<%
	}
	%>
	
	<a href="Funding/fundingForm.jsp">펀딩</a>
	<a href="Funding/fundingList.jsp">펀딩리스트</a>

</body>
</html>
