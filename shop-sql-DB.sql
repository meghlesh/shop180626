-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce_new
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_9emlp6m95v5er2bcqkjsw48he` (`user_id`),
  CONSTRAINT `FKg5uhi8vpsuy0lgloxk2h4w5o6` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,'2026-06-13 16:31:41.112393','2026-06-13 16:31:41.112393',1),(2,'2026-06-15 07:45:59.072484','2026-06-15 07:45:59.072484',4);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `quantity` int NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `cart_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6oue0maw421roerltnxn16a38` (`cart_id`,`product_id`),
  KEY `FK1re40cjegsfvw58xrkdp6bac6` (`product_id`),
  CONSTRAINT `FK1re40cjegsfvw58xrkdp6bac6` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FK99e0am9jpriwxcm6is7xfedy3` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `licenses`
--

DROP TABLE IF EXISTS `licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licenses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `deleted` bit(1) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `activation_limit` int NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `customer_email` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `license_key` varchar(255) NOT NULL,
  `license_plan` enum('BASIC','STANDARD','PREMIUM','ENTERPRISE') DEFAULT NULL,
  `license_status` enum('ACTIVE','INACTIVE','EXPIRED','SUSPENDED','PENDING_RENEWAL','DEACTIVATED') NOT NULL,
  `license_type` enum('MONTHLY','YEARLY','LIFETIME') NOT NULL,
  `is_manual_key` bit(1) DEFAULT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `generated_by` bigint DEFAULT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_8t8rce88aoep65xlxnvnhy6d7` (`license_key`),
  KEY `FKe5lglta0iih9hpklacova3avm` (`user_id`),
  KEY `FK37k6tcy1xh7jtd1t7jlo27kns` (`generated_by`),
  KEY `FKrwbu30er6kfs9bsiu91xa0vre` (`product_id`),
  CONSTRAINT `FK37k6tcy1xh7jtd1t7jlo27kns` FOREIGN KEY (`generated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FKe5lglta0iih9hpklacova3avm` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKrwbu30er6kfs9bsiu91xa0vre` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `licenses`
--

LOCK TABLES `licenses` WRITE;
/*!40000 ALTER TABLE `licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `licenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `is_read` bit(1) NOT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` enum('ORDER','PAYMENT','PRODUCT','SYSTEM') DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`),
  CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'2026-06-03 12:43:26.827375',_binary '','New user registered with email: rahuldesaicws@gmail.com','New User Registered','SYSTEM',1),(2,'2026-06-12 08:28:58.032607',_binary '\0','New product available: Employee Management System','New Product Added','PRODUCT',1),(3,'2026-06-12 08:28:58.037887',_binary '\0','New product available: Employee Management System','New Product Added','PRODUCT',2),(4,'2026-06-13 18:20:50.075709',_binary '\0','New product available: Stock Management','New Product Added','PRODUCT',1),(5,'2026-06-13 18:20:50.080695',_binary '\0','New product available: Stock Management','New Product Added','PRODUCT',2),(6,'2026-06-15 07:38:44.152108',_binary '\0','New user registered with email: kulkarnicham@gmail.com','New User Registered','SYSTEM',1),(7,'2026-06-15 07:43:12.356438',_binary '\0','New user registered with email: verifygmailcws@gmail.com','New User Registered','SYSTEM',1);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `deleted` bit(1) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `amount` double NOT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `product_purchased` varchar(255) DEFAULT NULL,
  `status` enum('PENDING','COMPLETED','FAILED','CANCELLED') NOT NULL,
  `transaction_status` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2026-06-13 16:32:24.915575',_binary '\0','2026-06-13 16:32:24.915575',11799,'Admin User','2026-06-13 16:32:24.913576','ORD-1781348544913','RAZORPAY','Employee Management System','COMPLETED','SUCCESS',1),(2,'2026-06-13 16:55:30.056630',_binary '\0','2026-06-13 16:55:30.056630',11799,'Admin User','2026-06-13 16:55:30.055629','ORD-1781349930055','RAZORPAY','Employee Management System','COMPLETED','SUCCESS',1),(3,'2026-06-13 17:20:36.595980',_binary '\0','2026-06-13 17:20:36.595980',11799,'Admin User','2026-06-13 17:20:36.594981','ORD-1781351436594','RAZORPAY','Employee Management System','COMPLETED','SUCCESS',1),(4,'2026-06-13 18:24:34.713486',_binary '\0','2026-06-13 18:24:34.713486',17699,'Admin User','2026-06-13 18:24:34.712486','ORD-1781355274712','RAZORPAY','Employee Management System, Stock Management','COMPLETED','SUCCESS',1),(5,'2026-06-15 07:46:32.575423',_binary '\0','2026-06-15 07:46:32.575423',11799,'Ekansh','2026-06-15 07:46:32.574419','ORD-1781489792574','RAZORPAY','Employee Management System','COMPLETED','SUCCESS',4);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_limit`
--

DROP TABLE IF EXISTS `password_reset_limit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_limit` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `reset_count` int NOT NULL,
  `reset_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_limit`
--

LOCK TABLES `password_reset_limit` WRITE;
/*!40000 ALTER TABLE `password_reset_limit` DISABLE KEYS */;
INSERT INTO `password_reset_limit` VALUES (1,'rahuldesaicws@gmail.com',1,'2026-06-13');
/*!40000 ALTER TABLE `password_reset_limit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `expiry_date` datetime(6) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_71lqwbwtklmljk3qlsugr1mig` (`token`),
  UNIQUE KEY `UK_la2ts67g4oh2sreayswhox1i6` (`user_id`),
  CONSTRAINT `FKk3ndxg5xp6v7wd4gjyusp15gq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_methods` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `deleted` bit(1) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `active` bit(1) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `method_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_hn6pcph0iahf37xw5rxpvtyjo` (`method_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_methods`
--

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `buyer_id` bigint NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `currency` varchar(255) NOT NULL,
  `failure_reason` varchar(255) DEFAULT NULL,
  `order_id` varchar(255) NOT NULL,
  `payment_id` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `razorpay_signature` varchar(512) DEFAULT NULL,
  `status` enum('SUCCESS','FAILED','PENDING') NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_8vo36cen604as7etdfwmyjsxt` (`order_id`),
  UNIQUE KEY `UK_t4ffsaqe8d6i83gs100u2y3l1` (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,11799,1,'2026-06-13 16:31:51.711967','INR',NULL,'order_T15khucqC8HicK','pay_T15kzh7T09RPG1',NULL,'b53b975bde59b5a658a945368c8fb38e745252a66869df0dafcf9069dcc8bda1','SUCCESS','2026-06-13 16:32:24.925568'),(2,11799,1,'2026-06-13 16:54:51.214003','INR',NULL,'order_T168zkdk9uVmt1','pay_T169L2P69NZ2st',NULL,'e816fabba83a72d55b3d93c7a23a3ccaac76b65b8d6f9eab9792342ca571a6f8','SUCCESS','2026-06-13 16:55:30.067623'),(3,11799,1,'2026-06-13 17:18:58.380046','INR',NULL,'order_T16YTOSceL6cjW',NULL,NULL,NULL,'PENDING','2026-06-13 17:18:58.380046'),(4,11799,1,'2026-06-13 17:20:11.910405','INR',NULL,'order_T16ZleqG3TC7SD','pay_T16ZqyW86aYSKq',NULL,'a033eb382d952737c776dd945464faa04321b1e58b1d57fb980c7355b56278a4','SUCCESS','2026-06-13 17:20:36.607974'),(5,17699,1,'2026-06-13 18:23:53.511659','INR',NULL,'order_T17f34qhQxl2u9','pay_T17fU2H7zc7PHJ',NULL,'2158193d270d0461fbba4c76eeee693af636050f3c9187f063bf7f8a70e8f306','SUCCESS','2026-06-13 18:24:34.722481'),(6,11799,4,'2026-06-15 07:46:09.590919','INR',NULL,'order_T1jrbuIZDbtVKJ','pay_T1jrk799ilRXFQ',NULL,'bc9dd72b33bf7a63e6723d03244c7e53e3d1a8f2dbb7a50c47dc48aa41cb5512','SUCCESS','2026-06-15 07:46:32.581782');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_details`
--

DROP TABLE IF EXISTS `product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `documentation_url` text,
  `download_file_url` text,
  `faqs` json DEFAULT NULL,
  `features` json DEFAULT NULL,
  `overview` text NOT NULL,
  `release_notes` text,
  `screenshots` json DEFAULT NULL,
  `technical_requirements` json DEFAULT NULL,
  `use_cases` json DEFAULT NULL,
  `version_history` json DEFAULT NULL,
  `product_id` bigint NOT NULL,
  `demo_url` text,
  `demo_videos` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_d8itpicgj364s8ud8ge17m4qe` (`product_id`),
  CONSTRAINT `FKnfvvq3meg4ha3u1bju9k4is3r` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_details`
--

LOCK TABLES `product_details` WRITE;
/*!40000 ALTER TABLE `product_details` DISABLE KEYS */;
INSERT INTO `product_details` VALUES (1,'https://res.cloudinary.com/drpdpoxhr/raw/upload/v1781233068/cws-products/docs/4033c010-879c-4f35-a21d-a0e8036e7f4e_product__1_','https://res.cloudinary.com/drpdpoxhr/raw/authenticated/s--jVb7xjv9--/v1781233071/cws-products/downloads/5cdaf50a-dd42-47f9-b673-ecc60db96c34_shop-api-main','[{\"answer\": \"Two Question\", \"question\": \"2nd\"}, {\"answer\": \"Answer\", \"question\": \"1st\"}, {\"answer\": \"answer\", \"question\": \"3rd\"}]','[\"AI Pipeline Forecasting\", \"Multi-region Sync\", \"Custom API Hooks\"]','Can Use','','[\"https://res.cloudinary.com/drpdpoxhr/image/upload/v1781233086/cws-products/screenshots/a9616ec4-f56d-40a7-9bba-5f3e537611dc_20175357_black-friday-web-banner-10.jpg\", \"https://res.cloudinary.com/drpdpoxhr/image/upload/v1781233094/cws-products/screenshots/f44f025f-2872-43ef-add0-c65785050bae_20175357_black-friday-web-banner-10.jpg\", \"https://res.cloudinary.com/drpdpoxhr/image/upload/v1781233104/cws-products/screenshots/f618af63-ba5d-4511-b572-2f3fff9dc809_87833737_black-friday_web_banner_13.jpg\"]','[\"React.js\", \"Node.js\", \"MongoDB\", \"AWS\", \"Docker\", \"Redis\", \"Java\", \"Spring Boot\"]','[\"HR & Workforce Management\", \"Employee Self Service\", \"Performance Tracking\", \"Compliance Management\"]','[]',1,'','[\"https://res.cloudinary.com/drpdpoxhr/video/upload/v1781233136/cws-products/videos/13987ddb-d92c-4141-a1bb-1944d955a2dc_10_minutes_of_curiously_awesome_products__3.mp4\"]'),(2,'https://res.cloudinary.com/drpdpoxhr/raw/upload/v1781354996/cws-products/docs/85685d0e-ca31-4ab8-a90c-9956281ff21b_product__1_','https://res.cloudinary.com/drpdpoxhr/raw/authenticated/s--Rv53XcXM--/v1781355009/cws-products/downloads/dec96c18-7a62-4591-be33-56745e842042_itop-screen-recorder-enseo_hp-setup','[{\"answer\": \"Product Related answer\", \"question\": \"Any Questions?\"}]','[\"AI Pipeline Forecasting\", \"Multi-region Sync\", \"Custom API Hooks\"]','New Product Added','','[\"https://res.cloudinary.com/drpdpoxhr/image/upload/v1781355019/cws-products/screenshots/2c40e3ad-ed92-4f8b-b32a-97322379270d_20175357_black-friday-web-banner-10.jpg\", \"https://res.cloudinary.com/drpdpoxhr/image/upload/v1781355029/cws-products/screenshots/cf9e62fc-428c-4458-a294-11b85f7402cc_87833737_black-friday_web_banner_13.jpg\"]','[\"React.js\", \"Node.js\", \"MongoDB\", \"AWS\", \"Docker\", \"Redis\"]','[\"HR & Workforce Management\", \"Employee Self Service\", \"Performance Tracking\", \"Compliance Management\"]','[]',2,'','[\"https://res.cloudinary.com/drpdpoxhr/video/upload/v1781355047/cws-products/videos/201cce27-064d-4159-8631-f12de6e085ed_10_minutes_of_curiously_awesome_products__3.mp4\"]');
/*!40000 ALTER TABLE `product_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_licenses`
--

DROP TABLE IF EXISTS `product_licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_licenses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `activation_date` date DEFAULT NULL,
  `deleted_license` bit(1) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `license_key` varchar(255) NOT NULL,
  `plan_type` enum('MONTHLY','YEARLY','LIFETIME') DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE','EXPIRED','SUSPENDED','PENDING_RENEWAL','DEACTIVATED') DEFAULT NULL,
  `buyer_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_im75p3x6glcbuqpli70h6jayu` (`license_key`),
  KEY `FKg77xmmp83kvliwrbdrtejlw4h` (`buyer_id`),
  KEY `FK302bphm24redlckv9by6dt236` (`product_id`),
  CONSTRAINT `FK302bphm24redlckv9by6dt236` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKg77xmmp83kvliwrbdrtejlw4h` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_licenses`
--

LOCK TABLES `product_licenses` WRITE;
/*!40000 ALTER TABLE `product_licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_licenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_ratings`
--

DROP TABLE IF EXISTS `product_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_ratings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` text,
  `created_at` datetime(6) NOT NULL,
  `rating` int NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_product_rating` (`user_id`,`product_id`),
  KEY `FK6vmxt3km86rrgrslgy71ne3e5` (`product_id`),
  CONSTRAINT `FK6vmxt3km86rrgrslgy71ne3e5` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKrinkxs2nb4wouojjdsn4nn8g9` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_ratings`
--

LOCK TABLES `product_ratings` WRITE;
/*!40000 ALTER TABLE `product_ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `average_rating` double NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `current_version` varchar(255) DEFAULT NULL,
  `deleted` bit(1) NOT NULL,
  `discount_percent` double DEFAULT NULL,
  `discounted_price` double DEFAULT NULL,
  `download_count` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `revenue` double NOT NULL,
  `sales_count` int NOT NULL,
  `short_description` text NOT NULL,
  `slug` varchar(255) NOT NULL,
  `status` enum('DRAFT','PUBLISHED','ARCHIVED') NOT NULL,
  `thumbnail_image` varchar(255) NOT NULL,
  `total_reviews` int NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `category` enum('ENTERPRISE','SAAS_PLATFORM','UTILITY_SOFTWARE','E_COMMERCE') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_ostq1ec3toafnjok09y9l7dox` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,0,'2026-06-12 08:28:57.999227','v2.4.0',_binary '\0',NULL,NULL,0,'Employee Management System',9999,0,0,'New Product Added','employee-management-system','PUBLISHED','https://res.cloudinary.com/drpdpoxhr/image/upload/v1781233056/cws-products/thumbnails/77b69a6d-c0a7-4369-9c2b-ac6d1c8c77cf_11817464_4833138.jpg',0,'2026-06-12 08:28:57.999227',NULL),(2,0,'2026-06-13 18:20:50.052712','v2.4.0',_binary '\0',NULL,NULL,0,'Stock Management',5000,0,0,'New Product','stock-management','PUBLISHED','https://res.cloudinary.com/drpdpoxhr/image/upload/v1781354992/cws-products/thumbnails/3dd9231f-d29f-4389-b098-2d82334a4df4_11817464_4833138.jpg',0,'2026-06-13 18:20:50.052712','SAAS_PLATFORM');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_document_mapping`
--

DROP TABLE IF EXISTS `user_document_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_document_mapping` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `deleted` bit(1) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `orignal_url` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `url_type` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKs3mvtayxvms3lax1a136qhooy` (`user_id`),
  CONSTRAINT `FKs3mvtayxvms3lax1a136qhooy` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_document_mapping`
--

LOCK TABLES `user_document_mapping` WRITE;
/*!40000 ALTER TABLE `user_document_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_document_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tokens`
--

DROP TABLE IF EXISTS `user_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `deleted` bit(1) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `expiry_date` datetime(6) NOT NULL,
  `token` varchar(255) NOT NULL,
  `token_type` enum('EMAIL_VERIFICATION','PASSWORD_RESET') NOT NULL,
  `used` bit(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_fvl6k04x11pern525noiw5k6v` (`token`),
  KEY `FK61iiu6gfevpvo2v3yl76sar7r` (`user_id`),
  CONSTRAINT `FK61iiu6gfevpvo2v3yl76sar7r` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tokens`
--

LOCK TABLES `user_tokens` WRITE;
/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
INSERT INTO `user_tokens` VALUES (1,'2026-06-03 12:43:26.864489',_binary '\0','2026-06-03 12:44:26.079026','2026-06-04 12:43:26.861489','9ffb0c8f-3ff2-40fd-a7fd-2a76a1f616ca','EMAIL_VERIFICATION',_binary '',2),(2,'2026-06-13 08:43:41.923486',_binary '\0','2026-06-13 08:43:41.923486','2026-06-13 09:43:41.918493','529182bc-e807-4d74-b64b-8aace7933dfd','PASSWORD_RESET',_binary '\0',2),(3,'2026-06-15 07:38:44.177555',_binary '\0','2026-06-15 07:38:44.177555','2026-06-16 07:38:44.176558','4a1aa0bc-c88f-441a-94c3-520f5ef5cee0','EMAIL_VERIFICATION',_binary '\0',3),(4,'2026-06-15 07:43:12.370072',_binary '\0','2026-06-15 07:43:38.010513','2026-06-16 07:43:12.370072','8518520d-8d3c-4fce-9020-60ba3aa0fe44','EMAIL_VERIFICATION',_binary '',4);
/*!40000 ALTER TABLE `user_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `deleted` bit(1) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `active_token` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('ADMIN','BUYER') NOT NULL,
  `status` enum('ACTIVE','INACTIVE','PENDING','SUSPENDED','BLOCKED','DELETED') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2026-05-26 15:34:24.038929',_binary '\0','2026-06-15 07:51:26.780443','eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBzaG9wLmNvbSIsImlhdCI6MTc4MTQ5MDA4NiwiZXhwIjoxNzgxNDkzNjg2fQ.Nv2nlPY2mVR_zkF8PRIApaLgLwdKgyxcgwmm4sGqLTE','admin@shop.com','9999999999','Admin User','$2a$10$bF9Z0XIQLTbarghXSdTpiOWU5KpwtrbDRnFYGNDJIcseY/PR8ksTa','ADMIN','ACTIVE'),(2,'2026-06-03 12:43:26.752358',_binary '\0','2026-06-13 18:25:51.446640','eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyYWh1bGRlc2FpY3dzQGdtYWlsLmNvbSIsImlhdCI6MTc4MTM1NTM1MSwiZXhwIjoxNzgxMzU4OTUxfQ.64wmC9ExoFiZivI9LhFjW2RVaW2UbdZglDCjxRmkDEo','rahuldesaicws@gmail.com','9999999999','Rahul Desai','$2a$10$t15gY2lSPM2umzxwGnc1vOLKX2PMxoY79UVuINc2XxErdjGLs2S2e','BUYER','ACTIVE'),(3,'2026-06-15 07:38:44.029929',_binary '\0','2026-06-15 07:52:24.761741',NULL,'kulkarnicham@gmail.com','7888888888','Ekansh','$2a$10$PthAJaTevY.qG4JCqEynzOC9rUSzGya6V7pv583zGm8KcvdIBvPS2','BUYER','ACTIVE'),(4,'2026-06-15 07:43:12.337753',_binary '\0','2026-06-15 07:45:16.363761','eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ2ZXJpZnlnbWFpbGN3c0BnbWFpbC5jb20iLCJpYXQiOjE3ODE0ODk3MTYsImV4cCI6MTc4MTQ5MzMxNn0.0PNJBbmQShsJ0ybIW2FxpYsWO7NylRlGli8LzeGFJsU','verifygmailcws@gmail.com','7888888888','Ekansh','$2a$10$pvv2Bt0vHY5cnX7CeVt20.34fNJ9Wdg5ig6pVXYGfQVZD/7kV7sdK','BUYER','ACTIVE');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ecommerce_new'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-15  7:57:55
