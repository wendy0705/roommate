const dataContainer = document.getElementById('data-container');
const prevPageBtn = document.getElementById('prevPage');
const nextPageBtn = document.getElementById('nextPage');
const pageInfo = document.getElementById('pageInfo');

let currentPage = 1;
const itemsPerPage = 6;
let matchResults = [];

function initializeMatchResults() {
    const storedResults = localStorage.getItem('matchResults');
    if (storedResults) {
        matchResults = JSON.parse(storedResults);
        renderMatchResults();
    } else {
        console.error('No match results found');
        dataContainer.innerHTML = '<p>無匹配結果可顯示</p>';
        prevPageBtn.style.display = 'none';
        nextPageBtn.style.display = 'none';
        pageInfo.style.display = 'none';
    }
}

function renderMatchResults() {
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const pageResults = matchResults.slice(startIndex, endIndex);

    dataContainer.innerHTML = pageResults.map(item => {
        const match = item.match;
        const nonRentedData = item.nonRentedData || [];

        const matchInfo = `
                <div class="match-info">
                    <h2>匹配用戶 ID: ${match.userId2}</h2>
                    <div class="match-details">
                        ${renderMatchDetail('寵物偏好', match.petSameOrNot ? '相同' : '不同')}
                        ${renderMatchDetail('噪音匹配度', (match.noisePercentage * 100).toFixed(2) + '%')}
                        ${renderMatchDetail('天氣偏好', (match.weatherPercentage * 100).toFixed(2) + '%')}
                        ${renderMatchDetail('興趣匹配度', (match.interestPercentage * 100).toFixed(2) + '%')}
                        ${renderMatchDetail('濕度偏好', (match.humidPercentage * 100).toFixed(2) + '%')}
                        ${renderMatchDetail('作息匹配度', (match.schedulePercentage * 100).toFixed(2) + '%')}
                        ${renderMatchDetail('用餐地點', match.diningLocationSameOrNot ? '相同' : '不同')}
                        ${renderMatchDetail('烹飪地點', match.cookLocationSameOrNot ? '相同' : '不同')}
                        ${renderMatchDetail('用餐偏好', (match.diningPercentage * 100).toFixed(2) + '%')}
                        ${renderMatchDetail('共用房間', match.shareroomSameOrNot ? '相同' : '不同')}
                        ${renderMatchDetail('條件匹配度', (match.conditionPercentage * 100).toFixed(2) + '%')}
                        ${renderMatchDetail('燈光偏好', (match.lightPercentage * 100).toFixed(2) + '%')}
                        ${renderMatchDetail('鬧鐘偏好', (match.alarmPercentage * 100).toFixed(2) + '%')}
                        ${renderMatchDetail('友誼偏好', (match.friendPercentage * 100).toFixed(2) + '%')}
                    </div>
                </div>
            `;

        const nonRentedInfo = nonRentedData.length > 0 ? `
            <div class="non-rented-info">
                <h4>尚未找到房子，房間需求：</h4>
                ${nonRentedData.map(nr => `
                    <div class="non-rented-item">
                        <p><strong>想找房的區域:</strong> (${nr.region_sw_lat}, ${nr.region_sw_lng}) - (${nr.region_ne_lat}, ${nr.region_ne_lng})</p>
                        <p><strong>預計租期:</strong> ${nr.rental_period} 個月</p>
                        <p><strong>預算範圍（月）:</strong> ${nr.low_price} - ${nr.high_price} 元</p>
                        <p><strong>需求房型:</strong> ${nr.room_type}</p>
                    </div>
                `).join('')}
            </div>
        ` : '';

        // 出租房屋信息
        const rentedHouseInfo = rentedHouseData.length > 0 ? `
            <div class="rented-house-info">
                <h4>已找到房子，出租房間訊息：</h4>
                ${rentedHouseData.map(rh => `
                    <div class="rented-house-item">
                        <p><strong>房屋名稱:</strong> ${rh.house_name}</p>
                        <p><strong>地址座標:</strong> (${rh.address_lat}, ${rh.address_lng})</p>
                        <p><strong>租金（月）:</strong> ${rh.price} 元</p>
                        <p><strong>可提供房型:</strong> ${rh.room_type}</p>
                    </div>
                `).join('')}
            </div>
        ` : '';

        return `
                <article class="match-container">
                    ${matchInfo}
                    ${nonRentedInfo}
                </article>
            `;
    }).join('');

    updatePagination();
}

function renderMatchDetail(label, value) {
    return `
            <div class="match-detail">
                <span class="detail-label">${label}:</span>
                <span class="detail-value">${value}</span>
            </div>
        `;
}

function updatePagination() {
    const totalPages = Math.ceil(matchResults.length / itemsPerPage);
    pageInfo.textContent = `第 ${currentPage} 頁，共 ${totalPages} 頁`;
    prevPageBtn.disabled = currentPage === 1;
    nextPageBtn.disabled = currentPage === totalPages;
}

prevPageBtn.addEventListener('click', () => {
    if (currentPage > 1) {
        currentPage--;
        renderMatchResults();
    }
});

nextPageBtn.addEventListener('click', () => {
    const totalPages = Math.ceil(matchResults.length / itemsPerPage);
    if (currentPage < totalPages) {
        currentPage++;
        renderMatchResults();
    }
});

// 當文檔加載完成時調用
document.addEventListener('DOMContentLoaded', initializeMatchResults);