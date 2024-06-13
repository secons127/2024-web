<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Funding Form</title>
    <link rel="stylesheet" href="fundingForm.css">
    <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    <script>
        tinymce.init({
            selector: 'textarea.tinymce',
            plugins: 'advlist autolink lists link image charmap print preview hr anchor pagebreak',
            toolbar_mode: 'floating',
            toolbar: 'undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | image'
        });
    </script>
    <script src="fundingForm.js"></script>
</head>
<body>
    <div class="container">
        <h1>프로젝트 등록</h1>
        <form id="fundingForm" action="/SubmitFundingServlet" method="post" enctype="multipart/form-data">
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
                <label for="projectName">프로젝트명:</label>
                <input type="text" id="projectName" name="projectName" required>
            </div>
            <div class="form-group">
                <label for="targetAmount">목표 금액:</label>
                <input type="number" id="targetAmount" name="targetAmount" required>
            </div>
            <div class="form-group">
                <label for="fundingPeriod">펀딩 기간:</label>
                <input type="date" id="fundingStartDate" name="fundingStartDate" required>
                ~
                <input type="date" id="fundingEndDate" name="fundingEndDate" required>
            </div>
            <div class="form-group">
                <label for="paymentDate">결제일:</label>
                <input type="date" id="paymentDate" name="paymentDate" required>
            </div>
            <div class="content-group">
                <h3>콘텐츠</h3>
                <div class="content-item">
                    <input type="text" name="title[]" placeholder="제목 입력하기" required>
                    <input type="text" name="subtitle[]" placeholder="소제목 입력하기" required>
                    <textarea class="tinymce" name="content[]" placeholder="내용 입력하기 (글자 입력하고 글자 색 바꾸고 밑줄 그리고 이미지 추가하기 등등)" required></textarea>
                    <button type="button" class="remove-btn" onclick="removeItem(this)">X</button>
                </div>
                <button type="button" onclick="addContent()">추가하기</button>
            </div>
            <div class="product-group">
                <h3>제품 구성</h3>
                <div class="product-item">
                    <input type="text" name="productName[]" placeholder="제품 소개" required>
                    <input type="file" name="productImage[]" accept="image/*">
                    <input type="number" name="productPrice[]" placeholder="가격" required>
                    <button type="button" class="remove-btn" onclick="removeItem(this)">X</button>
                </div>
                <button type="button" onclick="addProduct()">추가하기</button>
            </div>
            <div class="form-group">
                <label for="selfIntroduction">자기소개와 어필:</label>
                <textarea id="selfIntroduction" name="selfIntroduction" class="tinymce" required></textarea>
            </div>
            <button type="submit">등록하기</button>
        </form>
    </div>
</body>
</html>

