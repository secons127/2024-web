<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>후원하기</title>
<link rel="stylesheet" href="donate.css">
</head>
<body>
    <%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Log/loginForm.jsp");
        return;
    }

    String boardId = request.getParameter("boardId");
    String totalAmount = request.getParameter("totalAmount");
    %>
    <div class="header">
        <h1>후원하기</h1>
    </div>
    <div class="donation-form">
        <form action="SubmitDonationServlet" method="post">
            <input type="hidden" name="boardId" value="<%= boardId %>">
            <input type="hidden" name="totalAmount" value="0">

            <h3>선물 정보</h3>
            <div class="gift-info">
                <p>선물 구성:</p>
                <p>선물 금액: <%= totalAmount %>원</p>
            </div>

            <h3>추가 후원금 (선택)</h3>
            <div class="additional-donation">
                <input type="number" name="additionalAmount" value="<%= totalAmount %>" min="1"> 원
                <p>추가 후원으로 프로젝트를 더 응원할 수 있어요!</p>
            </div>

            <h3>후원자 정보</h3>
            <div class="sponsor-info">
                <p>입력자: <%= user.getName() %></p>
                <p>전화번호: <%= user.getPhoneNumber() %></p>
            </div>

            <h3>배송지</h3>
            <div class="shipping-info">
                <p>주소: <%= user.getAddress() %></p>
                <button type="button" onclick="changeAddress()">주소 변경</button>
            </div>

            <h3>결제 수단</h3>
            <div class="payment-method">
                <input type="radio" name="paymentMethod" value="카드" checked> 카드 간편결제
                <input type="radio" name="paymentMethod" value="네이버페이"> 네이버페이
                <input type="radio" name="paymentMethod" value="계좌이체"> 계좌이체
            </div>

            <h3>후원 확인</h3>
            <div class="donation-confirm">
                <p>최종 후원 금액: <%= totalAmount %>원</p>
                <label>
                    <input type="checkbox" name="agreement" required> 개인정보 및 제3자 정보 제공에 동의합니다.
                </label>
            </div>

            <button type="submit" class="donate-button">후원하기</button>
        </form>
    </div>
    <script>
        function changeAddress() {
            // 주소 변경 기능 구현
            alert("주소 변경 기능은 아직 구현되지 않았습니다.");
        }
    </script>
</body>
</html>




