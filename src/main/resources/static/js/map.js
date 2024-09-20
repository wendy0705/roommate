function initMap() {

    const mapOptions = {
        zoom: 12,
        center: {lat: 25.033, lng: 121.5654}, // 台北的經緯度
    };

    // 創建地圖
    const map = new google.maps.Map(document.getElementById("map"), mapOptions);

    // 設置 DrawingManager 用於繪製矩形
    const drawingManager = new google.maps.drawing.DrawingManager({
        drawingMode: google.maps.drawing.OverlayType.RECTANGLE,
        drawingControl: true,
        drawingControlOptions: {
            position: google.maps.ControlPosition.TOP_CENTER,
            drawingModes: ['rectangle'],
        },
    });

    drawingManager.setMap(map);

    // 當完成繪製矩形時觸發事件
    google.maps.event.addListener(drawingManager, 'overlaycomplete', function (event) {
        if (event.type === google.maps.drawing.OverlayType.RECTANGLE) {
            const rectangle = event.overlay;

            const bounds = rectangle.getBounds();
            const ne = bounds.getNorthEast();  // 右上角
            const sw = bounds.getSouthWest();  // 左下角

            console.log("北東角 (NE): " + ne.lat() + ", " + ne.lng());
            console.log("南西角 (SW): " + sw.lat() + ", " + sw.lng());

            document.getElementById("neLat").value = ne.lat();
            document.getElementById("neLng").value = ne.lng();
            document.getElementById("swLat").value = sw.lat();
            document.getElementById("swLng").value = sw.lng();

            // 禁止再繪製其他矩形
            drawingManager.setDrawingMode(null);
            google.maps.event.addListener(rectangle, 'click', function () {
                rectangle.setMap(null);  // 移除矩形
            });
        }
    });

}

