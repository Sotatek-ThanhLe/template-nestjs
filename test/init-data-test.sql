-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: fcx
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `coins`
--

DROP TABLE IF EXISTS `coins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coins` (
                         `id` int unsigned NOT NULL AUTO_INCREMENT,
                         `warp_type_id` int NOT NULL DEFAULT '1',
                         `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `stellar_issuer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `bsc_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `decimal` int NOT NULL,
                         `type` int NOT NULL COMMENT 'Stellar asset type: 1-native,2-credit_alphanum4,3-credit_alphanum12',
                         `is_active` tinyint NOT NULL DEFAULT '1' COMMENT '1 - active, 0 -deactive',
                         `is_new` tinyint(1) DEFAULT '0',
                         `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coins`
--

LOCK TABLES `coins` WRITE;
/*!40000 ALTER TABLE `coins` DISABLE KEYS */;
INSERT INTO `coins` VALUES (1,1,'vUSD','vUSD','GAXXMQMTDUQ4YEPXJMKFBGN3GETPJNEXEUHFCQJKGJDVI3XQCNBU3OZI','0x6dEeeebCf2b03a1078D1FC624bdC57a667BF31d0',18,2,1,0,'2021-07-07 02:13:42','2021-07-07 02:13:42'),(2,1,'vTHB','vTHB','GAXXMQMTDUQ4YEPXJMKFBGN3GETPJNEXEUHFCQJKGJDVI3XQCNBU3OZI','0xdBa79A8049F52565de7Bc190d5B56a21A5959459',18,2,1,0,'2021-07-07 02:13:42','2021-07-07 02:13:42'),(3,1,'vEUR','vEUR','GAXXMQMTDUQ4YEPXJMKFBGN3GETPJNEXEUHFCQJKGJDVI3XQCNBU3OZI','0x7b47880B3B14Ec45023E2240C1f5358b0165FfD7',18,2,1,0,'2021-07-24 14:44:20','2021-07-24 14:44:20'),(4,1,'vSGD','vSGD','GAXXMQMTDUQ4YEPXJMKFBGN3GETPJNEXEUHFCQJKGJDVI3XQCNBU3OZI','0x332A96a808cfe9E3560E0d261d8b047bb6B85b4D',18,2,1,0,'2021-07-30 15:13:00','2021-07-30 15:13:00'),(5,1,'vCHF','vCHF','GAXXMQMTDUQ4YEPXJMKFBGN3GETPJNEXEUHFCQJKGJDVI3XQCNBU3OZI','0x1FDEe622a8c058923e4d006c3edeE14a0634E9d2',18,2,1,0,'2021-07-30 15:13:00','2021-07-30 15:13:00'),(6,1,'USDT','USDT','GAXXMQMTDUQ4YEPXJMKFBGN3GETPJNEXEUHFCQJKGJDVI3XQCNBU3OZI','0x84544B0815279361676Fd147dAd60a912D8CaAc0',18,2,1,0,'2021-07-30 08:17:44','2021-07-30 15:13:00');
/*!40000 ALTER TABLE `coins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_interval`
--

DROP TABLE IF EXISTS `config_interval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_interval` (
                                   `id` int unsigned NOT NULL AUTO_INCREMENT,
                                   `type` tinyint NOT NULL COMMENT '1 - volatility, 2 - confidence',
                                   `user_id` int NOT NULL,
                                   `interval` int DEFAULT NULL,
                                   `type_convert` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'minute',
                                   `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                   `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                   PRIMARY KEY (`id`),
                                   KEY `IDX_4411911ddfc4aaa20396cb5d74` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_interval`
--

LOCK TABLES `config_interval` WRITE;
/*!40000 ALTER TABLE `config_interval` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_interval` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `functional_currencies`
--

DROP TABLE IF EXISTS `functional_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `functional_currencies` (
                                         `id` int unsigned NOT NULL AUTO_INCREMENT,
                                         `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `iso_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `digital_credits` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `fractional_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
                                         `number_basic` int NOT NULL DEFAULT '0',
                                         `is_active` tinyint NOT NULL DEFAULT '1' COMMENT '1 - active, 0 -deactive',
                                         `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                         `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                         PRIMARY KEY (`id`),
                                         UNIQUE KEY `UQ_69539a697bb44c1493dc091d68e` (`currency`),
                                         UNIQUE KEY `UQ_b18c6a7807d6f1be4ef770b3bce` (`iso_code`),
                                         UNIQUE KEY `UQ_eef8a86bf67ababb6d5c128c88c` (`digital_credits`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functional_currencies`
--

LOCK TABLES `functional_currencies` WRITE;
/*!40000 ALTER TABLE `functional_currencies` DISABLE KEYS */;
INSERT INTO `functional_currencies` VALUES (1,'USD','$','USD','vUSD','0',1,1,'2021-08-14 16:59:20','2021-08-14 16:59:20'),(2,'EUR','€','EUR','vEUR','0',2,1,'2021-08-14 16:59:20','2021-08-14 16:59:20'),(3,'THB','฿','THB','vTHB','0',3,1,'2021-08-14 16:59:20','2021-08-14 16:59:20'),(4,'SGD','$','SGD','vSGD','0',4,1,'2021-08-14 16:59:20','2021-08-14 16:59:20'),(5,'CHF','Fr.','CHF','vCHF','0',5,1,'2021-08-14 16:59:20','2021-08-14 16:59:20'),(6,'JPY','¥','JPY','vJPY','0',6,1,'2021-08-14 16:59:20','2021-08-14 16:59:20'),(7,'GBP','£','GBP','vGBP','0',7,1,'2021-08-14 16:59:20','2021-08-14 16:59:20'),(8,'CNY (CNH)','¥','CNY','vCNY','0',8,1,'2021-08-14 16:59:20','2021-08-14 16:59:20'),(9,'KRW','₩','KRW','vKRW','0',9,1,'2021-08-14 16:59:20','2021-08-14 16:59:20'),(10,'TWD','$','TWD','vTWD','0',10,1,'2021-08-14 16:59:20','2021-08-14 16:59:20');
/*!40000 ALTER TABLE `functional_currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `functional_currency_users`
--

DROP TABLE IF EXISTS `functional_currency_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `functional_currency_users` (
                                             `id` int unsigned NOT NULL AUTO_INCREMENT,
                                             `currency_id` int NOT NULL,
                                             `user_id` int NOT NULL,
                                             `is_active` tinyint NOT NULL DEFAULT '1' COMMENT '1 - active, 0 -deactive',
                                             `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                             `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                             PRIMARY KEY (`id`),
                                             UNIQUE KEY `user_id` (`user_id`,`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functional_currency_users`
--

LOCK TABLES `functional_currency_users` WRITE;
/*!40000 ALTER TABLE `functional_currency_users` DISABLE KEYS */;
INSERT INTO `functional_currency_users` VALUES (4,1,5,1,'2021-07-28 03:20:32','2021-07-28 03:20:32'),(13,1,18,1,'2021-07-29 01:48:15','2021-07-29 01:48:15'),(413,5,149,2,'2021-08-24 09:32:27','2021-08-24 09:32:27'),(1912,1,191,2,'2021-09-08 07:23:54','2021-09-08 07:23:54'),(12222,1,4,2,'2021-09-29 17:33:50','2021-09-29 17:33:50'),(12223,2,4,1,'2021-09-29 17:33:50','2021-09-29 17:33:50'),(12224,3,4,1,'2021-09-29 17:33:50','2021-09-29 17:33:50'),(12225,4,4,1,'2021-09-29 17:33:50','2021-09-29 17:33:50'),(12226,5,4,1,'2021-09-29 17:33:50','2021-09-29 17:33:50'),(12227,6,4,1,'2021-09-29 17:33:50','2021-09-29 17:33:50'),(12228,7,4,1,'2021-09-29 17:33:50','2021-09-29 17:33:50'),(12229,8,4,1,'2021-09-29 17:33:50','2021-09-29 17:33:50'),(12230,9,4,1,'2021-09-29 17:33:50','2021-09-29 17:33:50'),(12231,10,4,1,'2021-09-29 17:33:50','2021-09-29 17:33:50');
/*!40000 ALTER TABLE `functional_currency_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gradually`
--

DROP TABLE IF EXISTS `gradually`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gradually` (
                             `pool_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                             `start_block` int NOT NULL,
                             `end_block` int NOT NULL,
                             `old_weights` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                             `new_weights` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                             PRIMARY KEY (`pool_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gradually`
--

LOCK TABLES `gradually` WRITE;
/*!40000 ALTER TABLE `gradually` DISABLE KEYS */;
INSERT INTO `gradually` VALUES ('0x264b257eafe1ea003521817dbaf65c647a70a90e',12238800,12238840,'1000000000000000000,1000000000000000000,1000000000000000000','1000000000000000000,1000000000000000000,1000000000000000000'),('0x418c2cb9fad788c60a7aff1e3b18509f22f0f28b',12128534,12128550,'1','2'),('0x7eb11affa8a30a02ff0b022681c75f551e763172',12128914,12128950,'2000000000000000000,4000000000000000000,','2000000000000000000,4000000000000000000,'),('0x82567f3f6c3261cd1a3608338140b5f83cde05b5',12271340,12271390,'6000000000000000000,10000000000000000000,12000000000000000000,10000000000000000000,8000000000000000000,3000000000000000000','6000000000000000000,10000000000000000000,12000000000000000000,10000000000000000000,8000000000000000000,3000000000000000000'),('0x85ad011d4095b6dcb86f407deed2d73e8e1f0bd8',12130114,12130200,'2000000000000000000,2000000000000000000','10000000000000000000,2000000000000000000'),('0x8e18e9858b0b20125d8ecb413d6ba39358adaa6b',12612178,12612220,'12000000000000000000,13000000000000000000','12000000000000000000,13000000000000000000'),('0x90bfef9e36f1f0c6ac26336a5343dfb3705b53e5',12694080,12694100,'20000000000000000000,10000000000000000000','20000000000000000000,2000000000000000000'),('0xa1ceaf938bcb6d7eeb5e25647300de124999c700',12213356,12213400,'2000000000000000000,2000000000000000000','2000000000000000000,2000000000000000000'),('1',1,2,'1,2,3','4,5,6'),('2',0,0,'1,2,3','1,2,3'),('string',0,0,'string','string');
/*!40000 ALTER TABLE `gradually` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_logs`
--

DROP TABLE IF EXISTS `history_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_logs` (
                                `id` int unsigned NOT NULL AUTO_INCREMENT,
                                `activity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                `admin_id` int NOT NULL,
                                `wallet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                `activities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1684 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_logs`
--

LOCK TABLES `history_logs` WRITE;
/*!40000 ALTER TABLE `history_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interval_settings`
--

DROP TABLE IF EXISTS `interval_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interval_settings` (
                                     `interval` int NOT NULL,
                                     `by_the_interval` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                     `interval_str` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                     `annualized` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                     `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     PRIMARY KEY (`interval`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interval_settings`
--

LOCK TABLES `interval_settings` WRITE;
/*!40000 ALTER TABLE `interval_settings` DISABLE KEYS */;
INSERT INTO `interval_settings` VALUES (1,'0.065','1 minute','47.1238792970188295','2021-09-14 02:47:05','2021-09-14 02:47:05'),(5,'0.034','5 minutes','11.0235529662627374','2021-09-14 02:47:05','2021-09-14 02:47:05'),(15,'0.12','15 minutes','22.462769197051374','2021-09-14 02:47:05','2021-09-14 02:47:05'),(60,'0.34','1 hour','31.8222563624894482','2021-09-14 02:47:05','2021-09-14 02:47:05'),(1440,'0.006','1 day','0.1146298390472568','2021-09-14 02:47:05','2021-09-14 02:47:05'),(43200,'0.008','1 month','0.0277128129211020352','2021-09-14 02:47:05','2021-09-14 02:47:05');
/*!40000 ALTER TABLE `interval_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `latest_block`
--

DROP TABLE IF EXISTS `latest_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `latest_block` (
                                `network` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                `block` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                `status` tinyint DEFAULT NULL,
                                UNIQUE KEY `CURRENCY_TYPE_UNIQUE` (`network`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `latest_block`
--

LOCK TABLES `latest_block` WRITE;
/*!40000 ALTER TABLE `latest_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `latest_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_histories`
--

DROP TABLE IF EXISTS `login_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_histories` (
                                   `id` int unsigned NOT NULL AUTO_INCREMENT,
                                   `user_id` int NOT NULL,
                                   `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `device` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                   `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3906 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_histories`
--

LOCK TABLES `login_histories` WRITE;
/*!40000 ALTER TABLE `login_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrate_tables`
--

DROP TABLE IF EXISTS `migrate_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrate_tables` (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `timestamp` bigint NOT NULL,
                                  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrate_tables`
--

LOCK TABLES `migrate_tables` WRITE;
/*!40000 ALTER TABLE `migrate_tables` DISABLE KEYS */;
INSERT INTO `migrate_tables` VALUES (1,1622599517640,'users1622599517640'),(2,1622600645607,'functionalCurrencies1622600645607'),(3,1622600968479,'functionalCurrencyUsers1622600968479'),(5,1622601455570,'settings1622601455570'),(6,1622601469160,'userWallets1622601469160'),(7,1622601482938,'pairs1622601482938'),(9,1622601579366,'trades1622601579366'),(10,1623135262089,'latestBlock1623135262089'),(12,1625208077403,'loginHistories1625208077403'),(13,1626333458572,'pnls1626333458572'),(17,1626856891213,'tradingFee1626856891213'),(19,1627373646984,'transactions1627373646984'),(23,1622601497353,'orders1622601497353'),(25,1628133819635,'historyLogs1628133819635'),(30,1623224073185,'pools1623224073185'),(31,1626682874041,'poolCoin1626682874041'),(48,1630243866855,'poolPnls1630243866855'),(50,1630046676479,'notificationStatus1630046676479'),(52,1630895978527,'gradually1630895978527'),(53,1628667931442,'notifications1628667931442'),(54,1630486781471,'userSetting1630486781471'),(55,1628129957564,'intervalSettings1628129957564'),(63,1632280163981,'warps1632280163981'),(65,1634200239316,'tests1634200239316'),(66,1622601438069,'coins1622601438069'),(69,1629187974577,'configInterval1629187974577');
/*!40000 ALTER TABLE `migrate_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_status`
--

DROP TABLE IF EXISTS `notification_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_status` (
                                       `id` int unsigned NOT NULL AUTO_INCREMENT,
                                       `user_id` int NOT NULL,
                                       `notification_id` int NOT NULL,
                                       `is_read` tinyint NOT NULL DEFAULT '0' COMMENT '0- not read, 1-read',
                                       `is_show` tinyint NOT NULL DEFAULT '0' COMMENT '0- not show, 1-show',
                                       `is_trash` tinyint NOT NULL DEFAULT '0' COMMENT '0- no, 1- trash',
                                       PRIMARY KEY (`id`),
                                       UNIQUE KEY `user_id` (`user_id`,`notification_id`),
                                       KEY `IDX_d322e9904f5f05ee7391c51405` (`user_id`,`notification_id`,`is_read`,`is_show`,`is_trash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_status`
--

LOCK TABLES `notification_status` WRITE;
/*!40000 ALTER TABLE `notification_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
                                 `id` int unsigned NOT NULL AUTO_INCREMENT,
                                 `user_id` int NOT NULL,
                                 `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `show_time` datetime DEFAULT NULL,
                                 `data` json DEFAULT NULL,
                                 `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                 `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`),
                                 KEY `IDX_5cabbd2bd7d11ad677ace1bd11` (`show_time`),
                                 KEY `IDX_9a8a82462cab47c73d25f49261` (`user_id`),
                                 KEY `IDX_aef1c7aef3725068e5540f8f00` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
                          `id` int unsigned NOT NULL AUTO_INCREMENT,
                          `user_id` int NOT NULL,
                          `pair_id` int NOT NULL,
                          `type` tinyint NOT NULL DEFAULT '1' COMMENT '1-limit, 2-market',
                          `side` tinyint NOT NULL DEFAULT '1' COMMENT '1 - buy, 2 - sell',
                          `price` decimal(40,8) NOT NULL,
                          `average` decimal(40,8) DEFAULT NULL,
                          `amount` decimal(40,8) DEFAULT NULL,
                          `filled_amount` decimal(40,8) NOT NULL DEFAULT '0.00000000' COMMENT 'include fee',
                          `remaining_amount` decimal(40,8) NOT NULL COMMENT 'exclude fee',
                          `total` decimal(40,8) DEFAULT NULL,
                          `status` tinyint NOT NULL COMMENT '-1-cancel, 0-pending, 1-fillable, 2-filling, 3-fullfill',
                          `method` tinyint NOT NULL COMMENT '1-stellar-ob, 2-bsc-ob, 4-pool, 3-combined-orderbook, 7-all',
                          `fee_rate` decimal(40,8) NOT NULL,
                          `maker_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `taker_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `maker_amounts` decimal(40,8) DEFAULT NULL,
                          `taker_amounts` decimal(40,8) DEFAULT NULL,
                          `sender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `maker` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                          `taker` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `taker_token_fee_amounts` decimal(40,8) DEFAULT NULL,
                          `fee_recipient` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `signature` json DEFAULT NULL,
                          `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `order_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `stellar_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `pool_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `expiry` int unsigned DEFAULT NULL,
                          `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `UQ_2746710dc5ef006001f38032060` (`stellar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pairs`
--

DROP TABLE IF EXISTS `pairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pairs` (
                         `id` int unsigned NOT NULL AUTO_INCREMENT,
                         `base_id` int NOT NULL,
                         `quote_id` int NOT NULL,
                         `price_precision` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `amount_precision` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `minimum_amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `minimum_total` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `group_count` int NOT NULL,
                         `is_active` tinyint NOT NULL DEFAULT '1' COMMENT '1 - active, 0 -deactive',
                         `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pairs`
--

LOCK TABLES `pairs` WRITE;
/*!40000 ALTER TABLE `pairs` DISABLE KEYS */;
INSERT INTO `pairs` VALUES (1,3,1,'0.00001','0.01','1','1',5,1,'2021-08-07 15:24:20','2021-08-07 15:24:20'),(2,3,2,'0.0001','0.01','1','1',4,1,'2021-08-07 15:24:20','2021-08-07 15:24:20'),(3,3,4,'0.00001','0.01','1','1',5,1,'2021-08-07 15:24:20','2021-08-07 15:24:20'),(4,3,5,'0.00001','0.01','1','1',5,1,'2021-08-07 15:24:20','2021-08-07 15:24:20'),(5,1,2,'0.0001','0.01','1','1',4,1,'2021-08-07 15:24:20','2021-08-07 15:24:20'),(6,1,4,'0.00001','0.01','1','1',4,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,1,5,'0.00001','0.01','1','1',4,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,5,2,'0.0001','0.01','1','1',4,1,'2021-08-07 15:24:20','2021-08-07 15:24:20'),(9,4,2,'0.0001','0.01','1','1',4,1,'2021-08-07 15:24:20','2021-08-07 15:24:20'),(10,6,2,'0.000001','0.01','1','1',4,1,'2021-08-07 15:24:20','2021-08-07 15:24:20'),(11,6,1,'0.000001','0.01','1','1',4,1,'2021-08-07 15:24:20','2021-08-07 15:24:20');
/*!40000 ALTER TABLE `pairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pnls`
--

DROP TABLE IF EXISTS `pnls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pnls` (
                        `date` date NOT NULL,
                        `user_id` int NOT NULL,
                        `wallet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                        `symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                        `balance` decimal(40,8) NOT NULL,
                        `rate` decimal(40,8) NOT NULL,
                        `trade_amount` decimal(40,8) NOT NULL DEFAULT '0.00000000',
                        `transfer_amount` decimal(40,8) NOT NULL DEFAULT '0.00000000',
                        `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`date`,`user_id`,`wallet`,`symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pnls`
--

LOCK TABLES `pnls` WRITE;
/*!40000 ALTER TABLE `pnls` DISABLE KEYS */;
/*!40000 ALTER TABLE `pnls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pool_coins`
--

DROP TABLE IF EXISTS `pool_coins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pool_coins` (
                              `id` int unsigned NOT NULL AUTO_INCREMENT,
                              `pool_id` int NOT NULL,
                              `coin_id` int NOT NULL,
                              `weight` decimal(40,8) NOT NULL,
                              `is_active` tinyint NOT NULL DEFAULT '1' COMMENT '1 - active, 0 -deactive',
                              `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                              `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pool_coins`
--

LOCK TABLES `pool_coins` WRITE;
/*!40000 ALTER TABLE `pool_coins` DISABLE KEYS */;
INSERT INTO `pool_coins` VALUES (1,578,1,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(2,578,2,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(3,579,1,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(4,579,2,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(5,580,1,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(6,580,2,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(7,581,1,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(8,581,2,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(9,582,1,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(10,582,2,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(11,583,1,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(12,583,2,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(13,584,1,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(14,584,2,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(15,585,1,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(16,585,2,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(17,586,1,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(18,586,2,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(19,587,1,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(20,587,2,1.00000000,1,'2021-10-18 11:04:36','2021-10-18 11:04:36');
/*!40000 ALTER TABLE `pool_coins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pool_pnls`
--

DROP TABLE IF EXISTS `pool_pnls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pool_pnls` (
                             `date` date NOT NULL,
                             `user_id` int NOT NULL,
                             `wallet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                             `symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                             `pool_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                             `balance` decimal(40,8) NOT NULL,
                             `price` decimal(40,8) NOT NULL,
                             `transfer_amount` decimal(40,8) NOT NULL DEFAULT '0.00000000',
                             `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             PRIMARY KEY (`date`,`user_id`,`wallet`,`symbol`,`pool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pool_pnls`
--

LOCK TABLES `pool_pnls` WRITE;
/*!40000 ALTER TABLE `pool_pnls` DISABLE KEYS */;
/*!40000 ALTER TABLE `pool_pnls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pools`
--

DROP TABLE IF EXISTS `pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pools` (
                         `id` int unsigned NOT NULL AUTO_INCREMENT,
                         `user_id` int NOT NULL,
                         `type` tinyint NOT NULL COMMENT '1-Fixed, 2-Flexible',
                         `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `network` tinyint NOT NULL,
                         `early_withdraw_term` int NOT NULL,
                         `early_withdraw_fee` decimal(40,8) NOT NULL,
                         `swap_fee` decimal(40,8) NOT NULL,
                         `fee_ratio_velo` decimal(40,8) NOT NULL,
                         `fee_ratio_lp` decimal(40,8) NOT NULL,
                         `status` tinyint NOT NULL COMMENT '1-Pending, 2-Rejected, 3-Created',
                         `flex_right_config` json NOT NULL,
                         `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                         `pool_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=588 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pools`
--

LOCK TABLES `pools` WRITE;
/*!40000 ALTER TABLE `pools` DISABLE KEYS */;
INSERT INTO `pools` VALUES (18,4,2,'',0,0,0.00000000,3.00000000,1.00000000,2.00000000,3,'{\"canChangeCap\": false, \"canWhitelistLPs\": false, \"canChangeSwapFee\": true, \"canChangeWeights\": false, \"canPauseSwapping\": true, \"canAddRemoveTokens\": false, \"canChangeProtocolFee\": true}','HI bạn Thu',NULL,'2021-08-19 03:46:27','2021-08-19 03:46:27'),(97,4,1,'',0,0,0.00000000,3.00000000,1.00000000,2.00000000,2,'null','This field is required',NULL,'2021-09-06 02:51:47','2021-09-06 02:51:47'),(127,4,1,'',0,0,0.00000000,3.00000000,1.00000000,2.00000000,3,'null','ok ok ok ok ok ok ok ok ok ok ','0xe22dcd93b1b79ae45bddf6e010962d9b95447817','2021-09-10 17:25:41','2021-09-10 17:25:41'),(128,4,2,'',0,0,0.00000000,2.30000000,1.00000000,1.30000000,3,'{\"canChangeCap\": true, \"canWhitelistLPs\": true, \"canChangeSwapFee\": true, \"canChangeWeights\": false, \"canPauseSwapping\": false, \"canAddRemoveTokens\": false, \"canChangeProtocolFee\": false}','ok ok ok ok ok ok ok ok ok ok ','0xa33707c2db9850ac6d11f48a6f8b255323822896','2021-09-10 17:27:11','2021-09-10 17:27:11'),(129,4,1,'',0,0,0.00000000,3.00000000,1.00000000,2.00000000,3,'null','ok ok ok ok ok ok ok ok ok ok ','0xf733b3b7188eb05dcdaaf5ecd3e4f597929ea81d','2021-09-10 17:32:37','2021-09-10 17:32:37'),(130,4,1,'',0,0,0.00000000,2.30000000,1.00000000,1.30000000,2,'null','fghjdfgjdefgjf',NULL,'2021-09-10 17:53:44','2021-09-10 17:53:44'),(131,4,2,'',0,0,0.00000000,3.00000000,1.00000000,2.00000000,2,'{\"canChangeCap\": true, \"canWhitelistLPs\": false, \"canChangeSwapFee\": false, \"canChangeWeights\": false, \"canPauseSwapping\": true, \"canAddRemoveTokens\": false, \"canChangeProtocolFee\": false}','fghdfghfdfrhsd',NULL,'2021-09-10 17:55:31','2021-09-10 17:55:31'),(132,4,1,'',0,0,0.00000000,1.50000000,0.50000000,1.00000000,3,'null','asdfsdfasdfsdfsdfsd','0x4ad26ad92c217e21e6ba69be77c031bf519409ce','2021-09-10 17:59:01','2021-09-10 17:59:01'),(198,4,1,'',0,0,0.00000000,4.00000000,1.00000000,3.00000000,2,'null','aaaaaaaaaaaaaaaaaaaaaaaaaa',NULL,'2021-09-20 03:04:19','2021-09-20 03:04:19'),(199,4,1,'',0,0,0.00000000,4.00000000,1.00000000,3.00000000,3,'null','sssssssssssssssssssssssssssssssssssssss','0xc254e90d77bd06fed78a551ad3c46b9fc51a1f08','2021-09-20 03:29:44','2021-09-20 03:29:44'),(201,4,1,'',0,0,0.00000000,4.00000000,1.00000000,3.00000000,3,'null','hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh','0x4ea9559f7fec4b91217611fa266ccd58bae53086','2021-09-20 03:53:23','2021-09-20 03:53:23'),(203,4,1,'',0,0,0.00000000,4.00000000,1.00000000,3.00000000,3,'null','hhhhhhhhhhhhhhhhhhhhhhhhhhhh','0x43aa2a894d3e538de71d1418eed63893292dc427','2021-09-20 04:07:54','2021-09-20 04:07:54'),(249,4,2,'',0,0,0.00000000,20.00000000,5.00000000,15.00000000,3,'{\"canChangeCap\": false, \"canWhitelistLPs\": true, \"canChangeSwapFee\": true, \"canChangeWeights\": false, \"canPauseSwapping\": false, \"canAddRemoveTokens\": false}','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','0xd8e405c6c56d3e7820eec58529d9cf6110f9981e','2021-09-24 04:19:24','2021-09-24 04:19:24'),(250,4,2,'',0,0,0.00000000,2.00000000,0.50000000,1.50000000,3,'{\"canChangeCap\": false, \"canWhitelistLPs\": false, \"canChangeSwapFee\": false, \"canChangeWeights\": false, \"canPauseSwapping\": false, \"canAddRemoveTokens\": true}','aaaaaaaaaaaaaaaaaaaaa','0x9b233c444da05ea3c95c0efdb97560643df374f5','2021-09-24 04:28:23','2021-09-24 04:28:23'),(260,4,1,'',0,0,0.00000000,4.00000000,1.00000000,3.00000000,2,'null','dddddddddddddddd',NULL,'2021-09-25 15:09:31','2021-09-25 15:09:31'),(288,4,1,'',0,0,0.00000000,3.00000000,1.00000000,2.00000000,3,'null','aaaaaaaaaaaaaaaaaaaaaaaaaaa','0xdbfb724b3c955ead18ab9cca47dcf807ba829284','2021-09-28 06:29:25','2021-09-28 06:29:25'),(289,4,2,'',0,0,0.00000000,2.00000000,1.50000000,0.50000000,3,'{\"canChangeCap\": false, \"canWhitelistLPs\": false, \"canChangeSwapFee\": false, \"canChangeWeights\": false, \"canPauseSwapping\": true, \"canAddRemoveTokens\": false}','aaaaaaaaaaaaaaaaaaaaaaaaaaaaa','0x69d32d9cc2c60ea28d96f5be24c8b071b361c706','2021-09-28 06:29:58','2021-09-28 06:29:58'),(375,4,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-11 10:06:22','2021-10-11 10:06:22'),(578,149,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(579,149,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(580,149,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(581,149,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(582,149,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(583,149,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(584,149,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(585,149,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(586,149,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-18 11:04:36','2021-10-18 11:04:36'),(587,149,1,'',0,0,0.00000000,2.00000000,1.00000000,1.00000000,1,'null',NULL,NULL,'2021-10-18 11:04:36','2021-10-18 11:04:36');
/*!40000 ALTER TABLE `pools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
                            `id` int unsigned NOT NULL AUTO_INCREMENT,
                            `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                            `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                            `is_active` tinyint NOT NULL DEFAULT '1' COMMENT '1 - active, 0 -deactive',
                            `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `UQ_c8639b7626fa94ba8265628f214` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trades`
--

DROP TABLE IF EXISTS `trades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trades` (
                          `id` int unsigned NOT NULL AUTO_INCREMENT,
                          `pair_id` int NOT NULL,
                          `buy_user_id` int NOT NULL,
                          `sell_user_id` int NOT NULL,
                          `buy_order_id` int NOT NULL,
                          `sell_order_id` int NOT NULL,
                          `price` decimal(40,8) NOT NULL,
                          `filled_amount` decimal(40,8) NOT NULL,
                          `sell_fee` decimal(40,8) NOT NULL,
                          `buy_fee` decimal(40,8) NOT NULL,
                          `buyer_is_taker` tinyint(1) NOT NULL,
                          `buy_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                          `sell_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                          `method` tinyint NOT NULL COMMENT '1-stellarOB, 2-bscOB',
                          `stellar_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `pool_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `buy_amount` decimal(40,8) DEFAULT NULL,
                          `sell_amount` decimal(40,8) DEFAULT NULL,
                          `txid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `created_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                          `updated_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `UQ_fc59b3b6cf74926bc19eab69b44` (`stellar_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18385 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trades`
--

LOCK TABLES `trades` WRITE;
/*!40000 ALTER TABLE `trades` DISABLE KEYS */;
INSERT INTO `trades` VALUES (2,1,11,11,5,4,3.00000000,0.98310000,0.00000000,0.05070000,1,'0x940340934eb52ef374f78865b1b0f220bd3ba3f3','0x940340934eb52ef374f78865b1b0f220bd3ba3f3',2,NULL,NULL,NULL,NULL,NULL,'2021-09-02 16:53:48.874','2021-09-02 16:53:48.874'),(3,1,4,11,7,4,3.00000000,0.01690000,0.00000000,0.00000000,1,'0x6ab47eb8357c101e5dac93474d8298bd5010e892','0x940340934eb52ef374f78865b1b0f220bd3ba3f3',2,NULL,NULL,NULL,NULL,NULL,'2021-09-02 17:22:03.259','2021-09-02 17:22:03.259'),(36,1,13,2,18,57,3.00000000,0.98500000,0.00000000,0.04500000,0,'GBQFXK4RFUJL7VKMQQQZCHEWXJAUJZW7L6L4WTGCN3QPWTFR3JMCM5S3','GB7AIXP5XQSXOR6RJHATI3C2YECKHP77CBV73PLSAJIO6CTPT3VTHJR5',1,'5638506080641025-0',NULL,NULL,NULL,'cc7ecdcff3f0a5af1eb04536b61fa742480fd853ba3278d312e75808627eb863','2021-09-04 05:41:22.000','2021-09-04 05:41:22.000'),(88,4,11,11,191,190,3.00000000,0.99730000,0.00270000,0.00810000,1,'GCJI22COJBWYROITZOHORTL22TKRPAL6H2KK6CXSNN22LMMP4EHURTKH','GD2QROPZGO2BZR4UBIIQFTMF3QFHK4ES7F422FJYHFJW3XV2BVEG2MTB',1,'5810386376859649-0',NULL,NULL,NULL,'0x5bdbb0d38802da9012a5e63bea4056f0a92fb196527c66251180913788966546','2021-09-06 16:05:00.000','2021-09-06 16:05:00.000');
/*!40000 ALTER TABLE `trades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trading_fee`
--

DROP TABLE IF EXISTS `trading_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trading_fee` (
                               `id` int unsigned NOT NULL AUTO_INCREMENT,
                               `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                               `market_order` decimal(40,8) NOT NULL,
                               `limit_order` decimal(40,8) NOT NULL,
                               `network` tinyint NOT NULL COMMENT '1-stellar, 2-bsc',
                               `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trading_fee`
--

LOCK TABLES `trading_fee` WRITE;
/*!40000 ALTER TABLE `trading_fee` DISABLE KEYS */;
INSERT INTO `trading_fee` VALUES (1,'Stellar',0.00800000,0.00350000,1,'2021-07-22 04:35:13','2021-09-30 04:31:51'),(2,'BSC',0.00020000,0.00750000,2,'2021-07-22 04:35:13','2021-09-30 04:33:31');
/*!40000 ALTER TABLE `trading_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
                                `id` int unsigned NOT NULL AUTO_INCREMENT,
                                `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                `rawId` int NOT NULL,
                                `group_id` int DEFAULT NULL,
                                `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `txid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
                                `signed_transaction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                                `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                `network` int DEFAULT NULL,
                                `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=553 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_setting`
--

DROP TABLE IF EXISTS `user_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_setting` (
                                `id` int unsigned NOT NULL AUTO_INCREMENT,
                                `user_id` int NOT NULL,
                                `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                PRIMARY KEY (`id`),
                                UNIQUE KEY `IDX_5f4f13e76abb0c0c35216d6084` (`user_id`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_setting`
--

LOCK TABLES `user_setting` WRITE;
/*!40000 ALTER TABLE `user_setting` DISABLE KEYS */;
INSERT INTO `user_setting` VALUES (1,11,'IsMailNotificationEnable','0'),(2,4,'IsMailNotificationEnable','1'),(3,28,'IsMailNotificationEnable','0'),(4,39,'IsMailNotificationEnable','1'),(5,77,'IsMailNotificationEnable','0'),(6,80,'IsMailNotificationEnable','1'),(7,190,'IsMailNotificationEnable','1'),(8,14,'IsMailNotificationEnable','1');
/*!40000 ALTER TABLE `user_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_wallets`
--

DROP TABLE IF EXISTS `user_wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_wallets` (
                                `id` int unsigned NOT NULL AUTO_INCREMENT,
                                `user_id` int NOT NULL,
                                `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                                `network` int NOT NULL COMMENT '1 - bsc, 2 - stellar',
                                `status` tinyint NOT NULL DEFAULT '3' COMMENT '1 - approved, 2 - pending, 3 - submit, 4 - blocked',
                                `is_active` tinyint NOT NULL DEFAULT '1' COMMENT '1 - active, 0 -deactive',
                                `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                PRIMARY KEY (`id`),
                                UNIQUE KEY `address` (`address`,`network`)
) ENGINE=InnoDB AUTO_INCREMENT=746 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_wallets`
--

LOCK TABLES `user_wallets` WRITE;
/*!40000 ALTER TABLE `user_wallets` DISABLE KEYS */;
INSERT INTO `user_wallets` VALUES (14,13,'0x242dc2cb02f065e1bcadd79612232402fe9db82c',2,2,0,'2021-07-28 02:22:48','2021-09-27 01:52:51'),(57,149,'GA3KFPFCI2SNDA36LCVO2A44XYUXRYR25QRY2A4VBOI4I2B7XYPB5H7H',1,1,0,'2021-07-30 08:39:30','2021-09-11 12:05:18'),(519,149,'0x7ed3ed81af7e2622762ece82f1ee2240079299ec',2,4,1,'2021-09-15 02:55:46','2021-09-29 02:12:15');
/*!40000 ALTER TABLE `user_wallets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
                         `id` int unsigned NOT NULL AUTO_INCREMENT,
                         `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `fullname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `role` int NOT NULL COMMENT '0: user, 1: admin, 2: super_admin',
                         `user_type` tinyint NOT NULL COMMENT '0: restricted, 1: unrestricted',
                         `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `velo_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `token_reset_password` int DEFAULT NULL COMMENT '6 digit number to reset password',
                         `expire` datetime DEFAULT NULL COMMENT 'expiration of token_reset_password',
                         `is_locked` tinyint DEFAULT '1' COMMENT '1 - unlocked, 0 - locked',
                         `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'refresh token',
                         `status` tinyint NOT NULL DEFAULT '1' COMMENT '2 - active, 1 - pending, 0 - deactive',
                         `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `is_first_login` tinyint(1) DEFAULT '0',
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `UQ_97672ac88f789774dd47f7c8be3` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'Mr.','yen.dinh@sotatek.com','Sotatek','sotatek','Yen',0,1,'+840987441677','$2b$10$dwu68Lh7UipG/Oy8WTcnC.JbW19OyrRJw5nYutw4TEJLn0BqtUqBy','http://velo.com',NULL,'2021-08-31 09:42:11',1,'$2b$10$NaBZzGxmGd8OA.drJiD33.EpJ8NO1uiCI5QHD/IO/jtEEmVTAeuva',3,'2021-07-28 03:20:32','2021-09-11 09:53:17',0),(5,'Mr.','binh.nguyen@gmail.com','FCX Pro','Leader','Binh Testlead',2,0,'+84984495035','$2b$10$72X3jIwzEEZaq/WJIOOinOpsMnVrB8HTGB62g2jf3.ANqR8onLiNO','http://velo.com',NULL,NULL,1,NULL,0,'2021-10-18 18:04:55','2021-10-18 11:04:55',0),(18,'Mrs.','yen@gmail.com','Sotatek','Tester','FCXTest6',0,0,'+840373102745','$2b$10$DqOJdvlZZihOH4htJZ2b8OgM8vTkTYftHjCIgJPfnOe9mgiMUXukK','http://helo.com',NULL,NULL,0,NULL,3,'2021-07-30 07:29:00','2021-08-20 03:45:12',0),(149,'Mr.','holahola@gmail.com','hello world','test','hola hula',2,0,'+84123456789','$2b$10$18X5AX81ZL9wgHopfwFK9upyycmD/V0.cqGSJg5r.cQ.G7Z7PBU5O','string@gmail.com',NULL,NULL,1,'$2b$10$kUDapBEQZejw3TiYkMZP1OngBqbFtzC9A5LgwWsEFI7E4yRac86eO',3,'2021-08-26 07:08:55','2021-10-18 11:04:36',0),(191,'Mr.','doviyay378@shensufu.com','sotatek','dev','Ninh Hung',0,0,'','$2b$10$18X5AX81ZL9wgHopfwFK9upyycmD/V0.cqGSJg5r.cQ.G7Z7PBU5O','',NULL,NULL,1,NULL,3,'2021-09-08 07:23:54','2021-10-18 11:04:37',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warps`
--

DROP TABLE IF EXISTS `warps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warps` (
                         `id` int unsigned NOT NULL AUTO_INCREMENT,
                         `transfer_type` tinyint NOT NULL,
                         `user_id` int NOT NULL,
                         `from` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
                         `type_id` int NOT NULL,
                         `amount` decimal(40,8) DEFAULT NULL,
                         `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `tx_hash` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                         `first_warp_tx` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                         `second_warp_tx` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                         `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                         `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warps`
--

LOCK TABLES `warps` WRITE;
/*!40000 ALTER TABLE `warps` DISABLE KEYS */;
INSERT INTO `warps` VALUES (118,1,149,'GDXOLL4RKNNNDVJJNFEKOQLLIYN5B7ACZVS7QMHHL4QQQJIVMB37G4PE','0xfda2078d9152c67a67e35ed24f2f7dad2e8f400c',0,3.00000000,NULL,'pending',NULL,NULL,NULL,NULL,'2021-10-18 10:32:03','2021-10-18 10:32:03'),(119,1,149,'GDXOLL4RKNNNDVJJNFEKOQLLIYN5B7ACZVS7QMHHL4QQQJIVMB37G4PE','0xfda2078d9152c67a67e35ed24f2f7dad2e8f400c',0,3.00000000,NULL,'pending',NULL,NULL,NULL,NULL,'2021-10-18 10:35:37','2021-10-18 10:35:37'),(120,1,149,'GDXOLL4RKNNNDVJJNFEKOQLLIYN5B7ACZVS7QMHHL4QQQJIVMB37G4PE','0xfda2078d9152c67a67e35ed24f2f7dad2e8f400c',0,3.00000000,NULL,'pending',NULL,NULL,NULL,NULL,'2021-10-18 10:37:49','2021-10-18 10:37:49'),(121,1,149,'GDXOLL4RKNNNDVJJNFEKOQLLIYN5B7ACZVS7QMHHL4QQQJIVMB37G4PE','0xfda2078d9152c67a67e35ed24f2f7dad2e8f400c',0,3.00000000,NULL,'pending',NULL,NULL,NULL,NULL,'2021-10-18 10:39:05','2021-10-18 10:39:05'),(122,1,149,'GDXOLL4RKNNNDVJJNFEKOQLLIYN5B7ACZVS7QMHHL4QQQJIVMB37G4PE','0xfda2078d9152c67a67e35ed24f2f7dad2e8f400c',0,3.00000000,NULL,'pending',NULL,NULL,NULL,NULL,'2021-10-18 10:39:37','2021-10-18 10:39:37'),(123,1,149,'GDXOLL4RKNNNDVJJNFEKOQLLIYN5B7ACZVS7QMHHL4QQQJIVMB37G4PE','0xfda2078d9152c67a67e35ed24f2f7dad2e8f400c',0,3.00000000,NULL,'pending',NULL,NULL,NULL,NULL,'2021-10-18 10:40:48','2021-10-18 10:40:48'),(124,1,149,'GDXOLL4RKNNNDVJJNFEKOQLLIYN5B7ACZVS7QMHHL4QQQJIVMB37G4PE','0xfda2078d9152c67a67e35ed24f2f7dad2e8f400c',0,3.00000000,NULL,'pending',NULL,NULL,NULL,NULL,'2021-10-18 10:55:59','2021-10-18 10:55:59'),(125,1,149,'GDXOLL4RKNNNDVJJNFEKOQLLIYN5B7ACZVS7QMHHL4QQQJIVMB37G4PE','0xfda2078d9152c67a67e35ed24f2f7dad2e8f400c',0,3.00000000,NULL,'pending',NULL,NULL,NULL,NULL,'2021-10-18 10:59:21','2021-10-18 10:59:21'),(126,1,149,'GDXOLL4RKNNNDVJJNFEKOQLLIYN5B7ACZVS7QMHHL4QQQJIVMB37G4PE','0xfda2078d9152c67a67e35ed24f2f7dad2e8f400c',0,3.00000000,NULL,'pending',NULL,NULL,NULL,NULL,'2021-10-18 11:04:49','2021-10-18 11:04:49');
/*!40000 ALTER TABLE `warps` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-18 18:13:16
