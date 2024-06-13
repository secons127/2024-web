<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Funding Donate</title>
<link rel="stylesheet" href="fundingDetail.css">
</head>
<body>
<%
    String totalAmount = (String) request.getAttribute("totalAmount");

    if (totalAmount != null && !totalAmount.isEmpty()) {
        out.println("<p>후원이 완료되었습니다. 총 후원 금액: " + totalAmount + "원</p>");
    } else {
        out.println("<p>후원 정보를 받아올 수 없습니다.</p>");
    }
%>
<a href="fundingList.jsp">펀딩 목록으로 돌아가기</a>
</body>
</html>




