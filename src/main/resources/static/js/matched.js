document.addEventListener('DOMContentLoaded', function () {
    // 在頁面加載時發送 GET 請求以獲取數據
    fetch('/api/1.0/rent/not-rented', {
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

            // 將數據轉換為 HTML 格式並插入
            dataContainer.innerHTML = data.map(match => `
            <div class="match-container">
                <h3>Match ID: ${match.id}</h3>
                <p>User 1 ID: ${match.userId1}</p>
                <p>User 2 ID: ${match.userId2}</p>
                <p>Pet Same or Not: ${match.petSameOrNot}</p>
                <p>Noise Percentage: ${(match.noisePercentage * 100).toFixed(2)}%</p>
                <p>Weather Percentage: ${(match.weatherPercentage * 100).toFixed(2)}%</p>
                <p>Interest Percentage: ${(match.interestPercentage * 100).toFixed(2)}%</p>
                <p>Humidity Percentage: ${(match.humidPercentage * 100).toFixed(2)}%</p>
                <p>Schedule Percentage: ${(match.schedulePercentage * 100).toFixed(2)}%</p>
                <p>Dining Location Same or Not: ${match.diningLocationSameOrNot}</p>
                <p>Cooking Location Same or Not: ${match.cookLocationSameOrNot}</p>
                <p>Dining Percentage: ${(match.diningPercentage * 100).toFixed(2)}%</p>
                <p>Share Room Same or Not: ${match.shareroomSameOrNot}</p>
                <p>Condition Percentage: ${(match.conditionPercentage * 100).toFixed(2)}%</p>
                <p>Light Percentage: ${(match.lightPercentage * 100).toFixed(2)}%</p>
                <p>Alarm Percentage: ${(match.alarmPercentage * 100).toFixed(2)}%</p>
                <p>Friendship Percentage: ${(match.friendPercentage * 100).toFixed(2)}%</p>
            </div>
        `).join('');
        })
        .catch((error) => {
            console.error('Error fetching data:', error);
        });
});
