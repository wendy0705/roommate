const dataContainer = document.getElementById('data-container');
const prevPageBtn = document.getElementById('prevPage');
const nextPageBtn = document.getElementById('nextPage');
const pageInfo = document.getElementById('pageInfo');

let map;
let currentPage = 1;
const itemsPerPage = 6;
let matchResults = [];
let myId;

function initializeMatchResults() {
    const storedResults = sessionStorage.getItem('matchResults');
    myId = sessionStorage.getItem('myId');
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
            <h2>對室友的期待 </h2>
            <div class="preference-details">
                ${hopeString}
            </div>
        ` : '';

// 動態填充 HTML 的興趣和希望部分
        const preferenceInfo = `
            <div class="preference-info">
                <h2>興趣 </h2>
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
                            <button class="invite-button" data-invitee-id="${userId}">聊聊邀請</button>
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
        const nonRentedData = item.nonRentedData || [];
        const currentUserId = item.userId;

        initMap(currentUserId, nonRentedData);
    });
}


function addViewMoreEventListeners() {
    const viewMoreButtons = document.querySelectorAll('.view-more-button');
    viewMoreButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            const userId = parseInt(event.target.getAttribute('data-user-id'), 10);
            // 將 userId 暫存到 localStorage 中
            sessionStorage.setItem('selectedUserId', userId);

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

                    runCompareJS();
                })
                .catch(error => console.error('Error loading compare.html:', error));
        });
    });
}

function runCompareJS() {
    console.log("hi");
    // 此函數將執行 compare.js 的邏輯

    const storedUserId = sessionStorage.getItem('selectedUserId');
    console.log(storedUserId);
    if (storedUserId) {
        const userId = parseInt(storedUserId, 10);
        const storedResults = sessionStorage.getItem('matchResults');
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
        zoom: 12
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

document.getElementById('openAdjustModal').addEventListener('click', function () {
    const modal = document.getElementById('adjustModal');
    modal.style.display = "block";
});

function closeModal(modal) {
    modal.style.display = "none";
}

document.getElementById('openAdjustModal').addEventListener('click', () => {// 確保另一個窗口被關閉
    const modal = document.getElementById('adjustModal');
    modal.style.display = "block";
});

const adjustModal = document.getElementById('adjustModal');
const closeAdjustModal = document.querySelector('.adjust-close');
closeAdjustModal.onclick = function () {
    closeModal(adjustModal);
}

// 關閉匹配結果模態窗口
const matchModal = document.getElementById('matchModal');
const closeMatchModal = document.querySelector('.match-close');
closeMatchModal.onclick = function () {
    closeModal(matchModal);
}

closeAdjustModal.onclick = function () {
    adjustModal.style.display = "none";
}

let selectedOrder = []; // 保存選擇順序

const checkboxes = document.querySelectorAll('input[name="priority"]');
const selectedPriorityList = document.getElementById('selectedPriorityList');

// 更新選擇順序的函數
function updateSelectedPriorityList() {
    selectedPriorityList.innerHTML = '';

    // 依據選擇順序來顯示選項
    selectedOrder.forEach((selected, index) => {
        const listItem = document.createElement('li');
        listItem.textContent = `${index + 1}. ${selected.label}`; // 顯示 1. 2. 3. 的順序
        selectedPriorityList.appendChild(listItem);
    });

    // 檢查當前選擇數量
    if (selectedOrder.length < 3) {
        selectionError.style.display = 'block';
        selectionError.textContent = "請選擇三個指標";
    } else {
        selectionError.style.display = 'none';
    }
}

// 當選中或取消選擇 checkbox 時更新順序
checkboxes.forEach(checkbox => {
    checkbox.addEventListener('change', (event) => {
        const label = event.target.nextElementSibling.textContent; // 獲取該 checkbox 的標籤文本

        if (event.target.checked) {
            if (selectedOrder.length >= 3) {
                // 已經選了三個，不能再選
                event.target.checked = false;
                alert("最多只能選擇三個指標");
                return;
            }
            // 如果勾選，將它加入到順序中
            selectedOrder.push({
                value: parseInt(event.target.value),
                label: label
            });
        } else {
            // 如果取消選擇，則從順序中刪除
            selectedOrder = selectedOrder.filter(selected => selected.value !== parseInt(event.target.value));
        }

        updateSelectedPriorityList(); // 更新顯示
    });
});

document.getElementById('adjustForm').addEventListener('submit', function (event) {
    event.preventDefault();

    // 獲取所有選中的 checkbox 選項
    const selectedOptions = selectedOrder.map(selected => selected.value);

    const selectionError = document.getElementById('selectionError');

    if (selectedOptions.length !== 3) {
        alert("請選擇三個指標")
        return;
    } else {
        selectionError.style.display = 'none';
    }

    console.log(selectedOptions);

    const storedResults = sessionStorage.getItem('matchResults');
    if (!storedResults) {
        alert('無匹配結果可調整');
        return;
    }
    const parsedResults = JSON.parse(storedResults);
    const userIds = parsedResults.map(item => item.userId);

    const payload = {
        my_id: myId,
        user_ids: userIds,
        priority_indicators: selectedOptions
    };

    fetch(`api/1.0/analysis/adjust`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
    })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => {
                    throw new Error(text)
                });
            }
            return response.json();
        })
        .then(data => {
            console.log('重新排序後的匹配結果:', data);

            const sortedUserIds = data.map(item => item.userId);
            sortedMatchResults = sortedUserIds.map(id => parsedResults.find(item => item.userId === id));

            // 更新 matchResults 並重新存儲到 sessionStorage
            matchResults = sortedMatchResults;
            sessionStorage.setItem('matchResults', JSON.stringify(matchResults));

            // 關閉模態窗口
            adjustModal.style.display = "none";

            // 重置到第一頁
            currentPage = 1;
            renderMatchResults();
        })
        .catch(error => {
            console.error('錯誤:', error);
            alert('調整匹配權重時發生錯誤：' + error.message);
        });
});

function addInviteEventListeners() {

    const inviteButtons = document.querySelectorAll('.invite-button');

    inviteButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            const inviteeId = parseInt(event.target.getAttribute('data-invitee-id'), 10);  // 從按鈕中獲取 inviteeId

            // 構建邀請數據
            const invitationData = {
                inviter_id: myId,  // 假設 myId 是全局變量
                invitee_id: inviteeId
            };

            // 發送邀請
            // sendInvitation(invitationData, button);
        });
    });
}

// function sendInvitation(invitationData, button) {
//     // 禁用按鈕，防止重複點擊
//     button.disabled = true;
//
//     fetch('http://localhost:8081/chat/invite', {
//         method: 'POST',
//         headers: {
//             'Content-Type': 'application/json'
//         },
//         body: JSON.stringify(invitationData)
//     })
//         .then(response => response.json())
//         .then(data => {
//             console.log('邀請成功:', data);
//             button.textContent = '邀請已發送';  // 更新按鈕文字
//             button.classList.add('invitation-sent');  // 可添加自定義樣式
//             alert('邀請已發送');
//         })
//         .catch(error => {
//             console.error('邀請失敗:', error);
//             alert('發送邀請時出現錯誤');
//             button.disabled = false;  // 重新啟用按鈕
//         });
// }
//
//
