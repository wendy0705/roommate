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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dorm_data`
--

LOCK TABLES `dorm_data` WRITE;
/*!40000 ALTER TABLE `dorm_data` DISABLE KEYS */;
INSERT INTO `dorm_data` VALUES (3,1,1,1),(4,2,1,2),(5,3,1,2),(6,4,1,1),(7,5,0,2),(8,6,0,1),(9,7,0,1),(10,8,1,1),(11,9,1,2),(12,10,1,1),(13,11,0,1),(14,12,0,2),(15,13,0,2),(16,14,1,2),(17,15,0,2),(18,16,1,2),(19,17,1,1),(20,18,0,1),(21,19,1,2),(22,20,0,2),(23,21,1,2),(24,22,0,1),(25,23,0,2),(26,24,0,1),(27,25,1,1),(28,26,1,2),(29,27,0,2),(30,28,0,1),(31,29,0,2),(32,30,1,1),(33,31,0,1),(34,32,0,2),(35,33,1,1),(36,34,0,2),(37,35,1,2),(38,36,1,1),(39,37,0,1),(40,38,0,2),(41,39,0,1),(42,40,0,2),(43,41,0,1),(44,42,0,1),(45,43,1,2),(46,44,1,1),(47,45,0,1),(48,46,1,2),(49,47,1,1),(50,48,0,2),(51,49,1,1),(52,50,1,1);
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'uwright@example.net','UG0eqn8yK@',0,1,1,0,1,0,19,23,17,22,2,11,3,19,2,3,19,0,20,17,0,0,0,0,5,4,2,2,1,2,25,1,1,'major',0,0,0,0,0,1,1,0,1,0,0,0),(2,'kimkaren@example.com','^9Nr)gMBjt',1,0,1,1,1,1,21,16,7,21,1,2,3,1,17,0,19,18,16,21,1,0,0,0,3,3,0,2,0,3,25,2,0,NULL,0,0,1,1,0,1,1,0,0,0,1,0),(3,'mjackson@example.com','Y5P7XI@ir#',1,0,1,0,1,1,2,6,16,3,12,1,8,6,14,18,1,0,10,4,1,1,1,1,4,5,0,0,0,1,22,0,0,NULL,0,1,0,1,0,1,0,1,0,1,1,1),(4,'kconway@example.net','_funcO0b7d',1,0,0,1,0,0,18,20,13,10,18,7,12,6,4,10,23,18,21,18,1,1,0,0,2,2,0,0,0,1,26,1,0,NULL,1,1,1,1,1,0,1,0,1,1,1,0),(5,'johnjenkins@example.org','m3$2iCFoG+',1,1,0,0,0,1,3,22,10,22,16,3,3,21,8,4,15,2,15,12,0,1,0,1,1,4,1,0,1,1,26,1,0,NULL,1,0,0,1,1,0,0,0,0,1,1,1),(6,'andre37@example.net','ez9NuqtA^!',1,0,1,0,1,0,7,15,22,9,10,5,13,10,7,13,12,17,14,4,0,1,1,1,3,1,0,2,1,1,21,0,1,'answer',1,0,1,1,0,1,0,0,0,1,1,0),(7,'tommykim@example.com','$8U#vNIbIb',1,1,1,1,1,1,0,17,23,9,0,1,6,22,22,11,21,16,9,3,1,0,0,1,3,3,0,2,1,2,24,0,1,'the',0,0,0,1,1,0,1,0,1,1,1,0),(8,'merrittchristina@example.net','q@6ODz*+Po',1,1,1,0,1,0,0,4,20,14,9,17,11,22,13,19,12,0,9,9,1,1,0,1,3,1,2,1,0,0,26,0,0,NULL,0,1,1,0,1,1,0,1,1,1,1,0),(9,'reyeschad@example.com','^9EeLzs+qB',0,0,1,1,1,1,4,8,6,14,10,20,12,9,13,7,3,1,10,5,0,1,1,1,2,2,2,0,1,2,21,2,0,NULL,1,1,1,1,1,1,1,1,0,1,0,1),(10,'thomas59@example.org','C#5VS5#fq$',0,0,0,1,0,1,21,12,17,14,23,1,6,0,4,3,7,1,13,5,1,0,1,1,4,4,1,2,1,3,26,2,0,NULL,0,0,0,0,1,1,0,0,0,0,0,1),(11,'umoore@example.com','dQ$bDYxi%3',1,1,0,1,1,1,11,17,16,8,14,23,18,3,15,17,5,19,21,10,0,1,0,1,1,5,1,0,1,3,27,0,0,NULL,1,0,0,0,1,1,0,0,1,1,0,1),(12,'smithcharles@example.com','UJz4BncC3$',0,0,0,0,0,0,15,23,16,23,5,20,9,3,10,14,9,18,1,2,0,1,0,1,4,3,1,1,2,0,22,0,0,NULL,0,1,1,0,0,0,0,1,0,1,0,1),(13,'trevinoshelby@example.net','r0&U0jlc#B',0,1,0,1,1,1,11,10,22,4,15,5,10,5,20,15,0,11,3,5,1,0,1,0,4,5,0,2,1,3,28,0,0,NULL,1,1,0,0,1,0,0,1,1,0,0,1),(14,'juan78@example.org','^r3NyyOyB4',0,0,1,0,1,0,21,0,16,19,6,18,16,8,18,14,8,20,22,22,1,1,0,0,5,5,2,0,2,1,20,0,0,NULL,0,1,0,1,1,1,1,1,0,1,1,0),(15,'kathleensullivan@example.net','_L3ZJDRvo0',1,1,0,0,1,0,6,3,12,10,9,23,18,21,18,0,6,0,15,13,0,1,1,1,5,5,2,2,2,3,21,0,1,'measure',1,0,0,0,1,1,1,0,1,1,1,1),(16,'blackgrace@example.com','VE3HX5BhN&',1,0,0,0,0,1,1,5,8,3,21,5,20,7,0,11,10,23,21,23,1,1,0,0,3,4,1,1,0,3,24,1,0,NULL,0,1,1,0,1,0,1,1,0,0,0,1),(17,'daniellekelley@example.org','*4Yw91Fh25',0,1,1,0,1,0,7,9,23,4,5,16,9,0,12,21,7,4,8,10,1,1,0,1,4,3,0,0,2,3,20,0,1,'role',1,1,1,1,0,1,1,1,0,1,0,1),(18,'ucarpenter@example.net','(1^GsVcl^3',0,0,0,1,0,0,4,11,20,11,18,13,14,20,18,7,17,1,18,0,1,0,0,0,3,2,1,2,2,2,22,2,0,NULL,1,0,1,0,0,0,1,0,1,0,0,0),(19,'courtney08@example.net','O63J$6SdX+',1,0,1,0,1,1,12,20,14,20,1,0,18,12,17,2,18,10,12,9,0,1,1,0,3,3,2,2,0,3,28,2,0,NULL,0,0,0,0,0,1,1,1,1,0,1,1),(20,'bryan16@example.org','!QU@WdkOZ8',1,0,0,1,0,1,20,8,2,17,15,12,21,19,19,4,22,2,19,17,0,0,1,1,1,4,2,2,2,0,23,1,0,NULL,1,1,1,0,0,1,0,0,1,0,1,0),(21,'hmendoza@example.com','a0u6ZQyc+t',0,1,0,1,1,0,8,19,13,7,10,11,15,2,2,15,22,23,23,6,1,0,0,0,5,4,0,1,0,2,22,1,1,'single',0,0,0,1,1,1,0,0,1,0,1,0),(22,'buckpatricia@example.org','J(&0ns0o4R',0,0,0,1,1,1,20,7,16,4,7,3,9,8,18,4,9,19,18,9,0,1,0,1,5,1,0,2,0,3,25,1,1,'financial',1,0,0,1,1,0,1,1,0,0,0,1),(23,'samanthasoto@example.org','!G1lUfYf%f',0,1,1,1,1,1,4,1,3,11,20,11,23,2,21,9,8,22,5,21,0,1,1,0,5,1,2,2,0,3,24,1,1,'structure',1,0,1,0,0,1,1,0,1,0,1,1),(24,'garciaalan@example.org','h!vjk8rcbP',0,0,0,0,1,0,21,8,0,1,15,19,16,2,18,21,5,2,21,18,1,1,1,0,4,3,0,1,2,0,28,1,1,'from',1,1,1,0,1,1,1,0,0,0,1,0),(25,'stephanieturner@example.net','C#3C2FolNi',0,1,0,1,1,1,20,14,19,7,13,19,20,20,7,11,1,13,5,11,0,0,1,0,4,3,0,1,2,1,24,0,1,'cup',1,0,1,0,1,1,0,1,0,0,1,0),(26,'monica57@example.com','Z*C)dz*e%4',0,0,1,0,0,0,15,21,13,2,2,1,22,1,13,17,15,19,10,17,0,0,0,0,3,5,2,1,1,1,28,1,1,'behavior',0,0,0,1,0,1,0,1,1,1,0,1),(27,'cmurray@example.com','!ZV3OJMo7$',1,0,1,0,1,1,19,18,15,0,12,4,3,9,9,2,2,23,23,13,1,1,0,0,4,1,2,1,2,2,25,1,0,NULL,1,0,0,0,0,0,0,0,1,1,1,0),(28,'sweeneyjeffery@example.org',')8BQ2M4)Wu',1,0,1,1,1,0,11,7,13,7,3,6,12,13,22,21,13,13,6,4,0,1,1,1,5,5,2,2,0,3,23,0,1,'brother',0,0,0,0,0,1,1,0,1,0,0,1),(29,'dsutton@example.com','@6AKIPta)V',1,0,1,1,0,1,22,23,7,13,18,1,12,10,4,22,0,20,15,3,0,1,0,1,5,2,0,2,0,0,27,0,1,'would',0,1,1,0,0,0,0,0,0,1,1,0),(30,'mharvey@example.net','1u6KaHv#+*',1,0,1,0,1,0,21,15,15,21,21,21,6,22,12,2,1,6,18,19,0,1,0,1,2,4,1,1,1,3,25,1,0,NULL,1,0,0,0,0,0,1,0,0,1,0,0),(31,'jeffrey13@example.org','i&a9XF8(Wx',0,1,1,0,0,0,18,2,21,21,14,12,11,10,18,21,1,14,8,16,1,0,0,0,1,1,1,2,1,3,28,0,0,NULL,0,0,0,0,0,0,1,0,0,0,0,0),(32,'christina59@example.org','i*%03ZHy)I',0,1,1,0,0,1,14,3,20,7,22,2,16,1,11,22,21,18,20,2,0,0,1,0,5,5,2,0,1,3,28,1,0,NULL,1,1,1,0,0,0,1,1,0,1,1,1),(33,'jessica12@example.net','09HLoznl^K',1,0,0,0,0,0,8,19,21,20,22,18,11,8,16,15,5,22,8,20,1,1,0,1,5,3,2,2,2,1,23,0,0,NULL,1,1,0,1,1,1,1,1,1,1,0,1),(34,'jessica28@example.org','As1%F0ZbCT',1,0,1,1,1,1,21,6,19,0,13,13,22,6,18,11,20,0,5,6,1,1,0,0,5,4,1,1,1,0,22,2,0,NULL,0,1,0,0,1,1,1,1,1,1,1,1),(35,'dawnbrown@example.net','@NHA3!7sP5',1,1,0,0,1,1,16,23,2,14,19,11,19,8,4,18,19,19,0,10,1,1,1,0,2,2,1,0,2,3,22,1,1,'whole',1,0,0,1,0,1,1,0,0,0,0,1),(36,'turnershelby@example.com','&3gWPScV!+',0,0,1,0,1,1,16,17,1,3,3,4,19,17,12,14,11,21,21,11,0,1,1,0,3,4,1,2,2,1,20,1,1,'age',0,1,0,0,1,0,1,1,1,1,1,0),(37,'melanie04@example.com','$7JSAmqe18',1,1,0,1,1,0,7,3,3,10,9,21,6,15,7,5,13,12,12,23,0,0,1,0,4,3,0,2,0,0,26,1,1,'environment',0,1,1,1,1,0,1,1,1,1,0,1),(38,'mariaarnold@example.org','6DxBqz)z#(',0,1,1,1,0,1,2,13,21,12,20,12,22,20,21,14,17,11,13,5,0,1,1,1,3,1,2,1,2,3,23,0,1,'agree',0,0,1,1,1,1,1,0,0,0,0,0),(39,'kleinashley@example.com',')9%V*%vl(y',0,1,0,1,0,0,17,19,6,9,2,3,21,9,6,12,16,7,8,4,1,0,1,0,4,2,2,0,1,0,24,2,1,'position',1,0,1,1,0,1,0,0,0,0,0,1),(40,'wlucero@example.net','&E3ERafnjY',1,0,1,1,0,0,9,17,9,16,23,3,15,21,11,19,20,16,0,4,1,0,0,1,4,3,2,1,1,0,23,0,0,NULL,1,0,1,0,1,1,1,1,1,1,1,0),(41,'pgarcia@example.net','8%IpAuf*^+',1,0,1,1,1,0,6,11,3,16,22,19,22,1,17,0,13,16,9,16,1,1,1,0,3,5,1,0,0,1,26,1,1,'defense',1,1,1,1,1,0,0,1,0,0,0,0),(42,'lorihunt@example.org','H9hD7hwY*X',1,1,1,0,1,0,22,10,11,18,6,22,15,21,7,6,8,5,12,16,1,1,1,0,4,1,1,2,1,0,25,0,1,'of',1,1,0,0,1,0,1,0,1,1,1,1),(43,'michaelmichelle@example.com','WUX%52ClRP',0,0,0,1,1,0,2,11,14,13,6,3,16,12,20,5,17,11,22,9,1,0,1,0,2,2,0,1,0,3,22,2,0,NULL,0,0,1,0,0,1,0,0,1,0,0,1),(44,'bromero@example.net','6aQiXvw+!G',1,1,0,1,1,1,14,17,11,1,8,8,22,15,13,19,21,10,0,15,1,0,0,1,5,2,0,0,1,0,21,0,1,'politics',0,0,1,1,1,1,0,1,0,1,0,1),(45,'autumn83@example.net','8rzn90Uv+3',0,1,1,0,0,0,12,11,22,1,12,23,8,10,21,23,21,20,6,18,0,0,0,1,3,3,0,0,1,0,24,2,1,'central',0,1,0,0,0,1,1,1,1,1,1,1),(46,'kelliehouston@example.com','!y4SFljPs9',1,0,0,0,0,1,20,11,5,13,22,3,6,2,3,20,7,20,4,14,1,0,1,1,2,1,2,0,2,1,23,1,0,NULL,0,0,1,0,1,1,1,0,1,0,0,1),(47,'jnewman@example.org','9bGWR1NS&b',0,0,0,1,1,1,5,2,15,4,0,13,13,10,11,4,12,2,16,1,1,0,0,0,1,1,2,2,1,2,26,2,0,NULL,1,0,0,1,0,1,1,0,0,0,0,0),(48,'wilsonpeter@example.net','(e(n1Yj%@U',0,1,1,0,1,1,6,6,13,12,14,7,3,20,16,13,21,21,9,14,0,0,0,0,2,5,0,1,2,1,24,2,0,NULL,1,0,1,1,0,0,1,1,1,1,1,1),(49,'jsparks@example.com','g0&LanjH_f',1,0,1,1,0,1,6,11,14,21,23,17,23,23,21,14,22,21,17,20,1,1,0,1,5,2,1,2,2,0,22,1,0,NULL,0,0,0,0,0,0,0,0,0,0,1,1),(50,'williamskathleen@example.com','Qa0ZtOY#S%',0,1,1,1,0,0,20,19,0,18,1,11,13,23,15,8,0,18,21,17,0,1,0,0,3,3,2,0,2,3,20,1,1,'industry',1,0,1,0,1,1,1,0,1,0,0,1),(51,'johnsmith@example.com','A5^h!9gB0@',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dorm_options`
--

LOCK TABLES `user_dorm_options` WRITE;
/*!40000 ALTER TABLE `user_dorm_options` DISABLE KEYS */;
INSERT INTO `user_dorm_options` VALUES (1,3,8,10),(2,4,27,34),(3,5,30,37),(4,6,6,8),(5,7,31,38),(6,8,4,6),(7,9,9,13),(8,9,10,14),(9,10,2,3),(10,11,12,19),(11,12,1,2),(12,13,6,8),(13,13,11,16),(14,13,8,11),(15,14,26,33),(16,15,31,38),(17,15,21,28),(18,16,20,27),(19,17,23,30),(20,17,15,22),(21,17,16,23),(22,18,28,35),(23,19,9,12),(24,20,9,12),(25,21,18,25),(26,22,13,20),(27,22,16,23),(28,23,16,23),(29,24,10,14),(30,25,13,20),(31,25,12,19),(32,25,16,23),(33,26,2,4),(34,26,2,3),(35,26,2,4),(36,27,3,5),(37,28,20,27),(38,29,29,36),(39,29,15,22),(40,30,4,6),(41,30,2,4),(42,30,10,14),(43,31,28,35),(44,31,14,21),(45,32,8,11),(46,33,9,12),(47,34,15,22),(48,34,24,31),(49,34,19,26),(50,35,5,7),(51,36,21,28),(52,37,23,30),(53,38,10,17),(54,39,7,9),(55,39,8,10),(56,39,9,12),(57,40,14,21),(58,41,9,13),(59,42,16,23),(60,43,3,5),(61,43,5,7),(62,43,9,13),(63,44,9,13),(64,44,5,7),(65,45,16,23),(66,46,10,15),(67,47,6,8),(68,47,1,1),(69,47,1,1),(70,48,21,28),(71,49,6,8),(72,50,27,34),(73,50,27,34),(74,51,1,1),(75,52,5,7);
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

-- Dump completed on 2024-09-18  6:12:57
