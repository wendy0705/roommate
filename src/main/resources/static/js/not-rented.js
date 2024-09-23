window.onload = function () {
    initMap();
    loadRoomTypes();
};

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

    fetch('/api/1.0/rent/not-rented', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData)
    })
        .then(response => response.json())
        .then(data => {
            console.log('Form submitted successfully:', data);

            window.location.href = '/api/1.0/matched';
        })
        .catch((error) => console.error('Error submitting form:', error));
}

function loadRoomTypes() {
    fetch('/api/1.0/data/room-types')
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
                lowPriceInput.placeholder = '最低预算';
                lowPriceInput.classList.add('lowPrice');
                lowPriceInput.disabled = true; // 初始禁用，只有在勾选复选框时启用

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