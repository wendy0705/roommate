window.onload = function () {
    initMap();
    loadRoomTypes();
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

let map, geocoder;

function initMap() {
    geocoder = new google.maps.Geocoder();
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 25.033, lng: 121.5654}, // 台北的經緯度
        zoom: 12,
    });
}

function geocodeAddress() {
    const address = document.getElementById("addressInput").value;

    geocoder.geocode({address: address}, function (results, status) {
        if (status === 'OK') {
            const lat = results[0].geometry.location.lat();
            const lng = results[0].geometry.location.lng();

            // 將經緯度設置到隱藏的輸入框中
            document.getElementById("neLat").value = lat;
            document.getElementById("neLng").value = lng;

            // 在地圖上標記地址位置
            map.setCenter(results[0].geometry.location);
            new google.maps.Marker({
                map: map,
                position: results[0].geometry.location
            });

            console.log("地址的經緯度: " + lat + ", " + lng);
        } else {
            console.error('Geocode 失敗，原因: ' + status);
        }
    });
}

let roomCounter = 1;
let roommateCounter = 1;

function addRoom() {
    // 選取房間容器
    const availableRooms = document.getElementById('availableRooms');

    // 複製現有的房間表單
    const roomTemplate = document.querySelector('.room').cloneNode(true);

    // 清空新的房間表單中的輸入欄位（如價格等）
    roomTemplate.querySelector('input[type="number"]').value = '';

    // 將新的房間表單添加到房間容器中
    availableRooms.appendChild(roomTemplate);

    // 重新加載房型選項
    loadRoomTypesForNewRoom(roomTemplate.querySelector('.roomType'));
}

function addRoommate() {
    const currentRoommates = document.getElementById('currentRoommates');
    const roommateTemplate = document.querySelector('.roommate').cloneNode(true);
    roommateTemplate.querySelector('input[type="text"]').value = ''; // 清空描述欄位
    currentRoommates.appendChild(roommateTemplate);

    // 重新加載房型選項到新增的房型選擇框
    loadRoomTypesForNewRoom(roommateTemplate.querySelector('.roomType'));
}


function loadRoomTypesForNewRoom(roomTypeSelect) {
    fetch('/api/1.0/data/room-types')
        .then(response => response.json())
        .then(data => {
            roomTypeSelect.innerHTML = '';
            data.forEach(roomType => {
                const option = document.createElement('option');
                option.value = roomType.id;
                option.textContent = roomType.room_type;
                roomTypeSelect.appendChild(option);
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
    })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            console.log("location.href");
            window.location.href = '/api/1.0/rented-matched';
        })
        .catch((error) => {
            console.error('Error:', error);
        });
}

