document.addEventListener('DOMContentLoaded', function () {
    initMap();
    loadRoomTypes();
});

function loadRoomTypes() {
    fetch('/api/1.0/data/room-types')
        .then(response => response.json())
        .then(data => {
            const container = document.getElementById('roomTypeContainer');
            container.innerHTML = ''; // 清空现有内容

            data.forEach(roomType => {
                // 创建一个 <div> 来包裹复选框和输入框
                const wrapperDiv = document.createElement('div');
                wrapperDiv.classList.add('roomTypeOption');

                // 创建复选框
                const checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                checkbox.id = `roomType_${roomType.id}`;
                checkbox.name = 'roomTypes';
                checkbox.value = roomType.id;

                // 创建标签 <label>
                const label = document.createElement('label');
                label.htmlFor = `roomType_${roomType.id}`;
                label.textContent = roomType.roomType;

                // 创建最低预算输入框
                const lowPriceInput = document.createElement('input');
                lowPriceInput.type = 'number';
                lowPriceInput.placeholder = '最低预算';
                lowPriceInput.classList.add('lowPrice');
                lowPriceInput.disabled = true; // 初始禁用

                // 创建最高预算输入框
                const highPriceInput = document.createElement('input');
                highPriceInput.type = 'number';
                highPriceInput.placeholder = '最高预算';
                highPriceInput.classList.add('highPrice');
                highPriceInput.disabled = true; // 初始禁用

                // 当复选框被选中时，启用对应的输入框
                checkbox.addEventListener('change', function () {
                    lowPriceInput.disabled = !this.checked;
                    highPriceInput.disabled = !this.checked;
                });

                // 将元素添加到 wrapperDiv
                wrapperDiv.appendChild(checkbox);
                wrapperDiv.appendChild(label);
                wrapperDiv.appendChild(lowPriceInput);
                wrapperDiv.appendChild(highPriceInput);

                // 将 wrapperDiv 添加到容器中
                container.appendChild(wrapperDiv);
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

// 新增房間
function addRoom() {
    roomCounter++;
    const roomDiv = document.createElement('div');
    roomDiv.classList.add('room');
    roomDiv.innerHTML = `
        <label for="roomType${roomCounter}">房型:</label>
        <input type="text" id="roomType${roomCounter}" placeholder="輸入房型">
        <label for="price${roomCounter}">價格:</label>
        <input type="number" id="price${roomCounter}" placeholder="輸入價格">
    `;
    document.getElementById('availableRooms').appendChild(roomDiv);
}

// 新增室友
function addRoommate() {
    roommateCounter++;
    const roommateDiv = document.createElement('div');
    roommateDiv.classList.add('roommate');
    roommateDiv.innerHTML = `
        <label for="roommateType${roommateCounter}">房型:</label>
        <input type="text" id="roommateType${roommateCounter}" placeholder="輸入房型">
        <label for="description${roommateCounter}">描述:</label>
        <input type="text" id="description${roommateCounter}" placeholder="輸入描述">
    `;
    document.getElementById('currentRoommates').appendChild(roommateDiv);
}

// 提交表單
function submitForm() {
    // 獲取表單數據
    const houseName = document.getElementById("houseName").value;
    const neLat = document.getElementById("neLat").value;
    const neLng = document.getElementById("neLng").value;

    // 收集可提供房間的資料
    const availableRooms = [];
    for (let i = 1; i <= roomCounter; i++) {
        const roomType = document.getElementById(`roomType${i}`).value;
        const price = document.getElementById(`price${i}`).value;
        availableRooms.push({roomType, price});
    }

    // 收集現有室友的資料
    const currentRoommates = [];
    for (let i = 1; i <= roommateCounter; i++) {
        const roomType = document.getElementById(`roommateType${i}`).value;
        const description = document.getElementById(`description${i}`).value;
        currentRoommates.push({roomType, description});
    }

    // 收集詳細資料
    const details = {
        petAllowed: document.getElementById("petAllowed").value === "true",
        rentalPeriod: document.getElementById("rentalPeriod").value,
        sharedSpaces: document.getElementById("sharedSpaces").value,
        amenities: document.getElementById("amenities").value,
        additionalFees: document.getElementById("additionalFees").value,
        nearbyFacilities: document.getElementById("nearbyFacilities").value,
        other: document.getElementById("other").value
    };

    // 構建最終資料結構
    const rentalData = {
        ne_lat: neLat,
        ne_lng: neLng,
        houseName: houseName,
        availableRooms: availableRooms,
        currentRoommates: currentRoommates,
        details: details
    };

    console.log(rentalData);

    // 發送資料到後端
    fetch('/api/1.0/rent/rented', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({rental: rentalData}),
    })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
        })
        .catch((error) => {
            console.error('Error:', error);
        });
}

