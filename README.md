# 室友媒合平台

這是一個解決學生宿舍生活習慣不合及家庭式租屋找室友需求的媒合平台，提供多元的生活習慣匹配、即時聊天和視覺化租屋選項等功能，協助使用者找到最合適的室友及理想的居住空間。

## 專案概述

- **專案名稱**：室友媒合平台
- **目標**：協助使用者根據生活習慣、興趣及租房偏好尋找合適的室友
- **主要功能**：
  - 支援填寫租屋資訊及生活習慣調查
  - 提供精確的室友匹配邏輯，依據居住需求和生活習慣推薦室友
  - 支援即時聊天功能，包含邀請和接受聊天邀請

## 目標使用者

- **學生或上班族**：需要與人共住家庭式房型，但希望有合適的生活習慣及租屋偏好匹配的室友。

## 系統架構
![image](https://github.com/wendy0705/roommate/blob/main/%E6%9E%B6%E6%A7%8B%E5%9C%96.jpeg)
- **後端**：Java Spring Boot
- **數據庫**：MySQL, MongoDB
- **雲端服務**：AWS S3, EC2
- **即時通信**：WebSocket
- **地圖服務**：Google Maps API
- **反向代理**：Nginx

## Schema
![image](https://github.com/wendy0705/roommate/blob/main/schema.jpeg)

## 功能說明
「室友媒合平台」主要服務於尋找家庭式租屋的使用者，分為兩種情境：
1. **已找到房子的使用者**
2. **尚未找到房子的使用者**
   
系統透過 Google Maps API，讓使用者框選理想的租屋範圍，並填寫房型及預算等租屋資訊。首先，系統會根據這些租屋條件進行篩選，找出房屋需求有交集的潛在室友。

篩選後，使用者進入第二階段，填寫詳細的興趣和生活習慣調查。根據這些數據，系統會計算使用者之間的匹配度，並依據匹配度高低進行排序，以協助使用者找到更符合生活習慣與興趣的合適室友。

### 租屋資訊填寫
- **房屋資訊**：讓使用者填寫租屋地區、預算、租期等基本資訊。
- **房型及設施**：用戶可選擇適合的房型及提供的設施選項。

### 生活習慣匹配
（以下僅列出部分項目）
- **作息時間**：週一至週日的睡眠和起床時間，以歐幾里得距離計算匹配度。
- **用餐及開伙習慣**：用戶可選擇是否會在家用餐及開伙，並選擇用餐位置。
- **噪音及燈光敏感度**：用戶可選擇噪音及燈光的接受程度。
- **興趣和交友習慣**

### 室友媒合邏輯
依據生活習慣和租屋需求進行匹配，並提供以下匹配演算法：
- **Jaccard 相似度**：用於二元類別（如是否會在家開伙）和多選類別（如租屋條件）。
- **歐幾里得距離**：用於數值型資料（如睡眠時間、噪音敏感度）。

### 即時聊天
- **聊聊邀請**：使用者可以發送聊天邀請，接受後即時開啟聊天功能。

## 使用說明
1. **註冊或登入**
2. **填寫問卷**：填寫租屋及生活習慣資訊，包括租屋需求、生活習慣及興趣。
3. **搜尋潛在室友**：系統根據相似度計算推薦合適的室友。
4. **發送並接受聊聊邀請**：若彼此合適，即可開啟即時聊天。

## 開發者資訊
- **開發者**：江彤恩
- **聯絡方式**：若有問題請聯繫：wendy9007054@gmail.com


