// document.addEventListener('DOMContentLoaded', function () {
//     initializeMatchResults();
// });

const dataContainer = document.getElementById('data-container');
const prevPageBtn = document.getElementById('prevPage');
const nextPageBtn = document.getElementById('nextPage');
const pageInfo = document.getElementById('pageInfo');
const mapDiv = document.getElementById('map');

let map;
let currentPage = 1;
const itemsPerPage = 6;
let matchResults = [];

function initializeMatchResults() {
    const storedResults = localStorage.getItem('matchResults');
    if (storedResults) {
        matchResults = JSON.parse(storedResults);
        renderMatchResults();
        initMap();
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
        // const match = item.match;
        const nonRentedData = item.nonRentedData || [];
        // match info

        // 假設您已經從後端接收到 matchDetailData 並且它包含 othersPreference
        const othersPreference = item.othersPreference;
        const commonInterests = item.commonInterests;
        console.log(commonInterests);

// 將興趣項目轉換為一個字符串，顯示用戶的興趣
        let interestHtmlArray = [];

        for (const [key, value] of Object.entries(othersPreference.interest)) {
            if (value === 1) {
                const interestText = convertInterestKeyToText(key);

                const isCommon = commonInterests[key] === 1;

                const interestHtml = `<span class="interest-item${isCommon ? ' common-interest' : ''}">${interestText}</span>`;

                interestHtmlArray.push(interestHtml);
            }
        }

        const interestHtmlString = interestHtmlArray.join(' ');

        const hopeString = othersPreference.hope;

        const hopeSection = hopeString ? `
            <h2>我希望我的室友: </h2>
            <div class="preference-details">
                ${hopeString}
            </div>
        ` : '';

// 動態填充 HTML 的興趣和希望部分
        const preferenceInfo = `
            <div class="preference-info">
                <h2>興趣: </h2>
                <div class="preference-details">
                    ${interestHtmlString}
                </div>
                ${hopeSection}
            </div>
        `;

        function convertInterestKeyToText(key) {
            const interestMap = {
                "sports": "運動",
                "travel": "旅遊",
                "reading": "閱讀",
                "wine_tasting": "品酒",
                "drama": "戲劇",
                "astrology": "占星",
                "programming": "程式設計",
                "hiking": "健行",
                "gaming": "遊戲",
                "painting": "繪畫",
                "idol_chasing": "追星",
                "music": "音樂"
            };
            return interestMap[key] || key;
        }


        const nonRentedInfo = nonRentedData.length > 0 ? `
            <div class="non-rented-info">
                <h3>尚未找到房子，房間需求：</h3>
                
                <!-- 显示相同的信息一次 -->
                <div class="non-rented-common">
                    <p><strong>想找房的區域:</strong> (${nonRentedData[0].region_sw_lat}, ${nonRentedData[0].region_sw_lng}) - (${nonRentedData[0].region_ne_lat}, ${nonRentedData[0].region_ne_lng})</p>
                    <p><strong>預計租期:</strong> ${nonRentedData[0].rental_period} 個月</p>
                </div>
                
                <!-- 循环显示不同的房型、价格 -->
                ${nonRentedData.map(nr => `
                    <div class="non-rented-item">
                        <p><strong>預算範圍（月）:</strong> ${nr.low_price} - ${nr.high_price} 元</p>
                        <p><strong>需求房型:</strong> ${nr.room_type}</p>
                    </div>
                `).join('')}
            </div>
        ` : '';

        return `
                <article class="matched-container">
                    ${preferenceInfo}
<!---->             <div id="map" style="height: 400px; width: 100%;"></div>
                    ${nonRentedInfo}
                </article>
            `;
    }).join('');

    if (map) {
        pageResults.forEach(item => {
            if (item.nonRentedData && item.nonRentedData.length > 0) {
                showNonRentedRegionOnMap(map, item.nonRentedData);
            }
        });
    }

    updatePagination();
}

function initMap() {
    console.log("initMap");

    const mapElement = document.getElementById("map");

    if (!mapElement) {
        console.error("Map container not found");
        return;
    }

    map = new google.maps.Map(mapElement, {
        center: {lat: 25.0330, lng: 121.5654}, // 可以根據需求調整
        zoom: 12,
    });

    console.log(map);

    // const nonRentedData = [
    //     {
    //         region_sw_lat: 25.0208,
    //         region_sw_lng: 121.5408,
    //         region_ne_lat: 25.0580,
    //         region_ne_lng: 121.6050,
    //         rental_period: 12
    //     }
    // ];

    google.maps.event.addListenerOnce(map, 'idle', function () {
        showNonRentedRegionOnMap(map);
        renderMatchResults();
    });
}

function showNonRentedRegionOnMap(map) {
    if (!map || !nonRentedData || nonRentedData.length === 0) {
        console.error("Invalid map or nonRentedData");
        return;
    }

    const swLat = nonRentedData[0].region_sw_lat;
    const swLng = nonRentedData[0].region_sw_lng;
    const neLat = nonRentedData[0].region_ne_lat;
    const neLng = nonRentedData[0].region_ne_lng;

    const bounds = new google.maps.LatLngBounds(
        new google.maps.LatLng(swLat, swLng),
        new google.maps.LatLng(neLat, neLng)
    );

    const rectangle = new google.maps.Rectangle({
        bounds: bounds,
        editable: false,
        draggable: false,
        strokeColor: '#FF0000',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#FF0000',
        fillOpacity: 0.35,
    });

    rectangle.setMap(map);

    /* const infoDiv = document.querySelector('.non-rented-common');
     if (infoDiv) {
         infoDiv.innerHTML = `
             <p><strong>想找房的區域:</strong> (${swLat}, ${swLng}) - (${neLat}, ${neLng})</p>
             <p><strong>預計租期:</strong> ${nonRentedData[0].rental_period} 個月</p>
         `;
     }*/
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

<!-- 在頁面的結尾處載入 API -->

// // 當文檔加載完成時調用
// document.addEventListener('DOMContentLoaded', function () {
//     // The initMap function will be called by the Google Maps API script
//     // Make sure the script is loaded after the DOM is ready
//     var script = document.createElement('script');
//     script.src = 'https://maps.googleapis.com/maps/api/js?key=' + apiKey + '&callback=initMap';
//     script.defer = true;
//     document.head.appendChild(script);
// });

<!--                    ${matchInfo}-->

// const matchInfo = `
//         <div class="match-info">
//             <h2>匹配用戶 ID: ${match.userId2}</h2>
//             <div class="match-details">
//                 ${renderMatchDetail('寵物偏好', match.petSameOrNot ? '相同' : '不同')}
//                 ${renderMatchDetail('噪音匹配度', (match.noisePercentage * 100).toFixed(2) + '%')}
//                 ${renderMatchDetail('天氣偏好', (match.weatherPercentage * 100).toFixed(2) + '%')}
//                 ${renderMatchDetail('興趣匹配度', (match.interestPercentage * 100).toFixed(2) + '%')}
//                 ${renderMatchDetail('濕度偏好', (match.humidPercentage * 100).toFixed(2) + '%')}
//                 ${renderMatchDetail('作息匹配度', (match.schedulePercentage * 100).toFixed(2) + '%')}
//                 ${renderMatchDetail('用餐地點', match.diningLocationSameOrNot ? '相同' : '不同')}
//                 ${renderMatchDetail('烹飪地點', match.cookLocationSameOrNot ? '相同' : '不同')}
//                 ${renderMatchDetail('用餐偏好', (match.diningPercentage * 100).toFixed(2) + '%')}
//                 ${renderMatchDetail('共用房間', match.shareroomSameOrNot ? '相同' : '不同')}
//                 ${renderMatchDetail('條件匹配度', (match.conditionPercentage * 100).toFixed(2) + '%')}
//                 ${renderMatchDetail('燈光偏好', (match.lightPercentage * 100).toFixed(2) + '%')}
//                 ${renderMatchDetail('鬧鐘偏好', (match.alarmPercentage * 100).toFixed(2) + '%')}
//                 ${renderMatchDetail('友誼偏好', (match.friendPercentage * 100).toFixed(2) + '%')}
//             </div>
//         </div>
//     `;