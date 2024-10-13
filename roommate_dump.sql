-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (arm64)
--
-- Host: localhost    Database: roommate
-- ------------------------------------------------------
-- Server version	8.0.38

/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE = @@TIME_ZONE */;
/*!40103 SET TIME_ZONE = '+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;

--
-- Table structure for table `available_room`
--

DROP TABLE IF EXISTS `available_room`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `available_room`
(
    `id`            bigint NOT NULL AUTO_INCREMENT,
    `data_id`       bigint DEFAULT NULL,
    `room_id`       bigint DEFAULT NULL,
    `price`         int    DEFAULT NULL,
    `rental_period` int    DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `data_id` (`data_id`),
    KEY `room_id` (`room_id`),
    CONSTRAINT `available_room_ibfk_1` FOREIGN KEY (`data_id`) REFERENCES `rented_house_data` (`id`) ON DELETE CASCADE,
    CONSTRAINT `available_room_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rental_room` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available_room`
--

LOCK TABLES `available_room` WRITE;
/*!40000 ALTER TABLE `available_room`
    DISABLE KEYS */;
INSERT INTO `available_room`
VALUES (1, 1, 1, 5000, 6),
       (2, 1, 1, 7000, 7),
       (3, 2, 1, 7000, 6),
       (4, 2, 1, 8000, 12),
       (5, 3, 1, 6000, 12),
       (6, 3, 3, 10000, 4);
/*!40000 ALTER TABLE `available_room`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_invitation`
--

DROP TABLE IF EXISTS `chat_invitation`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_invitation`
(
    `id`                bigint    NOT NULL AUTO_INCREMENT,
    `inviter_id`        bigint                                 DEFAULT NULL,
    `invitee_id`        bigint                                 DEFAULT NULL,
    `invitation_status` enum ('pending','accepted','declined') DEFAULT 'pending',
    `invite_time`       timestamp NULL                         DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `inviter_id` (`inviter_id`),
    KEY `invitee_id` (`invitee_id`),
    CONSTRAINT `chat_invitation_ibfk_1` FOREIGN KEY (`inviter_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
    CONSTRAINT `chat_invitation_ibfk_2` FOREIGN KEY (`invitee_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_invitation`
--

LOCK TABLES `chat_invitation` WRITE;
/*!40000 ALTER TABLE `chat_invitation`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_invitation`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_message`
--

DROP TABLE IF EXISTS `chat_message`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_message`
(
    `id`           bigint    NOT NULL AUTO_INCREMENT,
    `room_id`      bigint         DEFAULT NULL,
    `sender_id`    bigint         DEFAULT NULL,
    `message_text` text,
    `send_time`    timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `room_id` (`room_id`),
    KEY `sender_id` (`sender_id`),
    CONSTRAINT `chat_message_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `chat_room` (`id`) ON DELETE CASCADE,
    CONSTRAINT `chat_message_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_message`
--

LOCK TABLES `chat_message` WRITE;
/*!40000 ALTER TABLE `chat_message`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_message`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_room`
--

DROP TABLE IF EXISTS `chat_room`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_room`
(
    `id`         bigint NOT NULL AUTO_INCREMENT,
    `inviter_id` bigint DEFAULT NULL,
    `invitee_id` bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `inviter_id` (`inviter_id`),
    KEY `invitee_id` (`invitee_id`),
    CONSTRAINT `chat_room_ibfk_2` FOREIGN KEY (`invitee_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_room`
--

LOCK TABLES `chat_room` WRITE;
/*!40000 ALTER TABLE `chat_room`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_room`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dorm`
--

DROP TABLE IF EXISTS `dorm`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dorm`
(
    `id`        bigint NOT NULL AUTO_INCREMENT,
    `dorm_name` varchar(255) DEFAULT NULL,
    `school_id` bigint       DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `school_id` (`school_id`),
    CONSTRAINT `dorm_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 34
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dorm`
--

LOCK TABLES `dorm` WRITE;
/*!40000 ALTER TABLE `dorm`
    DISABLE KEYS */;
INSERT INTO `dorm`
VALUES (1, '莊敬 1 舍', 1),
       (2, '莊敬 9 舍', 1),
       (3, '自強 7 舍', 1),
       (4, '自強 8 舍', 1),
       (5, '自強 9 舍', 1),
       (6, '自強 10 舍', 1),
       (7, '莊敬 2 舍', 1),
       (8, '莊敬 3 舍', 1),
       (9, '自強 5 舍', 1),
       (10, '自強 6 舍', 1),
       (11, '自強 1 舍', 1),
       (12, '自強 3 舍', 1),
       (13, '男一舍', 2),
       (14, '男二舍', 2),
       (15, '男三舍', 2),
       (16, '男四舍', 2),
       (17, '男五舍', 2),
       (18, '男六舍', 2),
       (19, '男七舍', 2),
       (20, '男八舍', 2),
       (21, '男研一舍', 2),
       (22, '男研三舍', 2),
       (23, '大一女舍', 2),
       (24, '女一舍', 2),
       (25, '女二舍', 2),
       (26, '女三舍', 2),
       (27, '女四舍', 2),
       (28, '女五舍', 2),
       (29, '女六舍', 2),
       (30, '女八舍', 2),
       (31, '女九舍', 2),
       (32, '女研一舍', 2),
       (33, '女研三舍', 2);
/*!40000 ALTER TABLE `dorm`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dorm_data`
--

DROP TABLE IF EXISTS `dorm_data`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dorm_data`
(
    `id`           bigint NOT NULL AUTO_INCREMENT,
    `user_id`      bigint     DEFAULT NULL,
    `applied_dorm` tinyint(1) DEFAULT NULL,
    `school_id`    bigint     DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `user_id` (`user_id`),
    KEY `school_id` (`school_id`),
    CONSTRAINT `dorm_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
    CONSTRAINT `dorm_data_ibfk_2` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dorm_data`
--

LOCK TABLES `dorm_data` WRITE;
/*!40000 ALTER TABLE `dorm_data`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `dorm_data`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dorm_room`
--

DROP TABLE IF EXISTS `dorm_room`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dorm_room`
(
    `id`        bigint NOT NULL AUTO_INCREMENT,
    `room_type` varchar(255) DEFAULT NULL,
    `dorm_id`   bigint       DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `dorm_id` (`dorm_id`),
    CONSTRAINT `dorm_room_ibfk_1` FOREIGN KEY (`dorm_id`) REFERENCES `dorm` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 40
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dorm_room`
--

LOCK TABLES `dorm_room` WRITE;
/*!40000 ALTER TABLE `dorm_room`
    DISABLE KEYS */;
INSERT INTO `dorm_room`
VALUES (1, '2人雅房 - 莊一', 1),
       (2, '4人雅房 - 莊一', 1),
       (3, '2人雅房 - 莊九', 2),
       (4, '3人雅房 - 莊九', 2),
       (5, '4人雅房 - 莊九', 2),
       (6, '4人雅房 - 自七', 3),
       (7, '4人雅房 - 自八', 4),
       (8, '4人雅房 - 自九', 5),
       (9, '2人套房 - 自十', 6),
       (10, '2人雅房 - 莊二', 7),
       (11, '4人雅房 - 莊二', 7),
       (12, '2人雅房 - 莊三', 8),
       (13, '4人雅房 - 莊三', 8),
       (14, '4人雅房 - 自五', 9),
       (15, '4人雅房 - 自六', 10),
       (16, '2人套房 - 自一', 11),
       (17, '2人雅房 - 自九', 5),
       (18, '2人套房 - 自十', 6),
       (19, '4人雅房 - 男一', 13),
       (20, '4人雅房 - 男二', 14),
       (21, '4人雅房 - 男三', 15),
       (22, '4人雅房 - 男四', 16),
       (23, '4人雅房 - 男五', 17),
       (24, '4人雅房 - 男六', 18),
       (25, '4人雅房 - 男七', 19),
       (26, '4人雅房 - 男八', 20),
       (27, '2人套房 - 男研一', 21),
       (28, '2人套房 - 男研三', 22),
       (29, '4人雅房 - 大一女', 23),
       (30, '4人雅房 - 女一', 24),
       (31, '4人雅房 - 女二', 25),
       (32, '4人雅房 - 女三', 26),
       (33, '4人雅房 - 女四', 27),
       (34, '4人雅房 - 女五', 28),
       (35, '4人雅房 - 女六', 29),
       (36, '4人雅房 - 女八', 30),
       (37, '4人套房 - 女九', 31),
       (38, '2人套房 - 女研一', 32),
       (39, '2人套房 - 女研三', 33);
/*!40000 ALTER TABLE `dorm_room`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `non_rented_data`
--

DROP TABLE IF EXISTS `non_rented_data`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `non_rented_data`
(
    `id`            bigint NOT NULL AUTO_INCREMENT,
    `user_id`       bigint DEFAULT NULL,
    `region_ne_lat` double DEFAULT NULL,
    `region_ne_lng` double DEFAULT NULL,
    `region_sw_lat` double DEFAULT NULL,
    `region_sw_lng` double DEFAULT NULL,
    `rental_period` int    DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `user_id` (`user_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 12
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `non_rented_data`
--

LOCK TABLES `non_rented_data` WRITE;
/*!40000 ALTER TABLE `non_rented_data`
    DISABLE KEYS */;
INSERT INTO `non_rented_data`
VALUES (2, 5, 25.05492621848587, 121.55355536499023, 25.039374389670403, 121.52883612670898, 12),
       (3, 7, 25.045906398036156, 121.57175147094726, 25.03035342524682, 121.52935111083984, 12),
       (4, 2, 25.05585926547989, 121.59526907958984, 25.038596746452434, 121.5382775024414, 12),
       (8, 8, 25.05492621848587, 121.57827460327148, 24.994262936635014, 121.54171072998047, 12),
       (10, 4, 25.075607093475078, 121.53604590454101, 25.028798019511786, 121.51561820068359, 12);
/*!40000 ALTER TABLE `non_rented_data`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occupied_room`
--

DROP TABLE IF EXISTS `occupied_room`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `occupied_room`
(
    `id`          bigint NOT NULL AUTO_INCREMENT,
    `description` text,
    `data_id`     bigint DEFAULT NULL,
    `room_id`     bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `data_id` (`data_id`),
    KEY `room_id` (`room_id`),
    CONSTRAINT `occupied_room_ibfk_1` FOREIGN KEY (`data_id`) REFERENCES `rented_house_data` (`id`) ON DELETE CASCADE,
    CONSTRAINT `occupied_room_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rental_room` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occupied_room`
--

LOCK TABLES `occupied_room` WRITE;
/*!40000 ALTER TABLE `occupied_room`
    DISABLE KEYS */;
INSERT INTO `occupied_room`
VALUES (1, '男大學生', 1, 1),
       (2, '女大學生', 2, 1),
       (3, '女醫生', 3, 1);
/*!40000 ALTER TABLE `occupied_room`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rental_room`
--

DROP TABLE IF EXISTS `rental_room`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rental_room`
(
    `id`        bigint NOT NULL AUTO_INCREMENT,
    `room_type` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 5
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rental_room`
--

LOCK TABLES `rental_room` WRITE;
/*!40000 ALTER TABLE `rental_room`
    DISABLE KEYS */;
INSERT INTO `rental_room`
VALUES (1, '單人雅房'),
       (2, '雙人雅房'),
       (3, '單人套房'),
       (4, '雙人套房');
/*!40000 ALTER TABLE `rental_room`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rented_house_data`
--

DROP TABLE IF EXISTS `rented_house_data`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rented_house_data`
(
    `id`          bigint NOT NULL AUTO_INCREMENT,
    `user_id`     bigint       DEFAULT NULL,
    `address_lat` double       DEFAULT NULL,
    `address_lng` double       DEFAULT NULL,
    `house_name`  varchar(255) DEFAULT NULL,
    `details`     json         DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `user_id` (`user_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rented_house_data`
--

LOCK TABLES `rented_house_data` WRITE;
/*!40000 ALTER TABLE `rented_house_data`
    DISABLE KEYS */;
INSERT INTO `rented_house_data`
VALUES (1, 6, 25.0442108, 121.537186, '忠泰美術館', '{
  \"other\": \"訪客限制\",
  \"amenities\": \"冷氣、冰箱、洗衣機\",
  \"pet_allowed\": true,
  \"rental_period\": 12,
  \"shared_spaces\": \"客廳、廚房、衛浴\",
  \"additional_fees\": \"電費：5 元 / 1 度\",
  \"nearby_facilities\": \"便利商店、超市\"
}'),
       (2, 3, 25.0421272, 121.5449393, '遠東SOGO 台北忠孝館', '{
         \"other\": \"訪客限制\",
         \"amenities\": \"冷氣、冰箱、洗衣機\",
         \"pet_allowed\": true,
         \"rental_period\": 12,
         \"shared_spaces\": \"客廳、廚房、衛浴\",
         \"additional_fees\": \"電費：5 元 / 1 度\",
         \"nearby_facilities\": \"便利商店、超市\"
       }'),
       (3, 1, 25.0472361, 121.5429923, '林東芳牛肉麵', '{
         \"other\": \"訪客限制\\n\",
         \"amenities\": \"冷氣、冰箱、洗衣機\",
         \"pet_allowed\": true,
         \"rental_period\": 12,
         \"shared_spaces\": \"客廳、廚房、衛浴\",
         \"additional_fees\": \"電費：5 元 / 1 度\",
         \"nearby_facilities\": \"便利商店、超市\"
       }');
/*!40000 ALTER TABLE `rented_house_data`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school`
(
    `id`          bigint NOT NULL AUTO_INCREMENT,
    `school_name` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school`
--

LOCK TABLES `school` WRITE;
/*!40000 ALTER TABLE `school`
    DISABLE KEYS */;
INSERT INTO `school`
VALUES (1, '國立政治大學'),
       (2, '國立台灣大學');
/*!40000 ALTER TABLE `school`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

# DROP TABLE IF EXISTS `user`;
# /*!40101 SET @saved_cs_client     = @@character_set_client */;
# /*!50503 SET character_set_client = utf8mb4 */;
# CREATE TABLE `user` (
#   `id` bigint NOT NULL,
#   `email` varchar(255) DEFAULT NULL,
#   `password` varchar(255) DEFAULT NULL,
#   `share_room` int DEFAULT NULL,
#   `haunted_house` int DEFAULT NULL,
#   `rooftop_extension` int DEFAULT NULL,
#   `illegal_building` int DEFAULT NULL,
#   `basement` int DEFAULT NULL,
#   `windowless` int DEFAULT NULL,
#   `monday_wakeup` int DEFAULT NULL,
#   `monday_sleep` int DEFAULT NULL,
#   `tuesday_wakeup` int DEFAULT NULL,
#   `tuesday_sleep` int DEFAULT NULL,
#   `wednesday_wakeup` int DEFAULT NULL,
#   `wednesday_sleep` int DEFAULT NULL,
#   `thursday_wakeup` int DEFAULT NULL,
#   `thursday_sleep` int DEFAULT NULL,
#   `friday_sleep` int DEFAULT NULL,
#   `friday_wakeup` int DEFAULT NULL,
#   `saturday_sleep` int DEFAULT NULL,
#   `saturday_wakeup` int DEFAULT NULL,
#   `sunday_wakeup` int DEFAULT NULL,
#   `sunday_sleep` int DEFAULT NULL,
#   `cooking_location` int DEFAULT NULL,
#   `dining_location` int DEFAULT NULL,
#   `dining_alone` int DEFAULT NULL,
#   `dining_not_alone` int DEFAULT NULL,
#   `sleep_noise` int DEFAULT NULL,
#   `work_noise` int DEFAULT NULL,
#   `alarm_habit` int DEFAULT NULL,
#   `light_sensitivity` int DEFAULT NULL,
#   `friendship_habit` int DEFAULT NULL,
#   `hot_weather_preference` int DEFAULT NULL,
#   `temperature` int DEFAULT NULL,
#   `humidity_preference` int DEFAULT NULL,
#   `has_pet` int DEFAULT NULL,
#   `pet_type` varchar(255) DEFAULT NULL,
#   `interest_sports` int DEFAULT NULL,
#   `interest_travel` int DEFAULT NULL,
#   `interest_reading` int DEFAULT NULL,
#   `interest_wine_tasting` int DEFAULT NULL,
#   `interest_drama` int DEFAULT NULL,
#   `interest_astrology` int DEFAULT NULL,
#   `interest_programming` int DEFAULT NULL,
#   `interest_hiking` int DEFAULT NULL,
#   `interest_gaming` int DEFAULT NULL,
#   `interest_painting` int DEFAULT NULL,
#   `interest_idol_chasing` int DEFAULT NULL,
#   `interest_music` int DEFAULT NULL,
#   `hope` varchar(255) DEFAULT NULL,
#   PRIMARY KEY (`id`)
# ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
# /*!40101 SET character_set_client = @saved_cs_client */;
#
# --
# -- Dumping data for table `user`
# --
#
# LOCK TABLES `user` WRITE;
# /*!40000 ALTER TABLE `user` DISABLE KEYS */;
# INSERT INTO `user` VALUES (1506761450,NULL,NULL,1,0,0,0,1,1,23,8,23,8,23,8,23,8,8,23,10,1,1,10,0,1,1,0,2,5,0,0,0,0,0,0,1,'狗',1,0,1,0,1,0,1,0,0,0,0,1,'我希望我的室友愛乾淨'),(2372323332,NULL,NULL,1,0,0,0,1,1,23,8,23,8,23,8,23,8,8,23,10,1,1,10,0,1,1,0,2,5,0,0,0,2,0,0,1,'貓',1,0,1,0,1,0,1,0,0,0,0,1,'我希望我的室友跟我一起寫程式'),(2585278507,NULL,NULL,1,0,1,1,0,0,0,7,0,7,0,7,0,7,7,0,9,0,0,9,0,1,1,1,5,3,0,2,0,0,0,2,0,'',1,0,1,1,1,0,1,0,0,0,0,0,'我希望跟室友一起玩'),(3039582145,NULL,NULL,0,1,1,0,1,1,3,12,3,12,3,12,3,12,12,3,13,3,3,13,1,0,0,1,4,5,1,2,1,3,25,1,0,'',0,1,0,1,1,0,0,0,0,0,0,1,'我希望我的室友跟我一樣愛喝酒'),(5743390524,NULL,NULL,1,0,0,0,1,1,22,7,22,7,22,7,22,7,7,22,9,2,2,9,0,1,1,1,5,3,2,0,2,2,0,0,0,'',0,1,0,1,0,1,0,0,1,1,0,0,'我希望我的室友會陪我運動'),(6761839120,NULL,NULL,1,0,0,0,1,1,22,7,22,7,22,7,22,7,7,22,9,2,2,9,0,1,1,1,5,3,2,0,2,2,0,0,0,'',0,1,0,1,0,1,0,0,1,1,0,0,'我希望跟室友可以溝通'),(7251645126,NULL,NULL,1,0,1,1,0,0,0,7,0,7,0,7,0,7,7,0,9,0,0,9,0,1,1,1,5,3,0,2,0,0,0,2,0,'',1,1,0,0,0,0,0,0,0,0,0,0,'我希望我的室友是個好人'),(7349542382,NULL,NULL,1,0,0,0,1,1,2,10,2,10,2,10,2,10,10,2,9,1,1,9,0,1,1,1,5,3,0,1,0,0,0,0,0,'',0,1,0,0,1,1,0,0,0,0,0,0,'我希望我的室友會跟我一起追劇，喜歡韓劇就更棒了！');
# /*!40000 ALTER TABLE `user` ENABLE KEYS */;
# UNLOCK TABLES;

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user`
(
    `id`                     bigint NOT NULL AUTO_INCREMENT,
    `email`                  varchar(255) DEFAULT NULL,
    `password`               varchar(255) DEFAULT NULL,
    `share_room`             int          DEFAULT NULL,
    `haunted_house`          int          DEFAULT NULL,
    `rooftop_extension`      int          DEFAULT NULL,
    `illegal_building`       int          DEFAULT NULL,
    `basement`               int          DEFAULT NULL,
    `windowless`             int          DEFAULT NULL,
    `monday_wakeup`          int          DEFAULT NULL,
    `monday_sleep`           int          DEFAULT NULL,
    `tuesday_wakeup`         int          DEFAULT NULL,
    `tuesday_sleep`          int          DEFAULT NULL,
    `wednesday_wakeup`       int          DEFAULT NULL,
    `wednesday_sleep`        int          DEFAULT NULL,
    `thursday_wakeup`        int          DEFAULT NULL,
    `thursday_sleep`         int          DEFAULT NULL,
    `friday_sleep`           int          DEFAULT NULL,
    `friday_wakeup`          int          DEFAULT NULL,
    `saturday_sleep`         int          DEFAULT NULL,
    `saturday_wakeup`        int          DEFAULT NULL,
    `sunday_wakeup`          int          DEFAULT NULL,
    `sunday_sleep`           int          DEFAULT NULL,
    `cooking_location`       int          DEFAULT NULL,
    `dining_location`        int          DEFAULT NULL,
    `dining_alone`           int          DEFAULT NULL,
    `dining_not_alone`       int          DEFAULT NULL,
    `sleep_noise`            int          DEFAULT NULL,
    `work_noise`             int          DEFAULT NULL,
    `alarm_habit`            int          DEFAULT NULL,
    `light_sensitivity`      int          DEFAULT NULL,
    `friendship_habit`       int          DEFAULT NULL,
    `hot_weather_preference` int          DEFAULT NULL,
    `temperature`            int          DEFAULT NULL,
    `humidity_preference`    int          DEFAULT NULL,
    `has_pet`                int          DEFAULT NULL,
    `pet_type`               varchar(255) DEFAULT NULL,
    `interest_sports`        int          DEFAULT NULL,
    `interest_travel`        int          DEFAULT NULL,
    `interest_reading`       int          DEFAULT NULL,
    `interest_wine_tasting`  int          DEFAULT NULL,
    `interest_drama`         int          DEFAULT NULL,
    `interest_astrology`     int          DEFAULT NULL,
    `interest_programming`   int          DEFAULT NULL,
    `interest_hiking`        int          DEFAULT NULL,
    `interest_gaming`        int          DEFAULT NULL,
    `interest_painting`      int          DEFAULT NULL,
    `interest_idol_chasing`  int          DEFAULT NULL,
    `interest_music`         int          DEFAULT NULL,
    `hope`                   varchar(255) DEFAULT NULL,
    `name`                   varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user`
    DISABLE KEYS */;
INSERT INTO `user` (`email`, `password`, `share_room`, `haunted_house`, `rooftop_extension`, `illegal_building`,
                    `basement`, `windowless`, `monday_wakeup`, `monday_sleep`, `tuesday_wakeup`, `tuesday_sleep`,
                    `wednesday_wakeup`, `wednesday_sleep`, `thursday_wakeup`, `thursday_sleep`, `friday_sleep`,
                    `friday_wakeup`, `saturday_sleep`, `saturday_wakeup`, `sunday_wakeup`, `sunday_sleep`,
                    `cooking_location`, `dining_location`, `dining_alone`, `dining_not_alone`, `sleep_noise`,
                    `work_noise`, `alarm_habit`, `light_sensitivity`, `friendship_habit`, `hot_weather_preference`,
                    `temperature`, `humidity_preference`, `has_pet`, `pet_type`, `interest_sports`, `interest_travel`,
                    `interest_reading`, `interest_wine_tasting`, `interest_drama`, `interest_astrology`,
                    `interest_programming`, `interest_hiking`, `interest_gaming`, `interest_painting`,
                    `interest_idol_chasing`, `interest_music`, `hope`, `name`)
VALUES (NULL, NULL, 1, 0, 0, 0, 1, 1, 23, 8, 23, 8, 23, 8, 23, 8, 8, 23, 10, 1, 1, 10, 0, 1, 1, 0, 2, 5, 0, 0, 0, 0, 0,
        0, 1, '狗', 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, '我希望我的室友愛乾淨', '林先生'),
       (NULL, NULL, 1, 0, 0, 0, 1, 1, 23, 8, 23, 8, 23, 8, 23, 8, 8, 23, 10, 1, 1, 10, 0, 1, 1, 0, 2, 5, 0, 0, 0, 2, 0,
        0, 1, '貓', 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, '我希望我的室友跟我一起寫程式', '王小姐'),
       (NULL, NULL, 1, 0, 1, 1, 0, 0, 0, 7, 0, 7, 0, 7, 0, 7, 7, 0, 9, 0, 0, 9, 0, 1, 1, 1, 5, 3, 0, 2, 0, 0, 0, 2, 0,
        '', 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, '我希望跟室友一起玩', '張先生'),
       (NULL, NULL, 0, 1, 1, 0, 1, 1, 3, 12, 3, 12, 3, 12, 3, 12, 12, 3, 13, 3, 3, 13, 1, 0, 0, 1, 4, 5, 1, 2, 1, 3, 25,
        1, 0, '', 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, '我希望我的室友跟我一樣愛喝酒', '李小姐'),
       (NULL, NULL, 1, 0, 0, 0, 1, 1, 22, 7, 22, 7, 22, 7, 22, 7, 7, 22, 9, 2, 2, 9, 0, 1, 1, 1, 5, 3, 2, 0, 2, 2, 0, 0,
        0, '', 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, '我希望我的室友會陪我運動', '陳先生'),
       (NULL, NULL, 1, 0, 0, 0, 1, 1, 22, 7, 22, 7, 22, 7, 22, 7, 7, 22, 9, 2, 2, 9, 0, 1, 1, 1, 5, 3, 2, 0, 2, 2, 0, 0,
        0, '', 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, '我希望跟室友可以溝通', '劉小姐'),
       (NULL, NULL, 1, 0, 1, 1, 0, 0, 0, 7, 0, 7, 0, 7, 0, 7, 7, 0, 9, 0, 0, 9, 0, 1, 1, 1, 5, 3, 0, 2, 0, 0, 0, 2, 0,
        '', 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '我希望我的室友是個好人', '黃先生'),
       (NULL, NULL, 1, 0, 0, 0, 1, 1, 2, 10, 2, 10, 2, 10, 2, 10, 10, 2, 9, 1, 1, 9, 0, 1, 1, 1, 5, 3, 0, 1, 0, 0, 0, 0,
        0, '', 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, '我希望我的室友會跟我一起追劇，喜歡韓劇就更棒了！', '周小姐');
/*!40000 ALTER TABLE `user`
    ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `user_dorm_options`
--

DROP TABLE IF EXISTS `user_dorm_options`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_dorm_options`
(
    `id`           bigint NOT NULL AUTO_INCREMENT,
    `dorm_data_id` bigint DEFAULT NULL,
    `dorm_id`      bigint DEFAULT NULL,
    `dorm_room_id` bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `dorm_data_id` (`dorm_data_id`),
    KEY `dorm_id` (`dorm_id`),
    KEY `dorm_room_id` (`dorm_room_id`),
    CONSTRAINT `user_dorm_options_ibfk_1` FOREIGN KEY (`dorm_data_id`) REFERENCES `dorm_data` (`id`) ON DELETE CASCADE,
    CONSTRAINT `user_dorm_options_ibfk_2` FOREIGN KEY (`dorm_id`) REFERENCES `dorm` (`id`) ON DELETE CASCADE,
    CONSTRAINT `user_dorm_options_ibfk_3` FOREIGN KEY (`dorm_room_id`) REFERENCES `dorm_room` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dorm_options`
--

LOCK TABLES `user_dorm_options` WRITE;
/*!40000 ALTER TABLE `user_dorm_options`
    DISABLE KEYS */;
/*!40000 ALTER TABLE `user_dorm_options`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_match`
--

DROP TABLE IF EXISTS `user_match`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_match`
(
    `id`                          bigint NOT NULL AUTO_INCREMENT,
    `user_id_1`                   bigint        DEFAULT NULL,
    `user_id_2`                   bigint        DEFAULT NULL,
    `pet_same_or_not`             int           DEFAULT NULL,
    `noise_percentage`            decimal(8, 2) DEFAULT NULL,
    `weather_percentage`          decimal(8, 2) DEFAULT NULL,
    `interest_percentage`         decimal(8, 2) DEFAULT NULL,
    `humid_percentage`            decimal(8, 2) DEFAULT NULL,
    `schedule_percentage`         decimal(8, 2) DEFAULT NULL,
    `dining_location_same_or_not` int           DEFAULT NULL,
    `cook_location_same_or_not`   int           DEFAULT NULL,
    `dining_percentage`           decimal(8, 2) DEFAULT NULL,
    `shareroom_same_or_not`       int           DEFAULT NULL,
    `condition_percentage`        decimal(8, 2) DEFAULT NULL,
    `light_percentage`            decimal(8, 2) DEFAULT NULL,
    `alarm_percentage`            decimal(8, 2) DEFAULT NULL,
    `friend_percentage`           decimal(8, 2) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_user_1` (`user_id_1`),
    KEY `fk_user_2` (`user_id_2`),
    CONSTRAINT `fk_user_1` FOREIGN KEY (`user_id_1`) REFERENCES `user` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_user_2` FOREIGN KEY (`user_id_2`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_match`
--

LOCK TABLES `user_match` WRITE;
/*!40000 ALTER TABLE `user_match`
    DISABLE KEYS */;
INSERT INTO `user_match`
VALUES (17, 8, 7, 1, 1.00, 1.00, 0.75, 0.00, 0.94, 1, 1, 1.00, 1, 0.20, 0.50, 1.00, 1.00),
       (18, 8, 3, 1, 1.00, 1.00, 0.50, 0.00, 0.94, 1, 1, 1.00, 1, 0.20, 0.50, 1.00, 1.00),
       (19, 8, 1, 0, 0.55, 1.00, 0.50, 1.00, 0.94, 1, 1, 0.50, 1, 1.00, 0.50, 1.00, 1.00),
       (20, 8, 5, 1, 1.00, 0.33, 0.67, 1.00, 0.91, 1, 1, 1.00, 1, 1.00, 0.50, 0.00, 0.00),
       (21, 8, 2, 0, 0.55, 0.33, 0.50, 1.00, 0.94, 1, 1, 0.50, 1, 1.00, 0.50, 1.00, 1.00),
       (29, 4, 7, 1, 0.72, 0.00, 0.67, 0.50, 0.88, 0, 0, 0.50, 0, 0.20, 1.00, 0.50, 0.50),
       (30, 4, 5, 1, 0.72, 0.67, 0.58, 0.50, 0.87, 0, 0, 0.50, 0, 0.60, 0.00, 0.50, 0.50);
/*!40000 ALTER TABLE `user_match`
    ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wanted_room`
--

DROP TABLE IF EXISTS `wanted_room`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wanted_room`
(
    `id`         bigint NOT NULL AUTO_INCREMENT,
    `low_price`  int    DEFAULT NULL,
    `high_price` int    DEFAULT NULL,
    `data_id`    bigint DEFAULT NULL,
    `room_id`    bigint DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `data_id` (`data_id`),
    KEY `room_id` (`room_id`),
    CONSTRAINT `wanted_room_ibfk_1` FOREIGN KEY (`data_id`) REFERENCES `non_rented_data` (`id`) ON DELETE CASCADE,
    CONSTRAINT `wanted_room_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rental_room` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB
  AUTO_INCREMENT = 14
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wanted_room`
--

LOCK TABLES `wanted_room` WRITE;
/*!40000 ALTER TABLE `wanted_room`
    DISABLE KEYS */;
INSERT INTO `wanted_room`
VALUES (2, 2000, 7000, 2, 1),
       (3, 5000, 10000, 3, 1),
       (4, 6000, 12000, 3, 3),
       (5, 5000, 8000, 4, 1),
       (9, 2000, 9997, 8, 1),
       (11, 5000, 7000, 10, 1),
       (12, 7000, 10000, 10, 3);
/*!40000 ALTER TABLE `wanted_room`
    ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;

-- Dump completed on 2024-10-09  1:51:51
