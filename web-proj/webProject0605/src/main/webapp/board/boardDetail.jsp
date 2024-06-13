<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Board Detail</title>
</head>
<body>
    <h1>Board Detail</h1>
    <p>Product Name: ${board.productName}</p>
    <p>Product Description: ${board.productDescription}</p>
    <p>Reason for Promotion: ${board.reasonForPromotion}</p>
    <p>Start Date: ${board.startDate}</p>
    <p>End Date: ${board.endDate}</p>
    <p>Payment End Date: ${board.paymentEndDate}</p>
    <p>Remaining Days: ${board.remainingDays}</p>
    <p>Image: <img src="${pageContext.request.contextPath}/uploads/${board.imageFileName}" alt="Product Image"></p>
</body>
</html>
