-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: 
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
-- Current Database: `ccdonuts`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ccdonuts` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `ccdonuts`;

--
-- Table structure for table `creditcards`
--

DROP TABLE IF EXISTS `creditcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creditcards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `valid_name` varchar(100) NOT NULL,
  `card_number` varchar(25) NOT NULL,
  `card_brand` varchar(30) NOT NULL,
  `valid_month` tinyint(2) NOT NULL,
  `valid_year` smallint(4) NOT NULL,
  `security_code` varchar(4) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_creditcards_number_customer` (`customer_id`,`card_number`),
  KEY `idx_creditcards_customer` (`customer_id`),
  CONSTRAINT `fk_creditcards_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creditcards`
--

LOCK TABLES `creditcards` WRITE;
/*!40000 ALTER TABLE `creditcards` DISABLE KEYS */;
/*!40000 ALTER TABLE `creditcards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `furigana` varchar(100) NOT NULL,
  `postcode_a` char(3) NOT NULL,
  `postcode_b` char(4) NOT NULL,
  `address` varchar(200) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1002,'茸筍','キノコタケノコ','123','4567','山','kinoko_takenoko@yama.com','$2y$10$HhAz0ioB9TkPnOqHgcmxZeiLAWQajt7gU1yLtrMt6QD0mhkw9Stuq'),(1003,'テスト1','テストイチ','123','4567','山','test1@yama.com','$2y$10$rg1mBMieuJGvXbMF4aU8eOaVd60LizwRtcGT9FOx3xE/PpTCfyxCy');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `customerId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`customerId`,`productId`),
  KEY `idx_favorites_product` (`productId`),
  CONSTRAINT `fk_favorites_customer` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_favorites_product` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (1002,2,'2025-10-10 21:00:10'),(1002,4,'2025-10-10 21:01:59'),(1003,1,'2025-10-09 14:18:27'),(1003,8,'2025-10-09 09:36:16');
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchaseId` int(11) NOT NULL,
  `creditcardId` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('authorized','captured','failed','cancelled','refunded') NOT NULL DEFAULT 'authorized',
  `paidAt` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_payments_purchase` (`purchaseId`),
  KEY `idx_payments_creditcard` (`creditcardId`),
  CONSTRAINT `fk_payments_creditcard` FOREIGN KEY (`creditcardId`) REFERENCES `creditcards` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_payments_purchase` FOREIGN KEY (`purchaseId`) REFERENCES `purchases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `introduction` varchar(1000) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `isNew` int(11) NOT NULL,
  `isSet` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'CCドーナツ 当店オリジナル（5個入り）',1500,'当店のオリジナル商品、CCドーナツは、サクサクの食感が特徴のプレーンタイプのドーナツです。素材にこだわり、丁寧に揚げた生地は軽やかでサクッとした食感が楽しめます。一口食べれば、口の中に広がる甘くて香ばしい香りと、口どけの良い食感が感じられます。','original.jpg',0,0),(2,'チョコレートデライト（5個入り）',1600,'チョコレートデライトは、濃厚なカカオの風味となめらかな口どけが特徴です。ひとつひとつ丁寧に仕上げたひと口サイズのチョコレートは、口に入れた瞬間に広がる芳醇な香りと上品な甘さをお楽しみいただけます。','chocolateDelight.jpg',0,0),(3,'キャラメルクリーム（5個入り）',1600,'キャラメルクリームは、やさしい甘さのキャラメルと、とろけるようなクリームの味わいが楽しめるスイーツです。なめらかな口どけと香ばしい風味が広がり、ひと口ごとに心まで満たされる上品な味わいに仕上げました。','caramelCream.jpg',0,0),(4,'プレーンクラシック（5個入り）',1500,'プレーンクラシック（5個入り）は、シンプルだからこそ素材の良さと職人の技が際立つスイーツです。香ばしく焼き上げた生地はふんわり軽やかで、ひと口食べればやさしい甘さと素朴な風味が広がります。毎日でも食べたくなる、当店定番のクラシックな一品です。','plainClassic.jpg',0,0),(5,'サマーシトラス（5個入り）',1600,'サマーシトラス（5個入り）は、爽やかな香りと軽やかな甘さが楽しめる限定スイーツです。ふんわり焼き上げた生地にシトラスの風味を閉じ込め、ひと口ごとに広がる清涼感は暑い季節にぴったり。紅茶やアイスコーヒーとの相性も良く、贈り物にもおすすめの爽快な一品です。','summerCitrus.jpg',1,0),(6,'ストロベリークラッシュ（5個入り）',1800,'ストロベリークラッシュ（5個入り）は、甘酸っぱい苺の香りとジューシーな果実感が楽しめる華やかなスイーツです。ふんわり焼き上げた生地にストロベリーの風味をぎゅっと閉じ込め、ひと口ごとに広がるフレッシュな味わいが特徴の一品です。','strawberryCrush.jpg',0,0),(7,'フルーツドーナツセット（12個入り）',3500,'新鮮で豊かなフルーツをたっぷりと使用した贅沢な12個入りセットです。このセットには、季節の最高のフルーツを厳選し、ドーナツに取り入れました。口に入れた瞬間にフルーツの風味と生地のハーモニーが広がります。色鮮やかな見た目も魅力の一つです。','fruitDonutAssortment.jpg',0,1),(8,'フルーツドーナツセット（14個入り）',4000,'フルーツドーナツセット（14個入り）は、爽やかな柑橘や甘酸っぱい苺など、多彩なフルーツフレーバーをたっぷり楽しめるボリューム満点のセットです。人数の多い集まりや特別なシーンにもぴったり。華やかで満足感のあるひと箱が、食卓をより楽しく彩ります。','fruitDonutSet.jpg',0,1),(9,'ベストセレクションボックス（4個入り）',1200,'当店おすすめの人気フレーバーを詰め合わせたベストセレクションボックス（4個入り）は、少量ながらこだわりの味を堪能できる特別なセットです。丁寧に仕上げたドーナツは、贈り物や自分へのご褒美にもぴったり。コンパクトでも満足感のある自慢のセレクションです。','bestSelectionBox.jpg',0,1),(10,'チョコクラッシュボックス（7個入り）',2400,'濃厚なチョコレートの風味をたっぷり楽しめるチョコクラッシュボックス（7個入り）は、食べ応えのある満足セットです。外はサクッと、中はふんわり仕上げたドーナツは、家族や友人とのシェアやギフトにも最適。チョコ好きに贈る特別なひと箱です。','chocolateCrushBox.jpg',0,1),(11,'クリームボックス（4個入り）',1400,'なめらかなクリームの甘さが楽しめるクリームボックス（4個入り）は、気軽に味わえる少量セットです。ふんわり生地と濃厚クリームの絶妙なバランスは、ティータイムやちょっとしたギフトにもぴったり。コンパクトでも満足感のある一品です。','creamBox4pcs.jpg',0,1),(12,'クリームボックス（9個入り）',2800,'クリームボックス（9個入り）は、なめらかなクリームの濃厚な味わいをたっぷり楽しめるボリュームセットです。ふんわり軽い生地とコク深いクリームが、ひと口ごとに広がる贅沢なひとときを演出します。大切な方へのギフトにも喜ばれる存在感のあるひと箱です。','creamBox9pcs.jpg',0,1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_details`
--

DROP TABLE IF EXISTS `purchase_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_details` (
  `purchaseId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `purchaseCount` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`purchaseId`,`productId`),
  KEY `idx_purchase_details_product` (`productId`),
  CONSTRAINT `fk_pdetail_product` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pdetail_purchase` FOREIGN KEY (`purchaseId`) REFERENCES `purchases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_details`
--

LOCK TABLES `purchase_details` WRITE;
/*!40000 ALTER TABLE `purchase_details` DISABLE KEYS */;
INSERT INTO `purchase_details` VALUES (1,2,5),(1,6,4),(2,12,6),(3,2,1),(4,5,21),(5,4,45),(6,10,3);
/*!40000 ALTER TABLE `purchase_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) NOT NULL,
  `purchaseDate` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','paid','shipped','cancelled','refunded') NOT NULL DEFAULT 'pending',
  `totalAmount` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_purchases_customer_date` (`customerId`,`purchaseDate`),
  CONSTRAINT `fk_purchases_customer` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
INSERT INTO `purchases` VALUES (1,1003,'2025-10-09 14:36:10','pending',15200),(2,1003,'2025-10-09 14:58:17','pending',16800),(3,1002,'2025-10-10 20:55:58','pending',1600),(4,1002,'2025-10-10 21:00:31','pending',33600),(5,1002,'2025-10-10 21:27:23','pending',67500),(6,1002,'2025-10-10 23:13:54','pending',7200);
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `mysql`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mysql` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;

USE `mysql`;

--
-- Table structure for table `general_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `general_log` (
  `event_time` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `user_host` mediumtext NOT NULL,
  `thread_id` bigint(21) unsigned NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `command_type` varchar(64) NOT NULL,
  `argument` mediumtext NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='General log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `slow_log` (
  `start_time` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `user_host` mediumtext NOT NULL,
  `query_time` time(6) NOT NULL,
  `lock_time` time(6) NOT NULL,
  `rows_sent` bigint(20) unsigned NOT NULL,
  `rows_examined` bigint(20) unsigned NOT NULL,
  `db` varchar(512) NOT NULL,
  `last_insert_id` int(11) NOT NULL,
  `insert_id` int(11) NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `sql_text` mediumtext NOT NULL,
  `thread_id` bigint(21) unsigned NOT NULL,
  `rows_affected` int(11) NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='Slow log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `column_stats`
--

DROP TABLE IF EXISTS `column_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `column_stats` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `column_name` varchar(64) NOT NULL,
  `min_value` varbinary(255) DEFAULT NULL,
  `max_value` varbinary(255) DEFAULT NULL,
  `nulls_ratio` decimal(12,4) DEFAULT NULL,
  `avg_length` decimal(12,4) DEFAULT NULL,
  `avg_frequency` decimal(12,4) DEFAULT NULL,
  `hist_size` tinyint(3) unsigned DEFAULT NULL,
  `hist_type` enum('SINGLE_PREC_HB','DOUBLE_PREC_HB') DEFAULT NULL,
  `histogram` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`db_name`,`table_name`,`column_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='Statistics on Columns';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `column_stats`
--

LOCK TABLES `column_stats` WRITE;
/*!40000 ALTER TABLE `column_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `column_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `columns_priv`
--

DROP TABLE IF EXISTS `columns_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `columns_priv` (
  `Host` char(60) NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `User` char(80) NOT NULL DEFAULT '',
  `Table_name` char(64) NOT NULL DEFAULT '',
  `Column_name` char(64) NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`,`Column_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Column privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `columns_priv`
--

LOCK TABLES `columns_priv` WRITE;
/*!40000 ALTER TABLE `columns_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `columns_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db`
--

DROP TABLE IF EXISTS `db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db` (
  `Host` char(60) NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `User` char(80) NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Delete_history_priv` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Host`,`Db`,`User`),
  KEY `User` (`User`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Database privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db`
--

LOCK TABLES `db` WRITE;
/*!40000 ALTER TABLE `db` DISABLE KEYS */;
INSERT INTO `db` VALUES ('localhost','phpmyadmin','pma','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('%','sisiwaka\\_touen','sisiwaka_admin','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('%','sisiwaka\\_touen','sisiwaka_editor','Y','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N'),('%','sisiwaka\\_touen','sisiwaka_reader','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N');
/*!40000 ALTER TABLE `db` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` char(64) NOT NULL DEFAULT '',
  `body` longblob NOT NULL,
  `definer` char(141) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `execute_at` datetime DEFAULT NULL,
  `interval_value` int(11) DEFAULT NULL,
  `interval_field` enum('YEAR','QUARTER','MONTH','DAY','HOUR','MINUTE','WEEK','SECOND','MICROSECOND','YEAR_MONTH','DAY_HOUR','DAY_MINUTE','DAY_SECOND','HOUR_MINUTE','HOUR_SECOND','MINUTE_SECOND','DAY_MICROSECOND','HOUR_MICROSECOND','MINUTE_MICROSECOND','SECOND_MICROSECOND') DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_executed` datetime DEFAULT NULL,
  `starts` datetime DEFAULT NULL,
  `ends` datetime DEFAULT NULL,
  `status` enum('ENABLED','DISABLED','SLAVESIDE_DISABLED') NOT NULL DEFAULT 'ENABLED',
  `on_completion` enum('DROP','PRESERVE') NOT NULL DEFAULT 'DROP',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','IGNORE_BAD_TABLE_OPTIONS','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH','EMPTY_STRING_IS_NULL','SIMULTANEOUS_ASSIGNMENT','TIME_ROUND_FRACTIONAL') NOT NULL DEFAULT '',
  `comment` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `originator` int(10) unsigned NOT NULL,
  `time_zone` char(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'SYSTEM',
  `character_set_client` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `collation_connection` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `db_collation` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `body_utf8` longblob DEFAULT NULL,
  PRIMARY KEY (`db`,`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Events';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `func`
--

DROP TABLE IF EXISTS `func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `func` (
  `name` char(64) NOT NULL DEFAULT '',
  `ret` tinyint(1) NOT NULL DEFAULT 0,
  `dl` char(128) NOT NULL DEFAULT '',
  `type` enum('function','aggregate') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='User defined functions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `func`
--

LOCK TABLES `func` WRITE;
/*!40000 ALTER TABLE `func` DISABLE KEYS */;
/*!40000 ALTER TABLE `func` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_priv`
--

DROP TABLE IF EXISTS `global_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_priv` (
  `Host` char(60) NOT NULL DEFAULT '',
  `User` char(80) NOT NULL DEFAULT '',
  `Priv` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}' CHECK (json_valid(`Priv`)),
  PRIMARY KEY (`Host`,`User`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Users and global privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_priv`
--

LOCK TABLES `global_priv` WRITE;
/*!40000 ALTER TABLE `global_priv` DISABLE KEYS */;
INSERT INTO `global_priv` VALUES ('localhost','root','{\"access\":18446744073709551615}'),('localhost','mariadb.sys','{\"access\":0,\"plugin\":\"mysql_native_password\",\"authentication_string\":\"\",\"account_locked\":true,\"password_last_changed\":0}'),('127.0.0.1','root','{\"access\":18446744073709551615}'),('::1','root','{\"access\":18446744073709551615}'),('localhost','pma','{\"access\":0,\"plugin\":\"mysql_native_password\",\"authentication_string\":\"\",\"password_last_changed\":1571661132}'),('%','sisiwaka_editor','{\"access\":0,\"plugin\":\"mysql_native_password\",\"authentication_string\":\"*C9C594034C75CD8D683293365BA038A6FF598457\",\"password_last_changed\":1760545196,\"ssl_type\":0,\"ssl_cipher\":\"\",\"x509_issuer\":\"\",\"x509_subject\":\"\",\"max_questions\":0,\"max_updates\":0,\"max_connections\":0,\"max_user_connections\":0}'),('%','sisiwaka_reader','{\"access\":0,\"plugin\":\"mysql_native_password\",\"authentication_string\":\"*650DCD4ADAA7B1772A48882A8D74FBC621E23AF3\",\"password_last_changed\":1760545246,\"ssl_type\":0,\"ssl_cipher\":\"\",\"x509_issuer\":\"\",\"x509_subject\":\"\",\"max_questions\":0,\"max_updates\":0,\"max_connections\":0,\"max_user_connections\":0}'),('%','sisiwaka_admin','{\"access\":0,\"plugin\":\"mysql_native_password\",\"authentication_string\":\"*5349EF4A74B147AF4CBF48FAB3FDB436A9746946\",\"password_last_changed\":1760545294,\"ssl_type\":0,\"ssl_cipher\":\"\",\"x509_issuer\":\"\",\"x509_subject\":\"\",\"max_questions\":0,\"max_updates\":0,\"max_connections\":0,\"max_user_connections\":0}');
/*!40000 ALTER TABLE `global_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gtid_slave_pos`
--

DROP TABLE IF EXISTS `gtid_slave_pos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gtid_slave_pos` (
  `domain_id` int(10) unsigned NOT NULL,
  `sub_id` bigint(20) unsigned NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `seq_no` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`domain_id`,`sub_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Replication slave GTID position';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gtid_slave_pos`
--

LOCK TABLES `gtid_slave_pos` WRITE;
/*!40000 ALTER TABLE `gtid_slave_pos` DISABLE KEYS */;
/*!40000 ALTER TABLE `gtid_slave_pos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_category`
--

DROP TABLE IF EXISTS `help_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_category` (
  `help_category_id` smallint(5) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `parent_category_id` smallint(5) unsigned DEFAULT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='help categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_category`
--

LOCK TABLES `help_category` WRITE;
/*!40000 ALTER TABLE `help_category` DISABLE KEYS */;
INSERT INTO `help_category` VALUES (1,'Geographic',0,''),(2,'Polygon Properties',34,''),(3,'WKT',34,''),(4,'Numeric Functions',38,''),(5,'Plugins',35,''),(6,'MBR',34,''),(7,'Control Flow Functions',38,''),(8,'Transactions',35,''),(9,'Help Metadata',35,''),(10,'Account Management',35,''),(11,'Point Properties',34,''),(12,'Encryption Functions',38,''),(13,'LineString Properties',34,''),(14,'Miscellaneous Functions',38,''),(15,'Logical Operators',38,''),(16,'Functions and Modifiers for Use with GROUP BY',35,''),(17,'Information Functions',38,''),(18,'Comparison Operators',38,''),(19,'Bit Functions',38,''),(20,'Table Maintenance',35,''),(21,'User-Defined Functions',35,''),(22,'Data Types',35,''),(23,'Compound Statements',35,''),(24,'Geometry Constructors',34,''),(25,'GeometryCollection Properties',1,''),(26,'Administration',35,''),(27,'Data Manipulation',35,''),(28,'Utility',35,''),(29,'Language Structure',35,''),(30,'Geometry Relations',34,''),(31,'Date and Time Functions',38,''),(32,'WKB',34,''),(33,'Procedures',35,''),(34,'Geographic Features',35,''),(35,'Contents',0,''),(36,'Geometry Properties',34,''),(37,'String Functions',38,''),(38,'Functions',35,''),(39,'Data Definition',35,''),(40,'Sequences',35,''),(41,'JSON Functions',38,''),(42,'Window Functions',38,''),(43,'Spider Functions',38,''),(44,'Dynamic Column Functions',38,''),(45,'Storage Engines',35,''),(46,'InnoDB',45,''),(47,'Optimization and Indexes',35,''),(48,'Full-text Indexes',47,'');
/*!40000 ALTER TABLE `help_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_keyword`
--

LOCK TABLES `help_keyword` WRITE;
/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
INSERT INTO `help_keyword` VALUES (1,'account'),(2,'aggregate'),(3,'add'),(4,'after'),(5,'alter'),(6,'completion'),(7,'schedule'),(8,'server'),(9,'columns'),(10,'drop'),(11,'analyze'),(12,'json'),(13,'value'),(14,'master_ssl_ca'),(15,'master_ssl_verify_cert'),(16,'nchar'),(17,'action'),(18,'create'),(19,'at'),(20,'starts'),(21,'returns'),(22,'host'),(23,'row_format'),(24,'deallocate prepare'),(25,'drop prepare'),(26,'against'),(27,'fulltext'),(28,'escape'),(29,'mode'),(30,'repeat'),(31,'sql_big_result'),(32,'isolation'),(33,'read committed'),(34,'read uncommitted'),(35,'repeatable read'),(36,'serializable'),(37,'work');
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_relation`
--

DROP TABLE IF EXISTS `help_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_relation` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `help_keyword_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`help_keyword_id`,`help_topic_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='keyword-topic relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_relation`
--

LOCK TABLES `help_relation` WRITE;
/*!40000 ALTER TABLE `help_relation` DISABLE KEYS */;
INSERT INTO `help_relation` VALUES (116,1),(118,1),(119,1),(183,2),(184,2),(185,2),(186,2),(187,2),(188,2),(189,2),(190,2),(191,2),(192,2),(193,2),(194,2),(196,2),(197,2),(199,2),(258,2),(724,2),(652,3),(751,3),(652,4),(119,5),(645,5),(646,5),(647,5),(648,5),(649,5),(650,5),(652,5),(653,5),(654,5),(646,6),(657,6),(646,7),(657,7),(651,8),(357,9),(652,9),(665,9),(97,10),(120,10),(259,10),(652,10),(669,10),(670,10),(671,10),(672,10),(673,10),(674,10),(675,10),(676,10),(677,10),(678,10),(680,10),(681,10),(251,11),(444,11),(446,11),(447,11),(280,12),(447,12),(448,12),(449,12),(264,13),(317,13),(320,13),(419,13),(435,13),(95,14),(95,15),(271,16),(655,17),(665,17),(118,18),(127,18),(258,18),(656,18),(657,18),(658,18),(659,18),(660,18),(661,18),(662,18),(663,18),(664,18),(665,18),(666,18),(667,18),(668,18),(657,19),(657,20),(258,21),(664,22),(665,23),(97,24),(97,25),(614,26),(752,26),(752,27),(753,27),(607,28),(436,29),(614,29),(316,30),(625,30),(436,31),(108,32),(108,33),(108,34),(108,35),(108,36),(110,37);
/*!40000 ALTER TABLE `help_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_topic`
--

DROP TABLE IF EXISTS `help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_topic` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `help_category_id` smallint(5) unsigned NOT NULL,
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_topic_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='help topics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_topic`
--

LOCK TABLES `help_topic` WRITE;
/*!40000 ALTER TABLE `help_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `help_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `index_stats`
--

DROP TABLE IF EXISTS `index_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_stats` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `index_name` varchar(64) NOT NULL,
  `prefix_arity` int(11) unsigned NOT NULL,
  `avg_frequency` decimal(12,4) DEFAULT NULL,
  PRIMARY KEY (`db_name`,`table_name`,`index_name`,`prefix_arity`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='Statistics on Indexes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `index_stats`
--

LOCK TABLES `index_stats` WRITE;
/*!40000 ALTER TABLE `index_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `index_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `innodb_index_stats`
--

DROP TABLE IF EXISTS `innodb_index_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `innodb_index_stats` (
  `database_name` varchar(64) NOT NULL,
  `table_name` varchar(199) NOT NULL,
  `index_name` varchar(64) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `stat_name` varchar(64) NOT NULL,
  `stat_value` bigint(20) unsigned NOT NULL,
  `sample_size` bigint(20) unsigned DEFAULT NULL,
  `stat_description` varchar(1024) NOT NULL,
  PRIMARY KEY (`database_name`,`table_name`,`index_name`,`stat_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `innodb_table_stats`
--

DROP TABLE IF EXISTS `innodb_table_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `innodb_table_stats` (
  `database_name` varchar(64) NOT NULL,
  `table_name` varchar(199) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `n_rows` bigint(20) unsigned NOT NULL,
  `clustered_index_size` bigint(20) unsigned NOT NULL,
  `sum_of_other_index_sizes` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`database_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin` (
  `name` varchar(64) NOT NULL DEFAULT '',
  `dl` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='MySQL plugins';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin`
--

LOCK TABLES `plugin` WRITE;
/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proc`
--

DROP TABLE IF EXISTS `proc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proc` (
  `db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` char(64) NOT NULL DEFAULT '',
  `type` enum('FUNCTION','PROCEDURE','PACKAGE','PACKAGE BODY') NOT NULL,
  `specific_name` char(64) NOT NULL DEFAULT '',
  `language` enum('SQL') NOT NULL DEFAULT 'SQL',
  `sql_data_access` enum('CONTAINS_SQL','NO_SQL','READS_SQL_DATA','MODIFIES_SQL_DATA') NOT NULL DEFAULT 'CONTAINS_SQL',
  `is_deterministic` enum('YES','NO') NOT NULL DEFAULT 'NO',
  `security_type` enum('INVOKER','DEFINER') NOT NULL DEFAULT 'DEFINER',
  `param_list` blob NOT NULL,
  `returns` longblob NOT NULL,
  `body` longblob NOT NULL,
  `definer` char(141) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','IGNORE_BAD_TABLE_OPTIONS','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH','EMPTY_STRING_IS_NULL','SIMULTANEOUS_ASSIGNMENT','TIME_ROUND_FRACTIONAL') NOT NULL DEFAULT '',
  `comment` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `character_set_client` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `collation_connection` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `db_collation` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `body_utf8` longblob DEFAULT NULL,
  `aggregate` enum('NONE','GROUP') NOT NULL DEFAULT 'NONE',
  PRIMARY KEY (`db`,`name`,`type`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Stored Procedures';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proc`
--

LOCK TABLES `proc` WRITE;
/*!40000 ALTER TABLE `proc` DISABLE KEYS */;
/*!40000 ALTER TABLE `proc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procs_priv`
--

DROP TABLE IF EXISTS `procs_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procs_priv` (
  `Host` char(60) NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `User` char(80) NOT NULL DEFAULT '',
  `Routine_name` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `Routine_type` enum('FUNCTION','PROCEDURE','PACKAGE','PACKAGE BODY') NOT NULL,
  `Grantor` char(141) NOT NULL DEFAULT '',
  `Proc_priv` set('Execute','Alter Routine','Grant') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`Host`,`Db`,`User`,`Routine_name`,`Routine_type`),
  KEY `Grantor` (`Grantor`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Procedure privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procs_priv`
--

LOCK TABLES `procs_priv` WRITE;
/*!40000 ALTER TABLE `procs_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `procs_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxies_priv`
--

DROP TABLE IF EXISTS `proxies_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxies_priv` (
  `Host` char(60) NOT NULL DEFAULT '',
  `User` char(80) NOT NULL DEFAULT '',
  `Proxied_host` char(60) NOT NULL DEFAULT '',
  `Proxied_user` char(80) NOT NULL DEFAULT '',
  `With_grant` tinyint(1) NOT NULL DEFAULT 0,
  `Grantor` char(141) NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`Host`,`User`,`Proxied_host`,`Proxied_user`),
  KEY `Grantor` (`Grantor`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='User proxy privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxies_priv`
--

LOCK TABLES `proxies_priv` WRITE;
/*!40000 ALTER TABLE `proxies_priv` DISABLE KEYS */;
INSERT INTO `proxies_priv` VALUES ('localhost','root','','',1,'','2019-10-21 12:17:49');
/*!40000 ALTER TABLE `proxies_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_mapping`
--

DROP TABLE IF EXISTS `roles_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_mapping` (
  `Host` char(60) NOT NULL DEFAULT '',
  `User` char(80) NOT NULL DEFAULT '',
  `Role` char(80) NOT NULL DEFAULT '',
  `Admin_option` enum('N','Y') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  UNIQUE KEY `Host` (`Host`,`User`,`Role`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Granted roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_mapping`
--

LOCK TABLES `roles_mapping` WRITE;
/*!40000 ALTER TABLE `roles_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `Server_name` char(64) NOT NULL DEFAULT '',
  `Host` varchar(2048) NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `Username` char(80) NOT NULL DEFAULT '',
  `Password` char(64) NOT NULL DEFAULT '',
  `Port` int(4) NOT NULL DEFAULT 0,
  `Socket` char(64) NOT NULL DEFAULT '',
  `Wrapper` char(64) NOT NULL DEFAULT '',
  `Owner` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`Server_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='MySQL Foreign Servers table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servers`
--

LOCK TABLES `servers` WRITE;
/*!40000 ALTER TABLE `servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `table_stats`
--

DROP TABLE IF EXISTS `table_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_stats` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `cardinality` bigint(21) unsigned DEFAULT NULL,
  PRIMARY KEY (`db_name`,`table_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=0 COMMENT='Statistics on Tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `table_stats`
--

LOCK TABLES `table_stats` WRITE;
/*!40000 ALTER TABLE `table_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `table_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables_priv`
--

DROP TABLE IF EXISTS `tables_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tables_priv` (
  `Host` char(60) NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `User` char(80) NOT NULL DEFAULT '',
  `Table_name` char(64) NOT NULL DEFAULT '',
  `Grantor` char(141) NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Table_priv` set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter','Create View','Show view','Trigger','Delete versioning rows') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`),
  KEY `Grantor` (`Grantor`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_bin PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Table privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables_priv`
--

LOCK TABLES `tables_priv` WRITE;
/*!40000 ALTER TABLE `tables_priv` DISABLE KEYS */;
INSERT INTO `tables_priv` VALUES ('localhost','mysql','mariadb.sys','global_priv','root@localhost','0000-00-00 00:00:00','Select,Delete','');
/*!40000 ALTER TABLE `tables_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone`
--

DROP TABLE IF EXISTS `time_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone` (
  `Time_zone_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Use_leap_seconds` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Time_zone_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone`
--

LOCK TABLES `time_zone` WRITE;
/*!40000 ALTER TABLE `time_zone` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_leap_second`
--

DROP TABLE IF EXISTS `time_zone_leap_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_leap_second` (
  `Transition_time` bigint(20) NOT NULL,
  `Correction` int(11) NOT NULL,
  PRIMARY KEY (`Transition_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Leap seconds information for time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_leap_second`
--

LOCK TABLES `time_zone_leap_second` WRITE;
/*!40000 ALTER TABLE `time_zone_leap_second` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_leap_second` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_name`
--

DROP TABLE IF EXISTS `time_zone_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_name` (
  `Name` char(64) NOT NULL,
  `Time_zone_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Time zone names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_name`
--

LOCK TABLES `time_zone_name` WRITE;
/*!40000 ALTER TABLE `time_zone_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_transition`
--

DROP TABLE IF EXISTS `time_zone_transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_transition` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_time` bigint(20) NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Time_zone_id`,`Transition_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Time zone transitions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_transition`
--

LOCK TABLES `time_zone_transition` WRITE;
/*!40000 ALTER TABLE `time_zone_transition` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_transition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_transition_type`
--

DROP TABLE IF EXISTS `time_zone_transition_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_transition_type` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  `Offset` int(11) NOT NULL DEFAULT 0,
  `Is_DST` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Abbreviation` char(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`Time_zone_id`,`Transition_type_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci PAGE_CHECKSUM=1 TRANSACTIONAL=1 COMMENT='Time zone transition types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_transition_type`
--

LOCK TABLES `time_zone_transition_type` WRITE;
/*!40000 ALTER TABLE `time_zone_transition_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_transition_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user`
--

DROP TABLE IF EXISTS `user`;
/*!50001 DROP VIEW IF EXISTS `user`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `user` AS SELECT
 1 AS `Host`,
  1 AS `User`,
  1 AS `Password`,
  1 AS `Select_priv`,
  1 AS `Insert_priv`,
  1 AS `Update_priv`,
  1 AS `Delete_priv`,
  1 AS `Create_priv`,
  1 AS `Drop_priv`,
  1 AS `Reload_priv`,
  1 AS `Shutdown_priv`,
  1 AS `Process_priv`,
  1 AS `File_priv`,
  1 AS `Grant_priv`,
  1 AS `References_priv`,
  1 AS `Index_priv`,
  1 AS `Alter_priv`,
  1 AS `Show_db_priv`,
  1 AS `Super_priv`,
  1 AS `Create_tmp_table_priv`,
  1 AS `Lock_tables_priv`,
  1 AS `Execute_priv`,
  1 AS `Repl_slave_priv`,
  1 AS `Repl_client_priv`,
  1 AS `Create_view_priv`,
  1 AS `Show_view_priv`,
  1 AS `Create_routine_priv`,
  1 AS `Alter_routine_priv`,
  1 AS `Create_user_priv`,
  1 AS `Event_priv`,
  1 AS `Trigger_priv`,
  1 AS `Create_tablespace_priv`,
  1 AS `Delete_history_priv`,
  1 AS `ssl_type`,
  1 AS `ssl_cipher`,
  1 AS `x509_issuer`,
  1 AS `x509_subject`,
  1 AS `max_questions`,
  1 AS `max_updates`,
  1 AS `max_connections`,
  1 AS `max_user_connections`,
  1 AS `plugin`,
  1 AS `authentication_string`,
  1 AS `password_expired`,
  1 AS `is_role`,
  1 AS `default_role`,
  1 AS `max_statement_time` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transaction_registry`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `transaction_registry` (
  `transaction_id` bigint(20) unsigned NOT NULL,
  `commit_id` bigint(20) unsigned NOT NULL,
  `begin_timestamp` timestamp(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000',
  `commit_timestamp` timestamp(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000',
  `isolation_level` enum('READ-UNCOMMITTED','READ-COMMITTED','REPEATABLE-READ','SERIALIZABLE') NOT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `commit_id` (`commit_id`),
  KEY `begin_timestamp` (`begin_timestamp`),
  KEY `commit_timestamp` (`commit_timestamp`,`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin STATS_PERSISTENT=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `phpmyadmin`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `phpmyadmin` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `phpmyadmin`;

--
-- Table structure for table `pma__bookmark`
--

DROP TABLE IF EXISTS `pma__bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__bookmark` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__bookmark`
--

LOCK TABLES `pma__bookmark` WRITE;
/*!40000 ALTER TABLE `pma__bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__central_columns`
--

DROP TABLE IF EXISTS `pma__central_columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL,
  PRIMARY KEY (`db_name`,`col_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__central_columns`
--

LOCK TABLES `pma__central_columns` WRITE;
/*!40000 ALTER TABLE `pma__central_columns` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__central_columns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__column_info`
--

DROP TABLE IF EXISTS `pma__column_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__column_info` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__column_info`
--

LOCK TABLES `pma__column_info` WRITE;
/*!40000 ALTER TABLE `pma__column_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__column_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__designer_settings`
--

DROP TABLE IF EXISTS `pma__designer_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__designer_settings`
--

LOCK TABLES `pma__designer_settings` WRITE;
/*!40000 ALTER TABLE `pma__designer_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__designer_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__export_templates`
--

DROP TABLE IF EXISTS `pma__export_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__export_templates` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__export_templates`
--

LOCK TABLES `pma__export_templates` WRITE;
/*!40000 ALTER TABLE `pma__export_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__export_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__favorite`
--

DROP TABLE IF EXISTS `pma__favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__favorite`
--

LOCK TABLES `pma__favorite` WRITE;
/*!40000 ALTER TABLE `pma__favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__history`
--

DROP TABLE IF EXISTS `pma__history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`,`db`,`table`,`timevalue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__history`
--

LOCK TABLES `pma__history` WRITE;
/*!40000 ALTER TABLE `pma__history` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__navigationhiding`
--

DROP TABLE IF EXISTS `pma__navigationhiding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__navigationhiding`
--

LOCK TABLES `pma__navigationhiding` WRITE;
/*!40000 ALTER TABLE `pma__navigationhiding` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__navigationhiding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__pdf_pages`
--

DROP TABLE IF EXISTS `pma__pdf_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`page_nr`),
  KEY `db_name` (`db_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__pdf_pages`
--

LOCK TABLES `pma__pdf_pages` WRITE;
/*!40000 ALTER TABLE `pma__pdf_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__pdf_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__recent`
--

DROP TABLE IF EXISTS `pma__recent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__recent`
--

LOCK TABLES `pma__recent` WRITE;
/*!40000 ALTER TABLE `pma__recent` DISABLE KEYS */;
INSERT INTO `pma__recent` VALUES ('root','[{\"db\":\"sisiwaka_touen\",\"table\":\"artwork_media\"},{\"db\":\"sisiwaka_touen\",\"table\":\"artworks\"},{\"db\":\"sisiwaka_touen\",\"table\":\"artworks_import_raw\"},{\"db\":\"sisiwaka_touen\",\"table\":\"categories\"},{\"db\":\"sisiwaka_touen\",\"table\":\"users\"},{\"db\":\"sisiwaka_touen\",\"table\":\"updates\"},{\"db\":\"sisiwaka_touen\",\"table\":\"techniques\"},{\"db\":\"sisiwaka_touen\",\"table\":\"colorings\"},{\"db\":\"ccdonuts\",\"table\":\"purchase_details\"},{\"db\":\"ccdonuts\",\"table\":\"purchases\"}]');
/*!40000 ALTER TABLE `pma__recent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__relation`
--

DROP TABLE IF EXISTS `pma__relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  KEY `foreign_field` (`foreign_db`,`foreign_table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__relation`
--

LOCK TABLES `pma__relation` WRITE;
/*!40000 ALTER TABLE `pma__relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__savedsearches`
--

DROP TABLE IF EXISTS `pma__savedsearches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__savedsearches` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__savedsearches`
--

LOCK TABLES `pma__savedsearches` WRITE;
/*!40000 ALTER TABLE `pma__savedsearches` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__savedsearches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__table_coords`
--

DROP TABLE IF EXISTS `pma__table_coords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float unsigned NOT NULL DEFAULT 0,
  `y` float unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__table_coords`
--

LOCK TABLES `pma__table_coords` WRITE;
/*!40000 ALTER TABLE `pma__table_coords` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__table_coords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__table_info`
--

DROP TABLE IF EXISTS `pma__table_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`db_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__table_info`
--

LOCK TABLES `pma__table_info` WRITE;
/*!40000 ALTER TABLE `pma__table_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__table_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__table_uiprefs`
--

DROP TABLE IF EXISTS `pma__table_uiprefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`username`,`db_name`,`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__table_uiprefs`
--

LOCK TABLES `pma__table_uiprefs` WRITE;
/*!40000 ALTER TABLE `pma__table_uiprefs` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__table_uiprefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__tracking`
--

DROP TABLE IF EXISTS `pma__tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`db_name`,`table_name`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__tracking`
--

LOCK TABLES `pma__tracking` WRITE;
/*!40000 ALTER TABLE `pma__tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__userconfig`
--

DROP TABLE IF EXISTS `pma__userconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__userconfig`
--

LOCK TABLES `pma__userconfig` WRITE;
/*!40000 ALTER TABLE `pma__userconfig` DISABLE KEYS */;
INSERT INTO `pma__userconfig` VALUES ('root','2025-10-19 15:55:43','{\"Console\\/Mode\":\"collapse\",\"lang\":\"ja\"}');
/*!40000 ALTER TABLE `pma__userconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__usergroups`
--

DROP TABLE IF EXISTS `pma__usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`usergroup`,`tab`,`allowed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__usergroups`
--

LOCK TABLES `pma__usergroups` WRITE;
/*!40000 ALTER TABLE `pma__usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pma__users`
--

DROP TABLE IF EXISTS `pma__users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL,
  PRIMARY KEY (`username`,`usergroup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pma__users`
--

LOCK TABLES `pma__users` WRITE;
/*!40000 ALTER TABLE `pma__users` DISABLE KEYS */;
/*!40000 ALTER TABLE `pma__users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `sisiwaka_touen`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sisiwaka_touen` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `sisiwaka_touen`;

--
-- Table structure for table `artwork_media`
--

DROP TABLE IF EXISTS `artwork_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artwork_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `artwork_id` int(11) NOT NULL,
  `kind` enum('image','video') NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `video_url` varchar(500) DEFAULT NULL,
  `alt_ja` varchar(255) DEFAULT NULL,
  `alt_en` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_artwork_media_artwork` (`artwork_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5423 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artwork_media`
--

LOCK TABLES `artwork_media` WRITE;
/*!40000 ALTER TABLE `artwork_media` DISABLE KEYS */;
INSERT INTO `artwork_media` VALUES (3795,32,'image','https://storage.googleapis.com/sisiwaka-touen-medias/032/032_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,32,1),(3796,32,'image','https://storage.googleapis.com/sisiwaka-touen-medias/032/032_02%E5%B7%A6.jpg',NULL,NULL,NULL,32,1),(3797,32,'image','https://storage.googleapis.com/sisiwaka-touen-medias/032/032_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,32,1),(3798,32,'image','https://storage.googleapis.com/sisiwaka-touen-medias/032/032_04%E5%8F%B3.jpg',NULL,NULL,NULL,32,1),(3799,32,'image','https://storage.googleapis.com/sisiwaka-touen-medias/032/032_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,32,1),(3800,32,'image','https://storage.googleapis.com/sisiwaka-touen-medias/032/032_06%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,32,1),(3801,32,'image','https://storage.googleapis.com/sisiwaka-touen-medias/032/032_07%E5%BA%95.jpg',NULL,NULL,NULL,32,1),(3802,32,'image','https://storage.googleapis.com/sisiwaka-touen-medias/032/032_08%E6%8E%A5%E5%86%99.jpg',NULL,NULL,NULL,32,1),(3803,32,'video','https://storage.googleapis.com/sisiwaka-touen-medias/032/032_%E8%9C%86%E3%81%AE%E7%BE%A4%E7%94%9F.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/032/032_%E8%9C%86%E3%81%AE%E7%BE%A4%E7%94%9F.mp4',NULL,NULL,32,1),(5068,1,'image','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,1,1),(5069,1,'image','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_02%E5%8F%B3.jpg',NULL,NULL,NULL,1,1),(5070,1,'image','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,1,1),(5071,1,'image','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_04%E5%B7%A6.jpg',NULL,NULL,NULL,1,1),(5072,1,'image','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,1,1),(5073,1,'image','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_06%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,1,1),(5074,1,'image','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_07%E8%A3%8F.jpg',NULL,NULL,NULL,1,1),(5075,1,'image','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_08%E5%A4%96%E5%81%B4%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,1,1),(5076,1,'image','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_09%E5%86%85%E5%81%B4%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,1,1),(5077,1,'image','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_10%E9%AB%98%E5%8F%B0%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,1,1),(5078,1,'video','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_%E9%BB%92%E4%BA%80.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/001/001_%E9%BB%92%E4%BA%80.mp4',NULL,NULL,1,1),(5079,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,3,1),(5080,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_02%E5%B7%A6.jpg',NULL,NULL,NULL,3,1),(5081,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,3,1),(5082,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_04%E5%8F%B3.jpg',NULL,NULL,NULL,3,1),(5083,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,3,1),(5084,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_06%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,3,1),(5085,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_07%E5%8F%96%E3%81%A3%E6%89%8B%E5%81%B4%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,3,1),(5086,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_08%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,3,1),(5087,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_09%E8%A6%8B%E8%BE%BC%E3%81%BF%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,3,1),(5088,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_10%E8%A3%8F.jpg',NULL,NULL,NULL,3,1),(5089,3,'image','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_11%E8%B6%B3.jpg',NULL,NULL,NULL,3,1),(5090,3,'video','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_%E5%8D%81%E4%BA%8C%E5%88%BB.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/003/003_%E5%8D%81%E4%BA%8C%E5%88%BB.mp4',NULL,NULL,3,1),(5091,7,'image','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,7,1),(5092,7,'image','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_02%E6%89%8B%E6%8C%81%E3%81%A12.jpg',NULL,NULL,NULL,7,1),(5093,7,'image','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_03%E5%85%A8%E4%BD%93.jpg',NULL,NULL,NULL,7,1),(5094,7,'image','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_04%E6%96%9C%E3%82%81%E4%B8%8A.jpg',NULL,NULL,NULL,7,1),(5095,7,'image','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_05%E3%81%82%E3%81%8A%E3%82%8A.jpg',NULL,NULL,NULL,7,1),(5096,7,'image','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_06%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,7,1),(5097,7,'image','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_07%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,7,1),(5098,7,'image','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_08%E8%A3%8F.jpg',NULL,NULL,NULL,7,1),(5099,7,'image','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_09%E8%B6%B3.jpg',NULL,NULL,NULL,7,1),(5100,7,'video','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_%E7%8E%84%E6%AD%A6%E7%9A%BF.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/007/007_%E7%8E%84%E6%AD%A6%E7%9A%BF.mp4',NULL,NULL,7,1),(5101,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,8,1),(5102,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_02%E5%8F%B3.jpg',NULL,NULL,NULL,8,1),(5103,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,8,1),(5104,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_04%E5%B7%A6.jpg',NULL,NULL,NULL,8,1),(5105,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,8,1),(5106,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_06%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,8,1),(5107,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_07%E5%8F%96%E3%81%A3%E6%89%8B%E8%A3%8F.jpg',NULL,NULL,NULL,8,1),(5108,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_08%E5%8F%96%E3%81%A3%E6%89%8B%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,8,1),(5109,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_09%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,8,1),(5110,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_10%E8%A6%8B%E8%BE%BC%E3%81%BF%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,8,1),(5111,8,'image','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_11%E8%A3%8F.jpg',NULL,NULL,NULL,8,1),(5112,8,'video','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_%E3%82%A2%E3%83%AB%E3%83%9E%E3%82%B8%E3%83%AD.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/008/008_%E3%82%A2%E3%83%AB%E3%83%9E%E3%82%B8%E3%83%AD.mp4',NULL,NULL,8,1),(5113,20,'image','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,20,1),(5114,20,'image','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_02%E5%8F%B3.jpg',NULL,NULL,NULL,20,1),(5115,20,'image','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_02%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,20,1),(5116,20,'image','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_03%E5%B7%A6.jpg',NULL,NULL,NULL,20,1),(5117,20,'image','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_04%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,20,1),(5118,20,'image','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_05%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,20,1),(5119,20,'image','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_06%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,20,1),(5120,20,'image','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_07%E8%A6%8B%E8%BE%BC%E3%81%BF%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,20,1),(5121,20,'image','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_08%E8%A3%8F.jpg',NULL,NULL,NULL,20,1),(5122,20,'image','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_09%E8%B6%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,20,1),(5123,20,'video','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_%E8%B5%AB%E8%80%80%E3%81%AE%E7%A7%98%E5%85%89.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/020/020_%E8%B5%AB%E8%80%80%E3%81%AE%E7%A7%98%E5%85%89.mp4',NULL,NULL,20,1),(5124,21,'image','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,21,1),(5125,21,'image','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_02%E5%B7%A6.jpg',NULL,NULL,NULL,21,1),(5126,21,'image','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,21,1),(5127,21,'image','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_04%E5%8F%B3.jpg',NULL,NULL,NULL,21,1),(5128,21,'image','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,21,1),(5129,21,'image','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_06%E6%8B%A1%E5%A4%A7%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,21,1),(5130,21,'image','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_07%E6%8B%A1%E5%A4%A7%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,21,1),(5131,21,'image','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_08%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,21,1),(5132,21,'image','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_09%E5%BA%95.jpg',NULL,NULL,NULL,21,1),(5133,21,'video','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_%E3%83%A2%E3%82%A2%E3%83%AC.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/021/021_%E3%83%A2%E3%82%A2%E3%83%AC.mp4',NULL,NULL,21,1),(5134,22,'image','https://storage.googleapis.com/sisiwaka-touen-medias/022/022_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,22,1),(5135,22,'image','https://storage.googleapis.com/sisiwaka-touen-medias/022/022_02%E5%8F%B3.jpg',NULL,NULL,NULL,22,1),(5136,22,'image','https://storage.googleapis.com/sisiwaka-touen-medias/022/022_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,22,1),(5137,22,'image','https://storage.googleapis.com/sisiwaka-touen-medias/022/022_04%E5%8F%96%E3%81%A3%E6%89%8B%E5%81%B4.jpg',NULL,NULL,NULL,22,1),(5138,22,'image','https://storage.googleapis.com/sisiwaka-touen-medias/022/022_05%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,22,1),(5139,22,'image','https://storage.googleapis.com/sisiwaka-touen-medias/022/022_06%E5%BA%95.jpg',NULL,NULL,NULL,22,1),(5140,22,'image','https://storage.googleapis.com/sisiwaka-touen-medias/022/022_07%E6%8B%A1%E5%A4%A71.jpg',NULL,NULL,NULL,22,1),(5141,22,'image','https://storage.googleapis.com/sisiwaka-touen-medias/022/022_08%E6%8B%A1%E5%A4%A72.jpg',NULL,NULL,NULL,22,1),(5142,22,'video','https://storage.googleapis.com/sisiwaka-touen-medias/022/022_%E9%9B%B2%E6%B5%B7%E3%81%AE%E3%83%94%E3%83%A9%E3%83%9F%E3%83%83%E3%83%89.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/022/022_%E9%9B%B2%E6%B5%B7%E3%81%AE%E3%83%94%E3%83%A9%E3%83%9F%E3%83%83%E3%83%89.mp4',NULL,NULL,22,1),(5143,25,'image','https://storage.googleapis.com/sisiwaka-touen-medias/025/025_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,25,1),(5144,25,'image','https://storage.googleapis.com/sisiwaka-touen-medias/025/025_02%E6%AD%A3%E9%9D%A21.jpg',NULL,NULL,NULL,25,1),(5145,25,'image','https://storage.googleapis.com/sisiwaka-touen-medias/025/025_03%E6%AD%A3%E9%9D%A22.jpg',NULL,NULL,NULL,25,1),(5146,25,'image','https://storage.googleapis.com/sisiwaka-touen-medias/025/025_04%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,25,1),(5147,25,'image','https://storage.googleapis.com/sisiwaka-touen-medias/025/025_05%E8%A6%8B%E8%BE%BC%E3%81%BF%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,25,1),(5148,25,'image','https://storage.googleapis.com/sisiwaka-touen-medias/025/025_06%E5%BA%95%E9%9D%A2.jpg',NULL,NULL,NULL,25,1),(5149,25,'image','https://storage.googleapis.com/sisiwaka-touen-medias/025/025_07%E5%BA%95%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,25,1),(5150,25,'video','https://storage.googleapis.com/sisiwaka-touen-medias/025/025_%E7%BF%A0%E7%B4%85%E7%A2%97.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/025/025_%E7%BF%A0%E7%B4%85%E7%A2%97.mp4',NULL,NULL,25,1),(5151,26,'image','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,26,1),(5152,26,'image','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_02%E5%8F%B3.jpg',NULL,NULL,NULL,26,1),(5153,26,'image','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,26,1),(5154,26,'image','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_04%E5%B7%A6.jpg',NULL,NULL,NULL,26,1),(5155,26,'image','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,26,1),(5156,26,'image','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_06%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,26,1),(5157,26,'image','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_07%E5%BA%95.jpg',NULL,NULL,NULL,26,1),(5158,26,'image','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_08%E8%B6%B3.jpg',NULL,NULL,NULL,26,1),(5159,26,'image','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_09%E7%AB%8B%E3%81%A1%E5%A7%BF.jpg',NULL,NULL,NULL,26,1),(5160,26,'video','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_%E7%9B%AE%E8%A6%9A%E3%82%81%E3%81%AE%E3%83%95%E3%82%AF%E3%83%AD%E3%82%A6.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/026/026_%E7%9B%AE%E8%A6%9A%E3%82%81%E3%81%AE%E3%83%95%E3%82%AF%E3%83%AD%E3%82%A6.mp4',NULL,NULL,26,1),(5161,27,'image','https://storage.googleapis.com/sisiwaka-touen-medias/027/027_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,27,1),(5162,27,'image','https://storage.googleapis.com/sisiwaka-touen-medias/027/027_02%E5%8F%B3.jpg',NULL,NULL,NULL,27,1),(5163,27,'image','https://storage.googleapis.com/sisiwaka-touen-medias/027/027_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,27,1),(5164,27,'image','https://storage.googleapis.com/sisiwaka-touen-medias/027/027_04%E5%B7%A6.jpg',NULL,NULL,NULL,27,1),(5165,27,'image','https://storage.googleapis.com/sisiwaka-touen-medias/027/027_05%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,27,1),(5166,27,'image','https://storage.googleapis.com/sisiwaka-touen-medias/027/027_06%E5%BA%95.jpg',NULL,NULL,NULL,27,1),(5167,27,'image','https://storage.googleapis.com/sisiwaka-touen-medias/027/027_07%E7%AB%8B%E3%81%A1%E5%A7%BF.jpg',NULL,NULL,NULL,27,1),(5168,27,'image','https://storage.googleapis.com/sisiwaka-touen-medias/027/027_08%E6%8E%A5%E5%86%99.jpg',NULL,NULL,NULL,27,1),(5169,27,'video','https://storage.googleapis.com/sisiwaka-touen-medias/027/027_%E7%91%AA%E7%91%99%E7%92%B0.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/027/027_%E7%91%AA%E7%91%99%E7%92%B0.mp4',NULL,NULL,27,1),(5170,28,'image','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,28,1),(5171,28,'image','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_02%E5%B7%A6.jpg',NULL,NULL,NULL,28,1),(5172,28,'image','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,28,1),(5173,28,'image','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_04%E5%8F%B3.jpg',NULL,NULL,NULL,28,1),(5174,28,'image','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,28,1),(5175,28,'image','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_06%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,28,1),(5176,28,'image','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_07%E5%BA%95.jpg',NULL,NULL,NULL,28,1),(5177,28,'image','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_08%E7%AB%8B%E3%81%A1%E5%A7%BF.jpg',NULL,NULL,NULL,28,1),(5178,28,'image','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_09%E8%B6%B3.jpg',NULL,NULL,NULL,28,1),(5179,28,'video','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_%E7%91%AA%E7%91%99%E6%99%B6.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/028/028_%E7%91%AA%E7%91%99%E6%99%B6.mp4',NULL,NULL,28,1),(5180,29,'image','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,29,1),(5181,29,'image','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_02%E5%B7%A6.jpg',NULL,NULL,NULL,29,1),(5182,29,'image','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,29,1),(5183,29,'image','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_04%E5%8F%B3.jpg',NULL,NULL,NULL,29,1),(5184,29,'image','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,29,1),(5185,29,'image','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_06%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,29,1),(5186,29,'image','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_07%E5%BA%95.jpg',NULL,NULL,NULL,29,1),(5187,29,'image','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_08%E8%84%9A.jpg',NULL,NULL,NULL,29,1),(5188,29,'image','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_09%E7%AB%8B%E3%81%A1%E5%A7%BF.jpg',NULL,NULL,NULL,29,1),(5189,29,'video','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_%E7%91%AA%E7%91%99%E5%A2%A8.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/029/029_%E7%91%AA%E7%91%99%E5%A2%A8.mp4',NULL,NULL,29,1),(5190,30,'image','https://storage.googleapis.com/sisiwaka-touen-medias/030/030_01%E6%AD%A3%E9%9D%A21.jpg',NULL,NULL,NULL,30,1),(5191,30,'image','https://storage.googleapis.com/sisiwaka-touen-medias/030/030_03%E6%AD%A3%E9%9D%A23.jpg',NULL,NULL,NULL,30,1),(5192,30,'image','https://storage.googleapis.com/sisiwaka-touen-medias/030/030_04%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,30,1),(5193,30,'image','https://storage.googleapis.com/sisiwaka-touen-medias/030/030_05%E6%8E%A5%E5%86%99.jpg',NULL,NULL,NULL,30,1),(5194,30,'image','https://storage.googleapis.com/sisiwaka-touen-medias/030/030_06%E6%AD%A3%E9%9D%A24.jpg',NULL,NULL,NULL,30,1),(5195,30,'image','https://storage.googleapis.com/sisiwaka-touen-medias/030/030_07%E8%A3%8F.jpg',NULL,NULL,NULL,30,1),(5196,30,'image','https://storage.googleapis.com/sisiwaka-touen-medias/030/030_08%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,30,1),(5197,30,'video','https://storage.googleapis.com/sisiwaka-touen-medias/030/030_%E9%9B%AA%E5%A2%A8%E5%B3%B0.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/030/030_%E9%9B%AA%E5%A2%A8%E5%B3%B0.mp4',NULL,NULL,30,1),(5198,33,'image','https://storage.googleapis.com/sisiwaka-touen-medias/033/033_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,33,1),(5199,33,'image','https://storage.googleapis.com/sisiwaka-touen-medias/033/033_02%E5%B7%A6.jpg',NULL,NULL,NULL,33,1),(5200,33,'image','https://storage.googleapis.com/sisiwaka-touen-medias/033/033_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,33,1),(5201,33,'image','https://storage.googleapis.com/sisiwaka-touen-medias/033/033_04%E5%8F%B3.jpg',NULL,NULL,NULL,33,1),(5202,33,'image','https://storage.googleapis.com/sisiwaka-touen-medias/033/033_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,33,1),(5203,33,'image','https://storage.googleapis.com/sisiwaka-touen-medias/033/033_06%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,33,1),(5204,33,'image','https://storage.googleapis.com/sisiwaka-touen-medias/033/033_07%E5%BA%95.jpg',NULL,NULL,NULL,33,1),(5205,33,'video','https://storage.googleapis.com/sisiwaka-touen-medias/033/033_%E9%A2%A8%E6%B4%9E%E5%AE%9F%E9%A8%93.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/033/033_%E9%A2%A8%E6%B4%9E%E5%AE%9F%E9%A8%93.mp4',NULL,NULL,33,1),(5206,34,'image','https://storage.googleapis.com/sisiwaka-touen-medias/034/034_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,34,1),(5207,34,'image','https://storage.googleapis.com/sisiwaka-touen-medias/034/034_02%E5%B7%A6.jpg',NULL,NULL,NULL,34,1),(5208,34,'image','https://storage.googleapis.com/sisiwaka-touen-medias/034/034_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,34,1),(5209,34,'image','https://storage.googleapis.com/sisiwaka-touen-medias/034/034_04%E5%8F%B3.jpg',NULL,NULL,NULL,34,1),(5210,34,'image','https://storage.googleapis.com/sisiwaka-touen-medias/034/034_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,34,1),(5211,34,'image','https://storage.googleapis.com/sisiwaka-touen-medias/034/034_06%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,34,1),(5212,34,'image','https://storage.googleapis.com/sisiwaka-touen-medias/034/034_07%E5%BA%95.jpg',NULL,NULL,NULL,34,1),(5213,34,'image','https://storage.googleapis.com/sisiwaka-touen-medias/034/034_08%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,34,1),(5214,34,'video','https://storage.googleapis.com/sisiwaka-touen-medias/034/034_%E7%89%A1%E8%A0%A3%E3%81%AE%E7%BE%A4%E7%94%9F.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/034/034_%E7%89%A1%E8%A0%A3%E3%81%AE%E7%BE%A4%E7%94%9F.mp4',NULL,NULL,34,1),(5215,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,35,1),(5216,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_02%E5%B7%A6.jpg',NULL,NULL,NULL,35,1),(5217,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,35,1),(5218,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_04%E5%8F%B3.jpg',NULL,NULL,NULL,35,1),(5219,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,35,1),(5220,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_06%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,35,1),(5221,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_07%E5%BA%95.jpg',NULL,NULL,NULL,35,1),(5222,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_08%E5%81%B4%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,35,1),(5223,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_09%E5%81%B4%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,35,1),(5224,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_10%E5%8F%96%E3%81%A3%E6%89%8B%E8%A3%8F.jpg',NULL,NULL,NULL,35,1),(5225,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_11%E5%8F%A3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,35,1),(5226,35,'image','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_12%E9%AB%98%E5%8F%B0%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,35,1),(5227,35,'video','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_%E5%9C%9F%E3%81%AE%E3%83%AA%E3%82%BA%E3%83%A0.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/035/035_%E5%9C%9F%E3%81%AE%E3%83%AA%E3%82%BA%E3%83%A0.mp4',NULL,NULL,35,1),(5228,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,36,1),(5229,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_02%E5%B7%A6.jpg',NULL,NULL,NULL,36,1),(5230,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_03%E5%B7%A6%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,36,1),(5231,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_04%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,36,1),(5232,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_05%E6%AD%A3%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,36,1),(5233,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_06%E5%8F%B3.jpg',NULL,NULL,NULL,36,1),(5234,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_07%E5%8F%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,36,1),(5235,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_08%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,36,1),(5236,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_09%E5%8F%96%E3%81%A3%E6%89%8B%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,36,1),(5237,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_10%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,36,1),(5238,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_11%E8%A6%8B%E8%BE%BC%E3%81%BF%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,36,1),(5239,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_12%E8%A3%8F.jpg',NULL,NULL,NULL,36,1),(5240,36,'image','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_13%E8%B6%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,36,1),(5241,36,'video','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_%E5%A4%A7%E5%9C%B0%E3%81%AE%E9%BC%93%E5%8B%95.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/036/036_%E5%A4%A7%E5%9C%B0%E3%81%AE%E9%BC%93%E5%8B%95.mp4',NULL,NULL,36,1),(5242,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,37,1),(5243,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_02%E5%8F%B3.jpg',NULL,NULL,NULL,37,1),(5244,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,37,1),(5245,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_04%E5%B7%A6.jpg',NULL,NULL,NULL,37,1),(5246,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,37,1),(5247,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_06%E5%B7%A6%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,37,1),(5248,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_07%E6%AD%A3%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,37,1),(5249,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_08%E5%8F%96%E3%81%A3%E6%89%8B%E3%81%AE%E8%A3%8F.jpg',NULL,NULL,NULL,37,1),(5250,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_09%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,37,1),(5251,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_10%E8%A6%8B%E8%BE%BC%E3%81%BF%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,37,1),(5252,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_11%E5%BA%95.jpg',NULL,NULL,NULL,37,1),(5253,37,'image','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_12%E8%B6%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,37,1),(5254,37,'video','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_%E3%83%9B%E3%83%AF%E3%82%A4%E3%83%88%E3%82%BF%E3%82%A4%E3%82%AC%E3%83%BC.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/037/037_%E3%83%9B%E3%83%AF%E3%82%A4%E3%83%88%E3%82%BF%E3%82%A4%E3%82%AC%E3%83%BC.mp4',NULL,NULL,37,1),(5255,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,38,1),(5256,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_02%E5%81%B4%E9%9D%A21.jpg',NULL,NULL,NULL,38,1),(5257,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_03%E5%81%B4%E9%9D%A22.jpg',NULL,NULL,NULL,38,1),(5258,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_04%E5%81%B4%E9%9D%A23.jpg',NULL,NULL,NULL,38,1),(5259,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_05%E5%81%B4%E9%9D%A24.jpg',NULL,NULL,NULL,38,1),(5260,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_06%E5%AF%84%E3%82%8A1.jpg',NULL,NULL,NULL,38,1),(5261,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_07%E5%AF%84%E3%82%8A2.jpg',NULL,NULL,NULL,38,1),(5262,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_08%E5%AF%84%E3%82%8A3.jpg',NULL,NULL,NULL,38,1),(5263,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_09%E5%AF%84%E3%82%8A4.jpg',NULL,NULL,NULL,38,1),(5264,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_10%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,38,1),(5265,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_11%E8%A6%8B%E8%BE%BC%E3%81%BF%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,38,1),(5266,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_12%E8%A3%8F.jpg',NULL,NULL,NULL,38,1),(5267,38,'image','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_13%E8%B6%B3.jpg',NULL,NULL,NULL,38,1),(5268,38,'video','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_%E9%B6%89%E5%B8%AF.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/038/038_%E9%B6%89%E5%B8%AF.mp4',NULL,NULL,38,1),(5269,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,39,1),(5270,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_02%E5%B7%A6.jpg',NULL,NULL,NULL,39,1),(5271,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,39,1),(5272,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_04%E5%8F%B3.jpg',NULL,NULL,NULL,39,1),(5273,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,39,1),(5274,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_06%E5%B7%A6%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,39,1),(5275,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_07%E6%AD%A3%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,39,1),(5276,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_08%E5%8F%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,39,1),(5277,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_09%E5%8F%96%E3%81%A3%E6%89%8B%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,39,1),(5278,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_10%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,39,1),(5279,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_11%E8%A3%8F.jpg',NULL,NULL,NULL,39,1),(5280,39,'image','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_12%E8%84%9A.jpg',NULL,NULL,NULL,39,1),(5281,39,'video','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_%E5%87%AA%E3%81%AE%E6%99%82%E9%96%93.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/039/039_%E5%87%AA%E3%81%AE%E6%99%82%E9%96%93.mp4',NULL,NULL,39,1),(5282,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,40,1),(5283,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_02_%E5%8F%B3.jpg',NULL,NULL,NULL,40,1),(5284,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,40,1),(5285,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_04%E5%B7%A6.jpg',NULL,NULL,NULL,40,1),(5286,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,40,1),(5287,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_06%E6%8B%A1%E5%A4%A701.jpg',NULL,NULL,NULL,40,1),(5288,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_07%E6%8B%A1%E5%A4%A702.jpg',NULL,NULL,NULL,40,1),(5289,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_08%E6%8B%A1%E5%A4%A703.jpg',NULL,NULL,NULL,40,1),(5290,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_09%E6%8B%A1%E5%A4%A704.jpg',NULL,NULL,NULL,40,1),(5291,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_10%E5%8F%96%E3%81%A3%E6%89%8B%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,40,1),(5292,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_11%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,40,1),(5293,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_12%E8%A3%8F.jpg',NULL,NULL,NULL,40,1),(5294,40,'image','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_13%E8%B6%B3.jpg',NULL,NULL,NULL,40,1),(5295,40,'video','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_%E5%A2%A8%E6%B5%81%E3%81%97.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/040/040_%E5%A2%A8%E6%B5%81%E3%81%97.mp4',NULL,NULL,40,1),(5296,42,'image','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,42,1),(5297,42,'image','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_02%E5%8F%B3.jpg',NULL,NULL,NULL,42,1),(5298,42,'image','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,42,1),(5299,42,'image','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_04%E5%B7%A6.jpg',NULL,NULL,NULL,42,1),(5300,42,'image','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_05%E6%8B%A1%E5%A4%A71.jpg',NULL,NULL,NULL,42,1),(5301,42,'image','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_06%E6%8B%A1%E5%A4%A72.jpg',NULL,NULL,NULL,42,1),(5302,42,'image','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_07%E6%8B%A1%E5%A4%A73.jpg',NULL,NULL,NULL,42,1),(5303,42,'image','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_08%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,42,1),(5304,42,'image','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_09%E8%A3%8F.jpg',NULL,NULL,NULL,42,1),(5305,42,'image','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_10%E8%B6%B3.jpg',NULL,NULL,NULL,42,1),(5306,42,'video','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_%E5%86%AC%E3%81%AE%E3%83%A2%E3%83%A2%E3%83%B3%E3%82%AC.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/042/042_%E5%86%AC%E3%81%AE%E3%83%A2%E3%83%A2%E3%83%B3%E3%82%AC.mp4',NULL,NULL,42,1),(5307,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,43,1),(5308,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_02%E6%AD%A3%E9%9D%A201.jpg',NULL,NULL,NULL,43,1),(5309,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_03%E6%AD%A3%E9%9D%A202.jpg',NULL,NULL,NULL,43,1),(5310,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_04%E6%AD%A3%E9%9D%A203.jpg',NULL,NULL,NULL,43,1),(5311,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_05%E6%AD%A3%E9%9D%A204.jpg',NULL,NULL,NULL,43,1),(5312,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_06%E6%8B%A1%E5%A4%A701.jpg',NULL,NULL,NULL,43,1),(5313,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_07%E6%8B%A1%E5%A4%A702.jpg',NULL,NULL,NULL,43,1),(5314,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_08%E6%8B%A1%E5%A4%A703.jpg',NULL,NULL,NULL,43,1),(5315,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_09%E6%8B%A1%E5%A4%A704.jpg',NULL,NULL,NULL,43,1),(5316,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_10%E6%8B%A1%E5%A4%A705.jpg',NULL,NULL,NULL,43,1),(5317,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_11%E8%A6%8B%E8%BE%BC%E3%81%BF01.jpg',NULL,NULL,NULL,43,1),(5318,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_12%E8%A6%8B%E8%BE%BC%E3%81%BF02.jpg',NULL,NULL,NULL,43,1),(5319,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_13%E8%A3%8F01.jpg',NULL,NULL,NULL,43,1),(5320,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_14%E8%A3%8F02.jpg',NULL,NULL,NULL,43,1),(5321,43,'image','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_15%E8%A3%8F03.jpg',NULL,NULL,NULL,43,1),(5322,43,'video','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_%E5%8D%98%E8%AA%BF%E4%BD%9C%E6%A5%AD1.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_%E5%8D%98%E8%AA%BF%E4%BD%9C%E6%A5%AD1.mp4',NULL,NULL,43,1),(5323,43,'video','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_%E5%8D%98%E8%AA%BF%E4%BD%9C%E6%A5%AD2.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/043/043_%E5%8D%98%E8%AA%BF%E4%BD%9C%E6%A5%AD2.mp4',NULL,NULL,43,1),(5324,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,44,1),(5325,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_02%E6%AD%A3%E9%9D%A21.jpg',NULL,NULL,NULL,44,1),(5326,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_03%E6%AD%A3%E9%9D%A22.jpg',NULL,NULL,NULL,44,1),(5327,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_04%E6%AD%A3%E9%9D%A23.jpg',NULL,NULL,NULL,44,1),(5328,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_05%E6%8B%A1%E5%A4%A71.jpg',NULL,NULL,NULL,44,1),(5329,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_06%E6%8B%A1%E5%A4%A72.jpg',NULL,NULL,NULL,44,1),(5330,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_07%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,44,1),(5331,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_08%E8%A6%8B%E8%BE%BC%E3%81%BF2.jpg',NULL,NULL,NULL,44,1),(5332,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_09%E8%A3%8F%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,44,1),(5333,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_10%E8%A3%8F%E6%96%9C%E3%82%81.jpg',NULL,NULL,NULL,44,1),(5334,44,'image','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_11%E8%B6%B3.jpg',NULL,NULL,NULL,44,1),(5335,44,'video','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_%E3%82%A4%E3%82%BD%E3%82%AE%E3%83%B3%E3%83%81%E3%83%A3%E3%82%AF.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/044/044_%E3%82%A4%E3%82%BD%E3%82%AE%E3%83%B3%E3%83%81%E3%83%A3%E3%82%AF.mp4',NULL,NULL,44,1),(5336,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,45,1),(5337,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_02%E5%8F%B3.jpg',NULL,NULL,NULL,45,1),(5338,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,45,1),(5339,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_04%E5%B7%A6.jpg',NULL,NULL,NULL,45,1),(5340,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,45,1),(5341,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_06%E5%8F%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,45,1),(5342,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_07%E6%AD%A3%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,45,1),(5343,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_08%E5%B7%A6%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,45,1),(5344,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_09%E5%8F%96%E3%81%A3%E6%89%8B%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,45,1),(5345,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_10%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,45,1),(5346,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_11%E8%A6%8B%E8%BE%BC%E3%81%BF%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,45,1),(5347,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_12%E5%BA%95.jpg',NULL,NULL,NULL,45,1),(5348,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_13%E3%81%A9%E3%81%93%E3%81%8B%E3%81%AE%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,45,1),(5349,45,'image','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_14%E5%8F%96%E3%81%A3%E6%89%8B%E8%A3%8F.jpg',NULL,NULL,NULL,45,1),(5350,45,'video','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_%E7%82%8E%E8%8A%AF%E9%9B%AA%E3%81%86%E3%81%9A%E3%82%89.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/045/045_%E7%82%8E%E8%8A%AF%E9%9B%AA%E3%81%86%E3%81%9A%E3%82%89.mp4',NULL,NULL,45,1),(5351,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,50,1),(5352,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_02%E5%8F%B3.jpg',NULL,NULL,NULL,50,1),(5353,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,50,1),(5354,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_04%E5%B7%A6.jpg',NULL,NULL,NULL,50,1),(5355,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,50,1),(5356,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_06%E5%8F%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,50,1),(5357,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_07%E6%AD%A3%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,50,1),(5358,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_08%E5%8F%96%E3%81%A3%E6%89%8B%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,50,1),(5359,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_09%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,50,1),(5360,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_10%E8%A6%8B%E8%BE%BC%E3%81%BF%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,50,1),(5361,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_11%E5%8F%96%E3%81%A3%E6%89%8B%E8%A3%8F.jpg',NULL,NULL,NULL,50,1),(5362,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_12%E5%BA%95.jpg',NULL,NULL,NULL,50,1),(5363,50,'image','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_13%E8%B6%B3.jpg',NULL,NULL,NULL,50,1),(5364,50,'video','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_%E3%81%86%E3%81%A3%E3%81%8B%E3%82%8A%E3%83%92%E3%83%A7%E3%82%A6%E3%83%A2%E3%83%B3%E3%83%80%E3%82%B3.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/050/050_%E3%81%86%E3%81%A3%E3%81%8B%E3%82%8A%E3%83%92%E3%83%A7%E3%82%A6%E3%83%A2%E3%83%B3%E3%83%80%E3%82%B3.mp4',NULL,NULL,50,1),(5365,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,51,1),(5366,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_02%E5%8F%B3.jpg',NULL,NULL,NULL,51,1),(5367,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,51,1),(5368,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_04%E5%B7%A6.jpg',NULL,NULL,NULL,51,1),(5369,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,51,1),(5370,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_06%E5%8F%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,51,1),(5371,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_07%E6%AD%A3%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,51,1),(5372,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_08%E5%B7%A6%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,51,1),(5373,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_09%E5%8F%96%E3%81%A3%E6%89%8B%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,51,1),(5374,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_10%E5%8F%96%E3%81%A3%E6%89%8B%E8%A3%8F.jpg',NULL,NULL,NULL,51,1),(5375,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_11%E8%A3%8F.jpg',NULL,NULL,NULL,51,1),(5376,51,'image','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_12%E8%B6%B3.jpg',NULL,NULL,NULL,51,1),(5377,51,'video','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_%E5%B3%B6%E3%81%AE%E7%B2%BE%E9%9C%8A.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/051/051_%E5%B3%B6%E3%81%AE%E7%B2%BE%E9%9C%8A.mp4',NULL,NULL,51,1),(5378,52,'image','https://storage.googleapis.com/sisiwaka-touen-medias/052/052_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,52,1),(5379,52,'video','https://storage.googleapis.com/sisiwaka-touen-medias/052/052_%E9%9B%AA%E4%BB%94%E8%99%8E.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/052/052_%E9%9B%AA%E4%BB%94%E8%99%8E.mp4',NULL,NULL,52,1),(5380,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,53,1),(5381,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_02%E5%8F%B3.jpg',NULL,NULL,NULL,53,1),(5382,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,53,1),(5383,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_04%E5%B7%A6.jpg',NULL,NULL,NULL,53,1),(5384,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,53,1),(5385,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_06%E5%8F%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,53,1),(5386,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_07%E6%AD%A3%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,53,1),(5387,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_08%E5%B7%A6%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,53,1),(5388,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_09%E5%8F%96%E3%81%A3%E6%89%8B%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,53,1),(5389,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_10%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,53,1),(5390,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_11%E5%8F%A3%E7%B8%81.jpg',NULL,NULL,NULL,53,1),(5391,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_12%E8%A3%8F.jpg',NULL,NULL,NULL,53,1),(5392,53,'image','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_13%E8%B6%B3.jpg',NULL,NULL,NULL,53,1),(5393,53,'video','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_%E3%81%97%E3%81%A3%E3%81%8B%E3%82%8A%E3%83%92%E3%83%A7%E3%82%A6%E3%83%A2%E3%83%B3%E3%83%80%E3%82%B3.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/053/053_%E3%81%97%E3%81%A3%E3%81%8B%E3%82%8A%E3%83%92%E3%83%A7%E3%82%A6%E3%83%A2%E3%83%B3%E3%83%80%E3%82%B3.mp4',NULL,NULL,53,1),(5394,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,54,1),(5395,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_02%E5%8F%B3.jpg',NULL,NULL,NULL,54,1),(5396,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,54,1),(5397,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_04%E5%B7%A6.jpg',NULL,NULL,NULL,54,1),(5398,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,54,1),(5399,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_06%E5%8F%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,54,1),(5400,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_07%E6%AD%A3%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,54,1),(5401,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_08%E5%B7%A6%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,54,1),(5402,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_09%E5%8F%96%E3%81%A3%E6%89%8B%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,54,1),(5403,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_10%E5%8F%96%E3%81%A3%E6%89%8B%E8%A3%8F.jpg',NULL,NULL,NULL,54,1),(5404,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_11%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,54,1),(5405,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_12%E7%B8%81.jpg',NULL,NULL,NULL,54,1),(5406,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_13%E8%A3%8F.jpg',NULL,NULL,NULL,54,1),(5407,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_14%E8%B6%B3.jpg',NULL,NULL,NULL,54,1),(5408,54,'image','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_15%E8%B6%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,54,1),(5409,54,'video','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_%E5%86%AC%E3%81%AE%E6%B1%A0%E3%80%81%E6%B0%B7%E3%81%AE%E6%B3%A1.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/054/054_%E5%86%AC%E3%81%AE%E6%B1%A0%E3%80%81%E6%B0%B7%E3%81%AE%E6%B3%A1.mp4',NULL,NULL,54,1),(5410,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_01%E6%89%8B%E6%8C%81%E3%81%A1.jpg',NULL,NULL,NULL,55,1),(5411,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_02%E5%8F%B3.jpg',NULL,NULL,NULL,55,1),(5412,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_03%E6%AD%A3%E9%9D%A2.jpg',NULL,NULL,NULL,55,1),(5413,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_04%E5%B7%A6.jpg',NULL,NULL,NULL,55,1),(5414,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_05%E5%8F%96%E3%81%A3%E6%89%8B.jpg',NULL,NULL,NULL,55,1),(5415,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_06%E5%8F%B3%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,55,1),(5416,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_07%E6%AD%A3%E9%9D%A2%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,55,1),(5417,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_08%E5%B7%A6%E6%8B%A1%E5%A4%A7.jpg',NULL,NULL,NULL,55,1),(5418,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_10%E8%A6%8B%E8%BE%BC%E3%81%BF.jpg',NULL,NULL,NULL,55,1),(5419,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_11%E8%A3%8F.jpg',NULL,NULL,NULL,55,1),(5420,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_12%E8%B6%B3.jpg',NULL,NULL,NULL,55,1),(5421,55,'image','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_9%E5%8F%96%E3%81%A3%E6%89%8B%E5%86%85%E5%81%B4.jpg',NULL,NULL,NULL,55,1),(5422,55,'video','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_%E9%9B%AA%E5%89%B2%E3%82%8A%E3%81%AE%E5%A5%94%E6%B5%81.jpg','https://storage.googleapis.com/sisiwaka-touen-medias/055/055_%E9%9B%AA%E5%89%B2%E3%82%8A%E3%81%AE%E5%A5%94%E6%B5%81.mp4',NULL,NULL,55,1);
/*!40000 ALTER TABLE `artwork_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artwork_techniques`
--

DROP TABLE IF EXISTS `artwork_techniques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artwork_techniques` (
  `artwork_id` int(11) NOT NULL,
  `techniques_slug` varchar(50) NOT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`artwork_id`,`techniques_slug`),
  KEY `fk_artwork_techniques_technique` (`techniques_slug`),
  CONSTRAINT `fk_artwork_techniques_artwork` FOREIGN KEY (`artwork_id`) REFERENCES `artworks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_artwork_techniques_technique` FOREIGN KEY (`techniques_slug`) REFERENCES `techniques` (`slug`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artwork_techniques`
--

LOCK TABLES `artwork_techniques` WRITE;
/*!40000 ALTER TABLE `artwork_techniques` DISABLE KEYS */;
INSERT INTO `artwork_techniques` VALUES (1,'shinogi',1),(7,'shinogi',1),(8,'shinogi',1),(30,'nerikomi',1),(30,'shinogi',1),(33,'nerikomi',1),(33,'shinogi',1),(36,'nerikomi',1),(36,'shinogi',1),(37,'nerikomi',1),(37,'shinogi',1),(38,'nerikomi',1),(38,'shinogi',1),(38,'tebinari',1),(39,'nerikomi',1),(39,'shinogi',1),(40,'nerikomi',1),(40,'shinogi',1),(42,'nerikomi',1),(42,'shinogi',1),(42,'tebinari',1),(43,'nerikomi',1),(43,'shinogi',1),(44,'nerikomi',1),(44,'shinogi',1),(45,'nerikomi',1),(45,'shinogi',1),(45,'tebinari',1),(50,'nerikomi',1),(50,'shinogi',1),(51,'nerikomi',1),(51,'shinogi',1),(52,'nerikomi',1),(52,'shinogi',1),(53,'nerikomi',1),(53,'shinogi',1),(54,'nerikomi',1),(54,'shinogi',1),(55,'nerikomi',1),(55,'shinogi',1);
/*!40000 ALTER TABLE `artwork_techniques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artworks`
--

DROP TABLE IF EXISTS `artworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artworks` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description_title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(50) NOT NULL,
  `spec` text DEFAULT NULL,
  `width` decimal(5,1) DEFAULT NULL,
  `max_width` decimal(5,1) DEFAULT NULL,
  `height` decimal(5,1) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `clay` text DEFAULT NULL,
  `glaze` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `in_stock` tinyint(1) NOT NULL DEFAULT 1,
  `coloring` varchar(50) DEFAULT NULL,
  `shop_url` varchar(500) DEFAULT NULL,
  `instagram_url` varchar(500) DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `update_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_artworks_color` (`coloring`),
  KEY `fk_artworks_category` (`category`),
  CONSTRAINT `fk_artworks_category` FOREIGN KEY (`category`) REFERENCES `categories` (`slug`) ON UPDATE CASCADE,
  CONSTRAINT `fk_artworks_color` FOREIGN KEY (`coloring`) REFERENCES `colorings` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artworks`
--

LOCK TABLES `artworks` WRITE;
/*!40000 ALTER TABLE `artworks` DISABLE KEYS */;
INSERT INTO `artworks` VALUES (1,'黒亀','玉サボテン様コーヒーカップ「黒亀」','玉サボテンの亀甲模様からインスピレーションを得たコーヒーカップです。\r\n6角形の模様がゆるやかに膨らんだ立体感のある仕上がりで、触れるたびにその繊細な質感を楽しむことができます。\r\nさらに、高台部分を6本の足のようにデザインし、遊び心をプラスしました。\r\n上に張り出した取っ手は、持ちやすさを考慮しつつ、デザインのアクセントにもなっています。\r\n艶やかな黒い地に、無数の油滴模様が広がり、見ていて飽きることのない魅力を放っています。\r\nこの独特なフォルムから「黒亀」と名付けました。','coffee_cup','直径：約10cm (取っ手を除く)、12.5cm (取っ手込み)\r\n高さ：約8.5cm\r\n容量：約160cc (8割注水時)\r\n重さ：190g',NULL,NULL,NULL,NULL,NULL,'赤土','油滴天目','',0,'monotone',NULL,'',NULL,'2025-10-18 16:54:03',1),(3,'十二刻','柱サボテン様コーヒーカップ「十二刻」','柱サボテンをモチーフにしたコーヒーカップです。\r\nカップの側面全体に、柱サボテンの陵を思わせる立体模様を彫り込みました。\r\n外側は黒マット釉を施し、しっとりとした手触りと深みのある表情に。\r\n内側には白萩釉を掛けており、口縁では白萩と黒マットの釉薬が溶け合い、滴り落ちるような独特の模様が生まれました。\r\nこのカップの最大の特長は、円周に沿って並ぶ 12本の足。\r\nその姿がまるで時計の文字盤のように見えることから、「十二刻」と名付けました。\r\nあなたのコーヒーブレークが、ゆったりとした穏やかなひとときになりますように。\r\n「十二刻」とともに、心落ち着く時間をお楽しみください。','coffee_cup','直径：約10cm (取っ手を除く)、12.5cm (取っ手込み)\r\n高さ：約6.5cm\r\n容量：約200cc (8割注水時)\r\n重さ：200g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2023-10-20','2025-10-18 16:27:00',1),(7,'玄武皿','玉サボテン様12足黒マットパスタ皿「玄武皿」','全体に6角形の模様が施され、それぞれの6角形が膨らむように彫刻されています。これはまるでサボテンの葉が太陽の光を浴びて膨らむ様子を再現したもの。高台の形も工夫され、12本の足で立つような形に仕上げられています。これはまるでサボテンが土地から根を張っているかのような迫力があります。\r\n\r\nそして、黒マットという釉薬で仕上げられたこのパスタ皿は、艶のない黒い器となっています。1つ1つの模様や足を削りだすのにはとても時間がかかり大変でしたが、その努力が実り、美しい仕上がりとなりました。\r\n\r\nこのパスタ皿を使えば、パスタを盛り付けるだけで、まるでサボテンの上に乗っているような気分になれます。サボテンの魔法が詰まったこのパスタ皿で、美味しいパスタを楽しんでください。','coffee_cup','',NULL,NULL,NULL,NULL,NULL,'赤土','黒マット','',0,'monotone',NULL,'','2023-10-06','2025-10-18 16:54:55',1),(8,'アルマジロ','サボテン菊水様コーヒーカップ「アルマジロ」','　「菊水」というサボテンをモチーフに、しのぎの技法をで作ったコーヒーカップです。\r\n　カップの側面全体に、上向きのうろこ状の模様をレリーフ状に彫り込みました。彫り込んだ模様は滑らかに仕上げているため、指先でなぞると心地よい手触りです。\r\n　釉薬には「蕎麦」を使用しており、薄くかかった部分は深い茶色に、厚くかかった部分は明るい茶色の斑点模様が浮かび上がります。これにより、レリーフの形に沿って複雑な色の濃淡が生まれ、奥行きのある表情を楽しめます。\r\n　取っ手は幅広に作り、指をしっかり通せるため、安定感のある持ちやすさも魅力のひとつ。\r\n　サボテンをイメージして作りましたが、焼き上がるとその姿はまるでアルマジロの鎧のよう。そこで、このカップには「アルマジロ」という銘を付けました。','coffee_cup','直径：約9.5cm (取っ手を除く)、11.5cm (取っ手込み)\r\n高さ：約7cm\r\n容量：約130cc (8割注水時)\r\n重さ：195g',NULL,NULL,NULL,NULL,NULL,'赤土','蕎麦','',0,'monotone',NULL,'','2023-10-06','2025-10-18 16:38:25',1),(20,'赫耀の秘光','玉サボテン様しのぎマグカップ「赫耀の秘光」','玉サボテンを模した六角形の彫り模様を施したマグカップです。\r\n外側には光沢を抑えた黒マット釉を使用し、落ち着いた佇まいを演出。\r\n対照的に、内側の赤結晶釉は周囲の光を反射し、まるで燃え立つ炎のような輝きを放ちます。\r\nカップを手に、外側から中を覗くと、暗闇の奥から鋭い赤の光が目に飛び込んできます。\r\n静寂の黒に秘められた鮮烈な輝きの美しさを映し、「赫耀の秘光」と名付けました。\r\n光と影が織りなす表情を、ぜひ手に取ってご堪能ください。','coffee_cup','直径：約10.5cm (取っ手を除く)、約13.0cm (取っ手を含む)\r\n高さ：約8.5cm\r\n容量：約260cc (8割注水時)\r\n重さ：234g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2024-09-22','2025-10-18 16:27:00',1),(21,'モアレ','玉サボテン様練り込みコーヒーカップ「モアレ」','これも玉サボテンをモチーフにしたコーヒーカップです。\r\n普段は白土や赤土など1種類の土で作っていますが、今回は「練り込み」の技法でカップの形を作ってから、サボテンの形に削ってみました。\r\n赤土と黒土の2つの粘土を使っています。練り込みなので、カップの表面に2つの粘土の縞模様ができますが、これを削ると、削った深さに応じて、さらに別の模様が出てきます。これがとても面白い模様になりました。\r\nモアレ模様に見えるので、作品名を「モアレ」としました。\r\n全体に「12番石灰」という透明釉をかけています。','coffee_cup','直径：約9.0cm (取っ手を除く)、約11.0cm (取っ手を含む)\r\n高さ：約6.5cm\r\n容量：約150cc (8割注水時)\r\n重さ：189g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2024-09-29','2025-10-18 16:27:00',1),(22,'雲海のピラミッド','サボテン金剛丸様練り込みコーヒーカップ「雲海のピラミッド」','玉サボテンをモチーフにしたコーヒーカップです。\r\nでも、出来上がった印象は、小さなパイナップルです(笑)。\r\n赤土と黒土で「練り込み」の技法でカップの形を作ってから、小さなピラミッド状の模様をカップ側面全体につけました。削ることにより、等高線、あるいは、地層のような縞模様が表面に浮かびました。\r\n全体に「12番石灰」という透明釉をかけています。\r\n透明釉ですが、厚くかかると白い膜のようになります。このカップでは、削ったピラミッドとピラミッドの間の溝に厚くかかりました。その見た目の印象から、銘を「雲海のピラミッド」としました。','coffee_cup',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2024-10-06','2025-10-18 16:27:00',1),(25,'翠紅碗','玉サボテン様乳濁赤結晶どんぶり「翠紅碗」','サボテンをモチーフにしたどんぶりです。\r\n外側には、サボテンを模した6角形の模様を彫り込んでいます。\r\nその模様に合わせ、高台を6本の足にしました。6本足で立つ様が少しだけかわいいです。\r\n外側は乳濁という、どちらかというと地味に見える緑色の釉薬を、内側は赤結晶という派手な紅色の釉薬をかけています。\r\n風雪に耐えるサボテンの、外皮は地味で目立たないのに、内部はみずみずしい感じを表現し、銘を「翠紅碗」としました。','coffee_cup','直径：約15.0cm\r\n高さ：約8.0cm\r\n容量：約400cc (8割注水時)\r\n重さ：350g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'2025-10-18 16:27:00',1),(26,'目覚めのフクロウ','玉サボテン様練り込みコーヒーカップ「目覚めのフクロウ」','赤土と黒土を練り込み、玉サボテンからインスピレーションを得た六角形の模様を彫り込んだコーヒーカップです。\r\n高台は6本のスリムな足で支えられ、個性的なフォルムが際立ちます。\r\n土の自然な色彩と練り込みの美しい模様を引き立てるため、釉薬には透明釉を使用しました。\r\n銘は 「目覚めのフクロウ」。\r\nしのぎによって変化した練り込みの模様が、まるで寝ぼけまなこのフクロウのよう。\r\n手に取るたびに、眠たげな表情のフクロウと目が合い、やさしく穏やかなコーヒーの時間を演出してくれます。','coffee_cup','直径：約8.5cm (取っ手を除く)、約10.5cm (取っ手を含む)\r\n高さ：約8.3cm\r\n容量：約180cc (8割注水時)\r\n重さ：192g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2024-10-20','2025-10-18 16:27:00',1),(27,'瑪瑙環','サボテン様練り込みコーヒーカップ「瑪瑙環」','白土と黒土を練り込み成形し、全体に細かいピラミッド型の模様を彫り込んだコーヒーカップです。練り込みによって生まれる独特の縞模様を削ることでさらに表情豊かな模様の妙が生まれます。\r\nデザインのモチーフは、サボテンの金剛丸。側面全体に深く刻み込んだピラミッド状のしのぎ模様が、形にメリハリを与え、手に取ったときの感触も楽しめます。\r\n仕上げには透明釉を施し、練り込み模様の美しさを引き立てました。カップ全体に広がる同心円状の模様が、瑪瑙の層を思わせることから「瑪瑙環」と名付けました。','coffee_cup','直径：約8.5cm (取っ手を除く)、11cm (取っ手込み)\r\n高さ：約6.8cm\r\n容量：約160cc (8割注水時)\r\n重さ：199g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2024-10-27','2025-10-18 16:27:00',1),(28,'瑪瑙晶','玉サボテン様練り込みコーヒーカップ「瑪瑙晶」','No.027「瑪瑙環」と同じく、白土と黒土を練り込んで成形したコーヒーカップです。\r\nただし本作では、カップの外側に玉サボテンをモチーフとした六角形のふくらみを彫り込みました。\r\n削ったことで、思いがけない模様が現れました。\r\nまるで「日」という字を重ねたような模様です。\r\n漢字にすると「晶」でしょうか？\r\nそこで、このカップに「瑪瑙晶（めのうしょう）」という銘を付けました。','coffee_cup','直径：約8.0cm (取っ手を除く)、約11.0cm (取っ手を含む)\r\n高さ：約7.5cm\r\n容量：約140cc (8割注水時)\r\n重さ：205g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2024-11-03','2025-10-18 16:27:00',1),(29,'瑪瑙墨','玉サボテン様練り込みコーヒーカップ「瑪瑙墨」','練り込みとしのぎの技法を組み合わせたコーヒーカップです。\r\n白土と黒土を重ねて成形した素地に、六角形の模様を一つひとつ彫り込んでいます。\r\nそれぞれの六角形はゆるやかに膨らんでおり、削りの深さによって模様に揺らぎが生まれています。\r\nカップの内側には「黒天目」という艶やかな黒の釉薬を掛けました。\r\nこの黒が外側の模様を際立たせ、カップ全体の印象を引き締めています。\r\n練り込みによって現れた縞模様が瑪瑙石を思わせ、内側の黒が墨のように見えることから「瑪瑙墨」という銘にしました。','coffee_cup','直径：約7.5cm (取っ手を除く)、約10.5cm (取っ手を含む)\r\n高さ：約8.0cm\r\n容量：約140cc (8割注水時)\r\n重さ：208g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2024-11-10','2025-10-18 16:27:00',1),(30,'雪墨嶺','サボテン金剛丸様練り込み中鉢「雪墨嶺」','　玉サボテンをモチーフに、側面いっぱいにピラミッド型の模様を彫り込みました。\r\n　白と黒の粘土の練り込みにより生み出された等高線のような縞模様が特長の中鉢です。\r\n　ひと山ひと山、手作業で彫り込んだ模様が山並みのように連なります。\r\n　その姿から、「雪墨嶺（せつぼくれい）」という銘を付けました。','medium_bowl','直径：約13.0cm\r\n高さ：約7.4cm\r\n容量：約400cc (8割注水時)\r\n重さ：378g',NULL,NULL,NULL,NULL,NULL,'白土、黒土','透明釉','',1,'monotone','','','2024-11-17','2025-10-18 16:45:30',1),(33,'風洞実験','ハウォルチア様練り込みコーヒーカップ「風洞実験」','　白土と黒土を練り込んで生まれた縞模様の素地に、ハオルチアの葉を思わせる上向きの三角形模様を彫り込んだコーヒーカップです。\r\n　彫りの部分では縞模様が不連続になり、模様の中にゆらぎや乱れが生まれています。とくにカップ上部では、その線がまるで風洞実験の気流が乱れる瞬間のように見えます。\r\n　この様から、銘を「風洞実験」としました。\r\n　静と動が共存するような、不思議な景色となっています。','coffee_cup','直径：約9.0cm (取っ手を除く)、約11.5cm (取っ手を含む)\r\n高さ：約8.0cm\r\n容量：約170cc (8割注水時)\r\n重さ：245g',9.0,11.5,8.0,245,170,'白土、黒土','外側：透明釉\r\n内側：黒天目','',1,'monotone','','','2024-12-21','2025-10-17 06:05:25',1),(34,'牡蠣の群生','ねじり金剛丸様練り込みコーヒーカップ「牡蠣の群生」','練り込みとしのぎの技法を組み合わせたデミタスカップです。\r\n白土と黒土を使った練り込みの素地に、ピラミッド型の模様を削りだしたのですが、正方形ではなく、長方形を傾けた形で削ってみました。\r\nピラミッドの高さにより等高線のように白と黒の縞模様があらわれ、おもしろい見た目になりましたが、1つ1つの模様が牡蠣が並んでいるように見えたので、銘は「牡蠣の群生」としました。\r\nサイズはやや小さめです。','coffee_cup','直径：約7.0cm (取っ手を除く)、約10.0cm (取っ手を含む)\r\n高さ：約7.4cm\r\n容量：約100cc (8割注水時)\r\n重さ：176g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2024-12-08','2025-10-18 16:27:00',1),(35,'土のリズム','柱サボテン様練り込みコーヒーカップ「土のリズム」','柱サボテンの縦に並ぶ陵（りょう）からインスピレーションを得たコーヒーカップです。\r\n白土と赤土を使った「練り込み」の技法で独特の模様を生み出し、さらに「しのぎ」の技法で柱サボテンのような立体感を表現しました。\r\n内側には「うのふ」という白い釉薬、外側は透明釉を掛けています。カップの口縁には2つの釉薬が混ざり合い、波紋のような模様が生まれています。\r\n側面の模様が地層のように見え、それが等間隔に柱状に並ぶので「土のリズム」と名付けました。\r\n大地を掌に収めたようなこのカップで、心落ち着くコーヒータイムをお過ごしください。','coffee_cup','直径：約9.5cm (取っ手を除く)、12cm (取っ手込み)\r\n高さ：約5.3cm\r\n容量：約140cc (8割注水時)\r\n重さ：205g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2024-12-15','2025-10-18 16:27:00',1),(36,'大地の鼓動','玉サボテン様練り込みコーヒーカップ「大地の鼓動」','　白土をベースに、赤土と黒土を練り込んだ独特の模様が特徴のカップです。玉サボテンからインスピレーションを得て、側面にはゆるやかに膨らんだ六角形の模様を彫り込み、高台は6本の足で支えるデザインに仕上げました。触れるたびに手に馴染む、心地よい質感を楽しめます。\r\n　内側には、艶やかな「黒天目」釉を施し、外側は透明釉で仕上げました。カップの口縁部分では、「黒天目」と透明釉が交じり合い、豹のような模様が生まれています。\r\n　練り込みによる地層のような同心円状の模様がぐるりとカップを一周する姿を、大地が静かに鼓動する様に見立て、「大地の鼓動」と名付けました。\r\n　大地の息吹を掌に収めたようなこのカップで、心落ち着くコーヒータイムをお楽しみください。','coffee_cup','直径：約9.0cm (取っ手を除く)、11cm (取っ手込み)\r\n高さ：約6.2cm\r\n容量：約150cc (8割注水時)\r\n重さ：194\r\n',9.0,11.0,6.2,194,150,'白土、赤土、黒土','外側：透明釉\r\n内側：黒天目','',1,'monotone','https://minne.com/items/42299435','https://www.instagram.com/p/DF5br47Tkg3/','2024-12-22','2025-10-16 03:54:26',1),(37,'ホワイトタイガー','玉サボテン様練り込みコーヒーカップ「ホワイトタイガー」','　白土と黒土を練り込み、玉サボテンからインスピレーションを得た模様を彫り込んだコーヒーカップです。\r\n　側面にはゆるやかに膨らんだ六角形の模様を施し、6本の足で支える高台が個性的なデザインを引き立てます。六角形の膨らみは、手にしっくりと馴染み、心地よい質感を楽しめます。\r\n　内側には「うのふ」という真っ白い釉薬を使用し、外側には「亀甲貫入」という、貫入（亀裂模様）が現れる釉薬を掛けています。この亀裂は、一点一点異なる表情を見せ、世界にひとつだけの個性的なカップに仕上がっています。\r\n透明釉の場合は白と黒のコントラストが強く出ますが、この「亀甲貫入」は、素地の色を柔らかく包み込み、白いフィルタを通したような、やわらかい色合いを生み出します。\r\n　その独特の色合いと模様から、「ホワイトタイガー」と名付けました。','coffee_cup','直径：約8.0cm (取っ手を除く)、10.5cm (取っ手込み)\r\n高さ：約8.4cm\r\n容量：約160cc (8割注水時)\r\n重さ：236g\r\n',8.0,10.5,8.4,236,160,'白土、黒土','外側：亀甲貫入\r\n内側：うのふ','',0,'monotone',NULL,'https://www.instagram.com/p/DGnhjBXTaRX/','2025-01-05','2025-09-24 15:38:10',1),(38,'鶉帯','部分練り込み小鉢「鶉帯」','　白土と黒土を練り込んだ模様を、帯状にめぐらせた小鉢です。\r\n　その帯模様を中心に、しのぎの技法で六角形の文様を彫り込み、リズムと立体感を加えました。模様を器全体に施すのではなく、あえて帯の部分に集中させることで、洗練された佇まいを意識しています。\r\n　器は4本足でしっかりと自立します。\r\n　本作は電動ろくろではなく、手びねりによって成形しています。そのため、形にわずかな歪みがあり、それがかえって温かみのある有機的な感触を生み出しています。\r\n　鶉の羽を思わせる模様を帯のように器がまとう姿から、「鶉帯（うずらおび）」と名付けました。\r\n　副菜を少し添えたり、お菓子や小物入れとしても楽しめるサイズ感です。','small_bowl','直径：約11.0cm\r\n高さ：約7.5cm\r\n容量：約180cc (8割注水時)\r\n重さ：257g\r\n',11.0,11.0,7.5,257,180,'白土、黒土','外側：乳濁\r\n内側：黒天目','',0,'monotone',NULL,'https://www.instagram.com/p/DIWgqjkz3lD/','2025-01-26','2025-09-24 16:20:54',1),(39,'凪の時間','玉サボテン様練り込みコーヒーカップ「凪の時間」','　穏やかな水面を思わせる、白と黒の静かなボーダー模様が印象的なコーヒーカップです。\r\n　白土と黒土の二色の粘土を練り合わせ、さらに側面をしのいで、六角形の模様を削り出しました。この模様は玉サボテンの陵を思わせるように、柔らかくふくらんでいます。\r\n　練り込みでは複雑な模様が現れることも多いのですが、このカップは穏やかな水平線になりました。\r\n　その落ち着いた佇まいから、『凪の時間』と名付けました。\r\n　コーヒーを飲みながら、静かに流れる自分だけの時間を楽しんでみませんか？','coffee_cup','直径：約9.5cm (取っ手を除く)、約12.5cm (取っ手を含む)\r\n高さ：約7.0cm\r\n容量：約160cc (8割注水時)\r\n重さ：232g',9.5,12.5,7.0,232,160,'白土、黒土','外側：透明釉\r\n内側：黒天目','',1,'monotone','https://minne.com/items/43768529','https://www.instagram.com/p/DN6_gUEk4iB/','2025-01-26','2025-10-16 03:55:33',1),(40,'墨流し','玉サボテン様練り込みコーヒーカップ「墨流し」','　白土と黒土を練り込んで成形し、玉サボテンをモチーフに六角形のふくらみを彫り込んだ、力強さとやわらかさを併せ持つコーヒーカップです。\r\n　外側には、細やかな貫入が入る貫入性志野釉を施しました。白土と黒土のコントラストは、釉薬の効果により、白はややクリーム色に、黒はグレーがかった柔らかな色調へと変化し、全体に穏やかな表情をもたらしています。\r\n　本体は短い円柱形で、6本の低い力強い脚でカップを支えています。安定感と同時に、独自の存在感を演出します。\r\n　内側には黒天目釉を使用しました。縁の部分では2種類の釉薬が重なり合って泡状の模様が生まれています。流れるような練り込み模様と、しのぎによって生まれた有機的な歪みの線。\r\n　その見た目が、日本の伝統的な染色技法「墨流し」を思わせることから、この作品に「墨流し」という銘をつけました。','coffee_cup','直径：約9.0cm (取っ手を除く)、約11.5cm (取っ手を含む)\r\n高さ：約7.0cm\r\n容量：約180cc (8割注水時)\r\n重さ：241g',9.0,11.5,7.0,241,180,'白土、黒土','外側：貫入性志乃\r\n内側：黒天目','',1,'monotone','https://minne.com/items/42866956','https://www.instagram.com/p/DIyqnpJzqjd/','2025-02-16','2025-09-24 15:38:52',1),(42,'冬のモモンガ','部分練り込みコーヒーカップ「冬のモモンガ」','　このカップでは、練り込みとしのぎの技法を部分的に取り入れています。\r\n　白土と黒土を組み合わせた練り込みは、側面の中央付近にとどめ、その部分を中心に、六角形を描くように、しのぎを加えました。あえて装飾を一部にとどめることで、控えめな印象となっています。\r\n　その上からは、厚みのある「亀甲貫入」の釉薬を掛けています。この釉薬により、白黒の練り込み模様は乳白色のヴェールに包まれるように柔らかくぼやけ、しのぎの稜線も滲むようにやさしく変化します。\r\n　高台の代わりに3本の小さな足をつけており、まるで小動物がちょこんと身をかがめているよう。その姿が、冬毛にくるまり木のうろで静かに休むモモンガを思わせることから、「冬のモモンガ」と名付けました。\r\n　日常のひとときに、森の中の小さな物語をそっと添えてくれるような、やさしい一品です。','coffee_cup','直径：約8.0cm (取っ手を除く)、約11.0cm (取っ手を含む)\r\n高さ：約8.0cm\r\n容量：約150cc (8割注水時)\r\n重さ：245g',8.0,11.0,8.0,245,150,'白土＋黒土','外側：亀甲貫入\r\n内側：黒天目','',1,'monotone','https://minne.com/items/43197758','https://www.instagram.com/p/DKpPIkQzhj4/','2025-02-16','2025-10-14 02:33:19',1),(43,'単調作業','サボテン金剛丸様練り込み中鉢「単調作業」','　白土と黒土を練り込み成形し、サボテン「金剛丸」のいぼをモチーフに、ピラミッド状の模様を側面全体に彫り込んだ中鉢です。\r\n　練り込みの縞模様を削ることで、それぞれのピラミッドに等高線のような文様が浮かび上がりました。しかし、このピラミッド、実に360個。  ひたすら彫るという、まさに「単調作業」……眠気に誘われながらも、一つひとつ丁寧に刻みました。\r\n　その甲斐あってか、この中鉢には独特のリズムと表情が生まれたように思います。銘は、制作過程からそのまま「単調作業」と名付けました。','medium_bowl','直径：約17.0cm\r\n高さ：9.5cm\r\n容量：約1,000cc (8割注水時)\r\n重さ：850g',17.0,17.5,9.5,850,1,'白土、黒土','外側：3号透明\r\n内側：黒天目','',0,'monotone',NULL,'https://www.instagram.com/p/DJMrjMJzm_P/','2025-03-22','2025-09-23 15:56:36',1),(44,'イソギンチャク','玉サボテン様練り込み中鉢「イソギンチャク」','　たっぷり900cc入る中鉢。\r\n　どっしりとした安定感があり、食卓の主役として存在感を放ちます。\r\n　白土と黒土を練り込んだ後、しのぎの技法で表面を削っています。この削りにより、模様はさらに複雑にゆがみ、有機的な表情に仕上がりました。削りのモチーフは玉サボテン。六角形のパターンは、それぞれが緩やかに盛り上がり、独特の手触りと立体感を生み出しています。\r\n　外側は、貫入性志野という釉薬を掛けています。わずかに不透明なこの釉薬は、白土と黒土のコントラストをやわらげ、全体を落ち着いた印象にまとめています。釉薬の特長でもある細かい貫入やピンホールが入ることで、どこか時間を重ねた器のような、静かな趣も感じさせます。また、内側の黒天目釉は、その深い黒が料理を引き立てます。\r\n　高台は9本の足で構成されており、器を裏返すと、まるでイソギンチャクのような姿に。銘はそのまま「イソギンチャク」としました。','medium_bowl','直径：約16.0cm\r\n高さ：約9.7cm\r\n容量：約900cc (8割注水時)\r\n重さ：936g',16.0,16.0,9.7,936,900,'白土、黒土','外側：貫入性志野\r\n内側：黒天目','',0,'monotone',NULL,'https://www.instagram.com/p/DJRtW5szHrx/','2025-04-13','2025-09-23 15:38:12',1),(45,'炎芯雪うずら','部分練り込みデミタスカップ「炎芯雪うずら」','　練り込みとしのぎの技法を組み合わせたコーヒーカップです。\r\n　白土と黒土を練り合わせていますが、その模様をカップの半分ほどに抑えました。模様のある部分と素地の白土部分が大きく二分され、ひとつの器に異なるふたつの表情が共存しています。\r\n　さらに、カップの側面全体には、サボテンの金剛丸をモチーフにしたピラミッド状の模様を彫り込んでおり、独特な立体感を楽しめます。\r\n　外側には「貫入性志野」という釉薬を使用。貫入と、黒土の上に浮かぶ小さな凹凸が、まるで永く風雪に晒されてきたかのような風合いを生み出しています。内側には「赤結晶」という釉薬を施しました。ゆらめく深紅の色彩は、雪の中に灯る「炎の芯」を思わせます。 \r\n　外側の練り込み模様が、雪景色にたたずむうずらの姿を連想させることと合わせ、銘を「炎芯雪うずら」としました。','demitasse_cup','直径：約8.0cm (取っ手を除く)、約10.5cm (取っ手を含む)\r\n高さ：約5.5cm\r\n容量：約125cc (8割注水時)\r\n重さ：167g',8.0,10.5,5.5,167,125,'白土、黒土','外側：貫入性志野\r\n内側：赤結晶','',0,'multicolour',NULL,'','2025-03-09','2025-10-14 15:35:06',1),(50,'うっかりヒョウモンダコ','玉サボテン様練り込みコーヒーカップ「うっかりヒョウモンダコ」','　深海に棲む猛毒のヒョウモンダコをモチーフにした作品です。\r\n　ヒョウモンダコは猛毒をもち、危険を知らせるために体表に鮮やかな青い輪紋を浮かび上がらせます。その姿を表現するために鮮やかなトルコブルーの粘土を使いましたが、少し落ち着いた雰囲気を出そうと貫入性志野を掛けたところ、警告色がぼんやりとした印象になりました。貫入性志野の特性をよく考えていれば、この釉薬を選ばなかったのに・・・ということで、銘は「うっかりヒョウモンダコ」にしました。\r\n　トルコブルー、ライトブラウン、ダークブラウンの3色の粘土を練り込み、カップの側面全体に六角形の模様を彫り込んでいます。高台は6本の足で表現しました。\r\n　こんな「うっかり」したコーヒーカップですが、毒はないので安心して毎日のコーヒーのお供にしてあげてください。','coffee_cup','直径：約8.5cm (取っ手を除く)、約11.0cm (取っ手を含む)\r\n高さ：約7.0cm\r\n容量：約150cc (8割注水時)\r\n重さ：202g',8.5,11.0,7.0,202,150,'カラー粘土：トルコブルー、ライトブラウン、ダークブラウン','外側：貫入性志野\r\n内側：黒天目','',1,'multicolour','https://minne.com/items/43841419','https://www.instagram.com/p/DOV3SO9kVUV/','2025-06-01','2025-09-23 15:57:47',1),(51,'島の精霊','玉サボテン様練り込みデミタスカップカップ「島の精霊」','　練り込みとしのぎの技法を組み合わせた、デミタスサイズのコーヒーカップです。\r\n　黒土と、比率を抑えた白土の練り込みにより、黒い背景に白の流線が浮かび上がります。\r\n　カップの側面には玉サボテンをイメージしてゆるやかに膨らんだ六角形を彫り込んでいます。このしのぎによって、器の表面に細かな凹凸が生まれます。\r\n白の流線は、しのぎの影響を受けて変化します。凹凸を避けるように曲がったり、途中で切り離されたり、時に中洲のように浮かんで見える箇所もあります。\r\n　高台は6本の脚で構成しました。やや内側に湾曲した脚は、大地を鷲掴みにしているような印象を与えます。\r\n　側面の模様が一見すると顔のようにも見えることがあります。その表情と器全体の雰囲気から、「島の精霊」と銘を付けました。','demitasse_cup','直径：約7.5cm (取っ手を除く)、約10.0cm (取っ手を含む)\r\n高さ：約7.5cm\r\n容量：約125cc (8割注水時)\r\n重さ：192g',7.5,10.0,7.5,192,125,'カラー粘土白25%＋黒75%','外側：3号透明\r\n内側：黒天目','',1,'monotone','https://minne.com/items/43197854','https://www.instagram.com/p/DL2b9keTIVn/','2025-06-01','2025-09-22 03:48:13',1),(52,'雪仔虎','玉サボテン様練り込みコーヒーカップ「雪仔虎」','　白土と黒土を練り込んで成形したコーヒーカップです。\r\n　側面には玉サボテンから着想を得た六角形の文様を彫り込みました。六角形はゆるやかに膨らみ、手に心地よく馴染みます。高台は6本の足になっています。ちょっと太めに作ってあるので、安定してカップを支えてくれます。\r\n　内側には真っ黒い「黒天目」を、外側には貫入が現れる「貫入性志野」を釉掛けしました。「貫入性志野」により練り込みの白土と黒土のコントラストが和らぎ、落ち着いた風合いになっています。\r\n　白と黒の模様がホワイトタイガーを思わせ、さらに太めの足は大きな動物の子供時代を想起させたので、銘を「雪仔虎」としました。','coffee_cup','直径：約9.0cm (取っ手を除く)、12.0cm (取っ手込み)\r\n高さ：約7.5cm\r\n容量：約150cc (8割注水時)\r\n重さ：222g',9.0,12.0,7.5,222,150,'カラー粘土の白75%＋黒25%','外側：貫入性志野\r\n内側：黒天目','',1,'monotone','https://minne.com/items/44109057','https://www.instagram.com/p/DNlXNHnTvkM/','2025-06-01','2025-10-16 03:56:44',1),(53,'しっかりヒョウモンダコ','玉サボテン様練り込みコーヒーカップ「しっかりヒョウモンダコ」','　深海に棲む猛毒のヒョウモンダコをモチーフにした作品です。\r\n　ヒョウモンダコは猛毒をもち、危険を知らせるために体表に鮮やかな青い輪紋を浮かび上がらせます。このカップでは、その警告色を表現するため、鮮やかなトルコブルーの粘土を使いました。そして、その青がしっかり見えるよう、透明釉を掛けました。しっかりトルコブルーが発色したので、銘は「しっかりヒョウモンダコ」です。\r\n(実は、以前、うっかり貫入性志野という釉薬を掛けてしまい、ぼんやりしたヒョウモンダコができたことがありました)\r\n　見た目は毒々しいかもしれませんが、もちろん毒はありません。安心して毎日のコーヒーのお供にしてあげてください。\r\n','coffee_cup','直径：約7.0cm (取っ手を除く)、約9.5cm (取っ手を含む)\r\n高さ：約7.0cm\r\n容量：約135cc (8割注水時)\r\n重さ：184g',7.0,9.5,7.0,184,135,'カラー粘土：トルコブルー、ライトブラウン、ダークブラウン','外側：3号透明\r\n内側：黒天目','',1,'multicolour','https://minne.com/items/43841520','https://www.instagram.com/albrecht1999/p/DOV40uREVVw/','2025-07-27','2025-09-23 15:26:20',1),(54,'冬の池、氷の泡','玉サボテン様練り込みコーヒーカップ「冬の池、氷の泡」','　寒い冬の池。氷の下をのぞき込むと、大きな泡の塊が氷に閉じ込められているのが見えます。急に気温が下がって、はじける前に凍ったのか、氷が厚く成長するのと一緒に泡も育ったのか・・・　本来すぐに消える泡が、氷に包まれ冬の間だけ姿をとどめている。その不思議な光景を思い浮かべ、このカップに「冬の池、氷の泡」と銘を付けました。\r\n　白土と黒土を練り込み、カップの側面には六角形の模様をしのぎました。\r\n　外側には亀甲貫入釉を掛けました。透明感のある釉の下から練り込み模様が透け、小さな気泡や貫入が自然の中の氷を思わせます。白と黒のコントラストは釉薬によって和らぎ、穏やかな表情を見せます。手に取れば、柔らかく、やさしい手触りです。\r\n　静かな氷の池を思わせるカップですが、温かいコーヒーのお供にいかがでしょうか？','coffee_cup','直径：約8.0cm (取っ手を除く)、約10.5cm (取っ手を含む)\r\n高さ：約7.0cm\r\n容量：約140cc (8割注水時)\r\n重さ：204g',8.0,10.5,7.0,204,140,'白土、黒土','外側：亀甲貫入\r\n内側：うのふ','',1,'monotone','https://minne.com/items/43925588','https://www.instagram.com/p/DO8ous2kbgM/','2025-08-03','2025-10-16 04:03:23',1),(55,'雪割りの奔流','玉サボテン様練り込みコーヒーカップ「雪割りの奔流」','　練り込みとしのぎの技法を組み合わせてつくったコーヒーカップです。植物の生命力をイメージし、グリーン・ピンク・イエローのカラー粘土を練り込み、さらにそれを白土で包みました。\r\n　当初、しのぎを入れることで、白土のあいだから花畑のような色彩がつつましく顔を出す姿を思い描いていたのですが、実際に削ってみると、白土が思いのほか残らず、内側の練り込み模様が勢いよくあふれ出してしまいました。結果として、雪割りの植物の息吹がほとばしるような、生命の奔流を感じさせるカップに仕上がりました。\r\n　しのぎのモチーフは玉サボテン。側面には6角形の模様を、膨らみを持たせながらていねいに彫り出しています。それに呼応するように、高台も6本の足で支える形としました。\r\n　残雪にも見える白土を押しのけ、内側からあふれる色。エネルギッシュな春の芽吹きを思わせる姿から、「雪割りの奔流」と名付けました。','coffee_cup','直径：約8.0cm (取っ手を除く)、約12.0cm (取っ手を含む)\r\n高さ：約7.0cm\r\n容量：約230cc (8割注水時)\r\n重さ：248g',8.0,12.0,7.0,248,230,'白土、カラー粘土(緑、ピンク、黄色)','外側：透明\r\n内側：黒天目','',1,'multicolour','https://minne.com/items/44109057','https://www.instagram.com/p/DP1VHX4klCE/','2025-08-03','2025-10-15 18:18:29',1);
/*!40000 ALTER TABLE `artworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artworks_import_raw`
--

DROP TABLE IF EXISTS `artworks_import_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artworks_import_raw` (
  `id` int(11) DEFAULT NULL,
  `description_title` varchar(255) DEFAULT NULL,
  `categories` varchar(100) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `spec` longtext DEFAULT NULL,
  `width` decimal(5,1) DEFAULT NULL,
  `maxWidth` decimal(5,1) DEFAULT NULL,
  `height` decimal(5,1) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `technique0` varchar(100) DEFAULT NULL,
  `technique1` varchar(100) DEFAULT NULL,
  `technique2` varchar(100) DEFAULT NULL,
  `clay` longtext DEFAULT NULL,
  `glaze` longtext DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `in_stock` varchar(10) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `instagramUrl` varchar(500) DEFAULT NULL,
  `completionDate` varchar(20) DEFAULT NULL,
  `updateDate` varchar(20) DEFAULT NULL,
  `valid` varchar(10) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artworks_import_raw`
--

LOCK TABLES `artworks_import_raw` WRITE;
/*!40000 ALTER TABLE `artworks_import_raw` DISABLE KEYS */;
INSERT INTO `artworks_import_raw` VALUES (1,'玉サボテン様コーヒーカップ「黒亀」','coffee_cup','玉サボテンの亀甲模様からインスピレーションを得たコーヒーカップです。\r\n6角形の模様がゆるやかに膨らんだ立体感のある仕上がりで、触れるたびにその繊細な質感を楽しむことができます。\r\nさらに、高台部分を6本の足のようにデザインし、遊び心をプラスしました。\r\n上に張り出した取っ手は、持ちやすさを考慮しつつ、デザインのアクセントにもなっています。\r\n艶やかな黒い地に、無数の油滴模様が広がり、見ていて飽きることのない魅力を放っています。\r\nこの独特なフォルムから「黒亀」と名付けました。','黒亀','直径：約10cm (取っ手を除く)、12.5cm (取っ手込み)\r\n高さ：約8.5cm\r\n容量：約160cc (8割注水時)\r\n重さ：190g\r\n',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,'1'),(3,'柱サボテン様コーヒーカップ「十二刻」','coffee_cup','柱サボテンをモチーフにしたコーヒーカップです。\r\nカップの側面全体に、柱サボテンの陵を思わせる立体模様を彫り込みました。\r\n外側は黒マット釉を施し、しっとりとした手触りと深みのある表情に。\r\n内側には白萩釉を掛けており、口縁では白萩と黒マットの釉薬が溶け合い、滴り落ちるような独特の模様が生まれました。\r\nこのカップの最大の特長は、円周に沿って並ぶ 12本の足。\r\nその姿がまるで時計の文字盤のように見えることから、「十二刻」と名付けました。\r\nあなたのコーヒーブレークが、ゆったりとした穏やかなひとときになりますように。\r\n「十二刻」とともに、心落ち着く時間をお楽しみください。','十二刻','直径：約10cm (取っ手を除く)、12.5cm (取っ手込み)\r\n高さ：約6.5cm\r\n容量：約200cc (8割注水時)\r\n重さ：200g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'2023/10/20',NULL,'1'),(7,'玉サボテン様12足黒マットパスタ皿「玄武皿」','coffee_cup','全体に6角形の模様が施され、それぞれの6角形が膨らむように彫刻されています。これはまるでサボテンの葉が太陽の光を浴びて膨らむ様子を再現したもの。高台の形も工夫され、12本の足で立つような形に仕上げられています。これはまるでサボテンが土地から根を張っているかのような迫力があります。\r\n\r\nそして、黒マットという釉薬で仕上げられたこのパスタ皿は、艶のない黒い器となっています。1つ1つの模様や足を削りだすのにはとても時間がかかり大変でしたが、その努力が実り、美しい仕上がりとなりました。\r\n\r\nこのパスタ皿を使えば、パスタを盛り付けるだけで、まるでサボテンの上に乗っているような気分になれます。サボテンの魔法が詰まったこのパスタ皿で、美味しいパスタを楽しんでください。','玄武皿',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,'2023/10/6',NULL,'1'),(8,'サボテン菊水様コーヒーカップ「アルマジロ」','coffee_cup','「菊水」というサボテンをモチーフに、しのぎの技法をで作ったコーヒーカップです。\r\nカップの側面全体に、上向きのうろこ状の模様をレリーフ状に彫り込みました。\r\n釉薬には「蕎麦」を使用しており、薄くかかった部分は深い茶色に、厚くかかった部分は明るい茶色の斑点模様が浮かび上がります。これにより、レリーフの形に沿って複雑な色の濃淡が生まれ、奥行きのある表情を楽しめます。\r\n彫り込んだ模様は滑らかに仕上げているため、指先でなぞると心地よい手触りです。\r\n取っ手は幅広に作り、指をしっかり通せるため、安定感のある持ちやすさも魅力のひとつ。\r\nサボテンをイメージして作りましたが、焼き上がるとその姿はまるでアルマジロの鎧のよう。そこで、このカップには「アルマジロ」という銘を付けました。','アルマジロ','直径：約9.5cm (取っ手を除く)、11.5cm (取っ手込み)\r\n高さ：約7cm\r\n容量：約130cc (8割注水時)\r\n重さ：195g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,'2023/10/6',NULL,'1'),(20,'玉サボテン様しのぎマグカップ「赫耀の秘光」','coffee_cup','玉サボテンを模した六角形の彫り模様を施したマグカップです。\r\n外側には光沢を抑えた黒マット釉を使用し、落ち着いた佇まいを演出。\r\n対照的に、内側の赤結晶釉は周囲の光を反射し、まるで燃え立つ炎のような輝きを放ちます。\r\nカップを手に、外側から中を覗くと、暗闇の奥から鋭い赤の光が目に飛び込んできます。\r\n静寂の黒に秘められた鮮烈な輝きの美しさを映し、「赫耀の秘光」と名付けました。\r\n光と影が織りなす表情を、ぜひ手に取ってご堪能ください。','赫耀の秘光','直径：約10.5cm (取っ手を除く)、約13.0cm (取っ手を含む)\r\n高さ：約8.5cm\r\n容量：約260cc (8割注水時)\r\n重さ：234g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,'2024/9/22',NULL,'1'),(21,'玉サボテン様練り込みコーヒーカップ「モアレ」','coffee_cup','これも玉サボテンをモチーフにしたコーヒーカップです。\r\n普段は白土や赤土など1種類の土で作っていますが、今回は「練り込み」の技法でカップの形を作ってから、サボテンの形に削ってみました。\r\n赤土と黒土の2つの粘土を使っています。練り込みなので、カップの表面に2つの粘土の縞模様ができますが、これを削ると、削った深さに応じて、さらに別の模様が出てきます。これがとても面白い模様になりました。\r\nモアレ模様に見えるので、作品名を「モアレ」としました。\r\n全体に「12番石灰」という透明釉をかけています。','モアレ','直径：約9.0cm (取っ手を除く)、約11.0cm (取っ手を含む)\r\n高さ：約6.5cm\r\n容量：約150cc (8割注水時)\r\n重さ：189g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'2024/9/29',NULL,'1'),(22,'サボテン金剛丸様練り込みコーヒーカップ「雲海のピラミッド」','coffee_cup','玉サボテンをモチーフにしたコーヒーカップです。\r\nでも、出来上がった印象は、小さなパイナップルです(笑)。\r\n赤土と黒土で「練り込み」の技法でカップの形を作ってから、小さなピラミッド状の模様をカップ側面全体につけました。削ることにより、等高線、あるいは、地層のような縞模様が表面に浮かびました。\r\n全体に「12番石灰」という透明釉をかけています。\r\n透明釉ですが、厚くかかると白い膜のようになります。このカップでは、削ったピラミッドとピラミッドの間の溝に厚くかかりました。その見た目の印象から、銘を「雲海のピラミッド」としました。','雲海のピラミッド',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'2024/10/6',NULL,'1'),(25,'玉サボテン様乳濁赤結晶どんぶり「翠紅碗」','coffee_cup','サボテンをモチーフにしたどんぶりです。\r\n外側には、サボテンを模した6角形の模様を彫り込んでいます。\r\nその模様に合わせ、高台を6本の足にしました。6本足で立つ様が少しだけかわいいです。\r\n外側は乳濁という、どちらかというと地味に見える緑色の釉薬を、内側は赤結晶という派手な紅色の釉薬をかけています。\r\n風雪に耐えるサボテンの、外皮は地味で目立たないのに、内部はみずみずしい感じを表現し、銘を「翠紅碗」としました。','翠紅碗','直径：約15.0cm\r\n高さ：約8.0cm\r\n容量：約400cc (8割注水時)\r\n重さ：350g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,'1'),(26,'玉サボテン様練り込みコーヒーカップ「目覚めのフクロウ」','coffee_cup','赤土と黒土を練り込み、玉サボテンからインスピレーションを得た六角形の模様を彫り込んだコーヒーカップです。\r\n高台は6本のスリムな足で支えられ、個性的なフォルムが際立ちます。\r\n土の自然な色彩と練り込みの美しい模様を引き立てるため、釉薬には透明釉を使用しました。\r\n銘は 「目覚めのフクロウ」。\r\nしのぎによって変化した練り込みの模様が、まるで寝ぼけまなこのフクロウのよう。\r\n手に取るたびに、眠たげな表情のフクロウと目が合い、やさしく穏やかなコーヒーの時間を演出してくれます。','目覚めのフクロウ','直径：約8.5cm (取っ手を除く)、約10.5cm (取っ手を含む)\r\n高さ：約8.3cm\r\n容量：約180cc (8割注水時)\r\n重さ：192g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'2024/10/20',NULL,'1'),(27,'サボテン様練り込みコーヒーカップ「瑪瑙環」','coffee_cup','白土と黒土を練り込み成形し、全体に細かいピラミッド型の模様を彫り込んだコーヒーカップです。練り込みによって生まれる独特の縞模様を削ることでさらに表情豊かな模様の妙が生まれます。\r\nデザインのモチーフは、サボテンの金剛丸。側面全体に深く刻み込んだピラミッド状のしのぎ模様が、形にメリハリを与え、手に取ったときの感触も楽しめます。\r\n仕上げには透明釉を施し、練り込み模様の美しさを引き立てました。カップ全体に広がる同心円状の模様が、瑪瑙の層を思わせることから「瑪瑙環」と名付けました。','瑪瑙環','直径：約8.5cm (取っ手を除く)、11cm (取っ手込み)\r\n高さ：約6.8cm\r\n容量：約160cc (8割注水時)\r\n重さ：199g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,'2024/10/27',NULL,'1'),(28,'玉サボテン様練り込みコーヒーカップ「瑪瑙晶」','coffee_cup','No.027「瑪瑙環」と同じく、白土と黒土を練り込んで成形したコーヒーカップです。\r\nただし本作では、カップの外側に玉サボテンをモチーフとした六角形のふくらみを彫り込みました。\r\n削ったことで、思いがけない模様が現れました。\r\nまるで「日」という字を重ねたような模様です。\r\n漢字にすると「晶」でしょうか？\r\nそこで、このカップに「瑪瑙晶（めのうしょう）」という銘を付けました。','瑪瑙晶','直径：約8.0cm (取っ手を除く)、約11.0cm (取っ手を含む)\r\n高さ：約7.5cm\r\n容量：約140cc (8割注水時)\r\n重さ：205g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'2024/11/3',NULL,'1'),(29,'玉サボテン様練り込みコーヒーカップ「瑪瑙墨」','coffee_cup','練り込みとしのぎの技法を組み合わせたコーヒーカップです。\r\n白土と黒土を重ねて成形した素地に、六角形の模様を一つひとつ彫り込んでいます。\r\nそれぞれの六角形はゆるやかに膨らんでおり、削りの深さによって模様に揺らぎが生まれています。\r\nカップの内側には「黒天目」という艶やかな黒の釉薬を掛けました。\r\nこの黒が外側の模様を際立たせ、カップ全体の印象を引き締めています。\r\n練り込みによって現れた縞模様が瑪瑙石を思わせ、内側の黒が墨のように見えることから「瑪瑙墨」という銘にしました。','瑪瑙墨','直径：約7.5cm (取っ手を除く)、約10.5cm (取っ手を含む)\r\n高さ：約8.0cm\r\n容量：約140cc (8割注水時)\r\n重さ：208g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'2024/11/10',NULL,'1'),(30,'サボテン金剛丸様練り込み中鉢「雪墨嶺」','coffee_cup','玉サボテンをモチーフに、側面いっぱいにピラミッド型の模様を彫り込みました。\r\n白と黒の粘土の練り込みにより生み出された等高線のような縞模様が特長の中鉢です。\r\nひと山ひと山、手作業で彫り込んだ模様が山並みのように連なります。\r\nその姿から、「雪墨嶺（せつぼくれい）」という銘を付けました。','雪墨嶺','直径：約13.0cm\r\n高さ：約7.4cm\r\n容量：約400cc (8割注水時)\r\n重さ：378g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'2024/11/17',NULL,'1'),(34,'ねじり金剛丸様練り込みコーヒーカップ「牡蠣の群生」','coffee_cup','練り込みとしのぎの技法を組み合わせたデミタスカップです。\r\n白土と黒土を使った練り込みの素地に、ピラミッド型の模様を削りだしたのですが、正方形ではなく、長方形を傾けた形で削ってみました。\r\nピラミッドの高さにより等高線のように白と黒の縞模様があらわれ、おもしろい見た目になりましたが、1つ1つの模様が牡蠣が並んでいるように見えたので、銘は「牡蠣の群生」としました。\r\nサイズはやや小さめです。','牡蠣の群生','直径：約7.0cm (取っ手を除く)、約10.0cm (取っ手を含む)\r\n高さ：約7.4cm\r\n容量：約100cc (8割注水時)\r\n重さ：176g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'2024/12/8',NULL,'1'),(35,'柱サボテン様練り込みコーヒーカップ「土のリズム」','coffee_cup','柱サボテンの縦に並ぶ陵（りょう）からインスピレーションを得たコーヒーカップです。\r\n白土と赤土を使った「練り込み」の技法で独特の模様を生み出し、さらに「しのぎ」の技法で柱サボテンのような立体感を表現しました。\r\n内側には「うのふ」という白い釉薬、外側は透明釉を掛けています。カップの口縁には2つの釉薬が混ざり合い、波紋のような模様が生まれています。\r\n側面の模様が地層のように見え、それが等間隔に柱状に並ぶので「土のリズム」と名付けました。\r\n大地を掌に収めたようなこのカップで、心落ち着くコーヒータイムをお過ごしください。','土のリズム','直径：約9.5cm (取っ手を除く)、12cm (取っ手込み)\r\n高さ：約5.3cm\r\n容量：約140cc (8割注水時)\r\n重さ：205g',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,'2024/12/15',NULL,'1');
/*!40000 ALTER TABLE `artworks_import_raw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `slug` varchar(50) NOT NULL,
  `label_ja` varchar(100) NOT NULL,
  `label_en` varchar(100) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('coffee_cup','コーヒーカップ','Coffee Cup',1,1),('demitasse_cup','デミタスカップ','Demitasse Cup',2,1),('donburi','どんぶり','Donburi Bowl',11,1),('large_bowl','大鉢','Large Bowl',8,1),('large_plate','大皿','Large Plate',4,1),('medium_bowl','中鉢','Medium Bowl',9,1),('medium_plate','中皿','Medium Plate',5,1),('mosquito_coil_holder','蚊取り線香入れ','Mosquito Coil Holder',12,1),('pasta_plate','パスタ皿','Pasta Plate',7,1),('small_bowl','小鉢','Small Bowl',10,1),('small_plate','小皿','Small Plate',6,1),('soup_cup','スープカップ','Soup Cup',3,1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coloring`
--

DROP TABLE IF EXISTS `coloring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coloring` (
  `slug` varchar(50) NOT NULL,
  `label_ja` varchar(100) NOT NULL,
  `label_en` varchar(100) NOT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coloring`
--

LOCK TABLES `coloring` WRITE;
/*!40000 ALTER TABLE `coloring` DISABLE KEYS */;
INSERT INTO `coloring` VALUES ('monotone','モノトーン','Monotone',1),('multicolour','マルチカラー','Multicolour',1);
/*!40000 ALTER TABLE `coloring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colorings`
--

DROP TABLE IF EXISTS `colorings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `colorings` (
  `slug` varchar(50) NOT NULL,
  `label_ja` varchar(100) NOT NULL,
  `label_en` varchar(100) NOT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colorings`
--

LOCK TABLES `colorings` WRITE;
/*!40000 ALTER TABLE `colorings` DISABLE KEYS */;
INSERT INTO `colorings` VALUES ('monotone','モノトーン','Monotone',1),('multicolour','マルチカラー','Multicolour',1);
/*!40000 ALTER TABLE `colorings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `techniques`
--

DROP TABLE IF EXISTS `techniques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `techniques` (
  `slug` varchar(50) NOT NULL,
  `label_ja` varchar(100) NOT NULL,
  `label_en` varchar(100) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `techniques`
--

LOCK TABLES `techniques` WRITE;
/*!40000 ALTER TABLE `techniques` DISABLE KEYS */;
INSERT INTO `techniques` VALUES ('nerikomi','練り込み','Nerikomi',1,1),('shinogi','しのぎ','Shinogi',2,1),('tebinari','手びねり','Handbuilding',3,1);
/*!40000 ALTER TABLE `techniques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `updates`
--

DROP TABLE IF EXISTS `updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates` (
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `article` text NOT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updates`
--

LOCK TABLES `updates` WRITE;
/*!40000 ALTER TABLE `updates` DISABLE KEYS */;
INSERT INTO `updates` VALUES ('2025-09-24 22:33:35','サイトを作成しました。',1),('2025-09-24 22:34:42','更新情報機能を追加しました。',1),('2025-09-24 22:34:56','見た目を調整しました。',1),('2025-10-15 15:15:32','お問い合わせフォームを追加しました。',1),('2025-10-16 03:19:50','玉サボテン様練り込みコーヒーカップ「雪割りの奔流」を追加しました。',1);
/*!40000 ALTER TABLE `updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` varchar(100) NOT NULL,
  `pw` varchar(100) NOT NULL,
  `role` varchar(100) DEFAULT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('sisiwaka_editor','$2y$10$SoyaepnRTbLupMp5.04T1OXYW6FGBSvAyOPhnBMxcqTUMWZhsTEYq',NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `test`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `test` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;

USE `test`;

--
-- Current Database: `ccdonuts`
--

USE `ccdonuts`;

--
-- Current Database: `mysql`
--

USE `mysql`;

--
-- Final view structure for view `user`
--

/*!50001 DROP VIEW IF EXISTS `user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp932 */;
/*!50001 SET character_set_results     = cp932 */;
/*!50001 SET collation_connection      = cp932_japanese_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`mariadb.sys`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user` AS select `global_priv`.`Host` AS `Host`,`global_priv`.`User` AS `User`,if(json_value(`global_priv`.`Priv`,'$.plugin') in ('mysql_native_password','mysql_old_password'),ifnull(json_value(`global_priv`.`Priv`,'$.authentication_string'),''),'') AS `Password`,if(json_value(`global_priv`.`Priv`,'$.access') & 1,'Y','N') AS `Select_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 2,'Y','N') AS `Insert_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 4,'Y','N') AS `Update_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 8,'Y','N') AS `Delete_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 16,'Y','N') AS `Create_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 32,'Y','N') AS `Drop_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 64,'Y','N') AS `Reload_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 128,'Y','N') AS `Shutdown_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 256,'Y','N') AS `Process_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 512,'Y','N') AS `File_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 1024,'Y','N') AS `Grant_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 2048,'Y','N') AS `References_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 4096,'Y','N') AS `Index_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 8192,'Y','N') AS `Alter_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 16384,'Y','N') AS `Show_db_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 32768,'Y','N') AS `Super_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 65536,'Y','N') AS `Create_tmp_table_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 131072,'Y','N') AS `Lock_tables_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 262144,'Y','N') AS `Execute_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 524288,'Y','N') AS `Repl_slave_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 1048576,'Y','N') AS `Repl_client_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 2097152,'Y','N') AS `Create_view_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 4194304,'Y','N') AS `Show_view_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 8388608,'Y','N') AS `Create_routine_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 16777216,'Y','N') AS `Alter_routine_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 33554432,'Y','N') AS `Create_user_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 67108864,'Y','N') AS `Event_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 134217728,'Y','N') AS `Trigger_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 268435456,'Y','N') AS `Create_tablespace_priv`,if(json_value(`global_priv`.`Priv`,'$.access') & 536870912,'Y','N') AS `Delete_history_priv`,elt(ifnull(json_value(`global_priv`.`Priv`,'$.ssl_type'),0) + 1,'','ANY','X509','SPECIFIED') AS `ssl_type`,ifnull(json_value(`global_priv`.`Priv`,'$.ssl_cipher'),'') AS `ssl_cipher`,ifnull(json_value(`global_priv`.`Priv`,'$.x509_issuer'),'') AS `x509_issuer`,ifnull(json_value(`global_priv`.`Priv`,'$.x509_subject'),'') AS `x509_subject`,cast(ifnull(json_value(`global_priv`.`Priv`,'$.max_questions'),0) as unsigned) AS `max_questions`,cast(ifnull(json_value(`global_priv`.`Priv`,'$.max_updates'),0) as unsigned) AS `max_updates`,cast(ifnull(json_value(`global_priv`.`Priv`,'$.max_connections'),0) as unsigned) AS `max_connections`,cast(ifnull(json_value(`global_priv`.`Priv`,'$.max_user_connections'),0) as signed) AS `max_user_connections`,ifnull(json_value(`global_priv`.`Priv`,'$.plugin'),'') AS `plugin`,ifnull(json_value(`global_priv`.`Priv`,'$.authentication_string'),'') AS `authentication_string`,if(ifnull(json_value(`global_priv`.`Priv`,'$.password_last_changed'),1) = 0,'Y','N') AS `password_expired`,elt(ifnull(json_value(`global_priv`.`Priv`,'$.is_role'),0) + 1,'N','Y') AS `is_role`,ifnull(json_value(`global_priv`.`Priv`,'$.default_role'),'') AS `default_role`,cast(ifnull(json_value(`global_priv`.`Priv`,'$.max_statement_time'),0.0) as decimal(12,6)) AS `max_statement_time` from `global_priv` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Current Database: `phpmyadmin`
--

USE `phpmyadmin`;

--
-- Current Database: `sisiwaka_touen`
--

USE `sisiwaka_touen`;

--
-- Current Database: `test`
--

USE `test`;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-20  0:55:54
