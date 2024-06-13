<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
 <h2>새로운 게시물 추가</h2>
    <form action="${pageContext.request.contextPath}/BoardFormServlet" method="post" enctype="multipart/form-data">
        <label for="productName">제품명:</label><br>
        <input type="text" id="productName" name="productName"><br>
        
        <label for="productDescription">제품 설명:</label><br>
        <textarea id="productDescription" name="productDescription" rows="4" cols="50" required></textarea><br>
        
        <label for="reasonForPromotion">공구 이유:</label><br>
        <textarea id="reasonForPromotion" name="reasonForPromotion" rows="4" cols="50" required></textarea><br>
        
        <label for="imageUpload">이미지 업로드:</label><br>
        <input type="file" id="imageUpload" name="imageUpload"><br>
        
        <label for="startDate">시작일:</label><br>
        <input type="date" id="startDate" name="startDate" required><br>
        
        <label for="endDate">종료일:</label><br>
        <input type="date" id="endDate" name="endDate" required><br>
        
        <label for="paymentEndDate">결제 종료일:</label><br>
        <input type="date" id="paymentEndDate" name="paymentEndDate" required><br>
        
        <% 
            // 사용자의 세션에서 User 객체를 가져옴
            User user = (User) session.getAttribute("user");
            // User 객체가 null이 아니면 User의 ID를 가져옴
            String userId = (user != null) ? user.getId() : "";
        %>
        <!-- 가져온 사용자 ID를 숨겨진 입력 필드에 자동으로 채워 넣음 -->
        <input type="hidden" id="userId" name="userId" value="<%= userId %>"><br>
        
        <input type="submit" value="제출">
    </form>
    
<script>
document.getElementById("dateForm").addEventListener("submit", function(event) {
  event.preventDefault(); // 폼 제출 기본 동작을 중지합니다.
  
  // 선택한 날짜 값을 가져옵니다.
  var startDate = document.getElementById("startDate").value;
  var endDate = document.getElementById("endDate").value;
  var paymentEndDate = document.getElementById("paymentEndDate").value;
  
  // 콘솔에 선택한 날짜 값 출력
  console.log("시작일:", startDate);
  console.log("종료일:", endDate);
  console.log("결제 종료일:", paymentEndDate);
  
  // 여기에 선택한 날짜 값을 서버로 전송하는 코드를 추가할 수 있습니다.
});
</script>
    
</body>
</html>