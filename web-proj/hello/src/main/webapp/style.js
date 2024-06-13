function selectReward(id) {
    const selectedRewardDiv = document.getElementById('selected-reward');
    let rewardHTML = '';

    switch(id) {
        case 1:
            rewardHTML = `
                <div class="reward-details">
                    <h3>1,000원 + 선물 없이 후원하기</h3>
                    <button class="choose-reward-button">선물 선택하기</button>
                </div>
            `;
            break;
        case 2:
            rewardHTML = `
                <div class="reward-details">
                    <h3>258,300원 + 4분 33초 패키지</h3>
                    <p>- 라이팅 박스 + 엽서 + 몽당 연필 2자루 + 4분 33초 종이 30장 + 모래시계 (x1)</p>
                    <button class="choose-reward-button">선물 선택하기</button>
                    <div>
                        <label>수량:</label>
                        <button onclick="changeQuantity(-1)">-</button>
                        <input type="text" id="quantity" value="1">
                        <button onclick="changeQuantity(1)">+</button>
                    </div>
                    <p>총 258,300원</p>
                </div>
            `;
            break;
        case 3:
            rewardHTML = `
                <div class="reward-details">
                    <h3>273,300원 + 패키지 2</h3>
                    <button class="choose-reward-button">선물 선택하기</button>
                </div>
            `;
            break;
        case 4:
            rewardHTML = `
                <div class="reward-details">
                    <h3>293,300원 + 패키지 3</h3>
                    <button class="choose-reward-button">선물 선택하기</button>
                </div>
            `;
            break;
    }

    selectedRewardDiv.innerHTML = rewardHTML;
}

function changeQuantity(amount) {
    const quantityInput = document.getElementById('quantity');
    let currentQuantity = parseInt(quantityInput.value);
    currentQuantity += amount;
    if (currentQuantity < 1) {
        currentQuantity = 1;
    }
    quantityInput.value = currentQuantity;
}
