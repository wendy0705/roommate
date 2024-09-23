function getCookieValue(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}

document.addEventListener('DOMContentLoaded', function () {
    // 在頁面加載時發送 GET 請求以獲取數據
    const userId = getCookieValue('userId');
    //console.log(userId);
    ''

    fetch(`/api/1.0/rent/not-rented/${userId}`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        }
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to fetch data');
            }
            return response.json();
        })
        .then(data => {
            console.log('Fetched data:', data);

            // 在頁面上顯示數據 (假設有一個 <div> 來顯示數據)
            const dataContainer = document.getElementById('data-container');

            dataContainer.innerHTML = data.map(item => {
                const match = item.match;
                const nonRentedData = item.nonRentedData || [];
                const rentedHouseData = item.rentedHouseData || [];

                // 匹配度信息
                const matchInfo = `
                <div class="match-container">
                    <h3>Matched User ID: ${match.userId2}</h3>
                    <p><strong>寵物相同:</strong> ${match.petSameOrNot ? '是' : '否'}</p>
                    <p><strong>噪音匹配度:</strong> ${(match.noisePercentage * 100).toFixed(2)}%</p>
                    <p><strong>天氣偏好匹配度:</strong> ${(match.weatherPercentage * 100).toFixed(2)}%</p>
                    <p><strong>興趣匹配度:</strong> ${(match.interestPercentage * 100).toFixed(2)}%</p>
                    <p><strong>濕度匹配度:</strong> ${(match.humidPercentage * 100).toFixed(2)}%</p>
                    <p><strong>作息匹配度:</strong> ${(match.schedulePercentage * 100).toFixed(2)}%</p>
                    <p><strong>用餐地點相同:</strong> ${match.diningLocationSameOrNot ? '是' : '否'}</p>
                    <p><strong>烹飪地點相同:</strong> ${match.cookLocationSameOrNot ? '是' : '否'}</p>
                    <p><strong>用餐偏好匹配度:</strong> ${(match.diningPercentage * 100).toFixed(2)}%</p>
                    <p><strong>共用房間相同:</strong> ${match.shareroomSameOrNot ? '是' : '否'}</p>
                    <p><strong>條件匹配度:</strong> ${(match.conditionPercentage * 100).toFixed(2)}%</p>
                    <p><strong>燈光偏好匹配度:</strong> ${(match.lightPercentage * 100).toFixed(2)}%</p>
                    <p><strong>鬧鐘偏好匹配度:</strong> ${(match.alarmPercentage * 100).toFixed(2)}%</p>
                    <p><strong>友誼偏好匹配度:</strong> ${(match.friendPercentage * 100).toFixed(2)}%</p>
                </div>
            `;

                // 非出租房屋信息
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
            <div class="match-container">
                ${matchInfo}
                ${nonRentedInfo}
                ${rentedHouseInfo}
            </div>
        `;
            }).join('');
        })
        .catch((error) => {
            console.error('Error fetching data:', error);
        });
});
