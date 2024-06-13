function openModal(field) {
    document.getElementById('modal').style.display = 'block';
    document.getElementById('modalField').value = field;
    document.getElementById('modalLabel').innerText = field + ' 변경';
}

function closeModal() {
    document.getElementById('modal').style.display = 'none';
}
