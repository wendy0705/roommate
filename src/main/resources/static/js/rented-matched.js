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

    dataContainer.innerHTML = `
        <div class="matched-container">
            ${pageResults.map(item => {
        // const match = item.match;
        const nonRentedData = item.nonRentedData || [];
        // match info

        // 假設您已經從後端接收到 matchDetailData 並且它包含 othersPreference
        const othersPreference = item.othersPreference;
        const commonInterests = item.commonInterests;
        userId = item.userId;
        userNonRented = item.nonRentedData;

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

        const viewMoreButton = `<button class="view-more-button" data-user-id="${item.userId}">查看更多</button>`;

        return `
            <article class="match-result">
                <div class="flex-container">
                    <div class="map-container">
                        <div id="map-${item.userId}" style="height: 400px; width: 100%;"></div>
                    </div>
                    <div class="info-container">
                        ${preferenceInfo}
                        <div class="non-rented-common">
                            <p><strong>預計租期:</strong> ${nonRentedData[0].rental_period} 個月</p>
                        </div>
                        <div class="button-container" style="text-align: right;">
                            ${viewMoreButton}
                            <button class="invite-button">聊聊邀請</button>
                        </div>
                    </div>
                </div>
                <div class="room-budget-table">
                    <table>
                        <thead>
                            <tr>
                                <th>需求房型</th>
                                <th>預算範圍（月）</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${nonRentedData.map(nr => `
                                <tr>
                                    <td>${nr.room_type}</td>
                                    <td>${nr.low_price} - ${nr.high_price} 元</td>
                                </tr>
                            `).join('')}
                        </tbody>
                    </table>
            </article>
                `;
    }).join('')}
        </div>
    `;

    updatePagination();
    addViewMoreEventListeners();
    pageResults.forEach(item => {
        const userId = item.userId;
        const nonRentedData = item.nonRentedData || [];

        initMap(userId, nonRentedData);
    });
}


function addViewMoreEventListeners() {
    const viewMoreButtons = document.querySelectorAll('.view-more-button');
    viewMoreButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            const userId = parseInt(event.target.getAttribute('data-user-id'), 10);
            // 將 userId 暫存到 localStorage 中
            localStorage.setItem('selectedUserId', userId);

            // 使用 fetch 請求 /compare 來載入 compare.html
            fetch('/compare')
                .then(response => response.text())
                .then(html => {
                    // 將 compare.html 的內容插入模態窗口
                    const modalContent = document.getElementById('modalDataContainer');
                    modalContent.innerHTML = html;

                    // 顯示模態窗口
                    const modal = document.getElementById('matchModal');
                    modal.style.display = "block";

                    // 增加關閉按鈕邏輯
                    const closeModal = document.querySelector('.close');
                    closeModal.addEventListener('click', () => {
                        modal.style.display = "none";
                        // 清空 localStorage 中的 selectedUserId
                        localStorage.removeItem('selectedUserId');
                    });

                    runCompareJS();
                })
                .catch(error => console.error('Error loading compare.html:', error));
        });
    });
}

function runCompareJS() {
    console.log("hi");
    // 此函數將執行 compare.js 的邏輯

    const storedUserId = localStorage.getItem('selectedUserId');
    console.log(storedUserId);
    if (storedUserId) {
        const userId = parseInt(storedUserId, 10);
        const storedResults = localStorage.getItem('matchResults');
        console.log(storedResults);
        const matchResults = storedResults ? JSON.parse(storedResults) : [];

        // 根據 userId 查找對應的匹配項
        const selectedItem = matchResults.find(item => item.userId === userId);
        console.log(selectedItem);
        if (selectedItem) {
            const userPreference = selectedItem.myPreference;
            const othersPreference = selectedItem.othersPreference;

            // 顯示比較數據
            showUser2Preferences(userPreference, othersPreference);
            generateScheduleTable(userPreference, othersPreference);

            document.getElementById('toggleButton').addEventListener('click', () => {
                comparePreferences(userPreference, othersPreference);
                toggleDisplay();
            });
        }
    }

}

function initMap(userId, nonRentedData) {
    const mapElement = document.getElementById(`map-${userId}`);

    if (!mapElement) {
        console.error(`Map container for user ${userId} not found`);
        return;
    }

    const map = new google.maps.Map(mapElement, {
        center: {lat: nonRentedData[0].region_sw_lat, lng: nonRentedData[0].region_sw_lng}, // 根據區域範圍來調整初始中心點
        zoom: 13
    });

    const bounds = new google.maps.LatLngBounds(
        new google.maps.LatLng(nonRentedData[0].region_sw_lat, nonRentedData[0].region_sw_lng),
        new google.maps.LatLng(nonRentedData[0].region_ne_lat, nonRentedData[0].region_ne_lng)
    );

    new google.maps.Rectangle({
        bounds: bounds,
        editable: false,
        draggable: false,
        strokeColor: '#FF0000',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        fillColor: '#FF0000',
        fillOpacity: 0.35,
    }).setMap(map);

}


function updatePagination() {
    const totalPages = Math.ceil(matchResults.length / itemsPerPage);
    pageInfo.textContent =


        `
    第 ${currentPage}
    頁，共 ${totalPages}
    頁`


    ;
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