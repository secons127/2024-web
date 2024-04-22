<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8" errorPage="01errorMessage.jsp"%>
    
<%! public int add(int n1, int n2){
		return n1+n2;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp 구성요소</title>
</head>
<body>

<h1> jsp파일 요소 알아보기 </h1>
<%
	//int myAge= Integer.parseInt(request.getParameter("age"))+10;
	//out.println("10년후의 당신 나이는"+myAge+"입니다.");
	int result=add(10,30);
%>

계산의 결과값은 <%= result %> 입니다.

</body>
</html>