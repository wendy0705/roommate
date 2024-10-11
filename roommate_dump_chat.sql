-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (arm64)
--
-- Host: localhost    Database: roommate
-- ------------------------------------------------------
-- Server version	8.0.38

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `available_room`
--

DROP TABLE IF EXISTS `available_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `available_room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `data_id` bigint DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  `price` int DEFAULT NULL,
  `rental_period` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `data_id` (`data_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `available_room_ibfk_1` FOREIGN KEY (`data_id`) REFERENCES `rented_house_data` (`id`) ON DELETE CASCADE,
  CONSTRAINT `available_room_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rental_room` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available_room`
--

LOCK TABLES `available_room` WRITE;
/*!40000 ALTER TABLE `available_room` DISABLE KEYS */;
INSERT INTO `available_room` VALUES (1,1,1,6000,6);
/*!40000 ALTER TABLE `available_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_invitation`
--

DROP TABLE IF EXISTS `chat_invitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_invitation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `inviter_id` bigint DEFAULT NULL,
  `invitee_id` bigint DEFAULT NULL,
  `invitation_status` enum('pending','accepted','declined') DEFAULT 'pending',
  `invite_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `inviter_id` (`inviter_id`),
  KEY `invitee_id` (`invitee_id`),
  CONSTRAINT `chat_invitation_ibfk_1` FOREIGN KEY (`inviter_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_invitation_ibfk_2` FOREIGN KEY (`invitee_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_invitation`
--

LOCK TABLES `chat_invitation` WRITE;
/*!40000 ALTER TABLE `chat_invitation` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_invitation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_message`
--

DROP TABLE IF EXISTS `chat_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `room_id` bigint DEFAULT NULL,
  `sender_id` bigint DEFAULT NULL,
  `message_text` text,
  `send_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `room_id` (`room_id`),
  KEY `sender_id` (`sender_id`),
  CONSTRAINT `chat_message_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `chat_room` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chat_message_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_message`
--

LOCK TABLES `chat_message` WRITE;
/*!40000 ALTER TABLE `chat_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_room`
--

DROP TABLE IF EXISTS `chat_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `inviter_id` bigint DEFAULT NULL,
  `invitee_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inviter_id` (`inviter_id`),
  KEY `invitee_id` (`invitee_id`),
  CONSTRAINT `chat_room_ibfk_2` FOREIGN KEY (`invitee_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_room`
--

LOCK TABLES `chat_room` WRITE;
/*!40000 ALTER TABLE `chat_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dorm`
--

DROP TABLE IF EXISTS `dorm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dorm` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dorm_name` varchar(255) DEFAULT NULL,
  `school_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `school_id` (`school_id`),
  CONSTRAINT `dorm_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dorm`
--

LOCK TABLES `dorm` WRITE;
/*!40000 ALTER TABLE `dorm` DISABLE KEYS */;
INSERT INTO `dorm` VALUES (1,'莊敬 1 舍',1),(2,'莊敬 9 舍',1),(3,'自強 7 舍',1),(4,'自強 8 舍',1),(5,'自強 9 舍',1),(6,'自強 10 舍',1),(7,'莊敬 2 舍',1),(8,'莊敬 3 舍',1),(9,'自強 5 舍',1),(10,'自強 6 舍',1),(11,'自強 1 舍',1),(12,'自強 3 舍',1),(13,'男一舍',2),(14,'男二舍',2),(15,'男三舍',2),(16,'男四舍',2),(17,'男五舍',2),(18,'男六舍',2),(19,'男七舍',2),(20,'男八舍',2),(21,'男研一舍',2),(22,'男研三舍',2),(23,'大一女舍',2),(24,'女一舍',2),(25,'女二舍',2),(26,'女三舍',2),(27,'女四舍',2),(28,'女五舍',2),(29,'女六舍',2),(30,'女八舍',2),(31,'女九舍',2),(32,'女研一舍',2),(33,'女研三舍',2);
/*!40000 ALTER TABLE `dorm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dorm_data`
--

DROP TABLE IF EXISTS `dorm_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dorm_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `applied_dorm` tinyint(1) DEFAULT NULL,
  `school_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `school_id` (`school_id`),
  CONSTRAINT `dorm_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dorm_data_ibfk_2` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dorm_data`
--

LOCK TABLES `dorm_data` WRITE;
/*!40000 ALTER TABLE `dorm_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `dorm_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dorm_room`
--

DROP TABLE IF EXISTS `dorm_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dorm_room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `room_type` varchar(255) DEFAULT NULL,
  `dorm_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dorm_id` (`dorm_id`),
  CONSTRAINT `dorm_room_ibfk_1` FOREIGN KEY (`dorm_id`) REFERENCES `dorm` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dorm_room`
--

LOCK TABLES `dorm_room` WRITE;
/*!40000 ALTER TABLE `dorm_room` DISABLE KEYS */;
INSERT INTO `dorm_room` VALUES (1,'2人雅房 - 莊一',1),(2,'4人雅房 - 莊一',1),(3,'2人雅房 - 莊九',2),(4,'3人雅房 - 莊九',2),(5,'4人雅房 - 莊九',2),(6,'4人雅房 - 自七',3),(7,'4人雅房 - 自八',4),(8,'4人雅房 - 自九',5),(9,'2人套房 - 自十',6),(10,'2人雅房 - 莊二',7),(11,'4人雅房 - 莊二',7),(12,'2人雅房 - 莊三',8),(13,'4人雅房 - 莊三',8),(14,'4人雅房 - 自五',9),(15,'4人雅房 - 自六',10),(16,'2人套房 - 自一',11),(17,'2人雅房 - 自九',5),(18,'2人套房 - 自十',6),(19,'4人雅房 - 男一',13),(20,'4人雅房 - 男二',14),(21,'4人雅房 - 男三',15),(22,'4人雅房 - 男四',16),(23,'4人雅房 - 男五',17),(24,'4人雅房 - 男六',18),(25,'4人雅房 - 男七',19),(26,'4人雅房 - 男八',20),(27,'2人套房 - 男研一',21),(28,'2人套房 - 男研三',22),(29,'4人雅房 - 大一女',23),(30,'4人雅房 - 女一',24),(31,'4人雅房 - 女二',25),(32,'4人雅房 - 女三',26),(33,'4人雅房 - 女四',27),(34,'4人雅房 - 女五',28),(35,'4人雅房 - 女六',29),(36,'4人雅房 - 女八',30),(37,'4人套房 - 女九',31),(38,'2人套房 - 女研一',32),(39,'2人套房 - 女研三',33);
/*!40000 ALTER TABLE `dorm_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `non_rented_data`
--

DROP TABLE IF EXISTS `non_rented_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `non_rented_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `region_ne_lat` double DEFAULT NULL,
  `region_ne_lng` double DEFAULT NULL,
  `region_sw_lat` double DEFAULT NULL,
  `region_sw_lng` double DEFAULT NULL,
  `rental_period` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `non_rented_data`
--

LOCK TABLES `non_rented_data` WRITE;
/*!40000 ALTER TABLE `non_rented_data` DISABLE KEYS */;
INSERT INTO `non_rented_data` VALUES (1,8413682333,25.05361742169519,121.55884566604122,25.025933501812112,121.54116454421505,12);
/*!40000 ALTER TABLE `non_rented_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occupied_room`
--

DROP TABLE IF EXISTS `occupied_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `occupied_room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` text,
  `data_id` bigint DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `data_id` (`data_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `occupied_room_ibfk_1` FOREIGN KEY (`data_id`) REFERENCES `rented_house_data` (`id`) ON DELETE CASCADE,
  CONSTRAINT `occupied_room_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rental_room` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occupied_room`
--

LOCK TABLES `occupied_room` WRITE;
/*!40000 ALTER TABLE `occupied_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `occupied_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rental_room`
--

DROP TABLE IF EXISTS `rental_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rental_room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `room_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rental_room`
--

LOCK TABLES `rental_room` WRITE;
/*!40000 ALTER TABLE `rental_room` DISABLE KEYS */;
INSERT INTO `rental_room` VALUES (1,'單人雅房'),(2,'雙人雅房'),(3,'單人套房'),(4,'雙人套房');
/*!40000 ALTER TABLE `rental_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rented_house_data`
--

DROP TABLE IF EXISTS `rented_house_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rented_house_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `address_lat` double DEFAULT NULL,
  `address_lng` double DEFAULT NULL,
  `house_name` varchar(255) DEFAULT NULL,
  `details` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rented_house_data`
--

LOCK TABLES `rented_house_data` WRITE;
/*!40000 ALTER TABLE `rented_house_data` DISABLE KEYS */;
INSERT INTO `rented_house_data` VALUES (1,4548183258,25.0413275,121.5479952,'遠東SOGO 台北忠孝館','{\"other\": \"\", \"amenities\": \"\", \"pet_allowed\": true, \"rental_period\": 12, \"shared_spaces\": \"\", \"additional_fees\": \"\", \"nearby_facilities\": \"\"}');
/*!40000 ALTER TABLE `rented_house_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school`
--

LOCK TABLES `school` WRITE;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` VALUES (1,'國立政治大學'),(2,'國立台灣大學');
/*!40000 ALTER TABLE `school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `share_room` int DEFAULT NULL,
  `haunted_house` int DEFAULT NULL,
  `rooftop_extension` int DEFAULT NULL,
  `illegal_building` int DEFAULT NULL,
  `basement` int DEFAULT NULL,
  `windowless` int DEFAULT NULL,
  `monday_wakeup` int DEFAULT NULL,
  `monday_sleep` int DEFAULT NULL,
  `tuesday_wakeup` int DEFAULT NULL,
  `tuesday_sleep` int DEFAULT NULL,
  `wednesday_wakeup` int DEFAULT NULL,
  `wednesday_sleep` int DEFAULT NULL,
  `thursday_wakeup` int DEFAULT NULL,
  `thursday_sleep` int DEFAULT NULL,
  `friday_sleep` int DEFAULT NULL,
  `friday_wakeup` int DEFAULT NULL,
  `saturday_sleep` int DEFAULT NULL,
  `saturday_wakeup` int DEFAULT NULL,
  `sunday_wakeup` int DEFAULT NULL,
  `sunday_sleep` int DEFAULT NULL,
  `cooking_location` int DEFAULT NULL,
  `dining_location` int DEFAULT NULL,
  `dining_alone` int DEFAULT NULL,
  `dining_not_alone` int DEFAULT NULL,
  `sleep_noise` int DEFAULT NULL,
  `work_noise` int DEFAULT NULL,
  `alarm_habit` int DEFAULT NULL,
  `light_sensitivity` int DEFAULT NULL,
  `friendship_habit` int DEFAULT NULL,
  `hot_weather_preference` int DEFAULT NULL,
  `temperature` int DEFAULT NULL,
  `humidity_preference` int DEFAULT NULL,
  `has_pet` int DEFAULT NULL,
  `pet_type` varchar(255) DEFAULT NULL,
  `interest_sports` int DEFAULT NULL,
  `interest_travel` int DEFAULT NULL,
  `interest_reading` int DEFAULT NULL,
  `interest_wine_tasting` int DEFAULT NULL,
  `interest_drama` int DEFAULT NULL,
  `interest_astrology` int DEFAULT NULL,
  `interest_programming` int DEFAULT NULL,
  `interest_hiking` int DEFAULT NULL,
  `interest_gaming` int DEFAULT NULL,
  `interest_painting` int DEFAULT NULL,
  `interest_idol_chasing` int DEFAULT NULL,
  `interest_music` int DEFAULT NULL,
  `hope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4548183258,NULL,NULL,1,0,0,0,1,1,23,7,23,7,23,7,23,7,7,23,9,1,1,9,0,1,1,1,5,3,1,0,1,1,0,0,1,'狗',1,1,0,0,0,0,0,0,0,0,0,0,'我希望跟室友可以溝通'),(8413682333,NULL,NULL,1,0,0,0,1,1,23,7,23,7,23,7,23,7,7,23,9,1,1,9,0,1,1,1,5,3,2,1,2,2,0,0,0,'',1,1,0,0,0,0,0,0,0,0,0,0,'我希望跟室友可以溝通');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_dorm_options`
--

DROP TABLE IF EXISTS `user_dorm_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_dorm_options` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dorm_data_id` bigint DEFAULT NULL,
  `dorm_id` bigint DEFAULT NULL,
  `dorm_room_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dorm_data_id` (`dorm_data_id`),
  KEY `dorm_id` (`dorm_id`),
  KEY `dorm_room_id` (`dorm_room_id`),
  CONSTRAINT `user_dorm_options_ibfk_1` FOREIGN KEY (`dorm_data_id`) REFERENCES `dorm_data` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_dorm_options_ibfk_2` FOREIGN KEY (`dorm_id`) REFERENCES `dorm` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_dorm_options_ibfk_3` FOREIGN KEY (`dorm_room_id`) REFERENCES `dorm_room` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dorm_options`
--

LOCK TABLES `user_dorm_options` WRITE;
/*!40000 ALTER TABLE `user_dorm_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_dorm_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_match`
--

DROP TABLE IF EXISTS `user_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_match` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id_1` bigint DEFAULT NULL,
  `user_id_2` bigint DEFAULT NULL,
  `pet_same_or_not` int DEFAULT NULL,
  `noise_percentage` decimal(8,2) DEFAULT NULL,
  `weather_percentage` decimal(8,2) DEFAULT NULL,
  `interest_percentage` decimal(8,2) DEFAULT NULL,
  `humid_percentage` decimal(8,2) DEFAULT NULL,
  `schedule_percentage` decimal(8,2) DEFAULT NULL,
  `dining_location_same_or_not` int DEFAULT NULL,
  `cook_location_same_or_not` int DEFAULT NULL,
  `dining_percentage` decimal(8,2) DEFAULT NULL,
  `shareroom_same_or_not` int DEFAULT NULL,
  `condition_percentage` decimal(8,2) DEFAULT NULL,
  `light_percentage` decimal(8,2) DEFAULT NULL,
  `alarm_percentage` decimal(8,2) DEFAULT NULL,
  `friend_percentage` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_1` (`user_id_1`),
  KEY `fk_user_2` (`user_id_2`),
  CONSTRAINT `fk_user_1` FOREIGN KEY (`user_id_1`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_2` FOREIGN KEY (`user_id_2`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_match`
--

LOCK TABLES `user_match` WRITE;
/*!40000 ALTER TABLE `user_match` DISABLE KEYS */;
INSERT INTO `user_match` VALUES (1,8413682333,4548183258,0,1.00,0.67,1.00,1.00,1.00,1,1,1.00,1,1.00,0.50,0.50,0.50);
/*!40000 ALTER TABLE `user_match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wanted_room`
--

DROP TABLE IF EXISTS `wanted_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wanted_room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `low_price` int DEFAULT NULL,
  `high_price` int DEFAULT NULL,
  `data_id` bigint DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `data_id` (`data_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `wanted_room_ibfk_1` FOREIGN KEY (`data_id`) REFERENCES `non_rented_data` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wanted_room_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rental_room` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wanted_room`
--

LOCK TABLES `wanted_room` WRITE;
/*!40000 ALTER TABLE `wanted_room` DISABLE KEYS */;
INSERT INTO `wanted_room` VALUES (1,3000,9000,1,1);
/*!40000 ALTER TABLE `wanted_room` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-11 17:04:52
