function addContent() {
    var contentGroup = document.querySelector('.content-group');
    var contentItem = document.createElement('div');
    contentItem.className = 'content-item';
    contentItem.innerHTML = `
        <input type="text" name="title[]" placeholder="제목 입력하기" required>
        <input type="text" name="subtitle[]" placeholder="소제목 입력하기" required>
        <textarea class="tinymce" name="content[]" placeholder="내용 입력하기 (글자 입력하고 글자 색 바꾸고 밑줄 그리고 이미지 추가하기 등등)" required></textarea>
        <button type="button" class="remove-btn" onclick="removeItem(this)">X</button>
    `;
    contentGroup.insertBefore(contentItem, contentGroup.lastElementChild);
    tinymce.init({
        selector: 'textarea.tinymce',
        plugins: 'advlist autolink lists link image charmap print preview hr anchor pagebreak',
        toolbar_mode: 'floating',
        toolbar: 'undo redo | formatselect | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | image'
    });
}

function addProduct() {
    var productGroup = document.querySelector('.product-group');
    var productItem = document.createElement('div');
    productItem.className = 'product-item';
    productItem.innerHTML = `
        <input type="text" name="productName[]" placeholder="제품 소개" required>
        <input type="file" name="productImage[]" accept="image/*">
        <input type="number" name="productPrice[]" placeholder="가격" required>
        <button type="button" class="remove-btn" onclick="removeItem(this)">X</button>
    `;
    productGroup.insertBefore(productItem, productGroup.lastElementChild);
}

function removeItem(button) {
    button.parentElement.remove();
}
