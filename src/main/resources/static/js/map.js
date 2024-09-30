function initMap() {
    const mapOptions = {
        zoom: 12,
        center: {lat: 25.033, lng: 121.5654}, // 台北的經緯度
    };

    const map = new google.maps.Map(document.getElementById("map"), mapOptions);

    // 根據地圖類型執行不同邏輯
    const mapType = document.getElementById("map").getAttribute("data-map-type");
    console.log(mapType);

    if (mapType === 'drawing') {
        notRentedInit(map);
    } else if (mapType === 'marker') {
        rentedInit(map);
    }
}

