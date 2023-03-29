-- MariaDB dump 10.19  Distrib 10.4.19-MariaDB, for Linux (x86_64)
--
-- Host: mps-devhaya3.cluster-ro-cp30z4rr9h0b.ap-northeast-1.rds.amazonaws.com    Database: db_mps_fs_g3
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Current Database: `db_mps_fs_g3`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_mps_fs_g3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_mps_fs_g3`;

--
-- Table structure for table `t_account_info_g3`
--

DROP TABLE IF EXISTS `t_account_info_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_account_info_g3` (
  `account_id` bigint NOT NULL,
  `secret_key` text NOT NULL,
  `organization_type` int NOT NULL,
  `organization_id` bigint NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `organization_index` (`organization_type`,`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_account_info_g3`
--

LOCK TABLES `t_account_info_g3` WRITE;
/*!40000 ALTER TABLE `t_account_info_g3` DISABLE KEYS */;
INSERT INTO `t_account_info_g3` VALUES (999,'z_secretkey_should_be_in_here_==',1,2425683101,'2023-03-09 06:13:10','2023-03-09 06:13:10');
/*!40000 ALTER TABLE `t_account_info_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_document_data_g3`
--

DROP TABLE IF EXISTS `t_document_data_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_data_g3` (
  `account_id` bigint NOT NULL,
  `node_id` bigint NOT NULL,
  `type` int NOT NULL,
  `value1` bigint NOT NULL,
  `value2` bigint NOT NULL,
  `value3` bigint NOT NULL,
  `version` bigint NOT NULL,
  `data_size` bigint NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`account_id`,`node_id`,`type`,`value1`,`value2`,`value3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_document_data_g3`
--

LOCK TABLES `t_document_data_g3` WRITE;
/*!40000 ALTER TABLE `t_document_data_g3` DISABLE KEYS */;
INSERT INTO `t_document_data_g3` VALUES (999,901,0,-1,-1,-1,1011,12288,'2023-03-17 08:05:01','2023-03-17 09:18:21'),(999,901,3,1,-1,-1,1014,720,'2023-03-17 08:05:06','2023-03-17 09:18:25'),(999,901,4,1,-1,-1,1016,17,'2023-03-17 08:05:07','2023-03-24 08:57:39');
/*!40000 ALTER TABLE `t_document_data_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_document_data_history_g3`
--

DROP TABLE IF EXISTS `t_document_data_history_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_document_data_history_g3` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `node_id` bigint NOT NULL,
  `type` int NOT NULL,
  `value1` bigint NOT NULL,
  `value2` bigint NOT NULL,
  `value3` bigint NOT NULL,
  `version` bigint NOT NULL,
  `data_size` bigint NOT NULL,
  `deleted_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_document_data_history_g3`
--

LOCK TABLES `t_document_data_history_g3` WRITE;
/*!40000 ALTER TABLE `t_document_data_history_g3` DISABLE KEYS */;
INSERT INTO `t_document_data_history_g3` VALUES (1,999,901,1,1,-1,-1,1007,24576,'2023-03-17 08:05:03'),(2,999,901,2,1,3884380833494948,3141592,1008,6,'2023-03-17 08:05:05'),(3,999,901,0,-1,-1,-1,1006,12288,'2023-03-17 09:18:21'),(4,999,901,1,1,-1,-1,1012,24576,'2023-03-17 09:18:22'),(5,999,901,2,1,3884380833494948,3141592,1013,6,'2023-03-17 09:18:24');
/*!40000 ALTER TABLE `t_document_data_history_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_documents_g3`
--

DROP TABLE IF EXISTS `t_documents_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_documents_g3` (
  `account_id` bigint NOT NULL,
  `node_id` bigint NOT NULL,
  `open_date` datetime DEFAULT NULL,
  `option_flags` bigint NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`account_id`,`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_documents_g3`
--

LOCK TABLES `t_documents_g3` WRITE;
/*!40000 ALTER TABLE `t_documents_g3` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_documents_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_file_history_g3`
--

DROP TABLE IF EXISTS `t_file_history_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_file_history_g3` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `node_id` bigint NOT NULL,
  `mime_type` varchar(256) NOT NULL,
  `version` bigint NOT NULL,
  `file_size` bigint NOT NULL,
  `contents_size` bigint NOT NULL,
  `thumbnail_size` bigint NOT NULL,
  `other_size` bigint NOT NULL,
  `deleted_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_file_history_g3`
--

LOCK TABLES `t_file_history_g3` WRITE;
/*!40000 ALTER TABLE `t_file_history_g3` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_file_history_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_file_info_g3`
--

DROP TABLE IF EXISTS `t_file_info_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_file_info_g3` (
  `account_id` bigint NOT NULL,
  `node_id` bigint NOT NULL,
  `mime_type` varchar(256) NOT NULL,
  `version` bigint NOT NULL,
  `file_size` bigint NOT NULL,
  `contents_size` bigint NOT NULL,
  `thumbnail_size` bigint NOT NULL,
  `other_size` bigint NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`account_id`,`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_file_info_g3`
--

LOCK TABLES `t_file_info_g3` WRITE;
/*!40000 ALTER TABLE `t_file_info_g3` DISABLE KEYS */;
INSERT INTO `t_file_info_g3` VALUES (999,901,'plain/text',0,0,12288,0,737,'2023-03-09 06:13:10','2023-03-24 08:57:39'),(999,902,'plain/text',0,0,0,0,0,'2023-03-14 02:22:41','2023-03-14 02:22:41'),(999,903,'plain/text',0,0,0,0,0,'2023-03-14 02:23:33','2023-03-14 02:23:33'),(999,904,'plain/text',0,0,0,0,0,'2023-03-14 02:23:59','2023-03-14 02:23:59'),(999,905,'plain/text',0,0,0,0,0,'2023-03-14 02:23:59','2023-03-14 02:23:59');
/*!40000 ALTER TABLE `t_file_info_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_folder_info_g3`
--

DROP TABLE IF EXISTS `t_folder_info_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_folder_info_g3` (
  `account_id` bigint NOT NULL,
  `node_id` bigint NOT NULL,
  `depth` int NOT NULL,
  `abs_path` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`account_id`,`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_folder_info_g3`
--

LOCK TABLES `t_folder_info_g3` WRITE;
/*!40000 ALTER TABLE `t_folder_info_g3` DISABLE KEYS */;
INSERT INTO `t_folder_info_g3` VALUES (999,900,0,'/','2023-03-09 06:13:10','2023-03-09 06:13:10');
/*!40000 ALTER TABLE `t_folder_info_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_nodes_g3`
--

DROP TABLE IF EXISTS `t_nodes_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_nodes_g3` (
  `account_id` bigint NOT NULL,
  `node_id` bigint NOT NULL,
  `node_uuid` varchar(64) NOT NULL,
  `name` varchar(32) NOT NULL,
  `type` int NOT NULL,
  `parent_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL,
  `created_user_id` bigint NOT NULL,
  `updated_user_id` bigint NOT NULL,
  `deleted` tinyint NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`account_id`,`node_id`),
  UNIQUE KEY `ui_node_uuid` (`node_uuid`),
  KEY `idx_type_updated_01` (`type`,`updated_at`,`node_id`),
  KEY `idx_type_name_01` (`type`,`name`,`node_id`),
  KEY `idx_type_created_01` (`type`,`created_at`,`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_nodes_g3`
--

LOCK TABLES `t_nodes_g3` WRITE;
/*!40000 ALTER TABLE `t_nodes_g3` DISABLE KEYS */;
INSERT INTO `t_nodes_g3` VALUES (999,900,'f2043330-8756-4553-aa81-e439f3b62c90--2425683101','MyBox',0,-1,900,2425693101,2425693101,0,'2023-03-09 06:13:10','2023-03-09 06:13:10'),(999,901,'b09d0a10-1de7-4f4f-bf5b-d76f57393ba9--2425683101','テストファイル',2,900,900,2425693101,2425693101,0,'2023-03-09 06:13:10','2023-03-09 06:13:10'),(999,902,'188a3a70-ac0d-461b-8102-34b6b6faa5e0','サンプル１',2,900,900,2425693101,2425693101,0,'2023-03-14 02:22:40','2023-03-14 02:22:40'),(999,903,'dcc0d3a4-6528-434b-bb77-efb18bef449d','サンプル２',2,900,900,2425693101,2425693101,0,'2023-03-14 02:23:59','2023-03-14 02:23:59'),(999,904,'4af47a53-f97d-4b46-b400-14d93c75ad35','サンプル３',2,900,900,2425693101,2425693101,0,'2023-03-14 02:23:59','2023-03-14 02:23:59'),(999,905,'d74ebe15-9bef-496a-abb4-08ee8c2fd4d8','サンプル４',2,900,900,2425693101,2425693101,0,'2023-03-14 02:23:59','2023-03-14 02:23:59');
/*!40000 ALTER TABLE `t_nodes_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_permission_info_g3`
--

DROP TABLE IF EXISTS `t_permission_info_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_permission_info_g3` (
  `account_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL,
  `editable_node_id` bigint NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`account_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_permission_info_g3`
--

LOCK TABLES `t_permission_info_g3` WRITE;
/*!40000 ALTER TABLE `t_permission_info_g3` DISABLE KEYS */;
INSERT INTO `t_permission_info_g3` VALUES (999,900,900,'2023-03-09 06:13:10','2023-03-09 06:13:10');
/*!40000 ALTER TABLE `t_permission_info_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_permissions_g3`
--

DROP TABLE IF EXISTS `t_permissions_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_permissions_g3` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `group_id` bigint NOT NULL,
  `privilege` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_permissions_g3`
--

LOCK TABLES `t_permissions_g3` WRITE;
/*!40000 ALTER TABLE `t_permissions_g3` DISABLE KEYS */;
INSERT INTO `t_permissions_g3` VALUES (1,999,900,2425693101,-1,1,'2023-03-09 06:13:10','2023-03-09 06:13:10'),(2,999,900,-1,10,2,'2023-03-09 06:13:10','2023-03-09 06:13:10'),(3,999,900,-1,20,2,'2023-03-09 06:13:10','2023-03-09 06:13:10');
/*!40000 ALTER TABLE `t_permissions_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sequence_info_g3`
--

DROP TABLE IF EXISTS `t_sequence_info_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sequence_info_g3` (
  `account_id` bigint NOT NULL,
  `name` varchar(16) NOT NULL,
  `value` bigint NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`account_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sequence_info_g3`
--

LOCK TABLES `t_sequence_info_g3` WRITE;
/*!40000 ALTER TABLE `t_sequence_info_g3` DISABLE KEYS */;
INSERT INTO `t_sequence_info_g3` VALUES (0,'account',1000,'2023-03-09 06:13:10','2023-03-09 06:13:10'),(999,'node',1000,'2023-03-09 06:13:10','2023-03-09 06:13:10'),(999,'permission',1000,'2023-03-09 06:13:10','2023-03-09 06:13:10'),(999,'version',1016,'2023-03-09 06:13:10','2023-03-24 08:57:39');
/*!40000 ALTER TABLE `t_sequence_info_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `db_mps_common_g3`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_mps_common_g3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_mps_common_g3`;

--
-- Table structure for table `t_account_info_g3`
--

DROP TABLE IF EXISTS `t_account_info_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_account_info_g3` (
  `account_id` bigint NOT NULL,
  `secret_key` text NOT NULL,
  `amount_used` bigint NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_account_info_g3`
--

LOCK TABLES `t_account_info_g3` WRITE;
/*!40000 ALTER TABLE `t_account_info_g3` DISABLE KEYS */;
INSERT INTO `t_account_info_g3` VALUES (999,'z_secretkey_should_be_in_here_==',0,'2023-03-28 05:15:18','2023-03-28 05:15:18');
/*!40000 ALTER TABLE `t_account_info_g3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user_g3`
--

DROP TABLE IF EXISTS `t_user_g3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_g3` (
  `user_id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `login_id` varchar(256) NOT NULL,
  `password_hash` varchar(256) NOT NULL,
  `account_id` bigint DEFAULT NULL,
  `mail_address` varchar(256) DEFAULT NULL,
  `furigana` varchar(64) DEFAULT NULL,
  `locale` varchar(5) NOT NULL,
  `timezone` varchar(32) NOT NULL,
  `deleted` tinyint NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_updated_at` (`updated_at`),
  KEY `idx_name` (`name`),
  KEY `idx_furigana` (`furigana`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user_g3`
--

LOCK TABLES `t_user_g3` WRITE;
/*!40000 ALTER TABLE `t_user_g3` DISABLE KEYS */;
INSERT INTO `t_user_g3` VALUES (2425693101,'目田文字郎','metamoji9999','ee79976c9380d5e337fc1c095ece8c8f22f91f306ceeb161fa51fecede2c4ba1',999,'metamojirou@test.metamoji.local','メタモジロウ','ja','Asia/Tokyo',0,'2023-03-10 06:00:00','2023-03-10 06:05:00');
/*!40000 ALTER TABLE `t_user_g3` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-28 12:46:10
