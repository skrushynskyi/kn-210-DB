-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: crypto_hay_sk
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `wallet_id` int(10) unsigned NOT NULL,
  `type` enum('buy','sell') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1,101,'buy'),(2,2,102,'sell'),(3,3,103,'buy');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `kilkist` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_kilkist` (`kilkist`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'buy',22032.6,1.388),(2,'sell',36014.4,1.395),(3,'buy',38482.8,0.257),(4,'sell',21319.8,1.982),(5,'buy',28428.7,2.961),(6,'sell',33696.3,1.734),(7,'buy',43087.3,4.344),(8,'sell',38192.6,4.939);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_system`
--

DROP TABLE IF EXISTS `payment_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` enum('deposit','withdrawal') NOT NULL,
  `limits` decimal(18,2) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `wallet_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_wallet_id` (`wallet_id`),
  CONSTRAINT `idx_wallet_id` FOREIGN KEY (`wallet_id`) REFERENCES `wallet` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_system`
--

LOCK TABLES `payment_system` WRITE;
/*!40000 ALTER TABLE `payment_system` DISABLE KEYS */;
INSERT INTO `payment_system` VALUES (1,'PayPal','deposit',10000.00,'active',1),(2,'Stripe','withdrawal',5000.00,'active',2),(3,'Binance Pay','deposit',20000.00,'active',3),(4,'Revolut','withdrawal',7000.00,'inactive',4),(5,'Wise','deposit',15000.00,'active',5);
/*!40000 ALTER TABLE `payment_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spot`
--

DROP TABLE IF EXISTS `spot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `trade_amount` decimal(18,8) NOT NULL CHECK (`trade_amount` > 0),
  `trade_price` decimal(18,8) NOT NULL CHECK (`trade_price` > 0),
  `trade_date` datetime DEFAULT current_timestamp(),
  `status` enum('completed','pending','failed') DEFAULT 'pending',
  PRIMARY KEY (`id`),
  KEY `idx_spot_order_id` (`order_id`),
  CONSTRAINT `fk_spot_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spot`
--

LOCK TABLES `spot` WRITE;
/*!40000 ALTER TABLE `spot` DISABLE KEYS */;
INSERT INTO `spot` VALUES (1,1,2.23181461,37442.13000000,'2025-10-27 01:36:06','pending'),(2,2,2.89259717,39859.27000000,'2025-09-18 07:43:48','failed'),(3,3,2.24238329,40274.42000000,'2025-10-27 13:30:01','failed'),(4,4,0.30215362,38815.88000000,'2025-09-30 14:08:18','pending'),(5,5,1.90994678,41777.93000000,'2025-10-28 10:47:51','failed'),(6,6,2.65521843,41482.96000000,'2025-09-03 20:53:10','completed'),(7,7,1.57153745,44108.85000000,'2025-08-13 04:40:23','failed'),(8,8,2.59259057,43006.74000000,'2025-09-13 02:40:12','completed'),(9,3,2.81134203,44203.80000000,'2025-10-28 03:18:30','failed'),(10,5,0.42726649,36915.40000000,'2025-09-19 03:52:58','failed');
/*!40000 ALTER TABLE `spot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `def_token` varchar(10) NOT NULL,
  `usd` varchar(10) DEFAULT NULL,
  `kurs` decimal(18,8) NOT NULL CHECK (`kurs` > 0),
  PRIMARY KEY (`id`),
  UNIQUE KEY `def_token` (`def_token`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,'\nBTC','USD',10644.64000000),(2,'\nETH','USD',33778.03000000),(3,'\nSOL','USD',64287.52000000),(4,'\nADA','USD',22987.29000000),(5,'\nDOGE','USD',53744.21000000),(6,'\nUSDT','USD',36891.64000000),(7,'\nXRP','USD',54503.22000000),(8,'\nDOT','USD',5621.98000000),(9,'\nLTC','USD',17149.97000000),(10,'\nAVAX','USD',45874.33000000);
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trade`
--

DROP TABLE IF EXISTS `trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prace` float NOT NULL,
  `kilkist` float NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `data` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_trade_prace` (`prace`),
  KEY `IDX_trade_date` (`data`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trade`
--

LOCK TABLES `trade` WRITE;
/*!40000 ALTER TABLE `trade` DISABLE KEYS */;
INSERT INTO `trade` VALUES (1,48400.2,3.595,'pending','2025-10-16 08:27:40'),(2,31481.2,1.142,'pending','2025-09-14 00:30:36'),(3,21548.4,0.544,'failed','2025-09-11 16:35:13'),(4,5059.28,1.287,'failed','2025-10-30 05:33:20'),(5,28680.1,2.184,'completed','2025-09-05 04:44:44'),(6,25807,0.754,'failed','2025-08-16 21:33:37'),(7,25105.4,3.841,'pending','2025-10-13 02:48:24'),(8,49726.9,0.848,'completed','2025-10-03 15:12:17');
/*!40000 ALTER TABLE `trade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `type` varchar(255) NOT NULL,
  `user` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `suma` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user`),
  KEY `IDX_transaction_data` (`data`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,'2025-08-17 17:27:58','withdrawal','user1@example.com','failed',2817.8),(2,'2025-10-23 07:08:28','deposit','user2@example.com','failed',4977.07),(3,'2025-10-28 13:26:48','transfer','user3@example.com','completed',616.82),(4,'2025-09-02 00:36:41','transfer','user4@example.com','failed',2664.76),(5,'2025-10-24 01:32:28','transfer','user5@example.com','pending',2192.46),(6,'2025-10-25 23:18:35','withdrawal','user6@example.com','failed',1921.8),(7,'2025-10-03 15:11:12','withdrawal','user7@example.com','completed',951.81),(8,'2025-08-22 00:02:25','transfer','user8@example.com','completed',2513.1),(9,'2025-10-03 13:39:13','withdrawal','user9@example.com','failed',820.73),(10,'2025-09-11 12:08:59','transfer','user10@example.com','failed',2457.09),(11,'2025-08-16 11:02:43','transfer','user11@example.com','completed',3877.07),(12,'2025-08-09 00:34:58','withdrawal','user12@example.com','failed',4689.99),(13,'2025-10-09 20:03:24','withdrawal','user13@example.com','completed',4650.44),(14,'2025-10-14 15:35:30','withdrawal','user14@example.com','pending',868.39),(15,'2025-10-25 04:36:44','withdrawal','user15@example.com','completed',4230.5);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `user_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `chk_user_type` CHECK (`user_type` in ('admin','client','trader','support'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'alex','alex@example.com','pass123','admin'),(2,'mike','mike@example.com','qwerty','client'),(3,'sara','sara@example.com','abc123','trader'),(4,'kate','kate@example.com','pass321','support');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet`
--

DROP TABLE IF EXISTS `wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wallet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `token_type` varchar(10) NOT NULL,
  `balance` decimal(18,8) DEFAULT 0.00000000 CHECK (`balance` >= 0),
  `created_at` datetime DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_wallet_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet`
--

LOCK TABLES `wallet` WRITE;
/*!40000 ALTER TABLE `wallet` DISABLE KEYS */;
INSERT INTO `wallet` VALUES (1,1,'BTC',1520.45000000,'2025-10-30 12:26:28','active'),(2,2,'ETH',780.30000000,'2025-10-30 12:26:28','frozen'),(3,3,'USDT',954.22000000,'2025-10-30 12:26:28','active'),(4,4,'SOL',2100.10000000,'2025-10-30 12:26:28','active'),(5,5,'ADA',320.55000000,'2025-10-30 12:26:28','active'),(6,1,'ETH',850.00000000,'2025-10-30 12:26:28','active'),(7,2,'BTC',460.78000000,'2025-10-30 12:26:28','active'),(8,3,'SOL',1450.90000000,'2025-10-30 12:26:28','frozen'),(9,4,'USDT',999.99000000,'2025-10-30 12:26:28','active'),(10,5,'ADA',2340.12000000,'2025-10-30 12:26:28','active'),(11,1,'BTC',120.00000000,'2025-10-30 12:26:28','active'),(12,2,'USDT',870.60000000,'2025-10-30 12:26:28','frozen'),(13,3,'SOL',340.33000000,'2025-10-30 12:26:28','active'),(14,4,'ETH',4100.00000000,'2025-10-30 12:26:28','active'),(15,5,'ADA;',275.15000000,'2025-10-30 12:26:28','active');
/*!40000 ALTER TABLE `wallet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-03 10:50:40
