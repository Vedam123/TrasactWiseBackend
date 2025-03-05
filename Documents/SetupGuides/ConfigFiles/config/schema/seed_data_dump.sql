-- MySQL dump 10.13  Distrib 8.4.4, for Linux (x86_64)
--
-- Host: localhost    Database: adm
-- ------------------------------------------------------
-- Server version	8.4.4

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
-- Current Database: `adm`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `adm` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `adm`;

--
-- Table structure for table `bk_configurations`
--

DROP TABLE IF EXISTS `bk_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bk_configurations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `config_key` varchar(255) NOT NULL,
  `config_value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bk_configurations`
--

LOCK TABLES `bk_configurations` WRITE;
/*!40000 ALTER TABLE `bk_configurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `bk_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bk_super_user`
--

DROP TABLE IF EXISTS `bk_super_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bk_super_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bk_super_user`
--

LOCK TABLES `bk_super_user` WRITE;
/*!40000 ALTER TABLE `bk_super_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `bk_super_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `folder_name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (10,'admin','2025-03-04 11:41:26','2025-03-04 11:41:26',0,0),(11,'common','2025-03-04 11:41:26','2025-03-04 11:41:26',0,0),(12,'employee','2025-03-04 11:41:26','2025-03-04 11:41:26',0,0),(13,'finance','2025-03-04 11:41:26','2025-03-04 11:41:26',0,0),(14,'inventory','2025-03-04 11:41:26','2025-03-04 11:41:26',0,0),(15,'products','2025-03-04 11:41:26','2025-03-04 11:41:26',0,0),(16,'purchase','2025-03-04 11:41:26','2025-03-04 11:41:26',0,0),(17,'sales','2025-03-04 11:41:26','2025-03-04 11:41:26',0,0),(18,'security','2025-03-04 11:41:26','2025-03-04 11:41:26',0,0),(19,'utilities','2025-03-04 11:41:26','2025-03-04 11:41:26',0,0);
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequence_table`
--

DROP TABLE IF EXISTS `sequence_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequence_table` (
  `sequence_name` varchar(255) NOT NULL,
  `current_value` bigint unsigned NOT NULL,
  `increment_value` bigint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`sequence_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequence_table`
--

LOCK TABLES `sequence_table` WRITE;
/*!40000 ALTER TABLE `sequence_table` DISABLE KEYS */;
INSERT INTO `sequence_table` VALUES ('ITEM_NUMBER',1006,1),('JOURNAL_HDR_NUMBER',2000,1),('JOURNAL_LINE_NUMBER',150000,1),('PUR_DIST_LINE_NUMBER',2000,1),('PUR_HDR_INV_NUM',2000,1),('PUR_LINE_NUMBER',150000,1),('SAL_DIST_LINE_NUMBER',2000,1),('SAL_HDR_INV_NUM',8000,1),('SAL_LINE_NUMBER',70000,1);
/*!40000 ALTER TABLE `sequence_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ui_config_data`
--

DROP TABLE IF EXISTS `ui_config_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ui_config_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `config_key` varchar(255) NOT NULL,
  `config_value` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ui_config_data`
--

LOCK TABLES `ui_config_data` WRITE;
/*!40000 ALTER TABLE `ui_config_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `ui_config_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_module_permissions`
--

DROP TABLE IF EXISTS `user_module_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_module_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `module` varchar(100) NOT NULL,
  `read_permission` tinyint(1) DEFAULT '0',
  `write_permission` tinyint(1) DEFAULT '0',
  `update_permission` tinyint(1) DEFAULT '0',
  `delete_permission` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`module`),
  CONSTRAINT `user_module_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_module_permissions`
--

LOCK TABLES `user_module_permissions` WRITE;
/*!40000 ALTER TABLE `user_module_permissions` DISABLE KEYS */;
INSERT INTO `user_module_permissions` VALUES (100,1200,'admin',1,1,1,1,'2025-03-04 11:42:28','2025-03-04 11:48:53',0,0),(101,1200,'common',1,1,1,1,'2025-03-04 11:47:12','2025-03-04 11:48:53',1200,0),(102,1200,'employee',1,1,1,1,'2025-03-04 11:47:12','2025-03-04 11:48:53',1200,0),(103,1200,'finance',1,1,1,1,'2025-03-04 11:47:12','2025-03-04 11:48:53',1200,0),(104,1200,'inventory',1,1,1,1,'2025-03-04 11:47:12','2025-03-04 11:48:53',1200,0),(105,1200,'products',1,1,1,1,'2025-03-04 11:47:12','2025-03-04 11:48:53',1200,0),(106,1200,'purchase',1,1,1,1,'2025-03-04 11:47:12','2025-03-04 11:48:53',1200,0),(107,1200,'sales',1,1,1,1,'2025-03-04 11:47:12','2025-03-04 11:48:53',1200,0),(108,1200,'security',1,1,1,1,'2025-03-04 11:47:12','2025-03-04 11:48:53',1200,0),(109,1200,'utilities',1,1,1,1,'2025-03-04 11:47:12','2025-03-04 11:48:53',1200,0),(110,1205,'common',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1205,1205),(111,1205,'employee',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1205,1205),(112,1205,'finance',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1205,1205),(113,1205,'inventory',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1205,1205),(114,1205,'products',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1205,1205),(115,1205,'purchase',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1205,1205),(116,1205,'sales',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1205,1205),(117,1205,'security',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1205,1205),(118,1205,'utilities',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1205,1205),(119,1207,'common',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1207,1207),(120,1207,'employee',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1207,1207),(121,1207,'finance',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1207,1207),(122,1207,'inventory',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1207,1207),(123,1207,'products',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1207,1207),(124,1207,'purchase',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1207,1207),(125,1207,'sales',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1207,1207),(126,1207,'security',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1207,1207),(127,1207,'utilities',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1207,1207),(128,1208,'common',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1208,1208),(129,1208,'employee',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1208,1208),(130,1208,'finance',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1208,1208),(131,1208,'inventory',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1208,1208),(132,1208,'products',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1208,1208),(133,1208,'purchase',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1208,1208),(134,1208,'sales',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1208,1208),(135,1208,'security',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1208,1208),(136,1208,'utilities',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1208,1208),(137,1209,'common',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1209,1209),(138,1209,'employee',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1209,1209),(139,1209,'finance',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1209,1209),(140,1209,'inventory',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1209,1209),(141,1209,'products',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1209,1209),(142,1209,'purchase',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1209,1209),(143,1209,'sales',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1209,1209),(144,1209,'security',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1209,1209),(145,1209,'utilities',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1209,1209),(146,1210,'common',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:50:30',1210,0),(147,1210,'employee',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:50:30',1210,0),(148,1210,'finance',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:50:30',1210,0),(149,1210,'inventory',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:50:30',1210,0),(150,1210,'products',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:50:30',1210,0),(151,1210,'purchase',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:50:30',1210,0),(152,1210,'sales',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:50:30',1210,0),(153,1210,'security',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:50:30',1210,0),(154,1210,'utilities',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:50:30',1210,0),(155,1211,'common',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1211,1211),(156,1211,'employee',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1211,1211),(157,1211,'finance',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1211,1211),(158,1211,'inventory',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1211,1211),(159,1211,'products',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1211,1211),(160,1211,'purchase',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1211,1211),(161,1211,'sales',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1211,1211),(162,1211,'security',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1211,1211),(163,1211,'utilities',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1211,1211),(164,1212,'common',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1212,1212),(165,1212,'employee',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1212,1212),(166,1212,'finance',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1212,1212),(167,1212,'inventory',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1212,1212),(168,1212,'products',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1212,1212),(169,1212,'purchase',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1212,1212),(170,1212,'sales',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1212,1212),(171,1212,'security',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1212,1212),(172,1212,'utilities',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1212,1212),(173,1213,'common',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1213,1213),(174,1213,'employee',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1213,1213),(175,1213,'finance',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1213,1213),(176,1213,'inventory',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1213,1213),(177,1213,'products',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1213,1213),(178,1213,'purchase',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1213,1213),(179,1213,'sales',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1213,1213),(180,1213,'security',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1213,1213),(181,1213,'utilities',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1213,1213),(182,1214,'common',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1214,1214),(183,1214,'employee',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1214,1214),(184,1214,'finance',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1214,1214),(185,1214,'inventory',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1214,1214),(186,1214,'products',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1214,1214),(187,1214,'purchase',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1214,1214),(188,1214,'sales',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1214,1214),(189,1214,'security',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1214,1214),(190,1214,'utilities',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1214,1214),(191,1215,'common',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1215,1215),(192,1215,'employee',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1215,1215),(193,1215,'finance',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1215,1215),(194,1215,'inventory',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1215,1215),(195,1215,'products',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1215,1215),(196,1215,'purchase',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1215,1215),(197,1215,'sales',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1215,1215),(198,1215,'security',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1215,1215),(199,1215,'utilities',1,1,1,1,'2025-03-04 11:49:36','2025-03-04 11:49:36',1215,1215),(200,1210,'admin',1,1,1,1,'2025-03-04 11:50:15','2025-03-04 11:50:30',0,0);
/*!40000 ALTER TABLE `user_module_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `empid` int DEFAULT NULL,
  `emailid` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `emailid` (`emailid`),
  KEY `empid` (`empid`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`empid`) REFERENCES `com`.`employee` (`empid`)
) ENGINE=InnoDB AUTO_INCREMENT=1216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1200,'jsmith','$2b$12$ZYLy8RdnRIN22yLKvyAh3OQqxNwhitSpDbVmECuCuW5LzFDAbsI.u',2002,'','ACTIVE','2025-03-04',NULL,'2025-03-04 11:36:22','2025-03-04 11:36:22',0,0),(1205,'skumar','$2b$12$dT7eWMKK.Z6Nu63bWE1dQe5QD3YgZud2mQ0sq5EM3NcLmPM3A3O3m',2003,'testemail@test.com','ACTIVE','2025-03-04',NULL,'2025-03-04 11:37:20','2025-03-04 11:37:20',0,0),(1207,'atalluri','$2b$12$VhqOm42uzJNi.16TYsmFCeYkwhRx84YY5I9mRWPANruUnrwH.x/om',2004,'test@test.com','ACTIVE','2025-03-04',NULL,'2025-03-04 11:37:51','2025-03-04 11:37:51',0,0),(1208,'lreddy','$2b$12$SJ1aXqRE4GUYsu4OKamqpuveYE1G2D4Aw.J6GXBaINS0C8sbCb2SS',2005,'lreddy@test.com','ACTIVE','2025-03-04',NULL,'2025-03-04 11:38:20','2025-03-04 11:38:20',0,0),(1209,'sbalisetty','$2b$12$tvkxc6GSv8FCBK08GMl20eEXcqyHyHSr001JjYWkUmsLqN7UizyX.',2006,'sbalisetty@test.com','ACTIVE','2025-03-04',NULL,'2025-03-04 11:38:51','2025-03-04 11:38:51',0,0),(1210,'kvedam','$2b$12$TDYnabbNgvv8xCwjJW9/pO5BXCfkGx96nIly/yOukg0yRIggRztzW',2007,'kvedam@test.com','ACTIVE','2025-03-04',NULL,'2025-03-04 11:39:12','2025-03-04 11:39:12',0,0),(1211,'asingh','$2b$12$5nI17drUv8Kw8IhjnAY1tOYcjgFGUR4kKslfKj4qwVp.SStK/RExm',2008,'asingh@test.com','ACTIVE','2025-03-04',NULL,'2025-03-04 11:39:32','2025-03-04 11:39:32',0,0),(1212,'kvedam1','$2b$12$g.a3dLjo8I.j4y9QNOJpWO7PObhVVAOozX5deBZ7CWTFcZ3D0Zbhi',2009,'kvedam1@test.com','ACTIVE','2025-03-04',NULL,'2025-03-04 11:40:05','2025-03-04 11:40:05',0,0),(1213,'kvedam2','$2b$12$bm/z3Na5UtcOQLu.V6XQkuR7Ew.pre69oj4rDzJ2ShMcPvG2jOvlm',2010,'kvedam2@test.com','ACTIVE','2025-03-04',NULL,'2025-03-04 11:40:29','2025-03-04 11:40:29',0,0),(1214,'pbondu','$2b$12$rkaBlqiiPzYm9AeO.VD0JecF/176oo33rq7eBw6R1Du71s06c/gIa',2011,'pbondu@test.com','ACTIVE','2025-03-04',NULL,'2025-03-04 11:40:50','2025-03-04 11:40:50',0,0),(1215,'karasan','$2b$12$xrEb96eGzTzDzXrjTghzJ.Azrb0jSzBh0nwE2zMs91OOuADEX4zmS',2012,'karasan@test.com','ACTIVE','2025-03-04',NULL,'2025-03-04 11:41:15','2025-03-04 11:41:15',0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `com`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `com` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `com`;

--
-- Table structure for table `attribute_definitions`
--

DROP TABLE IF EXISTS `attribute_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_definitions` (
  `attribute_id` int NOT NULL AUTO_INCREMENT,
  `attribute_name` varchar(100) NOT NULL,
  `attribute_type` varchar(50) NOT NULL,
  PRIMARY KEY (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_definitions`
--

LOCK TABLES `attribute_definitions` WRITE;
/*!40000 ALTER TABLE `attribute_definitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_definitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bom`
--

DROP TABLE IF EXISTS `bom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bom` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ModelItem` int DEFAULT NULL,
  `ParentItem` int DEFAULT NULL,
  `ComponentItem` int DEFAULT NULL,
  `Quantity` decimal(10,2) DEFAULT NULL,
  `uom` int DEFAULT NULL,
  `ScrapPercentage` decimal(5,2) DEFAULT NULL,
  `RoutingOperation` varchar(50) DEFAULT NULL,
  `Revision` varchar(10) DEFAULT NULL,
  `EffectiveDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `NotesComments` text,
  `Level` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ModelItem` (`ModelItem`,`ParentItem`,`ComponentItem`),
  KEY `ParentItem` (`ParentItem`),
  KEY `ComponentItem` (`ComponentItem`),
  KEY `uom` (`uom`),
  CONSTRAINT `bom_ibfk_1` FOREIGN KEY (`ModelItem`) REFERENCES `items` (`item_id`),
  CONSTRAINT `bom_ibfk_2` FOREIGN KEY (`ParentItem`) REFERENCES `items` (`item_id`),
  CONSTRAINT `bom_ibfk_3` FOREIGN KEY (`ComponentItem`) REFERENCES `items` (`item_id`),
  CONSTRAINT `bom_ibfk_4` FOREIGN KEY (`uom`) REFERENCES `uom` (`uom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bom`
--

LOCK TABLES `bom` WRITE;
/*!40000 ALTER TABLE `bom` DISABLE KEYS */;
/*!40000 ALTER TABLE `bom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `businesspartner`
--

DROP TABLE IF EXISTS `businesspartner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `businesspartner` (
  `partnerid` int NOT NULL AUTO_INCREMENT,
  `partnertype` varchar(20) NOT NULL,
  `partnername` varchar(100) NOT NULL,
  `contactperson` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `postalcode` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `taxid` varchar(50) DEFAULT NULL,
  `registrationnumber` varchar(50) DEFAULT NULL,
  `additionalinfo` text,
  `currency_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `customerimage` longblob,
  PRIMARY KEY (`partnerid`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `businesspartner_ibfk_1` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3017 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `businesspartner`
--

LOCK TABLES `businesspartner` WRITE;
/*!40000 ALTER TABLE `businesspartner` DISABLE KEYS */;
INSERT INTO `businesspartner` VALUES (3000,'Supplier','ABC Supplies Ltd.','John Doe','john.doe@abc.com','+1234567890','123 Supply St.','New York','NY','10001','USA','TAX12345','REG67890','Leading supplier of industrial goods',30,'2025-03-04 13:28:12','2025-03-04 13:28:12',1,1,'Active',NULL),(3001,'Customer','XYZ Retailers','Jane Smith','jane.smith@xyz.com','+9876543210','456 Retail Ave.','Los Angeles','CA','90001','USA','TAX67890','REG12345','Retail company specializing in electronics',31,'2025-03-04 13:28:12','2025-03-04 13:28:12',1,1,'Active',NULL),(3002,'Both','Global Traders','Mike Johnson','mike.johnson@global.com','+1122334455','789 Trade Blvd.','Chicago','IL','60601','USA','TAX56789','REG98765','Engaged in both buying and selling',33,'2025-03-04 13:28:12','2025-03-04 13:28:12',1,1,'Active',NULL),(3003,'Internal','Company Operations','Emma Williams','emma.williams@internal.com','+4455667788','101 Corporate Dr.','Houston','TX','77001','USA','TAX22334','REG55667','Internal business operations entity',32,'2025-03-04 13:28:12','2025-03-04 13:28:12',1,1,'Active',NULL),(3004,'All','Universal Partners','Robert Brown','robert.brown@universal.com','+6677889900','202 Global Ln.','San Francisco','CA','94101','USA','TAX99887','REG11223','Handles multiple business operations',45,'2025-03-04 13:28:12','2025-03-04 13:28:12',1,1,'Active',NULL),(3005,'Supplier','AutoParts Warehouse','James Miller','james.miller@autoparts.com','+1113335555','101 Engine Rd.','Detroit','MI','48226','USA','TAX10101','REG11122','Supplier of automobile spare parts',30,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3006,'Supplier','Speedy Tires Ltd.','Sophia Wilson','sophia.wilson@speedytires.com','+2224446666','202 Wheels St.','Dallas','TX','75201','USA','TAX20202','REG22233','Supplier of high-performance car tires',30,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3007,'Supplier','Global Auto Components','Michael Anderson','michael.anderson@globalauto.com','+3335557777','303 Vehicle Dr.','Los Angeles','CA','90001','USA','TAX30303','REG33344','Automobile component manufacturer and supplier',30,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3008,'Customer','FastDrive Rentals','Ethan Clark','ethan.clark@fastdrive.com','+4446668888','404 Rental Blvd.','New York','NY','10001','USA','TAX40404','REG44455','Car rental service provider',31,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3009,'Customer','Luxury Motors Showroom','Olivia Martin','olivia.martin@luxurymotors.com','+5557779999','505 Showroom Lane','Miami','FL','33101','USA','TAX50505','REG55566','Luxury car dealership',31,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3010,'Customer','EcoDrive Vehicles','Lucas Walker','lucas.walker@ecodrive.com','+6668880000','606 Green Street','San Francisco','CA','94101','USA','TAX60606','REG66677','Electric vehicle dealership',31,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3011,'Supplier','TechZone Laptops','William Davis','william.davis@techzone.com','+7779991111','707 Laptop Street','Chicago','IL','60601','USA','TAX70707','REG77788','Supplier of branded laptops and accessories',33,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3012,'Supplier','Mobile Hub Distributors','Isabella Moore','isabella.moore@mobilehub.com','+8880002222','808 Phone Ave.','Seattle','WA','98101','USA','TAX80808','REG88899','Supplier of mobile phones and gadgets',33,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3013,'Supplier','Gadget Kings','Daniel Garcia','daniel.garcia@gadgetkings.com','+9991113333','909 Tech Plaza','Boston','MA','02108','USA','TAX90909','REG99900','Leading wholesaler of laptops and mobile devices',33,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3014,'Customer','Elite Electronics','Emma Thomas','emma.thomas@eliteelectronics.com','+1113335555','101 Tech Street','Austin','TX','73301','USA','TAX10110','REG11122','Retailer of high-end electronics and laptops',31,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3015,'Customer','SmartPhone Store','Liam Martinez','liam.martinez@smartphonestore.com','+2224446666','202 Mobile Lane','Los Angeles','CA','90001','USA','TAX20220','REG22233','Specialized store for mobile phones',31,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL),(3016,'Customer','Gizmo Retailers','Charlotte Lee','charlotte.lee@gizmo.com','+3335557777','303 Gadget Ave.','San Diego','CA','92101','USA','TAX30330','REG33344','Retail shop for gadgets and mobile accessories',31,'2025-03-04 13:31:36','2025-03-04 13:31:36',1,1,'Active',NULL);
/*!40000 ALTER TABLE `businesspartner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_image_mapping`
--

DROP TABLE IF EXISTS `category_image_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_image_mapping` (
  `mapping_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `image_id` int NOT NULL,
  `image_order` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mapping_id`),
  KEY `category_id` (`category_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `category_image_mapping_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `itemcategory` (`category_id`) ON DELETE CASCADE,
  CONSTRAINT `category_image_mapping_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `category_images` (`image_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_image_mapping`
--

LOCK TABLES `category_image_mapping` WRITE;
/*!40000 ALTER TABLE `category_image_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_image_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_images`
--

DROP TABLE IF EXISTS `category_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `image` mediumblob NOT NULL,
  `image_type` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_images`
--

LOCK TABLES `category_images` WRITE;
/*!40000 ALTER TABLE `category_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_company_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `local_cur_id` int DEFAULT NULL,
  `home_cur_id` int DEFAULT NULL,
  `reporting_cur_id` int DEFAULT NULL,
  `default_tax_code_id` int DEFAULT NULL,
  `default_account_header_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_company_id` (`group_company_id`),
  KEY `local_cur_id` (`local_cur_id`),
  KEY `home_cur_id` (`home_cur_id`),
  KEY `reporting_cur_id` (`reporting_cur_id`),
  KEY `default_tax_code_id` (`default_tax_code_id`),
  KEY `default_account_header_id` (`default_account_header_id`),
  CONSTRAINT `company_ibfk_1` FOREIGN KEY (`group_company_id`) REFERENCES `group_company` (`id`) ON DELETE CASCADE,
  CONSTRAINT `company_ibfk_2` FOREIGN KEY (`local_cur_id`) REFERENCES `currency` (`currency_id`),
  CONSTRAINT `company_ibfk_3` FOREIGN KEY (`home_cur_id`) REFERENCES `currency` (`currency_id`),
  CONSTRAINT `company_ibfk_4` FOREIGN KEY (`reporting_cur_id`) REFERENCES `currency` (`currency_id`),
  CONSTRAINT `company_ibfk_5` FOREIGN KEY (`default_tax_code_id`) REFERENCES `default_tax_config` (`header_id`) ON DELETE SET NULL,
  CONSTRAINT `company_ibfk_6` FOREIGN KEY (`default_account_header_id`) REFERENCES `fin`.`default_account_headers` (`header_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3003 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (3001,2001,'Opera Trade & Logistics Ltd.','Global distribution and supply chain solutions.',31,31,31,51,2000,'2025-03-04 13:47:40','2025-03-04 14:06:39',0,0),(3002,2001,'Opera Legal Solutions Ltd.','Legal advisory and compliance services.',31,30,30,51,NULL,'2025-03-04 13:48:12','2025-03-04 13:48:12',0,0);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_tax_codes`
--

DROP TABLE IF EXISTS `company_tax_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_tax_codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `default_sales_tax_id` int DEFAULT NULL,
  `default_purchase_tax_id` int DEFAULT NULL,
  `default_excise_duty_id` int DEFAULT NULL,
  `default_customs_duty_id` int DEFAULT NULL,
  `default_income_tax_id` int DEFAULT NULL,
  `default_property_tax_id` int DEFAULT NULL,
  `default_corporate_tax_id` int DEFAULT NULL,
  `default_local_tax_id` int DEFAULT NULL,
  `default_environmental_tax_id` int DEFAULT NULL,
  `default_vat_id` int DEFAULT NULL,
  `default_gst_id` int DEFAULT NULL,
  `default_service_tax_id` int DEFAULT NULL,
  `default_excise_tax_id` int DEFAULT NULL,
  `default_other_tax_id` int DEFAULT NULL,
  `default_extra_tax1_id` int DEFAULT NULL,
  `default_extra_tax2_id` int DEFAULT NULL,
  `default_extra_tax3_id` int DEFAULT NULL,
  `default_extra_tax4_id` int DEFAULT NULL,
  `default_extra_tax5_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `default_sales_tax_id` (`default_sales_tax_id`),
  KEY `default_purchase_tax_id` (`default_purchase_tax_id`),
  KEY `default_excise_duty_id` (`default_excise_duty_id`),
  KEY `default_customs_duty_id` (`default_customs_duty_id`),
  KEY `default_income_tax_id` (`default_income_tax_id`),
  KEY `default_property_tax_id` (`default_property_tax_id`),
  KEY `default_corporate_tax_id` (`default_corporate_tax_id`),
  KEY `default_local_tax_id` (`default_local_tax_id`),
  KEY `default_environmental_tax_id` (`default_environmental_tax_id`),
  KEY `default_vat_id` (`default_vat_id`),
  KEY `default_gst_id` (`default_gst_id`),
  KEY `default_service_tax_id` (`default_service_tax_id`),
  KEY `default_excise_tax_id` (`default_excise_tax_id`),
  KEY `default_other_tax_id` (`default_other_tax_id`),
  KEY `default_extra_tax1_id` (`default_extra_tax1_id`),
  KEY `default_extra_tax2_id` (`default_extra_tax2_id`),
  KEY `default_extra_tax3_id` (`default_extra_tax3_id`),
  KEY `default_extra_tax4_id` (`default_extra_tax4_id`),
  KEY `default_extra_tax5_id` (`default_extra_tax5_id`),
  CONSTRAINT `company_tax_codes_ibfk_1` FOREIGN KEY (`default_sales_tax_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_10` FOREIGN KEY (`default_vat_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_11` FOREIGN KEY (`default_gst_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_12` FOREIGN KEY (`default_service_tax_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_13` FOREIGN KEY (`default_excise_tax_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_14` FOREIGN KEY (`default_other_tax_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_15` FOREIGN KEY (`default_extra_tax1_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_16` FOREIGN KEY (`default_extra_tax2_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_17` FOREIGN KEY (`default_extra_tax3_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_18` FOREIGN KEY (`default_extra_tax4_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_19` FOREIGN KEY (`default_extra_tax5_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_2` FOREIGN KEY (`default_purchase_tax_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_3` FOREIGN KEY (`default_excise_duty_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_4` FOREIGN KEY (`default_customs_duty_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_5` FOREIGN KEY (`default_income_tax_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_6` FOREIGN KEY (`default_property_tax_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_7` FOREIGN KEY (`default_corporate_tax_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_8` FOREIGN KEY (`default_local_tax_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL,
  CONSTRAINT `company_tax_codes_ibfk_9` FOREIGN KEY (`default_environmental_tax_id`) REFERENCES `tax` (`tax_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_tax_codes`
--

LOCK TABLES `company_tax_codes` WRITE;
/*!40000 ALTER TABLE `company_tax_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_tax_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency` (
  `currency_id` int NOT NULL AUTO_INCREMENT,
  `currencycode` char(3) NOT NULL,
  `currencyname` varchar(100) NOT NULL,
  `currencysymbol` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`currency_id`),
  UNIQUE KEY `currencycode` (`currencycode`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (30,'USD','United States Dollar','$','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(31,'EUR','Euro','â‚¬','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(32,'GBP','British Pound','Â£','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(33,'AUD','Australian Dollar','A$','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(34,'CAD','Canadian Dollar','CA$','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(35,'JPY','Japanese Yen','Â¥','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(36,'CNY','Chinese Yuan','Â¥','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(37,'CHF','Swiss Franc','CHF','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(38,'SEK','Swedish Krona','kr','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(39,'NZD','New Zealand Dollar','NZ$','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(40,'MXN','Mexican Peso','MX$','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(41,'BRL','Brazilian Real','R$','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(42,'ZAR','South African Rand','R','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(43,'SAR','Saudi Riyal','Ø±.Ø³','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(44,'RUB','Russian Ruble','â‚½','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(45,'INR','Indian Rupee','â‚¹','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(46,'KRW','South Korean Won','â‚©','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(47,'SGD','Singapore Dollar','S$','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1),(48,'HKD','Hong Kong Dollar','HK$','2025-03-04 11:54:39','2025-03-04 11:54:39',1,1);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_tax_codes`
--

DROP TABLE IF EXISTS `default_tax_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `default_tax_codes` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `header_id` int NOT NULL,
  `tax_id` int NOT NULL,
  `tax_type` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `header_id` (`header_id`,`tax_type`),
  KEY `tax_id` (`tax_id`),
  CONSTRAINT `default_tax_codes_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `default_tax_config` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `default_tax_codes_ibfk_2` FOREIGN KEY (`tax_id`) REFERENCES `tax` (`tax_id`)
) ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_tax_codes`
--

LOCK TABLES `default_tax_codes` WRITE;
/*!40000 ALTER TABLE `default_tax_codes` DISABLE KEYS */;
INSERT INTO `default_tax_codes` VALUES (500,51,204,'VAT','Fall back VAT code A consumption tax levied on the value added to goods and services','2025-03-04 12:26:49','2025-03-04 12:26:49'),(501,51,205,'GST','Fallback A multi-stage tax on goods and services sold for domestic consumption','2025-03-04 12:26:49','2025-03-04 12:26:49'),(502,51,206,'SALES_TAX','Fall back Sales tax A tax on the sale of goods and services, typically added at the point of sale.','2025-03-04 12:26:49','2025-03-04 12:26:49'),(503,51,207,'EXCISE_TAX','Fallback excise tax','2025-03-04 12:26:49','2025-03-04 12:26:49');
/*!40000 ALTER TABLE `default_tax_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_tax_config`
--

DROP TABLE IF EXISTS `default_tax_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `default_tax_config` (
  `header_id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`header_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_tax_config`
--

LOCK TABLES `default_tax_config` WRITE;
/*!40000 ALTER TABLE `default_tax_config` DISABLE KEYS */;
INSERT INTO `default_tax_config` VALUES (51,'DTAXHDR','2025-03-04 12:26:31','2025-03-04 12:26:31');
/*!40000 ALTER TABLE `default_tax_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `manager_id` int DEFAULT NULL,
  `description` text,
  `default_account_header_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `manager_id` (`manager_id`),
  KEY `default_account_header_id` (`default_account_header_id`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE CASCADE,
  CONSTRAINT `department_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `employee` (`empid`) ON DELETE SET NULL,
  CONSTRAINT `department_ibfk_3` FOREIGN KEY (`default_account_header_id`) REFERENCES `fin`.`default_account_headers` (`header_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=40006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (40001,3001,'Procurement Department',2003,'Responsible for sourcing raw materials, goods, and services needed for operations',2000,'2025-03-04 14:09:45','2025-03-04 14:12:10',0,0),(40002,3001,'Logistics & Distribution Department',2004,'Handles the transportation, warehousing, and delivery of goods',2000,'2025-03-04 14:10:09','2025-03-04 14:10:09',0,0),(40003,3001,' Inventory Management Department',2006,'Focuses on managing the flow of goods into and out of warehouses',2000,'2025-03-04 14:10:33','2025-03-04 14:10:33',0,0),(40004,3001,'Supply Chain Planning Department',2007,'Responsible for forecasting demand, planning production schedules, ',2000,'2025-03-04 14:11:07','2025-03-04 14:11:07',0,0),(40005,3001,'Demand Planning Department',2009,'Ensures that the supply chain operates in an environmentally responsible manner',2000,'2025-03-04 14:12:52','2025-03-04 14:12:52',0,0);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designations`
--

DROP TABLE IF EXISTS `designations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `designations` (
  `designation_id` int NOT NULL AUTO_INCREMENT,
  `designation_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `salary_range` varchar(50) DEFAULT NULL,
  `responsibilities` text,
  `qualifications` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`designation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designations`
--

LOCK TABLES `designations` WRITE;
/*!40000 ALTER TABLE `designations` DISABLE KEYS */;
INSERT INTO `designations` VALUES (106,'Chief Executive Officer','The highest-ranking executive in the organization, responsible for overall management and decision-making.','150000-300000','Oversees the overall operations, strategic planning, and decision-making processes of the organization.','MBA or equivalent, 10+ years of leadership experience.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(107,'Chief Operating Officer','Responsible for overseeing the organizationâ€™s day-to-day operations and ensuring the execution of business strategies.','120000-250000','Manages operational processes, implements strategic plans, and ensures alignment with organizational goals.','MBA or equivalent, 8+ years in operations management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(108,'Chief Financial Officer','Oversees the financial operations of the organization, ensuring financial health and strategic planning for growth.','130000-270000','Leads financial planning, budgeting, financial reporting, and investment decisions.','CFA or equivalent, 8+ years in finance management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(109,'Chief Technology Officer','Responsible for the technological direction of the organization, overseeing the IT department and systems.','120000-240000','Develops and implements technology strategies, oversees IT operations, and ensures innovation in the technology space.','B.Tech/M.Tech in Computer Science or equivalent, 8+ years in IT leadership.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(110,'Chief Human Resources Officer','Responsible for the overall human resources strategy, including recruitment, employee relations, and organizational development.','110000-220000','Leads HR initiatives, ensures alignment with business objectives, and fosters a positive organizational culture.','MBA in HR or equivalent, 8+ years in HR leadership.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(111,'General Manager','Manages a specific department or function within the organization, ensuring smooth operation and performance.','80000-180000','Coordinates teams, oversees daily operations, and ensures departmental goals are met.','Bachelorâ€™s degree in relevant field, 5+ years of managerial experience.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(112,'Operations Manager','Responsible for managing and overseeing the daily operations of the organization or a specific department.','70000-160000','Supervises operations, optimizes workflows, manages team performance, and ensures operational efficiency.','Bachelorâ€™s degree, 5+ years of experience in operations management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(113,'Finance Manager','Oversees financial planning, budgeting, reporting, and internal controls within the organization.','80000-170000','Manages financial records, prepares reports, and ensures compliance with financial regulations.','Degree in Finance or Accounting, 5+ years in finance management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(114,'Senior Accountant','Responsible for the organizationâ€™s financial recordkeeping, reporting, and compliance.','60000-120000','Prepares financial statements, audits, tax reports, and ensures compliance with accounting standards.','Bachelorâ€™s degree in Accounting, 3+ years of accounting experience.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(115,'Accounts Executive','Handles the day-to-day financial transactions, recordkeeping, and administrative financial tasks.','40000-80000','Manages accounts payable/receivable, processes transactions, and maintains financial records.','Bachelorâ€™s degree in Accounting or Finance, 1-2 years of experience.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(116,'Payroll Specialist','Responsible for processing payroll for all employees and ensuring compliance with payroll regulations.','50000-90000','Processes payroll, manages deductions, and ensures timely payments to employees.','Degree in Finance or Accounting, 2+ years in payroll management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(117,'Internal Auditor','Responsible for conducting internal audits to ensure compliance and effectiveness of financial operations.','60000-110000','Reviews financial records, ensures compliance with regulations, and reports on audit findings.','CPA or equivalent, 3+ years of auditing experience.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(118,'HR Manager','Oversees all HR activities, including recruitment, employee relations, and benefits management.','70000-150000','Manages HR processes, ensures compliance, and fosters employee engagement and development.','Bachelorâ€™s degree in HR, 5+ years in HR management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(119,'Recruitment Specialist','Focuses on sourcing, interviewing, and hiring candidates for various roles in the organization.','50000-100000','Manages recruitment processes, conducts interviews, and maintains candidate pipelines.','Degree in HR or related field, 2+ years in recruitment.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(120,'Training & Development Manager','Responsible for designing and implementing employee training programs for skill development and career growth.','60000-120000','Identifies training needs, develops programs, and ensures employee skill development.','Bachelorâ€™s degree in HR or related field, 5+ years in training and development.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(121,'Compensation & Benefits Analyst','Manages employee compensation, benefits, and rewards programs to ensure competitive and fair offerings.','50000-100000','Administers compensation and benefits programs, ensures market competitiveness, and provides guidance on compensation policies.','Degree in HR or Business, 2+ years in compensation analysis.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(122,'HR Executive','Handles various HR tasks, including employee administration, records, and HR policy compliance.','40000-80000','Manages HR records, assists in recruitment, and ensures HR policies are followed.','Bachelorâ€™s degree in HR or related field, 1+ years in HR.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(123,'Sales Manager','Leads the sales department, develops sales strategies, and manages client relationships.','90000-180000','Sets sales targets, develops strategies, and leads the sales team to meet organizational goals.','Bachelorâ€™s degree in Business or Marketing, 5+ years in sales management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(124,'Business Development Manager','Responsible for identifying business opportunities, expanding the customer base, and driving revenue growth.','80000-170000','Identifies new markets, develops business strategies, and builds relationships with potential clients.','Bachelorâ€™s degree in Business, 5+ years in business development.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(125,'Key Account Manager','Manages relationships with key clients and ensures their satisfaction with products and services.','70000-160000','Develops long-term relationships with key clients, resolves issues, and ensures repeat business.','Bachelorâ€™s degree in Business, 4+ years in account management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(126,'Marketing Manager','Oversees the marketing department, developing strategies to promote the company and its products or services.','80000-170000','Develops marketing strategies, oversees campaigns, and tracks performance to meet business objectives.','Bachelorâ€™s degree in Marketing, 5+ years in marketing management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(127,'Digital Marketing Specialist','Specializes in online marketing strategies, including social media, SEO, and online advertisements.','50000-100000','Develops and implements digital marketing campaigns, optimizes web content, and analyzes performance metrics.','Bachelorâ€™s degree in Marketing, 2+ years in digital marketing.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(128,'Customer Relationship Manager','Builds and maintains relationships with customers to ensure satisfaction and retention.','60000-130000','Communicates with customers, resolves issues, and ensures their needs are met in a timely manner.','Bachelorâ€™s degree in Business or related field, 3+ years in customer service.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(129,'Procurement Manager','Responsible for sourcing and managing suppliers and purchasing goods and services for the organization.','80000-170000','Identifies suppliers, negotiates contracts, and ensures timely procurement of goods and services.','Bachelorâ€™s degree in Supply Chain or Business, 5+ years in procurement management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(130,'Supply Chain Manager','Oversees and optimizes the organizationâ€™s supply chain processes from procurement to delivery.','90000-180000','Manages supply chain processes, improves efficiency, and ensures timely product delivery.','Bachelorâ€™s degree in Supply Chain or Logistics, 5+ years in supply chain management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(131,'Logistics Coordinator','Manages the transportation and distribution of goods to ensure timely delivery.','50000-100000','Coordinates logistics, tracks shipments, and manages relationships with carriers and suppliers.','Bachelorâ€™s degree in Logistics or Supply Chain, 2+ years in logistics.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(132,'Warehouse Supervisor','Manages the storage, handling, and distribution of goods within a warehouse environment.','45000-90000','Supervises warehouse operations, ensures inventory accuracy, and maintains a safe working environment.','Bachelorâ€™s degree in Logistics, 3+ years in warehouse management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(133,'Inventory Control Specialist','Responsible for managing inventory levels and ensuring accurate stock records.','40000-85000','Monitors inventory levels, performs stock audits, and manages inventory records.','Bachelorâ€™s degree in Logistics or related field, 2+ years in inventory control.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(134,'ERP Manager','Oversees ERP systems implementation, management, and maintenance to ensure the organizationâ€™s processes are streamlined.','90000-190000','Manages ERP system, identifies improvement opportunities, and ensures data integrity.','Bachelorâ€™s degree in IT or related field, 5+ years in ERP management.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(135,'ERP Consultant','Works with organizations to implement and optimize ERP systems for improved operations.','80000-180000','Advises on ERP system implementation, customizations, and troubleshooting.','Bachelorâ€™s degree in IT, 3+ years in ERP consulting.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(136,'Database Administrator','Manages databases to ensure data availability, security, and integrity for the organization.','80000-160000','Monitors and optimizes databases, ensures data security, and performs backups and recovery operations.','Degree in IT or related field, 4+ years as a DBA.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(137,'System Analyst','Analyzes and improves the organizationâ€™s IT systems to ensure efficiency and productivity.','70000-150000','Works with stakeholders to analyze business requirements and designs IT solutions.','Bachelorâ€™s degree in Computer Science or related field, 3+ years as a system analyst.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(138,'IT Support Engineer','Provides technical support to end-users and resolves IT-related issues in the organization.','50000-100000','Troubleshoots hardware and software issues, provides user training, and maintains IT infrastructure.','Bachelorâ€™s degree in IT or related field, 2+ years in IT support.','2025-03-04 10:35:41','2025-03-04 10:35:41',1,1),(139,'Production Manager','Oversees the production process, ensures product quality, and manages production teams.','80000-170000','Plans and coordinates production schedules, ensures quality control, and resolves production issues.','Bachelorâ€™s degree in Engineering or relevant field, 5+ years in production management.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(140,'Quality Control Manager','Responsible for ensuring that products meet quality standards and comply with regulations.','70000-150000','Monitors production quality, manages quality control teams, and implements quality improvement initiatives.','Bachelorâ€™s degree in Quality Management, Engineering, or related field, 5+ years in quality control.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(141,'Maintenance Engineer','Responsible for maintaining and repairing machinery and equipment in production areas.','60000-130000','Monitors equipment health, performs maintenance tasks, and ensures equipment reliability.','Bachelorâ€™s degree in Mechanical Engineering or related field, 3+ years in maintenance engineering.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(142,'Process Engineer','Improves manufacturing processes to enhance efficiency, reduce waste, and optimize performance.','70000-140000','Analyzes and improves production processes, designs and implements process improvements, and reduces costs.','Bachelorâ€™s degree in Engineering, 3+ years in process engineering.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(143,'Safety Officer','Responsible for ensuring that all safety regulations and practices are followed in the workplace.','50000-110000','Monitors safety practices, conducts safety training, and ensures compliance with safety standards and regulations.','Bachelorâ€™s degree in Safety Management or relevant field, 3+ years in safety roles.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(144,'Customer Support Executive','Handles customer inquiries, resolves issues, and ensures customer satisfaction.','40000-80000','Responds to customer queries, provides solutions, and maintains positive customer relations.','Bachelorâ€™s degree in Business or related field, 1+ years in customer service.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(145,'Service Coordinator','Coordinates the delivery of services to clients, ensuring that projects and tasks are completed on time.','50000-100000','Manages client service requests, schedules appointments, and ensures service delivery is on time.','Bachelorâ€™s degree in Business or related field, 2+ years in service coordination.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(146,'Technical Support Engineer','Provides technical assistance and troubleshooting support to customers and employees.','50000-110000','Assists with technical issues, troubleshoots hardware/software problems, and provides user support.','Bachelorâ€™s degree in IT or related field, 2+ years in technical support.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(147,'Helpdesk Analyst','Provides helpdesk support, resolving IT-related issues for internal users and clients.','45000-90000','Assists users with IT issues, resolves hardware/software problems, and provides training on IT systems.','Degree in IT or related field, 1+ years in helpdesk support.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(148,'Procurement Officer','Handles the procurement process, ensuring timely and cost-effective purchase of goods and services.','50000-100000','Identifies suppliers, manages purchase orders, and negotiates contracts for the organizationâ€™s needs.','Bachelorâ€™s degree in Business, Supply Chain, or related field, 2+ years in procurement.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(149,'Supply Chain Analyst','Analyzes and optimizes supply chain processes to ensure efficiency and cost-effectiveness.','60000-120000','Monitors supply chain performance, identifies inefficiencies, and recommends improvements to reduce costs and improve service delivery.','Bachelorâ€™s degree in Supply Chain or Logistics, 2+ years in supply chain analysis.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(150,'Logistics Manager','Manages the logistics operations including transportation, warehousing, and distribution of goods.','80000-170000','Oversees logistics strategies, manages transportation and distribution teams, and optimizes supply chain operations.','Bachelorâ€™s degree in Logistics or related field, 5+ years in logistics management.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(151,'Warehouse Manager','Oversees the management of warehouses, ensuring efficient storage and handling of goods.','70000-150000','Supervises warehouse operations, maintains inventory control, and ensures the timely delivery of goods.','Bachelorâ€™s degree in Logistics or related field, 4+ years in warehouse management.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(152,'Inventory Manager','Responsible for managing inventory levels, ensuring accurate stock records, and optimizing inventory processes.','60000-130000','Oversees inventory control, manages stock levels, and coordinates with procurement and sales teams.','Bachelorâ€™s degree in Logistics or Business, 3+ years in inventory management.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(153,'ERP Consultant','Consults with clients on ERP implementation and optimization to improve business processes.','80000-160000','Analyzes business needs, recommends ERP solutions, and assists in system implementation and optimization.','Bachelorâ€™s degree in IT or related field, 4+ years in ERP consulting.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(154,'Database Administrator','Manages and maintains databases to ensure data integrity, availability, and security.','70000-150000','Monitors and optimizes database performance, ensures data security, and backs up critical data.','Bachelorâ€™s degree in Computer Science or related field, 3+ years in database management.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(155,'System Administrator','Maintains IT systems, including servers and networks, to ensure the organizationâ€™s technology infrastructure runs smoothly.','70000-140000','Manages IT systems, performs regular updates, and ensures the security and reliability of the network and servers.','Bachelorâ€™s degree in IT or related field, 3+ years in system administration.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(156,'IT Support Technician','Provides technical support and troubleshooting services to end-users in the organization.','40000-80000','Responds to IT issues, diagnoses problems, and provides solutions to ensure business continuity.','Bachelorâ€™s degree in IT or related field, 1+ years in IT support.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(157,'Network Engineer','Designs, implements, and maintains network infrastructure for the organization.','80000-160000','Plans and builds network systems, ensures network security, and troubleshoots network-related issues.','Bachelorâ€™s degree in Computer Science, Engineering, or related field, 3+ years in networking.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1),(158,'Security Analyst','Responsible for protecting the organizationâ€™s data and systems from security breaches and cyber threats.','80000-170000','Monitors security systems, analyzes potential threats, and implements security protocols to safeguard data.','Bachelorâ€™s degree in Cybersecurity or related field, 3+ years in security analysis.','2025-03-04 10:36:37','2025-03-04 10:36:37',1,1);
/*!40000 ALTER TABLE `designations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `empid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  `supervisor_id` int DEFAULT NULL,
  `pic` blob,
  `salary` decimal(9,3) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `doj` date DEFAULT NULL,
  `resignation_date` date DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `designation_id` int DEFAULT NULL,
  PRIMARY KEY (`empid`),
  KEY `designation_id` (`designation_id`),
  KEY `manager_id` (`manager_id`),
  KEY `supervisor_id` (`supervisor_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`designation_id`) REFERENCES `designations` (`designation_id`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `employee` (`empid`),
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`supervisor_id`) REFERENCES `employee` (`empid`)
) ENGINE=InnoDB AUTO_INCREMENT=2013 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (2002,'John Smith',NULL,NULL,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0„\0		\n\n	\r\r\r \"\" $(4,$&1\'-=-157:::#+?D?8C49:7\n\n\n\r\r\Z\Z7%%77777777777777777777777777777777777777777777777777ÿÀ\0\0±\0½\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0N\0	\0\0\0\0\0!A1Qa\"q‘2BRbr‚¡±#$36CDSs’²³Á4tu¢\Â\á\ğ5Tƒ”£\Ã\Ñ\Óÿ\Ä\0\Z\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0(\0\0\0\0\0\0\0\01!AQ\"2Á\ğ±Ba‘ÿ\Ú\0\0\0?\0\Ş(ˆ€\"\"\n,m§\Ö\÷vH1%U5<\ğŸ…˜@ù.ÿ\0˜\áV5½¾G\â\'\ËWls¥1°e\ÓBG\İX<q\ç\ğš\ÕK]\ìkK\Z\÷GLr\ã$È›\É\òih\îM\â)¤\Ù1\ÇdO\Ã]\è\0\ìq=\Ì\\×ºW\Ö\Ùnpœ\É=<±3=›‹H\0ú\Ê\æš\ãCÀ²zZ˜¹qF\æıE¥u¬s\Ê\êW\Ò\Ô<ºªıD®wl˜cşsKO§#’øTä¢š\î\÷ş?\ìÑ¥\å|œÔ¦¸GKt§¬|-|3‡†¸g\í\Çx\ì\à¬4\×F8PZ\ÂÑ\Ä\á¿\äªv?½ä®¶n²,şŠ_9¾€^Ï˜¥\\\Ğæ–¸\ÓÀ‚;B³‹>o¥\Üƒ\ÃÄ´\îYT{MÚº\İayÃª]@ùb,y%\ò²70~`3…r¥©Š®–\Zšw‡\Ã3#9´Œƒ\ì_g«·\r”ø{:(J=œèˆ­ˆ€\"\"\0ˆˆ\" ˆ€\"\"\0ˆˆach_H€ ¾¦¯k\äm•Ò¹\öù1\æ\Å!Ë\ô\Îg¥\Í\ä3\õQİ¡®…¤²f\nj–\á’\ÇúœH\ôIJ_\\¾1d\òzŠ\ÕÁW+ ;\ç1œ\ã\æ8¸5Å¾~\Ğ‡\ê†\Ó\Ö\ÕZ¶\\^[K,”Ó½,qÜ»F.\Õ\ò\ß\Ê\è8\å\õ0ÿ\0—k\óû\î]Á>Kƒ>n\òK¥\È\Õÿ\0E¨\å\æ<®?%\àz\ÜT°_N€=…hsKKHwƒ\Ú‚\ÏVV,\ô\ö\'§(µ\îC[%\r¶V\ÖË´1\óT\Êr&CO µ úÕ‹C\Äøte)k\Ûn€8GcUcV\Â\æi¹(i\ZÀj\İm\âÁ¶G‘\Í\Üx\öv+N—ºT]-¯¦Š\ZF\Ç+¡ŒC9•k84–4\ã \ÎY\â0W\Ó\rŠP\õ%%Vúÿ\0E—\å/‚q\éX\"\"\0ˆˆ\" ˆ€\"\"\0ˆˆ\" ˆ€\è]â¤š\ÕW\È\"0¿¯\ÜH˜;y`-e§/Ô–j\Ë\å=úº:Y|©²2J¡Ô¾¡¦&3¬\Ø@w¯$c$r[^x#¨‚X\'h|R´±\ìwcšF\ö-Ò¾†¼\Ü5¤·	Mº¶¹¢9\Æ<“®w\İA\'\Í\á\ÉqÉO²p•;FÄ¶\êK-\ĞJh.Ô“uM\İ l ·™9\å\â±q\Ô\Ö;dŒ¾\íIhpk¥\à\ö•@t}We¥­¸\İ\Û¯–™\ÑSS‡5\Æ<\Ò{7\0\ñ_\'ty[w¸ı¸°6)d•¡µ\áÁ…\Î77<Ñxs\Ï\n–>ue®s\ãtO\êKµ%\ò¦\ÉMf­š‰&j0et¶2\Ç?\r‡´m\áÛƒØ¶}T\ğ\Ğ\Ó\ÇB\Ö6™‘µ°¶?r\0<0´?Gz6\õl¬¼G%U=Q¢dnvÎ°³¬\Üv\î\0{†“Œ\ğ#\í[ŸL^£»RI…´µ´nURv\õ.\Çw°-w1\è*\Ö5ºE|œŸ\Ô\É\ÄD]\ÎAD@\0DDD@\0DDSW4CzÓ•|<\é\æ¥qø¯…\Ïıèš­jT\Ú\'¼PC$\ñÁSOSDO’2\ö\å\Î‘\Û\ÍFj\â\Ñ(º•g±²0±\íi‘GˆH\Ø#kZÆ†µ£\0€®A>¨–\ãr¢\ò«8u­ˆ¿\É%\Ã\÷F\Ç\ç\ğœ1¿¥\Ú\êµOüe›ş_ş‹.X\Út\Ë\êi«CM\æY¯§ó‹Œaø±5°ılr\ç¹RT²ª+½­*v\í\Ú\óµµ\çŒO<¸\äƒ\ïO \òX\èlµAFù’4I n\Ş\ç9\Ş\×\ßN|gh\÷‡(\Ó$¬—ŠkÕº:\ÚM\Ík²\×\Ç \Úø\ÇNşaHej.’tı\Òz\îšj²¶–«\ÕT\ô\Ó9‚­ cv\ZF\\´p\íÀ:\Ü+Ä½o–T\õ¿®v}¹ZX\ò)«E	ÁÅ\Õ\'\ŞÕ•\ä«\'Izº\Ì\æ\õ‰\çŒ1Õ¹§\Ã\Î\â=D-ƒC\ÓüÍ¤p¸X%X\Æ\ÓAc\ßÀ‚G´®„\ræ€¯<\Ö\ô\õ~‘ÿ\0x\Û-°3º]\òh-ú–(zx\Ô†¶\ßm–\r\Ã{cc\Ø\ìg	qD\"\êZ\î\÷[u=}‚Jjˆ\Û$n\ïùø.\Ú\0ˆˆ\" ˆ€\"(½Kz‡OiúÛ½H–\"ı¹\Æ\÷v5¹\å’@\õ %h\nŸ®®Ş¶:&7ºI^\ó\ôav\è~\È	†\Ñp\Ó\ñ»=®‚¤ ´ıh\r\İ=Dt\ĞI5DŒ(š\\ù\àÖ´\ÒO!Ái½gÓ„0>JM)L\É\Ü\re@!‡\ä7>“AT®“:Lª\Ö]o£µ7t%\Ãt\Ï\ï€=ƒ\Ã\'–5\æ\âNP‚\è†\í[}µ\İnWIºú¹\ë³$›Csˆ\ãh\à\0_Ğ\ë\êm+M5}¯¦š^·®ˆù\Ì8Ü\ÑÃ½m\Ûvµ\Ó7S^iqÀd\ÒuN\ö;f\ìc“›i°\ä\Z\'\ñ\Ã¢ju=‚‘»ª/V\ö|_*aw°ª…û¥\ë\ÛDr\Üf\÷®\ÚbŒzIú1\â¹G\å\Ò:<‘^\å¿Sß©tİš{•[‡\Ü\ÆØ£\'Y=\ëG§\êâ¼·SQ%MD•d‘\Å\î c$•)©µ=\×SW\n»¤û‹A\ÄÁ†F&\æx•\n´p\â\ô\ÑK.Nl,\î\ô„]Fr™Á\ÈXDıûµ\êm\Õ\Ö	\Ü\\)_O\Ğ\Ç8\0\î?9ne\æN€\êD Gq\å4²\Ä\0ÿ\0\ğ/L\î9\Ç\Ò\" ˆ€\"\"\0´\÷\Ùzu5–\İf‰\ä\Z\ÉL²ü†c\0\â\â\Í[…y¯ì„©3k\È\â\'-‚†6\ã».s¿šXç¿Šd¬\";r°ˆ€\Î\ãÀ\ó	’°ˆ\ä¬\î\ğ\åD@7QšwLC\\\ZGvG¨¯jÁÂ¾±\Ã8]ŠJ\ë$,»±\Å\Î\ìkGy<‚\ì¾Jj¶‘\ÂyÁ\ó§#\ro\É\ë+\Úù>™¼\Õ\é[üZhX\êšf¿cfoœ\Ç3ˆ}\Õé‹ş\Ø\Õi\n{\ê¢I\ë\î.uK\ŞşM\'\0»@88\õ\çV½\İ\è*n­§{( ‰Òºyxu£$0v¸\ğ>1•\ë;l4\ô\ö\êX(€\ÑB\ÆD``\0¡B×š=¦»;hˆ½<ˆ€\"\"U^e°\Ø\ên±\Ò\Z¶Ò$°µ\Û]\Õ\ç\Ï \÷“x^_\é&ıM©\õ}]Ú²ŠiYX$n\ÜF\ĞAù\Ê\õU,5T\Ò\ÓNÀøfa\í=i#\é^9¿[§°_«­\Ò\ÖRL\èÃˆ\÷MÁ\Çq}h¬q\Âû3#¶±¤»\ğ\ğ]\ÖUSJv\ÖR4Ÿ\Ò@\íşc\èR6š:\'\Ö\Å%{wgL\í\Úã‘Œ\Ä\ÅMF\Ù\ãtWQ}9›Ik¸p¾TB\" ˆ€\"\"*z\ÛB\ÊJ9\ê.ÙŠšh\ö²1\î\ä9]¥@)7\\\ÅE;\"¯„\Ìè›¶)C\ö¹­\î= Rœ\Z]2F\é©&m²\Å@\ñ\09\êb\÷-ø\Ò8ıem]\ÑE¶\ÖS~,¸U‘–Ã¸0ú»\õ\ğ\ğST\Ñ\Ô\èš#E0½™Š¥±\03#xdã´–\à\ç\Å[\ÎhÏ¥glmI·\æ,¤\Ù\ÃSG,@a‰\Í-1©w´S\İ&Œ°\È\÷ns­´\î\'¼\õmQW\Éü–\Ëp©ı\r,’s\ÃIşJcI:Ÿı—´Š)”Í£‰Œp\î\r\Ôxvw©jt\È\ì/(˜DEp¬\0DD#YPQKª¬rV\Ñ\Ó\Ï\rT54¯\Æ°\ÉœøD\ñ\ëWu\\\×ù\ê\í1UQ±\ÒU[ªc¬Š62\ğ{}&7<&®,\ö=•\Ú\Í¥k&±Ò·\õ \Åû„(J¾‰4\ÔÅ¯¦u}\ÚrS\î\Ş«\Ô\ÅQS\Ã#_¬lŒ{O5\Ã W Y®Hº³GÓ„•\Ñ\åı®¦\Ïw«·Ö‚&‚B\Òy8rp\ğ#Š[\Ç_\è‰\õeu\âº\ÛÆ¾\İ;c€vL\Ò\×9\Ã\å`·ŒsZI\ñ:9\É˜\æ’\\0AŠÔ„¹E3>K‹h\âDE\"!D@s\İÁag {\ÏW[p³LNÉ™\×\Ã\Ü\Ş’\Üzš·:Òi\Ç\Ñiùu¬­s]IW‡‰üvN\ïµ\ç\ö\n\İx=Ş•µ\Zše\İy\\há«§T\ï\Ã1¼€\ày·<G³+«b”\Ù\õ–\Òv\Ñ]K\ê)š{#¨2°x8y\àw‰‚†\Õ\'«·CX\ß\ÃQ\×SM\îû«ZG­®{~r†2H–h\\l¾\"\"\Ô(D@…}¹Gg³\ÕÜ§\í§ˆ¿c{d<š<IÀ• ªš\Ñ\ŞQ[cµv²z£S+G8\á¿ˆb\ö(\É\ñM\Å[H\ë\éú)­\öZjZ§Nù°85\îqsšßŠˆÀ\0¤S‘\ñE‘)[³M*Tu\ôx\ßuÔ²ù\ìQƒè¦„Ÿ¥\Ê_\ô[j\ÕR¾¾•\æ\ßs8\İ3¹’ü¶\÷üa\ëÊ›\Ñ\r\ã~~R\êÿ\0¢(™ş=sœR[j\ê\\p!…\òdø­h}¨ÍŸ\Ü\Ï\ËW+Ù¸;k‹wx\\k9XS\"\0DDHX\í5»\Å%²Œ=T­¼;3\ÚO€\'À.€\Ío±ûI!›S\×DC\æ\Z0\á\ï=\óıg\Í‡r(\r§O`¢¦\Ó\r\Ó\ñ3\"”\Ó\ğš[‚O‰\É>’ 4\ÅL\ÕV\ZGTŸ¾ca‚£\õ±’\Çÿ\0y¥]•*’?#\Ô\×\Ëc_$u\ğ‹(\Ú\ïû‘¼ü\åWj7ø;\à•H“Q7\æyT¶›h\÷UW(sƒ\ë\êû–=aK.…<¯\\C\Ã,·\Û\ß)g´ş\ÌO\öªšñ¼ˆ³™\Ô’\"-S<\"\"\0ˆˆ¨^\òuÍ¼;•®£owa\Ï\Ô½U5\Ë)µ\Ş\ÆqCS\Õ\Î{ —\Ìq>\İ[ƒ<ª\à\Ñ<m)+;„;Gz\ÈY‰Å \ëMl§\ß\İ+=‚w´}K“¤)ü›B\ß\ä\Ï\æ44¬¯8\éx\İúJ\Ê\Çûje*3¦Y\\Ş®\ğ’fª|PDÁ\Ú\âdi#\öC–\ÔW„‘™\'\å³\Ê\Ë\í\Í\ÚHp E|©DE\àŠJ\Åe¬¿])\í¶ØŒ•3œ4rh\æ\çM¤ \':6\Ñ\Ó\ëC.\×6†IY(\å™\÷ ü\'q\Öx\à¯W\Ò\ÒÁGK-4MŠ˜#6Œ´\0=AA\è+I¤l0\Ûh\ğù}\İD\ä`\Í\'3\è\äpV$\n¨\ê6Š}af¨\ÆU5E+{šY#~†\É\íV\åW\×-\Ù°şmt‡8\î“t?ùG±sÈ®\r\Æ\êIœË¯£\×V\ß\î\'\òµ¾N\Ç|HX\ZGªC/µs\È\á\÷û–‚I°³\Ñüeº6\×+\Ü•Pù\\‡\ã\ÌLú^UMHùlµ³/	4DW\ÊaD@^ºŠ\nú)\è\ê\Ù\ÖA<nFŸ|\Ò0Wam=4\â[m{‹\ë­\Ò\Zi\Ü(\0\Ë$ù\Ì\Ú}9\îR\Ù]-a	µ\ÖÁ¨\âi\ê£ã·œù²Õ¸\ç\ä¹\İË¹œ\ãA\æ>…™Ÿ	Zè¿†|‘\ó\Ñ\ï\r4\Î:\ê\ÆTÊª\'\ÜE]\î‚\×·6…¦ªp9H\á¶1\é\Úd>°y«F„sYGu§\rÚ§w†\÷\õƒ\èxZÂ¢:ˆ/h«ß¾µ•²\õ\îød\Í#À°³\á\ÉljENH\Í\ÎøÅ•}O¦\\\ãY@\Ğ*;_\ì“\Ñ\â¨2D\è¤tr5\ìx8-pÁ¸…¹~®\åu²P\İ[\÷\Ôg¬\å+=|ıj\æmn_TJØ³×‰\Z0­\ÕZ\Z©®ûÒª9\İ -?FrºmÑ—}øs!c~”c\Ù\Û\ô*ş+$~H‹m¶®\ë_\rºJŠ©İ²8\Ù\ÚOş¼y/O\ôe ©´]¹Ï—l\×Z†(œv4||Q\ßÌŒ\÷ª¬q\éin´›¤¨¤K<˜ü,XÄŒ»i8\ñ\Çr\ô</d\ÑG,/d€9®š†Ln\rXŒÔ®\\x•”Ef²š*k¥\æ²\İÎºG›œ‘\ÒC\åN,E¶F´F\Ü4‘œùÀ“·µlå®«´-S©+\êë®\õ1IQYB#‹ki\æ{úÀ\÷Iv0\Èm\ÈÂ„\â\ä¼2Qi?%‹ v=˜\ëı\Ö\Ğ\òyk\ì.\á\ö¾]\ôã¾\\¹Ÿ²w³\æY{¡ûUlª¸R\Èø\ë\Ú\×\Çbt®/,\Ş\Z\\O\×\Ä\ödKhkM}+®fGm{\Æ\Úv\0<,È‡278œ\ÅÊ®´eeŒ\í2ÖˆŠ\éT\"\"\0ˆˆ\" #\ïÿ\0\î+—\õItªÎ—üVµR‹\÷\"§·\Ò-k{Ÿ:;\ñ\ïVşª‡\÷ª:\×\ñ\î\óúŠ_\İz\Ê+ú=¢\×L‹DE´Œ\Ç\Ğ>\á‹\ê?p²ŠL’8\çşŒÿ\0\Õ\İ[sB~$\éÿ\0\ì\Ú\á5f\îv‹:\Ş\ä\ò\"*E «ú\ë\ñ3QfTÿ\0¢ *\ñ~6h\Ô\Ôÿ\0\0-‹ùOšˆ¹bûI\å\ìûDEÔ€DDÿ\Ù',0.000,NULL,'2017-01-02','2024-05-04',NULL,1,'2025-03-04 10:52:07','2025-03-04 10:52:07',0,0,106),(2003,'Sushil Kumar',2002,NULL,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0\n\n\n\r\rÿ\Û\0C		\r\rÿ\Â\0\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0	ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ú\0\0\0\0ú¤\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\00\æcÏ¸•m\ö—0ù>=\'·\à9”¸ÿ\0+\Ë\Ç\Ñ[\ÉŸtmÿ\09{G\è\å\Ş\éj\í\Â\Ğ\0\0\0\0\0\0\0\0\0\0\0\0\Ç\ó”\ën\é\ó–-/~ˆ„d\å\âs5š+¶/L\ÇE6k0²d9>F&N\ÃÙ˜úË·şo}Oj\÷Á¥@\0\0\0\0\0\0\0\0\07\äú^üK6\óµ\ë~N†:6Ç–#+\Ô\Ù\ÎÁŸTË´ˆ”Ì³1kÜŒ9C\Ç\É\Ö\í³zırı#\Ú8š… \0\0\0\0\0\0\0\0«\ìÿ\0-D\ñ,}X\Ü5™—‰½m\Ï\ÅÆ‰\ØP²Õ›“<Š{/.bD¾\ÌUn\ö.\'\Ül¯%„¢}‹DÜ—ÖŸI~w\õu>ºrn«h¸$\0\0\0\0\0\0\0\0Bø\í¿„©|mº²YZÕ‰uŞ¶\àÊ‹\nFr’›qp\Êù\ÎE\æ\Ã\Ø3¹oÎ¦u©¼ı:¾ÉŠ‰\åVú5É¯7\×û—8\Ó>{›\ÃN\î\à\éŸC|\Ö\á\öŸ¸lÎ•\0\0\0\0\0\0\0\00_\0ş|1Y\Ò d19h¯\å£l\ÅÓŸ‰\Å\æ°\ò3\Ó#\n\Şr¶•\Ò3;g£«\ç\öIùo…\÷=\å-¯c¶¨\Ô\íl1‘¬s~Á\Î\ô\Ë\æù\÷\æ{,mƒ¸£í“˜\×0\0\0\0\0\0\0\0>	û\×\â\Z\Ï7\Ç\å=\Îúµ:m2fıºyŞÉ»\Ñ;oÈº~r\ï?U)\ò©¦”U\åš+¥P®YLXs\"£ÎºN…¦>\Êcıo\Zv×®o·¯\Ú3-]\×0\0\0\0\0\0\0\0\ñO\Ú\ß&C™È£e\æ\é\É\æ³\ôùşK/\Ï3R\ß&h¹H¶\à\Âfs\ÙUwkkH¥¬İ‰i\ö¨“ûc\Õ;JÚ°¯\Äl˜\ß[\Å\÷³s¨oN4 \0\0\0\0\0\0\0oƒv\Ë\Ù\Ê\öˆY¬¯Ÿ\â=£\Ë\×\É\óİ‹-®|;5Ö¡\Öú\î\åfznq\ñè•Œ‘®MqÚ–\á~~Yk§×®\\c\ÎÉ©De\ç\ê{77_$\Æ\í\Ñ}.\÷\Ø\ß.ı9¶Yq¾\0\0\0\0\0\0\0\0vNC\æ{\Z\\\Ü\Î3+M‘¹ü\ÎFË’\ÛÑ \ôÎ®]w3:G¡wk\Ó6®}\î\ê.«1’\Îo‡(o\'\ÛÁ“\Î\ãq|}\ÛW\ìg}_+{b\êã¯¥\èÛ•7\İÇ¯\á\0\0\0\0\0\0\0\0®1\ŞxŸ\é\Ş\×\ó˜.ü½ø¹$Æ¯-\"4\Â\È\ÏÉ‰\Ã\ã\ö\\D#\ç\ñ:]¯\æ\ğ\ó½›˜½4úv;6®¥+c‰‰—\Ä\Îtmš\öÄšz2\í}\\’Ç§\ã€\0\0\0\0\0\0\0Ü¹7^«Š\É\ãü\ÏW5‘\Çd\"\Ù,”<¬tSr\ô:\Ú6\n\ÆFi&g™¶?µaL%¨ù$_#\Ô\Æ\àsø+ag3‡\Í#%\Ù\ô-\÷\Õ\ñC£œ\0\0\0\0\0\0\0\0iÛ·œ^Ø¾Gµ•ŸmmŸ\Éa²-¤\ë9\ÈT\×‡\Ï\ào–sh\çù)nú¤<2\'M×¶\Ê\é“\Ébg\Öş\árx›eˆ\Åe1\ó•œ\æ3lúşV\Í\ïg\Â@\0\0\0\0\0\0\0\0ÓŠ\ê\İw‘ù~¶ZU™<ı9)®Eı]«\çf«—-X\év%\ZÄºQ)\n¨¶^FF[J\Å\Î\Ç\Ê„(¥½—\Ùú¹eVz~H\0\0\0\0\0\0\0\0\0\Z\÷ú#€\ñwN½O¡•®<˜´}ga±x\ÒngëœVNG±¼+9\ó™4O{·\àÊ¶S \É\Ç\çz L\ÆÚ»‡Y\Ów/W\Ç\ôo€\0\0\0\0\0\0\0\0\0W\Õ1´¿\É`²?·”›Š\ÉRÔª®Ö‡NCÙ®59(^M¬…*çµ˜\ö¤Á…\ØtÆˆ¢ˆ\\\ïl~Ğ“\Çû¯â„€\0\0\0\0\0\0\0ª›V§\óW—\Òü»–\É:_Sù‹¶yşF\Êk¼ÿ\0Gd»Œœ´š}\òTU#\ÛD_oX=S\å&>2\ö\"kz\Ë\Ï\ó\×\Ó_/z\ŞN_éŸ’$o\Ïú³~fu\È}®\äRÄ€\0\0\0\0\ß05\ñIù\ó\ŞÕceRµ~\Ü-\ïºR-\ô%Ş¥\Éü¿Rvg]¹\ËÕ¸HÔ²kl^aü¶y˜\Ø\Ûlœ(1«>yr=©c¦\ÅÜ½?\çÿ\0›º.\ï\à³Wµ¢\Ôy¶b\Í\óG®#\ì\î\Ãù»¿\Äı\Ğ\ä}P\0\0<\Ö\r¡\Ãxü\Ç\Ö|g\æ6t>}cÙ„Ÿi#\Û\È\Ú\"N¿Mm™.ù|û~G?\í\éÀ=íœ£ƒ\Ñ\Ç\×\íû\İ\÷Ë•Ÿ}¢ˆ™&Z°7L\Ö\á\İ\Ã‘\Ñ{x¾9\Ã\ä!Z–n\\\öVü½\\ İ¨Q*m{k\Ón\Ä})Ö¾»Yı»\ğ_K‡\Õ.U¾h˜ûšVŠ‰=»a7=½Yv\Í\Ê\ËV¢dQtˆ\ÔH¤‹\ÕmÚ¾™ù[\ê\Ú\ÎR\r\é\Ğ\ä:\öƒÁ\é`©°\á\ï[¿˜\Ó\İ\ZT¯O\ÊG“|!\ñ>\å\ó\rœ2\ØÖ­5ypUr²¬¦.^Ú¹I:‹Ñ…\ê¬Å­ß·q_ocr.ÜšeU«µ–®Z”‹7}&Š«°Y\ÌÙš*\ò˜šm\Ü+gË¾Vz\Ù_	ı\É[Í™oLF\ÕÏ´È¼Zu˜ú\Ş\ÅÅ­\É\\\ÄN\'\Éø¯¡\ßv´­×«+_ı\ğ¶Œ-«\ÔMW|¨«\ÅeP2Í±^\Óq[¾Úš[‹\'Â¨³#•y\"!n\å\åT§Û¾øh½i7¬W0»\ç¾D\ÑM\ß&my]¨SE5«?\íÏ†ş¹¥ú7Íş<O\Ä\Û\Òÿ\03\Û>“Ÿ\æıO\Î\Ûb\çY\éTC¡ıiÊ´Œ_×Ÿ=\õ¾¨×¾5úk\æ]\éMº}š\Õv›¥Ur^W\í\ãk5­¦fJ\ôE¿\ä‚-\ë‰X:,,¯Y¯z{M\ÚOT{>ç¥ŠoµM\ËB‹~\Å^Û¨\ó\è?Ÿ;­/\õ%\Êjˆ· ty\ÎZ\Ö;\Å\ê\Ø\æB\Är_K\è<«´{<\÷\â\ìº\Ïn\\O†\ônqjúª©Š.\Ø\ğ•\í«…\ê­\Õ6¯”+T9D—µJ»5‹Q\ïRG\ò\í%›´\Ş-WO°Uu	\ØZS\ò4”¢_¶‹\äYˆ\óÛ–Jú§)\Û\ëo¹$b²\Õ[\Õ\ö­Y0a\óœGŸ\Ñ\×şFûc\à|\é\õ\ö\íÏº\÷T^\æ=Kš\õ\å\ò~¹r›\ÅKw\â\ïU+2¢_%{\Z»M\ÈĞ¨.Jµ95{\ïªÚ¹n\éº(_²y\åv\Å7¬ÂªoÅ•È²mB\Ä\Ë3“MDM¿i®kk\ß}„|2j~\í\Ù9\×C\Ê\×4\İË‡Lq™»N©Œ\öo•rF6Û¾ ù?êš\ä8?vùoH\áj\ãÚ·.x•Ë¶\é.Y¿\éb\Ü|” I¨{:»Zª.Ø˜¦\õ™1,ß‹ÿ\Ä\03\0\0\0\0\0!\"12@#3BA 04P$%C`ÿ\Ú\0\0ÿ\0\÷¹Â®\ÔVûrºzŸ:ª\õ.\ëTŸ_^½º\æ‹\Ô{”Oª†\ÊT(\Í\èu•®½CSC\Ó\×İ©-‘\Ş}Y§…\\µ\õ\Î\àOrš¡T~zÂ„a&:pv\Üp¨\êªK\åm°­¤\ÕZ5-\Ü?\è\ê\ëa ‹Rú›\ÒzıA=\ÄúÌ„7¡¥7Q	ƒn$\\´St\\fqEM&M‰ˆ_4W9©%\ÒZ\ìk\Ïı©\×YFï©«.dr;¢\ÂtÎšBQI\ÅD»E.SR\î.E\ãª7&¨‹&\àLnl\ï#m\Î\æ†m’z}¬}\ôy\ßkk=w\ĞR\Í-A= š(\â![M8gAZ8úd\Ôm¢\r$ \àlSA‰Š—z\'’5c*©†r\ê:¶\\$¥©Ó·Q»\Úş\ï¨Z³\ØE,å½4\õïµ™mº7§Q\Òmv \î6`sYŞº\î/úNˆ51\ÈB«>›»®IezSXS[¾æ¢»–\Ùt¬’¶¬±KfR6¤”wrxw»CT/O†\ÚK´Ë¢Ì˜d´“FjHe%<.\å+º)8pt,\ë\Ò}\ÑS}\ÏQ¯^æ±¹)O«\'A¢ˆ\Ø0T[X%(\n\ŞZ}\Äû¶œ\óºc•¤9D“Jb\ÍQ)\'&%Ò\"Dp<”ø±\ÓvµŸVU\Û¿¸\Z±kh\ë\ĞıŠ\ÉÚšš\óTuµs’„prü)\éNG¨\0…K\ÍK\Ğ:v\Üv34fÒ¶\ç=’\r@0I9Jº¿§Lm%.8„©\İ\r#3{1VƒFêªJg ¼u_Ij#bû\Z®^…\Ë|\ò6\äÀ \õ&Æœ\ÜF¬Xœ\Óš\ö\ÛQ³²c\î\Zm\òAG•»-Kg)Tv\'\Û%\×\öû’¨Ó\Åd OiÌŸ\ÒX\ÇPQ¼)¼€”o\Ó=\']\×MC\ÕPı{\Õ\õme4”U‘FØ’wt\ò¾a¬3108•3aI[¹e±\Û	Z\í\í#Áj„;9AA‡j\\/nŠ,EH\Ä\òÒ¶Ş†\Ö\Ô\ô\Í\Ó \Ã\ÅûqF\ç–w§»iø=½«\ìkÕ¿:3v\æ–Hß¾£q“±·Éœ}\äBÖ»$•…Ad\é…=¯¦£¥\Âp\Ø[Q†Qq\Ã\È)\Åj0ı#c©›£=¢\ïlm”¿cST\õ5m\İTNÁ\ğ\\“\Ò\ĞK2(\ê¢l\ÑÙ««\ZÛ¤\r\Õ’*a\nqÀÌ¼7\á\İ©yR#Fµ?·8ú\Æ\î²¶Ó’¯¦ı¯±¬i\Z“Pœ.\ÊH:\Ñ\ÏJ\îTpn›OZ„)\çµER4¶Zhqˆş–V\äÄœ“šrDI\Ë(“©‹ÿ\0üZØ½¸J\ï\îkCsiZ9+®Ñ¶\ØşÆ²r’ÿ\0$X]0•ai–‘\ét\Å=40ˆI‡c\Ê\Éÿ\0\Ò\ì:wNIÉJü^ÿ\0\á\Ö\Æ\Ó\à/#A\×oN(Œn\ßgZ\ÛJ’\æ\ê\Å{\ö~jªÂ\"¿C¾;ı.PÒŠŠ\ó4H\Í4Œ\íµ0-©\Û	\äd\ó¶±™{ %4Ã†•›š\àJb‰\å)a\Ù]G:\ÑÑ£µıƒ6Œup]\"™˜(¬\Ñ\í£]n•wJ\È,\õ\ò8iº\ÆMa«‚†¢˜©\\\Ñ\Èl£>7¦%WR\Ñ.£´\÷J²;\ÙB‹P»)u\Z‹RMK-\Ò*øwnWz¨‡T\í\Ñâ¾‚§¤û’q·\Ì\ÎC]O¹[m1\ğ¤µ\Ç\Â	\Æ\"SÀŠjg[D\ãº)P’2\Ú\ÕX”¶3)(BW{\r$«ûr†”U\ÇO\Ã![(Zf\ó¨!gš\n&#·\ÑKl—­G\ö.üĞ\æ;œ[F\Û¶X¦h•\Ê\ëVR\Ïg›úLT\ïÒ²P\Ö\ËT\Äp\Èn©¤u\ñPüUÉ‚z­5\É\âzWS1\ë:ø«[VD\Ä\ÑT\0ƒ“a]…\÷\ĞÒ¾\Ø\àn?\ÑûoøE\ÄU±u`o\â§v’s	wC&Ylpš\n–’ªQ\Ä\Î\'À\Í\â_Üš=\ïi\öt\í¨,µts\Úmu•\×{\å\r=Z¤¶¼*(\öŒœHnjX\ñ1g\ÇØ¸ƒ¾úh_#¹>SDºb†$\Ôe‰mp\ğj¤7(\ãwb\Ë.“º8Ì‡\Û:\ö·…\'“¬û¢sÿ\0Ç°Å²›\ìe§\í«¨,0ü…²¢\îCN†d,Ì¦~6¶CÈš‘Ñºƒ‚(„Ø©×¶^\ÙI\ÔB¤\ó\÷\äb-\òSEĞƒ\ì\İCmÎ°ù\Ì~\Ë0-ŠªAŒzJ(øé¢Og°\ã,³‚Á\nrR21Ê¨lÖˆß£§©ú\×?µ¨`\é\\¦ı¸›‘Q\ò\Ñ7\0\Ü2©Ÿ¢\Êcƒ®‰*†G\Z¥—a,\ìŒQø\'U?!\Ì?\r1K°~Ö¢€NwgüŠE\Ç\á\Ë\n¹\ÊR±\ë\õ4\'M^!MP\ì\'W´*«\0Z\ãOXXT’dS²›„Ju\Z\ËÛ©ı½/Ú¾¶hªj\ä*/1ºRÌ¥%-®\"0§x”uG\Z:§‘MZHmÁ\ğ\Ç\Û\ô\ßr\"R¾S©Y\n¥ıÈ¿k\íMM\ò\ÖtE\Z\â?1¬\ğFˆÿ\0\Ğì¶§Í…	&‘1e‰Ô®±Ì¾Y•9K06\Ñûz¤7QG\äP¡E\á&L)¡D„]a;!|&$&HH­°´\õPREM\÷o°\õ­\Â\İ\ã\ñ\ÊHkT\Ö\Ê%%Î°ª\å\ÄU“D\ãx›{6O}$¨=|N ”fŸ¹Ô«üH\ëMÃ¾·\î\Ê\r,u‘==TE\Ãyü(£l’j^\ÂE\ì¤v\ö2\"¡,h‡\nB\Ã\å\á‰ù\Ót½:o½ª¨v\É	¦Q’\Ï	\Ù<i·s%\Õ<u\×s¡+n2\Â2N¤5Zxš~\õu(\Ö\Ó?\é\ÍeùoXL\ËnV\Æ[Yme·\òIÓ–T‡„GÎ¥½{u 5K^(¾\å\ÛSÛ¬\Ív\õ}…\\5\İ\Ö\æ:v\î\ò=<¹@h†|ş_\ñ±m\Â\ÂfüH\êY\õ!ªÉšŠ²g{M\ÖkM]»Õšwkf£·]ş\Í\ëQ\ÑX£Ô¾¦U\×)\ê\Îr“\å•\ç\ï©\Â\\´saE*[¸\ò\ìxDøg\á\Ë\r4¸N{œ‹\re<º\Ú¶\é‰\á	±usÑ“\Ôû•µ¬ş¤\Ú\îJ)‚púw+\Í¦=Cê‘›W\\d¯”ùM\ZnW.ú+l—é ’q< •\ÅCPÄ‚T\Ç\ËK…\Öe\ÔgNh¤fRÏ†w\Ş\è¹VkW²‡\Ô\ê\ÌA&rßŒ.P“³\Ù5}\Â\Ë&\õ\"\æÀc ÿ\0¼ï†¹\ë;]±¯~©UNª®•7·¾9\Ú/\Ç\ã8VÚe_p¶5Ò”À¡‘Ÿ?¨vQÕ±.«c¨º¸E:y²±ŸÁ+—j•\òµ\åkUj3^Ÿ\Ïù\ğ¡ùY5}}’K¨”Š`œ?Ú¸\ß(­Cv\õ^U\ãZ\Ün\È\ç9_’F\ÛA‡s›s}\ï—XDÉ›jh\ò\Ú~³\ŞZ®\öQ¸Bp&\å{}É •—Fe\Ò5\ÒfXXN¬¶=\Ä|)€*\äz¹É–\rœmgD…»\ÄxE\'L­Ú¾\Ñ-«\Õ7Vı_l¸ 1‘¿\ÑpÔ–\ëc\Öú§E\n»ú“q¹5Etµ<§}\ä¡£}\Ä#´I˜0\Ø°°¶ l¿§5\â\É«–;€T\ĞIK\'D™dÁ5^\Õ\ïE=S:\ê\å]ENs²\Â0­¸i9ZÊ§\Ù\é\ÉC²°Î˜\ğı†-´¤¥§?\Î8	Œ¢+n§¯¢V\ÏU*¢zQm•J½P\\µ\Õ\Êà¥ª’b2\Êø2¤t\r†a\ã#ä¼‹u\ç\Ø,Ÿjÿ\0\Â\å\ÔM‡\ô\â¥\ã¸\ò\Õ\Ô\×GUDtr4B\é©A=n½˜²\öÂ¨-¥XT–ø©H\é\Åz›U²\İ7—\á3-‹¼SH¦v1~\à/Ô7Â‘¸Ãv—\îGœ<¼´R/s,I\Ó\ö\0]\ß$=¢—$\r’2Ëg†¦‡¦V\Ô\íøv\ÊDQ\â\'\åM\0T}Ze\î°ş\ç\n9¤ıœ4-O\Ò\èş²‰zSÕ»K\ÜN\ÎßŒ²\Êgu\å‡Q—.\İÁ\ß\ñ“¸\"~\é‡\í.$hÇ—\îwm€ÁÌ¾cn¸n›*B\ØV\\º\îu´\Ö\Ôø\\ºf\çGKÒ»Á\İ*š°¥¥ŞªuMS\\Wè©¡¶\ÜN¹§¡§˜«* ´S\Ø5]%\ñ\ß\ğ\\6«ª\÷×—yd\Ä\Èvº\Ø.ºLšQI#s\òC‚‡‘\ğ\ò6\èØ¶œ\í\Ìg†~À\åù(\Ûœ¸a(Û™y(¢¨œ‰r¿É°¬\ÕÊ€\÷\Ò3-Qª \Ó4–+\É\È\õúÙªdµ\Ô\r}8‹•DTù¦\r±I®\ê\Ş+J\"\Ò\Z–=QgWŠ†¤¶\ÕOÕ\İ6Y7.\â.š6]4ÀH s\ãœ\Ç/;d˜vœ\\\Î1º\'!l†.6XÉ‹nw~[´ \å„\ãø\áer\é\Ùqº>\Ó\Ó\õ\ì\õÕ­C\rúŸú¬µ–z›IZI™\à\Õ\ô6\ÊZms\rQC|ˆ\Õ¨aWjÊš²–§û‚]1TúB\ğÒ‡¨5~\ÚÁ¿L.ºn\ë•\ÊÜ·-Ì·*\Ù\"~Y;n‰üJ;£‰°ø\ïü3eey#ùkx\íl©\ßd\Ó%\Ò[E>Õ¹9;¬nwd%¹hË¨˜†ˆª\ÕN™¦©W>G¨mu6·°hJ\ë”q\è@£†\î\ÓzaCUh{#\ÃE\é¬T\×ú:KbŸd>ªÏ¶˜Qrøu\ÔvM*\ÜË±\Ó-¢\ÊV_í‡‡–Úƒˆ;‡\çŒ7p2\ÆH[Í”\\±7&…F\ÎR;’\åa\Ö›–À¢|°?>\É×£\0\Ø\È\Û#t²\ÃTR\\e¤lR\Å\rL\ğŒM}u:k^ ³\Ì30ûU\êt\İY]Ó²!`wd.¶³®›.“.“e€d]9–‡…ÿ\0Õ¸L‹\æ|I#w\âÿ\0^L.Oİ\î1\íg\Â\í\\\'G—MÀ‘u\áı.?ı‹~\Å_\nıH\'-\Ä	«$Ujk}P3R\ê­b\î(\è„U\Ü\ö¼©\ê\Ş\'|®\Ñl\å\Ö\õ½nuİ’\ä™\Äc\ò\\)x›\å+£4n‰¹/\"É¾#À\ã*W8T:Ú¶²\íNBGvn\áw\ÂvO\ä¹^UûmEg\ğ\ê\â[U\ÎQš\ê­YH\õúkK\Ë\íµ5º?}A“»qv|\ÔjJu}.øa\òü§È¼r3>\èĞ¸-Ñ®«:š½\ãT\îDL;Q|O‘\Ü\ív°\äŸÏ—.›ş\0ÜŸ$pŒ¤3œ‹wn\ñf\å‘6\÷\n\Zni~€¿Q:»6X\ß$Œ\íºà±¸J\Ô3½5v”¹…Ğ©\Ç+\Î\Ø\æ3s!l\'\å|Y¸`O†}¢K¦+db¤ªS\ÄÑ lw\ğ@|ydÀ|·?\"şr|£eœ”lŸ¹K3Q\Í+6\×$O–.D_#a˜\Ïj‚}\Äß‹\ä\ÍusYY©\"*½E«¨¿¶\í\ô¾\ê»\Ó\n‡\íLû \ZÎ¿\Û\Ò|œ\İ/‘g.ü&DN\ÆUl-O;mÚ‹\òŸ–o\0‡\åüÈ–\Ô?¶¿Ày?\çÀ\Ç\Ë\ÌÛˆ…£\"|¡ø(<aşBü´|«Tt!\ñZ\ö Ú“RXcµ)\òc”vK{TiŸL\ße\ê…ÿ\0Dş¡\È\íJ,¼§\à[\öÇ„\è¸m¸Œ{J2$DoøGÉÍ¾LÜ»\âR\áÿ\0ÿ\Ä\0)\0\0\0\0\0\0\0\0\0!10@ \"A2BPQaqÿ\Ú\0?ı“\È\ÛK\"Å¼$4·¹¯+\ï[/\íC\ï%}o\ï³-ßˆ\õ¶‘\ÅJ\â z\'¤T¥e£]\Ô=P¡“Ø…<Kkb|¼´Q\É\Ø]:MAElnX\ÇZœı%y\n1ç¨…U\nC’233FW%º#\îÑ£œ\\™A|‰¬¶=RHQ±a¡Á”\Ì&…ÁU|‰\ÓqJ]Ş‹\ğb†5“ƒkaS¨¤\İ\È\ñ¹m\'t®…:¹B\Ê\Û\é†uNª+\Ò\î\ôR\æ$¹¹‰‰kf&&#V ¾Î²vŞ™\Úcwbb/­\Ó\Ö[ƒ\Ø\ê%”û´ÿ\04}\é\ö‘”Z³6\\ÑG»\ïP“’»\Ñ2R7cMŠDf_Jµ½=»ı4¾µˆš>$”I(²\ÖÖ¼²Ÿ~\ÂW#¹m,no£ZNX\ÆşOW\ô¿e\õll«S7\à\ÇfR«’Ü¹’.\\rÒµ[üW‡|]\ÑN®GúYk_hø¼nR\ê\ÚF\Ä\êBJ®~/Ö–Œyn®L›JV\ñQ{Ì§\ôFsc_\È\ì\Ö\Ş$tE7u¹²&\÷\ñW:\"Š\ä{H©ÏŒ\ô_‘\Ë9]\Ïÿ\Ä\0)\0\0\0\0\0\0\0\0\0!01 @A\"#2BPQaÿ\Ú\0?şVJM²+%3\á•\÷\à8\Â•ÊÀˆCQ½Æ«›c\İ*T¡¦\óøB\óba\Z‹\æ_*ù:ŸR(n»„,l]T\ç\ä‰\ìg*do,L	F¹F»‘q<\Ú{\Ê/{¾•C\rYh°+Z¡B\Å`±„\İ\n!»V®[\ñL8¯•|…)@ \à³jÉ¨ªG\éLx&7z¯\È\"\ì˜,\Â\Õ°ˆ„\ë³Sª-§	Àz°v4\Õ\÷7z¦\è…\åL\Ü’›;ú]35\Ëv¸–/W‹\ÅÅÊ¢\Øf\ëÿ\0½v\0 …©\å\Ú4\Õ\Ú\Zt¸!zT³\×¨o»É…7¢!»\înB¦\Ó\Ù6crtoÅ«\Òı‡qA\0©SÀn\Çc¸Uic¨P¢\ñj4£S·\n;\âDR–:\Úl§F5(wB‹\ÆÏ»U¡\íª\ne792˜e‡‡\îÂ£\Ş\è`N\ê*A\õ/\'EA¯sr&\Ã\Ãr‰SD\ætÿ\0±\Õ>•ªni0\Ô\ĞG+×†\ë\õTƒ]X’ºf\0\É\÷â»‹\õ4\ßS…LKHÿ\0O£5\ñ…§*R=¬>\Ú4mÿ\0ÿ\Ä\0B\0\0\0\0\0!1\"AQaq 2@BR‘¡#0±Á\Ñbr\á3P‚\ğ$4CS’\ñ`c¢ÿ\Ú\0\0?ÿ\0\çÇ¶´´\é•ÿ\0\rG´\æ\ó\n(3úZ:\ÄO\0²´’\Õl\\Z\õ\÷´\ï\éPú.\nk\à<’šu\Z\ñ\Èÿ\0”b´We>D§2\ÇL¸üEU\Ü\ĞwnG\\]TŒ_\é+jTx¿«U´\Ì\ÎÕ°\àÿ\0¡YÏº\Úh<\n\Ä\ÂD YQÃ	¢´Wø¡Ù¼5\ß	?ä†¥z¦\ß\æ)\Ô\ì9Z«Ì­\\²\Íl…Zµ\Ík´–­“´w”\â\ÒQ.d·‹V_øh¾S£øşÿ\0º\ñ<o	–KaŠ¾—\ñÿ\0\"u<V´ı\Zœm\æy¯=§\Şù“\Õ-9\ğ\Ñ¯\ê¶\é‡{<@ü+1˜ù¡‰†\ñú£²\Ôc7ˆAdúP\Ú\ÓY\îB–ü ıAB\Åj©Š¨\ğ8ú¼ü\ìvK´sÚ±½\ŞÛ”¼ 1\æ¼1Ì¬\Æk\Ó\ìaãš†§¾j[=\å›Xy#\rsgp@\Õs\ÔfŠ¸št%K!\ègšøÆV™¬l\ñ\êy­U:­v\Z2Tk´ÌŒü\÷\Øl\Õ>ù\Ş27\r’\ã½MGmpà¡¢x“½FAo\ÃÁ\Ëü?ªÉ€sQ&9|Cœd¼By9b\ËÎ˜\Å\È,aÂ´u‘…k‰œx,.\Ú\ÖÒ»\'º\\7¬.n\Ö\çÁU¤\é»\ÎÕ´\Ó\ê\Ô%\ÏyYœNS RÜ¿™\ËP\ó\Åhc’\ñš(§›~h\âp\èWˆ\Ï!’ \ö\ËIş­Q\Âr\á+\Ä\Z}\Öe…¼Š\\>k\à­£Ú#U3ˆ)ºuU	l¾|\ï\Ù\ç\î\è\î\âWhıw \İT\êÿ\0\ÉAû\Ã\ô^0\\w/\öY\æV¹pi\Ñl7U\Â%\á\ëj \è´\÷…S¹ay‡p\Í5*°‡—Fç£±-\à|Av\ğ\Îa»r\ÑN…5´ªvm‚\Äç¦¶´4\á ùš•]£[)\Ïj£¾K-w©\ß\Åb2¸Wh\à\è\n\Ú\Ì\ï(7H\Æm\â¼_E–\Ğ,›–\õ²\Ğ†\Ó\î\0 \÷2\ÃE\àkzû©\ÄTœ,\áX_´KO|–bF\åÿ\0wÌœµ	¦¦\ÅX\É\ãC\Ô*vz\ç:ù›c¿„z/|\Ï‡\Í\Ë,\á72N\à†¤¨\ğ\Ï2¥­kÁ=\n\ÂT\ã*sY\í&\âloB\Z\0ü\×™nk’ù„šG0ˆ#M\è\åŸ+„\íG¥\Ù\ôO²ÃY\íA\á¯û\ê©Tv±»\ÌW¡‰º*\ôªŒ%§	]£\ô­bs+ƒF\åŠ	\'r\Úf\ÙÜ‰\Ã· çŸ‡Š\0|”nX!³\ñ)p\Ër%\\»š-.;\×%<‘\Â\äˆŒµY\ê	\íu\nƒ9y›n\â¨\ï\Í4\È\Ã+$\Ãx©l4q*p\Ï9G$¢\íeN\ó»‚\Ä\ñ\óú,\ó<VŸ„LO.(‡‰\Z\'1Ş‚AU”úÀ<ù¦\Óø6|Í¼\ñyÒ°tDs\Íg©\n†œ!gIÿ\0ø¨m\"O r\Ö\óSU˜O5–n\âVŸ7¸¨œÉ„\Ö;\ÅJ§W\ãcIù+4nx&“©ù›P‰\Æ]Ÿ\Ò4\Â<\Óøe67\ñM‘²L*r\Ø\É\Äq[4\Â\Ğş\÷F©S)\Î<“ze\óş\ê\Î\Z3d8\ó„\Ñ\Ë\Ì\Úu\ÆG\Õ\Óû&²2\İ\Ñ\ÙX\'9”\Z4,üƒ\Ü=9¦‰Ù§ù\'23\'%M\ÚÀ\Í\Zº\Ó\r\"|\ÕG‘‘\Ú\æJ5\'\ÂyøD ±8À\\—ˆ\ä¼c\æ„]O~n*AS3uQÅ«\0\ÉŞ¢§\\1ù\"=/iB®©S\Å\æK@,,§¾¹\Í0AS.9“½I\Ñ}\ÓH¥ 	¹k\Í:w\óYøP‡\åÁaª\ĞTb\Ä9\÷!TşŠ\\\çüÔµ1\Ñ[\n\Æ\ÇgÁ´–¸µ›§UF›˜\Ù\ÍSct\ÌÔ…k³\Ó\É56€¼M^&)z-{º©p•´Ì–l_\áµl#ƒøLfsI‘¢¦\íşe\éÁ‘¡\Í24‹³X,\ì1\ÅT´×´=\ïe­\È\Ç\â¬c[²u7L´|}ª\Ì\Ëe;Oe¥AµMş\ë\Øl\õ~+\Ã\İ\Èf†\'\æ},	\õiY*º›€¼\è\nû={™Pj\Ç.M\íXúX½\Â\Ä\ÇJn¥³ˆ’‡A“›\æ\\œ1\Ä\'Ùª7aÀƒ+*\ãT[A­$\ê^T\Ôm7{h£^]\Ã+B“›~\'U–j6z¦a–»„¡mş$\÷9\ìMA™’Œ\0p\É\á\ß{cYX\÷nA;§™|j3Ng4\àt\æZ¬\Âğ¬‚™\ì\ïY(\ÑjU\Z.=\Æœ\óXFš\Şh>d§‡>şK^û½1œš­\É\Åü†o”P\'Fg\æË¾1(\÷\åI\îi|ü\nÂªU#\\¼\Û^uKƒ\ãÁ\Ò2P‹\à\Ñ\ÅN Y_š=À˜\İúù¿\ÂÅ†O5’\Ì]cš\ÇOg\à‰L\é\æ\Ü\ÇhP&N‡ËŒ!\Ã\Î0\ğ?¥\ñøtÛºV\Ã|\íH\ô\çß–\Ó%ª<º¬\ÅE‰¸–\Õ)+Ã‡\Ùm7\Ú\Ë\'OE-3\Ş\Ü3\ó\Îa\Ñ\Â\Øu;ù%eh´Q…n[Y¬š]\ãW{²\ó\â\ĞÑ²\ízş«5Ÿ} 4\Úm\Ğ>úNß¡\àS›;\÷y6\Ù\é;l\æşA-gÍ¦ÈŸP\ó§\íŒz™XlVp?™\æQ\ík¹­>†\äÙªv¬tı.B½x‘M¸“ª?7;2S+\Ñv4Ê¦\Ûm3\ëg\ì‡\ÙmL{§C\æK­v\÷S\Z”\êvC\öz<µ>\è¹\ï.•;®´·B~•G½\èü Ö‰sŒ\0Df\êh\'\ëú(7a:!\äs2³…¡œ*fšÚ¤Ùª‹E›\ÛQ§{LùLVªÂŸ-\é\Ô\ì\rì›¦3ª.©P½\Ç5\n\n\à.…N…C®\Ç2F\ã?$\êU=º\ß\Ï\ñ;j£ï»\á\n\Ée78ÔC/\Õg²\ÉÆ»°\ïi9\Úv¿øj\Ü}%4‡4\ï%®*\Ô†\'2\ÈœFeUª\ç\ó\'¹¥\Ùd |Õš°t\Zuˆ\éøú\'5\àµ\ã\"s3š\Õk~K;Å¦»s\ô4\İZŠM¿\ß\Î\î\÷¾.\ÈÂŠu‰f\ö[h?f«\ÇÒ±\Ó{^Ó½¦m5\Ú\Î[\Ñm3\ñ<şˆ\öµˆo\Â2\n\\f\èº\ÓN\ç5\ÍX\ë\Ì\ö”šV6CmGn=Qk\ÚZ\á¨7\äVGæ³…™î¶½ e\éa¹\Ï>‰*µwª¯/ù\÷4Y.‹Ø¸.E}\Õg\Õµ\Òr(`´\nn\áS%-pp\â;¤W´µ®‘™G±¢\êœ\Üa9”\ß\Ø\Ó;˜7—)7B”n\ë={œ.\ì¶w–û\îŸ\rA£‚\ì\Ş0»\èn\ÑoZ\÷Z$¡R®\Óøn\Û7\0\÷Z\İÁev‹­\İT\"=\×0¡l¸…\÷‡0Ò¢\Ô\Æ\Ö\"€ª]g<\ó+M\'\ê[u\İAKˆ\İ\ÍBÂ§¸H\ïÕ¥£j¨ÿ\0fü.\î<Œ·;\Ú-—ldÁ«–\ÈÏr…œzİˆûw5Z˜C,\Å\Ü\î\\\Ü\Ö ±…„¨\Äc­Ñ¾\é\à§}Áªn”]½g\â=\á+-D\áeF\âª\Î ¡\Ùk\\–\nL/<‚mO\â5…&ŸO\î›\Ø\á\ì\÷`Óº\ÊS•0²=Ì®şÈ°\ßrA\×uEŠSx*x\ße²Õ¥Ú­VW´|M#\õıOy.’~\æ\â˜\ë#\ğ1§:pC%6º\rk¢b $\ê‚\ÅN©n\à#\òNhcl\ô\Çj\Z®øS\íB¥Zb›\ğe¼\ôF“*}û}7J\Ğù\ÊVD]˜\\ë¿ºk\÷hT\ñ@\Üy¢Û¥¦è»Rn…\ÒşŠ#3­ú\÷l\õ2†<©t¸9ÀÕ´\ÔÊ•´ş3S£q\ê\æ®\Ëø{03ş\áÔ§\Ë^\Ğ\Ú8j<x\ÍR9Š•	¬\á\Ã(	›G\é\ö\rs\âN»Õ¥\ã\Óû@\n\ÃaA¬ÿ\0\È~ªª\ÏQ\Ô-4\óa‚©\ÚD6¸Ù­Oƒ®´U&!…T\Ä\ân\ÉhŸ\"µ+\'-B‚\æ\Â->&¸&•\Ê\âKº]\õt¸•%Nà´»[²»U¸ U\Ú\ä±xªzZª`\íK\÷\ğ\è‡j1Rq†T\Ğ9#g`©ksÌ¼³dt”\òl•˜\÷7N\ôTb\ğ\Ö„úV{&#q\Ôv¿%\ÛÔ³ÙøºS’4\éSmI?\á³À\îœ?¶³š\Øw\ô\èš\ö™i\nx˜Ç’\â«+´Zw1\î9„\rÇ§p\Ê\ëxh\ñ\Z%~\ëPµ•¥ú¨QqÚ©%¡½i_2w-\Ä#g¯D\Ú(;\á\ÉÃ¢ÀÆ²“¥?Q\çû&Õ¨Eš™ø\õX¾Û˜\âÜ‘ \Ç\ö.{H\Ç\Z kZ*\Ô\ä\Ó\ì}\ñX\ÛPÕ±µ¸Àv \î@µ¹!D\é\éVzs\êıÔ®K\ö_º\ÒıB\Õ9ª£%\ÕBp\à¡.7ÁM\ğ¢\ìq\ÑfµZ\÷f5\Õ:†\öVŸh\î5Å£\"\n6g–Ñ¦\Âs\ñ„\Ìu\'6S~¿\êù \öŠlÀçš¿ş[¦Š“SS\Ï3™:û\'\öG\rk]ANp\÷\õVAiy} °\Z:¨º\ÄqxÁ‘\Ò\à8®J%h‹R¼E\âú-\'\İ6¨4(º\Ş{ı.(0js_\İjÕªŞ´Z¡G\ílÿ\0\ëù\ï\İN \ìs·ªnû\Ö1\Î8K©Ğ­iye\0qT~²UGÒ®j\Z»#³a0¬Ær\ê6*rh>™n‡?¬(¸\0™Ou*Cëš•+’™ù]¢\Ò\ì‚\ÑA(\Ó:·\ëwK\Ê’t^J›±3kt(\ğ»Z…\âZ\Ê\Ñl\ä¢\éS\Æ\êmÿ\0º\ÇSıN\éq8qlƒ\Õ5Ì´œ`@Ñ‹¨:«SY®	™şŠÇ™\r{°\æ\n¯h\Â\rn\Î;FB\Äoµ»Xv\ì!F\á~K\Ì~J\õªŞ²?\Ä;”¼\â7‹½¸\à\n.\r»¥\ì\'(”[¼j¹(º]ü>¤\éU¿.í’•\ßyA»\÷‰\ğ·\ó(u›Û½Ô¶J.ˆadÃ¸B¥U&T|Õ´µ½›©’\×\Ò\àºm\Ïwú\ñ<’³¿\Ê\éÃ‰«Eœ©3\óX(7\ó¡5\Ò\à®&\ğ.8\ğ¾F\É\â1X·®ŠP>\ÆùS\Å[š¦\ï‹;\óÑ¹”ú\Ï0m˜\àÑ¢u[Gü­œvµr\İÁ<Ø«µ\ïª;6´j8 _•\Z_yQÜ‚ş(\ãÿ\0T}O\î›u­\ãR0|—%\nn\ËE\nT·>#Š\Ù\Ûw{S\íx(\î‰ÁQn\'œ\\Q\éq^\×˜\Í\Åa\Z\\QE\íV\'M&~H\\\ö\Ş)Šƒ\ØüM¨2lxaWh1\Ú\Õc]\ĞQ_\Åkap{g-F±\õV€7°~kÜ¢˜>*¹üs\é\Ü\'\Ùcşl7:\ï{‡<»€\İÿ\Ä\0+\0\0\0\0\0\0!1AQaq‘¡±Á\Ñ\ğ@\á\ñ 0P`ÿ\Ú\0\0?!ÿ\0\÷¨jÌ¿°Kqüb^x+\÷f\İP61Œ?ì¿ª4®VVu\Ã\î\ËkûMw†Y=S…ÿ\0\È@`.¾“…Rı\à‡E•I»\Ê\ÍpÊ”³\ŞBcš\Ş\ñœ\ëŠ\'kr´ˆb\ğxa“g[~ ™5\òz1¶Ázvby<~\Ô/\ôº/7\÷üCªù\æ­\æ\Ö_\ÄoÒ»»_yQH_.\åŠOe\Ô\Í1[¶¿É\Ø_h\Ùv¦«L_ \İ~#\Ø\älf$\ğl{ÄŠ†\ö?ŒF\Üqÿ\0\r\ÖZ‹>‘Àe°\êºÿ\0²\Ô\Ñp\ç\õ\Â¯=ız\Ëùø]z\à„F\Çÿ\0€µ8\Ì-7\ç\ï:\Ó,C³\â°\Ëº;·OmOß˜J \Í­‡‰˜kl\Øß‘Ö—n&I\ê6\Ù-Å­­l\î+/ƒˆbwE{\îbG$rCu]\÷?nV\ç^§\â\Ì\ôX‡oĞ˜g€\öQ\éøHüœû\Íÿ\0x‘(r\ËøÉ·\Ğ~\ó5\îW\îNv\ô\æbK‰¹H)~bæ¬M›Mu\ôš}a{m\ô&\Üw\ò&aQP<Ö‰~\Úú\Ã\Ñ\ê\×\Í¾D¬ªA\è¿HÈ‰\Ü8\Ç)U¥’a\Ø\Ã&Ÿ$(©ÿ\0B*ùY\Ú6p\ö\Ö~ı¥\Û\Z\İtüŸ\Ş\Ô#\ïcW\Ö9XùYaqoqù\ÄF´LF[\î\ÂD\Ñ\ö…vs„»\öS\í\Ì*°®\n™/\×[_³9üxh}\Ì3‚«šb²Ç€ÏÁa|‘{¯\Ù\âTZ\÷˜F*+³¹Ì¼\è_\ç\Ş)¶\ï¬,½\ö%y%Ál\Ïsüş\ê\ó\İF\Å\ïfR\ã\âÜ¥…\Ñb,\Øi-—”\é(E[\Ñ!U‰\Ò\r›vAi+¡¿q\Ö$®+ŠÃ™K4¸zD\Ó\õ\"ˆ»ûp\Ë\ç¥S\æ’f\Â¸¯sKpeÀ?|\÷w\ë©1„\ñ¨¡%y\ë\r\Ñ4½ºC\'\öÖˆ\êVªvn;\ñqt&²\ñ\ô˜‰‹ÁüÌ7C\ó*k\"¦‚*\à\ÆX`\äyjWVWº\nj;\Z}X¯[?‰»\Ê*V\á¼+\ñr\ßDMrûÁ0¸8³—@\ô#\ß\0\rEşÓ¶‰³Ô•¹\İ93 8¾	*Î›•lÀ\ò>a†\nƒxÍÒ–ƒ„\Únl\Äş\ÊYNwØ”=Kœ\ÒmÈ°Óƒ\Ş\ò\ç-\Z%‘Q)\Õ¿\ğU~\à\ŞÈ»O‡šy»\Íÿ\0¹‘ùjd\ß`«\ó;ú ¦\0Ve\0¸²_®SAœ\Û;h2\Ë3\"ùs2Öº\Ë\íŸû-\'hmQ]’Ë˜èŠ¬/0nh }\áÖ–¸ıSCRG‡\ï\Ï\ìez\Ü\òT¬twd\Íÿ\0!^=ˆ±£\ã»\Z\ì¿\ëú•x¸­·ytPs&»ƒ˜2\Ó\Â\òF7\Z_™š\Ñ\Ú/SR/@\Öe\ÈÚ±\é5¬˜£unj\ğA]¸\n©T^ªE1™§uSş\ÌQpN`\ÅV\ò˜\Â\Í\Ş<d,N\\\'Ibh\Î\ô\öÏ¤SB\òt{ÿ\0cZR\ë1I\âœÁÔ»i\Õ\â½ 7©gBa\Ñ-\Å\åú!1’\ë³\Ä\ñ*´ª^Y\ò\í\0›Ã‰A!l\Ë\Ú6\Ş€ı	¹¯NX=\ra99£sq3\ñ8K7\ÑgTª…\ãQN¦iq«\àÀ\Ù¿†&\Î\Ğ%\é\Í&O\ßœ)?²\Ãv8Î£ }\Ò`w[Ò‰T¾EÒ²Ê°Ÿ,!¡\İÀ\È\ôúÌ‚\Æ\Ú\â\r\Â\Ê\èŠs;`yŠû[\Ù‰hÙ„s&8©J\Ï\ÒµN&¦I@•/i¬‰9ŸV^©K&\Ñ\Ôÿ\0‘³S¢‰x®\ó\átxW\Ö_›\äøø¯\ì:„	 |Ÿˆ\ô®hoˆI\å1Ubµ\ÃW\ôÑ–Rn=a…ˆ\õ\ä+\ÍÌ»`d™£ş\ğ–u\Ï\ñ\\ÁZ\é¶\Û\ÏX,¹+s¦Al;\â\Î=x~>b‹°9*.¨¯z>Ğ­zG•¹…\â“\åı†\Z\ó0rı`\\6P~s(ı¨CnÕ¾\ãqx\á½\ã!`~#\Ğ‰SR¹©¥\ñ!‚¥SY¬\ì\Ì\\K{§±:\Ö\Çf£Ä¿\\\ñÖºF¶\èpÚ¦\Ú\ßs´p\äm\ñ\ôÏ ¹\ä\í€?²°7»ŸHfÀW\áû\âdA\ç\Ğü\Ë)Ë±\åƒm´\Ì…!Q„9Èƒ°^e\ãøqü8G\ï+fia–Q\Ì5[GF>°T\ñ<*ã€œ}Ï˜uı¢%N®G€¸<syøb\ö\n\Óø\Ê\Ã\î1\×r;\âe)¾É€\ËÒ‘€\Ã\ÆLL:¸2¹…\ó*9B\åÊ—V\ôŸ\áË¸{M)\õ\ÜL\áq]z\Ì5º—®?£%h»\ì_£*Cld¿™—\ÈÓ¹¨ÿ\0eù¥k\n\ñ\×h¤ot¨\\PPÙ¿¼Yjcº‹`¼C\"\æ\×I†W!\ë]u~\ó\éºEfŒŒ©H_dÃ¨+\ñ:Œ\Ê*\Ü\ËSe-‹\ÔjÆ´P—ˆ·¬Ì±»\×R¡v)n\á<.‡¤I]3‰\éPÇ¼B\ãB4L¿v,×¹ıd4|\Î\é\Ûb<+\î+\ğ\Ê\Ë)•r¼*\ã•¨ø\àfZ\à\ó­šÔ¶ Œj½ …K3ü Úª‹º¦œ\\\è\âZ\Ø8\ëÆŒ561X!V\ëLÙ‰Z¨k0Æ­×†3ºX¿™\ÛE7ı“C¬75:\ô˜u7\0œ°µG]=&M|pŠ¿‡$\÷\ë‡\ô\Êsø‚y¾A\Ñ:\Ø×ƒ\õ\Ö*\Ç1\è,=Àf\"!g\n–§ ´\Ü)~Ş‚Ákh‘\ÅK%•\Ò\Öl¼°3nKN\n\ï=L]v(º\Ì\ËA\ä¹ı\Ë3!«ŠµÁMdß„\å·1£\éQ\Ğs0œÜ¯Qp\Ó2\á\Ç\rF-Kƒ[<Î²\ÇOµƒ*\Î\×\ÕS˜\Æf\æYr€\ç¶¬rÀ‘:›Ï˜0j\ÕA\Ğr\\\Ã\Âr.”\ÏYR\Ò\çP‘˜\ÕVC\ã¬\á¼nf\ë°qùd\×S\á¹aq\'8*A\É\ël\İa\Ñ\r3¹Q»\ÒOĞaï…¸7(:Áé\Ü\Ği>œ\ÂJ2\êMQ7’.\Äy–“‚\öŸ\áB¡„£\Ì)bPÑı\ÉQ\ÜÂ‘\ÂL¡\Äb\'e\0aZş\ïZ•\'iF@\n73\æW±XLâ§´kÉ–„µ\õ—\\1P\Ì\'®	G\æ\Ú\ïp@\îyş\Ë†°¼·,[S\ÌVaÇ¬®!Z©\Ä|À!\Ó}\ä¸C¤–š”n¦5\Ó*£.\÷.JLû@¥¾HœÜºÖ¥\Ğ(J\ó•ü\í·\0VøûLú\×0c˜\Ò\éhIy\Ê-\\\ô&+y…\æf.(.¤\ØK3\Ã˜¡»…UXf*	®w40»@À”h\âV\åªÿ\0l\Â/«\æ¦\0\ó\ña\ë*ÁÁUR¤gT®^#\ëıMK\öŒ¼\ÓøV\äeME\Z-M—„\Ç0N`dÑ‚\×1	D\õlË³·Ÿ\íşÿ\0£-y†£²u¥qkø\ï0‰]\æA_µ©š\Å\é\Í\äx!r\ã\"T¡½„\ñŒ\ÃrüÏ_\â5/NS;:~Ÿ\Û¬\ê1–uCl\à\ô\É.Q1*`Õ‘)Ä¥˜C¤\à\ã¯\ğŸ\àa”b‚ª¯i\Ù`s\å\Ïsü†©\Ä\Ä\ó1{\Ç\Ò(«€m›û¥§\ñ\\”ø–\Ä\r—.\Z•q™gø³L\æ™Î \ÌB–È,\Ç]¿\İ]ƒ§\÷Ì¡\â\ŞX\"©™,\Öw(1u\Øn3\nù?2\àÛ¢MÖ¨v&½‡\Ãhÿ\0®ª¦d+\å+ƒ\Õ0øºs\Õ\æ\n\Âÿ\0yµP½fü\Z\÷–\Ö*±1‘q7•¯H\õÀ6\ßPÇ¶4—\ÄhÊ—z—ºye~œC‡b‘P\æ\æŸq‘~…º,\Ã5<}\Ì\è¦~¸X¬šgzVYd·=c\Ú\\	Y•\ìù‡)qV\á.³3¨ƒQ\Ûs‚˜w¡8t_ß­Œ2zeA®K%\'YH&c³\ËºFÎ“e\Äª¡™\Û*\r\Ë¨–d\Æ9\Çø	\ßp ~\ç\÷GKúo±F‘\×IV§F\ğKHÈ¿y”\Ì\Ë\ÂÌ©˜t5+Ü‡\ó(x¹SdzX•\â[—‰©‹¼£\Æ\'Xx\Î\Å\÷£\å‹mø\àÁ\" ¤·\çŸ\Ó¨·¢ÿ\0dy¼Ÿ\Å»\ñOŞ„Œ\ì,6¦ş\ñv\Çh\È\ğ‡Ó˜c=N\Ì<{šW\r\çøhy‰“Œ\Í\Z”®Y^Xœ¬5\Ş7\ñŸv	\å\õù¸\\e\ï)dŠw¾\Äé“’\×Á‡­\Ü\çe1}\ğ¶‘>¿Ô©^¬\Ùzxug~:L“…m\Ü&\"ü‚ce¬ù‹\Ô%‡\İ6rx\à\ãc\Ñ<ÿ\0\r\ÊQkIcKi¤¸&ˆ\ãq*şş;¬pw™\ê£a~—	M½\è»\á\æ@’…\É”\ài8•i\ZD\î\âBSJ\â–ş \ÂÄ±ÿ\0\Ş,€V\÷\ñù\Ôm\ó¸ËØ™\ÍÀ½Tm…Û¢9r¹\ÌKoh\É>L\è\è9øƒJ\Ê\×wg\â/U\åÇ¤#\Zf\ós\rDyÈ(®Z\î6E;Š¨\ó¹\æ\êŸ\âS\öt–¿*_YŒ\ö”›1\Ù(v†¬–Q\Ñ\ï\Ö[¼\Çy,\Î \âx‚ÙŠSiûCúL@úÿ\0\ëH¯š\ô\'NpıÏ˜\Ê@cé„º˜Z\æS¼\Î\ÕS_\Ö\êsm\÷C±¢Vú\Ì=\n¶ -¾‰\È\0y¬ü\ÌZJLOËˆ\Å\ó’ZrW*Ÿ1¶-\Û\ĞÂ0\ä\Û*\"T§<®\ìTŒ\í!A-­\ê_¼\Ä\Ö%\öÔ¡rG¤=¥¶-\ğ\Ë\ä\Ş\ó …¹€2\Ã0%\\\àt‘!\×\ßø»3˜ùj	q\Ò\Ùÿ\0‚„Ş–0Ğ¢Éª¼\è”|\î/8\åVq»R½&V\\ìŠi‘wÏ˜eG!RË˜\Üiƒq\êsÓ™f\ë4]\Ë\çÁ}‡Õ—\ÌaÀ\Ù\ğ\õ\"\Zg\'ÁO\Ò0\È=%_d\Ò\ç\ÒQ€\"~0Sx š¦IDO*û\Ê\Ò\ç\çP¥\Êrü\'©)•JˆuO\Ä\èyKKMWŒ\"\ç\Şj\ÕL\îQ*R¼ÁƒµJ§Ğ—\0yû)\ŞU\Ğú\ÆÚO\ğ’Ó¼UCd\÷R\È9\ê\ÍCİ—\Úbuwe§¡\Ì\ÎZFVş\'Y\ìB\n\÷½|\×!-\İ\ô¡;\ä>á­‹)n;Q~]Ñá‰»<gi=îœ‡^’œ/7¹R‰\òE]^\ÛúøŠ\éˆ\Òı ¦ª¹%¶\âVÏ­:´®² 8›5®ªcF¢Ã¨h\ô\ä\Î0g\êË¹\â8†/¦‹9¸	‰\É3Kt&H^w2C\Ë;\â`\óD9\ó?e‚()\Ø\Ï\\\ì\'\ó\ó\àÔ­¥ø…mÅ¯µ\Ó\ğ\Ì$”\Å\Ã\àü0\ö“À¿C˜$\äØ‰\ĞE~\ô¾\n¬\ì\õbu\Í\r;W\ğÊ`¨<>×´\"ûZş\ñ\íp\Ô\îLkÏ™BW„±’\æ{<G\èª%¥\å\Ô\ïÃ¤®e\ÇDv0)•Œ,™wDWA·’t,\È<Jc\ö¨®#³¼ m´\ï“\ÖV€Ä«tø‰?	F—H]\ó\'}p‚\é\àË–G‰DL°}	\nÅªü®V¼¹a\Õo\åYoˆ\×GxŒ\0\à\ßc¤	x\ÙMzA\÷q±JÂ} z6</£­~&‘Ì«øÛ¤\æ2\ßQˆÛ‘©\ÆJ\ßE\Î#?\ì·7‡\ÔL*\õNúq2\Ä!\ğ,”j«#(¹™”ox \ë—D%.gK¨°Â“/	Y¬\æ8\ri4±rŠ\ö´†(s*\æ^\ìø\"Œ\ÙÙ” /–U­—8ˆq~`‚ˆX¼\Ğ\Ôg\Ú]¹g¡P¨\Ú\ô\ë\í\ô\ÚBºv®gC-\Õ\ö	JiQ¾Y†QN\"-\ìh\ã\ÄZ\ÜÁ}\é@¡u„\ğ¯«	\ÑûÄœ}o\Ï\òi•\ÂfzK’ß¨A\Îc½¦ÒŸ—\Ò\ÒX\Ó}\î¾®‡,¦\ö\í;\÷–\ï\ÅbLQ[K–ª\ó\r\Är†\Ñ\óc$cÙ„²¿9”\õJá«“Äµ¹³²ll\õ—¡»ƒ2ı\îùƒLvD\ñ\æ\0lE?H\×I\Î_\ÚSV%³\ê)JŠ.dĞ)q·\äëˆ‘OGeLƒ&ƒŸ£\Ú)02\Ş\n\ë1\ñ$‹f\Í\è\âU7Á\\\Ò¥\õÜ¨¨´*\Ü\Õ<\îW\Ü,Z-¶.4\ó“‘\ÓÎ«7\×K{\\ú=`R(Œ\å3¡´x\Ù5‚ûÁ˜7\Û07\æaÁ–9@\ßOHY¹¥”?–µ/­T\Ñ\î®l‡k•_\ê³8b¡:Ä—Œn5`tĞ™a\Æ!\ô™\ò&[-m… šÁty³\Êhz\Ä\Z\ö&,[\Ë\Z\è\ë3L\ògI8•\â`R\êm\"wYÀ$ªy.\Äç¡€2µ\Ì}f[œQ¹\âT\éÊ¤Å€\É\æt\ğ\ã\ï($R©\÷\ÒÇ§G“BÍœ\ßi[\Îr\Ã\öv”¶G§\á	n‘,˜\å\Úq\áz«†\Ó\é\0ì¾}\Í@M§’_û	cĞ‰[¤\æ#\îc#\å)ba\Ékı\÷†ù°»Ô¶nN‘\ğu\ë<‰a\È\é,“W—‰x\"\É\êœÙ»Á\Î%\Ëİ‰•ˆrG|AşÌ#[±–P\É\á¯\â›\óT†‡\ñq,®\Ö\îº\õ‡\É\ñ¦\íu\Í\æV*\ì(­q\á\â1#½\Ş\õ%¹U^Å“\ØyV¢Ñ™Nø!°¶6š\ç\ÄÁ˜\÷\Æ\ô0/\æq’q¹\ã\â\n¤yU\òJW†_\Å\é:r7\â3-.\ğD|?\Ãnµ*›”P¬\nûO~`¯#.\Şf\á\É\0h\ç(\õ[˜\ğ\õ‰\ã\Úd%Æ °l¯D(¢c\ÌA\Ã\Ò%\n·¥D¥ü˜ÁÑ®°\ß&\Ó\ìœ‘<s\öK+?ƒ”Ws¹ƒ\èb\Í[\Ù\ô„‰¨j\ÚÁjxV²8Áİ†…i§†ª·W\0PCb\É\Õ\ì…W™S|CM\Z\ÛêŸ¸œ\ßX‹mÏ¶G`\ÙQ\ë\ÖPû#j`ÿ\0l$EÁåŒˆ‰US¢\r\n©¡yo¬[kc¼³8E\r>ä¶®\Ç\Ú‡˜Iq*C`\í*>s0\êZ”u5<Ldu§Eû–<±\æ\á”¼\n€:û±¡JaH\n^³¨¸\ÖpŠ‡­\æ\nb±:\ç´)\ÔK–¨\ÕLFu€o‘\ã~’»<À{_WxT-§•R•]\êº\Ëw:“\ç\ËY;AD¡E^„¦\Z¤}\Øú“D\ï\é²j6\í\äZüN^ú3\Åb½¦e·\ëR\Ö¬\Ì¨q¹s˜Ê \õ3;^*;Œ¬g\ÙXÀn§“&wL¹¬\Ğ\ô•wbı\æ´3;™{¬\Ş\'@Ü¬M\í\Ì+\n˜p\Ò8”J\è|DU\ì–;9+ˆ\æú\õ\æ1´†\İ\ŞM?¤O\àL\ä%7\Ñ(@	úb\'·}?\":¸‘ù–#£>­K©rvù9\"Y.Ê¡lN·G«¿¬©\Õ\Ö%_Xe\Ú­ù\í,\éLÓ³Ä¦},ªœ/JüG„°¦\Ãw\âXN¶®\Öa•v$8\ğwû\âNWX\ê•\ë\é7O\Û\ï±R\Ğş\"[|L[\ã0½‚±.¼\\\ÏTÁ\æ|\ï\Ò=\ãÕ£„\à¥N	AŠc<gPO\ğı\íK\î}\æJX…¢1·%\à\â\â¿h\Å\0[±4\ÈO‘‡\ïI‚;vJS»DfW\ÑË²91{\ë§r\×\æ×¬\ÃZ‘İ’\óÚ¢¥\åfW\å<\rJJsú<˜=\Äw½’Àª]I•O+¦*&\àƒSY•Š\ğuŒ\Ş\ÕÅƒ¼*Š\Ò?¾\ñ\Z\Ü˜ø}\Ñ\Ü\n\ğÆ¯\Ñ$å»°\Û\Ò\Ğ~rü¢\Z.dJ\ÈÁ<\n—·¼\È:3\'oıŸ‹ªú3\'\Şcj%Œ\ÏÁ*)\0À\õ?J‹¾˜µ\Â\æl\éÀ=\åHn\å%²“\Ğ\Ï\ÂpK\èqZtú‘\Ó\öFù°E\Ê\â\ÅXÂ°9\ç»s0C¤›¸\å:Œ\Åw†N.{\È}•\÷ÿ\0\Ë!-—kL}›{—,C\ÒUÛ²,ÿ\Ú\0\0\0\0\0\0\ó\Ï<\ó\Ï<\ó\Ï<\ÃO<\ó\Ï<\ó\Ï<\ó\Ï<\ó\Ï<\ó\Ï0#¶\Ü\Å\ô\ó\Ï<\ó\Ï<\ó\Ï<\ó\Ï8eb\ß\á‡D1=<\ó\Ï<\ó\Ï<\ó\Ï<\áFbzw„^\Ï<\ó\Ï<\ó\Ï<\ó\Ë P¯}ü\öª¶\ó\Ï<\ó\Ï<\ó\Ï<b³‚ª9¡û\ÄI=\ß<\ó\Ï<\ó\Ï<\ó\Æ\Ê\Ê\nOm¹:.4j{\Ï<\ó\Ï<\ó\Ï<k¥yUˆ\ÃI\Å<\ó\Ï<\ó\Ï<\ó\Â\íQM\Â\Ç\Ï\Ù.s\Ï<\ó\Ï<\ó\Ï<jº\È\n0—šü]\ï<\ó\Ï<\ó\Ï<\óÁWk8<‹\Õ•\ó\Ï<\ó\Ï<\ó\Ï<¸\Ñß”º¹‹­b\ã\Ï<\ó\Ï<\ó\Ï<\óÃ¾¯È\Ôo‹š\ã\ó\Ï<\ó\Ï<\ó\Ï<+\ß\Ú\ğAe\åÀ?<\ó\Ï<\ó\Ï<\ó\ÂDc \Æzk\â´\Ü\ó\Ï<\ó\Ï<\ó\Ï<\ğ\ÅnÆ¨!	Ê\ó\Ï<\ó\Ï<\ó\Ï<\ó\Ï=\òúŠ ®’ü\ó\Ï<\ó\Ï<\ó\Ï<h\àp‘n\Öë‚¯\Z,¼\ó\Ï<\ó\Ï<[\"€{\Ôi©\Ò\ô’D•<\ó\Î\r\óÁ¢±\Ó\ÆmOk¹\àN­°Ï°\Ìnm›Yq\ã7uµ\ÓE\İS\Şn”›¶\É\à—¾ƒ\ó\ÌR)¼¯\Î6ÿ\0_y\×> FŸ~\ãÔ\Z\Za$\×\Û6¿\ÖO\íÖ˜R\æa\ã=¶˜áŸ·;v{\í\Ş3\Ç\ê\Õ\Üj²KÁ„7C1\ì+>tŒ|ˆ\ğ\ñG—®uÕ—\÷`\Ãÿ\Ä\0#\0\0\0\0\0\0\0\0!1A 0Qa@qP±ÿ\Ú\0?ÿ\0„\Üvz\\­$½J?\ÂW—«o1«9¸³/å·°ÿ\0\0R\ì«…Ï‹K¯\Êı\Ú28´#\÷i\Ûq9\Ï\Ûqp\æu\ç\î\î\Ë.-\ãˆMŒ‹	\à\Îz†H©p\ñ\Ï\"\Ã6P\Ç\ö\Éİ X7‹€6ı½£’`˜qmœ»p­Š\Â\í³%–;šû\ìr\ém¢’	!Ì´‘Ğ\"X}¥\ê\"X\î\ö“®9q\ñ7\İ\è0Ù¯(Ç“\ó\ßÛ‡ı\ğ\ä\é²\æşg†PA\í$\â\Ùf&5\Ãt]OPŸ\ó>\ÜW\÷\Í\Ñ\æ¦fH\İ$¬´\æH&ûÙ£Û¿nyûb\ØY\Ím\ôY¯0\ÌtXŒo\Â[f\Ë_ù\ö¼ÿ\0m\îY Bˆüû\Z\ê\áŸ2ºÜš‹\örBûov¬W¢‡)\Ã\Ä\ê\õ\Ì\\©\÷\á¿\÷\ğ\à@]n¼\æÁt‘´\Ëhg®>üÊ±¥\Ê\Î%¼\Ø$\öc\Äu)\Õ\×ü\r\ÂŸ\Ø 8°9Ÿ¢\ßß±l\òH°\í\æRs\Äƒ=·\ò>\ï~9ºù­¿!\ÈpÃ†\ç\Ò\Ò\ã\ÒqÌ¿ú¥ù\Ç~‡¢b\É\ãm¢r\óù?‘?N\Û\ä\ğyc™‹Á!\Õ\Ì_¡ı€w4\Ï²cŒ\õ\öfø#\á\Ñ .m\ê\0d®Lş\Ë#\ñ\ğ\ß\òşøßƒ\ác\ã´z[\ÔÎ³\Ô<\äıGÀ|o\Ân\Ö\ÉÙ–\öc²\'¿†\Û\ñm\ó\î8\ğ\Û7h\î\á—Õ¼Á\×6\à\Ç\Ğ\ğùÿ\Ä\0&\0\0\0\0\0\0!1A0Q a¡@q±\ğ\ñPÿ\Ú\0?ÿ\0\â$•\ê\Óİ«\Î\Äx?¢r½®»p\î\Ş6ş\Ö\Ù²\õ¿\Ğt\î\Û\Í\Â}6\×m\ÉwfCm	\àü\Ê\r\\­nR}†w¬¹;‡|\âÏ©R\Æ0\ïÊ°Cxè³Y›\0• |W?(~®%\Ì6t‡h\êY¹-—Ás±\×\Èvt\ë\n.\í]J02wT!!¶\Û!\Æ87\æ<¢\ßg´¶\õ,¶\Û;Û•8 \×\å`}Ë/r¥½D\öO;—˜Q\õJ‰³3\ë\åş»;!„cˆeÁ\ã©\î;°…ŸpW»–Ÿ¿—O¡\ÅÕº—9¿YQ \ÉN-Àc(z\Ú7ë—S\õ(’\áY¶\Î\ç«/\Ú;†‹\÷\ò\Ô\Ân\ägY#Á\Ür‘\0>l\'˜\î	\ä-Ÿ^=İƒÁ\ó\ì\ê9nŸV£-GDx\Ç\ß9:™£bh\Ú\ìx90Ï–O\Ù#lse’\È=\Ú1Š\ö\É6ü9±\ö-\ßX\Ú=\êw;s\åx/\õ9\ã,±“lO\ÈL‹?\Ø\'\ÜX2®[^¨\Ã\\—]\ñ¶XO	\÷,|p‚Ë¯_‡± ˜\È®I\æ_ƒˆ\ï·\Ç}üOe—\íü=\Ï<şs–O°ÿ\0½\õ6\'Ô³ ÿ\0k\é\Ì\ÈD\Ò\ê¾s\ğ\Î.?‡\ñn®	8w!\Ï\ñTW+&¯\÷ÿ\0\ÈG\ZuÎŸ\ç$\İlp#\ï\ÆA<D\Ô\õ\à<e–y9cÇY\Ó\á»ø¿\ãş\õ\Çş§«\è\ğCq\ã¤\ó›Çƒow««yü97Ç«:\ß~?\ÖE3µ\Ù~®ì\ñß<g\İ^§—Á\÷u&™r/[<\ç¶mry\'`ß£¨\ĞB,ü=Á\àn¯ÿ\Ä\0+\0\0\0\0\0!1AQaq‘¡±Á\ğ@\Ñ\á\ñ0P `ÿ\Ú\0\0?ÿ\0øÅ©cÌ³©ÿ\0Î¬\Ë\Ğ«·1Aè¯Yu\á«!{ Z¨›#GŠ\0\Û\ÌcB\\ƒ²\rkŠa‚ÀDÇ”µù˜\r³e¬\0ÕŠ}øœ\ÓF\äu\rbc\×øP\Õ\Õ\İB\è\\…<\Ôÿ\0\ã-GxÀ%]l(ƒY¡w—  Š\Ó\ë¨ŠŞ¡z5¨›]6>ƒ3…´p©¾®\ìÀ\Ê%x\\ú’\ŞVL\õ8\çUÅ¯¨/\ÓX\Öf.¤Jc­>BSRüIn§\Å\Â\ä?9|´\ö”A\õ`6\ZÕšU˜|Y˜dP\ß\öUB=eœx\Íg\â\æ\Ïş\Ö[\n\÷\Õ]\å\ìJj¢\"Uºn¾Nx–s\æ*YeK\ê:g\ÄE\Â-\Î\ï†\î)qÀû]ÛœbSF¥~@Q\Ç<	´v\Î7\â\ìš6w2û®Q2i~F³§\ö¡o‘\è`—\ÅC =‘øKø\Ô¤=¿[•e´§/6’\Ì\"!\Ğ\\º)BıÛ¸\0«–6\î„\Å¸]nG‹+Šk%5šj.b¶¨—®\\Na–ˆØŸü\0´EŠ“D‹\÷İ~Ë»Kƒm\è\ñ\ÒswV›¸\Ê\Ù\â\nN¨+G‡Ó˜Nn\Ó@P\ğ\Ê~\æÚ˜\Âf\ê	¼\ö«oÄ³ `µ\Øz\Ó™azƒvú¬P² ,\ã¬+Tzã¯©ı\ÌÒ‰­\Ö\å\à\ë¸h8\É#Á\Ó<‰-‹ƒkÁ\Î3\Ş\nA\Ò(a\í¯\"_\Èm˜8\òw\ãİ…ª\â0\ÑÌº2œD\ä $,9SÛšXx	*•]s\Ì	‘şp\Ğ%©@Múr	D¨\à\ëj\Ú\ÛmıJ”_#\Åk\ó\ny´4ƒ±Ç˜¹f\ÄB«¡\Õ†‹¡ˆ	¶£šp\Ë\ç3#5\ë1 ¡‡Mqª\Öc\Ú\å	}ZMi–{¶Æ•Kœ&‰Pp\Â;\ì‡;´¦jY”h5hv\÷Š€\ò\ã\Ş\rº\Ø\İ\ÜgÌ•‰N\ğ¦üSu	k…ƒ¥\ì\Ó\æ=\ÓP‡m3y®“=j´½b\Í)]œ¢L\rJU\Ø\â\Ó\çˆuSiugi\Å<š{e\r\í¦‹»«A0@*ˆz@¯\æ-K¼\õ\ÈT(.q‚ºÇ±U\ä\ÑÛ»ˆD»X6Ïˆµé¯¤\ZVúÜš5b\ÔqJ>¬Nü\"•\áÁ\Ó. {£¬•‰y\ã~#H\ì\0ª1\Æ \ÊÕ’ŠÎ­vH\äCn:\æ\Ñ(S\ê(UR¬«\Ò\ï¯YN[‚ø*¤\í1kfÊº5…\î—h\Ï)n0\Å6\â†g.N\0/\0]tr|Âš5¦¸\ÄÓ¿ŠH´W›VA\Õ\Ø\ßA›ŠR.|À3Y—‚\×\íC8dÆ³\ëz\ë–\"£“Š¾\Û\êÿ\04 7—V\ğ\äA¦nµµ~­\í¨D/K§¥™˜n‘=/A\İ\èBn\ĞÁ-pÀv³\Æow\Şk\ñmB\ä\æ\ßU%@ {Ñ™}T^nªb3*eÎ¹ Ç¢¦¼…|\Ë\Ñ\Ù·‹´`R£h\ïA\ÄŞ¶?K6rj¹.\Ù|\Ì2 `Â‹=:J\Z^\â]\å¨G³\í…{À\Ãÿ\0~¡´_\"w\"*¹«5DJjúùeÙ«)²¿0µº–\é;6\îøo˜\ç°\òQ[\áFº—ˆ¨l\ôşY\"\è‡<­\åZ\õ\íQ\ğÎ‹½®›\Ğm¡}3\ó)\Å]µ™Ê»Xˆ¢\õ¨±\ÇwÁBÄ®Wü…·6¹8¾%\ÙQB=-u\â <i\È\Ï\rœú@ĞŒ{8:\Æ\È\Ş3n\ô¼¶«¸ƒ^\ÚxP½¬	1}®p\ñV/\ËY&üT:\04–úUV\"*Z\Ù¹OˆF#vUy\ô\ì\Ã[f–Û£{/˜\ÒG(®Œ>S2\Ö#¯Ã§\ç\Æ3©K½3·¬W†\Å/U\Ú!©9¾\ó)H©£n%«ƒ–$	LV‘N‡øbjhb†D\Ë\à¼j#XXŸ\ÉIEFG~‘4›µ·\ØXmH\Ğ0[\èf\òÜ¡Qmt\é}\å9³&\éWi\Õ\éß¼ƒ}\Ñ\æ«\Ş_Àù0R¢Sœû\0ûê‡¤½2Y\Ó\Ç\Ì0†Õ’C‘DŠ\Ã\ÇÔ¿Šˆ\ì9Ô®p\ï7\ï\Ä\öf³†‹_¤kV–C—e¸\ô\ï€=2§€–\Ø$u\Ó@(\Z\åC±\ñ”\õcR*m8a«ÜµJ\à\0T\íy}\æP€\\À+N\Ä	¤\æ^xÎº.8´\è=\÷\ê\á\Ó*+i}ú‘‚E±t\á¾#iQXw\íw‘\Ñ+b2\È\ÕC€”\İM·\á…\óR”¹®Eİ 	2?\È\Å]5K[\ÎbON2q\î³q–‡F3\ñ6-Y\î˜L”.G¼]\×Z%	’\'»\Ï\Ç¬\Ö\î\×5ê«Ÿ¨p©ck\İ\ô\Ä\\’Â«ç¤¬\Õ\àf\÷†\Î\ğ}\å©\õ\×\æu4¶ d+uN15Ihl[\Ô\"p\ßd®…DQ\Ò7\ËFg$;`\å\Óg•\â5\Ãz\0º\â.€Æ¥ºÛ±\Ô;Y˜r™\õ€¹”\Ãt\ìr\æghB\êrteÃ“Ô ²*\Ø\à\Ã\ß\÷ŠA¥X¡’\Ó\÷SÆ—úw”&\Ù(–\óM\ÌT	\Ùn‡¤\á\ÓF1B\×\ÍW˜¨–´\àšJs\×ù5¦‹LEÿ\0×‹E½F)µka2X\ñ6G2B‡}JS-\Z\ï\Î=c­5OOGˆ\á\ğ@\Ìı\Ì	z—µ\ö:Na\ÊıÄ³)\05L\Ğ\ö\å\çY‚BÆ‡&\Õ\Æ\Ã5e\Ğ\Ç\Ì0\ÖJ”[\Ë\Âe:!nCÜ€%#‡—»Œ\Ës¨tºx—hj­e\"ª\ÙG\ÄqBš\çj„µ©}4zGEM™s\é\æ¤Õ•\ÉZ§¬C–\09‚ü\ÒÒœ\ïÕ¦\"\î\ê·\ñ\õVÁ\r½h\Øy53TT4[o&‹\í|N\0\È2w9¹€³¸«\Í\ã\0z!h\ÌV¡D\ĞUì¯˜XÀÂ´¿\\\Ç-­¢Z¯N>c•F§ Mj\ã\Ø[t‡\İ\Ç\ë¨}a ¬\à6\ä|/YVP«e¬s/š¡º\î\Ã\ÄX\ğ\ÖU4\Ç\Ş\ã2!VüC\Ï¬£\Ã\Ê\÷h+\0\ô\æ[\Åk6\ê\n\0]T@­Î–\\n-ª\ÊP2¯KU¾‡´6te\ÈÇŠ„†¼<\çP´h/şú\Çh\Ú@ \ëtµ\à½\Æb‘\Úl\Ù\ç\íb¬\ò{SB1 I¥Z)º\ÉS\å\ÍÄ°eÈªl\ç\ò_\ò6M \ÚyX^¯\îY J0D\Şû~!#†M–-•\Ú*\Ótú¿xœ¡À¸•\Ê:»\Ì ‹·[úÀBÁOµ\\k%²»\Ê\'ù-µ…Ø´3\Õ}\"©\0|#§¤c«¼\Ä4Q\Ñ‡¢\ä\Û\Ì-\È¥\Øø€UXqs0\ŞY?y‹¼\İ\öF\0g˜\Å\ĞbJ ·\Ğş\ßù*y}Ã¨ü\á„±O|´‰\íar}\æwªm°ƒ\Ã\İMKıoUV‹_UşA±:Ê®B\äO¢5˜\Ú=Êf©\î‚\r”“„³\Ü=!şŠªÏµ\Ã7Ë¦#\Ìd™V\Öû“‰}=şe	!V²ù\ë\n\nûEX\ó¸Ä¼/¼¯­E/\÷¢\'\" °«¥Ü±µ¸%ˆ¥\Ò d\îu\ZX(hwÔ³Ã–\\V[|¥\ğZ…\ç9Ä¦S2É—{Jn!”B[L\î\ô\×\Ñ\n³\Z]\ß\"º„H\Óq\ÃFœ\ë\æ\0e	œ\ÈZ¤d‹\èqÔ¥^+\\\é®7z\î‚\İ\ÍZ®„\ò}¢h€+Dpk\Ç\ö\Ã?rU\áª\ÏS\â^0ƒv\âƒ\êE\0\İÔ¡«\ÈdœGÑŠ\'¾gF{Xjeœ/¼\Ş\ìai\Ë×˜F\õ\0.\Ô\×xkh:+\ÒP3;¬ß’(Ne\à8\á\ä`µ”0\íû\ñ.\ö\Ş3€=\ô\õ\éQ\ëÊ¡h’3\à€3¢Ô»<L\Å\çZÑ®Á¾¾(Áü›$\Õ\í¦­3Bİ·\Ì*!”±K‹=\à+\Ì`®}\ã¯Hks£\Ú\ÅoHµ\Ë\Ó\Ş³ŠnÁ\è\Û)‹·Y{\0;\ó\é(P\ÃNuQA•Õ¦!³|Á.3\Ì\Û\0j–\r½Ó‹ù¡x\Ùt®à¤º+—px[¡/Œ\æZ¾ÔªĞ™°Ï¤Ñ°h\è\â8\Ä6‹·’Í#X›ˆ^§Ø—\Ì€’›şµÑƒ½B¯\Ñ\É\öC‚ M[Q<>qy\î\ñj®¥M\Ò\Æ(\ï\Ô\\Ñ˜\Z£H¥´\ÖX\ğ1\ÕWŠ\Ì.¨\0ŒD}#ø_N@r¿	Æe)·>\õİ¡N=\í\Û[¼úf.rÍ[\é\ğf1{ˆMcƒÄ°\É\âqz\0¾‘¼\Ğ[!`/\á\÷‚\Øv.\Úù%“!\"•\è˜g*wWšü\Ê5}e\Õ\×n\"0,±·¾78\Åt°»‡\÷0\\\ØgœL\n\ßZ…m=o\Ş	/\ÑÙ»J†eVg§\Û)_~\Ğ+7ü—7_@(\ÃG{\Ô8,·0c\ÇM›\ë£›-\í\ö¨6f•¥+˜\Ä\Ô0U†±\×Rs`\á:&³!bV\ÑnŒzK…D{D\" »Y)\0¹M0¡n´Ü¨\ïl¾n½ \Å\äW5ƒ1¸ø\è\èK\ÌYn\Ù\åHœ au«®İ¦P,œ ûû\ÂF\r\Û\Z7\ä\Ôp\è`«\õ>\æd\á¨\ád°¯\İ%\ç\à\ö^˜M>#ŒøDi7·¤»²µ6cú}’hr¸\Zr\óq­¡€±_\Ø>\Æ\ÅA”ZV\âignf]T»U0±X\Ë;Éª\é,¼¹¬¬µ·¡2¹)]€\Æ@\Õ\"ª\í£\óqªš\Ú<.‘3¸\åT\Å2›CM\ÓB¯\â`½ZG\á%ˆ[\÷‚m„~¤D\r\Ö\ã\Ğ})ºÚ¸–©rûR\ëK\õYI!¤\Ş1	\îP¶	ŒØ˜`OP%L¨”‚S‰‘™€\×û)³¡y¢\éM\î\0µ\ô.\n-\r]üJ{AW\á9\ÜCX¥«OYb\0†\Ñ~½¿“Q\É\Ìq¹E–<\İ\ÅU\Í\0^Z\öb2X\ÅW™ä®šˆ›™œBP\î\ãÕ¥¦¬/‹\0b^.7T\Í]JªŒ²Š£\÷²\Ì\Æ\å²Ø€\ä\Î5˜•\Ùo\ÊU+!¸V²\å[\ÑAø…©Ğ‚œ›W\Z\é\Ïh‘¶\0µi¢\ÓN³P\Ï_fú³\Âş\â¡Q„.€\Ï\İ\Är‰li®½\æ7\ZÜ‡—PkÀ9vu˜€ \Ç s®J³“‰d¸\ZT\ôƒ&WÕŠyÀ½Z_É§J\ôW\ğ¸ùH·—2ë¤’a\ÏÔ°©±™bî®‘\Å\Ë\Ş\î\æu\à#gn^CE\î€P\nŸR­\ó.†N²\äYœWs,\Ë\r\Í\ËE{sÌ¸¤!Œl\ğ(µ\ëP\0°›7Xÿ\0˜$f\Ú:\áseC«_¿k(!O\r\ğµ\Å\ôŒ±Ù˜ƒ#T\ğ°”^ÀJÁn\Ø\ï‚4n\Ä\ëW\É¬Dvc6–œ(\Õ\ÊV\ô±ˆ›5o®\ÑCÒ¢\Õx\è\Ë\éa4­A*­d)C\Íş#\0\\À–ƒ˜1ú\ÑXÁNú@%5¢9+>¥•\È\ÕÆ¤\Êbv\ÉrÁEÊ¦-\0|A!r^\ÂÈ¢\Ø7\"²d”Unš¾²\ê\ö`\ÜBÀeO\İ\ßSkT18¦…\×e\÷¿\ä\é\Íb„?q„!lq{DE\Şy%@ÕªP\ä\İg¸j\0%n!İ\\®d›¨J&(\â*@S%^Ó˜\n£<°’\ó\rA/I‰Ñºjx€`°hAe\ĞŠ‚A¯¸ˆ\n\Ñhü¼\Õ@Š¬µNU—™š»\×X\å™btqš\ğŠ¯šü—2¹‡š¶úû\Ê1\nƒ|K	\ë¢T\Z1†meˆ[°‚\ŞJ¸/\ñ\äi@\Ä5W&ˆ\ôtxP\æk,\â0®\ê:%S“1”\ïÄº…\ó(^‹Ì±¥°‰3\à„9™€ƒ¤Gm_¬a™:jeB\Õ\İ(\ñ}®0¿‰yşU\ÓAQ\ê`\ö•‹½ §£Zx\Å\ßFf.øTv&\ô\\{\n\éeŠ\à˜[]{@\Å,¸\ÕsuZ\à\æ\ê+Q›z\"ù‚H©o\"sÈ¸\ç?04<·±\àW¢\ÏyFÓ•Ê§\ÈVbs*9r\â9€\Ê\Õ[»\×ˆ@qŸ¥\Ón{G0º¨e¥‹5ü§˜¯EĞ…%”\ğ™¦\0º6û\Ë\ÉÀú\ÅS\î\Ã\Ò5œœ­D\Z\r¨‡sb‰T\á*5B\Ä\è²\å\ÌE®\ÄDbª\Ä[µF\r\íy—€\Ô3°\ëÁ\ßKÄ°f\Ë]‘®\Âd¦SA‡£‚n¢‡*\â£Q’ª\÷§\ò†\å\Ê\rbÓ¢_#˜Q§`—eaÉŒù™^\ñ\ÛaY\×­G[—9\Õ/\Ê*\ZVøÑµx\èDNUs®%#4|\\Jb\é	´\ài•\÷?K\Ğ\Ët¯øOh+°\é\ĞcqgH}\ğ\ÔTL!\Ï\á:\ÔPcš•@­¦_¼¯‚¿”…C$­md\è#ø@¶:J¯’1\Æ\åÃŠœ˜ƒ|v3™`\êÀT¬3œø‡\0µ²	+N,a…-Ÿ6\Ó	JD˜tU\Ò7—®@–\ìş\Ï\Ò/\É¼\á\Ät\nR\Öfj3\ÖgLYK\Ê*ä¹…É¯0[”—™X¬WI\å\Ï\ókå³¼>\Â}#;³\ó/1X{LC	\ÇR\06CBd¸F\ì2@\êZŠ–m©\Û8—nPŒ_\Ú·y¶À\ë±1?RV\àO¾!\è2\Ú1@¾\Ã\ò\Ê\Ä\Â{,,úƒ1Ì˜\'’V¦N‘ˆ˜\Æa.Š×¼©­P\n9\Ä\ë|Fb\ËûV¾RU6Ò¬£`T] `R‹\ñ-\Ö^X7\Ğe\ö%5\Ì‚ø#rp5’]+\n\Ê…Ã©1³6{F\Î¼†\0 iˆ\'\Ë\r\å2¬-6—^OH€L¢œA‡f_“\',\0\ìV\á\"¶¬\í—\Ç0C6-x‡E*ŞŠ¿Ÿ©zşq½\0ßš{3•L\î\×x@,(A6q©UŒºe\\•Å±,2\n­$\Ş\0À\\]„¼g\ó7FûUc\n{\Ê\İb\ò\Üx9nT¥®aQ)»©SJ3f&yi\ĞúKt–°fAP]e\à\ï@1®z¾­¿\Ï9E¯Ó¢\ËBX»²a1†o:\è~¡A°T]<\Å\Êh\İ\æ*T\ñQ\0I\ÖY\ZªH•®Ä¥Ö’PhY«”\ÕA\í,\î°Ç…T†o¬K.7q*\ày€Û¼\Å\è\ËR¼Æ»N\Ì*k¡\ŞmĞ‡€\å´É7üµ¨>ÿ\0;¬a,›\é¡.x\Õu,¦ˆmD¾n9oºm¢» \æ“¤:7qP;À\í±ˆEÙ¶aQA\à½{\ÂP–‹Vñš‰°#‹–ù}%Bª}\Èh\È\à\ÆÒ™9\Ä\å]J\õ}bº\\r›=%\ã\èT.}À\õ‹[•j\Õ}\à•™‰6\"a=\Ã$U\ó[Së´¬T\ípoùnSÂ±¡‡-K8\Û\Ü±~B1Sgy\İı\Ä\í«—\Ú>—\Â\è\ì‚\äPdN\ğT\0¬iÀ?F\Î!%¸ú–-a\ïsƒªa ˜\éˆ\Ëş\àj\á[ˆf\Ñ7\Ì\Ğ/!¸7â³˜‚ª-‹§g\å—\Ë\õ”»¨±­\õ—\Í+\æ2\ò\Éc\Í\Ù/(;–Š],&%\òXe?3D®\ğ$n)]‰\ÛÀ*c¡P\ßZ\í4)¡\ñl<“\á²^AO\á…D¡6>Ä¬H ›±^›{‘’–“¿YWC%\Ì\â\âooXj r\æcºF}º\Ê:h\ï\æ7€;\0E\î\æº\å\\«QÀD}ÁG\rc9€)Y«\é¥˜+p¾y€¸º\÷\"XNJ\ë6\Êy\ë.pµª¹„\0·S1vÀ\"–â§£ùŒ¦ƒº4\ÆKÑ›eb\Z}³-¾Ò«B\ÛP/•\÷Fº·z\Ã\Ú Å±xƒe)º\Åys¬…@…¨^o˜=S!\Z¯i\\\r,j\õl}¹€edš\Ş/>¶w!\ñ\0\à:D\ßş\òÀ\êÌ¼\Ñ\ÙKŞ¯u\íŞ¡\nü\ÌzB»´wyˆ­t-ùƒ»–J\Ì\Ò\Ğ\Æ`;.\Ñg\Â<<ÿ\0R\ëÔ«­W™j›]²Â“Y£O[°H\Í=<©ÕŠ?H-£Ù¾L›–‘\ÏÔ§¦W­\Çw¸P*²{Ä¨©nS!€¹\Şú„\ÖqÁ\Öt\Å\÷.å®»Jª>8Œ#\ÛÛ¤±Kn™¼_C\ç¤T\ç»M\0Âƒ\ò\ñ\Ú+\ç†\ñ£\Z\Ë×¼2‰ZüÒ««rfWr\èj4\é\á|ŒV?\Ø[&+©‚\ÚZ˜\ÛWce=\à,,W!vz\Ù\Ş\ö³Ë°Sÿ\0HS¡½t]\ñ‰x•¸d\Ö\åxƒ€+T­E\ï*ß¤dp„…9\÷×¼¢˜|\ÇC+& Ñ¯š9\ìˆ`\èW\â5±n€¹±i\ZK¾~£}k.¾f\õ\ñŒø“\ÒV:\Ø\è5–\à\Æ\İ\Æ!\ö\ñ\êÒ‘7c‘‰Q\É\Ú[\n	\é„%\Å@¯odeª\ÄùÄ¹–pÒ£c³\ï\nºM³Lq9[\è\÷˜\ó ¯±7\İFú×¤¸I{³j\n\óc£úŒG\'B\ÏY\Ä²\êÿ\0@ˆ4V}&%l\Ş:ı{Ë°\nıŸW•†µ\n—o“’¡BgOù0\Í\É\Ø]>¤»·\ÑY\İZ¾<Ã€’”ø\ÉùL„4;&?üª\Ël3@Ó“½’7te\Â\Ê\êEs8icµË‰FD¿Ü»t\Õ|B\ô¦ •GYˆ\0B–\Ø(„h\Şjl5^† \Õ.Ü¨­l§-k\ç\ê=Œ¹­\ÂÉ\à±9v\ÍÃ§+Z‚·w·\ÖT\ê\ÛN±\î~k©úA<\ÜMVm%p×º\ö¨Ø²\0P\ê«_\'0½o†eœ<«fk\É\ËnTz\ÒZ%\äe,,Y¹`·\Ö%7¢\Çü µ4®	”\ë*BªYC¬fA¦\Éü)BPgc\Õ©K\ÖJj\Ùq\î\ËN¬9ˆtU›34\ŞFË•2\Õ_¾s\Z‹\ï\ñ\Ùÿ\0!´\Â\Èi|Ÿ½fW\Óç¬²zŠ\ñ\É\í\õ\î-\Ùû\õ=}\åaµ×§\ïH^PTz§z…?`„Á\ò1‡û¢\ÏiM\äBk¤6a¤ú%s¸\ñ\Â\ÜĞ–ù\Ä\ós9f\î\Ö\æRSxr\ôZE&\è\Ïc\ë\ó\0F\åS\Í\î\rb²S\â\n*yn+\Ï\Õb8V¾\æ\"Š\×V/\Ò\ÇF ¡3ƒoü\ÄÖ€\Ğ\Õù†»Iº\Ê\à‡n\ç4ºƒH0\ÚHş\Úä‡®53@o1BLKÀ#ƒ1HqQ5q\Ø\èX\öu0\ïL j¥&w”dvz\r{«A\é=\ÕjßˆŒ-¥\äO\öZ\Îø>±%\ã\õ)ıCv\è\ìÏ¥FŠÆˆ:\ä\Ï\î\"¾pZ\Í9=›\÷&ÁÖ·\ñ-;EY˜¬\Z\éÿ\0~\à˜°<H.\\\ã8ÿ\0°`&ÿ\0-J¢)®§S\×\÷S!;\ó\Ï\âoJ]Zˆ¡\ì„Y4Æz\çˆ½V;³®\rRfUv0j\í\çû†ı¤4ux›˜4\Än°k\÷Jl¾&R±\Ö\n \ŞU\ÍNp9~q\ã\î\İ8\ÏC>bV•ü”3›ÄµÀ®Pùt\ë¦(–0°8\Ù\äTW˜z\ÃcgD^(\ç¬\Ç-±\n/¢9;Ç¹f!Íƒ©\ÜËµˆ\Ä\ò\"\öM°\ç\ÒVaÎ­0\ØK–¯Ö¸\Ç~%\ÍZ\Ü\nÁ\'Š‰t¸¹bj8¨\Ô\õhµ\ê\Ã\ğ[\Û/\ë\æ\\YB\ó¦\ó\ï	°9d\Ô(X^\ìsp\Ùjt\İ\Ì\ä]~Ê†²6ƒUb\á=BX8\è\ç˜â¸\é\Ç\Ä&¢‡\'\ïh\Ä\í\'B\Ô\ô»”oúù™\àLŸ¿¤*Q\àşıÁº!gnk0J<\Âß®e\İxÃÚŠœ¶®\Ü~\÷€\0¬Gr\Æß»‹H3m¼ºø†”;\æ\ğ~²á©uß¹–fN‘ˆ¢Üù¸Ô•Z\ÉÄ©²p\ôûıJj¼œ|Ì—¥¬¯ye°8»Ç‰v¢\ÌĞ·úŠšmµ\ËıL\ï\Ö#&\0¨\r\0\ó(vú/‹\ßD—\Ü`P˜ß¶X4%´b¨,\0\Û¿ \Ó¨ŠPK,CAË¢\ãfƒ6@ÿ\0¡¥N“S[zB\éËºÆ e‘\äjsˆÏ·PªM%9R\r,¦+\Ò\\¸F}£Tp@¿µº\í-¦G\ğ\Ê”Ã¬( ½GÒ v$@Qn¨­‘\Ø?0\Ö]µ\Z;\ëˆ\Ó\è½^~n¡_e~\ñ(~C¬¥YN\Zwı²\Ú\á,1£+¼3.Üµ\Çü’”m¿\Öec\ÉrœûD´\Å\â\à\Î7\÷-³‡S¦D\Û\\½>¥€Z2±{kre–\noû†E›\ç™q\×,v\â1,\Ğ\ÒT^t‰¬\Â%T¬:\ÂW\Ä\r`£$GT®\Ç\æ\n\É\ğ{‹œe‚\ér~e*\Û\Å\è¿%$ª\Í\ÎLd\è]\ö~ \Z\äbc¾f5¤Ú©z2\Ã‹Œ\ĞP*=ÛŠ„H ‹U—=U„²H	(-\Åˆ3\ÛûˆP´Y½\Ü#;Rd\æ\í@V5®Hf\İRŒf€Íª\ö‹²È»[\Í\æ”HYg‰¥œ:D„£AjFAvV\ÙÅœ¥.&5)a\ÕAµRÖ…\'±[.©\0(7W\ÎÀ\óg²È­ª\å\ìtFg\Şo\ôÀ‚\nq‡\õš\â\õ\Ì-\ZO|L<½\r\Ø=\æ	´S\Ï\Å\ËikX\Ü\0[Iƒ\'X&Ák|4‘\ZTƒ9Z\Ë\ïr©\ô\éú\Ä\r\Şøş¥qVc\í+\è8‰«\Ï\Ï\ÔE kEq)\Ûjøş\áßµPgú…l\ßp°ÀW58¬¶\æj\Öx1ÁC?¤‹\0\ë9¸*\ì\Ì\ZÃ]ı\\]—\Å\â2°g’ß˜–…Nuı \ĞE\Â\r°( {zCNVh\Ç2šI*\í´ü\Ê\õiÀ_U\àJ7YH€«,\óm\Û\Í\ì\r£†¬Ì¸¢\ä”6” \r¬¼Ì¤ ¨¢R‰¦\nK\0­§w•{G+\à2Mª“Àv§¬dŠ–²Q$M\ØÈ€[‹\ê\ó<\ä-¦,ˆ´¨˜\n(0ªz¨r\Ä\Ê\æ\ØkÑ‚]ƒÒ“\í\"\Ò\Ñ\n_‡©û\Ú”°RŸ\ÉªŞ˜¦=Áe`PÓ˜€i¶\îcU\óûKÂ©\ë¢\ŞRa²ˆÙ \ì\ì\ñ\ÑX9º\Ì\Ü\ZP›¹°+©3ù!rJ\áÿ\0k\ŞX d\öÿ\0.Wd«\ïú„n%\Zn\n\æ\Ï2»b\Ùk\Ş ›Vº\Êİ­	ª0EŠÕ¹3\ß\ï\â	][\çş@³tµ\õCı¯i˜\åJ­9\ÔC½‹Š!\à¾^_x\ô³\İS}v\ÏSd·\Ôgƒ1b\íÇ¯1»/Õ–\Ğ\ê\Å5ZÑ³\Äd\àİŒÿ\0\ß\ê+Áqi\é\Ìg\é“j…^\0ÿ\0qS!;`\ìv{A\á\î609XŠ\Æ\Ø Ù²\ÄEº\ZËŸL\Ü\ÑF·(\ïª\ÆLh\òúF¦\İU¨R¶\ğF*\é¿1F²’œr=­·j8#Îlq¿H\njH‚ƒ£\Õ \ØL\'5f\×Õ—ß¬\ï8şn>Ÿ)m\Çn¬a\Ëmpzøı&° ­ù›\é£V½{)\õ7H_\êF\n¥W_›#(\áÂªş¢G‡w\İw‹\êP(+¦¯[™§RNz!\ß–€\0=zı1§vJ\æ·ùaaš°\×\ë´\âV]Ác60\ïÌ¹Åœ.Oü0€*®œA-Ÿo\Ô@X(F3\ïÄªK\ğfpes\ç}!—¨—	h<9~n0&¹\ß\Ä(ß£i\×_1\ñ@\é\Ğ\ï\Õ3À_F/b„·‚Qv\ÌAP\Ï\n`Ò­\Å\Ê)V%ª¬,_qz\×}ú2“\n,rœ—\ó\ï+´©\ÂuF©~e² ¥ÿ\0Á/\Æ\ÓzVš²•…\ğ\ÊL»j\àoF\ğ,¨Ø¼‚®\ÖªÒK\Ê\ê*mii¥¼\Ì\í#ú:^\\º\\w\ÄRR\ä¡\Ş\Ç\ÆZ@qˆir†—–\Şe\Íe€\"–Ò©0•:|\å½F›]ûE\"6¯{¿ˆ\É+l·\ä9:Å¡R…©;LM\n\ğı”\Æ\Ğ\îŞ¿»€\nS\Â^<ş \ËQŒ[??µ«\0jŒyY€\ğ\è\ö#|ti\Â\å-\ëX´\ÌşZúb1l²ºŸ\åÁ\Ìjÿ\0\Ô+l«d6B»¼Œg¡UxÌ¸<\Ü7‡\'\Ù-\0.1zÇ´\äƒ,’ù¯-ZR\ğ\×\ÚT€u/OÚ‡nØ£Œ¸ş\à–0Z¼¿\êeÎ¡9¸D• ]q,X*¹g\Û\Şc\ë\Ñ\÷*W‰›\ñ9lÎ\õ9Áj\éo–\"\ÎıT²s2\Ù\à\æˆDl,\rSşı\ËN\Ç9¼^°‘Ûƒ¬\r¸k\ÄU©\ò\ã†iÌ²\å™vJ¨Á†\ÇV W©9Œ¤Ÿ\ón\íE£1’;!Y\õ´\éF˜Õ‹)Y¬¶FıÀ	`\ÆBha*\ñ	{\æQ(q½À…ªg¾=˜¨\Ñ\ĞM\ğ!«\İ\ó\n\àa‹|±•lw¾ÿ\0I^¿<)\Ãd¯CÔ¨E\÷‹†/–+\ä.£:W£\ğDe˜Düb[*\â‡“FUa\rµÉ§\â\å´\\D›ºùŒ\"\Ë!®°‚¥\'\Ğ_˜‹‘kP¾z^?Ød\Õ:\Z”›t*9\Û\ì\Ù\é(+O2‚\Ìzûp¨PB«—èš¼¢\Ò\\˜\×O4ŸEÒ¸a¬„…z\â\nƒ8ùbQ±\í²ş!’^½†\ï\ö¢\ñº\Õ\Í>•3 L+]½@^ı\àaSf”\ñ]ø\õƒG!w[®c;@!\ó\r¼šœV\ö>±R–»Šÿ\0¶^\Ú\ã«C\ò`\õ\à$)ƒ~o:†Œ$Q  Ê…§tT2‚\Èb¬šE²\"Jü\Â*Ò¢:\× §pˆ!\Zšg.…\Ğ\à@}\ác7RŞ¶z\nI\Õz©w€f\Í\ò&„‡\å\ï\r¥\á]\Ôj‡p\0«3@\ä\İ;r\×h‚ˆ,¸^\å\Ü¡\è„q¢µ\Óı\Í©O¸Ô¹\êÚ¿¨mBh\ê§\î#È‘*À\èvŒT\Ğ^Ë„b‘G\nYgš¹7\İ\ñR¹\ÍÑ—\÷´½AªS\ñ•¥[­\'\æÀ\Õ\İs9Î€\ß0`‚(^Ğ mh³\Úf\éUz\Î0\Â\ä øxƒZS\ê\ß\Ş\ò„\ØC\õø€°\á\Ø[Qƒ­\Î\Ğp}D’\0cù–\õ%İ¡\ä˜\ÏÜ’WP\0Õ¢(\ä~|1\ÎF=s\é„\îG6°a\äx†¨ \Ô\ä¿\é¹p™U\\\×\ïi\ĞUø?²ı\ÉkSn;ÿ\0\Ùn>Qüœ\ÊûXmÿ\0À\îúq\Ä4Ö„¦*\'1§c\İ\\ø½\Ğ.y&` )t\Û/1\ÊÁPˆ!ø‚\0G¬\Øü‘Nš¶œ+\ìBB\n<ûú~#{”\Õz@Ş²µ9©hx«‰Y\É\Îs™d-¶3¯)\ã\÷R\Â(¹_\Ú&M,İ¢g·™z*9\è\İÀ\r\ÉbE6ZO€‚\È\ë\ìyˆœZY=B\÷„\é@\ì\ê8P\Õ\÷\Óø\÷‚\ê&¢i\÷{°4\ŞU\á“ü”?1Y:4\Ô«•ªXbÁE\Ù•­}R—\ê\Ã¡T\ñ\Ì\Í\Ş\Æ\ì3ø€J\òµ–\Â;%`×¾ş*%Ñ»UıÔ§xQ\å\Ñ\ó2–±\0W»{\Â(\Ìp\×ü—°\'M¥\Út\è§¨¬\Èt\Õq\Z\0¡Íš©E)\Ên¶\ö\Ä\ğx\İ}%O\"\ñ\×\÷¤a%^Ş\âb Éª\Ã\É\Û?\èG\ä\\³«\0}\Ê\Ö‘\çµ\Z¢·\âu=k<jz\ç\ÌvÑ°…\ÉZ9 \'Rˆ\"–02*\ê:Í¼ÀÁ\õU\0Ê‰Ö©œ\É{E\á²\Ï$¹\îf @.},úF	q\Ğx?n(bif¼Ÿivœ¸¸ÀCA\Ì\"\'Gû¿Y¶„\Ú8?>\ÑÂ§€˜Y{\n«Oı0\îj\å\'u˜\Ü`\ØY¯5\nÑ‰jb›ş¥Dh”Õ˜¿jˆ\"\î\Ëo	ÿ\0\"´A±SH\ß\Ğû±^\Ò\àÈ¿·\Ô.\"iMúCª\ö‡œ_\âa\r&%ªZ¡\Ù°AŸ^¾ÿ\0\Ô\Ù\Ô51¼Gk\ĞXj\ê+\Ë\ÊU\êi3„=wû\â*µmnº_\÷\ñ8‹U¾‹‹™1R³\é-Åkˆ hÀ—ùŒ\æß…™\óP]f\à\õ/\ñ\ó¶–\ß6¾\ÏX®åŠ¡Ğ¥øeù¬\í©‚z\è\àüü*-•G×ˆü\ÅZcÉ\Â\Í\Ô=K»,#VÂ­\Ú\ïEW1¡€—Á‹¡bÙªL³Á–>cf@\Şu\Æcb7\ÇJşùbhD1[\Ô\×\Î@¸D`¡µ®b­\Ëmù˜¥»\ÊË¬Ä\Æa‡H”qt\\µe•\Ë8@ûU\Ü.³V\íWø‚,E‚ü—qc©L\Ô8\İ\Zv¼\Ì@¤=HOy°o\é2…U\ö„µ\0G\Ü›Eİ‘ş¦¡Š<[œ[/\ÆO©UC#¼v-Ÿÿ\Ù',0.000,NULL,'2023-01-04','2025-03-02',NULL,1,'2025-03-04 10:53:46','2025-03-04 10:53:46',0,0,107),(2004,'Aravind Kumar Talluri',2002,NULL,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0\n\n\n\r\rÿ\Û\0C		\r\rÿÀ\0\Â\Â\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0	ÿ\Ä\0N\0\n\0\0\"!12ABQRab#qr‚‘’\ğ¡¢Á$3T±²\Â\Ñ\Ò\â4CS%5Ds\ñ\òEc\áƒÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0-\0\0\0\0\0\0!1\"2AQa3Bq#4‘Áÿ\Ú\0\0\0?\0ú “9_%\Ó\Í%»r\ã’\0]‰~\\\Ñ\ØRS“ ÿ\0nhÂ¢,\Ù\õ\åÁU0\èr\ñ\n¼\ít6\Ç{²£a\ÅsŸ§5b£>ß‘q\Ùú\É\åÔ®\ôr4€¨8&c/u \'Ô’\Î\ËH ‚ˆ°A\0A\0A\0Dbäº€‚ \0‚ \0‚ \0‚ \0‚ \0‚ \0ÒŠ\İ\È\ßJ\0\ê €š;…BW\ÃÀ”\ì*2´X€²]B´5\Ãdaµ”\è\ğUjy·r)\ê˜ƒ$3‘c\ÔApp ‚\0 ‚\0 ‚\0 ‚\0 ‚\0 ‚\0 ‚\0 ‚\0 ‚\0 ‚\0 ‚§\ßA#8\Ü+2Š§ª?¬b\ã\ó&ş\å–Iÿ\0šT~5-\"İ¢{‚ºĞT\Ìš\õu \Ê\Õ\Ë	*%\ÔQ–\0‚ \0‚\árA‰\0usÂº¸]H\0xQPF.H\0¨ \á@A\0Ai‚œ	\Í\íQ\Õ;EO9…ı\ÂN•´»Qb¦\ÒQ\Éd•M¹\Ø\òraúVc´?¤%F15\àQ\Û \Äw•¹g§¹\Õw|*ªr\è\ô\È¶fl#\ô¤ºŸş\ã/bÿ\0¤U|“\ÑÖ‘D3’r\'k\ŞÛ›\Î\ÛT5GnX\ìÀR\ÅS \Ú\Ú\Æ\ç\ê»\Åæ –²ú-CClú=¸\Õ\Ô\åvR¤sG0]1¹×‡\èûh\Ú=\ìO\í²d\ä\'\ËW’°A\Û\Æ?‹µLFYWŸ«Áuk«c¿O¾\'°½y\ãf?HÚ\ôQb°8^v‚Ù€}n\ö\ï[·\Ø^\ĞG|S°ıgV\ál\'\ÑJ\Ê\ç[\÷¢Ğ‚\àf\Î\Ä+ªR#…\ÉF×“XJ@‹‚ŠÄ³°—Q\ÆCGÿ\01\Ê\ÇA\Ğ<v˜~yX\èGBfG\ê ” ‚\0 ‚\0 ‚\0 ‚\0 ¹r\0\ê € € € € € €\"\ñ½4\åÇ¹eeÿ\0™O›\ê\Íj8\á6ä¾…•\É#%+{ÔµüŠ¶\öXpRù\Õx &µP°Y-™^¨$\Ò9²\åƒTJ%\Õ\Æäº£,@.H¢Hë– \ÜH_\ïFµP\0H\\Š‚\0\"TM<e$†À-\â%W\Ç\ö\êŸ£–W0€‹#•ú²I)\ÆŒ”¤Y§¨Š•³\Øo\ÛjjMšK8u\Ê\öÃ·,?\ÙKwP\Æ\\uÙ¤[Ô²\r¥í†1Üµ›\àkÀ\ñ\àGk~\ÑT,\ÕŒuéœ¹fÉ´ı±7³„t\Æ\Ç9\ës\'\éşY´ı°<Õ›\Ø\õ	‡6 -78·z\Ê\Z–¨\Ì\ŞRİ›	sQµ~\Ñ\\9G}½6\÷eşj“±¿‘©^•\"Õ‹\í•n\ĞM,²\ÈvX\"Kgı\ÕU©*š£¾#‘\Â\Ëm\'¹?y#‰\Ü\Ï!\Ò<…?§\ÃN9\æ\ÛO\áU¦zx•ªx\ä—7r¼mVZ-\ã½İ\Åù\İ\âR;–‡†M\õb\êuVVd¿\Z”z\Z\ÅKnm•\×x|‘\é\éZ\ÚPlŸM\Ü’g\å\é\ô¦\ï]s\Ù\áK\ä%\ñd±Ğ“­\ò\õ:³a¸£\Ó\Ø\ñL\ñ\Î\í“\"üÚ³h±„³fq\òR\â\ÌVfúıB\ê\İZ¥;t»û=?²]®OJ|lQz‡\Â\ËV\Â1\ê<jœ%§‘Š\ñº\Õ\ã\Ìj\Za\r€Ëº\å¤l~\ÚTafKK\ÅşŸ%·Mû\Ï3©ÑºùG¢ŒndÊ²$™l\æ\Ó\Òc³G\'Î·€ŸR•š;•\ã-•\íİµä§¨º]dvi\í§b.	$˜»\×RA\0A\0A\0A\0\ÂäºˆY \0…Ä’r4?4\0»®¢û\Ñ\Ğ\0A\0A\0A\0A\Ç\ä€ vŠka<–Q¾r\Äe\á§5¨mg%9ä²©\ó6RW\ÙV\Ş\Ë	#G{ \'sY\ö%Ó³t«\î\ÈxÜ»?‘\Ú\É\è\Ê\àGH\Ó\òK(‹ A\0A\0A\Î\î(\0¯Ş˜b8´t#“5\ò—!M6‡i)°:)g–F\ó^X\í³\ô‚l£\Ø\é+K\å\"S\ÓBw…\Ùı¢ü>¥RÛ¶\ñ\Éc^\óK\Û\Ş×°úB9kdga\Şn²\ê~;°ø\ì\ã\î¹ywl{f¬\Æ\æÂ2&=Fÿ\0\Ë6Ÿo+6ª`W}\Ğ9ˆ™?>§úI\ß\÷“z\ê>†T\\e/t\ÍJ«Çµl3¨¬©9\å=RÇ¥IVS\ÉPÃ›\ÜY\ñ»\óÁ4À¨\÷†cY?\Ï|¡Áâ°F¸²\à*œ¬\Ã5««‚¿‡Q\É0e¥üYd*\ÇqGe\õx\'PÓ´o\õ[Ä.›]\İTs/Æ±¶\î8x3#<oÂ¸r<œ|<\ÒfVı_JÌ±’g´]¼\ÒGPe\İ\ö¾$Iø\ğ\îMe™\ÄI¸¨2XH_?´›LNO˜» ‘;²D¤¹\Éş\áFIR›2\á}¥——´]¤Ş¤r\ñ;¦\ò“	[\áRdf‰jBJr½Ä•\Ë\Ú\É)\Èw\ö–t29q\Ê\ëR\ô\Õ\Ï“qÏŠš»eU¶…5\î=	³ûht\õQKO+	wwd·\íŒ\ÛH6š#6\Z¡mC\æ¼A„\ã\Ş\Î\ã›ı?\Ò6Kl¦\Ã\ë\"©ŠW½µ5«oM«\İ\í‘\å\õŸ·\İ\ÕX€¤©fµ²Qx\ÑE´\ØPTµùk\î\ç\Ö\â\÷D\ó2\ö²b›4\ì	ˆT-5stº’‚¡‰q£©\äv‚\ãj]J0A\0A\0A\0WW’\0H…HR(Š\0U»‘\×’\ê\0 ‚\0 ‚\0 ‚\0 ‚\0…\Æ!\Ş¶k#Ç£xq®z–\Ó_,“m¡qˆ¼I¡\ò µÁ$¶£Š¿a²6C’Î°Ÿù˜Öƒ…\ô‹ejy‹‘`¦$\í4¥\éN\ÔE ‚ã•¨\0®V®Œ“9\'5¨\ÓL\Ù*\Ş\ØmLxQ9=¶»©L…@\Ç§#\Ø\ÜK\É|ÿ\0ı(;h¨\Ú\r­¬ \Â\êJ\\/r‹{½®o\Õv\\\Ä?eAlšXDYxv\ÃúAOUˆo(\äc£…\ß+sq–V,/wb_^g\Å1ÊŠ\ÉI§)MØˆ\ä7ÌˆŸ©ıüR˜%$\ÎrNw5\Ö\ç¤]ú•ji·‚.o¨\çkQ.,NıFıY«\î†œ–F\r«©\Ëûª€€\Ûqf$üVÅ³Ô±\Ã\0_“·\Ú%GS-¦¶–9\'°Œ%©À2f,¹\÷«D\ÃË—reJ-`·‡+“¢‘¤á«¦ÕŒ\æm¤\É\ä\ä\Ús\óM\÷#\ñ\Ò=\Év\ÈDYü¸’k!q&\ËJ…²t‚”xøG¹3’GÈ™\í\Í99\áfÿ\0êš˜¾y>bD£e„‚™7/BëŸ‡S%m\ä\í\õ’a\ğ\Î\âJJ‰\çß©62}Yi.\äû†¬Ù‡\áM‹»…¹ q“\õ“qE!{G\'ú²\Æ\âyf\é(Åµ\çÕ’d8a\ÒgjJ ­\îø‘\Ú=\Øf\çp»Ü’8t½_Øºs\0k1\Îß¬¦0}¤:yG3·\'Ušİ¹fú]4i·g¼lıâ¥Œ¶J\n^\ÖzŸ²nĞ›¯\İÜ¢3´ÿ\0Z\ôH\È5Œ±»\\Ä¼²;@\ô\õ!™½¬\ãÒ½\Ù6\Õ|±…{¹obk›zW¦\Ğß½lg‡\õM\'ù\"]œI?¢ªr·Šg(²$Y‰­s\Îg³C3“\n\\y(šz‹{ÔŒ2]Ş¢&LY@ÀA\0A\0\\.K«…\É\0¹ <\Ñ\\‘˜ˆ ‚\0 ‚\0 ‚\0 ‚\0 ‚\0F§ú%“\ö†-d\Í\Ô\ëZŸú7Y_iy‰Ó»zø¦dV\ôE`\ä\Ş\ÒD\Ã\ò\Öe„ImH-//›I¬#‡È±Ó\á6„´ŠYFY‘2t{ı\é7\æ€”¸&¯™p\ñ%\æQ˜\Ö$.=\\‡`\09™|,•½«p\ç\é_\Úuf\Â\ì	S\á¤1O^~\Êò”–·yjwRùßŒ\âM+G#¸\İ-\ãú²^…ı2v²\r ©\ÂcŠ \'\Îi¬mF‹\\/\åu\Â\Şn$¼\ÃQ\ó\Æ!\ê\ôøUX½ü– °\nÁ\ä\ê}Ü‡-D\Í|\ÂM•…™\Ú#\æ\Ù0—\Ò_\n„y­—¡Ú¥75T¹\ô³80ı\n\n\Ùß«;”äˆ¿lŒl%“¾¾ÿ\0­\é[Î‹\Èy–e—‰d[˜Ie\Ş_\æ¶l\0Z8G=f\ï\Ò+Tù7\ô«‚\É.-Ã„S¦\ËO½¼)10‘;›%·\Íh;7R\Éf²\İ9&s MÄ‹»ÜœM!gŸÒ™HO\Üı\Ş52M®Ï§½Y‹&\î\Ô\é+ŒG\'v¹s}lœ_Ÿ…):\nV—\ß\îE\r6¿¿\÷Q„›<œ¹\"\ÈV°¾w]\Ò+˜0t¾nÚ‹Å’$Ù—™\ò\Î\Ô[­\ã\Ó\Éta¹\å¨2¹*p(²\Ê\Òø“Šœ\ò,¿\nJ˜½ 2±Ä‡N®¥\Ü‘ga\à\'©\nˆ\\C•\Â\ÉÁR\Ú\÷øm\â9®”6YÉ°6Jı|gº\Ï,“\0›ym\Ã\×o„T\ÜĞ¹FY\ô¨a…\á©,\ÃCfK¨‰Š\ĞV==@³;\çŸ\è^\Év±\ğúŠ9\Ù\Ş]\Ék,ü\êüú—œ\ZKf´­bq¯g€Y³.-˜\é\ê\ğ«úi\ìL\Íu^J\ğ{¶9‚ª)c{€\ØI‰\ÅR;!\ÚÀÇ°B£7}ü\Z‚\î\ğ\ô«\Ñ\ó^¶\ß\Ç\Î-­\×7v­\êR\ÕM˜¶j%\Å/KÖ™¡ \Ër17J&”…¥;Q\0‚ \0‚ $R$½\Ğ\Íù.4\0\ä3GI‡JQ\0A\0A\0A\0A\0fº2YwjQ\ÛM\ç\ÊE¨Teº|\Ö_Ú¡ac›\ò1\É4{DV\ôT°©¾xi\Ø$ÀQN²<2mb´¬g‡55ˆŠ’\ëO\'\â\\¢i¤l‡Š|26J¹hX‰\"d†\ñ¼‘\\™\0\Ê\Ş9\\±_\Ò?´øv3g\Ê=\ã\0\É\ÂÅ¯\È@{³7ı\Ü\ßÂµ} \Å#\Âp\Ùj%“u	—“/™½´\ö‘Y·›k[YS9”9„1;ˆp»\Ë<˜U{y\öÖ¹+¨\í…f\×cVTd1SS=,¶ˆbkˆ@[“ù½Ê\Ğ\Ó\î\å\Ó\ğüI\Ö%T\òR\ï:ºµko40|Gs\ĞË©mX&\ZR\È\Ğ\Ö¸\İ\ê\Ô7\íLœ–m¤t£\ïI¥p\ÈG7PjE­\ò$\Ã\Ä\Ò\ö$Z\ñd\"\ßO\ç\ó©k˜h°ˆEP\é\ôÿ\0©e‚%ŒE›d>®R\Ãcx\ÄD\éMş\æX7\öo\éŸ‚\İ\Û\Âş<¼Is\ò\ÏWMª>G)\Ä3¸¬üÓ“š\à#f\Ô_º³Z5 \Î\ÊZ&µ78Û“wx‘\äÌ„Y¿_\Õ\\}Nş\à*&XB—&\È\ÒN/\êNx7fú¾$\Ü\ó#½İ­\ô£©\Êû‰\ßı©›|HºSÇ\â7\ê\à\nw·\Ó\ä¸N„\nC¼3\ğ£]s‹g\É.\"\ñ\ğvbEÜ€–y~\è)“\ØFù–\\…)µ—\ñ\ã\Î\ß\nWr\å\ÏW‘Gh\\GƒZ¤L0X®\İII¨2\÷\òJ\Î,:\Ù\õdqh\ã\Í\ß_Â¤8\ÖH\Û+$£j)\Ú\Ò\õ\Ãj—!	˜~¯Jk58H|È›Ä¸Î•ÊŠW,š\ï\à§vvkHƒ7\İı\ßÚ“z]\ç\Ô/©+…P¼s‹·ŸRVù!µe‡cûTXN=f\ö6›s\î~®\Ô4€&p“\\\Ë\Å/3\Ò\×A\Èx\õz™z\Ë`qÀ\Æ0Hµ±io¡z\r™X<ªS‰\ïE‹Ä•€u\nH\ô¡Ö¾Nµ0`\"z“\åK3z–ˆ®,£¨ ‚pù®¤f&\ô\0C“Ş’9=\é	¤o4\ŞI›Ö»[Ö—4#š\çQ²L\Å\É	­\æ›o&\â‘,\Ò2a\ÌB•\ß2BQ\Ö\ñ\Ş2g\íT\Ù »\ÖAGûW¹`\æI4]\é\ïAÓˆ$Ş ¹¤\äª\0Jù˜b\æ².\Óë˜©„Ï€­\'¬kK%Œ\öX\òN-\ä\é\â¹+\ÚÈ¼6N…¤`5D_†É¤Uûg\æq\ÉÕ›I\ò_\é¤kG‚z\ÒpQS9\ğR\"Oj¦ZL[x†\õü’\\WP2?Òl?’½—b&\ÛÚ†\İ[E“¯™SV]P.ú|Os\çk\Úß§†=S\ò~…\Ä\ç\ì\á\ó\Ó\ÚúEùø—‡*d«\Ï7!~_…A\ö\Ùb¿ˆ+Š\êw\ğ·J43[Yp1»Wi‘Šg\ï\ä›\Í5¬d>^\ïÎ”\Ä\Ã‹^]<o\ç\Ï\óš“\Â\ái¤0»7»š‹\ŞVf\ïû£¥¸†\Îo¥®ı\ë¿U\Éf\ö¢J\ÖMc\÷q´Q»8‹\è\×\ïŒ¾\îJ\ï†\Ö]!;=\Ü\Æ\áüZ>@\Âk>vX\Û=×§\Ä\ív«~°€²·ûSf\0\Æ\å•\â\ö¿Qg«\ö¹,kc–l\Õ.U4nq³\ô\èr\ó\õ~~$şy\0›¤s\ã!wü*.‚•\ê*µ”A–~£5h†\ì->\á\ğ²Ï’4«cqÌ£µ†\Ñ\õ&®.2_{¯Ò¥%\Ö×¨­Qs‘p\êz®^€œ¶	ˆ»“G\ñ\ñ\ÕŞœ0\ï5»\é$}\ËC\åsú>p7€š1t¹S°¶m\ås¦5˜…=)\òH\î\ïtÈ¶Š1\ã1\æDü“ª\å wF$¼±µ¤m˜–I TF=fÊ¿\í\ö‡Ğ”+{•£¶Šª\Ñ¾›\Å\ò•ˆ\é&ş„z\Ê\á\Û6šbal\ßH¿/r-EC	¶¶û=\ë—µ\ç¥\ÜHw{)s!l\ô¿ˆ~ª– \íJšª  \î\'\Ò\ÆO\ô\"ZI£µ\ê\ëo³G\öÆ\È\Ú\æş)¨\áZIAaø\àWH>¬®u\')1\0¶vŠƒ\Æ\Ñ}MI=«ç‰Ÿ+­\ôzx\ô²ƒ9˜f\õr\×\Ç†\Ü\ä\Ò\é¡\\¤r\É(-\Ä\åN)IK{\É(œ\õrE£Æ©†ªÀ3k®.ü+Ï»C·\ÔW\ÔE’\r\ò[©³\Ó\Â\Ô\Ë\í\n¢#i\\&\ê\óøGŞ´!£f%š\ô\\\àXµ%e‡\Ú]M\õ–\í\ÙN,ø}lq¹ü\Ä\Ïm¾+W\Í,¶¬SªˆÁ˜¢\ÏY\ê\Èÿ\0I3’”+\r©\ç\'9\å\Ç\Ï5zš\çC1µVBø4{\ÉÒ›4\×\Æ)\ñ\ì–¶’F8¦->…<5´$\ÇTs[Ş§)d\á\ÍVa‘\Ä\Ô\Í%C$’%‹&H\ÃP\Ä\È\å3Z”1\ñuSP\Şiz‰”]LŒ™![ÀIª4’`!I™\\H…\ÍK‚\Îo8\ğJ„Éºû\×D$¡ªNF±CŒ–¥=©\í\\À\êD\×{’%\\\ä˜C’KxşhÀ®D§µº\n3z\è#\ä»\ï\Í7£†LŠ\ò&³I©@\\9¾Ô„’hä»Š1—	’/˜„%m\Ù>\ğŸÅš\×1N’YÜ¢%-\"µ„VZ_\ö|´\n\Î\ğ²_\öx´\nµ%Àˆ¾PRÒ¢0\îL¥\ã\éeE– ¹. ‚\àı7±(¦\ÛˆSœ†B\'rX[\ñÜ¼¸\ğ¸˜Ha¥›¥z?\ô\Ï\Ãfÿ\0‰²_\óa\0ün:›\ö/<WH\ã.}9}\÷(c\ö[‡	X—\ÌÔ7K¿O\ÚLÈI9\Û`9|(\Õ3oŒ\äw¹ı)©\ç\ìı¯RrQZ8NJ‹\Í\ØI\Ş\ç\ãú\Õ\Ü/§ „‚K²Ë_\á\éT\ì\"¾s²\í\Üw7‰‡ø«)T™;½\Âos\ÛÇ¾\âÿ\0\âPK’jÉ¼6²Ú¢6\r\èfR°\ò\à\Ù~\Ş¼¯$YYa‘…;|zÅ®ı\ë–_†Í»\â\ïw\×\ç\Ów\öş\ò\Ó{?„\æ8\Î\Ñ=_¼ÿ\0Ÿ´¨Ü°\nyf¥³\Øk^\Êon\\=*zrŒ[&Õ’J˜‚–˜t0‹0\ä\"’šK‹¸‹+VD™³ZM3\î\ípúTl°´†n\Â\ÃÁ:˜NFÉ›RI\ó£¥9g6§Š-NE\ä£\Æ\â\Æp£c77a·W’\ÎvÛµª>ú</*ªƒ\Ò\òç·\Õu\ÚF\ØU\â\Å-5!½7\ã\äg\ï&ş%\Ü\ÇQ[‘›™y\ö­*tË¹™—jg\ñˆ¦?¶X„\Òp–ËµhP5›aŠn­‰\ä!ú\ê\Ü#¾l\Î9-/Iÿ\0	–%°mOv^\Ğ$zm‘³bû–špkVH\ÏkqŒO“9jäŸ®»pEˆœbfr\Òb/\ÄR¾Å°´\õü\ìo»\ğ0ni½V\Å\ÇO\r\ñ\Êû\Ñ\ñ‰?–<3+øQHT\çNt\ó1{‹+„¿fIx©eŒ 6\Î\æ\Ë/ªùÿ\0µKP`\çK\Å\ó+¹z7)\Êl5ˆB\ÆksºÔ\ÄM\Z¦X6{¨\İ­e ‹}Vo\õ-–ªR‚\'“1\Ô\ä^BÙšj„øek|?œ•\ÖM\å=8\ÇqKw¹eÛµ³L\ÜW¸%UV\ì\ËW/ \í®,s@7¬ù—™sş\Õg¬)‰\Î?¾£\ğ¶_‘U<vr\\]®\Î\ë‰ÿ\0\n\åX‹R\Ü\áÁ\ÔBts¬\÷\Î:\Õ\â»ûDúª\å|2H\å,¦\å\ñz¾¯¹_«)\à\ÒÙ°\Ä-ø”1\àÿ\0)LL\â.B\ËR6£\ÏN–Q*\êX™¯ˆ}#ş/4\ëfqJ\Ê9²‚G±ù‰\ô’\Ò!\Ø\Z¥`\"\ñ\Z57g¡4áœ\0“ùşYK\æƒ zY£\Õß¡\÷k\îL8}YVx‹‰µ\å¸İm\İwW’\÷S5D!#t\æ¼oú\"l&Š\ï3ù½ˆd#‘/d„-ˆ6‘v·¹:ˆì± \'T\Õ¦û´I)J\Ä\Ü5\Zy%^«Ü£¡‘/¼t˜&Rš¡\í\ä¢\êfrN$‘\Ó	\n\â]HF\Â9\"‘pAû\ÑKšaÜ…È«£\Í6ŠäŒ“.Ip’w#\âqÜ‚ €-#¤L\"I—%Pº\Ù\Õ\Ó\éEH\ÅÒHlO¤–Q·#¤Ö¯Št’Ê¶\ÛP“)kùY\ÑZÂ‹€«ş\Ït\n§`Xn\ğ\Í\Õ\÷¡aa±\Õ\Ùt\"-øqp/iQT°ˆ©P\éYÌ°ƒ5\ÄB\ñéµf\ÖO»¸k\Z8G-&\ï\Ô\Ù\÷?¥y¼¤ªjˆ\Ü\'q`6Ë‹¦&üK\İ¥V\Õ¢\ìıg´\ÓQ\Ğ\ÎG-L\Ö^\ñ\ë\ï~ï´¼«\Ûf8¬U”ù\ÙY\0\Ë6nW9{¾\õQ<M¢\å|\Ä\Èg¨š\Ãıc\åq\"T“Œ¤\ò=Å–Zz[\Ü(ø…Ttb!<²¿;¼\äÂ–LBk\ç;G¸T\ã¢_‘\÷„\Æ\ì0?¤~/\Ø*fY;c<\Ç\Ê\î\äÂ‚„7R\Êù\ô½\İ\Ã\âÿ\0O\Û\Éj@\'\Éø\Ú-\î\ÉD\ÉW´œÁ\æ˜Z>Y>œ¿?\n\Ü;9\Âc† wf},±}˜“ù\Èúò·Ÿ‰øş\è\éü+\Ğ\Û)N\Ğ\Ğ\æ\ã\ğ¬S\Úk\éVK&ø,\É\ô¤Œ˜ŒŸ€ù$N@\'Í¹¤$ª=\ñ35\Ñ\åsk&\âCû„\\&\õ¬\í\rE5\Â\Ò\ËÛ‘Deo\Úd\êzª¢>9D=Ä ¦\Z=ùo*Z ‹\Æ?ÁX¬†EK\Ãã®¨&yÛ‹\ÜC%û\É(\ğ!o™¦h‹¦\ãj\ÙSU\0…\áb#È‰g›K\Ú5%\rIR\Óÿ\0:ªÿ\0µw\Ö\òV\ãd\å\í‰\÷H’šH\îok´¿ıl-’…\Åq*z–¦\òûÊ“m·³\ç.\'ˆµ(*jN&\ê£AUYQ	Bòœ˜„\í“7¦\ò\â\å\áa\âı\Ê\ítY2¼\ïª\"ı>\ÚQ\ÂD\Ñ\ï.ÿ\0\õ:‰¬ÛŠ2¼%/Fê‡…m\Å~\Ñb\ÑQ\ÃMšZ\Ü\ÉLã£ˆa\ğ\ÊÕ¸[‰B\×™\ò¸µqSÿ\0N@µJ\\1H«ƒ8Íˆ]ø{K4´\ód\î\ö¬\Û\r\Ä)\ä˜N’[n\æAÂ·µ\Ño\r´‹q/5¬±84½•²¨\î»\áW3£y‹?¹g»P\ğÕ„g•¤\ëd££Œ©„ı\Ë\Z×²f\Õ+|S(•Ô¯\rÏ—u¬9,Ÿlq#›*xİ®²\ô­\Ç¥µ™\îà¼©¶´¿+WÀW\\ Ñ‡\\…‘vV©\ô«\É\"c\ñ¤+QŒ´\î ª•Š\İ=,–‹­§!cŠ˜n\ğ\ï5,§Æ±k¥¢\Í\è\Æ\'µ\Æ4\\R¤BBZ\ñ0iEˆ3,š\î\é{‡\ìæ·¼m\êx7\nMª¨¿#¤~\ìuk\ÙM ¦\Ä+D\Û{ŸD­©f\Û9Ù­~5³´x¦Y-=AG\ó‚G§;²Sİ›\ãT^ß‹`{S•.3MK$\ôÕ¾\0sş\Û\Ú?k\í\ryiù\à±W\é\ôƒ\ôn\Âı˜¥v+-»/x¯@k\ì¹©ÎŸvù\Ø\ğ\à–O®\î/û¹Š\ÜÇšÒ§\ày½_6°¥\ZH\ãNRe\ÉLRi-J4ÇŸ4™¤]6d1\È\é\Î\ä©\n\å¯\äŒE.iw\ã]8\Ä8£\ñGÜ£´k¸8$“.I\ÉGÁ$Q£\07!Eµ\É8\öw.\ô R£\r·f‚\övAp\î	\æˆü\ÑÏ¥$J¡h8\òF.”F\æ](\è,–cµ±\ï%\ËŞµHtÍ¶ m›?z–¿‘úÁ©Z0\Z•\ß	§k‚ªa9‹«®•¢­ÉœH˜¦mOXx&±\õ2t=*“&G4\î²\ñfrEKŒ\óµMÀ\ñJ\Ì#h±ê¢§¥Á\Ì\ÌB.R\îÛ¶\"\ïú2^J\íxp.\Ñ1Ñ­zh\è§\÷Mü\àŒŒ3\Óv~\å°ş•›iV8¼1¸\Ål:}f\×ıÖ¯<P\ìÿ\0·V€euºœ\ËÄ¼\î£S›œa\ô{O\ô…ı*\Ô\Ù\÷Ñ\í\Ïg²\á?9<±\ğ,\ó%H\Ã\á—¸Œ§2±¿=\Ë\Ó{G³\ï\ìf8˜\r\Â\Âo¥aûS³v¼\ò‘„DÍ›ˆ5oO¨\ß\Ä\ÌıNC\İ+ªš*8$\0\ã4±\ñ7\ôûº~›~ª¡“xc&V€µ£w–¤Î°¥\'\Ê\\\Æ\ç#·\é\\†Gº\Çw\çû?6­(¾\ìa]‰E&w\Öş~\Ê\ô&G4G•\ÄMÀzm^xØ’xæ‰˜ŸQ±=Ş•\èœ2¥w{²\âK[Ù¿ D®\ñ¹Iû\Ş\Ö\çÌ³+Û‹¹’…#\ò\Ğ^¦Iœn!“w\òY\ÙÁŠUE«y+¾u>-7ka\ä¬5\Ôq”y»\\9t\äªø®M‘h/U*U1]y(a´•5-5Aˆ‘>g\âf\ôK#\Æp|f6/b‚XßŒ™ffî·©pºjs#hœ\È|I¬\ökˆ_§%~«¶tŠ–\éü³¡\ì\Çù:P\Ä\',³”ƒ3/Sfÿ\0k\ğ¦³v\'‰\ÍRR„\íwa\å\ğ\÷­\Ø\ö\Ê(F\ÍØ—‹J¬\í:D}\Ê\ô5V}¢«\ÑTd»+°5»\'…y„URÇ¥£,\Øzº•j1¬_h\0½¦Hh\Ã+^8#\Ë\ö’Šm\ÄU\óT\ï)z¬QGŒm!\ç€\'\ë?\òN\í“:´\õ@¨G²´<’”G\İ ²¾`\ØlT´¤]a1i‘\İÿ\0j—Á\ö!\ä\à\ó\ÎZut²˜ª\Â^\ì\Ò-\Ò, •\ß\É<(\Ï8\Ù\ñq«€\"|Ï¥l\ôE$t‚Ï\Ùx•³ı™y§*“x\Ü\×xV‘4wv‡©a\ß-\Ó\à\Ü\Ó\Ã¯×‹\ÈDù¹g\Í`y±\ñR\íD\ò›”ß¾HüY\ñÿ\0R\ô\\mi4nê¥¶û:Ø¶¿pşqM\âË˜?R—InÉ†¶$8b†WWM{Jr›¶f/şI•_gxt†oE[-Ÿ·-&³fg wƒ\"\òŒº|?r”NO§!/‰–\÷™¿³\ÏM´K\à˜\Ö\Ğ`¸l^t\áJ\0\"\ÄQ\æJ\ó°İ‹\Ó\ö‘Mb5³\Ì{M~\Õ±36\ñ€\0l±‡M}\î=\å\ÕE \Å\Z;rfµ¿ZÖ»Ûƒ\Ùİ ‚¤s\Ë;y|?ŸÂ£\ï!fš\n>\Äz\ôN\Æ*jgj\É\ny\Ş6…\å•\ówÉ­ş×—Z¼ƒ²U˜N\ØAaÇº£A;´‹\ç¨=\Üş\åë¸‰ª)\ÂP{„Ù‰–®–\Í\ñh\òş£^\Ë\Ş\"\õ\"[©/«¸2‚„.H\íNi\ÔBœˆ²]\ã¤Fns\Ù\Ş\å(B\É2FC`\Ë\Ù\\‘½†\î\ô\î\Ôn•Ì\Ú2*6I\áµ=2H.¦#C}\İÈ»”«\òF\â\àKrĞ¥XR ,»À\ßp‚wky —#`D¹¢ºp\âˆqª¤¸nhş[]Â€\Éˆ‚Y¶\×\éu¥\âC¤–o¶1\İ	d\ÊX|ˆ¤Dl\ö8µ¤>%uÂ±\è¹¥“\á\ÓZd\Ş\õn\Ùù®1W\Ú\Ê \ËF¡G\\qRQ•Â 0B*\ÇN<Qh³QH^\ä¾\í\Ûx¤Àç¿H\Ùn\Ó+sg\Ğ\ì?¸*¯²{I4®\í F\åı!0\ßiRi˜\0\Ú\ï£ÿ\0\â¬\ì\ğ…nZ²`/Ø¼T\ÓWO?¬úül_øº1øŠ®\Ö\ĞûE1€€CÈƒÃ’Á\ñ|.”%ŒŒ™\÷ 2pV¦^© H\ò¸e[k„µ+y°„R†½\Ùt¾•r™l\\ı˜\÷Ö§^/C%EmA\Ş\çi\Ú\òz‹-J%²\Z\Í\Û¥—\ô„¯2\Çb1¸4@\àU\0E\÷ÿ\0\Ş%H7…‰\äMM\Ã>eşW~µµ\\·#\Ê[\rŒ½lUX¤G\Ò\0ü;³\ô¯C\áÚ¨\ß\ë[š\ó·g\Ã^“ZüÈ¿^Ÿ\ï~\ê\ô=4–Ñ\÷G©ck~FŞ{\ô\ÄùÉ¤²D\"}\ç7\ôºJ\"’C\Ñ\\‰©\ä˜8½¤\å\ÆÅ˜lN=\ğ—‡&L*°“\\›r\÷©Šh\Ú)ú¼H\Ã teq;»¾%\Ä6\n„\Ø	\ÔLL\Ñ\é~›|*:³fX˜\Í,\İ>%zar\Ì\Z\ï¥$t\ñ\Ş\ÄÁp“\ñC“Eˆ\Â&]S³ú2hˆ\ô\ÛfY¨\ã\Ù0’\Ö\ök–¹SO¬™ˆ…GMN\Í\å½Õ•¾\Êé¯±ü\Ï\è\Î\é\ö4)øû5\ÙxK¥J\Óag\r¹\ÄÀ#ËŠ´n\Üb<ˆ\ÇÄ™LW\\\İ9§\óM‚\ÒÁt†v\ÇeV¤e†*\'6\å\á\ğ¡0\Û\ÅÙ³Ï§4\Ö\Z†+Y¹\İj\ç,%ˆ\ğ[¶x·p”½¥ş6\ñ¾\î\Ï\Ş\óP\Ø$/k\ë>J\Ã	16]_UUd#Z²\ã‘&§w\Øap–—/<<4=¤¢+3Œ…Ÿ©*\ö—v\î‰PÆ¶4\ğº›Á®¥“P5W³­5\Ù\Æ\Æ^Á\÷\à|•Rv\ï\n\Ød\ô…T*p\ó\Ãq\ZŠi\ãp¨BKø•\õc\ÆL·Rß²Eù\Â{JÑ³\ÛgŒ\Ï¶¦!|”\Ôo¯\á—%-BNy·\r6ù.ùX¯O\ñ-[#0a²”nly»‰t\Û\æ½e\Ùn<\Ø\ÆÍ´\ìR\Ñü\Ó\ê\î\ğş~\ãL>ÊŠˆ²{\ß\ÅÜ·>Æ¶˜\ğ|f)OLÏ¹’1m6=¶¿\Ù+U\ËWAv\'´\ó>­¤\İ^\å\Ú=ejÈ—š5:{W¦G†ø\á“\Ş\ÉĞ—Ä¡5$oh{\Ò\àe\"d¾”G&\óQ>\Ù/š\'´JE\ÍÑ°ï—y{\Ñ^f.\õ\Z%!y¥\ãF\äqÔ0Ü„1§A\ZC©dGÙ›\É‡Ü´lŒB\È\È\Øn>ÑÜZË„L(\È`mj	]\ãy ›\"\àE¹ \äˆD¡À\Ù\n\\Ğ»‚+’\ê`#\ñ’Y\ö\ÖÌš\Ğq\è\İg»`VÀi¡\ò\"‘š\Ó\ÏÒ­û6Wª]98?¥[vjKLV‚\èª\ÍK.¬\Ô\İ*¥ƒ‘VŠb\àªHµ\â!\ô²Ä™•\Ê\"S\Îÿ\0¤\æ»\Æ0\Ú\ğ\Ò\'\r„_Cÿ\0ıY,\ÇKƒ\Õ\ÈD\âº½úF\á>İ°cX\rt´s±}—\Ò_\á^gro\ä¨É›\Ïq^KWš‰\'\Ò=:ÿ\07§WÇş•œchš\Êû¸\ñY\ÚbU{AY\ì\ñ»\ôŠ˜\Ú|@æ¯•˜úÔ¶	³­\r\ÖOÅ¥”\ÕE7¹“]\ÖL|?\Ú0h 1ºZyŠ/H?ÿ\0*v\Ö\Æ\Ñ\íS\0ZÍş¡·\ó\ñ/D\á;NX&RF\Ş\ÑVc3;C\Ãû¥w\ÚY~\ÑvgŒbm4q@\æ€œ¥\Ó\Ó\Õûš.ƒ›<\ö²—…‡gù\ÃVr»i{x\ğ[\ÆPr\0ƒ¶E§5\\\Ù^\Î\âÀa($¤œYe—\Õÿ\0\nº\rt\ñ\Æ,Mm\Ş\åKS%cà»¥<)„G7\îOd™£\Í\í\òL¢™£ fkˆ[\É81¸s\Ê\î~\åA£E0†\\DA´\ôÜ’\àM¼b{_<­d®\îA\"wÈ‹©­ğ¤¥‘\Ä\'n\Ôl,o	adqfıI6°­v\×s¤%K\ò\ÎËŸŠJYŒmİ•\Â\ÚW;-À\÷ \óIM`İ›\\Y\ğµ*310¶W]\â\òJû?´í“\rÚº«l³¹.\ÈW-\ØqÌ;­Mkdb„²\ÒL\â%\ì\å–MwŒ•s¬,\İú})\ö`‘K$n1‰Z\n¯³\ØÁb\Ñe\Üü=)=©\Å>d\ØP\Ü,I§f„•\òç¨´«q†+lÌ¶yµA¶N\".n\÷;p=H1\ÇY9\ñ\â¢0\Ñ`Í‡»OR\íN\ĞE‡\Åc¸]—Vjšq\ãè™«„¸*\ö)\r\çW…%6\Ò5TD\ì\ì%\ğ¨:üQ‹F\â€\ğ“PbK_\ß\ãnşJ[´	#“Š¾&ÿ\0š§2\õp/\ìZ\Ã(şR¬Ş›\Ø\â\'RûUŠQM‡Ò„n\Åd‚!\ï\ÒWg\î«P­\í\ÚUº\Õ\äCH\ä\r\È¶d-\ÔI_nk\Û>]>j,\æm\ŞM\õ|j‹@X\ë_Š…¬\Ö\Z,x}e³µ\Ú	º}+L\Ù,H+85†lÅ”€\Úş&û¿\Ã\ô,NŸa”Yİ€‰­b\Ë%wØ¼ksR\0fÀO\âÏ—Ä­iÙ™:\Ú\÷À\÷\Îb`8uvz¦€\rş›u~\õ\ÊD\ãT\Æq!®\ØjvÉ‡s1\Åûoÿ\0\Z¾oƒÍ—°ƒ\ÌS>]dvNHfqû’%Iù\ÔrL¤¹)QCQ(¥†F\òFi=\ÈÈ¸t\ì—\Ù&2?’U¤$Œ•`T#J°¦\Û\â\ô®Sr\\\r”<yQfQ\Ób¾\çL\'ÅŸ¸\nWbDÄµL)¡\×(R\ÄGGŠG.jU/&I/mtKP]Úe’W \äˆY\äƒsUÉ²\æ‡r\âPzP1Z.BK<\Û_po’\Ñ\ëºIRv´n£—5Ø‘HÇ©£rœş•k\ÙÑ¶l\Ô\r=+ûI¾^%bÁ£q˜rkV„_´®\×ƒ\È\Ö\n³\ÓIÁ•C’\ÑÕ¢M’«\"X\÷ˆ\"-Î¸¢%+}¥\á,l6-H\İg\rÀ#\æ\Ü‚\ñ\İ\'\óŠ\nª\r7yq\ç\ÇÂ½\ÅSTDQ›i6qu\á\Ğpù\öGkq*`gˆi\êG\è\ğ—\áµy\ïR‡½L\ö^…f\èNŸÿ\0LKlpù0œ`œ\ÛM\÷2´\ÒI¾\Ã)\ò}Ÿ\r*Sjh\àÚª!fû¤\nŸbqJ<(\"£¬Eµ\\@¨BÕ³k=û%û:\Ú&\Új¢Œ\İ\Úz6²\ß0f\È_ûªÿ\0ì»° \0b\É\Ê\ò/\'YŸd/Y„\íe}}D\ğ\ÊHB{¦ï¹¿Üµ©txo›“\á‰‘ky\Ã ¦¥aidf\Ô\\\í\êu9o\Ã\ÏN–RUS93i\ãçšw€y³‰?Ú¢™%bc0f\ÙÄ—	€¸\çwt¦§`±ƒx=É©\Ô>\÷ƒ\Ú#˜\òıªZ]2\Ô4`L\Ï\ÏÅ¬½)­\Ì\\Ï—«½FC\ÈyBŞ¬\óI\Ô\Õ8aÓ–¢\Ï\ó\ğ¤d\ÑMT\Ä\ì\î?ä£¥™\ä`\ê\êLª±+O#\ËSp\÷¢R\Íu×½¿\nL \Ç\ã3\Ç,Wj·U¼¸§)4,\ç\ÂÜ¸\ñşê˜‚iH\İú|Y¢KT\Åƒi.ÿ\0¡M\Ñ;\Ã]T\Ò^}ŸMÄªtR?¼”¦\'X\Å\Ğ\ö‹jTüoqŒÙŸ\áR¯s\ÏlH:ù­\İW¥!E4û+‹ûC³Œs!\î$\÷f…¤¯)dn¥;9Bll\Ç\Â\åyuµ˜\ÖOİ¼O\íxh\è	\éª*2\Ğ\å›ı*™%·Q)\ËY‰Ã„\Ò\õ0@×—\ÚwL\ê°Ö’[â„\ó»K\'T\ÓTY”†\özG¥Y®š\ÑFz»&ù,¸f-‹à¶´øƒW\ÄŞ¶È¾\ô|Wµ\n\n;œ\ÌÅº#\âDªµ›\ËÅ³r.«sQgJ\ĞN`\Ä^%\ÇD\ÉÅ«±,!\Ö!\Ú\æ7Tû#>F\î\Ù\Û\ÆY\é\îV\Ü\Äj¦§’¢\ñ¥‚\ë\0»\ÉüJ¯‡P\Å\rHHÀ7‹%o§ªgº½J=½(şe\Ùk‡	ƒ7n\ï$§µ§wb\î=J«Gˆ8½¹\õ\'\ñ\Ô[c¼¯`µ¶—‰\ÕI#n»=¤\ÙM\óC—\ê¹H`X•X0IfO\âu[Š±‰‹‹\ğ\ä¤0?ùø»®+|\ò\È|ˆí—´\÷\Ï\è\ñ\\sl4ù\çoµ–W}@Z‡´}e˜~°´;Y\÷\Õ\ö\ÓDY{*?¶”\êÿ\0¿?\ö)½tq‘\Òc’0“)J¢£3¥FDÔ¤a@j˜{\Ùs’D	“È™DµRTjŸ¹\Òá¤I\Ú\É)E­M‚©Ë›§#‘\n\æ0>r3š;“S£b\îR\å$6\òN˜$PĞ‡’8Ñ°\÷\'¯\Z\ã\óFE\Ú5Ü²	kPKÀ£•\È\\›\\H\Ã\"BAdaä’º\ä¨\òKÆ•…¤³T§\'š\"knW<D­eCÚ™-„\ß5$W%{:*QR„3–`\÷zrS¸m<}\ïo\ÂJ\'\r®‚ir\Ï\ç_Ì¬{½\ğ³;ı¤‰¼\í,\ál,x\\l$,Íš²R\Æù…Cuª\ËM‘N\ÑP\íü—7NŸ\î\ÑHTd¸XşK\Ìÿ\0¤F\Éü¥ˆ%L\rv{™\Äz®\ğ¿\Ú^¢!X§m8•6\Æ\íYYÏ‡b¥\ì5B-ÑŸIı—µP\ÖW\ä¨\Ñ\Ğ^\ô·©£\ÈuxY\áµ61q\ó\Ò\É\\K\Äj–7a§—K\õ8²Ÿ\í/—Æª¨\äkŒ$|­\év\ğ—\ÚI%AFøn5³ƒol\ĞÜ¼º{s“\è½ûe²{c°ø¨aªİƒ	qø“\é\æ¸ú\Z\æÒ£v\Â\êª\ØK2\'gN+>p\òfnüÕªşE\ß\Ü\Ú3¬&°›.zI0š6\"\È4\ñ·\óû\Éz‰®2l\ô¾«}?i‰“‰ˆ6¡+Š\ï%$‰\Ç\Ôz^\ïrª†\"v\Õ\á\æŸ\Í#\Æ\ÄüHEºyşÜ£§\Ê0\Ê\ïQs\É&	“\"\äªqy[2j>|@\ÄÅ‡¥:¯\ÌO\'´ŸŠ‡šN\Î\Ü\ôÚ—©\àR¦c\Éü=({sFù\ço=CF9\ÜL™Œ\ÎVµ\ä\\Sm$Vm&^¹\ä6~1ŠF²±³,²/‹5\ÕÀ2œfW[˜¤æ™¤l\İ\ô‹ı\È\ÚMF¸q•\îìª˜\Ícw½¥\éS8½U¢\\ˆ½K>\Åk=£™ßÎ®\Õ^YRıF\ÔX\ğ\\ds·\Ê^i½±¬\0r\á\Å@\áPœŒ.ù[’¸\ÑÑ€–yk\'ü\"®4¢e«\ÈO’\Î0\ä\ãs¦²Ó°†N‰\\\nŒ!\ç{½M\Í°¼6ùú–·«—RT\åÑ›\ÔoJ|\ì´s\ê\ñ$¤\"Í´‹¿R¼\ÖÃ…	“\Ç?\ìQÕ\á\Ñ\ÂM¼\Ï\Ó\áO\äúI\Ü9\ñ¹8”¥§bf\à<Sš‚C\ór•¨\Â\Ûq{jn:R\ö#‹¬«E‹Zv½\Î<¬¦ùº\î.ÿ\0…Vq\èN–¤%û(´\Ón\æ´KÂ¡²²\Å7²ıG#•­\ïWŠ¡*ŒR&7k{ÿ\0\nÏ°\"º\×|ø˜“—¥–µ±0¾úBp³\Ş_ı¿º¢®\âk\í\ö\×ìŠL?`p\àv¶Io•ş›­ş\n\à\õR\n†\Ø\ÚW£\ÙL\"/Ó?\Öv»ø©b^²µˆ$|\Ö×¾\ÉHU\"/µK\æ¢\ÚJB \ÅQ/š+Lws\\q4¯Ÿ4\0\åª\Í8†©û\İ0·ŞŠ%is@*i˜»Ô¤37š«\ÒU7š•‚¡­\\hx²ldbdB&Mc™‰¤Q`›!Ÿ½$ü\Ğ\Ş\"\ï\åÓ­A\r\â²%\Érµ&C\Å Š\ä£\Û\Í$\ãj\è\È¥y9,ûl$\İ\Ó\æ´*\Ñ\ÒK=\ÛXØ©M4{\"³¢ƒ‡T?´“\æ\âJ\å³\Åu@\ñ¸•\r‘½¤¸«¾Î“{H©R\ä|û\rC	€«0\éU\Ì$´\n²\Ò”²‹\"?zU\ÅDN7!Y\é\'²\á´\ÛYWo`\Ç\Ô\å\âı‹fµ¼•sl\ğX±J)c¼cg\'SZ•\Ãz\Ú+n<\ì\ó´Oø‰\á\à?\Ë8UĞ…a¸ÿ\09„9|`\Ü>‹T\î\Ş\Õ<4e5€kZ²¼w—Û¬Jy\"¢\Ş[ \Æü\Ê\ì\Ô\í•˜¥´\õ’\ÉPı2>k\Ëk)\Û\Ñ\í}/S˜­\ßD¿b\Ş\Ğ8>/½\ÌD\ê\÷±‰y87ù¶\Ï#\Ü\İh›%…¶†\Ö;5·\Èû®Mg#j\ía\õ(\ã\ğ\'¶[\írª°Jü\í\ğ¿znR“i\åŸ”if´\Ë=#\ñw\æš\ÈV\ÊYivnœüJ&4Q\Ò\ñ5\÷?\Ã\É5«Šg\Ëü‡4¡„rûN’’¸m`9¼¾*\"§@³·Å©BW‰—şŸÂ¬5%\óœIˆ²\ã\õTE`´<YµgrqŠ\ô\Ñ\Úd\Î½))£=\öl\ö¿qr¨\×wQ{’;—3}|:œ±…„nı\ßzg1|\Ñ3\ä#\Õj™z³<\Ú\â\å\áQ\ñµ\ÙG¥w\ÚL‡\ÉK\Å1¼Á\ÛOq*¼#VO)»	t·ûi$’\Z‚\áhª½N>%R-¥?2©Ö•(Ë½å—Œ7¦£a\ŞMY\êt\òn\Ñ0\êù‰\ï>9Ú¨1vg!Xn\ÏP.ıW»©¼?bi\á„Y´|9d§q‡\Û˜2\Ç)\íU!Ta\ôr•(åœ¹i\ãÒ¥6;³]¤ÛŠ¢§™¥9\Æ_\Å\Ëø§3O\à\ô\ò\Óa\ØÌ”´\ó\Äl\Ì‘3\Í\Ş\ÂVıUjÙŒckvG9i+i¥—x\õ$q³?-9[\ä…\á]—%Fªkş,\ìo±¡\Ùù*£–H\å8\Ä\Ä:_/O¹U\ñ-‡Ç©é½¯M¶^Á—Su-W\íi+¦œ*–[š\×2»W‡Ô gsˆ£©\Ä\ÜA£\0	\"\ÖL\ÌÖ\ãË‚\ë•Y\àe¤Öµ\Î>»i1&8**\é\÷J\ö…¾¯\ÎjÕ†\öÁ@4EO;7R±—e¡‹UUu2U»c#\ä>B\êl»££Š	)A§‰Ùœ\È3¸3\õ&N\è­uQ{ä†ªÅ©±‡\Î#¸[’&\Ş—ÖµAÃ†R`\åi%jÁc	ü´ª\Ö\ğT«\ä]°(\ÏpL\ÍqŸ\à¶í£Ü”Xÿ\08vü#\Ç+\÷S±pµE@p\Ó\é&Ï’\ô/d¸bO\ÓIÁ	‰[Ìº\É\ó/½G#jl\Û\Ï[\ÒC\ì\ôt\ğ³\éŠ1¹’\ÍÉ³D¹—¤H\ğL;ı(¹7©‰—.Ó‡K/4^.\\È·5\ÈRII[›\Í\õ$\0”Rn\ÍJSU5ª8iØŸ’u\ÛÉ—‘$jd\Ì5\'M%Ì¢\"\Å;G\óJ\Æ\ÃC\Â.\õÛ´¤nA‹ŠQ…\îA\äM7_hÔš„ˆ\Â\\R‘\Ö\ò\äh“{‘\ÂD\nÌ„	Pv¸ZJCorº\ÖÍ¤•j\æO$\Ñ\ìFWE\î¼\Ù^vs2©\ÉS\Û/”sW-Ÿ\ÌjŠ²$>­ƒbj²\Ó\r\Í\ÉW0şh]Õ¢›!U\ìd\õ \Ä.“qN‘\rE’QI£i\0‡Ü•C©0`\ğ\é/Ù¯\òWm\ñLn’©\ë*˜<-+p\ÅşY>	Š5eP\ÎÙ…\Ì#»ÿ\0‰}\í#³ú=ª¦œ+i\ãª	!v“\Î\ÛŠ\ğ.\Ò\ì\ì{;VÁ8EK!\r¹\ô³=¹,md>ÍŸM³\ÃDÁd¥ª>¶bû¿ùQUEif\ö/ˆR[-ˆøbÏ®>V•¦@ù\\ÿ\0±d/‰¾×¼hsnø›\İuß‘LJG ’L\Ş\â\÷%JG\âıï˜¦²\Ì“µ£\âø”l‘+ºİ¹\ê·\Ë\óšk/\Í\É{µ\Ş&.H<š²\Î\Ñ\ï\"HTM©\ë—	VH\Órf¸¹\ñä¡ª‹Q9»\ğg\îOd\'·C·\\\Ô}Y5œV^H2c:™¤\à\ïË©4º\Ó\ÉÃ¼‹RRJ€ï»»\âL¥‘¤<\òr\á\æ¦C2H¾r\"v6/…B\âe«£•­Üu±^Ú‹%_&ù\ó=\"…Ø¬¥md7B\î\ïv^\ä\Ûf\ğ\ö˜Í˜‰?\Ærª;¸¥0\æ\óg`«\ë\âUxs\')!z2iœG¼T¼4´\õB\Æ#\Ç\í(ò‘‰¸H\ä)1\ZˆO8‰ø¤L—•\îD\ÛarIw†\ÒBb£qw\"\õg\ÍA¾=%\å&’v\â^\ôœ\ÛYb.\æ<|>I\Òd\Õl\'§\Ú*z€\Ş;›xyjDşRAO½v\Ô\Å\åsx\îo\÷*%µ\Ø|œO+ºtºŠşWRL\çÇ«5.\Çø\\^¡v_i²a\ï¿?•¯\n\Ï\ÙH\ê\äir\"\òµd¸v\ÔEx¸d#Ò®\í\õƒ“E°•¿\nu\ì\\™—\İ\ç|_	f2\Ë\ì¦8Û°8Ï«=­¸-\Ñ\ğm=.ª\ô4\ï\rfLÖ‘\ä¢ù\"‹6\Ì0\ßj‹x\Ì\â0\ërË§‹\n\õw\èÿ\0‚ï±‰\ñÀ†>¬œ³û«\Ïİ›\ìü\ô¸Mg¢Yİˆ\ôj \ãş\í_­{#²Œ\r°}”Š]İ‡R\÷ıfn’şò¿¦¯“#_n+\Ém2k’D^\äc\"\Í$\ä¶O,/r{‘Hr\ç@€r\÷ \Äù\òE\"t[\ä\0\å‰ü’°ÄN!+]q“C±\ÈC\îK~\åÈ‰’\ÌL«\Ô\ÂnÒ .Šr2%\ÊDE&.Ü’ (€L–Ó€A+o¹1ºTÓ ‡Ü—R›F…©\áB“(\Ğ1Y‚T}«i\Íh51½Š•µ4®PšxHÉ¡Ì±j\é\rL\\UA¡\İ\â^*ß…u‡e‘Ç£aÁ\èCÄ¬4\ãÁR¶v©\ãŒY\İ\\©&¹…Sšeª\Ø\íp\Åuq\òQ‰\îĞ¶\Ôk‘H“ˆ%_O\ífÕ—W„Hn\êªe£\ö\İv\Éû|Ÿı\Ë\Ü;E\\ø~\ZR\Ú}\Ë\Û\Ì\r¼¡*L^ ª\rY6 1u›ªk\âh\é3\ïG‘vv¹\è\å\r\éü\ìOk{Å•·(\ë\Ì\æb¸P\Úş\Ãq›\ê0i\ß§\Î\ïf•ò•¾«\òuSÂ±\ëe—©i ¨\rC¬Lc\ğ¬F¶’3SHPV™7‡«\ó\÷—\áMg&q\ãùıIy£¹\İİµq\ïQ\ÓHbF\Ì\í\á\ÓüT,°\Z@\Ö\ÜK»\õ:I\ê4f\ïmü„½)+·zÙµ3xY7–n2\æúz˜³üü(:	\n\Ñ\'vkr\ê%WPBß¼œT\Ö9®ï¹”l\Ò	8;ƒˆ\õ[–Wt®¤w#Yäµ…»ŸÅšA\äk‰›O(“\É\ó\Ùs¹ø¥F\Í!„\Æú›R‘ \Ü::†…\Ë?ª\â˜T\Õh½\Ùı)	*7ı¨\Ó\È\Òpg´CÂŸ\î!ªE\Æ\\¸Ov—J\ÓF\ÂW}œ¿y*b\å\ç\Æ\Ô0…‡…\ÜU¥\ñ*·\È\î2m»\ó\ê\ğ©hD\÷|\ïc%¯—M¥\öT¥$ÀGc\ä\"Ì ’-W!½MuQ“>D=ê¡\ì«\Ô{0rıJübgOA§Œ€\Ù\Ç?HM¢yW	˜\õ^\ÅÏ©\Û1$\Î=‘A\É\óZ\Íd/?‡5(†øİ›\"ı\ÕuZ\ÊNˆVÍ½(Õš†7‰7§¬‹¼S ¬s\é\â*\'–\É\"‰*hZª@gøB\Ñ\ñ\'˜f\Â\Í]Q33±=^³\ÔL\Ş\ô\ãe)[/›;¸\ÜB=\ëf¬\Â\â\ÃÂ‰£‹\Ú*§n$:s»\ô\ò\ê\é\Ë\Â\ŞJıp\àÌ²Ç¼¹vk²ÿ\0.m==v@\0\ñq(AšÛ³\îq/È¯U¼!GM\r±F\0>–eC\ì#a\åÁpi\ñZ\Æh¬™S›¿o\÷~%£TÒ¼œ–¥0\Â<Ö®\İ\ò!¥\'¹$\å\ïO\Ï°y<\Õ\Ìƒ\'/zM\ËŞ¤>G?R\"º\è¤m\ß\è—jG\ä7\óGlWz\0f\ïGi-O›qGù%&	FmX\Ã\Í,Ø€#–\nÙ®¶\n\ÈÚ\æB~\ÙrVœ‘\Ã	at\à0\Ö\Ø‘ZrrOb\Í%\r-©\àB¢d¨º	]\Ú	NˆB)ÈŠJIĞŠBD\'»\\(Y8B\Ô\r…L-j©m+&®\ód«XØ¶\ìÔ° š1V‡\÷«/x(£q!z™\ÂˆqV^&ƒƒVª\"q\âªøG@«EK(dXˆüIü\×n5Áäº«NÜº¸<\×PÙ‹|—{»\ğ\Ò\ßJ\Îd\ËU\Êÿ\0¶\ÄsB9j5ŸO#rY\Z\Í-?DmM8Ivl³n\Ñ{\'\Â\ö\Ê\åà­Œ5ph”\éşP1\òLf!,\Ùf3J-\Ä\ò®!…\â»7Q\ìx˜6ü:*cl‚a\ó\÷?˜¨ª±»[u;ø]z_k6Nh¨\n\n¸\î\Ô\â\ó\çÍ­\ÙZİ•©(\çÌ©\Éî¤[Kü%\äêµ‘\ÃÉ­MŠ|H®G\Îe—\ÚL\æ¨b,\ß>¡+rú¿\äPW7¹¹Ša_%§\ÇJTXhÏ›.D&\Ü=\Ê2²f³;\î\á\Õş$&¨x\Ú\Ü\ØnnSJ™€Ÿı*Tˆ˜Y³š\Ó|\Æ\×\à˜LVİ›Z}:‘Î£PÙ¤~/ªš\ÈL7œÓ®v„^C&»\âMšG’Ss+n\Í\n‰2\İ\í\îDµ¤\"s;>/O\çR”¡S&Í»›\Ãä•¦§b13k…¼)¸H\Âv1¹\ç\â\É;¢“vc›\Ü\÷?i“ÁG‘›°ƒµ¾”„²9“\Ş\ÃfY¤\ä\ê\ZK¬kG\ó\÷¨ù„$Ş™¾¬\í·4É\ä_\å\r\ñsr·˜ù%jkaM‡\'P‘b‰\ç¤Z\Şi…es\Ş\å\õQ…’E7‚F§ÓŸQ;\Ûv}JÚ˜g#\ÍıÃš@\êœC‡‡•ÉLr\\\ê\\s%\n¸\çf\Ôú˜S˜\ë5‹f\Ş\õe`›\ê\óR\ğ¹M6N$ÿ\0…:DNF½\Ø\Æ\Zø\æ64\ì\ì\"\ó\0½\Ï\áe\ê¾\Ë{?>Ğ¶¶|RX\Øp¸Í†ü²ù–} >\ò\÷…c_¢\çf8\Ò<²\ÓE`\Ô\ä%>˜\Æ\İr~\Ño´+\ß3³´{\'ƒÁ‡\ÑŒQ·œ¥\â\"\÷­*c•Éƒ«»ì‘œ!ˆ\"Œ\Z8€D\0E´³7K#µ-\ÉP\â(\Ù_‰«P±!\ò{)0‘·h\Ş.\Ò+\ä\ñ\òF\ö\òR{´7h\Ş6\Â8h[É—=…¼”í´Ww0\ØGûzW}„|”­ä…­\ä\Ì6\Ş\ÈŞ”oco$ş\Ö\òFµ.N\íDsQ·¥h\Û\É>µv\ÖF\æFCJ\ŞIQ§oJqj5¬•±¶\r·-\ä‚t‚2\"‚R\Ì)W\ÛP6Ûš25¨Z€—¥V±\áù²Vi‡B®c±\İ\'‹!°Å¶ˆ¿\ñ!úT\Î\Ô\n#k!\Ü\Ö	ûÔ†FV:µ\ôT‰¥\à½¬\ô}*¥‚Hû±VŠ2|…C4X‰*‚HI\òB\ç\óP`³‘v\äŒlbt¨“w\îd¬Y\Ú\êÆ§¢•³ùÙŸ\ğ²Î¥\Ôy©\í§®z\Ê\ól\ô³\Ú\Ê–\Ï,×¥a\rÈ­M¥°[7Ne+nQ5“y*,»‘)¤¸\Ô61ƒ\Ó\â”\ÒÁQKµ¦$\İ\É\é\ÍsY®‡I(ó¸³§Ÿ6ó²š¼\ê¼)Š¢•¹Á\Ì\Ã\êù²Êª\É\Ä\Ì-!\Ó\ö¾%\í\Z\ÚQ˜9jY–\İvSE´\ÌsÀ\Ş\Å^_\õcm._(œq\Ñv»¾¤y®~®-¨_‚a0\Üy¶•cÚ­“\Ä\öV}\Ö#€\çhN:¢?Öª\õ\"wp\é\õ\'LŸ\nCi\ÉÇ„i¡\ïIŒ\õe\öQÜµ}I#‘¤gwEJˆ\Ú\äA\ä;É¤f/ª›–\ò;›WV¤\âB»¥¬M\\^üÀ\Ú\ä\âŠ\ÌW>z…¼—c¬xK\ÃÜšœnC›5¤:œmJ4P\0k~|P&\ÒH\ñ‘º\í#LM\à–}]M\Ç\áQ/”²\æ\æ\æ=6øS•t9³Zt¦\Ç\à¯ùTg\æ\Î\Â_Œ\n£ÌŸ7\ä”:À.—H\Ç#y\nt\Î4drfüH\Ô\Ğ\õ1\æ$É¸ü\Ï\ôn\çúÓ¼?¢\î. ü\\¾µ)R\"dsˆ6¯\Õ\âZ7d½–\×\í\Ö=PDb`;\Ë3\âı\Â\İ\ï\ğş\ğ¤\ö³\Ğ\Ç1\0\é\åœ]\ÃNZ8»\ğ\áÇ»Â¾Œv	\Ø\Ël#ˆ\Ó\Æ‰\Ì@!—³ƒ\ñ\Õ\İ\Õ\ö•\Êj\Şgjo\ğ¯\ä¸\öWÙ½f»+O‡A\rC€”Åy?§?\Îo›«u«†I;Ö¦6m\Ët·Hr	\Ô|“$\ê\"@£\Ñ\äŒ\Ù$ƒ¥Šp]ÒŠ‚\0\ï\İ(¨¾\0e\Ñ\æ‰\Å(O´…Èƒ\É\Z\Ô\ÔaEta@\ÇWx!j\ë\nP\È. €¢%m\÷!j\0#\n5«¢([\îF@BaÒ 1\ĞJ\Ã0\é\ä q±}\É\ğLˆ\äc;g‘M—½:Á\áù°Mv¨nª\Ë>\ôû-Øƒ3+Y\à«\Ë/˜?4*\×GP8±B*\ÍK–à¢“\'Šh\ô¡bq»Ò†\íE’|\r\Äx¡[#S\ĞK›°“·‰-4I\îe\ğ¶j©¶˜ƒ•<P»<Dm{>¥^\Û6Ä–¸\î‘L­ùÊ’úSYrJ™nø?RBBÔ°¦Íˆ!…dš	W\êd{”\İ`\ÜJ³1¹Ve\Ê\Ğ\Ş\í­8	˜_\'Q»\ëO$³I¼.j\Î	\Ô)¬Ğ´‚\\5!\Ïø‘œ´\óO‘p@\â\Ø\r>)M,G<E¥\ã3ıK\Û\ÎÁ\ä¥\Ş\Ô\à\âEC+\éú ı\ßizA\ò‘6¤bgd¤\×Gƒ\ñŒ>¯¬:z\Úi(\êCœr¶_¬|\Û\â7_¸?\í=¬\Ø?i(\Ê*\Êh\çëº™ıBü\Û\ì¯>\í\Ça8†|\ØT¯Y\0g\ó\ÛxıS\äÿ\0k\ñ\'‹,+\ì\É\ç‘\Èxf¹¼¹\Éò´¾”`Í†\ÎT\õ1<\ì\×8dé„µZ\Ë,ÿ\0$Ÿ\æf’L\å.\ì\õ‰7š¸„‡\'dS¬¸\ä)ƒû\Í\à\äz´¦sS\ÜC\Â\Ş=(=Pe\Í\0¬o.\ô2\"T¯wrW\ÙOK4l\ÂZ³\á\ÉHÓ”BYe¥‘\Ø2¢\Âd¨ \È-.ş+D\Ø\Î\êv“¥¡§Zƒh˜\ò\0Ï¼ù0¨Œ?l©\ãf!w\ê[v\Í\Ò\Ól\ì0E›o\Ì/9»Ü’\ëü\ï\Õ\Ó\æ–È\Æ\ì[\ôwÀû3¢‚²C\Ælÿ\0™\Ë\æ¡\õn›ø\óú9-^H×•{:\í³\Ù2Š¢W¯ úr?…×£v[n°²£h*@-q\ëo²¶´:ú51\Äx‡“\×\è5\Zy\æ\ÎW\é\"y¤ŸJu(û\ÓS<Ö›1Ğ¬<\ÓøE2§\óOc\Ë\Ív=\0\è+j$Yy£\äŞ¥Á\Ğ-B\Ô2oR\îŸ4r\Ô-]\Ó\æ¹{y j¡{y£\\\Şh¢(\Ì(£#y£oÔ”Z…¨»\Æ\ò]\Ş7š\05\äw\æ†\ñ¼\ÒË™\0Â»¼o5\òwº)bQù®d	]\ãy¢”Š%\ñHü\Ñ\Í9’RY4¨LVF°—yª\ö3F1—¹g\ÛxQ\Â\'#i!P\ØV8Û°|\Ô\'j[`°3\ê},>¥@Á\öÁ\ãŒX\ßRÒ¦\rÀÏ“ÄW\ì¦$\ÓBš»\Ñ\Ô5£\Åy³b6ú\ë;„}\ëgÀvƒ\åŠ8\õ½¬*½œ2\Íl¿G&\óƒ#™¸\ğ\ÌG\ë:®c\Ø\ã\à\ñE/¬™\É\ÍS*±JÚ‡#9d\ÉıD¨Yr‡\Ø\ÔÙ¥\Ö\Æm»\ö²ˆKº\"f\'ık8ÛŒ2ªœˆ0ü&ªsÍ‰«G¾\å[]>ÿ\0-\é\Üm\Ù\òHGb4v\îk%\ôß¥P¶\åg\rj¥Á\å\'\Ä)!\Äh¦¦c\äg°?úSs¬	06Jc›O]‹S\î*]Œ2Ë—.=K?Ä†¯	˜¦£ºz6z‡\Ş\ä¨X\ñÑ¥T7ü¸.sH\Ä\Ù:†¯\õeÒ£p¤‹¦)\å\ŞÇ®%ÀüLLüX“\Ék.e\ô\Ë~7E\Ôf/ŸR+T8\ñJ\Î,\\“-\å\İ\É	R%f ]|R8\ğ\Í8˜›Š2.\ÏÂŒDÄš‘Z=\ÈÚ…¼)r8\ô\÷(\ê\Ü6: ,Ù‰H‰1H¯¤)“m\ßexv\ÓRTS—qe‘7\Õ~\å\å>\Ô{\'\Ç\ö\å«\Ã\ã—\ÃY\îp\Îh\Çø²\÷ü\Ô\á \ç\âU¬ofâ¬ŠF8Ø³\ğ«5İ³\å\Ê>jÁ´\Ö6lú½$V\ñÛŠ\ôGl¢ı614ø¦\ÏÛ‡b¨\â\Ë(f‹\Éş%\æÚœ.¿g\ñIpüV–J*\È^×Vı\ïz¹˜Mf&\â\öÈ•„kx\'“ÓŸÔ˜SH\ä\"\Ü“\Ø\É\ó\Z~•e„‡\Ñ\r\Ü]\íN\é¡{\ó\Í0>wƒ7\Útú„œ¦\÷¨\ÆÁ¢lT!Nc+\ê<ø\n»\Ô\É<•{\Ö\'Tmšä¨§ß›µ\Ê\Ôx‡²\Ö;hÏ‚\È\õ{\rO‚Ë‘r\Ã\ñ\Ïe3gW-\ÚÊš:Èªi%x|@ùf¨8m\ÊMp\÷)º\r›«cq\ğ¬z·F^\Ò\İ\ê\Ù¨\ØN×Ÿˆ)±Œ‚R\ÒÓI}e¢•pd\'›?\"—^GÁ\ñ	(Àc“1!ZF\É\í\õf\ÃO#=e)ÿ\0\Ó\'\Ô?U{M¨<l¸\ğ\Z\ïMYs¤\Ü\"Ä€{Ó¨\ñF\óY~%µP\Ù#\È\á­s]\áøSP\Û\êAÿ\0ÔŞ½Ekr\ÌO)7±í‘²†(\Ö\ód•\Ícƒ\Ú5ÿ\0\ê\Ã\ïG\Ò(;\ê\Ç\ïO¶_„~TlMŠ7›#|¤k \Ò0\á\çX?z?üK\Ã?®Ş¹±ş\r\ä_¦´X£y¢>(l²S\í3ş¸)¼¦a\İ\Õh\Úÿ\0yWé¯¾,kŸ-š\Æ´\Ê\ê‡Dÿ\0‰_\Ö	?ş\ò¯\Ókùh=K£­–\"]¤Qÿ\0\İ?¹»J¤ÿ\0¹\'Ü—\Äÿ\0ùW\é¹|´¦\\ùp=l°\ïø•I\ê“\îE.Ò©¼\äû—|L\ç•¯\Ëa\ë>\\ZÂ¿\âe?”¿r8\öL>	¾\å\Ïü;\æF\å\ò\èz™†ÿ\0\Å\noûs}\È#\Äÿ\0y‘7ü¼\Å\Ëÿ\0Å—\ã@¶\ã.X[ı©\Ğv|=\òeÉ•m°l¿L\ò£m6†\İ`}©mN\ßm$we†FEÿ\0¸µÀC\ĞÉ”\Û7x6 \'úe‡\Úf\Òİ“\áqÿ\0\èê¿´= m$\Ô\çü\Î(>,\İ\Ö\Í6\ËÅ‘=wĞ«ø¾\Ë\ÄQ“87Üˆ\íülÿ\0O*\íf\'‰Uo+Ì»½)>\ä~R\Û\r‘h\ŞW`Ò«˜.qˆ09‘=¢\"\ÙÜ´\ë’q\"\Î8	\Ò\â#0û3½\ß\n\õ7a8!>)Š0¿\ÍÁ\î\òşzG³N\Æ)p:(±z6:ƒfp£\ğ‡\Ó\æş\å¦\Ôâ”¸M#L\Ú\"É¸7Ğ³\ïµ2\ÕU>\È¡\Ç0\êz\à\Ól±‚&\ÙŸ5N\Å\ö‚«ªŸ( d\Ì\ËA¦\Új,Z¤`2”2\âEÀmT\Ì|b\Æk^Ã£‰…\î\Ş\ñ?¥b[\î\å3b”“\ÃEl¦\ß]\'­\óD\"J\Õ\Ñ\ËK-’ƒ71\äš\É#\å›A¬\Zø	6DYúTuM8L”\êj†“M\ö\ğ\ògúTl™\"—‹`g\ra\ÖQ²\Õw˜\ôŸ\Ö\ô|;hc\öz°jz®\á\ğŸ\Õà§±!¹²U\\V9\0˜ÙˆU,?i§\\²°\É\ÙJ\îiœ·\ç\á\õ*\Í6\ÒO‚Í»\Ä\0\Ë\rwùº²\ëø\Û\Ë\ß\Ï\Ï\á³4Q\Ë´±\\\Ä/˜® kG3\æ\çn|R\í#\òIlL]\ã\éE‡1\î]8:i8!wƒ…qË$¯ƒ‰šgøS†‘ˆS.9\ç¥\n\Ş\ô&\rduv¯…\ÊO\õ$.¹²Fº\Ñ6.5\ØhL9d\ßUf¢\ö?‚\í\Õ\ë¤ù\Ñş†¦&\ÊXŸ\Üş_%¬‘\\)	¡»š\Ü9C³À] v7\ös9I$O_„“\è\Ä m\õ\ÛÀÿ\0³\âU\ó_E\ñ,*\ãˆ\ÚÓŒ›1&\ô¬´\ßÑ¶H¿d¢Š°uI†\äÿ\0\í;\ò„¸}\n\ì-S\ã\ìx¼vyª8ÌMá±¸l\×p\â‹S\Öa5’\ÒV\Ã%D%lJ?\ÄÎŸBA³;\Û\é\éCe”·\r-\ÜÀ\÷±y+½.\Î\ÏU(Jmp,\ß›\Ù\È]\Ş\áR\Ü0J\à*0goJÎ¾F·ê›®/¿e\ğX)iƒ k•Œ=2\Éİ€½>¥…\×Gg´R\ÒL½ck™D  A\')\öOG\ïXƒJB‘£Å\Â\Êp\Î\İ,ª”x„¾{Æ±Ó©q\ö•ÔŠX\è‰×¸\Ñ)±\êj€\Ü\ÕÁsJQl.S\reÀn\ão½–A\í\Ïx¾\ñ×¦;\"\Ã\\{?\Â\Ì\Úâ‘_¼\Éz?J\Ô\Ø\æ\ã\ôy_W\ÓW©}”\áì¾‹ş\Ç\ìJf4\Õ\Û\îZÿ\0°7¡u°\ö\ô/Q\åg’\ñ#$\Ì\ğ\ñÿ\0Ò²T{5\Ãÿ\0«7Üµ“›ĞŒ8{zùX\Ş$e\rÙ½\õ@û’£\Ù\Í\õ`û–§\ì#\éF\öƒ\ö.yd$eƒ\Ù\í\õaû‘Û³ú1ÿ\0\ÓÜµaoB\ÂŞ„yd$fM°tÕƒ\îJ\Â\ÒVÂ´¶¡oBÀŞ„ydwÄŒ\×ùMıX~\äaØšo\êÁ\÷-#\ØĞ¹\ìm\ä¹\äx‘\Å\ÓV¹ùOıX\n\Ñ=‡Ü‡±û—<’;\â3¿\ä]?\õaü(-Ø›\Éy\ÏE=cR›´WV-\à‹:	\Ãı\Êe\ãD(\Ğ \å\Ãt\òPø¦\óeÁ\\>\n6¾€+F	¶øk\Ã¯’\ì7³I)§\r£\Å`i\0/¥zûè·’¾Ã²4Ø…[T\×C¿ˆ^\è\érş˜¿\ÉZ¤Áıº\ÃÄ¤m\Ğr¥\Ê6ú|\ÓN\×\ìBWV^\æE\âW-\\…\ÔK\Ë{nb\ßB‹}Š\Äq\ê\ê¦w\ã{\òS\Û_†\à\â\ğRFÒ˜\é¶!\ÈAm\İH\Ô\ÏN\ã¾b¸\ò\Ó\êYV8›É«/\ğCzÊŠ=§§•ª*­p7Bª˜¥`¹\î\ä!s{œ…ú‘\é¦ab|µ&\õ2>¯‰g\ÎY/\×\rŒaWUST9#™6I›\ßx¶i\çK–”en«2\â9,n1\æ\î	‚8‰ß«¹82\êg\Ò)„\Â\×]’\Ë\Ü%RNAÉ”%Lc}cÿ\0ş{‡\âS5\Ï	>W“\é\õ:‡)\Z\Òf\ÔY\Ü\å\ê%Ye„\ğˆÊˆB¡ŠYŒ<BL \Ş:ı•º\\.?j \Î\é0\ò~^¢/\ÏÒ¬\ÒdI«\æ\'\Ã5$’cFM\Ú*-¤¦)he¸Á\í’\"\á,o\äL¤\È[¹­%I\Ç\ö5\ë+\Â+	Åƒş¼m˜\Âm\Ş\ÊO\ÚIîŠ‹*Zü­ib™›\ê\ç\Ë\ê¨_“w\ÑaµĞº\áB\ß?Ô‹Ò•¡C}6£‰pDb¹‹”˜è•¢”\"ü\óI[øR M²\\gK1t¸dŒE\Õ\êDq\à†)\Ã<“I\éØ¹2yu½\ï©tÅŠÜº»—\ôT¶›a\ğ=¶„ \Çp\ğª³ú:\Ñ0|7½\Ë\Û\ï\Ñ\ï\Ù8\ê1<\"F\Æp`ºS(\Û)aˆ;\Ø[\Ä?…z“wÕ“ZJ¥\Ú\Õ>\È\à»\ÈÚ©Œaw\ï\ê,¾«™]…\ïµ=ø\æ\r‚¡l[h\èé­¼\î!øYz\Z“eiÚœ\â ˜G‚«\à”øF\ĞEŠ0\á\Õ\á¨\å£l€\ó\ê¾?\ñ\ëZ0\'\Z5‘˜p(¸‹·Ò«\Í\î\æ%ü¸û$V\à†¢2ú}LRS\ËQ\îÙŒr\ãk¥¨\ëjlİ˜‹\âS0a¬1o`\Î)r\Õj…·‚G²\èj# İrJi\Òmw¹Yi#iA‹/¦\çC\ÄNE\ê\\M°\ö•\êY*=¶-\ÜrT	½Œ\ç\áe\íı€Á\åÀ\ö3 ¨\'†œA\ò|µ2\ò6J\ô\àSƒZlwzr^\ÕÃ‰æ §7\ê(ÄŸ\ğ¯G\é\r7#\Êú\çşø\ÔkR›´7kÑWm\÷#.\Úşk–û\Ğ €‚\ç\ë\\@Apy. \0‚ \0‚ \\\çAr\Ôpµ\Å\ä\\¹DLù¢Ú“ywˆG\É&4-&³m>’]9£§„§¨6›\ÕŞ«\Ğ\Ö\ãr•.°>’Ï¹$¬P\Z1\ŞHbûQE‚9„M\í<Ÿ\'\å\õUÊ£Ú©XZ\áü¸\n›\Ã\ö\Z8ş™å“©À:T…TuÀp\Ñ\ÇO\ß,kºª\Ô\ç\ó\è³|H90;\0¤)\ë\r\ê¦\èYù*\Ğ\×%_¼±‚6\ÒøXU\×§Âˆ7u©9‡QfÎª8„t1\Íü\ŞY\'Q6J\İb%\Ê;\ËA\';‹4>ly2+T6|I•R\à\Òa}Y&£¤\Ë4ş{	›Viœ\ÂÑC(\Ù*˜šKYÿ\0Zo \Û\ñ%\Ò.‹T}eC\È~\Î\ßo\á\÷(\ÉP\Ê_\çRd\Ö\ô‡\Õ\óû_\éQ\Ò\Æ\âZT\Î\î\Ö\âš\Ë\Å\ÉNdˆ1r\âŠb\Ö\ñRGJ\Ä$\í’lpù®`l‘\æ;¾])¦\'†\Ó\â\Ô\Ï@\\\Ë\Ô\ÊH\éû›4\Ü\Å\ã~)Y* °Œ[Ù™Âƒº·\éƒ%\Ã+½\\_lb\íÀ‡Ä ¦&´™Ù‹\á%\\j$\ØÚ\İCø1>±%\Ä>\ï‡ÿ\0…]\Ş_Œ{\ĞH”\ÕPVR…M<\áQO#\\\Æ¦Ô©{dBIqQ™r,’ŒOo4Ÿ½7$c‹R=\Ş\ô\ÍÁ\Ñ\î¹.\0;®­²I18’T\â»-HGYrŒ8·\Ú\çş\Ñ\öš,kjgŠ3cŠ†\èZ\×ÓŸÿ\0\Ã\öV«\Ú~\Ö$vJ²¦3a¬6\ÜÀ?\ô¿\Ù\ç\öV°^95dŸ>\Şùª—\Ï\è\Ó\ÑSÃ±“˜<4ø–¶!¨\ò’;YK`ûU[³\ó\'K\íll‘\çû\ã\ïú©ÿ\0\òŠa\'¤§É¼&\ö’@\öVZ3\Ìåœ \ÏX¿\ÂÎ¡V(<\à·58d\Ì\Ø|¸|\á\ì%U¡¾†Ql\î\õ+=\rcFŸ’¨½Aá§†µ\ò<-¹b\è!|\İÿ\0Š²U‘\Õ@u±»‘Z9)\çd;Eu[k’TJ:€],<t»*\í& \ñÍ“»ˆ«-fúA\ÏPƒ&‡Y+\É8“û²u\Ö5AD\0ùyyj%\êÀ£f\éµd]†\ÖQûUdy\ÆÒ‰\ÓøVÄ½o§R««rû<O¨\Ü\î»\èå«–²2T\ÌÀ«®(\è®(%¢‚:\ã\ä€qD·Ş\\\ÑK’d\0µ\ÔK‘›$\0k=Ë–¡r%+¼8y.ş¤À6\ô »w¹¹k—A \á½\äBù:Ÿ¤G¨“˜\á\ïtY$)M\Øy\Êi[DÉËŒU\Õ\Æ\áNä‹ˆ\í³Á\ì\ğ\Ş\ß\ôÃ¹2\Æ1Cº›§”a\äs“\Ø\Åú\Ô\'\òj‡\r1<W\Ëş”\\_\ïT\ç6¾?û-\Â)üÿ\0\ô·o+jš£\ò\ïQÍ‰\âR\Êrz‹¥N=€\á£üÒ‹~B\ö\İ/L1-¶¢\Ğh#\0\î•I4û™j)¯„\n\ô\ğ\î\ß[¹¥5<şªV¢¨\æ\"7Ó›¦û\ÇÔª6‹‰17Ô‰»Ô¤[­Q’\0´–i¤\Ò\\IÄ¥Á3“O\ÕH\É`„jfh\á#Ï¥1§…Å‰\ÏQ¢$­G\ÏL1ø[Sÿ\0…+o\á]ˆ\ò|`Kv’8Z\îIËŠ!sR¢!³\Â\ÅÜ’––\î\ä\ñ\Å\×T CMOjeSOwv¥c8À“I¨|ºR8’©:šw\ËÒ«8\õø	\òWúš;‡\'UüK\rrfm*\Õs2L?j«û+ÄŠ¢0*Íœ˜ÿ\0œR§\Ï\Æ\ïrÛ¶{\Z\Ã\ö“Š¿©jª955¯\Ó\îYn\Ğ\àú\rŒ/\Ò\÷7?…føf=Š\ö7û~\ÅQ€ÔŸ\Ï\Òg\Ñ\õ?YD\â\×(¶Ò±\'ª·|-\â¢\öKk0ı´Á\â\Äp\É\ÚX¸ˆ\ÒL¦J6.KœId­\Ì^\Ù	Z\ÄBy.·JV\Ö!&vÒ’qq|Û¥.\"‘y{—£+æ«½ \í@l®\Ë\ÖV¿\ô¹n T\Óş@’‰ûF^\çµ_oU&\Ñm„X]1¹S\áú\\|\å~¯\ÂÖ\Órm‡\ì\Ë\ÇE°I¸«f¸{ş²o³›#\ò\ÄÇ‰\Şû\÷;\Ş\ïú\â¥\\©£qù¢kHy\n«³È²Íºæ«Š‚\Ù]´–\öJ\ğ\İN\Ú~•}£\Å)\êu²\Îkp¸\ë€smÜ£\Èı)7©\Ã\ç\ÜI¤‡\ß\Õ\õU	¹R\ö–]Q³”hûUR`ûÈ™ŠX¤\Ó\å_\Å6£®?f\Ë\'/\nˆ§\Æ¡†7\ï\Ò\âI\Ó\î<úTŠj\ÄB¢\áÀZ‰-<\Ùú]Z6nú\â‚\Ú\ég‘€\âw´U6\Zä’ƒ\ô’\Ò;\'‡\Ú6¿\áv\é\÷\Î>\î¯\×¸C\õ•5O\Îk\é»Á\ö~“¦¥„NB\òÕ“2’Q\Ø^,\ÑúKÒ¤W¾}§\Ì—!r`\É\Õ\Î(\\‰rˆY£\\\è®N€.K‹¥\ÉŠ`ŒŠ\ÜĞ¹\Ğ—8®\\…\È·!r\â· ¸‚\0U-lE™r\îo4@‹–~B˜c\ÛAOS•\æ\Ç3¶QNj=\äH\ÖVEN\Í#\07šªc;qCdûD\ÈK¥•/\ÚjœRby${s\éªg\õ,‹5MûbiW¦\ÇÌœÄ¶\Ã\Ä.mû\Ä˜ø(¿œ˜³wrw\õ%\é\èm\ÏH£œ\Ñ\Â\Ùø•W—\Ì\ËKˆ	=£™\éÖª`Bz£™û\Ó9cr<F\ß\Ò%„É†9®\äˆù¥·mf\é¼\Ó0²“ ¶®h­\'‹Ş‰$ŒMjQ°bd\Îi˜D½)B’\â.)…lšl\óJLjl\äºG\ñ\ÉgÒŠ»B\í7)Wm\î8H…\Ít‰\Ê\×@`Ww \\‘W|I\Ó/\÷£®¢\âG\Ş\ÊS‚g\ÌÅ›5É…V\ÒøË}$(]sj\çc&\ÑJ\Æ\öu\ê\",fM³»½\ìr\ÅtFÖœd\ÚHVşy6\ÌT>-\Ób<lWs¹E³¢\Õw}3\Éxn%Œv?´#ˆ\ánR\ár\ïi‰\ô\å\é/‘/R\ì6\Úa{y„\Å_‡\ÊÅ™\". I2Ï¶«³\Ù%\ÜTBmi\Ä]\â²JO–{)Ç‡ÂœÊ•İ·IÓ—‘7\ö:­$\Ó\ß\óJ\åüÁ*_~”G…¹ª\çgİ£aûm‡Œ‘>\ê [ç©¤}@J\Üp±¹2j|¢Œ” \ñ!¦\æ\ÖÍ–\ÛtûM´0a”\Åu\Úv\ô¼\Ôÿ\0«—\â[>\×c³;?Y\\\ì\Îq‡Í¨ß€·\âı—,‹c\ğÓ’«¨\ÎS¨+œ©\Ë\ÍE8\ç\ØX¥\ãş@ø&\ØM7P§³P\ÇX\Ú\ô\òz”£\Ğ\è\å\õR%NQ—\Ä\Èu\à&Ytgm^¯	(œcy¡\Ì\Z\ÙCP¹0±R5\Â\é½Nh\ç•\ñ?‹\ÉS¶­\Ë:¬¤QV\rTY;|\èi!\ô©\ê:­\õ6^&k]A\í6.1b\Â\ä;Q\ğ\\R* \ñâ²£\\\ğj=³[‘3“\'\õ-s±i¶Êˆ2·*S/Ø²£%ªv+Q¹\Ûj?9ƒ}ksşjŒy+\Ïé®şÍ›FCQ%E\à\ö—\ö«nŠt<__z©\Ï\Z‰)d#u\ì \ö<”7—\Ëı\èg\ïQ¸V-t<\í>\ñOÕ¥\î*\ãh{ı\ë—\"¢¦ÁÃ·.¤\Ér\ïz\'\\—‘_$[.CÜ…È—.¦Àd5\È\\Š‚0\rr\åÈ·.£\ä\í\Í\êA\ä€\É´{g\r3´µO\Â\ï,Æ¿–²b’Cs7{®\'HMPr;¿R==>\ñ×™¶\ÙX\ÏG]Q­\Zw‘Ô=(S†\òM#Ü€Œtaœ]À£ªk\n ø¿\ÙQ\ñ¹˜â¢»|Y7H¦»Ç“‹®E—$\â:}Ø‹›Ú—.C\á Ã¨Ÿ-I#§{\ä=^”­MSC\óq\õw’„­™\É\ó\Í\ÒK$ŠlqUX\Õt¦RM£š,}9\æ‰8\ÜD\ŞI’À\ãy\ó\"\é\äK¯ı–\\—;\èA\"!\óL-\öŠ›¼\0NOaqL Ì„½\îo¡\æ\ò\âøP>\0\ÚRg¥³R.i?¥$t\ëP¹‰ş$/²ˆq¸\ñ\âr\óF7|\ÑCW4x)Pm	›‡Rg œ\'Ÿ…pd8\ß6~I\èIPdıI³‘:¸±\Ê|\ã\ä¥œ\á<™´¦U\Ñ\é\Í\\\rEÉ¨x³[\ñ*\Æ=²´˜°Im\ä¬\î/r+G\î\Ô*©mOi‹I°5û\'‰\r~1sˆ[\Ë\Ş\ËU\ÙºlR\İH4\0\Üu\éû)\ì´a76e]²qT>\ö\Ø%ï·†j9W`O\äSX˜Ã´Y¿”Õ”P\ô\ñ|\ñ\Û\Ş\ïş–ş\òV›`m\ÖÚ¤°İ:7)e½\ÓÂ¥xË–…b¾\äU‹\nCF\×\nJ«\İ\ñ\êR–\nw°F\Ò5†\Êm‹¡7à¨6\å\É\0\ÌU³\r´²QsP¼oš«*\ğL¬\É=H\Ì\ÌBM¨½e[S³\õ;ˆü§D\Å.e\ó\Ñ\åª\õ}_8\\‡\âM*ws\Å81µ¯siuF\ÊT:5.\ÖV0¢j¨\"©f\Ñ «\æ\Æ\â\r„\ãŒúi\æ\Âÿ\0\í%R£†:9½‰€¾nŞ’…La\òn\å(\İ\õt¨pÿ\0h½bVG§®¡˜&„x\Ü$\É\Î\ãÒ«½Ÿc+l­\÷Kn\ém*\Ëı#d\ë\Ú\ÂJ\ÈFk\ìù¼\âêœ Ä‚I(\ä\à¤U·\Æ\"Ä¢\Ù;\ÅSÜœıB‹¼’V¨§¤S©8\Ê\Í\r\ÅE\à˜\ôx”b.\öŸx©›´\ÓYE\'p!kù!j[w\ñ!j`À®[\ğ¥œnI¸ \\	6~HÖº;\n5©².­t-t­¾\ô-\÷£!+_\É_\É-j\î\íZ\è%\÷h##`\Â\Ç\Ã\õ”\Æ\áA\ä\á\Ù\éløŒ1}\ï7HEÔ‚’\ìhüIøSp\à““\Ã\ô ‚•®\ÆSÿ\0\Ì“Â‚\nœË°O\Òè‘ ‚\ï\Ğ\Ì\r\ĞI\"\éd\\ú\r«?£/¡#E\Ò?B.G°—B¥\Ö_J4¼™ı‘ˆKÔ•\è\ĞA1&\îJ‚)b+.h\ã\Òÿ\0UP¬BNi \ëo¥\ö2è”—şY0¬\è$RÈo\Ò_J\ÕúAW,!4\äz`vc\È|I´¬\×Ğ‚\n\â\èªşCQo›G(\Ø\è4ÿ\0\ÑH¢§m( –]*^¤\Ã\èAE—£\Ù_\Å\İÚ§v~7sRPÿ\0\Íş}H ¨[\ó7kø\ÄŞ»ü\n¯ÿ\0ü+D™ ‚\õ:/ú\ğ<·ş\Ìÿ\0\Ù\ÙzSXy’+ŸeX…\Ã\É\Ç\ÛWr\Òi\İ\÷-Ç¹”\ôW¿\äù\"¿z+H¬&\\.H €gš2 A\0o\n@Aÿ\Ù',0.000,NULL,'2023-01-01','2025-03-02',NULL,1,'2025-03-04 10:54:36','2025-03-04 10:54:36',0,0,113),(2005,'Lokesh Kumar Reddy',NULL,2003,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0À\0À\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0>\0\0\0\0!1\"AQa2qB‘¡#±Á\Ñ\áR3r‚$Sb’¢\ğ\ñÿ\Ä\0\Z\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0%\0\0\0\0\0\0\0\0!1A\"Qaq¡ÿ\Ú\0\0\0?\09¥\ß\éÿ\0y[™o\ä`\ğ\ç9\ã@:“D/´d\Ó4~û\ãdY\Ñ<N<!Ç¦J\0š…ƒ_^!‚\Ú%V’L|\Çş#üR~\ÚN\ö\Î\ğ^\ßKp(‘\ÏËœ\ôı«œ¥{Gjwzlµ(.¯b\ï\"“.C{Y\ïn5O¼D‰Da8«º–¦\ëº!\ó¹\ô¥]Q\Ú\å\0<â™;Ù.\ì\Ş\È\ò\Ä\à\n\"\ö“I(‹,.sU4³X´cxDª\ÅsŒ\åOqj\ÑÄ¬f°6ãªˆÓŒ˜\õ¦d›B\ñ\ãO³?š\ŞH%Œ¡\ô#4\ò|\ÍNšÄt„Mv\ğ¿\Êx.\ÅÅ½²Y\ñm\É4p›’Ø©Ã‹#Š\Ò¹Á‘¿\ä\Õe{¬2<QPG\"LN\İûü³\ÅG4ì‹°`\0h˜¶^MB8\ÚÎ‡¦F8¯Í¯]«`\İJ\ô!\Ï\ö4\Ïxr\Õ\Ïp\Í\èG©¨—\ì—][¾\0¿¸ ywşk¨u­U}¾¥v…|„\Íşj„6\0«Xƒå¶¬-¢\Ç%\ò|™ºŠUA)>\ìn\Ò?µ‹Iµ[\È\Æ3¸l¨\ë\÷­\'I\í–»o\ß\Ù\ÊK7\á\ĞûŠÀ‚ü°Ç°\ëD4\İF\ãI¸ú\Öb²\Æ\Ä:·B=\ëŸ\åø\ò\Æ\á§ÿ\0\r8|™\'MŸ@[\Ì\ëy)ÁR4Ä£ºN8\Ûg8¤]_\Ó\õ{x¦‚t\ïH\ñÇ»•>˜£2Ü¬I<‡ƒq\÷®69g\ñ\ç\Â-£\\–9«Á}{¡¦³\İ.\ÄV#\nrGÖ³c«5·hY\Æ\æ.„³œ\ÒÖ±©\ê‚i® ºx^NŠ\íL±¹}Lti.\ï$i\ß\Ã\ÈLxzyrŞºy\ÔS–Ø˜$!–N\âú\Ã\â\à)Ê•\'[¡\ó¨û=!7×‚\öTMŠ¥8\æªj\Òi¶A…\Ùh¯*‚KR/h5\ö¸B®\Ä 9£6:n\õ©m„\ä¨Ñµ>\Şv_K™¢sw{#f\İx\êH\ÏÚ„\ê2C1’P\n\çœş\ë9Ñœj\Zİ¹™•Q	n}J%¯\İ^\Ûj\É:¶m™rcT\ÉQ\èMi\ãZ*\r{4mS\ğ\×@\í”\é«\\Y\Çc/\ó\ÓoxXd’9ş\ŞU\î£øWy¥\é—i—\éq2!\"\'ƒil€\ä\ó\íJšhµ»Y\"M?S\Ê	\ågd\Üw\Ğsœb´\Ù{E©´2²±HØ€7?j™|¬P¥$Å–\í3\æË‹\ë\Ù%–)b¼˜sœ\ô\Åp°•%¦À\éFµSJ‰®bXœ\İ\ï>r¤\ç’=»”¾\Ôt§)Z´’§²¸‚3pÎŠrN\0SÉ§[´»+{‹¹–8\ó!s\Îz\í\ç\ß¥as\ğ—\ğ\\\ß\İÈ¯³\×8¢Zş¿s¬J\ÂFşR“²0\0?Ş¥JNŠRŒbÁ·šƒ]¾\öÂ¯\ö¡\äş«™›bc<úzT1\Ê\Ù\Ë\íZ¥FG&\Ùb¹n=ù\æª\Í!yù\çVSj†*\ãQw¼$mÁ\õ¢\â599\ö©6\àŠ\îY;´\nTtëŠ¥$Û¸v.\İƒ\ÇJ•o‰\à\óC\Í^©;ª\È\ïÈ z\ó\Å1\Ømkf\ìe^2\ØùRÅ²n\É^¾\Ô\Ãox–\Ö,@))\ã\Ä\éBZg\èn–\Ú|DûH<2·Jin\İ]Å§|$°Gt|\÷ƒ–FF@¬\êYwJ\î¸\ä\ç_µY7r1P\Ç$)R\ÅvƒY\Ù6µa¨H‚\æ\ŞA\á,\ñ\Æ\n\"\çË©4R\ó\ñ\æ\Ö£²\r\Ç\õ\Ú=úùV}=\ñŒ\ôÁ5S\â\÷ùš…7\ĞÏ’Ôšş©®^¸yR2|O3‚Oû¨¯t¨‡\óúY$=I\ö\Í´»xİ[\Å]\\^\Í&[sÓšo)Í‡4½Oøc@\Ì~idˆ;Š)üH\ëo\Ş\ÏrV\à›m¢…|‰´\ñ.xri“²WVĞ½\ËJU¤Â…Óšú\Ø\Ü2¹S&¡=¬¡\â`±•c\ÔQC¶\÷‹¥:F‘³°\ÚI\õª:\ïg\ç\Ğ5CcvD™]\É\"©=q\ëKºÜ’*¤i‘ü£\ÏÚ³<Qr\\‘«“­^vN\öç³°v)c4¬%Pÿ\0-y\Ãg\Ìqû\Ğa!0‘&\ÒzqZ¿g\î—M\ìÕˆ‘‹4eP\Åÿ\0=ı@g9\â‡\ö\ç\ğ¶].\İ5$\É$r>\Éa\Ûÿ\0M\Î~_şŸ*¬>C\É\'-.€ÉÑœE*›”]\Ø\'$b½š\\F\Í\È\ç#>t\ç\Ù\î\Ã[\ÛK$ú­\Ç}t#n\æ\Ş/“~8\Ü\ß\Ğ~\æ\ï‹2<Š\Û½\'ı•$”¹û\Ôa¼U\àÉ´’qŠo\Ó;\'Í¾ùw‰\È9\éE)(\öT`\åĞ¸’œÒ¿9`wb‹_h§Ë‰¨ü¬zÒ‡¸R0HYªSL\r‹\Z”\Õ\è,\ŞYÑŸAS›dúzT\ä‰Á‚vš–rÍ–^(‡ÀŒ\ğ9¯{ENVN4[Ó¼9TH½Q\ï\\ßº\ó\İ°ü«\è*	V=\Ë\Ãt\"©I9^MZŸ‹ÿ\0A^,§½Á5¶[&¸s–«(!o5°»F½‰¦·F\r$hûK1šm¼\ìn“=\ìQ\é\ó\Ï\n3—mü‘·JF‰Kx:v[SN\å#y¿„®\Ö<‘\åûTlˆ/¬vG³úgc®f²©D\è\âi §F\é\çšC0|\ÅjÚ‘\ït+À\Ê0\Ğ7AY#·\Û\Ï\íT[5Ã®\ÊhZ®”Ú¦¥j“\È%d\Ù $q\íZbiº\0µ6\çOµ\Û\Í\İ¸¤¯\Ã`\Ë\Ù³\ç4˜ıi\É$U®MY­~#\è³\ê\ZE­Õ¬FK‹yB\0‹–(\Ş_¨¬†ùa1+’N\è\î`‹†¾œÔ´\Ãü>fL’ª\ïH\ó\ó0\äÖ¾}·I\'K¡¶w‘šAŒa\É\ä`t\ÇLVLº•š\ğ»T5~h‘\ë\Z¢^L\äzsw‘’8\ï!~¸?aO®¾4\ëv\Ú\æV\õ\ôŞş\ê¢\r:\ãMº¶kfC*\ÊÑ•\ïU½\ñ\É>˜£šı\õb	ü\×\ä˜ú\Ö|qQ6Ü¶&[vz\æú\ì,jXIO#\åY7o»9qÙ¾\ÒOk Ô£¾‡9\r\×?N•\ôlš—\ğ\Í<¶7uİ´pW\Ïı¯\Ö.;Ow4\Ç8Ÿ°\çœ}úÖŒz‘X¹Ù½\õ+\ã!3\ÔúÖŸgo\İB¨«Œqš\Ù~\î\ÄK\Æ\\øF<©µj\î=i9¦\å#V¨Ä«{¥­Õ¾Âª\ŞeÎ•d\ìütÇºT!ºbœ¥»XˆR\Ê2*…Ì‘¼,øB\ŞT1•h“V\ì^š\ÒQ6\Û)\'‚\Õ\Ø\Å\"n”Á=ºˆ@“•#‘UBD°?Zb\r!Z{aœ€2x&ªMn\ÆW€y\0S]Å²H\ÅW©\Ëh‘\ğš%*\Å12\ö)#v\à\à­\n“;¹§‰ì¡”a†z\Ğ\İ\ZU\ñ€\Üç¸§\Ã\"3\Ê†Z’@»°½\ry\İ8$ ƒ\æ+\ğ$6Zh¶Yµ#~\Æ_›¥{2Ÿ*p|±R\ØE\ß\Ş\ÅŒ36+\İD<Oµ\Â)\Î89\'\ïP†— jK©h‘1–B­“\ö?½fSF{\Æ\Ú3Œ\ñ\è(\×b5&·\Ô^\ÑØˆeRü\ôR:\Õ9¬\æŠg&	q»p\È\Ç‘Ï¦*¨†»øw\Î\Ãi\îG\Í\Şÿ\0#O\Z-œ7·Le\'ºˆn|yz\nV\ì4&N\Åè±ˆ·3\Æ\Çi`£—j\Ñ\í\í£†\Õm\áP‹Á?rk7—\ä|P\×ln8rd\ß\Æ#Œÿ\06\'„Ÿ•‰Ü‡\ß\"i}’¶‹Z¼\Õ\î•fy¦i \\¨9\é‚y\ëDt\ë1¢\Ü\É ?\"\àªûŒ\Ôú–½c¤i}t\ÛU|*ƒ†v\òP=j²Ë–†C]^GÀLìˆ‡Í°9\ò¬Ó´[\éº\õ­\Ü:\é\î2=”±8\ï08!±‚zqLq\ßKr‚\ö\æ/ˆ»c…ŒŸ\å\ÆO\ä¸\ã\'\ÌÒ§j;]£\ê•`º–)iH\äpU1ûšprt‹”\Ò\Û*vƒ´\ësÙ›‹\Ô2¤\÷¢Xd¨aƒ_AY\Ä\ÖV\Z©–&Á`3\Ô :\÷L:Æ§\ñ\ïÁR\Ş\00B¨\è9Ï­Õ»Uov“\Ùü\íİ¶dc:ª<şS\ç\ï]B-	s\ä\ô^†\ô\Ú\Åq®\Ä@\0\÷\ÅAyÚ©€#z”\ô\ó¡w:Á‡·%€#;Øœ\éT\î\ÚY­–\õ\ô\Ëh \n“\Ş\0\Çÿ\0º±¬i\ö;\äkE³\Ú/¸¹9ıª\Ü\Z\îø”øI\Î9¥\Ä[yCf»GfR\ßL\î©`M2C\\Kwˆ\Ú5•[\×\Ä\Ç>\ÔO\n}²\Ó\Ø\Ó>·•À|J6²_\Êr§œı}«›ı[B¼l´\ë„`»Yò©¸\ÅG\îJ¼v\ö»”\ñº.\ğ}\Ãd~\Ô1\Å]…<‰\ôLšÄ›ˆBI\ÎI&§]F\êB2ÿ\0\âMV±‚k\é\Ú3q»‘¸d\ìúp+ˆ\à\Ôÿ\0\á¢,[¦\í\Ç\Ğ\çŠb‚Í…’\í\Ø\á¸8\ó¯EÀ$N´\Z}Nş0bøÛ¤hü\0	Ø\ëŠ/§\ë6\çN‰nK\Ës†¹b7q’x\èG­G\Ùk%•¯,¤º\á`c!\é\×\õ š•Í”Ê·v\ÍŒ¹*|ı\é\Ê-_.\Z;5`½;\×\Ü?AŠW\Õd›S\Ôä¸›ş¬\È\íA\éG’=\ì\ï|š½¥\Üh\á\çIï”…`qûW×’vW³\ZÅ¼s\Üh\Z\\\İ\ê\ËZ¡<Œ\õ\Å|Št¹£\Ó;Õ’BT\îÁnƒü\×\Õ‡7¯y\Ø\rY‰\ï~&s“\á%µN¢8:³\óş\ö,œ¦k\ÍPş ş\Ô#Yü\"\Ğ5i{Õ»¾µ\rª‘”¡\\ş\õ¢n\ãš\å€5`\ëØ™¦\öM{7§Y[\Çr·\öˆQ]\ã{Q—1[_O§\ĞU\ÍY\È1D:µ\\É¹¿(È®>y\Ãf(\ÔB\÷V\óË¥¼q•I\ö\ä\Ó#Ş²®\×\Ê\×§Ò­®¥, ˆ¶\Ò8ÿ\0ïŸµ\×{ms¦\é“\Ü\Â˜Ø”ù¹\à}¤k\Í_\ã\n_\Ü\Æ\Ë<p…v|œ\õº]‹I¡«]Ô¥\Ó{;p ¼†\rÅ‡“1şÀ\æ²\İ6‚#5”Û§u<\\»Fx\ñdß­6iı¡¶\í“sdûw\'†D<–Q\æ=Ef½ 6ªú|^\áa\È\ãËƒ[<jBr«\ì7&­g²¥\Í\è2!(Ä¯x?cŒPû/‡²\Ö\í\ï-%¶%\İMÛ°\Äq•<Ÿ­¸–v\ÑA\Çx[|˜\äúc­tÄ•\r¥ÈaÑ»¬s\ô­û!q\Óµ-;\ÈD\İ\Ù\ğ\ä`=ø ·W“Qjn\ÄŸ/jpÓ®ÿ\0†utŞ£\'».Ÿ\ç\õ1°\Ò/e\Ã4\"V9Ë¡OÜ€+œ\äÓ£k‚j\Ä;+‹·\Ê\r±\Îx¢#³‡P\×,´\àIÜ¦IH\ò@p)šş}:	~)°8	o>~‡\0~\ôK³RŸQš#¹UE“ª\"\ô\Ë$\äœ\ZŸ#J\ÉI‰ı¬\ìå¦…z%°\ñBÀH9\\`*Š\Ø\Å$*Ts›\×\Ğı\Å;\ö¡74\ç‰b\Ç\ÌR¥•”\ğX7{n\òB`t—k\Ç\ÎH*x úd}j\á7%²§\' lúS¨\ï-\ÆGš“U19n\ì¡£¶Ú¤dG ¹\Ş\Ç4J?}\ÜT²v;\Ò3\Ïü\ÙWúş”wBøX½&3B\Ò2t\éú\â¯=‘x9\ãÚŠ\ŞcqÄ± 8Ry5$«\à\å\éB\ç\è%¶Am\ØG™ ³X\Ì%™‘Ny~cÖ˜\"«ÿ\02\Ê]½Td½W\"5bş›ªI\ò\îmÔ¬€‚\Øù‡¥nŠ\í Ó»#cj¶\âUŒ6v?3qÒ±Ò«/v\Â,/\Ì\ÌG_¥hš\n4;XÏšnıI?Ş°ùÙ¥	Á\Ó4a‚›¦?\ë9O\ËfŸw?\â¿\ÖŞ²øa…G¹&”ƒ\Z¿“µ\Êü\Ü\ÏÙ«\ñ\ñş†\ï®/Z9n6\ï9QŒ\×W/\È_^+£Æ–l§À‘’\ç\Ó\'\÷¨{Å¸˜K+´lş™«m½¾\Ìú\ô!\İ\öz\ÔX ·\Ö\Ò\Ú\êI\Ø\ÑMÃH9/Pü6\ÖV\Ú@\×\Ö\×J\É\ÉF\é\ÎzkamO6\Ñ\Ä\ö\á\Êu\rŒ\Ç\Ô\âª\Í\Ù\ğ«›Kƒş\\¼ÿ\0æ»‰™\ìù\Şç³ºÖ›:\ÉlŠ’\Ç\Î\ôl¡”3SMbı‹Ol¡×«\ï\0°5°kºM\Ìw{]YwgÖ€jú¤}\ì%Ÿ\ó\èN€–û3=qrÓ¹LD»\öA#ŸÚ®\Å$—,²H!X†\Ş\0\É\Üeı\è­ü‘\ØÆŠş Ä†\Ì\01B\Ö\õV\ÖŸ3I!„œA[\ñ\í¥¥¡Š\ÂoıŠ\r\å‡Lùš\âÿ\0QqQ)\ó\İ^\Ão\İhV\÷D\ó|(À8Ò\\1°o^+5\öf\è?¢	\ör\âu	\ï\'V 7s\õı±L–ı¬µ¸’TM¤\õÀ<ŠR„C;d+“\âaA\ï$[iZ¨ıWÎ‡‚—a©\Ğßª\ë\"Ty¸#\ô\ö¦3\ZÃ·jƒŒ\ã­’\ò\î\ñ1%GRƒU;¶€QÚ›I-‰–Ka¹\ÌW\Ó\È\êJ0|ªÅĞ‹0Ê‹½z\ÏmnŸ\Ë!‰\äÔ’L³m8\àÕ¸\è!ˆ].\Ô\ö¨\ä—$\å±\íBa²950rÆ—T• Œ\'=*\äO´0\Î2¤f‡À\Ä \ÍJù–Eà²*Yø1$©’\í\È9\ö\ó¡\Æ!ES\0\ô¬ûE\Ó8´kiX	“iÀ\÷\Íh(›\"E<\íP+—ü‹N‘³\Æ^ÎƒsEl}q~]Z…\É™4m±™Û«>ƒ¥s!š\'.1,k®\ñ\ÚM$/…#k.}*–‹z‚¡—\ò®\í\Ó\÷«·§½´™`6y\ë“\ëTt\ïl’\à¸U9\n^\rh1Œ)o|H)uÁaSy\ñF\ØúŠ\Â&\í\÷i“+6¹v3ù•À\ç\ì*§ÿ\0;ZnZ\ëWr?üN~„~\õ\ßXŸH\É\ÌØµ»©I²Œ9\ÊüÔ¹=±*U\á‡\ÊÜÒ—¢\íÿ\0h%…\"\Õ,\ôÛ‚:\É´n?\ñÁ×—}²2¸Š\ŞÛ»&=\Î\îs´\çÊ8\'`<‘\õ\í\Ò\â\í£\ï\n˜s¹b¶O\0šO»\Ón!* \Ş\Ñ\òpÿ\02\ç\è(\İ\Ä“\İ\İ\\\Ê@Bå¹\Æy\'\ôæª¬—r¹(m\Ùzn]\Ì?a[\á•\å+<Òµ™\çµ\Ò{¹\'u\\$¨#q\ğ\ã:“\åV\ç·?\0y\ÈÁ\Íu\Å\ÛÈ³\Ær$Ls|\Õjwª\åc\Î|Á¬™\ñ\ñ|82rú‹*\êBY\Ê\Æq´u4Q\î$¾ˆºXº…\ğøb\ÉÆ½†%k\ñ\ğrx\Íø˜\í•Xep3½ÿ\04HĞ¢,¬\òF\n¬S†ÿ\0³ıT\Û\İ?\Ã<`\óºC·\ïF\'\×s¸\Äù§O\÷Bh\îe/-Ä}_úS$Š’Ay9Š\n¤œŠ\âg[\çŠ$\×`HÏ‡Ú a`U¶ZŠ¾#T–Lj\Ê\Ï\Å- “-ŒRG\'\ô<\Í\éS[¹‘\Ğ‡“UE½šœüL“\Õm¦zBÓ®\Ú\ò+ˆ“s\ó\à\Î3L«¬\Ü49x£;ˆ®“\ádÍ“”z4\ã\òa\Ó[B\Ó\İGYºûS¥¸Y˜\Â\ãj`¶:ûVcü¬ù/O\Ú]ùºÑ—¼\'¼S´·]Â“›\Â~<y7`şB\Ê\é\rœw6\æ7;sù½>ßµ[\Óm?‡\Ø\Çld’Xû’½qCq\ÅNb‹8^_\Ë\ô¦N\í]I\ÜHo1\éY¤‰~“\à\óR!’=‘ƒ3Œ/ûûQ‹kh\ì¢hap\ÌyfpC1ÿ\0\Õ$ú‚¦Aš>œ.0µ–\öbI*¬	\ã+Ø¬q‰\Ésl’y\Ú·:7ù¨\ä\ÔU6È¸Ï¿¥@g\ë*Ä®z\î\éúÔ¶ı™\ß|“„€\ò¨A\É\÷\ö]\ôQ\Ü/¨…\ï{E\n 7ú¢l\"¶‰AUG…|¨;\èWh\Ä\ÇxBç€®¡uyfOz\Æ\â/>|c\é\ê(ªe›«¹p\Èã€¾UZ\Şù^\ê^Q¸\È\ò>U\":\È;È¤\à\õ\öûT\ì,]×Ÿ\\UN<£L¸Ë‹´\Z·€Ëh\È\Ò\æ¥°Ÿ­,\Ø\ŞÌ¼¥]M\ãˆ&¨®FH8º:š’²­\÷gm!pfªzŠ¦º=¢¾aSV_R^\óq\çŞªÍ©‡c\ÅzDs\ÚG\ğ\ôªR¶\Õ t©\'¼\Ü<]|ª„—;1lO5øËV3zWOV« l¸$\Å^±I&}‘rÇ«Š=~µB\Æ\Ò[ùB¨!G\ÎŞ‚›,l\Ö\Ú!@_\óD¡ûS®‹–\Ñ\Ço\Õo2zÕ¸\Æ\îMqKŒg-çŠ–\ê\ö\ÇM‡¿¼G8_\Ì\ÔŞ…w\Ù~\Î,œ¦+-M\ôûBBX³’„qYš\öºú\ò\á`Ñ´Ğ¡\Î\Ód®)†\ŞÏ´¨ŒÏ­\Ä\'#!\ÔlısIÍN<X\Ür\â\ìÒ»?%¦³k-Ù·&.\ğÆ½\ê\à‚\0\'úš¨\İjz¦\éiq!€ø\Ò7\ñ(z!\Ù\Ñvz&–9.˜\Ëİ®$“\Ó\éŠ),º¿}1\à\ás“Ÿ\õ\\,\á.,\Ù\Ê\ö|\Ñ|\Íc;\Û\ê6·r©Á†t\Ãı‡¥\rk\è\Ô\â\Ê\ß§\í_^jz^‘¯Á\ğ\ÚÆmw•#\èzµ\"]ş	\è\ĞK%\æƒ!‚rr‘Ü±‘ş\Ó\Õz\ô±\Ë}˜(Ç´\Í\á\Ùou	\ÎF\åŒ#?\Ü\Ñ	\'8\éDµş\Ïkz1\Ôle0\ë/Š3\ô#§\ß·%\È9ıkDkĞ‡~\ËRM\ÅP–a‚§\íPItNrxª¦BÆŠ\ÊG“)Š^\ò<\\\ğ±ÿ\05Ñ6vT€\óŸ\÷Q\ÈÁT\îG\n5U\ïr\"g\Ï;n#Ş…²\è\ëiY\÷¡\ÃgŠ!\òÎ›7ùŠ·£vCYÖ˜\äZ@\×\0ŒıVı©\î\Ã\ğûB\Òa7W¥®\Ù9f°™ÿ\0´zÍ™Á¡ø¹&e\÷>\Òq\ÍT3°Šh\Ö\Ú\Î\÷P¹–\ÅBA¿\n008\ò¹s®|8\÷¬¶“£K¶SiœŸjŒ¿­H\ĞH}*„&L@4\Ï\Zlt«úf›5û\ïaˆÁ\ä‘ûU­@k\Æ\ïfŒ¬]F\åÁ?\â›a´X‚\Ã\nx\0\ò£I\nl\Ò\Ö8¢TEÂ	¢0D\\…Q´z\×qZ\ã\æ\ô«7/´1Án=\äşÓ ÌŸP(¬\Z\êZ\ÓX\Ì,lMx~vo–?|W\Z_e\îu…º»W¹¹-/Ê¿AL:7fl\ì}6n.\Ü\îgnAoaMI˜‘AÀ\ö<‹¢¡\Û\Ù*“·v9ÀA µ#Ç¸\×,ü\ñQ\É Ş†\Ë/\Û\Í±\ßn\Æ&\éœ\ç?Z3e\Ú\è*Ü¢ÿ\0šŒŠP2Š\ñ.·a¹\à„ûA\Æm\Z¿Z7\Û\ÅTW©CŠ“\Í$S\Æ\ğ\Ï\Z\ËŒq}ˆ¬ßµ?ƒºn«¾\ï@›\à®9cn\Ü\Ä\ç\ĞÆŸ\É\Í~Ftl§Z(\Í\ÄÏ”u\ÍS\ìş \Ö:µ£\ÛL	#\Ê\Ã\ÕOB>”\ZK°œ/SÒ¾¯üA\ìÍ§j»/5´È¢\á\Ém69À\Ï_C\éYGb\n\ì/¥[›\Òd¶FÁ•\ÇG\åQ\Ó\îkJË¡Ì·HÑµ\Ğ\Ş]\"\Â\æ\òRs\àS…ú±\é\÷­7³‡:‡e¯\æ©{\Å\Êü$=¹9\ñ1\óúV\Ë#i–\Ñ\Ö\×KµŠG`ÿ\0\Üi\"{‡šF™\Ûs19\Ï\÷¥K# ‘\ç}¯°7©¥\Ş\ÓŞ­Õ£\'\Ä\ì€.N\Ó\óU\İ]š;8„Ñ™!s‰§\ÓÒ…±’T£øÔ…\ñ’=p)5l4\èÍ´‰sq{o¼:ƒ½qÓ®?¦+»½\Ê3\áÇ¹\Æ*\õ®ƒ-¯h§\\]€\"§;·\õG$\Ğll\ã\ï¯ş`gap\Ì>Ù ’¹hzuˆ\Ğ\Û\Ş^¹ùO‰‡Eú‚™4\î\Ë\ÃlVI\ó4¸\ÎOA\ôCP\íS%\ìQ\é\Ö\Ñw11\ÛN\íı\èŒ=®\Ìc~šû\ñ\ÈY8\Ï\×§¥Fw;\Çj@TO—§Ò­¬3À\ò\äÒº\öŸUšLCanªz\ËØŠ\'m®]‹½>EoùEœ~Ÿ\î®À ³0U,ÍµTdŸAV4_Q’ML®Àãº·\\|±?©<\Ğ\È\íe\×fKX\Ò\Ë!®&pTmÿ\0€\ÏRzS”jÀ–\ö\éˆ\ÔÖ¡d‘F°\ğ\æ\õ®e}‡h\å\Ï\í^\ÊM´\\\Ôo1\ĞWFS38;G\ïBS8vØ»›­C¼¶OJı$\ÆY3\Ğµ\á[Ë‘\ò­(\ğœ±\Å~\ÎzœT*Dû]xy\Ç\Éû\×H&°Äƒ\Õ\ÎO\é\Ç\õ«!¬¼TŠ[¡\éP+f§F\ò4‹45]’¨\ÍXD\Æ=ë˜\rH\ó\ÇË† sÇ•Z\ÙM•µQ4·ZÁœ°%±\å\Æ3Tm´{=³\Ñ\Ãqq#-¸$²xK±9û\òh”\ä²w¨ÁC¨\ÎG8¥\Ñ\êf\âo‡S˜ 8ü\íşºS,X#Q¼k™\Ùİ¾c\ë\Ğ€{U\0\æY1\n\ó\õ®%m\ä\ñ\Îz\×q¨\æcT\Ê\'“ù©>GÊ”;C¨{G\Ùÿ\0µ¸r³(\ê‡É€ı8m `ûP^\Ñ\Ï‚fUk¬b\Ã;}Z…v]‹Z\İ\è\Ó\ÉKp¢\ñ\r!9\îÁ\ç\ß¥g\÷s³\ÌR#\Ş\ÊO^¹&‹\\›R\ä€\çi<¹\ä±\õ\Å\Ó\ôx-G{·s€\ÄS]”\ä\Ø?I\Ñ>\r\ÈN\ß1\ô\öil\"|Œ1\ô\â­\Ã\ç\Ôz\ÃEi@’Aİ¯Çˆ\Ôl Mœ›‚A2%£\öt)W¹”\íU9&‹Co\ršm…“\Ô\õ&½\ËH\àc<Ğ–Fp±B\n¢\ğ¨<¾µ;˜\ícc»ù§<«¶1Ú®\ìfC\ähs;\Ü\\œ\ò=1œU’{©I9\ÙÕ‰®n®–G\Äp‰Àºšd³‡º_˜\ò\ßÿ\0hWz›\ZV¤]Kc‰\ò\÷¨ŠeÀ†*É\ÉsÈ¨\ÖInÔˆAŠß¯{Œ3ú\í_SQ¤mpKJr‘S\ëVÌ„\àÀ\à\n\"Š\â·8I\Ç\'\êk\Ñ;t\\ƒ\í_¥\ç¨Z„\Ã§°«)Ÿÿ\Ù',0.000,NULL,'2022-01-04','2025-03-02',NULL,1,'2025-03-04 10:55:38','2025-03-04 10:55:38',0,0,115),(2006,'Sree Hari Balisetty',NULL,2003,_binary 'GIF89a?bp\0\0!ù\0\0ü\0,\0\0\0\0?b‡\0\0\0\0\03\0\0f\0\0™\0\0\Ì\0\0ÿ\0+\0\0+3\0+f\0+™\0+\Ì\0+ÿ\0U\0\0U3\0Uf\0U™\0U\Ì\0Uÿ\0€\0\0€3\0€f\0€™\0€\Ì\0€ÿ\0ª\0\0ª3\0ªf\0ª™\0ª\Ì\0ªÿ\0\Õ\0\0\Õ3\0\Õf\0Õ™\0\Õ\Ì\0\Õÿ\0ÿ\0\0ÿ3\0ÿf\0ÿ™\0ÿ\Ì\0ÿÿ3\0\03\033\0f3\0™3\0\Ì3\0ÿ3+\03+33+f3+™3+\Ì3+ÿ3U\03U33Uf3U™3U\Ì3Uÿ3€\03€33€f3€™3€\Ì3€ÿ3ª\03ª33ªf3ª™3ª\Ì3ªÿ3\Õ\03\Õ33\Õf3Õ™3\Õ\Ì3\Õÿ3ÿ\03ÿ33ÿf3ÿ™3ÿ\Ì3ÿÿf\0\0f\03f\0ff\0™f\0\Ìf\0ÿf+\0f+3f+ff+™f+\Ìf+ÿfU\0fU3fUffU™fU\ÌfUÿf€\0f€3f€ff€™f€\Ìf€ÿfª\0fª3fªffª™fª\Ìfªÿf\Õ\0f\Õ3f\ÕffÕ™f\Õ\Ìf\Õÿfÿ\0fÿ3fÿffÿ™fÿ\Ìfÿÿ™\0\0™\03™\0f™\0™™\0Ì™\0ÿ™+\0™+3™+f™+™™+Ì™+ÿ™U\0™U3™Uf™U™™UÌ™Uÿ™€\0™€3™€f™€™™€Ì™€ÿ™ª\0™ª3™ªf™ª™™ªÌ™ªÿ™\Õ\0™\Õ3™\Õf™Õ™™\ÕÌ™\Õÿ™ÿ\0™ÿ3™ÿf™ÿ™™ÿÌ™ÿÿ\Ì\0\0\Ì\03\Ì\0f\Ì\0™\Ì\0\Ì\Ì\0ÿ\Ì+\0\Ì+3\Ì+f\Ì+™\Ì+\Ì\Ì+ÿ\ÌU\0\ÌU3\ÌUf\ÌU™\ÌU\Ì\ÌUÿÌ€\0Ì€3Ì€fÌ€™Ì€\ÌÌ€ÿÌª\0Ìª3ÌªfÌª™Ìª\ÌÌªÿ\Ì\Õ\0\Ì\Õ3\Ì\Õf\ÌÕ™\Ì\Õ\Ì\Ì\Õÿ\Ìÿ\0\Ìÿ3\Ìÿf\Ìÿ™\Ìÿ\Ì\Ìÿÿÿ\0\0ÿ\03ÿ\0fÿ\0™ÿ\0\Ìÿ\0ÿÿ+\0ÿ+3ÿ+fÿ+™ÿ+\Ìÿ+ÿÿU\0ÿU3ÿUfÿU™ÿU\ÌÿUÿÿ€\0ÿ€3ÿ€fÿ€™ÿ€\Ìÿ€ÿÿª\0ÿª3ÿªfÿª™ÿª\Ìÿªÿÿ\Õ\0ÿ\Õ3ÿ\ÕfÿÕ™ÿ\Õ\Ìÿ\Õÿÿÿ\0ÿÿ3ÿÿfÿÿ™ÿÿ\Ìÿÿÿ\0\0\0\0\0\0\0\0\0\0\0\0ÿ\0…\r(\àÀa\\È°\áÁ‚#f&‰\"EI3b´XqbD…\r*™0¡Ã“(S.L¦R ¦Œab†\ÙbcŒ˜ŒdÆ¼)sKÏš:µ\Ü\ğ©³(\Î0’t2\Ò(i&†&UJJµªUªÉ„±D6Œk\Öa_Yj\Èu,Â¯eA›È–&^“.J\â5·®İ·o…\Åe+\ñ£_‘Ñ‚\Õ:x+\Ø\Ã,#^¬X\ñ@–N¾|)IŒ$FgrÆŒs\Ë\r¡ 9‡‰¡E\ôMÑ¤‡n#”(Ñ™£eŠY¤3\ó¤_F\Î¹aÁ§\'6ø© 2Ş„\'B^Î¸yc\çĞŸK?Lr!D±\"GRo9¤@^N\é^ÿ¤,)Rù—t›V\Ä\ô\ñ©B\÷Oùt\İ\÷I\ã\ë¦™ ÛŒ‹ˆaTQ¯múƒMa,\è kC\ñµ6”j\Z•™l\õ\ò|±µ\ÖA¼±T\â‰\Ã|²o$&7_ˆ0FuÕŒ•%XWe%Vwj\Ù\èRŒ™x^&n\ÙeSEZÔ‹^\Â\÷£Z×‘Õ›„%FW^-\äUA\Æeˆ\ä]¦\Ó®– \r±Õ¤EŸ\Å\à‚4%ƒjƒ›£•†h\ÆÔ§Q³ı‰n9Ruˆ\n–Sı\õØ£‡©\ÈUq,y2˜¤)f)K*r\Z)X™xšL¨rµ–@–*\ôUuŠBzŸZ˜,ÿ©\ŞEt¥·Ky\ZQ\ôa{°B‰\ÜC0úW‹#´\éJ\"­J\İS-µ\Z‘Ê™ƒZ8\è&P0Dø¦g6‘6gµÜªÃ§¶ haˆF€¯¥;(QŒ F€‹\ävª—¼©8%‹¤’ø\âB\î+(\ÉhT±ˆv¦>\õ¥Y“Z=Å•{G—]r‰‘x¹µ¤“û—(™º\ÜXV6\Úo‰\ÉşH^Ñ†¡™L İ”í¤!˜ ‚\ê\É\ó¶s\ÚÄ ·y¶º6\Ë\ë®L7Ç”TQ¹5Ù›v,¹g*£m\õ£˜\ìªÑ•m˜bY\î\Ç\Üb“ş•\ã¡ji\'w\ÜM\ò\"\\So1u¤\ÇIÿB$\Å!\òú‘\Ä]	§Ü¡QÉ¸ê–®¾\Ô\ñºbD2fƒ=\ËY\ZAc~mj@w»\à\r\Ö^\È\íiw\Zx\Z·r\Ó\ö‰\ÙÍ–-\Õ¿ÿ\"lŠ\0¯\Èr,\Üû¿ &,¼À ¾8jv­¦|\Ê\é‡DÀJ²ED\âU+Se^É€û\å\ö~\\k\ÅWı>w’e$û\"9I\ò¬NšWû³\æ@û4\Ï\ç\â?4\èû\ßy`ƒ\r\ZÊœfrÎ´N6´\Úm¸¡\ÌH\"z\rq¾ˆ·\ãŒ$ıY[–\ÃH1§Qû\Öp\å\ï\Ä\è^Á3Dz10»¹\ğ\ÃUz\æR½%\Å\ê#\Õ)aoR\å…kk9\n[\×ÿ\æ3C\É\ÙfPcÚ“Mî§¹Ÿİ‰~\Şb¢ş„\â&7e‹L\ãºSµø9\ÑE@Dé“€5F?½¯O’˜&ú%\Ä\í\à(\ä\ó°\à±b5ª*w\\\â\îSY\ĞTR\n›\Õ’ü\ğ\n… ‰{66\ì\å\r/L¢˜“¦¥À\õ\ÑQ\çCY!\ÅŒ\ÌK&	L`g\êGJR>Q\ç’\"œ|Æ¹Sú\Ï[41–6\Z\ÏÀ¦Œ²ĞºÂ°!\Ü\Ò>\öùJD\ô•°’\ğN*B&\ó E8\ÂÁŒv*\â\ÍS$Ö=\ö\æP\ÈN_\Ş8º“$³²Kz\Ò\ó–¸(!K\â\Ş$\ÔÃ’\Ä|§\Ê`\à(³®\ÛL\r‰=\á_iTpÿ?~® ~QŒ?\Ô&Ï¡²hø»‚lp\'†ŠNt´\ôS.uRFI A3\n\ĞRve%T\Ú$°€Õ’ÎƒùW!Q¶¢\àt“Ş¼WH¢\'¸Œ)„H\'5B\ë\r\Ãn0m§Zl\ÚM\Ê-\"ÀiV$\ñ¬zİ“@˜“\æ` ‚Ÿ<sb\çnÀ&\Ó¨ªpú\Ö\ß\ä?®hâŒ›¾(Ñ¶R\íiG\ÄM|\â(7b\Ñ\ôj»™\Ø1ï¥¯LÒ‚y-pv*¡~d¹«${Mƒ€g}£Hz\Æ3	‘\é†b\à\é%i*KE	9\Ïs\nS-IœÁ}ĞšMQT\ÙOü¬`\Í*?ùY@¢ÿt«h­bi\Ê\Ği\İiiY\ëÓ†KÑ˜ \á©Ãµv~‡Cè®¿»I\÷\Ú=v°!•Ï‹[É Ê‡WÀIgH„\Ã\"e\"7<ÍÈ„q\Ã\È(–{\ğı\r¢¸Ù¬E\Ø3\õª×¼\"\× ]\îgÿ4\å@±*\Åİ ¶L¼\ßÿ¼Å°¦€”£%œ¸\ê“>Ğ­QTºd—0eIo7\ÛÉŠ*I\ë\Ö.>½ù7W\Âé‘·»¿\â,c\Ãû¤\ŞT6\ä…d\í¢\ŞÊ¾\Å#qA\'‹{5\ä\êÚ´n/‘\\L\ôK›h9y¸\0*ş\äOª\"\05À@ûÇ³\Ø6\ñÁ¥‰e\ê³\Òl1\\6 ›\æ¦­\Îÿu=\Ñ\Éı8_9ed\à‰\ÌRL\Õ\Ùj8Œ…$$\ÃÇ°\ß}©“(6+YE&³¿b\ÕD6†—\ì\õT=?\õˆy«»Xÿ¦/am\èIP\îR3ø›­@JeıUUË˜#0U\ô\Ú\Û\ZÀª§\ôWÓŠfş\Å\ÉN\ô\õ…\Ø$\Æ\Íhøi\\u\×F\å¦\çI¨{Y¯|&™\ó\Åkd¯f\ålf9;\È\åFP_\nI\ê!\ì\ôH|Uˆ\ÎE\ê…\Ç/\éEE¹¤ ‹!˜ş´{­\Ë\é`DrS\ä\î>™L5\Ö	Æµ•\Ì\Ä\Ìúª·†¢ıh­p+fU¡j°Z\Õú`³>´]dP»X\÷@µ8\Óuÿ3¯e!\Ë\ò¦0‰\å8N9EÜ»m–G›/7j¡\í¤ª\óG™Mg¬¢ã¦€\Ç\å#	\Æ0K¤\ÎP\ŞI\â¶@\ğ&^„`8yùaµùz\é$@K\Ãc½\ê«Îº\Ê^^uU\×n\ÕvY•·²\ÛK2ÿ–\ãc.-9\îš2^øO¯‘]\ï<t\Èn{\æ\ó\Ö\ö‡„Tx¿\Z\åªù\ÌŸi:\Óx›üwhJ1\ÌZ½\çÀq\Ë\ÄØ‹\î›¨}›D\ß`hNh\Ç\\\Æ8mo_\\\Ş º\ä;9m´B	U†[Yˆ2•Y\ë\Úú\Ø\í>(\ÛU	\á9eÕ·uÚ¸P\Î\Ña7—Â\Í2Â»£#\Ùn\óş±ÿek^x·lú\æ“Ç›eÁÏ¤\ÄSYH\Í\ó\æ\Zts§\çøş\é\r\ó-İ¸Üœ¡zp1Y\á!u\Ãr7\ä=*\×^\í%z.Y\0‚˜\rrp­4ÿ´Z&P\ğOX¦[ˆ ˆe0p\0\Éw@q…:S\æ?ºv4¿uEœ:]%§a¦CQ‰\ç!³¢z\Õ~5$~C·r\ê\×m‘wC\0øƒŠ\ç!.Dt»B{AxW»\òS2£c\óy\Õ\årÀ#,nL\á8i\Ô~?5z~è–†Á^@„\ÕSj6\óI\â9\Å\÷‚^&wš\ãOÁ\çvÃ‡k[V|u˜vıDkLav‚‡Á•E\çRheƒ\âÿ2c}\Òf²$5{ahO¨1„¨GxC2~\âÇ‰˜…Ex^z\ñcCwx6”uA–x ‘TV¨nJ’q!8#±^jäƒ’UYi4º‘yqayYw†£Šû7s\éÁ»W“H?—#kú\óO(\0P|&8k°¦WkT†‚‡L\Äp&¨?d¥`RD.§t9‚w\Ôfn80\Z{²\'kB(5Š¾\ØS6g?6yIˆdCBzC\Ç$C‡iD„\0ho\ì\á„y!‹›Wo}1u3Gz¶w‰U—b9+½CnQY5\ôr‚Fx\í\ñ\â\ö7!+Â°.\ò\"JK\Ö\rb4¨´v˜\ÃpwU7[7ÿy W:YU&¸|„\È3XfU‚˜q\ë(EGù?@S@ŒQ\á\"QnfVx²}„i4ŠI„\äg€©\È,„Ç˜„€\ç§xAh€\ì$\ÕSz\âV€™¢\÷lÂ‘g˜Y\ê·1‘µ‘êµ–©x€¡si’E\çtš!pªu3úS“À”€8­q\Ç\÷p\ÜØ\0U”3iv‰I?¦˜“J{\÷-\Úç’¨A.±1/\ÙS=E\ò…ˆggøRµnxm±ieyg~\ÉAøl»²$>7‘=7u0…B\ö^7´™\âaN4$	NX2yVh\écyøE3ø„3=cP\ÃÇ‡\Ü\ÈjuX|`u™\'ÿ‚10‚Á\çp0\0yxe¨™¢\ÔÈ˜¹Vv<\ó_L¤Hs:g}“H9¥!½X$u\Ñr“s°\É$\à–*Ö†F‡sÀ‰ ,¦›%™\õ!\àqnyâ¶Å©‰t€1…/\Ô7\ç\å7Q2\Çx\ÜS‹\áBÀ\é\Î2(¨\r&e\Ã\ô	\çp\å	ˆ=ªÈ‡™\à\Éj\ÔH‚8š‚ã¹©\öU·5e›i?L\\¦\óqK“\Éfq­A3&zŠ‘mûv€\Ø{±sGt±§¢€3	 s\ë\ç¦b!\n\â\÷›(§.w{ù‡‰xÁ‹;Æœ$–\å\'dAHŒ.«gq˜š1Fÿ\ÓZ^6‚\è9‚‘‰£ß¹‚ŒI`wUm—`\êÉÁ×£\äI?&˜“\ßÈ‡\Ã35ÁUg‚fa€`$¢s³œ¡ørFs\äUufZŒ“T†\Ø%d8U2\è&n\÷F’£s.a—jhhY\'‹Á\ØrV\ÙrE¢zª\÷Hƒ\ä\÷h%c¦\ç6o\î“Q»4&5aÃ‡97¹[&“/ˆ9\ê[2™:Z¤EZk²¦”iªD:¤·¦üÄ£\÷\ëŠJ²\Ä-¥D5‘W\Ê\Z%5~\Ã~µøb(\å\\#5T7–0\à!M\á;À\Ùxš›ŒIø\'‘z5‘#b\Ä\ÊH©\'YyC­à·€\ÏsNbt¸\Ù~¸\"‡úÿm\æ£\ïZ?\ÛÈ³Õ©#H‚\0Å‚€ˆ¯LŸ•Š?v“W\ö{\ëÉ‡\ÚHv\Çj‚HPq\"4&/•\Èw° N\ç†\Ä\Èg/¦t\ÖÁ½jc8d\ÃB¬Ãˆu!»¬zÌºbZt•\ç•\rK%\Ú7\ñ\ö§”gn0¢lxª 8H\ô3P\'˜‡\Ş¯ ¸™²\æZèº¸|\è˜IÚ£¨d©E‰UûJ‚n—©FÊ¤\ô\ÃZS”Pw\Ò\Z\ãbaÕ·\Z>Q/Ê…\ì6S\"Aj;G\Ãsm€qNY¬Y‡7¯ˆn@5—¶InP\Ø~¡\×\ón\Ì\é8>–oqQ²\Ò	t(9Ë¸_8\ÛZ„¯~˜¯’«“Å´šÿz™<³\à¨|qÇjº:ºpé‰L´|\æ\ŞYfY´`1\ñˆ\ÜB¤¹}*’€¶WÃ“c8Á¢oeK\és\é$:6—^)nqÙ›y¦¬³¸Q¢ªw\Ôú‹d¨m—¬H†!\ç4\ñ£pOº‡uø©ü¤d\÷‡\ïyp1Ù¤*¸½\×e›ZVU?>IU\èÉ¤/¨´6ªUfU\å\"\Zù›lH\ÑMD7_‘†<\rX\ÙArzo3K¬e8¡Ê»$#c!—´§xt\Ñt˜·p!Yk™oÀñ¼°ˆ¢4j1fƒ4Ş¸´—ùO™ú½\æŠUŠ¤2<f®”U\æ(È™{[PûU£\Ëj\èÿY2™|±EE\÷Ãˆ\ôŸ¿5D\ì…R†@\ÂgshER\ã,tTX\ïÑ¬Y\Çy¡—\ÆyZ·ZØ¢\Æî§‘¡Áº2†ùv’²\'n\Z\ê\Æ.‰\òDB‡9š¯\Û>úp·4\ô˜\Z±¤37Ã¤û‡ÿÊ£U¦\Â\×DN+Eÿ\õŸeE{\×\ÌI¼oG6T0\Ål·+O8²6^\ò¶W²V˜—†¦,\Ï-úhP›/„ iÔ‘~zŠù\\hnˆ–¥\ö\é\âIdÒ¨\óù¾J‹\Â\0uOªp\÷\Ó\Z0 4\á\"Ñµ4®\n\ÒÌ£¤»i§®V\ö¸PT|Ø¤RÉˆ©tVRs‹\í–iy…R Rz\ô5À\õ%hÉ›tª€\÷Wxı¶xÓ¡¢W\ë7Šè±§Ë‰•)$m‹\éA[°&\ñ\'V\Ô&\ÖLKª\Ş(¯5Œ9fBt2_\íd\"\Ö\í¸\'¬‘\ZX+\Ñ	]\ÈSe\Ì7\é¯V\Å\Â:w¢OYT\ZP]xz\öM&–Bk;¤\Â\"‘%,Ez¼\Ë\ÎqIt:Œ\Ïf§~zøW{Š‡xhÜ‹)o¬š0\ë}! <XpùdŸ6<´Ü˜‚n\İ-|ıª\ák\ò\Z\ÉAa=Q&erd\r!°\İ—¬J\Z\èjıDª\ék¹SÖ™Sf \â’E¦bß±NBR±›}5Å©B,ÿT¬‹Æ• i`\ÊNŠeÊ˜\èÊ˜ˆš\æEC`¨XÙ•\Ú\Z^yC\Ú\ÏRpŒ:-¦£@g‚%\rEGC!¶´-¾&\õ8 g\n«\íRšhPĞŒ‡‹‹\ÃÙ¼™ú\ó’@Ó)e¸a\Û%_84¶Í‘gƒ2É–¼û\Ó\Ã*\Ï8ÍŠ\Åø\ÜVŒYM„t\í—ÁYX€šYhQ`v\âR\'§Á\Õ\á\áJ\êÂ«\ä-\ËL!5Q&D\Û\"\÷IŠ\ğIpœ!Â’4JÉ¨;Ÿ`\õ¹\î\ê´øJ`\İR±A4<\á!s™1£bk\Ø$„,wT­X<\'—@§i\ä‘¸s¶\÷À˜\÷c\èı\Şÿ\é—%«L¥3 Ëœ™9<|Š‡?\Ã §Qp|\é\ó2å˜¾\é‡\ÎT£†\é\Ê(jLuO`\Ç\ÚÉ¶M\Ê\èª}\Í\Ób.A#V¯Şªe:B2b*´Nÿ¢LU2HW\ò(£’œ&‹\è\ö°\÷¦cVL\Ï\Ø\õ ;\r8·\n¡\î\çƒ8„N\È‹†+5£T\ß\Ör9\Å\Ç\Â,\\¤I\Ë\Í/©°ú»e]-I–n³T>/\î\îŸ\Î>\ìc3£–´•	¢/Xn\á\ÂJ\ÈÌ‚|\\Ÿ§;V\0«?ªa^´>1I¦7%\İO\ÜQ‡a\Øx\Z\ã­\ã\'E·mk§!Ë›úy\î4\ÅK‘\Z1/ÿ£j%\ä\í9ºnÇ“\0K\í\Z\0ş\Z›N\å\î\é>\ßT¤Ep\õb‘ \ïæ¡ŒN•_\ád\ñ\"\ÂIKe>v—˜\ÈW\äkL\Ä\ÚŸÄ»‰±&\Æ*\"±5\Ã8,\õ­Rn\ğÅ…\Ù\ôbVXI>­’\Ú\ğ·1Ihy\æ\'z3	d.ù\ËU¹f—\Õÿ\ê-ÿ™¥Jk\Â{Ÿ\Î\ó£\Æ_F_/H\ï>\å\ênLù—\\N\ÕFo—\ñ\ô\í\Òk\×vı‚yÒ¤B±¼O»#²u\Ñ\åÉŠBAı%R¬h¿\Ø9’#«…\Èú\Ê=W‹\â\å/‡…\å\÷*\×\Ş)_„pvedV¯Ne6¡½\n\İD5ÿ5H\ÛN\Û[0\å\í\ï\ìc\ô¯S\ô\ß/j\îc\ô”?\ô•\Ï7›Ÿ+==U¬C\\w-f\ó)Ÿ\Ğ\\q\ö\É½]$i\0!l\Ø@a™L6L\à0dÃ’-LxP¡Áˆ1)(\ìbÆ\nb\È+£Ç‘‡u,™É¢°^#%\Ô\Ø¤L^\Ã^\Úd9\ó¢$1IZfK˜0b„#iŒ¤+”\Âxú´)Ô¥Iµ\Ä\0³%\ÆQ-G‡n	\Z&l\ĞEeE³\èLY g-\Z\Ém$F‘€J’D\÷.^¼vù\ò\â+lAI™ø¢\á›/#£D‘†‰ac‹\ä¥Ral¹¡\Õ\òRPV^\Z\ï\Éa*%N\ôhš\ôE…ÿIK„Hr˜\'„…\Ù6Í‘$L˜o›\ö‰q˜H•¼P¼ˆ²\åI^*e\n\äY°f\ô–™š\ç\ì…\×qcÌ\ÃX\Ş•©\nÎ›•^ºµk×£DÇŠ…OVlYºp\İ\Î}{\×.\\ºvıÖ’@^QL¼T2l’‚K\Ì& \Ğ ª±ˆ\ZŠ)¥ ‹\á*Ğ¤\"*\ó@sÌ š\Ú(7‚H„\í4\×\Z*-µˆN\È \Ùt³¥\Ûv\îFŠn£Œ\óM8\âbÂ¤&a®“i8Lªƒî¤H3P’¢\Ä2j«\nco\Ã\Ï<¬¬\Ãoø²«¡\Ú\Ëj0\â‹Ï¬»Â¨\ë¬E\ê‚S®¸\î²//dPÀ\ô4Ì¦\ìl\ZhÿI–\Ä$AL](F\"tlÂ¯`¸A0%“\ê*¨”\ê0S\Ğ\Â\Ã®‹T;¨ U	8\ÔHk(¡Œ’¹\è¡\ÜL*‰$•|\\$aE	£\åz‹µD‘0²\î\"$}\ÍI!&•\Ô.(1Œª²,•\Òj)I£ı\ğª\ğ\Ú\Û\â\Ì1\Ã\n£4\ç[K.7\ß\ìÏ¾ú\è\Ì¯:y\ñ°]€\ÚSTxúPÁZt°Ÿ[tQ\î\Â\033,­X©ª\ÄûP©Ho`D\ÆMšqµ\Ò:m¤[F5Ûœ\ì)\Ö\ZW\ò8Gz}\óØº\İ$\î: ¥Ò¤š„•$-4\Ò2*3\nÁ„a\Ë™ú\îÙœ©²V²\ï\Â`o¨3‰–/i³\ò#·ÿM:û“¿ş\ÔÕ³j«\ñ2P&™DÔ LX+­9Ie\ğŒ·\Z#ª«­ÀÈ¬mh\ŞpÓ­\ÄÀºbƒ`ºF˜JÁŒ\ò&\õÕˆu\Ä\í·’ovVŒ6^)G—oS™\È\á&2RÁ$3’©.¢¤¬r(1b¸á²¥²L\n3§`\è\ğ²\Ë\"\õ\Ê1£»E³¬ù‚BK®µ\Æ}:N§\á’\ä\İHl\ñË¿«tA\ëdÌ¤—x:Èº<Ec‘\ó3N7«Š©\Ñ†L2¡EL\ÆRm<o‚d­ïˆƒ\ó1G5Ê±e`?ş¨ş\ë&\çU\ğ\ö7\â¨V\Ù^>I²Ğ°¨\ôL)3R9X—\Îc¡eF2\Úr]\Ò\ÒD»·ˆ‹iÿ»\ë\î2˜A;½\ËV\Û\Ó\Ø4‰š8\Ì ŸšD&¼\Ö\"ƒ/²Ó”dH½¶•î€š¹–w@)\Ñ\rLl\Z”ú–$ª\ä´\Ìo\ë\ÉüNˆ¢\\!.%%Q\áx\õ7‹I0Œ\Ü\ã®8{É¯D\ÆL„‚Ò¶-0K{\ÒLR~f\ÑM++\"Š\"À\â	J©>a \ÍE.û\Ôi?yá\ô¼«\é‰P\n2a b´¶h^‰A#¢=š±\ÉuDY´&´•M\êP(m\ë§&A¥&$C\ä\Z¬\Ğ¥#R\Ñ7*	\á\'¿\İ9XT¥\Ç`\Åè°¬IA\Î¦•U	\æqŠ—\Îc³1\rELa8ÿ“\ì–v»6•«-ŠŠ\ÚÓ€\'Il\Ó?\Û\ÔW¯Èµyø*g9\Ç\ö\ÂN.Sb&+,‰˜D\ÙJ>!#0\ëÙŒw–#”Ä¤s¼û%Nrx3	ul\Å+(\Õ\ÏVü[\åC\ë×«Á5\ô%·y‰‚®SŠ¾l1\Ô\ãŞ²0š\Ò!¬¤\Ö#\Z…6ÁÙ‰e-»{\Ë\Õb®¸pSj\ê\n¡]!=¥P+\ê0ˆ!2Ï„W|!]\Ì&%)zÕ›\Í&$†\Ô\ì“ı¬w6W˜+08\ñ›J\0\Ê2ƒŠo\n\ò28\Z?\\2n$¿BNEcù*X&):\åÃŸÉ´C”nEJ$Å’Á:³¥§¯\Í\Ê\"ÿºB¥¶)¦t2›\\¢\'rO?ü±)»\â<Àd4\÷\êÓ¼Ô‰¼L(#F\È\ê\ò†(\ÄDO4‹ Ù¨\'¡«z²J\Ìg…È¸ÑˆPZI*µ¶·$\r±¬Ø\ßB\'\ÊJ™Ê•°\Ü\\c‰‘(^¢M$‰º\à˜Ï©%Z\Z‚\Û´Ã¯¨šn$»\Äe»ûd>\ë­f›vQ\à\õ‡¼b\0S,\ÅÈ¨\ÍAˆ\ÃJ3X¬Â€!_\"1ÀHlG†cj„§TO­r’˜ú,\n_Àjš¨dd¢5\Ş\0\Ğ\Ş\0˜¡‡[Ÿ¬p\ÙP\Z=J\×\Í\0md\Ä(}’)˜ÁRQ\Ü\Æ\ÊX(\Ù\ÙU\öÿÌ”’EO¶<R\ï\ÒµúX³i\ğ\İ\à\î\ö’Áû*¹§W\\- D\ëYt³À\âÌ £—º¤…Md!`<­Šƒ\î\ÔLŸa\n=u8”ÀOA¥\×p»:Uú\nJµ\ä˜,\íV’½O®3*œq\rœ]!\Ë1úœ›Q¸\0¦YS£»P¶$<\ÆFÉ¶\Ü»D.úP¶¦\ö©\Ë\Ô\Î”ùÚ¥Õ€\ñ\Ë_ŠD\Ğ%\r*I\Ç3ª—YH`¯\á\Zk’ ]\Ä`\ÑP²%\à(#,Lˆ¡;s¤!#©\×\Ù@8I’‘\ğÚ›\ã²Rc\ó‹k\ãøn§xº\á\ŞMKŠu$d¯\Ô\ë\ç³\ÓH:©d©\ÍK$\ì\"\Èÿ±Cş>\ä\ä;R;Y.ú¶\Ï.\ê”\ğº\0\Û.Œ`\Ä)“y	fI2:\Ô	\Ã\çµÔ†/F\Ê;\Ô\óü\Ã?\è\ñ\ôn\rg6Ì€9[\Ú\Ú^&1k \á\Ùd0A¤Œ\ñŠ\è@wŒ­Œ{ G\Òa¬¨5\ç\Îscš\é\0ŸŸü\äm-„³¤ Z\åu\İ\Ñ\Ør›`c\ì\èº×…\á\é€\'™€\ĞÂ£¼Á\ßıq\ßO\ñb×­ı\ö\"¥TAzAZ µ…‚ùµbbwÆŒQ£QØœxª\Æ{“\ì!\n#~\Ò\Ê\Ô\'\î\rŒ^#\àÛ¸¦–\ÜN\"G\Û¢º\è§\Ç\Ñ\ç\r½’½B\Ø(\"ı\ÜH5\ã”gÿØ¢#}l)y|z»Ø½À•ü\ÇU\ß³\å\â ^Z-\÷!V<y;YŒx¯\é\ã‹ysg\á\'º9F1X•:9~Ş˜·	.L–ƒV“€-\ó\ç[«¸\ç\÷\ó}F7ú¹\ÑW’\ä¼u¯\Ò~½	ÃŠ¸\Ù¬€°ÅŠ»¸\Ş>†®Û…K‰®\ã…`x	\Íz…Óø\ÚºhµA\â,Aú¼§\å!\'\Ê3ŒOá‰¯ik‘*°GŠ’Š»»¶†ƒ\'€q3\Ğ\Ñ1­h.ƒÅ‹=\ä­j³—[c¤ó‘ƒp¿\Ó`+£‘iûˆ\Ò+	VI+Zr	Ì¡\"L  \Õi¾‚ƒ©Œ·\Éÿ1\ë‘0±\Ğ7\à†`˜‡yh\Ã6ü½E6¸ˆc—\0!5;Q5>l8¸¨9\ñ\í\ËCã¸²è„\âR±±©¾×˜9t*\Õ\"¡\çYŒ<63›°Û‚\0dŠØ›ª~\â€\Ù*\Ñ\êˆ%<E\ñ	•Š\ñ9\ñ‰]\"·Xz\×À¿*”\r+œ‘¤;™\Û\È)\ñŠ\İ\Z\Êx–À²¡0iZ\ã\à7$¸6„À]†\nT¯<‹¶ƒ¹¸/û\Z>F\ğ`ÁwÙ“p\r…\È9´*Œ40­;¿K§Âˆ=!œ²4P*é™¡¢\à™0\n(?ª\âGO²‘SüŠ¡˜):‡XÈ„H•P\Ùÿ\å´úƒ¥ù\ñ<Ó›\ÅU±\Ås\ãŸ`1y²™z\ZFp–¹Œ\ÉÀº #±\ÈQ‹\Æ#	;\à†HI±À\0\ñÀ¹\àC¸x=œ\Zl¸¿h—:\ã‘`\Ù;ş²	/sMhÁ\ã\éEı6u¹A´\à›ñªª¡\Æs”M\Ú$cº9Ë˜Ut\'TB‚	ÚˆH(\\œĞ»?\Ôk¢»Hı£BŒHŒÚš33˜º\ÉØ´	2^@[\n;šŒF6‰¾ˆ\Ë@>\Ä)¼‹W[8\Éd\Ë\"Á\ÍÔ““\È±ù)@idpG¡’‘ˆ0»*¥Œ’¸Br¯\Â\ÇE“}„J¦\Å\ãÇ€\Äÿ0´ù¬‡q˜\ÓK\×`ˆ´N†Nø±¥Y2œüiœ¼D½\éªË£\Î\'ú3¡¸=Ş²J‘–À\"&Mƒ£4q5bC\ã…\ß;\ÌhT\Ï](’#qµÊ¬¡$¾ªù£w\Ñ\Ém\âpÜ·AÙ“¨ä°ŸĞ²F*\'Ë„\ÒLMš³	\Z¬šI—«,3\Ç\ğG¨c\Û\ä\Ğ\'\Ì\Õ*É»„TK\â<A\Ë7\ŞH½µE¦ü›\Î[¼\Å\èÚ¼\0©\n\Û\'\ÎĞŒ\êy#Ç ·3\ßÃ„P»¸®£\É\ñtO|—\âJ\ËÂ¬n\ìÃˆƒ»DiÍ—x$-+®Q‘v*G:	A°À°\Ä:±G3sÿ*\ĞÁŒ!Ô¡ªúœN\Â0N\ê-&„Z\áDˆƒ˜Å´$	\Ï#º¶\"™\åÂ®\è¼BÒ“N\\\Â^Š)‘³fKIŠEµ¡(¯9b‹ˆ3ı<\Ã\\Æ—tI\ãj\ôÀ6©2»Jû´²d„R%\ãn$q\ò\Ò<#\æ°?	ªd P³\Ú;œql\Í<¤\ZF-61£¤4\ĞùD4ø\Ä\ğG€€Œ¼\"JgÕ¼;\Îu\"¸DN\Ë»\Ü\ÈA%	\\Î¡“+\íh°\ö¸ª:Ic\Ä³˜w\é\Ç¾jd\Ì5¤É±¸BÕš²\ÆSm\Ò{MF¸µ¾\Ø\Ìı\Z\rCr.eA´’ˆ\Ô\nª>©µGÿG€\á\"Š\è!#6%£N4\ÖhK2\òG\Ä ˆ¼¢û\ÍSBQ•xˆˆ¤\"]zB\è\Ì\Ó\ç<:\á$\Ômµ‘M›‰\Ğ/¹\Ò!\×\ÙÙ·\"©\Zp»$(]„NU²w©W7\Ù¨ùÃ–Ü¾\÷\ÌÃ†\ã\ÕAj\É\İ\ÌeMÿR¡\Ó*N\'¼—\0JÄŸ\È¡\å\ÌXÓ‹¼03I@)˜»b\Õ\Ç\Üü¡E)a1U•ˆ E<Õ¼+¼µJ½pãˆ•\ÍÈ»¼\Ë×…œ\Ó\ÆuŠ\n\î\à™¿¼8R“Z‘(R\ÎÕ“³‹\\„‰\È|\É\÷ŒÌˆ\óÉºhµº\ÈÌ©¹/\Í\Õ\áû *+Dş4ÿ¤\ì˜A²M¥Z\r\Û>I\è\à…ET\Ğ\áÁ¾XK)±\ÜGH\Å|\ZBPb¶…\Èi¨\õIş¡\Ãaq´=ËŒœÎ‹\Ô\Öµ\Â\Å\õ\ÂC\n\ğ\Ê\ö8‹\"iO‘8Oi¼K¥_œ\ì}S¯ú\Z>X“\İ8Ú©™\Z%³,(…µ$¤]eM\0}$BùO\àbÂ½;\0+\r˜9\rØ¾Hàªœ¯\Ä\n \àa\n\Î\'»\åG®\äÁ¢<\öS\n‡i\Â\\Ô¥\ÛÅ˜\ßXY\\o%ˆZ\Ì\Â\Ó\óE*¹*~¢Œ™‹8\È)ú5ş}Z\ß\É\ÃT²lü_W³Œ\ÎR\İ%\ÓC\ŞS\rA^\Í8\Z*ıªı\"!»c\Ğ\Ù¢<D\Ü\Z­E\Ş¤Áˆ+3! ¡\È\Î\Ğ\É\'¥\0\È\å.­\è0X\ÔÀ‰•$ÿ:HŒ \\apK·\"ºE^\Ùî˜\è,½\ò\ÕH\ñ…?†”C½¤¡§À´Š\ÈÛ·#abÈ‰\Æ\"yOl¤\Ék5Se\×l2n|\Ú9¹Ì¶³,\×ˆM—¡\ÔZÀ\è\Åkk`>ù\Ï|±µI„ç«š(™<ŠµÛ½Ä¡Ü®\ZV\é§\Ï!V¡0msŸ¿	R\ÑB\á\ğ\Ûø\Z¨Kş\ÖYnW@+\ôE8»*ª\àø\Í\Ú#\íÀ³[b<8S•)Nİ¸h\åƒc—ãƒ“å“š@ê¨\Å\â‡şµ\ÂÁ1¦¹Z\ÍE\ä©¤Ò©œ\ÒÇ¸+\ŞKœQ‰–5\Â7\Ã\à\ö\óŸ\à\è›\'z•ÿ£¿d™\\\ò\ä\ñIv\rL\×<ú$F¦\ÛcI¢=»Ne—±;\Ï\ñ<\ÕW{]|MÒ–,P\Õ7Yn¸´‹bEY>\0ù\É}¤`\ãL³fµÅ‹\"©\ÄaxŸj\Ø¢A‰\æ\Ìü\Ü`\Æ\Ú\Åpªk1\Ór–²æ€™›AY\rmÃ²‘i¨#R±@3Q\0\ßEV\ÎÄ¥Knµ\ä¶\Å\ÄUÈ“8›4³¨€¢X\àKjO;»P\ói\Ğ5\Õ\âG@Š‹´\ë7¡ş¨\å¨İ8‘\İ=\ÌW=qe\Ú\ÖZ‰æ©¸¾¶˜À‰6Gyk\ÜpœX\Zü\ÉBZ\Ê-{ºfJcM¼¾\0Š»œÁ&¢\Å\ÙŞµÿ’\È\ò=_€\Ãa‡™•Ç¶˜Œ\ĞÖ¾8¬*1`„HŠƒ^P<¼\r\Ï\ÎjWSUW{\Ú<,¾~Ş‚f5øl»j’Ox\ñIª¸\ÄøI\0.¤šxØ«i‰—\Ğ+a\è¸F\î\ã\ÒÚµ\ğtI›}€\Ä1ºù¡Î°BÁ9Wº¥s±_Zœ•†r¶¥Š¼En\ìt\æáš½¿\ñu\\UQ…T\ö¦\n\n\ñ«ı\ÄT\Î&evM\Ò|m;À\è\×ki‰İ‰\í\ã«)¼\È@\×\Æå¬LœR+3Def\ë\Zt<¡Á\Öü#np+W0]Vn˜\ã,\á55S\ä‰\ËÁ¹o;K`\Ê¶¼%\á8\ç†ØˆrK…ÿh‡Zd\ÑÓ«\ñ\Ö ‰C&I¶G\ÃNÇ€0˜Ú–\Ô\ç£\æ\ÜWV¯¼\ĞI\ôrZ7$~`}Ë‹m\ÒÀ¹ÀSŸ\İnü\ÉT\ÕU8\æú53A¾€`\Ù\ğÁ#JÀ \õ6k\rX)¹\nz\â€|³n<²4T|\á—\î\ó?Â¥\ñl\Õ\ñ\á4\ï\Å\õ˜‹\ß;mˆ\ëgyŠ¯ÈÍ;¦\å\ì…(\åFú²\ÆO\Æ,gZŸ“\ÖE¸§\İ·\è@nš\ëd>+\ÛO\ÜNŒ³S­¦<\Í\íÁÒ¾D6\ïh6øª\ôE\ì€a¹“\ÖAF2	\Â>Ÿ\ôÑ›Ud€¥\åÌ‘…R\ôf\Üd`l\ÇaBÿ-=…\ï\Çm`b“3\âqÿ!¡IUJ­\ZM\àU^C©^\è\È\Ä\ŞYFın¸H\0›2¸Ê”ZQ\Ë\ï¬e\ğ\î\è${k]!\í\ÌD´\Z\Ü¼¹\ét	!ı\Ü\ÌE)\İt–d\rB,\ñ\Ç\×c\óNp>f½\áÓ‡Bo\áÀÅ†`‡Ty]\Ú\áMˆ\ñ\Î\ñş	\åÕ1Ì–S5\È\Ù_¡&or‚\ÓÉ¸¸Tü½\ÌÆ¥O;Ê¤ü\0ş\à\ö\÷?\ÜÔ–¸ UFùek¯‚tœ\ßLµ\Õ`\ãİ“¢µ)ı\õJÙ„¹º*\Ó\ë×«—^K‰PVTÈ¶\ÌûAß¬y9uùW\ÜuVLx§G›\Éÿ0,\Ş9p¥}D»*Êª/(~h\È\Ä|ı\Ä\å\Îg²¥\ßC‚K\å†;\ç`²\æ0–a\çØ‰y\Ü\Üe^’&	”$‰‘Aƒ#\ÙR\È(’¤…	\rB¸‹bÁ0\Zc„‰#Ì\Å\Ä y#Æb\ÂH\Z6L\Ø0L.]&s),\Ù\Ía\Èf\Ö\ÜY\ó\çË˜\Â`:\çÍ£Â%\Åù\Ò\éÎI\Ù\éJ\Ô\éR«5“V}\n§¤E+Ãˆ\Ùr²£Y-Y.Š\è\ö\"\\I!^\\Ä‹n$»v!Vl[KR$^v1\İh˜nXÀr/Š\Äh\×C[\ë†,\Ø\à_†€VØ™/\Ânİ†\î%lÌ™	e¾LXP!&\ÎÿŠ\rO„¨\Ğ5\é\Îy!t¸\ñ†Y³&Åœ½Á\Å8Y²’2\r«\Ù<\ç×™<s\Ò:s¨U\ì\Â2Å„\İ{v¯\Ã\Øm­ú•¨Õ—\\aJ\Å:g²v/\ç	3¨q‹F[b€Y«%L[Š!vWe-rQaµQ[I\öPc‹4–_f`—µµKƒy%\æD)¶˜c³\éF[A¦vZ}\r\ÓRK\×eR\Zn’`Ò‹$\õuÖ›m(2B ˆ\é6‘ˆ‹%´p1x\ÆGJv\\H(İ°R69\×\ÜsXU\İN\\f“wYi§TUµ\Ç\ÕN\íH\å|c&…L\òd\ÕS\ÃD¢YJ—\äZ\Ù5\Z‚!&I-ÿj`\\E\â!ˆ¼\Ô\'¡„	³£\ruH`c…Ø‚*$†Fš[¢\Õ\'Pj¡½“j£­š\"&·&\Z_Š!T]t›A?&\Æ~6\ì·\'“a\È0%ûi$&\Ì9w¥–uR—\ÚO\Ô\Z\õÒš\Úz\ÉP¥S;\ëµTpÒ‰\æKj\Ú$\ÉXù\Å0lHhC\Z¨d\Â\Å _—)ú)¥a-\"Œ£F*(ƒ»>\öPe}Z/E$\ÎfdD‘ˆv¡h½FĞ§%‰i.\õ2s\ÛÁ/\Ã\à8\ñD£)¶ n¶¹*\è‘™…J\ÇnÑ¤F\'M\ÉOA_ùlu@Qk“P\ê\õ&Rm¶IŸyeÿf[&vg¦\×^¸\ğ‘W°ÀB)opø	\ÙPn¼E2—e“=tW¾4C\\‘0‘\ZÁ{\ñR—§R6WDnzÙ§—U\ôi¢U™#ŒƒZ&Œ»¨1m/Nc}-Ş»\öC6d˜§m-\Ä\ğAµµJ\Êr´sGb$\ë\ä”6b\ÙU—]M]´pvæ¶¶_-^ì»¿™vV¥0‹\ô\ì»\÷%©Ñˆ£-\×ÚˆÕ«\é\Ã9|wDı…\÷\Öz\Ã\r\n¾Xfw\ö}E¤\nyKÂ°ÿ¢Ê©Å´²\Æ\Ò1\÷\âk½\Ñ\æ–\Ì	\Ñ[cÿÒ™]±\Ëk{\â\Ï’\ä\ÅH~D#\ŞVˆ\Ö%jq\'w\Ú\Â{\Ì®ÿ®\Èir}¼å¦<L!QÔ•\Úi%ø\á\È\ÏV\Â±5dW–ib\ö\ò¼´\íaĞ£K\Ü\îÒ™`H\":[[l±Å¥_o\ËP\ö´9\Ç¤E¸2\Õ\áx1#\Ä\İ\Ï~Û‘Nk´ø±–¹,TP\äEÈ¶«\ôht\ÄQ\Ë\r  \ğf \Z¢34ù½\î:\ÒqN—\ÔS.\äxQkŠ\ÍsH\õˆN\Z¼I\Ö\Îy\éIyf	ƒl\0v¯\Ù+`h[øø–Áª1JD\Ö/\Ñ$s\õ\Z\ß_ s(ŒLl€#\Ê4¦¢\ĞÀ¨4¬™‰m2‰\Å\åh˜!›\Ëx_¨H	¹U€&‚ ÿ\å$\É:J@¢,L²\æ*G›\Úy\Ã’12L/‘‰RH¨5\ó¨\áR\äšNhAl\Ñ35VƒZ	](G°‡%BrM£\"#¨…ub)”¾\Zå¨…lqÁ\Ş\å\"¨m2W=†H¥ªÛœŠ0/\ê\åŒ\\#\îs&\Ì)\Ù\ÉRB\\’ªbŒ\ØkH”+Ï˜\r0b!Î´‰ÍÈ€I\Â\É#ıøG0–Œ&©©\à<\İ\äÈ\È\É)PsŠœv²5›p;LŠT\æ¡Á.\İI?\É[‰5Âˆ?	DD²ü$‰2C™¼Ñ•	\"&(5 K\Ü\åTr{K\Å\\* OI£›¼È©dEš0vŒU‰s\ÉI\ÉùEû	ddÿø\ó¯‚ ˆÉ²W	mÂˆû\È\Ë$v,	H\ä…\Éå¬§+\è§L0á”š°\Û\ò„¥\Âº\Ó\'$lä¹¬r\Âİ¦k‘\ĞÁ:»¬¯”·™(\'=\Õ\É\Å\Ô\å.‰\"\Ñ‡Â¡\Ü-n”b¢^ù¶ÄŒ^ds•I®d·ˆÄª4,rKü&T“\ö\"¤1\éM¬B\çª\Ä,\æs­\ä¤\0‘yC¡IJ*]Nax²\ä—ã´’Q\ëtÚ¤¨\ÔV&\äI5§5\'‘¤ZxÀ£;t%…>\òFX\×Ò®-ˆMT’\ÍĞ†~D3E±­J\ÌC\ËPGí‚ºv\Å%†\ô—\ğ\Ö¿P´\å-5ª*\Ât´}“ÿ\Í0¹“XV\İG©AM\Ë<w\Æ\ĞI¤D\Íû\Ğ3KdI(A	%\ÇÉ—\Å\à:3L$\Ë\à™\Ó\Í3\çn\Ú)“\ç\ó•­\õ\ä\nzx{.­‚0:R¡&~À*’\Ñ~|ùùÂ²/M	Q.¦\\±\Ü\n\Æ#\Æ5G6fb¥GU_\ä\öX¯\'2ªTŠ^^¾\ïT™¨\Ò\â<F²`’3\Õ\"e™eWŒ\Ïä¥‘Eq†\Ín\0N6u*\æ\ô=¬2\äK21\Âß\é\\Şª\n|¢\ö9»\'[\æ)\äƒ#x‘v-$‚\ÖY¤Œ«Ái\Ò^“!‘d^l·	M\Ê\Ò54C#B\Ä6,r	7ª\É\Ú;•¤z‘ûÿXT\Òu±\Õÿ\"\äL³E½Ff™’¯@\÷—Ì‰E§j\áH€CrM±b¢µn0bScf%O°‚\Üz¤œŸ•¬©P\ÛA±vQ\Ğ)µ—¿¼5\Ù\Z¯OG–Í®¥W¶ŒENŒ\Ã{”\çF\İ\nX‚Q7¸lwas\×]°ú,`\İ\ØÀ‚F\ë\äE\ïn´Ş‚#K\÷û\åK\ØW#5\"*6QB\Üh¼›•›Pú\òH\\gœ¬&\Ş;Ò®#OB…N†³m-l\á3Q\rÏddmSŞ\Ö\ğ39[Ğ‚\ä+\ğı•¹œ\Ò\ä\\\Ú&¸»\É\Í(¦7Ê»sQ#z~\Ü\õz¾Ë–¾PÓ¼³J™S6ÿŒy(ƒ¨\Ã\èı•ˆ?\éÈ¤}x5Rf“\É\Ğy\Îo\ÉA‹¯o}\ÖEI^ù\"t¬Ú½BZ\Ã\è>#\Ù\ó\æ«Pe\å\Ğ†|\è´\Ú–Vw¹½ŠWX(4\0\Z“¢eIoX\Ïu®\Ü¢h¢\àRtM\×tIZ}\\\ë}†Fa ‘\×dYE°RúˆÚªäˆ“u \ÖOœi F\Èl”|qÎŠ\ç\Ñ\×Cˆ\ñÈ‹¯QRÀÀIlq\ó¬99…tC\÷A‹³…¶]Õ¸0U\"\Ş!©K<\Õ\Ózx\Ó:MtHB\×\Èı%fYd\ĞC\ÉZf\äË‹ÁEaÀ\Å\Ê¼\r/\ĞU,”-\ñ`TNÿ\ÑŞ¨Œ¦9ŠF\Å!ª-‡IıÁ‘LŒ\ãˆm\ğ\ÍùH®}WoÀ\İ\"\ğ\Z\é`\\—İŒµO‚R)\ÒLh˜\ÓÀI™\ô\â\Ùú	¡=˜!!\Ã8µ\Í!\Şî¥†&Gü\Óş\ğ\ÆE0Ğ›\ô\\Š,†5\İ\İFMD\ám\ZnÔ¨\Ü^xQİ¬ \à|UilG\Ê`_D –\îİ¡ª©†K\ğ”\ÅTD\ğL\ÑK(1g€\Õ\åm\r\Ä\0PR\İ\Ç%…L8‡\r´\õ‘–\äD2 Eø‘V¹SU\ÇùE[i“\"!\"qEy$…\âGr Bn–|‘J¿\ôh\áK-\Ñÿ\ÙÄ•*9‘M\n*í›©œa\ÅE1×¡\nª\Ì\×\åUG\õBh\Ä0½B s\Ø/µVı|E™\È\Û\õF!\ÖFq­`úš\"¶`)\Ñ\à t<P\ÑÀ#\Í\r$Ôœ\Éli›&ªŸ7T€\"&²Ç…Q°¨`»¨ \Z\è\Ï\æmc\\\Î^\ÉsY\ÄB	c*Á\ÕİŒ\á¾\í›`c\öŒ¤\Ô5`©ŠªœŠ˜\n\ÍOl\ÄH«\İaP\r\Ói\ğRLa\èD\íß¹¥ ı\éG\Æ\à…\Ä\Î\ôk\à\à–<P´\Åc!MJºD[T©\Ë\Öp\â…M%\Ì-å¸¨f\Ö8!Œ…:\áX\íFn\ğO‚\è`\àZ¾H”[†dÿ]$\Ú\ØR1W¦\rÔ\nr\Ù1\"N\×a˜J¨…Œ<&DK²\nL¸Á¥\Ê\Âd	P®\"\èT\à\nzZ´\à\r”\Ğ`+&% eIgF\Ë\ë=Ò‰º<UŸebN8\Û?R¥UF¢Hm–R\Ó4\â-*HYm\Æs\íN”F\ö\æD\Ñ\\\Ê-ş¡F©¡ú\È\å\í±Rz]3\"|´Fû«XK\äŞª‘\Ñ-bFœ\Ûf\Ğ\×!\âÉ»\Ô\İ~Lf\Ï\ä\İıÔ„\ÍEPdf|F\Í\á\ä5L„Pœi&¦\ÌÁ\Ü%z”&NÄŠh\á\Ç\" A\ÅE“Àå¾­_dšs\á¢K	\'\Ş&]\İUÿAdh`\æ¥\Îe]…šûlTÀÑ„VµDa]\ãü¸L0œF\Ù\Ì\äf\ß\Ô\Æ\Û\é†ıy¯E_G\ôGÎˆx\ÄP\ğ\ã\òh|\ÂgA‚‹TÅ‡&^œu˜W<\å$fKj.U\"u…0è²¬¢X\ñŠw\Ò¡¾\'1W\Z\àEz¤\óø˜¶\÷4``\\\È\ÕÁ!i\İB\Ù0<#™…(ŸBÎ©%›]\'ÀA\âLÌ¸5D­PŒ\Û\Ñ\ËC\à\É8Æ€°ˆ„’¨%‰AvP\ìŸ%¦b\É\áMúe\r\å\ç#e*“N\"‡a\Å;Ñ“S8¡\r”…r¬\à!\ÆeEÙ\ÛH†\èFhP\ä»qH-\ÒZú\èr=Fia›2\'\Ú\Ş]u(‚tn¤i¬$Q@alÀAü¤\Ì|\í­Á\Ô?E†€„c—’\0%\ÙÑ”pD[4G¥jU|\\*\Ïî¨ÿf\êq\ê{\Ãj\"N4\åR¢\ÜU\ä\ãmÕ§~\ØA\Z„¿\Ò\æa¼øEE\èL…d­\é©L\Öb\æ•\\–v\Æ-n]î¡Šw€\às\Òş@k}ø¥}\İGšÌ”b¬Q®½\êX\İG”§9.\Ğ~\0\ÇÆ‰A\Ğ\ä£K \ë¥\ÒNVG\ÔP…O˜b\ä5\æj\ê):)V¡Vˆ)\Â\ßN¸¦XeB»\è\Ï\ñ†\ÙÎ…Š1&¼\Í\Í/6_m\í¡\Òr%l Vh\İs\ÒU\\\Õe‡Š$©a\Ø5cDœšªœ,‰±º*\Å(D[p†µF\è \â\ÍxU5G A;²§\Ï^\ê³\éhæª“œ\ÕYµÿD¥\Ê=^\ç\ö\çT6-mµ¯\È•dÂ²°îš\r,F\\JÊ—Ö•\ô(\Æ \n®\Û\ÙZš\ÊÔ¬„0\Æ\n‚™p\ö.ip¬¿M«ª\ÔûD\ÉzsJ\ï&\İß¼l¬\ng\ğ\Ú~ n”`œpœNŒ\ÔDi?–ojhÕº¾¼6?z\âM‡ºp\îÌ½·Œ\Ğ\Ì9­‚‰\nbAt|\Ö\Ù\Î*e\Ü&‚ #]=`\ì)ˆ˜\îş­\í\Ê\ó\\\Ñş¾tF„\ğÖÅ¡\í!\Î\Ö’]\Ìk´q\ó\ğ\ï­dR‰d\ëfY\0\å9®’œ¾c´\õ¬º&­\å¶gï€ª\Ë+Ò®(:\ÕÀ\ï\èjP\ñ\ãu:†˜ÿ~\ì$Š\Ğ\Ì\Ã\àZ,U”E¦R\Ç‘ÿ„ùøŠ¡nşù\\Ê”-ın‘2\Î0\ZN%„´º–q]\ë\íZY\Î\é\ñÅ™#JˆkOµ\"sĞ°\Ñ\"\ìˆ\Ü ­\ì\ØDÕ§¼ºÑ&\ãq˜!\Å\ï\"­	U\\¥´\Ø\Ç@0G°n.»Šr½.`r®\Ø\ê†ß”r¶\òFn‚Èƒ<$¹eqÎ¼\ÍL^º¥npñ”…—6Š\Úm\Ä\×a\æ©”0Ù¾¨\æ.P^œH\ì‰Y\0&û>‹M®F¿\"q\î\î©$•‰‘6\ò¹p3\é\îúÁ\Î;\ÅY`\ÂX\ô\Ç\ã€t\éÿM/Z\İ]LˆƒHƒÿ0†+¹RüO\ÂØ…\ê•@¨\å06œ\ÓW¼¨Ï‘m”\ôz#¹\Í\Ãr°\äq\ôyãº \ë\à gN\àYn\ÖI\äE[mÙœ†fJ\'!û\Î\ÒÚ«´µ\Èh\ñ\Z#„š²\çTÙO¦0Ì¸’\ñ¶\n\îZø4c„Ed¢¡<\ñ¹™\íh\ëZ¨\×z\í¬–%	„À¬N\ns\ò\ÕHK¡\àÿ@4BˆW]›N\ÄePµl Ÿ!\Í\ã°&Ò‡V)[c\ÉT\æ\ïX›~\ò\'‚\Ñ\'$e_}€\Õf‰A!\âÈ±&0\×\Ş3iQ„F\nÿ@\ÈŒ\çkÄ•z¥g;F„„c\ë\Í\ì\Ø_)½ÿ©mä•¶¶x\Óßˆ™?Q5ı\\„\Ş&)ˆbf\Ù$3\Í\Â ¼ø+\Ğl`YŸ\õº£g\æ{ª\äÊ‰n£\Ë\ğ\Ìo\Ó6²\ÓJKg^§\ñ´.gŒ\Ôy)A_¡\09FvÿJr bp±Ä‰s·•.¶\n:¡„46\Ì\ì\Í\Û\÷z\ä\à\\«½DH^\âlwpq%Kd\ì\Z\ZHSC^\õˆp\ÆK)¹Ÿ\äkkÁ\ò¤\ã\÷fßš\Û–5´¸oÇ™nk[›\æ\"w\ó„	$\ï,-\ÆY¼s»…“uwT`\0\ÖmVÌ‚Œ\'\Ø9B¦8 ¢X¶ı6x{ˆø<$Z©7w&Fù”7cø¹7z\æ%WV\\\nÿ\ÊL\Ö\nV­€\\È†€\â±1\Û\ó1BZw\óY\Ó\ÎÒš‰\Í\ÑYUt¹œ´\Üm	·\"P™câ·¤	t¨\Â\æh\ÍÈ\ğB»\Å^\à\Zh˜$¿˜xŠ\ç9gqk£g¸Ÿú‹\ë_<È®˜Õ¦iO\Ú|\Ègû4€û\â¼¬\ê‰\Óß²D‚˜E“U_zW¯­L~”gG@\æ\â†#hX\à±‰3m\æv9ƒƒK™t.;8^ü&)–\Ç!½\'\å…&\Í_?Öœ£-~UZcœ8B\"$uKpt±swp!6 \ö^…VŒ@……‡\ÊOG|¶¯ ‰Á@œ\ãIßŒ~\rX	Ú²\Ïn€\Ú\Êş‰\àÿv\ÎX\0\å~\ä1şL\Õ\ŞO8¡‡\Çùü$ı8mªš„\æ‚s\âl\Ëm‘ù„‹GzÀYP|\Ğ\éDpĞ€‹|¬¡\ÑB\İĞ²g{ü\Ç\Ú‡°|+°”£Z”\ã9\æ±\Æsûwüb…t¢6\Éÿ¤üc»¯ıv\âšc\Ğß€¸®\Ø\ïk²E\ËFa\ïf\Ì\Ë®\Ì+‰°8IÏbYC³#%\éû`C[\ê\òq;)!]\"Í¬Sø´üVp\rl[.g£\ì\ÕW¥qŠÚ§x\â\òÆ±`\â\"Z£\ò\Ï\Û\ãı¤=\á\ÃL‡€FAvº\í¸‹G\È}Ø±D£\Ü\ëÇ¢\Ö\è\çgSHÄ‹·ÿ3$€\ğ\Ê>—H ø	‰_^’ø\Ú\Åu\óL#48\öL(#©/@´C6,™°y\Ã\ä–l\ØÀ\ÃF„8QÄ+6¤±\à\Æy\n¨p\ä0I‹‰\Ùrƒ‘¤^™„MÖ‹—I^‘$\ñ\ÊI\çMI<O†	³h‹\ĞB\ÃÀˆ±\ÅÆ–0’&}\êTè•J·@…\á´iQ¤B\rºhQ¤E\'OF²e6#‹n2Ú…6’Ù“gÉ–\r\Ãh(¯[ü6…a#F-…§ŞˆqC©b«V\Æ\æ¨P4a\Ä,Bƒ\çÎ–m%\ÍıIWgÛ°”³Zm¼U±S1’`r”]\Ä\Ø3\r³­£\íd\ì~3øÿ\ñcÁ‚\Ä+&4\Ø\ÛaEdA2WH±\ãÃŒ;J,(\r\ß0[\Äd\ìSwN\ósKÿ\Ì+	\Ó\é0~ı*e½2«ü\ÄaT?=\Æ\ğÔ­Pµ\ØB‹0D*,¼\Ê*Ë­¶v‘ë¬¶\Ş\n\r¥\Í:P,\÷\Ì\Ê0ù\ê{\nû”zª¿\Ç*\ÃO%¤9ƒ¯ET\ÔI\óF{Ñ–_t«¥E&\Ó\"D\rCŒ\ì†o›h#\Ş6\Â(7\Úl\Ãh!…‚[Ò¸vŒ›Í¸…Ø¨7Œ:ªr6ê°¤®¡vdûH7ˆ$	C’™d˜^†Q³&„\ñ¦µ\ÜR¯\Ì…*\Ê0\Å\ö\ñ0\Êø\ã‘GÿSª\Ï\ï\ò\ëB\Ó\ÒrKAœj\ğQI9ÿ\ĞB±\Ô\âG\ru$\ÔSù\ì[J1\ÊbÀÁ+S¿š¬%\Z;;‹—:!\r\íE¼¾û\ï*›z\Ì\Ì1¯$2£_}\Å\í\×L‚N!\äZ¨*§\ä\È9.\ÊN8.5r\ÖY1£\ìr ^2›L(1\ÆÄ„M“h2\ÏÅ¸*,3¬¢¼Jj¥\Ã³\ïÏ£@\ì\ï?©´°ÀJD-¥Ğ­Z\ĞzTÁ+LX\Ñ\Ó	¾\r!>`X\áCB-\Ñ*\Ê6®Œ>_­%C–dÕŸ>3¹\Ì\Â\Z\Ó0+ú6>’ \ŞB\n6¶\Ú*Š\ÍHŒN (5:$ªDfÙ†”´\Ò\Úg;Ê®H\"\ÅL$\Ú\ÊL©(FtwÍ˜\â\ì	¨ 0$ÿ)ú…L>‰A•×¿‹a8¬Ï­d·_±Ô½KRIyÁ+\áJ\óºP(ø’rb¶A\âŒA\ñ\Ç\Ât]\é[\Ìp<k4%™§G»\ñ\Î\Å%q±\ÈÂ¨\ÍK`\êˆ7™u\Ã¦Ü‚c\Ò „˜\é\Ùh±œ}˜*—©W‡t\Ãn\ÉÒ­(Ê¼\Å8QI\Æ3^z‘3d\ï„*0\î·\Ô0}A\ÍJı\ìe»Ó¶û£°\ñı¶\ô\îJ#!8A½ÉŠ\Ä\ï~§\ğ;·\r­øÃŒ)\ö\ğÓ¥šZf\Ê0ƒ¨¯\ì¥F4¢\Ñ\É@Ó™JQ&D ¢\ÊÆ\Ç\"ÍŒWO\Û\Ù\éxSœ\å\ä ¾\Ó\à—h\÷¬¤\Ù\ÎI¿#\ÒE,ÿ’iQd3b8\Ñ$\Ô4&5gy\æÁ\É\×\õ•…]P¡¿b€=ÿ<…1œÊR°\ç.ølÁBd‚*” G‘eŠbùW!2\ÄşhŠ~úIÛ§\nÇŸ!jŠ*\Û\Ø^ ‡2Fµ\Êd>©\ÓdşC¯¥±27D\íf&\Âa\ÜF¹†\è\Ô‚ŒdJ\Éø™Ï²¥‘ˆ8\':‘]°¬­av!$D¼U1\ÔdMYC\óĞ·0Dy¥@üzWTzˆ¨\n\È)L\áTø\à¦Y\Å/ºf\ÖwGM1ŠN\Ë\á·\ï{rJ½\ì5(¶\í\Éqb`\Z\Ø†\ÍlFehQYgn£°ø‰eE,\Ñ—<\ÓÿMPx½ú#‘V7\É%%„8’Î³\ŞYIE©YMj\é)›\Şùj(“\Ù#ü˜<\óL\ÂEœŒ3£ùªüe€Mù\Î\r: U¯{Æ„\ç¢\ò§\á)`Pl\ßG9\Ã\"_e£Ò‘+ã••\ÃP\ÌP\áS\r©g=\ëe)İ‹Š0Ó™kV®€(«‘»\Z¨¡\Çx\ë®S”¶.!\õq©°\óCzFHB\ê…´s\ÚUkgº9©J¿ùÒ—$\Èo…\ç%\ãš!&H9Ee”c`B\ó\Ô/\òm”–{œ\ÛhZ½’z¥`°P\÷¶>GE,\ğûN`\Æ\÷Ÿ»\ög‹®[ r\Åw-€­^»„R53U“ÿrg±Ü‹Õ£\á3w<jµh†AA\Ög|RpF2ÕˆI9N\ë•s D\Â\é\èNZy\Èo‰„	\ï\\m†¼ê…¸$1‰¦¤­ sÁ\Â\Ğ\ç¥–\0r)¼^¶Å£”`ÚŒ‚\Ö\Ş\n]¨¤\ÊPSâ“•-b@‡Eb\Ç\÷£\ÊF³2d \ä\Ä\0\Z¼\ô\' ¹\Ó1sQš.E(Œ¨M\Í)A`uB$”Š6\Ùv5À%ao)’,§Ê†v¹’ ™¤À\Î›\Ô\ä\ä6ï€¯AIf İ°\r°]$\Í\è¦\0”×¢´Wn\ËKû†’0²œÁ—ªe\Ü\ÜÕ”\0m%‰\0\Ú\Ô\r\äJË\ÙÉˆÿ‚(»¬R\ã\Ì\â\ÈL|\Ğ5]´M¬\Ì\Ñ)º‚h8tÔŒHp79CRS×©NC\Z!QŠpqG-İš\Îh½1]\î\nR’%i‰\Ï\×\ò\Æ\Ä&³¸%\ÏD\Éf\Æ6\÷Dhd\Ø{‘‚\Ø\'H_‚!)]YË¢Ò¦ùq\0\ëË¹•×¤?\Úz\r£\Ä\í’\ò±˜%-f™’\'(\ó)™tfTd2\è\÷E@%”b\"S4˜¶f™\Î0<A\Î	\Ö&6™ \äpL\ÈN©½SvÍ’Î¯še\ãt5: \î˜°C\â\0¢¤“™P4A—§\Ü½¦%ıü…ºu\éK=7QÑŒo€6=?§\Ä•b+\ßúˆ\ì>À\Şr(q;²ÿ)\á¶/š’Q²E2\à¨W·>×¼\óŠw4S§vF\'ŸV\n©&û1\ÑÍŒ\Í\ã\Öm\0)\íƒ$$¶t\Ö \õ˜U\éˆøu\"á³\ĞÍ›’ˆø!dj«X;\İ\Ä;&¼P\î\É\Ît©ù­\Ò0¾†,.e\ÊrÑ®§”ŸÃ™ø\Ä ÿ¤}S`ˆÌ—‰Í‡~ø¿1\İÜ¿mœ\Æ=%Â€SµV*F\Öd\à n5ª\×\ì\ÖZds\é†u\İ\Ì6\ÎO\Z\Ñ,B\ÛR\Î~§\n+B\Éj\rD\Ğ\Ş\á\Ë?;Ù¦a\ğ\Â\émJnOù\"VJ{\Ç[“®û\Æ\ğ%Q\â\\T\â\ËJ>¶\îw\È\r2\Õ&¶%³}~‹#x¨mÿ,7ƒO\÷\Ò1.tm\Ùw´l[ù\ãZÉš]-‚„s•º¥o°\ñ¯3\Z“€S´£Agi\ÎR!‡…”§j¤$$Zˆ\ä\õ‘“&\ñ¤\Ó\r(%\"\Æ\ö\Â}V\Ä=ü\r\ö\èGG\êgCÚ¦¥\ÜfS¶‹‡ªë°°\ÈR\Æ\"Š2\ğ\Çş\å\ì\äŠø†o?`±¸.É³š\Ï\õˆÂ¹l\r\ö\î+$§¿tB$F\Ç\ãs´\0\éÊ‰f2‚û\ò(yX+©e9*©\ò¬ª\ôliÀDj®dZOH¬#Y$\è$`,3g\\œ\â\r\0OoUaU\Ä\êúm~>Ä¢^‰?d{Ê°¥ K\ö¸\î\Èl),\Ìb\ì\Ø\È,\äÿ_‚o£fi|LI_4…˜\Ì\ğ¤`À/ª‹D\é+V\Ğ\Æ*\ê—¨š\Ü1°\ï>¶ofŠ\ÎiZ&IXB\â¯\ñ*¬:\"o\"xG\çz+j\Ü\é8@hŸœ%(Ğ´´p\é˜G¹š§OOTd\0Sd­¢G¥#¡ \"|\æ\Èm\rÃ‡2\0¦t0n‰-ø\ÆnÌ®\áşf|”£\ÌK+\nebÖ°}Q2½‚(š\ï\õÄ¦]¬\éË€¢V‚È•\nƒTV\ÂÀ~\ğ)(’z&š&yˆe$‚\æ|‡ ‚§Ù’iz\å\ÏTQ$6OH\èoI–¥LÆ¦%Œk&0A&”‹?©\ÑLfß¾\ãeXc‡´\÷\\	|l\åÿ~P#¹HG>Mø\Ê\Ç\n\õ\Â\ÃKQúŠ¤‹\Z®Pt„bXª\nlE%FG¼Q\÷0d§\ÑªÀ¬)\'D¨œb1‚Q>2‹û\Æ	!w#Zk&¢6Š\îülnZ(Ï«Œ†wı†Æª¼¸Bş¬\å!\Ò[v¥\"d\â%˜\'¹²\Ğ\İ\äFp‰\0UŠ\É\äf)Ò¦»§>\Z0L\ò^\ìÊ¡º‹BÀ\Ë4pB/\òÂ¯\à\ğ^\îJ#\Ó\ĞC<\ò² mL\é\Ş\Ö\Ê\õü\í­\Ì$D´˜1P£0\Ê<VNx˜df\ìJdfÍ¨\Òür\Â\æ\Ì§…n+\Ã\"b	&¨\nş„L\âh\ÂB`o*¨Mb\"\'&\Òa\é’\Ó\"\İblF\òc\æ¨m\Òp\ìgb\ô\Ç2‘\r7D@¶kù\ÄF\ì¢,\Ze¼\Â‹Q~spTÀ/\ã\èOv\ìc\Ğh¸j\Ò$\èÒ ‡\î\ÂQ\ØN.$°\â¢ˆqû\"©‚\ê1yr§5ÿÙ¬gŒ%ZŠ°7­J$©Y4¢¶„Gıj\óÃ–\"\ÄJÿm&*B9_¤y\ä’ú*m¥´/>Ù†¥\åp\Ò;\ğ{q–¸H\÷n)\á`e-taT\í°˜‚~\êc¹\ñ=\×\ÆCN\nº`\ïC’4¡šH€j‰a®©RtB¸q*€\å\â5zP‚L‡XŠ$\æR‹HB¢ƒdS6\î\É\Û\èi+\ï\Ï\Î\í #B\nƒ¥=¢k/(\"7h‚\")\Ò$T\æ‡bIÿ$O–i¥¸‰p\ì\çH½\çl\\~\0e|¤`\ÄkJ\ãÔ¶\à\ìx²;\Ñ>\Ôp//F¾G2T(Ş³m8“\0\Ã&š$eü\Îúü\Ç CÿXg {#H\Z\âHÿ$\ÈÁ9š\Ä¡*Án‡‰Æ¶8\â‡5\Ü\Î\ò¹r:\ÚÃŸš2\Ñ\Îi t‚ &Ñ‚?$`\n¥CøR5,\Æb4$B²st\ò\õ\Å/\ô\Í.\Ğ\Ã\\rA\Ä\"\ã¼qCºˆ\'PH\í§:cT(3OF2\ÇØª\Ò\Ö\Å\õ\\¬šŒ²V(+Ù\í(\Ğì´˜*µ¾Oü:I\êlf\Ìûl¤£BX\Ø[€µi\Ö/N\Ş\Ê8{…d\ämZİ­Fp$\Ñè˜¶\Ç)AD\öbŒü¤b\Ü\îˆ\Ø&*di¯\èFr\\„Axh1Á<\á‡^\é\ç?\Ô\ğSxdb’\\Y\Ê&\r\åŒ|¥|HJ\é²\ï\"\ñs¨+#<ÿ*( 2\â6\Ô;´X\Ğv’*TB«\Å\Ï\"Œ‚ÊJ·X\Ñ6\×$(¼l“G7\Î\åEtb<\äÍ™\òd\íŒ\Â:K„\rG/?%iW4\ë\ç^\àfq˜q,\Ò\Â\'‚V\é€6-\òBz˜,^\Ïp2¦\"iE\\=¥\Å^\Ì\Ë\ç\óOs(r¬‰|bsj\Ù6\ò(Ğ šFP\è5ı:Btd¦\ÎJˆ¶$Œv,\ÖınN‘l®ı€K\ÜD\"\Ğv\ÊdÔ†\"X\ÎeU`\È$!Y©z0£&•\",^C\ğUXŠG ¶¦š–\ôRå«¤„\ä\Ì\ãJ&U‡&–H$[\n)¬\ğU{\öReE\ÕVäª‰Ô’aÿÊ·dT¦\Ğú\ãúcT*“\Í\ö	5;”\å2¸\ö15s\Ón!T¤eYl…úQ9ŒjwG4sOƒ‰\öOAù´F\à„ PQú£‡F7Š\Í{C’›:\ç\äŒm§w(CÀB\ØnN”®<t\â\Ç\nD±0µs(u‘Bl\0€G/_†eˆˆ]^©]\òm\ß(‡¿f…^\æŠˆ\×7\ôœ”X¦r{‘\â	\ÃlsZ tw\ç)y£EKp\ÎJº\ÆJ£)œ„¤\'ú´Dkø°d\ï[9$R‚!O\Îc¨bt\'F\Ë\Ê\ĞbFÒ®\ôÕ±\Ú\Ç\\27#–¥4s‰.U¹‡F\'¸k¥‚/eTDl\Ì±Ç•Â±ŸÿV¯\0¡NVr\Â(\Êl°\ïÌ\'6œf\é‚%g¼T7>a\ñr£ƒç¸œ\Ä$„\Ü8tC\Ç-hˆ\õYP\ëg\r\èUª¶&zp<-,¼\nıW\Ï\Æ:a -‚Iù\â®\ó\ä>\Ò)&+<º.“r_D4‚V\ÂxeR\É&\áF0¶\Óp:¥(T\rr\0`T>(!jl8ˆ\ğª–\È}(\rœ\é\×oÙƒ/ š1n°zZ\"HÆ–Z MŸ0ü|;¸\ry\'\Ôı&Be§ƒ6\â-¶Iø¦UÀb@Æ„›“3(¨4\ìr£\÷0nø^\ÅS=¤‡¹q_®´‹T\ô=pd\'z\"N´k.r\î6\nn\ì\êq\õ£¡ÿal\r	eia6€^)Ö‹],d\êøÂ§J¦Ntb^H\Ó^J\ë4ı¨\è\ö6ü†\áº”\å`§g6L¿\ä6¡w¶\ö‰x;#\n}\Å}†\â\'ø“rÆ\ÛB,\Zm\0[x¢ş€¨zNNp 05T‰^¼“^m´Q3P]I\ïgÁ„oe%Š\ö…Óº\Ñ5\Ò\ÓY\r)*\÷^\ê=@UqT([\×\ÚU0:£	\ä¥\ô\ä^D&šÊ‚y\"¹£»©\æLª–ƒ!\ØaB‘\n\Û\\\çÏ¼2X¥#[BBh(\Êœ\'b<œN¸(²+\í°úc~\0h¡\"°\Æ$K¾”T‡Œ\â\È\äË‡2\ä\ãX…\ĞJ\\tc	¼\'ÿœ\è=Æ‡9G\å+¥Á\Z|½#\Â,½$ú4\Öú¦>`5HuO&l\ßxzcº1 ÀT8(i6¿Ò‚–\æı\àcµ¸„µw)º_^wWØ„k\Ì#Á9“¾¢IjuÍ­ªŒ\ßJË’\Ï\È5P((z\"h£—7š\ÇE\Ú5´F&C2Q)$/Fb\ò§*\Ü%9\ä^\ö\Ú%­d4^Å€û‡\öaiü*ˆ,*Rtfs«\Ìtµ{6¤\Ğü\öI,W¿j‘\ğø^\"K#z\Ì¾¼_c\Ì\Ö\à°ø¨\'£˜1\×\Òü+\ÚË¼\Z\Û\\‚\ö¸yŸÍ…,«_*0»€\È/2\î­reIY0#ÿ\ñ\ÒPf/©‹­6|\0\ÑbUp\Â\ÊÍ˜0,³(üü\Üz\ğ!\ô:b\í¬8)xœ:‚¹\ÏTˆ„\'‚’¨ı\"š9©”E7\æ\ğ\ìü†2‚“\nÊ—Â¬ji™\ŞR\"r\òm(\èù\ê\ÈmM¸İ£\âÀ¢N\æb\Ğj†G]½ó¢‹\ÂÛ—\\ÁT¾x\îP¤\Ø\ò“\ß\È Q\ÔJ,Í¢;t\n£i€D…*nùb®…W#P\Ç\Í`x6\ï,y¶¥µCJ\àOy\ÖgL¨:\ÚA]Fm¸Af\î¨d\È\Ók\Âb@|‰ns\êli(§L•\Î\ï¸‰`\òˆ{\Ô\ÑjH¬:\Ì\ádnÊ‘|2}nl\íj»ƒ€œ‹Yÿ\Û\n¢/3l4\Õ:œF\n\Í\â“\ì[f…,^do™^±‹Yƒ\ÇÄ¯EL9HØ·FQ[¾œL8Áp§;BÄ†a­Ü·f\ôH\ÏyÔƒ\ïb0¿ny²§N\Ò%\Ç$\Ë\á\ñ\à\Ì\äRZ}\Í=9h/·\"”\îÀ3·\Ğ\Âã¦…ş\Å\ágY­„]U6#\õ\È\ç?’•’\Ü@?dª\ô\ó,4C\Âi 2\Ù[Ú•*;X\Çe,\Ùy\ß/z¥¦Z”CN²t \â \n\Ä‹øH´0N€h\ëB\í#!\ô\Ùhúj„\ÈX?\ì&\İÑ›+­\ÑÿI3ü3?\ô\"0\÷Mr­4PlÆ‘¡\0Ì–0[À„9xp ÿ\Â0‹2Š$FRCF\Ñ0:ó¢¤‹\Ä4(á¢†$Š‰¤1\ÒÆŒ\ÂÀC\Ë\r-6”$l˜Îœ\ÃxË”3Y\Ïa\Èt\Z*4g;dí²Ê®g²œEs\n›ºS\'Ó«K‡aMš,jU°Âº†6OjÙ¤¼>2\"\É2g¯¼$\ñ\â¥2R¤E»$E\Â\ë\å_»‹$®DÙ±d\Ë0o\ÖTXĞ±d’‰7$ˆp\ïÆ¾wy	\Ö“gŸ8qŞµ+±¤j\ÇÃ´v³M…—^®\Í\Ø!FŒ~=JŞ˜i%K\á*5Ö•t0F˜[b({\à\"F˜ŒZ\êSØ§£W«M–IhQyj§bµŠ¨ú±Aÿ©ªGz\ÕkP©ßƒ¶“¶\'C-%†‘dh\Â\ğ\"š$}q\öJ»üU^…mTE5n\r4M4É¶ZK‹DbYˆ…L§R]Ÿ\rˆ\"/:\õ2\à0*zf\Úa\rb›d…`†¡lal\ØaboA‡D¾ù\ö–$B\ÔC\Æ	\ç—F¨­„	#\Ì\Å\ğR!…¸\È@\0\ò„P\ÉT\'\ÔPYù„_R\ó“–y]\rU{ê¡§Ş›P%U”Zr\ÒGVE¥UIE.¦¢Q¥\á\ÅË&`}ùÕ–$Ux!Ae¸#	}´Z¦˜MT\"ƒŸy6\Z‹Ÿ\ÑZŒ¥Æ\"–İ¶Ÿd\æˆ\ĞM‹\ìVJFúeGÿı\÷Ÿ“LBHœF‹Gs½´¦‘MG\æuV…9ŸWß‰)\ßYu2U›b\Æ\×&}W\Å\Ç\Õ{Ã¬Išq\æ\ÙN|M	3£D¼`(‹§\r‰0»Z¯g\÷ª\ô\áH#‰4Y”D\ğÀ5N†¥dXúe‹i9\İÕ¢gÃ°\È\â0¦M\"Ì Mjúom4I·l7²:\ÒIo¡\ña\İCÈ¹lƒL2r\Üq¿J²\ÅK*\ÃD›c7†\ÉNŸÀ©S&=eRgu<%%mXÉ˜e\'z\èuû\íN`Y½~\×\ê$Ş¸\ğu]\ç\"ª6–\å\"\ö\Ò ¾\îb¯¾~‰İ±@rK·\éÁ5İ¥mıœ0CÒ\ÄH_z\â§\ØÿI1¨§ÕŠe”%¼¡¤\İm\ÓÁ2$Ü’™ì“¶>Y3r\Ê\İ #:\'+r¥…yw\'v^\'\í´V%Vº\æ}›\í\ÔZi=\ÌSb&µ&S\êE\Õ5ºO?]”\ã‹1b]ƒ‘ˆ6`0§-¸W\õ#\í\å/3\îø1–ÇªpÂšº\\˜g\éFÕ¢U\ó¤\"h¢½\ß E+\"m\İW*P\÷¿ú˜CY|«\Î\Ù\ÌfLªËƒ6\ÌH\â%·\ÑA\nƒ \È:\Ï\"š¶¼f–\ö¤§‚o:v\ô$\'.\íN>K¹\Ï\Ó\ŞŸa\ì%7\r\Ñ€z\Â\"\Ô*_Ÿ‘^$j¡—B†— ”PUˆI\å¦%—«MC‚ˆ™‘‰oÿa…\Ü\Ó>\Ã\ÏDEb\ì\ÈIT\î\Ó5ˆ^6+ŒÑ€½\Õ$\Ä ?b†4´¿œiak”\Ì[B·Œu.f?`&vƒü‡ne£N¬\ó¥¡M\á!$w»¯\rƒ<ì™ŠUrg§:Imƒ\ÚrO\Õ\È\"”´G“-QDI\Â¨ †3\Ñ\Ó\á‚xa\ÃSrT‚Ñ»\Za(K­iˆªÆ§\Z4b\íGº¬\Ò>Q¬\'\÷‹Z‰šŒ\Õ*#‚¡H\ãüµ\Z…´\n3\÷sŒ‘>\'^l\îIvÁ„oV+`™N9ÿ¹IP†‘½>9Ï¶¨5¦¡D¥\\X)›\ØÙ“¡m\Ğ*„\ãg¥&”®\Ä\Çiÿ•\Ö^P\×I`m¨	†„‰]\ôÅ†\ö\Â	\Û\Øf¯{¨•{¥´\ğ³E´\æF|\ôĞ”$’E4\ê3g:Š„1\Å_Š	‹0„_\ÆR\ÄMÁ\\S8±\ßÒ±XÇ›s’Š:\×Hf‹z&A%‡¨Œ$d´Í–&h\ÈN‘)DŠ´\öd\É\ÛU\òhŸÁ\Äg€R³¦•ŸJ“Ú¨¤’.i\ñi)iÆª \çİ…mú\Â\ËEQ\ÄWŒ\Ê^\\Ü…h°ÇtD ˜rM¦ü\õ]z\ÈVy\áE;\æ\Ñ\ËO•\åEŸi‡Š®¨“¸zmi+PŠLd—Œ\ÉPµş‰ŒL’˜† \éVœƒ¨\Ì\ìb1m\Ö%·\Û\Ä\Õÿ\í‚-35—¹‘\"’µ³\ê¤:Ì‰YG¦«MM \Ö\Ê\â>rÖœ¨U\Û\ínw¹\ëVm¥i=\ñmV$J\çùeA„ıT0ªX8T\Ê7•(ƒ¤š \Ñ{³š`ú\õÁ\ğ¢Š\óÀ,L_z¢\õ%-gûŒi6\ç\"µ/\ÂÊ„QN\0tœ\é”\Í ¸\é\ï\Í$1	^LÄ¢™„h‚£\Û\÷…\æ¶2+\ÑJ„\èHe‹\ğ\èAş7I\ïÀ	`ƒg\ì\ê\Ú\ãouG»=Y«7Yûáº¼\'˜h²Z­‹3-r\\E\á—c˜g½ş\å@\òmo\×q\à\ö.ˆm	ª(}è¯»\Îp=EŒa£™š¯À\'\Z\r/XÿtQƒ;A[…o:a¬Ï¢Ñ‰\Ä\\Tš(i˜17Áq\Å\Ú\Ç\"L\ÈkÅ‰3t&Ğ¶9Ö†3\r[I]Œ\õŸ7k&\\‘³º\\£\Ô	=\ŞS¦²®²¼’(\ĞJT›—¨œÉ¬5x\Ó\ãUQ\ZÉª}\Ğ(\rd\Ê±c\Ùa®b0,Q¿ªQÆ†&À\ô{=/\Z¦_^$Ô\ó1¾j6E.2JS\ÚAŒb[\Ì}/\ÂÉŠtL\Î^\Z\'±Åˆ\Ê9»ú\'¡©w‰36IW@µ¡2·	\Ğ\r1aŒ®oqÿ‘\õhCQ\Ú \é\ãz¢-|²­‰Š«\\‹<\ä¾ıQ\×\ÍÁ=¹È‹Œ™\Ä}Vlÿµı\å\Ù&;\äSf\Ë7\ö€\Æl—a…š\Ì\ÌÈ‡€Z¤]\æ²V\Üg\ò\ïq\é„\óPA3¯£\Z»E[Z\ñ\æ$\rpa\Ûe›c‘×­[\0\êvs\õv\ß\\tb„{z3\ÂyLhs‰„FüÁ‰€š\ğ¬\Ğ\'[_\Å×¸&–¨)\÷¦µ>®xµ”1\æ¡<\ÊÀ¨—3\äZ8M\æ\î;Y\ë!£$\Ñ?T%\Ä\ÂEa ƒÒ»(*…A\ßg×·•\÷B\ö§g~5\é¿Á^\à\ì28:F\Ü£g\ÑBuz\Ğ\ã\ê™~\÷‹ş¢¬[\Ì\Ç.»7\á.ŒIl\î\ë¡\éşÀ]a°Ë±A×§;\İm&›dÿ¬l›Š‹2½ıg\Åh†ÿQ–\âªY¥\ÉL\Ê#\ĞpRap1€\à#€’¡S·¶xa\â\"ˆW}vl»8xAsU\Ä6²—z\Z\Øs\ÃW/\õ„r*µ@(*¥Rœ\ö_d\ÓD1w\"—\õR¬*\õ0F¡|\ô iÁY©ev \ÒM #	\ï6	°\Óm\×}\ô&a\Û\ç}\Ã\ôG\Z\å\öƒ\åGx\áL+‘g azDAD\Ü\õ~\Ã\\<\á«–H”I\÷·A\ĞS\Z»yı5U@B9”3€¾\ñ»¶¡ÁNŸ‘³T¸W¯GX\ö5{m\÷\Âsú\òs·#œ!gºwt\Ö6,8`\Ê\ÖJ­\ÄÿJ†\Ã\î5((\Â1}ˆZ&a!†\Ó\×v7}B(„¤\"3z\ZS\ZO²(.f•B§Á~4Q¢‚1\ßg„H\\#B…<–T\àr+\Ñ_ø†:¢GÍ¸3*C‡aVT^\ñ\Í3J¿·Q[†`•Q‘\0_\Z8|u\ölw!=…\â<\r\ãC8tÿQ>vE \ÂW\õ\"‰\n6\í@\ó@\Å\ÖM1Tn\ÇA3\ßs\Ş$„Én©f¬;‡^\ÖX\ZI%3-–a¨A¡Gg@GdL\Æd\ÚDdJ#x\èá€ªV-\Ô\åOK–»‘”3\Ê“/\Ù<“@$-Q@\Øe1(Q/\ä\"!6n‘[fÒ“Q…C»PE\ã\ØeEXU4\Z\÷\"aB\Ù*%	¶\ĞLÚ¶W~7\Z\ñ•Zƒ\ä¦iauC\ñ\".²>1¤C\'x‹2iŞ¡R\çA(iª(„\ê\ãvV~>H‹Œ\"	b€w§\"4\"\ÉtŠ\ğfH«\æU$ÿ™Bh\ò-\çAk\É\È+\Íø0`%1a1q0°63›y$M7v·V\Z:!$a0+R3Bù‡…47|Á0s›N	_H\Ù6\ÈÆˆ… ½M©\åwu&\æ\ĞJ\éˆ(]1\Ä\Äg††v\Õ\ñ\"`·Vù\Ò\Éb©H^D—aR’\èp&\"‘\êRY\ô\Öa [øu’}\ìx»\ÓN±£ja\"<U\Ã]¶¦€-Yœ\É3Q™šI™\ÂE™\ê™\ÂÅŸ6y@WVÈ±™\à+Š\È\ö=¤›R””^&=UTf0eg\èØh&…S‰ƒ3\Z½³•^9X\ôhli3Z\Í\"1/Š6`ÿ€A\"\'\è.\ß\Ô,\ÖAt©Šì´ƒ\Zs[‚C@ƒ\á—Q  R6µV[&f‡·\Öh4„\Ç-;!e\Çp¬¥\Ø€±\Ì\ñ¥\Â%”ùŸ.™J%¹™¡‰\ÙT½0\Í\ÃTj³W¥$ˆ\òU(\â\ÆWD\é­7C\"\Øµ@R8tzA8: QD{j\"^Y‰¤2ƒVheù¢U©…!¨m1‘\ä£Eco9u\Ûù|0\ò2´pºf•\ÄA.\ö\ÚC\ä—8ß§cGA‡\ç€\Ø-\ÇhV!\Ç2²41™f*¦TB¬J¬š3d\Z¡‰txa!z\Ù\Çk\Ù„•§\ÒCm\Ã6Iiˆ}ÿ\ÕzeCjƒl?\Ä/a»À\"\çL\ò¸JuªC\êøM B1/*aa„\Ô>‚=ÿ¥Œ¨LœÚ©Ÿ*Ÿ\ó\÷0r¤Lbk>D‹u±!)\Æd\ë6}¿ø,Yv\òQQqH–Ÿ5¡U\â_ª™™I¬9ƒ™\0Z¬%¬\Ï\Ø\nX‡³‡\Ò*\Z!\Ê‚•\÷r\"‚•Q]¶¢ûr \ó{\"¨‹€C#¡=¦v`Q¡¨N\×Šƒñ®®´u\İT–¥oU\ë 3šZ>P›1M¸£´j\Ä@S ‘i!6³¹©2…T¨%µ‚9\ÜE \ŞG ‡O\ÎR’·j’T³nºvoˆ,3Á“ù™`@%$ÿ[¬&‹²—	 ¡9y1p´\"›3‘Awá‚…³gfX¦t(~%	8¤6‚ÿ\Õ1wA*\òhgÀW7Ûˆ­+‚ª8\Õzg\ğ† \ò\Ù\Ö/—\êƒ[G—\é\ö–¶•Vš\Zó¯ƒ{¹²¥\"·i%±¥Ø˜\Ü\ñ\"t†\Ü\å· \â†[,\Â%¬ij¬Â•¬Šû™\ê†j6ÿ\ó2Y–[Xz*\Z\õµeû¢!ˆ¼\ñ+¨C+…\ÜF&š\"l¹¬‹+%(®‹³8Tûo\Ş\é‰+M¥ ¼¯\÷\Zx;\ÙÑ…\"Ö¢\ñêƒ¡, rcı\í\É}[Á\ÖQz{|r8\×?\Æ¬šÿy™†—‰¦ÆŠÃ‰K¦wGNnAmj›\ó2\ÃQj£QAWzF<®\õ¹8ŠC¡‹‚şrK\â¨_¿V\ÉV\Ù0\È8ˆµÌƒH–Â¦»C\ç›rFµû6utI\ìÆ\ìƒ\Ò0³kË«†¡F\Âu\ëy—\æ‘ur±ºSd¸¶¼rÑŸ\Í!Ÿ\æ\ë\È9ãŸ„;¦\'û¥¯ju‘£[yw¿\"\è\ÅFÜºHl(û\âÁ?»^„C¹«_˜\ÛW•h¹\Î\ó{¤{C\î’ X\ìºR¹\ĞS–\\—_Ù¶\î(¨.\ÆÀ°³‘º[í†—­{XA9­¡¶\ÇiWŠµj«&I^\ÉÀ4\Úÿ¥k`ä††¬.0U%Ë¸7@¬\å›Î‹l²\ä\\\Ô\Ñ©	a?ø¯•+•¦ÔY\É\ÊIÅ\Â¹‹X\ó\Ã Ó£¢‹ƒ‚‚‚qÊbÊŒrœ¤T\ò¢E¨‚mşÂ»Á¼E©\åcB¸T¦\ÅÁL\õÁ\â2Ë»\Za‡m7q³*A~ŸX\Ã\ödkş)È’@aZ™†‹²8ı™\Ã\n\è\ì½;U=ı¥/$”šsAÏœ,•Ç¦\ÄD\Z¿†Â›ı\Z\Åû\n‰·tº\ìP\ë\Ğ!\îø\Ï\ò8\ÊZ«©ŸÜ¨\0W¯»XTeÑ»+º*Á‰ºoµÆ”.I5 \òBµ{:\Ã\ÒƒrŸÑ‹ÿC4b\Ø4]%¶\ÛQ\n(‡†Ü½5=%.1¸6\í=½Ó—İ™BM™k\Ú\Óİ£!z\Ã`o›\Ú £¼\ÄO¿x\Å\n\òF®m®\"5?¬{œ¦DZü^\ä\Õl &(\ÖS}t(˜w3ª¢–\á@²R7\Ú\Å\"¨oÊ´>_+5»Õ¦\İk\ÔL\Å\áü²[8a\Íe‚WxqŸ\Õû&™\0r(ÁŒ°‡¼¦œ),\\V¢™Œ<¦¾•)\\ƒ:3lF1hG¥\×\ïú\Ü\ÊbÍƒª £¤‹©¬_\"1¢ª\'\Üo±¹\Å ˜j=mÁm´\Ì\É\ä\'È•*Qj\Õ\Ì.Ó®\ÕúGOø0Kÿ\õ0\Ü³(~…2]\Æ!\ÍYj·À\ö:‰´4‡wxü¤Z…>Á?£\ßùß„‹\Ój:™S\Ò\Ó2¼Ùƒ™\É:„\öMŒ¨t‡\Ú&XG]>\Ëü»»\ÖvKüÁ\Õ3:5´F\×{mP¬µ\î\á\Ş/¥\Ì\×\Â\Ğ·\Ä\Ö\Ê\Ã_ı€¡ZŠC*\óª[<\ØÁ\õL®6š+&‘k\íYÁ²£Zex€,Œ#„·2µ\á¸a !\ÌÁ™“Ù™—I\ßS\Ò\Î\Ë\ÚÙ”I\ÙQ:oZnhb¤•wµ7\ÖDš À´Q\ì›(N\\°A#\×8f\ì/o^\ì€3\îhır\Ê7dº±\rM—\Ê\ÚPû4B\ñÀ\Øÿ\óæ†¢\ív\ğ\ãÑ£$\Ç\é×¿\Ç/$\áM2Iw;I»£ùQ&B~<\ÚQºÆ ¾!F±\Z\Â\ïÍ™6\\™5\Ü\ZÔªn\ğŞ‹©\Éoƒ4~l)\Ò\"}ë©\n\îd\ŞÖ“Ru3‚\ï“_–twş\Ïş›fxc\á^T®¾*¶$2\öÀ]=\ñşz*³[©	¼©5\Ş9»\ö9ş#V1\ÖX\Í\Õ2;\ñ^&\àr†¸r¡\ô+\äb¸!›¦™™\êø-\õ\Ç*\õš™7„ƒ^hƒh	,¨].\ÒıJ\ñS	\ÌıR´{Q\Ğd¤\Ö7\nƒFk„F±r£H´mf-¤{\ïZ³şü\Çu\\hÿ\Ş1T]\ñ/CºüKu…°Ê¦[¼Å¹4=\ß\ã\ä\\Ö¬\ØÒ²ùM\Ó57ujÈ H7?×¶X .\êÂŠÎœ]²\Çz\ß8<h(…=¹\İ\ç¢va\î©J\æ½-\ç—\n\çV\Ém\è™,4Á7¬R)r\ß\È<\Í\÷¶‰qN\ò¡F*\0* *ÀF5\í\Íÿ84r´\Ùo•Æš›j‰Œ\Ê\×Ë—%w\ôN\Ôr\Ø\ä.\Ú\ÙL\óOK¶m¹\×D(Ÿ\÷~†[`„‰C À1Âˆ¡%!C†\r2Œ†‘¤a\Ãz\rË´Q\ØF^’x…¹KR$I¶\"ñŠ¤²e¤–‹$-Š\Äh×¢›8éŒ´sgÿE[\Âº(ŒÑ£a„n‘\Ã\áSƒO•&\õ\É\È\çU£Fµh¡¢+°NµlC´¨$´W‚)†ì–¬Ei\òT¹Ë¦¤]$E\êå…‰\ïÊ•\"O\ê|q¦HF+‹	y2cFa%gL–\Ù\ã\ÈÂ’µV¹3\åÇ•+Ë“,L˜_\Âe®\Ù3±Z¤a´\Ü3°`\í7(‚}XĞ·D\ß\r†™\ôx\ã\Æ\â\Ç1\ò½kR¦]”«{\ò\Ú\éº\çj\ØYÁ,Ò²H\è\Ñ\ïC‚iˆ\Ğa\íƒZdeÿ3\îP²\rB\Ü\âu\ÅW¦LJ&)\ñQŸ”b+·\Ù«\×\"©¥ZD¬?¾\Û\Å/ÁX\"¬1‘db\é¤\Ä8\Äÿ­¾†‰LÄŒ0)\Ä\Î4ûL4\ç±2\Í\"Kf\Äa.Ë¬¯’D2I¥Ã¢;i®¸b\ÛB¨‰\Ú-¸…‚K8ƒT ‘aŠ\ë(ÊŒz\ÉÊ‘)1•V»‰:»\æ¢N\'šjÒ§Ã“ø¦ªh<ù\È{\ê†\ó–R*HªdÊ©¯\î\óª °¼šH(‘ú‹À¡\ê- \Ú\ëIAgº	¯\n)5)BQ’DJQÒ”\êü;CG4´\Ïd|±=s\Õ\Êl,µ?ar´…\ÒZx\Ék–´\êºED\Ït“\Ï %•ä¡?aX!I’{L£*‡\áK\Är”\É×$åµº_­\Â\Ê=½\ó®(1\Ü\nÿ\ã†\ï¶`· $y“j,u‰Bª¬ƒÀ\òSß¯T(\È_°\öfK\÷\ÌŠ\Ş!½ª¦\ë6iA“.\Õ0\'nL\âl\ãPSşĞ¢q²Se…\ñ\ÕK1UK6M\ÄZQ\Ã+µ]^’\ô:r•\"\Ò\Èx•¥o·…\nƒ±L¨•6J^zÁrK\ç^›I\éf*\ó\ÌGT´¤\ÖS>:c3k\ò\"Z\ö©8\õ‹Q¦¸\ê\×Ù®ˆÁ¾®\æ\rEJQE\Õ°À¬®ºiÁZcI%–\"®4¤À04	-Q2,1\Ã\éO¤RQ¼¬F\ÌH¶qdX_-2Y#Ã¤Ö½´%/Š!uZ\î\Ø\Ü\"vzƒHÙ‚\îû\ö.\Úÿh\Ê^‚FnL°\åå¢¤mp‘É¬i§œ®RÏ©\ÜR¶Šl#·¦f_6\ëƒ\Şz\Ë)@\÷\0\0\Ö6à«°nƒ­‹\òDŠj„\×\ò)j\épºk%\re*=GŠ\ÑÂ˜¤šLb-\0~Ns”CQf(“™\Í|f.R\å^\å™y\Ğ4¼¨U­t5’\Â\Ù%b<	Q–Òµ|Á\Î_\0C³”´4\än#TZ\áq°uI¯[‹H¸W¼\÷Áf;\à\Ñ\ÓXˆb\rjYiù\0µ°\Ål^a\â¼>¶\à>\÷ˆE\ÎÀˆ3,-)\êi‹\Ü”a¥\'|“TQâ¿Š]ªp0´P‡d†8ÿ(®&šÖ©Nÿ\Æ\"Ua®$Íˆq2šˆ‚8ª\é2Õ \è¼&.øª\rA^\Ù-\Ë7$l\Ê},\"‰\ÛgJ\Éùˆ`nu<Eºf.9iØ™\òª!e,\ÔÚ±jc,\àü‹7L”¥p$’¯\ò	\nŠR4€\nzù•„J\Ğ\Âbl\Ä\õ¼)\ÕÁ\ğ`² Î„:Ó¤T§~g6\n†\r\êP‡h‚!°€\':\Ù\0=39tZU4M;-8’ZŒW\ÂaOx¨=!’©\Â#\'‰‹\èN#›š•¬„>†\í$”4,¥w²<…UM=ùT\Ø²,?M’Y’\ä\Ş,\×¨´	jR„Á^\÷3¢ˆ\á\Ã\Ğ\ó\ÚUÿ»\"o\ÌT¨u¨	ÿ\r¦&;	´´±hÂ5ŒÑ©4gªs‚†3ja¥\"°´\âIxÑ «\â¥0	\í`\óÈƒ›}~v`c’\n.™IN¢“\à\ÑR‚—\×(R‘M#3i,\í¬\'„G\á%KA–_‚ú\r \ô\ÕK\'\Â \0Š\r	+rƒa\Ò\Æ\"fŠ[Ê¢WF†\ñ®@ºI¤h¢QScˆLÿ\Ğ\ÂM5$(*§ŒüX\Ç;>\Õdš\ó\çX\Ö\ÎAbPW–‚kOn’q%¥n	!Wh\'ß”P ?\ãˆ&×ª\ÂŞ±•­ûMMI3\ëng‡\Ş\Ù“\â…6\Ö\õ58\ácy\÷µ6eÿ¤\ß\ë\å$MšÚ°k]\îb©Rl³Jı0ŠT\Éa]\ç\Ò\ZùEgCŠ#‡DKTO1n2\á\0\Ç\ÙZ\È\Ì\èU*ŠQg8ƒ¹\Ç\\&e¦\Ê\è¬\Z\Íi\Ê:\ÕÅ®W£/‚e}=È±\àe»´F	“V²Ö–D5®\ëæ°¡z\ÏlnY¾G\ò†ˆÁ˜/ı4>\ö\nJ8€ú\×{Sœ\\†¬X\å‚|‡\ÂR…q*W{\Ëv±¿2\õ¨AvÉª…¾\Ãÿ±\Ä&ª\é\ãü2		–ì¨¯j\Ç\ä’Á&uE\Ìi2\óNĞ‘pg˜Ù´\Ì-E6+\îš>\ï³b\îEˆù²ˆ‰2’œ\ät„­…]\çj]\ìvU+ÿz+½°*\Ì]Qo\ìL°H¢\0¾\ôŠ\Ú(\â:ø\Î\÷¹	*\ò\ë*2¤‘]\ÏLC\r$\ßzc\ö;Ì¶\Ã\ì\Ô.ø0´\Â\Ì8#,¹¢Ìœy\Ì6…=w\Z«\Î´\Ñy‰U¬\â4\÷(ª¥\è\Ég‘E\'‚¨kP‘–\n…!\İ{\óbº\n¶\n€Ä°“[\ÙWÙRI`.Y\Ø7\ğ\×\Ëƒ\öv\å{I¥pÒ†^ß´\â2»v½\â¡üš<\Ã\"¥?H şZ\×L\à¢\É]4\èPıWÀÇ“¦´;´Z¦\ìE4’p\æ:ƒ\ç¤\ê\Ñ3*<s¤fúyÖ®\ä\Ê\n\\’)v=\Ò<\òË¼´¶”\ÚaR\ÓmUÿ«A1\é6\ï\äX»C\ÕÑ¡¸…O²dr\Åÿ”LkMvµ9²«ı\ñ@ùuPf\Û\rv^ûúg»®¢|\Z©dš@P8W[Ã´ÿ\ÎG-Ÿc\åÃŸS¹vZ²²gÒ‰²±\è3\Z–\à\ç>W¡ş›†”77V\òD¸C\Ï!È\r‘š·”§ŠSº·Z­\å\õƒ.\íx‹\êhr”²/Œ\\ŠÒa[DY\'…t³tI>¶\ê½1y6N‘GO!¿ƒP\ÂJ²¥,B­{:ºR^:üşƒ\ç@ŒPX2¦‘†\è¢y ²³[™,Ñ–\Ø®‚\ö(¶Dû Ë—\ôPÿuA¼E#–©(\ä0¨\è‘I\ğ˜;4t={*‰\Ò\r- \"´\Ù(ˆ \ã\Z\nˆ¸%Gj–ûø\'ã¨B.\Ú1–¿£\r^\óA…˜‹:¼;I”\Å3>Pc¹†ašf£.†Q06r0°l»6\ÊÙ£\Ñ\ñ\n©¦o>†\"¾¬¤øu‰!t·x:²Q\n\õ¸ˆ¶\ÊLÂ¤¬CÁP\×ø·”›‹\Åû‰\ë\Ø!¸#¢¬%¾r$\Û(’\\ˆH±4’\Â\n2}\ò\rw9?†À’{–‚,HŒ\na\é\õY„\å9¶\êj¹1 Q½\Ë{BQ\ñ˜)¤‘RÿkªÍ‰ »0!@–\éBBúˆiZ\r~\Ã\n>¬\Zª®j%“SŠ8¯RCh\ÉÀ8ûÀ‹Ã°›‰\ö#>£8´2\ì	´\Ów«¸’Bµ‚¸¥¬¹(\Ã{$‰H¢§ƒåš¿Š%ˆˆ:‚\È\r14(ˆ)S\é+¹‹\"‹©\à1 ;<8{?†\"7~\Û”  :’³£\Ê\Î\È\Å=Û³ºXÿ! Ï™*Á8£&C±Á\öË“bLC\Ì\Z’Õ±,¡`8lIF¸·©úÀµ²1‹#6>,˜*\È`™(\"¢\"WË»D4\ì\ñ1	|7©\È@51ˆ¬‘ˆs\\ˆzìŸAƒ\é©\Çuñ§¯²›\Ê\n’‡ÊşR(Ÿpš0¾*\Å§œ=\n™µ\Ì<«°ûŒ:@\Ì\È\n6“!U¬œŠb\ì¢b\Ó+¥ÀÀUJ<¶`¤dº\Z´¸4}	j•°ûm\äÊ±\Ë\Æ\×I\ä¡\ì«Á\\Š7y\ôhJv©;¡,·ˆ\"’|š½€9¿`1\0<GRŠ\Âúª²(\È)»”ã¯‘Œ±L¨²„!6ÿ\Ò\Â\É\ÎZDÿcZ¤\È<Ó¿\Ï!$4C(Pa\r…Z<\õ	\ÌsÙ²\æ\é\ÎvL´© -0È·d+\Ã8Œs;\n‘<%\÷\ĞM£ˆ¨ƒ98@A5T‹ˆ\ÑÂP\Æu\Ó:AI±9IøX}\Ç\Ú\Ó\r„ø+\Èr$Hƒ/¯²°“\Ûd¿\åKQ\ÜIÄ«\ß\\½6S\Ï\'Œ³Va™\È\ÑCN\Í½ ‹Œ¨•°‰ù£¹¹8´\ìÌ« ®.c”T\êFI&uÁ¤K³<„Ì¥¹\"<‘Ì¤\è7®LŠ6DPF|$UcÊ·¯Ò¬¥M\ó#M”SJ\îl8¤ºcAˆ¬	¹°(Î¼\ZT’e\êM6ÿ-È¸P½\'\ô‘&\ä\ĞĞ¹\ÈYU\á3‹¥È¡C†o7\n\ÑM\á.™¼\Ö`ÓˆJ¥\ìN¡P”ıJS\îØ²\ï@‹)©´\è…\ô\Ä\"s;Š£Q\Z\ê\Í\÷8\Ã 22\"8Y4,¥\r/…4\ä2•,\ÂEbÆ«\á²\Îd7<?°‚\\•R»Y¦¢›8\í\âM7=”8\İË´ \ÓRÁ\ÅŒ\Ør­Œ\ÄBÊ˜\Ë\Ú\Z˜L\è\Å‰¹_Œ&\ì®l?²8—Z5Šı2Š¶8—¶À:¡Ã´B\ôaœE@€[„\Êd:ø\Ì\Î\ía…\ğ«C¬=Gm.µ\Õ\ğ\à )\Í\ğø‰²¦œ\Ô\ìD#‘zD\ÓGeˆÿ*È‹­\Ñm”	úƒB£\Ó\Í\è#\ä4N‰¼\0œ­\ã4\Ù-¼H93\Ç\áqC‰O*0®\ÂÎŸ¨\ĞøLI…‹b3I<+*©C\ô `L\ÒPmO¼#aP`2›rS«·\õ°.]É²X\×\Ü\Ù.\òYG\ÅÀü\Ê\Õx£º½kX+¥\ğ8Lş\n\ÖFqŸFY\Ú\â³\Î&¼\Çn¹6Y\ÄÓ¡«0\0¼]¤\Ö\Ë)¿°–©”K±Ÿ»8³„*E\÷D\×4İ¢s‰ª	\n\ïhC\âjWŒ\ğ:x\õFP\â»I{u€Û6U¢V\ò\'\è\'¾’\ç\éN\ÖmF)\Âü\"T2IŸ¥U«=ƒOe/E\ä(aiÜÿHr‰\\ŸÕ.\Êë€–Õ¸\"V\Ì\"\Z@X, \Ñ ¼ı%@@\"‘\Ï\Ô\éÀ\ñ\\i¶c5J¥\í\à\Ñ\åa\\EÓ\á¨\ê…FÀC\ÆQ^nüT‹›¾Dª\É\Õ\ó˜¯hŠ1\Û\ÚS;²)\Ş\ï8×“|:s]9—\ç›–\ä×›©½©Û¨¶´\ëZ\ÉHm”b¼Q¯Å“C\éX3\\şY\Úr Z¼Vÿc§”­S\Ğ À\ÌØˆªúBÿ\ñ¦ŞšŸ›R0¯Ü®’\Ô\á=\n’U\Z\nMÂj*#\Í\É{]\\\æyb¡!!3.°Q;\â²ÁL<\Ü{@\õ\Ø/\Äs©±©À·0Jd\ÄÜ…G\àÿhŠˆ@\Õ\Zu¡ˆı*^s›!zW£H‹\â›\Ã<Å³jC \Ú6	Yi]\á\ZÉŒ#‘ÙiêŸšS3\è“3Ámº¬©¶¥šƒ‰:BY!˜.>\ö\ZŠ\Û\Î\ÕFP•Oeşı8¯\é#‚Re%LƒSE«:®\Ø\n]ŞŠ2\î.·}\õ1œq1„“u±¬\Ù\rŞ‚c\Ü\â\nV7£a¹_¥©	™V!B–¸œœ-\ÜS9\Ù?\ã\Üry­¿hÒ × d\\Ú|[T2—\nüÒŸ¹\Ü(9¨I¨Æš`\ŞP­	\å<jŞ¢ø“‰°`\ò¡\"X®¨°²vqO\â¦ÿP-¨]^4_–4¦p›ÿİ™\nV\ã0\rFkø\Ø\ÙÀdT…)8\ÉMŠ9æ¯\è\\V„–¸¥\Ó\ÈHNÛŠÛºŒ¦j\Ê\È\Ê0QŸ\Î\ŞR3NŒ\'lDšŸNÃ™\â`Ÿ\Õ\äE\ê¦KÓ¥\ĞÛ™’h\"\İ\\ÿXb@LåXM\Çú\Ä>yA\Æ\é)Í¥•h¸¨¬—~{	¸_f\n*Hh³Ñ‚f	\äeV\í^L®\Z\æ\ë\à¬\0ht‹„\â\ß\Å\öi\Ê9\Ùn\Æ\È<\ÅB‘lş¹\ì`=\rúÅ—¸8vSPT˜0\Ï\ó1(Q¾±¬\ß\ÕcOÅ¦<\å=C\ñ,Uù ¬(…\ğ±u\ÛF‹˜Ì™ÿú\Ã?¬\nQ¹• «`)\ó\ãŠúP/&B›¾r\nTCÛ¼)V¦+\È\Î\ÎnQ\Şf£\×ËƒŒ¹T§\ì5 n\Î6FÏ«SUi•\Ì\ã^pa9ù3£5Û±?|\æÈg\÷¤šbÄ½³ÒºP^4¨Fÿp€\î·\Ã \è;\×&Šƒ.İŠS~Û€¼² \ñ\ÜCSR\Ë\Âé…D·\Û[G¬f9\"€·g^RQsS\õ‘W¹•[\ÌS •†\ãDaW\É\é\Ê^Df\Ù‰\n\ê˜RÁ°”¿\é\Ğ\ğ\0y\Ût\rÌ©	’¬%µ³Àj\ñ@›œ	zElš\è\\\×ş·\'C\ÙVMv;\"5¼:ƒ£,I…\ÍÕ«\×2/s‘ÿ<7Pg[\Z£\èKø‹†X¨`c*x\î\05V\'F\ñP’,\Ú	\î^\r\îv\ÅuR\ï\ğ-º¬\Ş¼°\Ò?	\ê°\n™\ß\÷§\ñ\ÖB\Ë\õÙ®üf\\\Æ-\â:d¡hi§¡&l½~“\×ıh¹ıeû2¬baF¡À\Ò\æ\Ñ\ÆUt4¯\n°\Ôp¿i«‘Èˆds\Û\Ü\Şfp«©m¸s°ø1ª•h4\Ö6¬\÷VŞ\à\îÿY>\0:\Ö6[ŒK–\íf¢û³ßœ©\ÍF7d?Æ½\äø^)F¹ O\Z–.xe˜{$¾™\èÜ±\Ëc-\Ç\ÆÇƒ=û¢O‰˜\nˆ6‹\ì¤Qš¡\Õ3·\÷–WÁø7\î´ÿ \ös\ó\ö0¸\â+bALG9>¦\Ó\ól,´s{B\í\Æwÿ‘\äL<\ã\ÛÈ‘aÑ E¡q\õ\Ş\Ó@²–\Ç\é×‹š?\×^\ê¦\n¸ˆ\\\Åª\é\\‘0£Áˆ[\é\ê(·\Î`¤Wy-¦\Ø\ñ*b59\é\ö]œ\Æ\\oq\âÙ‹Œr\õ”øS7ø\í\nƒø¡za\ö\Ï\Õ\ßw>\ì±hW¤6Ó”¶jo\Î3sª^Wa\ô˜\×?}\ç€\ã$\íC†²\Ì#_\à¶\Ğ\ï™2`®4µj\Ñ\ÉWm³LûTš»_+w\ÕV\ò1ªs\Ş\Ö\Æ\ã\ÃS%`%£!P\émBHF\â\×O§¬„NÍŠ+²Púÿıx‚l˜\Ş~¼Ci\r,g9B*FË+•;r\Öf§O7Ä±\ò5µZ\ßO7\õ9\ñx\ÖY‰T\í\Ö7˜R\ç\ç{Ÿ_«\È\ã<†?Ebp5üN«=´\Ò\÷´\Ø\Ö\÷\êBÅ”H¨!­Á9z€\à%P/LJJ(IÌ¢†a\Âl±¡%\"\ÅZÂ€	³(£†‘}Œ´\èã™†Gjl\È\èLÇ‘‹@¾	r\å\"Ia$Å”$lØ¼aÃ„%\Û9,\ÙPŸE‘ù$\nh;¢Éš}\ê4\ê0dP«şüiAœ85>\Ü\ö$Ç”MS(Œ\"[\Ú.\ÚrR\î\"0\rÕ²\İ2¶fB^“„M\ê%iWI3I2)\æÿc\Í\Æ0i2\\\\\ö\á01,_ŒQ\ïX†E¾d©\ñ\ëc•Œ\ï‚\É\ëej¯5W{\åÊ«W/À²	4Ø— Ê“\ÃÀØ¢\Å\âCˆ#IB\îU9\ãE%2dù<\Ò\ÍEh\Z^y¤M…F¥úœ·s\'Ra\íŒ\"-ª\Ş\éN\ñS\Û!%º>kÖ˜„%Ô¾È³\Şş\Å\É8\ÖZsµÆ€q•\àXrÆˆ$\ÃH\Ò&‚	\æ a,\á4SLe‰8\í\ç\Òg`=dzø\ß‹\íwG#1¢QGeÕ”RG\Ú\ÒaG¶DbKc±EX~?IX…º\ÆØŒ]4\ÜD)†u#wù9¨_v&\ôbJ8i\Òh0\Ä\ËOÿJ\rµQ=Eµ\Ô0M™‰UPS\É\ßP\ìy\õA(Œl\É\Å Yk‘xR€mb—qlidW]‹¨Ñ€š\\B&DXB:XÓ‡Ö½T£†û‰D£‡dùWœ©2j4\êK`\õi“ªª\ÚdZG!\Õ—Œ¤¶gA³ù\Å~½ø\ÚUW\\QG\İF§…\r(%i$°\ñRcŒ]\÷Œ^Şª_w\Ö%d\æyDÑ‰\çxß¹9Œ<IA\'UT\ÉGß¸ø\á\Ç\çG4êµ–^bùù–n¤ƒ\ÒuW!ıº—Œ‰\õ˜`\Z†¦\æ\éÕ­\n˜\ÅU–±Š\0z\æê¬µD£ ·‚\ÙØµ \éJPa\İ2\\X°ÿ…\Å\Û)e\'.\ë$g\Î\ÅdaM»È»h¡\ÅX\ìc\ØrÊ˜W<\Õ\'Ÿº\ìE.»>!\åO@•Y\ÕH•\÷“º¹6cŸa\õ‡\ïX`šQ]¢\\ˆš¤hZr)\Ç0„\ï\öpŒ8]‡w\Å1^Wt b™\nx‹Ek(YŸø–46€&	Ú’†]^\Ê\ó»	»kW\Òb|\"”\'q8­k\ò\ÂX’«&Ó—\ÙJ†\Üw==U\Õy\æK.R\á&n\ÔO«K»»?e\"L\ï“;–½\ÊUoFi3\è–FZ<\àÀh5„6DaIi„®ŒpM‰U·RG}“\Õ\Ñb_o\Ä«)ir\"y&Ö¼~\î;½Š\î…%Œ”»¬\Ëÿº)\æ[Mb$P¢\ëR¦¸Ä\Ó|\ÏSŒaI¼\Â–Œ\êA\Â@“O¨–v-%]XÁ\İQ.(§vem\\¼€A2Õ’\öQ\Æ`‰šK¢Â¶´ù«`l!Ø¢\à\ÃMª+“\ÈÑ¥$‘#£e\éF{sLJb¬\É\ÜL\ñHp\ÂÀë¬F§\Z\Ûÿ\0x³\Í\ï$¢»ŸB$…¿a\õp\Z»¢\é“­YmZ×šL´ÁQ\ç>E9Wë¬’\Î\çi¬£\Zxj§´2µ\ËL\ã!A˜\ã5®3€Š\á€\öµOAS\ó\ôrVé‡ƒY™a2¾ş\åm}\ä‹L\Å\è((n$hY:\É\×–DY\ò›	\àÿ\Şr/)²²‰\ñ\Ên\0ƒb¤o³ ı`Rœ°¨o2¡¥\õ•y¹¦:|ÿXÁj\Ş	+\éÙ£S \òÁ\ğl0(Ü Pv¢“=%†1cÿn˜‘‹d\Ä_†Z\Ë\Ú!(°0/—\ä\İ(„)\é\è:	ŒÑŒ\Ù°\ÄJ~Ùˆ\ŞB\Ä!W*\ï\"b<Ñ“Æ¨9f	n|\n	Ÿ†…$aQ‰:Å‘\èØŠÕ¹¼5Ä€?:Y—L¦7\È@¬MVqİº\îØº›²\éqBW\ò(\ó¼I\\\Ã\Ø\Ó\ö:E¾}İ‹3Œ,XRe³(J`¡h”\nc½\ì]È„\ì\Óø\Æv\Ô‘hEï‹1G‚Âd„2\ò³$q*#ÿK+¾RPMä¨…â¶¿®\ğ\ìR,Ì¢¨ª#“-:Ó¬º$YC‘\É>\äx\ë‚\à\n\nT,\È4\Å\"ÍCI‰•«­©œYÑ‰°\ZsÖ´,´‘g]\nµ¯B´%m’|\åE4v’\İ,l†\á…\ÎA† \ôE`\r_\âHµ\Ğ\õPK6\é“h\ğ•1H½5¹œ‰\å+Ó§)%dg`c\öšV@ımT‡”‰(©\"[\Õ1\Ì$	ç³L„‡j\ìXW\Ó\ĞdÓ©I¥²KKJ›®²A7iVL`\ÔÏŒX(—µ…yÆ© `¸—¦\Ä.…Z‹€µ°\ÏNr\ÅRXeJ\"Ä‡&´•`\â+ÇŠ’\á:\ç«\Í]+-±H\Ì\Íÿ}\Æ%\É!H+\ÇY\ÎVWli%‹‡FEf®\Ï#hZ?·R½qD\'k\ÒiV\Äcš‰ƒS‘“Uº¹Ó¦Á*R¡ºr˜{¨xSukƒ\ç²\æ	Š.\è[DZÛ¸:hŒ(ŒJ1>&nj¸Î\ë\Æü³R—E4ùØ¨\ÖV…\Î\Ï,4Á[•,\ä²*$^Á„şš˜ĞŒn/\ÏiŸYkD@–6\æ|_KN\Ğ;•s™k>r\n\ç˜\"Ë¦°\î*\éù¦e\'Ø¦\õ\Ö\ç/i\ØLĞ·(}!ªP’h%\×\Æ([Ÿ%m2›\ğ#tbµ;\ñ^§ª%²¨\È|\æû­c²\ã=Š\éVq\ĞPG\Ó3*Q\÷ÿ\ÅU7\';\Zi*¦\ÒOL\é\Z™¸Ò•šT;˜ø–c}B\ï\ôª\Ç\È}”¯z¾¹\Óû\ÊI<¬[\ï¸\ÎYH.AAnA“b\Ú\æ\ÕP’²¤\ñ\×I…`\Ï03¡\ğª¶E“3x&!¿\âr_\Zqj{º\ä”…A\ôyE1ÈX\õ7,\ê)»\Î]\ìE±‰\r,\Æ&\Â\Ç\'\Ø\Ç1•\"\ßm\ŞĞ•\Ûa\å*D\Éid©–j§ĞMT§\nSbÁ\ôT°>#TWL=Cıw-¦]K\Ú\è96E0®´y)­]\Å\îN®\ïC\ÃLD#>d.I,*v—\î\Ü7;¸,gi\ÌiŞ°.t7²ù¥\Êı—\"\rU\ç)±”$t\Ã5n»¹\0\êí—º‹v³›!8snB\â›4YS)Of×·¢¢A\"\Ïÿ©§U“\n\Îs.şd„\Ä\â…H@ƒ>·»/vw\ä$\ÏÕ“œh#º&\İ\"¸’w€:\è\Íb (¹ÿ…u\Ú\Åi$¨lœF!jˆ—^\ìb\Ü.\×K\Ü\ó\ö\é\Å0j\ã\Ë\"\é\\7¿Z4Hkt ·ê¡”K±Ñ—H†\Å\àVˆEB›tT°IQÀ\Ò4–º\ĞE`P\Õ[T\ô^P\õD|œ\Ç\ëd…\ğ\ñB-HBjZ\ĞS½,ÁLŸ\İ\Å\İYøKC0^À]J\õš\é¦ )Aø‰Æ”Jq(‘Cı\È@ı\ÕL\ğIş\è\Ê\Ë,Z°\0Ë„˜\ÓPiEıù0HHmø…/\rI‹E\Z\ğ‰)	Î\ÑCGLdšJˆÿ\Æ1Ôƒ4…Z\Ö6UU ‰\Ô8Ùº°|\á}¡\ÚO\ô¸\Ú0\ÜNŒ\ñ­\Æ\Ï\ôË \Ê\Ú\È\â È¯9•IÔ HÀ\Şu’¦—\ß\İÖ†}‰h>ù	\í\Ùxı\ÈQ£É†n\\¡˜ø\Î…]V\Ô‘\ğşù\nn\ğ_WlÈœ\Ñ‘Œ|Ic\ôM\ß$\ç„HŞ´É›${\rY\Ô1\Ùd%\Ùb\r\Æ^\î¥KNµ\ád…Ï\Ğ.\ğ\Ï\ì‚KÀ \n\Ù\È\Å:\Õ\ó\Ê!:j™\Å\"Ô‚$>\Ë\ö\ĞZu’sM[©”Šg\ğ\àK€ˆù£¤¤\Ì<\È,v…\Ş\Ç@Ja+\nE\ØIP‘„¬\Ì\Êÿ§@\Ğ)±r\Ìn…\Åy1£5NE>\à›\Ô\Ş\Ô\ÍœT–¾¡ÁW\"Å¹\Ğ\Éz±\Ïa#\ñ\íB$´£G\ÄÙ¸O:\â\"À\İ5D\r>RÂD$\à\ä;\Ò\Z\Ä(F\â-†…¹H‹(\'b =DÈ¥’±€4AL\ÊHm\ô\nAøAĞŸ‘L}\ÙB\ò‚\ÎIPı\å\ç)Dx\r!Ê‰}Eº9‘ÅŒ\×W\å\Ù<HQ\Ü\áL¥GH\ÒœœZ\îE\î”\äP0x\ì\Ñ\ò!ì´ƒƒ0\ì7.B72\Î^0È—5¢]t\æ¾ Pe;\Ş\ä62e\ö5Œ…¥\á’\ÈM†Unø\Ô\áPw}Æ\Ğ\ñ	ÿ‹mD\ï\è„lY¡=Hm¼¢Q\'¬\åNlm\ä†\åI€VÒ™Ÿ”\Äs\ÌÊ³)\ŞUŠEI8H\×I\àT\Ğ\Ô`¶a@A–a\"E\æa\Ó \ÍKJ£\õ\ìĞ¤\\\æ6f¦7\Æ˜[®\r%°%\È\óQ\ßeF\Â.\Ô\ñ\É#\ß§¨ÏµÁ\æ\ô\à£üL%¨¨Xµ\n\ËYH^y\å/\í\ß \Şß¬â‘‰h/\ôÿIûeIu )U§F\ô\ÍÇ™„w\âb\Ğ1\Â%|G1\"\r\ì\Ñ\×İ¡“•\ç{\Î\Ç|©\ZÒ´d{™‡\Í\äLšCe^\æi\â¤~B\Ï)XE\Ï\åP2N;r\éM\Ş\'\ÄlÏ‡\ÌDd<Pmÿ•©LÛ„Nem–EŸu\\N8Lş‹¥g	Df˜ˆ\É5Š¨»L\ÂOü…\Î\õ`Ä\ÄJ¬„\\XA›¶YK*\Ù\Ú\Ø$\êM\è„T¸\äHZ\İG>\Å7fÕ¡L\Í‚\ÇL\Ég\í„\ÚLN\æL\nC0l£6\ZhR¶D‚Ä ,\n¡ £ÛŒ&\õ%å“²j	\ÎD…Q¨…\Î\ÙT’ )‘^@ÊµŠ(\ñ…\ÊE—\Â\Ø@\ÓV\ä\ßZ\î\éf^V\\\Ş*2š•aHš0B\Ñ]†E\È	k³€“xcO}š\í5Ù¥:\æ\î­\ë±W{¸N\Ó\Ä$ \"; ƒ0,©0¬/Ã“&eNN\éª]ØªhŠ&—ÿh-x)«–\Şq„³qŒ\ŞYù´ˆZQFº\Ş\Äİœ\ÏX\í¥B \ÍYµ\Ú)A@¤\Îaa‰¶eZB}è„„\äiB@ˆ\è|EB¤Ïˆ)R\à„\Ås¸R\è•wş%¥Rª\í\İP\æ|hĞ¨\í›\ìµ\çAE¸\Ä\ä¿úkÀ²C0°\Ã.,«rc¢IØ\Ôİ•¥–\åŠ\ÄMJl\ê*‚R‹›\íÇµ\Õf=*\ÑTú‡fa!(øEy	`\Î@NÈ©~d_\Ô\é‡ş…QÅ„ —*\ê‹\Éi•D\ÏB[>M\Õ\ôXdqÌˆíƒ¼e±GOTÖ\Êa\ê†j¦©•Q\Ğ\ÑdŠ\ÇN jÀ®Cª\ìÀ~ÿ­\Ä\æ$\Ân&Púç¾¤­\Ãn\éÁÂ­®~iJ\İ\rƒ\Şw\Â\æ\×\Ü\ã\Ç^eq\ô\Éu\Ô#ˆ‘\Ã\ğr8\ë®É³\ç)\Zg~E!\ÊÚƒt[:F³LU\ÑB‰j˜¸ª•^0z\íá­\×R\Ğ7\Zz\Ó\r\×I­¦®‰\ë,…\Öle\Ş\î\íz-\ò¨$ø®C\Ô ˜\é\Ë\ğ®£Q*B\ñ™&\ò\Æ-\Ï\á\ÒmŸ\ß\õl\Ç\nk®)GlŸ\á1Û‹\ì%˜~oúJ\â.\á¢§AdBBÃ \Z$\å\Ô\Üÿ˜Q\Ñ\æ&Ï¢†Ş©ˆ_M@\Ö<¨KT\\ñ¯¼d¿A\àI¢ÇšXÀj±<¤\ê\Önm—ƒ0”ƒª²ÿj~j\æfš­I\ÈAbJdiCtc\çªo#oY®\ğƒ*‘\õ\ö\ì\ônÁ\î1ø\õ,AIG\İB\Ó(ª@.)\Z	g}\è0 — \ö\Îùş…\Í)?Q‰hü\Ù\Ì\È\Ï%mL\à¡\ÇB¨¤2#\Õ\í!ª\é¨.\Í\íq\ênS\î‰G”\ñ\Ü\ì\ö+\×\Ú\ò\í\Ã‹\ñ\×\êj~b\é]üZ[Àg°NB¬#\ó6\òÆµ‘\Ò\ßnbÇ¶¯„Š\\3{ˆ\ö ¨Èœ<\Â\ğ³H\ğ\Ñp¸Á\ËJ²\ä¶\Æ\Õ_\Ğ&’\È%¹ıkUZM —\ê–ZÀ™\Za¢î¹¸\Ça®Z\Õlªz\Èr\í\ğœß²À.\ñ}b\æj\è\'°©ÿ\\\Ì\Ü¯N\Æqf*\ôe\ò\ò}&„\õJ\åd\0n\ë\ôª\ó\ïÏ’Ò¶İ¶\ô—`B\ğ7Ã´7T•\å©/D‹ıˆ\ã\å\æVG\É\ÉOµĞ‚®Z…\ôMd\ÒZ\ãF\í¡g“%f4&fš\Ü3Vd­\ô:tV¯\Ã.lµ[f/Ÿ±\ÚÖ ­\n\ó\ï®-\é\Ô;\â\ä?\ğ“~56\"“3\Ãf\Ş\na]\Ã&g\ä­CQØ¥Ø˜?şj\×yùPW\î7kh¸MW#—&Ã£9pZ‰p™UªÃ¡\é°\Ù\ÑZz\ÆŞ·HYÓ®\ò™`V\ÓH\Ö\ÒX¿*240\î\ânÁb5/lu.+tRJ)\ô<\Ï0ÿ\Èƒ†$f&®¯®–Ã“\n„\ïxÈ¥°D3—\ÅT²ı\Î\õ\ô>%_ Á\Årœ\é6{g—\ğˆK/®h³\Û\\¼ \É\ç-\ö\öJÊµ8 ^ÉµÖŒE\ï(kgt8)\õ{–\çr*+\÷gS+*I:\Å\ï	\óVøAsu0\ä2‚›\Ã.X&~vcZ·qÄ\ã0e1W47\"\ï\×f4\Ï\røu\Ò+\÷©|\ô©pÁ&ºYw\Ô&¢2ƒº‘}N7‡Wv7‚\æ\ÕKw¯w’v(D\È\âht‡\õ;©UŠH\Û(W„Fzb*½i3–²¦\â«\ëÕ³\0\ğxp±\ã\ò{-Vg5W·\õ“\æ§!fÿi\rÖ 9Šf\ñ™H¬B\÷.´ù7\à\òh\à­È¥)D\È5s[‡…8³œqt\çD¥\Ï\\™¹ù\Øv3¥\Ø\æ\Ç\"O‰ı˜`OÆ¢.”0\Ë=^”\æ¼\÷‰Ü€\È	>Ë«\Òrj\Õ\Õ!\êJ\í1nª»\â•\×rVkµk¸\î.¸2W\ôYO\ô¬›DZh«j\ão#³6\òœMh†f¬0™‚¬üqUšrˆG„Rˆ„\Æk½›kh‡	‚‰W´\ã\åN\Ë,º£\É\Üø\ğq•<h™m‘§”\È\Ò…\ß^\Ò\rÀ\÷\Ñ6>ƒ\ö46#x\ÎW*Y¾–²S`­-_5‚xl?pF·*;B¢\Ú\Ò:®\övH¨ù®\ëÿªª\òD°;\ß~ß¡Adüq±_v¦û©´&™&m:\Ôa\É\Ê˜\ì\ö\Z!œk\ğ\æ\öH\Î\Ï}w\äLt\Ü\È]ve\\F‘u˜ˆ,\ñ­ùˆn\ê&\Õ=V&\Ù\Æk36E¸\è·+b€w±¿ûû–{­wm\×Ö±\ñ\Ê:\ã 9š\Çh@lf®ù—‚m2\ó\\ŒÀ@º\ÃÀ\Ùr›\n]—xhü\\‹ÁŸ#&\ÈV™F\å+Ñ„Œ4\Z¹„‹³›\Ñ\Ô	²¼¤ a´\ÈEz\á%6/<px\ìq\é<E,»C¼ùh<#\äp¾«²¼\ï(¦‚¾¿¥	»b\ê\éú„<\Ø2\ê7\ğªø\ì×®j¬k&$P_ZKÿ¬Z›¦Kt£Hp\éjø>\Øh#/~\\ş\r¨€\n\Ä\0°‡A\Å77™>D¦¿\÷(s§rwEl‚\á\ÈÚ˜±\âÏ”\Æ\ßV—\0Ss§´Š$HG47\ÜEX¾\ÍÓŒ^\\\ÆûC¨¥\Ë\ÒúK\ê<«‹¨ƒ>œ\èN2„z\ÓÄ°d\í’	$(p²a\n+˜L»`%®\Ìb¹‹\Z7\n+\Ç+¯]»x-\Úer\ÊZ*#t©L”.c–\Ü\Õr\äH^-MÒ„‰—0I‘\ÂÀ\Ør#\0*ŒŠ‘\Ä(T¨[Ä„	#fK˜¬ZoT­º\ÕjT¯R\ÏD…ZuQØ¨a\Ò.b´HÛ”‹\ÄÀ\r\ém¤Ez\÷\ÂM‰w\ï[¿ÿO#fD\ôm˜3o\ÑØ•$)­Z­achSt\òYµh\Õr£3Œ0•+w®L9Œ¤4’›\ç\Z\ák\Ù²+øz\àC‚\Âf?L¸Û·Bˆ¹\r\Şf(l˜Dd\ë„a¼hÑ¢\óŒÁv…\\\'{N–{c®t)©–MI.\í\ß2ü.[‘lÑ¼\ó¤.“@\ã=\ÊT©Š%y½\Z¶ªÿ¶À!³\ì»\nª§\ÔBƒ‘­‚j2¶¬Š¬-¼\Øâ«­µ(¼0¯\nÿ\Z¯H\ê\nk\Ã\Ô\Ü\n+«´:C‹-À8\Ğ\Å^\ÄLF·(E\r\Ül4\0¯š„¡\âŠ­¸‡\nÎ·$!\Â-H&™.!†\ÄMæ «Ò¹]¦\Óÿ2„\Ù\åK‘F:¯;™^R½›\Ğ½–D\Â)\'œ¸‹D‘˜\ö\"	²\ÑHS!©\ôÃ©º\Ä*À¬*\Ë\ÊÀ³\n\ğÁ	}t4Bµ\è¢KÂ¶Î˜ë®¶4•*£\ò°K%•‘² ´*+\Ñ\ÄĞ‚4\Í8£\ñE\Ğ,‹!U\í3Ò¬\ÒÕ©Lº\rX‚t3®7‚„=ˆ8\ã\\2\Ù\â`+HJ„\Ø9†¢\ç¤sNº\ê˜+L’\Ä©\ÌZhê©–\ñx¦\ñº©½6\Ãİ«N¸$F«Ó’Z\Ê\0VP•¯µJŒDQ\å\êÀ\Óş»\ê\ß\ÌM+«†)¼´B¹*¸­RûªtQÓ‚*²°ú±\ã†\'[4´0ÿ\Ê@\Ğp½\ñE£Dc\õ\Å`±(™\r¦54€†\"}›\Ç\È “d¶\áe6Jˆb!Ÿ\î2ºŠ¬Õˆj\ë¾dÌ¨7Í™\à[o$qEjO$u±ƒSÜŸVR„Î”\Øæ…—¸\ìe\ê\0\öUŠ*¼EX@\ì\ñ@¬\"9\Ò\Ì:s,H3\\œb‰+\ÕxT\É4\Å+.T7M´?;*´†a¨\ÑU\Ğl¬Q+\Ñd+\Ñ\0+ë•˜Øˆ•²·y2Ö¸$›$Rè¥”Ò·aªü\İ\"©¡\ÃÖ¢]°$¸IZ~¼°[j/l\ìzRS\\5s‚o&”Ük^\ÕGƒA©XJ…\Ô\ö\ö\àu-ø\ß<³\ÉwÿtC\ÆÏ¸ş‰%Udƒ­:<W-R«N¶£\\\Æ2,Š«¸\Â*[m\æP“1PÀz$†Løj\ÊZ³†E›\ãGºsVí•;ˆ\ì\ÆJX\ZF¦s\Z/k_\nS\ØĞ´‹´‰-\'\Ëk\Ù`r.—Œ${\ÛSD[\æUŸ]ù	X\ÊT`€0L¢?l\ñ\à¿C‘\æ3ªâª¶R+\Ó%0~ûS‰\Z\'	%nˆ‹hP\õ9&\Êe°2\Ø\çh£‚n3œ»An Ÿ¬p)½\ò	D&%#7¼y–	y\'B(…07´s‘Â‰8‡…X\ÂHªÅ‹m\ÍPL\éÁ¡\r\Ç6œ¤\Éz\"\é	J 1ÿE\\ˆ5§ª\Ê\ç˜b€»©@¼\ÆY(U•\ÕU0‰Z_e‘ºµœF\òK”\ÈFFÉ™QŒ\"›_­Rƒª­lFe\n\\ m¶À\Ñ\äJqtH«\Ó,¥2{ŒA\Ä0‰L´Nƒ‡,a\íI\ÈE¾&w‡Lšï ¥4\à]\ËJ˜œˆ\ñJax\òj\ËSh\õj’\ÃRúP]kR††8¸#U\é\Êh\ğ\ã\' Q}\ÊS\Äp*°|~•a£Wú³™Qi<\Üf^„ÀI\ê¦+\êÌŠXS\ËüE2«&fŒR\Z¡\Ze—\Ìl\öb.œœ£\Õ\åŠ\â\Ë\Ïq%]I\Ã044 	N¢\ÍA„\Ã,¤\rÿJT¢ç°˜\Ğj	Ï“\0ı]9ªt<s„dk6T(¸t¢\×8‰+m>±\Ó.\Ø\æ6¶<f!ZQ]Áƒ¥(…˜\è\Å0Â )\Â\Ïo¨2¡¶\òF Á|ıbT\Ã>8\"®‹5Mcf4#\0ºH~°E\í\å¶Ò¢\Ò\ğt™c\rhÀ\ZA•ª.“\êh˜j:U}¯|«‹Ğ 	j‘´KA „Hg\á\æ EcpF¸H:«9n¨s\î*\àEd\"À\ó¤\ò–w\Ã\ö…$1\Ş|ª—½•.˜`MF\÷¨\'»}.|0€#0¨ «D±a\ËL™¡F+F]1\ëœª@Ø¶hF\æÌ«^\ëª/\"\õ€ÿ\İf®hD@\Ç\n¸·›¹œ\è\È\ÛPtÄ¥TA»Ä£\è)i¸`\ë\Ö\êÁ¯F²\ÇCûÙ¯ˆÌ»*„!\ÕÒ¤•\n-—9eH\î*¦¾æ„¯9´\á\óû½`h^½À W\ÄP\Ô|}´‰|zŒ.3ÑŸ‰P[&\à\ÜG£]Q\n\ry\n\Ğ4Kš\Ş\Êl€$T1—@ª†fW::\Ùm/\'\à§±Å¬4« :i\ÇÊ˜Ğ£±®â²¯«\Ê\0)\Ëug&4‘Á\"I\ÒvOz–vÅº»\ÛLIhG\Æ%+¢B\é@™\ÖRFy«\ÃnY9¾X>É¹\Ô\ö.{gˆ…Yˆ¯”——~n‰M\ô\0RƒØ¸\å³k‰W;ƒY\Å=6\Ì}]œLIÕ¢«¦\ÖH´ejMe\Õ\ân€H}U½\È[™e\ÎÂ½¡m\æ\ásSÚ·”\î7€\ö\í§t\Ş(2À;K};\İ ÕŠT\ë\í\Ò\ê\ğ(\É!ŠÿL;°T-\æ`¤J\\\n­\'\ò\ÖKŞµ[:©\Ş\õ´l\Ê-\×\÷\å|\Ñ/2!Œw´b8Ã\0l7&\æ+q‹eS•³üiÄŠ}p&Á†\ÑJ`ƒ\"œiœúh—-\Õ\ÅªËª\"\É0\ë\Ş\ín·y”«›8W0]\ÚAl.ª=ÀQÖ™UŒ\Ô\ï\\«\íŒf;\âè³¶±¸Ò \Õƒœ…¡Au½[‰“0\ôµ•³¬\×u1´\Ø5É¼21	L`\Ô?.VÁ\ò…\Ä\Ô…æ¼˜„hÿ\ãŸ\Ão2\\\Ğl#SÍ²Js.3™\É\ëÔ¥\ê\ëû\î\íMy¤š˜›I\õm…›|\Ğ\íV\à\0\ïfÿû\ÖÉ§”\Å\à\02@C\Z\Ò\à\Ü_½.„²\ëÍªù~\×\ô!\na\Ò‡e[t\äV2¨®%R\åuT§\å\nÕ²œhèŸ˜‡\è&øk\Ö)?\êF)a\â†?$Az	AG\ö¸\"\Ñmµ\ìH\Ü-‚\\…ù|K\ìNŒUl€\Òt/\ŞRE3´‚,\Ç\ÃN\æ\ÄD\'(­f\Ğü\ÒXpsl|I\îøÇ–+\r\Ş@œKƒ\ê	w\ì‰ü\Ò/Hª\ëh\\mb\nK~“T\Èı\â\á\ñO½‚Áva?\"ÿúo\å¨Ç”\Ò&n\ê1|¥>f\Æ\0,_\0@Í„B„\î-\0eRE-\'&™l`˜	U.£\÷ÿH\ÃdJf\÷N\Æ\Äj\ğ\Ş\â¨FbE·,¬\0Î oß¾§(¸©€ \ÍG0\àb©\Ò\'\î`\à\0²Š\ç–kt\Ìû’Œƒ\æiv†#i\Ìo!\ğ	­,.i\"şIx.)…r1\"¬D\ê\n½\ï\"@b$¸…[¾\å\ÆP;\àF¤€$&a£F\Ñ\àø|À€Ö¬¥\è\è\\O£¨b`d Ñª\ée\Î8\ç@6§¨¢/™\Êÿ¸XdU*œ\Ê\Î(D°›\ñ\Äl&\íz‹› \rĞ¼m+\ÄÀ±’‚O²jBr û„°»lƒi–dÂ\È\ğIŸ˜° bH.®5\n¢®HÎ…¨px(b–C\â\áwL\î®\îŠµ0‡ÿŠ\Ñ\õM‚9<Hˆ\r²\r\0m‰\Z\Ë\rSc\'\â\ğ)>«\Z[jDf´\Æ>ª(E\Æ@Pf\ÑÚ¨(\ìQ…+¸‚\n\í²¶hk£\ÊÅ¾\Ç\ê\è\÷\î\ñdx\Ï4zË˜d_b\à£\ê® q\0¸\ï¥%J¢Š­\æ\é7	i\ä‰¿«9pMj$‚®t1\Ê\Òk\äa\"rQ\ñ`ÿ\îo³%\Å$\'Š$\ár\ÔÚ”HÊ‡?v\â0\ä¥\è\Ä\"@d\ï+P\nF„i\ÂP#3\ò\È(L0+y/€^ª‘„+WÀ šO\Æ\Ş\è3Ä²\ì6\rù\î­ù±\Ğt¥\ÜF\ï¿2\Ô\Ø2€0\r\Âw^£h\æR8ÿ˜\æ»4»\â¬Iıâ²Ÿ|\'9\ä\â\Ï#Ç³J\ä!$\ÙÁ\nER\×\ÊA\"´>¹%4>©ct>…M\'\ã\óú\rZ\'\ç\ÎÀfk_š(\Ç\Ã\'\õ¢Úb1\Z`(%+\Ä{\'B\ğ°t.™r$7SL\Í5·I\Ğ\ê\èETŒC[L\ß \Ñ\Å’u¯+\Ï1\êØ©Ì–3±/ -\ğ-9ø©„Á	e\çÈ¶\ëÕ‚£„\Ğ;Ÿ\Ğ\ğ:n<µ\Ğ<u‘şHr“9\ês\è\ÓJ\ç³:\ä“%±\Ãw P\Ğ`!„>\áò…‰˜.\nƒ>¤.È­_$}&aš\Â\è©›L\ãA´ù8\İÿ\ÎMD\ÏmC¡\ïO+\ñO\ã\Ífd™\êo(ƒ‰\îE-i\ô \Ó@\rH­\á˜9zq.‘#Sùi! \î\ïè²»‚CTkQ¼sI=rZÔ“–\Ã0\rS(\ñP\Ò>\á\ó>\ã“:¬´\×\ÊKA‹23\ê*F\íh)_\ZK^\Ê%\Ûb(\ÅTN…o¨\Â\ép,Â øŠ©\ä§\İ\n­57Ã©ˆŠI\ô›\ê5ŞˆKøŒ?p\÷š\n\Õ\Î>2\'˜H³*š\è,#ûp\à(\õ\r(\á‚\"\"8\Õwz´G£“`3nw²3/WÑ»¢d`70mq<¯I\ë\n\ØÁ\ñ¨Jkm[\ÃVmu>ƒA\îK·æ ˆ\rªb«ÿ†Á?\È4 \ÓM!c(ÌƒA)\å\ëP,$ŒB\ãTŠPpWX†V:WJ\ÃÂ¨ª·hDM°*o\óß„*QcPª(\r\ë‚S]‡3GN-ŠÉ£Ä‡F\ë\î\0n ~@\r\Ò\0|`9®G9N‚iÀ3:iQ“D\ğ¶i \ÄwSI\ÉSş–£b©%zq0=N…¸¤j¨F>>\÷ \ô«\ótF0a\0­\Ì|T@)\0`c\æ\â°0BÆŒ˜u\Üø\æPœu´l`V^dœ^\Ä\É\ñe<Œ*—²h­§\òœ´\Îd\ä]yk\Ó\ÄNu+Eû0\ÑVV‰\ê\îsh4ûš\ó\r\à\0\Ü\Éw„y›\×w\Ğ9 ®ºÿZQ7Fµ„.’w~Qbo‡\"Z•9\Ğ\ÓU³JF…D.d1>\ÕWÍy\İI&a\Ğ\à\æNv*ŠÊ±Fo3a`0\ö¢0C\ÛK\Â\Îbo\Â\ÈwÕ¢‹\ÒÈZª*Œª„*tˆs(jGgO]\Óßˆ\Êf\Zm˜\Ây¯ùbŒş\ñ?K‰\0`k\ë-)U\r\à@”w\×b˜ ·G69À\óh‚	‡C‡\ÂnG{So\Õs$9.c/\É0\á\ïZw>\ác\é3$˜—\æT#\Ït¦ @\ëd?§\à(7\Ín M7w(`6NE\ÆQ¥*ˆBMSy„f\Ö\Í[\÷Z3h|\÷¸5h­‚)\ñqwÿQLE¡M\÷x®_\Ï\éş´ \Õ^ s\0W\Ş ‚&\'™`’yÁS!@•“\Ä›…}\Ô\Õfx®LN¼\Ü*…¯\×3$\å\Ï<«\æşœl:\Ê\Ê\áş8\è\Ä`ûNVB$Á\Ş\Ğ\Òe·`sa\'\à\"n&F\Ü\Ä\íÁ\nxµ\ğ\ĞhšL\çp\ğff6§JR\\i%6ıT\ÑR„\á\r‡3\ó‘¶,\ğ—\0ù…CqV À(y_˜lgL\ÜW”\İ7\"vG/\ÒIF	{Z^K\ÊjzbS|WµbÃ—|¥T: C–iy}=\ÖG0\r¶\ÏqYƒN\ö*B\r\Ú\ğ\ãs\Ò2ÿB\ä1&B’2~üPg\'\ÑnpfŒ\ÏO8››\ê›h×€\\«\İ\î\Èø„\Ï-¸\îMrQŒ8}Q¶\â4\ĞBnøÄûù\r€\à·\óê ¢L$z/\â^QTR.\ãR!´{!‚ş\òr\ñ”ûÖˆ…ÁoS™ˆ\Å\ó\ğ\Î\×\"\Ø\÷•\ásG«x£\Ç\0\rt\ôÒ§¨\0¬@,Dˆ™/Rºp¶B\ö˜\éÁ^\Z,60¨2\ÃtyzF^\æB;GDcœm©4\ã\×nƒ\É\Ùeø\Äs(Mi\ëE`x4P˜O2 »Ô \Ô@\r4AÇ€D†ªì ®«›w`\"z©³HY±i¾\Ó!\ã:°M\ÎbÿInUİºo\'V\Ù3¢\Ëw¼\ò:–™t!Nv£q—ÿXCzF\Z|Jú¤û\"f{µG“ù½øY»­GfúPü\ÌÏ¸\İ@”3\ô»€ºuw\÷”\ë•¨I\ğeœ‘/Á&.\Ä Ù©¡:`\à\ŞÀ¶‘W\r<O’·:$¶º¹9•S\ç\ò;Ó¯HCˆ¬›Z|Ç“ª¡¡{b\Ñ®#‚ZŠx\"Hrº\ãk\ÖÁ•›ø|/\Ä;\r\Ä—E*\ô–²ú–B4NºC\Ã*.ƒ\ö2\Ã­6™,4\ç4\\\á\ÍF¨.¨HL\'M:\ç5A›]Î¨]l\÷xwk†\Ä\ÒgP\Z£¤\Ê…‡wx\Òkÿ[¸…ù\r\ÜI’“§[°Z’ÿ<i±!Pm9¹Ÿ>¹ ®ƒI±00\ÊIim|\Ù\áºW$—È©CŠy¡qy£\ÛR¼·*\á\ğ…)\ÊTC/`¶cØ¾Q\ó\é¬(~f~b‚PWVÈœh¨tª¦•]]EÅ®Ï²À!‘,¡•.\â\"Aœ\â&\í&-Ÿº\Âe\à\á\0\à 4_{!«I\"L\ğª\ĞIÜŸ3.H\Ô]i´5˜—®\â]½Wº‘8\" \Ô\ÆÁ\×oÁwUy| ^9[˜#qP6:\rüº\È\é£@kve\Ó$w3M\ä\Ë\Ö\ë‚c¼.™”ZC\ïû›l\ä\öd…¦…Êš³™ÿ[„¦®·f\Æx›hS\Ó1-,3q+;1Š®\ÂW\Í\'‚7\à9R»! …‘7yknŠC¼\Ğ\õ\ÙG/¹\İ+²¬§7¹ıUv¡\è\ê­\Ô+)‚ZZ\Õ\n\áš\ß\Å\ÓJ/¯\õZ—(³Ù¶o£u&\Ï\Ä`\0\'Pú\Ã@f\ì^”\ÂQ c/(\Ş/\0d\å²sz²7pÿ\Ç@\Ç\Ï^F´¿¹\ê\Ø\Î9ptx\İÄ²œQ·–‚\æ-\à\à‚(0} #P\ä\Ú\Ü9-%l\á\à\ô]øªƒ‚$”¾ÜŞ’q8\ê‹L¬\Ûo\ã\â\òİ©,†\èŠ\×b½v1ß«dˆ+¶oå­+Â…²å’‘C”a£ÿ\ç×¯£_\á;š\îG)˜|3µ\0\ÂÛ¢1´r\êcEh\ğ\Ó(e0¬V\0\È^nKV\\%\å\ë§o7\İn\Ú\ä\õQi¡9Q‡“Á›O8z8_ bh‰fKŒ0%‰	\Ã\è#Iab\Ä\0 ±bŒ\ÈH\óCM j\àÀI“)“0^\Â\Ì\í¶‹\İ.”¼V\òb\'¬—0vÃ„\r†lg2@‡ı6Ï§\Ñd\Â~–\Öre9a\ën£•\İÔ©ì±Ëº;y7\ã	‹GS\Ş:¯\ÇÖ±[Œ\í\Óul\Í\ã\ì\æNI“&)C#&M\Z4c\ĞL\â;LS&Fhø\"¼±F\0 \ÃX1Ò¢E‘\Â`\Æ\Ì3Ba´0\Öÿ\ô–Z¶d<:\âi\Ñ[´±%Lm‚C£ˆ\Zu\é\Ü0\Z«N›¶\è\ÔÁj	\Î\Æ\òÆa8(]\à\ã\ê\Ò[\ßb\ã1w\áÁ.³HŒC4ˆÃˆ¡\âF-Æ¸#\Ç8@\ğ\ÃQ\ófÒ°I¼À\ô\ÒKs\É4—0\"˜\ÓN\ó\è”L;?%\ÔNI-¨\ÓN9	SNL\ë4e•9PQe\ÕVSuMdc–W&µ–TQ©Õ–†\Â`e\×N˜L\"‰2ƒ¡‘†|\ñ%F&\ÃH‚b¬=\ö{ i¶\È—E\ÂCad&\É\"¶É¦\ÚAß¹F\ÛpŒ\Ûi·\Ù\Æ\\h\\‚&›@\Éñ¦…–´©)Plıfƒr»ÿ‰©\Üt\Î5§\ÜcÊ©\ĞØŸ\Î\ÍB\Z\å‘\'†$’<´c\ò\ÅwQ8t‡!‰”†\ZD\nƒIL\'±¤R€„’Mv]\ØÓ…²\óRş”‡N¥T¢K4Q%U¯Zi%X`­;\ÈD•¢<S±µV]Á€x†x¡!	1b\0™-\Ú\n–\É$@ªwI\Â`€\n\ìi\æ$£šY\ÆeX¢	\Û@f–fm¨dA¡•–\Zm«©¦%n\Ç\å{¦r\àm)fA\Ì\rÊ¦\Ã\ÙÚ§u…Ru\ófzxA4eC\n]‰†C@©\Å\'i\è\'Rû\õ§\É06øK8\ËTª‚:%\ÕÎ„³\ZUkR=ÿSX\Î.Hom‰OùZU‰f\õj¢YÃe•<e5\Õ\Ö7%x\á]G*s·h­“d©B\İQD\Ñ á¤”XZf\å”a\è\é›sTPD`hÉ˜i´YGZ±ı–p\òº‰Û™\Â\é\Ù\ÜwG·›€R¼\'u\Â\å™&C’D2z¦Cú(\Ü™l‘{™\ò„ùi²IDNRjL¼\Û\Ìû\Î\n¥“<<ı\ÜS\ñ\Ç×Š¡S\Æ\Ä\ë¯]Wµ5²ÆX\õ±,ŠÕ±]\ÓT4†\Ã‰\Ø0ÜŠÁ-\Ù|\å^\Òx\óE$“*tY•\äA\Ù»–Ej\æk\Ñ{ÿ\ó\ò\à g¸\Å$cQ½£@\ä\È\ëÿrcs¨CA\ïH,a\ÇQœk£ÍˆAJ\ÖB\Ì\"\ĞÀ:%e¤\"\ZaV¸8¬\ávš˜Y\îv—3\Z¢$\'\íø\òŒ¾WYhG\ÛÅ†&—™D\ë&rqZ±~…\êQ\ÏjÃ¢\n\÷¾a|km\Ö\"Fc­4\è(m%	_B\Æ\÷œ4#\Äg\Ô¯†0\"3a@ÍŸü–š|}\éKy\Òi%§\Ğ`Ns`c2¶¦B‚&sZ\Ä6\ÇHZ\'N;\äAB¥>Ê\è	CüR†BLaŠ#o˜\ZŒ\ĞÂ‘hÂ‹’\ÈD/2ªV\Ş&<3JO\ZŸ|\ÍV9\ÒxÕ”_•HzWC\Ö¿r=ašÈ˜<ÿ\ë&\ğ2eXQmWœ=3	/\n\æšDRe&‚ƒˆÁ=\ï“º&S%uI\É]i\ô˜º$·¥\ÒQ w\Ì\Í@\Úƒei±©\'rH\È\ßh!N‰\Ä ¦\Ó9>¬aÁd\Ãl†qŒ2QebÂ‹P\Ê\"8¨\Ï\ò³)‘ˆD\r¶3\Ú$Á‹Qd.J/~ˆ	x:P\Ñ.”4!\"mr\Ñˆ\ØÁ\é+^aV\Ö\ÊR–®\õlmŒ\ĞQ&”!Ã’¬m/\İ\Ú\"Ú9Œ\ñ)I‘…¥\Îh\"\ó\óD>£@\Óü\Ï8¼\ähz9yG­gm\çß\ã°\åg‘Š›`A!Iâ€‡~\ñ*Oÿ\êEL\Ş`“\ÅF`—©ˆ\ò£-\ÔV¤¼¬’’P]P¼Ùª\'\í8^Ğ¾†!L\Øt@E|\ËMZ‚DU!Š\"Õˆu“¡XHG@J¥&ˆ¡Œ’\èH?\Ê¶|¤1\01ş\Éf¸uo\Æ\Ñ \ğCcf<#¥¯6”J‹˜–şœ\İ\Ôq\ß)H—j3¸3%Ô¯hor‡š6tO\×Ùœ^\ñ\n†\óš·OÜ¡\Ò\Å(\ô8„)aEV\ğŒL–eŠ\Ì`\Ö)MŒ˜\Zƒ\Ş\àEVšT¥²‰…~f+[Áj\'><\ŞMG,D–\Ì%<\Ñ\ôTL[du\rkB	&–i-HaÂŠ\Í$\Æÿk­!%#[\Äı\Ë5ı“\ÜoŠK§‰#€®¹©Gj\Ô”\Ô\è(!\nL\à\Å\Üo\ôƒ?Ò†¡\ßQ¯ƒ³°2ŸÆ¹«¿\ÔtH»f:y\ÕN\"½+œ.{Pdod\Ä~G(\ÂL^LIŠb`¾1p?\Ì\" `e~QC\Ú\ÒF3L”J\Ã:ÁÉ¬8œ“	-xDªi\Òb¢§4m*3¦Wª2\"¬±(\Æj“T*sü\á&\ã[™HCµ†D>\ñX\Ï\èI·\éMÖ°ºL’Ÿ•;cº\ìVY»OF\Èk\"RH‚t\Ù8½I˜6\':¬\Ëe…«w\ãŒP\Ğ1GƒÏ™Nœ,·§\é\ô\r!\"Œ”BL\÷\Æÿ\ÖR\òY²|$‚Cwd£\å(HB²	 \09È_F¢Í¥’D_Ï†\"¡\ï}­hG«\Å.4~S^l\è$)6b¯bt\ìy¯g\Â\È\ì\Ú&	\"#:&S\'İ£…©|gL¬\È[Fx\Ó|[ÀÁÛ”t.À[]Nª”\ÉXi\ëF\ÌmÚ¶}Ç»\Z8µ³NgN\è{\ÛÏ±I‘\à)7¹17A\Æ \n“‘`\Ô~Z\Ø\0o]\àŒÁ\nPf1(<\r9øÀY‡hj@ÀPŸ¼S\"†š ù¤q¬¼	¥(±I†a\ÚküTs\áUOi”\Ä\î9Fh$‰UÛ™½-	o­¨\ëÄˆÿA\ÏCÚ¦|\0$×£‡\Ò\Î$a¸\ÜvpÂ4OR#£Ûr\ò-Ê¶	³=¿\í@7‘\ëı™\ãœn\å\Ä\É_c¿ s\Öm\í§KGdD€\ó)(‘\'¢\ö†ˆ’´C\÷fTzw,~H)\ÊülB²@€şƒı†¹\æ\ÕF2\çx<F!Ã°qØ€C\"-qbÀ\Ô=4z9ai`£\Ş\ÒLE\"	\Í\Ô[\Ö@¶:\ös\å3¹E$0\Ç?GhÇ†l\è\ÂFldeI\÷F„(ˆB/ß†&\ã8¿Áƒ\ÖfHtR_€¤u¡Wv…1…„\nEmue(\öR%ˆ	ª\ÃvÍ¶_nT…*?¾\ç:q)>9`h A;´³@\Ğ2¶“ù§yww …x”\ğj €†qAy9„K?ÿ\Ä\Èq\ÂE4Qj\"5=3*F\òNl³f‰‘6½¥#\ÚV\äMARY‹·zB‚nSl±[\Ø2¨F\äQH‡(\ñ\ÂP¸a/X\'Zb\Z²9\à\åN\Ä}]‡n\ØW}“H\Ê1\íd/\áQ‘N\r%)¦#%xv[û\í\×,£)œ\âQ\ô§ı·	i\à\0ù—wù\Ñ) \õ2¶£	ü\áE`43\'qµ„cD\Z§q1S¤Bˆ\Ş#5)5¶j)%±*¨\Ä`$ƒF‚\ÄPU¸Fi“J*¨E!$Ù¢(.\0 ]…tT†‘\ê\ÂtˆR^ú\ä&„cf\õ\Ò]\êÿ…0H\È\éVW\Ìa9	S1´&\â•^­ødkƒgi¤]\é·:k³\ì1D\÷:eh-\ÃQ\n¦h1Üˆ\0\ğc€”\áR)\÷wp@	^d»e€q=ƒ4´Ğ‡£–+Et(\"\Ã\ğ3)\'oÀU-yÑÃ g9	\ÄpıØy‘\Ö‚~\á#\×Ô–Âµ,h>q$.·!N\éRŠ\ê\âU•„ƒW\Ö}\Ôfv´ßb’%\ã¶G\Ç\áN\ZT_²„\ä8\à1\'\n5(k¥m„\Ã(\"S#Qn\Ôlú£I\èRQv\æ\ñ),”q`;RC90x…\Çjg8Hi;“ÿ\Ğ%!C<;!–gH\Ã;\æ <…b¡‡T’6®\×6[ \á-ª—\Ê\0s¾.\\\äz:–-<\ÖC6k\ÂEBB—-\Î\Õ{\î\Ã$“ÁtQ†%4X±Š¶‘@\÷ROoU8Œ19ûsW-©¸ˆP»H1ƒ2A\ôD\Zÿü48JI\Å(>\Éx~\Çø_¢¥A\õ\ñq\Z\Üii`i ‡E\Ğ)\"qJ\"xpû§p6ªi\0y7~\÷›!\ñœ3ƒzxc,–µ \ïxS˜wb7\ñ3˜…Y’pc…‘kÙ¢‚AU™¤\ß\ÂEhCXh`E}\ñ\Ô$x‘MÊ B\ç”Ÿ’]ÿª‘®™Š8X[\ò6°\áO¤¡*}@nw¢|û¤„(ùWS—’	\ä6$m\åQoR\â˜\ñ(\ÄG¢‘gv+°¢\î7 \ô1\Æ-Yb•‡§8€\0„×”y7•6Šj¸z£#\ñ)wF™€K\Â¥\Ä\Ê;/\"œ5X\êB¡c8\Ä\ğ	«‡k\éL%¡¨W¦?¢kB–-½$!€‰{(X>İ„d ø>[ˆFªØ®«/“\nf—9aP\Üv™*P\ê˜\ó^\'{2(\äGÚ†1Zr@µ˜\ÕUoXbo\Ç\ØP\åq%\")\Ğ5NU¥º¦xghs\Ø2«Š”¿y£?ÿ «ûGuœ.3@0gØ²Ÿ¢h¶\ó)ŸRM\0\ÈxV´qPº‹ –œui\')\ò[sùˆh€k¸¶ª\É C^®@B‰h c8\0\Ä\Å:¦\Î\ô\nQl\ÜG\\0tM\Ö$\Èg \È\ÇA~\Ú7ı\ó6g‹:\0cfš“Œ\0\ó¯ªu¢	PS¤ÁPj©‹]\öv“˜Š‘Gµù>\Ëo\ó±¦\æƒp„§p¶ƒ”¡p£°Ê†? «ùE?&û²sH•1\äw‡;Ù´€Ö©³*\"5>:f{hS¦\èkÉKe­1—?’‰B¢¦}¡-q\\2G5§-_*t¬ÿ=ù®\î\ê˜9ˆ¶ıb™¸auÁ%Û¶½Àøt¹!°²˜OQ§8l»¡\à\ç¡Ñ›§]•Ni\ä°\å1sN\ñ³¢>‰˜2¼ú{p\0\0ÿ{\0\à\ã8p²šw:\Ğsˆ²/´R9•gw`;?`w~\áp©q´	´°³/\ÑJ$•rHMg\ÓA˜\à¬\í9iF{-\Ù\ê[\İÚ‰@¦¿\ë#\Å;ƒ‘Jœø#7°Eu\Zt§\ñ\ãT\ğ*½Qv¶\\¨€jv\ÃQjbv°1¯øÚ¶t½\n3„\áEnı¢\Z\ë/…pgÆˆ“²9Q”A:\r%Qps1¡\nNƒF1úkp`\0@\Ç\0ÿpp\õ\ñ¶³	T9²@\àX£„«!A	Œ”G\éQ/³µ*€%qSW°„	\Ñ1¹g$B¶E`D(CHûêƒ‚!‚Arb@np6‚6h€	\Ù\"\0yM\ÙB{g\ã\\¼w[Ø·X…08f{e}3”¶uÒ·\Ú+¯]b\Z\ôš\Z‘y[\Ìe\ò8\çE„Z€ 88¶	±\î«]\ìÒ°\Ä)¬™gA¡ŠQ>i\Ì\01`2\0ÀÀ†\ÈÀ\é\0¼¹\'»\0wœx\È6Z¹”Ğ²È¹h!‘†Qµ	/‘Y+¥:@›JqZM\ß2Æ…iÓ´\Ùs¼\åL2¤—=B\Ê\î	$<ÿ\Ò¹\öœ\Õ\Ô1\Â5»Q>\Íed\Şdd\äŸ[` š°«Ø·Š\ò\Z\ÓFF~t ¿\ì§d/j\ÂPü”/ı\Ò@ƒ4©Á\Ì\êVÛ…|Š ƒQ€¥©­›\Å8oûªø+¥Zª!\ğq\Ç\ğ±da\0p\08p£!«\ôü\Ç	W« q²F°Àq½Bj°	\÷\'³\Èû3ˆ§	¸*E\ò(DFq\Ú$\á\ÅÅ‚!€œü¦DbÏ”JƒÑ—\áÚ–@RAR\Ù9\Üz;‘{¿;µ\"µ\\\â\ò\\Qt“ú\Å}K¯k›°\Z\Z&G\í¡e¯«\Ì\â58QŒe!\É0^ı zJ\Äg‹%­\É(£Sr~\éÿ±\áü\Ë\Õ\\mªm,\Ös¼\0ª\ê|\Ö,³ÇˆŒÀLù\Ö:PB\Új°B+´Q/ûQ-p\ç†\Êz@‚—ÿ­º\öejµaš	\ázÀU{À\Z\à0L\Ù~©-;®~\\mš\\¾EaÀûM\æ¹\\W\ÕCœŠf;8t#\ÌIÆ·!™m¾\á`6\Î\ÒF\Ì\Ïì§¾\Ì0a\Ô4\ÍFÀ½tO\Í\â\ö†7i%•Á°­)o”AI\Ğu›\òQªqœQrGrS\Ç\ğt¼ [¹±:¹À\Ïø¤¬œ@`c8‡‹\çm\ğ: ‡i0¤µkş¡\Âz±¦Øº\ö(\ë“-øEiCIÚ¥	\ñiÃŠÙ™@ÁÕ´>’\Ã(\\u˜k|Ñ­ \È\Z‰\Â$}\ËPŠ@¯¾¼n@8ıeg\â\Ì\Ò[¯&~e\'OıÂ¾Š©F`°1-\ÜltN\÷\ÖU\ÇQ\Äg©\ò&m\Îë“—bª˜²?rw,\ÖD~\0¡\İ\î\r\÷7œlH×[¹ú`€ü›»ªS>\å\å)8°\Ò>\í\Ô^\í\Ö~\íØ\íÚ¾\í\Ü\Ş\í\Şş\í\à\î\â>\î\ä^\î\æ~\î\è\î\ê¾\î\ì\Ş\î\îş\î\ğ\ï\ò>\ï\ô^\ï\ö~\ïø\ïú¾\ïü\Ş\ïşş\ï\0\ğ?\ğ_\ğ\ğŸ\ğ\n¿\ğ\ß\ğÿ\ğ\ño\î\0;',0.000,NULL,'2022-02-02','2025-03-02',NULL,1,'2025-03-04 10:56:54','2025-03-04 10:56:54',0,0,149),(2007,'Kishore Vedam',2002,NULL,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0\n\n\n\r\rÿÀ\0\ô\ô\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0V\0			\0!1AQ\"aq2‘#B¡±Á	Rb\Ñ3r\á\ğ‚\ñ$%Ccs’²\Ò&4DStƒ“¢\Â\'TUe•£³\Ãÿ\Ú\0\0\0?\0\ö¦\ñ¶’X\Z\n\Ø4 y£¢Ïµ\ä\Z ÀQ’¦]phüĞŠ2	ùU£j\İ7§A½™’f(¨\Íü…En¼\éhVnn\ö\Ùş¦’ş%\é0\åh—²Ÿ}€\õ\æ£\Ë\â\ÌQÿ\0º\Ğ$\Ïş‘\ÔT)|c½Œş\ÇI´Oø®?\î¨rx±\Ô\×ı\Z\ŞÌ¯¼1´„~„\Ñ´\ë{Ñˆ\ÖpOa\r‹U¨“]x‘s\Ù59ø©Ox‹z\ãw\÷\Ò?~\íød\Ñ7…½s~X\\\\Æƒ\Ğ\Íz\Íÿ\0º)qx#®\Ûu«\é\ñƒ\Ç2H\ß\éF\ílOÔ¶K\ÆvG?Å©\ä\ğBG~©\ŞyŠ5ÿ\0<<<\èØ²\Ô\ZŒ\Ìşl…şIR­´.ˆ´U\÷\Û\Ó\Ü<’\ó\õ\È\"¦G¥\Ö\Ëd±¹C\"#±b²/q\Ü\÷Ê¢¼\Å\Ó\ë\íJYr(Ä§p_zy	\ï\éJ\'¥n<Q\ï\Ïj0\Üâ‰»QWY4LÀ\n7j’1\å\Æ}\ÔP\ÎM\0x\ÏÎ\ä\Ò‚šA9\Íı€R\÷\nA<\Ò=\é$\ä\Ò{Se»â‘¼æ›‘Á\â N|\Û\Ûe<ªn\ÏT¾\0À¦$;w\Z‚\Í\æÌª;zÔ¼BÏ§­\íxIn\Î\Ù\õ\Âÿ\0\n‰§\é\á®\ã21©\Şq\ì*.¥©+İ»a}ªıX\ö¥n£Sš=\Ş\ô}ıh\ói;¨\ñš\àf\\55\'$\0q“Şk]\õ °]oÛ¹Jq\é3Rì—¦t\Öº\Ú^3°Ç™¿\r‘\Ï?ù¸±L\ÇD3üby2O\êNj:jı?\ÛK\Ù9HÔŸ\â*RuW\İ\Æm\ôk`¨¹ıA ı{©( y1©\íµoúı>uY¨x©\ÛFq>\ç \áv\ä\÷Ç§\ÏëŠ¥—¯z’f\æş(\"\ä“øˆ1¿øqF3\ë\Çc_\'^j²\í­\\wùI¹3´\"|I’xv\'\éP©u¨\Ö¨\İ]1Q˜\Ó\Æ\Ø\ÏÄ’ü8\á»c\ä=j!\Ô\ï€\É+$y\óJ|e\ö~T\ív\åO \È\ôü\ZıÅ¢¤77k;F<¢`wG\Î\Ş7;\ã\Øf¥\Ú\ëv·{¤­œ+g1Ágş±).d´|`\Ê\ãş´\ÖZW\ß\0ŒzŒr*ş\ÒKŸ\î\Ù\0o1 \"\â2A\áüc=¹Z‹u\ÔzcN/\íY½QfV#\ô<T\Ø\î£p\nu>¨Á‡\ğ¥y€\Ê~\ïO	}¾˜\Í;¸â”‡u,Q\î\ç\"•¸\â‹q4A‰LO¯jNF{\ÓR\óG\Û\á‹\ä¸ş4½\æ8\ô<\Ñn\âˆ\ä\Ñn\ç‡98¤\ÒHÁM‚8¦\Ã\0)µny¢8Á\Å2dšvVV#¾8\æ¢[ş\Ò\êg#„—?ÌŸ\áRs·j‹q6\Õ4ÕµMB8P1\Ü.G`3\Éü†j\ï_¹z›ù!\å&=\ñJ‰Í–$¬y“„ÏµT\Åœ»Š3s\ÜV“v~T G½“¢\Ü(Õ;P\Ü}¨g?*VhŸ•¦Ê“Œ`\Ï=Ê³\÷:­úH\Èl¢\éúQZ\õ\Ët–\òÀb\İep\Ê\Ï\åV\ïs\ÃÏ´C7­16eO„FT\à\Ø?Ö˜7\r#\Îlÿ\0„\çÿ\0\\SO\"°;—\Ì\Æq\Û>¹\èI8Á\"\Æ\Ê1\Èúq\ëY]CSeº•\Z\êeeÀÊ³\"g \Æÿ\0\Ç;[<\ä\ğ+¥Š\ÒUh\äÓ£}\ÊÀ¬†\ß\r™#\çü\'\ã\ày<Sˆ\÷qÉ2\Ş)‹p\ğÀ\ê\ZA‚¬Hs\Ã.Ï¯|\ğ*5\Í\ÌRÇ¶\â\æù\í\Ú3¹Y˜%\Ä\ôüHü\ó†\Ç~8¥OFE\ó †\æ\çv\ŞO™B\á†>\Ç<w\õ”\ÈY\"\"†Hm\âE\Ø\Í±7û¢6¿Ãµ°	\öÿ\0¥5Ì—.$\ê\âec ¶wH£d‘€ÉTn™Õ¾‘2O§y>Y>PX•\æd`\ë\İÀÛ·\ğ\ïW¶:a\Ó\ï\ÓIqş&„¼œ\ò\0\àš\Ê\êzm„A%\ö«nb·>fùŸpch€\àü\ê‹^Ó¼/\×\õ;½.\í-.<\÷_*\î=7!“vpeX\ñ\Û9s\\+¬<1µ\ğ¢\â;‘\ñ\"ş\Å\Ì\ŞlvF\ìKjëœ”ü8O©\Å\r/\íG\â5¥•¬š¦‘§\Ü\Ù\Ê\Í{er\á˜\Ãùyv\ÆÁH\Ï9\0€7½+\ö\Õ\Òn\î–-B\Ê\î9=\Ó\ïTuB0²!³ÿ\0+¯\ôg\Ú¢z\î\Î/\î\ír\Î™y]J\ÏÓœÊº%­Àš0T‚HıÓšxh$\Ã\ïV}2x\Î(®.lF\á…<š%¸S(BÀ7±<\Ö?©¼R\ĞzFÿ\0\î\÷Ú¤\î	™[\öpÿ\0\Æ\Ù\Âg°\Ïs\Å`5¯µ.\äµ\Ò/-n¥\ÄÀ\às\Î+ŸûL´›U‘â°·\Ô\õI‘r\Ò\Ù\Én\È=\ÉT\İÀ\ö\Î~f´½#\âİ®­h\ÇPÌ…ˆ\Å^0;ù‘°±\ä\á[=^8\Ã\Çm¸\í‘[$z\ö\ïZ·†x\çEx\älR\Üü$\çµl¨\Íø\íIb84	\ö\æÏƒÚ‘»\'‘M³c<\Ó[\ñI2(ˆ~´\Ó\Ü\ìsša\ç9\Å15ØY€\0Iü†i$“a‡!¤a\÷\äæ¤—99ªû\é2¤gmiºJ\×\î6—\Z‘\à¢yQç‰»ŸÒ‘°–B\ÎO s\õ¦5\éÀh­•‰B\ñ\ó«}+DK$d†V\ê?$Ñh\Ç\rN+Ñ—Á\ïF[&†rh9\àÑƒ“DÕ’\×ú\Û_\Ôå»šúş \èc0\Ã>\Ô\ÚWiÇ¯|ş•Qa\àÆ‰§Cn¾u\õÉ·\É\Ş\'\ó6\å@+\È?Ç½k­t\è\ì\íc‰^O-8b[Ÿ©?Ö›“0;)ü ‘ÏµG–Cp\Ìs\Ï\éMy€\ò	\ïœ\î\Û\ò\îF\ë\ó¦\İ\Ê\Æ\08½x\ö8ªJ)a”&Á\Ü1\0qGÆ„¯nùŒ`ã¹ªf¸{y¶\ó’Ÿ—\npva€\á†T\óÁ¿& ©TP\ñ\Åk l1¥²¶#ü\0\Æ\Ø79¶\0\÷¢ûùYœ·š\Ó[¾<°\òD¦@¹pú:œ\ã>\ô\äz€•\"<¬UU.%™XXdø€9\ÏÃ““\õ\ïQ\÷$AR\Ú\Î$\Ü\Í\0…„D‘\"-û«\ÙÁ^\á\ë{»\Ë9c”j­\ìr(VŒI<\Ñ\äŒg\'k¡\ô\Îr{\ò½\Ô\÷\ÓO¨\Ë3%»¦E\Ä\îNT\å—^H<c\õ&¨z³©µm\î&u¨²\0™# ½\æHíƒÿ\0*\æ}Q\ã…\Ò\İOi©\éO\ÕxbµW\Ô6\ó€B£?-\İı+k\İK\ã‰vww\ö\Zf´bL$WR[,\Ïî¢‚\ç\Û¸w[h¾\'\Ø0~§Óµ\Ë•\óo^}¨=\Æ\Ğ@\í\Û\ÓÖ¹|š~¿\ÎÖ°\ŞÈ‰‚\Ïfn{z+¤\×\ì^\÷\ë\Ëx£n9\n¼g\êEuu\ë\Û\í§\Ú6ƒK\êg—ÍŠmQ!`R \à.\é®±\ÜÄ‚®£¸®ƒ\áO\ÛY\èe´7–‘\Ê\r¼sKT\Év•ø”Ue\ÇøM{;Ã¶Døm\÷cr\ÚN¨ª¢HnŠ \É•9\í\õ\Åiµo4N‘´•ÿ\0Ú­\á0dH®\î\Ò\"\ãƒsú\\oµ\÷U\ê2\Ü\Ç\Ó^\ßjm\İ\÷†¹Dƒ•Á`»»‡#5ƒ\ë|b¹\Óe}«\Ù\İ\r\Ïq/Ş­\0;‚\")`y;\Éù\Z\ó\ÇQı¡ºmv\æn \è\ökG—\Ë·2:,r\ì\ÚNY/NH\È\ç\õK\ñ¬¤Š;{M\ÇZ\ÓS\ÍMKQºE¸\ò\ß\âP¢i ~?Jr\ï¯:¿¯\Óû\÷U\ëkûg‰–\"úzùGv\0\Â\É\Z¢€3¹\Ç\çY¾¦\Ô5-:G\ÔW¨:T¸„¯\í\ä•\ä8ı\í\ŞüV\Ó\Â_¶Rx{ª½§sw¬h\ò\Z\Ş\ò@\nû¶q\íŒ×·ü<ûB\Ù\õŞ›mw¥^\éºy\ò„e,\ÒHb>˜ _\Ë5\ÔúoÄ›=j\İ\Òå¢†h†$\Úû€ù‚;j\ÓR€\Å\óS8\ì\õ¢“Vµ‹†”L>¹jxY@ ’i¶Ö”~®ü¡o\ô¤|\Ü1ı¤\ì¾\æ2?!uE\Î>\ã\"ü\Î?ÖŸS“´\0}M#\îú™\ô~D\Ñ5•ÀÈ¿¡¤ı\Âc\Şb?\áGJ/Œ\ÈI\÷4‰´\î!xä‘‚°\Ç\Ây\ïS\Õ Œ*~\Å7(\0\Zª‘\Ì\×)\Z!bX+wuhl,\ì\ô\ğr\"\\\ÊG«j9\Ûg\Ó1\í\Â\â™\é›©\ê¢i07\Ä\ÃßŠ\Ö\õw‹}+á¶¦šF«x\ï\ÉYŠ\Ç	lH#×\åY\Ô2iB&†\âi{\Ç\çEœ\Ğ\Íÿ\0j,š<f“‚\\\çY\r\ÄXş\ì”JnX)À…™ ¶\Ğ@Á\á.*N“\Ô½I¤\Ú\ê6FFµ¸\\¡•\n7\æ‘O\Ë—\'\÷±€\ÅüªfBF$$w \ãøP,?#Õ¶°ı*,À8|guR\nÿ\0˜c\Û8¬¶µ\r¼m&I«o\\\ì	Ë¿Û¸\ÙÁ\0\â«\åt\á\â6‚`ø\0Z£\æB3’C/&y\ô=ıª)™ãº¤“G*\ë¢\ãÿ\06ùiO®<qR-g¶k¡\õ\Ã[X\ï\Ì\Í4û\Ìq·û\Õ—\'a\ÃOç¶—¬é§^ œ\Å––\Ë2\Ì\àa°Ë>~ aQu;\İ?£úz\çR\Ôo\Z;•@•7Ç¸+m\rß§\ô>\Ã\Ê}a\ö´\ênªÕ®4ÎIm\ô{I\Õ\æ¼\î’Y™€Q\ñ´<(üıj´n»\ñÿ\0©\ßC¿\×%½OœKU¹›|V\â‚\ÏNXx\ö\ç´\éĞ\è±=,j7\nB<\ğ\î˜\Í\'|’lw9\Ú=H¬\÷Sı²\ï\Ò;;F´²\Ğ\ì’&ÁE/$Šr¡v).×½q\ÍW\Æıw¬u!-Ü–--»4\æ\òVœD2¡	nO\0ry>”\å\çLi½f’&‰ ÿ\0|E\ZºXÁp\ğ`R²Lÿ\0Ãk\õ7šœ1-\İŞµ¡Gq-i©¸\Ğ4m\ô«=w\Ãı_ :D\ïû$ş·\Zk0$V—{e=T\ã\ó®9¬\\»„Œª¥Ù‘rª6³`\08\à\ğ¹ú±¥]c¦\é\÷ˆom\õgg“2.\Øü°\Ë(}Nw\ç\Ó®\õÓ>\Ø\ôii¬\ôÅ±5\Ì\÷¹RÑ´,«æ¯’x\\H]CF@;NPMz7V\éú“K\Òú‡Áî¥¿¸º’\Ã\Î=+©]y(\ècM¦\Ï1\Ä~_0qŸg\õ¤şü\é[å¿²Õ“/qtH#\áx\Èn\ÌXœœg5#\ÄR=5KH®l\ÅqM*¯\á\çœ\î\ËNú\à¶\Ş.·Ku\ö•\Ô\÷ˆ“\Ül[}N\Ùv\É\ÄFG$…lƒ\Èşrx½\áØS¸´Ñ¯t\ÍFk©%„Ù¬~R\ÆKa	\çŒdŒ~uqe\ö\Ñz\Ã4›:{\Ùon\Ú\ê\ÛkmX\í·•hßH’2Tv\Ãi¿~Ğ\r\ÖZ6—M<w–Ú¢\êM&\Ä\ó|²Bb\Ğ•jú\Z‰\ë~“·];JĞºw«Ÿ\Ìxn­:†KŒ³\0«G±€\Î1ŸNâ¬¼3\ñ\'\\\ğ\ß\Æ+]«¯VMB1n&\Ğ3]\ÛIGqy\Í{\÷\ÃıV\rsDU	»\0•\n2 Œú\ZÕ˜£\Ê)ú¨ 6\ÆÑŒ{\nOœRƒÿ\0º›s=\é$\ö\Í%°OjC‘;\Ò2pi*\å‰hn\r-qJ¯½ı˜l|\é\î‹\ÓÄš”—\÷#\ö‡v\ïFo\İ|5¼<\Ä#’I[«™gh­b\Æ\æ<ƒ]C¤t«>‹\éiµKˆ7\ËL\áHÜ@3\Ås\Û.Š}_\Ï\Ô\õhVmNşSq9p\Òpü*…_Ê“»uf”1FJ1&{R·ŒqŞXûP\İ\ïB†}\èo\ô İ©™\"Gä¢“\èH¤ª(_,\0£¸8\ìj-\Ôm†eø~0Fyª½J\Ô\äMÀ\ÎH\Î*\ËÁ\ç¿ùiL\à\ñ\Éa\Ï\Â1P5C2F‚²ºº\È\Ä1R½»‚9\ëT7\Ú\\\é9¼”øWÊ·\ÕI\È\ÆÓœ£r0;~f ]h«6Ÿ#I4‘j*şdv\Æ\å¢g>r¡?@À_QŞ©lµN‘¢µ¸\Ö,\á¿\ó	\ê\åd%\ö\àaXpY>\0\ï[ûyú_A\Ów\İ^\\kLcWŠ\"\Ó!N\à±ùp;W3\êºRMgM¶\Õ4£w¥L%W\Ó8\æf9ªY^y\ã¹Ç½bu­c\Ã/\ô\å6šu‹*Fn`1\÷‚rv¦!9\É!dbG\ËS\í\r \ê6\Ïees}036£cb‘@¯ƒ´¥®\ä5\Ê5¾¦‡¥ü\æ¸\ë¯\î.2\ÙE\ËÈ§’VY„D\ä\ö·z\æG®èš¬Rv\é.\'s\İ_j_|s\èF\Õ\n}\ê£H\ÖDs\ÛÁ<‹a¦4„L\ÑZ¡e\Ô\ÉÏ·?Ê†¥Ô«iqvt‰,\ßO?\nAt¹L\äd6rŞ„ú\ÕAek\r\å\ê1½DH#°\\\ä•\0`‘\Ù\äb¬µ=k_Ô´¸Ì³\Ïw`®\ğEJm\0‘·Ó†\àc“SúX\ôÖ³¢\İ\Ùk:„\Z%Ó‚`¹š\Öy	obÑ¶O¿–\ßÖ²\Z…œšU\Ë[H\É(<«¡\æ\r_j—Ka\Ó)¤\îŸ\ïEûÀu;N\Â\í\Ü\òY\ß#\Ü\nM—ˆzÎ––\â\rFe.>\ğ$eO„n\Ü(J\êú¯Œ\÷\Ú^£mÔ¶,\Öz¦¡hŸ~–&4\ğc*\ê@¤\ç¿9\õ\âú/ü>\ê6=?©\å\×\à\Ô\"f6\÷q\"´3K!v c\òs\ëH\Ğz~¯¶×¨iú¾•§\Ä\Ì&:ThLJ7n \à\ÆHY‰<Æ°>\ôGL\õWT^Ã¬]ù0À¡‘‹yh\íŸ\Ã\Æ\ä~µ§¿\ğ“A\Ô:Á´}:[»Xtù.cIº\Äs#H•\rı¿wŒ\äVg\Å+»DÖ¬\ôKmN\çY\Òm\â$·£&\'*F³’d\Õ\ìO²›m\â‡Ğ¦»Òš-Ô¶W-§@\×\ö±<¡YBs–\n9\ô¯>ø\÷{\Ò\ÚvZ6¥Å£.™¬«\\\İÛ’\Æ1\í?\n\íø\Î@\ìV½\Ë\öo×¥\Ô\ôX\Úy¼\éd·_ü[]—q\Ç®\Ú\î‚Nù\Å8¢\ôÉ¢\È4‚™=è±(¶z=˜ù\Ò[\0\Zk9\íF\äãš¯\Ô7\0\\œgª\Ñm‰\é\ÛH\Z#Oûi‡\'=¿…]X\ôü‚•qm)a\êjÀXE\"5\ïÈ¤\\,V®C‘Œ\ğ+˜@9\Î)[¨Áü\è\Ğ\á±KS\ëJ\rŠ\"\Ü\ÑdÑƒš6\àQš\'84œ\ç‘\íI$\ãqø°0\ÜrG¿\åP.-Œm·\Î;\ğ?\èU,\Ö\ánr¯jja!*û\'4%¶uf9[w@¢›\ò\Ø)e8#Ÿo•f¼@ƒ\îı<Ñ—x…Ä‹K\ì`½Û‘\È\È?*\är\ôv•«k30º‚ú\Î\ÅCgl†7”gÕ¸<{Òªt{\İbş\ò\ê-\ï\Úy`Ÿr[¹‰¶\ö«Œ“\ã\ïY®:o§/á¹¿\ñ\îw±m6–®nQ‹\n\Ã\07|¹\í\\\ÃÄ¿ºªt=N¸°\Ô5;/|v\óİ¹\ß2“’$!ƒ6\â	\Éø¥p=[«`›\ï\î\ïm~-\î\Z<\÷ \î\ÍQKu\r\ÊÄ–\÷7r\ÈÀ³À\ØULvø½AQb\Ö%²l\Ù\Ê\é#r1\ëŸO\áQ‚\Ü\ßJ¨¶N~C\ç\íS\çû¥ QF‰8?µº•\÷\ñ\ë€\0ùŸ=n\Â\Ñ\ËÂ—\r:ÌŠªT\÷\É\ï\ô\ô \×l\ğ\Ç\Æ\ÍK\é­K¸\é=#\ïze\äR@B<\Éş4]\Ò`“˜‡Ğ•VüD“\Ëür\Ö4½K\Ä\î¤}\Z\í\ô±¨Jm0\0X\ò\0\0pO\æk!m)\ò\ÑfL©\Î±v\"­tkˆn’\íµ)\í¢P\Í)|H2sİ²A\çŒf¨\ïY\Ü!\"sÇ¡\íO\\\ê·\rs…Š´H\"Pİ‚Œ:\÷o(9pA\î{œc¤\èÎ¾\ÕúF\í%\Ó\ï\ÚRD™\â`eØ¬ 0#‘† QW[-¨\ñR“Ho/H½»\ó\í•N\ß.9\à§\ä£#*\ê—=Mg§u4\Úû¹nP\Â!\Éc¤aCû\Çi\í\Ø\Ö;¦®\í\õ­N\ßT–$iqošİ\Ä\äs02Ob8À\ï]+\Ã\ïú¯\Ã;«\ï*\r>\ğ%\Ã].#’s>A\0\òj\ò+\êzF£\×\ZÔº¦\Â\ãQ¿½W—±‚AfÀ\à\å”@W¾~\Ë\Åa\Ó\É-;¤[¡YZ?…¶³ƒƒz\ô•µ\êO\'–fø\Èqš‘\ï\ãÒ‹u\ğ¸¦\÷zWw¤¿Xù\Ñ=sI>Ÿ:K`PV\íš8|‰$\Û)8\'\ãµn\Ê\Çss\æ,±˜YWfc«[Sk\î!S\ó\n–5M*>$\ÔmW\å\æŠ~>¡\é\È0d\Ô\à\ò¦M\õ¯Jn\ÃM¼S?Ò¹sEE¿œQ\ä\Ô\æ\ì+QÂŒv£®hg	&†qDp\Ã4\0RAe!”dq\ò¦\åMøLş\ÅÔ•#\Ğû~]\ê\ò\×=~t”Œ\Ì2 \í°)On\åq\å;|TKµ[hY€\íù\×3\ñ›\\¿“K‹M\Ò\í…\Åı\á\Ù\0hVHÙa\É,\ç^Õ®µy.\áÖµE\ÓDlI[;O2\ãƒ\ÄaQ\Ô.}Y\÷b£\õŸWÉ£\Ë¥\ô­Ö¡$†1+£”F™?\Ä\Ò\0v\à`c·­yo«úªúV—\Ì	9fr\ØF<eÇ°?\Ä\Ör~™\Ög\Ñ\á\Õ\î,»\ôÉ‰û½\ÍÓˆ£“\Ìy\åÿ\0*fW\éo\îÙ…\ÅÆ§y«?\"Ü\\±r\Ç\å\ğŠ§\Ê\Ö\Ñ\Ë$…\ä`¸\İ\È^\ä\ó8\ô\ô¥\éºÎ¬‚dU¶°W\Ø\÷/\Â)\Æ3€x©zœvir4ıdŸw\Â&uÄ³3\ğ\öQ\íù\óQ\ítÁÀ#i2\Å$™T\ã\nqúr)z’¹‘¥œ\í“ıØŒpq€?N*6º;\Ğ\Í(DŸ^x¨\Ú\ä‹q©\İHŠ|²\çn\îıû\Ôy–m\Íÿ\0£I·*\ã•şµ$J\"(\èp»r\ã#×Ÿ¨¨Ì¹ˆ–\ä\ç>£Ş˜\áOµ)d\Ù\ØpE^%\ÒI}i+cYø\ìUBÇ¹xÚ¿şNŠ ï¹¥i·\İO§\éU:6¬±%\Ú\\K+¤6œÿ\0\n\Øu¦úÿ\0Li%‹$\ídQ0\nû\ã¸n\ç\é\éMhÚ­\ğ‰ ³\Ôü\È!·\ÛOµN7‚Us\Ïq“¶½\àG\Úr\÷Á\×\Ò\ízª\Ö\áz~w \Ï\noÚ ²’¼\ò2I\ãš\÷\ÇHxŸÒ¾&hÚ–‹ª[\ê6³\ä\ÆTü@\ãÁÇš\ÒÁ1L*’\ê89üB¦$ûQ°g=ø¢6üP	´\Ñ/\ÅÁ¤–¨‹{Q\çŠIû\óE…N\0¡¸ÀE‹g\'>´\É$ŒE¹\ó\Ä\ãŞˆ»n9\ÇÊ¹ g\éV@“œ\ÑZ\"Â“œÒ\âœ)£R(\ò)a€\\PÈ¡C\"’y¢$\â’{\Ò$\0Ç·\È;½¡§DW»\Ö\Şv\×ş»\Ô¤º!\ò¼Æ“-\ñLƒ\ß\×\æ)2ZLˆ0‘`\Å\ç)ú\ö5™\ëN§M\Ğ}\é\ìá¯Ál\É#{‘\Ë1\õ\à\Z\ñÏ>)_5ºi)i‘24‘\ánH\Ü\à3˜Á\ÆF\îx\àW/\én°Ó®®a\Ò\ïfûPº“ı\î¬\Ä	R	\ÜHï“Š__YG f;\Ë[¡T\Í\ÓY¤ŸÂ™!x\Ïc\æ¹µt\ç¨!\Î\È\é\á\ì\İb\\J}ˆ\Ëµ]®tf½yv—W\ë*\Í!$-ü¡\åÀ\÷A’?<Un´—P\Ë´\Âp—k?5\\sùÔ\'¦\ô\Ëu¸}f\ñm\äT\"+[hü\Ù\äm½{– û\n«\Z´&È£P)›\ñ$\0“Ê¨\àŸŸ5#K´‘¥–\Î\÷k«%¿œ\à¤}\Øÿ\0”\ë\ì1ëŠ›gl\òIP\İD\äz\ç\êyb}\ğj¯ŸK“P¸\\±vI=?\ï¨:†œ\Útˆw|[	n9ª\ém‰!ps\ÜÓ‹e¶!•\Ï?Ò—%Š·;>T‡Ò›b\ã\nH\Ü;ŠDºY\"²£$\Ä\ğ€\0ş¦¡Km\å¶\Ö\äU\ÓR[)E*r\0À4j\æ°ß…N\ì7\ïJ›x\ô\ÆyKXa[‚\Ùƒ\ÛÖ«W\Íf8\Î\í[\r\ÊF\é»\É0b…‰?…²1\Û\óP¥\ãFø#z¿â†T\Ö\ÓCÔ´Ûˆ¢¶-<)+\Ñ\î\ô\Ç*3\é\Åt.‹‡\Ä?\n´\ë\î¢\èE®4ˆ\ö›\ËH\Ş)”©\Ï-\Ü1Ûœ>|\ã\Òş\rı®W«g-V\óL\Ó/‹Íµ\Ë=³»`r§qF\'\Ø\í×§zs\Ä$–\õ,\îrÜ”‘|¹>d\àš’+\r\Â\Íø]]\È \Ó\Í9šd¹\ó\éC€üX£aŒRX\ç\éI\Æ3D¼\ç–\õ¤ \ÆsIT!³F\Ì6i 8¢\ÍOo=\èfÒ’M\n0y\ïJ(sJ\íCp\÷¡ßœ\ñ@=s@}qDM#z}Ä‚;cÖ›.$‘€\Ç\éúSSÁ\ÜF)TF\ç”q\î+5\Ö:\õî¦Gš±=\ô²,ldbQ\ç,\0\ç?*\ò×‰ş2h>2\Û\É~\Ú\ÇTP\Ü5×›\ä!$32)8?\åü»Wl,¡×º‡\ïV–­©™\äm\ó\ÜJ°©bpNw\ß¥?\×\÷×1¿K\Ó\àX¤\Çÿ\0H¶&\È?ˆ4›¤p=zVN6Ó´û?^\ÔnuË‡Œ2A§Í¹Kc\÷œa‡Ïšg¤.5[y\åM9[N\÷3\ÜO¶S=\ÉfPc~=hµ=r\ßN{‹=8¦»3\ÚkW®ûTc´`\0Œ\İı«-6¨yv‘}\î\íùy¢‰ŠúqŸË­\Ñz®·t–\ŞC.\ñ¸Emb\Şü\Õo/EG¦<p_[\ÜG)BU¤n	\÷¦ \é[\ë\Å/wm5¥©ødxÿ\0\Ş0\Ï g¿\áúV·]9q<†2\ÜG\Ç\æƒ\æƒ\åÅŒ\å¹ùÒ¬,\ô‹w\Óaû¤8!dIŠ•\'øxÏ¿?:\Ìj:\Óu1\ËqI¸ù‰\"ƒŒP~Ubı—±\Û\íLs\Ão4’È£*\ä3>O·\Ã\Ç\ä+=ı\Ä\Ó2yC“\Æ(\ä\Ñ\Ş\Ø\æDU€\Û\ïÿ\0_Ò™\Ôt£”)\ÈA0z9t\è…\ÔFIUU\ìŞ•[q¤FÁ\Ê\á·û…ü\ê­4\Ø]\Ú6;O\î;\Ô+\Í\Z{pc`\Ö=\rFš\å\Ü“/\ß99\äú\ÔS{œã“ŸJ\Ñ\\\İ\Ék\Ó\Ñ\é\ñ\Ê\ëû\ZE.\ìdd|³T2n]¹\Ú;Š\\3O\ÆT©\Îj\ÛLê‹%ÁWpJ’\ÊH?B+_\ÓK¤Ez‘\ê0«\ÙÈ»Á’@Ç³\ã+“ß\ŞÂ½\áÿ\0ˆ“\ô‘—Tı\ëW\è{§Ë©,\Ë»·ø“\Ö)\ä¡\ã\0ı‡áˆ2A–§y£ku“NÖ­a½„\ÄH\ì\ã\÷«®\ïVPC±Sh\Æ=\èÀş*,\å¨œ\Ğ\Ç$\Ñ98\àf¥”\ãG~\ã\ğú\Ğ!\Çd\'\éCƒZO”}{R¶n\Î)>GùªiùRJzŠ1I\0ƒ\Éâ•šP|R\Ø\ñCŒ\n;P\Ü¦h²­i\ó\áPf™´\âÎˆ\ÍwLdƒ\îµfuÿ\0úo¥¢y\õ+ÿ\0»DˆX´‰·##8\r‚{úW—ümûT\èš\í\ÌP\è\Ñ\\O¦§ÇºIZ\ÖK†\ÏÀT§ M\ÄW\éO\ô\Û}\ZK\ë?ºi\Ó\Í\æH\"Di\Z\\\ç\0_3ŸCUk\ãI¸\Ôä¥\Õm\Ö%\ÃM4*7g‚qŒ(ù…{\õ˜\Ğ\åÿ\0h.Œ—\é$\÷K\Í+\î\ØüX\'sü€üø¦º–\ö\ßA¹\Ûkº¤£t——j†?SùVR\÷«µMfH\ì\Ä1°\ä[[+yl\ÃÔ¯ ‘¥^\è]®k¨\Ì\÷&XR\\x\èÁ\ÎH\'\'\åük¦\ô¯„\ÇWh\"·ƒû\ŞW˜¢dH\Ë`|Rp#“ùW£:+\ì•y¨\ÜZZ\í\ôo»©Gû ‘\ç’<ú<˜C\Ü\ç\Ûa\Õ_g­@\â\ÏH²ˆ\İH6\İ]™K³EÅ±œ\é’N¬\ÏTøI&™\ÒkH³\êEX£À6G˜£¿$`9\íI\é³}`\òj\á\ßR2ûE\n000F*/St‰\ÒZ’Ş²(ÓŒE$A‚w`\ìO\èkj}5Î¹}«¨UB¼N¹\ò\äc’¹\õÀÛš‰>™p\0‹{\"¾Pb?{ƒƒÚ [\ôtR\Ê ³@\ãŒúŠ‘¨xn\é“oœÿ\0¾¡»}WÉ¥\'\İE¯K\á\äL9#ÓŠ\Ì\\\è‰4c#\Ì\0\ï‚:…s\Ó\ÒZFe$…\ğ‚0*¯RÓ”\Ã}\ÑT“\"I?N\ÔrÂ·ˆÿ\0µ]¸\"U\ì>Dv¬–­£\Å\ì„ü\'\Ô\n¤šÍ¢}§•=‰\õúÒ®%“Ê± ´„ü\Î\ò¡\Ê\ßÌœ…\Æ~tq¡U±\õ\ô\å\Ë\í0>†¦¡•\âp\ÈHşµ¬\é¿/t\'·v{:\â3\öc*²Ÿ§­u\ï	~\Ğ\Í\ĞV1i\ësq¨iQL“[\Û\\?\ŞüHe\ìA\Ï¾”xk\×:_RhZ]Æ›t\×:m\ì^m´¯“†ı\ä\'\å\é[\ğ\êq\È¢Àâ€‘s\é@>3\Å4Q\ïùP\Îy\Å\rÿ\0#F>>\àŠ5ÊŒsA‘˜c4K	PsühùÔ‚3I<Q\Î)<\ä‘C\'Şˆƒh‡z6\'w~f\î)ÀşÔ’ü\Ñù›¨n\ã\Şï‘¡»Ş™š#;® ^r?•c\õ«›\Íbe†\Öÿ\0\îzM¿7w›7;`şä©\ç\Ğüx§\í\âŠu7^G\Ó\Z¥³\èº^n5‹\ÂLN\Ë\Ë?^\Şyn5\Ä,ZSW›U:tº¬­+Œ®#¶‘Û¾	8\ã°Q\Û\Önk]jk{’–\ß\İÖŠ\Ù\ò\Ò~@@\ã¹Àª–\r\"2\ów¿)9MÌƒ\ä3Áù\óW}%msª\êV\Û.]J![»*\Ë;m¶\0\'“\Å]\Ë\Ñ\ö\Ò\Å,Ö·\ß0ŸË·\nCN\ç’\Û@Â€¸\Ï$ü@{\×V\è¯	%\Ò\ìˆ\Ém¨_C±\Ã\Ägi Ÿƒ·\nFp2\rvM\ÃQoh\Ñ\ÚCwwsÅ’\'`Vkm\Zœ\ö$\Ï>µ\é¿zZ\ÃE\è\ëW–-®¯\Î\ò!„‘³ª¼\ç\õ±\ë?g¹µş\rbÿ\0M–mc”Klr˜\î;\×=ÕºsT»¾[8\Ù\í­d+›‡(\'`_^A<\ö\Í^iş\Û\éºÕ‰†\Ø\Ëy:—¸¹šO1£\0g\'\ÆqÛµ^u¯I\Ú\n\ìJ`¸,{‚¸¯+ø‡¥‰®%\ã\"$€~\Ôm\ã \ñ·Ô\õÎ–\ŞKm=\í®XN74ŒbRI\ô\ÍX\é-ı\å¥$\Ñ>[\ÈFŸSjº½>m\õ¼¯¶PG;‡\ïc\Ó?\ĞUƒE¡\0’½H\É(2Ö«Ÿ¦á™ƒy«	\î“Šª\×z_NŸ1\Éd¿z\ÇH?\õÿ\0¬VJë£•\ç+\Ó€’7üª<\İ,%·\ò\Ì.\Ğ/g\çn:\Ï]\ô5\Ş$\"›»d\î_\áYmO¤e´b\Äÿ\0³“YûÎ–†Tøgı±9l.\ãúVcQĞ¥·vDeŸa\É(8ùƒ\ÍS\ä8RN{Q¤ÿ\0w\'‘\æg¹\ô¤\\I½Â‘†\Ï\äi\n¬¦9\ïE\æ•9<ƒOE0\ÜIZ\ög\Ù+\ía£t¦k\Ğıc#\ÙAşf«\0qû g\÷¹\ï\Î\0¯¡;¯\Úu—m}ksÍ¼Ñ‡h\äs\È#J»EW\\\î(\÷ƒFFT\Óa9¥¯~ÆœŒc=(\çÒ‹\r\ïF¬I¥r\ÔDŞ#G‘H+DT\Ò6“\Í\ÏzF­w¢Š:0qGº¢l(Ï¥S\õ¡\å\é,Rs/\ì„\Ã\ç\Æ?R+ø\Í\×#¦4ht-\ö\Ö\Ä«w}4Š«h‹\òX)$äƒ+\Ì\Z¾›Ó—V\É-º\Ú\õ.Ÿd»!‚xn {‰\Äe‘œF\0\ä|\×;\ë^¶\éÎ ¹•-¡ø\éÑ†o\æ\İ|@lU‰\r¥‰\ğœsXûØµN¦\Ò\ãq5Ñƒ„xe1*¯ €0\Í\ÏÖ³b\Ê\Ö{\æ[xb\Ä\É=\ä\à\ÂOø‹\Øs\ğ\óŸJÜ½‡C\Ó\ÇJ·3\ŞH\\Ú¥\Äj_`­¼db%\î=Y·d\ãµn|#\ğ\İ\î®\õ\ì]\ìªYŠ!ß±\õ zÂ»Î›¤=¶©h\ZQ$E‘w²±$\È9ÿ\0®+\Ğ~\éZG•¼ºG9$K¾\"|\Ì\ã¥t~\ï£ZG¦YÛ¼\Ê]\Ì[Ü»rp1•\ò®º³¹\Ô[\ö±±Qø·c`\Üw?!T:M\Ëse}-\Ëü2*Ær\0\0ç·¦?­J³X\×^½\ò\Ìb\Õ!Dd@\0ryB¿­Eê‡ŒÀ‘,\Äeƒ`\ÈÇ¡\â¼ı\âšº\ìWl\àÈ’\×€?•rmGH˜\Îm,W„\í´zı*\ÛH\ÓZ\Â%Xÿ\0\Û\ï\ó«\ã¤ı\ò\ÒH%@\Ë\"\í\Æ;|\ÇÎ±W/g§9´¸\rû)Qˆo¡\Ç©\ït™›6\ñ°u\é†X™Â™\Ô4+¨£Êº²\àB\0úT³X:I†U\íÂ¨\å¿Ò¥K¦?—¸£IŒa1œ~”«\ß\Êdd\Ü\ä1Š\Çkı*\å\0>U\×zQ¢u‘HÃ€sYM[§\ê\É\ÑĞ‰\ãü¼6>f¹Î­¦\Ë6]\÷Ck>\Ğ)c\ß\áøj1c\'\Â\ÙùT˜\Ù!©[œŠUİ™hŒ\ña€ü@z|\ê&Ì®W9Á§\â—z\àş1^„û5}«ºƒÁMj\Ş\Ö\êy5N—“Ï§9\ÜÑŒş(¹a\Ï}V\èN¹\Ñ|I\é\Û]wA¾\ò\Æ\åK+¯u#\ñ+\ğA\à•_\å})§aÚ€#`Œ\ò)DæŒ|\è\ï@x¥)\ömšoq\õ©˜ùRHùR\n\ôAX\ç½#\Ëa\ïI\Ø\Şæ€O\ñ£1şt¯$Z&ƒ¹¤•\Û\Æ)J¹¨Ç¥\Ò.X\Î\Ügüİ«\â\r\ÙM\"\è@Y$HAÁR¬+\ìp?Ò¾}ø·\â\Ók½Ux1[}©\"!b»‡\Æ\à>vœ\0<d\ö\ÆG2×ºŠ\çP{xc\Ù\è\ë°I¾^`?\Ä8\Ï\ãøÔ¨ºRF²—R-\Ä\"]\ÑF˜\Şc½*n\Êz`7qqY«Íº¯ßf1Aj†I¶T°S´1\Ë(Àíš¯\ÒnµfX\í4 bX#mùq\é\á?\æ\ãµ\é‡»N³Ò£»SpK	\î7µ@<\ï\Ï5\ì~—\éW\Ñü©b\nK\ò\Ç\Ê*Uq\î/Ö·6šE·\Æ\0\\Hvw\ï\Ç\ç\Åv.‡\Ò\Ã%¿Ä‡]²E¼\Û\ëÿ\0uv§tı:\ÉáµŒ[ı¦è›O|ŸúÔ»‹(­b#§#sI#~¤š\Ï_\ë—V*\Ör††&\Ş\Ò\ğ\àwÇ¹\ÆqY;+›}+\Îh  \\\É\ç<³gÕ½{\ã\òªNÿ\0Î¸šV,¹bX1\äo­d\õKH\ï\ÒBØ’3\Ë\")9\ôÿ\0sıs¦Æ‰8\ó#T`\ê\é&r\0\'°Á«m>İ„¬±\ïv8ÜƒŒ\Ç\èjm•„\0\0Æ¡sœ¸s\ëYÎ£\Ñ!¼“\ö\Øi@ ²H=úwª[It¢°:K}Àı¯;‡\ÈûıZcV³¸‘†‘>#’++u¥I‰-³‰8nXaO\è\åü\Åø¼©7p\ÌqŠº»²†\ê\â&‘HŸ\Ë\\\äqœw5\nÿ\0¦\Å\ó1¨\Æ>$^\rdu’I\0h\Ã>8\Ú0¿–;~uŒ\Ôú\ßûE\ó+•\ØûŠ\ä}¡Gc)›\ÉtL‡pªk‘\ë6_wŠ€½j¡\Óş$do\î¸\0\ñ\Æj\âĞˆ‚;¨eq†\à\õ¨\Úù7Lƒ!O§jˆG—!9©6\Ò|Lnùµz[\ìo\ö‡¹\ğƒ­\áÒµ\'y:wV`œ‘‡€\ë\õ<\Zú«it—¶°\ÏYFAS‘Š|\ÇÚ€•³>”´Ş•´{P\ò\è\Ö O$R¼¼P\Ù\ó¢\Ø=ªsE\Çj!$§=¨Ò’\ê1M\ìŒQ4#\åIÛŠI8ú\Ğ\İ\ïD\Ç4@\ç·Y>\ô 3\õª½^\ëÉ¶•Ä›,@ü_*\ó—=Ks\Óşkš½\Åİ¼0©\ò•Ì¥V\âg!J(\ãqQœsû¤úWÏ›Û½\İCq;\æ+²€\İWVº,ú£\É=¬¬°È²ux\ÑF\\œ\çoü€ªŞ¡¸\Z‹,\ó\í³²X—daIa0XŸA‘Û¿5ˆš\êMkT	ùk·`!0ŸB=I<\×Q\ğ\÷GŠ\ÇXMf·\Ã=Ä¬KnÜ ªz1]Á¿#\í][ ú~ç¨¯¯5$-s\åJ \Ì3—\n¤\à\ó\ó½G¤i\òO¦\Û\Í#4Q²äƒ–$c·\'\åZ\Í\n\Åmü\Ñ\n¤Š\n“…\í\Ø\ó\ï]/¥\Z\Ê\Ó\Ìr·6\ò1‘ŸS];N»ƒQ\Ü4\Æ1N\ØÔ’8\í\ÜR.o\'™¦{„	n™\æ¼^}\êŠ\õ\ò6M\ñ[&\á•\à\îù•fµ>.™mDU\Z.\õw\ïÏ¥D¹Ó£$B	l.N_–>¼Ò²ĞŒ\å¤m†*yldúúVs¬4ˆ®fV“qvù`x\ÈÉ¬mµ¸…\Ö6]€\äOJ–bı )€G\'ú\Õf¨¥/$d;¹8çš©–\0fv10%3Ç­C»\Ó7\Æ\Ã\r´\íT\×\ZdJ\èR2\÷¤E¥F$Á\Ëg<1ıj]•ˆ\Ç\ì‹y>µ`¶\òE\Ş5=j>¡¢‰>$Œ·Î²=E\Óp›v1\Â|\Ìs\\g®:}\î-d·‘~\ÍyŸ«t¤²»™\n…Dr€¯$cX\Éb\ÚO9¢1)Lş\\~u&)§º·%\Úh\ça$‘·\ï`j\râ˜®	p=Á¡\'\Çuü*U\Ó\ì\0\Ø*O\î\×\×±§ŠSx‹\àş™\÷\÷2jV€Á$Ÿı¢©Â±ù\ãß‚dR‚\ò)ÍŸ:=¼bSøR°=©J«Š#\Í$ŒP\ÅN\Ï\ÃEŞ‡zK#M´gÖ‹hT‚‡<Sn8\Í7B€\â@¤Kœ3\Åd¼G\Õ\âÑºrf2\ÇnÅ‘ZY4\Ï\Æ\ç\äªÒ¾jx\÷\âıç‰·±Å¦8¥3GggÅ·\Ï#¹-1\ÈP}\Íq\äc}4–\ÊQŒ’JX’Tr@\'Æº™yJ\è\ò\Ø4…–ş\Ù$Ÿk\ĞÁ¸‘±n	\ßSXNªÕ¤\Ö\ã\Ã\'‘#Ë ~^\ç\0\òI\ï\ò\È\÷¨\Ú=Œºd\ïÖ\÷¡‘’¡€o\â?Z\è}+c%¦Ÿsyun–\å“Ë\\a\É8<W«ü\é	4\İ|Áå³»…f\'<üù\Æ+»i\Zyş\î†)UY\Ùp¸(«\í;IKH\æ)\"—l­“¦Dr\ïvrvú\ãµot)\Ş7\0*F[¿¯\åS\õ]M\ÚÑ£š8’İ€\Æ»g\å\í\Î*º\æ\Æ\Ú\êİ£\ód\Ë\íÀ\Ü8\'\ÃU>ƒ\Ø1\ÄNS<³\äd\åŠ\\¶p\ÛŞ«¦<\à7dH$~\\ú~uYª1]ÁJ\Øıeµ\Ù \ÉgbNO\ô¬¾§\"\Ê\ê\è\ôÿ\0\ÌqÁ1W\É\ï\ß*d\Ú8•\×il)B\Ş0\ê²n\rå€¤•T2\Çj¹wü\\‘Ú¢,\Í\í\áy\ìh\ì´\è\ç™w`s\ß8n\ÚThÀ‰Kw\ÚÔ‘¦@e*\Ã\Ìvü$\ò*]¥¸-”?*¤Õ´¤@\Îš\ä\Ş!tüw‘\É\"\'\íq\È\Î\ã¿,\Z\Ú\æF\ò|¬¹\'#ÿ\0Z\æ\ÒÚ¨ˆ\È’*·\Âì»¾ø±ù\ÑÜ§—\Z\É!\İùTU”³\í8\ã\õ¤\İH\á“¿­.Àn„r?­*(Š3¯¨Š\÷G\önu´\ğ\Ü\ë\ZD\Ï4>sÁ„–	ü\ë\èT2¬‹‘Ÿ¡S\á3È§\ñ\ÍLÑ„ Ò¶Db\Í\Üw\íDÀÔª;\÷«1½’(š3\íH\ò\ÎhŠsMù\\\Ñy_:<z\Ó&/JI‹\é¶Bn);>t6|\é¹p8\'3^<ş\Ğo\ït.ÓºwNqÖ»4©/£-².ŸMÄ\ô\Í|ú\Õ:k2\ÓE\Ù“†y¥EÃ™\n…\n}ªª|ŸZ‘¥ÿ\0\â_ø\Èˆ—UTc\0û\ä\ò\áe\ô·63ù\Å\ÚW œ\ñ³‚\Ç?>\åU+%\ÇPjA²<\Ç;Qd8TA\Ø}{\Ö\Ô¼Ô¤••Øª»ø;\ë]{\Ân†nµ\êH-\Z\Ó\îú.–Ÿ|½¸\ñ($<,@\Û\'Ò½u\Ñz\\—:dP\Æ-c}ˆ‹Ñ¸O\Ï>\æ·RA\'š±,j€r¦®´Ø–0\ØÕ¯š\ê?\Ş6\Ò9T8şUccª\Í<©€e\ì$#?>ı\Æ*\Ê\Öÿ\0\Ï	…-*c¹¹Œ\Z—k¬}\Ù\Ü2ÛŒp¨\êC{\ç±£]jrA\åş\ÕN>^»~•	µ1q3·Àv…8\\ù\ô\õªOT]Ø„|c‘\É8â²š\İ\Ã8,H\É\ç‚?JÍ€á‹~,\ã\çLw¸EC±·d\çŠv{ÿ\0¹J\ÊÒ–fï³W]\êBbU˜û&}}ª†û\Ìm\êW¸\Îi¾4{c\Û\ØR­uB\Ä0>•{gñŒm£½J{¤\ò\Â+n#Õ†\r5	\íQÕ¾İıj5øU‡\Ì\Ëw\Í`z½bŠK|\Ë	\Î\æ\õ\ä4&¸Ô‰¶‘Œ*m‘‚Œ{?\èW½•\Z\Õ\áa8+ƒú\Õ)Qo8$dc\õ\â£\\Jd\ö\í\ò¤\Ä\Æ7\Üi\ÙbÈ®N2y¦m˜yû³1R¦“\ö„\åq^©ş\Î~§·\Ñ<q\Zu\ä\÷¥«Cj1\ğù\êCsÿ\0d8¯ªŸlKc €úÓ…p¸a86z}©¶+<³íš´	\ïJ#E\ô¢\ò\èŒ9¦Í¶9\ï\ò¤\ì9ü4–Lúb›)“œQM4\ÛÅH\ò\ê%\è)²Œ²‚@¯“ÿ\0m?.:‹\Æ]b’dŠ\Ê!d!™\ŞÀv\ç$gÁ¯8\Âw\"\åÿ\0\0*ÿ\0?­]\ßjP\\F±¦C.\r˜\÷\ïO\\\Ê!†8¢2Iû»K£åŸ\ô¥\è0\Ïs¨‰IV\0\ó‚Ol\ò®©{Ó§\ê‚Pı\Ş\Æ\Ë\ç†b»\ËzüDŸ\æ½S\à_L\\\Ø\ô\\J‹%\ö¦\í¨\\\ÍÀ,c\İU\ÎùzCŒ\ØZ\Å\n\0@ı}Mh\Ò5Ú­û\Äg8¥y\ñ \Øp\ß¡±L]\Ú<œ¹\ö«6’(V3´\à\0\"ƒ\ÜA:p][9^üªLO y¢›Ë‚	º\Ê\ã\Ü\ç‘\ô5Qª\ëV~cÀ±\Ë6Xaf\É\Çsœv\÷¥]^\Ù\ÄbQt\à¶D¹\ÛÇ¯|\ğ\åP/-ŠÚ‹‘ut#\'†1\ë\Ü\ö¬­Ú¼—-‹¦’F\åCv\õª\á\÷Û•L\\¢\à\n\çú\Ô\È\í­bY\÷L\áW9\î\É?¯­F•¢\è\ê\ÙQœ“œŠ¡Ô§¾\í˜\ËTjz%U°G<\ôq_¬1fU\ó\Ûu-¯\ã¸;‘|°\áSš›£j±á˜Œ7`3VW·%\ö„>dgü\'¦-\æû´‚•\Æ}p.\òE¿AŒìƒ’üª—TMa4\"˜S´±\É<q\é^O\ñwNÜ·´”BL\ÃùzŒ\â¼\ë®\Âm.\î-zg\åú\Õ@p‰\äz\ÓJÓ•4†<3E,Œ\åqùSQ\÷E>\\°\'±\âº€F:oÄ®’\Ô\ã•\ÄÖš„r`mÀ }A5\ö\æ\ÆU¼±†u9 q\Çpj@\"œK~)ÁŠX…qÚ·V\0F-\Ô\nl‡œS‚\Ò3ÿ\0u&$\ãnhy&Œ!Z\ÇÖœ¸\n1#µ#\ËÁ¡\ä\î¦Í¹&›kb)£sIh\È\Åˆ\â\ñcµb<_\ê\è|>\è[\İZ`¢\\m„1á›’ı!\å_º\Û\\n¢\ê[Ri%¸7—2LÒ»d¶\æ\'?Æª­”#yŒ¸QÂ¨\ïš\ç\Ï\ÆGn*k\Üy6e”\ìp	>¾§ú¡­‡Gi\âûH·¸”—•L\ÅW–?Z\î}=£i‰2_\ê\ZŠ\\K4Û \Ò\á\Ã>\ĞÜµ\Ç\ÄBz\í½1\á-ª\ÜK$‚\'Š96\íV\ÈØ€aTs\Ï»\\\"\Æ?{½My@T\Ç\ÒJK\à\óM]^<.60}…7¢ğ²²»+Xy\Í.=F\ê\ï»¸\Îşù\Ô\ÑzfU9pv€xùœ\nb\ÛL¶¸c,q\ÌX\ç{\ğ?\ö©—Ë¦£	LA£Â®\ÅÚ¹\Ç\áo|V{Sº[\ËU\Ë*©8†ø±\é\ò\ÇÊ©e¼¶U\Ú@Wü\É>\Ç#½&\ÂV–@±G\'\Â~ b\á:e–3˜ZA¸À\ä\ñBIgT\'\É >1\Ícú‰c\ç\î\ì¬‘†?;\âcˆ4\ô\ñ3¯Á!e\÷4”_-p—û9\ÛZ•@y\È\Ú\Äâ¯¬5i£ƒyO27\÷\õ\ô§\ç;™\÷Ä¥ ,¥˜\í?5^H¼{\Â3üª¯w\÷˜B\Ä\î\Ğ\ö®â”nŠ\í·\'wfùz\ó7St\óK+\Ç\ğ\ÅvX²G\éŸ^\ã‘\ÂA\ô>•FÉ£Fıi2\Ì6ş”X€ƒ\ñ“\Í;\'À„û\Ö\Ã\Âø¦~¨\Ğ^\Ú!5\Ø\Õ DBßŒ–.>x\Ç\ç_rúN\ô]\ôÖ›9]¡\í\Ó)\ìq\Û\ò\íùU\ìCÏ §n\â•À\ô \ZŒ>>T\Z\\Sf\à\ò .‰\Í1a“Á©fX\ÃF3Nˆ›\Å‡¨€\ô£\Çj=´6ü¨Š\ÒL6\ğ\æ˜{|úR>î¸¤`£>•ã·‡^MM\Ş\è–\ä$²F¶\Ñ3iø\Îd\àrIP£Ğµ|Æ¿k+k‰QA¹“Ğ¨\ò\ãS~2};\â™ß¾)w\×Œq\Ü\ÔH\ß\ö\ÛGıš¸[Gy\ãó°±¤BS\ê0qükw\Ó\Öm.ª\÷ş^\Û{x\Äe\ñ\ğ\î(\0\Æ9\Ï5\×ü?\é˜uk\Ø\'·\å™[tª\ç‚8\äÎ½§Ğ–Q\Ú\ÙÀ±¤JJ‰Gn+|p\ÈCü{\ê®o1§,€x\Úr1\ó§c5;{z·<ŸÎ\òl]ùø\õ¤\ÙF—24‡cL!<\ÔûB©\ñI\Û\ö`³ 5.\Û@\ÕºFı\ŞX\È\0|\òG8ıir\Ù\Ü\Èq]Hş)V!ƒ¾0x\Ç\õª{\Ë)‹KÀ@-\èÃ;\ë\éP’x\ZEH‘?Œ¥‰\í\ê\ÇµB’\åbY¾8\Ğ\ÙW9?08­\Z3H\Ê\àLƒ·\0R\èpTnÁ#\éM\ŞÚ½…1\Îß‹\'*\ÊOg$\×-$€vøH\íòª»­&y$r«¸¯?‹şU]\÷;§?D7jŒ\Ú}\ÌO!d1ƒÙª±J\'@O˜I\ã(N*\ê\Ê&‰s,*I\ì\Ù\ãúcøÓ²\Æ\Ë(fG»d¥*GXX+|»G\Ç\Ó\Ì\É(lˆ™\óœpG\ñş•\Ï:\ãN}B)„ø9ü@\ò>•\çÎ¹³;n\äš3+’<\å„vu\õ¥q¬€-ş\ö\Ø|Á¼IÀ|\õ“(\Ø\ÎE9\ô*3–¤´µü[©NK£\È\Î+£}œ¬nu_::\Â\ŞPŒú­¼\Ù$l‚3\ê+\í¶ƒb`µC$aH\0\0£\å\ßşUs1‘\×\ÔsRW qŞ9\ïCµ#$“šm\É\Ç\Ógµ\ÓF\Å_\êº,šc$ºx$3ş\Ò~\â\\²T\äú{P\ò\ó\éDa›)\Í\ô¡‘\íDy=¨ˆ\r\ÍJK ›\n›°Xc\äj=\ó,;±\nŠ	\É\í_%¾Üq/\\x‹«5›ùúe…\Ò\Â.™\Ø\0O¸*\Ä\ã\ÜW”y\÷ü(;ûŸAOÜ¤\Âc@V\õ5{Ñ½y\Ô6·šš!k\\‡q\è\år£øRï´£\Û[À·—\ğ\Ésü+S¥k\Öú-Š\Úa\Ø>Lˆ£ˆÿ\0Z\î¾\Zkp\ë:f‹i¥\ÙC¤Z\ÙÂ¦\òvc\ç_HNK7\ÈvÇ¥{¢¦ûİ¥»$e#\0Vù %G¦ECk&y\ÆØ—¶X\ñŠm-d9Á\ÇÊD3?\í¤Û‘€qVšN#0	¾]G?¯j\×Z[\Í1\ZG	ˆM¿2£½;¨\ô\èºE†\æ¸R\ãr\Å*\îXÊ¨\õ™¶™`A¼da•ùd}½;\æ²r\èû³?\Şç”ŸÙ“\\n\ö\ßÓR\\\é¦\Ú”\Ş4+\éufo¯U,W® @\ÌyQ×\õ­\Òú*û\î14\ğEŒ»·K!.G¾L]=H­\"«pUX\ä\ÕuÎ†nW2?š; ŒÎ¨¯zn“tM\nsƒ\'oÊ¢u,l[\ÍUÏ \æ¡\ßX´¹X°OùG5Sw§ª\ò\Ê\ØsT«e\Í ”4n§ŒqM›(\áø–4—ü\ÎH?Â”Q.\æ#\Çv1I‰\ã³9–L¹8,É\ß_ù\Zv\á!TF \ÆHUÀ\Ï\æj‡R\ÒL±\ÈT•BwnÎ¸§ˆ-P\Ì\÷6„\Û\Ê	ic;Y\Ì·n\ry‹\ÄNœş\å½\ÄW?~µ?¾Ò¯u”üıG=\ó\Å`eq\'\éD§\ôRQ\Å8\Ê\\\Ø\ni2‚€0\0\ã\ç\ó®¿\öP¶š?´]TZ4\ö6\Ó\Ì±?Ï¡%@k\í‘©6«D\áRD™WÖ®#b\Æ\Ò~¦$\nO\Âz\"E\'\"“)D\÷¡½­q+1\İ\õ¨¬ƒ$\ñM4c¸\Ë&Oµ!£\ã4†_•\'e.‹\Ê4E¢+œqE\ä«z\n¥\ê\ëhd\é\ë\ï¼y…D,ª±±’1ü\÷¯_j\õ}?V[KXc²\Ò\îf’{xPV\òÑ·w9€X\÷`\Äp\ÕÀ4\ô)o,Œ/l’94\Å\äFH\ÏÀù\×I\è-\×©Z\Æ\ì‘G9y™XŒª·ÏŸ\È\Ó:ı\ê5İ\÷u	–üM’\Ç8ü\ê¯A»“\Ë;{€>\Ã\n3Ü’;W£¼±™lCGnÏ¾P›œü\rŒa€\ï\èy>üW¶:\ÖH\ì iQ#8\nú\Öş52p¿#ƒÔ¥Ò²Jº\ç<™@©\ö\Ú,[@MÀún\çŠšx—\r\"sœ…Qü±\ëV–\ö­´L²\ó\Ç\é*\Ú\Êh\ÄN\ÌF	Û°q\Û#Ò\æk\0-$›˜\à(E\Î!Ú³W\Ñ]\ê	#Ep#\ÆB†A—Ç©\çÃŒš\Í^\Ú\Íæ°eip]¢\Üv<g\Ü\Õ3X\\\ÂZ[I\nW†AÇ§\÷©:\Üûœ\Ïn‡?€\î\Ç<ü«Jš<³¸HgGtBd\n‚=rNOjrß¤·\â+‹´ˆ.Œq’ÇBÒŠ\çA³µİ²)&NÀ\È\ä±ú\à\Öj\÷K‚yE²¨\É\ÛşµWpR”„Ub9\â©gK\ëúŠ«ºs’F>µ[ya¬j¹=\Ûÿ\0*‚\êş\Èc\ĞcúµFY€\âø\ÈÀÿ\0Ù¡G\äl\ãü¸]x’’IŒ‚q„Ÿ­7\ÌÉ²hÀQ\Î1\ëYŞª\Ñ\í\õ[WŠO\Ù\îR¤À\÷¯3xÁ\á£C$³—•Ù·—¸¨\ÇcJ\ón·¦É§N\Ë\"2\ç•$p\Ã\Ü|ª´v§½»Ô¸°\ë¸\åqI9w*£Œq]¯ì§ªÿ\0uxƒ.†\â\Ş\æH\Ö{U$4ˆr¤\ïÈ¯¬^\õ…¹`\â\Şv•c9À*\Ù\ä;WDû\ôj1¸c\ß4\Ój–\êNf\êj<šÍ ›•\ßp¨r\õn•\ÚÚ²Á\İ(ş5\ZN¾\Ñ!\á\õk1\óó–˜—ÄF\Ú\ÚÅ¦ÿ\0a(ÿ\0Zhø›Ò±¶X†C\í[ù\niüY\é¢J\Ã4\òã¹?ş\Í#ÿ\0\nš1ü)vGÿ\0t—ÿ\0†»»-0\ëšF\ÊC(4Ë®\r4Wš.(\ó£À\÷¢*=\Å(lÖ«º–\Å5]\öÄº§Ÿ)Tä2?:ùGı ıMu.ˆlm¼‹³\Ò\"¿\îÂ¢’~€\äıG­y6\Ğ\Ç„C+¾I·«.\Ñ\Ç€\î\ï\ò5Sq)\ã9<¶r{\÷­GNuA\ÓZ\ñcı“L :€6³\Şù}*¡~\Ó8g“\Ì<•\Úp«~º), ª\í”üışxı+\×>­Æ³-„M\Z\ÛÂŒ\"„_s^\Ø\é\İ1c¶Œ0^8­\" Bª8\\\â­#‚d\Ü>u%&d¡±\ß\'4©&eˆ$²í²S# T©\0(6Æ²|9$ #\ëJI\Ù-\Ğ\ïA|\"\ä8Úµª+F­œ0¶~G c\òªùo¡»WX· ;A†B\à–	>\Ü\â©\ï ‘nHÊ»\r¥@#“\Î2q“Ï½B·´Kbû¼­»C\ç8©Š\Óİ¦dT¶\'px\ö8­œ\ñ\Í.\òv„7\ÃÇ¿n\ô·]•QŒü]‡¿½P\ê7\ò\æDE;cÌ“\\ûŸúV;X¹y-\É\Ş<o•e\î®c’@²HËƒJŒR¤º‰!df_p@ª\öÜŸ.M¬sƒB\ës\Å\Z»	®\Å?\öısU1ˆT2¤{\Ïrx˜mS\Ø\ì?Ö¤K¢¡¶q\õ#úS\r§‘P\0 s“Úª\õ})ˆ%#Y\n\óŒcùU$\È/\İ\Ân\ç\â\Íbº\çDY\É4rd²±h£\\8\à|\ë\Çş)\ôş¯+1ø‘x\0ı;Ö¹+!V \ñŠ.Æ±$Ôˆ[Ê‰\Èül0\rt\ït\ô·Ô­µÛ‹¹-,\ô\ë\Û¼‹gxhÜ’J)<\ão~\Ü\××¿~\ÌZf¨jrgR\Ş\ì…Á\Ã<\çnZ\İK\à?OÇ\×\Z“\ó]¹\Ï\ñ¦Çı-{Y¤ÿ\0RhºG\Ì\Ştˆİ€\Æ_\âşu*	ºR\"1¡Ú’=Lc\áV6\Ş\ô\Ôg#Eµ9\÷­\ízA‹4{E(…\\[\ô–˜£\á\ÓmGÿ\0„*\Ê˜±\\b\Æ\Ù~‘\ô©« […m\âQ\ì#\éT†jm¤\Ô\nA”{Ö›i½2\ò©\îÀ}i™%_\ñ/\ëL5ÂƒË¯\ê)·\ÔaCƒ2\ìX­1&½b£›\È@\÷\ó%z‹Oÿ\0øÈ\Ñ\Åu.¿ıj3\ôni™z®Á\"p\Ç8\Æ\Ò¨W½Oi$[_\Îm\çnÁ\òùW„¿´w§e\Õ:CI\Ö- º6¶L¬>\îÁdA´±#W\Ç\"¾v=\Ïû\ò\ë†*p\0^2$Ï ¥#•˜d“\ó§eo‹ZN„‘F«—˜“<§\ò¯ \ßg®ckp\ËW\È\÷¯U\ép2\ÅWA	 _\ëVq[°„´–ø#H•\á†0Uwû\ÍG“U6ÿ\0%°1µHşU_.§,Rn|)\ö\Î>˜¨ÿ\0\ß[U\Ù.[‚\ŞXjh\ë\×Œ\äù@€&\à\Ô\r	u\Ô6ë›†fQ\ØÆ¨ECÿ\0hƒyc\Î\r¸\ì\å‹0_Q\ò¡©`\à±\ç„\'˜½\ê)m\î\Ôù…[<ªju—S¬R\î+0N\÷\öü¸©w\\²8\óB0s\ğ)\Î\Õ\È\ïŒ\óü¾UA\Ô]`e\"\rÅ¶(´\ñ\ÇlV^ÿ\0W\ìwyÁA$y`r+\'ytK\î‘\Ë@{R#Õ•“\Ë\'hùT(µR—l3½³R©’ş?\æi›\\(\î{ù\Zn¡x\ö»‹û.­Y\Å\Ö%cª\ÊI\ì\çü\ñOË®\Û](I\"…œ\ö2\ê~y\Æ!N‰‘UB\ÉG8.	aÿ\0^•]©\Û,ŠNI\È!	#ü¿\õ\ïYMOL\nŒ“ ’A>•Ã¼O\èU»Ieˆ\ïŒ\r®¨1¹~u\ä>¯\ÑN‘«\Í‰\ã]\Ç\nÕŸqƒJÿ\0\ÍÔ›u/\ÆF}+\Ó\ßd¿×®.u³.›ÕŸaq{ws9bX\ã¯\Ä@’=}¤\ğ¯@’\ÇÃ®š[€\Â\èXE\æ\\J‚G\êj\î\îÏ“\Õ]5±¨ÿ\0uæœ\ÔûT\Û{2}*\Ö\Ú\Ç=\ÅY\Û\Ù\ÜTÄWÒ•\åŠ\Ä\ÅÑ›¿¥v~…G\ô©I\Ğ§—½¾ÿ\0Ò_4\Â>7»\ñNG\ò¥/‡\Z<\Û\Êÿ\0\'\Ï\õ¥Ÿú|\÷\Ó\ÔıY¿ÖŒø}\Óÿ\0ÿ\0,ˆısM\É\áşŒ&ÜŸš\æ \ÜtnÀÒ­\ê\ÅW\ÜhV1\Éc‘ì‚¡Kan¿ıZ!\ôALµ¼h¸X\Õ~Š)±g\ğÒHH+„R \ç:\Çx\ááµ—Šj]3wa\÷³xŠl8BÛ»p@\ã5\ñW\Æ\á\ğ\Ö\÷P\Ò\ïa¹‡W·¸ÁIÆ¨›œ`9\áT\î\ìwzW\"\'c\är=±AO\Æ}*TH$„n¶şh2\Ş\ê%M»8-‚§\Õ}E}C\ğ+£ÿ\0ºzb\ÉW,¾P\'x\ç•\Üt\ëeE\\…lü8\'\×Ò¬#1X\ğ\à+\çœ\÷¦&\ê(|·C\"\á\Ûi…\Û\óæ¨®uH\×2ÄªÎ„~b¨5~¡KX±\æ\Å“Œ!\0şcIq\ÕşJ––P Œ|ısü*’N©Ie!\ì\óŒ\æ—7U˜HŒ/\Ä\Ün\éÑ¯ƒy1\ß\'2§³\Ü\Æ\î\ÆU]­\ğM\Ù\ë\Æ\ê`Š¸\0\ò\ÃÒ†¡(µºYCi\õæº\Ö\ÖÉˆ/½Ï¹Éª\ç\ê;²\0\ê–\ï¨\ÆIVd\Z\Ï\êU·y \àdnS\çı+9{\ÖH	\Ã7ı¦ª[²mä«‘\ôjS\õZ\Ä\É\æy˜\àù›G\æj¢\ã\Ähm\\;\\\ç€\ä0˜æ«µODP4‘\'œ\ñ‘\\úú\Ö]\ñ\'\\A¾³DŠ\óp*\Ï\Ë\â\Å\ÌM\÷¬Vl\Ç\"$F#\õ%‡\ç\ÅD´\ë»\Ø\ï\ÒA{\Zm\Ãª\ò™9\îT\ÈwŸ‘\ã\å]ƒ¢º\ô\ßİ¥…î±¦X\\8>M\Ôz!@\ìO\Â~•\èH.o„Sj0J6Œ\\\Û/s¼ŒVb\òùœf\å\Úy¦\ÜT¼{BƒÛ·•¼¶70eÜªFA¯9}¢<9û¥‘Õ£Aœ\ó\àW™d\Æ~tkøiûbwı+\ìG\ösø,šwÙ–w\Ê\ßuŒ²‰¦\Ú<Å€\Ê\Ğ(ÿ\0•qş*ú²[À‘\"\íDPª\0\ì\0¨7–\à“\Ç\ğª™\í\Æ\êŒ\ĞsÀ¥\Ç5cmn*\Ö\Ş\n–£…FŠ\0 S\áqJ¡B…¦\'·Ynj’\òËœbªn,€\Ïkp=*1‡\'Š“9\â­a€Â°\Ïjù‰ı«~\rKe­i\İw`­•\çş+uP?h1‰?01ÿ\0dW\Í\×4Hi\Ïoj¶\Ñ\ä)* M\å\Èâ½¥\ög\ğK‡¶¾š/Š\\>[\æ½ß¢i\÷XD\Ö\áQØ„ÁQ\íM\õ·U_tÖ’\ê kÁ‚®‹½A\÷\ÆA\Ë:ƒ\Ç{›5T]\Ä\ó\Ì0\É\æa\ã\0·?*\Â\õ_-\Ò:´v×’O%ÉŒH\Â	\Ñ\÷g°\È?û£?Æ«\åûC\Ù\ÜF\Â8§\ËFdM€úÇ·\ñ5ƒ\Æ[«\ÉJ\Ë*®\ïŞ‚S0?Rı)»Ÿ\Z\İ\ò†d\0Y~£#øÕ¤,Y\Ë\ÌqGU,\ì$ˆ*\ã\äıj\'ş4\é?ú=\É$şş	\"§\Å\âL3Á$+$\n¹*G\ÔUŞ‘\Ô\ñ\İX$¾p’B2\ÈS\È¢°Õ¡aRrI\ß©\÷z²Ij$V}\È\Øø\ÍT\ß\ë†YUÔ³``\àUM\×V ²Hm¸#˜¿\êI7|\äú\ÖKV\êøùœI#\'š\Èky%²Ì¡y\Î@ÿ\0c\õ”V\Ö\ä ²I¿ù\ÖJû\ÅK¼\à\Êÿ\0¸#\ôŠ¥¾\ñ\ãQ9‘\Ã0\àc€*²N£a#1,§;w¤\\\õ\Ü$_\âVmÁ¿•VK|K`\í\çÔ\ô \Ô\Ä™\Ë\Úp\È:\Ñh}gp²,o;Kş\çbT}>w.ˆ\ñr\î\Å\â\ò\ÊÎ€luŠ8LpJ“‚qó®£ øŸ§\ë­“>%BÌ’K!\ÉƒŸ\Şş¯JTK0*ƒ¹ù\ÕW_tÍ¶½\Òw\Ö;\ÒMÑŸOc_?:ŸE—C\Ö.m&]…HªÁÀ§ \Î\ìŠû\İı\Ş t\÷ˆ_gNµ\Ğ±¯MXG¥\ßÁ;\Éxª¿t\ä°>\Î=A¯QL\\G¸U\\\ğ\Ôc=©q[\óÚ¬­ \íS•qJ¡Bˆ\n:(R\Ñ+\ã9£\×\ò¦.!U\Ü\Úpj¦\æ\×¨-\r?k\Ä*\Ş\Ú q\Çj\áŸna\ê\ï\õk¹4\÷\Õf\Ó\İ\Çlƒ<…e\Î=@İ“\ò\ğ[U´kK\É\"q±\Ğ\ãZƒ\ö„\Ö\çÂ“ª¼@\Òt\Øø\ó$\03\Å}I\ğû¦\ÓB²±µ·µq±—“!F8\ôe\â/‹K\Ğ/*G©¤º¬ªLqÀŸ\ó\î~ƒ’k\É=O\ãŞ«<‘jW\Şe\Ø]Î·\Ğ4“/¾\Õ?\nş`\Z\å\ï\ÖW:ş£4Wš\Ú\é¶j¸A\Ç,Pş\İşuI}×‹n\ïm\ä/_K/ûQï“‚?*¨—«7¼M$·2(;ù\äR\ç\õ\"ŠÛ®¦W‘’gY	\n%\'t™\ÎpO­±\×R\Ê\á&¸IZ<\î%\0-\ÏT7ıwspÛ™‡\0äúù\Ôxz–\õ\İZ\Ù\Û)\É!\Î1\ëM_Yxvš{@]¢FødH\à‘ş•\×:C®.\î\ö\çv\éHU9\î>gÒ»\Ö\ÂcK¯\ám\Ù5}q\Ô\îa\\8\ä\îÿ\0*¢—^’\Æ%3IOÃ–\àıbuÎ®œ9ı»6[$1È¬¶¹\Ö-¡Q)y\Æ0?Z\çz\çX\\\Û¼ª¤Œ‚»\õ‡\Õz¢\ò\óv.ú\à±L¦k;>¥#/\Å#O©\ÍDû\ì„Œ\çÔŸÖš7n \÷\Í\ZO\É$§½?\äGÀûz‘J‰‹~!\ó&=ªx\0|°h\Ø\r\Ã;”\Ï8«:\ö\çM•|Ç‰‡Ã´vü\Åoºk©\ãû\Ä\İa\æÀ)’TŒw\ç\ç×½zG¡µˆ\õˆ[T†%\0y’f@>Õ²–LÀQbgSİ±ƒ^/ûM\ô\áÒº\Ï\ï+g^\ËØ‘Ş¸¹À\ïùS\Öüb¾\Ãÿ\0ew†6øasÖº\×VX\Û\İ\õAÀÒ\î4X£ˆBÀŸ\ÆpOü,+Ûº‡‹}¤\ç\ï\İg\Ó\ö„sû}RşoY­K\í=\á˜¬n|H\é„¾\İRÿ\0\İcY\rW\í³\à}€\Ëø‡¦M\Ïÿ\0UYf\Ïş\Â\Z£—\í\õ\àTyÿ\0çºŸ¦Ÿs\Çÿ\0\ã¦cş\Ğ_rù\ã!\0\÷\ZU\áÿ\0şU6\ßûBügTÿ\0l\åBx´›À?ÿ\0Uu€ûCxm\âŒ\ŞOK\õ“ª\İcq´Y\Äw\0{ùO‡\Ç\Ï\Ğ\Ò@\ã*A\â•B…\n*6¡›k%\Ä\î$%`\ÅH\ä¸Úˆ6\İ\ëu§\İ-ıœs§f\'§(pi	†Nş\âeYS \ç5YwoŞª\ä·\ÃS¶\ğ\àÕ½¤8\Çz¶šš¶se(\r\ñ˜\ÜÁÆ¾ı¶¾\Ïw~u“\ê\nl/.e†8‚\å”\Ç|q\Èæ¼½l~}\ğk\Òb-=_\Å\'º~R\ÚÔqO½\ñ\â/YG\á\÷GO©D\õ_.\Ú2ÀB>•á¦\ê\İR\çPûÅ­\Ü\÷W°\÷·\äø„`ŞœV\"KiZy¶³\Ï;\Ò²¤ıj]¶–\0ª\ö\â\ÙßŸ…~>y\æ²3\Ëq0Vr\ì£ Tc«Lˆ\ñ0\ó<\Ï\ÄO\â#\Û>Ô›½H\Èc6\ĞFĞ¸\ãiµ¸‘WOš\ß\çSW?y¸Á[²“\ÅX\é\ğ´p¶øĞ’8\Ú~!Rt­*yŒ‡i\ì+y£µÁ…e\Ê\ásÛŸ¡®ÁÑ–\÷PÙ©œ\áO\á\nı+ \Å$&É„›‹z`Ÿ\õ—\Õm–w;Y˜g…b[¯oÊ¨¯mk$\Ü\íX~\ßÉ£_‰}>uÎµ[f\ÜF›s—f# ?\çY‰´Ë™IeR\Ã8\É$\Ó+¡\ÜJ\Ç(˜\÷&=58UÁ\Ã{\ô¬\ò0Ì¨ûûS\à\è\Ès‡¼\İÿ\0gıj}¿E\Ã!Y%}Í€?/Z°n“´¶…¾Lm	ÛŸÖ¦\Å\ÒÁ Ì›v\ç¸ù\óPnºb\'U”;Áş´üp\Ñ/–\Ä*’¹ü…N±\Òf°+\î§rüA’ù©Wu\ğ\Å\ËÚ¥\Ä\Ò\Û$˜Ù´º«c\ó®\Ãi$w¡W\ÎGaÿ\0up?µWNAwÓj(„I\àŸ©\Åy\nNN=EX\è\ö\Æ\êúq\ç\ÔÈ—§§û».\çR7©9\Â\ã\ò¤ÿ\0x\ÍY·7™´\éDu7vÁ$\çi½y\ò(^p\ŞØ¢ø1x\Æ\n–\Îqıim}a\Z¹p3»ø\ÔI.d–Rş3ÁÀ¨z®­\"Ü¥­¬oµh\ê\Ä1oc^£û}³µ\Ïzÿ\0N\ĞúƒX¿\Õ:T•mn,\î\î<Å²w`©<{\ó°)üJI8ÊŒıªŠE•Ñƒ+\0C\Ä{\Ò\èP¡B²#[=î†°+\ì&I##\Åq\ñ \\}\éeRÅ†8À®\ë\Òúlš^‡mo1P2\Ä\òj\ÂX\÷T	\à\ï\ÅA\Ú6U\ÌÆ[\ä»\È8I?\Âi–\'µ;?j´‚=ª*@\\\nùııª\Ş\Új~\Z¯UE	v\òŒ˜ĞÄ²\ä¶=€<\ñŞ¾9\İÅ²V\\{Wµ³¿I}\ê+Âª\\$(#ş\"N!ú\×p\ñ\ğË«\é»Ÿ\"¹\ò\Ê‘\Øÿ\0\é^N¸”\\jsL™j\Ù\\\ç\\Ö¯´mk¶/0I\Î0@ŸÁ³ü\é{¢Í·\Ã\å< üq¨\nG¾1ŸÊ²\÷ı	`DK˜[‰O¯q\ôª\×\é{KšA’9\à¿\å\ã¿ü\ê¾\â\Æ\Æ\Óy`‰y LŞŸ­R\Íw¦\ÄÄ—µW\÷Zn¡Ó•¶I4>†®lLœbmOş‘1»\ó\æ¬\ít\İ<2Ë.NrUÖ•moˆù.DœLük¢Cª[\Ån¸uS¾\æâš¾\ê\á?±Šy³øJ)!ªú¯Q.I°¸U=S\ÏçŠ®¿\ê~H	¡olnªC[·¹9ù²\â³w· H\n\ã·~\ß\éPM\Ô(H;q\ß\ó¨7½EkfûC\è\n©›«n_ˆ¡X\Ôú»\ÔSÕ·1“¸®=\ÆÖœ‡®ç€¡¿#ş´\ô!´L1\çŞ­ \ñ	Â‡ƒ\î6+Me\×Z|ª¡\÷E\ìdSùŠ\Óic} -Œ@e_–kc§Å¶\ã\á°?\Ú3úƒK~œi\Úv,§¾7p?B*ûB·C$j‘’€€G˜Àdz\ğó®Ÿ§\à\Ú\ZEFN\Å8ş&±¾>i#U\è+\ÅU\å>1œ\à\çúÿ\0\n\ğM\Ì&\İ}˜Ö—£C¨Z\Ü\ŞR@\Ç×j\è½s$cSû\Äg‹¸\ÕÁ#\0v\íúVjK–\Ê(‘Ş™gu¶ü`{?/\ï±7¶\Å>˜üT>^\ÒûUG¾hÙ¼³\å†\È¸{P\Ó#7\Zœq»¦Ñ–¸\óŸJ¢\ó\Î\Ôn% Œü \ÓIx\ñÌ®\á9Á\ç?*û%ı—\ßi©ü[\ğ\Æ\ã¡\õûÅŸ¨úZ8\ÒÙ¤o\Ú\ÜXcjş#\Â\ìc\Ï\'\'Û´t(Pª\í{D¶\ê-2k¿4C(\Ãdh\Ü}H ı+4hv\ïjÖ­}l\Ğci’I¸Ÿ‹y9ú\÷­¢(U\0zQ‘šm\â0EU^ZŒ*²H?:—l\ä\0­\ñ|ıª\Ê\Ş\0y­MUÀ*]s\ß<;µ\ñ;\Ã\r{CºT\"kI64‹Œ†üˆ\Ï\å_¿\éiº[ª\õ6B­®\Ã\×@?Â½Á\ö\r\Ò\ÇÃ½N\î8Ì’\\\Ş~\éøpª\'¾95­\ñ\ŞYE›\Ú	6ü \ÅI;\ã\í\\\"\ÓA\\H\÷JG„€ı¿Z”\Û,bRb·\÷’?Z\ËuŠ–ºX1\ÛÆ—2Fr\á{=\Ï\ô®O®x¹yq!µd“9)\éXıO«5Û‚c\òd3Œ\ã5J\â\âv\Ë\Ê\Í\ë’\ÔÙ\Ğ\ä15}§\è7W\Ús]¡Y\"QÊ“\ñ~T\Ä\n°¸\Ø\Ïƒ\÷G¥_Zu\ìb™‹LûVÃ§µ\çš\æ+fbGÊº\÷Hi©©\ŞA¦\òÏŒwşŠ\ôÿ\0†>\r® \ÑI\÷Uec‚cŸLş•½\êŸl-£!\í\ÃÈ –\0`Ò¼\÷\×\Ş\Çj®B„Q“\Ï9>\ë\Í\İS¤>y\Ä)\ÇÖ¹\æµ~±¸\ÛÀ¬\İ\î ø*\â=…WH\É\Ä\íºC\é\íV}3Ó“\õU\ìq©8$\Z²\ñ?¤¡\éIl-áŒª²nb[v\ãUKÒ“·M\Ùj\Ñ\\XL·S5²\Ù\År¦\è0\Ï-p¼˜ªO¹I$Á\"Hü\Çz\ÕtO‡W]_%\Ò[0‰¡™{1\Í@\ê~œÔº6\ô\Û\Üü\èªIS\ô¨úgS\İY\Ì)/Ùˆ?\é]c¢¼Eš\ñ–+£’8<~µ\Ù4KÏ¾\Ø#3p\Ø\öw§Cmk Ù‰2y3[­+\r2\08\ÏUY6­¡_[É†\İ\Ço„\×\ÏM~Ñ­u{ˆ®G\ñ­^Ÿ¡É¥h7ÿ\0‹\ï?G\î€Hş•´\ê\Ô§ß±XŒ8Š>Ü©#\ò5ƒû\Æ#¬²>oN(\ïz)_\Åİ‰N\ôŸ½°R3\ğú\ñÚ·\0“œ‘\ï\î(¥ºÜ¤pF}ÁÂ£Az«9!\Ä(A‘Ÿ\çU‹\"ù¯À=…+\Ì\É\Ç\å^™ş\Ï\ï\å\ğ\Ã\íAÑ—,\ÄX\ê·F»\Æ?Á®~BCøk\ï\íGB…\n(P¡Q®b\Ü*¶Kniq[dŠ±†-‚Ÿ¡M\Ï\Z\Ëˆ\Ã*\ÊA*üø}®º`\ôß]Qm\rFq?\á-\Ç\ó¯\\}\à—M\ğ?OÙ¥•Ø§\î\Å[xŸ .®ˆ\÷NN\ã\Ís\rN\Ñ,¡Pë½‘I*9®\â¿\\¹…¬\íd0w\Ş±‘\\6ûRš\ë\à\ŞD~\õ\éo³ƒ=\Õ6“j\×r‹\Û\Ä\á-\ØpŸ<z\óúT?´O\Ù\ğtÖ¼ú¼šŒ6¶\ÆEBÍ¼\Ş\Ş\ß?z\âÚ®£¦_Xhšp\Ó-¬š\Õgº€‘%\Î\ó’2>X\ïYI\ãO=’1N95\Ö4-CK\Ğz9m.L>|€3o\ï\\ÿ\0Z¹µ¹ºyaÂ\Ø\0g‘\ïQR\ñdu‹0\ôf\î\Ë\åZN›‚S©E™2w‘^\Ãû=t\Ó\ëwiu,c\á e»f½\Óá‘+\ßY\ÛFXş\'\òÁgŞ´~&Z\Úi2¸YO%rX\ó\Û\ó®\Ö\ÚL:•”³H\Ë/×šñŸŠšb¹bFG\âÇ§&¼\óÔ¶¥eaÄŠ\ËÌ¯\r§{7cŒâ’š}\Ó\ó³úú\Ô\í:\çR\Ò&BÁ\\w\È\ÍY\ëú\ö¡Ô–‚+\è72\ò¬	$Ïµg´ù.´¹üØ;m+\ñW\æ>u&\ÓQ¿‚iFf9;\óÁ\÷\â·}?\Ö7;¤\É“O#üRÜºqŸ\çüª†\ö\ÛP\êûÇ¸¾¹vqÁI=?*™m\áE\í\Ü „\Éÿ\0¤BJıOT\Û:†\Æe1Û¾;†úg½t~—Ñµ‹V[{‹Å±8\0¬\é¥tm+D¹„#6¢²Œ\öA…şu¿\Ò£q\ÛŞ¶\Öúg\Ş\àŸ\ñnq^$\ñƒ\ÃÄ»\è¥I$Y\î‘œp\àüG\é‚qZN¢\é\'\ÃV$É°p\ì3\ÈRNEg/¥øY7\ÆÙ“g®x5\Ë\ÍË \Ê\çoÒƒ]\r¿\r\Øÿ\0¯Î’.B§ \ìFixSøA#F\Í\ğd\ã¦\à’4˜\îx\ôşu	¿\Ş9³JY9È«\ÍX—Kº·¹…\Ê\Ïo\"Ì›x;”\ä`ıE~|$\ë\Ëo|0\én­´Rk:t¡º@YO\Ğ\ä~U­¡B…\n(P¢#4\Ë[\äúb–°…¥Š:—ü\'\é_ş\Ş\Úc\ÆJdM\Ë4\ä£±’k\Ğ\ßg\ë),<\é\è\á7[‡‡\Ô>¸\ÔÏ™\"¶\íÀ€xù\n\ó\÷]\ë\÷‚)cK[ˆI\Ñú\×\rº\è\rC¨§’e‰\ÜIf<}*5×„wp\Úy\ŞVÍ£üb i3uF\\E.›y5™VÊª’?3\ò­Sø½\Õ}Q¥®Ÿ¬\Ì5(W82g¹\ö?\é\\ún•¹2¡m\ñ}3\íŞ—I41´­\'\Æ\á \ö\ô©CP¡\Ù] Ji¢[ŸZ–4[\Ù\î“ ¦y\Åjü=\èK­_PP-\Ë	±Ú¾‚ø!\Ğ#B\Ò\í\â\áF3^\ğ\â\Í#\Õ#v\åT\à\ãŞ\ñ¦\ãºu¹†=\Î36O`8_\ëùWÖ´V’\ÚEt6ªG­yG\Ån›‰®\æO(•\Ë“\Üßš\óQt\Éi$]œ(\ã½b\æ\Ñ\rŒ‡||v\É¸\Ê øW#\çE°¿\È\÷\éÕ²û\Î\ÔœsV\ô\Ş\ä\n±nn{\ãÖ¬!\éx\ĞB<p†­t\îšM:à£¨–7Á\Ç\åZ{m&\ÉYYVfOÀ\ì\0şU©\éı\òb\ÒA\ì\Ç\â\ò\ÎA\ô\ö­Öš\ÈÌ°˜\Ìr¨\ÉŒ|©_Jµ»m»\æl\ï\õ\ç\ÛÚ¬\ô®ha_-\å`?t‘\Ç\ğ­…“ª5JsŞ¶]7l¯n\Ù\"T\ÆN\á\Ü{ı+„}£®N\ë-1¾Ia\È!{•n˜¬Å\ÍS¦\õh\Üï‰­˜›œW\êÛƒg\áİ¼\ğ™nNO°\Ûø\×*yI,x¥4¸\0gš5q\ÏcŸ­7%†?Z#!nwc\ä)´“N\à´\Û9\Ü\Ø9Ï­)	â¬´¸¤º»ŠÀ\ß+\Ç\äœ\nı$øK\Ò\ô…ı\'\ÓP3<:V—of¬\ç\â;#U\Éı+[Bˆ\ÑúÑ‘‘\íH`\à\äa‡±¥)\'¸\Å*…\n’\ÛOcùQyƒ\Øş”7ü\éF>‡\ó£<ŠùE\ö¢\è\ë[\Ï/luw\r<\ó/cœ•?\ò®\Û\Ğ}6š?@húj\ÆBCi(o©—\İ—\äŸ+\ÌÓŠ\Çu‚–’\å\åˆ\ÜLt\ãg\ä+™\õ_‡6z»”±•ŸJ\Å^\è\ß4KrV;P7\êO\ÌVgT\è=6I\çuº\r-Á\Úd$~lşU›¾\ğ\çO{\ëi¾\÷\nF€\ámQ\ê)¥DK\Ér7\'#Ÿ_•g/\í­\Æc†%\ã\ñ0\ç•PúM\Ëú\r¾\Ôå¾…,\Ïåª³¿ª!Á­\ÏMxk)\"y\ã+œ×£<!\è\ôç…¤Ef\Ü\"½K\Ò1’1€ pv‘Š?¼®FÑŒ\ğqZ½·\Ü\ÌQC;©Ç©W\n¸&_3²\ö\r^kñ‡§ŠK$‘\ñ¸–&¸F¿ÓªJª\ï*?:\Åj= ×ƒn\ÄÏº\óYMW &±sƒŸ\\\n«mH\İ©\ôŸ¸È„Œ¿<b¤C¾&\Èb¾j\Ò#\0RV$vÁ\íS¢ˆ¼ª_t„\÷;«E¥••~\ã¸2\Ù\Éú\ÖûC\Ô\ìm\â\Ù²Fç§\Õkq¯¥Àµ£	Gi\ÇÓ½?¦Z\Ïuq\És\æ.\àB…Û·\äk£\éVN¶\êRD_v‘w\n²¸€ˆB\ì\ï\ğ\óŸK\é{¢¢{vı™^p½š¼\ï\öÀ/\×L\Ü)(1p»ûg\âCŒşµ“\èP·I\ê{yMƒ\ó\Ås\æ[}I¶\0+3<§¥r¦;±G»ß€?\0üÑ©\ã>\ÔGş\ZCw\÷ƒg†\ÎiH\ÄU–“vÖš¬\à\íÊ¬OĞƒ_¥®œ½{\ÍNf\óVHÃ¯fÊjş…\n(¨\èP¡BŠ‹43B¾xı³4e\Ó|qÓ®\n\íi\îap}Ã€™ıIı\rtÎ„6ŸMÑ¢¯\ğ­F›bª¤\ÃÚŒ\èfı¤Ÿ±—şµ\Öz“ ş\ï\Õø\Ş\êI?‘®A\×YLŒÍ¦4çœ”øvüûŠ\àıu\á<zt‚Kc,%\àI ~g\é\\\Şû§\â·\Ü\Z\ò\èm\î\0fşµšL\å#·š\á·m\r&F\ãŸÎ>™\Ô\'l%£F\î\à~uu¤øu9c1 \ç\÷\Ö\ãA\ğ\él]f1‰Nù\\zV\×J\é\Ùn•#[m ·Ùº¦\Z\ÜE,‘\í\ğ{\æº\ïOi\ä0`ş\íu\î“\Ó\0¸Û‚M^u«\"\é2€¿Œ…ùq^}\Õ\à/;$D»’+’u\öŒú„SŸ®>£š\â\÷ı.%wG@A\ÚOj\ÈÍ I]Ldœ\÷Š%\éønW\â!Ø­C¸\è++ÀCD\Û\Ïb¢¨µg\n\ínOby¬\óøqxs‹cEm\Ğw\é(X\ãT_v\Èş•yi\ÒQQ\"‚Ş»j\Ú\Ï@–\Öq•d¹VÁ<U‰é‹›ËŒƒ‚0\ÃŒı+c£\ô,Ÿ±’Vb\Ìvœ\ßı+wa\ÒY61j\à“ùÕŠ@a%$‡\Êq\Ãûş©¹¦.¾Hq\Ù\Ç|Q\è\áaº\É•\Å~\Ø6\ğ\Ütn1?´Š\ôª\çü\Èsÿ\0º+™t\Ä\"Ç¡\ç\ó®\ğZ\ã>)\ê‹q­¥º±)J€CŒ·\ñ¬>\ìQ&<Q\î\ÏÊ¥$ŸaŒf‚6MIY0FI¯º¿dOuÎ¿û:\ôVª·úB2\Ù-««Á#0h¿fwã“·?wƒ\ÖWyÿ\0yf¿?ú4–\ëK•87VK\ò\Ïü\é\r\×R¨$\ßXw%\ÇÆ˜o6~-[MA\ó•?Öšo-\Ô\á\õ\İ%O±š?\õ¨\ï\âÖ%úŸFEÉºˆcÿ\0\ÕQ\ß\Æ}O=a ¯\Ö\òş:iüp\é\ôb­ºy[\Ôøÿ\0·Q\ä\ñ\ó¥coºmG¹\Ômÿ\0ø\é“\ö„\è\õü^#\ô\È\Ïÿ\0\Ô\íÿ\0ø\é\í\ÑC$ø“\ÓCÚ¿ÿ\0\'ÿ\0”WD0\ã\ÄÎœÿ\0û¿ÿ\0$ı¢ú‰:~CRƒ?Î’\ßiƒÏ‰š\÷Æ£ú\ÓG\í)\áşÿ\0¼\íı/\â?Ê›ÿ\0\å7\á\â\÷\ñ7J\'ü·H\ß\ÈWŸ>\Ò]S\Ó>%\ëZF­¡\ëk±@€Kujû„E z\è\Z\0V™’²ƒF+_bDp\àsŸz³I\ğ™À¡uµ\Ô^FEV\Ï©J#¸‰XŸ^ØªO\Ã=Vİ›e’@pJ®\äk!­ø¤¤[–*O\Ä\n€G\éX_üZÁ«¼\ï¤\ÕLC\0ûÔ©¼2²·‚G\ì~\"ƒÂ \Ï\Ğ\ñC\n*¨yÊ©Á¦?\Ù%-)\ì®y­M\ô³£M\ä`\Öú\Ö\Î=»#@©œŒw®¡\Ğú\n\Ü*®>\'\çşU\Ót\í1ls»,§‘YO5x\í x\ã?´”v\Ç\0ù\×ŠpÓ¼’>\×v J…\ÔZB\Í\ÈFı\ë\Ï5\Æ:«L·›JmR¸ø¬aŠ+¶+$jqŞŸµ\éØ§G‘bÙ¢~ŸT\äÇ‘\ìiS\ô\ÌFuı—¸½P\×F‡\ÊrcpW\äh\áé¦º„º¦W\òªÿ\0\öy\Öb\Z!ß*\ê\ÛF‰-‚yaX\ò\Íÿ\0}]\éº\Z4¨\ÉK	\ÆT{Ö„ZÄ‘,\É)A´‡S´Ÿq€O\ğ©?\Ş6\Ïj\"eD˜\0v•\r»>\Üdg\æ?J¤¾¾p\àÏ’±Œ2–\Ë\õıIª\ô¹ı±vÇ”yw\Å”\ê/ƒË©&¹·\Ú\Ò=K§4¸eXZ3¨!o< lz\æ}K§6\Ş\ÒÁ`[;M‚nw\Ã\î\õ5å¡ÔŸSÕ®g‹{±\÷\ïU{¨n\0P\ró¡»š<\ä\ÒX\ã\×\ò£R=¨Ó½?\Ù\ô7\ì/\öˆ\ÒzÁ\Ğ\õ}J;i-µ[ƒr0F\Ëÿ\0\ï3×™e\Ğ,\"‹#M´\rœe­”ÿ\0J„\Ú]¨l-˜úZ\'úU…¢\ÆC\ØZp;ı\Ö<ÿ\0,Ô“’\\––\ëû3\Çİ54Ê„¸†ÿ\0\à)\õúS°Î›m\Ã\î\ã\öj8ı3F~/O\áOE¨\ÉÔ¶\ØÒŸP»#â¹˜ıd4\å­\Õ\×Å‰¦\çÙ76©sc\÷‰A¾3ş´\ÜZ½\Ü\Än¹Ÿ\êd5\"K™‹+\\¶?\ãšb\êyûù\òs\ß\ã5\0\ÜK+\í39ÅNŒ¡i*~FºW€·\í6½}¤, ˜\Å7b;pk\Ş;2\Ù\ÇSüRˆ“&>@\íZ›]D¢¸`ı\Ì\ö\ÇÎœ›T”.ù\ãŠ\Íu4C\à\äş\÷sE„\å´€{Ÿj›c¶²ş\Ò\ëX|/œ\óş•m$p?2X\äÛ  \ç± c·½g59-Õ£P­p\\Œ\ò=\Î{~uKv#X06Ê„\Ş\÷U%ü\ñu@_E9\ô¬\à\Õm´\ñ\æH?j\ÏK×¤\Ô]v\r\É\ÙJ\×B\é\İ\'\ÏP\ì>PG\ò®\Ñ\×Mc4AÀ`>‡?J\ŞkWmgnY[#h\Æ;\ö9®A\ÕZ\Û\êW\"5f\ÄpF?Ö°^Y7R·˜ +6œg\×úUœv²j–\àF7>8$g\"¹7‰º<\ö3\ïš5|7\âS\ÛÚ¹]Æ—p\ó¶›wuU\â«\õ.¢¼\é\ô\ò\äŠEŒÇ‚\éGa\ÖK{¶&e\Ë\ö$şu¦°¿Kˆ>\\Ô©‹ÌX.\ìÓ²B¶\ğ\ì×\àSpÙ¥\Ç G³\Èü½jm„mr±…²2]@\'\æ3V¶šg\İ\å’@IÁ\Æ2?Oú\â¯-´¨.­\Ú7\Ø\ò/À…\Ûß3Ç½Q_tú\Û‰Ô’TE\ïœGÒ±Zû¬´\ÑTG\ĞÉ¿qüùüª•µ&¹\Ü#G\"r ~U/Ngy‘‰e\çœoùcÒ³-[Ç©\ôØµ‘«N§\ãÁ\0\ã¹ùš\æ¾=£\ôÇ…v·N	¹–´ŠC\İ;“Ï¡\ÆExÉ›\ß\õ¢\Î\rD;\Ñ\äQgš2\ÔY4±œ\Ó\ñ\÷©q\Ïq\n\â\'!O<\Z\î\í9’<\Õ6eÀ\æ¦\Â\Æ[¿¦·\Şv\Ç\ì\Í*$\\9·q[\å¸Â¶\ÚT\äF\0\ßÚ‘Ry¥°\Ü1R­\äT\É\ÇaŠ…u\Z½3·`ïš’¯¸šL\Ì5[($–A\ëŠ8D¥«M\Ğ\Z¤½9\Ö\Zeú\È#e™C±sÚ¾\"²M™\Ã\Í±\Ïp=}«Of¬\Ä3®T\ö \Ó\ìbi™KøU›8§nBÄ¡¿€[y¨$‹…\ô&‘ı\å\Ä	•¦Eß°m\Ú\Ã zŸ!\õx#V‘K,\È~2•\çü«\ëŞ²\Ú\ÏRÆ’†¸¸xÁløy\'\×#¿\çX›Ş¹’1\å$‹µ\0\É(\0 ~U’\ê_vg\Èˆş,57ĞšF£×“¼¬\Ì-c<\Ü\Z\ïı?\ÒI¥A\0H—n9\'š\Ü\Ù<\Ğm\á\rG¹\êE\Ó\ä2À\à\óß¸\Å#[\ñm¥‚TÆœÄ}¿•af\ês|\òFÀ P \íP’\ñ\Æ8‘]ˆe\Ï?_ú\÷«8:¾\ßJ/\Z\0$\r†\ØÜ€\0\Æ*7PkZoW\Ø\Ï\Å\÷¼*²²€·sık\Û\è2iš\Ë\ÆJ…ü#†§:¦\í5F\ò\ØMs±‡û×œ¼P\è™z>\ì]\ÙKV#\n\ç\ğŸOÖ™\é.´\ó¬\Ë\å\ÉÀ8<WL±\Õâ¸s!Ï¾*\ß\ÒO„\äüˆ¥\Ù\ê1¤ûB•Ï­[C}nÉ”	AøM*\Ã_‰¥e\ó7œú>Äœ\n´}ZX\à$Œœ-À½G§~ÿ\0¥@»\Ö\ä(Vk\"A\å\ÄHbŞƒš\Ô^+˜˜„Uv?…‡?\\Z\ÏN»\Úx\0?\ÇÒ†s\Z0\õª~ Ò¢\êK­n[ş- rq\ì}Î¹\Ç\Ú7I[Ÿ·y\í/Ü§c“·•\0Ÿ~Ex \Ñ(g\"…Cµ\n1\Å(\Ó\Èy%H½v\Ù\æ\İ*qšUš\â Ç–<\Ô\Ñ6\ä#\×¦Iû\Ó\ğJr2±nıÑ‘ŠIº(\Äz“\õ¡\÷;\ò£A–£Iw\n	+\Ã>´\Ïzm\äE?qH{…#+A$\óøƒb“ª“^jZH¨r5°\ğW¦$\ë\ßú[CX|\È\î¯Ñ¦\öH‘ƒ9?\öE}\ë}<i\İZ°Á\Z\Ã\n¢\ìŒ\Ãh\ÍYY\ê+(UD\Éµk\à¶%‹7#°ø…B“_Y‚=\Ì\ã‚=*‡Q¼m’\î8oJ\Í\Ü\ë\rn»Øƒƒ\ÆFqY\íO©\÷«†7†vŸ§\ÏuŞ¯i.]Y\Æ\Ø\óX½k®!\ã]‹»Œ©É¬¥®¡%\õ\ÈBä¼\ó^\Ó\ğ»E±é¾šµ„…W\à¹\÷\Íj5mv?.H\åP„ªN3T·jgMä¢¨ü@5f5n©–x\ÚH¥#Õ–}N\õ¥y&“zw§´¾«†(K\ÊIl\ñƒM^u)mÌ…¢^@`}\ê’~£o)\ğ\ç9\å½j-¿V=‘.6O»\òy\ÇÎ¯müEH¢I\Z Ä°üGµ[mQˆx{ˆV+Å½WK\ëKT_Û„;vœdTş£\æ.å¥¹RKoV\Úv9WI\Ñ5y\"EO1€„Öš¥\Ä\ê™œn\ô«Vv*@‘N\Í\ñì¦@\ö Õ¥®°şW—ˆ¶6Fm\Ê#SP2(Q=¸c\ñ*¢\ğ·Ş£¸F†_üa\n+\ä{{sT2ß•}®À7$|³\íH¸\ò¶ù‰[ƒ\Ïze”E\È\ö¢Ò®Uu\r¬nH#Ò¹§\Úz[m3\Â}M\ÓM \'±\Î¥xdœ\ĞÀû\ÑúQgŠ4DÑƒš:1\Û4\êRQ¶Z\î.A“’xÀ¢\r²ESÁ,gŞœ\óÁ$/$Ò¾ø® n1°©?:\\r)ŒsøG5I¼\Ã\ğ\à\ĞB\Ä\ò1O™\ì8¢\ó‰f\ï\Å3%\Éb@¤©ø¹¥K*€…4\Ó2®1\Å5In¡§R\õP\÷È®\ó\öºû\Ç\Ú;§ÔYO\Û5\ï\'X\õØ§	½^<n¶8G¢NvI\ğ\í>\ÄÔ¶\Ô\ÌjNv–\î«\Ø\Z¤º\Õ\Ş®\ñ\õKs¬†c™1ş5Öµ`\ó\É’Æ°=K\Ô\Û*q‘\\¿¨\õ¦‘\Éw\'<V.\â\òKÛ•3†\Îky\Ñ}31©\Ç\í\Ã‘È¯C\é½t‰9@2¦¯z†;\ß.O?p9\á\ô¨Rk(­´JŸ@\Ù?˜«\èf‰‰+$€gbœ\ÕuÎ£\÷e‘\çPÉœ•g\õ†\à‰bB	;²©\õ9.Â•2\ãwjŒZ\ã\îªZ@4\Äm°of^{œÿ\0?jvkˆ‘@‘\Ñ\ç\â Ë®\Âã™7°j\Î\õ\'V.Ÿ>\õ\óJ‹MsO\ó\ZB\ÜÅ‡\Ğ\óık_miub‘„\ó\éV6W.r­\Z4€ş$\ôıj\ö\Öå‚\ã`\÷\ìƒ\ó«[K¯-IBw|\Z~+µ¡(\È\Æj\Î\ßTH\Õ\É!»Œœ\Ór\ß,ªøš^rF;UJ\ËûS\"³HW¶\ê°>\\°),¡‡\Ä=\ÍA¹œ\È\à\ã\á\õ5S6¥m£¬×—²$\'yd`ª;I\ãÒ¼·\ö•\ñ†Ï®\î\í´\Z\àÍ§\Û6ùdBBI&01\ïFk…‚3K:K\Ñ\Årh\÷P$ŠV\êRjB\ö¯B\ôGL\Ş\õ\ç[h½7¦l7ú­\Üvp4§«;¹\Î\Â;œs\ëÚ½\Ù\Óa/4­/Yº\êŸ›Xm2h£¼—Ka·@”a\ñddŸOL\Z\ãjÿ\0<6\ğ\ÛIµ¾\ğ\÷_—R‚;µ¶Ô£U“cIš\İÑ”\0U\ã\ÜG\Â~uå¦‘UR%mÀ3|^ø£3BA\Î\õı)peH\æŸ/\ìqH’\àª\ã¦’S¼\÷\â“\æ—$qM\í`\ç\â\õ\ö %(O9¤]»\Ñ;•\Ç=©\ï82Š\Ë\Ïµu\Õ×‡i¦k\ö¤™mg\ã\ÕO~„\×\Ğk_\ô\ïúv\×V\Ón<Íƒd\È\ÊU\ã=\ğÀ\ó\ïúU¦·²\Ù\ß!s»\åM|<¡€#¸\Ïj«\Ô/\ówq\Üœ\Öz\ïY©\ÌkŸŸz\ÌjBK\ÅD_Bqük®\õšÒ¤$eFF7W0×µ\ğ³|.{\Ü\íÚ¯úC›_»F\åG}\Í\ß\ï^‚\Ğ:V\Ú\Öe‘F0=k\âıÖ…¢I§²£ªùG³g\×?*\ò\×TjZŞ¾\î\×\Z½\Ê<\Ç…Wø\Z§Óº·©úfaq§\ëw(\ñq\å3—¿\âV\È?v¿~\Ó1_KŸ\Ô\n–\Zƒa\r\Ä\î\äÿ\0\á5İ®µ\Ö, š\ÖO66\îHÀ?1Pše\óZ0À`\ãj¯!m¾›+\Õge¢Y´·WKj2ryü½\ë\õ_\Ú*şk™-zr\ÔF‡#ï—€3sş\ì?<\ÖmW¨5»\Ãq©\êw7\Ã#t˜Q\ôQÀüª\ëI76w“{<{øP\àš\ØZ\İ\ï–¼´²HA\ç\å[xa˜¹¸\'8\Æk¢\Å\÷C¥—\È Œq\ÉãŠ .–R¶\âJ\Èr¬Wgm|®  -\ô\Æ*\Â\Ö\õW´g¶\ĞN\ë\ó©Ÿxû¬§Ù…75\ğo¿9¦R\ä¡A¥Á¸\ÎN{U¢\æ8c\Ş}\ögú\Ôyev\í\Æ}s\\\í[}\ä\ô•¸b¦k\å8\÷ıEy4\ò(b•(©$Ñ\ó (\è\Z½,w\òœŠ\î]3\ÔW%\Õ\Znµ§±[\Û	\Ö\â/bT\ç\åŒ\æ»w‹¾5h øv²\éeq£j/2\Ü\êš\Ö.—È»@gRHÔ€CI†\÷\ö¯5\ßu½\Ôs]\Ã,Ó¥­\Ä\ğ\Í$M#:m	\å¶#2\î=\÷\ÔøÙ¢¸X³†j~7\ó\"lú/\à™€)y\Û\İd\ãŒQ\çdƒ\åD’ªÇ®i\\\à\÷\ïM•Nh\Ö\à+ \÷<\Ñ\İ9\ó.\î\ÔA\Ø\ô—¹\Ø1\ëN[Í–ık\Ódq›M\ê½9N\çmp\×k++¾	\äƒtk\'\Âú\ôú_yWl»ƒ@\ä\Õ\'\÷‹\Ìbd\0äƒŒ\ÖW]\ÖÊ¿\â9\'\çY\ÍGPm8-Á\ã<W:\ê}t\Ú\0\ñ6p=>µ\È\çÖ†«}s\ÆdO‰bS–\Ï\×\ÔW}\ğ»¬K\Ó-\í\îl‚\ê…Co¸°\Ç\ï{WW\é¨ŸX’p\ğ¼³ùh€lŒ¯,I\î@\õçŠ¤\ñ3¨WX\Ğï ·9\Ş\Í<Û•\0mRGÀ¤ú|½O­x‹©uK­3Rš_ˆ¸?{wøO\çYû­u\Ò\\#bB”NAlr9ªk@ùÁ<s\ï’©®¥\á\Ú7X\è\ËaezQÓørq\"P	\ô®İ¢ı úV\Ú\Èd³l\"~1ü\óO\õo\ÚF—§³\Û\Ü%\í\Ó¬d`=H\í^l\ê\ï$ê›¶¹¼ˆ4\áP{ù\óXùoRI‹û<v+\Æ\èT»e·£M\'\ì˜\\úU¼=BaD`D‡8¹\ö\âµ\Ú±\È y\\\Â·|}x5¬¾\ê\î»3$j7\0{‡q\ì\ñ©]9\ãX.\ÙÂ‘Ù‘ûƒ\ëZ‹®¿´\ÕÉ·8Fı\æ\0rGo¥5e¯B%\'\ÍTüHXŒ~•¦³\Õ\Z\í r¨0q’F?:¼‚\ëÎ±\0g\ã\ô¨\òË™qNùë€Ÿ¾£v~U*\Î\ç\âÈ«x\îd”\0\\\í\öT)§\ò\äWš\ó¯\Ú\Úä®™\Ó\Ö\ÍË™¦|ü‚§ú×š)Db‹u\n=\Ô3Şˆw£\'šU-9¥†\"º\ä\ÙT5Op	“š~Ğˆ\Æ\ãß½K‘¥c#\ô¡k9H\È\÷Z_œTŒš\ó&˜yC6sŞ[Ÿ\\ÿ\0\nC\\l\ç`aD\ò	c8\Ï8¨ \ãµ\ZH<\è\É=›&‹\ÎE\õyW`¨\á\ÏaKi2+º}“5©m¼C\Ô4\âc_X“‡\\’\ÈÀ¯>ƒ³^™¹P$$€q\ïú\Õm\í\Ø^Tÿ\0\n¤½¾‘`pw*•Ğ¦Lœ1\óš\ÌuÁ-§!w\àr\éş•\Åúª\äŞ˜\í\Ğùd«~\Ì~ù\Ï\éƒT\ĞÁƒs©\É<r+Z€†F\'\Íl”\Ø;v1\ñœWGè­³Ñ´S©I$U©»F°[F\ò&“by’\Ù\İ3¯Ãë¹w/\Äè¡µ»M8\İu$_wû\ÌO·2Ÿ‰cCŒ\äY±\î\ÖV\ñ.\Ôt¬V\"\ÆHu¸¯\ñ\Ê\Ì>b¢\à\í\' \ñ\\“[e\Öoš\æGKw¸ø\âE988\õ\'\çO¿Ò©µ\Ûi4p\Å4R…Y¡ü¿ˆ\à\ó\ë“Y\æ\\\Äü \ö½$\Ü\à’=€©Vw®„6N{\ã*\÷T{½ª\ß;\ïU²\Ì\ÎNNH\õ\õ£I\ò¹üX\ã\Ôc½(\Ê\Û@\Ü[\ßùÔˆ.$IUYd\åwzÿ\0—\éW\ğ\ê0_]ª@†\Ş@2Œ9ø‰\ä}1œU¦«\Õ\÷—qgugŠ%zdy€\ç>¼wª›K±up²“»˜\õúU\ğ»ciq\"K\"\ŞÀREU\åeNK~cƒ\ô\ÍtÎ€¼Òµ\î»M!\'O\"\ó|PM\Å)Œùc\óuQù\ÕÆ—«\ÇL¾cCµ†}~•¨\Ò\õ¥%]ø=\ğ{\Õ\à¹\É\\‡<~\áâ„’–\ÉQ\Ûß½L\ÓoŠKƒÁ\"­\ä¸#\àqQ\Ñ”\ï\è¿\é\Íy_\íS©½\ßUiVŒ~lË\ìY\Î\÷kˆ\ç4(P¡B¡Ú…sFŸd\ö§yÕ¦›	\ïU\Ò\È]\ÆsŠs•V\í\ÅJU—\×\àş”˜\äjT¤4JÁ¹\'µ!®˜GÊˆ±e\ïJRG4R^Œ¤\çÚ˜K–`Ç\0–	=\é“7\Ä{\Ñy§w\çN¤›¨	~*TO¹€\'Š\è~j\ß\İ~+\ô\ô«&\Ï:º±Š\êTŸ\ã^\ËÔ­¶*J¤\îœúŸSTú‚˜Ñ¾\"qT¿z>v’MAÔ®\"hK\Ä\å\È\à\×0\êî¥\Ş„­´\È^\äg°\É‚°Ô­\ô^˜»\ê½Dek[HV\İ&\ğ}0[$z¯ù…s+«¿½ºMg_¹k¸\Z\å§h‡$¤s\ğŒv\ÃÒ¦Y\õµ½³^\Ë<\ÒZ]]3-Â¤J\ØS€wu\â\È=¹\õ\r7VjK \Ú[µ\ë[\ÙÛ´“Gg„H\î\ã\r#^0¿/Näœ¶©©F\í.6¢\"§\Ë¿ü\ê4Ú¥\Å\õ\ÒI&\é06\0€\õ¥k\å-\í\ìaG{\Äe‘Fr Ÿ…Oı‘»Gª\\`\0,…Gtl´Ó‹\Æ9Py”q\Û<\ÓCr6\ì\óŠV\â(,„\ÎJS˜\ÖS‚Û°}…Hy„rˆ\í\æ¬\õ›¹\'X\àÛ´´s\Û\×\ôª\Øu·.@\Î@\ö\ÅK}GÏ\ÕX„\r¸g#\0Š\İø/\Õ\Ó\Ş(i\Z\Í\Ì	w\÷y\Ì\æü;¶°N\õ¹z¦¡\ä5#»”‰\ï2”ı\"µºc´Î·)ø—úŠ\×\é—%\í\÷>\× \à\É\íVk+\ì\'p=Ç®>•.\Ú\"\Í)=ùùUÜ‡* 6AšBNÊ…=	\Åx\Û\í«¦­â¨bm\ÑA²ÿ\0²£?\Ç5\ÎsC41Bˆ\Ñ\ÑdQ\æ…Ô®\âœİ+¤\\NYˆ\n„\î\ï\ëO™\Æ\çœw© Ú»H\'i}6\ÇsqùRU\ÎTg·j\'Rş½©)#/“F³\î8¤ù¿±\\\Zeœúü\ZZ1Q\ß“›q\ì8\Í?\Ï|S‘¸\"ˆ \óEŸzº\é{™-ºŠ\Âxd1\Ë¡\Õ\Ô\ò¤ƒùw¯~i\÷¿\ß]7gx\r\Ä+(¼Œ\Õ}\Ó$‘08\'\çY\Ù\â²°Ê“ØŠ¥\Õm„Q³!\òÔq\í^o\ñV’\ãP02‡.h\İ\Û\å\\‡©eux¡i\å‘c]¨$$\á3‘a\É5W%\ç\îF~O×“EÁ*#ÁtS»\îO©©pLgd\óL\0¨\Ï\Ü\í\öÂ£\İ$\Çb\ìŒ/±\Çj°[a²\óK\0\ç*\0\äÿ\0\×5¬g”‰$d`· \Å;\÷&\Ü\áG\0T\Í\'A–\æ\éX¡d>ƒµ\\“w2\ÆX®HÁ#…W©\ô\Â\é\÷\Æ\åYg•ªy´·±\ï\íMIf\ñ¾¦<œ’1\Ø\ö¥²\ç )$sŠS!H—\'ŸCS¯!hx`Bù`ÿ\0Q\Ûy\ôßš\Ñ39¥H>‚­4\íE`1\Èf#\ò\Û’I\Ç\ò­U„Ÿx{\È\Ï\ì\ç@]\Êù…Y½=;Š\é}-xg!İ´€8\'Ÿn,TA2À6;\æ´p¸º	œs\ë\ïúÕ…ªa°>©\Å$m)\ó5U\ÔL±¹¹“\Æ\Ò1\'\0g5\àÎ¡\ÕZ\×/\ï\ä\á\îgyH\ö\Ü\Äÿ\0Z€1ŠMhfŠ”(z*P8gµÑ†\"ºC\r\Ù#ÓšB¦pid\áH\÷¡m\á&‚±\\e Ò·\Ê}©M \ÚH=©&W=¾´\ÛOû7\ñ\Å’±‘@69£Ywµ\Ã$\ó\Å€M\Z\È”[Ö›\Õ\×J\å\õxÿ\0\Ê\Ó¾‰t\æ‰-·…]3}ÀZ*\ç\ê˜¬ü\Ğ~\Ñ\×»\Ô+«ue\É\ôª=b8\ŞØ®\Ö?	\nó‡Ššš]\ô7\öøY¡%ù]\Ù\ï\Åq^º]º\Ô\ÅV!Â²˜A‚£A\Æ2+6ƒ\'¾2)\è\ÈU\Ô\÷©\Ö\÷0¸”\õv5¡\Ğ,\ô}—\×Êˆ{ƒ[m§´®¢\ÔWO±\r¨M\"ÿ\0\âÿ\0vø¾,|Y­n¯\àıÆ›:ÿ\0xi\ï§JB®d\núgLşuS}\àµÕ©Œ\å^İ€a\"vaŒ\ÕÖ\ÑZ\ÛÉ²\İ~ÁcÉ¨hû]\Ö(8üGÚ¨g\ée¹¼S!Ù‡ø¾’?*Ÿ\á\ì(h#˜üK\é\õÏ­@—\Ãiÿ\0f‘\Ûù¦AÀ	’*©\à\íŞ“§=\Í\ÄOH¹f(Gƒ$wªon\å·k™m\Ş(…R±—\'\ë\ÕG{\Ó\ÂÑ™%c`9\çÚ˜\Ô\î\í^]\Şz¸Û°F9À\0ÿ\0\n«¸šİ”ˆI9\ìH\íQü™$…\æU>Z°RŞ™9\Ç\ò4A\ö\ÂG\ïwÆ¯:N\í?¿\"’w`§½\Ïn?:\ô|\ÚVŸ\Z\ÛO¦\İ\Å9|—ˆ²D\Ü0 ~£#\çW\öV\r\".\ò¡\È\É\Í\\¤b\Ó\×hª}œ\Şh\õ«\Øyl\Ã\ÜW7\ñ\Û^M\Ã\İAL=\â‹x‚Œ’Xú\çŒ`7\é^7=\è¨ø¢£\Å\n*c½*…tC!P~|QF\å—\é\Å/qr¡~yü¨–P\0\Û\Ûaû\Ñ4¸&’&’\ä‚\'½\n\åO„ü}\é#Œ\òiE°)ps@2‚)Pù\Å§„ŒqD*û£G™«:şÅ¿\÷”W\×\ï\rº)5ÿ\0³¼q\Ç\æ\ÜÁ\Ş\"\0eˆ\0eG\×Ê¸UÍ¯“<\ë \Ã|ª\çk\r\Æ¥@¾t¨…r\ã\ÔV«º}¦¼!·VšL„i\ÆBF€G\Ë\ÔxÛ¯l$\ÒzƒP±‘\Ú\ã\ö§Àn\'<Ÿ\×5™xÿ\0€dp\éV:~•$ü:ûT‹ş›’\0qÈª¸-\ÌCzb´şk\÷}\Õún³\ÒdBøW­¼N\ñÇ¦:¯¢Z[IXH‘†À\Èù\'Š\è\ŞuÍ—\\x_§\Ëu”\ßs\ØK\ØdÀùœWX\èÎƒ\Ó\î:^6¹³\é.?µŒEdú\Û\ÂŞœ°†S•”ƒ\åŒc\éY\ßü#Ğº‚\Æ\â\ò\ëLvR«»8\0VûR\ğ\çE‹Oh¢\Ó`‰Us\ğD£ŸÒ°=¢Y\éš\Õ\Ù\ò-ŒPm„g?_¥Tı¡.í—¡\nQš Cü\×1›«t®”\è\é\ç–\î/½,[(\ÏÅŸs^=\Ô\î\îuMF\ê\á\Ë1šF=\Îj\Ú\É#“\éSl4©n\\aHú\ö©-§¼a\âV+\àH\ô$p?™ıj¥\âe“pqWı-¢É¨\ß S°.¾3¥z+£m™£DeQ&@`ªBıEn\Í\Ö\áG#S\×A£·\çÔ‹)|¨·`s\ïS!¸\ó •zW>\ÓıV\×3i:$/¶O½ÌŸ\âb6©#\Ó\07\æ®	B…\n(P\Å\n<\Ğ\íFMtpM\'wPG*ARG¾Ïš#.\Å\0\êA¤9 ‹#\ß4”˜–\ñFe\Î@9¤»ü\0şÔ¨\å\Ü;qD\\g¾)>g8\Îh*}H¤‰	SŸz5<~\ïø¨ü\Âx\Í›h\äÓ\õ­A§›«¸\r‚UT\óuÿ\0¯jû¥\ök´H¼-\Ğ\ã(5²\åH\à‚F+Ï¾:t	\èÎ¯¼†E´—3D[¸S\Ø\Î+\ÜÛ…Eoˆg¹n\Ä\Ñ\ÙEµËƒ\ñ(øO®=…@Ô´¯\ïEI·Hª\ÅÀ<­ywÆ¯­­&½\Ô\"™¬w®\Ş}\à\ækiº \Ş\ÑG®\Óÿ\0\\V£H\Ğ\Ì\ä•!<rGµi-:rø„^XR=š\Ïu†“\ÙN·!*\ß\à^@¶\éÏ¿[…”lu\È5û¤e³{\ğ\ò+y\áß‰}Eá®úe¬+=‰c G\\\òœ\Z\õ?†¿mıh6¶Oaq¦OmS,1´\Ğ1\÷]£pÏ±Ru\Ç\Û;£\ï\è[\Új·Ÿ	Tl±ù‚\ß\Ì\àüª³\ìı\ö\Ú\é>”\é™4\î©\Ò\õ(¯<\çq<0ù\è\ÈI#\'9\È\íÚ¶š¯\Û{ \Òo¹X\ê×²Kœ*Ù…\ÚÍ˜\ç\ô®]g\ö¢´›R¼’\ç¦.’Ñ¤&R\áL…qû\ë€3\ô<|\ë\ãŠw¾*i\Ö\Úe–œ\ö–\ÑÈ³|¬G\0Î¹³t§}»\ïrº¢p\Şa\Æ\ï¥S\ß\ô\ğ²?³Ãş\Z®²\é¹on•H \ÎEj£\Ğ`µ@ƒ+¶£]h@DI \ëUƒ¤š\òP®©Ó¼:\è\Ø4´\à\ğ`\÷ÿ\0¾º¾ŸTa\nª\\²³\Üo\Úvœ`\ãŒSS@X°a•\É8=¨  \Â\ò}…;wsmkoa·\0³\í\àc\Ü×‰<F\ê‡\êş´\Ô\õ6$¤²•‹\'?³_…€š¡C9¡@z\Ğ4(P¡F(\n\ó[\×$sšCI\ïE¼ù4\ä\ó\ò\Í$¿ÁJW3ŒšK\Ê\\ƒ€>”“’iKş\óM³sŠ-\ÛH¥\ï‘œÒ³·£aµ\È\Îh‹¹\Å)[mD\Ú\Î\ã\Ï\í P>¯Ÿ\é_uü‡\îşhˆF1lœ~T^=\ô\ZuIIyA\ïlTº\àr\É\ê¿Ö¼E­X\Ğ\Æp61\ãåš¬‰„L¤Œ\äB\Öm\Ü7™m(Eo…“8c\\«\ÄkXE‰ˆÇ¸¿\â\r\ß\×?Ò¸\Üı6¹E$c½M\Ò4½@>¢µ±\ô\óF\á¡N;Ö¿EÒ£¸[‹9\ãB\Æ9C\Ô›3-\å´[b<\àÿ\0J\Ë\Ùi¾k:\È2P\ãf\Şk@4]0\é\ò‡±G¼p\Î\ôQ\ò¿\è˜\í\ÎøŸa\ïŒvù\Õ4ı&²±\Ş\ÙùM”‰@ Ÿ˜§\à\éGJ.\0;G­X§N˜\ğv`ûŸJ¾Ñ£¶\Ò\ä8.İ²œUgP8™\äe\É\É\È\ä\Öjœ›R/j\äš\Ğ\Ã\Ò0\è\ê]\È\çœ\ÔG\ÓV\âF\Êa¾]©›\í>(\È\n¼\Õ%¥“G\"\Û8®…\ÓY²Á\ÆI\Æs\é]Å¢{RÌ¡İ†>•.\ÄI\Å31b\Ê3Á4¸\âË¸sš\ç2uH\éÎ‡\Ô.a}“Ü¡µ<°*Gş\ÉcŸ¥xÿ\09\ï\Í\n¡B…\n(QƒŠ*<V\ÚG±DX)(\à7ı|\éD‚¼zS@“Ç¥6$9\Í.”\ÇH#$ŸZK\Â) \à¿Êœ^~h™‡cFs\êiûP\ãŞºOƒqµ\èû\Ô\0ÿ\0_w¼&„A\ÑzR(À ş¼Ø²F\È\Ãr°Á\ÔW‰¼|\ğ\Ñú7©®\Ê\é\÷Í…ı\0>Ÿ‘\Íq‹\ëy s»£Ö«µkiumeE’Jú\î+\õ&˜×—j3|[Ÿw\ô¬\õÿ\0O*\Ş2Û©\òû¶y¨\Öz\ô69¶¶Ó¢…B³…f5\"(\ã.g‘\ëÇ­]\Ù\Ì\×vDJC \ãÿ\0!Y.¦\é{{–ûÕ©\òY?c«1?\Şí”–‡\áø¨W\Z„S®\ÓR85Y\"¡mß»œ\Ó!\â\ó\òH^;š›\Ñ,yV\İ\ó\ïQNÀO<\Z€×»œ¬jXûT½7E¸\Ô\æ\Ş\ê@ˆ|«_k¡Ák¸·#\n{=\Ûj¨\Ï|\n¯›N\ò |_:§\Õ%X\Ã.N\Üzš®´³Ç–\ì3\æµ\ZxS¸¨À#Š\Ô\èÃ\ñV\ít«\Å¹I“r\ë~bœm\Ïü\Z\Òu\ç\Ù\÷\ÅO²F©\Öúw\Ş$\ê-.\êK\ÛK9Y\í\á—\áï»†a\ï³µ\óu²¬A\Å\ê,š43š4`\Ñ\äPÈ¡B…\n:Ù±,\ô]¨Ñ¶’§…$Z¹>„qú\Ó{\öúzš\çH\Î\Ó\õ œš{\Æ\ô\Ç\'ŠC\î\ÎqA_ƒ·\Â3\ß4D\î\' ø\Ä\ë\ÍR;\ğ3]cÀKO½u6šƒ\ñ=üaG¹\Å}\ß\ğş+¦\ô\å#aO\åZ\Õ\ô¬\÷ˆ]	e\×Z¶—#\Ü*“‡‚­\íŸc\ë^ë¾Ÿº\é­^\â\ÊhJJ®Å\ô \óX\ót\ŞD\ñ\öc\È–\ÕbûÊ ‰cø·\Ô8->ûtZNfrz~]\á\öıi\Ä\Ğ6I)*p{\Ó\ÇH\ò&c•‡û\ÂJµ(\çÉ‰1\Ã\ß\çO%ª3ø\Ş;ƒTú®ƒ2“ )*\àú\Öb]&\Â\å\ß}·“*Ÿ\Ä;\Z«›¥\àG	(\ã¾ªÉº2	\Ê\\0\Ù\É\İÚ›nšh\à\Ş\ä•\ô`=*\é\è\æ”l\íø›<qù\Õæ™§XBp°†˜©˜qS\Ämg\n£…¹Ú¢;g¯¨\ÍE—S…Ø†\Ò{\æ«\æ¼bpG>\ÕQw£\\<\îûƒ?\nzŠ“m¥ù¥Gr¼b¬¬t¹`˜¾\ò«2sÄ€Œníš°’\à\ÆÛ±ø¾ÿ\0_>…#\r’;P´mSP¶´†3,\ÓJ±F‹\É,\ÄüH¯¬>\ô…¿Et&Ó±\0\ñZZ,/»\÷\Îß‹?RM|Bû~}Ç€?hmkO\Ó\á\òúUÿ\0\Êzv\Ñ\ğ¤rº1ÿ\0LWš\ÌX\ô¤\í¡¶†\Úhm4X40hPÁ4dœ\Ğ\İCum\ò	¤·zC¶HÀ:&|\"~Î‚G>\ô‡}\ÃÚ}(ı)À~#\óQIf&†r4y\ğ(\\0s\Å6§£Òˆ\Û\ëJPXWlû5Z´\İi ¨\Ús|$\äã\õ¯º\İ&‹f§\ñ\Ôc\ò«a¬Y®­œ²ù·Œ¥Œq\Û\0\õb8_–{Õ¨ÿ\0•y\×\íE\á\Ò]\Ú.¹i\óÁ)Q\Èo\Ìg\ô¯\Z\êQ´Sl(c;\È<\Ôk\Û*]Gt\Ç\ó\æ¢Y[D\Ç­´¶=*\æK‰\ãqƒ\Èb¿Ò¤š[\öc3³€f£\0STw±\'Ş¥¶Šg4\\¶~,\Ïn*«K›À[“€\ÍÁ#\ß5­H[M\Z+“ =ª‚n¦’5\Ê1û*Ö½\r\Ì`#pr~u\÷[¶*\Ó 2FrxªXú\Ë\ïI¿n\í\Ş\ÕnS€*\í1z+qŠq{oytX¡Ua}E=q¨\Û\ÃJ¿\n†\õ¢¹\Ö\àeÁ \ñ\ïT—Z\ÄnvFK\ç\ò¨\ÒFD\ë\É9\ö>6š\à#)\nWv\ó\ëùU›Z™	@¹aø²{R\á\Ó\Ú\Ùÿ\0\0l\óŞ¤Cƒ\äsŠˆ¾\ñ±\n\ÜWr1•‚/À\æœyL`ú“\é]s\ì§\ÓC¨|d\Ò$‘U¡³\İt\Ê\Ã<¨\ãø‘_L\ô\Ü\ği®«è¾–\ë+o\Õ==¥k\ö rš¥œw£\è\à×™üIş\Ío³·‰\Í-†Ÿş\È\Ş\Èr\'\Ğo\ö*ŸıS–@>AEy\ÅO\ìo\ë-Mu\á\÷X\é=Y‚\â\Òü+“\ìªr\è\Ç\æYx§\Åz\óÁ}U´\î´\é]K§\ç\ÜU$»„ˆeÇ¬rŒ£øI¬”6q@©[sC`¢\Ù\ó R‹a\Æh¶f†\Ê\Ø\nq\õ¦\åøH\÷ÿ\0º‡u*.Âı¨Ç¥l\nQ8\ç\ò¢İş´E\ğ(+ş/¥\0 Q@&3C·jSFj\ë¥:K[\ë-R\r3A\Òo5BRJ[X\Â\ÓH\Ê?* £Õ»\núG\ö0ş\ÏÎ¤Ñ®t\î©\ñ\r[B†&[h\ñ\×r0d\î\"^,s\Î\Üs\ôXiw2Á\÷h\äş\ì³P!;¦e\õ\Ë\ò\ÉùŠ°\Ò\ô[-#­ºE“–n\ì\ÇÜ“\É?Z›U½E¢Á\Ô:5ŞŸ89\ã+\åO¡Jù\Õ\â\ÏL\Í\Ó=Kui6C9B\ëš\ËY1Ÿz?*QÍ¢\Ã,N‹\æD\ì7‚{6y«˜,cff\Ãc üª\âÁ#Š9™©\rB\ïNš)ƒM»<µ‹(R\Ãø@\íù\Õ­¢\é\ğ!T€	e\É$…?N\ÕI†:\ÂnV\Â.wzgZ\ğkQ‚4h™9üA»\Z\Êj¾	\ê“F²Z\Ê\Ä;|jq€=\Åa5o:¼£\É\Z2„ˆ<\n\Ê\Üø7Ö±¨•J¿\á\Çúü\ê³ı†\ê\ÈX¡a¹N\"¦Á\ÒD\n!‘¼\ÌlJ¹·\è\ÍYT5Ã±¶Nj\\½5-µ³\É>\\Á\Î*OOt\ó\\À\Æhp¾“ùV‡I\é\É-\ïYnd\0YO·¥Z=œ6\ã\àãŠ¡Ô¤1c‰\âh\ò\ğM3#¤!\Ø7¶\Ö<T„¸!\ñ‘¸•@ºw¨\à-\Ï<\ñN[399$\ä\Ós\ÎD¸ù\×uû\ë±\Ã\ãM®š\'6I#ˆe@ş!¿ZúSb0ˆ}qS¯tø5]:\â\Î\ê15¼\ñ˜\äF\ìTŒ_1ş\Ö?\ÙÓ­t´WU\á1½Õ´\ïŠK\İ\È\Ò\\Às\Ñ\ò.3\ğŸˆzn\Ï\'\é\ßz«¥5·Š\ê\ö\ÒHØ£Æ\Ê\êÀ\à0A½C\Ğ$ø\ÙÔºhM9ú›U\Ó\î\Æ\Él5‹	5)—\Õv\Í®®1XO>Ï£«®f¸¿\ğ¯T\è]bF;®zv\Æe³w\÷û¬™\n?\õl€{zW•ú\ÇÃo¢.\Ş-F\Æ\â8Áøgx5oÉ”ù\Ö\\©DP¡BŒ‚(ÂCµ\'\à\\\Ó2\ÈN\ô¤/\áJW\îÑ¨È¢|’q\éH=\è\Ï PÀbs\ò¢Û“\Ï\ò¥,G°Ø§L¹H>Æœ‡O–\á\Â\Ç;1À\n;“\ØW§ü/ş\Í\Ï¼J°Š\÷ı™‹¦¬¤’N£œ\Ú9ú \ZAù ¯Zø\'ı‘\Z‰$:‡‰š\Ë\õ\Ê6\ï\î\"g·´#\Ù\åÀ‘ı\Â#\ö\É\í^‰\ğw¥ü4‚=?¤z[J\éû%w\Ü\í\Ò \Ä~\ómø¥o\ó9ù\òk}~X\îI\õ\'¹§(QfŠIh\ÌN‚M|ú\ë^¥¶\ëŞ§\×\âr‹sm}3¢\ÄNT\à\÷=\Ç\å\\\ât6s;>3\ë\õ§\"O¿‚ä‚£‘Vv°¬h«\ëVšz=”şp\Ç\ëM\\F\×\×-33w\nŞ£\çŠMı”Vò¨Œ¨\",Ï¯¯ı|\ê\ë£\îe7K	G‡\Å\ğ~µ¯[ˆ\æ‚D\ó!u?	)\ñ`şUG¨Iœ§^²ŒbšÔ¦\Î\Ñ\ËZF\ÊP\à‡$=@\í\\›SŠy\Ñ\äY<¸\ç\'\Ë\Ç\îU%Æ”–\Ğ\îg\ÈqµY\rºM9’\"O\ÃÁ#\Úùr\Ü\å$eMF\Ô\ì\Ñ$\İ\æù\Éş\Æ*M¬C\î\äE’ü`S‚sy\æ–ø\Ô`ŒvªË’¿z”·®*¬@‘”f\à\Ç\Ä\ñ\Ô­&\öEV`\rÎ«\Ş@ƒ{\ó/b\ô\Åş ºdl\ÌÀM\"\íÀçŠ®²ÔŠ|D8>µÒ¾ÁZ³kÿ\0h\ívø6\è`m“\ØŸ\ë_\\,F\è\Ó\éV\Ñ\ğ´Ó°·\É\Î\Óø€5Ë¼F\ğ\ÏD\êK­gB²¶µ\×#Ì²\0q\ï»9\ã½b<:\ñP\İJ\Ö7*m®¢m¥H+üş†»MSl‰L¬¡H\ï!¨C¯\ô.©h\Ö}Rt­¤hµ3#\ß!ø¯9ø£ıÿ\0gŸ¡–~[n•\ÕdË­\×Lİ§–N=`%“#;BŸ|\çûNg7‰Ÿgu»Õ­\í¿\Û‹\âşø\Ó\"%\á^yš–äŒ¯o‹Ò¼¦SQ\r+\"€\Ôz\Ñ1Ü¸¤,vj$o„z\nSp¼r}½MK°Ò¯5[¸­lm¦»¹‘‚$P¡fv=”\É5\Ü:;\ì5\ã[*I§øu¬E\à\ï\Ôc[ \ô\Å+y®fŸŠ}7¦OR\é;½…ÿ\0»g\ÖB\Ü}\0Ù´ŸûXù\×\n\ê³ÿ\0ˆ]<²=\ÇK^]D‡]4¥\â©„°¤\ğ\ã\ìu\âçŠ\Ú\Ü\èı!wmatû!¼\ÕYlã—Œ\å<\Â\Ôz”W¦Ÿ\ìE\á\ï€}=k{\×O®ø£Õ²®N\Ò\Ñ\ÉŸq\óª\ï|g¸d\Î?\r?\á\ç\ÙÃ¢z²_\ï^ \èM¡\ô%å†£«\Ş_\İ7\È$r…^?\Äs\ò¯K\ôG…d\İ\ß\î±tÆƒª_²\0\âk9n]ş{[!j\ãVû8ıšº†u”øh±´8lXy–\Ê\ß\"©*ƒ\ô\Åmú|%\ğªM\İ/\ÑV\İ;\å&\Â\Öv$\Ò\óI\íù·>µ\Õ\ô/úc_dŠ\ÛT†9\Øq\rÁ\ò\ß\ô=ÿ\0*Õ¬”‚bitL	\ìqI]\Ù\ç\÷¥\Ñb©:\×Rş\è\é]Zì¾M³°\'\ß¾DuWZ\İt\÷\ÚY²Y¤y[M·—anr\Øÿ\0\ó\ë]Zi­:§NƒQµE\ò\æ,¬„\òŒ9ùfª,§m>\ãË‘vG»ú\n\Ğ\Ã\"KSGzng–(Š£ocVºt\Û\ám¿–3“\ÜÒHm„·«o?‰\ëR\àÕ£‹{\ÅO!\ñ\È\õ¤7PK’)J$\Òr|Ì—>\ÜûTI.\Ş\áNûm\ØSœ\Õnµ¨\Ëu\Z\Ån\än,ŒO\ÈsÚ³7Q\ò›\ğ À5F\ó\ÅÃ»É–+…$…?Lš‡w{\ÌjŠf9\É\÷\ïEqh\í%º¦7¯9>¢¢}\ÕZ\òMøpN³\nŸ§¨†W\ÑG\Õ}À\Ù<ŒBŞ \÷ªÛ¹L¼\ò\õ\Z\õÆŠ§%9ú\Ô«\Ø\Ñ\ç,}ı*\æûq\Î\ê‡u©¥¼m+·\Ø{š\Ì]\ê\í¨]™\Ü\í\ä \ä\n¬\ên [\åG(U8\0úâ»·\ö\\\Ûú\×Sºl\î‘\Ç$w\Îy¯°vˆ\Ğüª\É{R\\J¯\ÔÔ˜Fœ •>¹¯•¿n\ÏüNÑ¼C½ë…»×®z^\ö1w$zeÌ¤\Ø\È\Ş\rˆrœ¶y\'¶+Ä—sÕº­\ËC«u±y(Êº]\ŞJ\íÇ¦	ªË›‰¤Ÿ-#Ÿ}\ÌMnü/é¾±\ë;\ÃLiwú»GÌŸsŸ`\È\ä‘À\î;×¡´¼u\ğ6M\ÖúŸQ\Û@€3\ÛÎ¦\òÔ¨ıÖ\Ã(`\à\ìE3ÔS\à\'\Úq\å^¹\Ò\Ó\Â^¼?\ï:Ÿ§-KX]JOy\íÄ¤“\İI\'¹aÚ¸Wˆ¿d\İS¤\å–~\ë>\ë%Ae¹\Òu\Ëx\å\Û\é¾	]\\1\ö¾µ\Ç\îz;[´b²iwc\×\"\"\Ã\õ[$”‘Z&Ã®¤\í\"‹´€d\ö\ÏÒˆ0\ÜŞœbºG‚\ßg<}\Õ>\ãÑ;s©\":¬\÷Íˆ\ímù\É+aF\Î\Ü\î p\r}\ğSû\":sA–\ÓP\ñ+¨¥\ê+…¤\Òt€m\íws•iN$q\óQ¯px{\áDøUb-zG¥\ô½-¡Y¬­•$p\ç\Æ\æ?6$ÖƒT+ˆ¶OzÖ±\ñ\ä\ò\Ëø»\ËÏº–/¹\Û<}9\Ñ]Ihä™Œ¡l}N\çüG\æsYiúkB\ò…Ä\r{¥\ÈH¶ƒ\ë·a\'ø\nÁ\Ï\ö’\é~‚\Ôu“X¬cqa3M,c\ÙVN0=²>\\× \íe\é/ü>\áh5Î™\Õ\"Ld€G·¡Vv\à‚+}\öU\é†\Ò\å²\Ó\î¯l‘Ú»” >„€8ùš¨\Ğ>É¶:<±gRO*3œ\Å¹9®›e\áNZ¤~e³\ÜÈƒIdlÿ\0Q]xC\Óº¥‹\Û\Å\Ì\×‘š\ÊjŸg]6\âg–\ÓQš\'+€³(p?LVOX\ğ\ó®:\"	%\Òn\ä{dBZ[iİ¶\àq\ğd#\\ÿ\0¤ş\Ú\ß\ìoWiı=\Õ\÷RÓ®¤¾¯´#Z€\r\Ê27qœ\äŠ\öL\Çs\nK¬‘º†WSÀ\ò4º:„\ñ¥šN‚¼´™/^;U\ñ°_\ë_\Z~\ÒQ\é?hÿ\0¿\Ã\"¬R\Ş\Ïf\Ç<\Î\å\Ç\ò­¯A\õ\éi£º}ºE\Òl˜±İµ¸Ã–k­u¬wpù\íeu\ó–E\ä##\Û i:\ÄVNÍ·°Ç½^Fùb\ä|Œ{Sr\ßI\Ã;v\Ë\Çµ\Å\ä\×>\\.\Ì\Ñ.~\Û>œS\íµ…eˆyl7/¿µcu^¤+r\æY\ç €0?1RTE\Z	K™/%Ï­T¾¶ºyL#e\È\Æ=}³U7E\ç\Ü\ãqa\Ü\óšEƒ\íŒ\ñ—\0úŒŠj\öv°½‘Uc\Ãd€q\Ç\åP¤Õ®\î›z:7—ê”½+R2°2 \0q\ò¦µ	m\âº\æ?=\é‘x’\î\Ø\ì@ÿ\0¦$]\ä308\í\òª½KT*Œc`\\zf¨&½iwn\Âı=j¹\î‘¼\×Ø\ç\ĞVOS\Ö\Ú\ògŒq¶g¿Ö£G>\íÇ¡¬Wˆ:\ÆZ©\÷\'½\Éı™úX\Óo\á, #N={\ç_Ul1\'Ò§©\Å/¸®eã·Œ6~\èZ^½ªX\Ëq£O¨Eeys\Ú,œ	X\ê3y\â“¬O¢;\\\ÙZ®¥g(-\å‡Á¹8‚?r­SÁ\ï¼XÖ¦ŸW\éM\"\êúR››EYÕ½‹`>µÿ\0\ì\×\áF‰~‹sĞ?nˆ¹\Ë\Ù\ÆF=ùı›\éŸ\Ş\Ö}?\Ó6z_N[¿ş0,aXQÿ\0\Ë\ğ€+ø©ı ı;\ÓS©tŞ‹\Ğ0kvVµ±»\åaW*pJ¨F\ã \÷<×š<Mû]\ô\çY\Ë ŸÁ•–\á\Ç7W\Í#I\ò9\Ë\'\õ¯9\ëZ½»¨\Ívº=¦˜’¶\ÚÅ¦X\Ó\ä;\ãZ\r|-\êOu8\ôş\Ñ5]Jÿ\0+¼Ø™Œ{³g\õ8¯~xO\ö\ñŸG\Ó-\î5]_¦µ‹ı¤½-\ÖQ.§\ã\ğ–\æ3\ó¸ù\ö6>\"ÿ\0eNøƒ¦½Ş…bş\õ.\ÂZ\Ö\Ú\ğ\ê:D¯\É8İ‰“\'\ò\÷k\Æ[ı›~>\ô¶¹>ŸDÍ­\Åø/´»ˆ¥‚U\Ïu$©»0\å\\“¢|?Ö¼D\ÕÎ›¢Ù›©V;b¶ $sÂ¨\Ïs\ë€2H\Û\ßf_²\'‡\Ê\ĞkA§\ê\"”u\ÛA“a3c9M\ÅY\ĞAf8l\ğ¾şı\Òu¡\éN–‚Ë§º:Ç¤\ôkPD\Z}…®Ô{\ğª y8_\Ì\Õ]®«\âR\Ì\ê\í-¬&0GÍ†1ú\Ó\Ú\×@\õÜ¡Z\Úúş\Ü’\"¹\ö\ìp\ß\ëPú{\Â^£½\Ô\×\ï\Í*\Ä\ÍûIf%@<’[ş½+Ğ¶–\Égo1€±Æ@\Æ\0§qš\à_iÿ\0³%¯Œ95Ş!±\êx?k.\ğ\Èq\óÀoJ\óA×¿gı[R\Ò$I–İ¤\ß>‹:+¤r\ç;r§š\õWK}¥a\ÕRA¢\Ïn\Ñ¹\à|©? ÀÖ¯n||\Ò\Ö9~\ï¦_M*.\â¬x\ô\äY\ïú\æu\Zd\Ä[HŒYG¾I\ç\ô©-\ãOQZ[4²\ÛÚ¾6²c\èr1B\×\í0,®z¶“º5i­œ{\íoNü\çÒº§G\õ\î…×¶Oq£j\ŞÀ–q$D\ö½\Ç\ò5\åß¶\'\Ù)º\Êê‘²İ¨\0EŞ\n\ñ.N|\Å\×\'$z\ò}NYû\õ[é·šJ_^\Ëw£Ál7ˆI¶\n8T$†Q»Œr{\n\öX\íGB±ş G\÷‰4X³µ\è\Î\ìFF#Fo\æ|IûG™¯\õI\õ#°\Ë\ï\Ş\ê{\ã\åƒRl¥\ZÆˆ“n`ê¼¯¸\ô\Ï\ğ5¾\ğŸ\ÄÀª:cX¸Øª¥,\'›‚Ş‚3ı?J\Ş\êp}²m+A\"Ÿ\Ñ:´A †\ğ\0ı\ãW:Šˆ\ãd\0¬Ÿ€úU,ºœÈª¤Ÿv54\ë†k#¶\é@\Î`ŞŸÂ°\Z\í\Ì×“¹m\Çé”˜EŠUe\0sŸZ©\Æ	nD‹û0ƒ\ğ\Şú\ÔBT·\ä3=¸^w/¾_\õ\íZ]#XY´”P_ƒ\åIn\Ã\ØT9\î-š\ç3;d \ã}\ÍW\Ê\övA\Öƒ’rA\ìj¨\İG4‡$†ÿ\0)\â¥Er.#&N\ãŠD\ò[\Æ;\Õ\ë¨´!‡Ç·z\Ê__HÒ€ –oÅZ‰=Ä–Ñ™$\Èş•\ê :„†\Ş\'+\n\\w?J¬†d\0|E˜~=ı\Í.\âù¢\åc—+Œ{|\ëœ\ê³6£©\"\ä¶\÷\n?3_Iş\Ã\ğ6“\Õ¶\Ü( Ú½»\ã_Mt\é3|…X¬”\êœ\Öc\Ä\ït/º2ÿ\0¦úŠ\Ï\ïºU\Ş±\ï(x ‚ ‚\rrn¤\ñO¡|=\ÔJkS§\é\ZŸoj·KGR\äqAª/¨¼;\ñ&ü[t\çZ\é\Z\Üc\ÌQ¥\ßG$£\ç´*WTøo®j›.\õ;¹5\åvğ¾…—\×ş¸¬\ßRºxuĞº§P\ê{t«g“¥ˆ \ç–\'µx‡\ìµ\ö;¹ûB±×µ©t­[¹\ÑM;g\â9`T.N9\äz\ôÎ¯ı”şj°	4\îª\×\ì¥#¼¢	Tş[\ó§zSû*ü4\Ğn£¸\Õ5mc_\òù0K\"CıB\0\ßşª\ô\÷A\ô/NøI¤&ÓšE¦‰§B¼$1*Œå›¹úš\â/ÿ\0iCøc­K£hp¿Yj\Ñ%6³¶ˆƒ‚˜9#\äù\×>\ÒµcPk\ä[\ï\í\Ğ\ä\ï¶\Õ0\Øhù¯Ht\ÛÂ¹\éØµKwı¸.\ÑÉ§ê©²da\ë\ÆC)\à‚\×<\ß\öFû*^uİ¶£¯ty\è\ßlÈš×§\ïP‹\Íbu8I.\÷”İ´ş/„cnAúki\rºCoC\n$q¨UQ\ì\0§°(b†\Ñ\ÏÎ€P(\èPª. \è}ªX>«¥\Û^H£,‰\ñ\ì½f\îüé«ƒû4¹¶_\ğ\Å/\Ãú04-|\é\È.Vgû\ÔûN\à.>üZ‹.\Ñ4\ñû\r2\ÙO«4a˜şgš•6ƒ¦\Ü\Äb–\Â\ÚH\ÏZ%#ùW>\ë¿4¨\ÓnNŒh\×\î¸Y \Ë?&L\öúb¼Öº¯_ı›üMŠ\ê9%\Ó\õ;y°1û¸·‚pwF\ê}A\Æ0G@¼\ñß§üp\éˆ\õ\r6eµÔ£o4¹$t3T8Ê·¨ïƒ:z]¤W¯v–Ğ¥Ó®×Pa\ìOsR\èP¬\ßY¦,®fÊƒ\rË‚İÙ\êkã·\İ5\êZµ’ª‘0%}‰\ô®i\Ğz‹&‘gFcm\Ş\à\ãùI\ê­:b\æh£Eep\ãº7~\rt\ï\r<TG\0\Ñ\õ\Éÿ\0\ò´†\á¦;ÿ\0\Åü\ëU¨ fe\Ú=3C§º¾M1›©–\Ûÿ\05+w_Î¬µ[Á\÷a,«v-T·\Z“i\ñ†FÄ‡’MSÏ­1»!\\¸a\Èÿ\07­—¿x_Œ\Çjf8\ãf½‘r7=şc\åI”\Û\Ü	w§™s3Ÿ§Î¬--î ´K#ÇŸü\ÈøqùT-HOp»r\ã$S\"7r\ÒJ»‡;æ–‚\Ùdÿ\0r?\ÅQnX!f\0\È\êø\óªo\\Dc‘§\ÄH;W\ÛÖ¨#¹}\Çq\ËzƒL]jI›\÷À\ïX® \ê“t^y®pXúı*’9Áªmº\Æs¸mÀ\ÎER\ëÚ†\ÈÊ®;bªºÀ\êıac7\"¾\öúk\é\'\Ù^‹\Äh\ğ0¸{p+\èş–\àÛ¯>•b„š•8æ–:)#$€ÀŒ\ãŠù?\âï€½y\ö¿ê¾¢_\ï\í&^©è«¹4©…\ò˜\Z{b\Ì\Ñ1(¤de—·¥J\ğ\ïû0:©´¤¾¼\ñ\×D×­}±°·’O)Á\È\"]\ÊG>¡k+\Öÿ\0ho´ÿ\0\ÙÏ¨¦\éş¡\Öe\Ô\"´\\Ewq§\Çq\r\ÂvW\ì¿3Ÿz\â>)} üK\ñú[K \Õ.u‘¼4\ËXq<d\"¹¹\Ç95\ôÁ­N?²g\ÙKL¼\ë8\Ö\â\Õ^\âkH¹—Ì•\Ë,@\ŞÁ\õ¬\Ú\ÈD’_\ÖkUbVÕ°XzD¦j¿¨¿µ£P’\Ñ\×K\ğ\î\Ş\Ş\ãIu©4ªü+\ä~b¼\é\âŸ\Û{Å\í.4ıC^M+K¸}–‘¬§\÷KX‘85Ÿû9ıŸz“\ÇŞ²]#J‰\ì\ì!K\ÍRH\ËC‡#‚\Ç\Ğ\õ¯©^\Zıƒ|$\é\Ş\ßQ\Ò&\ê\åP\òşv\Ü\ç\×\0U¾§ıŸ\êWm<:~£§+aµ¿p™\÷\Ãdÿ\0\Z\ô¶\ÑĞ¢È¨\Z\öªš6‘wx\íe¿?O\ã^\\\êOµ\õ\÷AumZ\Ç\öĞ®t\\\ãr\ö\ö8¿¿·¥º\'­tºj\Ë^Ğ¯c¾\Ón\×tr\Æ{pTB B*\ö…\n(P®eã¯º?½0\Ö7{l\õh6:š /n\Ş\ß5>¢¼a¤xÖ¾	u%¶\Ûy\í3º•¡b„6U‡ c\Ó\ò=«\Ş>Iª\Ï\Ğúdú\ÍÌ—W\ó!‘¤”\0\ÅI;{—«¡Bª:’\Åo\ô«\è™w	-%ˆŒs†\ò›\Å>•’\ßÄ½_G•DOi;*L\ç8\\\áx>§Ö¼\Ã\Ò7GN\Öú‡J(š\Ö\öEÿ\0\n®\ã\Û\õ­f¡o$ºz\ÆÛ¾,nSık¬[Ï¥\Ì.`2$ˆ\á\ÕĞ•*ÃAƒš\é>ø½ı\ó\Ó5fT¿Qû;‰S\ë’}mµH¼\ô§z\ã9ŠsI\ê	,\à[mB#%»+…\ÜÉ—\çü*}Õ¼WZ²\Æ@\ÆÓ¸v¬\İÕ”–×‰$H\ÌÏ“µG\á4Ì·R3˜¤¬;\î\àŠp\âD]\î(\ò\Æ\ã=\ê5\äu\Â\öeÁ\ïÁ­ ¿\ŞYØ¨%’’\÷\ñ¸RP¨\äUEÕ”1\Î\÷!\nœpwª[«\Ø r%³s\ÕG«1VH	X\ÏpO&©¥\'!eRT08\ô¨:†³il\ÌÄ€üLO\'\Û°Z\ÏQM¨\Èbˆ4p\ö\È\ã5Zc T¨\ò\à€NO­.\æo»F<\ã“Y-^\ë\Íb3=\ëk\àF“\÷¾¡š\è®U1~#\ßú\nú\ö^±•üA‘‘ª`1Ç­}\Ò\ã\Ä	\ô«xc©±\'\ğ®#\â\êh\n\ô¿Yø‘¦\ô\ÜW\Zœ0}\çQ[<E%\äk\êÍ‚	\0“’jù\ÓÖŸÚ“\Õ\÷šƒ\ÃÑ½;e Û±\æ]D›¹³\ãT~†¶ÿ\0h¤úÖ°šO‹\Ø\Åkt\Û \Ö\í¡\Ûi\Ó$Ÿ\Ş^¨\õ¯WtÇ‰j\×y¤k}+,’ÿ\0\ç­\î-ÃŸ\ãš\ó\'\ö‘x\×\Ò:§†\Ö]%§jÖš¶±=\â\\²™eXQs’\åIÁ\'€;\×.\ğû;º›\Å˜³\Ö\õ¾¡‡¥­¯¢AjÖ|\åH\È.(^nk©\İÿ\0d\Í\Öü\Ç\â4^Y?ù(‚Gÿ\0›Š\è\Şÿ\0fÏ†\İ\r*O\Ô2\İ\õmÚ\Ûn¿elÿ\0Ñ¯$|™ˆùW©:c¦\ô’\Ó\ãÓ´M2\ÓI\Ó\ãü\Öpˆ\Ğ~J\0­Mœ»9\õ\ÎkC\èxÁşµÎ¼Y\ñ\Z\ç¦Ram4Ğ¤CixS\'qş‚¸ƒ?n5^¦¾\Ğz’\Ş\â\â\Õ$\Ä\Z¬qŞ™WAßŸU\É\í‘^oúk\ËVK¹$,2\0…‡\ë‘\ÅPk5\ÅR5ª\0£&K‡\ô\÷Àÿ\0Z\Ì[}¦\Ô^ùe\rú##\Û1R¿<ÿ\0:Ÿ\Ö/[k4\ÑX\Í-ZR@\õ¯œ\Ş7\õY\êË¡j\Û\ç‹r\ñÀ\ÆxÎ¥}’¾\Ó\Z¯€ıO,R\Í%\÷K\ß0kı(\òûÀÇ›³\Ü\ğÀ\0{>®\ôO]h!tı®³¡_\Å}epƒ#|I‘¬;©Æ¯³C4EÂŒ¹¦…\í»>\Ñ4e½ƒ\ÓÙ£¡Hh\Ã\ğÀ\ìFh\ÕBŒ\Ûª)F$FR2 Šù\ñ\ö\é!k\ãT–…£Íº\Ş#\ã™0/Ê¾vZ›}\'\ÆMZ\â\æm°mû\Ë!\ï#\íûx\Ï\Ë5\Ğ-µ#©\Ü\\;€­#±\n;.OaUZ\îˆ\Ò\ÛÜ¤0$\n\æ\Z«\Ú\\>%98­ŸFx³q`‚\×Rg¹€pwJ\ëš^£k­À’[Î·¸\Èd9\Û\ò4¶‘\íI0;@ı‹/Ò¤¦ºµO\Û\ÇÁ\ä\Ç\ÇùUN¡Õ–J\ÆH$ˆ\ÄdŸ®*·ı´\Ó&A\Zyc<)lƒJ—U¶˜¦\ëˆ\ÈQş/ZWû_m§H¤²JÀq\ñœc\ò¦\ä\ñ\Z\İÙ¶Ø¶\òx`§\÷\ÍC\Ô:ŠûU;l/­SHfdv™¾1üj\õ\ô1®\Üá­duŞ£\Õ\÷H\ÂsŠ\È\Ü\Ü\Ï|Û¥º~\êÂ›üjym\ğH\ÂüıjgŸ\å\ôªb\ïh\ïÉ¬½\Ó\ç>¤\×û>hX\Ò\í\æ|\Ùd2g\å\Çú\Zú[\öH\é\r–—š¤±a§—*\Äw\é^¶Ó \"5â­£‹¤\'—Œ\Öc«º~Ïªt­SC\Ô\Éc©\Ú\Ém2Te*x³+ z7ªWR¾\Ô\õ]z\Ù&Ş¶3”23ÙŠ€X~b½-€u—G¾ƒ¨tFŠl\Ìf0±Z$nŸ4u”üÁ\Í|\×ûL}º\ÇÂ¾«º¸\èı:ë©ºbg-nm\Éq\0<\ì‘$\ñ\ÎrŞ‹û,ø§\ÖúÍŠtn«gH¥\î5(Ä¹,_c=²k\ìŸE\ÚŸ\Ó4\Û.-¡H@^À\0\0şU\ÒM\ñ)üJGT[ˆ•²jjCU•¹íš’•\\^\\û]øš\İ/\Ñ\Ó\Ï\Ã%Á$dû×ş\Î>u-d\ßB	\ód.r1\Æxú\ó^\×\Òt[»‹xR\êqÀ»Šsœ{šª\ëƒm\rœ–±¹H\ÎK\Û\'\ë\\\Ö\ÓO77v\Ö\ö\Í\åÀIË¨üYïš²\ñc©®:c£\Ä1L\ò¾R¬µO\Ï\ë^\Ô:\ê—\×+‘2I‰\Ç&­:{B7‚\ö9Ó’1ø«\Ó>u\r\çKLn´\Û\ë›&U\İ+[1\àq\ğ;`\ñ^‡\é\Ïz¶x¡k°\òH¿’ø½³\Ç}/Œ½A4,>ş<Â§\àŠ%RÖ©\ÏSkº\Æd¹{Ù†9-!Àú`s\\\ó¬ºÑ´ˆœyo½Y\ìA\Ç\ä3U}¸\îzc¬´Ş\êyû§®¤\ß{‘–\Í\÷`1>©\ïŞ\Õ\ï\ÈfKˆ’H\Ü<n¡•”\ä{it(P¡BŠ¸Ú¡!¼Ó›©\Â|v\öR\ÛLGªJŸÈ“_¼W\Ôm\à\ë\ëÏ»©(ªş\à3?•n:GUY\ã\Éø˜\ÖÉŠM\0V…¬OW\ô\ëM	“n¸\à\×8?ºÉµ\ğ¤~ø\õ«=_¼Ñ®Á;\Â\à\ä•<7\å]E\ñG~\Ô\Ô\Æq\ŞTŸÊµ\ğ\ë6w\ã\ö3\Ç>}Q¨Iko»pRr9µT^tı±b\Ë€\Ç\ĞT\ÓV\åˆE|ÿ\0›N.0c\ç>\ôÿ\0Ü­¢‰9\n2*\ö¢E…q\Zæ²º¯YA0şk)\íXûş ¸¿fÛˆ\ö<\Õ[(9\İÏ­e®ÁŒı*Uµ®\Æ†\à=ù§Ì¤zT[Ë€Šq\Ü\n\Ì\ß\Ü¤\É<\Õk\ïøj\ö×\ñX\év\ñG™<¥@=\Î?Ôšú¡\àÿ\0E/Lt–j«´\Ç\Ü\'8®£o\0E%SÒ–#\âQ«.\æİ¾F³=cj$Rø\äŠ\Ì\èwF\Æ\ì\à{V‡^\Ò\Ó[Ó·\Ë\ğµs\Ë[I,®\Z6c€y«\Ø\ÙO\Ä~kU¡_o€FN}*t\ğ\àûµ\ğ7Ê¥\Â\Üg¶9®\â—\Û[\Ãÿ\0\nº¶n¾¸’ú\öÕ¦k<H±±\ÏÀHı\á\ÆGÎ¼g\ö\ò\ë­P\Ó\ôéŒ’¹b\ìb08ü³W\ße\è\Ğ\épMV\'\0‚ÀA^§:\ÓH|‹6Y$O…Ôx\àV«5‹«¸Á–$UbB¨?Öµ¿fn™ƒ«:®\í®,Õ¬¬c\ß -•f\'\á~§ş\Íu´GÙ»K\ñS u+]&´­qb-k,J€\ÈV^\Ø\'\×\ß\ñU\Ò5N‘\ë[»;«9’ú\Î\á­\îce\ä8l0#\ë]§4Æ¾d6Pº6T°>™ü\ë\Ó\ŞtLk§[\ËxIş\é8ık°Yh:u¬j\Âİ—¶NO\åV–\Ò\Ù\Ù|^B&}Oø\Ô]_ªmm-Ü™·`\ÙşU\åü@KFx\"?³“‡±¯>k–\ñA}\÷\È\"D\ç\ã;‘\ô¯aı¾\×:¯Fh\ğt\ÏU$ú¦Õ´»Á7\Ès\ğ\à\ò\è>c20½zg­\ô>¯±K­\'Q†\ê6\Ú\×^3†C†˜«Àr2;QĞ¡B…eüIÒ—Z\èıN\ÊH¼\èg·‘~EO5ù\Ø\ñ¢Í¬¼L\ÔtûÀ\Ö\íh\Æ$\Ù\ZüD2ÜŒdú\Õ\×NM-‘7\í\áXg¾g\Ó\í.\Z\æù~u*\æ\Ü\Ïl\ğÈ©\È\à·z\æıUÓ‹$›{/¸\ô¬=\ÊÏ§Kµ‡›\ñ.\Òıe_…\÷‘\ß=\ê\Ò\ËPx\á\ÄW\Õ­·V_A±¼\öu\ğ¹\É5cˆ7\\ù¤‹\è=E?ÿ\0„Yc\îüıj5çˆ\ñ\àÀsşøj‚\÷¬¯¤9@‘ƒ\Ûhü5A{ª]]¶\é§gç±ªù1#\ä\÷¤\0\ì\ß\0\çŞ—›HrHc\ì}*RÀ‘|9\0\ğÒ˜4\ï”8_zuˆ‡{š¤¿¸\rœ*¢cqV}\Ó\÷=U\Ö\ZN—iK5\Å\Â.\Å8\È\Í}ˆ\ğÀ	zn\æÁ5`·P(’`\Ø%\ã\í2+\Ú:M’\ÛZ¢¨\Æ\0b#§U(\ö\ÒOj\àl\ï\Z5<#=W¥\ØÃ¨\İ\Çw¸\à‘ßHŞ•€û-}¨¦ûL\ôF©6©§[iºŞ“0Št´rc’6kÜ\Är}+ Kp “,BŒ\ñ“R\ô\ßº\ÇP]û¬´;MP°O¹Ï¨D²n=†wùT¨´Hf[ˆYdC\èÀŒ{\äTX&VPZ\\\İUcÒ¶’^\êw\Ø\Ù\Â7¼\÷E3š\æ\Òÿ\0h‚Q_µ”R\ìÀ\í3Gc;ÅŸø‚\ÔSºÿ\0\ÛwÁMOm\×v7™ZG$²ı6\Ï\ë^LûBi5\÷T\ØO¡xme6‹e*•›Y»À¹u\õ \ÈL\ó\ñO\ÈWŒ¡%\Ë\Ë4\Ò4’\Ê\æFw9,I\É$şu\õ\×û@şÊ—¾?hú\÷L[[ÿ\0´ºl\ÅY*}\êî›\ï‚3\îj¯ÁÏ²ÿ\0X\ô\×MÁa{¥C`\ŞR©HŸ\02~k¸\ô—\Ù\ål¡¬j&IsŸ.\Ğ`\ìX\÷ı*\ãXû;t¶°‡y»GÛµXHhúZ\r¼2\Ó|2\Ó.m4\÷yš\â_6I¤P\à`=\õ5®\Âk\Êjo±M‡Œ\Ó\ÉÔ½=\äi\İRB‰–Aˆ®\Â\ö\'¤€Ş½\ËÊ–¾\ë½ªv\êº}İ…\Ì2\é2yj\è?yOf\0`q]7¥\Òù\ï\"YJ\Äa\Ù}I\ö°²\Önn/q3b9!\È*=\öú\Õ\î•\Ò=Cz\Å\Ò\Æ\ò\í1œ¬Àƒ\í\éY~¿\è\íwH³º\ó´‹\èce,dhX\0¸\íœcøúW:\Æ\â\åu\'‰\í\äkP\Ü\Ù¹$Œr8ªH\ôû¯;\ËDYcbW!²\ç]K¢´»&-m¥ªJ›~\Çn=+\Ò\ŞtÎ¹ªj\Ú{^G0½¸\Â0±Œ’{p{^\Ò\Ùm-a…3¶$2rp?¥=B…\n\ÜÑ¬\Ñ2:\îV ú\×Á\í\ğ´øg\ö‘\Õ\ã\nV\Æü›»w \ò­\Î>x\'•r\Í\ä\\YC•\İ,0EA\ä\í@2O­oúvø”`[<ƒ\É\ô­|%.B26\àx\'Ú«µ\İ.2¥bPTs\\\ï\\\Ğ\ß\Æ;\ò‡š\Å^\éh\å\ãb\î1¸mH\ê2 şú®sW\÷\É*²«©\ö=ªdK»“€;z\\\×	Œ\î¨\ò\Ï^Z£I:º\àp­F\Ò\ç\Ğû\ZW’–aŸj8\åˆpcúSŠ%˜¶f{Ÿz™og„¹¡\"~>T:­\È\ä\n\Ï\ÜK¸‘Q¸¯¢\Ù_\ölMKV¼\ñ?^´Ám].)\÷³Ì¿¨ }|\ñ\ô\ç¥t»—šO\÷’±sº¶\ğÁµ@\ô\Å:\nWj,\æ’\Ã\"¼©ı¥:K\ê\ße}uc\Æø®\í\\gÿ\0X\õ¯ÿ\0eO\Z\äû6\ßk:­Õ¬\ÚÎ•{i\ä\İZZ²«Ü’.ãƒŒ°Á#\ñg<b£ø\çı¢}A\×\öWzoIi­Ò¶3ƒ—M9’\é—ü¤\0lüyƒH¸º\Ô\ï›v\ò“$Œr\ÌÍ\çŞ½a\öcûY\ë^	\Î:«\óPè©ˆ’e\å\Ó\Ïm\ÑyOt\ã\Ôeµo„\ë¦G~}¢}Ù”8Sr˜\Æq\åş ËŒúWŠş\Ùÿ\0k3\Æ3eÓ)%\Ãè–²y³]81­\Ëza{•\õı+\Í\Z@šb±[\Â%\ñÉ«[ş’Ô–™ sœ“P¬t[É§h\ÌL‡\Ë+Sg Aº¤‡{\ä\nı\n\Í\Z½\ÄdŒx©\0qCt(Qb¡jz&Ÿ­C\å_\Ù[\Ş\Åş	\ã?R\Ã\áJ@\ìÉ¡Y‚\Ç\')#Vv])£i¤]*\Î=cAşUh€\0¤Ks\Æ\ÑÈŠ\è\ÃXd\Zù™\ö\ò\é=;¡|I+£Fm!\Ô-Ü°ŒlWİ³\n1\ğ3r~•\çŠ¹’ú\âkY\öhŠW‚	\çJ\õÇ‚3§YYCx¸aË¹\Íz\ë\Âh¥–yL`<h‘\é’Òº¥\n(P¢5\ó—û]ü8\Ğ\õ_mº¶kbº\æ™5¼0\ÜFqº9X«#q\È\à\ì~§?2ú\"S&ª\è\ßË´ûv\ÈV¿@b\×\Ë$ª’§\Ò\ôS›ea\ÍM%EÊ¡Eh\Û ¡\É«+\Ô¦_\n{X\r^,F+;{ ÀU\ÜKj<È¿fù\î?Ò•i¬\\I*\Äû\\{‘ƒü*É®—\Ğs\éQå•·w\ô§’C\åv¨	ZF\ç\ĞzT˜\â9$Õµ¶ŸTşµ`–‘ª\ã\ÅD\äwª¢ı\ÈRA\ô¬­û–-“U\în}\êNiqjıQ¤\é\ó–]\İ\Å…œ)Á\Ç|\Zıø\Ğú7Døs¥\éú= µ´†\Ş8R0s…U\0\n²º\ê+«n®M-V/»\'qOŒg½l\ôÛ©%bŒA\nqœsV\"…\n&\àW¾Ş‘	~\Ëı_Ÿ\İX}D\É_!´\õ\Új7û··}\ÃßŠ\à¯oJd…İŒ­tN”-!O,`ŸZ\Ûy)¨Û¼W\n$VF\î9z\Zâšº\Û\İ\Ï\Zäª·¨\ñ|L û\×R\é«h\í-c\ò\×†I\õ5¥ˆAv%\Í9Æ¹=\ëÿ\Ù',0.000,NULL,'2024-01-04','2025-03-02',NULL,1,'2025-03-04 10:57:39','2025-03-04 10:57:39',0,0,131),(2008,'Anuj Singh',NULL,2004,_binary 'ÿ\Øÿ\à\0JFIF\0\0`\0`\0\0ÿ\Û\0C\0\n\n\n\r\rÿ\Û\0C		\r\rÿÀ\0ˆˆ\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñ\ğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\ê\ñ\ò\ó\ô\õ\ö\÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3R\ğbr\Ñ\n$4\á%\ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\ê\ò\ó\ô\õ\ö\÷øùúÿ\Ú\0\0\0?\0ù—\ÅrV_­cùekK^6«?Ö³KW\Z>)jQ\'\ÍQ\'Jq\ïZXŠOkJi6À¦±‘Šš\Óv2[p7qV\\²yÆü\Ó\Íı\Ú_\á\ÛPb½y¢O™³ša;M\æ \óqM2TšŒ¦\áV\öw9•ø®\ê6ûEšH?»^vªwW¡\è?\é\Zf\Ï\â²e‘\î\æ\Åi\Æ=­Mu¤&#¶\å¨[\ïqS¬|R2\í«±\"‰\Í\Ô\ä„\ÉR¥«úQ`+¾v\Ô.\Ù+S\ìe»T°h\òHs²€¤±\Óü“¶¶Gû:ow—–\ë\óH(°m\ìaN´³‘U~SEß‹´«=Û§‹zÅ¹ø™eb\Ëÿ\0\\\Å,\é\Ò\ÎY*D\Ò\÷u?5p3üL¼‘qoh\ŞsT\Å ¼—\äqû‰E€\õ\Ëm-Ÿ<µ™ª_iº;fYUvÿ\0y«\Î\×û~\ñ6K{p\Ë\İsµi«\àû‹ƒ¾Y>o\ï1\Ü\ÍH±ş#iV¿êœ»\Ó4\İY\ó|X’Dh\í\í%ùº3»j•¯‚\à]¯!ù¿Ù­»?\r\ØB?\Õnÿ\0iªµ\Îj\ï\Æ\Z\İ\à]‡g¯·UH4½kV9É·ıŸ–½\n.-Ÿp~U£§F#V@Ke£ƒ°øoy0W•ş\÷]Æ·-~\Û\ÆÙ‘ÿ\0\à8®\Ú\Ûû\ÄUš\áœ\Ù\ÛN\'5e\à›+Sş«ûÕ¹‹küªÕ´\ëS¤|V7:,AºG\÷FÚ‘—+´S\Ê\ÒR\ÕR¢£,Uª]\ÔÇšD\Èiû«N\rL=iş]W()GJEQLOJr·\ÍKw\Zÿ\0vš:P[š’/™iX.V=*\ÊÛ™:\n–\Ö\Å.%ù\ßb­ZO³\Ã)H¶\ñ\òVª›h‡-Ny\á*\ì£•«\Şc\ä\ÔOü5ƒF©‰\Í7š—m-C•\éÛ9WsT¢=´jQ\éN§\í©>\êÑ¨\Ñ\æ—kSƒsN¡£8¢\Ù~J•Z‹o¼\ßZ\Õ²&\ÅŠ•\ã\æG\ÅK-tù+Y~\íc\ØÃµ\ëX.áŠ˜ŒŠZË»Q¶µ%\å¬ë¸š´±,\Ë\ïS…ùj\æ©\â\Ùiq\Ëj?5J±½J±»¢\Ò&\åa\ÍN{}Â­%«\ç\îU\Ä\Òä’´HMxq^Æ¾\ğDn–¿J\ğû\rÚ®\÷}«^¡\áOY\év*“Î‹´z×©†\Ğ\ò1^\ñ\è\Ë9!®ÿ\0\â\öb¿=\Ü˜®OXı¦4--~K„z\ô½¤O%Sgµ‹š¯\Ú\éipyzù7Wı«%¸vşÍ´švÿ\0e+>9|C\×.Yi\Ò*ë·Š^\Ô9·–\ÏN³x\×w5\ñy\Óş-x³oŞ[øv5\Ò]‹\ä‡s\æ\İJ\àIy+d75\nI¹ª¶ıüŒ>\îi‰!¯1¡wø©\áj¥»–~j\á\éT&5›\æş\íkÁ†¶ü+ı\ê\ÙÓ¿ymVI›*ş\ñª-\Ü\ÕË˜Ê»UWk\Ò\Ô—\ïP•c\ì¦D\\S¢\Ó\åc”\ìo½NX\ëE4y:}µb\ãnsÿ\0ª°~_\Í]×‚s%»Š\ËM5\à¸ÿ\0VÎ‹}g¤£‰$\Û\Íf\ÑeË›6Y[Š4ùg-Hş2Ò£}\Ò\\D«ş\Ó\Õÿ\0‰\Ú^\ÇKL\İIı\Ø\Ójşf„&^M<¯\\Sf·‰W\ç-pz5‡aoh	ş\'\İY¿\Ú\ZŞ y“fzùb¨“\Ò\Úú\Ê\Í?\Ö\n£s\ãM2\×\ïÊŠ\ß\í\Z\à—\Ãú…\óü\ï\'¾\ãW\í¼˜ı\á¨^Š\ß(·ŠI\Ûı” |L»X¿u§ü\Íÿ\0=\å_Ê¢·\ğ­¼+\ó“\ò\ÕÈ´›h\Çú \ß\ïT\ÜK¯kš¢¶\Ê\İü1\n\É\Õ/7y²\Êû¿¼\õ\ß[F‘®«EF(¹W8;²¿\ÍZV\r·½t\ç¥G\ÊZ¨’¤´…xˆ7û\Õn¡n/û¢§\rMvæ– 2E\Û\Í\'\ğ\Óİ¸¦\rH\rFùª\Ôlj¨û\Õa$¦€¿c\'\Ì\È\n–\Û3v¨B\Û.Ö®7\Ë5)—R9*\ÂI\ò\Öu¼›ŠÖŠ-pT\Ü\ôiI*\ÌrnWmM\×1²\'\ó(,*&£i«7Z‚\æ\ã\ËÙŸ\ïSŸ­fø‚cojøs[SZ˜\Ëb\Û\\${Ÿ?\í\Z5\ä‹j\àf\ñBÙ†Iÿ\0wjÕ”\×ûYrSi\Û\óv®\ßfsó¾­\Ò8\'r\Å\\Iº|µ\æ\ÚV±\öUÌ¹VeùY«q|@›’7}¹\ê\ßİ«\öd{C¥\ÜX·\ñsSÙ²n\Ø\ç\æ®TkQ\É}ºKµ0X·µG6±¶û\äsµF\å\÷¤¨İƒ­¡\Ù\İ\êZ\Ã\ò?\İ\ëS[\ë	¯\ï?\åù«Ï®uƒ&Ø³\÷\Î\â\ÔÉµ\ÄWD–S¹Ô®f¶0\ö’;‹¼G´¦[\æ¤O\ß-s\óx’\r>\Åb’@\ó·E©ü;¨I7\Ú./\åù”~\î4*ûW,\è¬n4;W4Ò¿-Ú•´\Ö[\İ\ËO\÷U\r ¸›kŠtœN¨T¸*\íj~\İ\ÕÍ–â¤O–¹ùM\î=T\ĞV2šd¥b\Ğ\"\óRl¨Õ¶\Ô\ß7¥q6Ô¶\Ñü\íQ,2I\Ñ\rZ´·–9T´g\ò­!’ÿ\0g\È\Õ*i¤u®\ÃG–\áµ!\ğ¿w;jX\\\â\Ö\ÛË©\ã\ë]„ú\r´q|\ÒÎ±&\Ò\ßw\ïSŠ¤ƒ˜\ÍxÏ¥Uš3Š¡­x\ÛO\ÓehÌ©\òû\×%\ñj\Î\Ä?û¢µ±\r\Ì>’é³µ}´4±‡28¯+ŒÚ„‰²\Ò\Øûnk\"ÿ\0\Ç+\Ö±\Åo\î«5U‘7=jK«K}Ù‘~Z¯/‹4»Vù\åk\ÅÆŸ\âI³,²ü\ßÂ¿-hYü?½¸ÿ\0^\ìÿ\0\õ\Ğ\Ò\ĞG¬\Â\Â\Ğ-S2]Å»ı“º¹ıs\ã´q\ïÓ‘\ço\öWms\ö\ß\Ö=»È­\í/ÀvJF\ğ[Ö—0¬s7<O­:\Ço–Ÿ\ìı\ê\Ş\Ñ|\ã_&ÿ\0¶\Ë\îŠ\ö/x\'M·²Y\Ş=ÿ\0\ŞQ^©\à\Ëx£²\Â U\İAİn\'D|\ç¦ş\Ìz\ñW\Ô.\î\'o\ö\ämµ\èı”\ôÍ‹$¨¬\ë^Üª?»[\Şn\Z½4‘\å\ó3Ì´Ÿ€zŒ\Ñ$–\âM­^\Ã\àß…ş\Ó\Ù6YÄ¿€ª·?»¹_­vš|\ñU£&u\Úw‚\ô«ku\ò­£ü¨­ûø\öZ)\óÍ³\ğEşg\éK\åûTÿ\0e}¿q·Uøt—’5}˜\İı\ã^R>ˆË†:•”ûÖ´ZN\Öù\ßşù©^K8S\ç#\åş\ñª2\Ò\Õ\ä\è+¨\Ñtwû\'#\æj\Ä*Ó­[\è\ì¿\ó\Ïæ¤—\â–ŸºŠFÿ\0g\î\ÕnÍ¢\ífßŠŒh\ö\ò}\â+‹\Ô<q¨]|‘¢\"ú±ù«95MRA¿\í2/û¢€=z\ß\Ãú|6û\÷\ãubjZ\ö—§»\":¶\ß\î\Õ\ç“ı²ûi–\âiß‘ªHt·aËŠ\0\é¦\ñ\ä\nÿ\0»G\÷F\ÚÈ»\ñ…\Ì\Í\ò _\÷Q\ZZFÿ\09\İV¢³?\àQ\õmB\á›•ÿ\0tUı\Â\÷\Ú\ó¹w‘—¾\çjzF‹\ØWi\à™7F\õ›eœü?Å»rÊµ£m\àûx_2’\íş\Ï\Ñ\Ş6×ª¾cúR+C¢\ÚC\Ò!VE¼P·\0/\áJ$¦M\'\ËA#\Ö1N\Ú*(dùişgÖÀFš\ÑÓšO–¢i>jz€\ô§ş\Z¯\æTÚ3hV¥\ó*³\Èw\Ğ\Å\ëH\ë\Í26fZs\î\Í\0\'—Iµhf¦·Z\08\ÍJŒ3U\å¦\Ã!\ßÖ€4Wş>#5vVùÖ²šŸ7zĞ¼ùB\Zl´_…¶…­8dùkİ‹VÍ²\ñ^}S¾™>\êš¨\ö­IW1Ô‰vü\Ôâ´©†Zw—B”®0«\\\÷‹o‚\éÌ™ÛŠ\Ú\Õ\Ù!Oœ\íZ\á\õ;Á¨j2\Ä~\âF\íş\÷\Ë\ò\×u4r\Ôg{3ş\ödù™F\êŠ\ï\\“û9¬\Üÿ\0­™\Õû\ÉFˆ•ş]¿\ì\Ö^©x\ö\÷şg*m]µŞ‘\Ä\ÙĞ¾¸\"y\í\Ïò«¯\Éx^X\Î\Åc\Æ\ê\â!\ß$1§?-]\Ôn\Î\ÑG\İã–­‘\ÖiÚ§—\ç¶ı\ï)\åş\ó*ú-Y“X?0\å¼Ï”\ó\ób¹M0Ùª¼ÿ\09­o\"†ew;›²Ö‘$\ê/uAnVwÂ®6…¬I\õ§¸3?8?\'µa\İ^\é·\ï,ˆ\ÌßD—œ\îÚ´\ÓCtŸhYf¸/´.½]VŸ¬\\^\"Âƒ\Ê_¯Z\óx\õ(\íCH›—«¹Â­Po]\ÜL\Éo¹“;|\Õù?ïš>…Ò®-\í\ág¸¸\n\Ê)\'×¢„e\n\íş\ökÊ­¦¹… \óeÚ²\Æt‡\æ\ÅVmclÏ™w¯e¨t\îk\Z\'¬\Ûx‚\ÒnP•ûI/\Ù\ó*c\ï/İ¯ ³º’\òuŠ/šJ\î4I.m\Â%\ä\öˆ\×\ïb²tQ¬k3\Ğ4»9uŞŸ*ÿ\0y«{Oğœ—³ø«˜ŸÅ$Q[\Ûyv\ê¿)f;˜\Õ\ËOK¥Ë½.dœ¯]\Õ\ËR)\Õ\n·:ˆü\å\İ\ì”üµ¨ú.—e\ò#?\÷s\÷k\ÈüC\ñ{Wºv‚\Ú\Í\Ön\Ò1\İ\\\ÌV>5×œ<È»\\¼¨ßœ\÷Ûs\ÃúZ7™<[–¹|P\Ğ\áuû;®\Ú\à\ìş\røR\æ\î\âo›ûÆ®M\ğ\ïO‰e–Bş´\Ätc\ã\ävê–°<\çı‘\\ş©\ñ³\Äz§–’F¿\íWYà¯„¶w‘/š›ÿ\0\Ù\Íz^™\ğ·K±‰@·F\Û\íPU\\\ñ¦¨\Ûü\×Oø\êK\ñN©\Å\Åı\Çûªv¯\é_Q\Ù[Û°\è¿/¥pº½ª[\Ş0D\n´®R\â\é\ğ\Î\â\á”\Ü?\Íİ¾\õkZü5·‡ıa\Ü\Õè‡¥U•~jw<\ğ\ÏJš^$~?»]}\çt\Ë;6\ò\í\ÑvûUoI\ò²\n\ìo#2[?Ò•É±\â\÷ú|V\÷ˆpi‘F+K^‡É¼z ”\\,2E\ÛV-~V\Ç\é\Í>–‘\'¤xja&ŸÏ¥u~\×-\íeû9o=+\Îü?¨$pù{\ö\Ól4û\Ë\ïA,\ò\ó\Ízg©\çâ–‡¾¦$E\"µ´F\ò\å¬k\Ìvˆ\Ş\Å_³gY~J\ö\Ææ¥³x|\×A¢j‘B‰’+•–\Öy“y­M\Ã\ò\ßJƒv\Õ\ïT&J\ÇVÖ¶\ê7†j*=7\áİ¿–¯&\ZŠwG5\ÄC®nV)¬«ü[6\Ó\Ä×°¯\îm\â_ú\èKWµx\ãÀú~—¥J\ñ\Ä]‚z\í¯{?\ô†M•\ä¦}(M­jwŸ#\ÎSş¹\rµWû6[‡\ß!,\İÙ\æ­Å³\àŒU\Èt\÷Ù“Ê¬ƒ\rt-µ~\ÇKŠ\âM>j±q—\ÅK§|·Ty´\Ø-\åÀˆP\ñ¦Ïº´µX\Æ\õ5š\íR\r–¼\nª\ÒG\æ#U7\Ëj\0J@\Ûi\íÓ¥Gø\Z $\İ\òWMà«ƒº{W.ŸC[¾o\ôü•›­f\ÊGQ}6\éj¶ê³ªGµ\ë9¤5cu2N•\ëNy8ª$XÚ¤ª¨\ß5LdùhVùªm­M\Ü\Ô\ß\õ†€-&6\óVbûµŸ\ót«1o\Û@}¿5B\ñÔ§­=Æ‹*´\ém¨„e[\ë…;*l\r&\êo™IM+TemÆ’ı\å=\"\Ü\ê)\óÛ¤%v>\æn«ı\Ú\0‘×¡\÷­+\Æÿ\0EŠ²\Ê\Ôù¤³Zv)¤Ÿv·,\ämµ\ÏÛ¯Ê¿İ­»)+†¢;©²û53qZkÉ¶3p¬9rxnZ¦:€~z \Í\å¦j•\Å\Ôp\îy\åU~\Ñæµ372‡uGNiIò¢¼\óD\ñÖ¼\áwm½\ò\Õÿ\0‰>$K\Ë,\àM»dVgc\\e½\ç“o)\ö¯BœlrN|\Æe\İ\ÃùÒ»Ÿ\Ş\ò-dkz†\ë\çzU;›\çš\îw-\ó9ş\ZŠù·]¯\ÑkswL¨\ß#\í@7\Zd:Æ¨¯&~Î§\îÿ\0³L»o³\é©\0ù§ı\ß\ö†´!µ\ò\ôû[x\ß\ç•\÷<‹ŞXÓš\ôC\÷_»\Zÿ\0³Yix\÷\í/üm¬\ï^=,\â?0ùv­J“}­\Æ`ù\Ûıª«“b\á‘,`D\æ\ï¸\Õ#ª‡m‡r\'V¬½ST{É¼¨\Ç\î¾\î\ï\ïT\Ë—l–ø\Î\ço\â4\\«¦’[\Ëe2\ê\ïÿ\0\0Vk‹¬²şşPx_\áZ§\n\Ïp\ê˜[\Äıkj\Êş/½L“B}P\İIio©\éc\æ6^P‹ş\ÏŞ¨’DŒS¦¸HWs\ÑrlkCªA¦ºùI·‰?‹5v\Û[–GWyY¿\öZ\â¦\Õ\à\á\0UZ–\ÛVK0\Şj5Â·ü³\Î\Ú\n=&\ÓZ·~_šVş/½Š\Ş\Ò\õ\ëK‡\Ù,§\åş,}\ê\ò\Í2ø\Ü:™mba\ë\ò¢\Ö\ö‰¨hQ\Ş0\Æ[…ıï–¥®bÓ±\î\Ú>—¦4\ÑH¢7f\Û\ó5zş…§\ÛGyqÆ«Šù]<Ya£¤~\\’3Ÿ˜Gù¿\Şj\î|-\ñ‚Iš+qU\ï+>\ßüv¸jQ:©\Ô>ŠbV\ãC_9,W?¢øº\Ò\ò\İ\ówù~ZÜš\â;ˆ\ç\Ü1\\-wF‚\ñË§½wU\ç\Ú\r\Ävº“\ä\íZ\ìN¹iÿ\0X*Mv\õU\æ(Ë½®¾\ó\Å\Öj¸\\F½ªG}s”-AFctª\ò}\ãRù•\ÒqT€\é|tÜ²;®\ò\çR·XXo±^K¢³\Íx¨‡n\ê\ï\í´4*\î\æ™,\â¼M‰/Š\Æ\Û]‰\ìş\Ç+\n\æ·5&~”°\ãu3øiª\Ü\ĞL›\Ã\Ö?l¹5\ê\Ò\Ò\Ö\á¸«\Ì<\'úz×ª\é\Ş\ñr~\õvaŸ¾pbW¸w(¿-Of¿\é\õ¨!o2%9©\íşY—ı\ê\ö\Ñá’(k_Â´<+\'—p£Ş³\í[Ì¶ü*×‡›Ë¼Á\õ¦c\×\ì\ã\Ş?¥• ke\Ç\ÍE#\ò\Û\âºI¦J:WƒMgr6\0¯ø…\ò\é\Ï\ô¯\n\Ş;u\ë^D\í²¬pı*c\ÛKI/Ü­S È¿_›5VÙ·L¸ûÙ«Wqü­T\ìT­\ÒÕ±~»¡ÿ\0k7\Ë[·Ÿê–¹Û¹?x\Ù57\Ä^MA\'ß¨b›\æ¦\Ï7\ÍOP.›z\Ğv\Õ!p*?9½M0.3\"Ö·†$=Q9?5s\ç\æ{Eı\İ\ôOŸ”»R\ÊG£\ëQ…Ez\Å+\Íu\Z”1É§#û-s\î©PQ\å\î©>jÀŒmª3*ˆwv§ıŸuO·i©GJ\0«\ö\óŠc\Ç\å\Õ\êk\ô \n#­OsKå¯¥I\Zü\Ôp1ü\ÕGµ¸«;h\Û\Í\0F‹R\É\îªD¦û9\ÙU¨¬¢ -\óV\Ú\è\ò\Ü7\îĞµ[‡Á\×r\Ë<S±\'2\Û\ØTK¿\Í\ä\×s€\åo™şJº‚8\ZYdUX!v\rZF~Ç³5u?c\Óü†Š4«\ò»v¹û©O™8T_\ãc\÷j¬\ÏEH³«Z–ú‘\î‘\Ü*¨\İ\÷«œ—Ç‘\Ù\Â\Ğ#™\Îß¼\Çj\×1\â/\\_W‹)»\ËS\ÃµR\é#UR\Çss}r>e_ûæ³Ÿ\Äy¶;d\Î\İ\Í\\¥©-\ò¬Q Š%N;˜ÿ\0µY\×(‹K‹\÷=\Ã??\İE¤©\"Fv:Ïˆ%\Ó\á•<À\ÛŠ¹\'\Ô6\í{5\Ü3\ífù±\\­\÷®\ZTvÿ\0r}\ÑT¤¸’A\æ\É\'\Ï7\÷~\è\ö­,‰\çb\ë\÷‹u{ß·øŸ\éXºÆ¨\ñ\Ú2DG\ï>Qı\íµn\ædt\ãÕ«U\ó.%‘şTO”µ@#8o\ÍhÀÈ»e\r\ËÒ¨\Ë ^”Æ‘\î6G«hF\ÒG¸»ûA\Î\ì\ñ]D,-\ì\Ş\à¾Xùıª\æ-p³.Ï¸½*ş«y\åÂ¶ü¯\İwúÿ\0\n\ĞD»k‡\Ë>wS\çºvVD˜\õj‰\äùjKkt“q“\åA\÷¨\ö»x>oFjÑ´\Ù\æ}ÿ\0¼\ÕY$û@\Îv¢ü¡V­Zş\í·b€6 ]µ+\Ì;‹İ«.k\Ï%x\Íf\\\İO©?—\÷\" \÷ ùü«s¿o\ñUTg›\÷’\È\ì\ßZ„Im§£\"\r\òÿ\0*ª\÷!ş\í\0iKuü\ÛWıš-\î3\'Ì«ı\ê¥mİ¿5¡m\äB\ë¿\æj5 ¼—Q]…6@\İ+r\ÊH­\Ç\È»5dEt$\Ú\åa&Š9Pq\çuXŞ‰\áÿ\0í›˜\å‘ÿ\0pzÉ»«Rµ\Ò</\nI\ö€\çjF§{±¯%Ô¾\"\\1k;\'\Ù»—\æ\ßW<=1¾•ä¿¸•—\ï~\÷\æ¤\Ğ×º{ßuK\ÅùE-Û…z}´š¤\ğŸ\'û5\à\×\"\Ò\îbx^\ÛN\ÜW®i\ß\Z¢\Ò\áX\î#ƒ\å\İù«¥#²\rXmn\äºd\ÉW\Ít\ö¾¸™\å¸n}ë³\ñÕ†©ª\Å<NQ_û\ÃmzÆ•x—–\ÈR@ÿ\0\îµpIrQf^Š?¾û«\ÄzzxRŸv½\î\ô®_\Å\Ö\å­\Ö\éœC/İ§6sM•7-Xt\ò\õ$¯[±o\ôtúW\Ø~\æ\ò\'\÷¯_\Ò[Ì³ŒûPM\Î7\Ç0\ív5\Ãw¯H\ñ¼c\É\Íy³Ì‹Õ¶\ĞCc\÷|´\ÑÖ‘n¢\Û\÷\ê)u(#;sT‘7:ŸI²ş*\ô¹á‘®\í\Ìy‡\õH\Ú\ò\rüU\î\Ú..\Ü-t\Ğø\ÎZ\ß\Øi\ë¶\Í?½Š¸V¢…v\Ä*Dû\Õ\í\Ú;)¼\ËEúT\ö-\åİ±ª:£­^¶_\ô\ìP\ïü#x\Óš*ÿ\0…\ìR;3ÖŠ³˜ÿ\0$\Û`\ãÚ¼Fe\òız×·x\õD\ì|ª\æ¼\ïû\Ñ~g\Ç_\â5\á£\Úg(sv¥h\Î\Îut\Æ;\×ªË¨X[\ğ]\à\"´ \ão\íea\ò¡ü©–zlª\Û\Ìg\ò®‡U\×\í#‹1‚ß†\ÚÍ‡Äˆ\ÛBD\àU¬@\çC¹š\Çz\'\ÍÚ¹\÷\ğ­ü\Ç~\Ê\í\Ó\Å\rLa«!ü|‘»~\àªı(,\ç\á\ğ\ê¿Ü¥›\Â7»ºV\ô~:,Äˆ\Âæ§‹\ÆYo0«ı\ìT\ÜTxV\î>¨[\ğ¨§\Ñg‡w\ÈV»\È|aiÿ\0-/\õ­;k\í3R^6\îş\ëQp±\åN—fqP*\É‹ı\ê\õ\éü3it0˜_\÷k\×|=©gˆZ.U‡J¸{\íÍ²³\ÏŞ«V\Ó\Şv\ÔW0=¼Ì†¥\Ğ\Ôÿ\03\ëQE\ó| n«)k,œ\"­ˆJ|rqV“.\ÎP¯\áS\ÙhrL\Ì†€ \òv¢\Üû«¤ÿ\0„wl[³RXé¶‘\í\ó]*¬6‘¼‡¥^´Ò®$<FZ»+\r7L\ë\æ-O¨x›F\ğ½¾\é›¦\ã\÷ªYH\ãd\Óä…°\ãkTF\İú\â³5¯‰\ÖWS¹ş\\\å\÷\Äi\ä‚\İ\Ûıªo\ZmËµ*\Ş[F~yWoÖ¼š_jw;±‰j{m?U\Ô˜n\Öÿ\0¾kD€\öKOhúX\ß$Š\Ì\İµ›\â6*d¸‚&?Ã¿\æoø\rx=Ÿ„\Ìsbşè¬¹\â=ûš»;?L\Ò\áb\"M\ã«\Ë\ó3U\ò’u\ZŸÄˆ®ı\Z2\Ã6s\\\Í\çŠ5H¸\ß\ZD½Yd\ê¾,Š9Dh‰°ü»TW#®ø¢%¹\Ã\Æ\ñFƒøVfÿ\0^½g–\Ş\È\È\îÇ™\íZ£o\Æ\ôŠ[\àÒ·ğ´›«—\ÅR\Éq\å\Åwµ\Û\ò|µ™6¡?Ú›{3¾6´À\ôY´Ÿ³\Í\æ’w–¨LÖ;\Éq?›;~P?»X·\×0\Ûì¸GR8V5I,\Òe\îü\ÃÚ€:=cÅŸ\Ù\ğ\É&À§fĞ«^yı¡qx\Ï,¯\òÿ\0wûµrşGšVi\äÜ¿\íUT‘1\Î\ê«ˆ›Nµ7\Üÿ\0ÀªÌ³D\Ó.\Ç-Gø{\ÓZ\ÖH\àdL«—\åª\r\'\Ùb\òş\÷«yªEyyºf|\÷İ»û\ÕJú\ñ\î$_\áEÙ¾i˜“@ø¿*\0®#25_††1ş\ót¡#\÷¥ÿ\0‡S\÷TtZ\0µb\ß;K’›\ê\ÕJ\æ\á\ä-#¶\æ\'q«’H!‰|«ı\ß\ï\Z\Ëv,h\0L\È\ëV\×3~\í>T\î\ßŞª\ö\ñ¼…@/v­$_-(T·Hc\Ş~UZ‰n3vJŠ\æ\à\ì\åª´~Tu¦M¼·\ËT.u\'\ÉÚŸÎ ’\à\Ì\ØO»O†8\ã]\ò¸U †™ºU…·‚6ù\Î\æª\Ïy¹vD_\ï565\Ú\Ûİ¨O\ÎL|‚˜²sÉªF\écR\Â\Ò\Ü\Õş\óP›jB¶¦wR\Ã%Ä¼’\ÍÚ’\â†,»ŒÕ´\Ô\"\Ç\÷¨\Öv;2\ì^ûSæ®·B¾³\Ó\ÎüH\ò¯\Ü\Ü>_­r\ğ\êˆ6ÿ\0µZ–š´\Æw\Ä©¢\r\áª\\4\Í œ·\Şaº®[^]4¸{´\çød…©\ÄL\Ñ\ÆV§†\ñ7«º\ß\íU=KÃº\Ç\ö—\æ¤rÀ›~\\ü\Í\ï^·\áYj\n„I-“¸ùşV¯›a\Ö-&EG‰Ë¯\ñ/\Ë[\ÚV©\Ã\ì+ÓŸš¹\åJ\çDj\\\Ùx,Jùşÿ\0\ÅU|I«G&œÏƒ^_à»‰¤\Û\åİ£ıß–C^‰wÚ´\éRD\ÚØ¯:tùY\Û	y>µoƒ\ò\Ô2\ë\ÉÚ«]\èn\×O\Í7û	ıir¢›b¶¼\Şruû\Õ\ì^ÕM5:\ô¯ş\Å\Ú\Êk\Ü< ùz$R»˜n\ÛC±:œ×¯%’Í\ryÄ—rH\ßz½ÿ\0\Ä:ZIjû’¼¶\î\Å#™şO\â¡X†rIos\'­:&Y&]\ä\×U(¨\òyûµB±.ƒ§¥«\Äÿ\0\Ä\r}\á[DG¢×‚Ù±W¯pø{1’‡µ]%\ïœ\õ~\Ğ\ã_’Ÿ·\æ§\Ã	aS¥›·D5\ìÅ;ZšúŸ&\Ú\ÓF\ÛzµCF³x\Û\çùkU\á\ê\ôj#Ô¼4Á¬\éEs:.µ%¼8\Æ\ê)™›Xı™—Ú¼ziG\äŸÎ½“\â\\{-\é^>\ñü\Í^BG¬\Ù®\Ş2\â2\Ûj\ÒGR¤{›š\ĞW1µP¶Õ“k\÷««\Õ\íwZ6s\Öv3\È\ÛDLß…\\I¹a”µ±\Ås\÷Š\ñ³WUŒ\ò#G³\æş\í\\O†º®¤Š\È\Ö\éN\Å\\\â\"\Î­\\I\Ê\ï\ì~\r\ê;\Ï\Ã5uZO\ÂshŸ:Eÿ\0|\ÖasÅ…œ·_r2ÿ\0\îÖ†\á\İbITÁo.\ß\ö…{¼>Ò´µQ.\Í\ßìµn\Û\ÄZ“7\ÜOø iU¦\è~#µEyc1¨ş½º¯K©KX¸\æ¯K\ñÅ­\n\ŞÉ’‡§û5\âú\ï\ÄM>g}ş\í;\Z›ú-\âyûQ6\î«\Z–ƒ-\åÀ1cµ\ç1x\é\÷7\Ù\àvaV£ø‰®G»eœNİ·–ªH†\ÏNÓ¼;Œ;\î-WŸ^Ò¬İ²\ë\òŸZ\ó•\Õ|W\âF\òÌ¢ˆ\á M¿ø\ñ«¿\n\ïµ\ó.ä™˜\õ\Ü\õfGM¨üDÒ­Ñ‡˜›«›—\â¢C»\ì\è\ï\éµ+z\Ï\à\í¤q~\ó\ï\ß_Îº?†úU¬\\¦\æúUs\Ì.~ k‘ü¶\ì¨\İ7\Z\Íş\Ò\ñ\ó\á2¬\ß\İM\Õ\ï>\Ò-\á\ÂD›—Ú£µ³²[ülEü(0š?Š.c^Ü¢?U\öÖ¶\ğ¦\÷R5Ä²J\ßŞ–\Ûù×³\Í\r¿\ğ ü«CJhÕ—º¦E\\\ñK\áZin¨Ùª\ö\ŞŠÜ³l\İéº½“\Æ\òU\ö\n\ó\ÍWR\Ô4¤…H\ÃRŠ¹\È\êp\ÛY\îO—\ÍG%I\ñ\ßO·Š\ÎE?\Ú«™“PMKV–gVg.yû¿İ®e¼?u$·\ZŒ¹±´ı\áü5¼7;‹A¼\Éq±c´{w­sºßˆ/l\ï\Ú$\Ş\ê\Ãx‘{Tz-ª^H¢x\Ä\í\õù’º³\Ò\á\r,rm”œyl\ãuj-Nfb\â\á\ZGO}¾\õV\Õ-\ç\Ö-\×\í„l\ñıÕ­\ë\å³\ó•\ßz\í\ê‘ÿ\0fÃ¬XG4¾m½\ËÀ»·m*Û¿Ù g\r5º[\Ü1Ÿaû\Ë\÷kgLW¸—?*+½j\õÿ\0\Ù-Q\ÊÑ¸\Üşn´ºmáŒ 0\"*ÿ\0v³e­\í\Ò;v‘\Ço½ \éXÚ\áÀ\ín­ZzÆµ\æZ%¸T^~i;ÿ\0»XSLì˜\åÿ\0j‘HÎ¼\Ë.\Ìİ–61§Ì²¸\ë\Óıš»\öX–\'i$Û´}\ï\â55\à\ò\ÙûP2\å\æ cV\0ı\ê\È7cü\ïT\Şù\ä-\Ï\ËQy…¨ä¿¼o“\î\Ğ\æT¨\àVe\Ï\ğÔ¯\ò\ÇÀùš€wt›Bº´û\İş\ñ\Ï\Ë\Ù½P\Û[\î;\åÿ\0VµbI<\ÆßŒ/eş\í\02\âO2F¥Š—&£{ˆ\ã\î*7¾\ã\ä \æd>J®\÷?\í\îªt}j4ı\ãf€.4†FËŸ–˜\ònl\rD[µ4\È#\ë\ó5\0ZI„iıÚƒv\çË\ÕY\î©¾i ­p\ÔfC\'z®¹©QwP\ñ7—\÷j\ÒL\ì:\Ô\Â\ï¾ê²¾Zÿ\0\0\Ï\ÎM]‰x\â«\Ã$yş\õZK„\ô\İ@»\\†98+»ıª ×‚>\ß\÷\Í,Z£ÿ\0PŸú^\Ü	\Âÿ\0»V¡i0¢YKVtwE—\'\å©Rø‘\Æ( µ\ò\ì\Ê\Ê\÷·û¸®F\Ö,Ø¼N\Ì\ß\ò\ÑV¸Hn¿\àU©m¨<p±\îÿ\0v‚i\ğÆ¨˜V´¼]\Éü\ë^ø„n k»}Ì£™ı\ÚùkC\×#µ\r½\Ù7•û\Õ\é¾\ñUº¢ı\ãd©\Õ[ø«\n‘\æ:¡>S\Ò.o#ûc\ìù–”|Õ‹cª& 7œ,Ÿ\ìÿ\0_Kz\âp:\ËRW¥ø^•´å·‘\÷(\é^Mq¨v®£À—\Şc0æ§§4zF©q–\Ï^[¬lá¾µ\è{ä…‚\Õ\Æ\ßxOS\Ô&b‰µ~•J&N¡„$4\É\ë]-—\Ã{\Ù?\Öf¯\Å\ğ\í|\í’9ªQ#\Úm½ÀY½\Ã\á|\Ê\É¬3\áİ”!K j\ïü/c¦\è\ó!.‰[Er³	O˜\ï¢d\ËR­\æŞ‰X\×>,Ò­O7\òû\ÖE\ç\Åm\Çvû¸ş_z\ìS8\Zg§M-\Ä\Û>\ím¾û2_mxÿ\0\í1\á­\\ı²/—Ş¸~İš%¼/¤¦vş,nª¸rŸpøJ\Ş\Î5c#¦\ï\öù“ªşŞš\ë;&™k#±ùB\ó\Ís\ì\Íoˆš=\İÕ¦\ôˆ•úWXx\÷Tv\ò\Ô/û\Õ\õ?‰\õoGf\è\òFÏ·Ö¼ş\"h\Ô_\n¨\÷Z\àGTR\×\á-\ìŸ|·\åP_x\é·1F\ä®\ã´\×_yû@hQ\Ä\Å\î U\Ä\Î+\Í<U\ñ\Â\ÏP“}“}¡‡\ñ ùj…©\Ô\ê~‚\Ş·¸ù«{J\ğ\î‰o¥ï”£6=kÁµoŠÚ¾¨Š‚\Ù\ÑFc\÷ªŠ\ê\Ş-\Ö#‘\â‹l¢\rOH\Ôo4\Ë=i\İlSü5\ÓC\ñ“D\Ñl?İ³ş\Í|\ów£\ëK¶\à\È\ÎÛ¾fz\í|\ğ&MiVY¤?6\Ü\ñÿ\0³\Z ;\rC\öˆ±\Ü\ŞT{—ûÊ›«\"ÿ\0\ö€½\Ô£\Ó\ô»»ø\ß\å^‰ üÑ´İ¾bD\ÍŞ»=;\áş…f«û€ûj\Z\'œù†\óX\ñ¯ˆ&ù-\Ş%o\á\Ù\÷jÕ¯\Ã\ë\r¾i&‹wı\òk\ë;}\'Jµ\n\Ú5ÿ\0ÇªümoùQı\ÚHùwOı›u„W¸•ÿ\0½\ó\ZÁ\ñ\Â\Ğ\Ã!}¬¿Ş¯²7$\È\ßJòˆ–6\ê²\ï£f \Õ3\ç\Ïøv\ÛÏœL7\í?-trXÁ\àF?*­£F‘\ê·Ÿ*\ö­Ÿøøj´\ÊfÏ†c?pW^˜U\Æ+•\ğŠ¤—8»š\ô5\Ó\í6\çxü\ê\ÌY’zT]«^k[5‹ıg\ëY³Mi\ïŸw\ãE\Äe\ÜC\å¶V³¼\Ï\ô\Å9ùªÎ§­F¨Á?\n\çV\ñüÿ\03š«\×yŸ\"\óV\ì/£WmµË¬\×s`\ò·\ñSV;˜\É/*­H-\ñ%¼vÏ½\×\ä¯\ñ>¡-\ôyr;úü¸«­x’&¾o9<ø“rÿ\0¼k›º\×\"\ó\'³¥\ízU\ÂjS\Óu(üüyA¶§+Š\×xmµ+•‰Ú»\÷G\Êi,<\Û\ÆI\Ş5‹¶¨ùTÖƒ\Çot†H£]¿2mÒ‘-•?±cµ»†?*4”\ŞO\í\İY\Ş/\Ñ\Äo\æZyN\Ä|ê»\rZ×š¥¼\×g‘Qœn\Ü\Ãø«\í\ô\è|ùL\á–\r«L\"r\É%\êÅ‡u\ëü5,*ş[4˜TWø]¼µªA$\ë\ó|²U+kyV\\\Ïåª§V\ÍD‹-X\äì¨¬Ëˆşw\ç\å\íS\İ^\'\Ú4%™½şZ\Í\Õ\õ$µe~o]µ›*Á7—\Z.O\Ì*‹I\æ>\õuTZË¿Ö“? \ÜÕ‘yª;&7\íÿ\0v‘f¾¥«$…}\Ï\çXw7^q\Æxş\íS{‡™ªX#\ÜWøš€\éV­\á\ó9?*\Ó\Ò\Ìù¸uùjy1\Ç\İQÒ€$Llù*93\Üı\ï\î\Òy‡cqj‰ü\Ö<)f¥r¹X²\İyl»¾\÷e¨^\á\äş:–[†\Ï;ª\Úxnv\è7R\æˆrH\Åu}\İ\ÍK\r¼³poûÕ½oá»…\í¹¾•wû\ën\ß*§\ÚD¿e>\Ç4-\Ò½\óµ#o~‰¶ºa\áùU\ÕTRx~\ãû˜Z^\Ò!\ì§\Ø\ç6¶\Şj&Q[\Óhr¯Pj»hr\í\ÎÂ«W\ÏrHÈ¦¯\Ş\éZO¥•\ìj	-\Ş?\à5\\\ÄØ®\Òm£\Í\õ*B\íüœÑº\öD·¾´¿h\ÜhxÏ¥1”\â€\'K‡_\á5*\\Ië¶¨ü\õ\"5\0_ûSS…\ô‹\ØT\ìn\õ7–\î\Ğ‹y&x©…\Óÿ\0p5U\ò_Ò§†\İ\ä\ãj\Ş\ã\æî¿_\êX]Lr¬µ·uu\ÙR™3‡û\Ô\Ô[_y›wü\õ½kx’:	Š_\ö~\ëW p\ñµmXjQ\ìWGt\Ç]\Ô\ê×®-n¼‹ƒµŸ¦\ê\ô\ëh\Şh”Ÿ•±^#£_G|\èK\ît\è\Ë^a\âG\Ò\ì\ÖI\åÚ‹üL7V|¥s3¬k7n\Õ\Şü*\Ó`û{‡\n?Ú¯Ô¾4ZX³!ùÿ\0\ÚJ\Â\Z‚Ü¨Ò„)ş\èùª9ImŸ \ŞN‰f‹¾Hª…\÷Š¼9b­¾\â/–¾O|P\ñR¯—\ÄJÿ\00l\í«\ö\ßş\"x‚O\ô½M¢W\ë\óµ.B\Ñ\õ½\ñ\Ë\ÂúLgqq\ï^msûJhŸ\Ú2bU\Û\\V›û%\êÈ§P\Ô\ä}£v\ÕmO\öi´\Ñn\Õ\ŞbŞ»¨\äQ¦­ûPYG%»—8\ã`\Íyn½ûDx³R¸\ì\È&T\Ï\r³uz~…\ğ@µ…KÆ\Ç<W]¦ø/B³\ám#ü¨°^\'\Éú¯\Ä\Ï\Ü;y·gø¾\ícO¬x¯V\â[‰›w»W\Ó?¼?§ü¯¯û¢¼\Ê-.¾?İ«Fmw¥øOTÕ®bŠ\æ\æ]W;™«\Ş<;û5\ériq?\Îø\İ\óW/mjÎ„\â½\ãÃ¾$ƒûß¢mªÁ¯ƒ~·¿ƒÍ·\Ø>UŸø¨[\ë-G\æßŸÖŠ¥±”–§ƒ\Ùü/ø‡\ãW»\ÕfdnŠ¿v®\Üş\ËúÂª½\Å\Ä\Òú\îù³_qhú=¾Ÿ¹R%_Â«x’\İ6\ôZ\äF·>(\ÓgTûN.pUº\îş\Z\Ñ\Ö~\éú(B£øV¾…Ö´\ß/\÷±»Ö¸\êÑ­†\Çq½znªD\Ü\â\ìü\r§\Û\é¨\â\"Y½[\Ú†\í\Ú\İÈvÔºm\äwš\Ì\ØûÕ§\á»\ëHah\æ”)ûÕ¦¡s\Ë|m¡\Çgª®j“\÷V½/À63M¦.\Â6¯ûU\É|Dš\Ş\âu’7Ù­ox\ò\ËC\Ó\öO ÿ\0Q¨=BşË¸şÿ\0\ëNm>|{\ñ®>ÿ\0\â\õ¿ü»©—ı\Äf¬¹~$j·‡eµ•\Ã+\r´jA\è/o,k\÷¿\ñ\ê¬\×Z¶ù@ük‚]C\Å\Zù\"h³V­¼\'\âA¿{+.\à5 w¶~$´±O\Ş\Ì\ñ¯;ø“\âk+„q\ïjÒ\á-\Í\Ó/\Ún%oûh\Ûj|)´\Ó\ìZ@76=j\r¢xÖ‹\'™©\Èÿ\0Ş­«˜yº±£û?\Ä^ŒÖ½\ä\Ü\ÒF„¶2:¿\îşV­\Ûe½‘y­súlŸ\é+]Õ¶\Ï%MhI–\Öwr.<Ö©!\Ñ\Î\ß\ŞHZµK|´Á\'\Í@ÿ\0²\à2@j\ÅÔ£Š\Ş\åp›3[·—I³®3\Å^\"Š9qº?ÒµH‚ş¯ªG\ä\"ı [²|\Ã\æÛš\â5ˆOy¥^lÿ\0[l¡”\÷ş\ís—ş(K\Åe;‘ÿ\0Š¹½V\ê\ãgú\r\ò\Çh­R\Z64•–;oŞ†yHÜ‹\÷¶\ÔB/¯eò¼¿´/Vs\ó\n\Ã\Ñüxay\à½F¶h“j\\¨\ÜÛ³ı\Úë­¤·\ñ…Ÿ\Û\í®\"MrÃ¯Ê³/£{\Õ\Ä»\á\È\î,\ì\ÔJ\ñ+\î\çh\ëW®\ï£ky\ã–\áV_¼¿‹ı\Ú\ã-uËˆfk{Øºü\É/\İ\ÚkZ\îh¦\Ú\òº2\ì\áª\Ì\Ì\íWz¦d@\Õ\ÊM!†	@‘	İ±“\î\×kia\öˆw£‰\×o\÷«šÔ¡{ye)«\÷\ãaÿ\0 \Ñ\"\âs–\ò\\yª\è6\í¤\ÔüU!?7\İùj=G\Í\ëı\Ó\Ö=ÎŠ\÷\ÌP\Z>\Û~\õdjCs¯yÏ²<ª­T/.¤a¼²¯Njy4¹c\r²\'¨\Æ\áW˜_½PY@«³Sš\Ì\õ«±Y»:§W’\ÄG·4wV¥µš[\àŸ™ª\õ­Ÿœ\Ü!Úµ©o¡½\Ã\ï»ı\Ú\0\Çh\Ê\î|n\â™o£\Ü\İI¸\Æ[w·\Ê+º\Òü3¾B»]~ƒ\á™o$h ´?(û\Øùk\n“\å:©\Ò\æ8=3Á/\"®\"ù›­uºg\Â\İÁIŒ³w\è\Ú7„~Îª%pÓ“\Ê\Æ7m®\ÏJ\ğ\éÜ©¯:udz\ô\ğ\ğG–iÿ\0\Ş\á\Õ-›¿‰« O…¶vcbA\ç·vj\öH|>\öv\Ë\Z&\é_«\ìµb\r¿z\ãu&uÆ”—\áİ¼m•Q»Šª~\Æ\Ò\äD*úş4î›š«\É\á”ù‡–+/i#OgÀŸÀc§—@ø~1*½²¼|¤[ª¿\ö,½<¯û\êi t\Ñ\á\÷Ÿ\r\ÓJÊ±\'\ğ8]ÀG¾¾„º\Ğİ“‘º±Ÿ\ÃbNm¦«4C¡|\ñu\à×‡q\ò‚ş‰u\á\Ù\ã-¾!ùWÒ³x>6<¦æ¬½GÀ\ñ\È3\å\Ö\ë\Ìù}&H\Ûı^\ÕúU	´ø¿\'Vÿ\0d×¿\ê^	X\÷f1ùW/¨x-1\ó\'\é]PÅœ’Á7%š)ù3·ıª­%š»^‡©xG\É\İ\òµ\Ê\Şh\ï­\Ç\Ë]\Ô\ë)œ0\î\ÙJÿ\0´´}ŸV­\Ë¶\ì\ÜZH\î›‘¶ºN2›[£m\n®¾­W\Ş›‘\òµ7\Éuû˜ ¢™\×\×ıÚ¹\r\Ã\î\Ïİª\ì¾caĞ«³K\öw_¸ÿ\0\÷\Õ\0Z\óJ›ª\Ì2#v\ÛY\ÛdZ|wN§¥\0kNâ´¬cI+\ŞD¸\á\ò­Z\ñ´ep\ïš\0\è¬\ãû\Ìd«\×[o¬\ëq\È*½«\Óu`¨±\\\Æ_şš/jÚ´™&~$ù‡š\0¹u£\é\ì\Ü#³ZŸ£\Ñ\ã\ñ…”Mù\ßoÌ•B\î\Ôù9\Æ\æ\ÇŞª~ÿ\0C\ñN—/‰\×5g\è7‡<#§ÿ\0g\Ä\ñ[Ä¼V\Ê\è1\Æx\Â\Ô^	š;­\ÕÃ£~\í~\é\ö­iü¨\×%\öş5gl\Ï}7jıú\óoˆ\Ö~L,\àı\Ó^‰uªZC»\÷¿­y·\Ä\rZ\ÚkWPßU†®q¶W‡\Êû\õqu«\×ú´v\Ê\ß=f\Üx‰70\ó*lj/ˆº¢µ†\ñ&İ½Z¼N\ó\Æ–¬\Û\î:{\×e\âÛ¯\í\Ë·k\Ï\"øgo¿|’n¥b\Ò)\ß|L\nqw¯`øq\ãC¨h¨\òdqüU\çQx\'O¶+”\Ñi±\Çg\Z\Åo\òªÿ\0vŠ±\Ûh.:‹Y\ß,\Ñ\\Œû\ĞOß¢ª\Ä\Øûÿ\0ûj8eÃ¸\Èx\×Ç–zl$¼¡U}\ë:\Ï\Ãz•\ô\Ìe•—ıß–°|e\ğ½5—\Ïrÿ\0\ï\Z\à39[\ãf•\ô\Æ\Í\÷~ş\ê\ñŸø\Â\ï\\¸g·GX3\÷”}\ê\öK?ƒ:u¿\ğ/\åUüO\ğ\ö\ËO\Ò%)|Ošš\Í<¨^\ÜY´NOJ×‡G¼º½a¶\Îÿ\0=^\ğ\rŠys¦Ş•\Øxn\ÅQtt .µ\áÿ\0°\Û1–o®\ê»\à\ØjR1¸\'\åş\Z\ì<u¤¥½—˜¹\ï†V¿hºq¼«f€;¨|+£\Â¤a›ıªØ¶\Òtø\ÕvEJ\ÚÈ¸š¢şÇ–>A%ø£Š?¸=$ù«;\ìwÿ\0µø\Òn\ô?\0j	9ª~!µZ{\äv¨•®¹\ÍjM\Ú,Y¥K5‹>K\ñm¹\ÓüH¹~zµyQ^¯üS±ºÚ¾:¾\ê¯&$´C\íB7û%[øø_\á®\êÁ¿\Ñ\Åp¶\Íû\å®\ßK5º\óZjg\"\Ó}\Ö\æ«„ù²j\â\ô¬\ë\Ëtİ¿ó¤µ2¼Cr°Ú±Cÿ\0Ö¯*º¸ŠK\é\ãwùe\ë^\â[\ï/K¹\"\ów\r¿-y´±\ï‚?».\Í\ï]0Dœ¿ˆ\Õ\ì\Ñü¤\İ½L\Ñ\î’E¤\Ä\ÍüMN\ñ¿\Ù\×\ì\ò9fq¸mş\Z£¤\ë\ëM¸‚\ì\rÑ»(eû\Ëı\ÚcGK¯øD\ßisÈ˜i\ñ\÷—\ïW¡x‚\ê›\n<O¸ÿ\0½]ß‡n¤\ò˜y\å\à›\æGo\áaX^0±·QV1\ír7o\Ç\ÊjŠ=CO\ñ5ª\Ü6£|\ß7\÷«1¼>ViÍ¼\æŸø[\æSX\ñ\Ø\Ä İ´uZ\ím\æ‹\\‚Yl\ÇCµ\Óıª­Hh\ä\â\óÃ·l`vt\Ç*¿v®Z\ëI­#y‘¥Tş/\â§k\Ú8\ÔJZ\Ş}\×_\á5\Êı\â\Öe\Ş\å[û\Ù\ëS!¢\â[ı–\ñ 0£¹\á³\÷M[F´IZ6ˆ+)\ô¬ù\ï5Ta¹±Q´’\Ü[,¿u³´Ôš\Z\×?c¸UC\'\Ê\ß{j\Öl¶ú|q¼v\ó•\İüM\óU’x\İ…vü´ßµ}0q»\éJ\à+\é¶\ö\ì®eşh[[f}Áwÿ\0¼j)o\"¸O\ï\öj³±S”ùV¤³ZeÚ˜\ÛWV3dµ¦\ÜE¿\÷ÿ\02\æµ4ı6K\ë\İ\æV-\÷V¥»93¥\ÓV\Ö$M“\ï—û«^“¡Cy«|–\ÆDNlH\Û\àMX~øw{2$¢\Ñ§Í¹ÿ\0†½\ã\Â~	»\Â°G\Ç\İQ^uI\Ü\öhÓ¶\æ7…üq\æ\âH—¾\â«^‘¦xtBˆ<ˆ\â_\î¯Ş­]\Â\óÚ…\ŞF\ï¥t¶z:©\Şùj\ägz2\ì4q\óg\ïz¯ÿ\0bÆ½«r+T\ÇJ‘\íFj\Z4¹ÎªÉ¦¦\î•\Ôy|T/nŸ7“€\Ó9V\Òê¼º*I\èµÕ›QP=˜©\å*\çq¡…^«:O\îÿ\0–u\Û\ËoP5¨\İÒ•Š¹Á\Ï\áÿ\0\ök6\çC\Û^6[šÏ¹\ÒüÎ¢³°\Ï-¼\Ğ\÷1\ß\ËX7şI;+\Ö.´½§‘Y·:_r€<OT\ğ¼ydx·zq\\7ˆ<sÆŸ0\ö¯¢o\ôQ\"¶W!©\è.\Çn6µi	\Ê,\ÊpR>dÔ¼>cvC\ÖúW3} ˜\÷\n\×Ñšß„ü\ÇûŸ¥pÚ¿„Jı\ß^V½JU\Ï.®±\âÌ²[¶v\Ó\Ö\é\×ı\Ú\íµ_˜\÷|›V¹+ı&KW\È«Ğ…E3Ê©IÀ‹\í¿Ù¥\ób*«ÿ\0«¨¼\Ç_\÷kSE$9«I \Åc$Ï»p5j+£Ş€4—\Øn«\öwSÿ\0Š¬\Ëy¾^*\ìR}\Ú\0\ß\Òdú_(e\\\Ö\ìzl\ğ\í2/\ñ-sP\åc]S?ÄµĞ¤s\ÇWjûù\×ø\àT\Ñ\Ù\ÜH¨ˆSvŞ¬»»ƒ§ß¬\ñ\ñµ\÷VÅ†¡o4(\î›Xº¿\Âk/^µ\ó·\Çü e\ğ\ï\í%6£\Åh‚5p=Z¤¸ı£5=A°ªÿ\0ykˆøK\ğ?ş5½–V\Ú\ç\î¯İ¯t\Ñÿ\0g½+OUı\Öı¿\Şù«TY¸&y£üRÕ¯¹Œ\Èû¿ïš¥¨xƒ[Ô—\÷©.\ÌzW\ĞV\ôû1„´\r·û©S\ê^‚;6al:zS\'™0,7—³¿\ßuTš3jß¼;k\Ôe\ğ¼\ójW1Dw\Êk¿®o.[Ì”ªÿ\0³@sE\æµok¾ı\Ì+ÿ\0„\Ú\óR¹h\ì\â/´\íÜµ\ë\ñ|´û3¼\Ìøş#\\V\à\Ù\ôŸOv\ç`<qÖƒE#\n+]vù²AJ\ì<\á½E_\÷\ä»5v0øn\á‘~M«]_†4_\ìù–I\Ü5¶\Ì\ğ-\ÍÃ¤…6\ô\Åê­¬i\ñÄ º|´R¹•¤{\Û²µ`ø™¿tµ\Ğ\Î\Ã}s~$“\å¯9\Z\Ò\õ¬o\Ç\æiRı\rl–‘\âIû6\\¸\éT•øO\ô›ˆ¿ºZ»m	¼½a«\Ïü#w:\İ\ÂoÛ¸µv–\"\ëùùXÕ :O[ù\Ú+Ÿ\îŠ\ó¿…\ó$z\Ä\éüYûµ\éş\'U›Dgµy‚dû?ŠÊ»\ê€\÷\Õû‚Šl\rºş”»h3bSJÔ«Ö‚»š ¢»ª\ÂüÑ°\ö v©­GÏŸt\ó¾hÊ²š\äaù´\ÕúW¬|k±Y¬wŸ\á¯/\Ó!I,7¥Jz\ğ0\İ]†‘!\òº\ZÎ†\Æ\İH8\Ôi±\Å\öo“\îÖˆ’•\åñµœ\Ì+Õ¼}=ªO¾/›·\èz\Ó:Ç°}\×ùN\Ñ^g\â\rş\Ã3£‡¸SÂ·\İ\ÛüU¢§©|H¼¾O)b+7-Vld\Z…«%ÀF›Ë“v¹]J\Æ{{†’\Ü+/\Ş\òı\êÖŸ}qul¹ùX|¥Vº\"I\â\íJ;•·¼¼ı•– \Ñt\Ø\éuû£™6\ìş\÷«>:³Š\ãNµ»p~\Õ\î‹yİ®WD\ñ&\éR\Êo\õLUSı–©.\'eı›q\öWHÜªyŒ\ác=¿†­k¶\ïy`’Ê‡r½XpøŠ\÷O–x#‘Qs\Æ\ä\İ[\Ö:\Äú¦‘:\\ı\ò6\îş\õ—}6K[lG&\Öm\Ì?\Ã]ƒ|I\å\İü\éşÌı\ìsG1\Ï\äK–L\ğÕ£¤4P\ÜKû­¿.\áEÊ±\ß\Ş\ÜExj\Ís:¾’nd·e¨¬\õˆ\Úé­²W\ğ©—P–6?\Í~F¢\ä\ØÆ¼Y!E\ç_\ïUO3Œgj‘]5\ÔÉ«D±\Ü f_•jƒx}\Z^7#\áj–ZG2\×\×³.S\ÏO\öªT[}A[\Ì&&ş\ëV\ÕÎ†cm„|İ¸¨‡†\äm§c~U6Pfº}¼o²;‚\ÍBi\÷>§\÷«¦‡Á²\Ì\Û\Ò\ŞWü+ª\Ğ<$—(\Z\ÚVo•vFŒËº²u\rcJL\ã´\İ\ŞL’K\÷¿Z\÷‡\Â\ÜD(ÿ\0¼x¯Pø{\ğ¿Hû=»\ÜY+:ü\Å[û\Õ\î\Z6ƒ¦[¢$v‘\"¯ET®I\ÊR=:T”ÁøgÁ\÷,q…‹\Ê^µ\é\Ö\Z\ZÛ¢‚‚´mtø\í\Õ\Æı\ÑW\Ö=\ËX‘3¡³E\ì*qf3š´\Óüº‚\È<µ‹V\ÏJ\ã\rR©´\í¦y9\íV¸ZN*,QQ¡¨=µy˜TN´¬Y“4uB3[\n7j\í\Ó=(°\ÂßZ¡’\ÏÒµ\Ö1\éI\å-f\ÑW9©\ì|\Î\nVeÎ—\óq]Œ–{ªÎŸiX.pw:,6n¬K\İ$İ„ù«\Ò&\Ó\Ç#“s¦ü\Õ#<«Q\Ğ\Ë+\rŸ5rš¯…\Ò\â6;6½{Mæ“¹z|µ\Ï\Ü\è\á]ù”\Õ\\ƒÀu¼{’H7-pšß…D\Ê\Ş\\l?\Ù\Çİ¯§u/¤Œ\ß&\ê\äµ_	ù›¶&+ju\\Y…ZJHù7WĞ\ÍÛƒ¹}«Ã·µ}\â–V\"?üv¼§_\ğ«\Â[bW­J²‘\âÕ \àq;E86\ÓV&³0\î\ÏŞ¨‘w6\ÜWQÀO\ëN\Ú\ãk))¹k*(^3ş\Í]‡¥\0uš|‘Ì›ş\ò/\ğúWG\Äq\ÛpJn\ëıÖ®_CX\Ù\Óc•nş\âº]B™!+o\ïPÀo-›+§\Í\÷i\Ó\ë\Ü\ç\éYd°¯–_r\öª—2•\0}—û\'\\&©\á\Æ9Y”£}\ï¼k\è\Åû\'c\ìG¯\Ïï¿%\ğ‹\Ë;ª“\Åz\åÿ\0\Æ\rV\ñÿ\0r’?û¢¯˜\åt¹™\õÆ±§Ú¾•\Ìkş0²û3F$OÎ¾p›\Å\Ş$\ÕU¶E/?\ó\Ğ\Õ?Äº†7\Êbÿ\0Çª}¢I‘6­eo,¾z.\ö\õ¬\ÍS\Å\Zr¾|\Ğ\Õ\Ç\ÛxS¼_\ô‹™+{Mø[\Û|\Í\Íø\ÔûCULŠo\ZYª\â1»ÿ\0¬g\ñ\ÜM˜l\Ëgû©^‘¦ü7²\×1=«­Ó¼aü²¹™\\¨\ñ\Û[¼lEl\ëş\õj\é\Ş\ñ \Ù/³u{\æ\á{H\ö„ˆ~U\ÒXh\ğB\ÜF(¸ùQ\óı·Á½B\áU\åV\ÏU\Î\Ú+\éE±OJ(‚\ó]«s•®s\ÄMw!\à\Z\ô\Ø\Â\ö®gWÌ—¥q##w³¹·\ñªú¦‡w5œ¹p¼Wt–¨¢«\ß\Ãşÿ\0J¢œt]\r\á\ñ<é¿¿5\Ù\\\é\ï\rüAÍš£~_¥§v\Ú\éu%¨Bkd\Åİ\Ï\öCy€\í\Ù\÷³^;¦´°ø·d\ßş\Zúo›D9Á^\r\Ç\ÙüsıÑ¿mQv=\Ê\Î;¿%1•3ı²>Æµ4û¨¾\Ãgù±R¾¡o\Z\òEK3±Œ²]«8\Ís\ïùU©µ«xı\Z©K®\àBß…M\Â\Ãş\Ñ>\îsùU‹k‡\ß\óšÊ›T¸“\îEQ	/\æ<&\ßÂ‹”‘\ñB\Ô_i-…Ø¯(Ò¼3w\öl·Ò½/\Ä1\Şy,\ë\ÚK¯/g•¶™©\ÏÁ\á97fI¶\×Aa¦Ág\Ü\î¨\åYÙ¿z\á*wû=³K%À\âµ\ÔZ”5¸R\âÍ£Œn\Ï_;x\ÒMVMbtûA\ò\ã\ê¿v½\ß\Å>4²³\Ò\ZKw—\åù«\æŸx²\ãXÔ®Š|¬\ïÊ¯şƒZ¡¤Eµic\"µ\Ìû›û«\óWG¤}Š\ê\Ù\î­$\îùy^§jÿ\0\ëC†”ÿ\0\÷j¦‘ª^øv\ñ\å²\r¥s\òÖ‰•cÑµ½>=Z\Í\ÒGx\ïZ\ó\È<\"\Ü#Áp…•\÷:\É\ò\×om¨>©`¯Š:\ñU[Ouo4¾\×QA&$ú}\Ãlt&y\æº0©%´<\î\Âü´–Yê–¾D\ï\ö{ˆb\Ù\ëS\Ò7,—\Ân\İ@›Ø “*\Úu¬rÙ•pé¿¶\êÙ³.¬$wù›gûÕ—\ö[v‹c\Üm¸\Ï,\Ñù\ÒM\æI†u\ê\Ê:­k\Û\ér^G…½T\ì£{r‡;\÷\ô¯O\ğ&ƒı¥\n \Ãn~U¿†³l\è;œ¾\á?2y\Ä\êx\\u­\áûË‰±\ånPxo\âj\÷I<\ØQ\ğ—ÿ\0\n¯{á±¨+hü‰W\æ\éµk\'P\êTO*´\Ó\Ò\ãÊŠ\æ\'^}+¸\Ñ~ÿ\0h2ºF6\öV\Üi^³¼<\ØÊº\ã<w¯G\ğÇ†æ³“b\á\Ñ‰…s¹p§cˆ\ğ\×Á\Ù3<AR½ODøs§iv\ñ ·M\Ëı\á\÷«­Ò­ü¸zjĞ¬\ân/\Ù\î\Ê&\Ï\÷kF\ÏG×§ş=Z=\éYªYD+?ŒS\ZJkIR\ËC‹S|Ê\ä\ô§+T\\²Jš\ÕÉÔŠ­-Fdùj1%\0K\å\ÓJ<\Êw\rPMÒ£h\÷S\öÒ• 6­O´n¥\í@\Ú3Lh\ê\Ót¦²Ò°\\ÌšÛ¸ùªŒ–~ \Ö\ó\ÇQ¼!—š›s–¸±\ãû\æ±ï´°\Ã8ù–»i¬\Ç\ÍTf±\İÚ¦\Ã8[-$\\\óVE\æ†}«¿“K\òÙ°*¬\Úi\Û\÷7Q`<‹X\ğÑ™\÷[š¼«\Å^ù\ÜùG\ò¯¨/4\Ş\Û+•\×<;\ænù7)\ö­\"ùL§c\âoxM\íÙ\å®!\í\Ş\é\ó-}\â_\Çp²\Ú}«À¼m\à¶\Ñnœ„*•\éÑ­}C—X}g®E\rQu\òn\ëZšv&*\rwq³¥/\Ù\ÑH®\Ê\Úa}f¿\'\ÏŞ¸[i<·h²x®£J¼\òÓƒ\ó\n\0«ª~\í\×ûµ—s&\å\âºaEÅ²\ÜF/\ñªı\å5\Í\ÜFc¨Ò¾i¶úÇ‰ş\Ïp7.7WØ–_t\ë{t\Ùn=+\âß\Z±\ñ\õ¨\Ï\ßù•}ÿ\0a‰,\ĞûT°9øü3iÜh—\Ãv\ò7\Ü]‹\Z\òHZ\È\Ô\õH,ù¥M‚\æC\é1\Æì¸«¶\ÖqB˜JÉ—\ÄV’»ft_Æm\â­>\Ôü\ó†¢Ás¥±³;³Šßµ³\çr|T\Ó\íN\ÄM\Õ¿6ŒAn\à5Is\×\íaH\Ç5zˆ—«…¯Ÿo>,k_ê‡”¿\íV5Ïµ9¹—PTükKs\éËr\Ê\İyp«ø\Ñ_)?Š#º\İ\æ\ê&_\÷ZŠ,MÏª¯\î9®[T\Ôe«z† f;P®#XkÉ®XF›k\ÏHF\ã\êÈµR\óX¡nkP¸nwşUiü<±w\íüF´ \ó›\Øvø›\í!¾\\\Ö\Í\ÕÇ<O\éBx~V×¼©*V\ö·¢ÁfŠQ\ÅZ\ZÖ¦“KtJ\ñmE^?o)µ\Ë×¸\ØMgœ\áŠ\ñ­~ú\Ş?ù¥\Ó`>¿\íU\Zjzß‡¬o\ï´ø\óÒ¶\á\ğ¼²¬qÿ\05\Ê\éŸ´}M‰\Zt\Üdj_´vj\ì‘\Ü#5d\Åc\Ò\ã\ğ¼Qı\÷«‰£\ÙB>r\ñ¯\Õÿ\0i\Í>\İ?\ã\â5v\é\Íy\æ·ûOjWR2i\ö’\ÜnÜ£j}ê€±\õûI¦Z·ß\Z§u\â\í\Í[\÷©\Å|V~!|H\ñDM\ö=.\é?\ë<½›\àF¥·ø\ñ3\Ä‰\äµS\÷·\È\Íüª\Òa\îŸIø³â†‰\n:y±«\ï=y¾¥\ñ»J³û’\ÆŞµæ—Ÿ³\ïŠ,\í\Ú[½BI[\ï|¡¿­`?\Âya|\Ï1\Ü+U¹\İj_¬¯&•7º¯fSXwÿ\0\rÕ³w™e\ÏÉ»\î\Ö]\Ã\Ûx\×//\ÍşĞªº¦o§…\ò\ä\r·vWª@;^\ñ…\ÜÒ¼r\İÉ¹+Ÿ–©iQÅ«Z¼¢\ã\ÈÙ»,Õ\âK\È\ï®#³\ßao\Ş/\Şzf+\Ém\ös\÷s\Êÿ\0³Vl‹\Z•Å¼–\Û\à4€6Í£\æ-YZ\\o©nGŒ<«\Ówz]V\İ-\ïW\Ë>jÿ\0|Ö…¾4\ó<¯•z\Ğ3CJº½Y¼²~\ö\ê\ìt\Û´A/+8ûµ™\á½r\Ò\ãRû:ùq;\ËIkª\Õ.#\Ô>\ÏqNŸ)\Ù\÷^¬†sV\Ş¶³™¤ù\÷\ölüµ-ü?g¹tO›<\ßİ«\ó\êjR}œ\Û˜mş\Z†M6\â\ëP\ò¤!ga»nh$»a£Ü­º\É\ö“ƒW3s¦?Rû<¸t•\÷†ş%SÚ½CC¸¸\Õ,:#|\ÍT\î<?\ö‹¸®Î®>_QQ&tSF_†¼.\÷Wq\÷Aù7\r}3\ğ\Ó\á\Êi\ğ¼\ï\Z2Ë†\n¿údxÀv\×_½‘6\ğ1\ò×¿øc\Ã\"\Î\Æ(Ëªµ\Ê\Ù\éÓ‘‰k\áT‘<i\í\Å7Q\ğ«ªf(“w5zE¶šŠ\ËÀ«b›«ny¥¶\ìşS\Û\İı\Ú\ê\ô­-\Âä–­sc·\Ü\îŠ†h†${VH\ÒTO%E\Íç’«\Ë\'\ËMf\æ«\Ë7\Í\Åf\Ùv%2TM%Vy6\Ñ\öJ†\ÊHŸ\Ì\ÛMóª¿šh\óMM\Ë,yŸZF\éQyŸJw™EÀV]\İ\èU¨¼Ãº\æ\Ôbjn\êgŞ§P$¢™\Â\Ó[­=\ê=Ô†Ošš´(o–¿Ş˜¿Z(]Ë¶š{\Ó%û´”\0<aª\'„S\ÏZo©¶\âAP}Œ2\Õİ»‡ZB¥iX“&\ïMV\íY7šY\Ã\r›–»4…$\\\Óe±II¹\äºß†DŸ8¯#ø‰\à4\Ô,\å\Ä0•\ôŞ¥¥Ÿ›\ä\r\\/ˆtQ\"µ\\=\Öe%\Ì~|ø³\Â/§»ÊŸz\'*\ëXštykèŸŠ>şÏ¿ºs\î&\İÛ½|\ñfúm\Ûs<W­NwG‡Z™¨‹\ç\àş\ôV§K\ÇT\ãøj…\àù_>6š&ob¿*µnS£Ñµ_2F‰\Ğ2º*\ÕJ\æ1\ç<g\î\ö¬»Y¿\ÒûÃ¥j\ÊÁ¢\È\ëE€µ\á-Hø\Ä\ÖWˆ7yrn¯¯tß‹\Z…Å„Brxû\Í_Ax\ö\÷\ã\ï^\ë\á\ßº\épfUEÇ­=B\ó\Å^ ¾\Ü|\Ï)\ïšÈ¹mBë›@«²\õ\Å\ßø\ê5\ô/\ã\\ı\÷\Ä8U³9oÆŒn{\'\öm¥‘\ö‰o7Ö°\ß^\Ó\ã\Î\Âe®\ÂZ´^0\Ğ\ç1JYF~Z\óK\ï^\Û\ê3\ÚE|¦ª\Ä6{ø¢\Ş>DU\Íø§\â$ú}¦ûm»³\÷k\Ï~Ñ­\İ7\É»û´Û¯\ê\÷4’ƒ\Ç\ğ\Ó\'˜Í½ø©\âK\Ça\æù\\ı\êÍ›\ÄZÆ¡ş¶ş_ûê£š%\Ù|\Ô\Å\ëA¡¹£ø‚\ö\Í1¾I[>´U\Ï\İ[[\İ\æ\ä\r¿\í\n( ı3¹³´·v.\ë\òÿ\0x\×1ªk\Ze”\Ì|\Øÿ\0\à5\ñÎ¥ûLx\ã\ÄL~Á¤Ì›\÷c\äf\Åf›Šş0e\óKU?\Å#\í_Óš\ó\Ë>´\Õ>&iZhoß§ü\×?s\ñ³J\Ãm[ı\Ó_;YşÏ¾:\ñªn\õI?\ó\Ì;\Z\ë\ô\Ù\ãfuB\ê\ãş™³\ìZv\'BïŠ¾;iú}ß›±\îÿ\0e\ò\ÕÀk_´¥Î \Û G—ø~j\Ù\ñ\'À=;C¿‚Ü\Ñ1û›Ù«º¹ø7¥G¢#¢\'M\Û\"‡j¯ü\n´H.x]\Ç\ÆO\êO¶\Ú	•Ÿ¢ªU6\Óüo\âZQ§\Üno\âa¶¾¯øQ\ğ·C]\öh\÷n\å˜|\Õ\ì\ß\ğ‡\éq¨KH\öÿ\0´(s˜úß‡|gb\\\é\÷›½\çşU\Ë\ÜG¨«¨¹X¿\ë \Ú\Í_¬/\à]P‡\÷–\è¿\î\×%\â?€>\ÖÄDsı\äZ€\æ>#øT¾\Ô\ë\Ø#7E¹?ş=_Tø&\Ï\á\ä\ĞÅ³\É~~\òU®sÄ¿±Şx\Ì\ğA\ä2£\Èı–¼·\\ı˜u\Ï\ÊÏ£\Ş\İE·\în,?•~c\ì½G\ğ“û4Pÿ\0Àš¶.ltøÿ\0\ÔE\nÿ\0º|¶ÿ\0<us%\Ô+\Ü:Ò·ı ¼s¢üš*lùƒ)*­Wl}S\ñ0ºs?\İ\â¾b\ñ-\×\Ø\î\É \ëF§ûM&µ•p“DŞ’}\Ú\ä/üie­K½\ö\÷«TUŠZß‹%·¾Îˆ\ÍÙ˜W›øƒÅš„“o8\Ï\÷TmZ\í\õ\rR\ÑQ\r»øV¹MRKK‹«”šÿ\0W·\ïU–‘Ë¬x\Ì\ò\Çû\Ç<IZVm›ˆ£Yd\ë#»Y\í\÷BY?…T\ô«š-«\\\\,¿h\Ú\Ìp¨7	m\ß\í\ê\"MÍ\ÛXV¾™¥ı\éü\Ó\ó\r¯\Z\Õ;x|½E\å–+\ïguk[y\ÊP†CÑ–€),\ït\ÉV<¯\÷kz\ëKGH.m\óµÀmÙª\ïg<U\Æ6\Ä\ß)ZuÏ™y>^7\n²¯#\ÜMƒ›¬‹[+¥™/–\æ\ĞJ\Ø@¢9>\òŸ\ïU/\Í\ö«GşT\Ï\Şÿ\0j»_	\é\óIr’\à4\r•ù¨- \Ğ.¥šeIbı\ê‡ıª\ï\Ó\ÃqMo¡7K+kT\Ó\õ}rw}Z½\'\Â\ÑÁy‚\áv‘\òÿ\0µXHê¦û\áÕªÿ\0`ùr\æ£×¬h\ğş\í\ğ\×\á½>5…~Y\æ¯HÒ­ü»U\Ïj\ægz-$tú)‡*k+š¡¬¢ª\\0©¦“h\ÍP•¾\ök6\ÍR\ózTE¸\æš\íU\ŞCX¶j\é¤\÷ª®\ÛiYª&\ëY–4\ô¥¤=)Ò•\Ê\r\ß7Z7\ZEZ]µ%j9z\Ğq\ëL\ïN aN)‹Ò¤_¿U¨\nÿ\0z\ï\ÍL±\í\Æ_š@7n\ê(¥\ÛR,{©]¾ıa\ã\ã¥D\Ñ\Ğ@\åù•iQj!š‘3\ïA$»F\ÚKÚ˜\ë\ïKP\"fù¨o»\Í8­Dû¨fˆz°ZzµT{/\ëMûfß¾?ïš›†¦ŠHª\ÔJ$¬cxX/É»ššA#“\÷Ÿ*\ÑrZ/]\Ã\ò°\Æ\Ú\åu½-$V8®½n„‰Ù“ûÕ—«Æl\ÃU\\ÍŸ?|Y\ğ\ê^i\íÀoÂ¾8\ñŞ‹%ü©°®\Ó_yø\Ö\Ì\ÜZ¿ş\Í_/ü\\\ğ\èû?\Ú\ã>ÿ\0ûµ\×Fvgx]l\Ş[®~Zµx\Â0¤Ûª—lŸÂ/\ÌJ\õ\ãµ\ÊÅ±‘şÔ‡\ï-tQ\Æ<\Ş\ÛXs\\Å³yk¥…VM’n\í\ÍQ$Vş[fš¥\Â\ì¶\Ü\ËV¦’9>C\ò\×_\à«X#\çq@™\ÉYø?[Ô¤ıãº¯\÷šº;„¯\"¤\Ê[\ñ®\á\ï­-åª¯\ãP\Í\â\Ë(\Óıxo\÷h2\Ô\ê>ø^/\Ú\Ü[\Ç\Ü\Zt\Ú.Ÿü¤ÄŒ\Ù\İ\óU‡¾0¶Ôµ†µ‰\ËIŠƒÅ·Z…¾´\émn]Iû\Ê*\Ìdt-º\ğŠ«U\õ]R\Ñl%L¢\ñ\\ı·‡üAª\ÂlSVŸá¡\"1¸¸;qü47¬\á¯\æ\Ù\÷s\ÅP^µ¯\â}$\èú‹À~m­X§­K6F…š\Épê‘‚\ÍEjx3şB\ö\ß^h¤#\ô|7\Ğ4ı¿¸Gÿ\0{\î\ÖÍ¥¾¦Ä¢\Ş\Şo\ö@®U\Óu[\È×™ı¦¤\Óü\'{2o–Y»µ\Ëc#¦m[p\ÙEÿ\0tP¶\ò\\}\÷ş\õfÿ\0`\İB¿&ñ¨¥µ–¿:/ü‹\Â|Q³‚\Ş\î\İ\Ñ\÷?v­¹/ ›ÂŠ7\Û+’øq*¦I\Ãa«\×\ÅV\ğ\è\Ø{…U\Ù\ëZ¤g\àO9\Ş4ù¾j\ô;¿K%º”C¶¾z\ğ\÷\Ä\í/G¸s4ƒo\÷«SUı ´Æ£‰%v6§\Ëÿ\0}P\Ğ\ì{¥—ˆ§X~q·ı\ãS\É\â`¨\Ì\ò\Çü¾]¹ø\ñ+\'\î,¿\ï\ìı+\ó\â\ö±u¸G\åD§û©»ù\ÔØ«U\Üøú\Ò\İpnWşk\÷\âÖ•n[Ì‘ı\á_+¿ˆµ\íS<\Íş\ÔcoşƒQ¦®\ê‡™\ò~\ô›¨\å|\×ş8ø}~GŒ>\ï\î\Ç^e\ã?ˆ\Z&¸€E©Ç¢\Ö\r‡Â½oP|¸u\çÒº‹/€\÷M\Ì\ä\î­\á:\öo-\Ë<Cj\çp®b}>Xd\ãü¾\Öş\rÃ¦Å—Ê¶=k\Ï<I\á»}/¡ù‡\Şf«-3\ÉYe2ûÿ\0\àU‹s¨J¤\Ånv\ïÿ\0Yş\Õt\Ş-¸{X\×\Ê)5\Î&–ø\ó	ùş\ñ \İ\r°\Ñ\îu\Ü@›y\æŸ>—r»\Ór¡ÿ\0Çª[Ë«$£\Ë$O\á­m2n´·¸¹ı\â‘üT­ª\êŸÛ—\r<±GĞª<º\Î\ÔI\nI;A\İUZ\Î9ùÿ\0\İZµg‹{f	\'\Ê\İV€5Æ¬\ÒF\ñ&fo\÷«Nm/\ÌE–\ß.\Íı\êÁKX•\âwß¸ÿ\0v»\Û?\r\Ïı”Ó¦\ôlı\Ù?»¶¬	ü?¦\Û\\X¢\"yJ\ß3\í\õ®\ÃJQo²(ÁU\Ìø;K–\Ş\ïd¿u«\Òa\Ñâµ™\äL22}\Ö\íAh“û.-B/új¢­X\Í>‹¨\Û\à¿Ş¨\í&HQN~oºjº\êmJ/7>Vyj\ÂGL}\ğF°\÷…np6ıĞµ\ê\ösy¯ûU\á¾¼KxQv×±\è\÷h…\ì+’G¡]sL•©û¾µ\ô¬5DR5P¸oš¬\Í\÷šªºî¬™² ?3S?J±¶˜\İj¡M£;©«\Ô\ÆZ)4|TNµu\×p\àS\Z\Ü\î¢Ár\ÚZ¼-ø§1EŠ\æ(§ùgÒ¯ı•Q\åŠ,UÊ‘Gº¥Šj›\ìÿ\0-H‘\Ğ o–“m[\ò\÷S|¿jUe\"¨©¼)†=´Q›j=¿İ©\Ú3M\òşZ	·Ö¾\Ô\â¿\ğ*P¦‚DÚ\Æ*6…j}´´S\Ù\õ¨^7şşÚ¼\Ñ\Ô~_­+›,s¯\\2\Õy™\ÛşY\í­\ÃeªsYúT´]\Ìo1\ã=wS¾ĞŒ˜š®Kj:\ò\ÕT¯™û¿(#z¤	m¤x\Ï\î\ß\å\ôj±,\é\"a\ë7k\Â\Ût¥ó»– F7Št\ß2Ù¶|ù\ãm\'‹Ä‘>ú\n\Õ\ô½\Ï\ï!\Úøÿ\0W’|F\ğûe¤ş¼v\Ö\Ôİjˆøg\Ä\öogzã”\óYp\Üm•s\÷Mu¿l\Ş\ÏXºB6«;curú$1\İ4±H>f7ûU\íS|\Ñ>zª´\ËR\Ù\î‰\\}\êĞ·ùcPj\ôVi%²\ã\ï(ªÎ¾]UÉ±½\ë¢\ğ~‹s¯L\Ñ\Ç)E\ï´\×5#Ws\ğ®\ãË¿d †w\âe\İqp[ZÛ³øW£\Âz\Ç\÷«v‚È´\ï=\ê\Ì6ƒ\á=+I¹G·‰ÿ\0Ù«Z¤1CªıÀÛ…V´­\Ì\\\÷«\"e\ä)¢}5X‚€m2\çP\ó!aY\Ñ\ô©vüµF\'|Oş&\ìk†z\ôß‹V¾]Ê¸\æ%h6F×†.<½V­KL“Ë»‰ÿ\0\ÛZ*s\ï\ro\öˆ\Ñ!GE»…›ıŸŸùWuûMAd‚9¿\ÙV¼‚\ÓÀr\Ü¤³y†\Ú\ßÓ¾\Ü\\:)Q¿Ú¬¬Gºk\ê´F«yÿ\0\ö\Û9ş7®z\ë\âÇ‰µùh _\öR»M?\à½\Å\Ç.ÿ\0/û)]E‡À1q·xf g‚jš†±­.n\îåŸN\ßGº¼•Po\÷M})«|¶\Ól\ğ—§4\Ï	x\nÁm%–FMÿ\0Oš¨›Ÿ7^xVÿ\0\ÏH¢M»¿½]•\ğwX¼U2¸Eş-µ\ê\é\ğC\âì•\Õ\Ùl[\Ù\Û(|z­\0yf“\ğ7\äı\ì…ÿ\0Ş®¯Jø7§Z\í&5o\÷«Yüme|\÷¿\İB\çâ–Ÿn­€\ì\ß\íajJ\åfåŸ€t»?ùgüV¼:>gÈ+\Êu	\óy[?¼Æ°\î~*jÚƒ£\Ç+¯û\Ğ¬\÷¿¶YZ°\Â*µV¾\ñuŸYc_Æ¾~ş\Ø\ñ.¬\í¶\ÚU_\ïHûi°øO\ÄÚ„™w©úµ\å=\Åş,¶Ô›\ä¸\r\é^G\â­B8\ËJ\ğ$\ëş\×j\ì­>\êwƒ\÷\÷³n\í´*\â¹\ïø./Ã™ÿ\0Ò®>Ec\ò\î«Lµ\Â5\í@\Üj^|cı\Å\ô¬«ûƒ;8e”Sü[%\Î_\Ì;[ıš\çş\İ#B‘\ò\Ø\ê\ÕFÈµ,u4J~f\Çr\Şi\ã8\ŞÊ£ø\î\Õ(y*l;\Ê\Õ\ÑÜ˜®\nZ^¬¿Ş ek\ó%Ø„nÿ\0k\îÕ˜|?w7úDHZ yo\î\ÓÆŸœ©™\ìoü+­\Ñ\í\Ş\ãNgI6ü\éş\Ú\Ğw‡¬m5FŠ+\Ënbû²¨ÿ\0Ğ«¿{\áo\åE+ù±·üµ®LW…–@˜\\2•\ÇZ\Ş\Ó\ô´[±¸ŠN»†\ÖÛšW5±\ê‘Yºüû—;—øEu³\ŞI%Š|ÿ\00\ÃŞ¹O\ÃrZˆ#\ß<«}\ê\ßğ­¼ŸedŸ,Àı\Öş\Z.U‹;dTW\Ée#Ÿ\÷ªÕ¬~s\Å\ñf®\ÚÛ£y¨~\é©l,ÿ\0\Ó\"\Ù\ó6k3¢š=;Á/\å\ìwÜ¿xWµøz?\ô\Õ\å^¶r6×­i\å\Û/ûU\Å&wÁL›x¤*4Ì\Õ!ùEd\ÍJ\Óbª8\ÛSM%Tv5%\êk6\êf\î*X\ã\Ü\Õ%\Ün\ÚrG\æ»V\ßq«k´tªH9Š‰oOşµ;ÈH¨>ØU\ÊG9*[…¡¡\ÓtŠµJ\ãP¸£”,<\"¡­¿q5Y5{ÕŸ\íU\íE‹\æ,i\Â1U~Ø’t¥ûA\Ç•ƒ˜µ\åü´\é‘\Í\ëV\ÍY´]È:„\ÇVÛ¥&\Ïj’®Sn•­\\–\Zã ›m5,]©\ËÒ¤\Ú(»wS|½­RŒS¼º\0£2t§$o\Ü\n”Gµªdš\0¤\Ñ\í~W\å§-¨a\ßm]\òşµj(CF´\Î~},°\İ\Ê\ß\İ\ÍP’\Í\ã^qº»³J§u§¯\\Ôš\Î*›ø7µT%ˆF[®’ÿ\0O1»`VT\Ö2z¿\ŞZÌ«”=\İOı\õX^$\Ò\ÓP´t	\ó*\×M\ö_­Gsoû¦\àn­\"\Ì\Ùù\÷\ñ\ëK6¾*Ù”¥y¿‡\ã\ò\ï0w1\Û_B~Ô¾û§kz€#²¼7J±y&ŠT™f-{Ÿ¸x×¾uMc\öX•$M¯ı\Ú\Ã\Ômü¹k½Ö´¹$…%À\än\ÆjK¹¹û\ËNú–£x’¯\Ë]\ÃÛ£ºƒøZ°&\éZ¸û>·n‡5ª8\Ù\ôu£~\åµJ\ÒU;	Z§=ª\Îê«œ\ìš9?z‡Ş·¼@»¬\í\äû\ßv¹µ“æ®’ÿ\0\÷\ÚL;m¦)bû‹S+U[y7%N­Vec\Ëş.Z\î…_Ş¼şZ\÷Š0ù\Ú[\â¯“\ïT…·ÿ\0X(§[)Ü§øh £\ô‚\ÛÃºŠ)ı\Ş\ê\õMM™Fûuÿ\0{m|½q\ñ\Å\Z§ú‹k†\İüR\È {\êŸ}\Òÿ\0¾ªùO¨¯¾*hvhØ¹‹wûuršŸ\ÇkHU¼§<Àk\Ã\á\î±}´\Ü\ŞÜ²ÿ\0¡Øµ¥§|·‘\÷Î†fÿ\0¦¯»mI§!\Ôx\ö†@\Ñ\ï‰„.ı\ìß•r\ğº5\Ã\Çg\Ã)ÿ\0qı\Ú\ê¬ş\ÙYÿ\0\Ë¿\ïZI\à{+*ƒ\ò\ÏøJ5\İBfu³“suinÚ±o¥ø“Tv>jÄ¿\ì‚Íº½gN\ğ|Q\óå…­ı7GŠ\ßøµ±\ãúwÃ½V\á\×\í³\Ëş\Êü‹]%‡Á8¦Ÿ/ÿ\0]	j\õ+kXü\Ñ\Åt0[+¥M‡©\æ\Ú\Â>\Õ\÷Q®\ßj\è,|§\ÆT\Åub›:[ˆ\Îh°®c\Ûø^\Êß„?*µm\ÄakGÎŠ3\ó\È¢›X°·V\ßpŸ/\ğ\î¢Ás/S±Al\Ûd\ò¿Ú¯\nøµ\â\ë-?M#Aq‘°\Ë\"}\ß\÷k\Òü[\ã\r\ßtÚ\Û2§Ì–°n\Üÿ\0\ïb¾cø¥\ãËMp‘\Äb²	²4n6û\Õ\Ç<IªEª<›#\Ú\Ãw\Í\\\äJUzUù\ì\ä\Û5\ìU\Ù\Õ\ê\ÍIl\ÔM4xû\Õ\Ôh*?´b‚\æ=\èÎ¬+J·FÔ¿\Ü^›k¨&\Õ-\Ém§…o\á ^!\ğüŸ\Ú/„+\Çµ© FmtØ­%\ËoFa&ß—>”k:³\Ç?\ï{0çŸº\Õ\Ñøz;K\Í=d–_)W9fûµ`‹\Úm»\É7\r»\ïû5u:|rI¼E\Ç\î\Ï\\\æ™cqkr\ñJD	\÷\Ãÿ\0	­O2K}±¼\Ã|¿Äµ‹:‘\Ñ\ß\\A­Y ‰6,%˜·\ñb¢°h£\'İº³¼8\ÒY¼\æ\ã\Ón\Õş*kP³e>\\ÿ\0\rMÊ±¥ixk\ìù›­h\èw^®ˆ\êYK\ñ\\ı½»\Ã7šŸŠ×¤ø\Ã\ñ\ê¬®›™Ÿpj\ç›:)£\Ô|§ÿ\0£+ÿ\0W¡[F\ëŒV_†tu·¶^>j\èü±·¥r³µ[+Lvw\\U‰p¨\Z‘E)~Z\ã5}c2”\ï³ü\Ë\Å$‚\å(\íK•r_/­^¶µùj-F\ò[y±W\ÈC™^I#·F.B\Ö%ÿ\0‹-\íÕ‚8\İ^{\ãÿ\0Š–\öwf·—s¯\ß\ÙÚ¼·V\ñÔ²J\Çy‹q\â<ü\Øÿ\0jµQ0uu¸\ñ…¾şd\Ü\ßìš‰|a¨ü\ëç‹Ÿ\\yk¸2\Ê[–û\Ûj!\â\ë˜ù•\ğ\ß\İj®R9Ï¢.<a\Zª\ã\rø\ÕI|aoŒ»¯.¾ m—\÷—kPø¥š¶û¿ø\ó5W)>\Ö\Ç\Ò\Í\ã(—\æ\Ş{sUÿ\0\á>~\Ç\ç_+\Üü\\{„ù7ŸÆ£±ø \êû\ŞCşê•>Í•í¯­<X“/úÁ[6z·˜›\÷\îük\ä«‹\ÉD³}+¡´ø\ñh°ù_h}\Ê>\ìC\Ò5Q\ô\ï\ö\ò)Áqº®\ÛkQÿ\0|WË¶>\Ù*º%ƒø·}\å®\ïÂ¿-µKfx\å\Ü\Èv²·U®i0gº\rAu©#¼\rŞ¼¶\ß\ÆE\Ém«\õ­/Ä‚\ğ)\çme#¡úÎŞ˜ø¬;m@0R¯¥\ç™J\åXšOjT\İŞH1Öœ¬7\õ§p±(\ÍJ´ÁÖ²m ‘\Õ*ú\Ôbú\Ó\àGŞ€±¡U˜\ñXÉ¨\rø«q^&z\Ğ&O,5#G»¨\ÍA\ân\ëW-\ï\"c‚vµF5\õŸ™Ø¯ü±®,\Ù]ºŠ\ï4‘{V]\î›\İE\Zg<o¿¥UŸı]t:¥¿-‘¶¹«üÇº•Šlù¯\ö¹\Ñ\Òo	ZŞ¦ËŸ\ço\ök\ç\ßh¿hº·ˆ\å“æ”²\×\Óß´İ¸¾øoy77œŸ7 \İ^1\à4iú\":\0¯´e½kÔ ı\Ã\Ä\Å|c¼O	³Ó•v\ö¯7¿o1Ú½k\Å1ù\ÚC?\Ş\Û^EŸ5ªú›\÷{…\æ¤\ÓË½‰\Ç\÷\è¸ù…Eo\òÌ‡\Ğ\Ö\è\å‘\ô‰3\ËaûVº7\ËX>›\í\ZLDúWB«A…†2\Õ\Ói\ß\ép~\ò\×?]\'‡›Ì°¹©Ñ‰fÍ¶¬sUaıÜ®=\êsp™ƒG5\ã\è|\Í\"J\ğk•\Û3C_Ax•MÆ™/\Ğ×jKş–ÿ\0Z\r?š\ÅZIµZŠ\n\Ôû6\Ç\Ãv‘…ıĞ­ˆ\ô˜\Õxˆ~U©v\ñr\î\ñ¥—V\Ó\áÎ¿\Ì\ß\ìÿ\0\ö*X,\ö\ñŠ‚û\Æ\Z}º1ß»ı\ÚÄŸ\â5¤%¶ ÿ\0Qa\\\ë\r9­\Òš¼\ò\ëâƒ³0O•¼¢±¯>\"\\Ì¬>v_­¡\Ä7\Î*&Õ­\áQ¶¼¨ø‚\îhZDuJ\å/üp#vŞ…ÿ\0eMŸ@\Â]§Û²\åªY¾\'XYÃŸ—ş\Õ\ó!\ñ\å£\Ëy%ÿ\0t\î§A\"\ñÿ\0Qbn{\íÿ\0\Ædù„ÿ\0€Õ‡s\ñb\ö\á~L·ş;^CŠù\Ñ¢¸\ñ_ùk\òÿ\0³PE\ÏN›\Æ\Ú\Å\æ\ïœ*ÿ\0µ\óU	µ«\ë\õ·»İ¯,—\Æ	\çß¿\Ş5}\ñùm·\ğ\Z™\İë—‘\ìs\ç—~\ìÆ¼£\ÅÚ’2°\ó7q\÷Vœ\Ş&»¾Ü¼ûW+­]K½\÷\'Z\r\âg=ç˜”Ü¿İªI4~c`m©m\ÌÜ†¥}\á¶\ó\Ï\Şo\á«54´v¹ß‘µ¾]­\é].ˆ¿Ù³,‹¾MÌŸ\ì\Õ\Î\è6şL©$\ïº&®«\÷‡\÷k¥µ¸E&ø\ö:¶\Ğ\ß{\"‚¾tz…\æË‡Ï»\æş\õj\éZ•µ·Ù¤€Êf?*\Ö#\å‘u\ó­X²\ì\èş`­\Õj\ËH\í–f\Ô,_\ìdº\ï\Û\å±\éZ·:[´*ù\Ú\ËúW3\à™\İØ»ºªÿ\0\ruw3&øÿ\0{¸›OŞ¬Y\ÑR\ÎD’\Æ/\ï\ò¦¯Kª‹mrR\İ¶,ûU¿»]4\Ö\ò¬H@;Z²‘¼c\Ã\ò\íE­\İû\Õ\ô\Â\ï	\Ëg	>\éù‘}+\Ìşh>eÊ¿”Y·Jú{\Ã\ÚZYÚ§Ò¹fvA\í\á\ö\Ë\ñPXÔ²|½\éK5d\Í\õ#\ò\÷S…¸\ïS,~µb8ü\Î)r²[ú\nœZ…\ç\îÿ\0½V¼±Z\á¼}\ã\Ë}.´ŠP¿ß—w\Ë\ô­›e\İ\ÅQi\è\ñDC?vş\íxg\ÄŠFio)i\ßå‘—ø²¼S\ñ+l7\ß{³Tş\ïÖ¼KXÕ®\ïYK–g<V†eûırK‰%\ç\æ\Ï\É\Zü\Íş\óVD\÷²y’¹fo\âo¼\ÕV(n2»3wùkI4{\Ö\Ú\éš\Ôù‰\öl¯6©$[v>\Åş\í`\ê¾*\òÑ€G•¿Šº§\ğ\í\İ\àÌ–¥\Z«\Ëx\ìoG´A\ì\'\ÕüI{y&\×>W\÷v\Ö2\Íw#oyKÿ\0µ^\êÿ\0	\âùŒˆV±µ… «\Õş\í\İ\ğ\íJ\÷S\Æ\Ö\Z\"º¸e\á\ÍvWÿ\0å¾L«µTc\ğÍ©Ä‘üµ^\İ\õy˜1j§\Ë!R¿\ÅZ–,\÷H²½ş\ÍkC\á4\Ç\Ïj\Ù\Ó|.‹\n²¾³uQp \Ä\Ñä¹µu‘2\Ë\ò©Zë´«§\Ó\õ6\İ\İ7\íiµe\Úi\ïg¼}\åzÔ³Œµ\â¾:…Z\å”\îvB;˜<A,“\"!ù\\şU\Øi {vT\Î\å¯;¶\Ä{¼+£\Ò\æ\ê^¹[;b_\Ñ\õ¤¸E\Æk~+\ï—¯6\Ò/	UÁúWQgx\íËš‹›\Ø\ë\á¹\İ\Æj\Â\Í\èk·¼m/6¯5Rd´tu´u¡\õ\r¢°[P]\õ\"\ß\ì\ÑrlmM¨m^µR]S\ïf±®5*Ë¾ÕŸw(\æ*\ÇI6°6\ğvµD\"•{†®\óZÿ\0omUO&2\ï\Í\\L¤z„>&ùyaº¯\Ú\ë#«\ç\õ¯—\ÅQG\ÎCT\ö\Ş>··oœ¿\ì\Ö\éI£\ßl<@\ïÕ³¥\Òz¾‹\â%¦\Õÿ\0H\Ùş\ñ­\Í\â4m*<2ÿ\0µUcsÔµ-=&‰ŠW®Û›rÃš\ëm<Ueq“\'\Şêµ\âH\à¾Fh\Èn8j–ƒœù»\ã\îÁwA\ÏË¼\èU\äºGDş\õz¿\í¥|-<I\ón‘¼\çE\Ñ\åš•5\×KDyØ\Êú¼{´ySÚ¼_Rùn{µ{\åş“;[\Ü&Ã·\àş!­µIc>µ±…7¡-D½ji:T-\ò\Ö\Ñ3‘\í?\r®šbj\ì¼ÍµÁü †K\ëFAü&½;şù\òh¹Œ\ï2º	Éºicş\ğª\é\áÒ^®øO[;\öù·\rÎ«y\ö]NX½\é«pYj\ç‰l\ÒeËŠ4Ø¼T¶¨\ÉÔ–I¬\å7.+\Äuûso~\àŠú1–/±¸¯\ñ´;uY~µI’\ÒG5\Ê\ôP‹\ó­©\Ñ\×4»“ƒ:/ûLk&\ï\Å\Ç\æ\ßyÿ\0|š\ñ©üM$œ\É)oÆ«\ÂLÖ¬\Â\ç©j1·W\Ú\ó;ş;«.\Z\'\ğ!o\öš¼\Úmz[‡n>Zµ‰:|´\ï®|mqü&5Z\ç/üey4­º\ä\í\Ï\ğ\×>\Ë<\ÍDúk\ï\ï\óP´ø?V:—†\å>cK\Ç\Şc\óW‘\ë‰©:1\Ü\Ùş*\ôo†–\ï‘,G\î×œk\Ún\ír\ã?\ßj\0–\ÛRû:`Ò”ê’·LÕ«\r%;\í\ÛVF—µ¨3¹“\ö‹Ÿ\ï½9~\Ñ\'YµV\Î5\êBÔ¾\\Œ\ä\Zc­‰\é’\ËŞ¦M=:ì«¿l…j&\Ôz\rÔ¬4ÍŸX\Ù5\Îo>dÃš\Åøog\öŒ\Ù&\Õ?¥^\Ò$\òmA¹¿¼\ÕS\Äú|¶\ñ\ğ\áœü\ÅWÒ¤\è‰ÀÀ¦3¾º)¢\Ô-–	\æ\Æ\ÑUtûtšFGr·ş;]6•km¬XŞƒ™ı\Ú\rÈ´?\Ë|ş^\ô‚Tù‚\É\ÜV…ürX\\[¹O\"{u\ÍEaÌš\âO°\ä\×Ew³T\ÓY	p‡\äuû­@\"ªIÕŠ¹e\Ç1\ÅtZ>U¼¾~µ—e\ö™\Æ\ğÊŸy«n\Î\ÜC+>\ó±£l\ñüU¢_\r\Ç=¼˜)\ò4œ\îş\ï¥j\Íj\Ğ\é\ÛÄ„Ê³Ÿû\æ“G„\É?6\ñ¿w\÷j\İı¿\Ù\î\çt?¸ûËº†k;[‹\ÉT>v×²i¶1\êS\ÇÏ•O,µ\ç\Z\Ø\Ö\r&Ï™¤şK^»\ğ«OûC·˜›ÿ\0y\òV:©«\ğ\×Á¯g¶\ão\ğ×ª¢ˆ\âP*†j,\ôØ‘\0«\õ\Ê\Î\ÄDWqÿ\0f¤]«Gİ¥†?1\ë2‡«\ö\ñ‹xw½2E\Ü_øk/[Ö¢³·iep©Š2|_¯{‹‡s¼`\á¾k\å\ßx‘µ\ÍU™%iRÂ¯\÷«¯ø™\ñ(k\ì\íœÈ™Û¶*\óı;K“\ä@›¾f\İO˜µ˜¯g{ªJ\Ş`Ø½ªY|\ÂlÂ·\÷˜WMm¥\Ë\Î77\÷«F-=\äe\Şÿ\0\ğ\Z\Í\Ì\ÙSG+a\á–û›Ñ›\é]&—\á\÷Œrˆ\í\ô­\ËM6ÿ\0v·¬4ø\á_ş*£œ®SO»}ø…Y·\ğºgı^\Ú\êQc\í\óT»m\ÛR\Ørœ»xN)Ïš«s\áO›d_7\÷«´uùj´Ÿt\Òlåš¿‚RfûŸ¥rş–Ô°z×¸\Ü\Ã\æzW=«\ébF\éY2\Ò<F}%\á?s\ô©\àµ\n½6\×£›µ\Ï^imJ›³Uc}\Z¬%ºFsüT\É!1\Ô~a\éšW4\öh¿\Í/5¿a\ò\í®j\ÚOš·4\æ}\ëSr\ìv\Zl…vâº«	\"\ä\×%¦ş\íVº‹™V¤f\ôrmJ”Hv\Õ(”Ô¥Š-\ó\\Z©\\]y}\ê+»¯-w“XZ†¡»½R ¹sª\õ¬MKZ*¸\Ïü\n³\ïuo,7\"¹-_Zû\ß=R\î·\âo$6n®Z\ñ\ä°+lŸkU-{X-¿a\İ\Åy¦©5\Å\Ã9|¯\Í]4\Ñ\ÅU«üB½o¹.\åÿ\0h\Õs\ñ\ã?¼“o\ã^oq6\Ş7UW¾H\Çvj\ïQG›9H\õOøXò”‘™¿ºÆ»_|@šdB\ã\ß\Ç|\ØÚ¤‘¶qZV~4¸µO-\'tO\î­i\Ê`\æÏ°,~(Ikû¯7{v‘k·\ğÿ\0Ä¯µId\İ\Ç\İİ¶¾/\Ñüi&\Ås)—ı\ï½]Å‡Œkx	Jÿ\0yˆTû2\ÕC\Úş2ÿ\0¦iPŸ~ej\Í\Ó<‹{8P\Ğ1®Z\ó\â\'\ö\æ•Áhu\Ø\Í\÷¶úR\Å}&\Å®1±\ËVz—\Ú-\Ùe\Î+æ¯‰Æº\ì¦0:Ÿ»^\ÌnEÁ5\ã~?„ÿ\0j9\÷­ \Î.Oº*\ëV\nüµt«‰R=Cà¾­\ö;™c\'o¥{5Î¸›w|\ñ\ğ\ê\ã\Ë\Õ9ùk\×\å¸FHz,I¸ş$¨4\íq\ÛSƒŸ•°D‰Š,\æ\òï\ÄQk™6tş5ÿ\0¤e\Û\Í\òu­_~\ò\Ú\ŞJç¢“jÖ¼§<¦\\š\ãlL×x\î?ø˜1ş\õz\íÇš\óoˆ‘şù^ª\ÂL\ä ·2H¨>\ó\Z*\æ‡™s¿øPQRY…“,‡”ùju\ÑJÿ\0®½-}§\Z|²7	úU\\\æ\ç9\Òÿ\0Ø§¥¸^\Ûk´_\r\Ë2gg\ËS[ø5\ä©sŒUİ¦¼%™p\rz~\n¼V#\ğœq\ó³?…9\Êş\0Wû3¡\ç\Ş-›\ì¾ •c^×¢i)f„+^Q\ãı4I\â|wş\Z°LÉµ\ÔA²4;jYn.™¿»W4\Í7\÷\\%Z—O4\n\æGq\'SOK2\İ\ëXX¿qV¡\Ò\Ë\ZW&\æ\"\éiüU/\Ø\Ò5\á+ \Z^\Ş\Ô\õ\Ò\÷Qp¹?¤z–\÷@ËºÂªø\ß\÷\Şj¥¿”Ÿx\Ê\ß\Å\í[\Ş\ÓR;\Å\Ş{\ß5\Ä]R)<«Kt\İ\Zƒ™?†¤\ê¤\Ï<\Òtÿ\0´]¬i\÷{µoi¾“MOpû\÷º±U?uG\ğ\Ö4\Êm\ì\öVG?ø\íu\öz}\İ\Å\ä±\õ)\rı\å \ê±OL\Ùg%\Õ\Èp\Ñ0\ÛUm/¿\Ñ\\º®q\íW\î\í\Ò\Ö\Í\í¿¿\óÀ«\r\ñ\Ä\ñ\÷\ï@Ñ±\á\Û2e•Áh%FØ¾ÿ\0Ş­\'¸\İ\ñ¤_*»©º¦@ùŒYª\öWwÚ†N\é¾\ïûÁZ \Ğ\Ô\Ñ\ä\ó%\Ów‹4…7´µŒ¬€üÀs\\\å²\Éş#0ÿ\0g5®—ú\Ñ\ßxfEmÿ\0\Ş\ÛAW4tL¢Xynx·\Ì\Ëÿ\0²\×\Õ_´t’\ÍnY;p¿û5|—\á†{\ÍR\Â\Ş3ü|/¶\í\Õ\÷Ã4\İ@6²»\\\Õ\ÚG]ÊŠYO»@Œm©Qv­r\È\é#U\rVcŒ(¨‡ZY\æ\òacı\ß\á©®«¨%œM—\n£­x×\õ‹¿;¢[_º#éº»]}¡;•\İ\\LÑ®\æ\Æ\Z³s6Q8\ğ\ËÛ¯Èˆ‹şÈ§‹_²§\÷šº\ë˜\ÍeOo\÷«&\Í\ÔdWcW!·R\Õ<6\æG\Â!jÔM[T\ó®F‹\ó\Õ#iÉ´\"š\Ñ[?-w\Ê\è‹şÑ¬\Ëmj}X´ZDb)º—\îşµgû6\Ò6\İu-\ë¯Ucµ*’e§\Ö4\Û1·\Í2·\÷Pn¨Ä‘\ícs/ü™7ˆ4ı=1V\ñºª¿Œ\àoùj•ªƒ‘ß‹/#ûš$\Ûk\Z\ó\Æ\×\ñ«gD¹Uÿ\0dU\É<unÅ¿‹\ñ¬K\ïy›¶¶‡”È¤ø•#\÷\öSÁş\òT_\ğœY^p.sVlş$m\Û\ğ\Íş\ÕrºŞ—a}¾EO*Vş(ş]µƒ‰\Ñ\Ê\óTIº8\ÛYWRZ\óC}¡\Ü2I+Oxj\èt­p^\ï\İY¢\í\Üz³]¶\õ­+‰·\nÈ¹ûÕ‘ªeû»«¡²Œµ\Ë\éY\ÍuúR–\Û@›I_º\ru\Úr\í*7W?£\Ã\Â\äWg¦Z\ğ§e>U\\\Æj+Ì¼&\Ú\èl\ì|\Å\éR\İi?#qZX\Î\ç™k6³\Í\ÂI³ı\ê\ãu\Ãk½$}Ìµ\é#\Ó\ä‡qj×Œx\Ú\é£f(y¢\Ã1µ\Íhü\Ç5\Çj:³È¬U-cXv•†ú\Ë<\÷·50,K1aY·V>v\î~jÔ†\ÎY;V•†\ó7\ÜùªÓ±“‚g/‡Zn‰\óTÁ\òn\åE{™\àSqÌ™J\ê\ô¿‡p|»Â¿\á[ª¶9\åI:M\ğ\îI“y\Ê\Õ&\ğ\Ôm\ò@]k\ëhüg\Z\ábÿ\0¾ª9|\Íû°\ß\ï\n\ÕVg+ ®4;›\æ9{MÔ¯,d_œ²µ}\â¯Û¬.‰i\Z·~+\È5ı[É?»]p«\ÌqÎ(¶—’\ÜD³ \Ü\È}~a^…¢k\Şi\é)?69Z\ñ¹\ä–m™F\ìÕ¹\à\ÍBfş}\Üşµ\Ó‚§ºz£\êH¿\Ä+\Í<p\Şe\æÿ\0½š\Ù{‡n\õ\Ïø‘w\r\Ô4eI\êrRÿ\0Uo½W\æZ¤\ëDN™\Z¾˜\Û\ê1k\ÕR\âI#\\\Z\ò\r\"O&\ñŞ½^\Â\á>ÌŸ7j£—\à¯Zz\\ùl¯\÷Vª¼Á›Šs·\î\êÑ‹=Yay\áˆ%\ËB\ß-t\Ús}³Á¬?º8®^?–µ1d\õ\Ä|@Œ4y®\Õz\×5\ã;q5›Ú¥’;\Ó&6qKıÖ¢ªÍŒ²\÷¨¨:Q\î\Ş¼b­§‡\âÜ¿»EZ‰üIÿ\0ª¯\âäºÎ•\Î3y4˜\öc…©O‰G5\Ç_ø\ó\ÉO‘¾j\Æo\\\È\ß|\ÖnfŠ›=7\ì¶\ñ\÷\ÉgrEp/«\\M\Z¹s»\ëUş\Ñ<d=k/hUz2^[I¹\Æ\ìW˜ø\×OFÕ³\÷·VÎˆ\Ï\ö\ÎIoÆ±>\"+\Çw§Ëº·Œ\î\Ó\åaoqu+´[úŠÈ³\ó<•\Ë\îf©’=\İj\ÌZ-4Ñ­5o•:%0F‹F\ÔV¨&\Ã\ßPv^3\í’v×‘6\Ö\ï„<7q\â­R\Ş\Â\Ê#=\Ä\Î>\ñ \Ò4Ü™_Dµ»\Ô/–1¸\îş\íz•û)ø§\Ç@\å—e»Ÿ9ù™İ¯¤~ü\Ğş\é1\\jC{«”\İ$²\r\Ëş\ê\Ñ\âÿ\0š~‡¹@Ì§\î\×\r\\R\ôXL¾s<_SıŠ\ídŒyúÛ®İ¨•ƒâŸ€\÷¾´D²¸ûR å±µ¶×¯\Ùş\Ğ\ZV©+G%\Â\'ûÕ».¥i®i­,2\Æ\èãš±†&\ç|\ğ|›£\áÿ\0\è\÷6rAÂ®¤\å«h\ãX/>~v¯¢~!øÎŸ\ì\ñ\ófİ†\Ç\İ\Å|\í¨\é\òÚ³\ìùù+\òÿ\0z»\áW™eJ.A\á\é “lg\ç\çi¥¹±KTˆ?\É9\ÇûY­?ø~5\Ñ wùn	i¿\Ú\ÛV\õ\í.F’(‘¢8Â¶¹…^\ãPK‰Z\Ñ~TŠTo\ï5/†\Ù\ãºl¦\åu(k?R\ó!\×e>e5\Ò\é¶\ò5½‹\ó»L¿Å´ıÚ¦LN\Ëá§‡c¸\ñm¹V5;¶\×\Û\Ş\ìúl	ü*\ógÀ\Çu-\ÓÅ½£c\î\×\ÔV6\éo\n\"\r¸\ÅQ…4h\ÇÖ¤\ïL‰KU…¹Y\ĞDË¶³u+¡\ó şµ~\òM£ƒ\\\æ¡\'Ş¬›4Š9\í]¼\ço\â¬fµMÕµv¼UX­^Nk&nŒ[›sµ¸¬Kˆw>Ï»]¤\ëºo“\Èøƒ\ÅV\ö(\ŞBF\Ïı\ê“Q/µ/Ùµ\ÅÁı£®-5I|It\×\Zƒ˜¬\ÇÌ{ı\ê\â¼g\ã‹K^\î\ö\ñe•z/\÷\à5\ã>!ø½«\ê\ã²&_\ïªK˜—\îŸMx‡â¦Ÿ\áûG¶´uVQ·r\öú-y‹h!n\Ì\ÛGŠ¼n]kQÔb’IŞ¢\ño„n,\ô¨®üÀ\ëß•\Õ\ZgJìšº\×\ÇmN\êo’_+Ò¹\ËÏ‹\Ú\î\ï“P‘«k}\Çû\íL›O|n ­u(#Ô‘\Ô/\ÅMw9ûl¬¿Z\ÒÒ¾.x‚\ê\å ûQvc\Â\×¶}«¶øW\á¿\í\ÏYA³vYı¾j|¨^\ÒGoÄ­WOŸ}\í¹\Ûı\Üm­\í+\âe¤\ß;ù\\ı\Öş\Z\öMk\áÎ™y`e².Şš¼g\Äÿ\0	`±¹yl¥Ù’\Í\å°\ák–PGU*®\ç@\÷Vº¥»lp\êÕŒ‘Ë¦Í˜\ó³5\ç\ëq©\èw2\"»\îCµã®³J\ñ7\Û\áL\İwW$ z´\çs®³Ô\Â\ì?z§–2\ÕON\Óü\çW\÷\çûµ\ÖXxv[‚ ¡jÃ”ß˜¡¥YË·\ğ\×g¢G·ni¡½œ+V´\è\ö\í\Ô4Zgi¤Æ›—]–£j\àW¤ı\Ú\î4H\Ëmş\íLAf›aZf1Pé‘…Z\ÕHø­\ì`\Ï=\ñ®šc³”Šùc\â]\ç\Ù\ä•3\óW\Ú\'\Òş\İa*½Šø¿\ã6š\ö:Ç”\à®\óNÀ™\å\rn\÷R\÷ÿ\0zµ4\İ,+\å\Å:\Ş\Ü[®\\…ªş([]\Éo\ó¿m´X«m·‘o·~*\ì~ °³|y‹¹…k\Ïl¬\ï5‰\Õï®ø#¯F\ğß‡\ôM6%*)_»\É\ó1­#M™JªF¦›\ã+mÍ±$eÿ\0dWQa\ã;HÂ™2«şĞ¨\ì5­Q¾ÿ\0¾kZsL˜\ì\Ù\î°Z~\Ä\ÃÛ£J\Ã\ÅW‹Ä‚¯=\äR©˜\Ú‡µ“q?\÷\â;1ùVm\ï\ï\ícitW\ÍP7yS·_\÷Z—³hÔ‡\ëViq¸œs^Y\â\r>vD\ÚKo3[j½¼ÿ\0\í}\ÓX#˜lg2š\"\Ú`\Ò<3X±x\älÕ[ˆ\á—\'\î–Z¹â¯¼\Ïéšƒ\Âp\í±W\Ï\Ì\çuz\ô]\Ñ\á\â’Lè¶­cø=\Ö\ëW\æ“mf\ê²y–\Í],\à\ç)7\Ìj´µmş\õ@\ë\Åb\ÆEnØ•~µ\éšEÀ’\É>•\æ+\ò½vú\r\Æ\ë4­‘\Í#¡sR›³›\æ7­K\Î\ÎkDcs\Ó|7\Ú<9<yû¥¾Z\åüÍ·\õ«\ğ\ÎGh®¢ş\÷JÏ¿·\òuW\Ü\Õ1şecxŸ\÷šsÖ¦Ñ·­dk5£\ó\ò¨¢D¯ˆ\ò«\ÌB\ïı\ê)ú¤;¢J+#­\Z“j’\È\ß<‡\ó¡5·Ÿš²~\è¦,…k\æª\Ì\×dlj¼WY_â¥°\î?vŸxüµ\ì¿g\ã@·ú\ìVQ\Ï8¡i_ü+­U\rÍ”2‹]*Ÿp\Ó_Ä[¡\İ^\ñ\ã?\Ù\çF\ğƒH—×®ƒ†\ò\Â-|\ï­Û¥½ü±\Å\óF®k*UM†\Ñ\Ğ\è>\"y5øUÿ\0ˆ²m	®?D\ß¥øÖ»ˆÿ\0\ò\nŠG\í^¥5¡\ÇP\æ´\ë\ï2:–M@\ÆzV^p›p*\Í\ÓV§#%mBVn\ËMûD\Òuz \Ó\÷Hİ5,\ì\ä¼u\\¿=6\×ÚŸ³\Ç\Ã{O†ş\Ä:„bMZ\ñ7A\æš4\õ¯ÿ\0fÿ\0‡\óø\ãÆ%\ÄR.j>\Ñ;g°\í_R|P\ñ \Ò\ô¹Q‰\"b*ÿ\0>\è®MnE\Ë\èr\Ì/¶Ÿ1\ÆüRø\Ì\ö\í-¼N^WÜ¿/\ğ×\Ş\Ş\\\ë-,®Y‰ûµf\ë\Í\Ö5)e|¶\ó[\ÚW†\Ó\n\Å7W€\ï#\ï¡N\áds¶:—Gf\Ã]\ç…/5®\Í\ò<yt~\ğŸ˜<\ÌWEu\áu”¡{§Y\'¡“ªGo\âV\à}ümúW\0ş‰¯\ß\Ê’n\İüK]­¦\í>\ñ­\Ï\ÜzÑµQ\â\äµ\ÛN©\åÕ¥s\Îu\İ=-R\ç?*¢\Ãÿ\0qw¯\ôÿ\0Ğ«ƒ¼’\âk9dùşwX·uºÿ\0\ì\Õ\íş/\Ò\ÓR³09;«¼\ğü\ğKÂ·L\å\Ã}½Ju9\Z­.S\Ém\ô¹.µØ–\àF-\ê»Oÿ\0V9a\Ô\ŞùR¨\í\éZwh†{{‰€s\÷j\r6\ñ?¶\"/\÷¤‘¿¥uKc‚?\õÀ«?±\é\Ç\Ì\çš\÷xxZ\ò?„\Ğÿ\0Ä²\×j§\÷k\Ù-˜2üµÁ&zP-Û®\ÑOv;8¢%ùi²6Õ¬\r»\ÍÛš±/#-[—UJH\ë6hz[›\æ\ÍP¾¼£\0WCso\ót¬\Û\Í7\Î\r‘Y\Ø\Ò\ç˜ø£Z»›tq–¼¯\Ä6:®¤Yº«ue¯ o<7\òU	<7oE+™\òı\÷Â± if\Ë)ÿ\0†³¥ø2’*²ù«»øq_P\\øn)$\Ë\'\ËY\×z8„¶ÁZ¯t—©\óƒ|5Kc\Åÿ\0\Ç\ÍQ^xen-^\Ù\Æøœm+^\ã«\è\"á·Ÿ›ıšÅ›I´¬B¯˜S\æË7¨\òI§\È[ø‚H«œ\Õ>\ë\ñÊ¨\ö\á\Ùz\ì5\õ\î\òso9—\õ®v\æMB—¸‘\Äÿ\0\ÂRµU]ÏœáŸˆ$‘Dv\Û}|\ÃÒ½»\à\çƒ\à\ğXk›°\ñú²‚·/<E+Y°]>8Ÿ³-T\Óukˆ\Û\Ìt\ß\Ç+ı\ê%P•‡;ûÿ\0n_.8\÷½\\†£k¬\ë^l–\öÿ\0\"­º©I\æ\ß3\rûµ¹¤\\\\\ÛÀ±,\ßŞ¨\æ7TTNF\ß\á½\å\õ\ãK8)v°®™>\r\ËyOq\å\íDÚ‹uZU¼»·¸?\ï5t6\÷’*l©“5I\Ä\ä<=\àt\Ğ\äT\å¾j\ô[}6\Ş”…\ñPZG»\ç\"®.k–e\ê1Š£mkºZÓ¼_1”-X³\Ó\ö\í¬:b_\Ò,ş\íw:<?v°´»?-T\â»\"\Ì\íSPhoXÛ…J¾µV\Ù~\í]E®ˆœ\Ì\Z9p\Õ\ó¯\í\à/2¿3\òuâ¾’H\Ír_\ô\í\Ï\ô8ª±šg\çOˆ#¥hs\å \ê\Í\\…\æ±ogû«D\óeş\'o\ïW}\ñCI»·¿\Ò<¥«Á¾O5n.¢vF\è\ÒU\ÓDT›Š8\rO\ÆZ—“i=7U}7\Æ\Z¨’‹\İbK“ø>ıo|c\Ğ\×O\Õ-\äAû¢›EyÏ—\ò\ãÖ½HEX\ğ\êU\Í]S\Ä\ÓG\"‹+\ë©}ZCüTX|F\ñùK\Ù:\Å5/\Ù}jùQŸ´‘\êø\å¬Ú²ı¯}\ÄK×Ÿ™«×¼;û@A¨C¹z¼§\á\Ï\Ã\×\Ô4V¹•>Gn?İ¬¯\èsø^ı\Ì8\Ùü?\ì\Ö2¦šud¦5/Zx«O\ØQwcrIüK\\_\öƒ´2\Û\É\ó2½^[\á^\Ç$eÃ¼\n]~\ê×¤[\æ\ê\ç\ÍvQ\\2§\Ê\ÏITMÏˆ­|\Ä|\÷\éPi±‹XU\ËWüq3\é¯o>V\ë•ş\Úv¯NŒt<K¼ÎY7wªW\ê\Z\Ùÿ\0½\\\õÎ¼\ñµU—]–o“µ\ĞrÁ{Ä®¿3T®\ÑS\Ûï™©\÷–şX®{\êw¥¡šz\×M \Ş$6\ë¸\×//Ş«“?J\İµ\ÙKªF½\r\'\ö\ä{:ûê¹¦^ü\ÕV_\ŞÖ‡;=›\áF¼—\ZÄ¶\ã«\n¿\â¼\Ú\ê\î+øW!³\ñU»ú×¡üBPº’¸\î*Œ™\Ï\Éxø\ëX\Ú\Å\Ó\ÉjÀw«¯\'ûµ¬oÛRÉ\ç\'¬£\é\òÿ\0\ß4S<O˜\ìp{\ÑPvıŸrÒ®k\ßü9û7\Ù\ê\ZoŸw\â	·\ãw—mi•ıZ¼\ÛÇ´\ğ½Ï•\ó2©eı\è\Ú\Í^Tk);V9{hş\Æ\Ñ\ö²\×g¡ün\ñŸ†\í–\ßK\Ö\r”j6ş\ê\İÿ\0}m®\r$?\ïRy‡ul\áüD\Ü\ê5\Ïx—\Ån¯­\Ş\Ş²\ó¿\÷\Í`\íùºTM&\êz7Bš‡\ÂCe«\r‘Ü¡\÷\×ø\î\×\í^‰ù\ÏŞ®6–E>\õ\ŞxL\Şl|\ÜW\\Ni_£Z˜ß“Z²YùYºE\Ö\é˜Vç™µ«CÁ§üÜŠ¶t\ñŒ\ì§Cq]\÷\Â\É\ã\éz\\pÈ¯3z ©“4¹O¦şø6?ü2Š\ætÛ¨\êAfvo\áO\áZ\ó_Œ\Z\ã\êW?dG\İ\Ï;M{wÄb=Á ·\"F«ı\Ğ6­|\çq\êÚ“\Êÿ\06\ã_;ˆ“œ\Ï\Òr\Ê\nœ.U\ğ\ö—\÷r†»MKk‰•w¨´ı<B«š\ôO\èbF\óH¬\ÔN\êµ,møAK{eŞ”ıv\Ì-»tjê…ºG\0®[\ä…\Õ*¬y|ü\Ì\ñ\İJ\İÿ\0´x›5¥\å¾\å\'\ïUË›\ïy;Û•E&¤Ñ•NŸ\öˆs\÷—½bj¾’Kgx>m½+¨´,»?½R\ßF–ú]Ä˜\è	®\Ú\Ô\ó+\ÇCÀ<e¤¤—/m\n\Ì\Åü\ë…\Ğl\çÿ\0„\İ2’¼Rp¹ù_\ßø\áxKˆr\Ï0\óO?pzW\á¦H\õ„wC\ò|Û«Ö“\÷O-O´¾\È\ë¥DJ³º\Õ\ë¶?,k^;\ğ®øM¢@\éŸ\á\Ízµ…Ç˜¸$\Î\èlm\Ç\ó.i.:RC\'\ÉC®\êÌ²„±–j‰\ãjO½Š†Oüz¡—Œ\Ø]\ßŞªS1aW^=\Õ‘Ô–bK	\Ü\Ç5N\áBŠÙš\ßuT{Zl£¸\ä=*…Í¯É–\Åt\ò\Ûÿ\0B\ãOFoŸ-Y”6\î\Ö97|›š°¯4½˜ë¾¸³\ì‘\ÖuÆ–\òU#C\Í.tq\ó~î±®\ô0\ÍĞ­z…Æ‹»¨ªSx}?Ş¦A\å\í\áø7r\rK†‹şª\Z\ôQ¡¢\ô@\Ô\Ö\Ò}\ß\öh-4^vûøZÒ¶\Ò\Ò\ßh8®¡tsŞ­C¡ü\İPç¡³’O\÷kZ\ÏK\î\â· \ÓR1\ÊU¥µ\Ü\Øj\Ò`d¥¾Ş‚‰-\Ûn\Ú\ÙûÕ¤[=Ç¥`Ù¢F%½‰ß–ù«n\ÃOù†E[³\Óşn•­¨Zƒ`³µÚ¢ºk\ò\Ñk\Zù«f\Ó\åBlB\ÜU„\ÍU·n*\âI[£E¨zSu‹T¸°to›p¢¼µb\í\Ñ\Û\éL“\äo‰·şŞ•\Ş \ÛÏ¥qW>·İ‡\Î?»´ı\Úú\Ç\ÚOxùş*\ó‹ı/\åaTŒ§©\â\Ú\çÃ›}`*\\N\'Dş+ˆ\Öş	\Ú\\3}C\ã…\õ¯n\×49\ãVxûWwysjø\åY½]J§)\Îè©©|\'\×tùY#¶3ÿ\0´µ‡~\êú–¦‰y\Ø\à1f\ë^\î&¼·ûŸ7<û\ÖuÎ¹sq.ÿ\0!ûµ^\Ø\Ë\ê\ÆÍœv\Ú˜–\ñ\áUnÕ¯,\ñ\æıI\ÜF\nµv\÷:„\÷V~Xƒk\ç\ïV%\æ—-ÀepwV~\Ğj/\Ñ$¹\Ó\æ–\İ\ó\åK\ÕkÛ¼\'\ö…¢o2|µÀ^x]\ãGtBÌ¿\Å]Ÿ\Ãhnm\×\ç\Îß»µ«FÔ•7eüRQı¥á¸…\öd\n\õ/ˆV~fª¾g\Ê\Ûr\Ùé¶»i¯t\ñ«?|\â.a–G\á\r\"Z\Éı\Ê\ì\ÛK\Ü\İ9t\Ô\ÇAZ´c`Xo‡nj\Íüe=Kq“&*H?\Òcj\â“\Ô\õ\é®h\ä\ß+U½\"?:\\š§\Öl~\Ë+S4\İİ®k¢,ãª¬o®»sIı‹î•¹\Z†j[{t¸}™« \àd^µzÕ¬ }×¯I\ñ¬\ây¼+ˆ·³û=\Â>\ñ\÷«Òµ\ët“\ÃÖ²“\òª/\ÍTA\Ãq\Z1\Ås7\ë\öI“øUk¦¿Ö¬­\í›c\îb>\ír\ğê‘¯›!M\Ìk68#…\ñü\ÛeT*Š+Æº‡\Û/Œª\ö¢‘\Òz—ü/}\ì‰\â+Ø #i\"©ü–¹K\íR\÷V¸i¯.%º”\õy_sS\ã†:•(\ëÉ´#-\Õ\Ì\È ÛµHm_uZI£\íNi6Ö¼\æv+-‹\îSW\í\ô\ğÊ¹ªÿ\0l¥\Zè¸¥\Î+\Zkf7)\ô5\×j?¼\ğ“\ñ\÷Sup\Ú«]Ö™\'\Û<1&~\ö\Zº)>c	£\É\ôŒ[ß°zŞ‘‘…s¨¿\ñ1”\ö­¦\Ú5®£•“¤\És_U~ÆºmºÍ®jîŸ½H\Ö$oL\×\È\í\ìÊW\Ø_²Deø{«;²µ\Ş\ßÀYU|°;0P½Tu?.¼\É+ü¦¼\ãE\Ó\Ş\ê\éQw5\İ|BŒ\È\Ù?v³¼bª\òK»_<½éŸ¤R—-2G±p\"ş!^«\á-?\ìztd×Y\Ûı³]H\Ç\Í\Íz½¿ú=ª\'\÷E\\:³¹4\òVl¶ÿ\0h^”ù®­d^ø-\ó±…CfI—E‚6i\'\Æ\Õù¾j\â<M\â+&Ô¢³ƒ\n\Ü\âªø\Ï\âW\Ù\ì\İ\÷7û5\ó\ÅÏŒ¯/<se*“\åG0\Ï?\ÃY\\\ÙEŸAB\Ç\í\õ­=rA…?\÷™+™ş\ĞÛ±\óZş!‘\Ãn~ÿ\0Ê•\×Cs\Ï\ÄlxGŒ5³™b\çf\Z±|/$wšº _¾G\ÍZ^%³MJ\å\í$<¨l·\÷[Ò¥\ğ6‚¶\òb_Á«\ÖoC\ÄK\Ş>£øic&Ÿ¥Ä§¸ÿ\0Ç«\Ò\ô\Ùz\óo‡³$zL’w(\Ü7W¡\é²|Çš\ã‘Ú¦Ù·%H\Í\Û§\î\á©wn©ü«ş\ÕVe©\æ_¢½I—¼TO	e\â®*î¡£©,\Îû/\Ë\ÍE-¯\ËÒ´\Ê\Ôo\ËAF5Å¿µT’\Í¹¸\ñ\Õ[ˆx¨°f\ÕRk¥l•ùª)­Ä‹Ò™ªg:\ögZ«&–?¹]·\ÚjŒúT\ç_KE\íP®+¡{–˜,\ÓÒ‚¬`ı‡Ÿ\ïT\ñ\Ú\ñ[\"\Í3Ò¥M<+}Ê«‘Ÿ¹ª\ÒÙ…^•¨!Mxù¨l«¦\×\å¨ÅŸ\ÍZO\ËLx\ë2\ÑV8şj´>\í5#æŸ·\æÿ\0f•†IŞ­{<\Öm´?û5·g4„\Ùvûµq\æ¨!Z°Z˜6O\Z\í­t§Ò¨CÒ´—\î~\å^3³;?\Şù«\Ô4½\ß85z‹cıû\á®Bkq\"`\Õ&&ÿ\0M¼Šäµ\Åy¸”\ğ\Z\õ»µ-a\Şiûz}Ú«…¾\ğ|°\î(7/\÷Š²N–\ğ\ğ\Ñÿ\0yk\Ú\Í;T\ä\Òm\æ\ë¤$yT6\ìT³i~bpŸ5zCxV&9	¶š\Ş\õŒ2\Ğ&\Ï;\Ó<6f—2\r\Ë]6á¸¬_\äOÒºh4Ô…qŠb\Ã\åÍŠZ\ö<—\â}¸‡TC·\æ\Ù\\+t¯Gø½o\å\Ío\'¨\Û^_$\Õ\ì\Ñ~\á\óX…i2P\ÔWF\æ½/\á?\Ãt\ñ…\â=Á\İ»ZÔš„yŒ¨\ÓugÊ%½üÏ¸h´·–9VA7û¢¾\éO\Ùÿ\0Ã–v(^\Ò6ey†\ê¨~\èZyù-#ü«ÅeRG\Ò:>\Æ>!\Ô\ô½OR™|»9YÜ¨ \ğ±\çìŒ•\ö}×…\ô\ÈKl¶\nÃ¼\Óm!\rşŸ•z<Š¾\ó>]›M\Ö\ì\àù\âp•\ö\Ë\ÛwÏ˜U«\ß<f\Ñ}…\Â ^+Äµy\ÍÛš\êL\âhÎ—T\Ô$ÿ\0—†_\÷k\èi¥\ğ\ò|³\Çşƒ^\0\Ø\Í{\ï¾\İ\à‰l\r¿\î\â­3\Îu(G\ëT®±\rŒ¿\Ş\Åk_²yÌ™\r\Ís^*¼\é’\ì?3|µ,\æšÜe\Ã}v\ÑTµ)¹¢‘¹\êif\í\ê´ÿ\0\ì¹ÿ\0ºkz«x\Û8;\êªp|ÿ\09\ß\Ê`G¥Ï»\îU\ß\ìY:U\ô\Õ?‹\éV\r\ö\ÕÈ¥\í\ìÌ„\ğû\îÿ\0\ëU´\ĞJÿ\0ÿ\0½WP’¶I\éS\ÎW³+¯‡\÷\÷\Øh\öb=\ãş\è®_\íRÿ\0»]W‡Yä°Ÿyùq]¸Yû\ö0­OC\Ë>\Ï:¤»ş^k`IoKÒ¹O\É$:ü\è‡jï«ˆ\Şb.k\Ö<¶™/­£|ŒW\Òÿ\0²Ö±æ‰©Y\Ç\÷Q\ÖZù@\Ã\ò\ñ^¹û9x“û\Ç[\È\åb»-¹ùAş\ZÂª¼N¼#åª™\ôÇŒ\ìş\Ñj\Ävù«\Ã\í¥ı+¹Õ¬\Ä\Ö.=«ƒ\Ócû4Ò¡¯Ü²>\ê\÷\ÓÁz_™,\÷\ÒûRºMF\ğBƒÒª\éÿ\0\èºL@\r¼W9­\êG,•-˜n\Ç_\ë†N\×%¬jÅƒ\Ñqt\ì\í\ÍsÚµ\Æ\İ\Ü\Ö-QG\âË\å0\Ï\ÌÕ\á	ı²\ñ®$û£\æ­\÷\Ó\ßT¾U\å·\Z\îa\ĞSG\Ò\Ö0>vû\ÕH¶\ìŠwK\å\éªG\Ş\Ål\Ş\Ú\É\'‡\ôˆ®2Ÿ»WzMImj\æ\Ş\ĞzüşÂº\ï\é°[\ØE‚#X\ÑP\ß5\×Ejy—¡\óm\ô.\Ú\Õ\Ğ9ù>\ï\ïs[Œ}¦ ÿ\0w;\ÍSš\éY®2´\Ñ\'\÷½k¢ğ®Š—Ö‹¾\ÉÔ†\Ş\é3È\çµx21¹e\åWwøV½#Nû\ë^\à\Ûwµo³¹ß´}\ê\ô}.?,®kHß¶ÿ\0U\ÏŞ©Ñ¾Zª’©Ñ½k2şf\ÍE\ÅJ\õsP\\CoÖ›M\ó9\ëI¾‚\Ò\İ)§½\r ¤f\Üh5HÖªÌµqºT­IV3f‡\æ¦múV„ªjø¨Š&>zUg·\ÜØ­7æ¨š?š€FsG\Æ\Ã\÷i¾M^1\Óx ¢­\ÂÔ¾M9~\õK·mjWû=FÑ…«G¥WxşnjWu¨$\ëS\Ü\\$b¨4\ŞcT–MŞ«!j´?)\Í9®\î•V\õºüÕ­aÁ\'Ìµ¿n\ß*\Õ#6[\îšz³+TK\'$y\Ú\Ô\Ì\Ë	6\ÚÒ‚\ày|\ÖP\ÅZ‡\æ\\f€9\ïZ•\Üøû\ÕÁ™6·5\ëzÆŸ\ö\ëù‡J\ò=v\İ\ìnœI•¼\ñùd\Ík\÷_‚\ów§\\G¸Qr¬s7; :{«WB\ğ\í\ô¨~\Ç\æ;a\÷Qrlb,oPho\Ş-l›^{P–;›¦\Ú5%£šû;®\êg\ØÌÒºf\ÑÌ•%¾—\å·Oš‹\Ñ\á_\Zt\óı›ÿ\0š\ñwW\Ñÿ\0\ô¹ \ğ¥\Õ\Â/\Í\ÏøW\Çw~,—\Ìd¯WİŸ\ÅC\ß;˜*\õ¯¥¿e¢¼¾h\åpÊ•\ñ\\\Ş$—?|\×ĞŸ²‡Š¤T<Í»_z\Õb•\é2°V…T}\õ\âv‚;LEŸ\Ã^Y¨\Ü5¿»][j\ò\Çy;¸®6úEf\Íxu©\ï\âÑ‘yq¸5`\ß~\ñ^·.®\"\Ú\Õ\Ï^\\\Ü@¯v\'\Î\Ësƒ\ñ-¸µpk\ço\\=¢\ñ²\çŠúGT“\Ì\óR¾ø…§\çRbÍš\éG;9BMœµ\ì?µ†“C–\îİ•¯¸·*½+\Ô~ª}²[w?)\r\òÖˆÅ¢¦¯˜u)S?(-\\‡‰\î?rÀ\Í]¯‹ahu™\Ó\î\ó^s\ã	<°¢†(£¿m\Ç\ñ¢«\Í&\ê)¼[Z\î\íV…z»m\Z*-L\òG\Z\òB­|“”g•b³«†\ß\ä\Å7\í\Ö\ñÿ\0¡\õ‹}½E\ó\è\í\ê\Â[\î\Ö3xšz0¨Ÿ\Å\È:U\É1s#¥û*2\ô®‡\ÃÑ¢\Â\é\Åy¤¾0~\ßÎºø\õ\æ‰şZ\ïÂ§Îj\Ír\ãû?‰\çş\îi\ñH<µÇ¥I\ñ5|Ÿ·ûUF\ÖO2\Ûp¯p\ñYe®¶œV—‡u\Ç\Ò\õ»+µr¯Áúû\Ö)¥_—kš–T,\Ñ\İT\\\Ğmn\ÇÌ“\ÂW/¨Û‹{\æ\Çs\\\ß\ì\á\â\Ã\âo\0´\İ-ƒùE?ˆ/\ğ\×aª.\ëØ¯\"¬,Ï®\ÃU¼\Ê\Ú=\ÚT_\îW\âIs5z&–¾v‰›\ä¯=\ñ„/Ïš\ä‘\Õ©\Ë\Ü\İzW;©3\ÌØ­$\ÜØ«ZV”\÷—+‘¹sYX\ìS°\ß\èo¿\ÏtÚ£¥uXµ\Örk¢\Ò<>\ñÂ¨‰¶—Q…4}²HŸ*šµ\n•	4\r\r<+e\çÊ›\ï.:ÿ\0°?»Y\Ş-š-[M–ÿ\0xUûcûR-\èû–¹›†v\ÔU\ñWU3Ï©©\áš\ôrÛ•¸y«\Û\ÙÚ»\0\Ù\Şø›X‹Pû<–k(Ş‘·o\÷«©¾ø_ı ¯qj’w\r\ßø\íz…|3o£\ÛE\'\Ê27V®\Ö\Ï1-M]OkwW|6\á\ÏÖº«y\ËÁZ¡n¨­W\âù«&nˆ$j\ÊIY\È\ê\Û>\íXK½\÷VL\Õ\ŞM\Õ­\ò°ûµ\È‘\÷ª¼\×W½P\ËHsH±ÿ\0w½P2nZ‡\Ì\÷©¹ºFœ·1B\\\Z¨#ûÿ\05J²mû´\\\ÖÆŠIC·\ËUVn(\ó©€\Ùw³SZ¤\İ\ò\ÔlÂ ;\ñL?0§³\ncah&uF\Ñ\óR™*d\æ‚\Å\Í\Ü\Ó<\Å\ÇZcH)2\Ç\É UªW7^^\êm\ÅĞ[&±//‡©‰.o<\ç¢2>Qƒ3K±>f®£K\ÑÙ•@3U$\r•b·v5»«WYo£¤iŠ%\Ó\Ó4È¹\Í[\Â\ê\ÊMnZ7ÉƒHl\ÄoMy>ûh\rK\éVqX¿nEl\æœ\Ú\âw¢\ácWw\ÍR­Ç—X®E¿U&\ñkş\ÕVviy\æC\\‹­\ãšYQ~\óT­â £øÿ\0f¹g\\\İ+HO\Íş\õ&Ã•œ\ÌrIgx\Ñ\È\n\í5¶\æmş\íX†\Ö\rj%“2Ğ¶og+\÷{Vc\öq\×bp\ßÁO\n*x°µQ m$I\Ğÿ\0€\Ò\r“ı\ÚÒŠ\àgadJ­LÌ¡¦ùk\ÍV–¯Z\×7È­²²\ç¸¨\ÔV8‹ZX\Õ<%©DS~\èJ\×\ç=\õ©ŠúT\ÆİF\Úı,\ñ[y\Ö3\Æ~\ë\nüù\ñ¶ŸŸ\â\ÍF$û¢f¯C\Ï\'ºœ|ª\Êk\×ÿ\0f\İ@\Ùø¥\ã\Ï\Êk\Ê.\×\ç®\×\àµ\ç\ØüaÓµMvU\\\Ğ8i;LıÑ¦ûF˜¿J\æ5Ÿ\İ\Ê\Õ\Â:‡™¤E\Ïj\Ê\×\äı\ó\n\ğiB\Ó=Ú³¼+\Ù\ÚÍ›ıKUû¯»Y—\ê{0GP\ã\ï3\ö‰~µ\ä_c\÷løùz\í\éÿ\0Lq^_\ñFÎ¯Õº2g˜\Ü\\#Wi\ğ‚û\Ë\ñ,CøI\Úkƒv\Öÿ\0\ÃÙ¿‰-\ğv\æ´Fr;oˆ*‘øŠ\ã2­y.7MŠ\õO³Mqs.w6ú\ñ\É\ç_²r†	RQD\ß-OTÅ“²ÿ\0G&¹w&\îv\ÖDM¶§V\İ^w±‚:½£&mB\á›ïš.%h\ñ¸\Õ4\Æ\ê¿1ˆ)H¤\ñÉ¿½=w{\Õ\É>\ğ¡V°r‰ªND_Ò»‡•Ö”ÿ\0>\ís‘-to/W‰©Ò’\çA8û…_‹\öb=R)¿Š°t¯ø\ö®«\ãLg}¼˜®7Eµ¿\á^¹\ã]†úc°\ÙQKş²˜Ù G¼ş\Ê~0‹G\ñ„ºtµ/\Ón\ßVwÿ\0e¯§\õ\ëpªÎŸz¿?¼!\â	|3¯Yjgt3ùOûU\÷¾‰ª\'Œ4;]B	,É¸\í\õ®*\Ñ=\Ü]9M\ï\nk]‚Û¹ûµ‰41¬BÎ¿ÏºÉ¦\Ì6|µ¹§k[‚‡5\å´{)S¯hwš=\Ç\ï#;s\÷«g\Ã\Ş\\«˜\Ï\å^µm§\ÚjÎ¾lh\ëWf\ğİ…¼9Kx\Ñ~•6)\Ô3´­B\ŞH$-fø\Â\Ş;ı.T‰·1é¶±¼OÚ«}›\î\×c\ñ:\ãI\ÔV\Şı[\çi“vµH\Ê\æ\ö„·\Z[¼u\r[:]š\Üx‚\×xÜ¬OşƒT¯\õm?R†)¢–6v;†\ÓZ^“\Ì\Öm~o\ï|ß…5\ñ-\Ü\Æ<œq´t¤X\Ã5nx\Ö7QÃ©\ëU]‚\ğŸ-uI¡Œ®\í‡\æ«\Ğ\Èûk>¹R‰¥&4j$\Çwj_0+\Õ!p–\è®ÿ\0v§I.Gİ¬™º-,Û·b¨\Ü\Ş|û\ãA¸\òÑe} \È\ì~\í`Î”i<\ß-E\æmª¿h\ÛCM¸R\Ô\Ñ\Å\×j9„\ë-q æ¦‹\n¼\Z.Q¦²§n\ÛY‹7\ÍRı¢À»\çTOp*«\ÍQnş\õ+pM»¥5›šª—8Á©œTÜ­IL•NY¼\Â\ÕÍ¹º\Óm¢\å¢O2£{ƒQ3n¨\İjFCs&\åjÇ½ı\Øg­gµc\êÿ\0,mT¼)\ì\ÇÖ½6\ÏÊ³µVr7cš\ò¯\êÛ§_»[7ş,6W\Şmb%\î+:\ãÄG».+\ËuŸ%ª¶d^m\â_š6’\Ì.5;x›û­%M\Ør£\èKÿ\0Dª\Ø#\ó®~\ç\ÅGoœW\Ì\Ò~\Óşge}b.¿\íU\ÛO\Ú¤\Ë\åjv\í»ûÏ¶—¼\ZC§ˆNŠ†Mc\æl=yŸ\ã«kÍ¦9£uÿ\0eÖ·\Ä	 \Ê8©\åe+\Ù\Ö>\\\ïªw:\ç¾\Ú\â\'\ñ\'—üu}\âÍ­\÷\Âÿ\0À©—c\Ğ%×¶Ÿ¿¶²\ïµo0g}q#\ÄF\ÎúŠ\ó\ÄQC\çz¯\àÿ\0\"¶Ç®\Ş\æH.­úŠù·G\ñ¤Kq”mú\×u¥ø\ñ.Fş”c\Ñ\âa»­9Ú°tMY/>ş\õ®·\Ô\\Ì¶\ÍM\æ|µM$M!ùj®+	r\ß6j…\Ì\Â1šš\æM\Ë\Åa\ê·F5©3fˆ\ï‹$»\ë\áÏˆ±ù2Ô›ø¼\ã_aø†\ğùO_ø\òoø«/ı\æj\ô\ğ»^+c”¾Qÿ\0­O‡Ÿc\ñe¯\÷X\í¬\ÍK¶)|/p¶ş!³sÿ\0=zøO.–G\èW\Ã\íPI¦D3Ú¬krn•qŸ\ïtèµury•\ä%i‹©xeùª¼\Ö\ê\È\Û\ê\öß¥R¼\ÎÆ¯F,\óf\Î\'[ŒGy^y\ñ:\ÏÌ°Y\ï-z6²§\ÎZ\â¼ynd\Ñ_\é[£#\Â\Í\÷ş\õkxbO²\ë\ïş\İbKû¹œ{Õ›+&\ê\'\ÏG¦I\é~$A\Z^?\r\Îá¶¼U›Ì¼•ı\ë\ŞüH\ÑÃ¤;}\ï2}\Õ\ó\íÿ\0\Í3Ÿv ¤g\Í&æ¢•\ã\ÛE²oj™\ë \ñ‡N“rÀ\'\î«--şZ\ó½¥Ñ½ˆ’3ºµ,\ãÜµ^;v­+8J+3X¡niR:¼\ğ»v¥K7n\Õ\Æ\ÙÖ‘]#\İ[ıÎ­~\îj¤Z{üµ±¢Xˆ\ï }ÿ\06j©ßœrøEøÒ¿\ñ.‚@+Î´™\Z½{â…ºM\áøœ\ò×š\è\é$¸¯ ‰\ó³eyc;ÛŠw\Ù\ŞNÕ³v\ò\ô¨ƒû”Ì®PK7\ÏO–¾ªı•<P\÷S\è\÷ü\ÊwÂ­ş\í|\È\òz)®\×\á‹\'\ğ¯‹\ì.\ğ|‚ê®µ!Ì\Ì=^IŸp\ê\Z?Û‘°>j\ÃşÃ»¾\á¯D\ğ|–ú\åŒW\ÂU”+|µ±§\Å\n7\Ê+É©\é©Ï™›púj|ı«GP\×\Ökóµ\âh\Â\Äû>V¯(¼\ñUüw/l™o\áZÀ\ŞÇ¡\Ü\\At¬™\r\\^µ\á{MA\ØlFÿ\0j¢C|ß¼“?7\÷«f\â1o\×\\–^?\Úin¥³\á\Ív>ÿ\0”~\ï\ÍXZn.¡?}•\Ö\é\ég¬\ÚÀ0»³üª\×\ÄD¶:ù›\îÿ\0A\æ|ÿ\0\'Ş§\Ë\òœ}\ê#m§·\Í]GŸ©*±¨§} H~@6\Õw¸IƒF3»ûµ\É\åº\ç\å§\"‘¨’G*\á\Æ\å§yÛ›ıš \ò|\Ë\Í\'™»¡5„\à‰\în¥h\Ó\æ\Ú9jª\ß*ü”3\r\ÍP\Ép#\ë\\\ì\êB™6¶hY7UO´ªX\ä\Ü+3RúIµi­pU·Uw‘\ñ\ÅE\æ\ë\÷¨ú\\züµ/šµ˜’|ü\ÔşgÖ‹•b\ã\Ü\Õ˜Yª¸j]\ßZR\ËL3CIUDŸ5A@Ç³nji\éP\Éq\éQ5\Ç\ËAd\í V\ëQù\Şgª\÷\r\Ç\İş\õ\\HÂŒB\ÛV±\õ¥ù\é[½Q¿O15©œÿ\0j.v\Íek0\ò\÷%nx·Eûd-³\å\áe¯\ñ6«Ú»!Gt\Ï¿\ÅIš&f|D\ñ•Ş¡±[\ÈUË¹Mx¼\ß\ïu\òº;³\õfû\Õ\ê\ğø~[‰s?\ã]–…£Á\n` oJ5\ò\ä\ß\ïZFq½\à5«¥|+¹…¿x·û\Õ\õŒ:]«&	X\ÚÖgF6N\ì\Î\É†\î|?\ó\Û\ÜÈ\÷¾S]Ï†|q¨F‰\Ü\ŞoûU‰m~}•\ÉKÍŸ\Ü\ç\İ¬	«s\â\Ï0¬¬‰¼F’>K\îük\Ê\î\õ-JI6#•Z!³\Ô.Ÿ+m4X¯hz£\ñ\n\ÏM‰Œ·ı\Õù™«\Ì|O\ñ;U\×&\Ùg\æ[\Û´6~cZ2ø<}\÷%·z«`\Ånpİ¢\Â\ç\æ+øS^\ÖùÜ³§}\Õ\î¾\Õ.6DKš\ò\İ\Î8dß°W­xÃ·z\Ô\È\æ#˜<»ûµ›E\Çc\Û<%Ÿ\ì\èœ\ç\çù…u–\Òz\×?a²\Ş\İ#O\àEiGq¹y \re˜/\ñQ$\ßwš \Ó\îÓo—-\Í\Æ\ÑÖ°597DÕ¡u7\Ë\\æ«¨m*Q8ÿ\0^‹{i]\Ï\İC_\ZkÚƒ\ßx†\êRwoµ}=\ñK\\û‡\ïdkl\Û_&£ff?3^¶&.]	o>\åV\ÓwªÛ¿\İÄ‚­L»…C\n\í•O£Wq\æŸh|3¼i¸µ\Ú\Ë0\İ^E\ğ¿T?\ÙPsü^‰\ç˜y®YGSU=\r´n*¬lj\Ìy‰EÍ¿¬L™\Ãk±\÷\÷®K\Äñ‰´‰Gµvú\õ¯\É%rš•¿™a*J\ÕÏœ\î¬v\Ü\Ë\õª\ë¬‹\Çz\ëu<Gxÿ\0Z¡ºF\İ*À\é¼kt–ş²qüp\í¯	ºÇ˜\Ü\÷¯Sñ¥»Ã°G\é^Eq\'\ïXP4ˆ¦“u\Ö\ëEMø’\Å/´U¸ûÍ³q®!m\ã\ÛÀ¯D†\Ï\í^Ps»fŞµ\Çÿ\0gü\Ì>\íy\İ6L\ÎFH\Ï5©¥\ì™\Ô\ng\ö|_\ï5\\Ó­ü¹°ˆkd\Ë°¤cTÕ¤\Ç	[6\çgÎ†«İ#¬dt&W‹\Ìa\Óm]Ó£”\ŞD}\éCı\ÏÒŸ\ä‹2\0‡vh‡\Ä9K\İ:ˆ–\ßh\ğ­y†\áû;\ã;«\Ôü[¾o\ËÁV\Ù^E H\ë+¯¢‡\Â|\õO‰\rüq·\Îøª¹‰y\Ş(¿o8.¨-¸\î\õ¡’.5\ÄT\ëmY,\åWAº©ùqú\Ò/•\ß\Äû“\öCø€<A`\Ú|¯\óÁ\ò…cÚ¾†\Ö\ñ°\â¿:?g¯‰	\à¿i\Ù!`–`…˜ú\×\è9‘¯#S\ÛÂµyu\à}.¥\Ñ\Åk\Öÿ\0hÜ‚¹‹o¯Ÿ\æº|Ù¯O“G\Ür~fªsiûEqX\ô\îrRØ¤c	jÍ¶\Ğ\ç\Õ.V ‡n~\õwP\é>pşu¯g¥\ÅcBj,Kg3m¡Å¤\Û\à›\×!-\ç—\ãk0=ş_ø\rwz\í\×\ÙÑ‹W”%\÷Ú¼}§D\æ%ÿ\0,\Z#¸Ÿ\Âzw\Ú7\â\á\Ëı\êŠİ¾]™\İ\ÍN\Ë\ó¶k¬\ó\õ+§\Ì\ï\Õ~\ï\ÍCş\ñš•\äLªoù»-Uk£1|w\å \Ñ¬a_$–nÔ’\ÜmmŠûZ£k\Ï0.3¶«\Í\'¢mÿ\0j±‘ª%mM›şjo\Ş\\\Üyœ–¥ß´W;7LyZ‰7\Æ\Ô3P$ùk3T\Ç4\Õ\Z¾\æ¨f\ÆÙ¨\Öoûæ¥–^ûF\ÑB\\š©´›©¢\àt¤V¦š\ŞT«q¸v³–O—4=\Ö\åş\íU\Æ]\ó‘»\Ó%¸\n*ƒÉµsP=Á\ÛLZ—š\à/$\Ò\Û\ïºo\î§\÷ª½•‰º;Ü•_\îÖ¸ŒF¸û´$b0 \n™VšŸvZ¤f\æFV©\Ü-\\v\á˜W–b@Õ…}£\ÇpWg$!…f\ÜÛˆ\ÇJ,U\Ï>»\ğ¾\æ)\İYo¡¥¼¼&\ÜW/V\Íc^Û‰:}\ìÿ\0\rh‘¡\Ê\Ífv\ìG\Új)t¿16-[\ÓY\í<}\ê¨\êıUc\'P\á5o‹‡o—¥s3øN?5“gJ\õ\ô·F€;«ŸÔ´\ô[œ\'\ğjld\æy|\Ş\r‰[˜\÷T­\át·v ®\ï\ì?»bÿ\0zª\Ïf|œ¶WwM´X\Î}%\ö7\É\\\Õÿ\0‡\î\ä—\÷Q–¯U\Zyo‘\ã\İW¬ü>’H¿\'Ö¥£¢39†¾’I–\â\õm;‚°ùk\Ü\ìlÅ¬Jˆÿ\0»I \è\éom\ò%j4;k)	‹m«QIT\ÇJ›\Ì*+\"\Ë\ép£š\ã\Ğ\Ök\İm¨¦¾\ëA-\\\Şm\rš\ä5\ëÍ©\Ç\ËZº‡\È\Ç5\Çkš§sUd\Ù\ä_u/HKpÿ\04ÿ\0Š\ğ¨s\æW¨|Mg\Ö5}Ÿz4v¸ø\ô?›¡Z\÷¨G\Ü>s?|É‘_mVhd\ì>j\ë!\Ñ\êÀ\Ñ\Ónp+ \ä¹\é¿\n/Ÿû\"?À6×«\é\Ó×|=ÿ\0G¶\Ù\ï^«£±Üµ”‘7;]*M\ÉWä¬½35­Ú¦\Å\\\æµ\Ë]\Èÿ\0J\án\ã>K¥z>®¾bµpWqùrºš\Ù#\È|Mb~\ÜÂ²–\Ä\×W\âx\ÄwŒM`´”\ìR9//—£·Ö¼±\ó¾½WÇ¹ş\Í\Æ>\\×–²ü\ÍAdMÖŠG¢€?E\ôß‚b9m\Ü;.6ş\ğ\Õ\r{à­¦—bÎ‘Æ^\ô$«™\ñ³n°¥sÔ¤¬yë»Ÿ<7€bS\É•M„m\íÊ’7WEqpsŠ¡> °†\ŞûŞ¯7”\õ\ã3&\÷C·ce5|?mŸú´¦^x‚\Ş5ÉU¿ZGl\Ùqÿ\0}Tû6\ËU¥\Ó\àvUs\å©\ác\Üxº&f\Ç\ÍYsx³üŸ-tB‹«­(¸\ğœÿ\0\Å\òn¯\0³¾µ:p¼š\÷CûC\ÃÏ\î6kÁ\Ö?\'W•?º\ìµ\ê\Årœ\rİš\ò\ÜI¦ 3I\İ\Ï\çR•ùjª&\Ãü\Í\İ\é)ƒ\îÓ—¥$µ¸{[´•\\£¡V\r_¤\0>&ZxûÁ6r‡ÿ\0J3+›pş\õ~o•Ü¼W¤üø©¨|/×šTÌºt\ØY\âSÿ\0W=X\İ–·³zŸ¥‰²E\Îj	£Iµp\Şø‰g¯ip\\\ÛN%@\İkEüD½|\Ê\ò\ÜyO¢„¹•ÎdŠ\ß\ÑZ²\ï\õ\Åù±\\\İ\ç‰#f\Îÿ\0š¹½c\ÅT\ãó¨¹¢Eø€yN7ıkÊ¼7«}£\âv›±ş\\IŸÊ¯]ı¿\Å¿g´²~wşZ»¥x&/\ë–WÌ·l»Q©5\ZJÇ­ù\Ñ\ĞS\ŞIdlı\ÊKl,[ş\ó0â£šGUÿ\0Ù«¤\ó\ì1\÷®\ç\ãn*/Ÿ\ĞQş¯l†M\íı\ß\á§y›†i2\Ñ4\×øTr\Èû8©&\Î\ÆÁ\ÛU“\å\Î\ï\ïV\Ş$>v\ÒØ¦¬‡\Ô\ÔO&\×bÿ\0wµD\÷º\rµ‹\ZeÆ¸8a\÷i¦mË\ÕQ®\õ¨\Ú\ë\î€+3DË†Aş\õF—~1µj\'˜}j\rS4|\Êll˜\çuSi¾ZN\ZÜ¸\×\\qM\ó6Œ\ÕEo’ ’\ãs\ĞUË¯p~ûŸ–’\ÚGº”|Ÿ\'\÷«1${Ë‘|«Şµ\Z\â;T\Ï\ÍZ¤C™»\rÀp(–\à\È\Üı\Ú\çÎ¤œ\í¦>¼˜Ám«Z£3j\âøÆ¼\Zˆk£Ÿ–°n5A#`=W7È»¾j\Ò\Ä\Ü\è#\Ö<\Ço›o5v+\í\Ë\Íprj^\\Ë°\Õ\Èu‹)|\Ô\Û\Å4…\ÎtÏ­\"\ÊÉš‚\æøM®X\ê\r½³\Ôß·\\¨]‰¹\ò*¬.y\Z3L\ë¹ÜµI\õH—¨ùª¥\Í\ä²#\\\Õ	[¹¦‘¼×†\á›b|¿Ş¬™­\åWnO\'\ïTÿ\0j?q8ÿ\0j¯\Ãœ2\ôÅ©–HEQ*76ú¹ª\ÜUù=k\r5´J\àR±-1\óG\ä®>ojŠ\â?>\\sO³\Í\Ä\ÊI\èkJ\ëK–dl\r«¼´š„\÷H§`q­-6=¥O\÷«h\Ä3`úÿ\0oiJ\òF¹=\êZ-3±Ó¯8–:¶\Òn®y?v½i\é«\ÙW5Tg\Êl;T\İmUo’U\ëT¯/V¹œN…;“My\Íf\İ\ß/­e\İj…]€\éY\×:†\å\ëJ\Åj^¼¼ùy5\ÉkwÛ‘±\óU«\í@ª6Ms\ó\Í\ç+WE]œu§\ÉÏµ8|\ë\É]\Ï\ÌMR\òQZ´µ\İİ½f™>j\÷¡XŸ19s1|¿¥H‘ŠˆH)şu]ˆ¹\Öx:DV\õ\ê:D‚¼g\Â\÷[uƒø«×´¦ù\Ô4#º\Ò\ä­`Û–¹ıMÕ¶½k\"µ)\ßG¹X\×­Bc¼–½\â=Â¸Ÿ\Ã\å\ÜgûÕ¢\ä3R·\nk’y\n\×o\ã\Èÿ\0u¼W~\íh9\ß]¬U=\ö×œ\Í\ò»W}\â\Ö\Û\nz\à\î>ù¨5EW\éE\÷h ×®\õ\â¸|\Í6_¥n¿Y!_3M—\éUSc\æi¿x\ğK\é<¹¥\õ\ç6Ô®-\Ç\î\ÏŞ®\÷Wùng\í\Z\ó¿Ÿ2\Åy^\ñ\í){§q¨\\Ìœ\Êk?t’}\÷-VŸ\î\Z¦sš\ïŒ7%\Ãx\Ó]~´CÒ¤z\ÒÄ\àœI¡Î¨k\Ç\õ(~\Ï\â„\Ç\İz\õ¯‡\çYÊ\è\Õ\æ&·1ø’\àütØ‘ü²¨[\æ«ÿ\0e-JˆY»5\ç‰Tv©bŒ·j·ŸÌ¢µ#³~~\õûC!#\é\ë\òÈ¥h¹ûÍŠ†&\Úâ s\×şø\Êÿ\0G<©[b\õ\Ë^‹q\ñ\Ê;\Å\Øel}\è\ë\çı/T6\ê»\å¨uA\ï¡\ÛYNšgueJ~\ê=\Úo–·–\Î\ñy¾\ÌÂ‡¾4Ÿ\Æ_´\İ\á\Ù\î»»ÀW\ÏKy$i\å¡eO\î×­~\ÌM&©\ñÀ\Ë\÷a·‘‚ÿ\0\ß5\Ï*I½<\\\ç¡\ö4\Z=¦—\Ûx%ÿ\0f°\ïlş\Ñy.Óºº\Û\ÌüÕˆ\öû¦\İ\÷k7W%K‚¥»P\Ì\Ï4² ©=j)¤1®G\ß\íRB…†.«¶¤\ÚÌ½v­Ui<‰wı\ï•E+Íµ:\÷j$j‰e\Ùıÿ\0–«\Í\÷~ZpoŸ&¢vn§\åÿ\0f±lÔ¡<››\0“š}\Ì=W²`=\ä\ğ\æş\õWi¾~µ1¯Z\\\çŠÌ¸š~aaNß´VrLø\Å=&~‡\æ \Ò\å\Í\ŞfÚ²jV™\å£Uy5#\Ğeh\Ë\ò\É\ïT¼Ï™ª›\ŞI\'\ñT±·\İÿ\0j„‚\åû6Kui?Œÿ\0R{\Ï:\åÁû«üT“³¬M°ıŞµ†\×[Q\ä&µH\ÊF\é‘$fù\ÅS»d\\¾6â©¥\Ğù]\È\æ¨j7…¤Àq°V¨\Ä\ÖûQk…À\ê\Ô\å¼I7ıš\æ’\ñ7·\Ï\ÓŞœ·[º>\îj\ÄÎŒ\ìùI\Æ\êš\Ş/5‘b\ß+.+z\ÆK½\Ã-;•i’\Ìl\Ş)E´’)\Õ\íV\ñ¯\Îé¶\í\Í>\Ü¬Ji” \ÌÓ¤\ÊÏ»œ\ÚOî—¸ş\õ>\ï\Æ\ÖQ\î	\ó»Y^6‹·\áL\ÕS.\Ûi?;oûµ¨\ÇQ\\ÏŒ¥“w—\ò­WOK»ys·û¹¨\Z¦uºÖ‹\ç;O”\×>\Ş‘[|qš»a\ã\Ä\és\ó/û5\Õi\ÚÕ…\äY«\Å*g¦øn\â9şpUs\÷kª}%\Ö\Ç\çùZ®\Ü\ë\ÚUŠ—y\ã\ß\\GŠ¾(Z,M¡\Ü\Ù\Û\ò\ĞO³)j:Lmy\÷7T\ÑfÍ—ƒ\ò\Ö^™\â\è\æu \İ[?\Ûs.8 ‡L©y«?¡¬K\Íc\æ\ä\Z×¾X\äl\Æ\ãmrš„…]²;Ò¸¶5\â\ñ\Ù\ÆÌjµ\Ã#\Ö20š¨_\êgûŸ3T4	›7W\Ûw>j‹\Şw\Íd5\ó\È2ME-\Ñ\ÛY8\nw\'\Ô5\rÛ– †O“5›%Ç™\"\âjºŸuEz˜Z}OW¢9|·;«\ÌúV\ç‹c\Û6k\İ^‘\ã¦L$§‰ª½>‚®kxzO+SOz\ö½+ş=’¼+J\Çû×¸øzO2\Í	¬\ÙG_£7İ®Š\å\ô¹ºŠ\ê-WÌ¬\Ëÿ\0v¹?\Ç\ó!5\ÖN»k\ñ$a­ÿ\0‰MR\Ê|mj$µ\â¼\Âoİš\õO\É\æ[²¯Ş¯/¼\Ëb+@‰\ÅøÁ·\"â¸‰—š\í|N\ÜWq\÷š \Õå¢‰ºQ@¯§\ï\ÕmwXK\ô«BJƒRÿ\09>•¬Ï–‹>z\ñ#¾Ÿû¹¯;\ñc+ıª\í¼su\ö=B\ã\ê\Õ\äúÆ¡,ı\ë\ÎZ3Ø§\ïDÈš=»ª™Q»­g^jÒ´\å«Zmœ·Öºnj N¬‘\õ4ÖºŠ‰´²®FZ¯6—»¥\ner‡\ğ\æ\ò6v@\ãœüµ\Èx\Æ?/\ÅSŒw\İZ\ß¡û>¥\õª?\ãh|A\æ—\"·¾‡<\×(C³\É_\÷j&aU,d>R\óSH\ÜVW9.rÔ—ÚƒH¸v³¾zµ\nŒS/(°É¨µ}˜Tr·\Ë@\Ñ\r¬Ì¯°\Õ\Éş\åQıh«\Ó/\î\è+©M~ø¯zı•\ô”_‰	r‡s%«ÿ\0Àk\Ã dP\äı\í¼W\Ñ?±Í»\É\âmJ\æO\Ü \ÛØ–¨š=|>\ç\Õ\÷\ñT&·¯,uN\év\Ä\ÕÁ#\Ø2e¾\âÿ\0*\ÔRI‹\ò›ıª‚\öG\Ã\÷³Yr\Ü±\Ïj@Z›{¥i·/Z¯\ö\ï2;|\ÍU’GmÁ\rf\Í¦$\ç\ğ¦<…›ıš©\rÁ0 n\ÅÇ—\Ñ3Y3TÁ¤,\ìsº˜\ì3zSwUşZŠ\âf\İ\Åa\"Ğ“LŒ\Ô\\3g\ïTÉ¹¹¦\Åû²\ßİ©(s\É\å·C\óP&4Ö5U¸û¼´e\ïz«$cqT]¶Ë¿şVR1Ö‹\0ø\ænÊµË•\é\ò\Õ\ã\r2·?-6ş\á\ãÜ€|½ª¢Q-ş¥µ™q\\½\ö°\êÌ€j’\öm »\çwÖ¹\ÛËƒ\ó0\ïZ£)V“ø\ßo¥gK­<a‰r\Ùş&¬û­\íÿ\0-?Z\çu\ÍQ\áFH\ÛqQ\÷j\Ñ\óx#›·j{oEªŸ/\÷«\È\õ¯\í¶¶\ómĞ¶>m¸¬]SW\é^\ï\åO\îÿ\0XG[x\ñ#VÙ—_\áj{ø\Ú\æ\ã\î>Å¯$Ğµ\ä’\ÙşVk¦µ\ñ%¤h¨\ßz«\èL\é¦\ñ5ÜŒß¼-L†\ò\æã—“jık%u\ëH\â\Èı\ë?\ğÿ\0\rH\ÚÕ¢Ù³\ç\Ëo\â\\Ö‰ü\Æ\ÊùŒ\ß$¡–¥Kydne®Wşh\àùç¨ \ñ\Ä>wß¢Æ‰l«äŸ\å¨\ZM\ßt\îÿ\0v¹}W\Åh_’@©ıÚ«a©<Ÿ2I»işY´]\Ù,\Ë\ì*\ßZ´­5ªü’7û«Y:V¬\ó\Ï\õ«z·–›ıªVº\Ç\Ûu	\ç+Qi\Ú*)Ì’\r\ß\í\Zw\ö”—0\Î\äª×š‘Œ\ì‰±©sb-\ÑH‘w7M¦²®o%µ\Ü<\Ñÿ\05\Ú\Ç\Ùm\÷İ–±.up>ú¯û4\ìC7­<Q-«.\÷ù~µ}\õ\Ë{\å\Ï\Şÿ\0v¼\ó[‘\ì\í\Õ\Ë\ÖUˆ»\ìW\Üİ¨\å2l\ô{ıCn\ä‹ø«\"[©6ü\Õ_JÕ„‘o—ø…6ş\èI\Ó\î\Ô\ØÁ²{kƒ&\ì\Ón.*½¤Ÿ-E}6Õ¥\Í\"œùQb\Î?2m\çøkLM\Zÿ\0r\ÃT\ò\×h;ª3«n…«Ú¦¹b|\Íjœ\ó&\ñ;y\Ë\År»~jÛ¹’[Á°F*¯ƒ{3|‘ü+}NrŠ­·o\à\İNgÿ\0P\ê¿J¿ÃRC\ò¦\Õş\õ\Z—s˜¶\Ï\÷¯r\ğ„e‚}+Š¶øWxÁKµ\èZ&ƒ&“F[vŞ©\Ñ\Ñ\Ø\Ç\óek¨\Òú\ZÀÓ£ùVº=;mdj‡\Şü«\\ş±û\Ë	A\ô®\ò?1kX‡n\ñ\n\n<{X·y¼\Ü}\ê\áo\ô;½¯+&Ô¯K»Â¹\Ídøšh\á\Ñ_y¾Q@Dù\÷\ÅQ¼s`\×%5vş/Ÿ\ö«ˆ¸\ïA©B\âŠl\ß1¢€?]\÷TW\Ò²?^•\'—\ô¢k}Ğ¸\ö­d|¤O—ş%·—ªÏ»Ö¼¿P‘1Š\õÿ\0Š\ö;u7ú×’\êz½p5©\ìQz{\"G¨µš\İÒµ/§\ñV»o\å\ß\õ\ïVt¶\Û*Vš¦µş ù\çŠÍ›P“µ\\¿]\ÏX\ó\îV£P\Ô\ê¼	¨;kh>\ê¶\Ú\Òø©—Ÿû-rş›\É\×\íÿ\0»š\ì¾+Û™¼¿Âµºø$>Á¼È–¬J\ÕSJlŒUùc\â³<\÷\ñ\Í\÷\êı¦İµNEùªÍ–q@\ÌcmW–¬•§h«¤,µ¦\ß4Uœ:\Õ\ôm\Ñ\ĞQŸt\Ül\õ\ìEnn\Är¿\İC\Z\'ùÿ\0¾«å«ˆ\÷M†¯±c\r5-ü3¬\ÏY^\à.\ï\ö‚\Ô\Ïc\×\Â=O¢&ªWr´dZ£x»¡j\óY\î¦£6\Æ#ÿ\0¬$\Ü\ï·;kgS\Ç\Ì=+œ¹®\à=i\n\ÃY¼\ÆSü*i\Íy\òùi\÷qTü\É\Ómbc;ÂŸ\î\Öle•‘\áe)\÷¾\õ=\æ\ó‚\ïû\ÕM¤ù\Ó$+«ûT2\Ñu.?¿L{¤\Ïzª\÷&if\ä\ÅecTMqû\ÎAúUy\ã^¿57\Í\×\æ¨n$“½HVù5N\æi \İMY\å$\Ó&ß¹º‚µ+\Ã&fù\êú6\ê\Î\Û\Î\ó\÷š¥\ór«Q––O±\ëUu¹v\ì\Ø\ß3\nl\×B8ù5d_M\ó¯\ÏL›™×·\æ\ó?\n\æ\ï\ïFp™­\ëÙ†\Ö&°Ÿf\çù*\Ås¼šEû\Íe\Û¤L\Ò?Í»¥o<?h%\0ùj]7\Ã~sl—ıª	H\Ù\ğ…¼RB\É$j\ÊÇ\Ë]³\ğ®\Ë\Äo‚4V\Å\Zn,\ãA\Æ\ì\rt\ÚV¡\öq³šw5Q<Š\ï\áx\Ó\ä\ò#ÿ\0¨ÿ\0\á\\\Æ\Ã\îÿ\0v½\Ìıùr\ãsUY\ô”\Ù\ò[FeX\ò{o†6qÀ¿<¾gû\õ:ü)´‘~w¸uÿ\0eë¼¸‡\ÉnjÅ†¡ªş\ò¶),?\ô\É3\è‡sVN¡\ğn\Ò\İØ³É·²×µ\Ù^[j2@ÿ\0z¶m\ôû9ıPeÿ\0j‚\Ó>nŸ\àı§\Ù\ÛË¸–\'a\\\å\Ï\Ã\İSCF’\Â\á\åoî±¯­.|?e\"6QU\ô\Z­c\à\İ*ù\Øeqü4¹MS>;š\óÄ¶iµ\í¶ÿ\0tuühş\Ü\Ö\î!´›w~+\ë\ëï…¶Lÿ\0¹\Ã\'\÷XUføWo…;#\İÛŠ\\…\è|\Çiy¬\\[ùi§É¿û\Í\òÕ¥\Ó\õx\Óç³“s|Û«\é\È>Æ»P¿\íb´Ç€ì¶ª:n£—c\ãû\Ï\r\ê·GvBÿ\0³\óVî›ª\én\Ï,E\ñı\ÚûCW\ğ•gl«\r¾\×?\Å^G\ãk{K7‘v&ÿ\0ºx¦‘\Ï#\ç;\Íb{\ä\òŠ;?\İ+ı\Ú}Ÿ†\î!\Ùp›¥‹ı¡¶½G\ğœ\Z…\ã\Î\à*#Ö§‰d‚\Î·‚!µiH\â‘ÁÃ½¶\ïV¬“\ïT\în¤[¦\ãmXŠM\ÏYÈ›—Ÿg“¶´|1\á\÷\ñe\ëE±Ï½s——\r#\ã\ï³^¡\ğ\É²\ôÖŸfÖ”ÿ\0mJ7g.\"¥‘b„v‘\íŞ›«^\Óá¾Ÿn«û„ÿ\0\nÓ“\\—øsU¥Õ¥a\Ô×«\Âd‰\á><¤©“C²ø#Z\Ë}JV\ïLûtµb±\Ğ%­”\İÿ\0€\Ôoqg®m\î%\İËššI=ij:yukx\×\åNmQ&9j\Ö>†¸ã¡¡–\×\ñ%¶›o¾S¶©\'Å2\İø\ñ\\oŠm\å\Ô-š \n·\÷«‡À\÷2l-ş\Õ`o\Õ\ïş<i\ñ–ı\ê\å\õ¯l_*ş\õrk\ğ\Ö\æW\å\n\Õ\ë†r+\÷h(Ú³Õ†¡l¯üMY^\'‘\î(”ü\Ìk{N\ğ¿\Øv‡}Õ©\é¢MW?\ó\Í*‘\â~8S\ã\'Ş®*u\Ê3Wkã‰¾Ñ©;»š\âu96¦YF[|\Î\ÔS—­ú\õNÛ¹\Z‘z\Ó\×\îµnÏ’>yøÂ¢G>»k\ÇuF[\í¿­ÿ\0\Ò\Åx†¡\Ë\\­jvÒ™\ç~$ÿ\0µ>\õ>Ÿ\í‡ø¨\ñ<{eSR\é±üˆh±\è©\èZ¿]¬µ“r£utz…¯\î\Õ\Ê\Ö\r\Ä|\æ‹¦;AıŞ¯n\ãû\õ\èŸ¿y£\Û\ÉÛŠ\ó\Í=¼»Ø¾µ\é~:ŒI\áHŸ”Z¯„™³\Î4Óµx«\íœU+š´\ÙwTX\àŸ\ÄgJ¿5X´n*)\×\æ©mŠ»\É{ÓŸ\÷ˆ\Ôı¿Zc|¢˜\Êc\å5u>\åT“­\\\îPY—\æ\æ¾\×ı¬L?\r\î%#o›zøú|µ\ñ\\ık\î?\Ù?\ğª­\Ç;¼\÷¬*ü\'±ƒ\Ü\öy\åjÎ¹ûZs\ô¬ë†¼\ã\İ8ıUGœÿ\0\÷\Õr\÷,rÆºUvLümZ\ço!I8\å¥p2¤¾}¾Q\Æ\Ü\ñ\ÅE»\ÌNÛ– ¹ù\çdOº¦0lnj@–mA¤\Ü6lZo™\ò\óT§›rªşu²:ª\ìüjF„’^(Y>U\Ï\ËTb¸‘—­\"\Ün4š(ºn?\ÒN‘¼Ê¢\ò\í}\ô\ï¶#-f\Ñd»Q¿Şª·\ó\÷©x‘´×º--J\Ôi\ß3©ş\Z²ìª¹ş*\Ì\İy\ã5$—ƒs³Lšc\'Z¡;\÷©Zc»5V\êN\õd²™9®v\íŒe\×û\Õ~ú\ãt\Ù\Ïü³\æı\ãs\òÓ±7+X\çs`µ\Õh°¾‘X6\ê#\á+§\ÑfZû\Õ,\Ò\äş`©Lf:–¸¸«\rsSs¡¶›j\óV\Í\æ\Å\ç\î\Öl\ğù}*¯\ÚL|\Z¤Ê±bÿ\0eÀlš±f‘\âm˜ÿ\0V¢L\ß\æ¨\å…9\Åt&1,\õ¡F\ñZ±øŠxYC8\Ùş\Ír\ò\Û\Ë6Ï»Ú£I%ß‡ûµª`z}¦ š¤;Ÿ›­Ok§½«~ì•¯>°Õ¤\Ó\İ\\9\Çz\ê\àøg\Zr…¿\Ş5W´{\\¹,\ÔGª$Œ ?5À\ê_\"¸\n–ÿ\0v«\é\Ş\";Ô—?\ğ*.h®z5\Õ\í\ÏKvëºªÿ\0n}Ÿäœ…o\ïW/ÿ\0	@6_k²kœ\×<D‹~\ô+}h¸3¤\×|QmŠ^qÁ\İ\óWƒx¿Vş\ĞÕ¥d}\Ê\Ç\ïSü[âµ;$n[øwW5g¾fóœ½·T¶b\ÍkkÏ°Á\ò\î\ëXÚ®¡\ç3½Ksq\Îcj³\ánju9$cMr<\Ö/\÷š®C\'\îkqf\Í_µ`\É\ó\ö­Ø½¢Ø¾¥ªE\0²y\Ûı\Ú\ö›\r/\ìv\É&\ÕQ\\7Â,Kq{(ùmFÿ\0j½B\ãPŠšî¤¬yuŸ3)3·¥F-K6)\×\Z\ÂljÍ›Xx\Û\ä5u\\ã±´š:H¹ş\Z“û.8û\Ö\nx‚\ã¾)[X’El½MÊ±\ĞE§\ÛnùÈ«\ñh\ö\Û3\Åq¢\ñ\÷\çq­{mIüµO2‹“ca\ì\í!\àT\æüˆ*\î:\Õ²=¯\ÈP\Õ\\«\ru…¥PcFÿ\0z£\Ôv‹\å ÿ\0€Š™ä—„5s\ìrÈŠŠ³fš˜\Íy$|L{\çaZO£\Ë3\ä\ÔB\Æ8İƒ‘¹i\rr\Ş:\îrzW/}ºY\ä\ß\ó¶»\rz\Ş(m˜\Æ~µ\Å\ß\Û\Ä\Èÿ\0>\Ş*\rQ\ãş-\Ù\Ç\É\\\rü›¥®\×\Æ\×ı­–3Ò¸‰¿x\ìj\ÏÊ´S$\ëE0?_\ÇJz­1>j•zWD’<O\ã}¿\Çûµà·‹\ò7µ}\ñ®Üµ¦k\ç\Û\õı\Ó\éX´mL\à|U\î”\ÔZ&\Z­[™­¸û\Õ‡\ô¹\Úù\ìÿ\0\ÅI\èGc_Q_2Ú°&QŞº‹\ë‰-\Õ¢/~~j\Æ\r™\çœ\íÿ\0dP5#\Z=«sÖ½OÄ«\öo\ö\ÅC\á˜#¸‰\äysü?-z¯jŸ\ğ†¼Qƒ±E\\v)¾c\Ç\ôŸ–V­\ä\éX6,\Í\õ­¡\'\ÉA\Î\ÑV\ívµ:\ÓÒ‹†\ó)\Öÿ\0» ›<³¶š\Ñ\ñQ5\à¨dºÜ¼P\"\Õ<r¨4Åªı˜Ü‹UcK®r»«\î_\Ùü*k-ùÜ²?\Í_Knd|W\Û?²vø~\Û\Æÿ\0+,XUZ®s\Ún$û\ÕBf\õ«Ñª«yL\÷\Èk¿}ÿ\0Ú®eş]\Õ\Õk«\ó\×-y¤UŒ[»\Ş9\ÅY\Ï\ò¾\rj^6\İÕ/\Ş\Íİ¼¾jq\Í:y8j«\ËPü\ã\Z¶\ËI\à\İÚ¢i>FÈª\ÒuRŸv‰¹¢\×—­D“\røªM\'–[Ÿ¥@¬Y\óš‹™~H_\ÎRO\ËNVO—\æ¨ş\Ôd_œª¬\ŞgCSc[’\Ü\Ü	cøj¼\Óyp§\÷³M—\ëU\å\Ë6\Ê,K%[Œuª³\Ş#³T\ï.>\Î\ê\İj†y£XsŞ•i\Ø\ô\Ù6\óüY¦½¯™Ò«\ÛL\ØÀZ¦+ü[h±7,Efz\í­K,‡5“\r\Òz\îjÔ³º\ó8\Ç\ÍPÑ¬Y\Ñ\Ù\Üy›G\ğ\Õ\å\ô¬\ËOİ¯ûUkÌ¬¬t¢Ì¿¼Z£y\äj“\í56i-\Zš\ôşdn\Ä9\\Qm¯\â_š­\İ\Æ5sÚ†?ƒ\å­S%D]}\×j[8~Ï“üU\æ\î·v§|2Âª\Å\ñ\Z\ò\Çtwq\ïA\ò\Ö\Ñ\Î\æ\ö#…‚9\ÛX\Æ97wj¯g\ã‹\rA0.J\İQÌµa5‹yøÕ–˜ø™\ã~~\õYûd‘¯j\Ó[R¶P£bµA5\å¿w\n´jW1^\÷\\–\İwW3}wxs¹š·5«L™B\É\\¦¡®[Ú–ù\Çü\n‚\\Æ­‰\Ú\Ò\Ü?ü ŸPL,qı\êÅ¼\ñÆ¡\"¤Y\Ç\÷ªÕ”;S-\ó5Dv\îY\İ\òµYZ\ÍËšĞ¸ùEsÚ•\Æ\çaü5I\õh\÷\àU˜\Õ\÷Æ‰\ó3\rgG\'\ï7Wu\ğ\ÛOK\Ë\ï\í	~h¢ÜÚ®ˆ\Ä\ó¥3´\Ğcş\Ë\Ò\â«\ó}j\ë\Í,\Ã\r_ûUºÿ\0\0¥MB,ı\Ê\êG·2~\Çy!ù#«\Ú=Äû\Ä\Û],7ˆ\Ö\Ù*Œú“\î`Ú (K\á\÷şøZAM¿;ÕŸ´K\';¨\ò\ßÕ¨£ÁsW-¬bU\Îj´\ŞfÏ¸j(–\í“A6:+{¨-\ÓmT¼\Ô\"’]\ä\rµšN£7;\r:_\Ş2ü\çm(•\ïª\r´hMKi\áù#;\Õ\Ï\ì¸\×ø©\\\Ö\Õ%ŠÎ‘¤‘·óº·®l\í\áLŸ™ª\åÅµ¼,F:T¶RG¬](“š\ãµ\İA,\ìî‹¬Õ¿©\êı±¥û\ÍÚ¼£\Æ\Ú\ó\ê\ö‘‘O\Î\Õ&Çø‚ù\ï.\åº¤\Ö3Hj\î¤Á]«-›šÔ€-ºŠ\ÏE\0~¿†\òø©bjÃ“\Å\Z|{·\Î6ÿ\0³U%ø¥\Ûÿ\0\ïÆº•\ä9¿ŒQÿ\0Ä©Ş¾p¼\èÀ×²|Zø¡§\ÜiR¤;±·¯\ñW\ÍÚ—‹§“p‰wº*$tÓƒ\'\Ö$\Âı—¤ø‰-ÕÆ¼¬KÙµMC\î[Éµª„~\×fû–\åw\ßU\'z‰\è72·Í¶\İÙ±\\\Í×$\Ç\Õ?\ru»…\\\ç\ßukA\ğ^\òNd¯ş=E‹IÇ‹%šly\ò7\ã^\Ñ\áÛ¯\íN\\’|º\å\ìş§œ¦I~k\Ô\ôO	Å¦hŸd\Û\÷†Òµ¢D´xt6\áw¿,Ù¤<Ÿs-øW±\Û|;´R\ÜRwV¿ƒ\ô\Ëu\é\Ñb,x•µ\ÌÛ¶Á#~§†µ…ù uV\ì‘\éºuŸ@ı\ÑS%Å”+û¸‹Q`\å<v\êr¸Ú­H>İ¶\Ò\òmÿ\0tW¦Y#û–\ëş\õDú\ä¿Àˆ¿…+\âm¾†\Ú]Ş¶\ìş\ÛÃ´¾k_ûR\îFÀ\'ş(ÿ\0I›»ştj„)\à:Ï‰ÿ\0¯¥>[\Åg\áŠC\÷k\ç\ìùY²\ä\íú\×Ò¿mM¿ƒ­\÷ü¬ÄµsV~\áİ…Vg I\÷j”­\Å^™¾JËšn\Õ\ä3\İH\Ä\Ö1»š\åo\Ôü\Õ\Õj¸‘z\×5~Ÿ&*K±\Í\ßü§šË•¶Š\Õ\Ô#\Ü\ì+\Z\ç~{U!&g\ó1CÉµh¹›š…\Ø\ï\Ç\Ş\ô«D±\ãıZš‚\\75/™¹0~Vş\íW—\î\ÕXDR©f\ÍUO-›>µa\äÜŒ\Ã\åªÅ–‹\n\å\æÈœUVºxD˜û­@˜Â¼\Õ?´y\Ùş*‹r\Ò\Ü	¯\ÍN{¡üU—\æ}\Ø~UT\Üİ‹·j9I\ç,jS\'™\Î\Z²Ìf\ä\ço\÷hI?y¼üÛºUÉ¶I*\ã\ñ\Í]ˆ¹O\íªù\éSü\÷G?u»Tü½\Ó0«\ğ\ó´š††h\Ø\Âq·Ë­8^ßø\r2\Òo-w\ËV\÷<’a0\ÊŠ²fÉš\×7\Ìv\Ó\Í\ç\Î\Û>\èª^J«|\Ä\Ôq¶\ÖaYX\Ù3Mn7\ni˜·z¥\ö‡\è§N•&éšJ§4a–®H£mQ¸ùh.\æm\Úùa«’\Õ\ôø\î>gûÿ\0İ®®\îM\İk\ö\ào­S!£º\ĞÑ‹9Z².\ö\Í\ØÁ$‰‹Ö»;œ5e\\ış•½\ÌZ9\Ù<i«Û®\Í\êÿ\0…T“\ÆZ¬\ÂÖ½Î—\Ò\Û\ëU\ÛIn\à7U\\›>\æO\öÆ©|\ç|\å§µ±’\á—\Í%›û\ÍZ–ºN\æ=kJ\ÛO\Úp¿5Ka\É\"¬6\éoÀ+\Ü<}*\ä\Ö>_j£s^¿-F\å?u¸½\Ï\÷«œ¾I-X\Õd*\õ‘s&\ß\öšº *¬Ëºtf\òşh\Æ\ç™\Â\÷¯|\Ğ|+6—¦\Åp\Øù\Ûıª\ã¾ø].¦—Y½·G\\•›ø¼\Õ\î­y+\Â]8™\Æ\Ç\áû™\Î6­N<7.\î­\éµC†ÂŠ­\ó\ïÉª\"\ÂXhn£cš´ş‹9sM\Zƒ\ö§5\ô²U\\,?û&\Ú5ş\õgmJ‡\Ìw^µ\Ş\Í\Ô\Ñq\ò—\ÚKEşùSb\Ô-\Ñş\ç\éT¾\Î[ÖšÖ¥_57SZMZ8\Ç³®µ\'“‘\Å5­Kw£\ìÿ\0-M\Í9J¯y#³U\ŞId\õ­³\ö§½®Ñ»\\9Nf\÷\ÍŞ£–ük\'Vg[gş\ö+§\Ô#\Úwÿ\0v¸\Ş4vl\å\ö\'v ¾S\ñ%\äz}Ÿ]\ò½y.»0··m¿4®w®«\Ä:‡\Û.Zt\'\ÊAµ+\ñ\Ï&\Òıê‘›9Ë™\ö\ÍT«3|Æª•bÒŠZ(\í·\Ó\õ[\õ×²/ıs;h_\Ï ı\íÔ¯ş\ñ­o·;/oÊ¢iŸo\ß-]©™rø.\Öc™~o\÷©\Ñx?L‡ø#_Â­´Ş¿\ğ#H¹\ö¥©ªˆ\ß\ì=2\İs„o\÷Rœ#²¤;¿\à4\×_›—¦´q\â\İF¥Ø”\\D£	\0_\÷l+\Ñ#_Â¢\Û\î• _—„£R…7“\öû\äTOq;Ôˆ®Í±\æ¬%œ­ü\\,R_7o\÷¿\Ş5*\Æ\Û{/ûµmtùw}Âµj--û\Óg\ó>ûš\Í7t\İ[\é£ÿ\0Àj\Ìz:/ZZ\Îo\á©\Ò\Å#şùWLš|K\éR,6\êø\â@\ç\ã±\İ\÷FÚ¹š\ê:V\Û\Ç}1Qı¡¥HX\È{\ÎE}\ğ\Æ\ÜC\á+?\áf«Á\ï.>ZúÁ–¿e\ğ\õ¢\Ó1\\\Õ^‡~jk\ËÑ«\"\ó\ï-k\Ë\÷k*\ë¥yL\öbc^I\ò\×?}\Ù·sŞ³.\ã\ÄMŸ½Qs[½\äe]‰¬;¥,\Ï]5\ä{ƒW9wŸœ}\ÚhÍ˜²\Ò$›Ş©/sı\ê¦\íZ¡\Ä\Ûw’N\æ5Hi\ÓüÁO¥4~\ó­Y›#qş\õE\Åu#\î­X|2\óTD\ÛV!”\õ+§[‡\ã\åş\íRy¶²ÿ\0z¬j3y\Ï\Ón\Ñ\ÍcK\æn\ßE‰¹<\×NµšÚƒ\ÜH\Ù;V¦™\ÜV|Jc‘•\Å\Ë\è\Ç\î\Ó\Ö\á\æ»ş\ïz«\Å\'üš¬ûÛŸ¥U‡rú[™~_\ïVµµši\é\æ\Èû\ßv²m®’p\é·ıªµiq\ö\Ç]ÿ\0w²Ô´	—\ÅÀ›v\÷«¶“\ía±·-WKs±†6«R\Ú\Æm\ä\ä\î_\î\ÖM\Z\\\Û\İ\æ.I¨™¼\Çù)‰\"3\í/²®D©±Š8ùj,Zd\Ô\ã\îT\ÑÇ¹wcµ3\ËvnZ–T†ÿ\0¬\Õ[›wa\Å_[3×• ı\íŸ\ÅQc©3‘\Ôa‘C\ZÂš\'\ÎW¢\Ïb$^EsZ†›\Û˜¬–­\ób©Ofûk¡š\ß\Ë=*„­¹¸WŒm\İU³UR\ß\æ\Ån\Üı\ÖÈ¨ ³ypW&\Ä\ö;E^··\ò\êØŒ±M\à|£o\ËR}”³\ğ6­H6U’1·5\ÎkwgF\'ş[š\×\Ù\÷.7W®^}¢6wø«zh\á«P\Ä\Ô.¼\ç4hZ,¾&Ö­\ì \Ï\Î~}¿Â¿\ÅYZ¿5\î|\"m\ìÿ\0µgƒ\ç¸ù£fş\åv¤y¿\ézƒ§Amn6$I´-]—2U£nø\à\Z’+r\İEPX\Ï\å…N–£eh¥‰cÒ¥û\Õ\â‚le‹Zj[–j\ÔK›¥4Û•9 «…¿\äµ,ı*\èŒ5N¸QAV3š\Ü\î§}—Ö­…\Ü\õ$¿-bƒG\óS^:¸aâš–\åº\Ò\Ô5\"H\ÆÕ¨/¤H\Óû´ë‹³¾8¬Mb\á\äOF4¬3]Ôƒ;üûU…k\É|¯H»bû©½[[D\íÿ\0¡W\\\Ú\Ë\â\Ï²;o‰Nã·²úQa3\Z9\æ¶{™şX—¢×Ÿj·Ÿl¹n»T\ñ]\÷ujam\ò.6üµ\ç^N\ŞŠ¶F,¥uU¹\ö©\îş\õAÏµ1\r¢\ô¢€>×R{ƒû¸\\‹Ï“ø\rm\Û\Ù\ÚZ\ôm=¯-\ãp{V·8¬d%Äœ\ãşú«h\óµhÃ¨$İ¦Í©4|\n.;\ã\Ğ\÷7\Î\õat8\ã\Ü\\†Zƒ\í\Òg­T\Ô5ic\\s¶¦\åX\Ğ6vÑ·j½\r¾\Î>j\ãc¼—=Ù«{J¼¸¸M›?\àT\\Fıµ½ºÿ\0\0\İNºh\áN\0ªAd^´H\ÎË†¢\â°Ö¸\İ|\ÔÅ…\Ùÿ\0Ù©EUÊ±/Û¾U¢›V1§Cº·ü)\ö+y›\í-\ß\í\Õ]z\Ö\Ò\óRÅ°]\ÕB¯\ñ\Z«À]iú`µU¼¼»irˆ\õ\õŸ\Â/\Ù2\rSJMK\Ä\â\Ş7G\ğ\Çı\ê\é¼aû5\è\ßdh\ô\Ëq \ãû\Õ~\ÎL\Ï\Ú#\âxµ+¼sV¢¼«\Ñ|Y\ğX\Ğ\åvûtÄ¢¸;›;‹a-»§ûÉ¶²ppÜ¸\É2]*5\rb\Î#\÷L‹šúƒI_.\Ê%uEx\ÃM?\í\Ú\äS”ù#ù«\è;E\ò\Ñk±\êa\ĞL\ÛKVU\ß\ÌØ­KŠË»¯5¤LKÏ—šÈ¹û­šÚ¿¬[\ÅYš\ØÄºùwV5\Ì;£cüU\Ğ]\Ç\æt¬™¡\Ú\ÍMœ\äªv²Õ›%o^/—¸V$‹µª\Ğİ¾ZcIŞ¥™‡JŠUo*µFl‚\á_wû5Q~\óv§mı7µ¸ŒÖ†L­y)±z\ËÜŒ›ù³\Åi\Í4[:V$\Ùg]Ÿ\Âh3\ñ¼nûıx¬›½\í7S[’ü\Ñÿ\0µYS®\×\ÍZ(f>n¬\ä\Î0wUY#}¬\ãÛ·ıšu¾\å¾\õ;iGûÎµb9<µ\Ş8E5Ad;\ê\×7U>TZMÍˆu\"¨»\ó\óV’I¹T\Ö2C\æ\']»*ı…\Æ\à¡ş\÷\÷k&4E°‘2\ä«gµu¯#_’4\ïU9®8z\ÖoÛŸ\ÎØ£r\Z›syw\È\èw\íQ\ïW~\Ñ\åÊ¡ş\ï\÷–°\ã¸\İ\Züûj\ÃL›UÜ–Ç½CE&lMpdl\Å\ò¯ûU\İÿ\0z²\ßPûûZº‡©Y´tEš/q\öx›+»ıª\ç\î?\Ò>»\éV/\õ\"c?-d]\Şyj¿5Iºc%\Äl\ÕB\âh»µZmC\ço\î\Õ+\ËÀ\İ)Ø«¹e“‘U\Ò\à\îÀùj›³±©L/\å+\Ó%³N\Ş@§šš[‚¼}Õ¬ax!_\ö¨›P\ó“\ïU(Ó™¯p’J\İk†\Ö\ï‘]€­\Ë\Í@\Â\Ï\Ó\å®7W¸IŸ\î\×m4yµ%\Ì^\ğ7†_\Å\Ş,µ³G(Œû\ä\Ú7|¢¾\Î\Ò4»m>\Ê(¢‰m\nƒj­y\ì\ñ\àq§ø}\õ{‹}³\İ>\èÙ¾\ğJ\ö˜¡=«¤\Ê#eØ«U\Â\ó\÷jùµ¦­Ú›©-NûÓ…¹©V7Uª°jE-¸\íU¥„\Õÿ\0,\ãšg—Ş¤5(%½:Xxâ¯¤t\öQUa˜É˜\ß\æùdM¼\Õ\É#\Ü\Õ^XDk@‘Bk\ã\Zü‘–¨£’\ò\ép€\"ÿ\0z®¬>cs\÷jÀ‡\Ó\å¢\Ã2ŸOû:os»Ö°§_´L\Ûjâ®şO1ü„;½Z²5†‹Mµg/\åúµ\0yG\ÄıB=?O•w±\Û^si¨>‹¡<‘·\r¼\ó\óS¾!x“ûSTp…\İ\íT$W·\Ò%¸¸M¬Éµ7»A\rœµu.¡|\Åş\õ@\öÿ\0¹gş\í\÷“I\'\Ş\æ´dŒ\Û\éL{™ªÌ:\çïš…¾\íOq\÷š«;PtQE\0}\ã\Æ\ïŸ\î\ÕØ´w“®k_\í	*\ô6Ú³\ÎM%\ã\â§\Z>\ê´.7Rù½ª!M-#¨¦±‹º\n°\òI%0\Ú\Ë\'j\nÔª,\íÿ\0¸*\Ô3Ej8\Â\Òÿ\0g¾)üE\è$kê‰UŸP\İÒ®ü\çuYşÏ·Û*À\Äk\Ç\ÛRG$\òq\Íkµ¼Qÿ\0¡$Š3Ò€2[O›5\î²§\Â\ôñ‡ŸPÔ­ü\Û+\Ş¾\ë=ygÚ·*„]\ß\ì\×ÜŸ³7„_\Ã~µ¸’\ßÊ\ôy¯¸\ß5\ÑMi\ÌaU\Ø\õ\ÄV†\0ujİ¸v­)—\ÌJ \ñ–8­\â\Ï5\ÈÀ\Ö<+i©[7ƒµ\â\Ş>øOl¡\åŠ\Î9\Ó\ïa\÷«\è\rÏ¿dƒ\ä¨5[8®¡\Æ\Ê\ÙZZ2\áQ£\âT†\ßC\ÖZ8­Ó´®6× \Ú\Ü$–\ÊA®\ÓÇ¿\àÖ‹\É~UÀ\ä2\÷¯-¸\ï\Ã7-gx„0\è\ß\Â\Õ\åb¨µ©\ïa*§¡\ĞJ\ÂE¬›®­RÁx“&Aª\÷\Í\ò×‡#Ü‰™xÕuZ“¶\å¬ù£\ó++›™3¶Ú¡q\ón\âµ.!ªG\ÍH4s\×\ñüø<|µtwvÿ\0;=dO\Ş\ÍZ&A\Î\\\ço\ãLK‡\Ø\È\ç\å­˜\ö»6+>h\ö·vµLÍ¢œc­fù›[%·n«W•\ê…\Ä.?ŠµF-\ÍÒ³\æŞ¿:Uµ\ßjª\Üb4üjÑŠpû°Š¢u\ì\ç\æ^\ÔI\ó3\Z‹ŠŠ¡XjÉ¹‰5ÿ\0H\õ«(°-\Ö%r±`\æ³\ÚA»\äû½ª„jC\"3|\èkR\Ş\à2\ìH\nª½ü5\Í4\Ï\Z£\ïú­oi\÷_¼T?tŠ‹¢I°0µj5\Øæª’]Ae¹ÉŸ+±Wº\ÔI#ùm+ü+Y´Q¤\×Oµ†7-R–\è[²\Õ4ÔŸ?z©\Ëpd‘³\÷jlU\Í\Ø\õA\åv¬& <œ\ò\ß\î\×<’	—\Îu\Ú\íZV)-©nfş\Z\ñ\ö\ç\ï-b\Ép>\óÒ­\÷™\Äùk6“5\'ŸŞ²./7Mû¿\Ù\Í>i“×µb\Í1\ó”\ÔX\İ2\Ä\÷\ß3qUL†G¨¤I.)\ğ©\ój¬Ã¾u<Š–{Ï‘Fi\Óıj›\ãm%\ÌcÍ»µ$\×	_9Q=ÀVT\0³´V>­xşk\Å (\É\ÕZ·Š8ªL£¨\\yŒ\ï*¯†t3\â\ÏXi:¤\Ó*—Q\÷W­P¹ºF,¹¯¡?f?\Æ\Öw\Zì±–w}³à®¸#•³\Ú\ô­>-?J·¶,H\åj\ÒÃ· ­…vb†ŒV–?if\éOœU…\Â\Ñ$¨°\Ö:vÒ¦¦Š?–¤+\òÓ±W(Ëšc\îT«O4¯\ËJÁ©I˜ı\Ú|1™\r9¡;³ü4\ö¸­\rDkr­º ¹·,½*\ìw‘\ì\ä\Ô77ˆË„¢À™E!\òÖ¡’GİS=ĞŒ|\õ\İA-!4X.Ux|”g\ãûÅš¼«â§Œ-¬t\çŠ9¥\Ø~Un\õ\Óø¯\Æm\äO\ïg\ïW…xÁR\òo7•R~\ëHjs^\Ó\ßT\Õ\Z\æ\ï\n‹“µ«?\ÇZ³\Ís\öH¾\à<Vşqû™\Ğ|ª½+™º·\Z—ˆQ\î/\Ì[\éA™N\ÓG\Û\r¬xıü§&©±²[s…o\ïWe\á]$\Ö{º\Ãı\İÂ¸M»QŸŸ‘O\ìÕpSı\ê®zT\ò\õ¨¥\ô (§/J(\ôF8\ã^\â¥ı\×\ñ\Z\Í\É\ëOkWe_œÕ˜X½\ö\Ëxı(}J,d\rÕ›\öš°–iŞ ,Mı¨›¸JT?À”-šS¾ÆŠ(4±\ö„\ôÇšv~®-¨¥6â€±I|\Î\îj\Â3\Ôÿ\0gû´ÿ\0³…«ûÂ˜\ñ\íZ˜®Õ G\ç2¦{ÒŠ¹-W\Â/\É\ãO\év\Ê\ó\Ì\Øùv\nı\Ól\ã\Ó\ôû{x~X£@ˆ=x\ì±\ğ¯ş_¾·~›oo‡\îÕ‡D\õ¯x2½\÷-vl¬yu§vF\òI‘;\Òm,ù#ob‰\Õ5	œ¥	v2±ªe‘\\\Z–f+ºª\Ê\Ï½uÁ2\åRH\Ê+\Íş$x.\ß\\\Ó\\\à,\è8uû\ÕÛ™¤ÿ\0zŸ%ªMo˜Š\étÔ—+6§QÁ\ó \Åqq¢ß½\Ø*\êx\İüKZmy\ç.sº½3\â—\Ã\íhZ{D\ÙpŸ0z\ñ\î§\Ó\îZ\Ú\áS¡\ÚU«\æ1xWMùW„\Å*ˆØ›­Uzr\É\æsM•~Z\ñš\å=x”\çJÍºR«Z\ï\÷k6\ñwn‘F<’\õ•s\ÈÍŸ–µ.¡û\ÕA\ãÜ½j‘-7Q–qY“Gº·¯†¬†R»…j™\r2\Ç\ä³g\î\Ö]\ç\ï·n£ù«.x\Ä{j™“FcÇ·mTw-[y>VsT¤“v\ê´\Ì\Ú*È¿#TK ¯\ÍO•xaTšM\ÍZ¦E‡\\²H\Û\ê‹\áV¬˜\Í\ä¿gŒ\ís\ó\n\Ì\ó6—Cü?/\ÍVˆd\è\Şs>?wUı\ñ.¥Ã¸‹\ï5d¯\ß\Èû­L9\ò,|¹?z´3:?µ\"\Ë\ó|\ÍQMªy\ì\ñ\É\÷“¥e\Ş4¶²´€‡\ôZ«>­\öˆ\Ò\ã\Ê	/\İuS@®n>©\åù&sP\Ëu$‡\0À«ûTT‰µ\ÅWş\Øu•\ğÿ\0v‹s¡†\ãhù\é\Ò^\àæ±¯/?Ñ¾_\â§\ÛIşŒ\Î\î>_\ö«6‹L\ÔK1i\ëp›\Ôgı\ê\Ç{Áııµ™´\ç}EyÎŠK¤eÀ5•sùˆ¨V\à1Z.n†Îµ<¥sF\Åe\Ëı\ê\î+šª²{\Ôw\÷H±(â«”ŸhO6¡\ò\ç<\Ô\ëpËšÊš\ì\"\õ\ÍP—Pu“\ïÿ\0Àj\Õ3\Ô/\İj\ö†\ò\Î\ßF\ÏJË¿ºy7\Ï<…˜\õf?3\Z‚\æG`\ÎÖ¬Ğ³\Ìs),Š~\ín‘\Ì\İ\Í\ÏøN\ï\Æ µ°¶ˆ?™\'\Î\Íı\Ïâ¯¹¼;¢\ÛøwJµ²¶AP¢ U¯4ış¿†\ô\í;\Èÿ\0Ò¯>tV2\'¥z\ì‘Ö \ÜR.Z¢\ò\ß50]«AW·\æ¦ù2Ô»=©6¶\ê«\Ç\î\n9¦4››Ši\÷§\"ü\ÔX›‘M»mE´\Õ\ôwŞ¥6\éŠ,.c,6\ß\ïTS[ù\ÍÒ¯O·}A#m-;1hû†|Ò´É¬şÊŸu8´­Ğš¡#Æ¸\'\æú\Ñbnf^]%n­ŠÀ\Õu¸}€\í­†y£L³³Ri’IV[„Ü¿\ÃAg!q¢ÿ\0h2\Ív7DŸ0½^O\ã	>Õ­} \ğ\×\Ñş!X´\Û	p.Æ¯™µ+£qª\İN˜d\Ş\ØjÍ\Ë\Ëy\ö_64û\Ìv\î¦\éºl¢\ñxù\åùEmøC:¥\ë\Ü< ·}\çı\ê\ì<\á\ó¬]Ï©\É\äl~• d\ë:\\º=…¸O—\åå–¼\Å\ëû\çºšú\ã\'M’\Ö\İ\ßM\æ¼\ÆV>M„W\÷<¯ÿ\0\ĞK8g]»ª´j\Ü\õUºÕˆŠq\éE\0~ˆ6‘d¨¢¬\Õ$q\ÑED¼-0\ÉE\nŸ5\rŸ\î\ÑEX™Q\\\\<}(¢€*µÄ³ ,\Õ\ô7\ì\éû=]øº\ö\ß_\×bh´˜Hh\ào—\Î4Q[\Ó\Ñ\\\ã­\'c\í\íR\Ş4Š/\İÄU{-N\åŠ(­O&\äR\Ü|\Ë\ÏÖ«]\êH\ÒùI\÷¨¢µQDÜ„²1\ä\ÕN\ç{;dü´Q]0\ÜF\\\Í\å¿û?Ş§}«\ÌÚ”Q]`EqœŒùkÇ¾*|3Mb6¼´/\æ¿\Å\íEh)Sw:h\Í\ÂZ-mq-½\Ã\Û\\\'•<GVˆH(¢¾h}­	76E¬\ë˜ş\õW\Øf\Í-ı\ÚÍ¹·hş\åPM\Ì|6k5\íÜ³ŞŠ*\Ó$É»S|V%Â¿Ì¹\Ü\Ù\æŠ+DdÊ·\n6\â¨K¯İ¢Š´C*\\\ãf+V9ş\íV¨Í†\İ\Ñ3\ã\ç\íY\óbG\ç\ïw¢Š\ÕHVj\ñü5^\îo1\Ğ¼§š(«D1­x!\Ü\ò|Ş•›34ÎŸ-U\\É•dšV“.ûš›\ö\äVù\ÅUÜ’\ä7PH¬drœ|ŸZ±§C\ö\ßÄ½¨¢‹€\ë›%Xÿ\0ş\Z¯\r\Ç\Ï\ÉùVŠ)\0\Ö\×#V_\Õ95#ü\Ä\í¢Š\0¥\òıü\ÕY\õ€­±…V–&\å)¯‡®\ìÿ\0\rSš\âFûœQE3&Ij²ÈŸ;–\ô¯Kø-\ğşOx\ŞKˆ\÷i\Ö\Ç|\ß\í³EH£\ìˆ#KXV(\Ój”*ÿ\0\r_wCE¡,o–ş”\ñn\íEp·¡\ÔGE¬µ\ÚSÖŠ*ˆ$ûP\õ¦½\ÇuPG¥7\Ë\Ü?»E‹ª\ë‘i\å‘›/\÷VªÃ§\ê:\ÑW(m\à?6\ç1¢Š$R6lt›]51\÷\åş&jµ4›‘@ÿ\0\Çh¢¤h\óOŠ—\Ïg¦\\Aú\×N\Ù\ó\ÅÄ‰•”û\îvš(¬Ùª\"²\ÖK\Ò\ÛO‹?m»p›½¯¡|¡¦—¢E‹\î\"\å¿Ú¢Š\'™|hg¸Õ•\÷…ÜûW†x\ÚO’+lm\òú­S \à\æù™ª«\ÑE\01ºQEÿ\Ù',0.000,NULL,'2024-01-04','2025-03-02',NULL,1,'2025-03-04 11:06:09','2025-03-04 11:06:09',0,0,151),(2009,'Kapila Vedam',2002,NULL,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0\n\n\n\r\rÿ\Û\0C		\r\rÿÀ\0\0\0\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0	\0\nÿ\Ä\0;\0\0\0\0\0!1AQa\"q2‘¡±	\Ñ\á#3RÁ\ğ\ñ$brÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0\'\0\0\0\0\0\0\0!1\"2A#Q3Bÿ\Ú\0\0\0?\0²\â0j\ò¡=*\Ó¡Z†6xNş\õ	³B A;\ïX]\Ù\ÉrCy%;¹\È\0{’zTm$\\Ø£:[~\ñ	+\0„\õ\ô\Æk‘\Ãxw8“[!§\ĞNm@\ïé±©´WlI\ß~Œ\ì\ô\ìv5^\È{Y!•eBP†T!•¨\\ÔŒ\Z„<=*Ù¡8¨Mš(\ô\õ5_q\r4¥º¤¡	Ü¨œ\0=\É\íXÙ’<\ñÆ®‰á¡“Ô±ª¯Ÿ†‚°e]¼\Çzu\ì4vÌ¨SŠ\Ş-uÿ\0$:‰úƒù}½D”Û­§\ÉdBsÌ¯©&©Üƒ¨\òµ\Ì\à\ï(—!$’—N7û\ïY\â\È\ô:\ÚÄ®±\Òv\ĞÕ®\àåŒ¡NTˆ=N\Ä\õ©¦Œi1\Ê\Ñ_\Ä/^\é\é ]„;ü!²\ã¼jH\õ ıA¬¶\Ğ7c\ğS\ÅŞ„\ã@j$YÉ´\ßU±¶LP\n\'\Õ¢‡\Ój,lú¨œt\Í†ß½d†T!•eB\â¡\ÄúUš“\ëP«4*¨`æ¥€	\'Ş§	\Ía®-z*\Ğı\Ò\ë-¸™•¸wQ\ë€;šÄŸMl®o+\ï|M—*¾k–½0\Ñ<\Èie\ny>\ävÚ”“\ä5k\ÙîšE\×-0Dh‰¥( -~\ä\ö\ó4EJKşD\Ém\é.¨¨©\Ü’\Ğ\Ø}N7ûU\õ {o\Ø-¸z\Ò<·’¼c	Q#\÷¬6\âYE\Íú\r¢\î\Ó& °’¢0  =3HİÑ¸£—°\ã‰Ze‰hš\Üe––XNpß¦ÀP\é\ÈRd\ÉÄ•ki[|\ß\ó\Ñ\"3Š)¥%\ÆTP¤v9\ë‘\ë[-\ítiµú‘`^\r¼fJ½L¡5\ôÀ¹ª6\ÛËŠwtúú(\õ\è}j\ÑN”9Ìœí‘¸\ÇqF1½+$2¡SP†r\ç­B\Õš“ùT*\ÎjV:\Ô0\êûh¾\òÒ„4‚\âÊ\0\0w=ªrÑ’¸|Pq\æGu¶\Èr”»le)9ªVwJ@\Û¡=\Îİ·MÏ\Ô D!\ê%Î–‹4C²ww”\ã§b}(‘‰‰Ë@==gT¹\r\Åa¥IuDdpMb\Ë>5²\Ô\Ò\ìRF\ğÿ\0Ã”kŠ\Zz\æã¸¤\ó)¶\ÕÊ„ç·©®~ÿ\0&«z:\Ì_\Ínc³k\à^–¶\à›Si\èT’¯Şµ’\òVH\Ü\Ç\ÆÒ¿A\Ô\Û-’\Ë\ñ\"!…cp\Ç\íAD\æ†V5p\ôkz\ÓmÎŒ\ã´•¡`Œ\r¦^X\ñ±i‘ËŠ\\1T\ìûR<§FTR‚@W¶+£\Å\ÏRZg)\ã¶\÷—¶^]ƒpB*a\öœùUĞ¶°vÏ¥o—~ZQ\×E±ø-\ñ/\è\Óh¼>•j{RB\\$\à\Èk X\õ#\Ñ\"\Å\Ú$\ÒT\nFù¢=\ïP†\Ã\ê\ôt¨CR{\Õœ\Ô\à¦O¥B\0\'\Ü…8²3“SÑ‡\Ù|b\ñµ\è,7¤m\ÒR\æ\'\â&º•`´\Ö~Tw=qJNCÀ\÷»¢c—H\È\r¤\ô\ÏAı~ÕŠ\× \Ö=\Û5­¢…\Êx\ó?)jqKWd˜úœŸ¦)\ğQ\ÛNh¸\ï\É3Ÿkœ¨\óaÛ°®[\Édih\í|V\"\öK«„D¤+M\Î[:©¿i¿ËV\Å?\n\Åİš:‹X	Á\÷4\Ï\Æ\r\Ú\\`$%C\Û9¡Î³*bCPYS.\"Ò±ˆ9«\Öø°6vB®>\é\éû\ê\î %¹	ù\ÂF\Å@\õ®\Ï\n\í\ÇG\äh\á=†<\0\â\Ì\î\Zk.£†\òš_• $\ã=\÷¨§\×\äieË¢\Ñ\Z²³Ó®°K¬Hm+\'¦@#\ó˜\èP&¡›µ\ì\Îj„Ù¢Z¡p$…mœqÚ¡×‹:\ö&‰\Ò\÷´§\0n;j\ä|«  w9;\\P¬‘˜¢«uÆ®—©ow;¬\÷KÒ¥ºT¥¨\îs\Ğ`1J{‡C]y”¹’`,€ã„@_\È\Ó® lfŒ“)\Ğ\Ò2””€\É\0?*–= ”\Çl–\Ü*µ›m­T|\ê\0c±µpBNR\Ñ\èş>§\ì}-\ß%\0\×¯®VÆ¦ù1E­d0}{\ÖÒ´#0[£‘Œ\äzÓª 6\Î$¨\ädoŒP&‚.„µ\ñ\á\å\à\ìOjM\íodv\ñ\r§\ËIÉ\ó3•\ãŞ·ş>£G\ä\ë\å\r‘H­k¶\Ìh\0yT==q]?¥³\ÓKeœÿ\0¾);y\ÑH³\ÌuJTGt’:$‚¤ıv\ÈûZ$@ÈšR	9=\ê\ìª:\'¥`¾jG\'¶*…Â»¬¡#Š\È\Ç*I\Ød\ì?\ïµa½[ &‹Ñ9@T(§.­Ô±°lœûŸjVoc5­\î\ë4%+\Æ\é	ß©=ÿ\0/Ş±\ZLM)%\åI’J	i?R@8ü…0—b²}ºe1¹2K‰m”\ÈJT\âº`nO\éA¹t5‰/±#-œV6˜\èj\Éevâ”\õ]I\0Ÿ\\\r\ñ\\\Ë\Â\æş\Ç_şBQ’6OWE/\à7¤[Fw>‡=\r^X0‚ù7\Ø\ïin$B¿!¼¶\é)\'q\÷¡*´0®ùgK¨¸¸«Ë—†LFš´C\'3)Â¶\õ<\İw¢¨ \Òi.„Ö¥\ã%¶Êµ! \Èq@ò„‰ÿ\0½\ê\ğ¡\ÈF\ìµ_¡/±>Ú \Ñ;9\ó”û‘Ö‰,\ö-\ö\ß`-s2ß©t5\Í\ÈO¦Lw£,‚“ºUƒ±Š\å\\\Æo¶6V\ÑtT\ÒÜ©\rIÀ=\ñ]D^\âqMkh•^x€\æ“\â,»Z×ˆ\Ò´@!i9ûd\Z¼\Í\Çm”%DiÔœ…¤}v£0\0\Ğs½Bl\Ø\Ô,ux4%\ØV7\ÜV\Õ	\ÓZrD®t‡[B”‚zt\í’~\Ô)½Š*›Šz‘\İA©§KqDb”\çbFOşş\ô\r¡±\Ôs>¶{\òü\ÇúQE$\Äã·‡S¦\æ8¢½»\Ğı³úQ7 im	\ô332g’#3•¨~#§ş\÷­vMº\éœ*7\Ø\ì3\Å\ë6Ÿ‹-1bºûS—D(şr‘¶TI#$\r\ÎkTª¾\Ç\ì\ÜJ\êj]£š5s\Z\æ™p£\ÊhFm.8\ëŒ ¡D„•©„\ä‚7\Æ;Ó¿ù§\öb«&›HY\ğ²[\ò\î\êˆ\ê<§Òy‡pw\àúÖ“2\ïˆ\İc\Ñ\óúk\í\ÏÈ³\Ë\\„”„¿ˆ{R˜ù.\Æ\'Ô†.\ét†—”¹n1\n8\ß\Ì{ ık?Ñ¥—\Ç\È7²\ßt\ÅÅ¢\Ìg\àO |É´•|g5%+QXªg\è~Ñ2Ã·;/*q²—\Úlü®¤‚3™\Õ\áj”´Rt8\ì„0%.\ßvs#”¶\áI\öÜŒV\ò?\ÎU\õ6˜\í\ğ\ÃQÿ\0(\Ö\Ö‚\rbBYZ\Î\à!G#\ïYF$]7	¯‰¾\ğş\Ç1\'>dV\òû\0Ï¾A¦#Ø¬…ªjÉƒj†P	\õlw¡.ƒ‘\Å\ö­şWc0‚\\\å\nJN\É9\ì6\"–°4\n\â\Ô\óƒ\ó@\Îsd€ŸÚªBU)Å g\'§§J*@\å\ØL[S*\î\ÃJyÕ„¤z\×\ò…d¸\öˆs–‰¯¡¸bË¶(\í¼\Ğ\æS`”ØŠ\å22—\Èw8˜šˆ&Wa\ÚÛ’†`4\Z}%¥°R“\ÙC¡û\Ğ!œ\Ó–š\ôr\Ó\Z8it\ØVˆ\Â\İ\ZXÿ\0\ä5\ä\ão˜\÷Ø©\÷\äø¡\ñK—¡I\Ã\İ.ˆSü\ğ€’)`\Ø\ØÂ¹œ¬‡’ÎŒeJ\õŒ6	kb\İ>\ô|Xªı‰\ä.LluFŒE\ÛM\\íŠŒ€\'”©\ÙA°^B’A*\ì:WSFZ‚9»\ğ•‚^\Ï\ÃM\Ü-„¦|\é!\ï\æ\ò\É2Y(HlŒc\ï\ó½Y±œ<8º7LÍƒiøI\Ò>$”\à¹\Ê1\õ mš\Õ\Ê\Ä\åÑµø¸Ç²qb\Ât§o\ğHm2Ö¤ú`œŞº\Ê_*Q\ÅeG\Ì\óM\ÜJ\Æ\Ê\n\ï¸;Q\Ze\Êx2Õª\Ô|%„Ó«Jß†¢Ê¹N~Ry’~\áCj4¤HT+`j\ÅNÃ¥B’U€OÚ„\ÆtAW‡c\ßX`+•¥\Ç\n\È\õC­- \ğ!\rÁÂ¹‚®nD•z‘ÿ\0ª\Év#\ïr‹o)@\ä¨b­°b“‚\ğU3ˆ¶p\ğ%¢¢#\Ğdşt®WT¶?\ãû\ÉH°\İ<\Â\"²\Ù8À¾Â¼ú\Í\ÊM¡£¤ƒ¹Ka\Ü@8\ïG…%]?±\'x™,\Æh^^Á\ë\êh9\èµs\äı‡ºR\"\Ê\ŞZ))Kdn+\\;dš\0jf\ÖÀR\Ê\Å8\ìkiÁµĞ• %™˜\×&P\n’²6 \õû\Ó‹h”?a\Út\ÄD€¢\ÊA\õI\ëX\â\Ó-º\Ù\ÍP[a%)\"­bwi»\â™\ö•\Æ\ë\Ól’T\ÒÒ—?ı`\Æ+²\Æÿ\0Z8\ß\ö1iuA\õ$#a\ß\íL6\"»-Gøvß¹t±ˆµæ¤€s\İ$€?CF€“y¥s$zbŠî‚¡‰‹\ål’v\Ï\åK±‚øÿ\0³¬ÀwF@‘@\÷8\ÇëŸ¥.\ÃD‚q]2\×)gªS\Ê=·ş\Õr\í‰\õGjD‡¼\åe)V	s\éP ¦\áş C\\F°²\Ø	Jdr\í¶ARùŸlv‡¼s\ÖBd\ä\"2NHÚ¸µ´zZ³Zf³5¿\r—W€O*sÔŸAOWÉ­±k7&³d–®\r?\É,|\É\'p=ˆ\ô­u\ÖFR\Ó®- %ŸZ_-W®YK\È<¬$‚ƒ\÷;æ¦ª\ß\â\Û%\êA•\ßZ\Ü\îÒ›RBĞ£\óTB³\ëÓ§µ55{\ç-\ê>€Iz]­\Ñ+PQSˆH9Á\î|zP\ã\öaœ¿±yjÖ¬Í„\Ú\Ò\êU¶\Ø=h\ÒzFRL\ÙW1%J\Æ2¯SB_’t—V\'\Ze\õl…/˜“ß’N1úb»*y\öCİŒOYA33Œ\äD¼Qd_\Ã\î[\é\Ó\ñ¾`s¤2”¿(	^>\ÅYû\Ñ\ëb,\"Á\ÖÂ‡CD(GMª\"¸aH)\'c¹ß°¥\Æ\Ñ\ã_O‹\ï	\'8ˆøNpV·‘4¼\ÃD¬;[‚;sy\ğ2¬S¹c-	»’\Ô\Üu¬\r‹ œ»Š„H\rg»%\Ô\Ö\ÙÛ¤1!+Vİ³C±rƒC4X«±2{é«£\Úa\ô¶_BT’ÛŠâ®†¦\Ñ\è\ö+ ™¾²¶\İc¥¹–\à\Ë\ï4Ÿ\ò\Úxƒ\ëœw\é½\Z¾)i˜³›\Ä\Ñ\î\ëY\Ò$[\ã>—PÉŠ)%G\0‚sS\ïT–-\Ûa!;\"¿Xµ \õ«24ø–‚\ád-µ¡[ƒPFı\r5]\n?ˆ+2*Ö¤¸h\İ[	×–\íŒB(\å*\ó”1ÀÁ\É\ÎM0éŒ¿ º¦µªµ…ûNN\\\n,\Ùi%>S+$’2v\ïE…\n+b\ó±±I£\í\Òİ†Ü™(<\êB\İi\'!*$\÷úcjF\ÎŞ‚Ô¥!Z©,Z`ÉŸ!À\Üh\Í)\×Q\Ø% ’~À\Z¬#¹ w\Ëø\ÙY:¾\äŞ¤Õ—Û´fƒ,M–\ô–\Ú\Îyµ’O±®Ê¸\ê(\á-{›2\Â\È\nB\ö<\ÃLU¤Q2\É?‡µ¡\Ãey\òÚ’u\Ç2FŠù\0>\ç	;û\Ñ\ëc\'„7@$€z\ï\ïEh\na¨ Š¡q;=hKkZ\äœ\0)w\õD.\ñ‰\Æ\è»D\ËLg’\ä\é\r–P\ßP\Ój.r3\î)y>A\Ò+½ùá¢°Fˆ>¹5tF\ÍT\ÒfC”‚:v=j2&ÊŠ]i\Ü©£‘‘±qû\Õ[\ã\Ñe\ö\ì‘\\\Ö\æ\çf§\å~6Í¨Ài2\èÿ\0¤t\Ø\\I\rj»‹ƒ\r¡á•£bS\\ü\÷ Œ€·;s\öùbm½E·’y ı­\r>CÑ·^Ã?\ÆI\Ö\è\Â,ÏmHq+	i\ì r o½n\è‚Ğ½\ßŸ’8j½~ş²q~[/—œ*\\‡Â€Á\Û\Ô\ì^q[)aRş4\ÓzB4U*Køu\å\r\ÖGA\è?­)9rb\ò³aü6P[C\0•nz`P¥-\å¢?ø\Ç\â\Ó:CG\r!mt\Ù²\nN\ì\Æ\Îù\Çu\ì\rm\ğ±Ü¿‘š,ü¤¾ˆ‡VIŒ±n“\ç¶\\uÁÊ•g`q]\Zg2\n\Óo8†€ù\É=»U$¶\Ë\'¤\\×„\ÍÂ<¥ ¦\\¸\éøQ\ÉN@\'ĞÛ·JrHBol}[\ÂpÛ±ıªÌ¬Cvÿ\0\ra+«ˆ\Ş<\æLÓŠ·AC\rKy!+”\ÒIX\è\'$ú\ô\ßlÖºR\äl”tDa©\ÕWº\÷œ’µ•¸\É%]\É\'|ş\ÕT´\\C\ßP@R†\0€±«\"\ZY§6 ^$»!C“›°\è?\æ£0!¤å’\æ$\õ&†\Ö\ŞË¯ª\Ñ\×M__\ÑZŠ-À(ˆ\Î\áÀ\ç¬N?\"\Ğz¦\ê{%\æ\Õ\ì\Ü#3!\n\nBÀ\'¥s4\è\ìq\îS\Ğ\ç\Û[MÅ”\ò8;³Z7.\İ$šÁ\ì>e¡+=‰§\é¶Zeq~\Î\áv¡Ÿ\ôÒ€“‘Es“\â\ã\èê²–J\Ô\0 ¬DVzLC\ñ‰\Ñ8q¥\ç]\ßi\ÉKH\åf;)%N¸\nF:\õ=€5±¢•š\ì›øD®m]«n:\ïP\Üo7W\Ôü\én\ó«=:\Ø€µtĞ‡Â¸…³w>g\"Ÿ‡ˆ•‚S€œt\ë½Y.\ôQc¹\áKAÿ\0\ä.1\Ø-\ïµ\æBK¡ù$Œ€\Ú$Ÿm±\÷¢Em”›\Ò.¢\ËYZhsE\å\n#ı˜$\Ô\Ó\Ú\Ò5û\Û\à\ÉnZü\ä­*hTœ\ã#®qCa\"\Z6ú\0#\'Ş°‹”b½·\Å\ÉZ°\ê›)Cy	=G¾;û\ÒF\Å0$ıI\æ¸H*)|œ•s@\â\ZcŸkùB\É\É\0ú\Õ\Ğ0ı4¸ª!$t\è0†\Ğmo…-i\å	\æ\ë\Ü\ïUFy\÷[“2Š\ã\à\È8>‡5tQ±m\Ân%;§\ÜùªQˆH\ò\İ\É<\ÇÚ¾H\Úb\ä´\ÉC¡xŒ\ÒJ\Z[©f\Ô\ËÆ¹»°\ÛgYNdt;µrŒ0H=~•H\Õ(–DY\ŞF¦mm‘„Ê¥ƒ/–\"J}ø\Êx¡œ¬oŒ¿Úˆ  -\Í\ÎCY\ÇI	¤\óy¥­Xg9¾;V\ã\ÆØ•š+[q\èn,ü\Ç].»Œ+SV\í@\Ü\"¨Kˆ¤¶‰¾P … î¥œ\Ì0s\ë]|«ù¡\ÉlluÏ‹gt5\åµ2\Ü\Ëd\Èh.Ê¤°¦À9\0Œ\ÇŞµ²ªP\\†\ãb”¸×†{¤N\ñ\Ö\Ò]!˜2Áajsl%`dúqU‹\Óì´–\ÑlÖ†\ãI„Ü†ˆuµ\0´…(”\ô\ì3Šy.HAıX£ŒP€GL½E\Ó6–\÷ÀúUt_g\Ï¨ñŸ‚¤„º;k\Î\ÊO|\ZC{H*L‡@\Î	V2z\Ö4a°WÇ©	\æ $\ä\0{ÿ\0\ÜU?e‘\ß\ãÉ•%\ÒA\õÿ\0š\"#İ\ìg\Ò\'\á\ÎzŠ…N\ÅK\É\Ø\Ô#Zq„‰L¨€AÜ¤\ô>µ‰¾ƒU\ì}´¶“ø\è\È\\9*c`¯/¨û\éZ«$¶n«„š\ès,¶\rC´O\ó\Ğ\ã\ó¥\å(±¥	\nXºn\âú’&\Ë%8ü)Ú–v\Æ#1ªA\ë6\ö`0‘‚zœ\îM&\æ\ä\Ça5|\\–Ô¨¶°\n\Zh«\õ$Nb\'\ífµ%\Ø\ê\ğoG\"\ÍÁ\Íu…fˆ·\ã€\ã\ï\È{+XZ\ÉÀ\0| ga^‹‡&«\â\Î*+Ÿ$k\\m\Ú\É\×e²¡b|\Æ\ŞÜ‚ ¬Cx!X \õ\Æ{û·\õš\âĞ®š—$F?\ZvÙ¥o±\çÁ˜—a:|æ¦¶Ò›H\'~Lc\0½²¥È¯ƒ\è\Ø\Ó.K²CøP\ñ\Å\Ò\Ò4î¢’\ÓR\Û)n+\î+‘/\'Á\' }¡Wk]2¶W\Ù3-\Ú\Î#°Dl¥I\n\0\çn\Ø\ÎGM\é¦!3#\Ä\ïl\ÓdB¼\ßÚµJiX,\ËJO¸\Øf„\Ù}‹9”-Ci\äHùR‘º}‡z\×\è#SD¨\Ì:$\ìA«\"¬;²Y“)j#®ø5S1\ô–e:\ŞK`\0\'|ıª\È\Êge²•+!|\é\Æ@\Æû\Õ6`\ç€e†×Œg#=\ê\Û0+`\Ç!`´0y€\Ï\éCœ†*D\àøD\æX\Ï6O~˜5§É‘\Ğ\â±û´ÃŒ¤•‰=\Íie6ª‚¿$\ã\'=0)w`d’\÷‰A†z+oE„y\ôM\ér;nƒ¸\ñOUˆe\ágl\óJ”r\Ø<\Ë\å\õ\èF\Ã5\ÔøüYZ\ÔZ\è\æ3\ò£\r´J­£l‡–\ÈPTh\È\ó\'HSd\ó†p”ÿ\0¸\í\ô½š\ãL\Ò×£‚¶r·½û3PE\ÔI´\Ûn.)S½<†[Nr”1œ@68\ÜÑ¥\Ãr‚^\ÅOjÙ®­°[\ïú\òE†Fš„ *\Ú\ÚÜ‹(„6H$\ò0z\×\ËRc\Ğm1¥™\á?C\ê+D\Ë\Ì{\Z¬MG|´\à³\\“€BV\nz\öÀ\ëH\Ï\Z2—°\ñ»H\Ú8Ÿ ¥°t¯¤Æ¶©)S-\ÜP¢\àOqå§*=F=À¤\İS]o\Ğw8iµ†n6qNh›v\×qC‘…µi§\ğA\ëÒ‡©ÿ\0d”\âWº\Û!`£Ÿ\ëÖ’\ZØ›¸¶yhüXÀ¬Š\è<°\Í\\hn„\î03\Ó5S+\ĞQ|N$-yù²jÈ§\ì\Ö\İ-Ju¦”9’•mŸCÚ¨Z\"-¥™Œ£—b­£,>µ\Å	SI\É$,Œı\é{$?BL¸B\Ï\Ã%\ğ…È³¦Õ§¾GC¡\ôµ¼®N¸Ûµi\ì6	\ä>¯ ş´\ØT„|—¹S„ù±á¶—T\ÆpÊ¹BI\ì7\í\ôÛ­t¾7O³IŸ•*c\Â#\å£‹Bn0\â´\ÛN\ÏTX’”\áM¶° €6HÁÀ\êrk\Ñ1i…o\ê=È²S}±ck\Ò0§;¬!\å\Æ\ßÃµä¬§•	·\Üı\Í7;(°Áv‚\ÈZmm\ğ\ê\Ô\ãW)ir´”yŠ%_67ú\Ğ\ß6\ÃpZ\Ğ6‚5Ë—G.I\å&\Ş\Ò\â\Æ\'û:gs½kø\ÓE\Ó\ì)·\éûR4>¢l\Ã\ØHY\Â)~\ã½e©|‘\ì¯\è6½i\ö!\Ù\ôS±ß’Ã®8Œ­/± ¹ \ïsš¥¤\Ş\õ½\ß@ß¥[c8Ì¸jBi/5…5œ\å9q¶\ÛmJ\ÇN(¼¢ÿ\Ù',0.000,NULL,'2023-01-02','2025-03-02',NULL,1,'2025-03-04 11:09:02','2025-03-04 11:09:02',0,0,137),(2010,'Kalyani Vedam',2005,NULL,_binary 'GIF89aI_\÷\0\0\0\0\0\0\03\0\0f\0\0™\0\0\Ì\0\0ÿ\0+\0\0+3\0+f\0+™\0+\Ì\0+ÿ\0U\0\0U3\0Uf\0U™\0U\Ì\0Uÿ\0€\0\0€3\0€f\0€™\0€\Ì\0€ÿ\0ª\0\0ª3\0ªf\0ª™\0ª\Ì\0ªÿ\0\Õ\0\0\Õ3\0\Õf\0Õ™\0\Õ\Ì\0\Õÿ\0ÿ\0\0ÿ3\0ÿf\0ÿ™\0ÿ\Ì\0ÿÿ3\0\03\033\0f3\0™3\0\Ì3\0ÿ3+\03+33+f3+™3+\Ì3+ÿ3U\03U33Uf3U™3U\Ì3Uÿ3€\03€33€f3€™3€\Ì3€ÿ3ª\03ª33ªf3ª™3ª\Ì3ªÿ3\Õ\03\Õ33\Õf3Õ™3\Õ\Ì3\Õÿ3ÿ\03ÿ33ÿf3ÿ™3ÿ\Ì3ÿÿf\0\0f\03f\0ff\0™f\0\Ìf\0ÿf+\0f+3f+ff+™f+\Ìf+ÿfU\0fU3fUffU™fU\ÌfUÿf€\0f€3f€ff€™f€\Ìf€ÿfª\0fª3fªffª™fª\Ìfªÿf\Õ\0f\Õ3f\ÕffÕ™f\Õ\Ìf\Õÿfÿ\0fÿ3fÿffÿ™fÿ\Ìfÿÿ™\0\0™\03™\0f™\0™™\0Ì™\0ÿ™+\0™+3™+f™+™™+Ì™+ÿ™U\0™U3™Uf™U™™UÌ™Uÿ™€\0™€3™€f™€™™€Ì™€ÿ™ª\0™ª3™ªf™ª™™ªÌ™ªÿ™\Õ\0™\Õ3™\Õf™Õ™™\ÕÌ™\Õÿ™ÿ\0™ÿ3™ÿf™ÿ™™ÿÌ™ÿÿ\Ì\0\0\Ì\03\Ì\0f\Ì\0™\Ì\0\Ì\Ì\0ÿ\Ì+\0\Ì+3\Ì+f\Ì+™\Ì+\Ì\Ì+ÿ\ÌU\0\ÌU3\ÌUf\ÌU™\ÌU\Ì\ÌUÿÌ€\0Ì€3Ì€fÌ€™Ì€\ÌÌ€ÿÌª\0Ìª3ÌªfÌª™Ìª\ÌÌªÿ\Ì\Õ\0\Ì\Õ3\Ì\Õf\ÌÕ™\Ì\Õ\Ì\Ì\Õÿ\Ìÿ\0\Ìÿ3\Ìÿf\Ìÿ™\Ìÿ\Ì\Ìÿÿÿ\0\0ÿ\03ÿ\0fÿ\0™ÿ\0\Ìÿ\0ÿÿ+\0ÿ+3ÿ+fÿ+™ÿ+\Ìÿ+ÿÿU\0ÿU3ÿUfÿU™ÿU\ÌÿUÿÿ€\0ÿ€3ÿ€fÿ€™ÿ€\Ìÿ€ÿÿª\0ÿª3ÿªfÿª™ÿª\Ìÿªÿÿ\Õ\0ÿ\Õ3ÿ\ÕfÿÕ™ÿ\Õ\Ìÿ\Õÿÿÿ\0ÿÿ3ÿÿfÿÿ™ÿÿ\Ìÿÿÿ\0\0\0\0\0\0\0\0\0\0\0\0!ù\0\0ü\0,\0\0\0\0I_\0ÿ\0\÷	H° Áƒ*\\È°¡Ã‡#JœH±¢Å‹3j\ÜÈ±£Ç CŠI²¤É“(Sª\\É²¥Ë—0cÊœI³¦Í›8s\ê\ÜÉ³§ÏŸ@ƒ\nJ´¨Ñ£H“*]Ê´©Ó§P£JJµªÕ«X³j\İÊµ«×¯`ÃŠK¶¬Ù³hÓª]Ë¶\íU}•¹1v\í†	s#_Mt/…»O®\\\ô”)#–)€0 C>°r\0*bd\"^\çÃ‚C\ë\Ì&FŒÌ¦K›\î{£\ô\r\0\0Dm rŒ¾0\"\ß\ØrC_¿½‡Mœd=h\õ+&mZ²\äÌ‘U\Øvù±\ó\Ë\ÓM\ës·\ïŠŞ™†ÿ\ÔG¸¸yŠúÄ´¦^Zu_\Éš7Ÿş€Ç¹\Ç\×ı>†z×¹ù%\Æp\ÊH\"†ix\rsŞ‚\r)Ó˜d\ïeg\Zo\ÚU`u©Í§!t+\Ø&\İm~\Éa\è%_k{ù6\à2\å1È 2¾U\İj‚(\âm+\Ä&l«…±B|\Í\Å\'d…dvƒ\Í\õ\Å\Û]¥\Ív“Ü!‰$›¹¸ i{\áƒ\Ò\ív[5R\'Ù¦É¶\ÚlHx\ãmM®á¦\Í\È\æjbH\"•sÁ¸\Şi‘Y\ám3Bw€v@\ŞpC‡“¡Öœ\ntØŸsjz)ÛŒ‘™	bd{İ†©bx\æ)\"£\0	Y„\\šV\äJØ—0¤i\Ú}ºÁÿ—a_\ñ\İp™† Æ¦£cp\Î\öŠ®m^§lM\â%šÒµ\n™\ŞYJ}©\ö%¯\Í9\ç ^~)!¦7¨`Ÿ†¶Q\è$Š\Ü\í•	±jù†k\ğ!\nÛŒ7\Ä­vİ¦Ö—‘e\Î{*š˜º\ÊJfİ¡¥\îyZ™b¦#^uN‚ºfIÒ›–¹\rj#d\÷)\nÃ­\"\Æw „\÷^V\Z\0dª`±ÿf¶Ÿ«eZ\Ú\ælŒ)w’ A\Äb)\Ó_Œ§9ns?Æ†[‘µ]\ÌW«•5i\İmfú\ì\\f¥•šª™²€\Ú{\Â\'¯u‹³W0\ö¡n}2j2fûqYµÀa\æ\\„\'›©š™“mñ²‘ùX½£jy·oM\æ\È\èNR™	=_o%Iˆ}]f\õ¢\ê\ê\í·ºZ­\ö²q¬B½¶Á\ö\Øo¼:yZ™µ¹š][„8m\Û&K\×!~’M2Œ\Íw&•\Î!F\×9\İbzşX\Õ:V\ímÛ§\r¼—DO˜$µzh\Ùlaxk\Ûnz*£dV+\Û\r’h\òÿ°\íTe’:¸k‚ûÚªı}Àoi\ß$ÿ8ˆª]X7~·NÏ§s¥e&l?2\Û\Ï<wƒd8L\à»İp3¸QL{Ë“ûc2Ëµno\óù“:‡¨\ê,kƒ\â‘\è>U¤Ì½2\ÒRÁ\nÄŒ%°)™8lR›2\ãƒ—R¤Ç¼Î„¿sœ™6§ªÙ†K}z\Ú}¶Ô³«\ïq³IVu¬&<X}‡7;\Zj\÷B¡(£=Œ\Ê>\Ä;\Ë\Ä)\0À\ÓÏ<·¥\0mxÖ‰\"—\0µ\Ñ\İ\è]\0\Ô\Z¶ «\İ\é*G–›Ÿs,$\Ê]4Š2&›\ìH/t[¥>\Æfx\ñ± \éÿ1\ŞÕ­‘ı\É\Ío°\òCÃ³+É¨šmK¨‘M&&DenøI¢\ç2sIµQ±]\é\ÓU£ŠwŸ\ìı\Î[i²\á~8\ÛÀ®’­ú¤¬‡9éœcs«\Ñ^\çL\ëd\r^³\åO\Ò\ğ2•Aæ‘°¬T¥„¨ ÁQ6\É\ì\äd\ZyI§S6x‹¢vtÃ¡XÅ’Š\Ê\ê\Ğ#§J³!6\0Ã”n&ÎĞ£~¡+\ŞÕ¨\Î\öE¦„m³Ú *e¶N}\Ø\Ë\r3W‰\ì‘oF;[‡\ŞØ¨I	Ì¤\éû_\ñ\ÄÅ†\ÖD\Ä#^LKE·*Z\Ï>ˆš”G×­7¦)U´Z\çU·§5\ÏB\ÏQx\èÿ¿4n\rm­[\â%o@Œ\Øt\'™0\Ók(ø®S¹nc’\Ù\×\è\æµ,$®\rfÒ‹kšZY\ÒUª\óƒ‰ÂŒı\öI²RY³\éİ±d•\ÕKNQ3û\çWo\êÁj\İO¯\Z\Ñÿ\ĞfG\Õø¯x¨l§](\Ğ\ÈÁ\Ì]l+Y©3©!‰\ÊIrb—…ÜºC\Ç\0€8]\ìMXuw\ñGA³M¦4\nÁÁ@†k&vĞ¶ÁÜœ­Œ\óY#~\ÄxU¿\è\õVĞ©T\Õ\ç¶L]\ë‚\òr\í\rTSÙ®§G¤ZVh¤‘\ÉË„_p!\ÕNÛ€v­(„\èŸú–\éˆ«—9\Û/cÖµî§±±‘\ê€b\à]™\èC\Úl\ë\äÎ–Á¿ÿ\ê\ño{\Ô\İ¶`ƒ-$l³¡\ğ9OS4J\Å@^\Â\ğ‡S[\÷eM4b\ë|f¹W\ñR:—\á\ïO+µ]\08&h\0€$k(\İqL:jQ#”X.±’3Ub0\Ä`Zh¦\î\ö¢\ñEy/%®\ğ“™<a-[Èˆ\Ğ¬@Õ™W…U‡}\Ë\n\Ã\"o\ìe*šCj\äFsªJYXŒ8#J<\áOx\Ë[X\Ä\ßn …0ø\ÙÁ6q‰[ca¿¤¼Q´’UQ\á\Ç\Ò\ë•v\ĞxJŸ\Æ\ÇN\Ñ`\ówy55\nÊ§T\Í\İ\è´\ğ=ÿ\r\Ë³p¡=\ä=º\Ä1€t“t\å-+9uNİ¯½›0DÿfsEªúæ—µ¼½*G®†A`Q£ä‹®\Ü[\Ï\é-$²,7ˆJ²‰-l\áE0\â\Ö{4\ñ­§tnX\Ã\ğ6\ö«‡¼]C¹\ÑJCŸ-\ä.£¶u—\Î\åuJ_r/Šµ\öHXe¹\Çxªn\æş˜\ì\îZcy\äƒ¹!‰ELiJ‹´‰#¬DYÑŒÀÄ}3\éBKú\ÕOn\æcdª`_ª¸T\Í\Ä-`V…—dòª¦VŠÎ\Æ	H˜2±¾a\íq/B!×¸Æ§\Äw\\\êH†\ò“\÷¨\ä§sœ‘p\õ¯±œ\ñ\È4zY¥\rª\ï,¨«^¥	vƒÕ€&\á\ó‘„5UpÜ‘Y\Éü2aGz\Â%ÿ6\÷%qnG]\Ğ!¯ú.$Áwü\Ösù^l-u©#~/…\à\ó°û\å+\äÁX€•½\Æ\ë¾\Ç\0Õ®;H\Ä\ğ¸%2h\çÑ‡X\á\Ãz`À2\Ç%!I(”…9\Ø;NüH„\ñ‚u\àox¨[\Ş\òP;×\íAà½‹Ó W\åvU¹h\Ú,\áª\×È³+û\ne’¸\ÚI\İ\æNNnsa/Œ¯:\ğÿø\ãK¢¾\ñ\ß\är\ïE\ğ\Z\×|\íy#iM2FJ5sE\ó;\ö!9\â\å*?\0\ïAø\Ğ]\á7b =\î”&®¢T¤”†–\ğVa&g{\æ\öqU\çq¼\Ğx\Çv\Ç	¶	\÷\÷ÿx\Z§N‡|\æ\æq\Ãv4\Èx½wn7a\ä¶uz\õHšRU\å9L\Ø4\ì\Ãl\á@¸°dTC~\\frE\íA„d7u„rŒ\'†>x|§x-(	û—ƒ/\èq‹v¼v»pn\ñ\'|\×dQbQ6˜v[CO“\óK°c}©¡66…¡\ÜD&jµ-vb%fr&wq\'„*HuièƒŒŠ·µp| Hƒ‹·ú\Ç‹7‡a·ƒ0\Ø\í‡\"½‚=@\Äa”1H\'¼\Òv¥1U‚ˆ±³1z\ÑdV©¢5|1n†fa\íf‰,Ø‚¤\È\Â -\Èsø‰»‡\Ò|q¨†`·sXŒ·ÿxg(ƒ\â\Øq\Î7„±¶ z³‘_©R[\òvf¢6¾1	\Ê`\0¼x19°\ÑR…$‹b„\Z\í\ñj\ê†\ô·‰a\ò‡Œ UWy\ÕØ‚Õ¸\à\èŒÑ˜x¤	\Ì\Èx3¨Š\0om26MQŸ$+\Ê\"91f\İA‡xÁ*G\÷Q}\å8·AG\Æh\Z\Çq‘\0uTg@˜†i\è“gØ\ß”q8ƒh\ZÕˆ”\á|\Äwu“¶\Ôn0wyc9¯#8¢gf|Á’.I\ôPI\è6E\ÔX‘\ár\Å\ö{fu¼0\ÏØ‚½€yU·”Ñ¸”§(‘F9‡Ò¸‰uY‘¦H‡+ˆeH†bO…ÿ!\æ\äi•ƒ„€\åa…ay“ÀCaD“\Í$*3‚o´†xg@Šb8o9š\Ğ8—-ˆ’Ğ”\×‘3h\Ş8‘«Ù‚zÉ”œ¸‚›Xu„—q1G}ùc~;4IU910(I\0vBw“ù\Ñ g\ædt$@6\Ğ!ŠFn\÷tW\Â šuY—\ÑÁĞvÙµÀ”\İY{©‘ ©£(Œ@y²\Ö+\ë˜(·\ØLfz\÷Ó˜\ñ“0,\É\Ù I\ÕH¾µF]$(o“w‡,Hu\ÃÀ¢iš\à‘\Üi‘©x©\é\åÙ‚H©‘\è©xy—·\öa»Q{Ñ±%NbD\ÖX8s¢79}±Ÿı\É“`¢dr\ãD‚\â?fwŒ]wuIŠ\Ã\Ğ\ÃĞ£q\éŒ\æ@—Iİ‰	™¤»¡œx›„7d\"o\Ï\ñ\Â8‹q\Õ\'\÷\Ù}:-*€\Â\ñ¢\n‘c‘#‘T6\ñ\ô!Wfb`\à†QIƒ\ÎØ£\Î8—½Àz¡Izš\İù\ĞØ¤yZ¡\äY”S‚\ò•®eN†aÁ•RwPœ\ä?B\×6hD#\á‘zbja ­…RF\×9Š† G|¶o\é£\ìÀ©\Z\æP¤GÊ—\ÒØ§Jzš\æY¤yÊ”I¨Û¨†1rr¤0­s¦l£&#l$	“ ±ÿ•©QT©4$7\æÿ\ç{)¸˜0—p\Ù>:š\Z\å\ğ­M:«Â€µª¤Dú­	¹‰˜Š¦‡1\ç^Ä–R5¨\Ö7%„Aap©\Ìz\ÔH£Sø(Ç–qaP ¨†	™\í\ğŒ\Âp§§9¤Bú B\Z¡ßª‘\çj‘{¹§yix¾\'v\æd`„G\Ş6<ùF$z}mx†©ıZ2·6Z%qQªÿ\'©x›¼`š¡\ÜI—©\Z‘I\nD{¡®Z®J\Ê{\ñG¤\ìæ†°¶G!j‹R\å8<rt	\Â$‚.\ô²£V¸w*¥O\\\'x:\èƒ\ò\÷Œ\Új§\ê*±¼À¶F[«ùL\Z›\êÿúªŒ7¦	v\Z\ç|J&¢ƒG§!c\ìcP—\ô€f\0[\Â^Åµ\ñ\ZµCğ¤¥½¥t:¸b\Ú§I´‹\ì¡sk”°Šzz¤¢	r|ûj~ûAIUz´xµ´HGVh\à²ıJA@MqtYjjy¶6€bˆ\Ğ(š®Ú°wŠ­:®|	¨Bû—\Î·±J±\é*š\Ãx¾iP[<\ÆS\ĞF2¼Tƒ\Ûv\Ğ¸Ë¬g¦2\Üd!zE¹ÿ\ç†\ÆG|³ª-¸ªÑ˜ªHjFk{\ßÈ‰\ĞøÛ¹³\éÊ®…\çnU–£CEú\ÑZ¿SL6g…¥²µ\\\ëft´MµÑ›¼\Äuÿ¶|;(|y›œKšLi±¼0·Ê¿ÿ‹´³úª˜«§jø±·\'-:\ÔK*€¸\÷\Ó3°1©5”]û*™.iˆ°\"I´aK\Ö|!W†5(\Ã\ÆÛ¿´	›:·¡{«\æ)«Ù‚×«§]Lx;)r·gdy\ÓMfªc\÷Ó¨h…¡\Â\à\'¦¬gP\Ò\ó<û\Ãu·|\õ×Œ¬¹®º—U,‘¤º-½zºxµ\ğ¿yzÀ^Lšc¥gafGY4\Ä}\ôH8ÁV\ÓRø²m<T\Ó/\Íd°bh‡5ØŒu›L\é”z‰”\ç	«´ª¤\Z\Zû+\Ë\àY´Ug¹b\\.\ö%Ml¤ATk¸*»%¬wÁD-¦\"¬ÿv˜›ƒ\çƒ>¹x¨)Õ¸¡x¹»¡¹+œ±\æ	¨±	º\Øk‘½À®Nû…š\'bƒøJ±øœ\÷‘I¡\ç[\ô²†HGV\Øy_R\ZNVhÈ—Šû\×xW\Ë@\È\äùšCiŠKZ¡\ßI¡\ĞÜ[›\òµYÀ4\èqa\\€€-\õSV\Şr+Bµ\Ïù8¨+%²É™\ZV¦G“¨1>šŠÛ˜³zÌ±EÊ‰Õ¸2xêš®)Í±ù¼\ç*½CK\Ë\Ğ(	Hix·–y‘x\"†(\åFŸ\'L-s\É2p/+	}4(ŸŠB\Ô	u8\Û\ÄML\ÓO¼´\0Í—\ã)­¹—\ãË¯\Éx\é\r)Ô±Ë©À§ÿ[uÏœ½Ì‡À¡¨\òùp\ğ*<b^OH©‹Ë¬8 •ùQ~¸i¹ŠPgnrØ¡µ\ì\ÂN\ê¿\ÖØ¦Xƒ*l\Ğ;Í—\Z\n›‹Ğšx‰—\ñ‡	Î¨6¸Ì®\Ö~e¼R55Ã¢²¢ş/\É3Ÿ«dl\äÆ“]=¿wŠ£-Ã§{®ã™‘®)†¨/m:H‰»`\Ü\Zy\ÙlütQ7yº0£vks^{\ó„ bÿ\Â\ÉyLn\ó!\ñ&|S\÷†\æM¤«5¸—‰\Ù5]¡z	¨™MÙ†\ìq‡|\Óp¨‘\Øšü—y\ÆxŒnƒ,®•Q\ÙHÁ\Ü//|m²©Ñ™:	ƒƒ™Ü‰ÿü­éŠ†v\é”\ÛĞ¶®©³‰øG‘`ÇŒO¹®ir”w‡™\òg\ğEFxd)AŞ•\Ãƒ©\ÕT’!u~\á†]ı†Üˆ½DK§Eû\á£Û)|¼P\â\Õ]›\Ó\Ú*\ß3­”HY¡©	v3h¹\Ï\'r`\ğ\Z”E£&Djk\'L RŞ¹+¾\Â5\ğf\äaw\âH\È\âú;š\ö+\ß1ÀÀ-ºük\ÊG)‡ÿ¬\ÍR.\ÍH\àşì¦Œıt±FC¨Q¢™S5®²mœ¾\ÉI5\ÓMhtÈ‚	Š\Ê\ÌÅ¦\î³\0\Ğ\Ï;º½”\Z	İ¦(Ğ‹W\â\ßhĞ›8ƒc\è\Ø;¼G½A3\âÀM\ØR²›#RÍ¬\ôÿ A3Gb\\\Æ\0®°\í\Í^´Cj\Ë{®¤+\ìª´°JŠˆ^\åJz\ÙaŞ†\êa\×3[¸%ds\ìs­A\Äh\Òh|{bd\á¢\Ö\Â=§\÷«ªø.±\\¤¶<Å•Í+,¨Ös¨†Y|\ç6zU`¯\ØW«\î~¬‚9U\"*PnS2\ë\â(\â\Ø[‘PJ\ËQL¤\êÊ´\Ü\ï\Ön\İ\ÌK®µ®QN|X€•=84V\İDO\ãÀ…kP\Z¯z‡b\Øt<x4\ï\ïh(\×zğ¨¬®?¤²\Ş\ò\Ğû\Ós\r\ãO”K\Éq\×L\ó©hnŠV{\Z\"ˆ-ƒ\é\Ze+on¢;¢\ÏÄ‡\ZÚ¡ÿ\é†\ni¶p\Ê\è¼\Ã»”*Î§v‰—+\íL\ï\á\ØÎ¿\n»‚B\ØØš5P{D\ô\Äv¯#>\Ò\"ı™Q74:H\ï\ÏP™†\Ñ\íƒ0\è\Ø_w\ËTÇ®À\è\Ş\Ü\Âc\rÀ\×n\ê¯§L[¨0.\Ô4x6¿.\"b\ç-“X`{\ó\ã/º©jo\ÇI\×@I\ìmy;\Èùš¨­\Ù\Ö\à(\×]¡9\Ã\è:\×\Ñ,\ÜÕ¿\ë–\Øn[ †f‹}\âN}4©˜£+A/ıZ\ØY\ÕAHï“¤È®Wq\Ãk\å\ê-­‹‡Ü—=\å^\Ö@\İÿ\0ÁK @I\r\ò*É $aw%\\qQI‹$E†Š1`x4 \0’%ÿM–TARÅb\ö½„S\æLš5m\ŞÄ™S\çN=}ş£\"d\0al	‰Q¤‹Ff‹©[`„\Ñ\âQdŒ©H‘†™±\"#‹‹xY¬ˆ°–¤]Nm)\İÅˆ—Âu\ë\n+ˆi`A§sı2¼»\÷-\Ù0„—’e\äFÖl$9@Ê“%c\à\óS\ófÎ=ş|\0Ñ¢¿2*hK\Ò[„‘¢n\óZ‹\r«Š·(\ö˜;k\Ô\Â+\ôV\ÒÚ³¼\Æ=.×¸İƒv\îbú08ß¶lù&œûv\ÑR‰’(F\å˜[(\É&\r\0Y9F1.A¿‡_ş|™[B\Ê\õFaIıû#,°¾º-+\òÿS!A‘„\n®xco1$\Ú8§Vcj»¹\ä*È¬Hû«-º²¡\ã\n\âË¸‚ªC¨¬\Â0Šh\Â06:°¨\0TÀ/½\É*;o4\Ñ4¡/H!‡$r¦\Ñ$\ëH*Š,Z\ë¡Z\È\nKF%¹:*Ta\é+Á:ì¡·„S\í!Y;5	\"\ÎDÿ\âE/\Ó\\«¥(|QŒ0DZ\Ê\ñ„ª\Ì$\ÊF€\"E4\ÑÎˆ\"j«¨ÈªH¹ \n‹,1\ám‹\n¿\ÉBJoA¶ UÉ¨Q*¡±Ò¢¬\í\ÒTQ;&;¼h°‡\äRh©a\r.Ã‹9ƒ0\ßf‰<üH´<’°l?EŸ…6Z™ˆQ)j…\ó’\ä¯?\é\ÈJÕ¢Ã¤\ôŠ+«j\Û\èJ‘&+7†¬´(\Õ7…˜$K‹\İ=C\î–\Z¸\ß\"\õUß²\"mM5„CÓ¥\Â\ğhV(\nT•-	\ÌÒÿ¶b‹‹T&2t‘C_„+K\ï0•\ğ\Ë-h»\í¶J\ái¬«¯¶3µE\äMp‹²‰\Ë_J#º“f¡…+\è\ßP»Pº±&\Ât,\r`¸\å!€‹&¹8k­\á\æa’D‹-]-\êVB³«’Š+ıºR7·:Z8nuo“\n\è‹\Ş\rƒ\n¨ª[<\'ú2pÁ¿$9R‹.\ä\Ùf¥\n³\Ê\ÚOı”\á©MºA4¶\Æ<\óŸ4\Ù($\",µS*X•\ô\na0¦Z¯u„o3\Ê\í¶a\óÒ·µ«\Âi06R\÷Š]\ò\Æ\Í\êw\Ş\0§9R\ëús‘0£pL\é<@OJI²•Z\Ò<{\ím\ncGG\Ñbÿª^±hWI-6¥M<\Z\ÛVÁª*:Š\İ\õJ\ÕY¢H\"Ú…ÂŠh&X@Rµ€°\ô2g#t{T„øã”‚-MO¤\Z‰PR2¨\è© \0`I\\n{\Ô1$qƒ\ê\æQşy/x¶?\ï\0)T	 º`Æ¥—Á\Ï#\ïKı\'\Ä\rJ\÷VT`h,Af‚\èJ•#®ÀEù\Ú\Îk<2™Qm4*©\\&@¸Å­)c’@ƒUĞµşŒ\è/hœTV7#«À¬mIX¹\nX›uiJIB…(t?=\Ş\Ï|otÙ‚ŠÂ ­\ï@G\ñ\ÊQ(‚¢¦\"¯+ay w¢ˆ†\\Ä¤´¼ˆ‰/ÿJ\"(£\ÙÛ¥V\Ã<§\ä*,R\"yvÃ›V…\\ID¤n¦\òšS¡J\"¹»¥oÎ†*&nH<â¹ª—\Äb\ê#:ûO‹˜Å©ˆ\ÆF¤TeVP(edÒšŠ’j¾H¬]¤))e³)\0Š$[\Ã@§¤\ØX —½\rm‹Á\ê¥(ş­~gs¡<\ÙG#—€<‚”`Q\Ş·6*-*\\\Z\Z£.†%bV4€bpMŠ‰aˆ\r#„1	„U+)H3Ë›.\"#\ÚQ‘\"CgJû#½N+Ã£\í\ê†\Ë\\FD\ó<%\ê\Îg \õi\ÅJP{d³v‚\å?dƒ’w\ÔP\ÇE“z8€AE¥\Z¤aÿ-{*`¶b\ä\æw‹Ş‹ü\Ó4V²\'uqS\Ø\ÉR6\ËS\ËUP)D†¸N$x›‚¹¹•Z),\àGŠ·@Ilq\ä2	n´#\ô\äZ™jd\ã3Œ¹Q„¥#Y\Ø\"KY\"\Ã\Ùuu<ŠwX:\Å	&±x›ª\Êú`£.´\å\î‡6]\â:Wºšo\\±\ã\ÓGrK…¹\Í(FY¼<B£¶\È`¼MC\'‡’€Y+`‰d¥ûI\Ìr˜²\Òd\öƒ´½Db-P¡t&#+\Ğ{\Ş;&^\ãX R­.,\ñ×€b[\ÛÕ­\îmT\ß0¹¾v¤x6\à¸N\ÅHH¡rŠŒ5IqD’DwºÿÖŒ$Ä›ìª 0r‹\áj[ «`W¨­3\äyÛ§6“¶*\óœP\ßøH!m˜l§…\Ê0\Åu+Œyg\Ê{\Çş@*Š\ò£\Ì\äJ89‰B\Ø\È=Y\Ä<	42\êE \ra\Êw¡\Â.y)©\\¡px><Á¡\ì\ÉJ\Ä+U\î\ô\Õ[\Ş\ò¦2QŞ§\Ûrá‡¿q\ô+Cz%£\÷‹Lh.\ëa-¹Á‘Z6-AEA\Z^ú\â(¥‚\\E3P†³¢*Şo v1\r.ºJS.ÿ˜*ˆA\í\ì\È\Ú\à¦Á3\\\Ä-é¶ƒ)„Mr2yLz\Ô\à‰\Ú\×3Q†© A0½¨‹ÿH\Í\ä¿\ğ€…AƒR’\ê–)q~J\ä¥U´°‚5\â²)jM£WC6_É§1U5\Ù\Ü[ª¬\ç*W\"X‚µˆ<z\õSÀ±[’¯A\ö\×ÿ~IUù†•\òr\ä?x\ç^TH)WF¥\Ã\ê,/º$ş91È‘µNSd‹+Äš†„¾sv‰­\rG—\n¶u°#f\ì«HS‰\Ù\ÇÒ¦^I\àP7\à\0oZµŠ\ğ¢\ãiH\Ç—\Æ\êi‘\Şaµ\÷>G\ë\ò3¼\Äå–®|.Œ\ïo*\ëb7n¤©şª£ _SVY!2\í_–:b\ÌM’\ê^\ß\Ü\×J•M«t¶<y\ê\0\Zša^…\Z\ï\Ô:T\çÙ‚Xÿj —%²]\İ\ñù0\Ì1ª·ˆ\à\ÎŞ­\Â>‚ZÔ±²?“À„\Z\å¹9Â¯\òQ)\İa¼£¬’d’Vsû¯±\Æ$W\és>L\â\Í\Ñ±a\ÄR´\ô$&©5Ò°S\â³Q™»\ñb\íh\Ç0\Ø1ŸWd*º5\é½²)1l\Ê4\ì\Ñı0&\áI©U\ì\ñ\ÃÊ©^t\öZWF(¦ÿ\Z{Ü“zA\Û*¯YL\Ï\õ¢\è»0@À)¬©ø{F´u\Óg—\öA$\ğC±ˆ0>vH>\Æ;‹\ØĞ‚R\ë«*Y5¿\Ú3&™•B˜‚{›u\áŠ\Ãa-@0\ç*$•¸\0\Ğ\"\ö;²`C&\Ü0ûaH¡ «:4\Úÿ™\é6IQ(Œ`¨ØºL6™0†H>\äc¼v$\Ä\È;\â®‚\0¯84\nj	ÿ\ó¾S\Ê3;II•ŒA1!\0X\\Á$³\âjˆ`Œ$´»³À³S\â%v\Ñ!qQ\ñª’\ÓC{²ã›‡$\\¾\åÃ‹›‘¡\È6\òpã¥¡ˆ8	Š\n\Í\ó\à;ŠnK\n²\áB\Şs¬è©¹Å‚2<²a¨›\0y¼0€½:^`\Ø#ˆ^¹—‰X#\Ø ‚ c\Z.“ûŸBˆ\ã;¾d(\Â\å[¼³À\nø¯¦‹4LÙŠ\ñ\'d)¤\ß{),d—Z%\îx$A\"	kQ\ÄO„°\n\ğ\"®Eû¹ÿ†`‡†p²µ°\î`8ú*R1±\'49NE\Øc¼@D¾@T>\Æ\óm3 —I+I»¹I\"¸£\ò\ê“Q\"L•™A•ps¾>ƒ\Z\ç‚#–\ÈFm”.b`i»\n0‹8E»KÅL‘[z\Æ0{±cŒq½°y’„^†^(tb‡yšD>^h‡§(§\Û\à\Ö1Ğ‚‰\óË˜‘†r=\ß\ò<\Ø\0“K¬‡£Œ}c°Ä”HAŠŒ¬/F`¼ˆ «8œR´»—üH˜Á\ÄA\ày\'\0\"<Œ«3E\ê4—\Ä\Ç<¾zLÂº¤½$¹U£¸Ñ›6Æ‚4ƒ%·y\âi¹\İa–Ò‘\ÆRÿ‘É„IÈ„L\Ğ¬±Ê©Â„‹LY£gt\nSˆq†TT\Å\Ít\nÂ 22©6\Z—\õ C©P\Æ;‡»\0\Äy@Âœ\ÌÉ½¨+µ¼º\nH<\"\ï\Û„±,0…<š\é £Œ1È„/\ê…I˜„\ê[¿É¼¦L ^@¶[š%´»Ùƒ½\Åk¼\ĞDš‹°«\îc\âúY\ÊS\æc¾S\\¾v\ÍvX<vÄ½À¨9Š\n¼\"\Z©Hl5\É\÷*‹za\n$=\0PN\í+\ö¨&é¼¦a\ñ¬®0»\à\ÌÏŒA°<›fs´wJ\ËRCûû9\æk‡™„O\r\ÍIĞ¼“¬RY\ë\ã«ÿQI-RÁ+a¬3JL²ùfŠ&ƒa\è?©X)\å„PŠŠ”»<3«\ğ„=\Ğº^X>…K¶Ã\ğ{!\ëZJ^˜„R„Kq\\Àzœ\Í$´¿\Æ\0³¡°zD\õ{ÿƒ3¼ t´Z‚/P›‹‹PÑ  h#ƒ\Û>CIRkJ‹†x?N\ÃH\rKŸ;‡ºlTU)Ê>«\ÂE3¾Ù›½F=>”Mah\ÔEB S\'yÑ¶Ù™0L¹@ÿ\Èur8/¿J¹\Ä\ğ	©\Ã@\Ğ ›\à.+aşƒ†A\Í$I1¾iµŠ¾\àLÕº\ÌIü9\Äù\ĞSÒ˜l¾\Ğ\ÌT\åCÅšD>$DÀzÿ\âhˆ%„Ÿu‰Ÿ;Ì\Ü—\óL ş›µÿ\è1¸À¹¡ŒZÃº`4¸\Z`Å¤\ÊŒ)C%\îjŸKT<@\å\ëEÅ³¿¡•Ys¢†`¼ˆV°\\ÀTœMüHøÕ¾ \Ğ{\å©)¨¶\é6K\ñ#\ä*ù.\r+?”°>-\Ì-@ƒ\çŒN~İaC5C%Qˆ7\áL\î†MM\Â\"D¾Sl¼g\å\Ğ\ö—UP}²FıEfM>‚MQ²\\\æ#‹ÿ \Ù\ñ\n¬I\é1wÅ°=‘(\nr¨”0\È:rÓšµ\Ù\ì!\ÒH`¾‰P„Úº0ºØZ\ÅUTÀ¢¥Í¥…ØpI—L¼1 «M\Î\ÌÉ—\ì[œ¤ºŒ\Õ:Y4A¥©  \0\Z*Ñ¡\Ú	O[\â\è‚œ\Ï1¼H\Ã¸ÿ\Û\Ìa>¾ˆ­¸\n¿¯DVƒ}Ö;Â¡D\å£RœDE\Ä\r:Æ£\Ò#\ô¹\ÚŒœ=3-E\ä;\Ø’<\n9 <\ÔÇ® «‹Ã¾ ?³\äj°€2¡’,\ö´\Õ\İÚ…AŒ­-¸[d2‹}\Ã4‡º \Ç\Ùl\ÜÅ›½\İ5\Ñù4QĞ´V\Ãm*\rÚkyhˆ6\ñ_\ØC®\àQ˜R# s\Ë\Â@\r\éUY®²U,#·q´R±\Õ%_­e’\÷‹øı9\ÄıHD\ØNMÀN\õ¹ù^ql\æ¸_4\Ñvp(³…¶\ÈP\Ä]¸®\âuÀRûO“]§˜?»°<\Æb³¶(,Œgÿ\Ü\rOj»Öœ\í;œ Â-SŒ\ß\0ş\Å2%\Ó\÷|O±\Ü\İ*uQ^°ûa»8‡2}²$œvX!L\Ò\Äx\ã™›\Ö\ÏM‘\Ã=Åº£“G\ÚŠÈ™Ë£®Å¾\ñ\Åb\ÍQ†zùLaÖY‘\Î\ä\İ\0Nc…µ\Ç\ÜE\Âs`‡\İ\í[\îˆ“ˆds_„M¾ø\Å\Éy ‡kß»@6\Çm\İ}?ßˆ\àşP´ªG\ötÜºPˆ½“D¡9*,™R?\ä‹Á¾`À\ô%›\Ç\ŞM\ÅQ¦\ÇÏ¼\Ç\Ù\ó\ÛQ­\Ò_|Šk•5‘°\Ü\Ö\Æˆm\õe7yC\×\\@.,¾;˜M»c\ÏTtVƒ§ƒI\"\öÿ8-`S¹”\öh\æ\ìi‡/V¾ı¡Š\ÖH‘vI\îDBûEXœ4\å\0n\Ô^0e“\Ø0ÀşU\\u\æn–M§‘\â U´]\öT8yn\É\ÂV\àuÜ‹^VÄ­Zœ\õ\ñ\ö)Œ\ÊL²Aƒ3€\ä‚Şšh‹º<‹J	\ã0\ÅQş\Û\ã\Ófl\Ä\×Å³\áü\çV\áPª\Ó\İnıT»\Ó\Øu~—\n`jŸ\â².\\‰U\ØkK-\çn\Ü\Z™´\Ğ\ê\×@1Obf¡––/\Ö\Êl•\ê\Ù\rmÑ‰¦\Í\ÇZWF\Ú\r\áJN‹ˆ{|²^HQ]üj\âu\Éø,`¿±\ğÈ‡F\'\ãkO\ö„\év^{\ô\ÎG\rf«ÿU\ñ\Ä\\x	á\Æ>‚\Ök\Ìa¼/=Å‰“¶\ğa\Ş\õÅº¼\æ 3e)\õ¸Z(³ˆ\à´N\Ãİ„ı[\İ\Øe\õ\ÔQ\r3¡»øl‹5\Ó{leVKf\ri4\Ş\Ğ©=¬ø\'KUIø\"’ù\É0\ğ \Ù\Ö\Z/ª‹­ëƒŠÁF\Åf\ÈE6şM\ì]“ı™ˆã†ƒ\åV§N¼v ‡P^Ö \ğ­\é£\Ö0\0\ZFB*\r^Q\ÕEV6\ã\àEaUa­¨\ÓøTY¤şcï­©9I<`ì•«5\Ú\Ò>\Ú\í|C\ÕxT\î\nª „\í¨\ÒfM\ÅZ¶G”º\ívˆ½X„Bg	†X\Ç\Õ_¢\íVø¼\Ç@Œ\á\Ä\Ö[]9gÿ\Ë+–„\Éş`\ÆDÁ\ß\Ztº°\ä\ná—º0fT\æ\è¸1\ñ®Š \î°@\ÔVYè³¶\Î\Æ#dF¶\Èş¹1Ô¼q\ğEp\ß\î\óœ\Í\ãCuÕµ&e‚\è\áxUŠBˆ¥¼\"¬\Ö\å;\0xP-¿˜\Îµ¢a=\á†\0g£\İ\ä(‹5!gl°\ç\Ä\ŞPDo\è\ß\Äc\ê›r\ì\õ\ê\áZBÿ_\ãM\Ö\åX‚q4C ¾•€\õ¦\ô‹i\Ø\ÕÛ¸a^>/X»p’‚\Éş\ŞRªˆ+ªH\í\Íj\è\áX±\ê´a\ã[Àù\ÌÉ¼\á›76so\'\ã%¿V\Şnu¹ üŠ\á\âY\Õ0oÑ’\0¨‡b×š2ú›¦ÿ˜}N\õ†8‘\ï\n=Š-D\İsù\ò–¸p—:[ 8Ä—nl$¬[D\Z\áq¡=wA\ôf³F\éº{«$³\ÖK™P\äe±µ‡ \Æ\÷Š™dş.š&\æª\Øût“6 Á!Ÿ¥º’«†Š›’­\ÜQ\rT\Ş\â\Ã2\\\ØS\Â\ã\ŞsüQ\æ\àxf]k\Ï\èO\ç!úŠ¬ø,£RNª\÷¼^ùD!pa±`“®»Àh‹\õ ‰\ÙBTE`\óº‰\àE\Ğ½Q*gş\Ş#(\Ñ#<\÷][\0*°Ğ…oh\÷dZ\È\õÛ©g7I!<±®X’\n@\æ…V¥¦¯\Ï\Z} ‡y¸ÁÀN\ñ“>é‰„^\Élƒuÿ“/° ¼\\Œr\â†\ZQC¼±\ÖHxt­üAEU|ªƒZ¥\Ë\ñ£\ô}Ä¬\0~¦+L°AµüŠÑ‡zH	m+8q_ºPv\'¯\×ŸGT×šˆº\Ò(X\ÂÿQ\Ëy\">İ¡¥œ‚”¦*\Ó8±H\ñ¹+E™nT\àş9/6“\ß?\ğ8}Á\ëz¯\Ê\äˆ},h\ğ B„Ã†1\nfQ˜H¼$\ñ\ÚE‘¢D^%Y¬‰Ñ®E¶\"-ZD²\äE[´hyø\"Ì‰¼†Q\\´ee˜-9oº\Ü³!Ä–7U¨`\é\ó¡$a·€\Ùƒ%Ì’‹$-\Ò\È\ë*Va¼„™&¬»­YeJü(5g\ÎEb´\èÿ|\ÈHÜ†a&Hh\÷.Ş¼z\÷\ò\í\ë\÷¯^eTs‚A*‰\Ö]\ZmIªÕ¸\êT©\'¥–lÊ’mIF_2úªu\"U¶+a†)T\Ú!D´:©À J´5\Û0ˆS¯ır‘f\ÇU)b\ËU+\ğ«¼-F\Ú\Ô!\ÚÌ˜@‹ƒ@&ÀÒ§S¯nıºB0\ÚNµ(\\¸\Å]šAŠœLÙ¦M–·£¾½:\ì+o[a,o1­\óşiŸ+Ÿ\ÂØ¾]ET e!;=\ÕRT&‘gEZ±\Ó\ËgÃˆu•0\ŞqT\ÒKµT{‰†$\0ˆ‰%šx\âu™h±K¼h–H1FRKq\ç‘\ä—ù”\àT[I8„¼\ô—M\ÛYÿ\ÛQ9­¸…\n79\õdQ:MÔP\ô¡æ–‚‘ŒTQo]Eng\õN=¾—C\Í Šmºù&œe\ÂT™’d\ÄG\Å’˜.¡´[–$LA¡„Aº¸T 7µ\İJ1¬()¥ÿ±\×DcŞ´fë•¤\åGy\ö\öVy\êv\ÒK<\É\õ\ÖB4…AhhÀ\'­µ\Ú\n\Ø$OH\ÕDŠ-–gq“­†J\êMu[{\Âü(\ägCfºŸSZ\Ä\0[\02ù$¥K\Ê6“p\÷\Ñ{a~$U½•Å nFFl-¾\'P¯ É­\õ\Ú{/A\Ê8\õh\ßq4‘c\ézJ&»‚’fo[)*aÂ‡\İD…+hQÿTTH*q¶\ÓnƒNM\ò\Õr‹Ø§\á<yjdVI\ä]¯š}ª.™-5\ÄbÊ¢ùª¬ø\ê¼sœúh,†¨lªyB¤RS»µ‘g\ÜJ\è/cŒ9\ñ“Õ†\á_\Õû¾\Õ\Ë{‰JÂ®M\ìJª0K%\õ¸¹H/\n,f’`¢l;\ğ\Æ\Z\â$<\ë½w‰a¨\Ñ[ŒaugÛ™RfeF?D’Lb\r\Ã\ÎB3}•\èVT1	`“ÿUCÅ”v<\Ñ\ä3…Œ–’’\"¹\î\áR·Í¶\Û\çù	\ÑqNŸ)É‡b¬\É7\î¹–	\çSE\"*o-6UƒÙ¤\ê¸aJ\ÑB\í<>L;¶Ca/½dª\ä“lı\÷\äMSM’ÿ¢X\r~ZXœS¦ùy\ÛG\í·¾\È0‰qcC<M\õn¿¿\Zºûÿ^$%µ)&x…£Š\Ô\Ş\çAù©\\™\ŞWz£6<¹¨!#\ÃO[!I\Øb9\ï	\Ò`LS¤\Ú\Ğ	5G\á\ÑIˆ:Îœd4†‰\ÄC\Î\Ğ\Û\é€6¼!A®¢µ©­qIfÌƒ>\"3¼iš\'b\É$py‹Ô¢\Ø!®	ƒ\";Ô„h²\Ò…]tjI\Ò^—@T½\ñ\Ó»®\ä2\Í0À!m† eh\åbqJ\Ò;%3©ùT\ã„\Æ\"ˆ1\\CELY&\ÕS·´Â°«H­)I‹\ÖJ\èÔ”Bş†4Wz\ÛK\õJ@ù\İn\"Q»Ä±•º‹Á\ß\Şr˜r%L8Aœ\ÊHT\è;@ù\ä0A dHB•È¸\È,	<L-¢\ÈA¸øRrˆ\òŒ\õ.RÅ¥ˆ°`%¬\Òir¢ˆ(\r&f&Z\è·L0\raHÃˆ\\©N½‰-e\Â+ \Ë4¢Ç«HD]‹Š\ÍIÌƒJ]†)3\êŠ\"1¹LY2+HZY\æ=Ûµ±\Ø0T5\Ç	\Û\"\nc\ZŠk<²‘†~W\Å o\ëü(¾r¥ \ñªa\æ’ZI\éI™Á 	AÈ¡Œ’\Ò\âO\"RFjQb8\è¢YRA¸I£Mr„:\éi¦qi5Å„S³¤M=¢\n\Zh\0h€ÿ´ª\õRF¦R¼Z”+<¼b„H’\Ôfb²£\Z%?edg\ó\çx¨’\Ëj$ƒ\ÉdP\ÆvœµÒ©›¯£Jû¤¦!a(\"\ó\Ã\r6f\Õ\Å\Ú\êIqŒ\÷«„‰\ç#\×cKSZC£˜5¦a\ÚBx\"\Âú\ØÏ‚X(E¢&“¸˜%q:\á\ëqÀ02Ù¾\ÎS‡ù&a\Ş\ò»\Ê!\'·c,p\ßD\ÈF–Uš¨&r.²\0±m\éQ\æV¤­°1\"š6)S&½\å$”\èd´/¹\í1›h¹±y±%Uš\í	\ö\÷3œoI=\æ\ñµ\æ Á½o›$±T\ö\ê;¥\"\n¸\ñX’6\ÓlQŞ¢\Ç\È\r“fÿŒhœ(ˆ‰\æ­~º\ÈfÔ³)h7Œ·!”Z\ô™\ñ\Èp\'²	ƒ0\è¡\âLHUø}\ñ‰†AR’´‡´,\àw\Î\Î- 4(+\Ù,\rŸE„\ï®\Ú\Ë$g¡\Ô(\ò%G«wM£y\ç³\Ú\n\n\Ä\ß\Í\Òx˜º/‡H‚úp\0X	\ã1“\è0¸\\\îb)‹Œ„1\â9šC&\ò=¹X¥’`\ğ#7	©\Æ!r\áN&±Æ“@¡&2^›	Ã¦\Í}sÄ¨„Kş`Å±}-\äCŒø-™3Md\Üv7*“‰…ü‹Ã¥…fiŸ\Ñb(š´U–\å¿†›?\ï„5\æV“\\BºCÃ¬@\ì!	\ZŠc\'\Æ3\ÄWkÿ	‹¶|†hº\ÙÔt\ñxX~\æ_13g¹\È% Ì‹œ.\Ò* \Ñ.\ä¤\õŠ\0dk&=\å>Bù#–z²´ü\ÅÕ²5tNT0­Lk\0À´³Î—L(˜*^uÌ´ÿ\Û8CG\åˆá›‰\ó\òÄ­yæŠ˜ú‘²Ş³gHƒ(\'œ“k0·YN¹D}š¹\ë6¥ ;\í‘\å‘Q%D¦%-\â\Ú.’X†Às\ÎÁD¦&…\ğ(\â%\È\ÛWq–¶Û¡\ôEU+<ú¡$1$&\'Rƒ¥küš&­5A\í½r¨¦r\ò6›Vß‚8\öf\ë¼\íz\ÑxCe‘s±\ì_DNŞ 	Ê¤\ó \Ægÿ\ì\àA\áf&ˆŠ¦\Ô£««mı5˜uwds¬5hi\'\÷±³lXI‹v¾\r³\ÛCŸ—\âuG3dw³İ§½Ç•\æÔ‡»q\Ì0\è1=\á$Ci-S\à”\Ä(¢¥İ¨¡Y¼\î“\÷w“\ô¼º<\éOL›ı\Ñ%¢>BˆÁ^b\ë\õ¢ª‘T.\Â\Õ\Ôf\äK¿Š\àÎ‹d²«¤”ù‹ˆ!o\í\Ï\ÄDú,?\âS¿;U\ñr\é¾\å\ïOD\Ğÿ?BH\Ş9¨¨\ÌSyÄ§X\\\ršN„Lˆ{˜ƒ„œƒ„!\õ\Æ$¹9\×X³˜N\ôıY^\Û\ğQE[\Ş9„PD\0°\0¾\à@°˜ˆÙ‰G\èÿI\Ú,Be\å’d4\İnıJ¯’Óµ\Ã9|…9\Ê\ô!\ôt	#,Q#)¸u\È\õ\Ø\Ç\ğ!P±\r\Ón¹O±\Ñ*!Ge\0†\á>0a1N0Y\ÅT şŠbp/l‰ø1\Ñ0!/\á\ô\ô‚\Æ\áB\ôHH\"R{ii\éVØ‘¸^o\é„\ÃT‰aV\"™D\átG°\ô\Ê\ìVÓ­\Ëa\Í\ğ\Ğ9W\èa\n¡\õˆO\ôP’™\Ñx˜M˜ı5Fû\Ğ\Ê@ÄlÑ‡„A&¸ $ ˜\Ñ\Ë\ì\à0\Ñ\"\Úd\õı`H´\r\Â-.\í†-ˆ„ø™\"X\ğ\Â9\É\Æaı\Å\ÕnŒ˜º8ÿ\Z\Úd\Ù9š‚<„\Ùíšš Á/\Â\à0¡Œ‘\Ë`\ß\Ù\ä\ÓÉš‚I†\àT\Ô[øÅ¡?\ö#Nyc,\ê_˜Ü†“\ò \âÁ‘jŠš¬c:$.\ÎTı\éSÏ…‡]\õ\nÊ¬\Ç=ªPEc4\Ô[\ÍÚ›‰\ä\âd™G\ÎBq\Ô_†\èZo½JˆDD¾`&\Ì\Ï\'¹M\nıSûd\Êjù#E‰ § d2‰d\ë\ãy\ÃÅ7\é$8®\'µ‹C<‡}\Õ\äV\İ\ÛÌ”Ÿœ\ÄYDT–]\ÄqPT·@…dc\0”ú¹Œ`…˜V\É\ã°`)bŸ\ÆqWš\0€:b\åBƒVúÑ±¼\Ú\ä\á\Ø\Ò7²ÿ…J¤Ei\ğ\\\õ\ÓipeÃTÁ\Ì[G8j\âG‰4Ô…_\Â \íÀ[\ÑeH]zÕ¨‹Y`ˆZ9IZ$‰cN”â˜ŸL&\Şe(IE°\å\ÏO)†X\Òş\ØM†&\0j‘®1\"n\Ä22“Gø\Ğ\åQIœ\Õe4Š“`~˜_i8\ÊCY\Ş\Ê¤\'•\Än\ÂD°m†\'\ÉVS$\Ö^ú\"qş\ß×	\äf\ö\íÂ–ĞG+jH hPXvİ‡ù¹	o\Ş\æú$•Ÿ„\ç\ne\'a´Es\Ì\Êz\Â`&\ô¦K\Ì\\\â\"Ú…s\Ö\Òj†\r’­H\Èm\ğ‡ùˆhK¸Å„\ZZ©K}c\n\Â\Ûk¥ƒ>\Çp>ÿ\èÿ)\Ã\Z-$\àH\ŞI\nO\Â]]Dqh’Á\ÒÄ¸FÖ©@À\0\Æp\ØYh&\Ì8\'©iÄ‹\Ò\èGŸÑœo\Ñ(\Â]•‰‰bHƒiqIãŠ¿–»™¤<,9\ÉqGˆ£\ò\è\è\ñ\\\ç•H¥†„\Í\ã\r–pj\é\Ö¹D\å\Í_.\Ş_…`\ÅrøK¥†j8	§ŒM\äœlhaŸ f\å\ÇqB©\nbj[l\0\\¥Ÿ²§™Ád¡IPtÇ¿$\ÑO&j©l(L9\ê}\Õz¡$0½£{úDKH\ékŒ\òÕ«\ĞQ\Z¨ç¨Š^§A„lş\İ\".Ç¢\ÊDp,KS…¦J7\Ñ\Û\ï¢0\ÂL	½\éÖ”q\á|Ua0ELÚ\ó\ë\ómT+i¾ÄŒ\ÇU,G0ŒŠX˜i.İ†\äØ¬ù’,œ,ı‚™\Ñ[¾(’œ\ÆQm\Ñ\áÇ‡\ğ[\0› +\ôS\ÕiD¥Wœ¾E¨%‘V@\È5ºjMx\ç\Ù`Jµ±\\¶²\Ù\íÁxKP-¨§6¹’\Î\"`ˆ*ÄŠ=€Wa\É\ß\ë|Š\àÀS-\Õ\ë„$\ÌË¡V\Â,© F\ë±Îšy]WLi×­¹lZ|ˆ¾\Íh\Í>Ÿ“S(\ÚÁ…øŠEŠ™–J›ak\Ñ>\İr`DHb\ØbOX)¹V\ÉP­•Ü¾\n#Àÿ^-\0\ÆE+b”Ie1¨A pœûÄˆ«®-Ó£™%•\Õ^½h[PÅ´\è\íKS6í‹¾N\Ú8†bd¬\Ê\0Q\ZJ\r\è&\íO\ò]Y(\ä•pXvZ‰P\ìiù\×…\æ\î­\Ø1\ä\È\ìj\Z\ä€a\ÊÊ¬\ŞRŞ¢ˆ˜\Õ\ã”SfdˆO”M”\Í\í\Óz‘\r”¡˜œ\ë\í†Mh\ŞU\ì\ßr’\ïN3Î\Ö\ÔRšê’‹j&’®…v%\ì¡+~Ìš\ßXm\ö¶1\Ûj\ÌQ\ÅÔ»¹«\ï\Æ.Œ‹].¥m‰‡…\Ûj¡lj˜Æ¸r\æ· \ÙM<\îC–o\Ñ\Ëı\Ú\ì\Æ\ãúPnZ”hÃ\î-ÿÚ¢K&½y\Õ\×VbO<nP½\ÖkS\Ä\0g\âr0¡Ü€\nPU‡\Ü1†c4ªvı\í¡\ĞL-¥¾ª\îeI!“[š~p\æ‚r\n\ä½0g’U\à0\Í\îp\Î\êF Œi\na´p¯¨\òù	¬ø¦¦N\Ş(\ö¨‡\Ü\ÒG\â\ÔmMh¥¦±jqÀÁ\İm•\ï`¹¦ş-\Ã\"\"k~ü2$y\Ñ\ã\ÆT¤FJCu×Vq\á±\ÛjH\"²š\'¹\ò\Ò%¹lµk•f“_%\ÈúF£H-\'%¬k+¼•\Ú×¨€ıRr³é±µAf\ZÕ§Â¨\"·…ú¨\ÏWS\Ê\nŸ—¾Z\ì\ê2‡Eª\'c—ûÿš¨@4È²\Î-ƒ\'\Ş\âCD™\Ü.f\Âb\ó‚FT!ps’x]Pk\Z’ŒQ|KŸ\è„J²4\ëÜ¡a	EhE-\Ô.¨mÈ­&uW\ÒÔ­=\'K\È\ğ¾8²oAbùÇ¯rª`ŠO<\Ë¿3™*°\äiÔ¦9?\åb\ó\ßZ\ZA\ñi\Ä\î>Š´$q±\Å\ô2Ekv.¯6¦N\ğ\í\õB´À\é\ñ–WŠ\î²1£´ÿ\âÄ­q³hP0€fV@/É£d»¬Ü€F\'‡{6\Õ<\ÓL5‡‡\ï¼\"\ì|\Ñ\ã\n\ôº0H«3u\Õ~htULoI\ÓIYU–2St\Æm‰\Ú=µ³\é\ÆşqœD*ÿ[\Æ\Ø<\ŞU\ï\ò>?_\çH~:r¤J—hHq $„\é\ĞI\åQ †\õ˜\ÅKÃµ¦q±›Ù•/k&	U·\æ\ã.6gJ¶pJ\Éx(h¯\È\ßJ1tO\Ûc¦FmVkÍ‘‹Iv¦\Å\óª‚J<Vt£”4 \'l_³\ìN\Ç\ğn\ãÄšJ\ğH\ç\Ä\ôZY\ë\òÁ˜’X\Ô%#À@_\Ò\ö˜E5U\ßş\ÑFŒ¶#´NG®O\Ã1\äy·Zy“y‹«\Ån×™˜\ŞIÄ€GQ7Œ\ÉuJMT\0(›wz¶q›5”-¶Œ´#4Ö 6yqhK\Ä$A›l\ËwuÿÎ˜\Ú\÷©L¥56\ìwPSJtY—\ö“ÿlv¶H^\ï\ZJÈŒW¤¦¡mÁlC8~\Ñwc”¨Luı±¤L¯Z¥¶tbVk\Z‰g\çµ\0©\ÖvqW_¹\ïC<M\é«Àø‹\Ù\èE\È\çFh®¯\ÏN{·a8\ë8ˆ\ö±\õ€›—¿©	y\Ñıüd$ Ò 8”\ã—2\à\àŒoX\Å].v\ê1»1yO\'§Œt^\×Æ€\ô`¹Y\í§\ë²\"w\è¨\í\Zšc<\ì›3V&€F*Ñ”\ßcªysJ†ûùY™K \õ~CK»‰\èHWq,?\ã•\Ú”F\Â\í<t¤«S/ …›i\Ä.pb´\r¬úr\Ä\î\ØHJ‡u‘¶tQA´¬H’ÿ\ÚÚ©s\nR—\ĞN\n¦¬VKº\Í\0\ñ\â¬/\Ö×˜ÊŒ´ÅªK¬²MgÏ‘\r{Ÿ—¸‡J\n€LÊ’\Z\éH¥\"*\Z\Ú	¾\Å%#\Är¶\Ç\Ñ$˜RÚ °Uø\n¦£\ÇQT^g¶°“;»ˆv’R\r<Åº‹µN›u»(ß…%gI\á{¾\ßjX\è>gNU–R]³\'´ ww\Ö»˜/¼\Ä`[\ô6\ã^M	¦KA\Ş\ÌLhü\ÆûA\Úb\\XM¬>pÿ\îso_µy\rv©‹ùMLï·¬i‰¢†\ZPY$ß½A—aB\Ş\îü\r)C¹•„2rÉªÚ‰r±±iˆ_ÿq\Äø\èxm˜Q\Ë\í`C=\Çÿ\äO¶My\èUW*#¤\í%ƒ\írı\ry­Ë„nIùÊ¿Wù\Â\Äy‘ü^-¨%:´´{&‘5¹K¾P \âU˜„„\óŠ„Ëˆ\ÛP…²xEŠM…\à~%…a~e\ÂF’Q\ó~\÷´\Ù\ÒZQ\öù$\ï\Å¥\rn³\áw\ñB\İü;$ƒ0L\Â0D\ó\é\ã1€¢;\ã\ÔÓ¿\Û›u¾T¤œÀ#\Í5é²›\×p#[´´F¨g\\\ÙY\ö§\à\Ëù\ÓV„\"H\Â<$\Ã\"l=4ÿ\Ş(CK°\Ú0i@Ô’´k -I¼\"\ñR8p £E’E³(Œ¢0Z.nÉ¨h˜[´h‰\áQ¤ o`	8Ã¤!·Äœ¸ˆ\ÑÁH	&dHP`Oˆ#B¼‰i˜\ÄE‘\æ•$)£L\ô\öE•:•jU«W±fÕº•kÿW¯_Á†\Ëu^\ÂŞŒHp\Ñ.Fw)Œ›—@¸FŒ¸…\Ğ\ÅEA†	¬¤\'a–¬b¤Æˆ%|h«©\ÛH”\ß>”\Ü0’À›xRT´H\Ø<aGi.•”ilk×¯aÇ–={«¾a\Ñ.<*‰2B\ßy\ä¼sÓ¶‘\ê\r¦\ïG’\Ë?^¼H\Ò#ËŒ;\ÎÚ”;/œ™9+I \Şî¥‡!Œ‰\İ<¦\ëkÖ”D\Zmû\÷\ñ\ç\×ß•0-‹\ÒÃ¤.½º\ì2·†Kp\'\ğ\Ö\Ò,2£şÛ‚£EÀ(¤Â‰\0#Œ¤À:zL/ *\'ˆ¢¬¼\r.¨\Ò\Ú\æ¦\Ï\æI&(î’O’^”\ÙÿO\Çy\ì‘+e†qOIrS¯-S$N.\ò˜*\Ï8µH”°‰£\ÈJ*)Ì£-%œ©©0\ô\ÉEzk¼»,\ó(‚„AK;0\Û\ó\îE¼B<\ÈNe \òQ\Ï=ù”m˜ƒ\ÜC¡\Ü\Ö31Éƒ\â\Zn \İ\Ú5‡hüp´™f\Ê\ËJ\å>ºRHEŒ\Ì2»\Ìlt¼\É<\Ë;\n#I\õ¡v†y\ñ¡Znjt ‡$a„(bú\ÌU\×]«¢HI0j•4…\Ê\\¯Ì¸È”8hl\nV\ó4J;!J\îJ‹>Ì¶Æ›|K‘LÉ‚\Õ2\ÊHk‘Â P+\í´W™\Ê\ÌQ[JI†Ù§^\ñ\Íw? 3iQ:sm%\ö¦Z\Èüÿ6¡ƒ}û­@\Ê\Èİ–`šŒû\Ğ\Ë#™V\â\õ¶\r\õ(1ewV$5&^&zQNa\ÚqU2%m\n8S…f˜\õ­\Ùæ±”™\÷¬?µ\0C’|\Ü\Ëm^‚#a¨§$\ßZR\Ñ]¸\rq\Ûwk\ÌV»3.\Î6b¡<K³­o\Å\÷­¢w[dyH®‘­r\×=Š2ŞŠî®DM4\æzo®\Ûî«€\\ˆ—şÙ‚´±[\ÕY\Å\Ç`…!¸º•K¡Z\ÒB\Ñ;AT\Ëb\å¬fJ½v\Ù\ò!\Ïä´‹IG\ñzvaú+y\ãQ6oc®\ç\"–È¸…65“™\ï®\İ\æ¼1YŠ— \õ™H¾…+\Ó\ğÊ˜>A´\Ğ\ÚEÀ\ÉKqem\×{ÿZ‚lQ\Öm„>~Ö·‚b\ZV\Ğ\ô9a¡x1\rŒT(¸\õ\n†X\äaV(=az†f\Û\ñ\ï3ozR\×\Ê\àü7¨\Ğ<©Qm1P\õ• Å­¬I)\\…1Š.q‰+ˆd¸\ÕO}‚GA™ª(¨I´G/J\\\\\â\â>\"\ÏÈ«Ì†3<\İ/5\Ì\Ïü^¸>”\ÑX‚\ÒYŒ‚–†2™‹š‚\ã>LÀ\r.Œ€x\nA\èÁ§€\Å[¢\\v¸\ÌMY_;RDP¦µ\ÉÅƒ-Rú’(ø\Å\ÎT\ìh\ãYb¶3S\ÅPft³\áa\ã«\ôC@¯C\Ë0\Ì^,Q\ó\0À\ÔÂ¨\ã nWÿ¬^\ÕI-Œ\Õ\×ä´¬¦\Ñe\ß1¡\óÄ­6aLQÜš;!B$	T¡0F\Ç7¢…\Â8G›\Ì!Ka´°–;›1”AC<s+@¢\ß\Zc¸¾±‘¦”{\È4/·l\Í@\âB\0\Ï\ÂDR³7‹DjÌ³¶\ã1iiÜ¤™–8nq˜\ğ×šŒvv$C\Í<\â@`¹\Âø!o—¸;\0‰\Ëa¸±E1›\Û0’AŒa\àŠ˜\r­Š>”\ñ\Âù%s~AZşÃ‹ú!o\ÃJKd7«¡\ğx¼h\å.\ÜF0+‰‘\âky\à’¬+&Êœ(½\'\ãV\Ô­\óxQšN\Õ&TJ2–q\åQaÿ\ÆK]\êr ºlQ-kÙ¢:&CfÀ\Ì\Äj‚™U­*˜Á\\FV©R­*cbÀA&\Æ\nV‡\ÂH2‹£A{q–¾¯§‰‘\ôÁ\Ú\äz\ã)pŠD,¸¬\rV \Õ\'\Õ\ã(\ä\ì‚-HTÜœ‡@›j®hsš\ÇÈ¾µ“TE\â¢g<¢o\\¿Z¶–ÿ4-TÊ§\îÎ u\Ì\ÄU\Å 4ˆ!²Cp›\Û hX(W_›‰I \á7ˆÁm\0ƒ\ãJ\"\r[¸b\İ\Ù2t­WF=®›£h\Ğc»maıê—Õ®ql\í\0\ÃCv\'7Cn,7\äœK=G\ÒX&/Ai,\Øp\n†8b­¯3L{OZ\×RÿùV/§K\ëPŒÊ”X]\ñ!\í‰\Õ\á\ä²\Æ~\öÓP­_‹šÌ¹¡¬’Xrcpƒ\Ú\Æ!¾-oCœ[\Ùf\"¶a\Ğ\ínc`€\0 ·˜\Ã\0 ‚\â\Ş\à¶ÅA\ĞZ]ªcÂ•mk»;:¦·Mı.?56ÿÀ1†¹[\Ï\Ò2”q\É`,9ù­&2\ö Œ‹ß’º9N¢°À\é™:XÈ¢”Š!h¹I0şyº¸\\bP»€\êYfYË‹>µµ$«\0*U‡\Ä0€q!@z¸a0nŠa@c\å@\É\å­rpi\Ü\0\Ê-\ñq¯šÚ¢a¸A\Æ\ãu¥\rb\\ZÄµe#b@¯a\ôÿÂ­s”\å@\Ûd*w\æ£vİ‡Á&\Óø0n\\;’\ñR¤\"5js\äYš¢\Çm\'\ï@DµK\ÂP\È\Ø!î¦‹B˜0ˆ}Äšª\ç,d;b\ë†e¨\ØÿŒ\êE\Û47Ã€\ß*4nûo\0\ğv¶h®Œ+c\İ&7· ~±¥y\ëcT3h`\õUgK»ü‘•¶¶½\íŒs]\äad\"¶r«†7JQ&Ÿ¥§ş\Ö\Ù\ñ:V‘&¿\ÑÜ³B\ÒÜ¸\Í\Õ[\Z#g\Ô_ÔKb¬›\ÇİºuS;§[¡>\Ò	À¢®§\÷LT,\åzZ]\Îû‰†<Z”ª\n\ÃÆ’^Šq{ƒ\ä>Ú¸aHC2Xœ´|¶ÿ&¦-­wƒˆ‡.~\ñ\r^LITšÇ¬ƒp…‰/1(\×\àbH\îÀq›i\0À¹ª†;d¦d•\ç\Ût\ì\å¼J3\n	yey>še‰»8\÷\\r—oÃ»¦-t°Qø\ÆxQ\òı\r¸\îB\Òu«¨*\âE2\æ!¶°ipz1ü\Ï½\Êm\ÊmÓ[¬@\á<6«Ü jg‚h%\Æle‹~X:ş\Ö-q wG\ßÀ\â?|&\à\ğ\Ú—\Õ7¨™2\Ä`\àüM¹\î\ÒB\ÌÒ¶@ŠGJG\×Z‹~\í¢4,\ôpv\Î\"!\æ!|^N€\ÒgË€NLetP\È\ç\Ş&§–º®Edÿ)§@†ƒ‘vb\Ü`jA\Ø \ğ\ÌDt\ÆE”\Íİ²©ù(\ì´2 \ä!†’¢–jz\r<Ì¸x\ë\0hm\Ôn\0\n/ıì¯¸b«¸ü.\År\ë\0ºÇ˜Pp€¹Œ\Ö0\î\È¶\äN\ô%€\0s\Ã`)\ğ¶ ·\èa\äV\ÃÅ¶@\×2Oc†´6jwúC¢\ÍùÖ¨t‚–\â\ÆÓ‰“\â\Æ\èzo¿NPµˆN\Ûª—Æ­¾4Q¾\\.)\ô¡\ÜG\İ\ØGEP&\İ>k*yni\Û\n­\Ğ\n=T\r,\Í\Ò\î\ïF\r \0´\Ğ\Ä\î\r\\\Ì\0ßış\í\r\ÍÊ¸\0\0f+Òº·\ğoÂ \ïpk5$ÿW2·\0 \ÔbLd\Ì\í^‹\Èj«\'\áW\ê°a ¶n¤8¬\Â(*\ô($~r©H\ÚANCŸ`o{Jnb\ç\ê6±´,q\Ş`q\Û\æ\n.\Æ\÷¬.\È-\ê\äÁ4`\ém†ƒ\"!H|\ê b‡H‹—¦/ú\Ú$\æ©¨ªh†Á\â¢\ñ\na\í¶·x‘\Ö4\Â\Åp¬\0qk\Î	!¶R²¬x\n™pÒ€Œ«”qK\Ç1\ñx\ä\Z#oÆ²Q\á\âp),n¶\Â`–¶‚±ã°&Ğ \é/\à¨ù8KdŠH’©Î¬\÷ZF\è8P°$q\ë(\ñ\ö¶­\ág.\ÄM–\Å\è\ÔL°v!™ZJ8\ÈC¨Z%…Lj©œÿ¬§ezŠUdfÑˆ\â\î&Í¬p\Åx+\03\Í\Åøm\ÆÀ\0t¬E\Ìşn\ñ¶JL\nP\Ò\àd,\n±¸V£\È$Á·ˆ\á\îB\Ì\àˆŒOn«\Ñ\ÒNıFŒœı\Â\ñÇû\"o*e†0­İ„Hc À~\ÚM\ô¢´\Îr¿h¿Tˆ\÷L\ÊŞˆ./j\ŞR¿\ğI¦\Ó,§-\òmc/A\Ú\Â4\æÁ}\ÜG¨h\É\Û\Ã<²!†Ş£\ßÄ€$-\â–\ñ\ìT`\õ\î\ï\Ğ@ür«)\î\ğll\èn¶R³\à\ê.r‘\Æd\ÒûŒ\ëa5\Ëj9VŒ\Õ\ô\Zh«\ri¬\í\Â\0\rJCÏ \Å\Ğ\à\Çjÿ‘½Pn€Dl@(\ê\È\Ğ\ÚX¶\ò­B\ô|*š^\Èûr\Úú\Ò\Ér–P&-\ím—Àrg\É-31Hİ‡H\Ò.j.\ò©J\åoÔ…³\àˆ—š,\ß\æÁ#ƒ„>°o9’\Ò\0½d¬	·\Ğ\0W-$m‘\Å\Ú\îµ&!€DÿÜ€†«\ÈN4\ZO\Æ:“4\r¸\ê)\Å\0†+¶p¶„2?V3r¬\ru+\r\îBoÀ\á\0®\ïúE{º\ë7W#\ßd&)*†¤J\ĞL…\Ï\"†\Ú\ék\Ï+›¢Ó¨¢ŠO«O«Ÿ–Š\÷\à\íe&ÂŠ®‘Î²3N©–‚atLk\Ğ\è)f\öMøm9nÿ@\Çp1\'·n\Æp«3µ\ï\'e¦\âd\ËÀ¶0_\ì\ğˆÁ\rNü”QM+G\ÒC¬\ÈfG¸¾±¬Š‹R\ó^x„¸\Óı23@=,\Ä\ê°ı$M¹\Úî¸¼X\ÔA	–\ÇP\ó\Ç!H„\á\"6\ì\É\ö©®„OŸş	fbG\Ú\öII‹t ª\ó*l©>/[\n©B«¤d•iø2Ø¼C]„a=a\Î\ÉN\ìj6û\Z&}V¶&!4wPµ·\öof*\î\È\È\0LÄŠQ-2Q\ÓÀ\Æ@.P¥P\n£M\í\î\Ç\Òı\æu\êCG”A>´c‹)SZ%M\Çj+\í¶`\Ôsı\Ë\Å8³m[ÿl9Bµä„#\ßj–VÈ§¾L€\í\ÏW!\ØnÖ“´^±Houú¶TEPV9+ÁŒŠÜœ±\Òi¾Vˆi\ÚÁ\ôº\ô\äTc	¡\Õ\ry3û6-\ÆJr·F\í$ŸK\n±\ñ>\ëuv†\á\ÈˆË¹f\'Q\Ëu”!¸D\0–\n»¶k‹\ë\Ô^¬y½/í„‹_\õƒ\Ô2Mm5\r·,3\Ç~\Ö\0²\Õ\Ä\Ü\à\nŸ\ÒJ\Ì\no\ñ]Í°“Â­\nJ\õZncÎ¬cA––T\èj\õ:¡\ê©vi´&\Ì\Ö\Ğ\à(.z¯½\ğ+\ôt©Q\æ+\ç*L\å\È\ÃjS0–ZılUT·L’	]—M{“\Û\ğ>\õ¯·Br\ñV\×\Å$AHN5+ÿP¯\Ñ\n»\öût¶T­Ç¼V\n\í/\áÏ¹\ÖO¶tD\ò\Ò(«\÷z]\ò\ß|Œ¶h7º¤QY¬şf\Ó\nL\×\0JúˆNhF\×}…pK+\ë\ŞgE\ö\ë\÷Ÿ\ğ\÷\"u\õd;VVaI\ê†=\n±rcY„¦µ|i\ÑJ\â\ß@L2{\ëã’¸n/\r\í\Z\0·\à]µ\õ]E\Ô1k‹(j\ë[A\Ø•P¸f&EE2\r}\ì]\Í\n¤0\r”AŞ \â ùû|\Ç \n\Ğ\î\Ğ@?\ê!\Ò`@m³\×uiŒÆŠ1\ÆhlDl|GO—\r4!$\Ã\ğ\r\Î	‘\Ò\â0fX\å˜X\ë=ù\÷ÉŠ•“pQPµ€°V;Vq\áwŞœ™Mÿ\nQP†!e¶$\ß\Ú\"\ã$\à6*ß°a\Ë_\Éı\ğ.·\õuËœ\í\Ö\Å\Ò w\Ã5˜$A¹j1~‹$şH6ÑŠx‘\ï¶¸4Aˆ+·V1o\0\Å\Î*v¶7q?”\áiIL\òŠ1{K¹\0µ–¸„‰ûîµ€\ñ\äND6\ni7\ÄV#2‚Ó­\Âkš³h…\î17\Z·\Í\á\Ş\î™•yÛY\Ö‹\ó7Y{é³˜fl\äAf±\íš[k)B0ü\0\ËE¹@\ne \ÅnRú\ğ&_·Õ©\ÖBŒEŸ\Z\Å\îo y\ì\È|kx%a\àvS”ÁN–L\ï\Ù5_\Ë\â\Ô\ÔAsQ†44a|áºŸEÿ\ÍL\Zylÿ?2A¹T Do\Ëzn\í\ô.\í\î\ğ¾\n±·\ğ4@hY¤û¹)Y\ìm…\Ãj.\"M\ãeU\ñ}y#µ-rŸ\ØVÿq•Ê™\ÊduI\Ú\Ü\í€A\Ê\æ%µ@Äœb\äş\ä¶nq|S,|\ßO™2oyœO²é¬AXD‡Á6hü\rbgG¡fG2	U¬\×\à`la±3_+\r\ì\ö\Ò\Üo²4\İ6\Ä\Â:n€ºf\ä\\wÒ‚;\Z›\×u®\ğ\Òşø\r*yx¥\Ğ\à\ÚA\á3}{5Bd”\ì‚c™Q\èQ!mš¦%×™ou™\ôŞ¸\ôK\Ù\á`gnœ\×&³?ıP-)•$\Ç\÷©_¬\ry\ì¸\ö¯¬\Èù	û\ØÄ‚+­\É\ê\0gF\ÄÀ2Clw}ex\áE\ìs\'@¡şB\r’I\ók»V–Ù»Y\\w¥\ÜÆŒK¹XY$·ÿ\Zµ5$\íEiÌ¹\\,¸\õ[Eú£‹\Z”Á–\ån|—\÷‘iÅ¬°ı6\ó\0%™d~ApÂ†\î©Ø¡^[Â9¦ÿ‰— \êĞ£\ï\ŞZn”(\ã\"\ÆZ}¶5\Ë7¸ƒ;¶f\'5[¬¸‚sK»Û¶Š\î\âp\îşT\ÒhL\ä46\Ãù\\\ÑJ\èT4yËÍŠ«AS¸\Â\ï Ö‰\Ì\ÆV­\ãŠR¹zL\rg#m\r\0•/%±w1û\0Or\ÔÎ®ù;G\Z0Á–/ùû¢vu1ª™\ÒL\ã°h\Â@\è\ÑEø©ùj•\Ğş	\Ğ3,\r\Ği\Z\Ø,¬V/\ñ\ö\Ô\òK;C9‘§6ÿ\rns‹ÿS\Ù\ô\no‘·\ào£\Òı\àûµ\Õnû®¸È”¶\Ğ\ÊW’:\â\êü\äP\ÄÀW\è\áƒi\ä\Î\Ç`\÷‘£Q²3A†v>2¡&øe\0>)iQ\Ä\"mnıO6ZÕ³\Ñ\á\ä\áœûb\ì–S\Ìk-.\r–1 \á\Èy,\rlya\çú\ÛC]›\Ö`@fˆ\Â6\ğy\èÈ³1\Ì´eL\Û\Ş\n\Í\"‹TÑ¹¸\ÂM™{ªè¢0–\İƒC,\r$¡²\ëı\è\Õh1[eÌ¹\î\ÛÄ–£(M\ò\0D\İ\Ä&\á\r\àND-\r•\âúi%M\Ş\à\Èd“P\÷\ZBrvº\ng³/;\r@axs@¯jü\á—£ÿ\'6\á>\íùXyZ\Ó@6²û3\Ú\İ\ğÒ²±\Å\ó\Ûa”\n}À\ïeø\ò•\Ü\Ûi\÷©\ó8\âO\ÕF\ìE\é\Ï\Ã\n‰\æA:R\ã <\ï\ò\öœxt\nÃ¢* œ¬ FWr¹8´\Ñ\'Øº`[\ïv\rfßˆ‰Œ\öı®)\ë\ßıFL7…¶A\âÀÊˆGb\Ş\Ó$IL˜b2)\Ë1†\n\0+ŠFb[b„‘¤lX&bÃ¢]L¦\0bâ¸¡!š4œ\Æ$\'‹2\Â\ÄH\Ò\ÉE’$\rK¦hŒšb\öY½Š5«Ö¬b``\ãP\0\ÉX\0F.\rxlø±\æ›L™&¡yÿ\ó\ñ\ÆÎ¼b|PÅ¡g Ñ¤\ÉMŞ›&…L¦O˜-aÀ„¹¼4)/^\Â6³\ãÜ®]g^˜8vzW\ÓH’„¡\î,¬İ¼a\ì\\sfwZØ¢H\Ã\Ú\r\ã\Å\èrŒ-7B|S\ÆÀvo0\é€0h&V”d7(ÅAcPœ8\ò€W\ï…c¦+)\Í0e3QO\ÙU\í\Ô\Ì1}Ü‚\Æâ°®\Ö\ÑH\Ê4Œb †B3\å\ô—M=y•=)\Å\È0’`²\Ş0\ó\Ğ#!jFÂˆ¼¸\÷\Ñ[H\â>ÑŒeÀ\nL\ÕUŠ\Òq\Ôİ€\Ö\ÙEW&2\ÖLùe’\Z“¼q#U8İ \ÜA\Ë„\Ã$5-F`A5\Éÿ<\Ê`\Ôe”…¡\Å\"‹0R\Ë\"¶\ÔÂ¥l’hq™L1²Q‹„‘¦‹˜´=\í¬¹\È.¼\È6L—’\ğ\ÒÔš—\ñ\ÅĞ5İ„ x=\Ñ\ç]P“ ‡\Zbt…\ĞrŞ½(w†&„è‹f²4\Ã4	 \Z6È—#hƒƒt7³ƒJM\âTTA\Ş=j\ÓG7`\0!ù§=\ÉC¡>ú¸“Œo\ô\Ğ3;\Ã<û¡0JID\í$%^›UYC©`$\á©E\í€J&©\Ì>6¦)c\Ë\áF:Ù¥ë „’\'!ºw7\İWœI\Ã\è\óiHTb\ÆŸ¶lf‹–¼ÃˆWšD_H\0NrÃ•D…Alk\ò6\Ïÿ<ºiÜ”RS™¤y€ıµä­˜\è\éGı§IJvU\÷‘|‡.D_M	iNù]”R&bH¢\Ğ7¨µªĞ„\Ğu±ÇJB¶$Y\åŠC\ğÖ£™;	…\ÊÌ£O;\É\Ì&­m>‹TP\Ä‡m\Ü\ô\ÜÑ‚\ã5ı\è€‰\Í>Q¹L‘=9\n}8!G(EùÚ«\\¤24ƒr\óF\Z—v(M%µş\Æ\È\"›·ep7¹\à\Ğ=j\İJ9\åš$kRÆ”’\ÃQt\Ó\á6)˜P_t\í8ë­‘:Jà£’\æ|ƒ\Û\é:$Cš\ğøhv©$\ÆşY´Ï°B‡a£Dh,W\Ñ\ö=\Ä^D\nI\ÔQW†*‡\ëÿ’¼š§4µN\r‹\áIMIøl2\Ì>û\é\ÛjM´E\Üq×¼£\Å Va†6ƒ’\èC¼#9um­|	\Êyn€\0\"A°\'9QœBšd9z\0\Ì}C{V/\\†B0\âK[\Ğe*\æ8I$Ra€\ÉIˆ!¥Ù°	d¢eH¶$\ÆJE\ÂÉ€\Ş@7,oySZ`–s3I‰À\ë\İ\È\öU£,({ÿ†±”¡e\èY *\Î\Óh”	Ô¤„\ë\ËG@\ôe\Íe[‹\ÜB–Ç´*aB«£Ğ¿\èGˆC\"iR‹¯ª\â¿)c#*0#·\Ø7‰˜e@\Â\ó\Î@\Ò0	_%®dJ\ÈB(Y H\ÍP<ÿ\Ë	\Îd0¾\òÁ“\áŸ	\áP)‹\ØB!¼Ä‹-\ñb¼ †’è˜“@qV\'1V H”¤t…8BÊ—kB:\ö1Q1²M\êB\òY‡\"u!„®\àd‡È£\"RLMzúğ›²C=*ª„1ç¬ºB»G\óQ3,\Ü_r˜…\"\ÏÈ­T”ˆ„D)—	™Dş#0\í$R‘eydXÂ’˜VÁAI¦B—®\ÄE\ñNš„²!Dƒ\r(¢¾wƒ1„t* l^0a\Ìd\àp\Î\nN\ç\îÄ°…p\ô]“$Ç£[’:\Ä\0˜$\ä3ŸŠ¡$¤«&i·.M|\Â{7\èÿ\áÌ¨_	*IPaO\öD újP1Ú’~F¬§%(\rü\õA‹(#<\"Jó©«©ø\È^*\Ø\×\É>²‚X\Ä|^	€`n%<Œ˜3¤\Ä\ñ	\İ Ò´L”D\Ä0\0V$nYiz©Kw\Ê7	0$o´k\Ò\r›œ’U\ê^	)%\'‘W\ót”8U¢Q¬gÍ†úp$Áˆ\ä>‹B\é’¥\È)aƒZ¸Å¦\á˜Ä\ñ¨\Ğ).(\r\rn PyyD\Å%µ\ÖW\ŞùšUÂ¨Nº\\$x\ÇYR\Z4\rY5#»\ÃH\÷*b£Se^\ôA\ßt…R…u&yƒ’\ÄS¯\ö3y9\Üw]ÿ\æ#M¼€AP\ZÈƒÍ\rŒ\\Q–R’ZjŒ—H\ã’]PH\\\â\ãR¤{•}\Êø‹/\ã(QhB¿˜\çÑ\Îi¬`Ï’V‘	z\\¯i#9‰bF	Á€[ŠƒTB1\ìK\\’8TÔ‰	P´\çšø5™[\Ä=“\Æ\'ˆµ»•fÍ›!\Í\Ä2\è¨¼‡\æ\ò\ÈN\ZHÉ‹Ø‡ƒ\éQ•M›¤ˆPhˆ\n\í\êX)}\Õ9XM\Î\òV£ß€-5|\ÔD¬eœ\Ø\'”4\Î\÷\ò\Ú\ÜGe§g]\ñt§sEH“”\'‘3(1…(ƒ¹˜ş\"\\bQWR¶–Jƒ	ÿ\×I¢\nµ}\ã\â€\är\ËrI.#\ì\å@{U&(‚	b`bQ*_¥mx\óUœycx@*I|¢.˜h\×\ö\ô\ìa?\óH¯\î”o{´#|\óÑ°¸\Ò\É\î© Ö¢E“\æ!FoX¯’H\ò\Â\Ú%8v1!\íB\×a\ĞTgedù\ÕĞ˜\÷»\Ø[/J¢Èƒ?\ÉÉ£v™r«y\Öd\à\ë\ä$o\ËC~²½”8ˆ¨\ËX´OS?fû†B\ô\È%\È\ö„\Ü\'ÿ‹,©’©ş06©€(4E	ˆ\ØX\æ0”>\àUi\ç\ËW¾†Ó’\Ú\Öd]¿fû\0™ŠŸU%r21—L0Q¾°\â\Z\Æı¨7@ÿ…\×r<™Mvr£\Õ\Ú$sƒ…)¯gY\Ã\Z4\ç\ò \ïgg\íŠÊ¯¢j¤\åE`‡\Z;s”AŒOD„.\ã+*…‰¾ø\È\Ã\r\ë\âl\"ƒ\Ã@\Í=rJı,$Bá¡­LÙ†	\Êl.\ëL©N•²\ÇeI™\Ãùu0’h@¡\Æ\ÆùÂ“è¦»3‹b]_\Õ(n\0&\Ôœ\â4\ğ\Ä7˜K~ş½\÷dv™\0\n\ô$4¡ZaÀng„‚5»w8nd ‚\ÓF\'¶š\'y(Cqan†NCNXƒ;§vzû 	6£´4(¦\æ_>²4‘C\Êq\î\æh¶(B82ˆEBÿq·‚P¶\Ø3¢,\"D,rN	\r%c\\\Ò\Ò½\Ğ6IA!\Ò\"e¨A6\É\ğTcw%¸ 5{\Õ>!\Å=¡	\Épù1nPd(¡¢r43!™m!e‚\Õ#‹’µcI2gA{’k7ª¥I\'‚‰Wk\éS\r  •\ò]m\ôyE-ü&<ªtA7c%¸\Ö\å*b‰8°Wb@&–yz\Ñ#±Z¹ƒ2\ÕM\÷\äb6R®…\Ä¤u\È\Â:Du6¢}Iˆ	\Ô\Ñ±uÁ\Âl¿ÁPÁ\Z²:[\ÇPCC]RF!\â\r´G\Ém\Ãjˆ‚0!‡\ÄRÿe4Œ!¡N\×8!’À\Ä\ÈG“hIJ/\õv\ò\\\Zˆ<”>\ò’ ‰ˆr“—\"\Ï+P‚\\\0rß•ICBÁ\ñ\ò(>°ycPs¹S‚s3Z\ò(§yƒI‹2.((\íB\Ó/ı\"V\ÙT’cDµG‚\Ó/\nu\õS„\É\à“ú\àEÁB!~„	~\â\É\Ç,)!-\ó˜\ÂĞ”k’û0\î1!\Éhlx˜	\ğF {hq‘ÀO\rID\0{ÿ	½`#\Ô1\'‘	˜m\Ãb7%-b?\\x49“ZVU5™\çv5D‚8—M~AL±˜2…p!a!!„\ğ2>¨”ÿBm\Ó24Õ/¶8X†B‚*\÷*‚+r<‹ÿ\ñNÛ³ ‚R‹o0.-csi¹¿2G‘I+C$“‚\ô,\"-¿%eNF@\ãt[t0`\ó\Ó\É\à,\Òld4-`s\ê4\Ğ\0h^¤f`$e\â6gy\Ñ4ˆhÆ†rƒ1dCù0g£C‹\ğ\ZÍ—1Mƒ‡	7\ã4$¥Oıø\Z¶$’Sc%yw;,2 \ö\"T\átør\Ã\ğKBB\Âfdl\Î2½PltD±˜i\âqz\Ë–(!ÁnYƒ’ùIIe(«•ZŸøyC£	/\Ú3f:ƒ5ß©NC£rÿ!H‰lQ¶§FAºGŸCkd‚M\Ñ1\Ì2šI§¢lk)_z¥N= §£Jù\Ñ@u–	Oˆ\ï£Â‚Æ’ùp\Z\ó ¦\ÂpNYKD\ñ=72+!¨‡U•F1c\ÉÁ„Jyz£7D\0‘2\Æ\ÆGuk&5UÁWgŠ&[\ĞN94:C9\æIqze–;@Xs!\Ñ#£¦±Z¡\ÔI\É1 \æ¡\Ñ eÿGIúr[n³¸Zù”3J‘	\î	\Òt\óÀW\ë\ñ*ÁP x\å&\òs‹ÀKiB&O1•Ÿb@˜Á[˜ag N|EXIn\\(JĞ”‰Y3¦ù±)Æ”ÿC\ìÙ›m˜ \"2\ß	<‹\ñD$¥ ‡/*t¨\Äq‹($·£\ó\Ñ\õp\Ë1	\ì±tF·[(\\p*\î \îpL2	Á\á6\'frw‘I.S§\ÇOH\ão)¿ˆ¨º$x1¨F#\Ì\å#u‘=\æ6˜3)\ënM\öMWu)q‡ˆfWyu\ß-JÁÅ©˜\à\É8jQ«‘B‹h@\Õ\ñ	ÁJ6a4--i#·j4¤D5\ìú)­¬ù\à\Z\Ï\"=U\ÒJ\Â8 $9ML5q_B\Ò8¨t5ƒ\"F;\Ä1w\\³4øjûÁsM\òq\Ó&\Ô\Æ0[p™\Ù\õ Œ0	;.´\óÿh«r1’\Ô3Ÿt(QJ‡#^™\ğŠ¯‹!Ñ¥Oü\ÄT\ñ™7\ÈG	ul`\Äp¨\"D*!!ü\á<\ë\ö,”\\“ÿ\òT’$8\Ğ\ä/{\õ/1i…=PA—“	‰23y¡RMÃ¶SZ\Ï\ÂG`\ğtÊ–Œ{H&¬V#€™¹n‹Rƒ5(‹ƒs³Y¾°uiS‘Z\Î1\ê\òr/[“Œ¹u–\\¡\Ã&a@mûd\ØÁ d!¨ŒpzaP¨da‰ \n›`š+\Éa=\ò]ip`C„N«(\êx\ß9›4—3¬3œ\"\Ô\á =Š?\İœ){½\ÚbÁ\ñ,I!!fb!Á\Ësøtÿø36˜\'Æ³A¡ q(£\÷]Y«¶E„o\Ùd˜Q”É¸ACLh\Ğ)\ÙÃ¾¶wŸ<Aµú§¦(¡+\ñšy[\Ğ.É 	¿\ä(}\ÊZ\Ê¶\\\í@¼\à¿ÁÂ«ºœ>5ˆqSqz’”\")R)„>˜\Ë\"g·»\n»\õeš \Ãş•7‹rÅ‚rn\õq\Ø\\\öS¦\ÃÆ |„ši\ËP1@\Ã\ÏR@Ó\àK\â\âGûAÛ6\ğ‹ ŸTÀ¸B{¹\öisC\\¦¢bF\È8 c¨5±… \á:/±u8§¤AµùI$\å#™d¨‘W\è¢›§)#	,Á½ÿ\Z\Ú7±[„M\Ô\Ây™6ı£r’¤\"­¨T$µ8\ñ\Å(…2¹/ŸY\è³²†\\\èI³ùI\Ô\âQEs\Ó\\\ô\ÃG*!°‚P–7!}\Ä\'a !\ÉØ5\ÉM,?\í7¿T\Êv[£\0k¤“3!U8‰ˆa°‡G\ã+‹\ò]qxÀ)B\âg@i†·iXo0$t-ıb²¸¢	!ª\Ğ$©u=\õu:8¤<¶\Ğ½ ]\'0¬4\Zb™†§w`ÑŠ‰%L³)G\ñ\âyb\Ğ\05Yo\0É¥·N¸\å_j¨\ó; š[\rIş\Ñ\É²ŒTe»,\áØ»Eu,Ò¢%7¬1$ÿš\Ò@”Ñ#\Æ\áü %¤E@A¿C2w`iˆ\æ\ô\'.8\×6m™ex3/<\Ô3\ÉY‹0\õ§Wc$’\ÃÊ“l7‘H¢\ÏTÁ\Í&\ÑC…\Õ\Ô\ò•dN	A¦42*\à˜*‡…ZyÏ¡T®\í\ÈA4\Æ:ƒŸ·\ãZ@„I5ÁQV¾<lpGü7,“7+NÁ\ÃŒ@hù,Ú³(\Ã,K‡B‹0dÿQ7\Íª\ÊÍ„\İ£A\æ\Í±?šgIN€tX\Å{an ¥„`\ÇÓµo\Ö\İ\Òşa<#‹\Æ6¿\í\n¡+p@S³yş}82^’	[\ğ64gˆt›/úŠÿ$\Ü\ÃOvzh\0—¸j“X\ä\nFI·c;ú\ä\Ô2·Qf¥\Íxa0»/\Ø\Ñ(\Ê\'!½A\è_–¡\\@!Q#\ì\Ú\Z§\ñw»A½+W$	/z<\ÖQiÉ–.©\Òcxº\òÚ‚—	›dwú\Û@`\r\í\ä)\ÅZµ\æ¶%‹\ÈÃ§\ë\â\Õ µ\ç·\"	Aº.\æ€S{z3±”Qg‡Rcµøˆ\É\ÓF\ò(;\Î&kR‚\'G3\ôy!9œ§\áJ~q¨‘\ãZ€ ÜŒO&\Ş\r/Mƒ\Ş)\Ø¼–a\ĞTRF`\ëBTX\Â1\õ\ãd#ù«\Üs´\ãx\è\åu\Í\×\ó4N%Y˜3ûùÿM?’28\ö(\ÊÁQ\Ô!­F\öÓ• °§k^·\á\ô@D¢°\÷\Æıt2\×.cpŠ7@¬\Ä@i€\ñ#uVs„\òQ\ßáƒ²i¯>PÜŒ0Ç¤(I•ˆs:c‚\ê\çû¶\å^J&¢b%Q>½›bÜ‘²\ÏRg½€rTe)\ÍJnÖ¬#\ó€NFF\ã§Ö€ZR8 \ÅG²\ò\Õ1ZJ¬\Å>Td8	W2›\÷L\Ò3-N\ñ\"d.û s\ÅF°\'\Æ\n.R	c1	n\ö\â\Õ\ñzÜªiz\Í\Ân\Ü^8Á‚)\ÆˆÕ½À%¨’´\êi\Í\ñ¥\Ô#\èr2\èrÿE\êO\í¢	\à…O\ä=LQ°\Ç\ÓD\ræ¸5mq%1\ô\ğ¢‘\Æi1`\Ãr	ú=®#\Ì]f\ÏD˜\â\ç!\Í-Š\àØ¨Àš‡o\à‹@\Â3	\Ñ.n ®‘dl\èefY\ô™a	·šÍ‹DT\Ü6ª/2.\ášuR\"%syŠ~Q\ï\á¥€\ãÛŠï¯ƒù;\Î\\0m\ÈU‚\ÄP¨´¶ˆ˜\ò§o§ŠÿOxƒ>}‰Ábp\Ä3i’˜bd$¼G[Ä¤A#F Db*6Œ‘‰²aÄˆeÊ„fdB82V\ãL¦aÉ†	K&,\Ò0La$IB#\Æ\r•*\n\ÔH1cF„ÿ\"D†c˜NÃ€$x¾d\Êr>lÈ  [\ÒH;IÙ0b2‰	\ã4F“\Ã`’D\áOL\'e\Ê\ÈÈ¢I~ı²•\ñ\Ö\áQ°o\'«{\àí´?I\nÄ&Sš¡@\ßZœT±hf»j)TI™h.1¶–4Œ\×>Ø±eÏ¦½/€*È€(°«Ã¿,µ˜†)B.GQL\Ø{3I\\€\öh‡$\ã‡kÇ±\ĞnE³\Ê&¥\É4føĞ”B}ºƒ	fL;\×\ğ\Ôw\éÑ¦Á\æ]H<†\rId\Â\r-\ÂÀDœjoh´:#4$\Éé«„\Şj\è¸-nD\Ã\Ò\Òe`/Œ\Í\ZÎ®L\â\Úk˜^&ad§À\á¨!°„Š!d‹a=\á\"Š(\ãºk? †+\é¯\äz\ã “\ê(\â\\dd˜Úª¬\r\0\0`pŒ¸úc+7 \ä©4ˆ{¨Æ¤ºT\ê§ÊŒ›n¡\ä¬#\n\ê8\"\r#‡Ki£…ˆJ©\Ä\0`\ÇÓŠ†<di¿\Äj\ô¢¿À²\è´V0pe’‘„D|\Âd\ö\Ñ\'\ÓL\'I”-II+RÒ»ˆJ&\ÅÉ“dº3»\ÔÓ©\ÕXÛ©^6Œa…-ÿ¼+®I€5,†¼(\"o\Ñ\"½l”(M,\ò¬\÷º\Ì39}`j»Œ$ÿ\é\ÅJpa\Ó\ËıQ#1:\Ãa/3;\r¬4z;Oº\ZI¬l >\nc¡ş†;3\Ò0‚DÉ»ŒN(\å\îra\Ü@P`PK\0p(S »ü…\è«\Ê\Ê×ºŒ¤»a}°\Â)Œ%\Ì$™?	«L‡\á	ª#M\ì\ó¯\åªB±®¦,\"±Ç‹®\ãp³´^|\Ñ\Å-\r\êÏ„&\ËÍ±ş2\ÑD\İú\0EŒC¥\Ò¦´ƒÒ„eÀ\Ö$L:\Å\ÄÚ®À\ÂW“,\ği¢4\âFc:\æ\ë\àª\ñV	8\àüú†\ÔLdN†£\Ò:SA2›1­1n)\ÏT™zhÚ…Ár\ì\'\Ì\r\Ğ-\06\ó\÷\ÏÇ»\Ã\Ø ’Æ¸\ôqÿšg’\ç‘/+’HrÃ½Lx¢=«›h¼×º®®…!\Ú\"#™\"h/\Ï-)2Ÿ¶\ğP\"\Ì0JûRAú\ã&\ó“\Ú\Â=\ê\ÆLVy%Š\Ğ\ÍH\Û\"M#H5µ­¼\í\éŸ\Îe.\r°\×z+U@Y’=¤R­|a~\Ñ\na\ÃaŠ$@±\ÑHjI)Xš¥Â‰\á\0\Ê@0Áû‰O9A\ÃBhÅ®I\õoXÃ˜‰0L(Œ˜\à®Anx\ZÈƒ	¹€HA °\\ˆ-ıamc¡)‰t\"sƒIh‚,MY\Zpu—«r\Ó\Úc*\æ;‹UmR„#MP µ4Ø…8AÊ´…3½%\í«’(¦·sebÿ\âI•C02\'ıd#¥!}j\ô\'\È\Ù\Å8\Z‰œ\ĞP¶‡\ÈÀ2\Ñ\âe¦ƒep–©Õ¿¾¨ø%/\ËIHE\Òrá®5$\ÌG;d\"&cTúˆFˆ\Ş\ğ	–Á$n Ñ…ˆ4%d<g\Ó\ÈA*\É1®O\'Ã€[$1‰ŸY¤01p\ÌP\åBa	\r“èŒ©\Âu\é@Iƒ&\èt&3ı\è^\ç;\ß}PƒI±61\0€\n¶$§\"\rE]vqci(%Ç ¡\ËM€VfT\Ò\ï2nĞˆ&&Ó´µ”„N7 ‰qĞ 	e\Ä+q”Y•CPM¾°j€{§²4Ñ’£\ä%ƒ‘R,3z¬Î„½’ÿƒ”qR7ü\Ñ#Ğ™»B†Pj9½yƒA\Ís¿I¥\ËWoI\Ú[2¡\õ!\æ\âWº‚=Æœ\á‰\Ô\Åü”Æ…‘ºZe\0¹…\ÑsT§lÆ…¥Í”m9wyß¤‰Ñ¡”ƒbS6:ÁÁ5R\\\r‘\\ A\÷€\í ±#†FR‘4\ä€šI\\™>W$‡”N7\n\Ñ@­˜ÀlhC†ûKk\èa\Âa°‘ˆ\n“A˜4ˆ¥É\É^ê·«\ÉiCQY\ã—I\ég…\Æ‡Ad\Èy\ØRŠ°ÀÈ‘Š‚q„¥1]\ØÖª\í­c¼×œ`	%\îœh™\è\êl\È\õı!\Ì:ÀAIgÿş)\ì`\Í4\÷Aÿ\ØDØ½L\â\rcÓˆ2¢1*P`*w–Q4b§},C \Ğ\Èd\\H£…UsQ>\n¡\Ô.–8k\"t-\ç¹H#\ä²!¦ J$\Ü\É\êf2Œy|V@2\Ô4\ôN\ÄÁt\"~<RK¬v†\æ ;L[bÀˆ^\Äv\î()H\Â\0´\Ü\í¨?2\ÌV0¨g\Ê\ñ^o\ÅÁz¯©’¸]F\Ú\Ê“+\ò\Å\å‹\êc-«›e€k&ª\Ğ’ı\Õ\"Ë´Hü¾S\Äh±8µ\ê2%L\İQÊˆc†H]x\ÒM\Â\rE\ôM4\Õ2\Ï\ö‚Q\ä\ÙgøøøSeºŠ\Ó\É$H\è3¡\ë­\ÆN>+ÿ³KÁu3üc\ä\âJ\å\r-\ô-›Jœƒ\ä4!g`K«½š0€A$m>ZºDi°Ì—#W^VB=c\Ş`jŒ\è¨Õ‹P\ÆM\Ê\Ôë˜™‡\Í<­\æÊ±Á BƒŒl\Ì:Q\\\Ød+º!µoı\é³B7jqs@	/¢…H«ü\ñb\è*µºIªkù)lH¢Œ?şµFRkk¨/\ô‹È…\"\ô%/µ 	e¸N*·•NP8 I4(»>X\Õb)•Aœ•u#(\Ñ\ĞF`+1\Üd¾\ì\"$\Â\Ï­\òX\"S®¼\òÈ²X&@qQ \\s\"Ä\Ê\öE@RrK\Ê\ğ\ì2\í}ÿ(cP>!\Ï3µ\Èo\Åi\"Gµ\ãD´6\Ç\'r\Ì¼¦v¼=\ÅıXˆR\ÅS)¢,¶\æúw{$hˆ\æ\ÙÛ¤H¡˜\ZI\ì\æ˜	h $\ç~VI¸P4`6©gœ\Ú\É\Ï\Ú’3,† Ü”Gü96Y“¢i­K\ÆÌŒ–Œ(ƒ“\é\åFI\Èrz\Ğ‹`½NV\ÌD!¼:e>\ãQ\æ]£\Ä\Ş \r< J\\ˆ0:VdN¶=G³%E7€z–\Í\é#zBKşÄ„w=c·\Ú2\ì¥S\ñ#UKL¤a\æ9aZ\éQTù]­o\Æ\Ï\é²’Ø’MüB“\ìb\'‰Z†$gˆ¤ú“±\nTÁ¥\\Ÿ„˜,\Ôkÿ‡´`YYš\ó!¸Ã·Ÿˆ©£j%¦ QÑ‡™ƒ¤‘\Ğ\"¡›‡vX90\Ğ—#)TÙ¾ÿ*\é!3¹¸&©!¸\õ: 7È„š’·iY2x\Z¾“?)\'Š>ºL€\é‰-\Ñ’ †\ñ\à‰‰a8ˆ<\Ñ&”˜7x\Z\Ï0(‹ø¥e*¢\Î`À+d\ZŠ\ô§’¸–\öª¯\ò¨¹\ã$\ì~b¿)‰\Êœfzˆ1\Ø„\óÍ€”œŠˆ:IzÀŠY¡™v©j²A´S˜¤ø0À³¾SQ\Ùz\èŒM‰\Öø¬y ¡aˆ„\é\Ö—›¬œIˆ,*§€\Ä@,‹4øÿ6q!’X/©I(£\àÁnÒ–£3›\ïÁ½ê ®+#†È’°\Ãû¨³Œpk9ˆ/¼”ˆ°j6ÏŠ¨ˆ™¬\á	µ 	LI\òP\Ê8Œşp¬†@”Ÿ\Ğ\Ø2û“E\"„ªÃ‘À„t!g|jI\n\à@´a°$¹¥\×BŠ¾š	£Š¶@\"\æP‰\ÌF:yƒ\é[°şz0\÷`4À„Y™h\È-\0\ä\Ä!™dh^Z^@!^X„*h‹¹Ÿ*+\ÎY¸`’\Â\0\n\è\Ğ= À\Å40:\òh¡Ê¸Á\ærª«Qºey*I!Fq\Z	BÁ1¿˜ÀŒ:\n§kŠ5¡F¢¤mQŠ,„´Iø\Õ+¿Ø‚ÿF¬\"\"²\nJjM•\ÊH\ñšˆú\Z	\ñË„O\0ª@¤¸\â\r1`\Çe¨‡‘˜,½\Ğ+«´§\rR&\é¿\Ñ ‰±54˜ü„OÀC9©\rIwS ‰™C‚h‹/»-}X°b—\ã%\Õ\0½†\à5VÔ»ah@¨0i!\òø„¸sÀ \ó§\Ò@:§‚’?ÁEf0¸`G2š„Ğœ,Q¸\È·¨\í .$\Èt\ñx\ò6AŠv@’™![›\ØL\ØJ‰-\ía°}LƒO\ğ\'\Ç27Q‹©²DPºdˆ´¸Ñ¿¾s4b\ğFµÀ/}È„EP\rÈ„á‰ŒŒ¸@Šÿ.\ĞPxƒz£»S’\Z7@ÀÈ”’x„\Ø3P˜¹\ØRIH‹\ÕÈ‰\0	)\ãFhaØ¨v@NŸ¨\Ë)—b˜B\éh\04TP»û£]Ìˆ3<2\ç¢!m¶…\ğ\'4¬£´NŸ˜˜j\Ëˆ“™zq–û N\ÏH”\È\à\Ø1\à§\ãF\ğˆÔ³5L¦\ryŠŒÀ9µPP‚c&.\ñ\n.\Ó\ó\0‹š\\»\Ö\0*Ÿ§C‰\Üa‹\0\Í3ÀxOPT^J>†\è“‹ \"1ºŠP©„KPø„7¨¤\Ö@N`L¸ûz	“D!‘¨X„\ÛZ‘4I*\ğ4Éšu£¨@¹·\á7[”ÿš\ò\ÄA5Ï p!¹)¾2A7fÃ˜À\Z›’°\n\ÌHœ\öQBy‹jûĞ•\áPXÑ\î\Ù&\òª,ı)l\n°±‹Šs—“˜\Ø\Øâ£´ˆ‰\à	za+¼#€\Ç\õ\ì\n¬‚ˆ¯Y\nˆ‘)1ˆ\É\"J´H½ =x‘	K=$!FXÀ=\"\ÕZ•\Äq¿…h€†hXPº°H\Ê	4À…uPHP¨CNi‹Ö°4½°€UNù\ÆI	\0\Ç(§	&9˜Õ½¼!>:\Ï\ÛD·¤“\ÓGb¨…8¨½0(\ÌHµ‘\âDÆ‘•\ğÑ½\ó«¬\ï*(uqT–‹`¿V\Û$IXF¸	™AECiÿpü\Çøs!o|T£\è\ÑA*‰1x–\Òø§-0z\Ø	G#!pœ„_r ¢PC‰-w\Û\Ø^˜z(Uw˜BI˜Ñ¡J+:ZH4\à½RŠ—©Iu\nF\0<h¨\\hh!À‹†L 	\×¹0EF(\ÚILHŒ·À’\Ê\Ï\â»\Z\ÙÉœ¼#8n\âÁ);°n:0İ« ´C\æ\Ê\0—<[Í‰iEOµ„¦¡È?\ÂÍ¤Pœ=Š\ï\"´\Ø*Ÿ:ª>\İ	a\0-¾…!L\ØÿÈZ\"	·…•—…\'\ßS«?š„rœş³Œ4Û½xšQù\r‰nœ0`Â®†›‰Ø¨]\ÅY#¡vˆÿ±À8u55P€PH7\È\ØH\Õ—A\0°1=[Ã„YXAsƒO\ØH€Ce¸±\ã%¡E0\"O``„@¢\Ô\Å1øRIˆLÒ–/\Ú\Ù\ò:¦1™–˜7\ç\Å*:R\Å\â@¤‡+!†0Pe\ÚX\Ã\È\çie\n’«>„Ñ£\Z&2\ò\ñ\n\Ñ\çy[aø\Ä\Ûj\\SBµ\àV¹\èYI—<\Ö@2R\ök_ \èI¯¶`„·\õR1°\Ún]Mi‹\0Uù\Ô	b\è[P´^‘\É^\Ü\r¹»û@¨Œ\õ9hø#7\0I\í4‚8yS†g¨\\’h\à1P7\è\\€\Ü]\nÿÒ¬¸\Î8\Í€	\óR£¡R~+³¥\ñ\â^³2©Œ\àE!\ã\Å\óXˆs(6™+©NDƒpE‰˜Ÿ@=\"‹\óxE«a\Ò\áøaW†b\Ì\ô´O,U^˜e¨4–{L¸D9\ï‚\Õ{APƒºŒ‡= )\İ\È\ê…v\ğ‹„L±µ0X€ÎV:¿hv=‘œ^\è[ I^I\n#\ny¡ˆ\\\Ğ\ÄÌ„…½Á8Ji\0\Ø\nX€Œ\ÔO¨\\Ü™˜ƒˆ\ÑL´\à@8À,\Ò\r\0X[Š1?Ş“r³‹ù¤¥³˜\ì\"\æ{ºh+Ii¬ü¯*Ñ‡²Š­\æ!\'™0¾¨ÿ\Ç(\n†\Z Ú¥‘\ïšÁ(\ÈjÖ™&UO”aÈ„GtQ‹]-½>\Ü9\ñ\É)\ë NI¹\ír´00„?ÑƒşŒOƒÛBú\Í^\è\Ó3\ã‡IFhÔ ùMh@C09 S``‹\Ôù2\÷ˆjd`L”bk#ú)F—DQ\ÂM\é)˜ \ÓLˆ\00\Î\Öx¿\ä\ïJ—ş¥\n\Ò=º)›–Ÿ\ì\ê‘(À7„X™«cÜŒ2msI5…¢~b	y\n\ñrŠ\ÄyŸŠ–;\ZšDÎ´øÄ—©BDg¢L\ÔØ„\\&™\é¯[|\Å\í!\á’h“È¡\é	P\ì…\Ñ%\é‚\Èÿ\n\Ü*)Û‚¡ı\ï\Æc\Ê\ÏÚ±ZQd½E€9¸\İ‡°–Dã½> k²\n\æ\à:	‘·B[z€†ş¶À	IÀœ\älŠW½€8)3r\n˜€°v0Q?Œ¬‚ˆk\ò\Ê. ·\Zûp¡/Z#³Œ\æş£„8©„(#ïŒ˜˜,Œ\ô(\Û¸d›\'ÀúŠ`„ì°ŒÎ¸\Æw2Œ¡Iœ\à…Ï¢\ğ™x\Ñ=I´\×ZrBŸ\ÉC\Í\èo“‹z‘À]‹\Îx\Å\å=†¸\Ê¼\Â™\Ø$…#¡C¯lú•	’®\Ú-°ZQE‘\ğÆ®\àAM\ØdPpƒ\"«\ï	,$‹”[¼\r7ˆ­’Á‰“i\çŸ\ñ‚Šÿ–ukÀ\ï\"\'\ãd‹-`„)‰±€e±\Öpè¿–‰\èU+–£!…À„ª‘²™*Ÿ\Û§‹*\Îø&\Î€\0 b6ù	/\\ÃŒ#×\r»\Ğ\"3ª‰¬…¹€¡½8©a¢Í…k\ğ\Ì!„ª¿ †dX\÷¶øÃ„‘`{\Õ\Î)¬¶Ş‡O`¬Ø‹\ÓHş[’v9ù\æº0\ğk\Ì2Q~^c\ï\â¦¹\İ\ãt\îø‰\0¬iµ€¼šX¸Õ‡\Ä\ãK\Ù£Zq¡\î´6\Ì\r\Ø)\égGE^\çq6İ¼n\ÌM(—¥‹“\ZVsŞƒbú„	‘ƒÚ¸9FX\Îq\í\nJ-œ\õ­1sÿ\æQœ•1•ø©¦\æ?‚()D\×\\M‰×µ€°Jm\ÔØN¦@Ÿ²\è°y4½P{¶\Èu\"œXüÂ‰·%\ÑQ\ÍZ‚Ö‰\Øj¼]jEv¹D1[Ú—ÿ\r¹k(\æ`§\É` O\n“ú$¹<9ÍŸ º\È¹M\ã4N\Õ\0[g=[w\ä^0Ia\Í1s$\Ê@ƒe(¥ƒ(²~\Ò\Ç\Ò8 Œ\ÆA\ã\0¼µ€4°\r~Ú¨\íÁ9\Ü\ğ°†’E‰œ‚¡\Ú5ıø\"\Ê\ÆCKoĞ’±:”hL\å<(\ó\ö› a1\è\ßş%(±¬Lqo˜Ñ‡}0q š´!)€&lXŒ»a½\Â dF\ÂE’x\õjG¯#IŒeR¦,o\à\0ù¤H\ÃÈ¸q#Ç•*c\Ü3Iša\Ã0I³r\Ë\rS\â8\03L4:a\öD³\Â\0\Ë[\ÄX”$iKI\íz\õ\âu®\×0…\Å\à\0+V,H1\Z3ùÀ¡MšLh\Ê\â0ª¶,š7h2i\Êsf&w™\0;',0.000,NULL,'2023-01-04','2025-03-02',NULL,1,'2025-03-04 11:32:36','2025-03-04 11:32:36',0,0,135),(2011,'Purandar Bondu',2002,NULL,_binary 'ÿ\Øÿ\à\0JFIF\0\0x\0x\0\0ÿ\á\0ZExif\0\0MM\0*\0\0\0\0\0\0\0\0\0\0\0J\0\0\0\0\0\0\0\0Q\0\0\0\0\0\0\0Q\0\0\0\0\0\0tQ\0\0\0\0\0\0t\0\0\0\0\0† \0\0±ÿ\Û\0C\0		\n\n\r\n\n	\rÿ\Û\0CÿÀ\0¿\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñ\ğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\ê\ñ\ò\ó\ô\õ\ö\÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3R\ğbr\Ñ\n$4\á%\ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\ê\ò\ó\ô\õ\ö\÷øùúÿ\Ú\0\0\0?\0ı2*LŸ\ìâœ¿(\Å\ìb\Úq\×<R\ã+_+\Ê\ÏpaJkeuIü¿#³:\íªcQ;n?N(c™6ã´@­\nûg½L¶W\ï{\Ğ3±ş\àb‹iI\'\åZ\ZMÏŠ-€g\æ€–d%v\õ\éN?¿‹\æÀ\ÇS]|·ùI¨š\ÇjZ\áv5)l\ÔP\r™Rrsš|-¿9\õª0W¥\î”ø·1À\õ«v°oşµ);nâ‰ˆÜ¿Nj\ÃA\å®ùQœ“Ò›r¶Q¼’l(WtŒ\ò\Õ©\'ùW\Æß¶\×ü\ëAı5(4¿Y\\ù\Ë\rÜˆ\Ñ\á$ ¸\Ïq\ÓúŠ•\ïlfä³L«\å\îoº£–Qşx®cÆŸ¼+\ğÿ\0B¼\Õ5\év6\Zxÿ\0I–I‚ùG°\ÆIf>ƒ¥~L~\Ğµ\çÆ\ÚF{\Èf\ñ¯…´™d\÷F\ØÀ0\Ò–\ÆÜƒ€®#Cı¡ü#\ğc\Ç37“¬ø\é•q\Ê\÷Kqº¢‰$T~:\äƒÒº©\Ñ{³R\Ìı\ñ_ü\×\á/…\í¦˜K­\ßGn\Û\ZHlXÅ¹\ß\é‚+\0ÿ\0Ái~\Z\êVQµŒz½\Ùf \Ç‘Ş§³\í\ë_›?¾:ø~kmj\ÌøV\Ótÿ\0ºšGGH\Û\ï3\áXc‚-p^/\ñÍ§\ö—s5Å¼±™cH\ÛÄŠ0]”·$\î\ÇLŒOA¯\Õc-Lı´‘ú\ëü\á\ìZ\õœ¶:\àûm¤w1b\ß{sÀ¨\'¦C]?‡à¬Ÿ\õÿ\0\\j‹¯y-Ğ»Áq‰—Wo=ø¯\Æk?Š‡\à=†—{\â\ÍR\Öf]Ö°ZÀ\ò\ápJ\îd\Æ\Ò\Ü\0B\\\ñ\Ç\Å\ñ7T\Ô\õvT²Õ¼+«J\ì\äA\ó\Ú\ä«p	\Ú{ú\æ©\àR¬Hş†¾~Ó¾ø\ße5Ç‡u\í?R\òB´\Ç0\ó¡\ë×­w‘¤‘µYVO¹&\ĞG\ã\Í7c\â7Š´\İv\á¼\'uqıŸ¥ª\Ãt\öQ¼J\ä\ç²°\è1\ÇÒ½\Û\áwüû\â\×Áÿ\0¥®\ãe\Öa·*\ÖÖ·cÌ¸$ct\\\ó´c9\÷¬~®ú\ZF²¶§\îUÍ‹•;ªµÚ»¹-\é_ş\Ç\ğZ­#\ã\'\Ä\ğ¯\Ä]/\ÂZ\ÌJ\ÖW¬ûm®\ßj\åzsšûcC×¬¼K¤.¡eq\ö\íÏ™Ñ¾„3XÊ”“5Œ“Ø‰\ä!~eÙƒ‘ô´œ\î\Æ\îzUB›k|\İ?\Ï=ê¹·‘S \â±\òÑ·\Şùh””/#Ş‰¡ı\Ærw\æ€Ùˆn ®b«4z\ó…<SŸ(üT\ò¢9\ë*1*©ùû\ô\ÅW0ù†\î\Ş\ß2Š`Lwi\nvúŠ‘N\å\Æ1R\Èda\Ûw\ğ\ô§\åHùzû\Ó›	\È;sÚ…–<\ïv\î˜j\0Ì•+F¾Iş\öj“\÷Ÿw­H\Ò½1@\Û\î\ß\ócmM„\ÇËº£‹\÷‰\Ï\ö§Jx\àq\Ô\0l¹¦!·\Êp´‘K\ò·ü\ĞQ@y6³\ZY#Ş¼“\Å6$\Û\'sRIÄŠ£øº\Ğ\nß¼Çµ:GÉ¦±X§9Ï¥6eP½Ö€SšsFzSŠù­#I\æJ\0@6¶\n1œSK\Èd\Â\í\Û\ì*EUc¸ı*7[a~\ïS@\ZQ«Şœ\Î.=i±†>›h?½•¡ \Øw1\íRy¬j\'f\å>\Õ…„œı\ßZ\0w˜\Ìy§DØ“w¶)Ö”´\0`\'\ÔĞ£`\Ü)·#>”\è\äÇ½\0Hy\õ…·cµX0|ùşRp\ô®+•\Õv6I\Ën\ïJ ±\ÍJÑ¥¬{™›v	Ï¥	\Ü}.Ikû¯›\Ìp­yW\íiûnø\'\ö;\ğœ·>\"¾u[~\Ãb¹2\İ€€œú\×3ûxş\İ:?\ì‹\áU·µ[=[Å—Ğ¼¶¶-8Œ\Ã\Z®ZY9ùS9\0\÷ \Õø‰\ñ\Ï\ö”\ñ\íU\ñ\"\ËR\Ö\õ;›\ëˆÙ®u7…É·‚\Õ\äÀ†\"IÂŒO$\î<\ã\0kN““±2š±\ô\í]ÿ\0=øƒûM¶‹\Ún¦_$Û´\Ë{\÷k…\n>üç€ \ó…\à\à\nùJ\÷\Çv~\ñÆ—y\ö\Ï^\Û\ÙÜ¬\Ö\ê\ñª$\×=\ğzºƒŒ=¿\ZÑ—Æš†fšÕ¬\áÔ´\r>şk¨%İ·Ì…º²‚q\É\õ®wÄº\æ‰\ãoI«L¯¨Í·]Ef\ŞDQ@Àî«ƒ\Ü\0Mw\ÓÃ¨\îr\ó\Ä\í¿\áxø›Á>†YtYfŸV¿š\â[\çŒI!v\0*\Î0A\àqŒcš\åt?ømgş\ç\Ã\÷V\Ú|hœ/+p\å›q\nGC\İF:\n\Ç1ş\ß\Ğaº{‡\Òt]B\r±Er\î\÷d©c\Ü\ç# \ä\çƒ\\\Å\Ü6¾#¼W¸½†\òi¶©3R\Ì\Ù<\öp98\â·\äFl\è|c\â\õM:\Ş\Î\Âxç±šgx\Ş[=\Ó\rÀ1\ËÂŒ\ànµ“q G n\"\Ö\ã\ìsGÿ\00Ü±h˜\ò\ä&y\\c\õ¬\ŞWÅš„\Òyk0Ê‰…@8P\Üı}kª±û»\ğJ\Ö[C\É6\ó½¼q\õ‘\İN>\ğ\ìF8ú\ÑÙ’Ñµa\ã]&\Ó\á\î·c¤\Ú\ëµbXŒ\ò™b•ÃŒL\ì\Ù+Ğ€ Œc=ë°ø³6•o¬[\è\ğÅ¥\Ø\Â½´\ìI\0f2\Ø\ô\Ëgk\n\ß\ÄQY\Ø^i\ë\æF`0–*	8!\Ï9È¬	¦\Õmf²º´¾\Î\Í0\í»œƒœşµ¤•\Ñ\'Q¡üLR\Ô ¸µº¾\Ómn”›ûXd)pÀPr¬@\ÚGs\í]Ş¯\ñc\\øe	\ÓNŸ46iº;Ë«T\ru¸ù ¬œr=\ó\ß\àzVƒı£¯[\Û6\è\ã’UW<\í\Ü	3œ\ò\ä\à×¡x\ãæ¬]É­G¥\ëKa^Z\ïªH\äu¼u¥«jbŸt;\ë	5¿’\Ë\\X\ñkm\ö/1?{\r„`× ş\Ç\ß\ğPßŠ_²=\õ§¥øš\ò\ãI»¸X\ïme›Ìˆ¡n@G\'.:\Z\ò}\ãFı 5-B+ˆ\ô\æ\ÎÜ›DxcQ!\Úif\Î\'#Ö©xkÁ|9\ñmşŸ­i0ø‚\ÇK‘V\öx.r\Ñ&W^pz\ó\ÅL©E„e$\Ï\è#\öXÿ\0‚¢ü;ı¤­,m\õ¾‘©I	œŒŸ\ìœ\õ?\İÿ\0\Zú<4w\öùŠEl\ğ?\Ìv\ê=\ëù»\Ô\ôO‡^*·»ğ¾¯ª/š\âco*2DI<`\ñ†şUúiûÿ\0Áb¦øaeg¢|G‡P»\Ód…c³\ÕLe¦\ç\Ü\ğ@\õ®Z˜TÖ‡\\*&¬~Ÿ\Éo$g‘\÷x9\ïQ¬œ\Öo\Âÿ\0Š\Z?\Åÿ\0\Û\ëz.¥k©\é—\Z;ˆ|mŸÆ¶µ\Ä2|£§r\ryÓ¥(»3R¸‡s\÷\Æ*7‰°wT¦R\ö\æ¢Xw¶\ê\ÌH\Ş_Ê½1LF\ÃsÒSsüŞ•Œ´\0Ö‰H?.h{u‰•·rx\Å9˜‘·µ\İ[®N9 \"‘¿yNp\Ê2\ß2úŠ‹+¤\í\ïV$”\Æ\0Ú¸aš\0dpn±\÷ºŠI¡hJŸ›‘œ”E#E¸\Ü})“K4P\åW<\÷ !iP±\\v¤NN(†\éŒ;\óšVl\r\Ô\0¨~S\õ¤ù·=¨İ±~^¾\ô²\Ì\Î:z\0Œ\Å\æ¹jx·Ş¾„t¦ØŸ;cgƒÚ€!±s¸\÷©<€\ã¾\êVPÀ\í\ëJ7:|¸\õ \ÉT_½ß¸©c#o¯½2EdO\ğ¤xŒ\é¸;.8 \r!2\Â;Ó‹‰9Zˆ\Æ1´\è\ß\ÊlŠ¾bù‡Hø¦\Ëş£©\ëH\ë¼Ó¼²\Ğü h\æa‰\÷iwm40¼\î\Æh6¬\ï\ó2¯s0\Ù$\ó\ğ©­\Õ@\ïP­_\ï~U!„\Â\Ôs15\Ã\0¿\Å@‘dO—\éQ\îg?uzT\Û—¿\'5;²\ët-7%W\Ó=\ëŸø\Å\ñsMø/\ğ\÷Y\ñ©$1®“g$şKJ¨\ó\0¤,1ùG {WUº¦$*/L·\n}O°\Å~-ÿ\0ÁO?n;\ß\Ú+\ö’¼\Ğl~\Ğ\Ş\ğ[Mb<m3œIqŸpª€\Ó\Ç9®štÊ”•ø…\â}C\ö\Úø»\ñP\ñv£*\êZ–œ\ïk „µŠ,\ÈÑ¡¸\İÁ\'\æq\ô®Oøgc\à\rcI_\íK9/5\ö\Æ\ñ$L66\åF\Ñ\é¸2¸\"¤\ñ.™\ğ\Ú\×S\ÓfXn–_>vYvH°\å³c”¡\Çoz\Ïø\ß\ñn-G[\Ğ\ä³\Ñc‰,mü\Û\Ø\æ]ß¿ \0\í\Ï\'r03;Wtyb¼\Î9É½Œ_\Z|G¾»\ğg‹´6\İ.´}>\"e…B\Åû\åV9\ÆYN8Ç½Tğ–“¡øWA\Ö\ô\ÍCY¸„\Í\áW¸›\ì\ğ‰\ÒIûÕ†2€qÔš\æ¡\ñ­\ÂxJ\×B’\Òh.şK›‹¥#mÀ\Ü\n«\ë‘\Ğb³o\õÛ›\Ë8\ôf†i5”k«¬(¤M¸\ö\àq\×;FW\ØÏ•Ø½\ãm*\÷B°y\õ[3\n\áü\å‡\Ë$\ìF:\ØW<U?\n\Ë6+5\Ä\ñÈšŒ@³0-„^\Òz7Æª\ê‘\ê^\"\Õf\ò\ï#µ•‘ZV\Â\áN\Æxš\î•\'\Z\r¥Õ½­\Ğ\Î\èv¨‰ºq\Ø\ò=j\çÁQ\Å\â©\í‹\ö>züÊŸ\Ä1ß¦3WtKkø<;6 †H\Zv¹µtX\õ?¥Z\ñ°¹X\í\í`û\'\ïb…ŸJj\ér¦Ÿ§M‘˜\É\"˜\Ğq\éÁ­=£H9]\ìs¾!\Õ\åÔµ»Y\Z\İUí”¤’§şµ\òfø~kˆef¸y\0Á\ësık§ÿ\0„RKx¡\ó¦få”¯1œœƒúQk\ğ\×T\ñLª¶¶3ü¯Ã…Ü‡Yº\Ñİ„h\ÎN\ÉœK<\Ë*«4\Òq&AÁ\ß\ğ\æˆ\ôÛ¨$«k!\Î\ë–\ï\Í{Ç…d\ÍR\Ò\Ï\íšg\\Í\0¶+¶ø}û\İjû`šh\Äx2\"–Ú¨¯\å\\r\ÆÁJ\×=\nyeg\ì|·£\Íy¢k\Íqo\æIq\Z‘*}\ĞF\×\ñ©-/\Ì6“£»IC†`$ \É\Îp}y\Í}‡\áŸ\ÙB\ÓBº¼x¶\ß}Œ0,y\ÜI\Æ\é\×\ñ®KÆ¿±\ÕÔš\õ\É]\Í\æ(*v\íTïøü),lQ¼²²\èxm\ö¼5k	&š-\Ä\Çj°ùŒM\Î9\íŠ\Üø9\ña|t\ö\ZµŞ¯&—plÑ¨m\Ã`+*‘‘“œ€GJ\è-fıb\ËÆ…¤Z®%r?vHü>•Áøû\áıæ‡¥ŒÈ±««•BW¤\ó\Åo\nÑ–\Ç+\ÂÔ„›hû\Ëş	\Çû~\Ëû\ZüX¸\Ño¼P×\×g‰<¹ ;müÁ\è™NUGp1Óœ\×\í…µ\ËO\Zøz\ÇP³™n-\ï¢\Å*01¸#9qøW\ò\áa\ã­I|?c5\Õ\Äw‹h\";\ôbA\ËNß…~‹Á?à¢º—Àÿ\0Š:\ÃojR7ƒübG\öd\ÓÏº;	\Ü\õ²Dy]¸\õ#šÎ¥>f/h\Ø˜\Z(;n\ë€sŠ„‚¸Õ¡rX\Ş0‘p¬\0\ì3\ëT\çˆn=kÍ©cD\î®1C¡\çm#/Ë\õu\Ç\Ï\õ\íRE\Î\àúb³%b_šz\Ê\Ì{Q\åä“‚¾™¢ 0Wr±\ë‘@ \ó>^[¯=)©\Z\å²\Íş€G \ç­$²/\Ë\Î9 •Ç\Û~jls\È$\ÚÍ:U„h\æo›ø*9a\ßqº<\Ç?Z\0ŠY1\Æ\Úyù”v¦m,ü\äjx\Î9ü(\Ñ.^£yŒR\í×œ‚¤I3M‘ü\ñ\å¯\×4\0Õ“\íµqš%\È<v\âœ\æ8À\Û\ò¸\ã\ô1`?‡\Ô|\õ©2¯\Ğ\ê‹Z’<\Ï~h\í\'Zw›”¿Jip­\'\İŠ\0Ğ—lb”®søR\0\ïp¼S&‘Q“›¡ \0»nû¸ú\Ó\ÒB­\ò±\Ô\Ùf\Şø\ë\õ¡c\Ús\Í\08¯Ï¸\äŸz\Ü\õ\éC>\æJz\Ó?Z\0E‚W\å4\ègY\ç\î\ñŠ.O\Ú\ò¶;Tq7–Ê¹\ÏZ\0VwšE*¬v\ä\Õ\Ñ‘4Œ»Twc\ëU\íÙ˜ı\ãŒ\ç&¯©[\èz]Î¡u`µ\åuU\Ü\ßC…\à9ª‚\Ôÿ\0\àªÿ\0·\Ûş\Î~·\ğO‡n’xŠ\ŞF–U9k;l0-\ì\ÌF<d\r~M\ÙE§\Şxª\ÇO\Ô/&™o\æ\öù“\÷fU\åœ7rA\ïœg<W¦~\Û?[\ã\×\í;¨\ë:ºIwrùa£†\×~!O\\\áKu\Æ]¸\Æ\0\ğ\ß\rÀ¾8µ\ñˆÀ·C•–XX\á’’E{ƒq\ÏJ\ô¨\ÅX‰\ö;\ÏüV\Ó5‹{/O\Ò\ã†8ü\Ëss,C\Ëf\Û.\ß\öI\'q\î\ÇÒ¼[ş\ïR…o\Öi®¯\×Ê¹~bÁ‰\'Ó¨\íÚ½Ã¹°´1\Åq$Ÿh…¼ø‰\Üfp7\'\'\ÓwoJ\æ¼á¹¢\×üë¤•¤Œ”\Û(\'\Ë\ÎrI¨©Z	›\Ó\ÂNKDrcKº°¿•J}£k™uÚ§·\èkk@ø{uªxš\ÆDU·“XD.Á–(Xœb8À<\Ô\ï#½\×\àÿ\0Á¸ç¶†ù\ì\í\ï6\È\à)\ç\Í\è\ŞøI§_^\Íc1m1C‹ˆC¿ú¹Fn™ƒ\×\é\Z™’‹´OS\r”9|G\Ï\×ß³~¥u©Z\ßIfn´™\æş\Íyâ˜¼v7\Ã\Æ\ç¾=`kª\ğ\Ï\ì´\É/\öm\Ä,\ò\é\Ù\ßº´7<\ôë•\õWÃ©¬\ô]\ëK×¬\í\î´\ö\Är]´\â/3p\Æ(\ÇÍŒ‘·<‚NƒK§øj\ä\ÛÁqk©5°\òá¹†P¤)\ç€¸\æ¹\Şi+š\É\à´>\ñÂC\Ãş\"š›yv‡·”\õ\êF\Ö\ê*\÷„>6©£Ao4{>\Ãp]T\ä\Ü?\çÒ¾¾ñ‡‚¬u\ö·¸½±··\Úù‰¼\ĞÅ¾£\×9¯øj\×Ãd‘\Åi$Áw(#‚;VSÍ§².9-;\Ü\ò_ü²²šin-–I#`®\Ã\'!¿J\ì|-\áK=6ÁW\Ë\Ù\öv\'hP¿-nxz\Æ\ëV\ÒoüÅŠ®6”f—jJ\Ço§„¼C\ö\rZ\ß\ËVP\É %¢œG\ğ5\Ë<\\¥­\ÏOƒ¥I+#sAk\Û\ÇX6Ç¼`\å³[Ë£¬¨#£\Ç\Æø|\×/\ô\õ¿’K8\ÖY\È>µ«·—v3J\ñŒ·N>•¯[Œ[½’\ÓGŠÁ\å’9n•±°\r ztªZ\ÅÔ—¶\ì»<\ÈÁ”Œ\Z¯a\â\Æ\Ö,\Äq™”œ5!0¤\ÏWnÒ ü\Äú\ÑY\êÌ§\íb¾§¢1´k[xcUnHr¿\ç5\ÊüUøW¥kn-\Ö\Éc¸\ÚB•“Z\ì\í§\çÌ†#/Í’I\ÅYÖ¯¡º\Ğü•j°\çıu\×G\à\Î\Z\ô\àÕ\Î][\Â\ÒhzÜš|Ÿ¸a,‡¤€tü\ëc\Ãz\ö¥¢Ûº\ÎÖ·\ÚK²,ÿ\0}g\n}U—#\Ğ\õ\Íz_\í7\ğ¾\çDjQ[\î…XÉ¼\õ9\È\Ç\é^M\ámj\âKYmdV“Ë“Í¹\ßL\ó\íN\õ\ô8jŠ¤G\Ã\ã(ºUYû\õÿ\0‚ı·fı³¿f\ã\Õw‹<±\éú¢\Éşµ°Rf\ç\İıÁ\è8¯¨.n\í¬¬3¦85øAÿ\0ƒı§\ì\ãûth\è·\ï‡\ãÂºu\â;b9NŒ·A\õû\Ë{d°\Å\Ì\ê\Ò\0\Ä1\äÿ\0®Vu¢·&œ“ET„mŸ­F\Ç0\îP3RJ2\î¦«\\\Ê7q\Åyş†ƒš\æF~\Ò1”¬‹€J\÷È /™n9£v?Â€\íÌ£j¶8$zSüµ\îdùA\à\Ôq\ÂWs\n­Á®i\ï\Îü¸\Ï\Í@\n\Ï\Z¶c\Ãg¯Ö£\Şf\î‹\íBÂ¶\Ê~VİH<S¤v\òp\â€#23`u\ëOcü¨ˆ¨6iTù\íÊª8 €§­8\"ú•\÷Ö‹®~”y{\â\ãÖ€\Z\ò«>İªOcN)»¸\ã€*6]ƒŞ”²…ù·}i\ò,qD\Òa‡nµ¿•.\Õ\åş¹¨$›\çÂ°?Jq‰¦é»Š|¬	\ä~4\"x¦™³\Ñ\å\à\Ğ]¶\çkT|\Ë\åÉ»\æ\Ó»\0p\Ç\ê),±\İN\Ù\óf€/»¦i\Ã\é“LÁ»t¤¾Ÿ^\Ô!‹pÜ´©#gkbšs³\éIÂ–\ïš\0Q\ó\ÛjA\å\ÎG§Py\àšt@À0}i\ò4AP\î\çoJ\ğø)\×\ÄÛ…±Œ¯¡¼’\ÎK«?³Dcû\ò32\å\ïı+\Ş\Ö?—p\õ\0|\×Â¿\ğX\ï‰^ŸÄ¾\ğN¯©ÿ\0g\Ù\Çpš¥ü’\Ñ\Ë•b€?ˆ³“­i\Å\Ş\Ân\Çå¿\õ\é øs\Ò~úM6U’\çr\ÅJ«¬|ÿ\0t0ü\Ípú‡¯´\r*\ë\í0\ŞG\'ˆbk‰\å<©r´˜\í• z`\õ®\ë\âÌ‹\ã‹\Z6ŸgšN•\â-r\ö\ò\ì9Gg	Œ\â5C×½p¿|I4?–\Ú9¼\ë{‹X\àŠXØªKŒ—<.K`u\Îy®\É^1·S:wu.\ö=\Ó\áVƒj\öúl“şüÉ‰¯fıl~\Ğ^|>\Î\æ\ê[€˜º\æ?—<ä¤{\×-\ğO\Æ0M\á\Ë\ìÛ‚ª\ì3œv8¯B}VG	p­Ÿœ°\ã¹ş•\ó8¬D\ã&™\÷¹uºiØ¯\á_\Ú\Ç\r¬L\Û¿\r\÷\ï[Zf©ı£¨Ÿ2%‘›†<\àú\ÖtºÇ™*$[~2O\ñK\íXz–»\"\êmD‘³¹;@ÿ\0\Z\ái·vz\ÎTzß4\Ë[¸\í\ï£o.>kJ\ã+›—\Æ\ğYjR‹¦·X$\'\ËH\"+´v\Ç?ÏšÇµ\ğµ\ö³ª/—’M!\Ú$l²ş>\Õ\Ú\Ø|’\ğ\Æ\×Ğ™#ˆch+Lş£˜\ÅR¦º\ÈM;â–¤4eûÚª•D\Ê·\Ó\ßN\÷MŸÄ°3\É\ó4\Äï‚vœ´\0ü»\×k¢x\n\ÏÁ\Â9m\ô\Öy¢b(\ó™\ãÿ\0\ÕR\ë!\Ô5]\'Ê¸K]¹!%D\\‘\Ô| sŠ[ho\nw\Ø\ñû9µk{\Ëd ‘\Ï\ÊGj\Û:5æ«§Cm4‘›xy\òÁ1“\Ïj\ëŸI·\Ö\í\áH\ãk1w\ín6v\ëøUH|)sªE\å\Ã\Åc8 ?Ê¾\Ô\\¯b\Î&\Ó\ÂR¼\Êøu\Ü\öF+¢>¸¶š!!+˜o\ë\ï]Ş›\àµK8Vkig‡\Ï<J½m¦[˜Ô¤pG1\Ë}\à=…\Ò\Äû=lyŞ›u‰Ã˜›ª\Z|©»5\Ì{eû¹\Új·#6Ù—r»søV^©\áoµ$O2P£$\ãU*‰œ\ó§fg\è¦6ƒ™# \Ärz\ğ+?S–O¶.\É6\Â$\êT\Öeİ\ö•}¹¤¸1ùaÙ•\'ÔŸ\óÒ­\Ã}²\ê8\æ\È$\êˆ\Ù\Ø}MuS2\Ğã­¡\ñ\ÃÁ\é\ãjÈªÌ±ƒ^0Fk\â‹\Í\â\Û\Ä7p³Ep2Kvb:ƒ\íŒW\è6µg\ö¯ü±©\í\È5\ğ¯\í}¾(5\æ\Ó\ö;‰¼™€ÿ\0–d£ü\ö¯k+›\Ö,ù|\ë’\æ+\é\Ö\ß\ğü@\Òo\òCo±¼l§ıC«\Æ\Å\ÇpG8¯\é‹\á\Ûj\nü?q%û\ê\Ñ\Üi\ğ\Í\r\Ûı\éU“\Ğ\÷¯\æ·\Å:t1x\Ú\ÃpE‰.­|\Îc—\åÁ\ëŸ^ W\î\×ü\ï\â\İ\ç\Æ?\ØÁ²\\3\\\\h\á\ô\ò\î~pˆ\ä\0:\ï\Ä+£ç©»;HÈ§v\ç\àz\n@\Êy\Ú±§<Bhı\êÛ\0\Ô.\Â2	û cŠ\ó‘\Êû\ô¦£\Øü)Á·şT\Ù78ÚŒª\İy c\ò²\ã\ÜSš5Tù§m\Ş\Õ]-r\Ì¥VÚ¸\ã\ñ \ßj–Wa\ô¥K¦d\Ú#\Ü=zR\ç„e_lTSF\ğƒ1\î(`»£\ÚU‡~´Ù¡Ú»O\Ğ\ìGR¿J\áv–fnÙ F\Îb\ãn\Ü\Ò+mOÆ˜—\÷¤\Û\íŠrùl»¼\Ïn”\0œ‘\Èc\ô¦\\6xùút§y›Ÿ†\ãÚ£’9$;•†\Ñ\Æ;\Õs?‡oÖ¬™Z8†\Ó\ÎsQÏ·`-»>\ô±É¿ºúsO˜	™·¨l\à\ãœSQœ¯w<šj\ï~U’‰\ò³cÒ•®ª«&~´\õ\'4Äˆ°-3OS\ò\à~µ 4Eæœ”FQ½Œ\Ğ[\É;¿†œ£ty uÈ ¦\åŒnú\ÑŠÿ\0)\È5\Z¸S‘zÜ“Ş€M\çaM2\æ\\I·ø©\È\Ø\Ü}r)²¨Nœçœš¸\ê\Ø\ä1\ØJ[$¹q\ê+\ò3ş\Õi´}J\êG†\İt\Ó\öb\ë»\í$,\Éü¿:ıs´O2–lc\ñ¯\ÌOø8§\ÂÚ†¥\ğ\æù–´\\^ZI+#\"\ãqü\Ç9­\éE¹SD~Yx\Äw\'Nû\Ô\Şdz}\Ë\ß&e*\ñ¼˜\ãp<”~\Í\Ü\ê“j~\Ô5k\Ém¥ˆ´\Ë0\ß~ \ç¸\ÃÆ·¿\á¼–\êF¸´\Ú\÷¢+(!#\'s1Ï¶ü«\ÏüY®2x^\×Ed‹­<’\ÈR¤ ü¶g\ñ¯NTù‘:\ÒM3\é¿Ù‡[ûV;X¦O\È9\ä\0	üÁ¯Y“^™®<•\ò\÷/ƒÀüú\×\Ìÿ\0²¿‹¤\Äg‚_/wÌª:zJúJ\ò%Š4’I6\ÜI\ÉÀ\í_%™Så«©\÷y=oiOA·ºmÆ§*ş\ò6e8PİjxEº—Q	\ã\r»ø€\ç?Z\Ã\Ó\å\á¢\İ4\Ì\ÙÇ¥wKË£¶HÂº \Ç~µ\çÉ£ØŒ¯¡\è^\ğ\åÅ¼¬qO!\Æ]?CŠ\ô\ï\n\è\ñ¸…s<\ÎL\ÃkC\Ó {û\×!\àKv\Ğ-#I$+!\Îã‘´\ñ[º\×\Ä3\"y+\öVk2yA\ï\ëYûE{\"’m\Ø\ë<Y\á-\"F‚\ö3\å\Íû¨\áûË>bzb¸=o\Â™\ï#ùn¾b\ÆG}¬œ»ş5‹\ñq ·’1q+\åNy«\Z/Ä¨u]¿jºg\r…(Pm\0~ık9M\Ü\í§\î\î\Zw…\Õ\nI$${HXU6\ßZ]/‡\ï\ö\İ\ÅŒnùÛŸÎ¯\ê\Ş<!“É™]p\n\í^S\ØW7¨ø¾=ZÍ\ò\Ô^+1o\á\àr+>fmÌmBú\Ô\Úy’^IpÅ1 TÇ·Iµ¸~H \ğÁ·1ük™Öµ{\ô\æƒ\ÎeP¿*pX~8®;V\ñÍ®“f]£e\ä±5µ8Jz#›ZG®\Ø]i\÷o½¾Ğ¬~g\å~•¿¥\Ëosoåº§\Êq„\×\ÉZ\ï\íK‘+G\â°NOz\âµ/ÛŠk\óº\õvƒ€¡\ğqù\×e<¶m\Ü\òjfPŠ>\Ş\ñ.£Ál\Ò\Ü\ãVW\æ\Z\óû\Ï\èz\í×“gqZ‡D\Ú@Y¡\÷¯“¼Kûc]x\ÇL–\ä˜v_¥r\ZO\Ä-Y5û{•\Ô.#¸A\æG)\àrx\ô®\ê9|\ã¹ÁS4„­c\í\ËKK¿b\Ò\ò\İ^=\ÛX»\òWü_\à\ÕÆe»c§\ß7—:¨ûs¶½¯\á\ídu¸-lüI\ç\Å\Ê2zz×§üKøyc\ñ[á­ ·“7\Ú!c‹ı\ö_‘†s\Ü\ZÚ5\n‰3›Ëˆ¤\å\ó[À¾\'“\ÄZ]O’6hTr\Ê\ñ\ç\ğp1_µÿ\0\ğoOl\õÙ—Å¶´‹\r®²$€\ç¢\ËG\÷\ØjüQğ­”Ÿ\nüe«Y\ÜÂ­\ö„3Ão¸ü?ZıZÿ\0ƒh¼`,|w\ñcÁ\ê\Í%Ÿ“k©Z$Sd¥xü\Ï•\ôJP\Ğø\ØÅ©´\Ï\Ô#\"/;·œv=\Å*K\Z\õ!¿\nl†Bs’W«}O&š.\n\ğª×Š\òdµ:\Ós¹¾U-\ìJ\í1|\ÅUOQPß›jü­\ê)<Ÿ›q;¹©\å`9A\Ş?Jw\çø\Ò;\í_\îı)UÁ<\ä\ñG+’.M3\ÉÜ½O\ãNwV“\0\ã\ëNx™G\\Ÿj9X\r°^™ #w§X\ò…\âoÆV\0‘\Ê\î¦É¸–£rÀue>™¥8\ò\òY·Q\Ê\ÅqTmm\Ù\õ\íMVS\ò\î\É\ë‘F>_™ğ¾˜¢%Mß»\÷\éG+¸\Ç\ós\ÏJr@6\î¨\ÌÛ‰^ù¤‘\Øqü¨\å`:GÁ\Æ\ßÊš\'o#½$\î“;š¥s“»ÓŠ¡\\\ÒVÀ¡Ÿ1L+¹\îiUpMf0-\ÎO\åR\òı\Ó\ÍW\Ü\ÎJÔ1X›\ë@,J{µ@_º[šŠ?™\óH\÷\ÛÛ­>P&šÕ™|\ÅùGL\Z‰Ñ¶\î?w§\ãO7lÁAl\Ñ\æ—hù”SŠ³\öš›\áe\Ãaø¯„ÿ\0\à\á¿C\â_\Ø\Ò\Î\â\æO²Ç§\ë\å$\î\ÌÇ ú`~u\÷%µÛ‰¶ıß¥xwü\à9ı ?b/\Z\è\Ö\ñµÆ­\ö_;N\\e–U;‰^?º\ô®ª2³»&¦¨şz\ì|m©x‹É½³ey´Û¢I#‰U8\ô\äş5\æ^ EX´û\È\Ù|»‡šY®~|‘ŸÆ»oÌ¿¾0i\ö6\ó%­”š}²\Í33©,~»‰\Õ\Ë\Ï\á¯\í\r\Z\êi(c³¹k5\0œ’r\å¿Q^¬d¬rGDjşÍš\ãh\ß£\îa6\ã\ïùs_i\Új0\êG>\å\ÜG\İ5\ğ_\Â{\ÖÓ¼Qo\"±Vg’z\ğ+\î¯\ék¢Z3#y·-Æ¾k6Š\ç»>¿‡\êh\Ñ\Ñxc\Ãwš\å\Ò}–%X\Ô\áŸ\õ¯~øg\ğ\Ş\Ã\Ãz?\Ú\õ+ˆ`iHn¦¼\ßI\Õ,~\Z|=¾\×5	<»{S\ògƒ#úÒ¾{øû]k^0»»kyf‚(È™ù@¯&–\Öv\è{Õ±jŠ\Ôúû\âÆŸ\é\ö\ò[\Éy\ÕT \ÃW’ø‹ãŒˆ­k)vk\ã-úW\Å?ş<_\\\Ê\æ\ãknİ•?ız\âu/—Jş\\\r#7?/j\ô)\äp\Ü\ò\åŸrèµµÏŒP^ùš<7\ÊÛ¸ªz_Å›‹7vKÅ“w8\Ü0+\â9ş.øƒS™c&\à)<cœÂºO|D\Ö-˜¢–_S \â©\åOB¶\æ\õ>\ã\ğ¿\Æduc5Â«l\éÖ§›\âÍ±\Ö\íœ1\É_ojùWÁ¿.®Ÿl„³mùŠœq\í^©\à\İf\ïS+n–\ì\ë\"|ŒÇ‘\\•0\\Ç¡C0u#tu^=ø–4ˆ\ZE,°“’k\ç‹\ß\õK\ß:;K©!R\Ùû\Õ\ï+ı›\õ›ÿ\0µÙ’F\Ü\Ì\Â w–8\ãRk\æŸ¶›\á=B\èkUÑŠ´D\î\Ú}0;\×n\Ü\ósMD¯\Ü\ó;ùµj\ğ†¸•A\ç´4Ï„š\æ²\é¶o™›¯Ö¶\í<Eu«³`\èO$)Éša±\0\õ\æ»?ü\ñQd½Ö£\Ñ\ì¤m \Ã#<¹\÷¯z4\Ô\ò›Ô§\á\ï\Ù\Ã\\-×—«:\ò\òJ¨\0®\Â\0\è\ŞÑ¡[¿irÌ¤•Cp„{\çœÖ¶‘û/xv\ëWƒK›\Å\ÓjÚ…ÃªEm#I0¹v;U\Ç\ó\òŞ€\ñ+¼—\à7„¾xy®®<\áR\Î4g:Œ²N\ÑÁ\ó#\ïB ‚#¥cR£¡\ì_s\È$\ñ/‡l^±h—$*J¬,ŸZ\õ¿ÿ\0ÁE<%\ğ\Û\Ãvvs}»Wš\İq\æÛ©e\ÛØ“\õ\È\õ®\Û\Å\Ú\Ã‡Ÿ¼\âo\ßxo\Å\Ók¶\æ\ïU\Ò[\Ã)\Z>\Æ \Æ\ó>C\îª\à\ó\ÛWş\nıû(|\ğ_…ü\r\ñ\àüp\è¿\ğ’h0\ê\Ú\÷…­\ä2%¢´¦3t¼\åppS8\ñ’NR\å¨\×1^\Òt\ãî²ŸÁÿ\0\ÙAÿ\0‚œø\Ë\\\ñ—€ü_¦øv\ïM	¡¥\Ş\Ù9}\Òd‡\Èaı\Ãø\×\Ú\ğN¿\Ø\ö\ßş	\Ù\ñ·şs\â6“}c\â1¤Ko%³Z²\Ë+\Æ\ñmb\Çw*F\n×ŸO\É\Ï\Ù?\ö\ñ\ç\ìo\â]_\ÄŠ;¨|Cã•ˆY–6l0\Ş\Æq\ìk\ê/…_\ğR\ë?š˜\Ş\×\íüJ·pŸ>\æh\î-m\å‚\áJgjB’pI=\ê«T©N6\Ä\á\éÓ­+Ks\÷m\Ì\êf=\Ö\ì\ÌÛ°qŒœv\ÆO \Ï\æ©\Ş6\Ô]Ñ´e†FWi={dşµø¹\ñ\öÀ\ño\ìß¨\Ú\ëWµ\ísÅŒ\ÂE·å£Œ\0ıWú°¼\ãGzıDı…¿k\Û_\öp\Óüam\">­ú.¬…\Ù8U;\Èˆ`> \×\n­\ËCLvU:1\æ[¡$q»g‘\ô§%º”ÿ\0X\Ã\êi\Î\ã\Ï+´¯Ö‰\×i¦j\Ï2:+\Ë!ù[q\ÍH#\ë\Ï\è\×\0\ô*Å\Ì:b‚¹…ü\Ù(¦=*@\åv®OSŸJŠY~nO\Óy¬\ã\å=±š˜&»\Ù!\ì)¢\ãx\ç0\0²ò£­U¸¹\Ã\ãn\0\ã\ë@sA#\æU\ÍDK3ü\ÜRÃ¹\áb§¯\ãI30\Üs\Å=\É˜¼zT72‚6·\×\"¦¸ùO\Ã\0\Z\nLQµbG\ãHÀw&œ˜ª¼’~u\ç #¦(10•£.\ßÆ¤U\ãü\ÕC\"‚>o~*x\æùÆ‚\æÁı\à\\v§\'ËŸz\\ù\\qI»y©\åfƒD`6h#h§HÊ¿w\õ¨EU\Ü\ß{Ú¤&\n[\ÍûN\æ^:R=\ŞN˜qÓµ\np››–\Ï´[\"\È€Ñƒ\Üb\Z\ÆL\ò\óÒ˜®\Èx¤Zo›-\Çz|¢¹:\Ş\ï8\ö\ÅhÚ•¼‰¼Ğ­FS¸d\0q»\ó‰¬¿/?2œsŒUÈ‡™fË¸Œ°8\ß\ãZGB%©ü\Ìÿ\0ÁW~\Í\ğ›\öÿ\0\ñ¦—\ösW\ã\ìQ…\àÅ·z\àz|Æ¼½\Ş…R+@cº{\ÃtŒ\Í\÷\Î\Ğ9ık\õ—şMı“c¸\Ñ4?Œ\Z.“\æ_Z\Æl\õIbŒœrLl\Ø\è>v\É>‚¿#¼	\ğ\Ó\Å\ß%‚\ËÃ¾\ñˆ2\ÌË¦\ÚMvy;‹*mQŒ\á^•)\'Nm\Ù&\Ì\Ã%ÏŒì•€UÕ€_\â=?¥~Œ|4´\ç\Ã6.\Ù\Ú5\0{\ö\÷\õ¯‘|3û\rüb\Ñ\õ«=j\ã\áŞ¹¥i6`\Ü\Ü\Ü\ê\0[\Ã\É\Ë=…}«~\Ö\ß>\è¶\ó]x\ëT\ñ6¥\Z¯™¤xcM`Ğ¸!\î\î6F¸c”6®x\ò\ó\n.«\\šşYUa\â\İM\Ûk\â\ô\ÚÆ£o\ákI–=;G#\Ï([KÕ²\ÅB\÷u\â¾uş}^\'‡O‘\î®&ùH@\ì\×ÿ\0Ö¯_\ğ\÷\"ø\ñ«\\jøK¢\é\ö¶\ê\÷2\ë>0\Ô$\Ö.$\Û\Ê8ˆ\É8\Â2qV\ô½\ï\Å6_gÕ¼Iu&\éµ®‡a“k¨›\ñ€?Œ>Q½¹XŠ»¼O\'´ıŸ,¼˜\ï<G¯XÙ†ùŒS8ˆû\è“ú\n’\÷Høk\á°Ê·\İsä¯˜Xû^‘g\à^\ê\×V:‡4—ÿ\0\ñû«js5Ç“\ë‚\ç½;\ÖŠ\æ\ğo…¯a\Ó\ô\Ù4\İcP•ü¥\ò TŠG?@1[FN\Ú\ÒÃ­\Ù\äúÇŠ<+°-†“­6\Ò\0\ò\íMc\ê1\Ò\à\r²\ÇX}\'¶e\Ü\Ï\ñO\Õ5kÅ±±š\Îm,…”\Ä”9!\ìyk_Á^1¹\Õ\\\Ã%\Ôwjù*²\Æ3\×9¬kYX˜Ç¢<\ã\Â´û-Z-\ä–ÿ\0\Öù}T­z…—\íı£ø= \Z.„ÚŒ\È\Ã-+ya{c\ôıkœø\ñ\ğ\ÂW\Ã3_Co\r†­§©•š%\Ù\çGı\Ü:\çßµ\Ìş\É²ˆ¿k?ˆÍ£\é1K\ömª\Ò4	½‡8\Ï\0ûš\ÙQ£V7™\ÄV¥UB–\ì\í¾0ş\İ~;ø\Ù!º>\Ñ\öş\ñ-xy=A|£1Ò»€Ÿ±<~&øiŒµ\ö“PÔµ(š{\r9Õ›\ä\Ş\ÛZF\Ï$\Õ_\ãüW\Å\ßü!yy¥É«j\Ò\ée\Åş—uj©4P€A™NÓ·®\'Ó}s\öLı¥¬fıŸ¼/q¨+ÈºIşÌ¿d\É{vC„.=]H\í\×5Œ•C\÷N\é´£^rıú±\â-F\ÓoÍ¡\ğC\Ñ\"\áWPÿ\0\õgZ\ğ7‰üI\ğn\ó\Ä\ZO\Ú#\Ó\í6ª\ÛÃ\Å	\äŒzW³|hÓ¼7\ã_\İ\Ş[\Èmt\Ó\óŠ3)\îG‡\á\\ÿ\0‡~%ÿ\0\Â`\öº;\\[Ù±l®¥\\zc\Ú:Æ#›sya\í±\ó‚.µ?\ë–z\ç‡oµ-?ÄšM\Ê\Ü\é\÷\ö·D\\[O\ÈFz†\ĞWÒ¿ş]ü#øg§ø\â\ï\ÆúŒ>4\ñ7W–\Ó\Èg7\ò\ÊI}\êy;»’k\Z\Â\Ò\ÊO}¹“IµV3b(P§9\à}k¬_\ÙüRÔ¤šûV’\â\â<¡’\ÊWû£9\Æ9ü\è\ÄU‹I#›\ê\í³\É48µ³xn;{\Ó¨ûŸ	o(8vŒ\óø\×\Ô³§ü»K\ñ\îƒ\ã\õ\ñÖ¤¾\"_\ŞÍ§À\'f|µ\ËBÛ³‘‚ÎºO„ş\Ó\ô	c†\Ê\Î8¤„c\ÌeÌ\Çsş¯¢>;x\Ç\Z{I¼­İÅ«*\÷WO™~„c­rık–I\Ó\Ë\ÛWgÅ¿°…´­g\öb\ĞuV\Ó\í\ç\Ô,\ï\'‚Y. HIR`°®\â×…\áøûA=Æ‘kjt_ˆ—‡+\ò[^! `GJ\õoø\'Ş–°ü\r\ñ4+˜\âO\ê‹\n\ã!c \çTk­nü3e©­›\\\r\ßÇ¨\áùX¢°$\çûµ+.k”¢qÿ\0¿eµ?\0M®^E2\ëV\ÑS\Ôt \ñŸ^µ\îŸ\ğo7Ç©|\ñ\çÄŸnŸfŸ\â+0aˆ“·Îˆ\î\ç\Ù\ïÀ¨|SûCéŸµ/\Ãy5&\×\ì\ğ\ÜD¬ n\0C~ ×”Á2<=¨h\ğS\ÛAo5ºMZN?€[\ğ\ÚMr\á§z–2”g…r}\ÜıAv\ÜÈ£\æ\ØÌ¤¹ƒU\Õ7),\İ\ëB\ö Ó¿O—\÷8\ä\Öy}­´…\ë^”£©ù\æƒz7\ğ·½6R©RsR?Ê¿*š‡vSi^\ôr°°¡³\Ø\Î;P\ëƒL®\ì–jt²ªŒ~”r°°Ü¿y‡Ò£•!Hşfmı²(yP\Ù!zG9¤l‘\Æ\ëœQ\Ê\ÂÂ«7•\ò\íÁ\ã¥t r¿0ùŒqÚ$Ñª\í<µ¬,>B»q»,}*;•Ø£éšº\ô\ÅH¿¿O™€\Ç!a½ÿ\0\nG\\§\Ş\ï\Ğ\Ó\Ùp\İr¸§yqÈú\Ğ!dD»Úœ\Â6L\òLT‰\å¨\÷éŠ†Dx ,k9${Ô±\ã\É\÷\Í3g—/5$Vû›ƒÁ\æ©Fúš‘#|\Ü\æ‰\Í\íWĞª0[=\ê)mrŞŸAO•U¶—½+\Û\í\ÆX\ô\ÍJm~lQß(H7¿\Í\"c§Z\\ 4–ˆ V|\î©\ÑCs\"şt-¢U”\Õ\Ër3\Z“\Ç\ğ«V©±~\ñ\ç\Ôf¡KLœ\õú\Z±ÿ\0eØ§¡p#¿—µ±‹\ñ\ß\áW‡~6ü\r\ñ…|T\öq\èzÅ›\Å4—L#N\Ö\0‚Hù#\ó¯\È\ÛGD\ñÿ\0\ìY\áoøw\Ãş(\Ò\á\rµ…l\ô\÷\ĞHµYH0\Ü\ïŒd\äq+Ù¿\à°·±\ğÿ\0\ö“‡Á\Ğn4½\Æ\ÖSl\Ç	,\Ó.\÷,3\Î\Ğ:ık\á\Úw\ã<_¶?J\Ô\èú–—3Oi,M²\"\Ä\ãGùû\×\Z\ÅI\Ô\ä\è}>_ƒ©N—¶‰\Ëø‡\ö\Òüadş\×g¸\Ô/µ\í\ÖqJ\×-r–¥¸\ÜÀ’1œ\ô\Å|\å\ñ\÷\öd\ñ7\ì\í<6ú\Ì0\ÜX_,µf\ó!¸\ï\å\çøm§\ëŞ­ŸŸ‡^7\Ñ\ã\Ô#X\äûlxœgl™o½Ÿ\óÒ¿A>=|_ŒŸ³Æ±£\"}¢\ök8\ït\ì\0?{nqü@{‘Ez0\Ä*š:¦c\ìªc[\ö\Ú8\ìy¿\Ã]\n\â?\Ú{\Ãn“Ãš©\ádÓ’Hd\İi­0…\Ò!\Â\Ì6’	<‚qÈ®k\â[K\à½/U·\æ)\ÖF„)\È }ı\ë§ı|{¨x\â_ƒ}u$–ºkO£\É\Ïÿ\0wÇ°(ş\ë2ªœ\ô¯Lø\Éû3\Í\ñ=B\ê\Æ6k\äs+E·\Ïq“\é\Ó\ê+’¶%B§,0øw*W\òßƒm!\ñ¥¦\è\÷—\Ğ\Ú\éùb\È\í±¦b>\óşŸ…cüFı›<A\á?µ^C%¬\Ö“–’©cƒ\×p\õµ»\ã	I¢\êa\Ô-Z\Î\â\Ü\à\îO˜}\rT7dO\Ü\Ít\Ë\'“€}‡JèŒ“Ùœ\ÒO–Ì¯û>\Ø\Ç\ğ¶\rcP»±[‹\íR5;w#	\â9\õ$\Õ\ëOYÉ¯\Ëu,q\Ã3Kæ·’~U\ïT\ö]\ê#ıf#\ä–Ÿ­t>\Ğs\ZÆ¡dUl—ŸpESb§v\åu{ıA®Z\İtÛ©\n‘ò€°±\ë¸Î½[ş7\â<=k®yH«}qt±\É)rg\ËÀ\í\×5\å\ß¡øQ\â­Yco.h­\÷y˜\ì\ã\×\ñ^µÿ\0jø}w£ü3¸\ñ\Ù&µ\ê+>YC\Ä{\0jk\Ê\ØvŞ‡F\ó\õ>\ìø­\ák­+Å·“(µ{[\Ô\ó\Òû\Ã8\'ü\æ¿$\õÿ\0\Ã-şØ!\Óuky¬|\âk¢.\"Û¹a\É\"\åF1˜¤%±\èq_³ld°\ñ+oı™ Ü¥—\ç†9\í\ÛÒ¾	ı¿d\ïø\\~’\ò\Ş\×nµ£³<L©\óJ‡’¤\÷\éÒ¾w+\Æ(Tq›ºg\ØgY|kRH\è\â`\Í\à\×\ğ\õ\Ò\Ø\İDx‹-¼ªG}(a$cø•\İ×‚H\í\\\çˆşHª\×V¢9£c\ÄEp[\ß½1\í\\WÀ¯‹^/øk\à[_\ê\Úü&\Ş\Ò\ävµˆL\Ñ\êº.\ã–X\Éû\êHS\Ó&½?\Ú+\Âp2\ãÃ¿­\ğûw\ç\óWµSWxŸ7	_}\Î-<4\ßleŠ\Ç \äÛ\Ü\ö¯ şøb\ÆK;r-£\ÜT»AdoÓ•\åv\ß\Zü/®\ê¦›\à/Š\Z\Õ\ÆïººRZ©ÿ\0¶’>\äkkGø\ã\ë-NF\ğ\ß\Ãÿ\0\rx:Lü·^#\Ö\Z\îuø¼˜¶.Ò²”gË©¤##\ê\ï|*–\Şû\í7+6\ñü\Ï,\Ã`Q\×$\ò {“øWŸü]ı³t\ô\ñwü\"	t\çø…\ãfV·Í‹gOÒ‹eZK‹\ò \\gO\óYz?ì»ªş\Ğ\Z,:‡\Å/Š&\ñeµ\ö?\âI\á\õ\Zf˜£û\îa\×\'9#\ñ^§\á\è¼?û7\éCC\ğŞƒ§h6p S”*\Ã\ÖF\Æ\\\ñÕ‰\é^u\\E:-¹j\ÏRYN+±\ğ_\à—ü3\×À\'\Ã\Ò_E«´“^j3 ù^\âi\ß\Ã \ès4ÿ\0\íf\ĞH³FÑ°\ìA+±×¼c½8¸VhÄ‡qSÀ®\Å\"û%¼\Í3++1v&¼\õˆI\ó3¢¦4©\è|\×\ğ\Ê\rC\àg\ÅEš\Ò\ÏX\Ì\ö‹¿*HcŸÃŠû—ş	o\á_\Zş\İ\ß\ÛQÆ²>£\\\İ3Â¬YEı[ùW\Å\ß­F¥\â\ë\ô™¤m\ZmÁ\ä<”nª·\õ¯¼¿\àŠwf?\Ú\Æ\Ë$;g“FF‹Œq\æ§\ô¯kÊ\Ïµg\ì%~„\İ\Şfv\ë\óG\Ó5ZC\å\òw5<—(%e+\éüª\Ô\ÜÁ•1^‘\ñ1ZK†\Û\è(a¿œşu—ùO\çN\ÂF\ß37\àh†I”ûß¥$nZ2W®q\Í<N®\õ¦2üû”‘\í@X?$n\ç’1šc\\ùg\İøt¥XÂ¶\îI\÷¢f?\Ìy\Åa\Ö\×Yn‹• B\İ3i\Ä)\÷ynhwb2¯J\Ã[k¦î¨Ú zıişAº?/ËQ\É\"\Å\ÇÍ‘\ÅD·\Ñ\å\÷nÚ¾•!–3\Êi¨\è\ã\×\ëCÀ§ıŸ¥ ±\n£K.{T™hù\ã\0\ĞW£c\ëB\ÛoLy\ès¯ÁB>\é\Ã66Z\æ©\'dKpœúrk\çş\n+I\æ[ø&\ğG\Ø\Ïv¨ §ù\×\Î:Æ¥¢|?V›M\"ŒÜ\Z\ó?ü|“S’D·\Û{°F?‘®Å†\È\Ë\Úb\\ÁL® İ·Á–£ı\ë\ïşµe\ÜÁN5\Äo\ÜøSGŒp\÷,\Õ\òF‘®Ï¯y`4Ä±\ç\æ5\Ş\é\ò,<É¶¯\Ü\äÖ«£h{\×ü<\ë\Ä1GŸøEt&n¼\Ì\ä:\É\Ô?àª\"?\èE³\Ï\ïŸük\æ¿x¹l®¼›w*¼‚A\ïYºv®³\Í>\æqU\õx´>¬·ÿ\0‚£øš\á\Æ\ï\è\ë³ÿ\0jiÿ\0\ğS=jr\Ë7„\ô?\\,\îù\â¾I‹Ä\ÚF\Û\Úm\Ë\÷yû\Ş\ÕVû\Æ\÷Z\îˆ|\Ï\Æ	9ıŒPı¢\ê}§kÿ\0*’5\rq\à˜OSş\ßæµ¢Ÿ\ğR-ùT\É\à}P\í9\Ş\ö7\Ëœ`¨5\ğŒZ–©zª\Í#,x\ê\Ò\ñ¥\\X‘±~l‚\Ø#=	\õ\Íf\é«4?i¦y\'ü£\Å6>ı§c\ñfŸg{ck¬XÙ²%\Ö<\ÍÈ¥9\Çû¢¼\à×†tÿ\0¬‹6Õ˜\ä©#\Ø\\×¨~\Ü>»ø£\à\ÍR·R\ß\Ù/²p¿x\Óù×Œ|3½’\Â•ü»…m§ğ¯Ÿ¯Fp›hı)­\Z˜X¨\ö1¿jÿ\0Å£ü8•\Ì\Ñ\Ésmr²Û¸û\Ãqÿ\0\ê\õ¯£~ü{\Ô4\Ïx~F\Ùv!\Ü\îûª?Zù³\ö…³“Ä—¶6c7œ\í¨?y˜w®\ë\özMGÁz}›+‹9\r±P;¯¯·5\\\Ót\\^\÷1”#\Z\÷\ÇY¨øWHø?ûNE?™§€~(\\\Çw¥]‰v¦‰¬¢ü¡¸\ãwË’z\ç¶+\íß‡\Ç\ãM\n\Ş=F9­5\Ü\\\ÂP®\n\ã\çS\Ü1$çµ\ò\'\Ú\ì“FÔ¼3\âM5o´½I•g¶Ÿ+…\äylQ\×$†=:×¦|.øA\ã\rx}u/…\Z<i°\é-\ÒSRû\ìmW*21\É\ï\\\Õ\êSª’“³F\Øz¥/u]™\ñ›\öC\ğ¿\Ä\ËIRc½\Û\òO\ó“Áÿ\0=\ë\ãß‹_\0\õO…Zœ\Ğ~\Ùgd\É\ÌBÿ\0µ\Û<t\Í}w\ãÿ\0\Ú\n\Ş\çl~%øwc\÷©\áùY›ı¬œût­Ki~:øƒzj¾\Zø}n¢!e\Ò|JO`\Z`\Üû\ãñ¥‡”a\ñMˆ\Â*š\Æ.ş‡\Êø\â\ï‰\×$h>×µ…\É?\èšt’*:°^\õ\Û\ê?ü7\ğDPø•\ãø_\Îş\È\Ó\'MS]¸6-¼LB1Á¼e\ÛÔŒc>©\â¿\Ù+\âG\Å\ï\nCoâ‹Ÿ<Ao2›I\õ¦\é¸ë±Ú¼\ô\æ¼\Ê\Û\öiøuû<\Ì/$Š\×\ÄZ¢p\Ö\ğ#4\Ç\÷\æa—\Ç^:û×¡e\ôw<\ï\ìú‘Õ£\Ãÿ\0jm_Vø\å\á-6\ÏG\ğıÇ‚¾Áq6\ÒúA&§¬\Ê@\Ì\÷ùA (\n ·¹\Í}ûû$x^\Ï\á/Á¿\Øi¬±\Ü}‰nfYr¼K\İ1\ÇÒ¾GM#Tø\Ñ\ñtøAûV©rZ¢\"¬vHÍµ@\ÂÆ \ó€:ık\î\Í7\ád^‚\ÂÕ¤\Û\r²[IÂ…P8úœŸÆ¼\ì\Û\å±\ë\ä™z\ö\î±\î_\Z\î\í\õ\è’\é¾u\Å\Ô\Â4\Â\'½x¯Å½¬®p\Ş|À\õgn{âµ¼\ñ\É!ğ•®–³HÄ®@\ãx«C\ÅzÖ\ñ\Ã:^¥o|\"¼@\à\'„\ã¿~şµ\àQ•¤¹O¦•/r\ó>ı¡¾7‡u+i*Ğ«a\ïbŒ²°$‘½Fx\íÏµr¾¼Ö§Š[\é®-ˆ\ã\çù—üO¹¯µ¼A\ğBOˆ“y\ãKU]³LD‹\Ï\ô\ï_5ü_ı˜uO…(+c<²Y\ÎIi³“‘\Ó1^\Ìq2}O\Äa\"¤\ÚF:Ö ­j^|a~T1+ù\äf»\0|\rÔ¼]sg5\ä\Ó%º8[†N•\Å\èG‡nÕ£U\ä\î\Ş>|9?…{7‚~0Ç­ø}cm°\íÀß•…Z\Ó\î^Œz£\Û4ûKo‡úLV¶–\ğ\Ík\n/\å/\ëŒ\×\â\íµ[Û«‰%\ó\Ój.\á„\ëZ\Ú?‹\Öú\Ñ-\Ûu\ÔL›K\Â×Ÿxº\Ê\õ¶\æh\ÕOq\òI^uIJOS\ÔT\×Aº­\Äz^\Æ\ËH\ÜnÂ¸Ÿ·±¸cû\æœü ÿ\0	®šş\Ú9\n¶\Æ\İ\ä\ò¥r~*hedg\Ü\nú]8}\Îw\Ãdp:¬±|c‚;\ëT–İ­%ˆ£·U?\çÒ¾\ğÿ\0‚aN\Ñ~\Ò×·LĞ©¹\ÑLl~\áM­Œ~\ó¯Ï›«¯#\â}œ’+\îK”.¼|\È9=\ë\é¯Ù“\ö–\Óü\ñûF¿Ñ£’\Ú\æ\æ\ç\ìW–Œ²¤½Œ{×½E|\'\Ëb,©\Ê\çê›zŒ…\É\0‚‹Ş¡tu˜m!¸Ïµ[hc(‡\ÊuÜ†}1P:\ì!:9¯Z[Ÿ!\ÊiŒ\'#ÓŠ®û™O¡5*D|\ÖW\íŠŸHXŠ\ßNEmÜ•\ïNĞ—iú\ÔrfQ†ı(Aê¦šN\×\É]\Ç\Ïjˆ\ÆT|¦„.£\æ\Î\ßJ\Â¼©,›wv)\\\È\å`\Ü\÷\ôvC\Ğ*\õ\àT\ê^e\Î<Â½±@XzÏ±~RÛ©e¾\ö?\nI˜±şø\ëšr¦\á\×Z–‚\Äm„ù¹\ÏÒ¤iw/CùSgfŠ/•¹\ÏjA#<`\î\ËT…„®:ûÓ£P;ªûS–5eİ»\æ\ô F%o™H ,~6ø\ç\âmÇ‰u93#È›°9\æ¬øBŸX¿BÑ¥¹&°ü)à¹®\ïÕŒO+\÷q^\Ñ\àOIlª­ş¹²}…{‚\Ü\ã\æ:Ÿxv\ÏK‹s¥T=‰\î+\'\âO\Ä[I-\á]ª\ï[Z\ÍÍ¾‘e\ä´Á„yf·O\è+\ÉüS\âKK‹\å]\í\Z©\ï\é“Z{4U®aù—Z„ß¼vİ¸¸®›\ÃZ=\Êùj#8\îqY1kvpN<©\ZVc‘´t®’\ÛÅ‘\Ø\Û\îi˜±N\0\íT ‡\Ê\Æ\ë>w\\.T“=A¬xu›´\î—k1?t\×5\ã_ˆ\ó_Î±®\ì)\ã=\ëJ\ñ¨H\Ònİ”r \åg´Zê‘µ\í±ªt\Ö&¥©Ã¨]¯\Ê—\ÑV¹3U[·\ï¼\Æ¡\ÎµOª\Ú\éHÎ¯µˆÁ\"¡\Å\\“¬Š\×MÊ\ZKo2Ÿ:3\È\ï\õ¯	\ñg\ì\Óy¹q«\è¥n—\Í\Şm\0\Ã\ó\Ô{\ä+K\Ä?d\Óa¸û),O\æ«|3ı¡\î4oXµ\ñ‘­g%%$ÿ\0«S\Ãc\ô\ëš\ò\ñ´n›‰\ïe8\çBJ7\Ü\ó/‹ş>\ñ~ƒ©\Ü+&—;LW…aŸ—ükW\öw¿‡\Â>5¾…\\\Émy+MÈ½6x¯°<?\ğû\Â\ß\ì5ø\Â\Ê\Ö\Â\Ñv\Şiz™l‚ªz‚8\'ŒrM|\Ûûf|,µıŸ|k¢É¤^GubW\ËŞƒ\äb¤?1_9*\Ê>\ã\Üúú\Ñr¶[ÿ\0\Ä=1üC¥,ª!k‰8\0\Èü\ë“\ğ\÷Š5\0´‘[\Ïqkü*¹*Â·¼¬\'ˆü1\ö‡_)R w\î\èq\\Ö¿i¤(\Í3\\5\Ñ\'§A\ê+É­~kH\í\Â\É\Ù4w¿¯µ\îšY¼\ö\ß\Ñ\ä\ö\Ø\' \Ïj\÷O†\Ó\Ù\ØZ-\Å\ê\Çq=º\æ?1B;Zù7Á_nü9z¶\íx\ßc\íe+^Í¦ø\án\ô\Éƒ\å²gq8\íş}kŸ\Ù\Ä\ö#RvÕ\ç\ÄŠVú\Ô\òUVB \áG\áık\æ?‹~4/Œ‘)Û¸¬»‰#Ã \ë\ØV‡<e2]2\Ç(eŠ\ry?‰\õ)\õ‹¦…|\Ù<\ãA\ã#®\nÚŒSvG\"²Ù\÷ÿ\0\õ]\'L×¼Q\â-Q­|\ÈBEj®rË¸ü\Ø„`~\íŸ~:\Û\Ã­›4\óN~U\0\àwü>‚¾Sø\à\í^\õ5)tÙ„Ku\ØJ\ğ\nŒ\òk\åß‰º~±w\ãû\ëıCX·¸†Wù\âüµ!A]\Ô\ò\ßo-Y\Ë\ÅP‡\Ú>!\ñî¹©\êBi¡uVnŒp£\é[~\Z\ñ\íÖ—k4\Ó]$6Ë–•Œ˜Tšø³\Â¶£¥Y\Ú\éwZ‘\Ôb€\ìH6\È§¿\×Ş¬üVøŞ¾.³‚É®fµµ¸?9GÀz\Z\íG\Çn ODÏ£|Mÿ\0@\Ğ|%{&•¦\Üjš”*q<\Ğ|±Gƒ\Îz\ôï„Ÿn¿h\İûh\Ø\ŞC§(ÿ\0Ei\ò­1\ã•\ÏÖ¾1ø%¦xFû\\µ³¾\Ò`¼‚f$H_j\ÄG#ÿ\0¯œ\×\×^ı¡´¸´x\ì¤h-£±\"D\0,q\è?i\Ô\ËaE^&x|\ÒUŸ,¶0ş5|ŸWv¹±a¸W,B¿\Æsı?\n\óO}\á›\Ãk|6¶0Ç­}%¬ü`\Ó#1%Õ»³\òVF\È\ç®+Ÿ\ñ\'\Ã\í\Ç)\ç[\Ïw‘®\ò§©®\n‘¾§u\Z\Ñ\æ²f\×\Ã\ßµŞ™„º\òYW<w¡¯\ßÉªˆnŒ›ya´`WŸ\éo†\æh\ä\É\\mÊ¶C{Š\ét½C\ìv\ÆV“*\Ü\æ¼\ÉüG¥\Z—\Ø{\İ\Ç\"\\\í“¹\0v®O\Ä\×\ì¶CjÉ¿¹¥­\İ#[\È\ë*nfÂ²\ñ“\\¸\Ô\'ûT–\ò+7\ÎpÃ§A]}\Î<T¯\â\ËÖ³\Õ\Z\ô\'\ï—%›h9\ã#¥~\Êüı>Á\á¿ø\ãO\ğ^“m®]i6—­:+myL`—+»³\ß…~,üY\Ô\Ò;‰c\óš\ñœü¤\ã\ó\Ç\ç_º±ÿ\0,|Aû#|;Ôš\î\ÆO‡\íQš[„\\2 ‚sÖ¾«MJ7gÁ\æ\Õ,\ì™\İN\ZbNNz“\ïT$·v—,NW¥gj\ßü¥\Î\Â\ã\Å\Ş…û¯\Úsü³Yw?´_\Ã\ÛE\Üş1\Ñ\ßı\Æf\Ç\é]ç†¤¬t¯\ÌÅ›\æ\'½,\ñ°\Â\Ä\÷®:\ç\ö øgmH\Ş+³úG“ùb°gı³~¬¿.«}6?‰mÒ§•‡2=)\íG\Ş\ë\ÏZ`‹\ï5y\í\Ç\íµ\ğ¶m\çU\Ô¨û¿cnZÁ¾ÿ\0‚‡ü0·…¶ÿ\0mÍ´\ã+j9ıEŒ9‘\ìQH¬\ß/\ÍøÓ·“\'Ì«­xşŸû{|-¼dóµ¥¸m?ú\õK_ÿ\0‚„|?\Ó\â\İŸ¯^/r°\Ç\àM?fÃ\'µ£7˜W\åÁ\õ¨MQu¼\0xü+\Ê>ş\ß|s­\Ãc%Æ©¢\Ü\Ë\òÆ·6ûÄ§\Ğm\é\õ5\×x§\ö¦øm\à™\Z;\ÏÛ´\ÙÚ«>O~UHıh\öl9‘×¦\âv\ãoÒ•mX!c†\æ¼\ò\Û+\áœZ\\š—\ö\ô¿a\ö–l´n\æ\ç=1Èª\ß\ğ\İ?\n\à³\ó?¶5I7|\ÛÈ’¿Z\\¬9‘\èÒŒ\ğ«\Í,V\í>µ\ä\×\ğP¯„¶üGZf\ÇAa\Ó\õ—\'ü“\áu¾B\Ë\â	^,1ÿ\0³U*aÌo[f\Î\á·?^i\ë»Î¬8\õ¯›ş\nk\ğ\Ö9?\ä\âi8\á¾\Ì\õª\Óÿ\0ÁS>\ÛGÎ—\âvÿ\0Ÿuÿ\0\Z=˜s#\â«WAo:I’\Z\ç\ÆEY\â¤6\ñî·\ã\'®i~!xfk\ëx\áx\İA‘–U\ÚÁÒ¼wR\ÖMµÙ†@bl\öû¹\íúb½®SŒ\î<O\ã>B¯3*¶rG\\v®\ò\æ\òg’M\Şf\î\éQj7·V±©eVI\ÈPX\ò>•¡¥ù——i!ùˆ\Â ¹\ê;ŸÖ¨\Ò2V,h²<sF¼²\Ç\0\í\æ¯k\×\ßaµ|\É\æH¼g¥X°\Ód²‡\Îf\ó·d!ë³“\Ås\Ş,\Õ#Í–h\ËI\æ\é\éA.NúÖ£«\Í<­¹±·¡_Zm–¸Ö…^GS\ÎN\Ú\Ç\Ô|\éŠ¡\îÁ?{\éY²jo\æ\Ç\n¹/ø\Ğ8¶\ö=M\ñ—\Ìh\Î\Õ<8\æ¹ÿ\0ø\ÎK©#]¬¥¸85Ï-šH‡\ï\ëÚ±\×Rš\îU\Ë3(}8©h§·-K{\ö°Å™¾q€\ïT|;\÷*?~\Ø\ğ\ç\õ«–º_ppv¢=sZzo…d˜–³!pSr:~y¥:i\ÇS?¶¤³¿b\ã\'\ÄÏ‚\×V\ö·b>\Ëk5\ĞË¡I\É\ö,qŒW“~Şº—†|S\à\ö\Ñ-ÿ\0DÌ·>_\Ì@#ü*\÷À_Š\Z§‚ş\ÜxNv·º\ŞÎ®\ß.Kc<\×ã…\Z¥şµ-\ôŠ²Áyn\Ö\÷d\ó\ç“ùdW\Æâ°’\ö\ÍÛ©ú.I\ày$\õg~Ì¾)\ê	´{™d‘Œ[P–\àú~˜®\ï]Ò¥\Ó\ì ùÕ–2Bœry—mÿ\0\n\ó\âÅª\"\í·—„Á\ï\÷p\0?:\ö\ó:\ê\ZK,‘\åUZ\ó±4m&v`j]s®A%»ü¹w\î½ni:Ü¶šc$\ÌYXg\0\ô«w~\ó\ì¼Ì°-\Î\rrWS½œ\Ò&\æeS·$\ô®xÁlz­-\Ë!\ÔT\Øm_½!ü…K\ğ\Û\á\å×¼Ki§ÚŒ\Ê\î0Ga\ß?…d*yÒ«y›”rw‚´<1\ñ\×\à\íıŞ©o3;¬xİŸ™OµuS£ü»œŠ\öÕŸMüZø\á¯Ù³\áZhzH·şÔº@0n¼I\÷\Å~ü^\ñœ\Ş1³\Õ$‰c†\ár\Å}rNO‘\ñ{\öÕ¾,x¢\â\òmÑ¼Ï˜rOÊ z\Ö\æ‘=\İ\çŸÎ«u\ã<\ÏZ\ö°y\Åİ;\ÏTyı…µ½½\ì\Ò\ÜZ1¸\0>lú\óW|a;jzƒBU£i	 `V†\áFÿ\0„\ã¸P\Ğ\î\Øüu\ì~\ğªh\ö\ñ‹&“\Ë;ˆu\ÇÒ½)i¹\âÆœ\å±\ã>\Õn&»†\Ú\ÖY”\ÛMzo€®5)4‹\õ‹\Ïx\ãR\Ï\É;O\÷¿Ï¥V»\ğV\Ú\Ã\\i\Ğ-¬n6\0rXy\à{Ê¶¼9m«xKK&_,Œù\å}:TÊ¢’³:\è\Ât\Õ\Ù\ÏŠ:ÅŒ\è±\ßÈ¥I\Éj\éü#ûDø“@>u\Ä\Ò\\\Ãpvrpµ\ç~,¹·Ò¯n¤¾’.‡h„\î¹ûm~-GGx\âš\êO$o\\\ö\Ì\ğĞ\Èq\ÄJ›æ¾§\Ú_~-C\ãI,\â’o¶\ÃûÆŠFİ•À\éø\æ½\n\×XM:\ÕQ™<\æ\Ú\Ê\Ç#\ñ¯‡ş|H’\ß\Ç\Ö[™‘\İV7Sü|¾\Õ\ö“\ÆL3+\ğ¡\È¡\Åxx\ì\Zƒ¹\ô™^9\ÔZš>#¿‡K-şY$‘\Â\ç²}+\Ä7¯£‹¬¶w.##ûØ¨o/\Ñ4G–`sÁŒXœ\õ®o\Å>&Y\Ûs\ÈDQü\Ë\ïŒ\æ¹p\ô\õ±ÛŠ«\îœ?\Ä{+›\æ\Ü<\ÖÀrOÊ¼\÷}u\ğ[\Åh?´}&+»Ac·\\.IX\ò3´vÀ\ÏOzø§W\Ô\äÔ¤‚\ßÌ“Î½—v\×o—nyü+\ê\Íâ†Ÿ\àŸØ›B’3B£j„\0?¥}~,u>#4’“±\é\ß`ŒI\ç^<v \òasùSS\Äv{\ÊÛ«;/\'­y·‡¼Kq\ã{†y4x`)4\ñi2­½´†7q]\\©»6\Úƒuâ…’\åcKŸ›ºƒÒ™¨x\ì¡\İ\æIR\Ä\×\á\ÍF;o\ŞM\óJ\ã\0\ç½7]\×\î5Wû4+…–¡\Ì\\\×ş \ÈÆ²´Œ~\ê‚z\Ô~´¾\ñE\Ò\î\ócP0\Î\ã*=…d\é\ÚX]4—R.ü}Á\Ô\Z\èe\ñlÉ¦,V\à\Ã	\ê\ÇÖTƒ˜ßº×­|+g\å\Ço\Ó/\ö\ñ^âŸ‰W7,¼®@À\î\óX>>\ñ¿\Ù\à\æFt\Æk\Ïd\ñ4\×m#4›Š“Á\èAÒ´T®®C>˜ım\ç\Óü+}\âiš?6\ö_²Ù´‡;\0w\Ç\â~µ\Í\ê\ß\Û[Ô®oa\ò\î-\í_\ì\r»·¿WaëŒŸÊº_I\Ã/\Ùÿ\0A³‘¤·û>…Ì­²¼\Ë\ç\ğ\õZ\óÏ„¶+s\â\ï\Ù\ÜL\Ö\Ğ[Âº\İÁh²AVk‰¶cI9\íKÙ•\Ìz§\Ä=UtŸ\Øøn\Öe—O\Ñ-¢yYWh¸¹t\r#7\Ó!Gû½\ë\"\çR\n¿Ç»»\ä‚¥a\éz«jú¾¡«\ê3\\jpGl9\Ü\0\ö\0\Ô\Z—‹VrbH\ö®\ìu5\Ä|Å©\Õ\ZRÌ­\Ï\ñŸ\çUoµK+\÷JÛlb¹¿ø†kQµœÆ¸\ã\'ŠÃŠ\é\õiÀdŸN”r¥ s¥ŸŠab\Ã\Éz†­m]U•¤\òÊûzV‡|,­û¦.z\çSµGf’An>X¾Q´r}\ê¹Ps½\â\ÍWM\Ô<)i=”\Í\r\á‚h®b”–\ÜNHaÿ\0Î¼\âvŸ\ç\ê\ó\Ü2ùkW~\é\ì?@+\Ò<A­Ç¥BÖŠ’]‰\"UûDx\n\\\á¾_U\ÚŸR\Õ\ç>3¾Y k6p\Íp‹b1´§o\Ëw1jSj’\Çj\ì¬\Ë Û·øAú×¦x#Cû~š’²¬\Ö\å\ÔÅ´&\Å,O\ê£\ó¯#\Ó\ÉkÖ¹>X™\æ»\í+\Å\ñxn\ÂÑ¶\äÛ¨,£?{q$\õ\ïÀú\n\0\ì<m£G\á_Z\Éo|ek¥,\ñ<{Z7`\ô!\Íy>»¯­\âÌ·J¬Ğ¶\Ğ\ã\è\ó&ºıo\â=Ö±¤H²L\óG\"Ä°’€8+O1\\6½:\Ë\á\äù~b\Î\ì0\Ë&\ã\òş[:\0\å\'Õ–Yü·\ä%[ûµ<\Zûu´ckI1[\ÓŸ\ó\éX\ö\ÖrL<\Ç8\õ\'\î\ßÒ»+v\İ\ô«X\Ìd\ív‡t\Ú1ú\æƒJ{\â~\Ãu:\Ã\ó\Ü1\èjŒO7\î\Ûr\îs´¨\ìkk\Å7pİº\Ç*’\ç§W;¨3o‰cùI\å\ß?w\éAU$¶:­7tVsa£v‡‰ıEY0]>u’\ŞB‹\Í\Ç|b¹X®5X™$nJÿ\0Ö›	ı\ôa\Z\"Á”ÿ\0 Q-QŠ\Ş\ç®ø\Ç\â\Â\Ş-¼{ÏYXd\n«\ğ\ã\âv¥ª\İ2L\×Z\Ù\çw?\'\ãøb¸V¸]G\ìÌ¼2¦1\ì:cŞº\r#\Åş\ğ\â\Ã\óF\× ùƒ©bxÁü…sÔ¥Ì¬Ñ½:\òƒºf\Å\r9m|Qo~¬¾L\ç\ÂGB	9şU\è\Ö\Z¢ÿ\0bY\İC/™\r\ÒÀ\äƒ^^uÈ¼c \ŞG\Ñ\ô3˜øÀ*\Ü`ı=±Z_¼Y&§¥e\îT’\ÖVa»’\Ë\Ç#\õü«\çs,W±\õ9>1·\ï”\÷N–¾Z±u\ÎÑ\óşq\\n±§Gqwr\Ò¬ŒŞº«ùq \åş\é?{5\Ï\ÛjKu{$o\é?½kÁ§NI\ê}W2h\ã¼y\â\Õ\ğ¶–\áCy\Ò.\Õ\İ\ë_6øû\â5Æ©3[\Ç#\Ç\çùsš\÷\ï\Ú?I–\ÇK[Á\óG´°\ö\ë_\Ü\Ş\Ís©I\å»\çy\äık\è²ü2œn—\Í\ë\ÊI¿†\õ;+7—\í·QÂ¸\0=>•\ÛA\ã‹]Rãµµ¸›j€P“øƒ\\\'„ş\ÂX\Ğ\É$Œ\íœ\ã<W½|8\Ò\á\ğYQyf²* PÀ\ô_N?\Z\îª\ãMhr\á)J¬®\ö8\í3Î’]\çE¿l\ó\÷0Æ·ü3\á¯x£U[]+\Ã×®\óp¡\Î\Ì{\ò+\è\r|J\ğ6—¢µ\Â\è¯utª±~\ô\ÅhMû@Y\r\ÓM\Óa·ºF,Œ6>¹®G[›cÚ§ƒŠ<\ÇÂŸ³§Š¯u\'Zš\óN·R±µ½¢\ï^y\ÑrA\Ç^\Õ\ï\ß?aß†\í\õ\'š\ëO¼]5œÚ‹¶ $n\"*€2{Nµ\Å\É\ñû\\\Ûo\å¯-\Î™\ï\í\õ>\õVÿ\0Ç—>++.«p±\í\ô™™ˆ9<d\â²\æ{\ZJ„-cÀüqû\Z·›w©G\"Ë¦Y¹YHÅ›’27W•x\×\á©\ğ”’-¬oxÜ¼~µ\öL\Ş\"\öxm\ã$Û¿\î\Ê\ÈK¬œ“’s\ïYÿ\0¾¶µ\áù¦X­¤\Û\ó)CœJ¨\âœ_+<\ÜN^¥hŸü’K_Z´\Ê\Ï\Ôv\é\Å}\Ío\âO´øu ¤Íƒ·+p+\ãoxU¼\ã	¾Î²*†X\Ç=¸\ö¯¢~|Zƒ\Ç\ZG\ÙwG\æ\Ù\Ç\Ã0\å9\Ígƒ©de–\Ë\ØÏ’Ge,7†H\ä¸ıÜƒ|J8\Æ9ª¾$û=¯…[X¹A¿\î„\Ç\Ş¹ıjM:\âMKT¹VEÂ¹8#¯J\ãh\ßexEt¸Õ–Fa¼Ey8x¹T\Ğ\õ\ñ•}Ó…¿\ñ/¬´\ÈÈŒ²\í\Îÿ\0“^½\à\á?Š¦µ€\Û\È8\0\Óü\ó^º:Ûªª\íelŸ¾zWÖŸ	Rø6\Şú\ã\ËY1 QßŒJû$Š\Ì*{\Ç}j\ö¿|&\òÈ«\æ2\ô¸¯\×|e6µ®=\Æ\æ\Û Sş\'|A¸\ñ=\ËG›!-\Â\Ö”>Ê»¤ı\ä„\ğI\à\n\é…+np\ó\\\î¼7uu)f‘Ï—€A¥oj~\"‡\Ã\ÖfA#4Œ¤o\ï\ô®?\ÃÚ°¶‘\Üı\ó˜\ô\Èx\ÓÆ²\ß]2y§b7\0t­yPsM´u‹\Ñ\'œ\Ì\ó7\İ\Ï®\ö)\Ú=25\İ\óG\Ô\õ\æ4ÿ\0¶\İ\É+ı\Ø\ÆFk¸\ñ—Šm\ô«/Ü²™\ã\ñ©\öhg	\ñ\nú1x\á\÷nf\îk?\ÂZ$¾ \ñ\rŸ\rq>¡u¼Q0\È\ÛqŸ¦JçµR}SY’I¤\\)\È\'¥zW\ì±ig\â?\Ú\Â\Ñ\ß\ßI§ZY\Ì\×şr.\í²B¥\ÓV\Ú·§Z|¶D\ó$\ìz‡\ít\Ó\Ãy¦\ØÌ¶¶\÷Úªiv¶¬N\ët\óDjƒ\Ø`¥I\ğ–V\ç\âf¼·Œšu€\Ñc‹;.¤+\òza€\Çl\õ®w\ö‚\ñlš\ÆMOi-škI\õ‹\Í\Ã\îK±¶=ùm\Ü{z\Ñø\â	´\ÏÙ—K†k9-g\ñOˆ\å½{\à™\ÅnTA#7\õ)\è\ìjhOªB¶ñ¬Šª6„\Ğ\÷ü;~\'\î´ÿ\0‡:\"<²,—’|\ŞXûÃ·\ô®»\Ã\Ú,~\ğ\ïÚ¼\Æf\ò|Ì·\Ìy\ç?Ò¾røƒ\â{¯ø¶Y$\å”\àn\ì2x©\ß@-6·7Šuq\ç4«œ…\ì+\Ğü§Ç¥\Ù\Ç+\í;‡\0W\á?.\ì©m»£8\Åkk^7ƒ\ÊKfUš0À?\ç5§³\ÉüM\â¹\ñ¡\ó]aRHPy5OJ\ÖEÅ§#\÷\ÎO¥d‹şF’MÌ§\'$\ñ\ĞS\Ş\ÎK+\ÆL|\Û@#\æ©A1\ßi^#]GDû\Æ\Ë|¡b¶&\r\Z·RcŒ8\ã\Îøİ¥¸’İ¦ûCF\ÛLø\"¶¼kg›Ù£UYLQ\Ô!w2Ÿ\ö²\'¶=+Wr$[ee\İ\ó:3\'\ãTA[x\Ú\'\Ì_º?­sş*\Õ\Z5\ò\ÖvÏ™¸b8«Z–¸c¹\Û4,£>f3øW/©^ı¦Be\Ü\Ò!ù]‹\ë@	\ã9\ã\ÓÎŸ\İ\Ç ¸Bs\İ:ş«\İøª[øfI\ZE‘Ëœ\r\Ä\ğ®wR•\÷+y\ÛXŸ\î\ó\Æ)\ßgû&\ïºÑ¬dnc\Îzÿ\0Z\0\Ò\Ó\õL@\Ö\ò.Ucj±§_\ÉF5\ÉX\Â.?\ëY\óÚ­³¯–û•—fG©\0œ\Õ\äŸ\ÊÒ™Ao5$\ÇN‚¡+=Lo¦\ã\à.=\óQXø}¦‚]\Ò*£µ­i\\[yûZEÜ½Xç¡ªÿ\0j,±¦?w’F03@I\İÜŠ\ãMVû·n6§¹¦\Ü\Ü\ÛÛ‚¬M;½~µ\óµ¼\ê¥ş\ñ*:\Z¡<a‰w;H\Ì2Iú\ĞIwO¹sŸ;\ê\0ş¥@ú›?Ë»ÿ\0®}iútıœ®\ç\Ë\Æ+<[º\á\ÙPŸ¼zS\åSBšap±«ma\Æ>YG`Õ›¢\İ]|;ø™L¡aß•en\n’x?­j\érüÁ“hÀP\ÊOÖ»ÿ\0‰_®|Q\ğ\ê\ÓSƒNŠˆb(“\æ,\â\Ç\Û~F¹1˜~xhvQ­*r)©\â›Ç»´şÜ¿“x \r§\åS\í\\h\ÖZ\Îı‡˜w\Ç\Ô{\ëY~0Å¨XŸ\r\ßÉ¶\æ\Ï%w½\Û\ñq­7_^L\Ê>^¨ú\×\Ë\ËÔ™\õ”qQĞ§\ñ]\Ä^h˜…ı\Ñc¿=+\äÿ\0h\és\âÖ±t†B9_zú\â-Û¬‚m¾`\à³Ò¸?†Ztqø¾\ãR“\ì\ó6v\íQœ^¦\ğ‹<¼l\İJˆ\í|;\à\É<?+\Ü‰sš\İ\×5Hü<‘}º\ŞM²\ñ\êk¢\ğ”\ñ\ßfx\ã½\ó\Õ\ÔxŸ\à\ßü$:R\ÜK¹VA•t\ÅR«¿¼zxX\ò­\Öş3xg\Ã\á¢X®\Øü\à/J\äu\Ú\ÂK\ÇV·7x]Ëƒ^‡\ã/\Ù1oƒ\Ü[\Ş.\æpÃ’y®sÃŸ°Ö§©\ê¤¾XW<:­tPTlœ™!\â\Âr_\ğÒ \Ôm\Óü”l\ÅK0üs]\Ã\ïx‹Æ·\åd‘–aµŒk\÷ù5\ìıŒt\İ2ÕŸTi$Xp?\å À\Îk\Ó|û6ø\Â\÷v\÷ZM¼‹Ÿ6\Íıs×·µMz\ÔW\Â|>\"~\ô{ÀŸ\rQ¶\Ó\ænƒ\Âq6üá¨\ç¥z¶§o7‡´9Z\î\Õf·’ÁA·iŒ\×k\á\×\Ót«o³\Ë·4\ÉaŒ€9\é\\—\Å\éW^º½·Ô­®UCE\öuû\Ø<Š\ò%V\õV¤]:V‘\ñÇ![Y{ueFù\ÜT\òkøe\âv\ğ\ïÄ‹g…\Ñm\år².v­w.\áƒJ\Õ.c¿Ù›\÷Vû~\èâ¼\í¼‹E’?‘¼\àw\ñ‘\Õ\ôTi©Ó³>Vµ^Zœ\ÈúªûÅ°Zøa¯\ã]\ÒC\ò®[ g§J\ğÿ\0\ë“x\Ã\Çv\ğ\É3*i„K7¿$\Ó,|}q/ƒB\ÌÎ­´¯\'\nH\é\År\Zv³u(ºvm\×´üCŠç§…P•\Íg\æZŸ\à}øş\ÜBÿ\0hœ8$\ö\éÒ¾„\ñE¡\Òl¢…>E@*§Š\òo\Ù+A¶¹\ñŸ™\åÿ\0Ç²:7s^©\ãMn½f\ê\İax\Ñ\ßj\ç&½œS\Ä\ÆTRzÍ¼—w,\â5mÍ‘\íV¤²±.\äù˜\ç­_şÏ\Ö\ãna\Èv\ö=r:–kc\"\íUİ·\æ\ÏPEtœ\æ£p\ĞÆª¿(-ŒW1{b\×\ì¹ş,ş5\×k0y\ÛYWk)\É¥P\Ó\ìRÖ–8Õ˜\äh­\ğ}\ÜZ‡5\0\Í\"\ä“Ú³¯MF	¦m¡W<{\ÖÕ·‡Z;\÷‡k}Ñ³½\íQø£L}#\ÂRK–Ã…:\r#®‡\Ü+]kO,\Êİ—¥{w\ì_5Æ‘¯xŠılVe¶\Ó\Ş\Æ–‘\Ñe‘TGuÏ¨¯Ğ¡\ó\õV}øPgµ}Oûü9\ñ&­\ğ£\ÅW–ÿ\0\Ù\é¦_j–VÓ¤‘1VT™\×\ËnƒŒA\çKc9/|\ó‰wb\÷âŸŒ/!\å:>‰“\Ç\Ã7˜\Ò*\íS¸\ò{\×w‹ªhÿ\0>\èú™X\à\Ò\ä\Ô-­Lf9\"[‹‡\'w$1,1Á#µ\çz¥•Öµ©üM’\âh\ì\í_\ÅVzu\Ó\Ê\n\Ì,7q\İ2q\Ø×¿j_g\Ğ<moıƒ}¹¡h\ö6–IuØºh G g\Ë\ì1\ëk>…Ks/UÓ®µ¨nšf\Ü\ëH‘OÊªª:\×\Ì\Ş+\Ù\ë\óı\ÔÌ¥@=ıU\õİŒO›«}ª\Ş\án®³;ˆLf\Æ3\Îk\äŒ\Z\Ú\ê^-¸X\ÕaUr¡‡¨©\á\Ìt\Õ\ìu–k\î£\Ò\ï˜®ş\îf\Ç\Ü\Ç\\Ÿ\\\÷­m7\Ã-\r\ÛO\öy¤Ù¹®Up\ŞQ\Æxü~†¸Ÿ†v	«\İÁqrûm\â“»G\Ôs\Ï~{W\Ò\Ş\ğ´>.\Òm\ïŒ)n±Û‘\æo\n/Ib6²\õ(_Î¶%]ÿ\0\÷\Ù\ïšú{\'r/‚ªÇ®\à\×…T\Ô\'k›m\ê\í\æC‚»o‰“\Ú\ÚL±\îù¡PO+3\òÿ\0_Æ¼\Ï^\Ö\×N‚\áÿ\0®PAf€:‰ÚŸ\öŸŠ/d¼Æº•\å‡sşµ\Ï[	\ÓEº‚F\Üf\åù\éıhş\Ô\ó§G\Ë[\Äùœ†~œÕ¯\ÚGc§‚¸f”maüX\n#ş\Ì>€S\å·8½[Q’šFlH§\Ë\\\ĞsÖ±lµ¢œ¬w|\äA=?¥/‹\î1r—«„o¹\êHk\\´I\åü\Ñ\Ç1\Æ­>V#eR;†›\ÌU\òØ†_›½)Dy¥º\íÀ9\éY–\ÆXd‚Nx\á³\Îj7\Õ#Â¯\İe\ç#¿ÖV´N\×%\Ûyf\\_qÿ\0\Ö\Å^\\[h\Ú11n+Œ‚}ëœ\è\Ép¬²\öü\Üw¤½»e·›k.\åwú\Ñ\ÊÀ\é\Ôwz\ÒGµœ>>\öj§«\\¤P¬»—qùHCÒ¨\Ú\ê?b\Ò\Ú-\Ç\í\Æ\0ª\÷s¢H¤–“\'<t£•€äŒ\í\"œª¯»\Zª\\7\ï¤l¨ù}\êK›¸ü¶ÿ\0–{¸Áªy\Â&\×\ï×¶(\å`lY\Î±¬d\íU%\ñŒU\Ë\Ö\"aºM€»pÄ“Yú¢Iq¹·;¨\Úı€\ô®º\Şú\Ş\r>)£šİ–9˜	\ò\Ô\à¦¨W9\Í3G’+\àd\óU\ãp8,	==1Šú¿\àq¼\ñ>pu¨-\×G‰»œ²Á\0\Ú\Õy\\¹\É`C^A\à_„7\Ş+=J\Î\Ö\ëa¸ı\È\å–\å¸,\É\0ŠúÀ\ÛøO\Âz†šg’;›\È\ÖKn­\nGµŒ\Ï û\ò4J7,k·\ç(K0\Ê\ÕJ\Î63º?:h·†~\"\ê\Z•—ú+Á1x!´\ã\'ƒ¾¿*ç‚¾!G\ã‹/\ÎXov~ş!\Ç Wº|_ø?i¯[°µ	#]\íH\ñIÂ™ı\òû®w@\È\ñ\è>Q\ñ†.~j\Ò\\B²«9Z9N8‘I\Æ}ÿ\0ú\Õ\âÎ”T¬\Ïkˆ|¢üD×®.fX\ÙXZ¬’a‡\r0k’\ğ”\ëp\Ç\öo²¼\ç\Ï\rsş}+o\Äu=/²±Ûœ\×w\\\×«h\òX_³Û¿fP\Ê\à\ô\Å\\i¥tf\ë^W>Ó¼C«FcQqä¯üÿ\0­z\'†ş5­Í”v·Wn˜\áI8­|\Ã\á·\ö2Ü­\Ã\Í4¨Ó¸Á\íRj¾>š\â\íh9\'=¿Æ¸*`Ô\ÏR;•N]üD‡L\Ôm\ã\Ü$¶¸nH\õük¡\Óüoq\öˆ\â…V;gù‹m\ÈQ\êk\å¥ø™X\Ù\É3H\íd‚zWi\àßPù¯Hş[®œ\õ\Ísÿ\0gù\Ô\ó4\ôg\Ğ,“S¼\Û\Ü+[ª±8V§\èŸ­\ô+o1‘­\ó†/Á>ŸJ\ğ\rw\â\r1â²ºeXN\Õ9ëµ\ÎÁ\ñ\n\â\Â!¸¸\ó#\Ç¹É¬ÿ\0³\å}M^e\ğ\í\ñ3\öûY†k9’Åˆ‚w|®9\à\×q\ñf\Æ_\Ï\Z\Û\Ço©H2\Ó)$7?Z\ñ/ø\ÆK„f’y)’6\ãN•c\âû«ˆ!·\óŒp\Ès¹˜œ\×v\ë#\È\Åf›h\ë<I\ãHe¸\Ù$…[\ÎÃ©®<x”\ÏpbUi%ø\é\ÅU\×\õÏ·›«y#Y\äl*2•[Lit«y¤&<l\ÚFıu\èQŒctx\õj3ª¼\×\á%–(1\åÀ9Ú \õ­¿\n\èûå¡O3i#§Ê¿Z§\ğWÃŸo\×mšFÜ²©![¢ú“^\á\à\ÏÁ4¬Ö°\Æ\Ñ1 œ}\ê\ç\ÅJ4\Ñİ„\Ã\Îj\ç©ş\ËµÔ¼W\áı1\İa[\ÌD\Ò*gy=k»ø¿\ğ\ô?}†\Æ\ŞFhÜ‚„€\ÌC˜q\Ó\ÛÚ¹ÿ\0ƒ\÷\ğ‡x\×\Ã×‘£m´»M\ë\Ã\0\ä #\Ø1\çÚ¾\Çø§\ğ\n\ß\Ã\Ş+mr\Ô\Ü\ê¡n5†n·c,\Ûp>\î\ğ@>\Ç\ë]|ù¢sfT^‡\É:‡Ã»«Y\âv`ştD\Éqª\Ãû\Ç\ò®{Y‰¼?ç¡\Ëa…\Æ~^@\é_¢Ú\ì\éo2\é·\Ã˜’\r\ÓY\ó™IRıÉ“Ÿ&;\×\Ã¶^›\ãm\ìZu“Ë¹·ˆ\nA8e\'±>\İ;Wq\çs«Z4PcødN95ƒ\ì–	|\ÃÁ\Ü\Ã#gÆ·4?\Ş_h\Ñ\\,e )û\õO™\ĞzSW´Û½7B2F\ŞdÁ •\n²g9\æ#Pµ\È\ôK\ëø†\Ş\Ş\Ş	o$¹o*$G\Ús’~«ù\Z\é?h«k_|\Òs\Zı²\ñ§^r§ üpO\ğ\ï\á6© j:±q%µ¨˜‡\Ó\ÎOú@a€\Ø\ì¹\Ïâ¦«~\ß\Ñ\É\á\íA\Ò\î[\õI%”©ù@\É ~§\ğ\Å)>Wf\\%gsÀüW\ÑÌ¾[²²H#<{\×\İ°WÀısUø{\áû\ë­GS†Z\îkø\ô\è\æX\í\ÄPª/œÇ¨b\Ç?\İ\ñŸ€mm\í|#\r\ÕÕ¬\Â\Şb:»GÆ¾\êı‰¼5k\á‚ú†¯ µ\Å\äm¢^O{\\Ô¶efØ›p\Z5\Ì`“Ÿ\â\íN[{\Ê\çÎ¾Ñ ¿ø1\ãMJúú_ˆLìº“†tX\'<–8bpû§Ö½«\Ã^³»\ñM\Õ\ï‡\ï\ìmü+-\ì°[\ÇjviÇºM…2G!S “ß¥xÏ€\ã\ğ\î¥û4øhj\Ö\ö­wq\âK\Íq£ŠP·7{eHF\Õ|£œ#®\ĞÁük¶ø~.\ñ¹¨ı²m7\Ã1\ß\Í}¤\ÙCfV;/,·²/DS†~uŸBœu4¼c-Õ¯€o¼Q|\Ó$p\Æ\ĞZ}©g@#Œ¶sJø³OŒ\ë¾(–\âM\ÍrùÒ eŒ\î\Ü\Ä\ô^\Ø\'=\ë\ëÿ\0\Úw\Æ73ı‰\ôZ\à\\}¡µi-g>hhc`hSFÀ§9\ék\æj6\öºe½šÂ²M|\åL\à„\ÚÇŸP>\\\öªi\ÅÜ—¦\çw\áŸ	%–«oi¨D\Ím\å¦\ó/\Z\ÌQQ\ã\ì\Ç.»\Z\÷¯„ş\r\Ğ\ít·\óŒ­$|\Ì$\âg\0W!\ã\î\õ\ïk\ğ‡\î\ïtk‰­ld¹¸Â’?”sm-¸\0\Ç\È\äü\Ç)\îO©øsIš\æ\ÓF\Ğ|€·\Öh\æ\é¤U‹\É\È.\âÀ\É\'¯ qŠ\Ú[XøÅºYË|§$¯¨\íş¾k\ç­\ÄkZ†\Ã!_@\ärx5\îÿ\0¶=¬\Ş\Ô|ˆ¤€\ÇpX\Ç\"IĞ¤u\n\Ãı\ê\ğÿ\0i\Úz\Ã]Kû»(\É{‡+’\ã;GRvÎ”t@lx\'XT\Ô\÷I\æ\\e(„ü¹<şu¯\ãR6qm#K¹ƒ7d\Ï$¥r\Z%\â/œ >\\\öoZĞ½šk66\æ*’Y³\Ğ\ô\Ç\ò­@\åon›\í¬wm=ÿ\0*§©\'E®I\àúTú³\âbª»·ş\õ©†EVgù\Ğc\åû´^\öF€ª—İƒ\É=jŒú‡\ï[o\İ\õ¨n\îrùm\ÍŞª»µ\Ä\ß.\åİ W5,u5G›p\'JÒ·“\í•wasX0yv˜fF<\ö\éš\Ğ\Ó\õ5]\Ûs¹F;PÆ3y\Òg£¨^kBÀ«Æ« \Æ\Ş~Z\Êy\İTùİ–éŠ¿¦\Í\æ@\Î~_››\î\ç¥!\Ömš\ì£N*+(\Zm\Ëòªª‚&®\Ër³\Ë\åûd\ïZ\Ú4=´[£VLŞ™ \n¶ƒÈµ\ÂÃ·\ä`\İO|ûWm\ào­İºB-\äšA\'™‰#9W\ğ\õ\÷ª\Ú„Œ\×va­¡dPI\Ëm\'\Û\èv¾›X\Ó\r¼I\Ú\ì•\ä³bn<\'¿\óÖ‚%¹\êÿ\0	N™\á\ß\r]\Üÿ\0g\İjZ†Gi§ZF\Í°\ÚI,˜Ff\ç!\n§®F:^I¢k~N¡g…’?1­¶\İ\"8\Ønù‰Ã¹`p2\0WˆÇ©Z™Su\Êş\î\ãz4«M\0$\ìr\äc&ºC­iš¨·kY5+©µ{±\Û<®!7~RÚŠª«†\ãq\È\ê2A‰®ü6“Å–³^*\ÚYG¨J\×W6\ê¢Y\0;ˆm\ë±\"\ÜGp\ßA_4x\çÂ°\ê\êw\ñµ\Ô`*n6:\à\ñ\î}z\õ¯«m¡¸—L\Ó#\Şk{{X\ãY\åºd)\Ã)o,dµp7\î9 \ô\â¼C\â†E\Å\Ìw.\Ò\Ê7Û˜t>\ã¦xÙŒ\Ô%s\Ş\Êà¤¬|‹\â/.‰¯\\I\ä6\Ô^b\ïy\çµq¾9\ğ»ZØ­Åš\ÈĞ²\îu\ÎH\É ƒ_Jø¶\ÎH34+\ö¨ú²J\ç¡ık\Äül$\Ò\îµX\ä’0Ñ„û¾\àşU•:\Ü\È\Û…\å\Ø\ò˜a›Cm¶ûZ)Tÿ\0tÆ—O\Õ!·¹0Iµde ¹n„\×Gw¥\Ú\Ê<\ÆHŸ\êÀ\ã>µ\Ï\êşFc>cv\Ç,+²	4yş\ôw1on\åÒµ\÷I½P\åCs\æ_¥hxwÅ­¸·\nª©»k\Æ{\ğ¨/¼7yk\Z/\Ù\äp\å}¾•B\×\Ã\×J¬ªÖ²È¥\ó\Æ+NDb¤\ï{Š<h.G—kµW;{rj…\ö¬şT{Ü¸aŸ–¹û{Y-\Ñ\÷+\Ü3v&®\Ü\ë\Ö\öºt0Æ¾dƒ®F[5\Ì\ÓÛµ —r<wÈ¬#”|»¾\ícÀ\÷^[[©/$hOqZVúM\ö¯;¼\è­ÀŞ»†ÜŸğ«‘”°U\Ø\Ã\Ì\ïş\ïµ>STm\Ü_\ì\Ö\ĞÙHşhşMÅ†\îŸızw‡\í?·/#_•N>n¯Tµd»–6Pn$•°H=\rzO\Â¶Ÿ}—A~\Ğ\Êp¸È\Ğ\Öu%#j\İI$w\ğ,~\Ñc¼\óRi\î‡¢\ã\Ë†½O\á|f*˜\ã‰Pgh\ìk\ÒKSlI\Êx\Î\âzş{WU\àhN\ÒE;7\Ú[‚¨x=\óş}+\Æ\Ä\Ôs‘\õZ<‹S\Ğ7H\Ö\Æ8O;\ôúcß ¯Ò¿\0iºÇ‹?f?øûDÛ¯hwÖ‰i©Gh<Ù´\æO26b§\'<\î\Îz·JüÙ±‡\ì¶\ñ¼‹ûâ¿•{\Ï\ìû^x£\öcø“¦\èv·\ò\É\á]­½Íƒ|\ÉÉ€]G\'®Gµv\à+(»~i‡r\â}\É\ğs\âmÆ³\á(tÿ\0B·\ö$q\ôûA\ÉùX !¶\ğ¼yS\Ï$W‚~\Û?±}¾·ªM\â%·‘[PV¿¾o(\Ç\n+L‘APF\å‡ F0k\ï}/\Ã\ÑüH\Ò-u\Ë•\â\r=\ó,\ò5ş\ëu\ÅxoüW‡Bøy\æ3i\Ñ\İ+±¼´’Q{dB’&27dzv#¸¯b5›q}Oƒ|eek\ğWÁ6¬¶\ñ\Ø\Ç$~u…Ü±—\ó•\Ôm\ÎÁ8\Î\ã5\ó\Ûx‚oø\ãI‚\Ú9 š\âT†ş\á\0>b¼€;tÀ;NztZ¹\ñ\ã\âıÇ¯K¼¿{ù–v“t/¹m²\ì\Û\äc\0Œu\àŠ\ì?d/‚W(I<L\Ìd¸\Ü\Ö\r™\ó\0tRÎ¹\àa›šÚš¾¦2’N\Ç\×³um^\óK\Ğ/­t\Ö\Ñle1™®`ù‘W”…Xÿ\0J€9nÙ¯¿à«ºµ\Ï\Æk³ş\â5%c¶+\"3ük\õ\Ã\ö0\ÓmŸ\\\ñ\ö¿¬[©‡\Ã\àJ\æHÙ¥DVb\ñPA¾£°¯\Çø)­œw_µ‹›[ˆ\çû}\ËL\óùC¿\ÌqŸ\á\nz/\ãXT’”´.;_ƒn>X\Â\Ê\ßegUi6nh\Ôr\ÍéÚ¾\îı™~i6Ÿ²?\Ä}{ÁZ‚\İYi~’;»»f\òc’\âD–Y	K)\ŞÆ¾+\ğ–\ç\á~†&›P†;V\ò\ïp²\Æ\ìˆ\Ø$Â–?Zıı”¤\ğ_\ğM¿ú—‡\ì\õ\ö_5ªİˆYl\Ôıû»ÁbO\ò;q[\Í{·\Z\Ş\çÀ\Ú\È\ğ^£\ğUm\ô\İB\ãX·µQ0\Ãj·hä»İ’&!W\ç\é×+\Ó&\×5/\ë~:\Ö\æ\Ô&\Û™/,ÑŠi\ïea\"n\èD™\ã€y\Ç\\ù½\÷Ä½GÁ\ß~¶“e5\åÕ§„\ô\Éd†\"\Ë<ˆ#‘›g_”\î\ç‡Š\ì¾2x~\ÃAøMª\\­Ö ú¬»µ;\ÛK­±Ez\Å\ZT“ vi0A\È\n‹\ß&°Æ…?‰O6£ÿ\0\Â\ğš\È!X¤\ñ,\ÄVM\Ù\Â;no¨aùW\Î~\r’\Î\Û\Ç^·‘K\Ûi[\Û\ÜM Ú‰à­\÷‚M}\ñKB‘\à‘>\Ôùÿ\0\á.\Ş{rZÜˆ˜®\êƒŸC\Ù?;x#@\ÆS–h\ä]7Kx\ñ ùM\ò•\ô\Çbr>µpÜš‡\Ù\Ö~#Ox6\×F\Ò\ò\ã\ÄF^\Ò\å&$Ox$s…\ÚY¼€9\ìÖ»¯x“\Ã²Nƒÿ\0¤¶Ú‡‰¯´·\Û\ÛO\'ï ›\Î\â7\0\ğ¤ns\Ğ\Ås¿\r<;¢ü:\ğN›\ã/kv±YJ\ÓË¦X³1k¬Ç¸\î\ç²À\ñM|ƒ\ñ\âˆş=üu“\Æ–¢ù\î/!Š\Î\Ø\Æ1\Ç&R&^\à–#Á \çŒhÑŸ1\ê“U\ñ\÷Àox\Û^ò‚®¦-t\Ø\ã·$T5%NFT®\Ò\ë×¾+\È<\á«\é,´\Û\ØÛµ³†\È,R¾˜\ã\ó¯~ı³5;\çı–<\á_:&\Óg\Ô&\Ô\"Dµ\òA\óˆ\İ<’¨AP3\Æ\ÜW+\à\Ï\ryş}bh#‹K\Ó|«+–A‰cQ‚£s¸t\ÅIqW\Øù\ã\Ïû4Ì«Â¨Á\ÏsZwq}—fı¾gZ\Ï×­¾\È\í\ór\ç½e\Û\ê2	V-\ÛT7QÖ´45r»û‘F\ŞGz\ç\ï#£\r\Üu\Ïz\Ø\Ô5²Ÿ\åÖ°ofT,\ß1\ç\éJ\àe\İ~\ä¸u\ïQ\Ú\r­\æ7=¸¨\îgV™øfElI\æ\ÖùTm\ô4s-\Ë7,c\İ\óq·p_Z«§]m–VS×Šl\÷†G-…\Î6ı*\Å\ó[§×½5¨\Ê\ÕM\ÜJ\ßyq\Î}i²\\\r­f\òÁ\Î\ÑY\Ş¾k\æ’’?•w\rÏ†ü±ZWZAK•m\Ä\îLœ\åTrˆŒS± ¶×ªWrı\è\òko\Â\×#\Édf1›pÒ±4¯\rj^!\Õ\×K±šşiP–\êef>P3®1_J|!ÿ\0‚YşÑ¿l\à›HøG\âæµ›%\É\íƒwJq\ïŸÂÿ\0„eoDbš3Â¢ˆ”DYŸŸ\ïg\ô®\Ë^\Ñu\rÍ¾\Çk4wgW|”s»\ÏsÇµ}‰\ğş!\ñ‹R°„øš\ç\Â\ŞV\Ú51qq	ã‚‘?\ñ\êúcÁ?\ğ@\0\Æ\Íy\ãO\Zx‹^¹`±é±‹h\ó\ì\Î\ã\ñ¨•H­\É\åm\è~:µ„·ú£,\Ï~IR,\÷ ’s\\Â½\á‡\ÃxüGe¦\Í<š”6¾q†X\áŠ_\İEœüÀ©\É?\ã_¯­ÿ\0€ı™>}›PÕ¼3®j@\É\ö¯;,Î l£\ë^»\ğ\÷\ö@øKc¤¤>øS\àû{¤¦\ÄM\æ/^¬I\ï\Ü\ö¬ş±½œ\Ìo\r~\Êz\ß\ÆÒ¾ø[\á\Û\Ë\è\ã\Ù%\Ô\ò\î‚\×hW\ËK#7g\å=\ÌcÒ¾x\ñf—&\âK½>\ñC\\Y\Í$¼V*\ß^A\ç½~\ÎÁC?i=ş	§û!\ê\Z‡ƒ´.\Ç\\Ö¥M/E±\Ó\íæ½—¬U@\ÜUInO\ğ\×ãŸŒtù¾\Ô\ó]1šúi\Z[¹	Ï™+1goÅ‰#ØŠù\Ì\ãœ•¢\Èi¾o{c\Å|q\à\ö\êIm\Æ\Øù$\÷\ç·Ò¼¿Wøw¦ø\é#’F†E\È\Ú¾µ\ô6¬‘~ú9±µ³9¯)ñ¾ˆºe\×\Ú#]ÉŸN•\åS\ÄIHúZ\Øx\ËcÁüW\ğ;û3s«LQ\\\òXzı?Â¸ı\÷\Ş¹‘-cV?2I’sşq_AG\'\Èÿ\0y”œ©<şs¢[‰Œ\Í>c\ëš\õi\ãf‘\ãVË“gˆA«4—l\ÛY.1\÷•­d\Ğ\áÕ¬•. dQ¹_8Ïµv\Ş$\ğœ‚V‘¬ah\äI¢O»\íş}kV\ğ\ô\×6{C+rdB¿Ö»#ŒRZœ2À¸™\ñ\èZZi\Ğ\Æ\ë~YË»‡¨¬N\Î\Æ)\ähV\íHş\à\ÜO®j\í\öƒ<€B¬±È£‘\×5—¨ø~E‡t\Ïnµ²ª`\ğº™wz\Ä3Fmam\Ë\Ôâª¶šúVı\ÉX\Ç9\õ5±k\á\ï)„‚Õ•z[\Ú‡=\ä\ë}¨\Ù\âl‰§…|Ú™~\n\ğê·X`ï¹‡\ò¯R\Ñtï°–…`S\09\ìGùO\ÂzMÅ™_)|\æ\Î0{Wo§xS{«^½\Î\Å=~µ\æ\â«6\ô=¼.ÔƒÃ–\òGw\åÀ<\Åc\É\Ç\Èk½Ğ´{{·1f¸#\ó\ÈCMŠ+4UXR8\Ç\nsŠ\Ğm±®ı\îrk\ÏUS\Ô\åI«+¢\Â2Ì ‘\Ë~5ëŸ±G\ÂŒŸ´nƒg\Z\È\ÖZl\âş\í\ÔgÊ>F\ãÓ“\Õ\âš4wW\×\Ñ\Û\Û\Ç%\Å\ÅÁE1\îwsÂ…ÿ\0iØ¯\×ø\'7\ìyÀ/…v\ãP…[\ÄÚ¬k6© ?4D€D9\ô\÷&½lù#0©rŸH|Ñ¤\Ğ\àV	\ä†%ˆÁ§\éŠ\Ùø\Ã\ğÁÿ\0\ô»yüK£éº„šx2@\Ó\Â¿®=ıkGLµÿ\0D\Ú»\×Ò¹Ÿ\Ú3â¥§|\r—™¾\î\á‚C~y\ğz\Ó[#\ç\İ>§“ø³\ö@ø\r\ñv\Ú\ê\ãÄŸü7qw\Éjk\Û\Ër@\ì#e\çX\õü+cÀ¿\ğMƒz$V¿a\ğ¼\Ú;XF\ËY]º\ìV`pÛ‹n\éŞ½\à\×\Â\ñ\á]µCR\éD\ØcŸ vP;¹ú×¤xGL\ò\ìä¹‘‚¬À•\ÇDkh\ÕqZ˜{(¶y“\ğ[Eøe\áOi6’jRiú°\İ$&`v©m\ÅA\ÛÀ=\ô>¼×Ÿ\Ú~\Æ\ß¾-\é²X\ë?\ô‹µ\Ûş¶Vc,Œ}0F¿Oj\õ¯Ü›­NkXdÍ‰$\ó\Çµ\ğ\çÀ\Ö~\Óü»u‰yicø\ñ\\\ñ¨\ïr5Ï„ÿ\0h\ßø\"¼^\ÑPøN·pK\æ\Üxn\æL\Ê\õ16\0l€\Ş~\íu^°Ô¼%ÿ\0½ø½\à{\ê‘ø‚á¥·:\"[ùwXh\í¢È‹q\ó· \õ_A_y5\Ô_9›\Ë\é·$ ƒ\Z\ç¼k¡Ç«\éù»’\î\ÙmT›}Z\ÑÉºµ\Î~úÿ\0\Z\ô<Œ\ñ\í[ıa5fg\ì›\Õ‹ı>=Yüj\ğoˆ?\áUø—:kf\"Üª\Îc¶ ¨m\ß.Kt>•\Ğ|bÿ\0‚nürÖ´\ë¥o\ëš\Ë}”\É‰SC$²VWPF]KÈ™#·zı‚\ÃZƒ]h\ã\ñ5\æ·oU\ß›º\Ì3À\äş>˜Ç¤øZ\Ã\ÄZ\r¾-\ï!d\"gIı\ï$\ãvx¥\í;+ZŒŸ´\Âı[\à\×üoC\ğŞ±¥\ê\Z.¯7$º¸²¼³x®!P›\0\äWN1\Ø\ç\Écï‡Ÿo\ñ Õ¯­\Ú=.\İ\Ğ]Z\Ê6\ÇwI\ä+gp#‘\Îr1_\ĞÖ§¬h¾1°K?iº.¡ 96\×\Ë\Üg‚3‡§½x·\Æ/ø&\ÇÀŒ–R®¡\à\ìyf!\Ş\çÃ·f\ç\0aŠ©(y\0ı\ŞÂµ§Z+r%\Ï\Ä\ÚS\ö„¾ı¦¼ia¢\ÚZ\Çg\áù\ö\Zl.v\ÆdıÛ·«À\'\Û\ğ­_´Yş\ßx\Òf’[M¼q	ûFm\ãš#˜ *\0-#²³\î\r…T`FYHı\0\ñ\ïüµ\á\Ùm§“\á\ß\Äû\í%\ÙXGk­\Ùù€)\Çj9\ã¸=ık\Î~!Á\">2|6\ğN‘§\é:^Ÿ\â-\'D¢=:\ò\ó™\ßs‡k–m«\Ép0’+¦5\"\ÕÌ¹Xøe\áßŠ¿°6‡¨_[Ù¯ü!2\Ì\÷¦\ò\ãw˜Œ)0¿\÷\Ôü¬§?3gŒ\â¾L\Ö>#A\ám;R‘\Ün··“Jû\")_µ¦\æeq“Œ\î*G¶+\ëŸş\Æ¼\'ûx«C\áWŠ\óP½\í‘\"w”)`&@˜\Æ\Ö	`9$\ó\ÆÀŸ´N…\âx\ÙÇ‹4[\Ã-m+,v\×\ö’\Û\ì\Î6–P\ñ·\è9©u\Â7L\ó}Z\è³no—Ş¹Sz\Ét\Ùg\n§·­uFF¹¯,\ÍÀÀ;O\ä?\Z¥e\ğ“\Ä^9\Ö~Á \é:–­w#\ä\ÙÛ´\òn=€M\ÇÓ’iÌ­sNVTPY`]Á˜±¬\İz\è\Ú\0SŒs\é_cüÿ\0‚~\Ô\ì­\ÚI \ÙÊ‚H\çÖ®¢³Vı’\Åÿ\0\ñ\Úú/Á?\ğj\Ï\Ä\Ít«x«\Ç\ğ\Ü\'–0™n\ØNŠ?\ÏZd\õ$ü‹º¹B\ŞX“f\ây \õü©\Ú\\ot8ù\öŒeO_\Ğ:ı\èøcÿ\0¨|\'\Ğlƒx\ÃÇ¾,\ñ\r\ó/+¦\Ú\Çkú\ï\Íz\×\Ãø7\ã\öYøOu\ö‡†¼A\â©!m\Ë«r|¢}\Äa3Ó¹¬%=t%£ù\Ó\ğÿ\0‚5/^\ÇŸc}¨L\í·Ê¶…¦r{\01ı+\éÏŸ\ğD/\Ú;\öŒŠ\Öm+á¾µ¦Y\İ’\ïXU±·ƒ\ÌI\ï\è+úAø]û?ø\àf¿\ğ…ü6\ğ—…\áŒ\íI–\Ş(F;\ğ\\\ö\ïÚ½\r\ã’\æ\Ù.&¸ûT’`ª\Æqúÿ\0Z#RÛÙ¶~$ş\Ïÿ\0\ğj6¹-\Ô3|Lø•¥h\ğ/2\Ú\è \Ü\\\ö\ãsa}{\Zû‹\à\Ïü\ó\ö_ø[o7º\ñİºl/­İ³gü¸\Â¹ëŸ­}m\âı6\ò\ñ$ki¡+\Ìse_l\\Ÿ«j·‡\È\Õ!_“\òÀa\ì=ª%Y\ßCx\Å[R\ÇÃ¯†ÿ\0\r~	\Ø\Ãk\á?\nø_@\ò~àµ°Hd\ôå±¸\ô\ë\Õ\ÖjZÔ·zm\Å\Ã]5¼j;0\\¼\äU}\ÃrKPÎ±\Ül_\Ş; \İø\Z\Ì\ño…\î4\Í>\êkZ;`7<%e\Åd\äÛ¹\\±5n\õ{=&Å¢\âkË•2;§\Ğt¬\ßGq…\âa$Š\ògSyşTï‡ºÅµn~\Õo2\ì^¯\ÓŞ¯ø\Ñ\Ò\ïlm$?¿™Qps´VSÔªqW8ˆ\å¼O\ñkG\Ò\ßw“gj@\à¾\íİ½\0¯TĞ´´\Ñ\å[U[AGPp\õ®CB\ğ…Æ£\ñ—Q\ÕË’\Ö@ŒBª\çŸÆºıa\ä\Òu\Ãq\ÃG6¸\éÀ£¢	|G\çoüûE\Õnoş\ëL\×Òµ›\Ór?\åš\İT[\ç\Üş\ğ\nø\'Å¿\ë$\ßÑ•J\ñŒ£\ğ\è}Á¯\Ü\ïÚ›\ök\Ñÿ\0k/‚:—‚\õ­±Áy‰¬o\0ı\å…\Ê\ó w \ğ}>¼~\'şÖ¿³ß?eŸ\É\á\ß\é¯–\ÄZ_¨o²_\ÄY¶¼2´’C|„\î\ÄW˜Ó”\Ñ\ïdøÈ§\ì\äy.«7\İ·nEr> \Ò[R°º‹b³(ùp+GY\Öf\Ñ\îBÉ»vq†\õ·?ZÌ¸Ö¼¹O\ÌÀ\É\ópkË\Ó\Ôú\È\Å5sÊµh\ä\Ğ\îš\Şee\ØÛ†;\Õ;›\Ñ2n(­¸\ã$t®\ß\ânı§k\ö¤\Ú\ÍüCÀ¥Â²˜\ö\í	\Ó\'’k¥7\Ğåª“d:£\Çqm\åù’FW¡SÒ³/\æıÊ¤“,\ÛG\çZsH¾Q\ÎŞ¼ŠÌ¿HoP…aZ\Âm5\"¶1®¬2\Í\Ü\Í\ÎGjÏ¸\Ó|\Öaa\Îrj\óK\öY\ÛV«K©¥Â²\íf\ç½o\íŸCŸÙ¡\Âv\Ç\Z\É!\Ç|cùUı3Â®%i\Ê±´wªú`–).q\îzWI¢\Ë$‹6\İ<\ÔûY\ZS ·64+\í¶\ğvœ\ï[Á‘¦ùy\÷5“§\Û\á›\ï\Ç\æt\È\ÜX\÷\n£Î¶4&\ëY\Ö#³Ó¬\î¯\ï$!\"µ†2\ó\Ê\ß\İÚ \Şß­c.ilu\ÓQ\å\ë|\ÉB³\î\àœ\Õ\Ôü\"ø9\âo~0¶\ğÿ\0„\ô»­_R¹<\ìc·_\ï»tU½\ë\è¿Ù³ş\õ\ñ\âø·Ô¼kÿ\07‡H\ö\ò\âMB\äpps9\ÆX‡Šı#øû1øO\à\"Ñ¼-¦\Û\év¥\Ú%›‹\Æ\àfI:œ\àp»G:\ç|>\ï3\Ï\Æf<­\ÂŸ¿bø%¦‹\ğU³\ñˆ®£\ñ‹¡ tC\ö[\'À\æ5=YNpÄ‘\ÏJû_\Ã\Új\é\ö\ê\Ê\nn\\€Ã’I9\'Üœ\Ô~\ĞVuÛµ\á9\È~˜Ô¾8\ñÖ“\à\n\ê\á.$†=ûı\Ò;×¥d•¢x“©9»È\â\Å[_‚>šşù·^H›m Vù¤o§ ¯˜ÿ\0g-[Vı©¿h›\ÍwV´işmÑ†Ï–9\0l×—şĞŸ/¼ss}=Ä²M¨±ƒM‹\'\÷$\ñ+\ë\Ø?\à\â|(ø[ckx£ûB\é\Í\Ëş°¶:şUt\ôÕ™\Ëk\Å{j7\Öv‚\Ò\äyÇ±¡\ñ0Í¥i\Ù\Ø\ğ\ÄmcÕ¥\áh\áÔµE\öˆ×„b8¸Ÿˆš\òÿ\0dêš„s3,)ˆ\ØzI_c(\Å\Ü\át\ÍZ\Ònk{Ë†@­ƒ¿ >\Õ\éZuş‘eg\ÉtV0¹¯Ö¾^yµ\ê›\Ù\İÄŒI×¨ü0\Ñ^\ê\ÙV_2@Ÿ\Â\Ç RÃ©\ö=Z\ë\âuœqùz|r\Ü\ö\Ü\ßw?Î²n5‹\íR\ŞhÙ¼´˜rŒ~4û]>(\nƒŒ\à•­«;c\æı\á\ãh\ïE\Å;4\Í-\Z\Î6úd9c\ïZ\Z\ïˆ\ì4\Í4ÁQ£B\Ã@\ŞÕŸy¨.Œª³´Í·¢/R.•\å<G}\âxš\Ş;;˜Q[hN$4\î\Ê\äC>³x·\ÇR\\6dFl¨\õ\ï³Kc\á29nŸj2cf\ìùWŠüğ¶­¥Nf’Í•› q\÷Fz\Ä~[™\Ö\æÿ\0ı7°Œı\Ôka{2¼ÚŒş!³V³ƒ\ÊY8 İ\íŞ¯A§6‡sL\÷7L\àg\å$\ô\à\ïM\×|{¢økL\ñ\í–\áG\Ë}W\ñ\éøV^ƒ\áC\âuÇ™¨Mp4Ş‚\Ö\"S\Ì\í¤s\ÛF2‚[›Ÿ´Xb\ßC\Òo\õ­JºXt¸\÷:û4œcŞ¼»\â\ÕÖ…û@h/ üA\ğ‡A¸¡qªL\'º€6F\ä!w+½XWÑº\'‡`\ğ/‡\Ş\Î\Î;K}¿\ê\ÑG\ë\ê}\ÎMqş+µ’kgfÓ£¼‰¸\ÚPdzâŸ´¶„\ò\ÄøW\öXÿ\0ƒl>ø)\í\ïş%xû\ÅÚ‚€\Ò\éšQû=xùY\ñ½\Æs\ÎW5ú\ğ[\öd\ğ\ìû ­¯ü\á\ï\ÇËº\Ò\Éf8\0–“—\'\0uj\Ô\ğ\'‹?´\ôeš‹\Ë6\Ã;¹\ë]\\²­…‹¹\nŠ¼œ\09ú\nÚ¥[-\å¹\ÈO\â\ä\×n-ZN\ÅP¸tëƒ‘Q\è~\Z’\r1š\â\â[«‰²Æ…\Ü+\Íş%|h‡\Ã\Ş9Y¤\Ò\õI¡L3\ÃA­½\öœ\ğ\ÅÖ¯\r•½¾­owp¹´l\ñ\ÉúŠ\å\ö‘\êÍ£F\êç£­½¾œ\ëqy\"}¡“0\ØP=1N‚ú\ßWG7—\ä\õ\0¸úW3­K§3>\â\Üo,6šĞµ\Ôa³¶\İq7Ë€¹4sv\'‘\'b¿‰4w†\ÊeÓ®<È™r\ğ\ÈD€ı2*?ø‘´\İ-­ZÕ¡\Æp]ºg=ªMZ\ÚK»H\æıÁ\Îı\áX¶ZÆ¡ª\êŸdX|\î~f\Û\÷E\ÌG}£Ck>›\å\Å4l\Ì7Hs»\'Ş¹OøRH¥{«fe\òø\Ê\ñL·Ó§\Ò\õ6Š\Æ\íD\Ò.J?#?†+OA\ñª\Ü<º~¤‚\Şeù2FûŠw\áˆk§N–\×\É4²œeGA[Z\öw¨²µü13/\Ë\óÏ®)\ÚG†¬\ôé¦¸Ê´¿&qúU{Ÿ1dÿ\0HÛ‘–\Ç4\ì-Ç„|Aj\Ò%¼\òÊx\ô\â®\êz5\Ò\è>uÅªùÑ²\Îs\Î+N\ÓP\Ô \ò\ÖW„m\ç\æ~¿­3_\ñj¿–‚\â\×vr\Ã\Ì\à}j%¸F2½\Î8®©£|@¾a¸†\Î\ãd©\Ï\Èr0G×Š\ôÛ¥\Z¾œm\åA\ê8®r\ã\Ä0]Æ¶\÷¬³@\Ü,\É\ÑOµB\ğ]hd\ó$¸±o»\"ü\Å~´‹qm\Ün·¨\İh	´#O™s\Ïÿ\0[\ğ¬_\ZYxW\ã?…\î4i6:Ö—x6\Ëi}\0•[¶WûŒ=Wº‰¦·\Ô#Uv_˜d0=Esş!\ğu¼\ì²)X\ät©\Ç\ã\õ¤\ä¶e\ÅXø\öŸÿ\0‚\r\è^)]C\áŠd\ÑÁbWF\Ö\Ø\Ë	=BC0s¬s\Ïücÿ\0‚rüRø\Z\ó/Š<#}§\Ã×f\âÕ†x!\Ğ7¦p@¯Ü«-6m6\ã?hf›s\Î>£§§kşZ´2G3G(\ç8tu<a\àş<\×%j0{nz˜|Â¼Cù\ĞƒR\î….$da\ÊÈ£Ÿ¦3ú\àûW”üTø5¨xF\ò9’7=J½OSŠş>(~ÂŸ>/\Ş5Öµ\à»¯\îk5š\ÒIO\Şv“\Ï\\gß^q\âø#\'ÀX´¤øš\İf\à4zŸ\Ü>Á®_©‘\Í/¹ü\ì\\\é\ÓGp\ñ¶\ìƒ\Ï<T\é2\ìù?\ñ_µ¿?\àŞ¯ƒúd­\öms\Æú~y\ß$\ĞJ\0\É\éû¼şµÀ\Çÿ\0øfœ/¼TW<iO\ãüª£‡²±§×“\ÔüV_Ş³>›vş¤Ò¨\Ï\à\Îw,¥Tœ\r ŸsÒ¿i¼ÿ\0-ø=¤HR\Ö<qªÆ§>W›úwT\Î?\Z\ô/Á1¿g¿‡\×\Í*ü=R˜.\õ[ùn¿Møü+EDŸ®ƒºg†¦kµ…c–\âf \"\Ç\ó\ïúl\ÜW\Ñ\àœş3,siÕ´û#7ºªıŠ\Üg‚ü‘\È\çûQ\à_…¿~mÿ\0„o\Â~\ÑnI-t\ÈVP\ß*[\õ®\öşn\â(™<\×^\Ë/\äkHÒŒ^a$\ì~}|ÿ\0‚Z\ésEq\ñ\'\ÆQjHª<\İ/@S\Éş\ëL\Ê%\0û\ó\Ç\Û_ÿ\0g\ß\0şÎºTV^ğ¾—¢yi³\Ï\òD—’V˜\å\ó\ô\"ºk­\'Xs,\nLj@BÍ…ı1Xx²\ò\×Vk\ô]B\êùT\"©‰út­)\Å\'±\Ç[)\îwq\Ü[\Û/˜]±\Ò7\ÌG¹\êß‰5›©üU\Ó\ôƒ²5ûe\Ó,h¼\ğú\ô®oş¿ø¾e\â\ò +“oı\á>›¹®«Á¿\0±¥\Í3\Ï—?\ñ\ò$ù¥}OOÊµ–‡)ÿ\0	®¹\â­LZ\Û,‘«.b\äÁœ\ãq\é^kûS\ë’øÃ‘øn)>\Û\âMa|Ë—‹89\Í\Æy\õ¯¡¯\õ\áƒ\ï\ï¬É³\r\ò\Êÿ\03Lİ€üF\Zø¯Ç1º¾›RÖ®|ÛS\Ä&m\Ã\æÀ\é\×\ÅO1\\\Æ\ì\ó\ğş?Šj\Z‡—5‡†ù7ı\Çs\Èøø\æ¾úøIk#i‹)]ª±œn\Õ\ó€¼+ÿ\0\n·À–ZdY½`\á˜ü\ÎÇ~œÂ¾¨øE1ŸÀ\â`W#w9\àV‹bY¯\âK\Ù\"\ğ¬üµÃß\ç\ß\õ+{\r.‡¦\æc\×o¿\é]\Ç}}|\àû]¯¶\å‚,[{±\ä\ç\ó¯5¸´û\\Id’K©\ÈR	\ÎFü¹©–\ä­•\à,\Z³4k\æGÊ»ˆú×ªøcAo\é\æfT\Û!\'\éÒªøWC‡NÓ“rˆLc9; ©\öÙ¥\Û\n\Ç\ç4Ÿ6\Å\êAŸÊ¬¢„¼­$²*Ã·=I\Ísÿ\0ş3/Ã-c†\ÕZ\æF\á}ûW]m¥.››P\Ú\Òc+(ÿ\0\Zù·\ã.³q\ã?ˆ[\Û.—j3°’ir¶£\é_\õMbş\ŞE·\Ü~\öF]\Â#ù\×q¡\é:§Š¯bmAÙ£Œ\ç!)>\ÜVÁ/‚Ÿ\ğŠxy\î/cE“hf\Ş\âx\ë]Wˆ>)\ØxfÍ¾Ø²Y\Å\Ëı4?ìµ\\¬W:7±şÈ·u’Cn§Ÿ7Šæ¿·uO&™¤¬‹K8ı\Ó\\«ø¯Xø’\ÃlwV\ö[°‹ÿ\0=®O\ç]·„5I´3~_—°€1Ò¨\\\È\Ê\Ô>K¢X«N\änu\Æ\\œ\õ\'Ö»\ßø\Ú\×J\Ó`‰‚Á\åeûŠ“P\Õ\á\Öm\Û\Ì\Üd“‚;W¬YıŠà¬‹ˆY±×‘LÆ¦»–¿\ñcûV\õ¡·FŒqO>\õ\Í\ê\Ş+Ô£b«\Ğ\Æ‰\Î8®“J\Ó\ÓJ\ğ\Ó8üÉ¤]\Ê\ÛzV¥¡kú¾š\ægŒlR\Ø8\Î=*Z2½«\à\ôsYÅµ£\r\É#v\ÎJ\î.’;\È\ö\È\Ù]\Ü„\×\àb=Àzm\å\äŠI¶PJ\ô\'*„ ¼\ñ«4\òI%½¬x(O\0\óDÕe\İ\Ñw\âg‡Æ q\Z\ÅŒ}\æ«šø+>©$m}b\Ñ`¾V$\ëØš\Ü\ñ\æ§\î—\ò\Ü2¢ \Ëx\ó\\·\Ãùcº’hU›27,©\Èw\ÇJÁÅ›]‡‰$¸¸y£†|¶Lnİ–úú~•‹\à½_7\ße¹1´È œ\ã“Öº)\õ˜\ã\Ğ.¢¶Œ«Á\÷\ä+\÷«Œ\ğŞŸ{¯\\IjÑ¯Ÿ\ónd\éZGD\'m\Ù\Ój\Ş1\Â\å\á›\Ë+	À\ÚkGB\Ö#\Ô`o±¨†IA,\àt\õ®&ÿ\0Á:ş«­´p\É\Ì\Ã\'3]n‡i{\á]*Hd’5	T\" \\¨ü©™{¢h>\rºŠ\îk¦™²@2¿N•—\ãoZøVxd\Ö7a\ÎQÁlœ\Õ?\Z\é\×WPbûS¼v8X¡\ÃY|¸\ñGˆ-vµ\ëXLÅŸ\Í%›\Ü\óPÓ¹qå±·\â\ÛC\Ğ\í\ãŠ\Î\Æ\æ\ò\æAûµë£úV{|u\ñˆ`X£‚==n9.À£\ó®‹Jøm\á\ß\0j{Jù™8| \ã\ñ\Åj[\ë:%¦£,-\nw/\éT¹‡dr\ÖZE\çˆ-$\ó5›«¦Œ|Á>U*¶“\ğ¢\óR½\ro©*ÇŸ°x\ö9=Æ®K¨\ÂO~ÿ\0e’H-X\î\à…N1[\Ş\Ğ\Z\ñ|‘$‹\n\òJ’3LV$‡\ÃwQ\İ\ÛC5\â\Ëk\Û\å\"`¶;ÿ\0ŸJ\×\Ò|o6™;[ı–Dv\ó\Ã/\ãZº&•û\ÇH\Ò\Ş5\à¿,\Õnu\ÔYYm\ÃGĞ³¯jdglƒW\ô.6<¶Ó•’\÷\ÂwW0\Ä\ZM\Üe¼³È§²­\ÔÖ°2C6\\ŒŸj€Ë¶\îDŠ\é­ø\ÆY¸oz–‡c_\Ò. ‚-™c!À\Ôık•Öµ[A“l0N#°+»\ò®\ÒMB\æ\é\Z\ÖAp-‰\'\ïæ´ –K;˜~\Ñ\ÈÊ¹”uÉ¨qb\ö–\Ğ\ñ“\ñº;K—\Ü\Ã\"±´d/J¿e\ñ\ÜY#H59\Öq\ò\ÄP6\Óüı+\Ø/\ß\Âş\"]\ön\Í\Ğï‹·\áX|\ğ=Ì™··²‡29\õ¨t.\îiN³[¨üU\Ó|]¦\Égx\ÛF\ÎHQ\ŞÄ•\äº\î±o¦\\40¼2Gœ¨‘Ao\å_N[ü\ğ¤3–²\Í\ÆN\é€\ã\ğ\ÅG\â?‚¾»´?\Ù\Úm«\\„ı\ÙQ\æd\ó\Ô\Ôı\\\Ó\Û\\ùmu«©]DSp\ÇN?,U\Û_\r\ê·\Ò/™j\Ä1-¸FW?­wCU—\ÃÚµÕå¼ 1„u«0k/<Ö«\"\É#\İ;›\î€\0\\¶Ğ¯hpv¾Ôfh\Úù#§j\ê´/¬nqp³L«‚y­‰\Z;Ğ¶\Ñ7\Ï)\Ê\ä\ä…^¹ıh\Ñ<`±\ê³\ÇŸ\Ú$cº\"¾ƒƒŸÊ€»®,¥†;i\ö\"—`\Í\ÎqMŠ\ÏG\Ò\ô\Ù./®;4i’;Õ\Å3j:‰6°\Íg\'Ù˜0ıî¿¥y_‹\ÓV\Ô|Uk\r\Ã3r`9Lbª‘=Z\ğ¦¹¬\ñ\Ú\é\ö«3†\óˆù€\é\Åg|~¼\Ôü+\â+]>+†š\ËT*½»sù\n\İ\ğ†M­­¬«µ$U\ã\ÎşÒ!ƒÃO´?Pº}°7ü\óúU\ÔdGc\Íh\Ïi[i\Ş´h\æŠ\Üïº‘\0a\Ô~\0ø×•|\r\ğ\ë|Fø·u¬İ·¢øaHE`6´ƒ\××‚:b­x\×Q]/\Ã\Z…Ô›\ñ\â*®Ç–s\Åz/\Ã\ï§\Â\ï\ÙB\Æi#}¯Ê¬\Çø˜g\ô\ÅdR\Ô\æ¼q©hkqLUpùÁ=q“Šú‡\à5º\İ|+¶T\'\÷‘„\Éú\ó_%ø¶F:\Ô%•ttJú\Ë\ö}•‡\Â;wU\Ú8$\ô­¢\ô	+nrÿ\0ÿ\0\â¶ø‡c§\Ã7\ËfT2/r;Ö—†ü5kev\ò\\H»\æ\ò?\n\çü<Tüb¾‘–K‰ÊŒ¯ù\õ¯Am\í\×*\×X\Ãa\"Q\óù?Ÿ\éE®g\Ë}H­¼\ë\Ù|›x\ã\ßÿ\0=û(\ôü\õ­\íM‹A\åÿ\0–¹d¤\àşu\ğ[\éqå‚¬Š?ÕƒÉ¬ø]K­NO²\é\Ö\à³\Æ[o™F=I\éj£E±\Îüwø6¦\Ü\İB›™˜\Ã\Ñ\óL\Äteş\Ï®#o\í\íj-Ú…\Ç\ïÿ\0«S\È^µk\áOƒ\õ‹ş&_\ë6“Z\è¶\'ş%z|ƒ×´Œ=\òqÓ¥z\÷‰¯\ìü)a}¢8\ä¹m¨­\Ô\àgŸOL\Õs	»ÿ\0>\"iÿ\0¼/6¡t¾th6}œ´G\Ê\Ô\ñ\\\ÏÁÏz§\Äÿ\0	Wœ\Ú\Ï\Ş\Ú\é\ì8·Nª9\õ\Ï\ãY¿|.ÿ\0´Å«\íORY$\ğÿ\0†g\Ø\"a”»¸\ê£\İFA\ãz\×Ñ—¾·\Õ\'_6I$\0c\ËV\Ú	\é\éÓŒ~v0•H\Ü\áu\ÓtQ\ä\é\ö\ñ²§\Êvµ4mCU¹fÕ“q\à\ÔW§A \é:dP†\É‡oşun\ëY\Óü?j¾l\ÑB†A&\ã\ÔÇ·dy´\Ô\0ù\Ï\Ù\Ùyù\ÍFş	kÃ³\\\\g¦\Ş+ \ñ/\Ç\Ï\r\èrª\È\æo\á™ú\×+©ş\Õ\ÍŒ¶ú|pªœnsœı*y“vC\å›;=\ÃZµ¤h²ª¤_\ÜÚ´eøooxÛ¦¸™X\ó…<cÒ°şø\ã\\\ñ\Í\÷Úš³\é\ê¸%ù\\ş£\ò©¼U\ñ\ZKkÙ¢†o¸0\núÒ“Q\ÜJœ›±\á8\Ó\á&›ı£\Z\ÃB¬›\æ=¿¥I.¹e\âI!\Ó\ì#V\óP*–o•@$œ\×\á;{\ïü%\ĞcŸÎši”J@\ê€\ë\íÖº\è\á	q\r¨“™›\Ğ\ñY\ó#ndt^/¼³\ğçƒ—\ÈK{ˆ\äùq€À†¸ÿ\0Å­-¬—P\Åi,ø\n)+\ÇZ“\Å\öZ\Ô\Za?\ÙpÅ§£nP\Ï\É>µ›k,\×1D-„‹‚Û¾QŠaÌ‹W\×$\Ó\ô¹-˜Z™nc\Ğq\Åe\é:•\Õ\å\Ävv\ŞZHÏµ–0<Ó¬­¤¸+\Ío™ND„t=+j\ê\ò\ß\áÆ\ö”U¸¾˜”B£¾j\n”Õ¬Šş/\ñ\"ø\ZÓ¬[\Î\Õ.\ñ\æÿ\0«Œ\ç\ğ5R/%…ÅŒq\Ê\Í4d™Ÿ±nÿ\0Ò¨\è^\ÔüUª-\õ\ãšá·F0=+¼‡\áÕ…“G%\Ê(etsA‰CN\ñ$\ZÀ‘Z\ÏÌ“±\Û\É>¹­4F²\Û<V3-\Ã&-\ò¯\ĞU¸\õk=\Z\ÙV\Ö\İ~SıÚ†?\Ã$¾d\í\"ª6@({¡\Ï\ê\÷\÷–³Guj\÷N\Ã\åB:~5ÁKMN\×Ëº¶¸‰®9uY>l*\ì/ş#\Ú<Œ!by\"«\\|HµÓ¬$o\Ş4\İTrh6Œ]Œ\Ë_…z‡bı’en€4™\È\õâº+Jµ\Ñm\Ö%UQ\ò©\ç5\Îxg\í\Ş-½ûDŠ\Ñ/\\5vd\Ï\"‹Š\ÆzY\Ï\â\Ï2\âFŠ\Ú3\òÆ¼f£\×5Á\ä5­²°nŠ¨1Wµ}_û>\İLx`ÃªŒ\×\â\Ëû2K90\Ø\Æ1\ó~([\É\ö	n\Z\ê\ÔH\ñ®O\Í\\Ÿˆ¼h³Ü´kkpª¼)\r\Åf\İxü\é‚\â\Ö\ê\Ö\á®&.\íüª\é‘|EÕ–{©­|¿¼XddS\å\Ò/xv\ßZ¹½VsM\ZFxE8.}+\Óü=u®\ê2G\ö‹8cV_™\åS\Ç\ëZ~\ğU¿…l#i¥k©RW…úU_x\Úd³’;KrYx\Ë8\Ò2”µ.^Ë¦øi\Ş23\Éı\Õ\àV.«\ñAh\Ö„’N	\n8ı+‚‹\ÄÚ§v\Ñ\ÜÛ´œ\àn|¢»]/ÀÖ¯m\å\É,£y\ÛNÌ¸µcW\Òa\×Ç—§\Ê\Ñ\È\ï…2H\÷\Çj\Û\ğ_‚d\ğ\Ô\Ë\öA¥–Cşª>6ŸS\í].Ÿ\á¸|7o$¬cV\Ç\Ê@\äT\Ö6\Ñ\Ãl\Ó9F’Nw±\ç”ŠM=\â\çÀ\ë?i\óI2}³n\âÁø5\æ~²\Zv¹i\rÒ³µ(\ö\Í{Š¼{ı…m\"ùƒv\ß,\ä~5\ä:F¶ºÇˆ\äš\ã1³ü\Ù\ÇM—\Ô\Õi£+Ggı\ñB\ñw*\Ú<eÂŸ\á\ÎzUŸ\ni1X=\õ\å¸\n6£’sXş:\Õ\ã¸Ôšx[sFp\Í\Ó#Òµ´=Qu?\r²Ûª\åTŒÿ\0ZÎ¤JUÇ‘ø\Ó\â\õ\æ¹y#\\aabª€\ñ\â­|7\Õ·¼S\Ò3m ¸\Õ^¶\ğí–\Ö\ğˆš\êf2ÿ\0´j\×\Â[{¥Ü£†\à½ª)\èT•\Ñ\ô_†\Ä6¶j»U¶¡\Ûı+À?j=T\\|M³±\Ç\Â\Ö\ìÄ·5\î\Ú.m£+û±\ÆXşµ\ò\ßÇ¿jüi\×$\\ºÛ¸Œ7 Q\Û\ó§U\ëbyZZk\â³\'Š> \è¾‹|…®CKø5\ô\Ç\í?hºGƒ<!§\Ç\åÆ©A\òı+\ç¿\Ù\Ò\ÒOş\ÑÖ·–Ü¼œ½\Å{\×\í—p\Öş&\ğ¼»c[%*{6\ïş½O+KP„µ<C\Æ-b\ÓÌ’M\ŞP<µ\õO\Â]at?v7Rc\æ’(\ö,\îªü\Í|£\â\É3\â¨U¹\0üM{Sx¨\Ûş\Ä\"\Ô!f\ó<;5¥\÷Ã²x\Ïå´¶~‚®%T>ƒÒ¼\'k¡\Ş5\ÂD·\Z…\Ö”\òeW5›ªj°\éW}5–á¹‘‰ù!¤\×-i\ñoS\ñOÂ¸\æ\ğ\ì\Üj³\"	6·\ï\Z&\÷‹\Ïn*¯\ñ\n\Î\r\'@±\Ñ\Öù£·Xü\ë\ë·l2w}z`zV¦q\ÕXn±\ãxLÅ­\Ç\ÚJd\Ë9?\"ú\\\ï\ÂıO\Ú#\â_j\Ì\Òxg\Ãr\r‘v¸˜Ÿ—=ˆdW\'\ñ·\Æ0\è\Ş·²Ó•\í\ÛR+Hÿ\0\Ô\ñ¸ıN*\÷ƒš]Ÿ\ÂÏ‚6Q\ÜH¶\æ„\÷4²?\0\ö¸\'m\Íø\Ş\ãÀW¾Õš)‹Gm±p&`>\êÀW‰O\â\İO\â^«5ª\Ã4—\×\Ö\ë\ZäŒ·s\è9\'µ\íš\õÎŸ\á;u\ñ‰ck\ÍJş,ZY\í³Œr8\ìNI\'Şµ4\Ù\ô\Û7ş(lm¬\Ş[o*\Î(€ùs\ËI\õ\ç\ô¢\æN\\\Û4ıWCı›şiºLŒ\Z\âp!‹\æ”ı\æ\'\ë\ÆO¥xg\Æÿ\0\Ú\ãZ\Ô!’\Ö\Î\ãû-K«„~\ğ}[ŸÒ¼\ï\öı #¾\ñM\ä:}\æ\è\ã>\\Óƒ»8ì£¯_N\ä\×+\àß‡z\÷$†\òk;«}>cˆù3¹\Û×½e9\Î^\ê)F\óÜ·k\âZMI¯$Ô¯$ùQ\ç¶}I\'?¥{gÁ_\ßx\óDš\Şù®O\Ï²03\éÁ¦ü>ı”¯\Ñ\Éq§I4\r‰Œ~9\Åz´­\ôr\rş¥¥iv\ğ®Ô·¶<…ú\äûÒ4•›*u\éd\Ú•“yj\êB\Ürs\ô®¿Àÿ\0\ã3K^†\ÚX\Ô£$ı\òxÿ\08¦¿\Å_ø.\Âhn.\ñ…š\\ŸÊ¼\Ï\â\íªk®\ö\ñ*˜A\Æc)ıkNh¥dg«Wg«üLø\ßg¢iri\Ú[C\ì\Û\ò0Âlb¼CQ\ñ\å\Ü\ó\"\Ä\Ò3g,\É>\õ\Ä\Ûi\Ú×µM\ëis˜\ß;`\ã\ğ¯døo\ğ­¢/,F¿QDT¬˜´˜\Ø~%]\r\'\Ã6ºIh\î/4ø•\Ğ/\n0k\Ô<\áMR\ímÿ\0´®%;€, ã¡®gà§†-®~*]\Ã2#6§Á\Z)t\ãÿ\0¯^\Ğ\ñG\á‡úÁ\Ğ{VÑŠµÙŸ[uûN\õ¼\Ìù*€o»‘şEaj¶vp²\Û\Ü m£\å5Á\ÅVø‰\ñ\ãC\ğ\Ûo®\ÌQ’ˆrŞŸÒŸ¤ø\æ\Ã\\\ğ²\ëP.\ÓtvA\æ/,ŞŸ¨¬ıÔµ¢øOC¾Ea\Ç\î\Ã•¯?„´ûù\ášx„’@.zŸş½a\ØÁu9—^Z\ç;s‚=ª\Ô\Ş2†\Ùgxÿ\0y¼M#¶z`qJ\åû6\Õ\É\õO\Ù\éZƒYC4j\ñT@®\Æ\ßc°Ü\İl;±Œ\ç5\åş\0ø£¨x“PÖµ+{_´\Í%\Û ~U)ºn}\â\éd¸¼l‚Rt\ÆJf±‚H\í4jş&½*\ël\n¸.G\ãQ\İ\ë·Q]4\ru4Š½\Æ9ı+{\Âúdz-¦V±†\ÖC\ÎO­t:\'ƒşq*Ù¦Ş˜a\ÏÖŸ).¥c\Ãşº\×$M²ya‡\Şa]V“\ğ d¸ºg\nsÛŸÒº«[;m%BŠ¿Ã‘Ö±ş\"x\Ôø{OŒÁ˜\Î{v‰\æm\èlI,\ZRªÇˆ\ãªk_ÚŸ\è\ñ£*nù¸_z\óüF\Ö/W\÷-\nªŒ\ì-\Î:\ç\î>\"k[²\Ş\Çp©´\ã\Êû†³•\îh¡\Ü\öOø\ÃL\ğÎä¤ˆ\åFB \ŞO¾kË¼E\âÅº½Y ¾hd\Îv0\Ú+“\ğÖ¬±\İ>\ñpY\É+½ª–½q¶V§‹\Ü\ñ\è*”´-»\Û9¼o¯\Ç\Z/™wŒ0{×·xÁv_\r¼4.Á!Oˆ\ç\ë^q\ğKÂ²¦—>­,b?=v[±v?É®\óXĞ¦¹³9!HWØ¿SZ)Ks/\Å¡»™•~\×\ò\ğ;A®rT\ê×Š¿Ù³>\ã\×y®¥ü=È±Cf¬A\áœ@®ƒ@\ğ\Ü:t-q$q3F\0\Æx,¯t\ËÒ¼1\Zi¬\ëb¶\óc#<æ¥µ\Ô~\Ïr±\ÉD6\åªÎ¥\âY&’HacU?z¤\ğş‹ä˜¤’o5	ù²*¹‰$Ö®¿´\r­¶&ı\ê/\ŞIa¦¤q\í;¸\éÚ®=´\'X;F\è\Ôg•\Ä|C\ñ˜È‘+\'•\ë\ĞÔ³jq{œ¯¯œ\İ/˜\å\Ï\0u­\ï„_V\ò\ã\íwQ\æ9H\ã?\ä\×/\á\İ>\ã\Ä\Ú\Ş\é\÷5¼„¢½³Oº‡O°vEÚ¢´A=5<»\âGÀ>Y®-•vNÀ9¯:\ğM¬\ñÕ¬‰\"\ÆÀ\àc¡¯¦Ix\Û|\ïŸ\ØgŠ\ãüu\ğ­®\ç[¸\Ë$™\ìk*Š\ä\ÆI3å¯:‘Ô®¬ì¿\ÚS út\ç\ò¨ş^¿¶…W,\Ç-\ô«ÿ\0üu¥x¢\â[¥\î\ì=?\Îk\'\Ã63Á¬\Æd‹r\í+\Ş\õ‹LêŒ“G\ÑV—«‹o\ò\íaw\Ë\0\'ùW\Æş+¿ş\İ\×\õ\íA_j\Ü;\ã\'°$~\0WÑ¾7\Öÿ\0\á\rø/©M\"±•¡6\à\î\É±\È\÷¯—<G\Ùü3!Œª;(\Ü~Ÿ\Ğşu#\Í-z\Æ\è\é¿b3\Ï\ñ\Õ\ÕÔ‡-Ú„y¯Zı¹\Õ\ÛÅcÂ¶œ\é“Ô\Ãÿ\0­V¿\à¿SR\ğdú\õ\ÔkûË‡H}Wn\ó®›\ö\ê\ğ|š…¯‡\ï\âµf[y&…\ÂvS¨­§cšW>[\ñÚ›?Y\Ê\ß2\É\İM{_\ì©}¦ø£H\ñƒ\õ²£I×¬dµœc\î‡R¡¿¿…yakˆ\ì.<²­`ƒú\×aû=\İ\ïø‰§ü\Ş_\nn_\áÿ\0>\õœtf\ÒWG¢iŸ³\ç‹ş\Ëbš^\íB\ÓOÚ¶š¼¿#F	8u\ô\Ç\õ\ÍXø\éà«¿|W\ğ]Ì—.‡\âY|«˜ˆùm\î”;½ŠÁ\ï]¥×ˆ|Q\à«çµ³\êV,\Äù9\Éa\ìz~•½£øŠ\ßâ‡‡®4‹\ä6·\÷¾Bº\0\ö\ó\ó´\ç\ñŠ×™\Æ.;Ÿ/\Û\ê\ñ{\öª™cùltÙˆŒ7?*€¯Æ¾’Ÿ\Ä\Ö&ø€¶m\åÿ\0bøFw©\ñ<\ì?u§d~\Õ\ò/\Ã/I\ğ?Ã¾>\×\õH\ä\Ä:N¦\ö\\£-\æb˜³¹F}\0ú× x6K¿|±[\Ã#\ê^ ”\ßjr\Ëy¬\ğÀü1K˜&®z’u?\Ú\âl³I­»\î\ìx‚ q·;Î¢ı¬ümxšu¿…ü\'\ëû\á\öXd_”[Âƒ\ç“=2rG\á]Wƒ$O…ãº¸ÿ\0®»‚\ËúÅ\Øu®w\á\Ç\ìûª|R\×g\ñ7Š¥›IÑ³‹hm’D û\Î\ë\Å+6ar»3\É~şÌ–zv¼°È­\â-tcªf®\â{\õ\çšú{Ã\Ñ~Û­Ş·4š\Ö\Ğ\â%o’\Ø(úƒ\\¿\Ä_6?m?²|3¥Cm”7s\Û9\ë^9q\ño\\\Ï%\óM$\Ü\ò­œw\ä\ÔÉ¥¶\åÆ—<µ=“\â/\íªkÛ­´£%®\ñ·$G<\×\Ï>9\×<C¡/’\×sd–TrO\ã[Z.¸·z\ô;ZEÚ¹\Él†\ä\ô®§\Ãú´\Ğx›\ÍX\ãf<}ŞŸ_z\Ï\Ù\ßVo¨hÒ´x¢\çÊ\Ê\â€\ã\ÌN‡Ö½c\áÀs*úµ\óü\Øm›GøW­\ÚH·’#\É\n\Â\ì:€UI\æ\Ô\ô­T\Ç\r\Ñh\äû¡¹æµ§MEÜŠ’sÜ¹i¡j^³2¢\Ç\"(\áUy5%—./­\Ø4>S+a°\æ´,µy\Ö\ØGu4j\Ë\÷Ÿ<}+6\æİÛ´rFbdzšÛš\äF)+_î¢¿ø\Õ\ã	#]À* o úWQ\ñZ˜^y1\ŞCf°&ùK\õ\Ä~Êª×¾%\ñf \Ë$*\÷\çù×–~\Ô\Ş2š\ó\Æ×‹kw œ¡\0úVU\'Ê’3Š\æ›h\Ã\ñ\÷‰\ìu\Z\\7·\Ş[\0­œ³œş\ôw‚ü)%¦‰¦\êW’(\ÓmmƒÁlz‡\ç“ú~U\ò¿\ìÿ\0\áy¼W\ñCOƒoœ¥·¹ük\êş8·\ğ\'„ş\Æ\Òlei\nxJq\ØN-½4ø‡\ñ\íc\ñCC˜\\\âL¿Êœ\Õ|y%‡Ã‡™n\"Y5\rÑ¤\ò0:s\ï\\§Á¿/µËNúÕ\î»r%Á\Î~œÓ¾5]\Âc\â\ë}E²T·…¼¸â‹«±\à\à{qG+gDtVd¿²ÿ\0…nüU$p¦\è\ì ¸{‹‡\Ï\ŞÂ­z§M\âmX‹[F\òá‘‚R¹æµ¾|¼o\Ã4s2~ù•\ñ’zŒW xoNI·X4\è]cQƒ+V\ñŠKSU=\ë\Ú‚>\Çf\òuŒg\îÿ\0jş»6f\Ë\Ñ[¯İ\Ü\àšŸ\Ä~ ³\ğ\å\ë©I3Â¹¯:¾\Ö\õ/^3K\nµ²œF¸\íSÌ‰\ßSf\ÓL›\Ä\Z–Å¸óŠ‘¹\÷d\Z‹\â\õ\ÚXYÁc\nne\å½O½t^Ó—\Â\Ş’\ê\åc‹‚\Ê|\Äv¯%\ñ‰fÕµ+›0\ïb|±\ß\áY³J{•/ü1k©\é¾r\Å\"\Ì\ßy•\ñ·\ëXZ\ë.`ÖŒÒ‹}\Ø\ó–L\ä\àWI j\Ò\\\éÿ\0e’\Ç\Í\Èı\ã«rG¥oi	\Ó\õ\"$’\Âh•y^\ÄU.S{£\Ë4m\Zgœ4-3C*\Ù\ÎO½u\ßş\Z\Üø»]\óoc´„\ïm\ß\Å\í^“¢xV\×?gµµw6~•\ÓYøb+Uo&\Çnÿ\0Z®Te)­†\èv6\Ñ\Åq®m­†\ÔA6¥|×±´0A+6q¹\0¢úh4\åo2\ó;WZ\n\æ£\ñŸr\ëk\çİŸj‡¹‰\Õ\é\Ú|–\î›\ËVÛ´X\æ\Ö9µ\â\ç\ÊYE5x„Üª¬\Ì\Ë\å¶I\'­P\ñm\Ü‰­\äf•;H\r\Ëo\ÛÁ|\Í\æ£n\é\Åj!·³Ç™$j»z\\ß‡|I\ç\é~dŠ¨WŒ·\\\Ö^³¯¶©s¼\ÒK!\ÚH<@Z\Ú\Åcq5®\Öf%U›\î×ê—‘\ê\Z¯•u˜WvL„ü¤Vï¥:EŒû¶­¸\Ü\Ù\ÜO©\Ïi\ñ¦¬Áf1·M\íÁ \Ş5V:M\Î\Ö7\İo*¬J;	\õ­K‹•°ŒH²1tPøv\Ëû&=¢\ÔHŒ0œ\ãŞ¤\Ôtë©¤_.<+p*¹ˆ©$\ö M^eJ±¶:|­\Ğ\Ö\î%Ö©·Ì’H\ã\ÎN\ã*=3\ÃrA\"³ü§“\ÏS]$«e\İ\Úû•,\Ì\åüU\à\İ]a%İŸ\Ú?+;úuşµ\Ãø\×\áE¡\Z7Ë5†;FOz\õ+\ëi/ÿ\0uå¯•G­f\ë:\'\öv\'—k¹˜\í\0PR“G\Èÿ\0\Ö\èO“4\ì¡xsÓŸ\ÈW‡x\ò\Îk\r\'\÷ª\Ë\å†\'\'\ï/­}\ãªxGOÕ>\Ñk\n\Ì\İq\ó×ø\Ã\öG´\ñ7‰¬]¤Åš\Ê$–>2À\ã§Cı*9]\îi\Z¾\ícı–<&¾ø\á‹\\‘X	¤|\Í!/\Ï\àÂª|m\ğ\Í×‰<ymh¡®!”\\Fg§_Âº¯IıŸ\Z\Åy†\Äh¹\ìZ¸Ô¤\Ş\Í\öÚ¿|“\ÃJ\ÚZ\Æ\Ç<y“>@¹øP5¨¤û<›‰ù@;—=sø\æ¯|>ø6|5\âü¢Û‡ÌŸ/\İ&½\ß\Ç_	\ÌkF¶\Ã;y’\Ûã§®;\Âú„zË´7\n¶²\ã\0\Ã)\÷¬¹·¶(²M¥\ÜYGq\"®Ø‹dKz\×\ñ*\ö\ë\Â\Ú\ÄwH\Ò*1V Á\'®~£ú\×a\ñ^\Æ\â\Ş\Â\ŞX\äµ\Èc™ª\çƒ\õ\í\ãV‡ıŸsq\êV¨S\Ëq\Ã`hph\Ú2º¹\óg\í\Û\ák}g\Â\Zo,<¸`\×5;Mb5,Î².\Ù=‰“\ì:U\Ş ´\ñ.™©Z^\È\ßg\Ğu\Ù¥wRwc\ñ\Ç\Ô×£ü`øz\Ú_€µ/\êÑ·\öv¥8[i?çœŸ\ÂG¡s^ûü9\Ô<]\ã¿iú„g\ĞtBN\ä7\Ërc¡é¸€¥\ÏQÒ¢\å\òŸp|9\ğÕ¥\ö•Š5†Y\Zx\÷\Ø\Å ùmb mÀ\õ\àsÖ¼\ë\öø\ï©i\×\Æ\ÖÔ™m$;Iˆ\ô\Ål\ê¾4—\âQÁ¦È¶ºsª¬Q3…!@®xW\à%´\Óy\×\Ş\\8$†6\ÎŞkX\ë¢2\öv|\Ìù¾}|M¨]	-\å&EÊ³vo\Ç\ğ¨\ì¼!¨\Û\Èey\0†cû\Õµ}\r¯~Ï—WÈ¶zj\İ[©È‘\İ\ô5rƒ\÷¶N?\âJ\î¬>`\\\éU\ìÉ•E\öO+\ğ¯Â»B±MÂ¼xcø=«¸\Ñ|1§fı×VéŸ­n\0\êE¶Ñ¤¶\\dü¬Æ±5\İiN\Ó]4³´j~e¬ùYq–š—ä¾Œ\r°ˆZE\õ¬›\İy¡—sF¬\Ês\ô5­i:|û\ÚF•—\å;†*\å\Û\é>\'•a†I­ea\åO¿J¥D¤®QK¡ªL\Ëq\÷f\à\à\ô«~\Z›Nœ(fš\×\ï+\ÓÚµ4‚Ú– \Çd»£\Ä\ÃVœ:X\Ñ\"û\n\Ì\ÒH§\'\'\å\ôª\åd\ó\Ä\ëuiŸ<\r<‘yH\ÓÀ¦?x\Ø\à\×Ç8¾m_[’i™.@\'\æù‰\Íz‡\ÄÛ“q\á«[†•\Ú%q»Œ_\Ç?…xŸˆoc¶K‹ƒ¹W\Üut\ó\Í$\å#ª4\Ôas\Úÿ\0c8m\ô|E\â{…o¦ „\ë“\Óßš\çş!øû\ã‹ZcšH\ä—\æP‡&½k\à§Á«\İ\à¤ˆ\Ó\í\Z³-\í\ã7pÀ¿–:ú×¤xà¶‹\àÀ^;EûC\ò\îy\çÚ»\ãc\Ï\æjG•\êWW\Şğ•§‡t;IdÔ¯bF¨¹*rq\Ç~k¨øû;§\Ã\ÍÚ¦¥‹Ÿ\\¦^V\Ã}˜\Ëş×¿Ò½6\r2\Æ\ÓP\ó£Š5¸nc’)umr\×C°’\â\âD+q[½…D´fŞ€Ö\Û#Iqƒ¹‹3\\¯ˆ¾,iúl2\îR%QÁ=Ï ¯ø\ÙûB\êºÜ¡4\ÙMš¾0„o­yÆ§\âMC^·+5Á`[r’½ÿ\0\õ““–ˆ\Ö4\í¬K\ñg¦\ñ\é1›\Ë\á\ã<\ôık\Ğ>øWR\ÕWÚ–-\í-\Ô‚\ßıj\â>|(\Ô<Ww\r\æ§–º}Ÿ\Î]\Æ\Zs\Û\Õ\Üülø—•¦®dÌ¯\'\Ë!C\÷W\Û\Ğıi\ò´®\Éz»#+\ã/\Ä\Ï\í»\å\Ól¾\Ï~\ğ¡\ÆqÚ¼\Ã[Õ”DÊ‘I–\0\0\ïd\àcŞªêºº\Ş\Âÿ\0e\óHrX“\ó7¿¿\á^‡\ğ3\á\Ìs\õ]|\Ï,²Ûº\Ş\ï\é\í\íKr\ôŠ²\Ü\Õøi\à‹}š\ŞH®\Û\æÛH c5\èºw…>\Ã™ytücqúV¬r<#r\Û\áº/¨\ã§Ò¹\Íb\â\õ®d’H¦¯\Ş\\\õúPe\Í\"mS\Ä§:Áaoû\æTg­Gc£^\ßO\æ\İH\èÀ\î¢ª\éú”—(\Ñ\Ú\Û\É9\êGÍŠ·s\ö\è­DJ%;‡\ÌO­a~\æo‰µX\ôß–5o:FÀ#jŒ6\÷¨Œ\ÌÈ\×$v­\ì¼\óZFg<\ìa}kf=7\ìÁ¥=ë¤@\ÎN{•H·¬\Ë%\Æ1°k7\í·’4—1¶\é\Õ\ìtW\ï§\Ú\İy¶¾ZL6N\å5\ñ\åMj\Ï\0“Š\0\â\ç¾kû¥‚‘¤%GF\ö®\×ÁM\"İ®&‡d’\Ã\õ^jh~:Q\ß­ª\É\Ô1\çÿ\0Z¡â©®\ôøšy¦#øV€9?\Zj\ê×³[ù‘…a€®x\'\'šw†´xQ\áûdmùX¶W‡®\İ\Úk7±-Ä¯g¹\òI]ÿ\0Òº­\Ã\ÓFS\ì\÷\run9Ä\ö\é@F‹i¿ú2³œ—•5Ş¥6‘»6¬vüÊª+7Ošt†H¶Â¹ÀV\è}\ê?øª\æ\Ö\İG\Ú1+\áW<P\ñN v½»+\÷\Ïªwÿ\0¤¼+\Z\Ã.\Ây3\ÇÖ¹]S]º“-ú\Ây>¾\õ%¿$\Ó\ì™<\ì\Ü\È0PPW+;-Ä¶\é6D\Òq\Î\Z¶u~\Ú]i·.\Ìg\Ğ×xx¶¥#	t¬2IkKU\Ó\î\'Ò¾\Ï\æ*+FzŠ	*\éÖ2´1\ÆÄ¶y\É\É\õ\ë]3\Â\Ën¥”£1\Ü\0`\Õø1t¸#d\ÎoQÈ®‰¬g[}\×¢\Í‘WM´{8\÷*v\Ç\rR}®K_¾¬\Ü\äsŠ\É\Ô\õi_.\Ş8ÂÁ¹>ù\ÍIm®µš´\ö\÷`\âi¹Y\Ğiš´\ä1\òK<J¡¯ørt»Œ}†\ò6\Ü}\×úŠ‚\Ó\ÆÖ¬vù‘®O5iA¯\Ç\n–k\Ëx\Û\Ïj®dCƒ1uO]jA¢Ô­\÷da]*EqŸ³\ö¥ x\Æ=j\Êú8cY7¾\åÀQé¸¯]³\Ö`š\ßs\Ë	\îJ¾Exÿ\0\Ç?\Ú6\ÇJ´\ÏOºi.18¿J™\ÔMX¸97Ê;ı£ÿ\0iY.\ô\İWL{;8ş\ÈH\æO\â“Rœú\Ö_‹5+„\ôŸ\ØF°\ê‘Cªjó•®f‘2K7C\Æ\Ğ\n\ğ?\Ú7\Äq\Ë`\ìdX\æ‘M\Â\î?)#½¹\Å}‘û:ø³Ã¿µ—\ìÑ£kCO\Ó\õk¥·[K\Ôh\ğ\Æh@F\n\İ{\ÜsYF.OCª_»K˜ù\æ\Ó\â\Ú\ì2ı­–8ø\0®@>\Ä\Z\ôÏ‡_µU¥„>Uı­\Í\Ñ%\Õù­ë‚·¸¹¸·\ğ½\ä—j>[K‰¿v\ôÎ¼\Ç\Ç5v¹k\ïì‘¤\ÄÍ‘p©\íŞ®P”V…Fq{ŸMx+\ãÕˆlc{[fX\ó¯/\Ì:v­Ox\Ö\ê\ê\Ó\ZlWK\'•NÚ¾+±Öµ¿j\Ëqk#\'–q»?#^‘\áO\Ûs\Ä\Z\Äp\ê\ö\÷\ê~ú\r¬>¼\ÔÆ£¶¦u0\ğ–±=Ÿ\ìş.\Ô&U’k\ÕE.\ã\Ó\ô¨\í~\ëW·\Í%\Å\ğ\ÜÇ’ıqQx\ö´Ò¼^XK4q±\è™\ï^—¤øŸN\ñ\r¸‘\Zİ›˜f·H\ÛS•\ÆPV8\Èş\é(\ß\é\Ó#M\×pü*\ÕŞc\á8T\ÙÁ\×\÷T(\'5\Õ\ê+}\î¸\åOš¯§x}`¸\Ş\Öj6\ó\ÙÉ§§ByŒ+\ï\ß\Øi±´–\ñ[‰z‘Ö²\í®tÿ\0Ü˜\î­\Ú\Ş@y–5-ººmK\Ã\Í\âÛ²·m3´z{şµ~\ÏB\Óüš«\Z·M\ì\Ô\÷>V\ñnµ£\à+\ËfÚ²Cvü\'\×5\æ>Ñ—ÆŸü7¢¹\ÄwÚ„\"Uƒa¿\ô®\ß\Äúbi `²,–º¤\"m\Èw|\ÙS\ès‘×Š©û%Z.¹ûU\îuRº¬\ó°n™#hşyú\×4~#Ô©\ğ]\Z\Úxzı¬ZhQ£ı\Ê\'\İ_”cù[ZGˆc\Õb‘–H_\Ë\êQ³\Å|gûJ|Q™|[t¶\óH’4²c\îü\ÍQş\Æ?u«³¯\Ù\É<\Ò\Ù\Ãf–F\'ÍŒg>‚·s±\Ï\õT\Õ\Ù\õ?\Ä‹º‚awºº_5y§,W\×\ó\Í|ù\ñ\ã#x\à\Ì\Ò¨tı\Ça\'\å>\æ³~\"øe\Í\ô®ú‚\Ü;\ÊB \èF\ã\ÓÁ¼3\á«\ë-Z\ßÌ³¹Œl\ïÿ\0d\Ö¨\å¢\ÓI™\ö\Ö0Ã¥\Ãp±,\Şs\å·g\ÜW¨|ø8\Ş&¼\÷P³\rf0T6@\é\\GÂ¯\'\õM<h­+\Ãd\à\Ì&`\ÛG_Hø£Æºw\Â\ß,m š\ã\Ë\0F£¥kN-j\ÅRKbß5ÿ\0øCtO.Í£·\İv \ï\Ó\ë_:\Ş]\Ü\ëZ\Ô\ÛVK‹«—%ı\æ\'Š\×\Öu¯|P\Õ\ñ½\ĞI>\è?t/j\ö…­ü%¥Eu¨Gºù\÷\Ì]8\ç½V­\êbì–†\Â?\Ù\åti-\õj%šeP\ñD\å›{×£\ê\0WkG‹\É!zS \Õ$’ù£\áW\Ü\ÍÉªr§\ö­Ì±+*¨,£’i=\ô\'^¥y5­cûD’;¶½*¦³­²D \ó¤\óA\ç#­Y\ZºŞ¡|µş>ù­6\Ñ\äUyD\×\ã$\nAri\ó\ã\Îg\İ\Ï\\t­\ÆM¼\ï\İ\ëš\Ì\Ö|@ºB´i—¥s\óx’\æ\Ùÿ\0Ò£x£\ä;PA\Ó\ßj\É`˜UV\'“\Õ\È\ëz¥Ö¡q\ò´\ÑÃœ§µGs¬\ÃrÌ±\É$›¸\éÒ¬YiŞ¼jb\ÇÑ²1Ç­]i~[É†Õ‘†rX\÷®­~Ë¤\Øü¨«\">^¦±\õOcE\ö+Y™G/\ï\\\İ\íÖ­s2ıBÓ±\Î\É1\Ğ_\ëZ\Ã@Å®-\í\á\'‚±\óü\ëŠ\ñWŒ\ä@bş\ÔY$\Æ\n\í\ëR\Ï\àø\ïv¡\öˆaŒ\õŠ_”ûcHøBÿ\0k\ó%\Ó[bœfG\r»ı¯\ó\é@s#Á:\å\íÜ—Ok8/\Î\ã\ëü«·\Ó\âš\äG\Z´q²œƒ\0\Õû}˜*ù2l_\àSZ°i±Ø®\áj±·¦\î´d\ê\Ñ\'”©+o‘½;\nÅ»\ÓÍ‘C,2*Ÿº\İA®a%\Í\Öi\É\êk6\çC³ºº&L<™\è W ¸µ]jÜ¡x\Ã\ÅE€\ô\ÛU’E‰Zg_”µ\Ği\Z\n€Uad¸<\Ö\Ìv\Öúm²®\Õm½8É§n¢\ç{#š\ğ\ç€cŠ%’h|¶oS\É\Ğ-µ­œ[#fQ¤sT5\ÃciÄªpx\àWŠü[ı©!\Ğ\Ö{=6\á|\Ï\â}¼\Õ’Š»)E³Õ¼[\ñCM\ğ}»5\ÅÍ­ª\È\Ş|\n\ğˆ¿µ\í¬wN4½b\âë­·;s\õ\ÍxŒ~!j>1»’Y®$xú“^\âY\é¼¥y®;\Ü\n\á©Y\Éû§u\Z*\×g¯jµµu4\ŞR\É<\Ø$V\ß\í\r¬D›¦\Ù[’|\ìÿ\0Z\ñMk\Æ\Z…úmK\È\í\Ë/\İ\ñ\\\İ×‡µÅ¶;\ë\Íù\Æ|¶eı1Y\Şfş\Î\'»O\ñ\ËX’o:¤}\ÜV\îûIø\âIs‘İœ~½k\æ+¯¾$½Œ,Zœ\Ì\Ä²ÿ\0Zg\Ãn\Í¸<}\åv\ç\é\Í\\y\ì\Î\'\ÔSüt\ñ\n‰#\òen0$ù€\öªšdM{/\Ú&f’F ·;˜“\Ü\×\É:¦Ÿ\ñ+á¤‹\"\Û\êJ‘\ó™TÈı{We\ğo\ö\í·µ\Õ#\ÑüUoı›¨HB­Àùcs\Ğ{\ç?h¹‹Œcˆ¿k\ï\É£g\õ\ÄF\æBw|¿_şµ}\áÿ\0\öø«¦\èß²\ç\Ã{{\Å]\æ\ßOky-¼½Š\óo˜‘İ\Ï9¯şü9µO\íu¤è²\ÖO\ö¹¦S¹V8şcøGZı\ñ\ç\ìÿ\0¤øƒ\à•\÷…\ô1Ÿ5¹\Z|\áyYB{ü\ØÁ+Z1\îr\â½\ç¡\ê—\â«ef1È§\æW^OÖ²5\ï†\ò\ê1~\î\æ;ˆ\Ô|±\Ï\Î\ï\Ë\á?³ÿ\0\ÄO|1\Ñ/4\ßh·Zo\öoÈ·ù\ß¹=G?Z\ö­7\âÖŸyä­¾©\ë*‡L\È5\ßıã’W\Ğ\á|c\ğbSw\ö†‘41¨À{uİ»¯C^G\âÙ®{\Éÿ\0\âS\r\Â\înVh\ğE}yg\â\ÛK¸‡œÊ˜8o”ûÎ®\\\ÚG©Ù²Ã·k\ó¹æ›„.K©(\î|#yû?ø›@¾-\Ç\Ê3û¾Aüª\ç…\õxı˜X\ê/\Ï\ó†\Ùüı«\ìN?2µÈ—grk(ø»Ãº…Ï—5£\óß¼+>X•\Z\ï©\ä>ı¦µ\ë\İN\Ş\Úk}ª\Çi\0ıkÚ´\ïˆ`*y…›’¬\Ø9ªún… ko\ö‹m.¿\ñ´xÉ®Çš¦5©ş\Ëjc?yÎ‚›‹\Ô\õ©|_·2b4]¿{vFk\Ì~!kZ–²Ym—\Î^Àş5\ÍYüU1ouj\ŞN{œV\ö—ª\Ú\ê—qıA0û»³\Å\0¢\Ó<?ı‰\áh\ì\ÖF¼·\Ó/Y¹û\Ëlı¿\à\'p\Ø\ëY¿² \Ğü\\ø•#[ˆt\ÉUû§p\Æ?+\Êÿ\0gŸ\ÚOüFo\ë\æM#ÄšX:n­§L~e‘y ş Á†\ã × |Šo|y\ñ}³nn²”HaÇ\\\ë{¤¢š±\Ì|F\×<‡º¸º=™\Û.z“ŸÆ½s\à†?\á\røE¢\Ç2\îüE;j3°8o\'O¶U\ã^#ªør_|Q\Ñ|7o\æcS½T”\á]Ä±ÿ\0\õ×½ø\ãW[mz\è\Ã\Z­‚\Ê\İT\à* \ÇS“ø\Ñ9&fÖ–0<]¨\îÕ›n\æ;‚¨\Ï\İ\Çz¥\ã\ZI¤Eg\Òn\Ú\\ÿ\0\0½a\İky˜“º7r|³\×¨\Ïlz×¥~\Êÿ\0$ø›\ây5­EwhúT›•K¹^„˜§F)»\ò\÷w=S\öløg7\Ão‡\ë=\Ì!5\r@y…	ù\Æ@\Æ}ø®š…\÷,Õ¤ºÕ„{s•\\\çµk]C·ª2\Ç\"©‰ÂŸ¾=ò­˜­Å¼. V†n\Z\ŞZ;²wwDº>…g¡ÀáŒ€Ujk\ëv½m»H\ÇMuX,›i¸N™\ãšl\Ş%†Lì‘¸\ïœJd.VW›N\Ö\éY•K}\Òy©¢—Ì”Æ‘Fªˆ\Z\ÉÕµ9..\ÒÈ±\Ãó¦´ Õ´\ÛK4¼™™·”…&–\â4ÿ\0²¦¹\n‘¢¨\Ç\0Ó£µ·µ<24£øˆ\éY\Ğx¿ûB,,o}˜œdz\Õy<]¢\ÙOş‘¨DŒ½K8\ÅC’[“\Ê\Ë\×\Z*\Ü\ÌdbsP\Ï\á\Óu´<ÿ\0\"ÿ\0\ÕY~+xw?\òµ‡\ï5j\Ï\ÆZuúş\â\ò\ÎEoI\nI\ê+6\"x\"\İ\ß+·>©\Å[³\Ò^\Ë\å_3\ñ9¥\Z‚©Ü²C\õƒO·\ÕU_\æ¸R¾¾•C\åc§Ğ­\Øgb«w\ã­:\r\Öİ•Â®A\ëŠo\öµ©rE\Ö[ûµŸ©k^]¼‡l\ìW@È¡jI¡¨x†9›9\íYw¾<´\å\ó\Ì##š\æ[^·¼™\÷´›±Ñ¸¦‡¡\'˜Í¹»m\ô ‚/ˆA\\\ï\İ$x\à”×º‹V–y£f\ä\0sP\éYO–Ğ±\×C¥øn=;bª¯jW)IlT\Ót\Ş)\Ü\Ó?\÷Ÿ°\ô­qn\Å\ó\Ã})—z„6\ë·z\'|šÁ\ÖüJ–\èwI`\ïcO¥Ã•š\×:³@‡n\à½ù®GÆ¿-ü9d|RlP\Ç*Où\Éø¿\â\æŸo‹\â\Í:©\ãv¼GÅ/\Õ<mM\Z~\âA\ÚK\ß\çŒª_DmN™_\â_\Æ=_\Å\÷³+\\\Í\n©8>\Õ<š\ó?_-„\r=\Ä\Ê\Ï \Éù¹?tV_üA®]ùpÛ°\ó898Şº\öKµ\ÕmD\Ú\Õ\ÅÔ·4Q>œƒ\ëYº.[|§I¬j#G·±…„y\Æü\ñŸ­jøS\à-\ö½ûˆ\î.$\İ\÷ ]\Ù\é\Ô\ã\ô¯¥,|\áÿ\07ú4Pª’R~c\õ?JÚ›\Å6š5¬g¸µ,|Áp§\ôşu£\Ê\Êrw<S\Ã?³6¥ÕƒA´¶R7y—r¿J\í4\Ù\×S2F·\Z®›c\ñ¢İ¦+°¼øg \Ë\ò\ÙA\Æ\â\Ù\Éüi\ğüCŠUdó„»ıZşz3J\ç?¯~\Î[ho5°n\î\â¼©-\ö+ı\ry\Ü\ó\\Z\\Ikp\Í\öˆ[n\Ü\ô>•\ô&™\ã¸\õ&U\òË€Àƒ…?yŸ\í¦¬¬d=¢hƒaS9n¸©zª_C‘Qi\ËB\Í\ò\àX­y?\íSû5\è?¾\êt\Û[}^\Ş6\Ş\â4Á\Æ1\Ó\ñ¯bÒ´Õ½MÍµ\ÎCWû@ø\É<#\à\rY’\à¦·6\Ğ*\õ29ùqÿ\0|š¨\É2¹™\ÑÁ?g8ü\ğ~\ó\â¯q&¥­kSIkd„ü\Ö\ö°°W?Rw~U\öİ¿Œ\ô>\Ù\Ã+[ù9l“œÿ\0\Ö\Årÿ\0³\ï\Ã\È~şÏ\ĞL\n’Zé±› ƒ½‘C\Ëÿ\01@>µU›I\Ô-f†kv7@2¨N\0®®d¢a&¬\æ~/|Q\ğ?<3&“ªjz†›kƒ\ç=\Êÿ\05“\á)¾h¶L,\æ¾\Ô$	€\ßy‡\Ó\ÅgüSøO£ø\ëM…t\Û\ÈašÔ†h\İJ™1\Û¬-?á¶•§^Cqq‹{…\Çú„e8¥\Í\'©>Í½Q\êZEÿ\0„\ï\í„v\ókˆ§\æXr ıq[ºt\Ú}œj\Öş#–SŒ²|€úb¹x3IšQ<——L\Ø\ÈUª\ã\é[Q|/\ÓuK“%½\í\ä27\ğO¿Jw‘2C¶\Ò\õYnUµ-6\ò>\ìO$U_xL\ñ<l\Ö\æ8\'\É\âp}Ms#\àØ´Fÿ\0‰\Å\ÌlÇ´`\åSA\à-R\ÆX\Öb9¦dnü\Ó\ç]N~W\Ø\Å\Õ>øƒNµš\Ú\ÖI®#cq—ƒ\ô\År\ö<U¢4¥¾\Òşsn)\Ùü\n\õ]cIÕ´›\rË­2mèŠ¹¬(5Ÿ³\í‡RY;\í‘v“U}V©¡´Vªš–t¬£f\ÚÄ“B]>\äMg#Ã´giW®C\ñZ…Z;«5ºe¢€\Ê\Ş\õøª\Öı‚\ßxu~a’Qp@¦\Ìø?\ö©ø7†—\ñ\Â6‹ÄŸ:Ş˜\à“Z´BL¶\ç\Õ\ö–e\'Ğr1\ê	5\Í7\Å\Úí‡4\Âd\Ó\õı!¤;\Æ\ÖF`~S\èÛ³rEwŸ¼\rm\àÏ‰\Şiw1‹+€dR¯»¯\ŞN;p\á\é_*x\óW“\öZø³&Ÿ&¡\æx\Ç\×\r-“³cû+PlV\Æ\0N \0>m\Ü\ã\ËÌ¯cØŒ´=C\önÓ£\Ô~-x§\Ä\òI²\Û\Ã:{¨n\ÄÒ¶ÑpEO\â¿\ÉypaA!i23|­\É9\ã¹ük±ı–~\r_ø‹\ö}0\Ù\Í¥\÷ŠuY&72/ú\È#\á~«’ßˆ¯ ~ş\Î\ŞøK£­\Ô\Ë¡x£\÷·\×8`¸ëŒ~•·&—g\ë{\Í\ğ+\ör\Õ>,_y—ku¦hq\æ\Ì\éµ\æ\Õ2^\ç>•\ïş/\ñ‡†ş\rxF\n\Êh4\Ûx£¡0c¹ÿ\0x\ãœ×~\Ğ¶}·†´\Ï\ì’Hş_9G\È:ŒÓ¯\ã_1j\Zßˆ>4ø¢;xş\Õ}w,Ÿ2ƒ–r}=1\êk~otYo#\é]w\ö®\ğÿ\0†b\è\é%\í\Öİ«!=ü\àş5\Ê\Ë\ñ\×X\Ôn7Osp²NwaNUs\Ûk\á\ß\ì\"Áq¬kŠ·%AhaNc>™\äW¥h4Ÿ†O$\×.·6\Ôg\\°\éÚº[Z\İ8]Åº\Å\óy–n¼\n>}±g\ÓùWY¤ÿ\0\Âi«Â¿gµXCœƒ3yxüë®¸\ñ\\zuº¬0ˆc\ä şµ_U\ñÔ¯d›ƒ$8\åX¾¾µŒ\ôzšF\Ö§øC\ÅªÉª]i\ßgQ¹‚1\É\ö\ëSj¿t¿	Zı¡Uhş\\Œm5‡c\ã\ö]AiŒ>T)(\÷¬ÿ\0|)o‹¶\r\öuXfQû¦\n2zš˜¶\ö\'•\r\Öh\Í\ö&U\ó\ï¼A\àW”üB\ñ.›®[J\Ğ\ÎË¸œ\r\Ç&³üI\ğ\Å¸š²\ó”·$İŸz\äuDŸI“\ì\ÓÁ\ä\ÜGÁ­eW˜\\¨«\æ\\\Ç/\Ë4¤vÕ¸\õ\íR\Û¾™W\Ú_\ğª7:‰¹™T–v©otÿ\0³Ä­·\æ<\õ5\É\Ë#jtã¹­g\ñX³e\ò®\î•sü.qš\î<\ñwV¶u]\Ü2±\à3w¯7\ZœQFŠÍ·Â¶´O,+E b¼\íe\È5JrZ\é\Æ\ç\Ò\ñ\ÅÍ¬r³y\n2İ«´³¿k\èJ¯™¹\Ç\İlŠùû\â\÷\Û<Å¸’¼-±ÿ\0Ö®‹ÃŸüI¥6\è\ï¤ùF\0q¸š\è§VÛ˜J†ºQZü8I€‘¤-\É\\\ô®‹M\ğı‘j?v¬Gzù\ï\Âÿ\0µ>§\Z\"\ß0\Ü\İ-z—\ñ¦\ßş\ô\Õ5-I¼’\ÛLi}?Æº=´NiQ•\ÏOyãµˆ¶6\ñš\åµ_}¦fH\äÚ«Á\Ü+†\ñ/\íE¢´+ıŸ“Çœ±\Øs\ôü«–\ñ\íd\ö\Ğ\Ûù,\İ\Äû\Ön´nU:Mnzf¯\â«[H7Ÿ\ß\àa¹\é^A\ã?\Ú\n\Ş\ÇPš\Ùd^F\ÇL•®7Yø}®±hVH\Û8úW\'¬\éS_O\ö€\Å\ç\',qQ*—Z‘¤š¹¡6µ/Šu:9w \Éâ»Ÿ†úUÆ’\Ç=\ëIÀ*U27{û×øm\r¾¡h\Ú=½pG\Í\õ¯l\ğ…\ä7(±´œ\àF)A\Ûs†V9O\ë‚\Ã\Ä¦I#((m\Ú\Ã\Ó\ô©4‹·–Vs-\Ö\ç\Ú6\óÒ›\ñ‹\Ã\É{\ê«\îO\âS\õ®*\âv`‰»	\'®+M^¨Ó™\r\Õ\å\Äû…kù-f\\0W\Î\ÒkR\Ò-\í.\ä‚\âo5³µ^\Éş´ºm²M¨H\ó],°\ã8ù\×¥w?ş\ë*¼š\è\Û:\Ú\È\ØYdR«\Ğr­>V\È\à4\r:\à\ÜIj\ÌÌ¤\ğd/®zz\×\á„wš\ìª4\õ¸š@6\ïH\ğª\Ún\ëÛ¼!\ğ\'G\ğÎŸÿ\0	\ñºŸ3\0/·LÖ­\ïü;\à\İ:Háº³m\Ç1£c\ó­W*\êc*—\Ò\';\àO‚1øJ\Û\í\Z¥\Ğy¸%6ÿ\0*\Ãø·«\èc\ÄVbK8\ä©ˆÇ­T\ñ?\íA¤\\xo–Q\ËB\Û\ë_4üRı§n<Y\âšÍaF!r:\Ö5;\"©Ó—Sª\ñCª\İ\Î\Ú|k\ç</LW“\ë_\Æ_´€4}N\ê\Æ\ÏI“T[\Û\én¥ª\Ãel\îã„úš\Ğ\Ğ~%ß…`Œ®q€zs^_ûf\é\Z‡~E|`Y¤\Ò\Ë”9ù\ãaŒsù\ÔS‹GG+z©ZgŠ¬<Oi7\öeæŸ¨FÄ\Ö\÷	\"\õR\Ü\ãu\Æ+/P\Ó\äpÑ …~]¼\î\İù	ú\ô¯\å\Çã—‡¼U\ğQ¹\Ô4k^³³‘7¨²¿š+d\í`3€9¯Lı‹uo?t‹}CKøµ\ñK·l\âa¯O°“ZÖ­B\ò5\Ã\à]I\Øş‡\àølÏª,\ÒI&\áĞ€qû\æº8<”d[\Ï\ÆJ»\óù`\Züw\Ó<\ã›[¥Ö¾6|Y\Õ.$lx’xW\é…\Çy\÷­\Û	kRÃ²OüB¸¹?h\ñ%\äŠ\Ã\Ü+\ËşÜ¤´W=ø\ğ½v®¥c\õ\Ú\Û\Â\Öúif\ò\íb\ÏRÅ‚\Ì\çS«X\ÆV5½\ÓVN\Ã\íw\à¯\Ç\İG\àÿ\0‡5‹v]D\ß^·\ñ‹\É\Ø?\æ\õ\Î\Åû;|;\Ì|?\ZÈ­\Âg\\şF¢\\E“şª\Ö\ë3\ö\Ò\ÖÕ°6\ÜB\Ê{\àÿ\03W\í\ìÉ¹\äy\ã\ç\Ü\æ \×\áüÿ\0|;b›t\ë[\Ë0;\Û\ê—0\ó\ë\ÃşµN\÷\áj\ÜÚ·üT>6µU\é\äøŠ\ïÿ\0¢<IE\ï_\×{HıÁ¿±W;¤O1Oe4æ·lZ4·]»\Ó#5ø]¥øk\Ä^u›Cø¹\ñKG™[*É¯\Ü<`ÿ\0ºÄ¯\æ+ª\Ñÿ\0j\Ï\ÚÁWJ\Ú\Ç=rş+nDz®mt¯\õf‹wáºº¨\ç”d\ô\Ğ\ã¯\Ã8ˆvg\ìŞcmb•L2°\É$CŠ½g<PE\ó<{›\Æ1’?Zü‚Ò¿\à¬?µ&€\í#\ß|;\ñª»y¤In\Ò{~\é¿Z\ß\ğ]ÿ\0š,Pı£\à…\õ\Ì\Ì\ö:\ó\Ú~K*ŸZ\ïX\êR\Ö\ç\ÉqÑ£\Ù\Â~-Ğ­\×\É\ÔR…I\Ø¾`=ı«\Íÿ\0iyc\ñß€\ï\ô\Íj\Ç1²†f#æ·•A\ò\äSØ©$zú\"\ËFş\Î\Ô\Ã3‹\Ê\ò{\ö¯ı¨¦†\ÓC\×%Xüµ\r\îz\ï\Ç\õ¨r´µ\'•µs\Şş\ë+û>|\ğ=\ç\Ú.t\ï@e\Ç&FM\ìÆ¸?‹¿µMÿ\0ˆ´¦°k\Æ\Ól€ş\'\Ì\ïù\×5\ñO\â\\\Ú\ëY\É\óm“O·DC¨c\\~‹\à;­{\Äv\÷—\Å$‡p\Ù\Æ2@¶\ÖZ\"$¡nb×‚ü/¬ün\ñ%¦—£\ÙN\Şk\åJ\ç%{»€W\Ú_\n?g½\öÓ…øº\êS\Ä#\è\ã\êc\Ç4¿ü;¤|\ğ¤‹ÚºŠ\îH\ã\ä&}^;“V/¾!i¾2­nœ\înX˜›“\ë\Ç¬b’·SÅ·\ä-\ç\Æ}.\ğ›v8alu?­~8ƒ\Å\'1É¾\âAÀg£_‡~µ\Óˆ\Íp$6\ô?/Ó¥eÁ\àX\à²ûM¯\Ë\Z¶\Ò¶ÿ\0¥+¢¹ \ñW4q\ÆÎ«\î	å¯qc*B²I\æH\ÓrÀ®„\ê6vÚšC\É+ \ÜÁ_j­¨kw»46\éQœf\ÍsÔš^\Æ+hú\ÕúyqZ4v\ê0dg®‡\áÏˆ\í¼.\ÓZ]\İH\Ñ\í;T\ç \í\\Æ¡\âS}yµ¤–>6ü¤\ã5ƒ­k‚\'\òÕ¶¶p\ÌGSXÂ¥‡\ì\Ù\ô\æ\â}\ZxU|\èİ›¼¸9ª¾*øO\à¯•mSG³¸i8\r‚3\ïk\æ?øK. ˜8F\öû cßŸ\Ë^o\ÚûÃºAú\òH\í~\èÀ‚O\æ)Î´\Æ¥­\Ù\é+ı…<=v\Ó\èú­\æ˜[¤L‚h\öÀv\ã&¸_ş\Ä.\ÓAk;\Í7VÀP\Æ\Çü#\õ­¯‡\Ú×Œ¾+\Å\Ú+Ikn\Çx\×@u\æ>§¯^>œW§h¾\Ô<\'0“Ä,º¼\Ü8\ÙT\ÔUE]]‘y-ò¯‹¾ø»\ÂEş\İ\áıJ\ã\ë4q	£ü\Ô\×*>Ñ¸\Ãs\Èÿ\0İgÏ¦\0şµ\÷u\ç\Å\ÍF·`²]M´c\".\ê}\ñ\\\Ü´“kq#Z\è\ëw“b#1\õùAştÿ\0w\Ôi\Ìù_\Ã?<s\â\Ù\ØøSU\òÛ$\ñùŸ|¹®ÿ\0JıŠ¼}{j\ï4\Ú>Ÿ.>X\æ¸2ÿ\0|ŒW¸\ÙşĞ¶·Î»¡’8\Ëa”\å\ó\ïŸ\éN½ı ¬\â›Éµ†]Û³ş¬ü\ÅG<V¨|\Í\â\Ùÿ\0\âo„\ÙV\ç\ÃZ¤qœ¬úd\ë>~¨pıu‰¯x‚\Ş\Ó\ì·\Ú‰-\ã€\ía%›\ñ\õÛ‘_XAûE\Ãer\Ëyi3\ä<ù\Õ\Èh\Í%¥ùc¹\Ü\ÜüÉ\ĞR½7Ô¥*‹KX\Ú@¦X\ï£e?u\í\İO\ê)\ãk;\×\È-\Ï@\ÈF?Jû2‹z\rûnº³†á›¦û`\Ü~\"¬\Úø£Â·‘]&\Ç\ÉÍš…\ÎT\Ã\ÚT\ì|o¦j0\Ü\Æ\á\ã\ç¹ıjÛŠ\îß¶+~+_[¢x^ı›F\Ò\ö\È>Vk58ÿ\0\ÇhkO\ÛÛ£\én\ÊyÅŠŸû\æª1ŠV·¨´±\ò42[C8a$;½ws]o…<U p‰\r\Å\Ç8\\l\ß\ÈW\Ğ>#\ğ\Şg\öŠüIjŸ\Ë$<=a\ØW\ÊS\Î\ßh­£b=¥G­%µ\ğ?‰<e#}.\î8Xm\Ì\à¢ş£5½ ~\É\÷7{[T¸µ†>\é.\Øÿ\0{§\áŠ\ìuú5˜ÿ\0[xr\"\ßú¬;ÿ\0\ÚWNšO&\İ5+‰t*±‚?:wB\÷\Ù\Óxg\àg„¼V\á,b¹¸6a¸Ã§\éŞ®ø›\â]®‰gûÑ¬goÈ˜À¯5Ö¾)x‡SUû—\r¸q¹L³†\È\õ\à\×7¨\è\Ş\"\ñ¬\ê·R\Çn\Í\ò$\Ê\ã\è>´ù\Õ\õd\ß¾5^js0·{‰B\ğª§k5yUûx›\Ä\Z§oc\äL\İ;·{š\÷\Í\öwk\ßyl\ó\ã%\Ê6El\é?\0--£h\×R‘fnN\ô\â©F\åG–;Ÿ%üYğ–¹¤xp5\Äm\Õ\Óa°Wn=°>µ\æúÃ»˜!>u\Ä{±œg­}­\ñ{\öhm[ÃŠNª\Æ;W\ŞÙq#\ó\æ7¼3§ŞªÉ¨\ßol‹pG?CJú›B¤o¡\ó\õ‡ƒn\"”6\àÁNN\Ğz\Õ\Ûÿ\0«[IÑ´\Ë2\ì`\ßwG ¯i\Ô|#\ám\"{…3\Ü\Êans·ükƒ\ñ¿‹4;V’\Ş\Ê•wmbÃ­e)$wQJLü\èı³~/…\ßR\Ó\æU[k„wÀ\á\Ğ\ç9ú{WWû/øV/ü\ğ\íŒ0ªFm¼\Ç\Ú1’Xÿ\0@+gş\n\â5;ı6\Ê\İ[\÷V’‘–$\åW|%i\Ş\n\Ò\á<m£L\ß(?Ö¼\ã\ã—S\é2Z|\Ózlo\é~d\÷,Wv\Õè¤’\ç]=…—š¦\Ë\ñ\Ç=+\Ã\ö\ìql«û\×agg\'\Ør»[Œƒ\é_?UÏ°Œ•µ2u¹Y\×\ÊUe\\p§½aıº‘Y°Elø€I\çB\Í!V\ÇOj\åµ;)EÌ­\Ç\ÌsÁ¢QMX\Ò1M	>¤±O´\r·<úU+»ø\åVfigiÀª\î­$\Ã2±aÁ\'°\ôª7ù’a\ó\ò®r;k1\÷‡\íyt\çGw;©Ï—?x\óQ\ŞÜ©´Uı\ãF\Çw^ƒ§\ôª±D\ÒC$ˆ\Ê>r\Ç^•\Í\äÚ’\Ø\Ú~\\\n\ê§M\Ş\è\ç¯+«Ø­k¶\rS\ÌBv\ã\0\õ#\Û5}\î$·6\æV?yœœLÿ\0]C,\Öe;FXu\ëNûÍ\ãš\0\Ş_$¯F\ïkœ’vZ£ÿ\Ù',0.000,NULL,'2023-01-01','2025-03-02',NULL,1,'2025-03-04 11:34:34','2025-03-04 11:34:34',0,0,122),(2012,'Kalai Arasan',2006,NULL,_binary 'ÿ\Øÿ\à\0JFIF\0\0x\0x\0\0ÿ\á\0ZExif\0\0MM\0*\0\0\0\0\0\0\0\0\0\0\0J\0\0\0\0\0\0\0\0Q\0\0\0\0\0\0\0Q\0\0\0\0\0\0tQ\0\0\0\0\0\0t\0\0\0\0\0† \0\0±ÿ\Û\0C\0		\n\n\r\n\n	\rÿ\Û\0CÿÀ\0V±\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñ\ğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\ê\ñ\ò\ó\ô\õ\ö\÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3R\ğbr\Ñ\n$4\á%\ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\ê\ò\ó\ô\õ\ö\÷øùúÿ\Ú\0\0\0?\0ı2\òš£X™zU©~^”’¨^•ã‡?® ¬\Ë?\õµ³¬Áº:È³\÷µ™™j\å5I\å/¥I\å5\0W\òš¤û/½I\åŸ/4ÿ\0#Ú‚yˆv\n’UÒ\ä{S™Cu ¢·”Ôª¬µ*ş\óıš?\å¦()¨\òš¬\ìl/‘\ÎqRy\Ô\åV“ıš\n\å!\ò=©|¶ÿ\0\"¦§yMA·³\"\rÔ¾STª¬´´\èA\äqŒS\ê}‚“\Ê_J\r¹Q\r7\Êj±,J½.ÁAÍ‘yK\éDq–©<¦§/\ËX\ò™r\ìj]­Sùg\Ë\ÍST‡(Í‚“\î\ÔşGµ$°\íLn¨(¯M\òš¥\Ø)j¹@g‘\íK\å5LŸ?J~ÁRo)¨\òš¬yg\Ì\ÅSP)¨\òš¬K\òÿ\0\r.Á@\ö\nH\ã-R\ì«\ò\Ğ_)ª]‚¤\Ø)2»>\í\0E\ä{Q\ä{T\ô›[\Ë\Í\0C\ä{S¶\n–_—¥&Á@\öµ\'”\Õg`¤\òš€!\ò›û\Ô\ß)ªÇ”¾”»fo)©v·—šŸ\Êj<¦\Æ(/Ù²¿’i\Õ%&Á@{62Š~ÁEœ¦›D\ÍÖ•”7Z–“`¯@À\Ä\ÖşU\ÅeY„\ó~\÷\é[\Z\ê\nÉ³?\é8ş•™1‹e\Ï#ÚµªM­Rl)_0Á©\"ùºÓ–%^‚…‰—¥h3kRyMR\íjZ\r¹Q]7\ğ\Òù¼\İÚ­\â¢\Ø\Ûv\ö 9Q\Ã\ë\çG”\Õg`\ô•Êˆ¼³\å\æš\ß5Oµ±ŠO)}*yŒH¼j|?\íT”\ß)¨\æ4\æCi\ŞRù˜\ÅSTSg4s‘ùMK°yy©i\ŞR\ãª4\æD §\Å·QOh7u±¨«P\ÈfÁMh3\÷jl²?:\Ê\ñ7´ÿ\0iy¨L!…[j\ö2Æ¦1l\Ì\ÖXvŒ3To$qG–`ß\Ï\ç_9|Lÿ\0‚‡øW\ÂK|’_\Û\é\òØ¦\éLM2ŸC\ZŸ—\ñ5\òÿ\0\Åoø.ƒ­\ôû¥\Ò\ô\Ï¬+¾9\Ö\å\í\ÚA\õ\Ü\ô­#I¾„\ó£7\Ş7\Ó\ìšK»p­\Â\à†?\ïpk›\Öş\"_>\ó¥i\Ò^\È#sùiŸ©ø\Ï\ñkş…\ãmo]_\ìÁz\r\Ó*8¡·Iš(ı4¤~=k—Ó¿\à¤_¼e¬\Â\ÚÇ‹š\Å|\ß.bg•\"ÿ\0\"º>¥ ”\Ò?k\Ç2\Ó\ô\í\rOE‚\Æ\Ó\Î\òÌ+]*] †®f\ç\ö«m\Zf‚C¢\ê‹\Ö\Î9¤·ºÿ\0¾]vşµù¦~\ß_¼eugg\ãÙ™Z}§NÕ¥GšH½VR\æ½\ëÁ¿´·Š¿h}\n\Ö\ËO\Õ\ôgµbu-?\Äú³X]LW¬hÿ\0\êØ·\÷\Ô ª–ÄŸjĞ†ß·w‚|a\ãøG/šû\Ã\Ú\á&4ƒQ„ÄW«	\ÚÛ½«\Öb\ñÎˆ\å\âigû\Õ\ß2­\îû\É\î9¯€\Â\n|C\à\èa\ñ·…|?§\êWÁŒÑFKg\ôhe\æBëŠ¶kS\á¥\Û~Î‘X\ŞX\êP|Lø9¬l[-n\Ã77^\ÏX¦yc\÷ÛŸz\å\öO±qw>ÿ\0¶º\ñVHYfY>\ãFr‡\ëR7\Í\÷k\Ä<%\ã\Ï\Ï\âY<?­t}Xc½’\çu¬7*›Šº¶Z4c\ÆN\ã]ş—\ñ\çJ\Õ\æ°\Ö-\ã†\â$#+·(\İ$\Õ¹¥Š±\Ø6\æÿ\0\õS|¦§i\×\ĞjVk<2$\É\'\Üd?!©¤Œ­!¼j<jŠ\0ƒ\È\ö¤\Çb›\å/¥\0W\òš—kcc`£` \n\ÒF^)ª\Â\Ä\ËÒ›@ùMN\Êÿ\0{\ô©)»—Ÿ\é@\Ø*9–¬l2\ëS\ÊZ>û¨\Ëÿ\0‘R/\ËEI§2!\òš—`\ó1R\Ô[[9 9SQSQ@sD¿µªH”7ZX¾n´\õP½+\Ğ30\õ\Ô‡f\íU¹¯+\nÈ³ÿ\0ª\Ìp\ĞÔ‹\æ\ëN\òš–-{6E°Sü¦©<¥\ô¥Ui?Ù =› ¦\Çj±\å/¥5~Z\r9QÖ§ùMR\ìmj•yMK°T›Z‚€\åBm_\ï~”GµJ\Ècÿ\0j—kVf>Gµ;`©6µ\'”ÿ\0\İıh›*ü¿z\å5+(n´ÁI\æ3\é~U\Ü>\íW\ïš\ĞO}\äÇœ\Ö6§\â´F\Î\æ\ÛÕ–¬ø‚\ê6\ŞIn%†•w–‘¼°£\Ø7ÿ\0_ÁC¿\à¨~ø\áû\Ãz­³\âkÁ\åÆ¶³	\Ü\Ï]\Ã\å?C‘\íZF›a-oı ?m6øE\ñY\Ø\Ú\Ü:5\å\å\Ú\Û\ÚDvg†<¿>‚¿3k/ø(\å\÷\Äµ­\÷.µF³“t6pkuoO1\ãø“_<üMøÁ­üp¼›R\ñu\Õ\õ”z†d\Ü\×\"\âd\Ú0v‚§\Ë\Ü?»Šç´N\Üxv\î\ËC\Ónc’\â\ádK“(‰¢}\ç\É\í\ìx\ö®\êt‘\Ñ\Zzµ\æ§\â\Ûİ—^\Õ\Ş\áü\Å\'üLOûa—\ô|Š\ê5o‡\â\Õ$\ÓlS\È\ß\Ùm5HcŒD?\Ş?-rWú%Ö‰gk©]\rBá»¥–«yÿ\0‡\ğÿ\0À«\Äÿ\0WB³»“P\Ğ\÷}£ıT\ó\É\öÕ\Û\Çÿ\0\×L4#˜<K\ğªK} :„o.~|ÿ\0g(7tù—\n\Önµ\ğ\ëZµ{\È\õ\0\ğ\Çy/\È\Âaµ¿\Ú\ò\Ï#şú§Y|u‹Å¾&\Ò\ï­\í4ø#±x\ä—û:H\íÌˆ\Ö+¦\õ\Õ\Õx\ï\Ç:‡À]]£“M\Òÿ\0²\ï>K«›yo­/¢\öWfÿ\0î‡¦Lµ8ıgO[0iúı¾§{0Å³\0\Ê\ñÿ\0À?ø\õsş#ø‰©i\Æ8l\×R’&m¦\ß*\Üyª:+\ã‡\×5\éºfµ¥üB\ğÿ\0\Û&\ÓmbF›d²Z»IşyM$¡ÿ\0mp+Î¾*øj_ø‚\÷M¸cÚŸj¶‘\Ê\É\ÂyH\ço\ëW¯´O)—\áMYu•kQ«^\Ãyi<\îb\\\õIÀØ¯lø%\ñ»\Å³–¥± \ëW\ĞHpeŒ\Î\â9˜tŞ™\Ú\ãÙ\ó¶¯%øiR?.E‹—€–,\ßCZş\Ö/~\Êm\ã¼]R3/r²\'\â\Ü\Ôr„.·>ÁX\õ\n\İIcq\ámûL¼˜\\¼0“²”>\ñ4¹7;\Û\Û\â¾\ôøCÿ\0\røiûPxÃ¶\Z\'Š,ü?\ã\è¢ÿ\0G\Ñ\õ?™#™F\÷€É·w’\ã\åœ§~k\ñ\ç\Ã\ğ½üi¨»v“ø\\\îSÿ\0\\\Ü\ñ]—‚|m¥ø6í•­\ïl\å¸\Ï\Ù/\Ö\õšd\É\Ëoa\Ê\ä\õ\Ç^‡5Œ¨Ášs3úøûE\é¾+¾\Ò\Ú\ŞEN\×mÇ”»0\"¸_\õ°ÿ\0=d;I¯yxCü[›‚Xp?\Úü\ğx\ãÿ\0‹\á7—Z‹\"³k\ék¤K–”_JŸvW‘\æz¿\Ş=É¯\Óø\'‡üHø›¡\è\Şø•\Òü]f>\Ç¦Œ>É©\'\÷œu¿\Ú\ákƒ†kbı¢>\é’\r´Ø”7Z–\Ú\îR\İ&‚H\äŠo¸\êÁ—\óŠ¡zW¢\Ö\ã\æ\"\òÏ™Š]‚¥\ïšM‚¤¢=‚‚­K@ü³\ÍE°T½±I°P{/\ñ\í\íO\Ø(\Ø3š\0`¦T”›\0G°RyMSI¯ü´ı)›O(\ËLQO\Ø3šBı\ê9@kQR\ÑG(\Z\ò\ô©\"ùº\Òl\"¨^•\Üˆ•–±,ÿ\0\ã\êº\Ö¿\ËwY¯ú¼\ÔûGŒb¥\æ4\ò¡û+|Ô»–’€\åD[Z\ä{T\Ñ(n´´*\"\Ø(`\Ç\îÔ›*ü½(TEµ¨\Ø*ZM‚€\åC••i)6\nZS?fÂŒ~\óı‚˜\ß1\Ê\Ñ\ÊÍ…7\Êj‘T,yfªz¦µ›o$\Ò0X\ã]\ç>”F-E\âkO\ğ¶…q}©_Z\é\Ö6«\æM,\ò\Ä1ÿ\0}™¸ü+\âo\Úwşa\à/†w\òi†?k‡\Ë¥ml\Ø}\Ğí™\÷Ÿ\ö«Â¿nOÚ†\Û+\âß‰¼=ªø©<#\ğ£Àê©­Ü´¾\\—3ºTÿ\0®nWG\ğ‡\Æ/v~5\Ô[P\ğæ–¾\ğM„km¥Bˆ>Õ©$]%”˜F}Á\ô¯B…\ö…tz—\íeÿ\0ø‡\ñ«O\ó|Iª]D\÷K²\ÛLµ˜Ágl=­\×şş_\'\é0\ê:\÷‰!iÍ±¾A\æÉœl„u\×\îş•b\ÏLÔ¾(\ê¾{6¡­jšƒ²\Ùi¶k½¦\Ï\İi\áU=\Øæ«·‡\Ã\Ú\×\ö~­gªiv\ğÉºù†>\Õ3p¶Yq]Ñ¥c)6iI\ñz\ïJ\Ôî¢‚\ÛÎº¼¹\Æ\ĞCj±§\é\Ş#\ñ~p\Ñ\Ú\Úue“r˜\Â\ë†-Š\äS\Ä\Ö\Ö\Ú\Ô\ÖZN«§—š\Şs\Å\ì\îr<\ÏdÀ­\Èo\ìm\ìƒ}¢o-ÿ\0t6\Å$Ö›¿½€J¨YH¾\r\Â&Œ5£L—Ÿ\ë-\Òù q\õÄ†¨E .…ª¤š^—«E°m’\é®7\Ç \÷Vªø‘á„šKY\í!¸—\ïË³\ÉTúi–:\ö§>µ\å\ö³<›?\Ö9Cg\ğ©ÿ\0Œ­\ô½_S¶·\Õ4X.!¹˜ª\ê\ZJG\r\Â1\ìB€ÿ\0°rÚ®™üw7€l®¬™ªGn\×Sµ¼‰$Šú\ÎSt™v\Çù2˜8äš¡e\âM.{ˆ^\Ê\ëO¸kY1rnU\Ù?º9û¾ÃŠ\Å\Ö\ì¾hl\ìi#†E—L·´®!a‰Z	rw¡ÿ\0NF U\Ê¶Ÿü9\á\rB\ë\\\Ò\ìu.I^\Ú\àAp“Bø\è]]Y”{7\íjX¼S }º\ÖfÔ´ù\â1\Å$q~\òGU\Ç*ƒº•¿„\n\äux¤ºu’=B;…”‰#š ]	ê²€0\Ñÿ\0´ÀŸzÁ\Ò~\"\Úø{Wvû-¼2\îbVÀ\éµ\ó¾2;‚;b¨cRùZ\ÇT·\ÖO´Ë\é,+\åG?ı3`Ë„­I{\â{9¦’\Ş\ê\İwBr\àŸ\"b\Øq…o\Ç5­7—TÒ­u	\îo®\ZHü™%	\åÈ£Õ£9I\Ûı ½\êM2ù…•¼7F\×,ÿ\0Ö´r\Û\æm¿\İ\Û\ò°ü9 ¢Q\î\í\ã\Ë\Õ~\Ë\ÜGO´*}\08\Ñ\è7‡T\Ódh­o®$³o-\Ö0D€ÿ\0{oCøŠÎ\\µ\Ò.ü›O\n\ÜZ\Ë\'Ü’Ô¼@~XV¥ Œ¢ş\ê=r\Êr»Mİ¥\ÄQ¬£\İÿ\0JÇ˜®Q, ¼\Óa\İfŸcŸ;™d\r\Çü\n\Ö\Ñ<A«i\Í\Ä\Ó\Â\å[t“Gu¶\áû§h—\Ø\ä{Uµ\×#\ñLoo­«\\\\a·–6Pzå™¶·ü \×>ø‹Á¶²\ë¶Ú ¶A¶C4;\á#\ëœÑ£\Ü9O\Õoø#_üMjk_\ë—W7‘\ŞŞ‹[	œ—‘ı\Ä\Éë¿¹9\"¿O§·02«+.î€‚­ú\ñ_\Ëÿ\0\ìıûVx·\áßŠt}CK\Ô!‚\×@º7x­£D‡ø·m\Ë{dœv\Å~˜ş\Êÿ\0\ğY/xS\Ò\ã\ñu\êø·\Ã7º¹¸úÉ¿½¡O\ã\\5p¬9Ôš+Ÿ\ğ\Ä\í\âw„\ìµ\ÍúKK\Ô#\ó-ç‹\ÃÑ½ıµ·ùû\Õ\å½\r‰i6\nVù£\Ê\Ò0c\÷h\0\Ø)•%\"¨_½@\íjZ’›\å5\03`¦S\äVZ6\n\0€\Ôı‚Ÿ\å/¥6€`¡”7ZY~^”P[ZŠ–Š\0Ò2\Ô\êUb´•\Ø?ˆë…\Ú\ë¢\ñ\'ú¬\×1l\æKı \óY\Ğ\Â\Ç\Ë\ÍL>Xª\"E·\ÌU~•™s\â\Èm„·gQA­Ñ¶ª\ïSw\ZÌ²\ñLW\İ\Ôş5 ’\à£oÖFI–-\ä\Úÿ\05:«Nj]Æ‚ùPú(§\ì*ÿ\0,\óO\Ø)\ÑÁ¸b°P¨`¡IÒ¤\Ø(Dı\Ú•\íjE‰—¥?q§mj•\î\×W‚~\×?­~ø3T¸º¹û=Ÿ4\İ4\á¾\êFY=«Şµ©ã±³i%o-!]\î}«\ñ\Ïş\n\ÃûTj\Ú\Ï\ÇI¼\á\Ö[­F\Î\åM\ÄûV#$\áœsÿ\0L½\Îu\ÃÁ\Ëc	i¹\ğ‡Æ\êŸ<Wsqr±\Éoy;dTn|+…+Œ\ãg gs\\\ç\Är{\ØÎg%Ä‰\ZC\å|\ïÿ\0p\Æ=«´\ñÿ\0†µŸx\îm\"mBK¨ü/Q¶Ÿp\êB]\02“¿ ç“g\ÂO·ˆ.¾\Ø\Ó\İ\ÃpZvŒ\ã\÷ŸÀ©\'Fıš\ö¡]I¼U¨\ÜY\èú>†=µš\Ør‘NW\î}\ß9\Ë\è¤\\ş¯\á½SÆš%\Ä\Z-Ÿ“ac™$\Î\â\ŞiW\Ó\æo»ş\×\Ş\÷¬\ñ¬ÿ\0o\É$²ş\ît\ÙÛ¯do¿¦G\Ë\ÇN\Õ\Ì\ëÍ¯^\Ümı\æŸl|¹e\ã\Ï\öú{)”lhs\è\ö–\ç\÷—‘Ú¯˜–v.\Õ\Øp¸¯@½ø\Ã\á}[B[6\ğ$v\Ë\İ[A™G\àN+È¯®#x\"\ÏÊ§ı\\6\ècYı­¸\Ï\ã[–\÷\Î\ÎI¯E%¥ısY\ËM\Â:\ìvzµ\÷…¬5Cºl`‰©Y\Ú\r\Ùû¼d\×5\â_‡~¸´–W\Z\æ4Ÿz`°Ÿø\óO¿´µ\×/b_µX\Ú\Ï\åÅ³\ä0\Èøÿ\0x\Är~Bªjºe\ô\"‡R‡MÔ²\çm\à¬Š:|Ë•©\æ6M\â\òcK]B\Ş1µfµı\Ü\Ì¯\ãVt_]A¤-µ­\İÆŸ2“6ù\Ûhy\ğ°\è\Éş\Ó\Ş\õ§ª\ÚumJ]:\Öş>\÷\Ú<“ÿ\0‚Ÿ¥gx³Dš\Õ0\òE<r¶\ä’xJ\í_N3ÇµlG1{\Äz\ì·Mq\r´v\ÌÑ¢\İ\Ä³Ã²9E\í\Ë{\Ö<\'\ÃÚ­×™¨E©i-\"n\ó`Tº‚SşÒ€	ª¶\ğH©p\Ç²X\Æc\ó£\\tÚ¤†S\î1Zr\Íˆá´š\ñd®K©…|\Å\ë_\é\É’hºä¬²¦å‘¼\Ë2§\é’\ãZ\Ñ|>Ÿ\Ä\0\\j&³™Sıd†T	ÿ\0+ŸÖ¦Ñ¾\İX…ºÔ®§µy†\ÔHŸøı+¦\ğ\÷†\ÓL¹kx\â\òUcùdú¶S\ô©rKsh.m‡xWÁ¤[ı¡üUuokkşªHaO.O i·\àkz\ï\ã½Çƒ´\ít\õŠ\õ–?šmM\Õæ‘¿\Ùİ¿sº¿†oµ›f‡NV·Y¥b\Ò\÷\ñü\0\n\å\æø;}4—	2±^²L\Ùbÿ\0\\\õükU\"ºQ\ÃÍ›\Ú\í_\â\ä×·Á¥\è\÷On\àI\ö‘\É@tÛ…\ã\ğ®¿Zø\ß\'Ä½ş=gIš\ßP‘\Ç…Ä–\ñËŸ!b¿®;\Ã>_	\Åq\ö?:9\\ù\Ê\Òc\÷‹ı\Ò%­\ôÚ´w–{nm`b’\É\î\å\0\õÂŒÒ©k±›ƒ[š~\ğD\Ô-d·µ‘tıZ’E<Ÿz\á\Ö\0:)ş\ë7\Èı…z_…-.-4\Û\Øm\âh¯\áo2KiF\ë{¨¼\0ùúbµ\Z\êÁ¾Y³Â­f¬m\î\îv\ç\÷,62–\ëˆx•9\Ê\áÀÀ\0V%–¡ym¬B\Ì\Ö\ë¬X¬‘A=¼„ù\îŸÀFqƒ•\íügÒ´\÷ŒùO³`\Û\Úû\öQ\ñ‘g¬N\Óx/Äœ^\Ûù‹º\Îùù„Q\Ï\è+\õ\çF\Ö\í<E¥Z\êZuÅ½\ö¨(–\Ş\â\'\İ\È\İHş\õ<\×\óck®C®iv\Ñ\İ[\İı«NŸÎŠX—t–Gİ²ıÒ¿:pA3zšû\Ëş	‘ÿ\0¿ø\â\Í?Á:Æ¡m®|?Õ\ëi‹\Ú­\÷–ùŒı\Ö$Ø¯?A}’ı¢?[ sŒTŠ\åzVf•\â=cKŠ\ò\Î\æ‹i“+26c”ÿ\0°j\Ô\Z”rÉŠ\óyYe½‚‰\ĞR\ö\İü47\ÍÖ¤\éw\ZvÁFÁ@\Şt¦ùMN_—¥,N[­\0EI°T›Gµ¨\0d»\ÏO\î\Ó*Eù[su¤\Ø(”S\ö\n(FŠ(®À2<N\Ë<\×-¢2\Üø[inµ\Ñx\Î]–\ß7Z\à\ô\ë\óg\âX\äİŸŸ…O(\ĞtHmt\İ\ËJ}\Å|\ó\ñ\óXo	\ëd¯Ê³~µ\ô \ñU¼š™#2ü™À5\ó¿\í\rj<U©Ã…\ÆŞ•\ÕB—\ó\ó2¯\Ã\ßÉª*·Ïµ½\ëÖ´\Û\öš\İ•\rÖ¼\×\áÆ„\Öv\ñ¯\0}+\Ğ`ŸkÆ¿\ÃYÖ·\Ù6¥#n9T\Ñ|\İj´¢N•z\n\ç7\åDŸ\ò\Ó.å¨¿\å­?`\ò\ó@r¢eb´”\ÍÆŸ@r şİ¿»EÅ»½ÇŸ\á\ô 9P›:\'-Ö°Pª¥Ê\ö«\ñ•Ç?g\ÏjV)m&¨\Ğk§m¨\÷:ª+\ÛT±\ã®\Şkù\èÕ¾%\\x«\Ç_¼cªX\Ü\ê Ö¯so¨£\í„+\Í#:„¹•ıá‘1“Ÿ\Û\ßø*\Ä\ğ\×Áù-­?¶i¶’j»Y~Wÿ\0—h†\r)\ó\ó´\ä~\ï¥~ø«\ÇZ„\Ú?Œ4µkK‹­I¦»–30*v³Œ\ãø³Ö½‘…I!¾!\ñ]¹ğ½¥œrM4ş$y/®¥·¹\naP\0q€: §ŸS\\ÕŸ\Äi\ÓT\Óc·o&$V…~\â\ÆW¡Px\éXº¯z­Ô‘\İIo\öK_³ü§…›û¿^\õ\ËxvK«NkË†=\êùqù‡vO\÷ˆ<W sF±n\Ö~·\Ó4¸\ZmSR´\î\Ì2¼\å\Û\ñ?—j\åÍœ\Şu¾Ÿo\×Qæ†ˆdN?¿ş\É\ön=«º\Ög{Ÿ¬\ßg†™¦\ÛÙ¬qq$\Ò;eÛUü»VM½®¥m\öT»\Ñ\ôÿ\0;ıa{€dú£§µL¥`û\\¥­#\áÿ\0Š5xaXmm\Ø*l!WÌ“?ƒ-XOË§·\ãRŠL\îu†Ñ¾A\õ5j\ËÂ—ƒ\÷r_Ey\æ6\á,2ü\Ùÿ\0W xO\á\åÕœ\á¬uI\r\Øq0G©É®:\Õ,\ís®\'.‡m\á\é5d‘b´[\Öh\ÆÕ™\n\Ç&:d·5Z\Ï\Â\ZÆ¡t‹a¢L\Ö\ó‚»Oİ„»Á\à~\è:»\Õ\ô[}±\ŞÚ¬\ê1<1A\æ1\ô\Ì0\"°—S\Ö<C\ö‹+i\ZşY-¯‘ş\ê…j\Î3¹»\Â\Åt8\rWHÓ´{•ƒP\Ón¬¥ùş\Ïuä«¯®°üª¶‰«I¦J†\Öm\ìşHv¥â¬§\rzúd\Âİ£¼†³\Í\"\é\æXb?\ì\î“\ğ­ø<¥^¤O{kxº¸	˜–d4\àt&F­}¸}YN5Ø¼DŸ\éšn\ó(qF\å§+‚\ZÓº¸›OÓ­c‚ûu\ÃlZ\ê5O†v\ö©\nÉ¥-›/™… ü´¼;\ğ\ò\İ\à7»·+\åıœı{ş4¥ˆQøo©\Í\ìsş\ğŞ®~U‘¤¸\ë4ûX\Ã\ô\Åz§‚¾Ot#\î\í\æ\åâŒ‘ŸËš\êü\ğ4[f_4\îé—o\å^¯\à†\ß\Ù×‹\"¯Ì½?\n\ğqÙ¤–\Ìú|»%şdp:À»˜n™\á…<”ÿ\0Vª7ø:\ê£ø7k\rŒMi¶y>\ğÙk\éo…Ÿ\ã\×¤u‘U~\êo\Æ\êµ\ã_„1øsPXZ9[¡\æ¼9f5Sß†Yº>ø·\ğŠK;‰\Z\Í{*¯ó¾¿ ^iz¡š\ò\Ú\Ü\äˆX®\ó\ôúI\ñ\á°kIUfş\ğ+Ö¾Wø\Ó\ğ†;I\ÚeHÀ\Ûj\ã\"½¼¯2M\òÍŸ;še6\\\ĞG\ğk\âU¯‰4]cB¾I­^\â\İ\îd¸L\ç€FŸ\ì®\É\ä×š\É\âù´¤\ó—Ï¾\ÚÑ®q°¯\Ş\0ú\ó×¯OA[––\r¡\ë+xÛ¢“Mr\è\à…^{ş5\ÈüF\Ó#‚Iš?\Ş.›x·²ÿ\0R\õ?A_O	)l|´½\İ\Î\Ş\ÓÆ–\÷\Öm\çO¦¢«À.[\æ\ó@Ç›øb¹\ë\Ó\Ğb{]z\óÁş)›û5^\êMo=‘²\Ë4øIp8eaüK\Ê\ö\"¼\æ\rVY´™\ôæ‰•n	\Ói\'$ßŸ\\úV½­\î±}\á\rCMšhu\Í½”q¡\é6Œr£Œ\ÓÒŸ*{™Ÿ³¿±G\í»\á\Õø_g¯èº£\ê^`‰­h²¶\íK\Â2‘ƒµO2A»ø¹ozûK\á¿Ä3Ç$š>¡iª[G‰\æ\ó#h\Ûî“A¯\ç/\öı¢µ\ß	ü^k_\ìù?¶7C%½\à[Ct\êÛ‚«\0T7m\ò\ï\ã\â¿P¿\àœ\ß/¯4Ë­[\Â\÷\é¾.û|“k^¸‰­¢¾´‰2\İqGˆı\õ\Õ\çbh5±¯´G\é\ÊG²3n­~\írÿ\0¼x¾(\Òmfe\Ú\×	’§µu‰(X\ò¿5y\ò‹O”²\r­KRRJ¡zTÁQª²\ô©h \è§\ì\Åı\çû4\0Œ¡º\Òù^\ô›Z—\0\ß)¨©¨ 	§c\æaF)\Õ7˜¹\ÍC/\ËÒº¹‰\æ9¿Ç¥yÛ¼Ps\Ğ\ägÖ½;\â\Ûm^3¯^5•şş¾\ÕQÔ£Ñ›\âz~˜\ë V*0>•\æ\Ş,\ñ„:µøy¾P:U\rSU‘\í$s»\é\\?Šµ‰,\"wfÛQ]\ğ\Ğ\ç=›Â\"·Æ»—wÖº\ËµUºt¯”¼+\ñr9u1I\óÀ]İ«\èß†z¸\Ö-’FmÛº\×m\r©\æŸ­_Sµr\Õz\ÑV&\ÜÈ—şZÔ‘üÏ·øj(\Ã3\ãøªÀ@§4Êƒ`¥¢Š•ü´\ÅÁ·µ?`\Îi<¦ 9P\ê\"ùº\ÑBü½(#™™?\ğ_\ÚN\Óá‰4?\ä’\éb¶¾”‹\Z¹Y¥HÇ©Á;±ßŒ\ç¿¼Wwo/‹\õQã¸‘¢vùbYc“\× WßŸ\ğV\Ø~ÒŸ\ğVF\Òo µ½\Ñ|§f\ò!\÷e’\Ôo«Ê§\ßoÖ¿:¼s¬\ê^:\ñN§q¼q\Ãu$\×7r¤1nû¸Â•\ëa\â’\Ô\á\Ù\Ìİ¾\Ûk¦’HZmFA.\Ğûƒ\êıı=ª?\êmc¤»4°ıºH\óD¿»…~O—>¼O4\ë¹m\ôbŸ¼¸\Ö\ã$«n\Ìa\ñc§\Ğcµf\Ë\ák‹‹;;YfÛªjS\ï‘8…8\ì8\ì?*\è\æ(\ôŸ‰Z\ßü!¾\Ó\í\ã…müI5 ùÙ†\Õ!q\ÇQˆşn:¹®\áşµº¼v–\ğ´“Kş¶y\\–o\Ì\ñøUÏ“,ş&Ô¦i²[mQ\ó9+\ËÇŸş·*/\Ù\ÃAms\Æ\ì\ÙVU|d\Ô\â=\Øs²¨\ÅÕ­hŸFü&øoi¨¬w\Ç\"\Ã\Ûn7~U\İE\ğ\Ş\éG\Ú4¹­¾\Ëÿ\0>„“\ó?­j|)Ğ­\Ò\Ó\Ë\å|½›xéµ\ëúG\íZ\ò­\æKüHNV¾/—?1\÷ø\\=Ÿ/S\çQtÙ·j\é7\Ö\âß¬‘¹U?F\'?­3P\ğ\÷‡\õ\áŸM\ğ¯}\"\ÑÌ·\ì\ç\İ\Ëık\é{ÿ\0\ğjÑ˜Ê‹¤n±L¹S\\†¯û;iZu\ó³X¯\Ë\ĞJ¡”~Òˆf	u4–ZÇø\áÖ¤º„7—¤‹9<\ÛX\Í\ğ–\í~‘\Ä%\Çı\õIªøcP½Õ®/µmB\ê;Á•\Ï9†5_A?3^·ƒ\Óu´0\Ék\r¤B‚>?\à8©4Ÿ\0\æ\òEX­Õ‡\ñ>m_\ö„»˜eD\ó|+7w\ô»O9F\ÓnPªœ\õÙ»¯\ã^µ\àÏ‚\Ğ\ÛF\ÒM\Z\Í3&^I0\Å\Ï\áı+¨\ğ\÷&$´¬\×\n¿zHH¾ƒ¥u\ÚEš…1\Çn±$c\nŒW#0sø[–B=»O\0Ckq\Ûü\Ãf\\\óÉ­\Ãÿ\0`h\Ë _Ÿ»¸­­7O>AŒ|üqSG<v\ò7›\Î~ny¯\Zm\Ëv{\é¨\ìw<Qea˜\ê»zs]‡Ä«\Û=^\Ég·š7™:)=+\Æ\í\õX­\î¬h\íE\ç\ÄR‘\í’0«\íQi¢‘{Ä“¥\Ô:ª\Í\é–ü+Ã¾*øoûj˜\\Œ®\Í\àv¯Pu”\Ëı\çŞ§w®3\Ä?\ñ0\à\Ç\åÿ\0»œ\Öøv\\\È\ä\ÄEN¬øŸ\ã‡\ß\ÃZ>¥+\ÆwC”#t×Ÿj—\ÛxCG¼º‹Ë¶h%\Ñ\õ6\ÂN\Äc\ô?5{\Ï\íy¦4^\Ôn@U‘7}Ü¾\é^\à\ë\Û;™.ü+y7˜š´	,RI\Ò;…)ÿ\0\ç5ú&YW›\Ì\÷?/\Íh\òby\'I\Õ\Ö\×W·ƒR_´\Û\Ç>Ûƒn\åfŒz\ÆI\Ú\Ã\ê\rmx¢\×P\Ò\\\Û\Ì\ó[\é²,\Â\î\Ü\ì/7\îdÁ\ã\æ\æ<c\n\å7g\'9>4ø}u¥Ü¼Ig$[ƒ\Ï\îYz£s\Æ\ï^µ¥\à\ïM=ƒi\÷½\å\äj8?†\ö\ŞE\Û<g\ÓxÁB9,gpzœW\ñTVºÕ¬:\æ’?³\ïof\Ùyi˜\á–c\÷&ş\ØN˜¯ ?gO\Û/\Æ\ñ}™›\íPø\ßOwş\Ì\Õ!›Èš\æ`7´R#|³¬±ü„d;u$k\å{\ÌxwQ—Ok¯6 }¦?)[\î»g\î€y\0|À\óœ\ó^©\áŠË¯økû\Ä\ÇM\Z.¹2¬²­40\ñ\ÂUP`aÜ±m\İ\óK•=Àıøı†ÿ\0i‹o\ÚÀÖº¶¯„T¹…“c[\Ê>\ô`t¯«´b\ò\Ûu\ÛøW\å\÷ü½\ñCOÕ¼\â\0\ßI,\Ş \Ğ.\ä\Ô\÷\Èw´\öÎ¸\r“\Ô\î¯Ô»h–5Ú£¼\ZŸ\Ä6\æCn«ú\Ó\ö\nf+\"ˆ\è£şZbŠ\0*7ı\çJ’‘T/J\0n\ãIN\òš—` \î4Svµ{r\Ò7\ÍÖ“`¥®ƒ3\ñ\ô{­k\ÆüA\íG&½«\Ç?¼‡Š\ñ\ï¨‚ùÙ¾è­©—\'m\ÌJu\Ç\İû\İkÍ¾(]µ\õÂ˜Š‘\Ó\ß]\Üù\Òcw\éQ\ê\Ş	[½:IX/\ï:f»Œ˜ü\á[„\ñ\ÃL\ÆEV9^¼W\Ù¢{M*<×”Yx\Ú\ÇZ‹¿^\Õ\à»Q¦\ØFª9®,DY¥9…§Éº<Öœ«X\ÚO\Í5¯ŠÀ®b\Ì#ÿ\0\Å\ëK–\ëH>QŠ\å\éA\ÓdIO\Ø*Æ¤\ÜhTI–\ëQT‹\ò\ô 9P\Ë<Ô–Py\Ò2³aT\äŸ\öj>Ø®o\â\÷\Ä{_„\ß5jù™a³µv\n¿}ˆ\éO\íXç“¶\ç\óûf|g“Pø£\ñSX³˜Éªø\Ã\ÆW¶\Ó\É;$Š\Ò\Ş@\"p\Ù\È\ä\ô\Çú¡\ês\óf¡\â][R¡»š\ã\ËX\ÄC\Ép­´v \0\ã^\å\ã?xGI\ñµv\ÚJ\İÍ©_\Ïp¯y5ºF\Ç*™Sù\'Š\È\"“X‰X`\Ù\Âdû\ÖzAd_\÷›\æ¯^\Z#\Ê<9\áË»\ÆşØÕ§i\È¼[ \Ù\ë\Ï\ó­_\r\é\ñi~1±½š\âH\×k±‰şrˆ:\'$ıNk¯\ñ6º\Õ\Ï\Ú5\rSU·µ<¶·K?&8\Ïû¹ \ÖO…´\óc¯\ß\\m]\Ëi-É’\ó\é\ê0V!\Ñ7¨\ÍW0u\ñ\Ç\Zw-7™!$( n\'\×\ëß±Ã©/,ŸP–?–i?u\ò×™kú\æ­\r®±\É#^¾$!\Ù\ó\ã\ğ\ãÒ¾\Øı‘~ÿ\0cøN\Îª\ÉÊ±\ìk\Ì\Î1”l{Y\ÚV\æ;xPÂŠU7o\ÆN1Ó¥z¦Šşzy-2«\r§Ş«\Úo‡\r…·”Í´E\è¿zºH\Ù,y\ä\Î\ìg½|.\"­\Ï\Ğ\èQ±”f\Ãj\Í™\êNM4X­\é’I£\İş\ğ®¾\Ï@µ…wyk»ı±Š†\òÔ´,h}q\\|¬\ï\öQ8=cFy¯\ÓÊ·Uf\ê\Ôû?\Ë\öS6«ÿ\0o_\Í%»†£\ì?yüªš\ê­\ÄK\Z¶\ß\ãk\Ìi\ì`Gg`\Ö\ğ*k{fØ¬[3u5¨,<Ø¾\ö\ßÂ³otÙ’i<¸\ÌoBGŞ©•\Ù\\‰lY³\Ô—;¿5\ÍÒ¹\Êş•“¦Nd\İ!\Ú\Ş\â¬Í¡µ¬+\ó4²I\Ğcir¢L\ÍA\ñn²	™Šı\áY:¾6É–en‹]ø™•²Uºµv­¬k\"·˜©\÷T”r£:‡%k{2[ùa”\ñ´d\öª\ó@-\ÃL±¸g\ê1œ\×I«x{Ì‘c\0¸«À\Ö\÷yÇ¥]3¡\ó¿\í…\á9$øa«Mn­,w[|\Ü\õV\'+Æ¾Bø¡\á\ö\Ğ\õK;¨Œm\ÒA=´ \í\å~\ğÈ¯\Ğ_[‹\ïj+2¬±\Ù¦ea\Ë\Éÿ\0\Çk\å\Ú\'\á-¾£ *\Í5­¤¢\ïK™\È\\\Â\çP#“‡ù2y\Ç9¯ª\Êq\÷^\Ç\ÃgxH\ó\óœG\ŞO\è\Ö:\õ„‡(‘Å«Byÿ\0„w¬MÁ\ö~+·o\ìıC\ìWV\äˆÁŞŒƒÃ±=;b¦\ğ\æ¨\Ş\n\× R¿l²¼¶O<2Š{ù”·^»\Ñu?øH´y?0dÅ\Â\Øÿ\0\Ó@8+ş\Ò\ó\ï_X|§\Ú\å0üAqŒc\Ë\ÄZmÕ¾¹k¸¼³+2\İ\"\ôgŒcs{¨Ş¨\Çx?Â±Àº¥†©¥\ß9š7µr\ê¤\õ%\n·ûš\ê5\Ã\â½IuI4\ĞÚ”\'d¶s\Ó\Ã/\÷¡+·\öz{U_xWBÖ¾%\é¾z\Ùj\ÚŠ\'6—¢mÑ›	d—\ËI\È!—\ïnŞ‚¹O¶ÿ\0\à‚$\ğ¯\í›e5¥µ\×\ö_Š4\Ùt—2DÛƒ\Â\áÕ\õl€\Ük\÷’\ÖV;}ú\×\ó»ÿ\0ıø©qû.~\Öú-®¸.\â_\ê¦\Æ\ñ\È,¨ûŠl¿#nV#)ƒ\Ï\\\×\î§À?\ÚIøÉª\êZ<–7š‰4yZ9\ô\Ë\å\Ù3Gÿ\0,\çO\ï#\÷\ô¯µ6§\ÌTu=R“`¥oš<­&\Ö\ò\ó\\\æ„{sFÁB«*\á¾\õ*ü¿z€#—\å\éD¿/J{(n´\Æùº\Ğ³–û´”/\ËÒ“kPá¿»ú\ÑN\ò\Çù4P\Òü½(¡¾n´WA™‹\â¸\÷[f¼s\Çj\Â9\r{GŠ•¾\Ëÿ\0\0\ÍyŒ\à\ó-¤-\ÍtR½bªdš€I~aú\×[«^4\r\Ñ3ø\×%}j\"}\Û~Z\é.ÿ\0\äXŒûc\ğ®\éF\Ç<es˜µÔ·x†5;±\õ¯b\ğª·\Ù\ãj\ğ\ë9[şùş<~\î5Œf¸\ñ%S;[n;V\Ì‹¥\ÊÃ½n\Ú j\å6ŒnJ\ß7İ¢ª¥O(Ê’“`©\"P\İhTGµ¼¼Ó·\ZlTy_\ï~”*$ÿ\0–y¯‚ÿ\0\àºµ”ÿ\0ş\Ç\á½%\ìn›\ÄHµ2š\Ş-™‘\È\É\ô\Å}\è\ß5¶V¿¿\à¹úD:–¯¯ZÉª\é¶zï’³½•Ê˜\ò\ß\Ë>CÀ\í\òHe+\÷¾Aµ\ÑF\Ş\Ó\Ş9\êDü\ëøot‘X]^\ê—\Öb\Â\ïv\Û)\0Î½u?Z\È\ñ/‰\õ«)Dzl62\ÙÍ\"¹‡\Í·¯rF\ïj\á4X¥\Õo\ï#ºY¦›M¶\"1.8\Ï]˜\'oü5/‡\à†ú\Ú\ÖC\ö‹h\÷·› \Ïz(\áÖ½j\ï\Å^-\ñ¤\Ğ\Ú\ÙX\ØZù»l\á\ód\ßùÓ¼\á?±i\Ú\İÖ´u)®.V$·v“‰r\á\Ğ\ò\ôVÅ–‡6µ-¥¾{qcgúP\òØ¤ŒŞ²£\è8­\rB›\Åş%‡MIn¤m\å^V%\æ¸brX““Ö²•h\Ås3Z4eV\\±5>x	µ\Ív\â\îi-¤9œt9\Ï\ó¯¯~\Zh)¡E—;W7\ğ§\á\Ô\Z.k\ZÚ´;~\ğaŠ\õxtH`¸w/Àù«\äs,b¯>V}\îWƒT!w¹\ØiPù\Ñ,\ËûÍ½­[c\öi!Œ£6şŸ0ªZ³\Ço™U}:V¥£\Ù\Ç{²M‹\İG\àU>ŠG]¡Z+s\"\î_îš·\'…ü\ÈL+SuqT´­O‘Rx\çı\Ù\ê_Š\ÚO\ZZ\Çl¬f*«\÷˜¯_Â³\Ğì™\Ë\ß|7\Ë\ÌxKD\ßÀTcˆ4ƒ¤¾\æ<ŸU®\Ö\ë\Å\öw¨&f”\×;\âMP^¦\ÕÛŸZ4)Jû¥Ÿ\ö”3r\ôùE^\Ò4™\æ1å¼¤\õ, ¹ü:U=S‘&*¼n\êEl\Í\â­#Rª’2\÷\Îüz\Õr—bıŞ‰B\å£\İ \è¡\0¬½wÂ¦ÔµÔŒ?|ø*ıH«–\Ş4ûD>Id=X°¬=C\Å\Ö\öqûKN \çqfşY£É´·d7º[Cs|«»î£ç¨¤\Ö\Ö[™#\ÏÒªjş?Ši¾\Íqo¸ÿ\0\ÏX\É\òÿ\0:£?‹l\Øce\Êı\î(\å1©R$š¥\r¼?3c\Ë\ë\\^¹¯ÿ\0h\\nE\òÖ·¢h\õeI¸‘\öÃ¨¬}gDh,š&\Ú::Ö”\â\Ö\ç<\ä\Ç#ªÚGO¾µa\ò\Ş[\Ë\ç¦F\ß\å^\'\ñBÉ¼y\áù£\n\ñÁ¸¹\Úûv¸ÿ\0¾¹\Çc\Ó\íÚ„\Ûm¤`øc1\ëÖ¼\Ò\Ş8ÑµM#c¬0\În!R3\òI™z\õ\ã?\àÖ½L=GMT\è|\ñ&\Æ]\"\â\Ü*˜nw:´i\È|t<\÷\÷\Ö‡¼O%\å\ï\ÙZ\é-cy°\ÎX¬pŸ\öÀ\íş\ÏOj\õ\Ú_Á\Çû*\Ş\ák[\ÈrWƒ\ÏZ\ğÇ¬nˆ\ÒI\Ò)T—\ê:W\Û`\ç\ÏBıO\Ïq”e\nÜ§q?Œ\õ]>\ë\ì:ı¦›«\Û\Å\'™¥Ê«şú\0ß™¬RüX\ê{iku‰¢‡\È}>µ\ÏÏª,7‹\ìf6	4\0aü¶\è?\à>½k[Èµ\Õ\ô+†´¸û=ÆŸ\å\ÜBeP\"‘\ñÏ¦u\ó»\ñR\ßRøI\à\êVz·™Œ¥Mn4\ád\'†A·p\ìN\á\õ\Û_¯?¿h«=s\Âü]¤\\,ti\Ú&¡l¿+ê¶·¶\É)<²ª’ü\ô<+\ñÆ–šŒ\÷¾f·Y\í<¸¡‘S\Ë$ñ»¸“\Ó\÷7ü£\Ã\Z\åÿ\0\í“\à\Ë\ï\İ\Ş^x’=N\Òu\Ñ\ï7)‚$·\Ø&\Ù\÷@X£\Î\Ünù±\\xšh¨J\Ç\î\ò\Ò,¯\Íü^\ô»1P%Øºl…ù~µ.Ö¯\ĞVù›q\ëH\Ê­-GRS|¦ \Ø)Û–’“` \î4S¶\n(\ÆÁDª¥-\r\óu®ƒ3/\Ä\Ü\Û~ü+\Ê<W\ë	\ë^µ\âUa\Ïz\òÿ\0(\î\íÒº¨ÿ\0ª»sE\â)Bøùv\ô­K›\õ	\ÆEs¿\õ¶·*M7T\óü-m­]\Ò\Ô\å¦f\Û\ÈZŒ\÷\ó+\Üü\Z\Êúlx¯\å[UŒ¯®k\Ş~2.<\×\",Ò™\ÛiªÂ·¬\Ø\Ö\å«z\Íq0Ğ³D_7Z(_—¥Ü¨*EùzTu%ÊƒşY\æŒQ\ÛP¨ \áv\ö¯’?\à°\Z„\ôŸ‡\ñOˆ4T\×_‹N¼‹P¶y\Ö2¾û‚\\|Ñ˜\Ød2a\ÈE}o|\Ãÿ\0pøyu\ãoÙ¶\ÆK9£†M3R†gib\ó#c±\Ë/\İ`\ÌwZFIK˜\Æz\ì~!~\İş(\ğ7ˆş<j’ü;\ğ¶\àı\Ñ\Z\ÑHC<w\å†\ñ+6w£\å\Æq\í^C¤\è73\Û\Ù\Û\Ãm-\Äz|S_\Í\ÓiºDªOûÄ¶?¥z\÷\Ä\ïƒz¥Îµ6¡o§\Ü\\A\r\Ô\è\Ş]¾\Ø.\î¨uG\Æ\Ğ78\àp:*¿À?\Ü_xsT¶º†h`ûSÁ4¡9\ãj¼\ÆO8fBMus0Oc›‹No\rü7†y6C5\ô_6\Ìe\ò\Ñs\ÔùŸ{=GlW°ş\É$®§v›.\Õf\å€ú\×\ñ\nÅ‡‰ü\áÿ\0-X«;NB\ñ)\Ç\å†jú·À‡\Â^µ…Wrªe†OZ\òs\Z­.D}G†ŒŸ;\'M9t\ë\Ådh¡­\ísN\ğÍ¨¸½\ó¼ w\rƒ\'5Ÿ«\ë±\éVRjO\'\Ù\àL¢¯­|ı\ñ_\ãf¥«Ü²Û«±?v8ù\ã\á\ğ±©.f{˜¬T©G”\÷ûB\é-$«uw\r½ºÿ\0«ùù–²®¿j\Û\\¿‘yk\Ñ\ßå¯µ7Z\ñ\Şu\Ä2y˜\ó\0\î\ñX\Z\ï†<e*\È\Ğ\Ù\Æ-ÿ\0½¸š\õ£–QûG“ı£ˆ>\ÜÔ¿k\r&\Õ![[\èd¸a¢\"\Ş\õß¶j\×e[¥K\õ\Å|(\Ş\Z\×De\ì>ZJû\ò‡;Òº\ß\İ\êB\ì4‰\'–¿\ê\İø#\ò¢Ym\Ğ\Ò¦!n}Ÿ¦~\Ğ_m–\İd’X\ä/‡…\ò®\Ú\Ë\â¿\Út\ædY¥ıc)û•\ñÅ†±qqi\ä\ÜH\ë7™\÷\ó\ÍzW‡us›!F•n$è…¶\ç\ò¯‚¦¶=|cQ\î}7 üHŠk_3p_Ÿ\0g\ï\n\Ò\Ô>.C£ù›w/N\0¯Ÿ\ã\ñ<zdû¦_2# µ•\ãŠ\Ğùg\æeÜ¸?Z\åË”\õ%Š´y™\Üø\Ë\ö†şÁ\Ô?\ÖF\Ë\íŠ\ã\äıªä»‘€UHÙ¶,²J1\íşÿ\0·J\ñx\ÈŞ¾*·Ö¼\ß\Å\Ò\Ş]B±Ç‘¶\ğ·{\ë\ï^\Æ/¦\÷>{˜O\ì³\ìøl-\Ù<µ\Ã3\Ãşµ\\…\éŠ\çgı­\ô\Í\'QšC0·/ş¬\È\Æÿ\0ˆ¯Š`\Ñu‹É¶­¹ÁL®\Ö\Üsø\õükcKø}\âë¶”ù6¥?€\à~\Û,¾‚\èy/2\ÄKf}¡gû_Z\ÜWÉGq\æ3G+¢øûG¶«¨\É\r\Ó,\ñI\÷7aG\é_Xü-\ñV˜Œa\ÔÈ²\ì;°\Ü~ \×_\á]3V³\ò\Ì\Ò,\Ñ\Ãÿ\0-#ÜŸÎ¢¶‡\Ù6¡\Ä}£\ì\íSJ·¿…®,\åE“§–wü+\È|{c>‰¯Ay6ÔŒ\Å8Ä¤\ä\Ìu\ë\×\Ô\Ö\Ãß‹W¾\Õb\ó„\ñG#\âO1•ƒÀqøWu®<Z\Ê\Ìû•¡Ÿ«œWš¨\ò\îzs\ÅJ¦Ç—|Q\ğ\ğ\ñf‹p¬­¶C@\ï_|GxC\Ås\ÛÍ¹¦†N:¯µ}\áªh“i¶&8u»ª\È~\àú\õ¯?k)´Û\'\÷·!œ}\å\÷5\ï\ä\õ¾Ä\Î)/kz\Öv7H\ÊÌŠ\çLm\Õ\É\õ\ö\í]vƒ\ğş;ø’Ñ‘¥š\ëG\òÀo˜\î\óùGû¡ºT~\ğ\ôw±Ô¦q<Ñ¢\ÄIY6\ì\Î8\÷¯Sø\ë\àoZ\êz\Äm4zzJMµ\Â4}\\yÿ\0»^Œ¥cË+œ\÷\Â\éUü3«[}ºK}AvMb±”/c\à†\Ü	]\ÃÒ¿[?\à•ÿ\0³M¯‚´h¾!xŠ\ê]kÆ\"¦2\İ\'\Ø°\n‚\å®\0 q_|%ıŸ<ûl|{\ÓüA¢\î\ğ\ÂÛ™WQµ…I\êXNW*\0\'\Ó¯Ô¯„^Ó¬t\ëvo*„V\'\ß\Üûkµ^h\ó •.Wf}\áû\ß6\âü\ë~)Yºš\æü \Ä\Ù\Æ\Ûynµ\Ó\Ãy\æb7\Í\÷h¡~^”Pl²ü½(¢z\0Š( Ü´TTP¯4RD\åº\Óv\nUùzWA™S\Ä#uy/u³°¸\İ^³\âC¶Ú¼/\ã=\ËCa/?{­tQ—½p±²<\âÏ‹\öƒ:\Ót?»x^>\ç\\/\Äıc\íÿ\0{>?\n\Õ\Ñu˜—Á\áù‡Nk\Ğ1„m¹\Ô\èúÏŸªn•\ô‡\Ã\ô:ùO\ÂÚ—Ÿ¨!S\Ëu¯«ş :<ık“$U3¾\Ò\à\Û[vÿ\0-P±ƒly¤ª¥q­\óG•¢…ùF?` Ó™¥\Üi\Û2€\æB\î4¾h¦\Ôk\òı\ê\åE„ù“\åùk/\â/ƒ,ş\'øX\ğî ¬\Ö:µ»ZÍ·‚›†	r8\î«Eœ°¤,OsÀ\ÇPg\ì\Ùù\'¢¿²\Ü?gÿ\0is¶\íZK\nx†\è¯\Ù\îv\àG–\á\\\ÇSÔ‡8\ãš7„\î-nu+;\Ç\Ó\Ö\Ê\ÇP}R5Œ™¤®¸\Ş\Ø\0g\é_­¿´\Ç\ì\áo\ÚoF\Ô,|A§\Çp5kh\í\Ú\ã· Ÿ\"e`AVs\0A:W\ä?\Æ?\r\ß|ı½/¼?0¸ºM.ş\éd\Ë³\"¦T\\®Î¾æ«™xx©;#\Ì|!¤Ç®|j\ğ\ÌrE‰¡Ì…‰?º@\'\ßk\é[û-\ë‚v¦08\â¼c\Ã\ó>8iw\ö\ó¥\Ü3@\Å\ö0YK{\ö{W¯j\Z©\Ô\"š\ãioE\ô¯/0»¨}&W\Z\\\È\â~3^B&û4\Å\ÕD\'\ÌTÊ¼\÷Høj“\Ûùr…	\ák¬\ñ\ö¹\r\ô\Ê×›RHI\r¸W7â¿‹pø[Cº6¨TŒù\Ött\Ø1R¾\â\İøb\ÏA….\Z\ê;x£}û¥eUaÿ\0\æ¹M[\â^™oc\'\Ù\áwQÑ¤4oÎ¼sÆ¿5\İ\Ş\\d\Ü\ê\Ó\0\ëlµ€™şÿ\0\á\\Ç<$Úƒi×š–½y©E%Ÿ,\ñ<b\ô\Çø×­Bœ~\Ó<\ÚÕŸ\ÙG¢ø“\âR\Ï\æG6ˆ¾ble3p‡Ú«Zx\ÛÉ•d0Û´*\ŞX’7\ó\ïW\r\áo\ni\×3\Ò!··{½9¯ekm‘\ì=I$W\Ğ?\ì>\ŞiÑ¶‚g†\î1\ä;YÀU]¿½³\îş•¥F\ÄSœå¾‡6o\íd²\ó¡N\Ù\Î\ä\ä\ç\é]7ÀÈ®|e\ã;}5\æ3®\ã\÷Ey•-\æ…\â(\ìW’i\óu.1øW\Ó°\ïÆ»\ñ\Z\óSF+mk\ZG#q\ë^^:P…\Ës\×\Ëb\ç_–;J\é²e›\è+$›$‘º‚½\Zù\Ï\ö¨ø?\Ã\Ãûœ\ì\Î\îık\ôSE\Ö\ÓÁşRŸ´4g%v¯“ÿ\0nmø‹KG\å%\Â}\Ğ?¾gY\ó\óHú¬v*‡\ç\Ì\ö=\Ó\Í4ŒÑ™5\Îø“\Å\Ó5\Ç\Ù\ì#i°\ÛQ¸±®\ó\Æ>¸³Ò¦µ‰V9™\ğ²IÁ\ÇÓ¥aø\'Àú—ƒµ›K\ÕKK©–o>?4ı\ñı\Ò:~•\ö\ØZ\å¹\ğ8®e.Vp>ñ¿¬\ê\÷\Ğ\ÂÖ¶­§\Æ\ä­\æ#a‹\Æ+oBø\ß\â-+V²¶š&\ò\î`e\ÚPŸ®3Z·5›¯ˆz†¹o%\íQÌo*erz\õ­_|\×t¯i\÷·–ú}\ô6m¾8P\â\Ô\×D\ëSg<(\Ô]\rm3\ã­\Ë[)’\Î\Şo™Ñ”°Y™\r\÷¿\à5»\áß‰ºŒ­L{¡\ËhŒ„:ş¬ßˆ³\Õ\ïÄEd‘¬\ôx\Ù\Ë\Ä-T¹ˆ¸\'$V\r·\ìy}\á‹V¸›Ä–\ép²|Ä¡UuúkR§#ª1¨b°\ğ®Ğ 2\È\ŞY\Ì^Y\Î\Óı\Z\ê<\'um¢–Y£x\ã~±\ï-Ÿ\Ì×“xC\áty#\ó.HıS\ÂÛ·\×{¡øVKmI$\îy&=QºW™VH\î¥z\İ\â\Ş\é³/—Ö¸\ò\ï\ím\á5\Õum6\\-\âl\ó1“ŸoOÂ¾šJg´ ·Qƒ\ô¯\'øÿ\0¤Ç§\ê:\õ\ÊM-µ¼±…Qû\ÉBd/\Ó5Ñ­jš¹¥;\Ó9OxbøCl\í\ï-W1\ÉĞ¹\È\ãG=*\ÏÄ¿\É\â-V\ê\åm&µ†EûYJ	¿15­\áme´k{H<¡>­t\ám¡Ow¸y	û©¿œ\å]\×\Ç\ïÁ¦|\Òm\á‘&¸\Ñ\Ûm\Õ\Èû\ÒI!\Ü\îO¹üj\í­‰i\Ø\áÀ\áù·=wşE\àx\õÏˆ~ ”Ÿ-¬l\Ğ;\å\ğO\×ú\×\êŞƒ\á\ó™r\ËĞ\Õù“ÿ\0\÷.ÿ\0Œ$·gE\ó4\×}½A\"D\Ç\ó5úû§\èQ\Å\Û\ô®|=[\Ó\Ô\Ç3Š^TM\á\İ<\ÚZF1\Ål@Æš¨B‹Ò•~^•GšG/\ËÒŠ\÷uZ]\Ë@	GûÔ»–™$e\06_—¥\ö@\Ñ\ä\Ó%ùzP|¦¢Ÿ¸\Ñ@¢Š\"ùº\×A™K\Äš×š\ğh™1ş\ïJ\÷\İş=+\Â>7A»K¸\ÍmO@>#ø\Ãy\öK‡lr\Z\É\ÒüxW\Â8¥oüZ\Ò\Úú\æp£§Já¬´“o\á)7/N•\é›\ğ›ZşĞ¸™·\ZûW\à\Ç\ï´[vş\Zø+\àş}\Ì|\×Ş¿~]\İG\İ\ô®IT\â\ÏU³ƒŸ\öj\Ô(&ÿ\0f™o\òÁ\Å.\ã\\¦\Ã\êJ¤ £“\å“\'ü³\ÍF~cš\0)Cu¦\î4n4\Zs!\í\ó}\Ú(_—¥6F+hd9\Ú$}§n21\ßü\ö¯Éø)o\Ã\Ó?\à¢V\÷º~\æT¼³7LÇ§\îH¿‰Q_¨ú\Õü‘#²\ğGJü\Ãı¿\õ»­\'\ã^‡¯j––¶qPM\å‹\Ó-\õÂ‰0%0\ôÿ\0²\êRvW:\ğ_\Ä>m\Ñt»\0üv[v·Í¼–\Ï…>!\ïık\×c°şĞ¼\n±\ï\ó>\ñN\õ\Æ|t\Ñ\î¼)\ñş\Éa_3G\ÕÉ¸´\çv\ó\İ\÷•\ë>´†\è£Ü±\õ\äŠ\ñ\ñ\òj\\\Ç\Òe»\ò¶£\ğj\ÛTš\â\Û;¾\èØ¹şU\ç~&ı˜tŸ(\Íq£ı Êª\ÅÀ_¥}e¤\è+wn‹mû\Ùş\nÒ›\Â\ŞÄ±ùoò Ú¼Uœ7>l&|Gm\á½Â‡ì­¦5Ÿ•œ\0Ÿ*\ç®AøU}SÃºmË´\ğ\Åjº–Eş]+\é\ïˆ³¾¹\ç]o—\r\Ôr3^;\âÿ\0\Ù&5\ŞĞ›•\Û\Ñ\ÍÃ\Ó8¯B†:\êr\Ö\Ê\ç‡‹ø›Kµ²\r\æMcåª„»H\0t\ã­p:Şº¶\í\åX¢»\Ú\n\Õ\ï\Ö±¥\Í\İÊ·\Ù\åŸ-»#\ñ®ûÁ_°?”\ñ\ÉsnUs—\È<š\ÖYœ)ü\'<²™Os\åoøR\ñ+\Ã\Zù\ç\Î9,cˆ}k\ëÿ\0Ù·\á\ô>\rĞ¢°·…•üÁ,\Ì~\÷*\ö­\ğ¦\Ç\áıÍ¼p¬j#M„(\ã?J\í¾xm­\ô]cZ™\î.&\Ù¸*z`\ñø\õ¯x…\Ë\Ğ\÷2Ì¾8}zÅ£\Ú\ŞXZZ²7•gv6<E\Ì=sŒşF¼\âç‡£Õÿ\0\Î`a}û[Œt\Å}+\ñÎ“\ÃZˆŒr‹$\r‚^¼Wx\ËG¸K\í\ÅL–\ò\ç\å\ÇL\õ®‡cÒ©(r³äŸŒ\ß>\İ<w‘(+œ\ğ;ı+Ìµ_†WŸnùY¢x\ì0\àı?ú\Õ\õ^·\0¸½fyk\á•\Ôc\Ò\è?,u\Ë\Ö8¡f\õ+¸\×}t¡3\ç\ë\å0¯>fŒ,\ôMrÁvIW\È:HŸ!ıkb\ÛW¿´\ò\Ú=MŸ\Ş2+c\ğ<W\×z\ìµ <¶]­\ê±n¿bchÁ^9/L5tÿ\0i.\æ?\Øs\î|\åe«k7’7“m\r¼gî¼ ¶?*\ê´‡\Û\×Ñ­\å\ä\ÓMı\ÅÁ_Ë¥{\ç‡?ck„Uo´?–½•şU\èZ\ì\İg\áÄe³Sq³9\Ï9®J¹”e\ğ³j9D\ã\ñ#¢ü#– ¬¹Š4\Ét|³\íPk¿¤Š\ò9\'\Û2\ÏH\Ğ\å_Bx‹\Ã[Ÿ\ì«n\Ğ\ÅÁa\Ækœ\Ô4äµ”#\Ù\İŒTS\ÄI\îtVÀ\Æ;=\êšdše´\ã\æW‡¢\ã\ïW‰ş\Ôw\rqm¥²¶!´œù¤1\ÈÁÀÏ§zú›\Æ\Ú\ZË§L>Ub¸S\â¯ø\ã\ğ\İ\õÈ´®Û»ù—¸\â/¯c^\æIJ\ç\Í\æ¯o\Â\ÏMa\ğ·\\\ñ\ß\èÿ\0c…//\Ş$É‚¹ş•sX\ñÚ¯Á_Û©i\Zkq*ù‡•\ÇCZÿ\0´Xµ\ğ\'Á\r\éz[Mu¤\ë\Ì\òI\'\Ê\Ìb\Æ×—`q\Ó\å\ô®D¸’?‡:\ê\Ç#s—æ‘»\å\ôÁ\âº\ñ\Z\Ê\è\áÀ\Ú1\æg\İ_\ğAûMá†™\âO\ëZ¾—§°[}>\Ü\ÜN¨&y4›Tü\Ø\Ú\'¥~¼X\ÏÍ²Ê¿4n ‡\ãi\r\÷XW\ó\ñ\ğ\ß\Ã\Óüı‘\ôÿ\0\Z4–:\Ãxy´©\ô\é\í\÷\Ëo#g\É\"¢‘\Ï6z\ó_¶?°Æ¡y«ş\Çÿ\0\îµ)š\æ\êmygÁŸ¥mÈ•5n§ƒ‹Ÿ=k­/\ËÒùgš\æ\ëC|\ÃH\å#\Ã‘I°yy§n4Ÿ\òÊ€#¤UÒ–Š\0wš¸\Å5ÿ\0yÒ“`¥_—¥\0?`¢–Š\0)aeŸ\ò\Ï4Š¡zWA™¼Ğ«Ä¾6 şÌ¸¯p\ÕIa&\ï\á\é^!\ñ›æ°¸\Ík@ù\Åv?h¾»~\ïJ\ã\õMb\ğ”ûWzW¤_i2\\\ê\×*y\rÖ¹ÿ\0ø}\íü7q\Ú\ôy‰\å8\ï\Ù\ÕÈ¸ø•\ğ>•\÷ÿ\0À\ï›F‹Û¥|+û>x^H¯·\íÿ\0–+\ï‚\Ğ}—G[\ïW}K†‡«Ú²´T•ŸúªŸ`®Q\óÿ\0,\óRT}±K¸\ĞPşØ¤\Ø)h ¶\nBı\êZ3u_Ö€\nB¡†)»>€3\ï´uº‹wu¯ÎŸø*‡,t	‹\çh\ï—_„€\Ä.\Ôb\ä‘\è	¿Iv\àb¾\Zÿ\0‚\Âü)»\ñÃŸ\í{8\ÃAm\å¢\î»xr\ÅûÇ‚zú\Öu>·+UQ\î|\âh¯¼W\ñ£\ÃV\ßh»š\ÇO¹ÿ\0VN\èÿ\0\Õı\ï§\é_Ex3JZÈ«…i›f\ß\îš\ò\ï\ÙwG}SÂš¦¥¨ym6\"X\ÆA\Ë#½ø\õ¯e\ğ´1\é¬Ks$»˜ÿ\0t\×\Î\æn}®]†j\\\Ìé´‚©Vû¼É‡h\Åv\Ú-š\Û\ÛF³±\İ\'AÒ¹ÿ\0iÖ¶±\Ç\"´Rµ¸Š\énüAk-\äL­û¿»»Œ~U\àÔ‘\ö8Zh¿y\à\÷\Ôm~i¼”“ À¨`ø§á¤»Û‡\è\íş*\Ä~=µ{dYm\î\ät¬?ü@[\õUŠ\ê9z`°şF²Œ”\ï\åOsV\ó\Ãz„mƒ\"\Ç#<²y®\'\â\ï\ÆK\é’J’\Ã\r¾1†<î¬\Z|Rm\'ÎL\Û2\ÏC\ô¯—>/x\ö\ë\â7ˆ¾\Ëyù¿0PÎº\é\Ğos\Î\Ä\ÕJ\\±=A\ñªüVº\Ô.‘|\È-\0ı\Í\íø\×\Ğ\ß\ôXlü9eco“\Ì9\Æ6\íükŒ\ğ\ÂM/\Â\ì­\äa\ö‰}Û•û¯\ëÿ\0\Ö\éZş\ñ\ôvšc[–\ò\Ş6Ø¤Aú\Ô\éq\Ó\Ós\Ùüs‡¨ø£ºÿ\0‰œ0»8\é\ÇJ\òm{Ã­gnÛ¼¶…º—<Ó¡\ñl—mk\Ë\ë‘\\\'\ÄŠV\Ú\ç\Üe× İŸÒ´œ[vA\'«³\Ê5\è)\×!kidXd\à\ã9¦ü*ø\Æ4mel\î6nß„f\ã#ŞºÏ‡šÆŸ\âRñ¤º…g¹9s\\\ÆOiş\×V\â\Â-Eq\ò¾Õ½8st<ê•œvgÕ¾ñ¥®¡k\ê‹&î©\Ï\ã]bx®Õ­f¼û\n\\2\ô„¨\â¾+\ğ\'\Å\Ë\ÏMŸu6\ån[\î×¸h_£k	d\İ\æt\æ¹18v¶=,&*3\Ü\öi\õ\î\íÕ•Vn€(«76\éi#\İ\Ö\à#`p>+\ÌtO‰q½\Ä!›,½8UıW\Å\í7–\ÈU×¾My®•GKs\Z$H\õ;\É¤Ÿ\ÆÛ?‡J\ó\ï}>\ÒE˜}\äşÿ\0\ãL\Ö|g$z£\å\Ü\ïG\ëø\õ¬+ÿ\0C\ègK¦Ppızşu\ßJ2<œL¢s#°‹V²Ul\Ã\"\Ì\Ù\ïYZ\íüQ¡>Ÿ\'\Íop6‰‚‚TV\å\î£	¶¼.\Ø~\ò\áúU\ï.ù#\ÜT¸8\ìÑœ£¹\òx\ÎV|³ûcKy\í</O†l•BÁmåœ¹o\Ä\\E·‰#\ğ\÷ƒ$°¼…£{Á‰€a\òŠú_\ã\ç…f¶ø\Ù‰#ÿ\0—\Ë·x\Ø`9U\Ú\ÍùWÉ¿n$Óµ-q\í\í¼\Îs²E\à-{j©\îxµ)¸S=9u›\ï‹6^\ğ~‡‹\ôÊ±Íµ¯®n\'™*@\Ï|šş…>xZ‡?\n¼9\áxUvxN¶\ÓØ¯\ñ4c\Ïû\Õü\öÿ\0Á\'|%\â?Š¿´u\Ğ\ô=7Zº\Ò\õx/$¶¹*º!\Ê\äz\õ\çù¯\èƒÀ:M\æ•\á»T\Ôf…\õŒ›’ªv-¸œık¹k(\öG\Ï×ªT/\ËÒŠ?\åjyNr:0\Ø\Æ\ßÖŠ1R[Z–—q¤ª\å\0o\İÿ\0µC|\ßv…ùh_–<Šq¢’Š\0“¶(¢Š\è3#\Õş[Vøº×‡ücùl.7W¶jn^×š\ğßR´ZmÀS†úV\ÔÀ\ğ{ke}f\\\ã\æ\ëY¾3°-%±\óu4X\ê2.³&\ï\åU|}›ªynµ\Ü\Ô>\èjš§¬¯­~¨‚\ÇQ_$|¿+¬a¿\ç¥}m\ğ\Ö\å@Œm®Z€zUŸúª›\Í^\ÎA\ölÔª¡~\õr-3q£q£r\ĞhI¼\ï\Ï\ğúRù¢£\óWf\Ş\Ô\Ú\0—rùu\ê;bŠ\0*J–\'-Ö‚y‡\Å\óu¯™?à¥¾9\Ğt?†øgPš\ÍuOH\ØÀ\ëş\Øp\Î\é\ß\ä±\ëšúz\Ñ6\Ó\÷«\ñ\Ó\ö±\ñ}ÿ\0Çø)%æ³ªk–§M\Ò\î[KĞ­\"›2@\ñ)„F\Ëü.\ÌÅ½\ó\Îk:¿İ6&	\ÃoG\á\ß\ê\Ë\r·ú‹L\Ä\0§\å[ºu\ÛYirs8\å¸\êÏ¥h\İ\évºv™\r„ê–‘øş6=y¬VV\Ó\ìS\Ì•ºŠùzº\î~…O\İ:[\Çk¤´\n+\Ó¥_\Z\ãAm\ó™ş¿5yT+“Oy\äU;¦\ó]·\"¹·c“\æ\Îz•\çÎ\ÏSˆ±\Ù^\ë\í<*\Şz¨_¼3\\]ş±s\ó´w±\É\ó:–şıd-†_›¯½r~0Ö¤·²Æª§\Ø\ÑJ‘\Ù\õ£â¿İ¢d‡+¸`ù‡9\Ìü=\ğLÚœRj?/\ï?‹\æ\İU\íü\ïø–\ŞV0·ú\Ç_˜\n\õ\í;\Â\Ñ\èúLp\Ç*´pœ\ç?x\×t­~XO´“Ÿ34üw\ñ\ËO\ğŞŠ\÷·g\Ó\ÙwË’£>œW•|6ı¯ü\ñw\ÇShú=\õÍ¾ §tq\İ\ÆaûKú¦kƒø\íá«­S\Ä3ª\É$1\ÎÛ˜FÀ¬Oë‡\èx¯5Ö¼7¥¦³\\Ú§\ö…’\ï\î\Û1J§\Ø\ñ^†I\Ó\å{^#2«\Zœ\Ëc\ì-k\ÅwZ$\r˜jdHÀüÆ¾qı¨ş//Ã\ãVšV¾¼“bZ\Ú\Ì\òªq\Î*o~\ÑwM\á4\İy\ä’ú\Ìa®”\Ü§Aø\n\ñŸ‰:§ü,/AD“\Ã%a\ò£„™­px¥\ÍPŒVh\êC–4~~\Ö>3\Õ5x\ã\Õ<#–Ì¬\Ğ\È\ÊAÿ\0^\İc\ñGş\íF¼\ëc6ìŸ›Ÿ¨¯‹E¸\×n!7\Ûş\ÏÀH‰_4~®û\Â7a\òm\í\áXJI\Ê\"\íız\×N*7ü5c‡\rˆª¾6v/Ğ¦Ô´ß´B»\ŞÓ¾|H’\Ú\åtû–o9~\ê7«¨²Ô¡»\ÓURHUW\ïy•\æ¿lş×¨\Çyd\ÂB×¬küU\çı]=\ÏV)\Çc\è-\Ä[c\Ë\ĞÔš—Ÿlq¤Àú\àı\Ú\ñ?†?\ô\Ö\ã\åÖ©8\Ù]”š\Ô)n\ò\ÆI\'\Ş8\ÎkÊ©…=ªy‡5=\r?ø{‹ø\Äm\Æ\Ã\Ôú\â\é\Ök-\ËF\Ò,1F\Íq³ê³H»J/\×5W[šMCNh\ÖM®\ÃÒºaJ(à­Š\æ\Ø\ët\ïGt¡m\ê\İ3\ß\ë\ëøÖ½»ù’Áµ±»®\î+\Ìü<kp²¶\ïT5\Üh·<l\Ò7Á\È\í[hyX‰\\\Ø\ñÖ–š\ß\öXY7Lc–8„£ın‡ü\ó_?ø[\à\Ë|Uñ¶¡¢\ÜI¬’\Ì\Ö\ìz‚øS½+\İ~*\êm¦xcC¼Œ’-@\ìcü,S\'\õ\í]\ÏÁ_\é¿üy\áù\ô\å\ßV\Ô.\íà»‰#½\÷“\íéŠ¸O\Şå‰Œ ½4µ¿\à\ğL/~\Âú\×Zl/ªk\×\ĞF“_\\¨,\Ç\ÙO\Ê?\0+é²¹}\Üú\ğxüªYÇ“\"\í\ìF3\ÏN•}#câ”œ§vv\Å\ò\ÓQ\ÊÍ‘Ê¬­‘\÷i“9ş\Z‘›r\í=)²¨^”h@\İ\ËII°R\Ç\óGš\n\æZ?\åh_—¥fEP»–’£¥\Ük \Ìn¤€[Iş\ÏJ\ñOŒ\Úi¿·”csµ\í®Z\Ô\çøº×šø\ö\Ç\í$\ås»­i	Xš\áÆ©#\ò¢¹ˆ$ì±©!zW¿j\ŞY1\ñ¼W­ø	¤˜–]ûº\ñ]\ÑBMÁ«\"u\\\íe9\ÏN\õ\õw\Ãû¸\÷.k\É|\ğ\çû>\çs\r­\ëŠ\ö\ß\0\é\æ\Ú8\÷-a)&nw6\ñ*®\ÜqS7\ÍÖ£µù£\ÍIÿ\0-1\\À›—šn\ãO\íŠ\n\æ#¥\Üi( 9‰7ÿ\0³Bş\óıšo˜È¤g-@s¡~^”\Ë<\ÑA$¶\ìU\÷­|5ûrÿ\0Á0\Û\Äß´F‹\ñk\á\í­“\ŞCî½£¶I\ØK\ó\ÜÛŸ»\Ê\r\İú\×\ÜK*¯Ju¿Û=I\ã?_~µ3\ãc¢nI\Æ}\ÌZË£j\×1È².\Ùv:·XÏ½fø¡f›Hv\Õ\ê_µæºg\í\âÈ¶*,—\ÈFÌˆORk\Ê\õ›Ü ]\ß(\è+\æq\Üe\ÊÏ¾\Â\Ö\ö°S—S‹M7²¤›™OPi¶ÿ\0e o/k(\Ú{WD\÷¥“´-¸¯\ŞùG5\Ë__}©–QµŠ¾+\é_ìŸ\Ä\í\çº\îUS={\×\ãIwpl­£ûDÕ¾j·\âFX?Fxø\Çü?º’\çÅŒ$’O-?\Ä+JtIU=SÁ‡\Âşpwš\ë\ï\àr+oS²¸K\îYZ¨\Ô\Ú\ÖÖ’F\×6İ™üjo\Zx¶\Æ=1­\í]gf\ë´\Ö1»\ìmR\Ñ\Ü\à|}\áŸøH\ô•º‡jÌ­¹€QÉ¯\'»\ğ\ÓË¨\É\æş\ïŒf^˜¯fÔ¼@\öŸ\ñê‘¿ü.§\å®G\Ä>»\Ö\ícI\Z0ı\ö\r³?z\ôd\ã¹\ã\Ê)\îx\íÆ‡ow3(–6)\×<n§i~·¶}¢5Qİœ}\ã]f«\à˜\ã\Ô‡\÷?\Ä?Š¢’\Â\Ş\Ò\ÅVk¨\ãe\éÒ»¥5\öLeE#3K´Y¤’4Û»9C\Ó·<1‘w!\ç9\Æ9¬\ôşÍ“\÷\İgn3+V\ÏY\Ò\ô´i\Zfo3¦?†°•\ØC•—¢}—E’I%]§¹<\×3¨\éy}\æ&|\ÏOş½C­ø¢\Îh¦\Ù\Èú£>7Vü,A©RÛ±gÁl•Ÿ±fœ\È\ä<Muq\á/ù»[l¾µ\é>\Z\ñ5æ©¦¦\õ2\×a¯?\ñş¯ˆ\Ú8\á]³Høb9È®\ç\áşqi§F›\÷_n¬\ëF+r°\õ_7‘­3\É\Ìv}\ïSI$O.£\Z…ùŒg­]\Õ-Á\÷mR\ÚV{\İ\Ë\'¾k\Ï\æ:}¢,\Æ\Şc‡–01]6‰²\Ö6BÛ·“\õ\ÌYÆ¶:\Ê-ÄŸ»=Lbº«k¨c“ÈG×­m\ZmœÕ´:\á=\ß\Æ\Ù\é6bc47I;LŠ|»V#œÿ\0s\ë\í_ø\'\çüúo€7Z‰¼E©Z_k&š\Ê\Ò\Ü!—i’By\Î;t\ã?±\Ï\Ã=k\â\Ş5­\Ô6:g™\ŞH\\\ï\ö…GB¾zv\Å~…øWOk+8ƒ\ò\Ø\Û\Ï<z}+Ø¥ƒ§~s\æ\ñx\ê—ä‰²\îd9jJ~Á\æb™]‡‘m\ÆùŸ½¦\åÿ\0È§yKœ\â“q Û•\r\ÚÔ­\óu¥\Üi*yL\è(\ÅT€v\ÅPŸ?J\ÌŠ( n4n4”WA˜^Ç­q$ƒ\Ï\í]­\â·\Ù[\æû½+\ÕÕ„\Ô\Î>‚­ÊµLøV2s\Ç\å]¶\Ï\Ê)$\Ò\öÿ\0\rW3\"9»MOÊ»k©\Ğ`\ò\0\ã§JŠ4ÿ\0v´\ì-6}\êDiÀ\Ûa§\î9\ÍELT”À)w\ZJ(\0¤\ÚÔ²ü½)w\Z\0J~ÁL§y¢€\ÛQE\0W½:\ŞP¿z¡\İO\Ø(\â?ø(n“ı‡ûA5Ò†\ê\Út[¿¼\ÊDl?0?*ù\ö\í\Í\ä˜\é_`ÿ\0ÁN¼3xk\Âş$ƒ\æ\Şytû†\÷“4yú#ş_\Ş\Ş\É¿v¾MªšŸk’Õ¾7\è[k¶†\Şe’5º\àu®K\ÄGo;HÛ£V9*u­…\Õ\Zİ£Y2b›ø\Èûµ‹­¤s¦\í\òH}\Åp\ò\äd™‹\â›Hï­–\ê·0\Ëı\á\\\äú¼>\ÔaºkvX\æV\Û\÷\ru\ñ:\Îqµ‚ggl\×\'\ñM{ı(\å\Ğ$}W?~»)•¤ş\Èıc\ö–\Ó4\Û_2\ŞH\äUd)\÷p^$ı¸t\ö¸Ÿ\Â> †>Ü–ß¹Vÿ\0w9¨\ôŸ\0[\ê›hzœg\ğ¯Z\ğ\Â-\ò\Ö;{¨¡–\ßn\ö,¼“\õ\ë]R§º9iºµ:cm\ñ‚ú\îÙ¯-gioº,Jş«ø\ÇVÕ¥dš\rbE	—Z\É!\Û\î^*øey\ğüÿ\0jiV\Ğ]i\ã\ï\Ä\0>]jü0ı£cÑ¯­\îš;M?Pµm…JW\á†\r8\Ê,\è£M¯ˆùb\ãâ¾Ÿ{u\ä}£Qm\Ã:\í\Ïû\'Š\É\ñ7‰\á\Ô\åÿ\0A‹P¿o™¶4o3\İ\Å}\ñ3T\Ñ|Mi}\"hşV¼—\Î\ÙmCkúƒ>ƒŠ\ò\íH\è\æb¶¶­j¶\çs²¦S\õ\ëùV±\×cªXX>§‰hšGˆ¼Fg’\ÓG}:\öfK™0c\Ï^;×¡\Çû;\ërh\ÆI\õ­<ùÉ’¡O\'\Ûû¿\ğ*\ëoüS iVB\âK–™S|h³•\Éø“\ÇzŸ\Ä\ï\ô-2\Ö\ãK±œbyˆ\ó>§­-Jt¡\æy¾³\ğ\Z\ß\Æ:\è„\ê\Í\r£\âW¶—‰Gù\ô§j_®4¯F¶\r\'‘œ\ò\ì\ÛOÔš\ö\Ù\ÙxcO\Ö\ÕcY?Û»U?k\Öze›\Åy—’}\àW¶g³‰\Äø3\Ãº\Ú\É1µ\ğœü\Õ\êÍª%˜\ò•W\ÃÖ¼\ßL³ûÄ—4Ö¿>\ô8\èkLø¯YY[i_½\Ír\â#r¨Ë“s¤¾\×ÿ\0´>B\ÈW\Ğ\Z} 4\×\İ)\ó\rs6\×¥\ŞÕ“szcŠ’[\÷ş\÷\é\\œˆ\è\æ:(u¥½¼¨ùW¡\ÖxnÁ¦\Ôk|§­p>ù®•~V\ë^\ãû3ü+½ø¿\ñ3G\ĞlşVÔ®V\0\ãŸ-G\Şs\í[Q‹g\"¦—?G\àŸ?	-|û6i:…\Ô+&¡­K&¡»nY#º0x\ìG#µ{²\ÄWş•‡£\Ûx_\Ã\Öz=X\ì´\ÈV\Ş\"£ ^‚¦i\÷}\Ú\ö\à­ZNRº¸\ç4”\ÍÆŸTH\ØØ´y¦\ÓÂ…£` ß•¢‰~^”P`GE?`\ó1L©\å\0¡?w\÷h¢³”Z\0¢Š*@Š]\ËFå®ƒ1“Æ­ƒú\×+¬\Ç\Åt\×R²\Ûg?{­s:\Çúú\n\å.\éZ\Z·5¨\ôªz?úš\Ñf-AR\Órº\Û\í\íSD­KJ¬Vƒ2XTy˜§S9§\ĞE»–€¾n´S73ú\0)6\nZ(w\Z_4Sj:\0’—q¤¦)ygX\ĞeÙ‘Tx´\É~\Ö³\ñ\ì¹\âHu«\ë]%.¢i\ô\Én–fºˆƒ\Õ\ä¶8=\ó_˜º½¬\È?y\òH²@\İ\0\õû\'ûvşÅ·µ\ì¡s\á\êC\Ãş.\Ól\ËèºŒ`(Šp9R…%\èHÁ^\ÄW\ãF‡§k–\ÚÖƒ\â­>\ãOñ—„¤:^·e.H¥Q–”ú\Æ\é\ó¡O¸³,;OœúŸ—¸\Ì\í^\äÊª¸ù[¨®sV\Ö$VY¬-\÷\\»]Uı³G$yùk™\ñ\r«)!¢\İ\İ[?v¼T}%9™3ø‡\Êu]±ü\Ã¢³<Iª}²\ÅZFYzI¨iøevÿ\0VOzÏŸË¸;—¯¡PV¥p¶\ğ%Ö¬\Ş|Mœ\íµl[jº†©µ»«F\Ì0¬\çN•k\Â\Ú\Ëh¶¯û¹<À»A\ö©µHWÄ±¹i?|¿\ê\Ø\ö®\÷cü¡}\ñ:ú\ÚŠ6i#^ŠqŠ\Ç\ñt\İoM_µi\ğI2œ–+\ÎkX\Óo4\ß1¤Ì‘\ã|Õ©fxYš2ºŸZ# ®\È\õ\İvy$\\\Ã À;uú\ç5—\'Œd¼\"¬fµ+İ…<\Çš \ÜÅ£;=j°»\óv6é‚·\ñ\Ë\Ít\ÃC.b´ú…¦—2ü‹\å/D}¿\äş4\ëoˆ7\é\ö{8\Ìv§øŸŠ\É\Õm­\ï1eûKš“I²š5ÁŒ\ãvq\Ô\Ìl–\ÅÛ¿\Ü\ÂÁ3\æ,¾\ïZ\êü\áø¯‡Ú¯¾\ô¿so;kÂS\Ô<\æ†\çË_”‚»+Õ“M±o³¨m½1Ú±\æ6–†\Æ	!·’{s¶1\÷°z\×\Ílw7\Í×š\Ó\ñ-Ä·PşúTw=\ë*\Ãu\Ño1F\Ô\ê3\Ôæ¯±1±¢jBK+;[ûÕ³n\Ëvùş\Z\æ4øw«¯½tº\Zo‹leI®hÅ²¹™\ÖxRÈÇ´\Ûsİ~Ÿÿ\0Á,fŸøW>º\ñÆ­n\ë¨\ë+\ä\é\ÑH˜h ş7\ÇL·®2;b¾Wÿ\0‚{şÅ·¿|cm«\ê\Ğ\\G\á=2k”P>\Òÿ\0\ó\î?\ÚúW\êÅ½²\Ú[CQ,pÛ¢\Ç\Z\'Ê¨«\Ğşs^†‘\á\æ­9\"8¶\á}ß\"¨^”´Wqã‹¹h\Üi»-û6.\ãF\ãIEœ¨\æ\ëE3q£q \ÏÙ°\ÜsšJ( ‚?7\Û\ô©%ùzQ\Şb†ùº\ÖR•ÀM­E;q¢ \n\ÔQEur“\ÊE:³&\Ş\Õ\Îkë«¥,Z\'\'ª\ô®kXÿ\0Š’‹š?úšĞ¬\Í!\Î\Õ\Ş\ëZtP(¢ŠI\åûÔ»F\Î[­>€W+Ò’šÒ«u£\Í\0\îù¥\Üj(Ü´˜©(w\Z7\ZO\ã\Ï\ğúQ@¸Ó¶\nn\å¥\óEr‰¸\×O\ğsÃ«âŸ‰6\nËˆl€º“\Ğ\ã 5\ÊJ\åzW²ş\Í\Şş\Ì\ğı\ö­·s\ŞK\å\Ä\Çû¾µQ‹{z6©­\Ûi\ä)ı\äœ\÷=ÿ\0\ÏN‚¾ÿ\0‚–~\ÈV\ßµV\ñÆj°x²\Z;¿-6®±œ¬rv2\Ç•\ö5Í»Kz\ì\Ù,:f¹¿\él²ue\ä!a\ÏBzŸ¯½kZŸ<yM¨\ÍÓ—1ø¯À\×Aƒ.É¡mMr>!ºkT\ó\İı\ñ\ë_oÁD¿d\æ\ğ\õ\ë|@\ğÍ§ú,­³V´O\î$ÿ\0 \Ï?¥|]®\Øù\ñ>\Ø\÷Iü@×:<»Ÿ[…¬ªG™†µ5£y»·\Ë\ò\éXq,p]y\ÛF=+fşÙ”\È\æû\ÛFk\Z\öÅ¢¾Xü\Í\Âoºq\÷k?d\Î\Ù{§Am§,\Öu¾j\É\÷£CÒµ´\ßï¹¤qû\"¸\í>\îm6\éB\ñŸ\ë\0\è\Ã\ğ®\Ş\Ñ\ãš\Ú97m›\×9ÿ\0\ëT\òHºRL§\â?y’™™Š‚û\Ê\õ¨\áø]g®Æ›K•a‚\Ö\á\ÕR\ã\Ë2\í\òşv søUu\ñWÙ¬š‘um\Ã\nx5Ù¿³G!}\ğUašnŸ/\Ş95™y\ğ‹Ê’I~V‹¸ü\Õ\İ\ë>\'‘l²»d[\õ½¼º\ä\'\ñ’\0Ñ´Œ»zµ\\\ÓXıÇ€vMû\Ï%\×\ÑC}¡-®\ï&0w&\Åú\×AgvuX\÷G´G\ë\Ğ\Ô7S¥\ÅÁ\ó¶\Ç\r¹\ÜX¼k_h\Ìù`C¤•\Ğt•W‘|\æ9)¦²üA¬yN_l*\İ56¹\â{Y.Y”(E\è®1Š\ä\õÿ\0U—*6¯A•|§I#\'^’;\Å]ˆŸ¥P#Ê5\Ús\õ«\òÿ\0¦M\ß\á\é\íV”·#Û¥m\Ês\ótû¹fUi°\ßwÚ¾‚ı?gY>3|Z\ğ\ï‡\æ\ß:µ\â\Ã4\è™\ò\Ô6X\ãı\Ú\óÏ‡\Şkûˆ\ÚBÊ¾\õ\÷Oü\ÂQêŸ´[N«û¿\é³ÜŒ}×‘“b\ç\ß5T\à¯\Êcˆ­eÌ¾|\ğ\÷IøW\à\Í3ÃºŸ\Ø\ô.?.<`I,Ÿ\óÑ½[\Ü\äÖ¾\êz VfÀ\Ü\Ãi•\èY-™©\')s1w\Z}GK¸\ĞHú#ù¤\Å3q§¸\ò\Órı\ê\rùPK\ò\ô¢†ùº\Ó|\Ñ@r¡7-%#(o»M\ÜhTKŸ\öZfÖ¦bæ·­~Í\ïš?ƒ\Å\ëE1\\\Êû¾é£•³c\è¦n4QÊ‡\ì\Ù\r\ó}\Ú(_—¥W10Ha8ş.µ\Ë\ë\ëë¦™“\\Î·\Ãf¤¢Æ‘ş«?\İ\éZ;e\énV\ß\ïVš(\õ¸Ñ¸Ñ¹i?\å¦(#”Xœ·Z“q¨—\å\éK¸\Ğ£¶\n6\nO4Rn4(\ñ\òœ\Ò\î>f*=Æ\Ç9 9I7›{Q¸\Ó<\ÑQ\Éu\å³}İ­\÷KuG]‰$\óEh«\ğf­\ãiviv7\ô\Ğ.\Èÿ\06¯F\ğ\ï\ì©y:,º®§¾z\ÃnıMW++˜\ò‰&‘Âª…i¶\0}k\êh±øWÁz~œ\Ó\r¾\Ígøs\à_‡ü%¶o³KwqoY\'}\Ø?A\Ç\é[Z\Åü{\ğË»ŒVĞƒ\ä\ÇSb\Şq9û\İx¬Ÿ~ÿ\0o\Ë\÷†½lM \ój¾£\İ\Û,ˆ6ã «\åFşÍW«\è±\İ\Í=´°\Çs\r\È\ò%Y2ºtƒ\Æ+\ó·\ö\ìı‡/>	jø«\Ãq\É\àû–9}1‡E~¤\Çş\Ñ9\÷¯\Ó={Lù³“œ\çX\Z•Œ7Z}Å­\å¼w])I¢•C$ªz†SÁ®J\Ô\ã-š5¥	i±ø‡u§C3™#def\ÚBŒ\í?J\ç\ï\ô%U„rn^†¾\Ëı½`»Ÿ‚v7:\ğM­\Å\÷†ùÚŠd›J>£©‘=Á\Í|…§ø¿G\ñ<m¯‘ƒ*\Ë `À}\â¾şÆ¼Úp\ÜúL=eS©\Ê\êzdšd›ù0Iü_İ«\Ş\×\ífy#\Ê\ôbksYÓ¡hY|\Ån¤?J\âu½M1\÷[¨S\ê9¬e:Ÿ\Êo\ëlÓ®Ì†\È\ÆÁÒ¹‹­R\âX¤A7\Ï+\áw\ÜØ¾ ‹HV•g\Û\÷‰ª\â}4œ¬ŠªNvû\Ôr¢ı»,\êz\Ä\Ñi\ñB\ó£\ÉüL€\óY¦\ç\Ì%\ã`\ó¨E\Züw\r¼©·ø¾nµ’\óıšf\'$·\İ\ÅiÊ=²\îiO\âO±\\|„‡ş\à\éXm\â[‹\ÙNC.\î¹=j­\õ\ê\Ù>\éxZ¡7ˆ¬D¿¼›\ò­=‰\É\ífId–\ì³|Ñ·PMg\êz³C\ÕÛš£q\âv™<»u\Û\÷Ş£µ¶k–F*\Ì[¯5¯*\"Wf\öŠ\ÆGŒ\"ü\Õ\Üx_\Â\Ítşl\Òm_B1\\\ï…\ì#²˜Iq…\Û\ĞWgeªµÜ›¶…Ò‰F\Æq’gS k)br\Ê\Åü8û\Õúÿ\0j\ğ´w>\ñÖ¹°,³M\r²\åC;6?+\ó£LŒ\êS©\èW¥~Á\"£M\áÄ–r+Dn¦³ÿ\0-Õ†\rÿ\0}ı*i\Ô^\Ğ\Ç©ŸS\ì_\Ô->\Ët\ñ¯Ë·¡\âªr¨^•\è:2Š( ”¹aŠJ(4\æB\î4İ‚–™¸\Ğ_*r½)(¢‚9Q\ÍÖŠ VİŸ\á 9»#|\ÔQı\ïn”2\n*?7\Û\ô¢€\æˆQE\\¦<¢\rs\Z\ïú\ÌWQ\'\Êw¥rú\Ï\Í5IB\é.Z=\İ\ëK`¬\ÍıMj\îZ\0J]\Ç9¤¢€%fS\÷i*5ùzS¼\Ñ@°Sw\Z_4TJ\æIv¯\ÌŞˆ3DuØb]\çû´fm»Y[Ğ‘]—‚~\ë^(™\â3ejz\É\'Z\õÿ\0|Ğ¼-\Èm–\ò\é~\ô“gùt­£E°\æ<3\Ã?uŸ\\\"\Ù\Ù\Ì\Êz´‹\å\Çùš\õ~\ÍvZ[\ÃsªHn.\ïBbü\ë\Òl¦†T\ò\â\Ã*ûqR\Ü\Ü-¼[\÷~´)\Ûs?$D‘\Û\é‘yiP§\÷TmF}fIï¡¶6\êkÅ—²%Uº\óV´F-»\÷\0½£CodÍ«©¡’	¡…\ñ,xX·\Ìc›n\İ\Ş\õSSÕ¬ü%¯Cv­$\ê{–c\ÄEº?\ĞV®¥‚\á£P\İ7.\î„}ir¢`¬d˜™hx\÷\Æû‡¥X\òÏ™ŠfGf\ëG*6\æF·iµ2Ww\á\\¶·b\×/»Mw7\ö\Í À¬}NÔ·j\ÏÙ²ùQ\Å\ÜYª\Å\"I\Z\É‹±\â#\åe\ôÇ§µ~;ÿ\0Ádÿ\0\à”\Z—ÀY\õ?Œ	b½ÿ\0„f\àı¯\Ä:²–} ÿ\0Å¸ù_\ßA\Ê\ö\Å~Õ®”·Sn\ëøT²x\"\ÏV³¸³º·{[¤h\æ‰ùY¾\ğ#ß¿¯zÏ–/sZsq\ØşS|û[\ë^VwP„‚Ì„\î\Ê/\Ş*ÃŒû\Z\ôo~Óº/‰­w\\<–\ÓrN+\Ü\à¹\ğG\íK\ö+ø‘u\ã\ï\és7Â¯\Î]Œ@˜´;†ÿ\0Z¬¼í…¿€\÷¯\Ï·0>n<\ÈWÛš\æ©«–\ç\Ôú¦»c¯D²[\ÜB|Ï¼29®CW´Pû¡™Y½š¼^\Ì\ŞZ\ĞM#F½\óZV\"\Ô-$`$f\İ\÷{\×/³Ge¤z\Ğ\İA~\òc»®3UX¼iW7|½+\Û\Æw’4ŒG\ĞT\ñj\ó2n\ò\Ó?Z®TE‘¡2\Ü\\.×šF\íSZi*[$°úŒ\Ö|7\Ï4yû¿…XI&”ni—ıƒZr•Ì;m>;GÂ·„\çùÖ½½\âÛ°Xú¯z\æšmÿ\01‘«OF•Xav\Íşé©–…F\Ïc¯°g’dv}\áº\×_¢ º‹jü«\éš\ât[kˆUTùq„\ë\Îk²\Ñn\İpÏ¹¾•\ËRfĞ£c¬\ğ\ì~M\Ï\Í\ÇÒ¿Xÿ\0c?\Í\à?xG\í\òı§y-\ò\ã\æ|H?¯ÊŸ\0[­R\Ö6?\ë¦D$\÷­~\Õü6\Ñ\Õ>xn\öDP\Ö\ËlÊƒø@MŸúız0>\õG\äq\ã\ä”lw3 \Õ-Û\ß[\ô\ÏzÈ‘¿Ã¶¯]M&Ÿ¬G*·\Êz\ñK©¢ùŠ\Ê1t\ë=\ìÙ•*ªÿ\06¦™ùü´\ÅQ@\Üi(¢ƒ~TQE~Í…5ee] \ñN¤\Ø<\ÌPD´\Üv\å¨\÷}úÓ¶\n6\n\0\\QL\Üh ®FG¸\Ò\óı\ê‹q¤V\ÛZ´$šf>Y?\Ş\ë\\Î¹\ò\Í]¹’+š×¤>lŸ\ì\ô¬\É\æ$\Ñş\î+Gr\Ö^Æ´7-n4n5“\í¤•™²ª\ßw$dPO1c\ÍGHÈª\Ê\Ìz\Ö×„ş\Z\ë.dk}:\é¢n²\Ù\ë^µ\àÏ€ºn‹µµP¼#‹\ä\ó\ëZ{6Ç•øC\án±\ã{\Ï.\Ê8\Ö5ÿ\0[,¹TJ\÷/†\ßt¿[,Œ¢\ò\ñº\É2ÿ\0NŸ¥u:~Ÿk¥\Û\äG*\İPøTZ\å\ğ‚\ÜVe95\Ñ\nv$¾’´ƒ…»R]¡–	8cYZ4——)\ç7\îmÿ\0\Ú\ëW5Mb\ÂK‰¤Æ£s>`=‡\ñ~qV\ÜC4yM¼ÿ\0go\õ˜¬û«‰g\Ô$2¤1ÿ\0ˆß‰\æ¹ÿ\0x“V›CmKOX\í˜Æ–Q\ô5\æZ—ˆ/¼K¨[¬<¹|:»¤}:R”’.1¹\İø·ÇšwŸ\å\rJİ–.\ñfMß«\Ş\Zø—gu§¤:l3\Ş\ç­\Ä\ë\äB\àm\Çş;\\’×­¯-­œ›U:²¨Òº+³-\çE½\Ìp\ŞB±q1N\ï\Ã2:9K\Z¯‡\ì<g¦]Xêš„—1\İDa\Ûf<¸\âcÕƒ}\ïÖ¤ø[\â‡\Ôa»\ğ\íı\ÃM¬øm–•\ğ>\ßnÿ\0\ê\ç\ì8 pc§¹4V¶\ök6Ñ«(À-Àü«ø—m}\áÆ²\ñ6o»R\Ğ\åı\ä+\Ö\ö\Øıø\Ï\ã\È\î#®\È\ÏÙ³Ñ¤²e9\ïD–«u\'mü*ok\Ö~6\ğå«¦\Ì.,uRh$\î\ë‘\ê=)Xyg%y£•g][2t¬\İGMÿ\0WF\Ğ}¡2~Z¨šZ¯\Şj9Q§29ø,¼\Å\İÊŸ­*+Fr+J\î\r£	\ò\Õ#Ú³\öl¾TV\ñ„4O‰\Ô<7\â.\ÓV\ÑuHZ«K¤\ó\"™¨\Çlv#{b¿ÿ\0\à®\ğDıC\ö#\Ö\î<]\á8\î\õ¿…z”\í\ä\Ì\ë¾}	›¤7? ş	ww&¿~mX\Æ\ÛOJˆ<9¥ø\Û\Ã7ú½ck«hš¤\rkues’¢n¨W¦o\î\ö\Å§raZQ\Øş>\õ_5–¡û‰\Z/\Ö?ÖªÅ¤\ÜYÊ¹…[oMŒM~›Á\\¿\à\Z—\ìq\â+x>\Ú\ïXøc}6\ŞI¡?ü\ñ›©1ÿ\0\ÓCšøF_\Ç)ıÒ¨\Ü0¥dŸq^eOs\â>„£V<\Ñ8xt\Ç\òÜ¬w¥i[\İ\Ë6úŒWK*¹]»T\õ\â¯7„¡\ÔiB¿&r9¬eY#£Øœ–›l—Ï·\ËÀ­¨4T’Pª¡ºãŠ³k¡®Ÿp\ñ\í,\ËüB´¢\ğ\ô—²\Û\÷¸©\ö\è¨\ĞlÌ‹B·1•\Ø\Ë\ê¹?5ih\Úo–wG\nG\÷€«~’\ÒVuÌŒ	\íZ\Zf‰\"œN\Øo\îGÒ³•dúšÂ…‰4\ëˆá¶©m\İx®ƒD‡yI\å\ÏPj¾c˜\Æ\ĞjI¯¾Æ‚L\ãoJ\ãu¶:yQ\ÓxW\Ä_a\ñ~ƒc\Æ\ë‹\Ø\ãQ_ºŸ³\Ómü³\Ş\Şa\İv‚:m\éùW\ó\Ç\á­\×\í#\à›bÛµ Ç¤t¯\è\ö@\Õ¼in\í˜\Ú,\í^†_¥)>§\Ïf¹\ß\Ü ¸ŒgŒt\ÍO \é‹\âK¥Ó¾Ğ¶\ó\Éÿ\0\ÆD ~55Õ¬k7’\ËÏ®j‘¡Ÿ\Ìı\öW¡\î?\Z\õ™üI \ŞøZ\ğZ\ê5¼\Í\÷OU—ı\ÃŞ³¼sŠ\ê\ìş#<šÜšOˆYu\å]\ã\ÚBÿ\0²Ë‚?(\ñ7\Ãi\ì\ìÿ\0´ty›T±ßµ\ãÀÀ=\\Pfq\ôTˆc˜\íUe\öfÄŸ—Jl‘• h§\ì^h\Ø(4\æC(¢Š\åAK#*œ\ÒR2†\ëA‹b\ÑEÙ±\ŞRúQM\Ëÿ\0‘EO1Zw\Ñ$›\Æ(¢¶2$\\,\\\n\æu\áû\Óş\×Z(¬\Ì\Æ\éo¶®†Ü¨yº\ÑE†¯\Ã\ßI\ñ+^û\r´‘Ûø\ó%\É\ã\è?Æ½\ï\Â?\0´¼r\\BÚ\Ñ\é,\ß\Ãÿ\0/\æ(¢ºÎ¢\ïQk‚ …V8\ÇA\Û\ò«–\Úz\é\Ñy’~ù½è¢º¹Pµ{†»„\È\ßu:Ş¬no\ìûv\È\ò\å\ê\0\Ã\Ï4QRq\ñq\íuf\Ñt\Û]\×\r\ÒK§\Ìkÿ\0şµ—®øhüAš¬\÷:„Ë±\çŸTş™ QE\0tV±}·O\òÁÿ\0q·-\É\"¼\ßÄ‡û.ÿ\0rª\ïß»=(¢±¨mH\Ş\ğ¦\ëunù\î:}\ÚÕ’I­\ÚYw/\îz\áFMV&¼¨\èü·X\Ò\Zy77 \'¥bk²ªIÍ³?ï®´Q[\ò¡-\Ù\Å|\ñ<Ÿş5j	]\Ói\Z\Ô-¬\Ø\Ö\É\Ëm’?\÷¯|\0½®\å·uşTQE‘‰^k–\Û\íP5\Ùi9¢Š9P\î“l|uª\ñ¦\ê(£•\ò¡¾NNi\Ñn#¢Š,Œ\Óüw\á[\Í\'W³·\Ôt\íB\"\æ\Ú\â1$s\Çı\Ö¨\ö¯ÁŸø+ükIıŒş%X\ë\Ş¼¼)\ã+™#´\Ó\ç\Üg\Óe\ï.\ì|\ñŸ\á%·ù¢Š\ä\ÅEKs\Ğ\Ë\êJ2²>8¼‡s7\'r¶9\Æüº\Ô6\Ó\ã\ä;¶\ã\Ïj(¯¡\õ\ÖEØ™`b\ÛU™º’*\í´˜|ş\ÔQ\\|\ÌÖšEÜ¯<}\î´\è:…W)©j6\Ì/\Ë\\\ï5\ì\İ>nl\é\íE\ÑL\Ã¦\Çû0\\7‹ÿ\0l\Ï\Ã.Z\ñ\İ\Ù\Âd~µı~\Í> ml#*d“iQE\ï`R>k{¶¿G;:¶8\È\ã¥Q\õš¯–¢Š\ê<2\èË©\é\ñ\Ü+2Mn6–\Éù…_\ğ\ß\Ä+é­«F¾t6¿¸¾·c\Ä\ëê§®~´Q@Ÿ‚¼?\ñÁnO\òZe\á‡\ÊÑŸluük…\ñ\ÏÁ\Ù4ü\ëK\ß1»2\ãù\n(®u8q\è›oİ\×\ï7\Ô\ôı)6\n(®qŒ\òi6\n( ß•§\ìQ@r \Ø(\Ø(¢€\åBa¨¢Š\Ì\Èÿ\Ù',0.000,NULL,'2024-01-04','2025-03-02',NULL,1,'2025-03-04 11:35:24','2025-03-04 11:35:24',0,0,145);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_rates`
--

DROP TABLE IF EXISTS `exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_rates` (
  `exchange_rate_id` int NOT NULL AUTO_INCREMENT,
  `from_currency_id` int DEFAULT NULL,
  `to_currency_id` int DEFAULT NULL,
  `exchangerate` decimal(10,6) DEFAULT NULL,
  `valid_from` timestamp NULL DEFAULT NULL,
  `valid_to` timestamp NULL DEFAULT NULL,
  `conversion_type` varchar(20) DEFAULT NULL,
  `provider_id` int DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`exchange_rate_id`),
  KEY `from_currency_id` (`from_currency_id`),
  KEY `to_currency_id` (`to_currency_id`),
  CONSTRAINT `exchange_rates_ibfk_1` FOREIGN KEY (`from_currency_id`) REFERENCES `currency` (`currency_id`),
  CONSTRAINT `exchange_rates_ibfk_2` FOREIGN KEY (`to_currency_id`) REFERENCES `currency` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_rates`
--

LOCK TABLES `exchange_rates` WRITE;
/*!40000 ALTER TABLE `exchange_rates` DISABLE KEYS */;
INSERT INTO `exchange_rates` VALUES (200,30,31,0.941300,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(201,30,32,0.817500,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(202,30,33,1.452300,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(203,30,34,1.357200,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(204,30,35,137.680000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(205,30,36,6.450000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(206,30,37,0.926500,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(207,30,38,9.560000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(208,30,39,1.350000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(209,30,40,18.070000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(210,30,41,5.340000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(211,30,42,14.540000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(212,30,43,3.750000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(213,30,44,75.340000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(214,30,45,74.550000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(215,30,46,1174.900000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(216,30,47,1.350000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(217,30,48,7.850000,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(218,31,30,1.064500,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(219,32,30,1.222200,'2025-03-04 11:58:38','2030-12-31 00:00:00','fixed',1,'active','v1.0','2025-03-04 11:58:38','2025-03-04 11:58:38',1,1),(220,30,31,0.941300,'2025-02-27 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(221,30,31,0.941300,'2025-02-28 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(222,30,31,0.941300,'2025-03-01 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(223,30,31,0.941300,'2025-03-02 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(224,30,31,0.941300,'2025-03-03 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(226,30,32,0.817500,'2025-02-27 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(227,30,32,0.817500,'2025-02-28 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(228,30,32,0.817500,'2025-03-01 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(229,30,32,0.817500,'2025-03-02 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(230,30,32,0.817500,'2025-03-03 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(232,30,33,1.452300,'2025-02-27 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(233,30,33,1.452300,'2025-02-28 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(234,30,33,1.452300,'2025-03-01 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(235,30,33,1.452300,'2025-03-02 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(236,30,33,1.452300,'2025-03-03 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(238,30,34,1.357200,'2025-02-27 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(239,30,34,1.357200,'2025-02-28 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(240,30,34,1.357200,'2025-03-01 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(241,30,34,1.357200,'2025-03-02 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1),(242,30,34,1.357200,'2025-03-03 00:00:00','2025-03-04 00:00:00','fixed',1,'inactive','v1.0','2025-03-04 12:03:43','2025-03-04 12:03:43',1,1);
/*!40000 ALTER TABLE `exchange_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_company`
--

DROP TABLE IF EXISTS `group_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `legal_entity_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `legal_entity_id` (`legal_entity_id`),
  CONSTRAINT `group_company_ibfk_1` FOREIGN KEY (`legal_entity_id`) REFERENCES `legal_entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_company`
--

LOCK TABLES `group_company` WRITE;
/*!40000 ALTER TABLE `group_company` DISABLE KEYS */;
INSERT INTO `group_company` VALUES (2001,1001,'Opera Group Holdings','Opera Group Holdings is a diversified multinational entity','2025-03-04 13:45:20','2025-03-04 13:45:20',0,0);
/*!40000 ALTER TABLE `group_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_attributes`
--

DROP TABLE IF EXISTS `item_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_attributes` (
  `attributes_master_id` int NOT NULL AUTO_INCREMENT,
  `item_id` int DEFAULT NULL,
  `attribute_id` int DEFAULT NULL,
  `attribute_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`attributes_master_id`),
  KEY `item_id` (`item_id`),
  KEY `attribute_id` (`attribute_id`),
  CONSTRAINT `item_attributes_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`),
  CONSTRAINT `item_attributes_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `attribute_definitions` (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_attributes`
--

LOCK TABLES `item_attributes` WRITE;
/*!40000 ALTER TABLE `item_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_image_mapping`
--

DROP TABLE IF EXISTS `item_image_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_image_mapping` (
  `mapping_id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `image_id` int NOT NULL,
  `image_order` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mapping_id`),
  KEY `item_id` (`item_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `item_image_mapping_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `item_image_mapping_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `item_images` (`image_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_image_mapping`
--

LOCK TABLES `item_image_mapping` WRITE;
/*!40000 ALTER TABLE `item_image_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_image_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_images`
--

DROP TABLE IF EXISTS `item_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `image` mediumblob NOT NULL,
  `image_type` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_images`
--

LOCK TABLES `item_images` WRITE;
/*!40000 ALTER TABLE `item_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemcategory`
--

DROP TABLE IF EXISTS `itemcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itemcategory` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1',
  `tax_information` varchar(50) DEFAULT NULL,
  `default_uom` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1033 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemcategory`
--

LOCK TABLES `itemcategory` WRITE;
/*!40000 ALTER TABLE `itemcategory` DISABLE KEYS */;
INSERT INTO `itemcategory` VALUES (1001,'Car Interior','Products related to the interior of cars, including seats, dashboards, and upholstery.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1002,'Tyres','Rubber components that provide traction and cushion for vehicles.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1003,'Car Body Parts','Exterior parts of the car, such as doors, bumpers, and hoods.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1004,'Engine Parts','Components of the carâ€™s engine, including pistons, timing belts, and crankshafts.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1005,'Transmission','Parts related to the vehicleâ€™s transmission system, including gearboxes and clutches.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1006,'Braking System','Parts related to the vehicleâ€™s braking system, including brake pads, discs, and calipers.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1007,'Suspension Parts','Components of the suspension system, such as shocks, springs, and control arms.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1008,'Air Conditioning Parts','Parts for the carâ€™s HVAC system, including compressors, condensers, and evaporators.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1009,'Lighting & Electrical','Lighting products like headlights, taillights, and interior lights, as well as electrical components.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1010,'Car Audio & Electronics','Products related to the audio and electronics systems inside the car, including speakers and wiring.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1011,'Fuel System','Components of the vehicleâ€™s fuel system, including fuel pumps, injectors, and tanks.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1012,'Wheels & Rims','Wheels and rims used in cars, including alloy rims and steel wheels.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1013,'Windshield Wipers','Parts for the wiper system, including wiper blades, motors, and arms.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1014,'Car Batteries','Batteries that provide electrical power to start the car and run its electrical systems.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1015,'Exhaust System','Components of the exhaust system, including mufflers, catalytic converters, and exhaust pipes.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1016,'Vehicle Accessories','Non-essential products that enhance the vehicleâ€™s functionality or appearance, such as floor mats, seat covers, and window tinting.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1017,'Car Tools & Equipment','Tools and equipment designed for car maintenance and repairs, such as jacks, wrenches, and diagnostic tools.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1018,'Auto Paint & Finishes','Products related to painting and finishing the vehicle, including paints, coatings, and finishing products.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1019,'Vehicle Safety Gear','Safety products such as airbags, seat belts, and child car seats.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1020,'Car Cleaning Products','Cleaning products for car maintenance, including waxes, cleaning sprays, and polishes.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1021,'Car Performance Parts','Parts aimed at enhancing a carâ€™s performance, including turbochargers, exhaust systems, and cold air intakes.',1,'Standard','40','2025-03-04 14:57:53','2025-03-04 14:57:53',1,1),(1022,'Desktop Computers','Various desktop computers for home, office, and gaming purposes',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1),(1023,'All-in-One Computers','Space-saving all-in-one desktop computers',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1),(1024,'Gaming PCs','High-performance desktop computers for gaming',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1),(1025,'Workstation Computers','Computers designed for professional use and heavy workloads',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1),(1026,'Mini PCs','Compact desktop computers with essential computing power',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1),(1027,'Tower PCs','Traditional tower desktop computers with customizable options',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1),(1028,'Laptop Computers','Portable laptops for personal and professional use',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1),(1029,'Ultrabooks','Lightweight, high-performance laptops with extended battery life',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1),(1030,'Gaming Laptops','Portable laptops built for gaming with high-end graphics and performance',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1),(1031,'Business Laptops','Laptops designed for business professionals with enhanced security and productivity features',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1),(1032,'2-in-1 Laptops','Convertible laptops that can be used as both laptops and tablets',1,'Standard','Unit','2025-03-04 15:07:32','2025-03-04 15:07:32',1,1);
/*!40000 ALTER TABLE `itemcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `item_code` varchar(50) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `category_id` int DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `stock_quantity` int DEFAULT NULL,
  `min_stock_level` int DEFAULT NULL,
  `max_stock_level` int DEFAULT NULL,
  `reorder_point` int DEFAULT NULL,
  `lead_time` int DEFAULT NULL,
  `shelf_life` int DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `notes` text,
  `default_uom_id` int DEFAULT NULL,
  `expiry_date_flag` tinyint(1) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `is_serial_controlled` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_code` (`item_code`),
  KEY `category_id` (`category_id`),
  KEY `default_uom_id` (`default_uom_id`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `itemcategory` (`category_id`),
  CONSTRAINT `items_ibfk_2` FOREIGN KEY (`default_uom_id`) REFERENCES `uom` (`uom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000064 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1000001,'CINT001','Leather Car Seat',1001,199.99,'AutoLeather Co.','123456789001',50,10,100,20,14,36,'Aisle 1','Interior','High-quality leather seat',40,0,NULL,0,'2025-03-04 15:02:49','2025-03-04 15:02:49',1,1),(1000002,'CINT002','Car Dashboard Kit',1001,79.99,'AutoDash Inc.','123456789002',100,20,200,50,7,24,'Aisle 2','Interior','Complete dashboard kit',40,0,NULL,0,'2025-03-04 15:02:49','2025-03-04 15:02:49',1,1),(1000003,'TYR001','All-Weather Tyre 195/65R15',1002,59.99,'TyreTech','123456789003',200,50,500,100,14,48,'Rack 1','Tyre','Durable all-weather tyre',40,0,NULL,0,'2025-03-04 15:02:49','2025-03-04 15:02:49',1,1),(1000004,'TYR002','High-Performance Tyre 215/55R17',1002,99.99,'SpeedTires','123456789004',150,30,300,75,7,36,'Rack 2','Tyre','For high-speed performance vehicles',40,0,NULL,0,'2025-03-04 15:02:49','2025-03-04 15:02:49',1,1),(1000005,'CBP001','Front Bumper for Sedan',1003,249.99,'AutoBody Inc.','123456789005',50,10,100,20,30,60,'Aisle 3','Body Parts','Front bumper for sedan model',40,0,NULL,0,'2025-03-04 15:02:49','2025-03-04 15:02:49',1,1),(1000006,'CBP002','Rear Bumper for SUV',1003,279.99,'CarParts Co.','123456789006',30,5,60,15,30,72,'Aisle 4','Body Parts','Rear bumper for SUV model',40,0,NULL,0,'2025-03-04 15:02:49','2025-03-04 15:02:49',1,1),(1000007,'ENG001','Car Engine Timing Belt',1004,49.99,'EngineParts Co.','123456789007',100,10,200,50,21,48,'Aisle 5','Engine Parts','Timing belt for engine',40,0,NULL,0,'2025-03-04 15:02:49','2025-03-04 15:02:49',1,1),(1000008,'ENG002','Engine Cylinder Head',1004,399.99,'AutoEngines Ltd.','123456789008',20,5,50,10,60,84,'Aisle 6','Engine Parts','Cylinder head for engine',40,0,NULL,0,'2025-03-04 15:02:49','2025-03-04 15:02:49',1,1),(1000009,'MDL001','Toyota Corolla 2023',1003,22000.00,'Toyota','123456789015',10,1,20,5,0,365,'Car Showroom','Model Item','Brand new Toyota Corolla 2023',40,0,NULL,1,'2025-03-04 15:02:49','2025-03-04 15:02:49',1,1),(1000010,'MDL002','Ford F-150 2023',1003,35000.00,'Ford','123456789016',5,1,10,3,0,365,'Car Showroom','Model Item','Brand new Ford F-150 2023',40,0,NULL,1,'2025-03-04 15:02:49','2025-03-04 15:02:49',1,1),(1000011,'CINT003','Leather Steering Wheel Cover',1001,49.99,'AutoLeather Co.','123456789017',150,25,250,60,14,36,'Aisle 1','Interior','High-quality leather steering wheel cover',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000012,'CINT004','Car Seat Cushion',1001,39.99,'ComfortCar','123456789018',120,20,200,40,14,36,'Aisle 2','Interior','Comfortable car seat cushion',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000013,'TYR003','All-Terrain Tyre 265/75R16',1002,89.99,'TerraTires','123456789019',180,40,400,90,14,48,'Rack 1','Tyre','Durable all-terrain tyre for off-road vehicles',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000014,'TYR004','Snow Tyre 205/55R16',1002,105.99,'SnowTires Inc.','123456789020',100,30,300,80,7,36,'Rack 2','Tyre','Snow tyre for winter conditions',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000015,'CBP003','Side Mirror for Sedan',1003,129.99,'AutoBody Inc.','123456789021',75,10,150,35,21,48,'Aisle 3','Body Parts','Side mirror for sedan model',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000016,'CBP004','Hood for SUV',1003,499.99,'CarParts Co.','123456789022',40,5,80,20,30,72,'Aisle 4','Body Parts','Hood for SUV model',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000017,'ENG003','Car Engine Oil Filter',1004,9.99,'EngineParts Co.','123456789023',200,50,500,100,7,24,'Aisle 5','Engine Parts','Engine oil filter',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000018,'ENG004','Engine Piston Set',1004,199.99,'AutoEngines Ltd.','123456789024',25,5,50,10,60,84,'Aisle 6','Engine Parts','Piston set for engine',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000019,'TRA003','Manual Transmission Fluid',1005,12.99,'TransTech','123456789025',250,60,600,150,7,24,'Aisle 7','Transmission','Fluid for manual transmissions',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000020,'TRA004','Automatic Gearbox Oil',1005,99.99,'TransParts','123456789026',100,30,300,75,30,60,'Aisle 8','Transmission','Gearbox oil for automatic transmissions',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000021,'BS003','Brake Caliper for Sedan',1006,119.99,'BrakeMasters','123456789027',80,20,160,40,14,36,'Aisle 9','Braking System','Brake caliper for sedan model',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000022,'BS004','Disc Brake for SUV',1006,149.99,'AutoBrakes Co.','123456789028',60,15,120,30,14,36,'Aisle 10','Braking System','Disc brake for SUV model',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000023,'SP003','Strut for Sedan',1007,199.99,'SuspensionParts','123456789029',90,20,180,45,21,60,'Aisle 11','Suspension Parts','Strut for sedan model',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000024,'SP004','Suspension Arm for SUV',1007,249.99,'AutoSprings','123456789030',70,15,140,35,21,60,'Aisle 12','Suspension Parts','Suspension arm for SUV model',40,0,NULL,0,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000025,'MDL003','Honda Civic 2023',1003,22000.00,'Honda','123456789031',8,1,15,3,0,365,'Car Showroom','Model Item','Brand new Honda Civic 2023',40,0,NULL,1,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000026,'MDL004','Chevrolet Malibu 2023',1004,25000.00,'Chevrolet','123456789032',6,1,12,4,0,365,'Car Showroom','Model Item','Brand new Chevrolet Malibu 2023',40,0,NULL,1,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000027,'MDL005','BMW X5 2023',1005,55000.00,'BMW','123456789033',4,1,10,3,0,365,'Car Showroom','Model Item','Brand new BMW X5 2023',40,0,NULL,1,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000028,'MDL006','Mercedes-Benz E-Class 2023',1006,60000.00,'Mercedes-Benz','123456789034',5,1,15,4,0,365,'Car Showroom','Model Item','Brand new Mercedes-Benz E-Class 2023',40,0,NULL,1,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000029,'MDL007','Audi A6 2023',1007,50000.00,'Audi','123456789035',7,1,20,6,0,365,'Car Showroom','Model Item','Brand new Audi A6 2023',40,0,NULL,1,'2025-03-04 15:05:09','2025-03-04 15:05:09',1,1),(1000030,'DPC001','HP Pavilion Desktop',1022,799.99,'HP','123456789001',150,20,200,50,14,36,'Aisle 1','Desktop','Affordable desktop computer for home and office use',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000031,'DPC002','Dell XPS Desktop',1022,1499.99,'Dell','123456789002',100,15,180,40,14,36,'Aisle 2','Desktop','High-end desktop with powerful performance',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000032,'AIO001','Apple iMac 24-inch',1023,1299.99,'Apple','123456789003',80,15,120,30,14,36,'Aisle 3','All-in-One','Sleek all-in-one computer with 4K display',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000033,'AIO002','HP Envy 32 All-in-One',1023,1799.99,'HP','123456789004',60,10,100,25,14,36,'Aisle 4','All-in-One','High-performance all-in-one computer with 4K touchscreen',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000034,'GPC001','Alienware Aurora R11',1024,1999.99,'Alienware','123456789005',50,10,80,20,14,36,'Aisle 5','Gaming PC','High-performance gaming PC with RTX 3080',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000035,'GPC002','Corsair Vengeance i7200',1024,2299.99,'Corsair','123456789006',40,8,60,15,14,36,'Aisle 6','Gaming PC','Gaming PC with Intel Core i9 and RTX 3090',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000036,'WPC001','Lenovo ThinkStation P620',1025,3999.99,'Lenovo','123456789007',30,5,40,10,14,36,'Aisle 7','Workstation','High-performance workstation for professionals',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000037,'WPC002','HP Z8 G4 Workstation',1025,4999.99,'HP','123456789008',20,3,25,8,14,36,'Aisle 8','Workstation','Workstation for heavy workloads with dual Xeon CPUs',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000038,'MPC001','Intel NUC 11 Performance',1026,699.99,'Intel','123456789009',100,20,180,40,14,36,'Aisle 9','Mini PC','Compact mini PC with high-performance features',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000039,'MPC002','Gigabyte Brix Pro',1026,899.99,'Gigabyte','123456789010',80,18,160,35,14,36,'Aisle 10','Mini PC','Mini PC with Intel Core i7 processor and fast SSD',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000040,'TPC001','Customizable Desktop Tower',1027,1499.99,'Custom','123456789011',60,12,120,30,14,36,'Aisle 11','Tower PC','Fully customizable desktop tower for any need',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000041,'TPC002','Corsair 4000D Airflow',1027,799.99,'Corsair','123456789012',80,15,140,35,14,36,'Aisle 12','Tower PC','Tower PC with great airflow and cooling system',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000042,'LPC001','Dell Inspiron 15',1028,699.99,'Dell','123456789013',150,25,200,50,14,36,'Aisle 13','Laptop','Affordable laptop for personal and professional use',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000043,'LPC002','HP Pavilion x360',1028,799.99,'HP','123456789014',120,20,180,40,14,36,'Aisle 14','Laptop','Convertible laptop with touch screen',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000044,'UBK001','Apple MacBook Air M1',1029,999.99,'Apple','123456789015',80,15,120,30,14,36,'Aisle 15','Ultrabook','Lightweight ultrabook with M1 chip',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000045,'UBK002','Dell XPS 13',1029,1299.99,'Dell','123456789016',100,20,180,40,14,36,'Aisle 16','Ultrabook','Compact and powerful ultrabook with InfinityEdge display',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000046,'GLP001','Razer Blade 15',1030,1799.99,'Razer','123456789017',50,10,80,20,14,36,'Aisle 17','Gaming Laptop','High-end gaming laptop with RTX 3070 graphics',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000047,'GLP002','Asus ROG Strix Scar 17',1030,2299.99,'Asus','123456789018',40,8,60,15,14,36,'Aisle 18','Gaming Laptop','Powerful gaming laptop with 17-inch display',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000048,'BLP001','Lenovo ThinkPad X1 Carbon',1031,1399.99,'Lenovo','123456789019',70,15,140,35,14,36,'Aisle 19','Business Laptop','Lightweight business laptop with top security features',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000049,'BLP002','HP Elite Dragonfly',1031,1599.99,'HP','123456789020',50,10,100,25,14,36,'Aisle 20','Business Laptop','Premium business laptop with 4K display',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000050,'2IN1L001','Microsoft Surface Pro 7',1032,899.99,'Microsoft','123456789021',90,18,160,40,14,36,'Aisle 21','2-in-1 Laptop','Convertible laptop with detachable keyboard',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000051,'2IN1L002','Lenovo Yoga 9i',1032,1299.99,'Lenovo','123456789022',60,12,120,30,14,36,'Aisle 22','2-in-1 Laptop','2-in-1 convertible laptop with high-resolution display',40,0,NULL,0,'2025-03-04 15:09:39','2025-03-04 15:09:39',1,1),(1000052,'LAPTOP001','Laptop',1028,999.99,'Various','123456789001',500,100,1000,200,14,36,'Aisle 23','Model Item','Model Item for Laptops, generic laptop product',40,0,NULL,0,'2025-03-04 15:11:05','2025-03-04 15:11:05',1,1),(1000053,'LAPBATT001','Laptop Battery',1028,99.99,'Generic','123456789023',200,50,500,100,7,24,'Storage','Laptop Part','Replacement battery for laptops',40,0,NULL,0,'2025-03-04 15:12:02','2025-03-04 15:12:02',1,1),(1000054,'LAPBATT002','Dell Laptop Battery',1028,149.99,'Dell','123456789024',150,40,400,80,7,24,'Storage','Laptop Part','Genuine battery for Dell laptops',40,0,NULL,0,'2025-03-04 15:12:02','2025-03-04 15:12:02',1,1),(1000055,'LAPKEYB001','Laptop Keyboard',1028,49.99,'Generic','123456789025',250,50,500,120,14,36,'Storage','Laptop Part','Standard laptop keyboard for replacement',40,0,NULL,0,'2025-03-04 15:12:02','2025-03-04 15:12:02',1,1),(1000056,'LAPKEYB002','HP Laptop Keyboard',1028,89.99,'HP','123456789026',180,30,350,70,14,36,'Storage','Laptop Part','Genuine keyboard for HP laptops',40,0,NULL,0,'2025-03-04 15:12:02','2025-03-04 15:12:02',1,1),(1000057,'LAPCHARG001','Laptop Charger',1028,39.99,'Generic','123456789027',300,60,600,150,7,24,'Storage','Laptop Part','Universal laptop charger',40,0,NULL,0,'2025-03-04 15:12:02','2025-03-04 15:12:02',1,1),(1000058,'LAPCHARG002','Apple MacBook Charger',1028,79.99,'Apple','123456789028',120,25,250,50,7,24,'Storage','Laptop Part','Official charger for MacBooks',40,0,NULL,0,'2025-03-04 15:12:02','2025-03-04 15:12:02',1,1),(1000059,'LAPRAM001','Laptop RAM 8GB',1028,49.99,'Kingston','123456789029',150,30,400,90,14,36,'Storage','Laptop Part','8GB RAM upgrade for laptops',40,0,NULL,0,'2025-03-04 15:12:02','2025-03-04 15:12:02',1,1),(1000060,'LAPRAM002','Laptop RAM 16GB',1028,99.99,'Corsair','123456789030',100,20,250,60,14,36,'Storage','Laptop Part','16GB RAM for laptop memory upgrade',40,0,NULL,0,'2025-03-04 15:12:02','2025-03-04 15:12:02',1,1),(1000061,'LAPMODEL001','Laptop Model - Standard',1028,799.99,'Generic','123456789100',50,10,200,30,7,24,'Display','Laptop','Standard laptop model for home and office use',40,0,NULL,0,'2025-03-04 15:12:54','2025-03-04 15:12:54',1,1),(1000062,'ITEM1005','Item123',1004,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',37,0,NULL,0,'2025-03-04 17:12:36','2025-03-04 17:12:36',1210,1210),(1000063,'ITEM1006','CBN',1001,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','',37,0,NULL,0,'2025-03-04 17:13:31','2025-03-04 17:13:31',1209,1209);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `legal_entity`
--

DROP TABLE IF EXISTS `legal_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legal_entity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `registration_number` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `contact_email` varchar(40) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `about` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legal_entity`
--

LOCK TABLES `legal_entity` WRITE;
/*!40000 ALTER TABLE `legal_entity` DISABLE KEYS */;
INSERT INTO `legal_entity` VALUES (1001,'Opera Legal Distributors Ltd.','REG-2025001','123 Corporate Plaza, Suite 500, New York, NY 10001, USA','contact@operadistributors.com','+1-212-555-7890','Opera Legal Distributors Ltd. is a multinational investment and asset management company specializing in real estate, technology, and financial markets. With a strong presence across North America and Europe, we aim to provide sustainable and strategic investment solutions to our global clientele','2025-03-04 13:42:43','2025-03-04 13:42:43',0,0);
/*!40000 ALTER TABLE `legal_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax`
--

DROP TABLE IF EXISTS `tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax` (
  `tax_id` int NOT NULL AUTO_INCREMENT,
  `tax_code` varchar(50) NOT NULL,
  `tax_description` varchar(255) NOT NULL,
  `tax_rate` decimal(10,2) NOT NULL,
  `tax_type` varchar(20) NOT NULL,
  `tax_authority` varchar(100) DEFAULT NULL,
  `tax_jurisdiction` varchar(100) DEFAULT NULL,
  `tax_applicability` varchar(100) DEFAULT NULL,
  `effective_date` date NOT NULL,
  `exemption` varchar(100) DEFAULT NULL,
  `reporting_codes` varchar(100) DEFAULT NULL,
  `integration_info` text,
  `status` tinyint(1) DEFAULT '1',
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`tax_id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax`
--

LOCK TABLES `tax` WRITE;
/*!40000 ALTER TABLE `tax` DISABLE KEYS */;
INSERT INTO `tax` VALUES (200,'VAT','A consumption tax levied on the value added to goods and services.',20.00,'VAT','','','','2025-03-03','','','',1,'','2025-03-04 12:17:47','2025-03-04 12:17:47',1210,1210),(201,'GST','A multi-stage tax on goods and services sold for domestic consumption.',18.00,'GST','','','','2025-03-04','','','',1,'','2025-03-04 12:18:29','2025-03-04 12:18:29',1210,1210),(202,'Sales Tax','A tax on the sale of goods and services, typically added at the point of sale.',10.00,'SALES_TAX','','','','2025-03-03','','','',1,'','2025-03-04 12:19:10','2025-03-04 12:19:10',1210,1210),(203,'Excise Tax','A tax on specific goods like alcohol, tobacco, and fuel',30.00,'EXCISE_TAX','','','','2025-03-03','','','',1,'','2025-03-04 12:20:52','2025-03-04 12:20:52',1210,1210),(204,'GVAT','Fall back VAT code A consumption tax levied on the value added to goods and services',15.00,'VAT','','','','2025-03-03','','','',1,'','2025-03-04 12:23:46','2025-03-04 12:23:46',1210,1210),(205,'GGST','Fallback A multi-stage tax on goods and services sold for domestic consumption',15.00,'GST','','','','2025-03-03','','','',1,'','2025-03-04 12:24:27','2025-03-04 12:24:27',1210,1210),(206,'GSales Tax','Fall back Sales tax A tax on the sale of goods and services, typically added at the point of sale.',7.00,'SALES_TAX','','','','2025-03-03','','','',1,'','2025-03-04 12:25:23','2025-03-04 12:25:23',1210,1210),(207,'GExcise Tax','Fallback excise tax',8.00,'EXCISE_TAX','','','','2025-03-03','','','',1,'','2025-03-04 12:26:16','2025-03-04 12:26:16',1210,1210);
/*!40000 ALTER TABLE `tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_types`
--

DROP TABLE IF EXISTS `tax_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_types` (
  `tax_type_id` int NOT NULL AUTO_INCREMENT,
  `tax_type` varchar(255) NOT NULL,
  `short_name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`tax_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_types`
--

LOCK TABLES `tax_types` WRITE;
/*!40000 ALTER TABLE `tax_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uom`
--

DROP TABLE IF EXISTS `uom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uom` (
  `uom_id` int NOT NULL AUTO_INCREMENT,
  `uom_name` varchar(50) NOT NULL,
  `abbreviation` varchar(10) NOT NULL,
  `conversion_factor` double NOT NULL,
  `decimal_places` tinyint DEFAULT NULL,
  `base_unit` int DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`uom_id`),
  UNIQUE KEY `abbreviation` (`abbreviation`),
  UNIQUE KEY `unique_uom_name_abbreviation` (`uom_name`,`abbreviation`),
  KEY `base_unit` (`base_unit`),
  CONSTRAINT `uom_ibfk_1` FOREIGN KEY (`base_unit`) REFERENCES `uom` (`uom_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uom`
--

LOCK TABLES `uom` WRITE;
/*!40000 ALTER TABLE `uom` DISABLE KEYS */;
INSERT INTO `uom` VALUES (36,'meter','m',1,0,36,'1 meter = 1 * meter','2025-03-04 12:54:42','2025-03-04 12:54:42',NULL,NULL),(37,'gram','g',1,0,37,'1 gram = 1 * gram','2025-03-04 12:54:56','2025-03-04 12:54:56',NULL,NULL),(38,'liter','L',1,0,38,'1 liter = 1 * liter','2025-03-04 12:55:10','2025-03-04 12:55:10',NULL,NULL),(39,'hour','h',1,0,39,'1 hour = 1 * hour','2025-03-04 12:55:35','2025-03-04 12:55:35',NULL,NULL),(40,'piece','pcs',1,0,40,'1 piece = 1 * piece','2025-03-04 12:55:48','2025-03-04 12:55:48',NULL,NULL),(41,'square meter','mÂ²',1,0,41,'1 square meter = 1 * square meter','2025-03-04 12:56:12','2025-03-04 12:56:12',NULL,NULL),(42,'kilometer','km',1000,0,36,'1 kilometer = 1000 * meter','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(43,'centimeter','cm',0.01,0,36,'1 centimeter = 0.01 * meter','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(44,'millimeter','mm',0.001,0,36,'1 millimeter = 0.001 * meter','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(45,'kilogram','kg',1000,2,37,'1 kilogram = 1000 * gram','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(46,'milligram','mg',0.001,2,37,'1 milligram = 0.001 * gram','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(47,'milliliter','mL',0.001,2,38,'1 milliliter = 0.001 * liter','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(48,'deciliter','dL',0.1,2,38,'1 deciliter = 0.1 * liter','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(49,'minute','min',0.0166667,2,39,'1 minute = 1/60 * hour','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(50,'second','sec',0.000277778,2,39,'1 second = 1/3600 * hour','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(51,'box','box',20,0,40,'1 box = 20 * piece','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(52,'carton','ctn',100,0,40,'1 carton = 100 * piece','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(53,'square kilometer','kmÂ²',1000000,2,41,'1 square kilometer = 1000000 * square meter','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(54,'acre','ac',4046.86,2,41,'1 acre = 4046.86 * square meter','2025-03-04 12:58:42','2025-03-04 12:58:42',1,1),(61,'Dozen Boxes','dz box',12,0,51,'1 Dozen Boxes = 12 * box','2025-03-04 13:07:46','2025-03-04 13:07:46',1,1),(62,'Pallet','plt',50,0,51,'1 Pallet = 50 * box','2025-03-04 13:07:46','2025-03-04 13:07:46',1,1),(63,'Dozen Cartons','dz ctn',12,0,52,'1 Dozen Cartons = 12 * carton','2025-03-04 13:07:46','2025-03-04 13:07:46',1,1),(64,'Dozen','dz',12,0,40,'1 Dozen = 12 * piece','2025-03-04 13:07:46','2025-03-04 13:07:46',1,1),(65,'Gross','gr',144,0,40,'1 Gross = 144 * piece','2025-03-04 13:07:46','2025-03-04 13:07:46',1,1);
/*!40000 ALTER TABLE `uom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `fin`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `fin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `fin`;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `account_number` varchar(50) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `account_category` varchar(255) DEFAULT NULL,
  `account_type` varchar(255) NOT NULL,
  `opening_balance` decimal(15,2) DEFAULT '0.00',
  `current_balance` decimal(15,2) DEFAULT '0.00',
  `currency_id` int NOT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `branch_name` varchar(255) DEFAULT NULL,
  `account_holder_name` varchar(255) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text,
  `is_active` tinyint(1) DEFAULT '1',
  `department_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `default_account` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_number` (`account_number`),
  UNIQUE KEY `unique_account_combination` (`company_id`,`department_id`,`account_category`,`account_type`,`default_account`,`currency_id`),
  KEY `department_id` (`department_id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `com`.`department` (`id`) ON DELETE SET NULL,
  CONSTRAINT `accounts_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `com`.`company` (`id`) ON DELETE SET NULL,
  CONSTRAINT `accounts_ibfk_3` FOREIGN KEY (`currency_id`) REFERENCES `com`.`currency` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8015 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (8001,'3001--04032502468','Opera Product Sales-04032502468','Revenue','Sales',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 13:56:18','2025-03-04 13:56:18',0,0,NULL),(8002,'3001--04032536607','Opera Service Sales-04032536607','Revenue','Sales',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 13:56:45','2025-03-04 13:56:45',0,0,NULL),(8003,'3001--04032582154','Opera Raw Materials Purchases-04032582154','Expense','Inventory',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 13:57:56','2025-03-04 13:57:56',0,0,NULL),(8004,'3001--04032548339','Opera Finished Goods Purchases-04032548339','Expense','Inventory',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 13:58:17','2025-03-04 13:58:17',0,0,NULL),(8005,'3001--04032503025','Opera Office Supplies Purchases-04032503025','Expense','',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 13:58:47','2025-03-04 13:58:47',0,0,NULL),(8006,'3001--04032558736','Opera Sales Tax Payable-04032558736','Liability','Tax Payable',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 13:59:20','2025-03-04 13:59:20',0,0,NULL),(8007,'3001--04032505927',' Account Name	Account Category	Account Type Opera Sales Tax Payable	Liability	Tax Payable Opera VAT Payable-04032505927','Liability','Tax Payable',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 13:59:48','2025-03-04 13:59:48',0,0,NULL),(8008,'3001--04032529044','Opera Depreciation Journal-04032529044','Expense','Utilities Expense',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 14:02:28','2025-03-04 14:02:28',0,0,NULL),(8009,'3001--04032545337','Opera Advertising Expense-04032545337','Expense','Utilities Expense',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 14:03:18','2025-03-04 14:03:18',0,0,NULL),(8010,'3001--04032570442','DEF Opera Product Sales-04032570442','Revenue','Sales',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 14:04:15','2025-03-04 14:04:15',0,0,NULL),(8011,'3001--04032573075','DEFOpera Service Sales-04032573075','Revenue','Sales',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 14:04:40','2025-03-04 14:04:40',0,0,NULL),(8012,'3001--04032555387','DEFOpera Finished Goods Purchases-04032555387','Expense','Utilities Expense',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 14:05:15','2025-03-04 14:05:15',0,0,NULL),(8013,'3001--04032574840','DEFOpera Import Purchases-04032574840','Expense','Purchase',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 14:05:40','2025-03-04 14:05:40',0,0,NULL),(8014,'3001--04032582238','DEFOpera VAT Payable-04032582238','Liability','Tax Payable',0.00,0.00,31,'','','',NULL,NULL,NULL,1,NULL,3001,'2025-03-04 14:06:10','2025-03-04 14:06:10',0,0,NULL);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_account_headers`
--

DROP TABLE IF EXISTS `default_account_headers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `default_account_headers` (
  `header_id` int NOT NULL AUTO_INCREMENT,
  `header_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`header_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_account_headers`
--

LOCK TABLES `default_account_headers` WRITE;
/*!40000 ALTER TABLE `default_account_headers` DISABLE KEYS */;
INSERT INTO `default_account_headers` VALUES (2000,'DEFACCHDR','2025-03-04 14:06:39','2025-03-04 14:06:39',0,0);
/*!40000 ALTER TABLE `default_account_headers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_accounts`
--

DROP TABLE IF EXISTS `default_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `default_accounts` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `header_id` int NOT NULL,
  `account_id` int NOT NULL,
  `account_type` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `unique_default_accounts` (`header_id`,`account_type`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `default_accounts_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `default_account_headers` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `default_accounts_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_accounts`
--

LOCK TABLES `default_accounts` WRITE;
/*!40000 ALTER TABLE `default_accounts` DISABLE KEYS */;
INSERT INTO `default_accounts` VALUES (3002,2000,8013,'Purchase','DEFOpera Import Purchases-04032574840','2025-03-04 14:07:08','2025-03-04 14:07:08',0,0),(3003,2000,8014,'Tax Payable','DEFOpera VAT Payable-04032582238','2025-03-04 14:07:08','2025-03-04 14:07:08',0,0),(3004,2000,8010,'Sales','DEF Opera Product Sales-04032570442','2025-03-04 14:07:55','2025-03-04 14:07:55',0,0),(3005,2000,8012,'Utilities Expense','DEFOpera Finished Goods Purchases-04032555387','2025-03-04 14:08:37','2025-03-04 14:08:37',0,0);
/*!40000 ALTER TABLE `default_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_headers`
--

DROP TABLE IF EXISTS `journal_headers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journal_headers` (
  `header_id` int NOT NULL AUTO_INCREMENT,
  `journal_number` int NOT NULL,
  `company_id` int NOT NULL,
  `department_id` int DEFAULT NULL,
  `journal_date` date NOT NULL,
  `journal_type` varchar(20) NOT NULL,
  `source_number` int DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `currency_id` int NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`header_id`),
  KEY `idx_company_id` (`company_id`),
  KEY `idx_department_id` (`department_id`),
  KEY `idx_currency_id` (`currency_id`),
  KEY `idx_journal_number` (`journal_number`),
  CONSTRAINT `journal_headers_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `com`.`company` (`id`) ON DELETE CASCADE,
  CONSTRAINT `journal_headers_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `com`.`department` (`id`) ON DELETE SET NULL,
  CONSTRAINT `journal_headers_ibfk_3` FOREIGN KEY (`currency_id`) REFERENCES `com`.`currency` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=701 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_headers`
--

LOCK TABLES `journal_headers` WRITE;
/*!40000 ALTER TABLE `journal_headers` DISABLE KEYS */;
/*!40000 ALTER TABLE `journal_headers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_lines`
--

DROP TABLE IF EXISTS `journal_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journal_lines` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `line_number` int NOT NULL,
  `header_id` int NOT NULL,
  `account_id` int NOT NULL,
  `debit` decimal(15,2) DEFAULT '0.00',
  `credit` decimal(15,2) DEFAULT '0.00',
  `status` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  KEY `idx_header_id` (`header_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_line_number` (`line_number`),
  CONSTRAINT `journal_lines_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `journal_headers` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `journal_lines_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_lines`
--

LOCK TABLES `journal_lines` WRITE;
/*!40000 ALTER TABLE `journal_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `journal_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseinvoice`
--

DROP TABLE IF EXISTS `purchaseinvoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchaseinvoice` (
  `header_id` int NOT NULL AUTO_INCREMENT,
  `invoice_number` int NOT NULL,
  `partnerid` int NOT NULL,
  `invoicedate` date NOT NULL,
  `totalamount` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `payment_terms` varchar(50) DEFAULT NULL,
  `payment_duedate` date DEFAULT NULL,
  `tax_id` int DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `transaction_source` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`header_id`),
  KEY `tax_id` (`tax_id`),
  KEY `partnerid` (`partnerid`),
  KEY `currency_id` (`currency_id`),
  KEY `department_id` (`department_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `purchaseinvoice_ibfk_1` FOREIGN KEY (`tax_id`) REFERENCES `com`.`tax` (`tax_id`),
  CONSTRAINT `purchaseinvoice_ibfk_2` FOREIGN KEY (`partnerid`) REFERENCES `com`.`businesspartner` (`partnerid`),
  CONSTRAINT `purchaseinvoice_ibfk_3` FOREIGN KEY (`currency_id`) REFERENCES `com`.`currency` (`currency_id`),
  CONSTRAINT `purchaseinvoice_ibfk_4` FOREIGN KEY (`department_id`) REFERENCES `com`.`department` (`id`),
  CONSTRAINT `purchaseinvoice_ibfk_5` FOREIGN KEY (`company_id`) REFERENCES `com`.`company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseinvoice`
--

LOCK TABLES `purchaseinvoice` WRITE;
/*!40000 ALTER TABLE `purchaseinvoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchaseinvoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseinvoiceaccounts`
--

DROP TABLE IF EXISTS `purchaseinvoiceaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchaseinvoiceaccounts` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `line_number` varchar(50) NOT NULL,
  `header_id` int NOT NULL,
  `is_tax_line` tinyint(1) DEFAULT '0',
  `account_id` int NOT NULL,
  `debitamount` decimal(10,2) NOT NULL,
  `creditamount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `unique_line` (`header_id`,`line_number`,`line_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `purchaseinvoiceaccounts_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `purchaseinvoice` (`header_id`),
  CONSTRAINT `purchaseinvoiceaccounts_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseinvoiceaccounts`
--

LOCK TABLES `purchaseinvoiceaccounts` WRITE;
/*!40000 ALTER TABLE `purchaseinvoiceaccounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchaseinvoiceaccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseinvoicelines`
--

DROP TABLE IF EXISTS `purchaseinvoicelines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchaseinvoicelines` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `line_number` varchar(50) NOT NULL,
  `header_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `line_total` decimal(15,2) NOT NULL,
  `uom_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `line_number` (`line_number`,`header_id`),
  KEY `header_id` (`header_id`),
  KEY `item_id` (`item_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `purchaseinvoicelines_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `purchaseinvoice` (`header_id`),
  CONSTRAINT `purchaseinvoicelines_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`),
  CONSTRAINT `purchaseinvoicelines_ibfk_3` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseinvoicelines`
--

LOCK TABLES `purchaseinvoicelines` WRITE;
/*!40000 ALTER TABLE `purchaseinvoicelines` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchaseinvoicelines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesinvoice`
--

DROP TABLE IF EXISTS `salesinvoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesinvoice` (
  `header_id` int NOT NULL AUTO_INCREMENT,
  `invoice_number` int NOT NULL,
  `partnerid` int NOT NULL,
  `invoicedate` date NOT NULL,
  `totalamount` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `payment_terms` varchar(50) DEFAULT NULL,
  `payment_duedate` date DEFAULT NULL,
  `tax_id` int DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `transaction_source` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`header_id`),
  KEY `tax_id` (`tax_id`),
  KEY `partnerid` (`partnerid`),
  KEY `currency_id` (`currency_id`),
  KEY `department_id` (`department_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `salesinvoice_ibfk_1` FOREIGN KEY (`tax_id`) REFERENCES `com`.`tax` (`tax_id`),
  CONSTRAINT `salesinvoice_ibfk_2` FOREIGN KEY (`partnerid`) REFERENCES `com`.`businesspartner` (`partnerid`),
  CONSTRAINT `salesinvoice_ibfk_3` FOREIGN KEY (`currency_id`) REFERENCES `com`.`currency` (`currency_id`),
  CONSTRAINT `salesinvoice_ibfk_4` FOREIGN KEY (`department_id`) REFERENCES `com`.`department` (`id`),
  CONSTRAINT `salesinvoice_ibfk_5` FOREIGN KEY (`company_id`) REFERENCES `com`.`company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesinvoice`
--

LOCK TABLES `salesinvoice` WRITE;
/*!40000 ALTER TABLE `salesinvoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesinvoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesinvoiceaccounts`
--

DROP TABLE IF EXISTS `salesinvoiceaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesinvoiceaccounts` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `line_number` varchar(50) NOT NULL,
  `header_id` int NOT NULL,
  `is_tax_line` tinyint(1) DEFAULT '0',
  `account_id` int NOT NULL,
  `debitamount` decimal(10,2) NOT NULL,
  `creditamount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `unique_line` (`header_id`,`line_number`,`line_id`),
  UNIQUE KEY `line_number` (`line_number`,`header_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `salesinvoiceaccounts_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `salesinvoice` (`header_id`),
  CONSTRAINT `salesinvoiceaccounts_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=909000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesinvoiceaccounts`
--

LOCK TABLES `salesinvoiceaccounts` WRITE;
/*!40000 ALTER TABLE `salesinvoiceaccounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesinvoiceaccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesinvoicelines`
--

DROP TABLE IF EXISTS `salesinvoicelines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesinvoicelines` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `line_number` varchar(50) NOT NULL,
  `header_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `line_total` decimal(15,2) NOT NULL,
  `uom_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `line_number` (`line_number`,`header_id`),
  KEY `header_id` (`header_id`),
  KEY `item_id` (`item_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `salesinvoicelines_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `salesinvoice` (`header_id`),
  CONSTRAINT `salesinvoicelines_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`),
  CONSTRAINT `salesinvoicelines_ibfk_3` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=808000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesinvoicelines`
--

LOCK TABLES `salesinvoicelines` WRITE;
/*!40000 ALTER TABLE `salesinvoicelines` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesinvoicelines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `inv`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `inv` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `inv`;

--
-- Table structure for table `aisles`
--

DROP TABLE IF EXISTS `aisles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aisles` (
  `aisle_id` int NOT NULL AUTO_INCREMENT,
  `zone_id` int DEFAULT NULL,
  `aisle_name` varchar(50) NOT NULL,
  `description` text,
  `capacity` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`aisle_id`),
  KEY `zone_id` (`zone_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `aisles_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`zone_id`) ON DELETE CASCADE,
  CONSTRAINT `aisles_ibfk_2` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aisles`
--

LOCK TABLES `aisles` WRITE;
/*!40000 ALTER TABLE `aisles` DISABLE KEYS */;
INSERT INTO `aisles` VALUES (40,30,'Aisle A1','Aisle for storing high-demand raw materials.',800,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(41,30,'Aisle A2','Aisle for storing finished goods ready for dispatch.',700,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(42,31,'Aisle B1','Aisle for seasonal overflow items storage.',600,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(43,31,'Aisle B2','Aisle for excess stock during peak seasons.',500,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(44,32,'Aisle C1','Aisle for temporary storage during peak time.',700,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(45,32,'Aisle C2','Temporary storage area for incoming shipments.',600,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(46,33,'Aisle D1','Aisle for peak time storage of high-demand items.',800,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(47,33,'Aisle D2','Storage for items with high turnover during peak periods.',700,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(48,34,'Aisle E1','Receiving area for new goods arriving at the warehouse.',1000,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(49,34,'Aisle E2','Aisle for sorting incoming shipments from suppliers.',900,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(50,35,'Aisle F1','Sorting and packing area for outgoing shipments.',1200,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(51,35,'Aisle F2','Aisle for final checks and packaging before dispatch.',1100,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(52,36,'Aisle G1','Receiving area for goods from European suppliers.',1100,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(53,36,'Aisle G2','Aisle for sorting and inspecting European goods.',1000,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(54,37,'Aisle H1','Sorting zone for European goods.',1200,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(55,37,'Aisle H2','Aisle for packaging and dispatch of European orders.',1000,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(56,38,'Aisle I1','Receiving area for goods from the Asia Pacific region.',1300,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(57,38,'Aisle I2','Aisle for sorting incoming Asia Pacific shipments.',1200,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(58,39,'Aisle J1','Sorting and checking Asia Pacific goods.',1400,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1),(59,39,'Aisle J2','Final packing and dispatch area for Asia Pacific goods.',1300,NULL,'2025-03-04 14:42:44','2025-03-04 14:42:44',1,1);
/*!40000 ALTER TABLE `aisles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bins`
--

DROP TABLE IF EXISTS `bins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bins` (
  `bin_id` int NOT NULL AUTO_INCREMENT,
  `rack_id` int DEFAULT NULL,
  `bin_name` varchar(50) NOT NULL,
  `description` text,
  `capacity` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`bin_id`),
  KEY `rack_id` (`rack_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `bins_ibfk_1` FOREIGN KEY (`rack_id`) REFERENCES `racks` (`rack_id`) ON DELETE CASCADE,
  CONSTRAINT `bins_ibfk_2` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bins`
--

LOCK TABLES `bins` WRITE;
/*!40000 ALTER TABLE `bins` DISABLE KEYS */;
INSERT INTO `bins` VALUES (70,70,'Bin A1-1-1-1','Bin for storing high-demand raw materials in Rack A1-1-1.',50,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(71,71,'Bin A1-1-2-1','Bin for storing fast-moving raw materials in Rack A1-1-2.',60,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(72,72,'Bin A1-2-1-1','Bin for finished goods ready for dispatch in Rack A1-2-1.',70,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(73,73,'Bin A1-2-2-1','Bin for storing order-ready finished goods in Rack A1-2-2.',80,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(74,74,'Bin B1-1-1-1','Bin for seasonal overflow items in Rack B1-1-1.',90,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(75,75,'Bin B1-1-2-1','Bin for storing excess seasonal items in Rack B1-1-2.',100,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(76,76,'Bin B2-1-1-1','Bin for storing excess stock for peak season in Rack B2-1-1.',110,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(77,77,'Bin B2-1-2-1','Bin for temporary excess stock during peak periods in Rack B2-1-2.',120,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(78,78,'Bin C1-1-1-1','Bin for temporary storage of peak period items in Rack C1-1-1.',130,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(79,79,'Bin C1-1-2-1','Bin for overflow storage during peak season in Rack C1-1-2.',140,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(80,80,'Bin C2-1-1-1','Bin for storing incoming shipments during peak times in Rack C2-1-1.',150,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(81,81,'Bin C2-1-2-1','Bin for temporary storage of incoming goods in Rack C2-1-2.',160,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(82,82,'Bin D1-1-1-1','Bin for storing high-demand peak season items in Rack D1-1-1.',170,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(83,83,'Bin D1-1-2-1','Bin for storing peak season high-turnover items in Rack D1-1-2.',180,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(84,84,'Bin D2-1-1-1','Bin for storing high-turnover peak season items in Rack D2-1-1.',190,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(85,85,'Bin D2-1-2-1','Bin for overflow peak period storage in Rack D2-1-2.',200,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(86,86,'Bin E1-1-1-1','Bin for receiving newly arrived goods in Rack E1-1-1.',210,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(87,87,'Bin E1-1-2-1','Bin for storing goods received from suppliers in Rack E1-1-2.',220,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(88,88,'Bin E2-1-1-1','Bin for sorting and organizing incoming shipments in Rack E2-1-1.',230,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(89,89,'Bin E2-1-2-1','Bin for storing sorted goods waiting for processing in Rack E2-1-2.',240,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(90,90,'Bin F1-1-1-1','Bin for sorting outgoing shipments in Rack F1-1-1.',250,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(91,91,'Bin F1-1-2-1','Bin for packing outgoing orders in Rack F1-1-2.',260,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(92,92,'Bin F2-1-1-1','Bin for storing final packaged goods in Rack F2-1-1.',270,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(93,93,'Bin F2-1-2-1','Bin for final checks and packaging before dispatch in Rack F2-1-2.',280,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(94,94,'Bin G1-1-1-1','Bin for receiving goods from European suppliers in Rack G1-1-1.',290,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(95,95,'Bin G1-1-2-1','Bin for storing European supplier goods in Rack G1-1-2.',300,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(96,96,'Bin G2-1-1-1','Bin for sorting and inspecting European goods in Rack G2-1-1.',310,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(97,97,'Bin G2-1-2-1','Bin for storing European goods in processing stage in Rack G2-1-2.',320,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(98,98,'Bin H1-1-1-1','Bin for sorting European goods before dispatch in Rack H1-1-1.',330,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(99,99,'Bin H1-1-2-1','Bin for goods ready for shipment to Europe in Rack H1-1-2.',340,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(100,100,'Bin H2-1-1-1','Bin for packing and dispatch of European orders in Rack H2-1-1.',350,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(101,101,'Bin H2-1-2-1','Bin for final checks and packaging for European shipments in Rack H2-1-2.',360,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(102,102,'Bin I1-1-1-1','Bin for receiving goods from Asia Pacific region in Rack I1-1-1.',370,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(103,103,'Bin I1-1-2-1','Bin for storing Asia Pacific goods upon arrival in Rack I1-1-2.',380,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(104,104,'Bin I2-1-1-1','Bin for sorting Asia Pacific shipments in Rack I2-1-1.',390,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(105,105,'Bin I2-1-2-1','Bin for temporary storage of Asia Pacific goods in Rack I2-1-2.',400,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(106,106,'Bin J1-1-1-1','Bin for sorting and checking Asia Pacific goods in Rack J1-1-1.',410,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(107,107,'Bin J1-1-2-1','Bin for final quality checks before dispatch for Asia Pacific goods in Rack J1-1-2.',420,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(108,108,'Bin J2-1-1-1','Bin for packing and dispatch of Asia Pacific shipments in Rack J2-1-1.',430,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1),(109,109,'Bin J2-1-2-1','Bin for final packing and dispatch of Asia Pacific goods in Rack J2-1-2.',440,NULL,'2025-03-04 14:49:51','2025-03-04 14:49:51',1,1);
/*!40000 ALTER TABLE `bins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inspection`
--

DROP TABLE IF EXISTS `inspection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inspection` (
  `inspection_id` int NOT NULL AUTO_INCREMENT,
  `item_id` int DEFAULT NULL,
  `inspection_name` varchar(255) NOT NULL,
  `inspection_location_id` int DEFAULT NULL,
  `transaction_quantity` int DEFAULT NULL,
  `accepted_quantity` int DEFAULT NULL,
  `rejected_quantity` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `comments` text,
  `transaction_number` int DEFAULT NULL,
  `transaction_type` varchar(255) DEFAULT NULL,
  `transaction_header_number` int DEFAULT NULL,
  `accepted_qty_details` text,
  `rejected_qty_details` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`inspection_id`),
  KEY `inspection_location_id` (`inspection_location_id`),
  KEY `uom_id` (`uom_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `inspection_ibfk_1` FOREIGN KEY (`inspection_location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `inspection_ibfk_2` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`),
  CONSTRAINT `inspection_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4562 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inspection`
--

LOCK TABLES `inspection` WRITE;
/*!40000 ALTER TABLE `inspection` DISABLE KEYS */;
/*!40000 ALTER TABLE `inspection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invrows`
--

DROP TABLE IF EXISTS `invrows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invrows` (
  `row_id` int NOT NULL AUTO_INCREMENT,
  `aisle_id` int DEFAULT NULL,
  `row_name` varchar(50) NOT NULL,
  `description` text,
  `capacity` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`row_id`),
  KEY `aisle_id` (`aisle_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `invrows_ibfk_1` FOREIGN KEY (`aisle_id`) REFERENCES `aisles` (`aisle_id`) ON DELETE CASCADE,
  CONSTRAINT `invrows_ibfk_2` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invrows`
--

LOCK TABLES `invrows` WRITE;
/*!40000 ALTER TABLE `invrows` DISABLE KEYS */;
INSERT INTO `invrows` VALUES (50,40,'Row A1-1','High-demand raw materials storage area.',200,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(51,40,'Row A1-2','Storage for raw materials with fast turnover.',180,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(52,41,'Row A2-1','Finished goods ready for dispatch storage.',150,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(53,41,'Row A2-2','Storage for finished goods, order ready.',170,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(54,42,'Row B1-1','Overflow seasonal storage for products.',220,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(55,42,'Row B1-2','Overflow stock from seasonal items.',240,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(56,43,'Row B2-1','Excess stock storage for peak season.',200,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(57,43,'Row B2-2','Temporary excess stock for peak times.',220,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(58,44,'Row C1-1','Temporary storage for peak period items.',250,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(59,44,'Row C1-2','Temporary overflow storage during peak time.',230,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(60,45,'Row C2-1','Storage for incoming shipments in peak times.',260,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(61,45,'Row C2-2','Temporary storage for incoming goods.',270,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(62,46,'Row D1-1','Storage for high-demand peak season items.',300,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(63,46,'Row D1-2','Storage for peak season high-turnover items.',280,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(64,47,'Row D2-1','High turnover items during peak season storage.',250,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(65,47,'Row D2-2','Overflow items storage during peak periods.',270,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(66,48,'Row E1-1','Receiving area for newly arrived goods.',400,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(67,48,'Row E1-2','Storage for incoming goods from suppliers.',380,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(68,49,'Row E2-1','Sorting and organizing incoming shipments.',350,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(69,49,'Row E2-2','Storage for sorted goods from suppliers.',330,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(70,50,'Row F1-1','Storage for sorting outgoing shipments.',450,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(71,50,'Row F1-2','Packing area for outgoing orders.',470,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(72,51,'Row F2-1','Storage for final packaging before dispatch.',500,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(73,51,'Row F2-2','Final checks and packaging area for dispatch.',520,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(74,52,'Row G1-1','Receiving area for European supplier goods.',550,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(75,52,'Row G1-2','Storage for European supplier goods.',530,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(76,53,'Row G2-1','Sorting and inspection of European goods.',570,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(77,53,'Row G2-2','Storage for European goods in process.',590,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(78,54,'Row H1-1','Sorting zone for European goods before dispatch.',600,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(79,54,'Row H1-2','Storage for goods sorted for shipment to Europe.',620,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(80,55,'Row H2-1','Packing and dispatch area for European orders.',650,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(81,55,'Row H2-2','Final checks and packaging for European shipments.',670,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(82,56,'Row I1-1','Receiving zone for Asia Pacific goods.',700,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(83,56,'Row I1-2','Storage for incoming goods from Asia Pacific suppliers.',720,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(84,57,'Row I2-1','Storage for sorting Asia Pacific shipments.',740,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(85,57,'Row I2-2','Temporary storage for Asia Pacific goods.',760,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(86,58,'Row J1-1','Sorting and checking Asia Pacific goods.',800,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(87,58,'Row J1-2','Final quality checks before dispatch for Asia Pacific.',820,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(88,59,'Row J2-1','Packing and dispatch area for Asia Pacific shipments.',850,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1),(89,59,'Row J2-2','Storage for final packing and dispatch for Asia Pacific.',870,NULL,'2025-03-04 14:45:07','2025-03-04 14:45:07',1,1);
/*!40000 ALTER TABLE `invrows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_inventory`
--

DROP TABLE IF EXISTS `item_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` int NOT NULL,
  `transaction_type` varchar(255) NOT NULL,
  `item_id` int NOT NULL,
  `uom_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `bin_id` int DEFAULT NULL,
  `rack_id` int DEFAULT NULL,
  `row_id` int DEFAULT NULL,
  `aisle_id` int DEFAULT NULL,
  `zone_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `status` enum('Yes','No') DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `additional_info` longtext,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  UNIQUE KEY `unique_combination` (`transaction_id`,`transaction_type`,`item_id`,`uom_id`,`bin_id`,`rack_id`,`row_id`,`aisle_id`,`zone_id`,`location_id`,`warehouse_id`),
  KEY `item_id` (`item_id`),
  KEY `uom_id` (`uom_id`),
  KEY `bin_id` (`bin_id`),
  KEY `rack_id` (`rack_id`),
  KEY `row_id` (`row_id`),
  KEY `aisle_id` (`aisle_id`),
  KEY `zone_id` (`zone_id`),
  KEY `location_id` (`location_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `item_inventory_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`),
  CONSTRAINT `item_inventory_ibfk_2` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`),
  CONSTRAINT `item_inventory_ibfk_3` FOREIGN KEY (`bin_id`) REFERENCES `bins` (`bin_id`),
  CONSTRAINT `item_inventory_ibfk_4` FOREIGN KEY (`rack_id`) REFERENCES `racks` (`rack_id`),
  CONSTRAINT `item_inventory_ibfk_5` FOREIGN KEY (`row_id`) REFERENCES `invrows` (`row_id`),
  CONSTRAINT `item_inventory_ibfk_6` FOREIGN KEY (`aisle_id`) REFERENCES `aisles` (`aisle_id`),
  CONSTRAINT `item_inventory_ibfk_7` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`zone_id`),
  CONSTRAINT `item_inventory_ibfk_8` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `item_inventory_ibfk_9` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_inventory`
--

LOCK TABLES `item_inventory` WRITE;
/*!40000 ALTER TABLE `item_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) NOT NULL,
  `location_type` varchar(255) NOT NULL,
  `description` text,
  `capacity` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `temperature_controlled` varchar(255) DEFAULT NULL,
  `security_level` varchar(255) DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  KEY `warehouse_id` (`warehouse_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`) ON DELETE CASCADE,
  CONSTRAINT `locations_ibfk_2` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (20,'Central Storage Area','Store','Main storage area for finished goods and raw materials.',5000,NULL,'Normal','High',15,'2025-03-04 14:34:21','2025-03-04 14:34:21',1,1),(21,'Overflow Storage','Store','Secondary storage area for overflow and seasonal items.',4000,NULL,'Normal','Med',16,'2025-03-04 14:34:21','2025-03-04 14:34:21',1,1),(22,'East Coast Distribution Center','Distribution Center','Primary distribution center for East Coast deliveries.',8000,NULL,'Normal','High',17,'2025-03-04 14:34:21','2025-03-04 14:34:21',1,1),(23,'European Hub','Distribution Center','Warehouse for handling all European shipments and distribution.',10000,NULL,'Normal','Low',18,'2025-03-04 14:34:21','2025-03-04 14:34:21',1,1),(24,'Asia Pacific Hub','Distribution Center','Storage and distribution center for Asia Pacific region.',12000,NULL,'Yes','High',19,'2025-03-04 14:34:21','2025-03-04 14:34:21',1,1);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pick_and_ship_stage`
--

DROP TABLE IF EXISTS `pick_and_ship_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pick_and_ship_stage` (
  `pick_id` int NOT NULL AUTO_INCREMENT,
  `execution_id` varchar(50) NOT NULL,
  `order_id` int NOT NULL,
  `line_id` int NOT NULL,
  `item_id` int NOT NULL,
  `inventory_id` int NOT NULL,
  `picked_quantity` int NOT NULL,
  `pick_date` date NOT NULL,
  `picker_id` int NOT NULL,
  `shipping_location_id` int DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `shipping_method` varchar(50) DEFAULT NULL,
  `destination` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pick_id`),
  KEY `order_id` (`order_id`),
  KEY `execution_id` (`execution_id`),
  KEY `item_id` (`item_id`),
  KEY `inventory_id` (`inventory_id`),
  KEY `picker_id` (`picker_id`),
  KEY `shipping_location_id` (`shipping_location_id`),
  CONSTRAINT `pick_and_ship_stage_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `sal`.`sales_order_headers` (`header_id`),
  CONSTRAINT `pick_and_ship_stage_ibfk_2` FOREIGN KEY (`execution_id`) REFERENCES `sal`.`pick_release_log` (`execution_id`),
  CONSTRAINT `pick_and_ship_stage_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`),
  CONSTRAINT `pick_and_ship_stage_ibfk_4` FOREIGN KEY (`inventory_id`) REFERENCES `item_inventory` (`inventory_id`),
  CONSTRAINT `pick_and_ship_stage_ibfk_5` FOREIGN KEY (`picker_id`) REFERENCES `com`.`employee` (`empid`),
  CONSTRAINT `pick_and_ship_stage_ibfk_6` FOREIGN KEY (`shipping_location_id`) REFERENCES `item_inventory` (`inventory_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pick_and_ship_stage`
--

LOCK TABLES `pick_and_ship_stage` WRITE;
/*!40000 ALTER TABLE `pick_and_ship_stage` DISABLE KEYS */;
/*!40000 ALTER TABLE `pick_and_ship_stage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racks`
--

DROP TABLE IF EXISTS `racks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `racks` (
  `rack_id` int NOT NULL AUTO_INCREMENT,
  `row_id` int DEFAULT NULL,
  `rack_name` varchar(50) NOT NULL,
  `description` text,
  `capacity` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`rack_id`),
  KEY `row_id` (`row_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `racks_ibfk_1` FOREIGN KEY (`row_id`) REFERENCES `invrows` (`row_id`) ON DELETE CASCADE,
  CONSTRAINT `racks_ibfk_2` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racks`
--

LOCK TABLES `racks` WRITE;
/*!40000 ALTER TABLE `racks` DISABLE KEYS */;
INSERT INTO `racks` VALUES (70,50,'Rack A1-1-1','Rack for storing high-demand raw materials.',100,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(71,50,'Rack A1-1-2','Rack for storing fast-moving raw materials in Aisle A1.',120,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(72,51,'Rack A1-2-1','Rack for finished goods ready for dispatch.',150,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(73,51,'Rack A1-2-2','Rack for storing order-ready finished goods in Aisle A2.',170,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(74,52,'Rack B1-1-1','Rack for storing seasonal overflow items.',180,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(75,52,'Rack B1-1-2','Rack for excess seasonal items storage.',190,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(76,53,'Rack B2-1-1','Rack for storing excess stock for peak season.',200,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(77,53,'Rack B2-1-2','Rack for temporary excess stock during peak periods.',210,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(78,54,'Rack C1-1-1','Rack for temporary storage of peak period items.',220,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(79,54,'Rack C1-1-2','Rack for overflow storage during peak season.',230,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(80,55,'Rack C2-1-1','Rack for storing incoming shipments during peak times.',240,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(81,55,'Rack C2-1-2','Temporary storage rack for incoming goods.',260,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(82,56,'Rack D1-1-1','Rack for storing high-demand peak season items.',270,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(83,56,'Rack D1-1-2','Rack for storing peak season high-turnover items.',280,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(84,57,'Rack D2-1-1','Rack for storing high-turnover peak season items.',290,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(85,57,'Rack D2-1-2','Overflow rack for peak period storage.',300,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(86,58,'Rack E1-1-1','Rack for receiving newly arrived goods.',320,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(87,58,'Rack E1-1-2','Rack for storing goods received from suppliers.',330,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(88,59,'Rack E2-1-1','Rack for sorting and organizing incoming shipments.',340,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(89,59,'Rack E2-1-2','Rack for sorted goods waiting for processing.',350,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(90,60,'Rack F1-1-1','Rack for sorting outgoing shipments.',360,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(91,60,'Rack F1-1-2','Packing rack for outgoing orders ready for dispatch.',380,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(92,61,'Rack F2-1-1','Rack for storing final packaged goods.',400,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(93,61,'Rack F2-1-2','Rack for final checks and packaging before dispatch.',420,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(94,62,'Rack G1-1-1','Rack for receiving goods from European suppliers.',450,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(95,62,'Rack G1-1-2','Rack for storing European supplier goods.',470,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(96,63,'Rack G2-1-1','Rack for sorting and inspecting European goods.',490,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(97,63,'Rack G2-1-2','Rack for storing European goods in processing stage.',510,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(98,64,'Rack H1-1-1','Rack for sorting European goods before dispatch.',530,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(99,64,'Rack H1-1-2','Rack for goods ready for shipment to Europe.',550,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(100,65,'Rack H2-1-1','Rack for packing and dispatch of European orders.',570,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(101,65,'Rack H2-1-2','Rack for final checks and packaging for European shipments.',590,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(102,66,'Rack I1-1-1','Rack for receiving goods from Asia Pacific region.',610,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(103,66,'Rack I1-1-2','Rack for storing Asia Pacific goods upon arrival.',630,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(104,67,'Rack I2-1-1','Rack for sorting Asia Pacific shipments.',650,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(105,67,'Rack I2-1-2','Temporary storage rack for Asia Pacific goods.',670,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(106,68,'Rack J1-1-1','Rack for sorting and checking Asia Pacific goods.',690,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(107,68,'Rack J1-1-2','Rack for final quality checks before dispatch for Asia Pacific goods.',710,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(108,69,'Rack J2-1-1','Rack for packing and dispatch of Asia Pacific shipments.',730,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1),(109,69,'Rack J2-1-2','Rack for final packing and dispatch of Asia Pacific goods.',750,NULL,'2025-03-04 14:47:41','2025-03-04 14:47:41',1,1);
/*!40000 ALTER TABLE `racks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipts`
--

DROP TABLE IF EXISTS `receipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipts` (
  `receipt_id` int NOT NULL AUTO_INCREMENT,
  `transaction_number` int DEFAULT NULL,
  `transaction_header_number` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `receipt_name` varchar(255) NOT NULL,
  `receiving_location_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `comments` text,
  `inspect` tinyint(1) DEFAULT NULL,
  `accepted_qty` int DEFAULT NULL,
  `rejected_qty` int DEFAULT NULL,
  `inspection_id` int DEFAULT NULL,
  `inspection_location_id` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`receipt_id`),
  KEY `receiving_location_id` (`receiving_location_id`),
  KEY `uom_id` (`uom_id`),
  KEY `item_id` (`item_id`),
  KEY `inspection_id` (`inspection_id`),
  KEY `inspection_location_id` (`inspection_location_id`),
  CONSTRAINT `receipts_ibfk_1` FOREIGN KEY (`receiving_location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `receipts_ibfk_2` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`),
  CONSTRAINT `receipts_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`),
  CONSTRAINT `receipts_ibfk_4` FOREIGN KEY (`inspection_id`) REFERENCES `inspection` (`inspection_id`) ON DELETE SET NULL,
  CONSTRAINT `receipts_ibfk_5` FOREIGN KEY (`inspection_location_id`) REFERENCES `locations` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipts`
--

LOCK TABLES `receipts` WRITE;
/*!40000 ALTER TABLE `receipts` DISABLE KEYS */;
/*!40000 ALTER TABLE `receipts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipments` (
  `shipment_id` int NOT NULL AUTO_INCREMENT,
  `item_id` int DEFAULT NULL,
  `shipment_name` varchar(255) NOT NULL,
  `staging_location_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `comments` text,
  `inspect` tinyint(1) DEFAULT NULL,
  `transaction_number` int DEFAULT NULL,
  `status` varchar(255) DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`shipment_id`),
  KEY `staging_location_id` (`staging_location_id`),
  KEY `uom_id` (`uom_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`staging_location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `shipments_ibfk_2` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`),
  CONSTRAINT `shipments_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouses` (
  `warehouse_id` int NOT NULL AUTO_INCREMENT,
  `warehouse_name` varchar(255) NOT NULL,
  `description` text,
  `address_line1` varchar(255) DEFAULT NULL,
  `address_line2` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `temperature_controlled` varchar(20) DEFAULT NULL,
  `security_level` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `warehouses_ibfk_1` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` VALUES (15,'Opera Central Warehouse','Main warehouse for storing raw materials and finished goods.','123 Opera St.','Suite 101','New York','New York','10001','USA',10000,NULL,'Normal','High','2025-03-04 14:27:33','2025-03-04 14:27:33',1,1),(16,'Opera West Warehouse','Secondary warehouse for overflow stock and seasonal items.','456 West Ave.','Floor 2','Los Angeles','California','90001','USA',8000,NULL,'Normal','Med','2025-03-04 14:27:33','2025-03-04 14:27:33',1,1),(17,'Opera East Warehouse','Warehouse for distribution to the East Coast region.','789 East Blvd.','Unit A','Chicago','Illinois','60007','USA',12000,NULL,'Cold','High','2025-03-04 14:27:33','2025-03-04 14:27:33',1,1),(18,'Opera European Warehouse','European warehouse for storing inventory for EU operations.','12 Opera Rd.','Building B','Berlin','Berlin','10115','Germany',15000,NULL,'Warm','Low','2025-03-04 14:27:33','2025-03-04 14:27:33',1,1),(19,'Opera Asia Pacific Warehouse','Warehouse serving the Asia Pacific region.','35 Asia Park','Block 3','Singapore','Singapore','530035','Singapore',20000,NULL,'Normal','High','2025-03-04 14:27:33','2025-03-04 14:27:33',1,1);
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zones`
--

DROP TABLE IF EXISTS `zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zones` (
  `zone_id` int NOT NULL AUTO_INCREMENT,
  `location_id` int DEFAULT NULL,
  `zone_name` varchar(100) NOT NULL,
  `description` text,
  `capacity` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`zone_id`),
  KEY `location_id` (`location_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `zones_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`) ON DELETE CASCADE,
  CONSTRAINT `zones_ibfk_2` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zones`
--

LOCK TABLES `zones` WRITE;
/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
INSERT INTO `zones` VALUES (30,20,'Storage Zone','Main aisle for storing raw materials and finished goods.',2500,NULL,'2025-03-04 14:36:37','2025-03-04 14:39:36',1,1),(31,20,'Overflow Zone','Aisle for seasonal and overflow items storage.',1500,NULL,'2025-03-04 14:36:37','2025-03-04 14:39:54',1,1),(32,21,'Temporary Zone','Aisle for overflow and seasonal storage.',2000,NULL,'2025-03-04 14:36:37','2025-03-04 14:40:12',1,1),(33,21,'Peak Time Zone','Aisle for excess stock during peak seasons.',1000,NULL,'2025-03-04 14:36:37','2025-03-04 14:40:36',1,1),(34,22,'Receiving Zone','Receiving area for incoming goods and shipments.',3000,NULL,'2025-03-04 14:36:37','2025-03-04 14:36:37',1,1),(35,22,'Sorting Zone','Sorting area for dispatch and organization of goods.',2000,NULL,'2025-03-04 14:36:37','2025-03-04 14:36:37',1,1),(36,23,'Receiving Zone','Receiving and inspection area for European goods.',3500,NULL,'2025-03-04 14:36:37','2025-03-04 14:36:37',1,1),(37,23,'Sorting Zone','Sorting and packaging area for European shipments.',2500,NULL,'2025-03-04 14:36:37','2025-03-04 14:36:37',1,1),(38,24,'Receiving Zone','Receiving area for Asia Pacific region shipments.',4000,NULL,'2025-03-04 14:36:37','2025-03-04 14:36:37',1,1),(39,24,'Sorting Zone','Sorting and dispatch area for Asia Pacific shipments.',3000,NULL,'2025-03-04 14:36:37','2025-03-04 14:36:37',1,1);
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `pur`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `pur` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `pur`;

--
-- Table structure for table `auto_purchase_log`
--

DROP TABLE IF EXISTS `auto_purchase_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auto_purchase_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `execution_id` varchar(50) NOT NULL,
  `purchase_header_id` int NOT NULL,
  `purchase_invoice_id` int NOT NULL,
  `po_header_prev_status` varchar(50) NOT NULL,
  `po_header_update_status` varchar(50) NOT NULL,
  `purchase_invoice_status` varchar(50) NOT NULL,
  `auto_purchase_status` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_by` int NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `execution_id` (`execution_id`),
  KEY `purchase_header_id` (`purchase_header_id`),
  KEY `purchase_invoice_id` (`purchase_invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto_purchase_log`
--

LOCK TABLES `auto_purchase_log` WRITE;
/*!40000 ALTER TABLE `auto_purchase_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_purchase_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_header`
--

DROP TABLE IF EXISTS `purchase_order_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_header` (
  `header_id` int NOT NULL AUTO_INCREMENT,
  `po_num` int NOT NULL,
  `company_id` int NOT NULL,
  `department_id` int DEFAULT NULL,
  `rfq_header_id` int DEFAULT NULL,
  `po_date` date NOT NULL,
  `supplier_id` int NOT NULL,
  `currency_id` int NOT NULL,
  `tax_id` int DEFAULT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`header_id`),
  UNIQUE KEY `po_num` (`po_num`),
  KEY `company_id` (`company_id`),
  KEY `po_num_2` (`po_num`),
  KEY `department_id` (`department_id`),
  KEY `rfq_header_id` (`rfq_header_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `currency_id` (`currency_id`),
  KEY `tax_id` (`tax_id`),
  KEY `status` (`status`),
  CONSTRAINT `purchase_order_header_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `com`.`company` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_order_header_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `com`.`department` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_order_header_ibfk_3` FOREIGN KEY (`rfq_header_id`) REFERENCES `rfq_header` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_order_header_ibfk_4` FOREIGN KEY (`supplier_id`) REFERENCES `com`.`businesspartner` (`partnerid`) ON DELETE CASCADE,
  CONSTRAINT `purchase_order_header_ibfk_5` FOREIGN KEY (`currency_id`) REFERENCES `com`.`currency` (`currency_id`),
  CONSTRAINT `purchase_order_header_ibfk_6` FOREIGN KEY (`tax_id`) REFERENCES `com`.`tax` (`tax_id`)
) ENGINE=InnoDB AUTO_INCREMENT=601 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_header`
--

LOCK TABLES `purchase_order_header` WRITE;
/*!40000 ALTER TABLE `purchase_order_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_line`
--

DROP TABLE IF EXISTS `purchase_order_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_line` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `header_id` int NOT NULL,
  `po_lnum` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `line_total` decimal(15,2) NOT NULL,
  `uom_id` int DEFAULT NULL,
  `tax_id` int DEFAULT NULL,
  `notes` text,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `po_lnum` (`po_lnum`),
  KEY `header_id` (`header_id`),
  KEY `po_lnum_2` (`po_lnum`),
  KEY `item_id` (`item_id`),
  KEY `uom_id` (`uom_id`),
  KEY `tax_id` (`tax_id`),
  KEY `status` (`status`),
  CONSTRAINT `purchase_order_line_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `purchase_order_header` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_order_line_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_order_line_ibfk_3` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`),
  CONSTRAINT `purchase_order_line_ibfk_4` FOREIGN KEY (`tax_id`) REFERENCES `com`.`tax` (`tax_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_line`
--

LOCK TABLES `purchase_order_line` WRITE;
/*!40000 ALTER TABLE `purchase_order_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requisition_header`
--

DROP TABLE IF EXISTS `requisition_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requisition_header` (
  `header_id` int NOT NULL AUTO_INCREMENT,
  `req_num` int NOT NULL,
  `company_id` int NOT NULL,
  `department_id` int NOT NULL,
  `requisition_date` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`header_id`),
  UNIQUE KEY `req_num` (`req_num`),
  KEY `company_id` (`company_id`),
  KEY `department_id` (`department_id`),
  KEY `req_num_2` (`req_num`),
  KEY `status` (`status`),
  CONSTRAINT `requisition_header_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `com`.`company` (`id`) ON DELETE CASCADE,
  CONSTRAINT `requisition_header_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `com`.`department` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requisition_header`
--

LOCK TABLES `requisition_header` WRITE;
/*!40000 ALTER TABLE `requisition_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `requisition_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requisition_line`
--

DROP TABLE IF EXISTS `requisition_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requisition_line` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `req_lnum` int NOT NULL,
  `header_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `currency_id` int DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `req_lnum` (`req_lnum`),
  KEY `header_id` (`header_id`),
  KEY `req_lnum_2` (`req_lnum`),
  KEY `item_id` (`item_id`),
  KEY `currency_id` (`currency_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `requisition_line_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `requisition_header` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `requisition_line_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `requisition_line_ibfk_3` FOREIGN KEY (`currency_id`) REFERENCES `com`.`currency` (`currency_id`),
  CONSTRAINT `requisition_line_ibfk_4` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=300001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requisition_line`
--

LOCK TABLES `requisition_line` WRITE;
/*!40000 ALTER TABLE `requisition_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `requisition_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rfq_header`
--

DROP TABLE IF EXISTS `rfq_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rfq_header` (
  `header_id` int NOT NULL AUTO_INCREMENT,
  `rfq_num` int NOT NULL,
  `company_id` int NOT NULL,
  `department_id` int NOT NULL,
  `req_header_id` int DEFAULT NULL,
  `rfq_date` date NOT NULL,
  `supplier_id` int NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`header_id`),
  UNIQUE KEY `rfq_num` (`rfq_num`),
  KEY `company_id` (`company_id`),
  KEY `department_id` (`department_id`),
  KEY `rfq_num_2` (`rfq_num`),
  KEY `req_header_id` (`req_header_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `status` (`status`),
  CONSTRAINT `rfq_header_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `com`.`company` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rfq_header_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `com`.`department` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rfq_header_ibfk_3` FOREIGN KEY (`req_header_id`) REFERENCES `requisition_header` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `rfq_header_ibfk_4` FOREIGN KEY (`supplier_id`) REFERENCES `com`.`businesspartner` (`partnerid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rfq_header`
--

LOCK TABLES `rfq_header` WRITE;
/*!40000 ALTER TABLE `rfq_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `rfq_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rfq_line`
--

DROP TABLE IF EXISTS `rfq_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rfq_line` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `header_id` int NOT NULL,
  `rfq_lnum` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `uom_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `rfq_lnum` (`rfq_lnum`),
  KEY `header_id` (`header_id`),
  KEY `rfq_lnum_2` (`rfq_lnum`),
  KEY `item_id` (`item_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `rfq_line_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `rfq_header` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `rfq_line_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `rfq_line_ibfk_3` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=500001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rfq_line`
--

LOCK TABLES `rfq_line` WRITE;
/*!40000 ALTER TABLE `rfq_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `rfq_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rfq_response_header`
--

DROP TABLE IF EXISTS `rfq_response_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rfq_response_header` (
  `header_id` int NOT NULL AUTO_INCREMENT,
  `rfq_header_id` int DEFAULT NULL,
  `resp_num` int NOT NULL,
  `supplier_id` int NOT NULL,
  `response_date` date NOT NULL,
  `currency_id` int DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`header_id`),
  UNIQUE KEY `resp_num` (`resp_num`),
  KEY `rfq_header_id` (`rfq_header_id`),
  KEY `resp_num_2` (`resp_num`),
  KEY `supplier_id` (`supplier_id`),
  KEY `currency_id` (`currency_id`),
  KEY `status` (`status`),
  CONSTRAINT `rfq_response_header_ibfk_1` FOREIGN KEY (`rfq_header_id`) REFERENCES `rfq_header` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `rfq_response_header_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `com`.`businesspartner` (`partnerid`) ON DELETE CASCADE,
  CONSTRAINT `rfq_response_header_ibfk_3` FOREIGN KEY (`currency_id`) REFERENCES `com`.`currency` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rfq_response_header`
--

LOCK TABLES `rfq_response_header` WRITE;
/*!40000 ALTER TABLE `rfq_response_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `rfq_response_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rfq_response_line`
--

DROP TABLE IF EXISTS `rfq_response_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rfq_response_line` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `header_id` int NOT NULL,
  `resp_lnum` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `uom_id` int DEFAULT NULL,
  `quoted_price` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `resp_lnum` (`resp_lnum`),
  KEY `header_id` (`header_id`),
  KEY `resp_lnum_2` (`resp_lnum`),
  KEY `item_id` (`item_id`),
  KEY `uom_id` (`uom_id`),
  CONSTRAINT `rfq_response_line_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `rfq_response_header` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `rfq_response_line_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `rfq_response_line_ibfk_3` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rfq_response_line`
--

LOCK TABLES `rfq_response_line` WRITE;
/*!40000 ALTER TABLE `rfq_response_line` DISABLE KEYS */;
/*!40000 ALTER TABLE `rfq_response_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `sal`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `sal`;

--
-- Table structure for table `auto_invoice_log`
--

DROP TABLE IF EXISTS `auto_invoice_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auto_invoice_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `execution_id` varchar(50) NOT NULL,
  `sales_header_id` int NOT NULL,
  `invoice_header_id` int NOT NULL,
  `so_header_prev_status` varchar(50) NOT NULL,
  `so_header_update_status` varchar(50) NOT NULL,
  `sales_invoice_status` varchar(50) NOT NULL,
  `auto_inv_status` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_by` int NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `execution_id` (`execution_id`),
  KEY `sales_header_id` (`sales_header_id`),
  KEY `invoice_header_id` (`invoice_header_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto_invoice_log`
--

LOCK TABLES `auto_invoice_log` WRITE;
/*!40000 ALTER TABLE `auto_invoice_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_invoice_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `discount_id` int NOT NULL AUTO_INCREMENT,
  `discount_name` varchar(100) NOT NULL,
  `discount_type` varchar(50) NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_order_amount` decimal(15,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `description` text,
  `customer_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`discount_id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_item_id` (`item_id`),
  CONSTRAINT `discounts_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `com`.`businesspartner` (`partnerid`) ON DELETE SET NULL,
  CONSTRAINT `discounts_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leads`
--

DROP TABLE IF EXISTS `leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leads` (
  `lead_id` int NOT NULL AUTO_INCREMENT,
  `lead_source` varchar(100) DEFAULT NULL,
  `lead_status` varchar(50) DEFAULT NULL,
  `rep_id` int DEFAULT NULL,
  `lead_name` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `email_id` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `industry` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`lead_id`),
  KEY `idx_rep_id` (`rep_id`),
  CONSTRAINT `leads_ibfk_1` FOREIGN KEY (`rep_id`) REFERENCES `sales_representatives` (`rep_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8500 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leads`
--

LOCK TABLES `leads` WRITE;
/*!40000 ALTER TABLE `leads` DISABLE KEYS */;
/*!40000 ALTER TABLE `leads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opportunities`
--

DROP TABLE IF EXISTS `opportunities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opportunities` (
  `opportunity_id` int NOT NULL AUTO_INCREMENT,
  `lead_id` int DEFAULT NULL,
  `opportunity_name` varchar(255) DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `rep_id` int DEFAULT NULL,
  `expected_revenue` decimal(15,2) DEFAULT NULL,
  `probability` decimal(5,2) DEFAULT NULL,
  `close_date` date DEFAULT NULL,
  `sales_stage` varchar(50) DEFAULT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`opportunity_id`),
  KEY `idx_company_id` (`company_id`),
  KEY `idx_department_id` (`department_id`),
  KEY `idx_lead_id` (`lead_id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_rep_id` (`rep_id`),
  CONSTRAINT `opportunities_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`lead_id`) ON DELETE CASCADE,
  CONSTRAINT `opportunities_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `com`.`businesspartner` (`partnerid`) ON DELETE CASCADE,
  CONSTRAINT `opportunities_ibfk_3` FOREIGN KEY (`rep_id`) REFERENCES `sales_representatives` (`rep_id`) ON DELETE CASCADE,
  CONSTRAINT `opportunities_ibfk_4` FOREIGN KEY (`company_id`) REFERENCES `com`.`company` (`id`) ON DELETE CASCADE,
  CONSTRAINT `opportunities_ibfk_5` FOREIGN KEY (`department_id`) REFERENCES `com`.`department` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opportunities`
--

LOCK TABLES `opportunities` WRITE;
/*!40000 ALTER TABLE `opportunities` DISABLE KEYS */;
/*!40000 ALTER TABLE `opportunities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opportunity_lines`
--

DROP TABLE IF EXISTS `opportunity_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opportunity_lines` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `opportunity_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `quantity` decimal(10,2) DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `line_total` decimal(15,2) DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `tax_id` int DEFAULT NULL,
  `notes` text,
  `status` varchar(50) DEFAULT NULL,
  `discount_id` int DEFAULT NULL,
  `promotion_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  KEY `idx_opportunity_id` (`opportunity_id`),
  KEY `idx_item_id` (`item_id`),
  KEY `idx_discount_id` (`discount_id`),
  KEY `idx_promotion_id` (`promotion_id`),
  KEY `uom_id` (`uom_id`),
  KEY `tax_id` (`tax_id`),
  CONSTRAINT `opportunity_lines_ibfk_1` FOREIGN KEY (`opportunity_id`) REFERENCES `opportunities` (`opportunity_id`) ON DELETE CASCADE,
  CONSTRAINT `opportunity_lines_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `opportunity_lines_ibfk_3` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`),
  CONSTRAINT `opportunity_lines_ibfk_4` FOREIGN KEY (`tax_id`) REFERENCES `com`.`tax` (`tax_id`),
  CONSTRAINT `opportunity_lines_ibfk_5` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`discount_id`) ON DELETE SET NULL,
  CONSTRAINT `opportunity_lines_ibfk_6` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`promotion_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=70001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opportunity_lines`
--

LOCK TABLES `opportunity_lines` WRITE;
/*!40000 ALTER TABLE `opportunity_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `opportunity_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pick_release_log`
--

DROP TABLE IF EXISTS `pick_release_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pick_release_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `execution_id` varchar(50) NOT NULL,
  `sales_header_id` int NOT NULL,
  `sales_order_line_id` int NOT NULL,
  `sales_item_id` int NOT NULL,
  `sales_uom_id` int NOT NULL,
  `sales_uom_id_quantity` decimal(10,2) NOT NULL,
  `sales_base_uom_id` int NOT NULL,
  `sales_base_uom_quantity` decimal(10,2) NOT NULL,
  `already_picked_quantity` decimal(10,2) DEFAULT NULL,
  `sales_line_status` varchar(50) NOT NULL,
  `sales_line_new_status` varchar(50) DEFAULT NULL,
  `inventory_id` int DEFAULT NULL,
  `picked_quantity` decimal(10,2) NOT NULL,
  `pick_release_status` enum('RELEASED','REVERSED') DEFAULT 'RELEASED',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  PRIMARY KEY (`log_id`),
  UNIQUE KEY `execution_id` (`execution_id`),
  KEY `execution_id_2` (`execution_id`),
  KEY `sales_header_id` (`sales_header_id`),
  KEY `sales_order_line_id` (`sales_order_line_id`),
  KEY `sales_item_id` (`sales_item_id`),
  KEY `inventory_id` (`inventory_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pick_release_log`
--

LOCK TABLES `pick_release_log` WRITE;
/*!40000 ALTER TABLE `pick_release_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `pick_release_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotions` (
  `promotion_id` int NOT NULL AUTO_INCREMENT,
  `promotion_name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `promotion_type` varchar(50) NOT NULL,
  `promotion_value` decimal(10,2) NOT NULL,
  `min_order_amount` decimal(15,2) NOT NULL,
  `max_usage_limit` int DEFAULT NULL,
  `description` text,
  `customer_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`promotion_id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_item_id` (`item_id`),
  CONSTRAINT `promotions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `com`.`businesspartner` (`partnerid`) ON DELETE SET NULL,
  CONSTRAINT `promotions_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_headers`
--

DROP TABLE IF EXISTS `sales_order_headers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_order_headers` (
  `header_id` int NOT NULL AUTO_INCREMENT,
  `so_num` int NOT NULL,
  `opportunity_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `so_date` date DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `payment_terms` varchar(100) DEFAULT NULL,
  `shipping_method` varchar(100) DEFAULT NULL,
  `billing_address` text,
  `shipping_address` text,
  `rep_id` int DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `tax_id` int DEFAULT NULL,
  `comments` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`header_id`),
  UNIQUE KEY `so_num` (`so_num`),
  KEY `idx_opportunity_id` (`opportunity_id`),
  KEY `idx_company_id` (`company_id`),
  KEY `idx_department_id` (`department_id`),
  KEY `idx_customer_id` (`customer_id`),
  KEY `idx_rep_id` (`rep_id`),
  KEY `idx_tax_id` (`tax_id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `sales_order_headers_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `com`.`company` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sales_order_headers_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `com`.`currency` (`currency_id`),
  CONSTRAINT `sales_order_headers_ibfk_3` FOREIGN KEY (`department_id`) REFERENCES `com`.`department` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sales_order_headers_ibfk_4` FOREIGN KEY (`customer_id`) REFERENCES `com`.`businesspartner` (`partnerid`) ON DELETE CASCADE,
  CONSTRAINT `sales_order_headers_ibfk_5` FOREIGN KEY (`tax_id`) REFERENCES `com`.`tax` (`tax_id`),
  CONSTRAINT `sales_order_headers_ibfk_6` FOREIGN KEY (`rep_id`) REFERENCES `sales_representatives` (`rep_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_headers`
--

LOCK TABLES `sales_order_headers` WRITE;
/*!40000 ALTER TABLE `sales_order_headers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_headers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_order_lines`
--

DROP TABLE IF EXISTS `sales_order_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_order_lines` (
  `line_id` int NOT NULL AUTO_INCREMENT,
  `header_id` int DEFAULT NULL,
  `so_lnum` int NOT NULL,
  `item_id` int DEFAULT NULL,
  `quantity` decimal(10,2) DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `line_total` decimal(15,2) DEFAULT NULL,
  `uom_id` int DEFAULT NULL,
  `notes` text,
  `status` varchar(50) DEFAULT NULL,
  `discount_id` int DEFAULT NULL,
  `promotion_id` int DEFAULT NULL,
  `base_uom_id` int DEFAULT NULL,
  `base_quantity` decimal(10,2) DEFAULT NULL,
  `picked_quantity` decimal(10,2) DEFAULT NULL,
  `uom_conversion_factor` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`line_id`),
  UNIQUE KEY `so_lnum` (`so_lnum`),
  KEY `idx_header_id` (`header_id`),
  KEY `idx_item_id` (`item_id`),
  KEY `idx_uom_id` (`uom_id`),
  KEY `idx_discount_id` (`discount_id`),
  KEY `idx_promotion_id` (`promotion_id`),
  KEY `idx_base_uom_id` (`base_uom_id`),
  CONSTRAINT `sales_order_lines_ibfk_1` FOREIGN KEY (`header_id`) REFERENCES `sales_order_headers` (`header_id`) ON DELETE CASCADE,
  CONSTRAINT `sales_order_lines_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `com`.`items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `sales_order_lines_ibfk_3` FOREIGN KEY (`uom_id`) REFERENCES `com`.`uom` (`uom_id`),
  CONSTRAINT `sales_order_lines_ibfk_4` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`discount_id`) ON DELETE SET NULL,
  CONSTRAINT `sales_order_lines_ibfk_5` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`promotion_id`) ON DELETE SET NULL,
  CONSTRAINT `sales_order_lines_ibfk_6` FOREIGN KEY (`base_uom_id`) REFERENCES `com`.`uom` (`uom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_order_lines`
--

LOCK TABLES `sales_order_lines` WRITE;
/*!40000 ALTER TABLE `sales_order_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_order_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_representatives`
--

DROP TABLE IF EXISTS `sales_representatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_representatives` (
  `rep_id` int NOT NULL AUTO_INCREMENT,
  `rep_name` varchar(100) NOT NULL,
  `email_id` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `department_id` int DEFAULT NULL,
  `empid` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`rep_id`),
  KEY `idx_department_id` (`department_id`),
  KEY `idx_empid` (`empid`),
  CONSTRAINT `sales_representatives_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `com`.`department` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sales_representatives_ibfk_2` FOREIGN KEY (`empid`) REFERENCES `com`.`employee` (`empid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_representatives`
--

LOCK TABLES `sales_representatives` WRITE;
/*!40000 ALTER TABLE `sales_representatives` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_representatives` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-04 20:11:57
