window.onload = function () {
    initMap();
    loadRoomTypes();

    const numberInputs = document.querySelectorAll('input[type="number"]');

    numberInputs.forEach(function (input) {
        input.addEventListener('wheel', function (e) {
            e.preventDefault(); // 禁用滑鼠滾輪調整數值
        });
    });
};

function loadRoomTypes() {
    fetch('/api/1.0/data/room-types')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            const roomTypeSelects = document.querySelectorAll('.roomType');

            roomTypeSelects.forEach(roomTypeSelect => {
                roomTypeSelect.innerHTML = ''; // 清空現有的選項
                data.forEach(roomType => {
                    const option = document.createElement('option');
                    option.value = roomType.id;
                    option.textContent = roomType.room_type;
                    roomTypeSelect.appendChild(option);
                });
            });
        })
        .catch(error => console.error('Error loading room types:', error));
}

function rentedInit(map) {
    const geocoder = new google.maps.Geocoder();

    // 定义 geocodeAddress 函数
    function geocodeAddress() {
        const address = document.getElementById('addressInput').value;
        console.log(address);

        geocoder.geocode({address: address}, function (results, status) {
            if (status === 'OK') {
                if (results && results[0]) {

                    const lat = results[0].geometry.location.lat();
                    const lng = results[0].geometry.location.lng();

                    document.getElementById("neLat").value = lat;
                    document.getElementById("neLng").value = lng;


                    // 设置地图中心
                    map.setCenter(results[0].geometry.location);

                    // 在地图上添加标记
                    new google.maps.Marker({
                        map: map,
                        position: results[0].geometry.location
                    });

                } else {
                    console.error('No valid results found');
                }
            } else {
                console.error('Geocode failed with status:', status);
            }
        });
    }

    // 确保在页面加载后绑定事件
    const geocodeButton = document.getElementById('geocodeButton');
    if (geocodeButton) {
        geocodeButton.addEventListener('click', geocodeAddress);
    } else {
        console.error('geocodeButton 元素未找到');
    }
}


let roomCounter = 1;
let roommateCounter = 1;

function addRoom() {
    // 選取房間容器
    const roomContainer = document.getElementById('roomContainer');

    const newRoom = document.createElement('div');
    newRoom.className = 'room';
    newRoom.innerHTML = `
        <div class="form-group">
            <label for="roomType">選擇房型：</label>
            <select class="roomType" name="roomType">
                <!-- 房型選項將動態加載 -->
            </select>
        </div>
        <div class="form-group">
            <label for="roomPrice">價格:</label>
            <input type="number" class="price" placeholder="12000">
        </div>
        <div class="form-group">
            <label for="roomPeriod">最短租期（月）:</label>
            <input type="number" class="period" placeholder="6">
        </div>
        <div class="button-group">
            <button type="button" class="add-room-btn">新增房間</button>
<!--            <button type="button" class="retract-room-btn">收回</button>-->
        </div>
    `;

    // 為新的按鈕添加事件監聽器
    const addButton = newRoom.querySelector('.add-room-btn');
    // const retractButton = newRoom.querySelector('.retract-room-btn');

    addButton.addEventListener('click', addRoom);
    // retractButton.addEventListener('click', function() {
    //     retractRoom(this);
    // });

    // 移除其他房間中的"新增房間"按鈕
    const existingRooms = roomContainer.querySelectorAll('.room');
    existingRooms.forEach(room => {
        const oldAddButton = room.querySelector('.add-room-btn');
        if (oldAddButton) {
            oldAddButton.remove();
        }
    });

    // 添加新的房間
    roomContainer.appendChild(newRoom);

    // 重新加載房型選項到新增的房型選擇框
    loadRoomTypesForNewRoom(newRoom.querySelector('.roomType'));
}

function addRoommate() {
    const currentRoommates = document.getElementById('currentRoommates');
    const newRoommate = document.createElement('div');
    newRoommate.className = 'roommate';
    newRoommate.innerHTML = `
        <div class="form-group">
            <label for="roommateRoomType">選擇房型：</label>
            <select class="roomType" name="roomType">
                <!-- 房型選項將動態加載 -->
            </select>
        </div>
        <div class="form-group description-group">
            <label for="roommateDescription">描述:</label>
            <div class="input-button-wrapper">
                <input type="text" class="description" placeholder="男，學生，安靜">
                <button type="button" class="add-roommate-btn">新增室友</button>
            </div>
        </div>
    `;

    const addButton = newRoommate.querySelector('.add-roommate-btn');
    // const retractButton = newRoommate.querySelector('.retract-roommate-btn');

    addButton.addEventListener('click', addRoommate);
    // retractButton.addEventListener('click', function () {
    //     retractRoommate(this);
    // });


    // 移除其他室友資訊中的"新增室友"按鈕
    const existingRoommates = currentRoommates.querySelectorAll('.roommate');
    existingRoommates.forEach(roommate => {
        const oldAddButton = roommate.querySelector('.add-roommate-btn');
        if (oldAddButton) {
            oldAddButton.remove();
        }
    });

    // 添加新的室友資訊
    currentRoommates.appendChild(newRoommate);

    // 重新加載房型選項到新增的房型選擇框
    loadRoomTypesForNewRoom(newRoommate.querySelector('.roomType'));
}


function loadRoomTypesForNewRoom(roomTypeSelect) {
    fetch('/api/1.0/data/room-types')
        .then(response => response.json())
        .then(data => {
            const roomTypeSelects = document.querySelectorAll('.roomType');
            const options = data.map(roomType =>
                `<option value="${roomType.id}">${roomType.room_type}</option>`
            ).join('');

            roomTypeSelects.forEach(select => {
                select.innerHTML = options;
            });
        })
        .catch(error => console.error('Error loading room types:', error));
}

// 提交表單
function submitForm() {
    // 獲取表單數據
    const userId = document.getElementById('userIdInput').value;
    const houseName = document.getElementById("houseName").value;
    const neLat = document.getElementById("neLat").value;
    const neLng = document.getElementById("neLng").value;

    // 收集可提供房間的資料
    const availableRooms = [];

    const roomElements = document.querySelectorAll('#availableRooms .room');

// 假設房型數量與價格數量相同
    roomElements.forEach((roomElement) => {
        const roomTypeSelect = roomElement.querySelector('.roomType');
        const room_type = roomTypeSelect.value;

        const priceInput = roomElement.querySelector('.price');
        const price = priceInput.value;

        const periodInput = roomElement.querySelector('.period');
        const period = periodInput.value;

        if (room_type && price) {
            availableRooms.push({room_type, price, period});
        }
    });

    // 收集現有室友的資料
    const currentRoommates = [];
    const roommateElements = document.querySelectorAll('#currentRoommates .roommate');

    roommateElements.forEach((roommateElement) => {
        const roomTypeSelect = roommateElement.querySelector('.roomType');
        const room_type = roomTypeSelect.value;

        const descriptionInput = roommateElement.querySelector('.description');
        const description = descriptionInput.value;

        if (room_type && description) {
            currentRoommates.push({room_type, description});
        }
    });


    // 收集詳細資料
    const details = {
        pet_allowed: document.getElementById("petAllowed").value === "true",
        rental_period: document.getElementById("rentalPeriod").value,
        shared_spaces: document.getElementById("sharedSpaces").value,
        amenities: document.getElementById("amenities").value,
        additional_fees: document.getElementById("additionalFees").value,
        nearby_facilities: document.getElementById("nearbyFacilities").value,
        other: document.getElementById("other").value
    };

    // 構建最終資料結構
    const rentalData = {
        ne_lat: neLat,
        ne_lng: neLng,
        house_name: houseName,
        available_rooms: availableRooms,
        current_roommates: currentRoommates,
        details: details
    };

    console.log(rentalData);

    document.cookie = `userId=${userId}; path=/`;

    fetch(`/api/1.0/rent/rented/${userId}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(rentalData),
    }).then(response => {
        if (response.ok) {
            console.log('POST success, now fetching matching user IDs...');
            // 2. POST 成功後，發送 GET 請求來獲取 matchingUserIds
            return fetch(`/api/1.0/rent/rented/${userId}`, {  // 假設有一個 GET 請求用來獲取 matchingUserIds
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                }
            });
        } else {
            throw new Error('POST request failed');
        }
    })
        .then(response => response.json())
        .then(data => {
            const matchingUserIds = data; // 假設 API 返回的結果包含 matchingUserIds
            console.log('Success:', matchingUserIds);

            sessionStorage.setItem('matchingUserIds', JSON.stringify(matchingUserIds));

            window.location.href = '/habits';
        })
        .catch((error) => {
            console.error('Error:', error);
        });
}

