<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Funding Form</title>
    <link rel="stylesheet" href="fundingForm.css">
    <script>
        let productCount = 1;

        function addProduct() {
            if (productCount >= 5) {
                alert("최대 5개의 제품만 추가할 수 있습니다.");
                return;
            }
            const productGroup = document.querySelector(".product-group");
            const productItem = document.createElement("div");
            productItem.className = "product-item";
            productItem.innerHTML = `
                <input type="text" name="productName[]" placeholder="제품 소개" required><br>
                <input type="file" name="productImage[]" accept="image/*"><br>
                <input type="number" name="productPrice[]" placeholder="가격" required><br>
                <button type="button" class="remove-btn" onclick="removeItem(this)">X</button>
            `;
            productGroup.appendChild(productItem);
            productCount++;
        }

        function removeItem(button) {
            const productItem = button.parentElement;
            productItem.remove();
            productCount--;
        }

        function addContent() {
            const contentGroup = document.querySelector(".content-group");
            const contentItem = document.createElement("div");
            contentItem.className = "content-item";
            contentItem.innerHTML = `
                <input type="text" name="title[]" placeholder="제목 입력하기" required><br>
                <input type="text" name="subtitle[]" placeholder="소제목 입력하기" required><br>
                <textarea name="content[]" placeholder="내용 입력하기 (글자 입력하고 글자 색 바꾸고 밑줄 그리고 이미지 추가하기 등등)"></textarea><br>
                <button type="button" class="remove-btn" onclick="removeItem(this)">X</button>
            `;
            contentGroup.appendChild(contentItem);
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>프로젝트 등록</h1>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p style="color: red;"><%= errorMessage %></p>
        <%
            }
        %>
        <form id="fundingForm" action="${pageContext.request.contextPath}/SubmitFundingServlet" method="post" enctype="multipart/form-data">
            <%
                // 세션에서 사용자 정보 가져오기
                User user = (User) session.getAttribute("user");
                if (user == null) { 
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/Log/loginForm.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // 사용자 정보가 있으면 폼 필드에 기본값으로 설정
                    String userId = user.getId();
            %>
                <input type="hidden" id="userId" name="userId" value="<%= userId %>">
            <% } %>
            <div class="form-group">
                <label for="category">카테고리 선택하기:</label>
                <select id="category" name="category" required>
                    <option value="">카테고리를 선택하세요</option>
                    <option value="category1">카테고리 1</option>
                    <option value="category2">카테고리 2</option>
                    <option value="category3">카테고리 3</option>
                    <!-- 더 많은 카테고리 옵션 추가 가능 -->
                </select>
            </div>
            <div class="form-group">
                <label for="productName">제품명:</label>
                <input type="text" id="productName" name="productName" required>
            </div>
            <div class="form-group">
                <label for="targetAmount">목표 금액:</label>
                <input type="number" id="targetAmount" name="targetAmount" required>
            </div>
            <div class="form-group">
                <label for="fundingPeriod">펀딩 기간:</label>
                <input type="date" id="startDate" name="startDate" required>
                ~
                <input type="date" id="endDate" name="endDate" required>
            </div>
            <div class="form-group">
                <label for="paymentEndDate">결제일:</label>
                <input type="date" id="paymentEndDate" name="paymentEndDate" required>
            </div>
            <div class="form-group">
                <label for="selfIntroduction">자기소개와 어필:</label><br>
                <textarea id="selfIntroduction" name="selfIntroduction" required></textarea>
            </div>
            <div class="content-group">
                <h3>콘텐츠</h3>
                <div class="content-item">
                    <input type="text" name="title[]" placeholder="제목 입력하기" required><br>
                    <input type="text" name="subtitle[]" placeholder="소제목 입력하기" required><br>
                    <textarea name="content[]" placeholder="내용 입력하기 (글자 입력하고 글자 색 바꾸고 밑줄 그리고 이미지 추가하기 등등)"></textarea><br>
                    <button type="button" class="remove-btn" onclick="removeItem(this)">X</button>
                </div>
                <button type="button" onclick="addContent()">추가하기</button>
            </div>
            <div class="product-group">
                <h3>제품 구성</h3>
                <div class="product-item">
                    <input type="text" name="productName[]" placeholder="제품 소개" required><br>
                    <input type="file" name="productImage[]" accept="image/*"><br>
                    <input type="number" name="productPrice[]" placeholder="가격" required><br>
                    <button type="button" class="remove-btn" onclick="removeItem(this)">X</button>
                </div>
                <button type="button" onclick="addProduct()">추가하기</button>
            </div>
            <button type="submit">등록하기</button>
        </form>
    </div>
</body>
</html>


