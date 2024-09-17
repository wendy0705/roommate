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
  PRIMARY KEY (`id`),
  KEY `data_id` (`data_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `available_room_ibfk_1` FOREIGN KEY (`data_id`) REFERENCES `rented_house_data` (`id`) ON DELETE CASCADE,
  CONSTRAINT `available_room_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rental_room` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available_room`
--

LOCK TABLES `available_room` WRITE;
/*!40000 ALTER TABLE `available_room` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  CONSTRAINT `chat_room_ibfk_1` FOREIGN KEY (`inviter_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dorm`
--

LOCK TABLES `dorm` WRITE;
/*!40000 ALTER TABLE `dorm` DISABLE KEYS */;
INSERT INTO `dorm` VALUES (1,'莊敬 2 舍',1),(2,'莊敬 3 舍',1),(3,'自強 5 舍',1),(4,'自強 6 舍',1),(5,'自強 1 舍',1),(6,'自強 9 舍',1),(7,'自強 10 舍',1),(8,'莊敬 1 舍',1),(9,'莊敬 9 舍',1),(10,'自強 7 舍',1),(11,'自強 8 舍',1),(12,'男一舍',2),(13,'男二舍',2),(14,'男三舍',2),(15,'男四舍',2),(16,'男五舍',2),(17,'男六舍',2),(18,'男七舍',2),(19,'男八舍',2),(20,'男研一舍',2),(21,'男研三舍',2),(22,'大一女舍',2),(23,'女一舍',2),(24,'女二舍',2),(25,'女三舍',2),(26,'女四舍',2),(27,'女五舍',2),(28,'女六舍',2),(29,'女八舍',2),(30,'女九舍',2),(31,'女研一舍',2),(32,'女研三舍',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dorm_data`
--

LOCK TABLES `dorm_data` WRITE;
/*!40000 ALTER TABLE `dorm_data` DISABLE KEYS */;
INSERT INTO `dorm_data` VALUES (1,1,0,1),(2,2,1,1),(3,3,0,2),(4,4,0,2),(5,5,0,1),(6,6,1,2),(7,7,1,1),(8,8,0,2),(9,9,1,2),(10,10,1,2),(11,11,1,2),(12,12,1,2),(13,13,1,2),(14,14,0,1),(15,15,1,2);
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
INSERT INTO `dorm_room` VALUES (1,'雅房，下舖',1),(2,'雅房，上舖',1),(3,'雅房，下舖',2),(4,'雅房，上舖',2),(5,'雅房，上下舖',3),(6,'雅房，上下舖',4),(7,'1/3 套 shared bathroom，上下舖',5),(8,'雅房，上下舖',6),(9,'套房，下舖',7),(10,'雅房，下舖',8),(11,'雅房，上下舖',8),(12,'雅房，下舖',9),(13,'雅房，上下舖',9),(14,'雅房，下舖',10),(15,'雅房，上舖',10),(16,'雅房，上下舖',11),(17,'雅房，上下舖',10),(18,'雅房，上下舖',11),(19,'住4人',12),(20,'住4人設電梯',13),(21,'住4人',14),(22,'住4人',15),(23,'住4人',16),(24,'住4人',17),(25,'住4人',18),(26,'住4人設電梯',19),(27,'住2人',20),(28,'住2人設電梯',21),(29,'住4人',22),(30,'住4人',23),(31,'住4人',24),(32,'住4人',25),(33,'住4人',26),(34,'住4人',27),(35,'住4人設電梯',28),(36,'住4人使用電熱水器',29),(37,'住4人使用電熱水器',30),(38,'住2人設電梯',31),(39,'住2人設電梯',32);
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
  `region_ne_lat` bigint DEFAULT NULL,
  `region_ne_lng` bigint DEFAULT NULL,
  `region_sw_lat` bigint DEFAULT NULL,
  `region_sw_lng` bigint DEFAULT NULL,
  `rental_period` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `non_rented_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `non_rented_data`
--

LOCK TABLES `non_rented_data` WRITE;
/*!40000 ALTER TABLE `non_rented_data` DISABLE KEYS */;
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
  `room_type` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rental_room`
--

LOCK TABLES `rental_room` WRITE;
/*!40000 ALTER TABLE `rental_room` DISABLE KEYS */;
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
  `address_lat` bigint DEFAULT NULL,
  `address_lng` bigint DEFAULT NULL,
  `house_name` varchar(255) DEFAULT NULL,
  `details` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `rented_house_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rented_house_data`
--

LOCK TABLES `rented_house_data` WRITE;
/*!40000 ALTER TABLE `rented_house_data` DISABLE KEYS */;
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
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `share_room` int DEFAULT NULL,
  `haunted_house` int DEFAULT NULL,
  `rooftop_extension` int DEFAULT NULL,
  `illegal_building` int DEFAULT NULL,
  `basement` int DEFAULT NULL,
  `windowless` int DEFAULT NULL,
  `monday_schedule` int DEFAULT NULL,
  `tuesday_schedule` int DEFAULT NULL,
  `wednesday_schedule` int DEFAULT NULL,
  `thursday_schedule` int DEFAULT NULL,
  `friday_schedule` int DEFAULT NULL,
  `saturday_schedule` int DEFAULT NULL,
  `sunday_schedule` int DEFAULT NULL,
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1@example.com','password1',1,0,1,0,0,1,23,23,23,23,23,1,1,1,0,1,0,5,3,1,2,1,3,24,2,1,'狗',1,0,1,0,1,0,1,0,1,0,0,1),(2,'user2@example.com','password2',0,1,0,1,1,0,22,22,22,22,22,0,0,2,1,0,1,4,2,2,1,2,1,22,1,0,NULL,0,1,1,1,0,1,0,1,0,1,1,0),(3,'user3@example.com','password3',1,0,1,0,1,0,21,21,21,21,21,10,10,0,2,1,1,3,4,0,0,2,2,26,0,1,'貓',1,1,0,0,1,0,1,1,1,0,0,1),(4,'user4@example.com','password4',0,1,0,1,0,1,20,20,20,20,20,12,12,1,1,0,1,2,5,1,2,0,0,20,2,1,'魚',0,1,1,1,0,1,0,0,1,1,0,1),(5,'user5@example.com','password5',1,0,1,0,1,0,19,19,19,19,19,0,0,2,0,1,0,5,1,0,1,1,2,25,1,0,NULL,1,0,1,0,1,1,0,1,1,0,0,1),(6,'user6@example.com','password6',0,1,1,0,0,1,18,18,18,18,18,14,14,1,2,1,1,1,3,2,0,2,3,28,0,1,'鳥',0,1,1,1,0,0,1,0,0,1,1,0),(7,'user7@example.com','password7',1,0,0,1,1,0,17,17,17,17,17,8,8,0,1,0,1,4,2,1,2,0,1,21,2,1,'倉鼠',1,1,0,0,1,1,0,1,1,0,0,1),(8,'user8@example.com','password8',0,1,1,0,0,1,16,16,16,16,16,9,9,2,0,1,0,3,4,0,1,1,2,23,1,0,NULL,0,0,1,1,1,0,1,0,1,1,1,0),(9,'user9@example.com','password9',1,0,0,1,1,0,15,15,15,15,15,11,11,1,2,0,1,5,2,2,0,2,3,27,0,1,'兔子',1,1,1,0,0,1,1,1,0,0,0,1),(10,'user10@example.com','password10',0,1,1,0,1,1,14,14,14,14,14,13,13,0,1,1,1,2,5,1,2,0,0,19,2,1,'龜',0,1,0,1,1,0,0,1,1,1,1,0),(11,'user11@example.com','password11',1,0,0,1,0,0,13,13,13,13,13,0,0,2,0,0,1,4,3,0,1,1,1,22,1,0,NULL,1,0,1,1,0,1,1,0,0,1,0,1),(12,'user12@example.com','password12',0,1,1,0,1,1,12,12,12,12,12,15,15,1,2,1,0,3,4,2,0,2,2,24,0,1,'狗',0,1,1,0,1,0,0,1,1,0,1,1),(13,'user13@example.com','password13',1,0,0,1,0,0,11,11,11,11,11,16,16,0,1,0,1,5,2,1,2,0,3,26,2,1,'貓',1,1,0,1,0,1,1,0,1,1,0,0),(14,'user14@example.com','password14',0,1,1,0,1,1,10,10,10,10,10,17,17,2,0,1,1,1,5,0,1,1,0,20,1,0,NULL,0,0,1,1,1,0,0,1,0,1,1,1),(15,'user15@example.com','password15',1,0,0,1,0,0,9,9,9,9,9,18,18,1,2,0,1,4,3,2,0,2,1,23,0,1,'魚',1,1,1,0,0,1,1,1,1,0,0,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dorm_options`
--

LOCK TABLES `user_dorm_options` WRITE;
/*!40000 ALTER TABLE `user_dorm_options` DISABLE KEYS */;
INSERT INTO `user_dorm_options` VALUES (1,1,1,1),(2,1,10,14),(3,1,11,16),(4,2,6,8),(5,3,20,27),(6,3,24,31),(7,3,18,25),(8,4,17,24),(9,4,29,36),(10,5,6,8),(11,6,25,32),(12,7,9,12),(13,8,21,28),(14,9,26,33),(15,10,22,29),(16,11,29,36),(17,12,27,34),(18,13,15,22),(19,14,10,17),(20,14,7,9),(21,14,2,4),(22,15,30,37);
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
  `weighted_percentage` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_match` (`user_id_1`,`user_id_2`),
  KEY `user_id_2` (`user_id_2`),
  CONSTRAINT `user_match_ibfk_1` FOREIGN KEY (`user_id_1`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_match_ibfk_2` FOREIGN KEY (`user_id_2`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_match`
--

LOCK TABLES `user_match` WRITE;
/*!40000 ALTER TABLE `user_match` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wanted_room`
--

LOCK TABLES `wanted_room` WRITE;
/*!40000 ALTER TABLE `wanted_room` DISABLE KEYS */;
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

-- Dump completed on 2024-09-17 14:56:57
