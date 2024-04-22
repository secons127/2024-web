<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="01Link.jsp?end=hi&st=12"> 하이퍼링크로 파라미터 전송하기(get방식) </a>

<h1> 로그인 </h1>
<form method="post" action="01loginProcess.jsp">
	이름 : <input type="text" name="name" placeholder="한글이름"> <br>
	아이디 : <input type="text" name="id"><br>
	암호 : <input type="password" name="pw"><br>
	<input type="submit" value="로그인"> 
	<input type="reset" value="취소"><br>
	성별 : 남<input type="radio" name="gender" value="g1">	
		  여<input type="radio" name="gender" value="g2"> <br>
	관심사 : 게임<input type="checkbox" name="inter" value="i1">
		   영화<input type="checkbox" name="inter" value="i2">
		   독서<input type="checkbox" name="inter" value="i3">
</form>
테스트 : <input type="text">

</body>
</html>