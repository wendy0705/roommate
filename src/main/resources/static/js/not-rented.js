window.onload = function () {
    initMap();
    loadRoomTypes();
    disableWheelOnNumberInputs();
};

function notRentedInit(map) {
    // 初始化 DrawingManager，不自动进入绘制模式
    const drawingManager = new google.maps.drawing.DrawingManager({
        drawingMode: null, // 设置为 null，避免自动进入绘制模式
        drawingControl: true,
        drawingControlOptions: {
            position: google.maps.ControlPosition.TOP_CENTER,
            drawingModes: ['rectangle'], // 仅允许绘制矩形
        },
        rectangleOptions: {
            fillColor: '#FF0000',
            fillOpacity: 0.2,
            strokeWeight: 2,
            clickable: true, // 允许点击
            editable: true,  // 允许编辑
            zIndex: 1
        }
    });

    // 将 DrawingManager 添加到地图上
    drawingManager.setMap(map);

    let currentRectangle = null;

    const defaultRectangle = loadDefaultRectangle(map);
    currentRectangle = defaultRectangle;

    // 监听用户绘制完成的事件
    google.maps.event.addListener(drawingManager, 'overlaycomplete', function (event) {
        if (event.type === google.maps.drawing.OverlayType.RECTANGLE) {

            if (currentRectangle) {
                currentRectangle.setMap(null); // 移除之前的矩形
            }

            currentRectangle = event.overlay;

            const bounds = currentRectangle.getBounds();
            const ne = bounds.getNorthEast();
            const sw = bounds.getSouthWest();

            console.log("北东角 (NE): " + ne.lat() + ", " + ne.lng());
            console.log("南西角 (SW): " + sw.lat() + ", " + sw.lng());

            // 更新隐藏的输入栏位
            document.getElementById("neLat").value = ne.lat();
            document.getElementById("neLng").value = ne.lng();
            document.getElementById("swLat").value = sw.lat();
            document.getElementById("swLng").value = sw.lng();

            // 可选：添加事件监听器以响应用户对新矩形的编辑
            currentRectangle.addListener('bounds_changed', function () {
                const updatedBounds = currentRectangle.getBounds();
                const updatedNe = updatedBounds.getNorthEast();
                const updatedSw = updatedBounds.getSouthWest();

                document.getElementById("neLat").value = updatedNe.lat();
                document.getElementById("neLng").value = updatedNe.lng();
                document.getElementById("swLat").value = updatedSw.lat();
                document.getElementById("swLng").value = updatedSw.lng();
            });
        }
    });
}

/**
 * 加载并添加默认矩形到地图上
 * @param {google.maps.Map} map - Google Map 实例
 * @returns {google.maps.Rectangle} - 添加到地图上的矩形实例
 */
function loadDefaultRectangle(map) {
    // 从隐藏的输入栏位获取预设的边界值
    const neLat = parseFloat(document.getElementById("neLat").value);
    const neLng = parseFloat(document.getElementById("neLng").value);
    const swLat = parseFloat(document.getElementById("swLat").value);
    const swLng = parseFloat(document.getElementById("swLng").value);

    // 创建边界对象
    const bounds = new google.maps.LatLngBounds(
        new google.maps.LatLng(swLat, swLng),
        new google.maps.LatLng(neLat, neLng)
    );

    // 创建矩形对象
    const rectangle = new google.maps.Rectangle({
        bounds: bounds,
        editable: true,
        draggable: true,
        fillColor: '#FF0000',
        fillOpacity: 0.2,
        strokeWeight: 2,
        zIndex: 1
    });

    // 将矩形添加到地图上
    rectangle.setMap(map);

    // 调整地图视野以包含矩形
    map.fitBounds(bounds);

    // 监听矩形的边界变化事件，更新隐藏的输入栏位
    rectangle.addListener('bounds_changed', function () {
        const newBounds = rectangle.getBounds();
        const ne = newBounds.getNorthEast();
        const sw = newBounds.getSouthWest();

        document.getElementById("neLat").value = ne.lat();
        document.getElementById("neLng").value = ne.lng();
        document.getElementById("swLat").value = sw.lat();
        document.getElementById("swLng").value = sw.lng();
    });

    return rectangle;
}

// function haveIntersection(bounds1, bounds2) {
//     var ne1 = bounds1.getNorthEast();
//     var sw1 = bounds1.getSouthWest();
//
//     var ne2 = bounds2.getNorthEast();
//     var sw2 = bounds2.getSouthWest();
//
//     if (sw1.lat() > ne2.lat() || ne1.lat() < sw2.lat() ||
//         sw1.lng() > ne2.lng() || ne1.lng() < sw2.lng()) {
//         return false;
//     }
//     return true;
// }


function disableWheelOnNumberInputs() {
    const numberInputs = document.querySelectorAll('input[type="number"]');

    numberInputs.forEach(function (input) {
        input.addEventListener('wheel', function (e) {
            e.preventDefault(); // 禁用滑鼠滾輪調整數值
        });
    });
}


function submitForm() {
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

            console.log(roomTypeId);

            const lowPrice = lowPriceInput.value;
            const highPrice = highPriceInput.value;
            console.log(lowPrice);
            console.log(highPrice);

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


    fetch(`api/1.0/rent/not-rented`, {
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
                return fetch(`/api/1.0/rent/not-rented`, {  // 假設有一個 GET 請求用來獲取 matchingUserIds
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
                checkbox.id = `roomType_${roomType.id}`;
                checkbox.name = 'roomTypes';
                checkbox.value = roomType.id;

                // 创建标签 <label>
                const label = document.createElement('label');
                label.htmlFor = `roomType_${roomType.id}`;
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
                    if (this.checked) {
                        lowPriceInput.disabled = false;
                        highPriceInput.disabled = false;
                    } else {
                        lowPriceInput.disabled = true;
                        highPriceInput.disabled = true;
                        lowPriceInput.value = '';
                        highPriceInput.value = '';
                    }
                });
                // 将元素添加到 wrapperDiv
                wrapperDiv.appendChild(checkbox);
                wrapperDiv.appendChild(label);
                wrapperDiv.appendChild(lowPriceInput);
                wrapperDiv.appendChild(highPriceInput);

                // 将 wrapperDiv 添加到容器中
                container.appendChild(wrapperDiv);
            });
            autoSelectRoomTypes([1, 3], {
                1: {low_price: "3000", high_price: "9000"},
                3: {low_price: "4000", high_price: "10000"}
            });
        })
        .catch(error => console.error('Error loading room types:', error));
}

function autoSelectRoomTypes(roomIds, presetValues) {
    roomIds.forEach(id => {
        // 根據房型 ID 找到復選框
        const checkbox = document.querySelector(`input[type="checkbox"][value="${id}"]`);
        if (checkbox) {
            // 選中復選框
            checkbox.checked = true;

            checkbox.dispatchEvent(new Event('change'));

            // 啟用並設置價格輸入框
            const lowPriceInput = checkbox.parentElement.querySelector('.lowPrice');
            const highPriceInput = checkbox.parentElement.querySelector('.highPrice');

            if (lowPriceInput && highPriceInput && presetValues[id]) {
                lowPriceInput.value = presetValues[id].low_price;
                highPriceInput.value = presetValues[id].high_price;
            }
        } else {
            console.error(`Checkbox with value ${id} not found`);
        }
    });
}