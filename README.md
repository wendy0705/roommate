室友媒合平台
這是一個解決學生宿舍生活習慣不合及家庭式租屋找室友需求的媒合平台，提供多元的生活習慣匹配、即時聊天和視覺化租屋選項等功能，協助使用者找到最合適的室友及理想的居住空間。

專案概述
專案名稱：室友媒合平台
目標：協助使用者根據生活習慣、興趣及租房偏好尋找合適的室友
主要功能：
支援填寫租屋資訊及生活習慣調查
提供精確的室友匹配邏輯，依據居住需求和生活習慣推薦室友
支援即時聊天功能，包含邀請和接受聊天邀請
目標使用者
學生或上班族：需要與人共住，但希望有合適的生活習慣及租屋偏好匹配的室友。
系統架構
系統分為租屋匹配和宿舍匹配兩部分。透過 Google Maps API，使用者可以框選租屋範圍，並透過提供的篩選條件及填寫的生活習慣問卷進行個性化匹配。

功能說明
租屋資訊填寫
房屋資訊：讓使用者填寫租屋地區、預算、租期等基本資訊。
房型及設施：用戶可選擇適合的房型及提供的設施選項。
生活習慣匹配
作息時間：週一至週日的睡眠和起床時間，以歐幾里得距離計算匹配度。
用餐及開伙習慣：用戶可選擇是否會在家用餐及開伙，並選擇用餐位置。
噪音及燈光敏感度：用戶可選擇噪音及燈光的接受程度。
興趣和交友習慣：使用餘弦相似度分析興趣標籤，並顯示交友和帶朋友回家的偏好。
室友媒合邏輯
依據生活習慣和租屋需求進行匹配，並提供以下匹配演算法：

Jaccard 相似度：用於二元類別（如是否會在家開伙）和多選類別（如租屋條件）。
歐幾里得距離：用於數值型資料（如睡眠時間、噪音敏感度）。
餘弦相似度：用於文本型資料（如興趣和交友習慣）。
即時聊天
聊聊邀請：使用者可以發送聊天邀請，接受後即時開啟聊天功能。
視覺化模糊：開始聊天後，用戶的照片將逐漸清晰，以增加互動。
API 端點
GET /map：使用 Google Maps API 篩選租屋範圍。
POST /submitDormData：提交宿舍相關資料，用於匹配。
POST /data/similarity：計算生活習慣相似度，提供個性化推薦。
安裝與執行
系統需求
後端：Java Spring Boot
數據庫：MySQL, MongoDB
雲端服務：AWS S3, EC2
即時通信：WebSocket
地圖服務：Google Maps API
安裝步驟
克隆專案到本地：git clone <repository-url>
安裝依賴：mvn install
配置 .env 文件，包括數據庫和 Google Maps API 金鑰
啟動服務：mvn spring-boot:run
使用說明
註冊並登入：填寫租屋及生活習慣資訊。
填寫問卷：包括租屋需求、生活習慣及興趣。
搜尋潛在室友：系統根據相似度計算推薦合適的室友。
發送並接受聊聊邀請：若彼此合適，即可開啟即時聊天。
開發者資訊
開發者：江彤恩
技術支援：AppWorks School
