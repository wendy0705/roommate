let matchResults = [];

const storedResults = localStorage.getItem('matchResults');
if (storedResults) {
    matchResults = JSON.parse(storedResults);
    console.log(matchResults);
}

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
    let sameResult = '';       // 用於儲存相同的偏好
    let differentResult = '';  // 用於儲存不同的偏好

    // 表格的開頭
    const tableHeaderSingle = `
        <table class="comparison-table centered">
            <thead>
                <tr>
                    <th>興趣/偏好</th>
                    <th class="center-column">結果</th>  <!-- 只顯示結果，無需顯示“你” -->
                </tr>
            </thead>
            <tbody>
    `;

    const tableHeaderComparison = `
        <table class="comparison-table">
            <thead>
                <tr>
                    <th>興趣/偏好</th>
                    <th class="user-column">你</th>
                    <th class="user-column">這位用戶</th>  <!-- 顯示兩位用戶的比較 -->
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
        if (user1[key] === user2[key]) {
            // 相同偏好，只顯示 user1 的資料並置中
            sameResult += `
                <tr>
                    <td>${preferences[key]}</td>
                    <td class="centered">${translateBasicPreference(key, user1[key])}</td>
                </tr>
            `;
        } else {
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
        if (user1.special_conditions[key] === user2.special_conditions[key]) {
            // 相同偏好，只顯示 user1 的資料並置中
            sameResult += `
                <tr>
                    <td>接受${specialConditionsLabels[key]}</td>
                    <td class="centered">${translateCategoryPreference('special_conditions', key, user1.special_conditions[key])}</td>
                </tr>
            `;
        } else {
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

    // 比較作息時間
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

    for (let day of days) {
        const user1Schedule = user1.schedule[day];
        const user2Schedule = user2.schedule[day];

        if (user1Schedule[0] === user2Schedule[0] && user1Schedule[1] === user2Schedule[1]) {
            // 相同作息，只顯示一人的資料並置中
            sameResult += `
                <tr>
                    <td>${daysLabels[day]} 作息</td>
                    <td class="centered">${user1Schedule[0]}:00 - ${user1Schedule[1]}:00</td>
                </tr>
            `;
        } else {
            // 不同作息，顯示兩位用戶的比較
            differentResult += `
                <tr>
                    <td>${daysLabels[day]} 作息</td>
                    <td>${user1Schedule[0]}:00 - ${user1Schedule[1]}:00</td>
                    <td>${user2Schedule[0]}:00 - ${user2Schedule[1]}:00</td>
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
        if (user1.dining_habits[key] === user2.dining_habits[key]) {
            // 相同偏好，只顯示一人的資料並置中
            sameResult += `
                <tr>
                    <td>用餐習慣：${diningHabitsLabels[key]}</td>
                    <td class="centered">${user1.dining_habits[key] === 1 ? "是" : "否"}</td>
                </tr>
            `;
        } else {
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
        if (user1.noise_sensitivity[key] === user2.noise_sensitivity[key]) {
            // 相同偏好，只顯示一人的資料並置中
            sameResult += `
                <tr>
                    <td>${noiseLabels[key]}</td>
                    <td class="centered">${translateNoiseSensitivity(key, user1.noise_sensitivity[key])}</td>
                </tr>
            `;
        } else {
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
    if (user1.alarm_habit === user2.alarm_habit) {
        sameResult += `
            <tr>
                <td>鬧鐘使用習慣</td>
                <td class="centered">${translateAlarmHabit(user1.alarm_habit)}</td>
            </tr>
        `;
    } else {
        differentResult += `
            <tr>
                <td>鬧鐘使用習慣</td>
                <td>${translateAlarmHabit(user1.alarm_habit)}</td>
                <td>${translateAlarmHabit(user2.alarm_habit)}</td>
            </tr>
        `;
    }

    // 比較燈光敏感度
    if (user1.light_sensitivity === user2.light_sensitivity) {
        sameResult += `
            <tr>
                <td>燈光敏感度</td>
                <td class="centered">${translateLightSensitivity(user1.light_sensitivity)}</td>
            </tr>
        `;
    } else {
        differentResult += `
            <tr>
                <td>燈光敏感度</td>
                <td>${translateLightSensitivity(user1.light_sensitivity)}</td>
                <td>${translateLightSensitivity(user2.light_sensitivity)}</td>
            </tr>
        `;
    }

    // 比較交友習慣
    if (user1.friendship_habit === user2.friendship_habit) {
        sameResult += `
            <tr>
                <td>交友習慣</td>
                <td class="centered">${translateFriendshipHabit(user1.friendship_habit)}</td>
            </tr>
        `;
    } else {
        differentResult += `
            <tr>
                <td>交友習慣</td>
                <td>${translateFriendshipHabit(user1.friendship_habit)}</td>
                <td>${translateFriendshipHabit(user2.friendship_habit)}</td>
            </tr>
        `;
    }

    // 比較天氣熱時偏好
    if (user1.hot_weather_preference.preference === user2.hot_weather_preference.preference &&
        user1.hot_weather_preference.temperature === user2.hot_weather_preference.temperature) {
        // 相同偏好，只顯示一人的資料並置中
        sameResult += `
            <tr>
                <td>天氣熱時偏好</td>
                <td class="centered">${translateHotWeatherPreference(user1.hot_weather_preference.preference, user1.hot_weather_preference.temperature)}</td>
            </tr>
        `;
    } else {
        // 不同偏好，顯示兩位用戶的比較
        differentResult += `
            <tr>
                <td>天氣熱時偏好</td>
                <td>${translateHotWeatherPreference(user1.hot_weather_preference.preference, user1.hot_weather_preference.temperature)}</td>
                <td>${translateHotWeatherPreference(user2.hot_weather_preference.preference, user2.hot_weather_preference.temperature)}</td>
            </tr>
        `;
    }

    // 比較濕度高時偏好
    if (user1.humidity_preference === user2.humidity_preference) {
        sameResult += `
            <tr>
                <td>濕度高時偏好</td>
                <td class="centered">${translateHumidityPreference(user1.humidity_preference)}</td>
            </tr>
        `;
    } else {
        differentResult += `
            <tr>
                <td>濕度高時偏好</td>
                <td>${translateHumidityPreference(user1.humidity_preference)}</td>
                <td>${translateHumidityPreference(user2.humidity_preference)}</td>
            </tr>
        `;
    }

    // 定義用戶標籤
    let userLabels = [];
    // 定義數據
    let data = [];
    // 定義顏色
    let backgroundColors = [];

    if (user1.humidity_preference === user2.humidity_preference) {
        // 如果相同，只顯示一個用戶
        userLabels.push('你');
        data.push(user1.humidity_preference);
        backgroundColors.push('rgba(54, 162, 235, 0.6)'); // 你用一種顏色
    } else {
        // 如果不同，顯示兩個用戶
        userLabels.push('你');
        userLabels.push('這位用戶');
        data.push(user1.humidity_preference);
        data.push(user2.humidity_preference);
        backgroundColors.push('rgba(54, 162, 235, 0.6)'); // 你用一種顏色
        backgroundColors.push('rgba(255, 99, 132, 0.6)'); // 這位用戶用另一種顏色
    }

    // 獲取 canvas 元素
    const ctx = document.getElementById('humidityChart').getContext('2d');

    // 創建橫向長條圖
    const humidityChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: userLabels,
            datasets: [{
                label: '濕度高時偏好',
                data: data,
                backgroundColor: backgroundColors,
                borderColor: backgroundColors.map(color => color.replace('0.6', '1')),
                borderWidth: 1,
                minBarLength: 5
            }]
        },
        options: {
            indexAxis: 'y', // 橫向長條圖
            scales: {
                x: {
                    beginAtZero: true,
                    min: 0,
                    max: 2,
                    ticks: {
                        stepSize: 1,
                        precision: 0,
                        callback: function (value) {
                            const translations = ["不開除濕", "不常開除濕", "會開除濕"];
                            return translations[value] || value;
                        }
                    },
                    title: {
                        display: true,
                        text: '濕度高時偏好'
                    }
                },
                y: {
                    title: {
                        display: true,
                        text: '用戶'
                    }
                }
            },
            plugins: {
                title: {
                    display: true,
                    text: '用戶濕度高時的偏好比較'
                },
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            const label = context.dataset.label || '';
                            const value = context.parsed.x;
                            const translated = translateHumidityPreference(value);
                            return label + ': ' + translated;
                        }
                    }
                }
            }
        }
    });

    // 比較寵物
    if (user1.pet.has_pet === user2.pet.has_pet &&
        (user1.pet.has_pet === 0 || user1.pet.pet_type === user2.pet.pet_type)) {
        // 相同偏好，只顯示一人的資料並置中
        sameResult += `
            <tr>
                <td>寵物</td>
                <td class="centered">${translatePet(user1.pet.has_pet, user1.pet.pet_type)}</td>
            </tr>
        `;
    } else {
        // 不同偏好，顯示兩位用戶的比較
        differentResult += `
            <tr>
                <td>寵物</td>
                <td>${translatePet(user1.pet.has_pet, user1.pet.pet_type)}</td>
                <td>${translatePet(user2.pet.has_pet, user2.pet.pet_type)}</td>
            </tr>
        `;
    }

    // 如果有相同的偏好結果，將其包裝成表格
    if (sameResult) {
        sameResult = tableHeaderSingle + sameResult + tableFooter;
    } else {
        sameResult = '<p>無相同的偏好</p>';  // 如果沒有相同的偏好
    }

    // 如果有不同的偏好結果，將其包裝成表格
    if (differentResult) {
        differentResult = tableHeaderComparison + differentResult + tableFooter;
    } else {
        differentResult = '<p>無不同的偏好</p>';  // 如果沒有不同的偏好
    }

    // 將結果顯示在不同的區域
    document.getElementById('samePreferences').innerHTML = sameResult;
    document.getElementById('differentPreferences').innerHTML = differentResult;
}


function toggleDisplay() {
    const samePreferences = document.getElementById('samePreferences');
    const differentPreferences = document.getElementById('differentPreferences');

    samePreferences.classList.toggle('hidden');
    differentPreferences.classList.toggle('hidden');

    const button = document.getElementById('toggleButton');
    if (samePreferences.classList.contains('hidden')) {
        button.textContent = '顯示相同偏好';
    } else {
        button.textContent = '顯示不同偏好';
    }
}

if (matchResults.length > 0) {
    const item = matchResults[0]; // 假設我們使用第一個匹配結果
    const userPreference = item.myPreference; // 假設當前用戶的偏好
    const othersPreference = item.othersPreference;

    comparePreferences(userPreference, othersPreference);
} else {
    console.log('No match results found');
}

// 初始化顯示
document.getElementById('differentPreferences').classList.add('hidden');

// 添加按鈕事件監聽器
document.getElementById('toggleButton').addEventListener('click', toggleDisplay);