<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.User"%>
<%@ page session="true"%>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
	response.sendRedirect("Log/loginForm.jsp"); // 세션에 사용자 정보 없으면 로그인 페이지로 리다이렉트
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="updateModal.css">
<meta charset="UTF-8">
<title>User Management</title>


</head>
<body>
	<form action="UpdateUserInfoServlet" method="post">
		Nickname: <input type="text" name="nickName"
			value="<%=user.getName()%>">
		<button type="button" onclick="openModal('nickName')">Change</button>
		<br> Password: <input type="password" name="password"
			value="<%=user.getPassword()%>">
		<button type="button" onclick="openModal('password')">Change</button>
		<br> Phone Number: <input type="text" name="phoneNumber"
			value="<%=user.getPhoneNumber()%>">
		<button type="button" onclick="openModal('phoneNumber')">Change</button>
		<br> Address: <input type="text" name="address"
			value="<%=user.getAddress()%>">
		<button type="button" onclick="openModal('address')">Change</button>
		<br> Payment Method: <input type="text" name="paymentMethod"
			value="<%=user.getPaymentMethod()%>">
		<button type="button" onclick="openModal('paymentMethod')">Change</button>
		<br>
		 <button type="button" onclick="window.location.href='UserManagementDetail.jsp'"> 돌아가기</button>
		<button type="submit">Save Changes</button>
	</form>

	<!-- 모달창 구현 -->
	<div id="modal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<form id="modalForm" action="UpdateUserInfoServlet" method="post">
				<label id="modalLabel"></label> <input type="text" id="modalInput"
					name="newValue"> <input type="hidden" id="modalField"
					name="field">
				<button type="submit">변경</button>
			</form>
		</div>
	</div>

	<script>
		function openModal(field) {
			document.getElementById('modal').style.display = 'block';
			document.getElementById('modalField').value = field;
			document.getElementById('modalLabel').innerText = field + ' 변경';
		}

		function closeModal() {
			document.getElementById('modal').style.display = 'none';
		}
	</script>
</body>
</html>

