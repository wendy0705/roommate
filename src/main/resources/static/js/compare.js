// 基本偏好翻譯函數
function translateBasicPreference(key, value) {
    const translations = {
        share_room: ["否", "是"],
        cooking_location: ["否", "是"],
        dining_location: ["否", "是"]
    };

    if (key in translations) {
        return translations[key][value];
    }

    return value;  // 如果沒有對應的翻譯，直接返回原始值
}

// 特殊條件翻譯函數
function translateCategoryPreference(category, key, value) {
    const translations = {
        special_conditions: {
            haunted_house: ["不接受", "接受"],
            rooftop_extension: ["不接受", "接受"],
            illegal_building: ["不接受", "接受"],
            basement: ["不接受", "接受"],
            windowless: ["不接受", "接受"]
        }
    };

    // 檢查是否有對應的 category 和 key
    if (category in translations && key in translations[category]) {
        return translations[category][key][value];
    }

    return value;  // 如果沒有對應的翻譯，直接返回原始值
}

// 用餐習慣翻譯函數
function translateDiningHabits(key, value) {
    const translations = {
        alone: ["否", "自己吃"],
        not_alone: ["否", "跟朋友吃"]
    };

    if (key in translations) {
        return translations[key][value];
    }

    return value;
}

// 噪音敏感度翻譯函數
function translateNoiseSensitivity(key, value) {
    const translations = {
        sleep: ["非常低", "低", "中", "高", "非常高", "極高"],
        study_or_work: ["非常低", "低", "中", "高", "非常高", "極高"]
    };

    if (key in translations) {
        // 假設噪音敏感度範圍是 0-5
        return translations[key][value] || value;
    }

    return value;
}

// 鬧鐘使用習慣翻譯函數
function translateAlarmHabit(value) {
    const translations = ["不使用", "響一下關閉", "需要他人協助關閉"];
    return translations[value] || value;
}

// 燈光敏感度翻譯函數
function translateLightSensitivity(value) {
    const translations = ["開大燈", "開小燈", "全暗"];
    return translations[value] || value;
}

// 交友習慣翻譯函數
function translateFriendshipHabit(value) {
    const translations = ["不會帶朋友回家", "可能會帶朋友回家", "會帶朋友回家"];
    return translations[value] || value;
}

// 天氣熱時翻譯函數
function translateHotWeatherPreference(value, temperature) {
    const translations = ["不開冷氣", "不常開冷氣", "只有晚上睡覺開", "會開冷氣"];
    if (value === 3) {
        return `${translations[value]} (${temperature}°C)`;
    }
    return translations[value] || value;
}

// 濕度高時翻譯函數
function translateHumidityPreference(value) {
    const translations = ["不開除濕", "不常開除溼", "會開除濕"];
    return translations[value] || value;
}

// 寵物翻譯函數
function translatePet(has_pet, pet_type) {
    if (has_pet === 0) {
        return "無";
    } else {
        return `有：${pet_type}`;
    }
}

// 比較偏好函數
function comparePreferences(user1, user2) {

    // 呼叫生成表格

    let differentResult = '';  // 用於儲存不同的偏好

    const tableHeaderComparison = `
            <table>
            <thead>
                <tr>
                    <th>偏好</th>
                    <th>你</th>
                    <th>這位用戶</th>
                </tr>
            </thead>
            <tbody>
        `;

    // 表格的結尾
    const tableFooter = `
                </tbody>
            </table>
        `;

    // 偏好項目
    const preferences = {
        share_room: "是否要與人同住一間房間",
        cooking_location: "在家開伙",
        dining_location: "在家用餐"
    };

    // 比較基本偏好
    for (let key in preferences) {
        if (user1[key] !== user2[key]) {
            // 不同偏好，顯示兩位用戶的比較
            differentResult += `
                    <tr>
                        <td>${preferences[key]}</td>
                        <td>${translateBasicPreference(key, user1[key])}</td>
                        <td>${translateBasicPreference(key, user2[key])}</td>
                    </tr>
                `;
        }
    }

    // 比較特殊條件
    const specialConditionsLabels = {
        haunted_house: "凶宅",
        rooftop_extension: "頂加",
        illegal_building: "違建",
        basement: "地下室",
        windowless: "無窗"
    };

    for (let key in specialConditionsLabels) {
        if (user1.special_conditions[key] !== user2.special_conditions[key]) {
            // 不同偏好，顯示兩位用戶的比較
            differentResult += `
                    <tr>
                        <td>接受${specialConditionsLabels[key]}</td>
                        <td>${translateCategoryPreference('special_conditions', key, user1.special_conditions[key])}</td>
                        <td>${translateCategoryPreference('special_conditions', key, user2.special_conditions[key])}</td>
                    </tr>
                `;
        }
    }

    // 比較用餐習慣
    const diningHabitsLabels = {
        alone: "自己吃",
        not_alone: "跟朋友吃"
    };

    for (let key in diningHabitsLabels) {
        if (user1.dining_habits[key] !== user2.dining_habits[key]) {
            // 不同偏好，顯示兩位用戶的比較
            differentResult += `
                    <tr>
                        <td>用餐習慣：${diningHabitsLabels[key]}</td>
                        <td>${user1.dining_habits[key] === 1 ? "是" : "否"}</td>
                        <td>${user2.dining_habits[key] === 1 ? "是" : "否"}</td>
                    </tr>
                `;
        }
    }

    // 比較噪音敏感度
    const noiseLabels = {
        sleep: "入睡時噪音敏感度",
        study_or_work: "學習或工作時噪音敏感度"
    };

    for (let key in noiseLabels) {
        if (user1.noise_sensitivity[key] !== user2.noise_sensitivity[key]) {
            // 不同偏好，顯示兩位用戶的比較
            differentResult += `
                    <tr>
                        <td>${noiseLabels[key]}</td>
                        <td>${translateNoiseSensitivity(key, user1.noise_sensitivity[key])}</td>
                        <td>${translateNoiseSensitivity(key, user2.noise_sensitivity[key])}</td>
                    </tr>
                `;
        }
    }

    // 比較鬧鐘使用習慣
    if (user1.alarm_habit !== user2.alarm_habit) {
        differentResult += `
                <tr>
                    <td>鬧鐘使用習慣</td>
                    <td>${translateAlarmHabit(user1.alarm_habit)}</td>
                    <td>${translateAlarmHabit(user2.alarm_habit)}</td>
                </tr>
            `;
    }

    // 比較燈光敏感度
    if (user1.light_sensitivity !== user2.light_sensitivity) {
        differentResult += `
                <tr>
                    <td>燈光敏感度</td>
                    <td>${translateLightSensitivity(user1.light_sensitivity)}</td>
                    <td>${translateLightSensitivity(user2.light_sensitivity)}</td>
                </tr>
            `;
    }

    // 比較交友習慣
    if (user1.friendship_habit !== user2.friendship_habit) {
        differentResult += `
                <tr>
                    <td>交友習慣</td>
                    <td>${translateFriendshipHabit(user1.friendship_habit)}</td>
                    <td>${translateFriendshipHabit(user2.friendship_habit)}</td>
                </tr>
            `;
    }

    // 比較天氣熱時偏好
    if (user1.hot_weather_preference.preference !== user2.hot_weather_preference.preference) {
        differentResult += `
                <tr>
                    <td>天氣熱時偏好</td>
                    <td>${translateHotWeatherPreference(user1.hot_weather_preference.preference, user1.hot_weather_preference.temperature)}</td>
                    <td>${translateHotWeatherPreference(user2.hot_weather_preference.preference, user2.hot_weather_preference.temperature)}</td>
                </tr>
            `;
    }

    // 比較濕度高時偏好
    if (user1.humidity_preference !== user2.humidity_preference) {
        differentResult += `
                <tr>
                    <td>濕度高時偏好</td>
                    <td>${translateHumidityPreference(user1.humidity_preference)}</td>
                    <td>${translateHumidityPreference(user2.humidity_preference)}</td>
                </tr>
            `;
    }

    if (user1.pet.has_pet !== user2.pet.has_pet) {
        differentResult += `
            <tr>
                <td>寵物</td>
                <td>${translatePet(user1.pet.has_pet, user1.pet.pet_type)}</td>
                <td>${translatePet(user2.pet.has_pet, user2.pet.pet_type)}</td>
            </tr>
        `;
    }

    // 組裝最終結果
    if (differentResult) {
        differentResult = tableHeaderComparison + differentResult + tableFooter;
    } else {
        differentResult = '<p>沒有不同的偏好</p>';
    }

    document.getElementById('differentPreferences').innerHTML = differentResult;
}

function showUser2Preferences(user1, user2) {
    let user2Result = `
        <table>
            <thead>
                <tr>
                    <th>偏好</th>
                    <th>你</th>
                    <th>這位用戶</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>是否要與人同住一間房間</td>
                    <td>${translateBasicPreference('share_room', user1.share_room)}</td>
                    <td>${translateBasicPreference('share_room', user2.share_room)}</td>
                </tr>
                <tr>
                    <td>在家開伙</td>
                    <td>${translateBasicPreference('cooking_location', user1.cooking_location)}</td>
                    <td>${translateBasicPreference('cooking_location', user2.cooking_location)}</td>
                </tr>
                <tr>
                    <td>在家用餐</td>
                    <td>${translateBasicPreference('dining_location', user1.dining_location)}</td>
                    <td>${translateBasicPreference('dining_location', user2.dining_location)}</td>
                </tr>
                <tr>
                    <td>接受凶宅</td>
                    <td>${translateCategoryPreference('special_conditions', 'haunted_house', user1.special_conditions.haunted_house)}</td>
                    <td>${translateCategoryPreference('special_conditions', 'haunted_house', user2.special_conditions.haunted_house)}</td>
                </tr>
                <tr>
                    <td>接受頂加</td>
                    <td>${translateCategoryPreference('special_conditions', 'rooftop_extension', user1.special_conditions.rooftop_extension)}</td>
                    <td>${translateCategoryPreference('special_conditions', 'rooftop_extension', user2.special_conditions.rooftop_extension)}</td>
                </tr>
                <tr>
                    <td>接受違建</td>
                    <td>${translateCategoryPreference('special_conditions', 'illegal_building', user1.special_conditions.illegal_building)}</td>
                    <td>${translateCategoryPreference('special_conditions', 'illegal_building', user2.special_conditions.illegal_building)}</td>
                </tr>
                <tr>
                    <td>接受地下室</td>
                    <td>${translateCategoryPreference('special_conditions', 'basement', user1.special_conditions.basement)}</td>
                    <td>${translateCategoryPreference('special_conditions', 'basement', user2.special_conditions.basement)}</td>
                </tr>
                <tr>
                    <td>接受無窗</td>
                    <td>${translateCategoryPreference('special_conditions', 'windowless', user1.special_conditions.windowless)}</td>
                    <td>${translateCategoryPreference('special_conditions', 'windowless', user2.special_conditions.windowless)}</td>
                </tr>
                <tr>
                    <td>用餐習慣：自己吃</td>
                    <td>${user1.dining_habits.alone === 1 ? "是" : "否"}</td>
                    <td>${user2.dining_habits.alone === 1 ? "是" : "否"}</td>
                </tr>
                <tr>
                    <td>用餐習慣：跟朋友吃</td>
                    <td>${user1.dining_habits.not_alone === 1 ? "是" : "否"}</td>
                    <td>${user2.dining_habits.not_alone === 1 ? "是" : "否"}</td>
                </tr>
                <tr>
                    <td>入睡時噪音敏感度</td>
                    <td>${translateNoiseSensitivity('sleep', user1.noise_sensitivity.sleep)}</td>
                    <td>${translateNoiseSensitivity('sleep', user2.noise_sensitivity.sleep)}</td>
                </tr>
                <tr>
                    <td>學習或工作時噪音敏感度</td>
                    <td>${translateNoiseSensitivity('study_or_work', user1.noise_sensitivity.study_or_work)}</td>
                    <td>${translateNoiseSensitivity('study_or_work', user2.noise_sensitivity.study_or_work)}</td>
                </tr>
                <tr>
                    <td>鬧鐘使用習慣</td>
                    <td>${translateAlarmHabit(user1.alarm_habit)}</td>
                    <td>${translateAlarmHabit(user2.alarm_habit)}</td>
                </tr>
                <tr>
                    <td>燈光敏感度</td>
                    <td>${translateLightSensitivity(user1.light_sensitivity)}</td>
                    <td>${translateLightSensitivity(user2.light_sensitivity)}</td>
                </tr>
                <tr>
                    <td>交友習慣</td>
                    <td>${translateFriendshipHabit(user1.friendship_habit)}</td>
                    <td>${translateFriendshipHabit(user2.friendship_habit)}</td>
                </tr>
                <tr>
                    <td>天氣熱時偏好</td>
                    <td>${translateHotWeatherPreference(user1.hot_weather_preference.preference, user1.hot_weather_preference.temperature)}</td>
                    <td>${translateHotWeatherPreference(user2.hot_weather_preference.preference, user2.hot_weather_preference.temperature)}</td>
                </tr>
                <tr>
                    <td>濕度高時偏好</td>
                    <td>${translateHumidityPreference(user1.humidity_preference)}</td>
                    <td>${translateHumidityPreference(user2.humidity_preference)}</td>
                </tr>
                 <tr>
                    <td>寵物</td>
                    <td>${translatePet(user1.pet.has_pet, user1.pet.pet_type)}</td>
                    <td>${translatePet(user2.pet.has_pet, user2.pet.pet_type)}</td>
                </tr>
            </tbody>
        </table>
    `;
    document.getElementById('user2Preferences').innerHTML = user2Result;
}


function toggleDisplay() {
    const user2Preferences = document.getElementById('user2Preferences');
    const differentPreferences = document.getElementById('differentPreferences');

    user2Preferences.classList.toggle('hidden');
    differentPreferences.classList.toggle('hidden');

    const button = document.getElementById('toggleButton');
    if (user2Preferences.classList.contains('hidden')) {
        button.textContent = '顯示全部資料';
    } else {
        button.textContent = '顯示不同';
    }
}


function generateScheduleTable(user1, user2) {

    const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    const daysLabels = {
        monday: "週一",
        tuesday: "週二",
        wednesday: "週三",
        thursday: "週四",
        friday: "週五",
        saturday: "週六",
        sunday: "週日"
    };

    function convertTime(hour) {
        if (hour >= 18) {
            return hour - 18;
        } else {
            return hour + 6;
        }
    }

    function formatTime(hour) {
        return (hour < 10 ? '0' : '') + hour + ':00';
    }

    const tableBody = document.getElementById('scheduleTableBody');
    tableBody.innerHTML = ''; // 清空現有內容

    days.forEach(day => {
        const user1Schedule = user1.schedule[day];
        const user2Schedule = user2.schedule[day];

        // 處理跨午夜
        let user1Start = convertTime(user1Schedule[0]);
        let user1End = convertTime(user1Schedule[1]);
        if (user1End <= user1Start) {
            user1End += 24;
        }

        let user2Start = convertTime(user2Schedule[0]);
        let user2End = convertTime(user2Schedule[1]);
        if (user2End <= user2Start) {
            user2End += 24;
        }

        // 創建表格行
        const row = document.createElement('tr');

        // 日期
        const dateCell = document.createElement('td');
        dateCell.textContent = daysLabels[day];
        row.appendChild(dateCell);

        // 用戶1和用戶2
        const scheduleCell = document.createElement('td');
        const scheduleContainer = document.createElement('div');
        scheduleContainer.classList.add('schedule-container');

        // 用戶1的作息條
        const user1Bar = document.createElement('div');
        user1Bar.classList.add('schedule-bar', 'user1');
        const user1StartPercent = (user1Start / 24) * 100;
        let user1EndPercent = (user1End / 24) * 100;
        if (user1EndPercent > 100) user1EndPercent = 100; // 限制最大為100%
        const user1Width = user1EndPercent - user1StartPercent;
        user1Bar.style.left = `${user1StartPercent}%`;
        user1Bar.style.width = `${user1Width}%`;
        scheduleContainer.appendChild(user1Bar);

        const user1WakeTimeLabel = document.createElement('div');

        if (user1Schedule[0] < 18 && (user1Schedule[1] > 18 || user1Schedule[1] < user1Schedule[0])) {
            const user1AdditionalBar = document.createElement('div');
            user1AdditionalBar.classList.add('schedule-bar', 'user1');
            const user1AdditionalEndPercent = (convertTime(user1Schedule[1]) / 24) * 100;
            user1AdditionalBar.style.left = '0%';
            user1AdditionalBar.style.width = `${user1AdditionalEndPercent}%`;
            scheduleContainer.appendChild(user1AdditionalBar);

            user1WakeTimeLabel.style.left = `${user1AdditionalEndPercent}%`;
        } else {
            user1WakeTimeLabel.style.left = `${user1EndPercent}%`;
        }

        // 用戶1的睡眠和起床時間標籤
        const user1SleepTimeLabel = document.createElement('div');
        user1SleepTimeLabel.classList.add('time-label-text', 'user1-label');
        user1SleepTimeLabel.textContent = formatTime(user1Schedule[0]);
        user1SleepTimeLabel.style.left = `${user1StartPercent}%`;
        scheduleContainer.appendChild(user1SleepTimeLabel);

        user1WakeTimeLabel.classList.add('time-label-text', 'user1-label');
        user1WakeTimeLabel.textContent = formatTime(user1Schedule[1]);
        scheduleContainer.appendChild(user1WakeTimeLabel);

        // 用戶2的作息條
        const user2Bar = document.createElement('div');
        user2Bar.classList.add('schedule-bar', 'user2');
        const user2StartPercent = (user2Start / 24) * 100;
        let user2EndPercent = (user2End / 24) * 100;
        if (user2EndPercent > 100) user2EndPercent = 100; // 限制最大為100%
        const user2Width = user2EndPercent - user2StartPercent;
        user2Bar.style.left = `${user2StartPercent}%`;
        user2Bar.style.width = `${user2Width}%`;
        scheduleContainer.appendChild(user2Bar);

        const user2WakeTimeLabel = document.createElement('div');

        if (user2Schedule[0] < 18 && (user2Schedule[1] > 18 || user2Schedule[1] < user2Schedule[0])) {  // 起床時間在當天18:00之前，需在圖表開始處顯示
            const user2AdditionalBar = document.createElement('div');
            user2AdditionalBar.classList.add('schedule-bar', 'user2');
            const user2AdditionalEndPercent = (convertTime(user2Schedule[1]) / 24) * 100;
            user2AdditionalBar.style.left = '0%';
            user2AdditionalBar.style.width = `${user2AdditionalEndPercent}%`;
            scheduleContainer.appendChild(user2AdditionalBar);

            user2WakeTimeLabel.style.left = `${user2AdditionalEndPercent}%`;
        } else {
            user2WakeTimeLabel.style.left = `${user2EndPercent}%`;
        }

        // 用戶2的睡眠和起床時間標籤
        const user2SleepTimeLabel = document.createElement('div');
        user2SleepTimeLabel.classList.add('time-label-text', 'user2-label');
        user2SleepTimeLabel.textContent = formatTime(user2Schedule[0]);
        user2SleepTimeLabel.style.left = `${user2StartPercent}%`;
        scheduleContainer.appendChild(user2SleepTimeLabel);

        user2WakeTimeLabel.classList.add('time-label-text', 'user2-label');
        user2WakeTimeLabel.textContent = formatTime(user2Schedule[1]);
        scheduleContainer.appendChild(user2WakeTimeLabel);

        scheduleCell.appendChild(scheduleContainer);
        row.appendChild(scheduleCell);

        // 將行添加到表格中
        tableBody.appendChild(row);
    });
}


// // 初始化顯示
// document.getElementById('differentPreferences').classList.add('hidden');
//
// // 添加按鈕事件監聽器
// document.getElementById('toggleButton').addEventListener('click', toggleDisplay);