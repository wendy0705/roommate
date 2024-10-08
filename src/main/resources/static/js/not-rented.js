window.onload = function () {
    initMap();
    loadRoomTypes();
};

function notRentedInit(map) {
    // 框选区域的地图逻辑
    const drawingManager = new google.maps.drawing.DrawingManager({
        drawingMode: google.maps.drawing.OverlayType.RECTANGLE,
        drawingControl: true,
        drawingControlOptions: {
            position: google.maps.ControlPosition.TOP_CENTER,
            drawingModes: ['rectangle'],
        },
    });

    drawingManager.setMap(map);

    let rectangles = [];
    google.maps.event.addListener(drawingManager, 'overlaycomplete', function (event) {
        if (event.type === google.maps.drawing.OverlayType.RECTANGLE) {
            const rectangle = event.overlay;
            rectangles.push(rectangle);

            const bounds = rectangle.getBounds();
            const ne = bounds.getNorthEast();
            const sw = bounds.getSouthWest();

            console.log("北东角 (NE): " + ne.lat() + ", " + ne.lng());
            console.log("南西角 (SW): " + sw.lat() + ", " + sw.lng());

            document.getElementById("neLat").value = ne.lat();
            document.getElementById("neLng").value = ne.lng();
            document.getElementById("swLat").value = sw.lat();
            document.getElementById("swLng").value = sw.lng();

            if (rectangles.length > 1) {
                var secondRectangleBounds = rectangles[rectangles.length - 1].getBounds();
                var firstRectangleBounds = rectangles[rectangles.length - 2].getBounds();

                if (haveIntersection(firstRectangleBounds, secondRectangleBounds)) {
                    console.log("两个矩形有交集");
                } else {
                    console.log("两个矩形没有交集");
                }
            }
        }
    });

    function haveIntersection(bounds1, bounds2) {
        var ne1 = bounds1.getNorthEast();
        var sw1 = bounds1.getSouthWest();

        var ne2 = bounds2.getNorthEast();
        var sw2 = bounds2.getSouthWest();

        if (sw1.lat() > ne2.lat() || ne1.lat() < sw2.lat() ||
            sw1.lng() > ne2.lng() || ne1.lng() < sw2.lng()) {
            return false;
        }
        return true;
    }
}


function submitForm() {
    const userId = document.getElementById('userIdInput').value;
    const neLat = document.getElementById("neLat").value;
    const neLng = document.getElementById("neLng").value;
    const swLat = document.getElementById("swLat").value;
    const swLng = document.getElementById("swLng").value;

    const rentalPeriod = document.getElementById("rentalPeriod").value;

    const roomTypeOptions = document.querySelectorAll('.roomTypeOption');
    const selectedRoomTypes = [];

    roomTypeOptions.forEach(option => {
        const checkbox = option.querySelector('input[type="checkbox"]');
        // console.log(checkbox);
        if (checkbox.checked) {
            const roomTypeId = checkbox.value;
            const lowPriceInput = option.querySelector('.lowPrice');
            const highPriceInput = option.querySelector('.highPrice');

            const lowPrice = lowPriceInput.value;
            const highPrice = highPriceInput.value;

            selectedRoomTypes.push({
                type_id: roomTypeId,
                low_price: lowPrice,
                high_price: highPrice
            });
        }
    });

    const formData = {
        area: {
            region_ne_lat: neLat,
            region_ne_lng: neLng,
            region_sw_lat: swLat,
            region_sw_lng: swLng
        },
        room_type: selectedRoomTypes,
        rental_period: rentalPeriod
    };

    console.log(formData);

    document.cookie = `userId=${userId}; path=/`;
    console.log(document.cookie);

    fetch(`api/1.0/rent/not-rented/${userId}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData)
    })
        .then(response => {
            if (response.ok) {
                console.log('POST success, now fetching matching user IDs...');
                // 2. POST 成功後，發送 GET 請求來獲取 matchingUserIds
                return fetch(`/api/1.0/rent/not-rented/${userId}`, {  // 假設有一個 GET 請求用來獲取 matchingUserIds
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
            const matchingUserIds = data;
            console.log('Success:', matchingUserIds);

            sessionStorage.setItem('matchingUserIds', JSON.stringify(matchingUserIds));

            window.location.href = '/habits';
        })
        .catch((error) => {
            console.error('Error:', error);
        });
}

function loadRoomTypes() {
    fetch('api/1.0/data/room-types')
        .then(response => response.json())
        .then(data => {
            console.log(data);
            const container = document.getElementById('roomTypeContainer');
            container.innerHTML = ''; // 清空现有内容

            data.forEach(roomType => {
                // 创建一个 <div> 来包裹复选框和输入框
                const wrapperDiv = document.createElement('div');
                wrapperDiv.classList.add('roomTypeOption');

                // 创建复选框
                const checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                checkbox.id = `
    roomType_$
    {
        roomType.id
    }
    `;
                checkbox.name = 'roomTypes';
                checkbox.value = roomType.id;

                // 创建标签 <label>
                const label = document.createElement('label');
                label.htmlFor = `
    roomType_$
    {
        roomType.id
    }
    `;
                label.textContent = roomType.room_type;

                // 创建最低预算输入框
                const lowPriceInput = document.createElement('input');
                lowPriceInput.type = 'number';
                lowPriceInput.placeholder = '最低預算';
                lowPriceInput.classList.add('lowPrice');
                lowPriceInput.disabled = true; // 初始禁用，只有在勾选复选框时启用

                lowPriceInput.addEventListener('wheel', function (e) {
                    e.preventDefault();
                });

                // 创建最高预算输入框
                const highPriceInput = document.createElement('input');
                highPriceInput.type = 'number';
                highPriceInput.placeholder = '最高預算';
                highPriceInput.classList.add('highPrice');
                highPriceInput.disabled = true; // 初始禁用

                highPriceInput.addEventListener('wheel', function (e) {
                    e.preventDefault();
                });

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