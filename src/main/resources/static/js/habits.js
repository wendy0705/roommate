function getCookieValue(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}

let matchingUserIds;

document.addEventListener('DOMContentLoaded', function () {

    matchingUserIds = JSON.parse(sessionStorage.getItem('matchingUserIds')) || [];

    console.log('Matching User IDs:', matchingUserIds);

    const steps = document.querySelectorAll('.step');

    // 移除其他步骤的 active 类
    steps.forEach(step => step.classList.remove('active'));

    // 为第二个步骤添加 active 类
    if (steps.length >= 2) {
        steps[1].classList.add('active'); // 第2个元素是索引1
    }
});

function toggleButtonGroup(button) {
    const group = button.getAttribute('data-group'); // 獲取按鈕的 data-group 屬性

    // 如果是 "interest" 組，則允許多選
    if (group === "interest") {
        // 切換選中狀態
        if (button.classList.contains('selected')) {
            button.classList.remove('selected'); // 如果已選中，則取消選中
        } else {
            button.classList.add('selected'); // 如果未選中，則添加選中狀態
        }
    } else {
        // 如果不是 "interest" 組，則保持單選行為
        const buttons = document.querySelectorAll(`button[data-group="${group}"]`); // 選取同一組的按鈕

        // 清除該組按鈕的選中狀態
        buttons.forEach(btn => {
            btn.classList.remove('selected');
        });

        // 設定當前按鈕為選中狀態
        button.classList.add('selected');
    }
}


function toggleTemperatureInput() {
    const temperatureInputDiv = document.getElementById("temperature_input");
    const temperatureInputField = temperatureInputDiv.querySelector('input[name="hot_weather_preference[temperature]"]');
    const selectedWeatherButton = document.querySelector('button[data-group="weather"].selected');

    if (selectedWeatherButton && selectedWeatherButton.value == "3") {
        // 顯示冷氣溫度輸入框
        temperatureInputDiv.classList.remove("hidden");
    } else {
        // 隱藏冷氣溫度輸入框並清空輸入值
        temperatureInputDiv.classList.add("hidden");
        temperatureInputField.value = ""; // 清空溫度輸入框的值
    }
}

function togglePetType() {
    const petTypeInputDiv = document.getElementById("pet_type_input");
    const petTypeInputField = petTypeInputDiv.querySelector('input[name="pet[pet_type]"]'); // 選取輸入框
    const petSelection = document.querySelector('input[name="has_pet"]:checked').value;
    if (petSelection == "1") {
        petTypeInputDiv.classList.remove("hidden"); // 顯示寵物種類的輸入框
    } else {
        petTypeInputDiv.classList.add("hidden"); // 隱藏寵物種類的輸入框
        petTypeInputField.value = ""; // 清空輸入框的值
    }
}

function createHourOptions() {
    let options = '<option value="" selected>時</option>';
    for (let i = 0; i <= 23; i++) {
        options += `<option value="${i}">${i}</option>`;
    }
    return options;
}

function insertHourOptions() {
    const selects = document.querySelectorAll('.hour-select');
    const options = createHourOptions();
    selects.forEach(select => {
        select.innerHTML = options;
    });

    document.querySelector('select[name="schedule[weekday_sleep_hour]"]').value = "23"; // 平日睡眠時間預設為23
    document.querySelector('select[name="schedule[weekday_wake_hour]"]').value = "7";  // 平日起床時間預設為7
    document.querySelector('select[name="schedule[weekend_sleep_hour]"]').value = "1";  // 假日睡眠時間預設為1
    document.querySelector('select[name="schedule[weekend_wake_hour]"]').value = "9";  // 假日起床時間預設為9

}

function checkTimeSelection() {
    const weekdaySleep = document.querySelector('select[name="schedule[weekday_sleep_hour]"]').value;
    const weekdayWake = document.querySelector('select[name="schedule[weekday_wake_hour]"]').value;
    const weekendSleep = document.querySelector('select[name="schedule[weekend_sleep_hour]"]').value;
    const weekendWake = document.querySelector('select[name="schedule[weekend_wake_hour]"]').value;

    const customScheduleButton = document.getElementById("customScheduleButton");

    if (weekdaySleep === "" && weekdayWake === "" && weekendSleep === "" && weekendWake === "") {
        // 平日和假日都沒有選擇時數，解鎖按鈕
        customScheduleButton.disabled = false;
    } else {
        // 只要有選擇時數，就禁用按鈕
        customScheduleButton.disabled = true;
    }
}

function toggleCustomSchedule() {
    const customScheduleDiv = document.getElementById("customSchedule");
    const regularScheduleDiv = document.getElementById("regularSchedule"); // 包含平日和假日作息區塊
    const customSelects = customScheduleDiv.querySelectorAll('select'); // 選取所有的 <select> 元素

    if (customScheduleDiv.classList.contains("hidden")) {
        // 顯示自定義作息區域，隱藏平日和假日作息區域
        customScheduleDiv.classList.remove("hidden");
        regularScheduleDiv.classList.add("hidden");
    } else {
        // 隱藏自定義作息區域，顯示平日和假日作息區域，並清空自定義作息選項
        customScheduleDiv.classList.add("hidden");
        regularScheduleDiv.classList.remove("hidden");

        // 清空所有 <select> 的值
        customSelects.forEach(select => {
            select.value = ""; // 清空每個 <select> 的值
        });
    }
}

window.onload = function () {
    insertHourOptions();

    const timeSelects = document.querySelectorAll('.hour-select');
    timeSelects.forEach(select => {
        select.addEventListener('change', checkTimeSelection);
    });
}

document.getElementById('preferencesForm').addEventListener('submit', function (event) {
    event.preventDefault(); // 防止表單提交刷新頁面

    // 1. 收集資料
    const formData = new FormData(this);

    let schedule = {
        monday: [formData.get('schedule[monday_sleep_hour]') || formData.get('schedule[weekday_sleep_hour]'), formData.get('schedule[monday_wake_hour]') || formData.get('schedule[weekday_wake_hour]')],
        tuesday: [formData.get('schedule[tuesday_sleep_hour]') || formData.get('schedule[weekday_sleep_hour]'), formData.get('schedule[tuesday_wake_hour]') || formData.get('schedule[weekday_wake_hour]')],
        wednesday: [formData.get('schedule[wednesday_sleep_hour]') || formData.get('schedule[weekday_sleep_hour]'), formData.get('schedule[wednesday_wake_hour]') || formData.get('schedule[weekday_wake_hour]')],
        thursday: [formData.get('schedule[thursday_sleep_hour]') || formData.get('schedule[weekday_sleep_hour]'), formData.get('schedule[thursday_wake_hour]') || formData.get('schedule[weekday_wake_hour]')],
        friday: [formData.get('schedule[friday_sleep_hour]') || formData.get('schedule[weekday_sleep_hour]'), formData.get('schedule[friday_wake_hour]') || formData.get('schedule[weekday_wake_hour]')],
        saturday: [formData.get('schedule[saturday_sleep_hour]') || formData.get('schedule[weekend_sleep_hour]'), formData.get('schedule[saturday_wake_hour]') || formData.get('schedule[weekend_wake_hour]')],
        sunday: [formData.get('schedule[sunday_sleep_hour]') || formData.get('schedule[weekend_sleep_hour]'), formData.get('schedule[sunday_wake_hour]') || formData.get('schedule[weekend_wake_hour]')]
    };

    // 2. 構建 JSON 對象
    const my_preference = {
        share_room: formData.get('share_room'),
        special_conditions: {
            haunted_house: formData.get('special_conditions[haunted_house]') ? 1 : 0,
            rooftop_extension: formData.get('special_conditions[rooftop_extension]') ? 1 : 0,
            illegal_building: formData.get('special_conditions[illegal_building]') ? 1 : 0,
            basement: formData.get('special_conditions[basement]') ? 1 : 0,
            windowless: formData.get('special_conditions[windowless]') ? 1 : 0
        },
        schedule: schedule,
        cooking_location: formData.get('cooking_location'),
        dining_location: formData.get('dining_location'),
        dining_habits: {
            alone: formData.get('dining_habits[alone]') ? 1 : 0,
            not_alone: formData.get('dining_habits[not_alone]') ? 1 : 0
        },
        noise_sensitivity: {
            sleep: formData.get('noise_sensitivity[sleep]'),
            study_or_work: formData.get('noise_sensitivity[study_or_work]')
        },
        alarm_habit: document.querySelector('button[data-group="alarm"].selected')?.value || 0,
        light_sensitivity: document.querySelector('button[data-group="light"].selected')?.value || 0,
        friendship_habit: document.querySelector('button[data-group="friendship"].selected')?.value || 0,
        hot_weather_preference: {
            preference: document.querySelector('button[data-group="weather"].selected')?.value || 0,
            temperature: formData.get('hot_weather_preference[temperature]')
        },
        humidity_preference: document.querySelector('button[data-group="humidity"].selected')?.value || 0,
        pet: {
            has_pet: formData.get('has_pet'),
            pet_type: formData.get('pet[pet_type]')
        },
        interest: {
            sports: document.querySelector('button[value="sports"].selected') ? 1 : 0,
            travel: document.querySelector('button[value="travel"].selected') ? 1 : 0,
            reading: document.querySelector('button[value="reading"].selected') ? 1 : 0,
            wine_tasting: document.querySelector('button[value="wine_tasting"].selected') ? 1 : 0,
            drama: document.querySelector('button[value="drama"].selected') ? 1 : 0,
            astrology: document.querySelector('button[value="astrology"].selected') ? 1 : 0,
            programming: document.querySelector('button[value="programming"].selected') ? 1 : 0,
            hiking: document.querySelector('button[value="hiking"].selected') ? 1 : 0,
            gaming: document.querySelector('button[value="gaming"].selected') ? 1 : 0,
            painting: document.querySelector('button[value="painting"].selected') ? 1 : 0,
            idol_chasing: document.querySelector('button[value="idol_chasing"].selected') ? 1 : 0,
            music: document.querySelector('button[value="music"].selected') ? 1 : 0
        },
        hope: document.getElementById('roommate-preference').value,
        matching_user_ids: matchingUserIds
    };

    // 3. 測試輸出
    console.log(JSON.stringify(my_preference, null, 2)); // 測試時輸出到控制台

    if (Array.isArray(matchingUserIds)) {
        // 處理 List<Long>，發送到 rented 的 API
        fetch(`/api/1.0/analysis/rented/match`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                my_preference,
                matching_user_ids: matchingUserIds
            }),
        })
            .then(response => response.json())
            .then(data => {
                console.log('Fetched data:', data);
                sessionStorage.setItem('matchResults', JSON.stringify(data));

                window.location.href = '/rented-matched';
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    } else if (typeof matchingUserIds === 'object' && matchingUserIds !== null) {

        fetch(`/api/1.0/analysis/not-rented/match`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                my_preference,
                matching_user_ids: matchingUserIds
            }),
        })
            .then(response => response.json())
            .then(data => {
                console.log('Fetched data:', data);

                sessionStorage.setItem('matchResults', JSON.stringify(data));

                window.location.href = '/not-rented-matched';
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    } else {
        console.log('Invalid data format for matchingUserIds.');
    }

});