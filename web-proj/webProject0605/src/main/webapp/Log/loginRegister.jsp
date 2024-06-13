<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
body {
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: flex-start; /* 중앙이 아닌 상단에 정렬 */
	height: 100vh;
	margin: 0;
	background-color: #f0f2f5;
    padding-top: 20px;
    box-sizing: border-box; /* 패딩과 경계선을 포함한 전체 크기 */
}

.form-container {
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 400px;
	text-align: center;
	margin-top: 20px; /* 추가된 부분 */
}

h2 {
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 15px;
	text-align: left;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
}

/* 기본 스타일 */
.form-group input[type="text"],
.form-group input[type="password"],
.form-group input[type="tel"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
    transition: background-color 0.3s;
}

/* 입력 필드에 값이 있을 때 색깔 채우기 */
.form-group input[type="text"]:valid,
.form-group input[type="password"]:valid,
.form-group input[type="tel"]:valid {
    background-color: #e8f0fe; /* 입력 필드에 값이 있을 때 배경색 */
}

/* 입력 필드에 포커스가 있을 때 색깔 채우기 */
.form-group input[type="text"]:focus,
.form-group input[type="password"]:focus,
.form-group input[type="tel"]:focus {
    background-color: #e8f0fe; /* 포커스가 있을 때 배경색 */
}

.hidden {
	display: none;
}

.btn {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	border: none;
	border-radius: 5px;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
}

.btn:hover {
	background-color: #0056b3;
}

p {
	margin-top: 20px;
}

p a {
	color: #007bff;
	text-decoration: none;
}

p a:hover {
	text-decoration: underline;
}

.error {
	color: red;
	display: none;
}

.success {
	color: green;
	display: none;
}
</style>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
	function checkPasswords() {
		var password = document.getElementById("password").value;
		var checkPassword = document.getElementById("password-confirm").value;
		var errorElement = document.getElementById("passwordError");
		var successElement = document.getElementById("passwordSuccess");

		if (password !== checkPassword) {
			errorElement.style.display = "block";
			successElement.style.display = "none";
		} else {
			errorElement.style.display = "none";
			successElement.style.display = "block";
		}
	}

	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById('address').value = data.address;
				document.getElementById('detailed-address').focus();
			}
		}).open();
	}

	document.addEventListener('DOMContentLoaded', function() {
		const businessRadio = document.getElementById('business');
		const generalRadio = document.getElementById('general');
		const businessInfo = document.getElementById('business-info');

		businessRadio.addEventListener('change', function() {
			if (businessRadio.checked) {
				businessInfo.classList.remove('hidden');
			}
		});

		generalRadio.addEventListener('change', function() {
			if (generalRadio.checked) {
				businessInfo.classList.add('hidden');
			}
		});
	});

	function validateForm() {
		const password = document.getElementById("password").value;
		const checkPassword = document.getElementById("password-confirm").value;
		const userType = document
				.querySelector('input[name="user-type"]:checked').value;
		const userTypeHidden = document.getElementById("userTypeHidden");
		userTypeHidden.value = (userType === 'business') ? 'b' : 'u';

		if (password !== checkPassword) {
			document.getElementById("passwordError").style.display = "block";
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div class="form-container">
		<form action="${pageContext.request.contextPath}/UserRegister"
			method="post" onsubmit="return validateForm()">
			<h2>회원가입</h2>
			<div class="form-group">
				<label for="user-type">회원 유형:</label> <input type="radio"
					id="general" name="user-type" value="general" checked> 일반 <input
					type="radio" id="business" name="user-type" value="business">
				사업자
			</div>
			<input type="hidden" id="userTypeHidden" name="userTypeHidden">
			<div class="form-group">
				<label for="name">닉네임</label> <input type="text" id="name"
					name="name" required>
			</div>
			<div class="form-group">
				<label for="id">아이디</label> <input type="text" id="id" name="id"
					required>
			</div>
			<div class="form-group">
				<label for="password">비밀번호</label> <input type="password"
					id="password" name="password" required oninput="checkPasswords()">
			</div>
			<div class="form-group">
				<label for="password-confirm">비밀번호 확인</label> <input type="password"
					id="password-confirm" name="password-confirm" required
					oninput="checkPasswords()"> <span id="passwordError"
					class="error">비밀번호가 일치하지 않습니다.</span> <span id="passwordSuccess"
					class="success">비밀번호가 일치합니다.</span>
			</div>
			<div class="form-group">
				<label for="phoneNumber">전화번호</label> <input type="tel"
					id="phoneNumber" name="phoneNumber" required>
			</div>
			<div class="form-group">
				<label for="postcode">우편번호</label> <input type="text" id="postcode"
					name="postcode" readonly required>
				<button type="button" onclick="execDaumPostcode()">우편번호 찾기</button>
			</div>
			<div class="form-group">
				<label for="address">주소</label> <input type="text" id="address"
					name="address" readonly required>
			</div>
			<div class="form-group">
				<label for="detailed-address">상세 주소</label> <input type="text"
					id="detailed-address" name="detailed-address" required>
			</div>
			<div id="business-info" class="hidden">
				<div class="form-group">
					<label for="business-name">사업자 이름</label> <input type="text"
						id="business-name" name="business-name">
				</div>
				<div class="form-group">
					<label for="business-number">사업자 번호</label> <input type="text"
						id="business-number" name="business-number">
				</div>
			</div>
			<div class="form-group">
				<label for="paymentMethod">결제 방법(계좌번호)</label> <input type="text"
					id="paymentMethod" name="paymentMethod" required>
			</div>
			<button type="submit" class="btn">가입</button>
		</form>
		<p>
			이미 계정이 있으신가요? <a href="loginForm.jsp">login</a>
		</p>
	</div>
</body>
</html>




