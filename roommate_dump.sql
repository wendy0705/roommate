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
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `available_room`
--

LOCK TABLES `available_room` WRITE;
/*!40000 ALTER TABLE `available_room` DISABLE KEYS */;
INSERT INTO `available_room` VALUES (3,2,3,5530,NULL),(4,3,1,6557,NULL),(5,3,3,5166,NULL),(6,4,4,4845,NULL),(7,5,2,5511,NULL),(8,5,4,4161,NULL),(9,5,3,7622,NULL),(10,6,1,4823,NULL),(11,6,1,6871,NULL),(12,6,3,5112,NULL),(13,7,1,4199,NULL),(14,7,2,5483,NULL),(15,7,2,7340,NULL),(16,8,1,7677,NULL),(17,9,4,6880,NULL),(18,9,2,4000,NULL),(19,9,1,5861,NULL),(20,10,3,6324,NULL),(21,10,4,5515,NULL),(22,10,4,6845,NULL),(23,11,4,5606,NULL),(24,12,2,5535,NULL),(25,12,3,7592,NULL),(26,12,3,5357,NULL),(27,13,1,6577,NULL),(28,13,4,4975,NULL),(29,14,3,7026,NULL),(30,14,1,4389,NULL),(31,14,3,7655,NULL),(32,15,3,7863,NULL),(33,15,3,4505,NULL),(34,16,3,6623,NULL),(35,17,3,5531,NULL),(36,18,2,4249,NULL),(37,18,1,5789,NULL),(38,18,3,4695,NULL),(39,19,3,7090,NULL),(40,19,4,5736,NULL),(41,20,3,6493,NULL),(42,21,3,6724,NULL),(43,21,2,6376,NULL),(44,22,3,5299,NULL),(45,22,4,7416,NULL),(46,22,4,7896,NULL),(47,23,1,6195,NULL),(48,23,2,5882,NULL),(49,24,3,6014,NULL),(50,24,3,5352,NULL),(51,24,4,7578,NULL),(52,25,2,6337,NULL),(53,25,1,6939,NULL),(101,60,1,6000,6),(102,61,1,6000,6),(103,62,1,6000,6),(118,77,1,6000,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  KEY `user_id` (`user_id`),
  CONSTRAINT `non_rented_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `non_rented_data`
--

LOCK TABLES `non_rented_data` WRITE;
/*!40000 ALTER TABLE `non_rented_data` DISABLE KEYS */;
INSERT INTO `non_rented_data` VALUES (2,27,25.0368361,121.559453,25.0180942,121.54098950000001,6),(3,28,25.041015,121.5483191,25.0217712,121.5302786,12),(4,29,25.037255,121.5440381,25.026495299999997,121.5271161,6),(5,30,25.0445871,121.5463355,25.027566800000002,121.5292087,6),(6,31,25.0470309,121.5522994,25.0347305,121.53274449999999,12),(7,32,25.0443562,121.5526012,25.0307217,121.5372098,6),(8,33,25.0307671,121.5550963,25.0129633,121.5383965,12),(9,34,25.0479838,121.5536264,25.0335272,121.5394381,12),(10,35,25.046231,121.5467567,25.0311435,121.5312246,6),(11,36,25.0444231,121.5440888,25.0253784,121.5293389,12),(12,37,25.0360283,121.5458911,25.0223005,121.5309728,6),(13,38,25.0497075,121.5428444,25.0390764,121.53179060000001,6),(14,39,25.0347462,121.5463423,25.0206458,121.52665320000001,12),(15,40,25.0498549,121.5423671,25.0324647,121.5287069,6),(16,41,25.0441473,121.5405194,25.0311675,121.52184439999999,12),(17,42,25.0345664,121.5452057,25.022020299999998,121.5311095,6),(18,43,25.0447634,121.5478092,25.0333356,121.53369070000001,12),(19,44,25.0394326,121.5423462,25.0245065,121.5226953,6),(20,45,25.0499859,121.5418174,25.0305466,121.5275383,12),(21,46,25.0362202,121.5436049,25.020231499999998,121.52669750000001,6),(22,47,25.0445341,121.554722,25.0305088,121.5361049,6),(23,48,25.0363721,121.5543312,25.021611800000002,121.5392521,6),(24,49,25.0386553,121.5587529,25.0210339,121.5399124,6),(25,50,25.0462431,121.5436171,25.0306682,121.52754230000001,12),(83,52,25.04492643101051,121.56908462556638,25.038549899741298,121.54385040315427,12),(84,54,25.04375583102185,121.57072150268554,25.039090064440618,121.54239737548828,12),(85,58,25.044255592530366,121.57059404972331,25.039667608876893,121.54149744632976,12);
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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occupied_room`
--

LOCK TABLES `occupied_room` WRITE;
/*!40000 ALTER TABLE `occupied_room` DISABLE KEYS */;
INSERT INTO `occupied_room` VALUES (3,'男，工程師',2,4),(4,'女，老師',3,3),(5,'男，工程師',3,1),(6,'女，學生',4,2),(7,'女，老師',5,4),(8,'女，學生',5,1),(9,'女，學生',6,3),(10,'女，學生',7,4),(11,'女，學生',7,3),(12,'男，工程師',8,4),(13,'男，工程師',8,3),(14,'男，工程師',9,1),(15,'女，老師',10,2),(16,'男，工程師',11,1),(17,'女，學生',11,3),(18,'女，學生',12,3),(19,'女，學生',13,3),(20,'男，工程師',13,3),(21,'女，學生',14,4),(22,'女，學生',14,3),(23,'男，工程師',15,1),(24,'男，工程師',15,1),(25,'女，老師',16,1),(26,'女，老師',17,1),(27,'男，工程師',18,1),(28,'男，工程師',18,3),(29,'女，學生',19,1),(30,'女，學生',19,1),(31,'男，工程師',20,4),(32,'女，學生',21,3),(33,'女，學生',22,4),(34,'女，老師',22,3),(35,'男，工程師',23,1),(36,'女，老師',24,1),(37,'男，工程師',25,3),(38,'男，工程師',25,1);
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
  KEY `user_id` (`user_id`),
  CONSTRAINT `rented_house_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rented_house_data`
--

LOCK TABLES `rented_house_data` WRITE;
/*!40000 ALTER TABLE `rented_house_data` DISABLE KEYS */;
INSERT INTO `rented_house_data` VALUES (2,2,25.0311826,121.5823672,'安和住宅','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(3,3,25.0915771,121.5945197,'仁愛公寓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 12, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(4,4,25.0542029,121.5593069,'忠孝大樓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 12, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(5,5,25.0785577,121.5336259,'忠孝大樓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 12, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(6,6,25.0233772,121.5064481,'安和住宅','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 12, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(7,7,25.0469983,121.5385379,'忠孝大樓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 12, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(8,8,25.0909998,121.5579659,'和平大廈','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(9,9,25.0458194,121.5650297,'和平大廈','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(10,10,25.0409791,121.5198372,'和平大廈','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 12, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(11,11,25.0781699,121.5381959,'信義雅苑','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 12, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(12,12,25.0083331,121.5687788,'忠孝大樓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(13,13,25.0444951,121.5266921,'仁愛公寓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 12, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(14,14,25.005067,121.529841,'仁愛公寓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(15,15,25.0669384,121.5157484,'忠孝大樓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(16,16,25.0340372,121.5295407,'和平大廈','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(17,17,25.0631908,121.5743581,'信義雅苑','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(18,18,25.0072467,121.5778128,'忠孝大樓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(19,19,25.0948756,121.5721751,'信義雅苑','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(20,20,25.0418289,121.5165849,'信義雅苑','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(21,21,25.053775,121.5696121,'安和住宅','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(22,22,25.0709904,121.5519381,'和平大廈','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(23,23,25.0660011,121.5466096,'仁愛公寓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": false, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(24,24,25.007072,121.522432,'和平大廈','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 6, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(25,25,25.0124992,121.5593702,'忠孝大樓','{\"other\": \"這房子很棒！\", \"amenities\": \"冰箱、微波爐\", \"pet_allowed\": true, \"rental_period\": 12, \"shared_spaces\": \"廚房、客廳\", \"additional_fees\": \"水電費\", \"nearby_facilities\": \"距捷運站5分鐘\"}'),(60,51,25.040964,121.5521933,'明曜百貨公司','{\"other\": \"\", \"amenities\": \"\", \"pet_allowed\": true, \"rental_period\": 0, \"shared_spaces\": \"\", \"additional_fees\": \"\", \"nearby_facilities\": \"\"}'),(61,52,25.040964,121.5521933,'明曜百貨公司','{\"other\": \"\", \"amenities\": \"\", \"pet_allowed\": true, \"rental_period\": 0, \"shared_spaces\": \"\", \"additional_fees\": \"\", \"nearby_facilities\": \"\"}'),(62,53,25.040964,121.5521933,'明曜百貨公司','{\"other\": \"\", \"amenities\": \"\", \"pet_allowed\": true, \"rental_period\": 0, \"shared_spaces\": \"\", \"additional_fees\": \"\", \"nearby_facilities\": \"\"}'),(77,61,25.040964,121.5521933,'明曜百貨公司','{\"other\": \"\", \"amenities\": \"\", \"pet_allowed\": true, \"rental_period\": 0, \"shared_spaces\": \"\", \"additional_fees\": \"\", \"nearby_facilities\": \"\"}');
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'miguel46@example.net','+)1pNwi7)B',1,0,1,1,0,1,8,0,23,0,13,3,15,8,23,22,19,17,2,6,0,0,0,1,5,5,0,2,1,1,22,2,1,'important',1,0,1,0,1,0,1,1,0,0,0,1),(2,'robertleon@example.net','H*^6N4R2Rj',0,0,1,0,1,0,6,10,9,11,4,20,19,0,3,18,2,14,8,18,1,0,0,1,4,1,2,1,0,1,25,1,0,NULL,1,0,1,1,1,0,0,1,0,1,0,0),(3,'monroejames@example.com','k+6hayTaT!',1,1,0,1,1,1,17,1,21,8,2,16,7,11,18,7,4,16,14,13,0,1,1,1,4,4,1,2,1,0,27,0,1,'born',0,1,0,0,1,1,1,1,0,1,1,0),(4,'oburke@example.net','f0WAJPNA)A',1,0,0,1,1,1,8,21,1,15,18,0,0,4,23,1,6,0,8,2,0,1,1,1,5,1,1,1,2,3,27,0,0,NULL,0,1,0,0,1,0,1,1,0,0,0,0),(5,'sarah74@example.com','E9MgHgR(@G',0,0,0,1,0,1,7,4,15,9,1,9,20,7,14,14,16,12,9,18,1,0,1,0,2,3,2,1,2,2,26,1,1,'dinner',0,1,1,0,1,0,1,0,1,0,0,1),(6,'wiseshelby@example.org','wnjc9HSe@b',0,1,0,0,1,0,6,6,23,4,11,6,18,12,9,12,10,18,17,6,1,0,1,0,2,3,2,0,1,3,22,2,1,'all',1,1,1,1,1,1,1,0,0,0,0,0),(7,'alan25@example.net','Z7DnBVbH(9',1,0,0,0,0,1,14,21,4,22,19,22,9,5,5,21,15,17,23,22,1,1,0,1,4,2,2,0,2,1,22,0,1,'strong',1,0,1,0,1,1,1,1,0,1,0,1),(8,'levydeborah@example.org','q_Fv3BWz(K',1,0,0,0,1,1,8,9,16,22,7,2,3,20,9,12,1,12,5,6,0,0,1,0,4,5,0,2,0,3,28,1,1,'report',0,1,0,1,0,0,1,0,1,0,0,1),(9,'courtneyhendrix@example.org','2wQdMtkb&O',1,1,1,0,0,0,5,1,22,13,2,16,22,6,11,18,19,2,15,22,0,1,1,1,3,3,0,0,1,3,21,1,1,'seven',0,0,1,0,0,0,0,1,0,1,1,0),(10,'jennifermartin@example.net','uQpzv$@**2',1,0,1,0,0,0,18,0,3,22,12,16,15,15,6,16,10,14,4,7,0,1,1,1,5,1,2,2,1,1,28,1,0,NULL,0,0,1,0,0,0,1,1,1,1,0,0),(11,'rnelson@example.org','+5XcKg1M9q',1,0,1,1,1,0,5,1,20,2,21,7,11,23,7,12,0,7,8,13,0,1,0,1,4,2,0,1,0,2,27,2,0,NULL,1,1,0,0,1,1,0,0,1,1,1,1),(12,'susanjohnson@example.net','5(uF62Nr$i',1,1,0,0,1,1,15,21,12,4,9,11,1,7,22,1,21,10,21,13,1,1,1,0,1,4,2,1,1,0,21,1,0,NULL,0,0,0,1,1,0,1,1,0,0,1,0),(13,'jaredadams@example.com','c84)sNFs&@',1,1,1,1,1,1,8,14,20,22,20,16,14,21,16,10,17,19,18,2,0,1,1,1,5,2,0,1,2,1,22,2,0,NULL,1,1,0,0,0,0,1,0,0,0,1,1),(14,'orivera@example.org','@qIf2iEF8W',0,1,0,0,1,1,11,12,10,22,15,8,13,16,1,1,9,15,7,6,1,0,0,1,3,1,2,2,0,1,24,0,1,'only',0,0,0,1,1,1,1,0,1,0,0,0),(15,'wendy34@example.net','RjZExRCk%5',1,1,0,1,1,1,16,20,14,8,3,15,10,0,0,5,10,0,9,16,0,0,1,0,2,2,0,1,0,2,28,1,0,NULL,1,0,1,0,0,0,0,0,0,1,0,1),(16,'stephaniehouston@example.org','A@83P3Ou5M',1,0,1,0,0,0,11,13,16,17,13,17,19,18,5,8,0,15,15,1,0,0,0,1,1,1,0,2,0,1,25,0,1,'support',0,1,0,0,1,1,0,1,0,1,0,0),(17,'derekrobinson@example.net','l)or1PJnm(',0,1,0,0,1,0,0,0,16,6,17,2,21,22,8,21,10,15,22,10,0,1,0,1,5,1,0,2,1,1,25,0,0,NULL,0,1,0,1,0,0,1,0,1,1,0,0),(18,'curtisbowman@example.org','8rC9QX)n+!',1,0,1,1,0,1,12,22,15,7,12,22,8,13,21,11,21,12,20,19,1,1,0,1,4,1,2,1,2,1,21,1,0,NULL,1,1,1,0,1,0,1,0,0,1,1,1),(19,'zacharyking@example.com','I01PgghfO(',0,0,0,1,0,0,4,18,19,10,15,19,10,4,4,17,2,1,14,21,0,1,0,0,1,1,2,2,2,1,26,2,0,NULL,1,1,0,1,1,0,0,0,0,0,0,1),(20,'halemargaret@example.net','_K_0lRCuO!',1,1,1,0,0,1,15,11,1,11,9,3,21,5,11,22,18,15,15,21,0,0,0,0,5,2,0,2,2,2,25,1,1,'arrive',1,1,0,1,1,0,1,0,0,1,1,0),(21,'gutierrezthomas@example.org','thsCqmTX%0',1,0,0,1,1,0,16,8,3,16,4,20,18,6,4,12,17,16,16,0,0,1,1,0,4,4,1,2,0,3,28,0,1,'institution',0,1,0,0,0,1,0,0,0,1,1,0),(22,'wjohnson@example.org','874KemEe%g',1,0,1,1,0,1,6,15,18,11,4,20,12,6,21,16,10,5,5,7,0,0,1,1,4,2,0,1,0,1,26,0,0,NULL,1,0,1,0,1,1,1,0,0,1,1,0),(23,'andrearodriguez@example.org','@utHixl8J2',0,1,0,1,0,0,17,16,2,13,18,22,5,4,23,21,18,13,22,3,0,1,0,1,5,1,0,1,2,3,22,1,0,NULL,0,1,0,0,1,0,0,0,1,0,1,1),(24,'wbrown@example.net','nuv7SlQ8&_',0,1,0,1,1,0,23,12,9,4,7,23,17,11,9,2,7,10,0,20,1,1,1,1,5,2,2,0,2,1,21,1,1,'vote',1,1,1,1,1,0,0,1,1,0,0,1),(25,'jamesgardner@example.com','7%u6Q3j)Hp',1,1,0,0,0,1,23,23,7,0,1,11,15,0,3,14,18,9,6,4,0,1,0,1,1,1,2,2,1,2,24,2,0,NULL,1,1,0,0,1,0,1,1,1,1,0,0),(26,'shawnknight@example.net','_@z%7G6bBz',1,0,1,0,1,1,9,13,14,15,22,4,9,8,23,3,19,22,15,19,0,0,1,1,5,1,2,0,2,1,20,2,1,'conference',0,0,1,0,1,0,1,1,0,0,1,0),(27,'dunnvanessa@example.com','DtKEV9Vu$A',0,1,0,1,1,0,13,19,0,21,2,17,5,17,15,23,4,0,6,12,0,0,1,1,5,4,1,2,2,1,28,0,0,NULL,1,1,0,0,1,1,0,1,1,1,1,1),(28,'christopherguzman@example.net','RAB0iFEw*)',1,0,1,1,0,1,5,0,10,7,14,5,3,20,22,3,12,10,15,21,0,0,0,1,3,4,2,1,0,3,20,2,1,'business',0,0,0,0,0,0,0,1,1,1,1,1),(29,'scottmelanie@example.org','c6qJCHeD@C',1,1,0,0,1,0,14,4,1,2,11,19,11,3,1,1,10,10,19,20,0,0,1,1,3,4,1,2,1,2,21,1,0,NULL,0,0,0,0,0,1,0,1,1,0,0,0),(30,'richard49@example.com','4p&c8PtufT',1,1,1,1,1,0,11,2,18,1,2,10,22,13,3,11,20,10,22,22,1,1,1,1,3,4,1,2,0,3,23,1,1,'way',0,1,0,1,0,1,1,0,0,0,1,1),(31,'megan54@example.com','(pHy5^w*c7',0,0,1,1,0,0,11,21,17,14,20,6,19,3,6,0,19,12,3,5,1,1,1,0,4,4,0,2,0,2,26,0,1,'community',0,1,0,1,1,0,0,1,0,1,1,0),(32,'tammy33@example.com','5@9ReXuU@&',0,1,1,0,1,0,22,7,22,12,16,1,21,4,23,7,9,6,18,16,0,1,0,0,3,1,1,1,1,3,22,2,1,'office',1,1,0,0,0,1,1,1,1,1,0,0),(33,'lindalowe@example.net','Sr4(4KJi(o',0,1,1,1,0,0,14,2,15,21,19,12,20,13,21,14,20,18,20,9,1,0,0,1,3,4,0,2,0,0,27,1,1,'ok',1,1,1,0,0,1,0,1,0,0,0,1),(34,'mirandadelgado@example.org','7Y@98E(y!0',0,1,0,1,0,1,0,17,13,21,11,21,23,10,0,20,11,20,17,2,0,1,0,0,4,1,2,2,1,1,25,0,1,'drop',1,1,1,0,1,1,0,1,0,0,1,0),(35,'qali@example.net','&_61UuXJRb',0,0,0,0,1,1,11,7,14,13,1,20,0,19,10,10,5,11,10,7,0,1,0,1,5,3,0,2,0,1,25,0,1,'since',0,1,0,1,0,0,1,0,0,1,0,0),(36,'jeremykelley@example.net','&9EJoy3mtP',1,1,1,0,0,1,4,11,10,16,14,17,0,3,12,2,6,14,10,9,0,1,1,1,4,5,0,1,2,2,24,0,0,NULL,1,1,1,1,0,0,0,1,0,0,1,0),(37,'connerlisa@example.com','(rMZy%oF^1',1,0,1,0,0,0,15,8,13,1,1,17,2,20,22,13,4,15,15,5,0,0,1,1,3,2,1,0,1,0,22,1,1,'someone',0,1,1,0,1,1,1,1,1,0,0,1),(38,'robert01@example.org','0sw5#qH^^Z',0,0,0,0,1,0,9,11,21,5,22,22,1,21,10,8,19,14,7,6,1,0,0,1,5,5,0,2,0,2,21,0,1,'condition',1,1,1,1,0,0,1,1,0,1,1,1),(39,'andre81@example.net','2G+HMKXw($',0,1,0,1,0,1,17,0,23,23,21,4,7,1,2,8,8,22,22,18,0,1,0,0,4,1,1,0,2,2,24,0,1,'hotel',1,1,1,0,0,0,0,1,1,1,0,0),(40,'garneralexandria@example.com','qS0DmaAk%P',0,0,0,1,0,0,15,14,22,19,23,12,14,9,6,21,13,13,0,14,0,0,1,1,2,3,2,2,1,1,26,2,0,NULL,0,1,0,1,0,0,1,0,1,1,1,1),(41,'christopherking@example.org','&U6!^Lwch0',0,0,1,0,0,0,23,18,14,12,15,19,16,8,9,8,21,4,23,16,1,0,1,1,2,1,0,1,1,1,21,1,0,NULL,0,0,1,1,1,0,1,0,1,0,0,1),(42,'jenniferburke@example.net','*nvrCG9a2Q',0,0,0,0,0,1,8,4,3,11,6,12,14,20,1,19,20,10,18,14,1,1,1,0,5,5,1,1,1,2,23,0,0,NULL,0,1,1,0,0,1,0,1,1,0,1,0),(43,'williamhorton@example.com','oi+K99OvNM',1,1,1,1,1,1,16,0,13,17,2,21,2,12,21,9,8,23,22,1,0,0,0,0,4,4,2,0,0,2,28,1,1,'without',0,0,1,1,1,0,0,1,1,1,1,0),(44,'natalie34@example.com','$w8T$9UshC',0,0,0,1,1,1,3,9,9,21,19,23,17,14,6,7,4,6,5,23,1,1,0,0,5,1,2,2,1,2,25,0,1,'left',1,0,1,1,1,0,0,1,0,1,1,0),(45,'campbellsteve@example.org','j54Ib+fU&@',0,1,0,0,1,1,0,22,0,12,17,0,10,16,14,14,23,14,5,11,1,1,1,0,2,1,0,2,1,0,25,1,1,'can',0,0,1,0,1,0,0,0,1,1,1,0),(46,'jmiller@example.com','7gPx%D!)*D',1,1,0,1,0,1,9,15,15,14,12,16,8,19,7,10,10,9,17,3,0,0,1,1,3,5,2,0,2,2,26,2,1,'manager',0,0,1,0,0,1,0,1,1,0,1,1),(47,'bcarr@example.org','s!!Crtr!%8',1,1,1,0,0,0,5,12,16,1,14,7,21,14,6,13,23,21,6,1,0,0,1,1,1,3,2,0,0,2,25,1,1,'close',1,0,1,1,1,0,1,1,0,1,0,1),(48,'irobinson@example.net','!63VW1!e(7',0,1,1,0,1,1,11,21,14,18,22,10,11,7,17,12,3,5,4,23,0,0,0,0,4,2,0,0,0,1,26,0,1,'yourself',0,1,0,1,1,0,0,0,1,1,0,1),(49,'markwebster@example.org','nl3sCi39m!',1,1,1,0,0,0,17,13,9,1,16,20,10,3,3,10,23,3,20,9,0,1,0,1,4,4,1,0,2,1,28,2,0,NULL,0,1,1,1,0,0,1,1,1,1,1,0),(50,'jmarquez@example.net','!dLBBeTvV4',0,1,0,0,0,1,4,20,2,21,12,17,10,3,3,17,2,22,11,4,1,1,1,1,2,4,0,0,0,1,24,2,1,'market',0,1,0,1,0,1,0,1,0,0,0,1),(51,'ksantiago@example.net','+71mEJhX9&',1,1,0,0,1,1,18,2,10,9,20,13,4,21,7,18,12,7,16,22,1,1,0,0,3,4,0,0,0,3,25,1,1,'feel',1,0,0,0,0,1,0,0,0,1,1,1),(52,'hursttiffany@example.org','h^y0NPjQ*c',0,1,1,1,0,0,10,2,11,2,15,2,2,19,8,2,12,11,11,2,1,0,0,1,3,4,1,2,2,3,20,1,1,'air',1,0,1,0,0,0,0,0,1,0,1,0),(53,'jonathankoch@example.net','ZuRIlRGm#3',1,1,1,0,1,1,1,12,7,4,9,20,19,15,3,18,11,1,23,3,0,0,1,0,4,3,1,0,2,2,20,2,1,'door',1,0,0,1,0,0,0,1,1,1,0,0),(54,'mthompson@example.net',')NaI@3ArS(',0,1,1,0,0,1,0,10,22,14,11,3,18,22,9,19,12,10,19,15,1,1,0,0,2,1,0,1,1,1,25,1,0,NULL,0,1,1,1,1,1,0,1,0,1,1,1),(55,'adamjones@example.net','wA2WbkU6)f',1,0,0,1,0,1,12,23,22,8,19,16,22,0,8,13,1,23,21,13,1,1,0,0,5,1,1,0,1,2,25,2,1,'sell',0,0,0,1,0,1,0,1,1,0,1,0),(56,'danielhampton@example.org','*!(IBU7x97',0,0,1,1,1,1,8,12,21,18,19,17,20,10,13,23,6,6,19,11,0,0,0,1,3,1,2,1,1,2,28,0,0,NULL,1,1,0,1,0,1,1,1,0,1,1,0),(57,'ubridges@example.com','&7Sk*XIe_q',1,1,1,1,0,0,21,3,13,23,0,21,19,14,19,19,9,19,16,13,0,0,0,1,3,2,0,1,0,1,25,2,1,'case',1,1,0,0,1,0,1,0,1,0,0,0),(58,'jodi92@example.net','9GDX8GaM&Z',0,0,1,0,0,1,21,8,10,19,4,13,2,9,14,19,16,1,20,2,1,0,0,0,2,2,1,1,0,2,24,2,1,'past',1,1,1,0,1,1,1,1,0,0,0,0),(59,'hernandezkevin@example.net','8406AXxt!P',0,0,0,0,1,0,2,3,5,11,3,20,1,16,8,2,10,19,12,18,1,1,0,1,5,3,1,1,0,1,27,2,0,NULL,0,1,1,1,1,0,1,0,0,0,0,1),(60,'lhoffman@example.org','*ev8YS0It$',1,0,1,1,1,1,12,18,4,11,1,8,13,20,21,17,16,5,2,1,1,1,1,0,5,5,1,2,1,3,23,0,0,NULL,0,0,1,0,1,0,0,1,1,0,1,0),(61,NULL,NULL,0,0,1,1,0,0,0,8,0,8,0,8,0,8,8,0,15,3,3,15,0,1,0,1,5,3,1,0,1,2,0,1,1,'狗',0,0,1,1,1,0,0,0,0,0,0,0),(62,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(63,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(64,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(65,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(66,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(67,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(68,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(69,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(70,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_match`
--

LOCK TABLES `user_match` WRITE;
/*!40000 ALTER TABLE `user_match` DISABLE KEYS */;
INSERT INTO `user_match` VALUES (1,51,34,1,0.60,0.67,0.50,0.50,0.78,1,0,1.00,0,0.60,1.00,1.00,0.50),(2,52,32,1,0.63,0.00,0.42,0.50,0.78,0,0,0.50,1,0.60,0.50,0.00,0.50),(3,52,49,0,0.88,0.67,0.50,0.50,0.79,0,0,1.00,0,0.80,1.00,0.00,0.00),(4,52,34,1,0.60,0.67,0.58,0.50,0.81,0,0,0.50,1,0.60,0.00,0.50,0.50),(5,52,35,1,0.72,0.67,0.33,0.50,0.84,0,0,1.00,1,0.00,0.00,0.50,1.00),(6,52,51,1,1.00,0.00,0.58,0.00,0.84,0,1,0.50,0,0.20,1.00,0.50,1.00),(7,52,36,0,0.82,0.33,0.67,0.50,0.83,0,0,0.50,0,0.60,0.50,0.50,0.00),(8,52,43,1,0.88,0.33,0.58,0.00,0.78,1,0,0.50,0,0.60,1.00,0.50,1.00),(9,52,28,1,1.00,0.00,0.58,0.50,0.89,1,0,1.00,0,0.60,0.50,0.50,1.00),(10,52,30,1,1.00,0.00,0.33,0.00,0.81,0,1,0.50,0,0.80,0.00,0.00,1.00),(11,52,31,1,0.88,0.33,0.33,0.50,0.83,0,1,0.00,1,0.80,0.00,0.50,1.00),(12,52,47,1,0.72,0.33,0.33,0.00,0.81,1,0,0.50,0,0.80,1.00,0.50,1.00),(13,52,34,1,0.60,0.67,0.58,0.50,0.81,0,0,0.50,1,0.60,0.00,0.50,0.50),(14,53,34,1,0.75,0.33,0.33,1.00,0.88,0,1,0.50,0,0.40,1.00,0.50,0.50),(15,53,52,1,0.82,0.33,0.58,0.50,0.80,1,0,0.00,0,0.40,1.00,0.00,0.00),(16,54,32,0,0.88,0.67,0.33,0.50,0.85,1,0,1.00,1,0.60,0.00,0.50,0.00),(17,54,34,0,0.75,0.00,0.67,0.50,0.79,1,0,1.00,1,0.60,0.50,1.00,0.00),(18,54,35,0,0.55,0.00,0.42,0.50,0.80,1,0,0.50,1,0.40,0.50,0.00,0.50),(19,54,36,1,0.44,0.33,0.58,0.50,0.81,1,0,0.00,0,1.00,0.00,0.00,0.50),(20,54,38,0,0.38,0.33,0.67,0.50,0.78,0,1,0.50,1,0.20,0.50,0.00,0.50),(21,54,43,0,0.55,0.33,0.67,0.00,0.75,0,0,1.00,0,0.60,0.50,1.00,0.50),(22,54,47,0,0.72,0.33,0.58,0.00,0.78,0,0,0.00,0,0.80,0.50,1.00,0.50),(23,54,50,0,0.63,0.00,0.67,0.50,0.77,1,1,0.00,1,0.80,0.50,0.00,0.50),(24,54,51,0,0.60,0.67,0.50,0.00,0.80,1,1,1.00,0,0.60,0.50,0.00,0.50),(25,54,52,0,0.60,0.67,0.25,0.00,0.78,0,1,0.50,1,0.60,0.50,0.50,0.50),(26,54,53,0,0.65,0.33,0.33,0.50,0.81,0,0,0.50,0,0.80,0.50,0.50,0.50),(27,54,28,0,0.60,0.67,0.50,0.50,0.80,0,0,0.50,0,0.60,0.00,1.00,0.50),(28,54,30,0,0.60,0.67,0.58,0.00,0.78,1,1,0.00,0,0.40,0.50,0.50,0.50),(29,54,31,0,0.55,0.33,0.75,0.50,0.80,1,1,0.50,1,0.40,0.50,0.00,0.50),(30,54,32,0,0.88,0.67,0.33,0.50,0.85,1,0,1.00,1,0.60,0.00,0.50,0.00),(31,57,34,1,0.82,0.00,0.50,1.00,0.84,0,1,0.50,0,0.60,0.50,1.00,0.50),(32,57,52,1,0.75,0.67,0.58,0.50,0.79,1,0,1.00,0,1.00,0.50,0.50,1.00),(33,57,54,0,0.82,0.00,0.17,0.50,0.80,0,0,0.50,0,0.60,0.00,0.00,0.50),(34,58,32,1,0.82,0.33,0.67,0.00,0.76,0,0,1.00,1,0.40,0.00,0.00,0.50),(35,58,34,1,0.72,0.33,0.83,1.00,0.85,0,0,1.00,1,0.40,0.50,0.50,0.50),(36,58,35,1,0.60,0.33,0.42,1.00,0.78,0,0,0.50,1,0.60,0.50,0.50,0.00),(37,58,36,0,0.55,0.00,0.58,1.00,0.80,0,0,0.00,0,0.80,0.00,0.50,1.00),(38,58,38,1,0.47,0.00,0.50,1.00,0.75,1,1,0.50,1,0.40,0.50,0.50,0.00),(39,58,40,0,0.88,0.33,0.17,0.00,0.78,1,0,0.00,1,0.40,0.50,0.50,0.50),(40,58,43,1,0.65,0.00,0.33,0.50,0.84,1,0,1.00,0,0.40,0.50,0.50,0.00),(41,58,45,1,0.88,0.67,0.33,0.50,0.75,0,1,0.50,1,0.40,0.50,0.50,0.50),(42,58,47,1,0.82,0.00,0.58,0.50,0.81,1,0,0.00,0,0.60,0.50,0.50,0.00),(43,58,50,1,0.75,0.33,0.50,0.00,0.78,0,1,0.00,1,0.60,0.50,0.50,0.00),(44,58,51,1,0.72,0.33,0.33,0.50,0.83,0,1,1.00,0,0.40,0.50,0.50,0.00),(45,58,52,1,0.72,0.33,0.42,0.50,0.77,1,1,0.50,1,0.40,0.50,0.00,1.00),(46,58,53,1,0.72,0.00,0.33,0.00,0.84,1,0,0.50,0,0.60,0.50,0.00,1.00),(47,58,54,0,0.88,0.33,0.50,0.50,0.78,0,1,1.00,1,0.80,0.00,0.50,0.50),(48,58,57,1,0.88,0.33,0.67,0.00,0.83,1,0,0.50,0,0.40,0.00,0.50,0.00),(49,58,28,1,0.72,0.33,0.17,0.00,0.77,1,0,0.50,0,0.80,0.00,0.50,0.00),(50,58,30,1,0.72,0.33,0.42,0.50,0.81,0,1,0.00,0,0.20,0.50,0.00,0.00),(51,58,31,1,0.65,0.00,0.42,1.00,0.78,0,1,0.50,1,0.60,0.50,0.50,0.00),(60,61,34,1,0.72,0.33,0.50,0.50,0.76,1,1,0.50,1,0.40,1.00,0.50,0.00),(61,61,52,1,0.72,0.33,0.58,0.00,0.78,0,0,1.00,1,0.80,1.00,0.00,0.50),(62,61,54,0,0.55,0.33,0.50,0.00,0.83,1,0,0.50,1,0.40,0.50,0.50,0.00),(63,61,58,1,0.60,0.00,0.50,0.50,0.82,0,0,0.50,1,0.60,0.50,0.00,0.50);
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
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wanted_room`
--

LOCK TABLES `wanted_room` WRITE;
/*!40000 ALTER TABLE `wanted_room` DISABLE KEYS */;
INSERT INTO `wanted_room` VALUES (4,3557,5561,2,3),(5,3420,5861,2,2),(6,4858,7505,2,1),(7,4188,8150,3,1),(8,3183,7040,3,4),(9,4293,6974,4,3),(10,4991,7704,4,1),(11,3745,6731,5,3),(12,4135,6745,6,2),(13,3238,7172,6,4),(14,3538,6072,6,3),(15,4689,8369,7,3),(16,3887,6254,8,4),(17,4683,8106,9,4),(18,3279,6131,9,1),(19,3950,7865,9,3),(20,4952,7647,10,3),(21,4632,7411,10,2),(22,4007,7973,11,3),(23,3110,6368,12,2),(24,4243,7366,12,3),(25,4002,6486,13,2),(26,4969,7840,13,3),(27,3765,6052,13,1),(28,3042,6403,14,3),(29,3264,7148,15,4),(30,4775,6924,15,3),(31,4250,7588,15,2),(32,4913,6935,16,3),(33,3262,5304,17,3),(34,3781,7492,17,2),(35,4762,7491,18,1),(36,3701,6433,18,4),(37,4645,7764,18,3),(38,4661,8118,19,3),(39,4248,6937,20,4),(40,3829,7420,20,3),(41,4430,7017,20,1),(42,4944,8837,21,3),(43,3789,7096,21,1),(44,4741,8198,21,2),(45,4442,6639,22,2),(46,4402,8337,23,3),(47,4878,8708,23,2),(48,3795,6435,23,1),(49,4746,8365,24,2),(50,3035,6094,24,3),(51,3077,5285,25,3),(52,4311,6623,25,4),(167,4000,7000,83,1),(168,5000,9000,83,3),(169,4000,7000,84,1),(170,5000,9000,84,3),(171,4000,7000,85,1),(172,5000,8000,85,3);
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

-- Dump completed on 2024-09-30  9:29:05
