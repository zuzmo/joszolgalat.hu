-- MySQL dump 10.11
--
-- Host: sql.ppt.local    Database: ushahidi3
-- ------------------------------------------------------
-- Server version	5.0.51a-24+lenny5-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `actions` (
  `action_id` int(11) NOT NULL auto_increment,
  `action` varchar(75) NOT NULL,
  `qualifiers` text NOT NULL,
  `response` varchar(75) NOT NULL,
  `response_vars` text NOT NULL,
  `active` tinyint(4) NOT NULL,
  PRIMARY KEY  (`action_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores user defined actions triggered by certain events';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions_log`
--

DROP TABLE IF EXISTS `actions_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `actions_log` (
  `id` bigint(20) NOT NULL auto_increment,
  `action_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `action_id` (`action_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores a log of triggered actions';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `actions_log`
--

LOCK TABLES `actions_log` WRITE;
/*!40000 ALTER TABLE `actions_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `actions_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `alert` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned default '0',
  `alert_type` tinyint(4) NOT NULL COMMENT '1 - MOBILE, 2 - EMAIL',
  `alert_recipient` varchar(200) default NULL,
  `alert_code` varchar(30) default NULL,
  `alert_confirmed` tinyint(4) NOT NULL default '0',
  `alert_lat` varchar(150) default NULL,
  `alert_lon` varchar(150) default NULL,
  `alert_radius` tinyint(4) NOT NULL default '20',
  `alert_ip` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uniq_alert_code` (`alert_code`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores alerts subscribers information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_category`
--

DROP TABLE IF EXISTS `alert_category`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `alert_category` (
  `id` int(11) NOT NULL auto_increment,
  `alert_id` bigint(20) unsigned default NULL,
  `category_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `alert_id` (`alert_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores subscriber alert categories';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `alert_category`
--

LOCK TABLES `alert_category` WRITE;
/*!40000 ALTER TABLE `alert_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_sent`
--

DROP TABLE IF EXISTS `alert_sent`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `alert_sent` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `incident_id` bigint(20) unsigned NOT NULL,
  `alert_id` bigint(20) unsigned NOT NULL,
  `alert_date` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `alert_id` (`alert_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores a log of alerts sent out to subscribers';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `alert_sent`
--

LOCK TABLES `alert_sent` WRITE;
/*!40000 ALTER TABLE `alert_sent` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_sent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_banned`
--

DROP TABLE IF EXISTS `api_banned`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `api_banned` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `banned_ipaddress` varchar(50) NOT NULL,
  `banned_date` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='For logging banned API IP addresses';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `api_banned`
--

LOCK TABLES `api_banned` WRITE;
/*!40000 ALTER TABLE `api_banned` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_banned` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_log`
--

DROP TABLE IF EXISTS `api_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `api_log` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `api_task` varchar(10) NOT NULL,
  `api_parameters` varchar(100) NOT NULL,
  `api_records` tinyint(11) NOT NULL,
  `api_ipaddress` varchar(50) NOT NULL,
  `api_date` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='For logging API activities';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `api_log`
--

LOCK TABLES `api_log` WRITE;
/*!40000 ALTER TABLE `api_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_settings`
--

DROP TABLE IF EXISTS `api_settings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `api_settings` (
  `id` int(11) NOT NULL auto_increment,
  `default_record_limit` int(11) NOT NULL default '20',
  `max_record_limit` int(11) default NULL,
  `max_requests_per_ip_address` int(11) default NULL,
  `max_requests_quota_basis` int(11) default NULL,
  `modification_date` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='For storing API logging settings';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `api_settings`
--

LOCK TABLES `api_settings` WRITE;
/*!40000 ALTER TABLE `api_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badge`
--

DROP TABLE IF EXISTS `badge`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `badge` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(250) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores description of badges to be assigned';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `badge`
--

LOCK TABLES `badge` WRITE;
/*!40000 ALTER TABLE `badge` DISABLE KEYS */;
/*!40000 ALTER TABLE `badge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badge_users`
--

DROP TABLE IF EXISTS `badge_users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `badge_users` (
  `user_id` int(11) unsigned NOT NULL,
  `badge_id` int(11) NOT NULL,
  PRIMARY KEY  (`user_id`,`badge_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores assigned badge information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `badge_users`
--

LOCK TABLES `badge_users` WRITE;
/*!40000 ALTER TABLE `badge_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `badge_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `category` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `parent_id` int(11) NOT NULL default '0',
  `locale` varchar(10) NOT NULL default 'en_US',
  `category_position` tinyint(4) NOT NULL default '0',
  `category_title` varchar(255) default NULL,
  `category_description` text,
  `category_color` varchar(20) default NULL,
  `category_image` varchar(255) default NULL,
  `category_image_thumb` varchar(255) default NULL,
  `category_visible` tinyint(4) NOT NULL default '1',
  `category_trusted` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `category_visible` (`category_visible`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Holds information about categories defined for a deployment';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,0,'en_US',0,'Hózárlat','2013. március 15-i hóakadályok','a3cbfa',NULL,NULL,1,0),(4,0,'en_US',2,'Trusted Reports','Reports from trusted reporters','339900',NULL,NULL,1,1),(5,0,'en_US',1,'Szállás','Holds uncategorized reports','009887',NULL,NULL,1,1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_lang`
--

DROP TABLE IF EXISTS `category_lang`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `category_lang` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `category_id` int(11) unsigned NOT NULL,
  `locale` varchar(10) default NULL,
  `category_title` varchar(255) default NULL,
  `category_description` text,
  PRIMARY KEY  (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds translations for category titles and descriptions';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `category_lang`
--

LOCK TABLES `category_lang` WRITE;
/*!40000 ALTER TABLE `category_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checkin`
--

DROP TABLE IF EXISTS `checkin`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `checkin` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL,
  `incident_id` bigint(20) unsigned default '0',
  `checkin_description` varchar(255) default NULL,
  `checkin_date` datetime NOT NULL,
  `checkin_auto` enum('0','1') default '0',
  PRIMARY KEY  (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `user_id` (`user_id`),
  KEY `location_id` (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores checkin information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `checkin`
--

LOCK TABLES `checkin` WRITE;
/*!40000 ALTER TABLE `checkin` DISABLE KEYS */;
/*!40000 ALTER TABLE `checkin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `city` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `country_id` int(11) default NULL,
  `city` varchar(200) default NULL,
  `city_lat` varchar(150) default NULL,
  `city_lon` varchar(200) default NULL,
  PRIMARY KEY  (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores cities of countries retrieved by user.';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clickatell`
--

DROP TABLE IF EXISTS `clickatell`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `clickatell` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `clickatell_key` varchar(100) default NULL,
  `clickatell_api` varchar(100) default NULL,
  `clickatell_username` varchar(100) default NULL,
  `clickatell_password` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `clickatell`
--

LOCK TABLES `clickatell` WRITE;
/*!40000 ALTER TABLE `clickatell` DISABLE KEYS */;
INSERT INTO `clickatell` VALUES (1,'HBHI2XWG',NULL,NULL,NULL);
/*!40000 ALTER TABLE `clickatell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cluster`
--

DROP TABLE IF EXISTS `cluster`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cluster` (
  `id` int(11) NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL default '0',
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `latitude_min` double NOT NULL,
  `longitude_min` double NOT NULL,
  `latitude_max` double NOT NULL,
  `longitude_max` double NOT NULL,
  `child_count` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `left_side` int(11) NOT NULL,
  `right_side` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `incident_id` bigint(20) unsigned NOT NULL default '0',
  `category_id` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `location_id` (`location_id`),
  KEY `incident_id` (`incident_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores information used for clustering of reports on the map';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `cluster`
--

LOCK TABLES `cluster` WRITE;
/*!40000 ALTER TABLE `cluster` DISABLE KEYS */;
/*!40000 ALTER TABLE `cluster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `comment` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `incident_id` bigint(20) unsigned default NULL,
  `checkin_id` bigint(20) unsigned default NULL,
  `user_id` int(11) unsigned default '0',
  `comment_author` varchar(100) default NULL,
  `comment_email` varchar(120) default NULL,
  `comment_description` text,
  `comment_ip` varchar(100) default NULL,
  `comment_spam` tinyint(4) NOT NULL default '0',
  `comment_active` tinyint(4) NOT NULL default '0',
  `comment_date` datetime default NULL,
  `comment_date_gmt` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `checkin_id` (`checkin_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores comments made on reports/checkins';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `country` (
  `id` int(11) NOT NULL auto_increment,
  `iso` varchar(10) default NULL,
  `country` varchar(100) default NULL,
  `capital` varchar(100) default NULL,
  `cities` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=248 DEFAULT CHARSET=utf8 COMMENT='Stores a list of all countries and their capital cities';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'AD','Andorra','Andorra la Vella',0),(2,'AE','United Arab Emirates','Abu Dhabi',0),(3,'AF','Afghanistan','Kabul',0),(4,'AG','Antigua and Barbuda','St. John\'s',0),(5,'AI','Anguilla','The Valley',0),(6,'AL','Albania','Tirana',0),(7,'AM','Armenia','Yerevan',0),(8,'AN','Netherlands Antilles','Willemstad',0),(9,'AO','Angola','Luanda',0),(10,'AQ','Antarctica','',0),(11,'AR','Argentina','Buenos Aires',0),(12,'AS','American Samoa','Pago Pago',0),(13,'AT','Austria','Vienna',0),(14,'AU','Australia','Canberra',0),(15,'AW','Aruba','Oranjestad',0),(16,'AX','Aland Islands','Mariehamn',0),(17,'AZ','Azerbaijan','Baku',0),(18,'BA','Bosnia and Herzegovina','Sarajevo',0),(19,'BB','Barbados','Bridgetown',0),(20,'BD','Bangladesh','Dhaka',0),(21,'BE','Belgium','Brussels',0),(22,'BF','Burkina Faso','Ouagadougou',0),(23,'BG','Bulgaria','Sofia',0),(24,'BH','Bahrain','Manama',0),(25,'BI','Burundi','Bujumbura',0),(26,'BJ','Benin','Porto-Novo',0),(27,'BL','Saint BarthÃ©lemy','Gustavia',0),(28,'BM','Bermuda','Hamilton',0),(29,'BN','Brunei','Bandar Seri Begawan',0),(30,'BO','Bolivia','La Paz',0),(31,'BR','Brazil','BrasÃ­lia',0),(32,'BS','Bahamas','Nassau',0),(33,'BT','Bhutan','Thimphu',0),(34,'BV','Bouvet Island','',0),(35,'BW','Botswana','Gaborone',0),(36,'BY','Belarus','Minsk',0),(37,'BZ','Belize','Belmopan',0),(38,'CA','Canada','Ottawa',0),(39,'CC','Cocos Islands','West Island',0),(40,'CD','Democratic Republic of the Congo','Kinshasa',0),(41,'CF','Central African Republic','Bangui',0),(42,'CG','Congo Brazzavile','Brazzaville',0),(43,'CH','Switzerland','Berne',0),(44,'CI','Ivory Coast','Yamoussoukro',0),(45,'CK','Cook Islands','Avarua',0),(46,'CL','Chile','Santiago',0),(47,'CM','Cameroon','YaoundÃ©',0),(48,'CN','China','Beijing',0),(49,'CO','Colombia','BogotÃ¡',0),(50,'CR','Costa Rica','San JosÃ©',0),(51,'CS','Serbia and Montenegro','Belgrade',0),(52,'CU','Cuba','Havana',0),(53,'CV','Cape Verde','Praia',0),(54,'CX','Christmas Island','Flying Fish Cove',0),(55,'CY','Cyprus','Nicosia',0),(56,'CZ','Czech Republic','Prague',0),(57,'DE','Germany','Berlin',0),(58,'DJ','Djibouti','Djibouti',0),(59,'DK','Denmark','Copenhagen',0),(60,'DM','Dominica','Roseau',0),(61,'DO','Dominican Republic','Santo Domingo',0),(62,'DZ','Algeria','Algiers',0),(63,'EC','Ecuador','Quito',0),(64,'EE','Estonia','Tallinn',0),(65,'EG','Egypt','Cairo',0),(66,'EH','Western Sahara','El-Aaiun',0),(67,'ER','Eritrea','Asmara',0),(68,'ES','Spain','Madrid',0),(69,'ET','Ethiopia','Addis Ababa',0),(70,'FI','Finland','Helsinki',0),(71,'FJ','Fiji','Suva',0),(72,'FK','Falkland Islands','Stanley',0),(73,'FM','Micronesia','Palikir',0),(74,'FO','Faroe Islands','TÃ³rshavn',0),(75,'FR','France','Paris',0),(76,'GA','Gabon','Libreville',0),(77,'GB','United Kingdom','London',0),(78,'GD','Grenada','St. George\'s',0),(79,'GE','Georgia','Tbilisi',0),(80,'GF','French Guiana','Cayenne',0),(81,'GG','Guernsey','St Peter Port',0),(82,'GH','Ghana','Accra',0),(83,'GI','Gibraltar','Gibraltar',0),(84,'GL','Greenland','Nuuk',0),(85,'GM','Gambia','Banjul',0),(86,'GN','Guinea','Conakry',0),(87,'GP','Guadeloupe','Basse-Terre',0),(88,'GQ','Equatorial Guinea','Malabo',0),(89,'GR','Greece','Athens',0),(90,'GS','South Georgia and the South Sandwich Islands','Grytviken',0),(91,'GT','Guatemala','Guatemala City',0),(92,'GU','Guam','HagÃ¥tÃ±a',0),(93,'GW','Guinea-Bissau','Bissau',0),(94,'GY','Guyana','Georgetown',0),(95,'HK','Hong Kong','Hong Kong',0),(96,'HM','Heard Island and McDonald Islands','',0),(97,'HN','Honduras','Tegucigalpa',0),(98,'HR','Croatia','Zagreb',0),(99,'HT','Haiti','Port-au-Prince',0),(100,'HU','Hungary','Budapest',0),(101,'ID','Indonesia','Jakarta',0),(102,'IE','Ireland','Dublin',0),(103,'IL','Israel','Jerusalem',0),(104,'IM','Isle of Man','Douglas, Isle of Man',0),(105,'IN','India','New Delhi',0),(106,'IO','British Indian Ocean Territory','Diego Garcia',0),(107,'IQ','Iraq','Baghdad',0),(108,'IR','Iran','Tehran',0),(109,'IS','Iceland','ReykjavÃ­k',0),(110,'IT','Italy','Rome',0),(111,'JE','Jersey','Saint Helier',0),(112,'JM','Jamaica','Kingston',0),(113,'JO','Jordan','Amman',0),(114,'JP','Japan','Tokyo',0),(115,'KE','Kenya','Nairobi',0),(116,'KG','Kyrgyzstan','Bishkek',0),(117,'KH','Cambodia','Phnom Penh',0),(118,'KI','Kiribati','South Tarawa',0),(119,'KM','Comoros','Moroni',0),(120,'KN','Saint Kitts and Nevis','Basseterre',0),(121,'KP','North Korea','Pyongyang',0),(122,'KR','South Korea','Seoul',0),(123,'KW','Kuwait','Kuwait City',0),(124,'KY','Cayman Islands','George Town',0),(125,'KZ','Kazakhstan','Astana',0),(126,'LA','Laos','Vientiane',0),(127,'LB','Lebanon','Beirut',0),(128,'LC','Saint Lucia','Castries',0),(129,'LI','Liechtenstein','Vaduz',0),(130,'LK','Sri Lanka','Colombo',0),(131,'LR','Liberia','Monrovia',0),(132,'LS','Lesotho','Maseru',0),(133,'LT','Lithuania','Vilnius',0),(134,'LU','Luxembourg','Luxembourg',0),(135,'LV','Latvia','Riga',0),(136,'LY','Libya','Tripolis',0),(137,'MA','Morocco','Rabat',0),(138,'MC','Monaco','Monaco',0),(139,'MD','Moldova','Chi_in_u',0),(140,'ME','Montenegro','Podgorica',0),(141,'MF','Saint Martin','Marigot',0),(142,'MG','Madagascar','Antananarivo',0),(143,'MH','Marshall Islands','Uliga',0),(144,'MK','Macedonia','Skopje',0),(145,'ML','Mali','Bamako',0),(146,'MM','Myanmar','Yangon',0),(147,'MN','Mongolia','Ulan Bator',0),(148,'MO','Macao','Macao',0),(149,'MP','Northern Mariana Islands','Saipan',0),(150,'MQ','Martinique','Fort-de-France',0),(151,'MR','Mauritania','Nouakchott',0),(152,'MS','Montserrat','Plymouth',0),(153,'MT','Malta','Valletta',0),(154,'MU','Mauritius','Port Louis',0),(155,'MV','Maldives','MalÃ©',0),(156,'MW','Malawi','Lilongwe',0),(157,'MX','Mexico','Mexico City',0),(158,'MY','Malaysia','Kuala Lumpur',0),(159,'MZ','Mozambique','Maputo',0),(160,'NA','Namibia','Windhoek',0),(161,'NC','New Caledonia','NoumÃ©a',0),(162,'NE','Niger','Niamey',0),(163,'NF','Norfolk Island','Kingston',0),(164,'NG','Nigeria','Abuja',0),(165,'NI','Nicaragua','Managua',0),(166,'NL','Netherlands','Amsterdam',0),(167,'NO','Norway','Oslo',0),(168,'NP','Nepal','Kathmandu',0),(169,'NR','Nauru','Yaren',0),(170,'NU','Niue','Alofi',0),(171,'NZ','New Zealand','Wellington',0),(172,'OM','Oman','Muscat',0),(173,'PA','Panama','Panama City',0),(174,'PE','Peru','Lima',0),(175,'PF','French Polynesia','Papeete',0),(176,'PG','Papua New Guinea','Port Moresby',0),(177,'PH','Philippines','Manila',0),(178,'PK','Pakistan','Islamabad',0),(179,'PL','Poland','Warsaw',0),(180,'PM','Saint Pierre and Miquelon','Saint-Pierre',0),(181,'PN','Pitcairn','Adamstown',0),(182,'PR','Puerto Rico','San Juan',0),(183,'PS','Palestinian Territory','East Jerusalem',0),(184,'PT','Portugal','Lisbon',0),(185,'PW','Palau','Koror',0),(186,'PY','Paraguay','AsunciÃ³n',0),(187,'QA','Qatar','Doha',0),(188,'RE','Reunion','Saint-Denis',0),(189,'RO','Romania','Bucharest',0),(190,'RS','Serbia','Belgrade',0),(191,'RU','Russia','Moscow',0),(192,'RW','Rwanda','Kigali',0),(193,'SA','Saudi Arabia','Riyadh',0),(194,'SB','Solomon Islands','Honiara',0),(195,'SC','Seychelles','Victoria',0),(196,'SD','Sudan','Khartoum',0),(197,'SE','Sweden','Stockholm',0),(198,'SG','Singapore','Singapur',0),(199,'SH','Saint Helena','Jamestown',0),(200,'SI','Slovenia','Ljubljana',0),(201,'SJ','Svalbard and Jan Mayen','Longyearbyen',0),(202,'SK','Slovakia','Bratislava',0),(203,'SL','Sierra Leone','Freetown',0),(204,'SM','San Marino','San Marino',0),(205,'SN','Senegal','Dakar',0),(206,'SO','Somalia','Mogadishu',0),(207,'SR','Suriname','Paramaribo',0),(208,'ST','Sao Tome and Principe','SÃ£o TomÃ©',0),(209,'SV','El Salvador','San Salvador',0),(210,'SY','Syria','Damascus',0),(211,'SZ','Swaziland','Mbabane',0),(212,'TC','Turks and Caicos Islands','Cockburn Town',0),(213,'TD','Chad','N\'Djamena',0),(214,'TF','French Southern Territories','Martin-de-ViviÃ¨s',0),(215,'TG','Togo','LomÃ©',0),(216,'TH','Thailand','Bangkok',0),(217,'TJ','Tajikistan','Dushanbe',0),(218,'TK','Tokelau','',0),(219,'TL','East Timor','Dili',0),(220,'TM','Turkmenistan','Ashgabat',0),(221,'TN','Tunisia','Tunis',0),(222,'TO','Tonga','Nuku\'alofa',0),(223,'TR','Turkey','Ankara',0),(224,'TT','Trinidad and Tobago','Port of Spain',0),(225,'TV','Tuvalu','Vaiaku',0),(226,'TW','Taiwan','Taipei',0),(227,'TZ','Tanzania','Dar es Salaam',0),(228,'UA','Ukraine','Kiev',0),(229,'UG','Uganda','Kampala',0),(230,'UM','United States Minor Outlying Islands','',0),(231,'US','United States','Washington',0),(232,'UY','Uruguay','Montevideo',0),(233,'UZ','Uzbekistan','Tashkent',0),(234,'VA','Vatican','Vatican City',0),(235,'VC','Saint Vincent and the Grenadines','Kingstown',0),(236,'VE','Venezuela','Caracas',0),(237,'VG','British Virgin Islands','Road Town',0),(238,'VI','U.S. Virgin Islands','Charlotte Amalie',0),(239,'VN','Vietnam','Hanoi',0),(240,'VU','Vanuatu','Port Vila',0),(241,'WF','Wallis and Futuna','MatÃ¢\'Utu',0),(242,'WS','Samoa','Apia',0),(243,'YE','Yemen','Sanâ€˜aâ€™',0),(244,'YT','Mayotte','Mamoudzou',0),(245,'ZA','South Africa','Pretoria',0),(246,'ZM','Zambia','Lusaka',0),(247,'ZW','Zimbabwe','Harare',0);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `externalapp`
--

DROP TABLE IF EXISTS `externalapp`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `externalapp` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Info on external apps(mobile) that work with your deployment';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `externalapp`
--

LOCK TABLES `externalapp` WRITE;
/*!40000 ALTER TABLE `externalapp` DISABLE KEYS */;
INSERT INTO `externalapp` VALUES (1,'iPhone','http://download.ushahidi.com/track_download.php?download=ios'),(2,'Android','http://download.ushahidi.com/track_download.php?download=android');
/*!40000 ALTER TABLE `externalapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feed`
--

DROP TABLE IF EXISTS `feed`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `feed` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `feed_name` varchar(255) default NULL,
  `feed_url` varchar(255) default NULL,
  `feed_cache` text,
  `feed_active` tinyint(4) default '1',
  `feed_update` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Information about RSS Feeds a deployment subscribes to';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `feed`
--

LOCK TABLES `feed` WRITE;
/*!40000 ALTER TABLE `feed` DISABLE KEYS */;
INSERT INTO `feed` VALUES (1,'térképi rss','http://pipes.yahoo.com/pipes/pipe.run?KMLFeedURL=https%3A%2F%2Fmaps.google.com%2Fmaps%2Fms%3Fie%3DUTF8%26authuser%3D0%26msa%3D0%26output%3Dkml%26msid%3D214097956251705172248.0004d7f42a7e1afbb0b36&_id=QAEgr2Oj3BGEQQ7sjUnRlg&_render=rss',NULL,1,1363381324);
/*!40000 ALTER TABLE `feed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feed_item`
--

DROP TABLE IF EXISTS `feed_item`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `feed_item` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `feed_id` int(11) unsigned NOT NULL,
  `location_id` bigint(20) unsigned default '0',
  `incident_id` bigint(20) unsigned NOT NULL default '0',
  `item_title` varchar(255) default NULL,
  `item_description` text,
  `item_link` varchar(255) default NULL,
  `item_date` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `feed_id` (`feed_id`),
  KEY `incident_id` (`incident_id`),
  KEY `location_id` (`location_id`)
) ENGINE=MyISAM AUTO_INCREMENT=401 DEFAULT CHARSET=utf8 COMMENT='Stores feed items pulled from each RSS Feed';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `feed_item`
--

LOCK TABLES `feed_item` WRITE;
/*!40000 ALTER TABLE `feed_item` DISABLE KEYS */;
INSERT INTO `feed_item` VALUES (1,1,5,0,'6 tagú család kocsiban','M1 80-as km-nél 6 tagú család, gyerekek 4-5-8-11 évesek, nem működik az akkumulátor hajnal 1 óta.<br>  A 80-as km nagyon közel van a komáromi leágazáshoz.<br>  Információ és meleg étel ital amire most a leginkább szükségük lenne. Kérek mindenkit, aki tud segítsen.<br>  Bikázó kábel pedig arra az esetre, ha elindulna a forgalom.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(2,1,6,0,'Átmeneti szállás','AUCHAN Székesfehérvár megnyitva.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(3,1,7,0,'M1, 100-as km Gönyü környéke','A 100-as km környékén az M1-en Gönyü környékén hallgatók hívtak minket, hogy derékig ér a hó, a benzin kifogyott és senki nem jár arra, hogy segítsen és esélytelen a mentés. Az autókat hátrahagyva melegedőre lenne szükségük ill akinek van munkagépe   közelítse meg őket és vigyenek forró teát, némi élelmet mert még egy éjszakát nem bírnak ki.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(4,1,8,0,'kávé, tea','Bakonyszentlászlón lakunk szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 06302944634','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(5,1,9,0,'Átmeneti szállás','Enyingi művelődési ház','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(6,1,10,0,'SOS','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(7,1,11,0,'MELEGEDŐ!','Budaörsi Tesco megnyitva! (eredetileg rossz helyen volt a jelzés)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(8,1,12,0,'Lidl parkolóban elakadt Ford','Székesfehérváron a Várpalota felőli bevezető úton a nagy körforgalom melletti Lidl parkolóba rostokol tegnap óta egy (Ford Transit KHG 378-as rendszámú autóban)két jó barátom, kérem, aki ott lakik a közelben legalább egy kis meleg teát vigyen   oda nekik és esetleg némi harapni valót!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(9,1,13,0,'Átmeneti szállás','Gondozási központ - Batthyány utca 134.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(10,1,14,0,'lellei segítség','Traktor beizzítva, ha kell valakinek segítség az utakon Balatonlelle környékén! Bátran hívjon: 20/ 383 57 75!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(11,1,15,0,'Átmeneti szállás',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(12,1,16,0,'bicskei szállás','Vörös Marianna<br>  Bicskén szálassal tudok segíteni a rászorultoknak.Vörös Marianna 06 20 92 88 536','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(13,1,17,0,'Átmeneti szállás','ÁMK Fekete István Általános Iskola és Alapfokú Művészeti Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(14,1,18,0,'64-es út, Enying előtt 30 km.','Észlelőnk segélykérése:<br>  &quot;Valaki segítsen!!! Osszátok meg!! 16 órája várunk, hogy kimentsenek egy 2éves kislányal minket többi 20bajba jutottal! Akárkihez fordulok,nem jönnek segíteni (mentő,rendőrség,tűzoltó,katasztrófavédelem)<br>  64es úton Enying elött kb. 30kmre&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(15,1,19,0,'csór-melegedő','Csór Ifjúsági Ház Csór, Főtér 9. 22/433-109','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(16,1,20,0,'seregélyes-melegedő','Seregélyes Horváth Gáborné (Kis Vendéglő) Széchenyi u. 1. 0622/447-014','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(17,1,21,0,'szabadbattyán-melegedő','Szabadbattyán ÁMK Iskola Szabadbattyán Iskola u 7. 22/363-022','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(18,1,22,0,'Átmeneti szállás','Székesfehérvári Civil Központ (volt Technika Háza)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(19,1,23,0,'fehérvár-melegedők','Székesfehérvár Civil Ház Rákóczi út<br>  Székesfehérvár Kodály Zoltán Isk. Béke tér<br>  Székesfehérvár Teleki Blanka Gimnázium és Általános Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(20,1,24,0,'autómentés','Demeter Zsolt 30/397 81 48','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(21,1,25,0,'sárosd- tűzoltók-','A TELEFONSZÁMUNK: 0630 676 7344 Takács István: &quot;Tisztelt sárosdi lakótársaim ha valaki bajban van bátran hívja a sárosdi önkéntes tűzoltó egyesületet, megyünk és segítünk, mi előbb ki érünk mint Sárbogárd nem beszélve arról ,hogy őnekik van munkájuk   bőven. .HA BAJ VAN SEGÍTÜNK.&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(22,1,26,0,'pécs-szállás','Én menteni nem tudok, mert nincs traktorom:) ,de megszállni megszállhat nálam aki Pécsett ragadt a hó miatt. Pécs-kertváros, 70-2528822 Gyenese Andrea','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(23,1,27,0,'BALATONAKARATTYA segítségre lenne szükség.','Annamária Zsadányi - https://www.facebook.com/zsannamaria<br>  <br>  Én is segítséget szeretnék kérni...<br>  <br>  VALAKI van Balatonakarattyán aki tudna segíteni? Párom ott ragadt tegnap délután óta, nincs nála már sem étel, sem pénz...ha van valaki onnan vagy ismerősötök, tudna segíteni? A MOL kútnál áll, a kocsit nem tudja otthagyni ADR-es. Ha valaki oda tudna menni/vinni   valami ennivalót, némi aprót, vagy bármi módon tudna segíteni nagy segítség lenne, egyenlőre a hírek szerint a mai éjszakát is ott kell tölteni valószínűleg, ez a tegnapi hosszú munkanapra sikerült :-) .Hátha lesz segítőkész jelentkező arról is. KÖSZI előre   is.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(24,1,28,0,'autómentés','30/665 1514','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(25,1,29,0,'autómentés','30/670 1242','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(26,1,30,0,'autómentés','30/348 51 54','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(27,1,31,0,'autómentés','70/538 8077','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(28,1,32,0,'autómentés','20/316 0560','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(29,1,33,0,'Átmeneti szállás','8060 Mór, Táncsics Mihály utca 25<br>  Wekerle Sándor Szabadidőközpont,<br>  06-22/ 407-161, 06-20/ 511-0462','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(30,1,34,0,'Kaposváron ragadtaknak','Ha itt ragadtál, nem mersz vagy nem tudsz továbbmenni, várlak szeretettel otthonomban, meleg tea, ennivaló, alvási, fürdési lehetőség van: 06-70-637-0773 Ági','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(31,1,35,0,'30/6826408 vagy 30/949 3292','Szücs Gáborék 96-os kmnél Győrhöz közel, étel-ital nélkül, tegnap duán óta egy helyben!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(32,1,36,0,'Egy kis család, két pici gyerekkel','KERESNEK TITEKET? DE LEMERÜLT A TELEFON? ÉS NEM TALÁLJÁK A KOCSIT! TEGYETEK KI VALAMI ÉLÉNK RONGYOT A KOCSIRA!  <br>  Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy tud infot a hírekben   elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(33,1,37,0,'Átmeneti szállás','Sziasztok!<br>  <br>  Ha valaki esetleg a Mátrában akadt el, Mátraszentistván környékén, akkor a Mátraszíve apartmanházban meleg teát és ételt biztosítunk minden úton rekedt embernek.  <br>  <br>  Pontos cím és térkép: <br>  <br>  <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">http://www.matraszive.hu/kapcsolat</a><br>  <br>  Telefonszám: &#43;36 20 932 03 34<br>Click <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">here</a> for more information.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(34,1,38,0,'Szállás','Pécs, 3-4 fő elfér, szállás: Kinga Pécsről 30/385-1230','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(35,1,39,0,'TRAKTOROSOK!!!!!!!!','&#43;36-70/5579-770<br>  Közel egy napja veszteglünk a 81 főúton.Mi és<br>  még sokan mások az elakadt kamionok<br>  között.Tegnap mi még tudtunk segíteni árokba<br>  csúszott autósokon,de mára már a<br>  vontatókötelünk is elszakadt és mi is segítségre<br>  szorulunk már.Az autókat betemeti a hó,már<br>  lassan az ajtót sem lehet kinyittani belülről<br>  jegesednek az ablakok is.Itt minden autós<br>  hasonló gondokkal küzd.Néha kimegyek és<br>  körbelapátolom az autót,de reménytelen harc a<br>  hóval. Fehérvárcsurgó és a Bodajki elágazó<br>  között vagyunk mi elakadva .Mellettünk a<br>  mezőn járnak a traktorok,tűzoltóautó,de senki<br>  nem néz ránk,hogy megvagyunk-e még.Pedig az<br>  utasaimat elvihetnék egy közeli<br>  melegedőbe.Több segítséget is próbáltunk<br>  igénybe venni,de csak türelemre intenek<br>  minket. Kérnék mindenkit,akinek itt a környéken<br>  van még nem dolgozó traktoros ismerőse vagy<br>  ha valaki el tudná vinni az utasaimat,bármilyen<br> &hellip;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(36,1,40,0,'Vörösmarty Általános Iskola','Helyiek küldtek be oda ételt és innivalót.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(37,1,41,0,'Ácsi Márk','Hólapátolás, kézi erővel elvégezhető mentés.<br>  &#43; 36 70 326 46 98','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(38,1,42,0,'Ha valaki elakadt!','Ha valaki a hó miatt elvan akadva Esztergom környékén,vagy tud ilyenről hívjon hajnali 2-ig tudok menni segíteni 4x4-es autóval,06204461053 telszám','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(39,1,43,0,'Két gyerekes család, elfogyott élelem','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(40,1,44,0,'Hunyadi utca 45','2462 Martonvásár, Magyarország','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(41,1,45,0,'Graf-Starhemberg-Gasse 47','2-3 főt el tudok szállásolni, ha valakinek közelebb van és / vagy nem tud hazajutni! Meleg tea, enni való van! Pásztor János &#43;36-30-265-6467','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(42,1,46,0,'Segítség!','06 20 5733578<br>  SOS Segítsetek fiaméknak 11 hónapos kisfiúkkal - akik Várpalotán rekedtek - egy kiadó szobát, v. szállást találni éjszakára. Részben a fagyos országúton töltötték az éjszakát majd kivezették őket a 7-es útról és egy enyingi benzinkútnál töltötték az éjszakát.   Onnan ma elvergődtek Várpaloltára, ahonnan nincs tovább!!!! De nincs sehol egy kiadó szoba és a telefonjaik lemerülőben. Így, engem értesítsetek, ha lenne valaki befogadná őket, míg szükséges. Megfizetnék, csak végre a kicsi fiúkat rendbe tudnák tenni!!!<br>  06 20 5733578','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(43,1,47,0,'Szállás és étel 2-4 fő részére Székesfehérváron','2-4 fő részére átmeneti szállást és meleg ételt tudunk biztosítani.<br>  <br>  Kontakt:<br>  Zsida Ágoston<br>  Székesfehérvár, Szent Gellért utca 105/A<br>  Telefon: 30/756-4885','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(44,1,48,0,'Hajléktalanok Éjjeli Menedékhelye és Nappali Melegedő',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(45,1,49,0,'Fáklya utca','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával&nbsp;és   szendviccsel várjuk a szélsőséges időjárás miatt bajba kerülteket!&nbsp;<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(46,1,50,0,'szoba, tea, szendvics','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával és szendviccsel várják a szélsőséges időjárás miatt bajba kerülteket!<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(47,1,51,0,'kávé, tea','Érd M7 lejáratnál teát, kávét mi is tudunk felajánlani otthonunkban. 203157093','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(48,1,52,0,'szendvics, tea, víz','Szendviccsel, teával, friss vízzel, petpalackkal... amivel csak tudok hozzájárulok a segítséghez, ha valaki megy ki az autópályára, vagy a közelben van (M1, ménfőcsanaki lehajtó). Autós telefontöltőt is tudok   felajánlani, ha valaki lemerült volna! 30-515-15-87','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(49,1,53,0,'Placemark 49','Balatonfüred, szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 063036567','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(50,1,54,0,'Golgota Teológiai Főiskola',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:39'),(51,1,55,0,'6 tagú család kocsiban','M1 80-as km-nél 6 tagú család, gyerekek 4-5-8-11 évesek, nem működik az akkumulátor hajnal 1 óta.<br>  A 80-as km nagyon közel van a komáromi leágazáshoz.<br>  Információ és meleg étel ital amire most a leginkább szükségük lenne. Kérek mindenkit, aki tud segítsen.<br>  Bikázó kábel pedig arra az esetre, ha elindulna a forgalom.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(52,1,56,0,'Átmeneti szállás','AUCHAN Székesfehérvár megnyitva.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(53,1,57,0,'M1, 100-as km Gönyü környéke','A 100-as km környékén az M1-en Gönyü környékén hallgatók hívtak minket, hogy derékig ér a hó, a benzin kifogyott és senki nem jár arra, hogy segítsen és esélytelen a mentés. Az autókat hátrahagyva melegedőre lenne szükségük ill akinek van munkagépe   közelítse meg őket és vigyenek forró teát, némi élelmet mert még egy éjszakát nem bírnak ki.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(54,1,58,0,'kávé, tea','Bakonyszentlászlón lakunk szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 06302944634','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(55,1,59,0,'Átmeneti szállás','Enyingi művelődési ház','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(56,1,60,0,'SOS','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(57,1,61,0,'MELEGEDŐ!','Budaörsi Tesco megnyitva! (eredetileg rossz helyen volt a jelzés)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(58,1,62,0,'Lidl parkolóban elakadt Ford','Székesfehérváron a Várpalota felőli bevezető úton a nagy körforgalom melletti Lidl parkolóba rostokol tegnap óta egy (Ford Transit KHG 378-as rendszámú autóban)két jó barátom, kérem, aki ott lakik a közelben legalább egy kis meleg teát vigyen   oda nekik és esetleg némi harapni valót!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(59,1,63,0,'Átmeneti szállás','Gondozási központ - Batthyány utca 134.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(60,1,64,0,'lellei segítség','Traktor beizzítva, ha kell valakinek segítség az utakon Balatonlelle környékén! Bátran hívjon: 20/ 383 57 75!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(61,1,65,0,'Átmeneti szállás',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(62,1,66,0,'bicskei szállás','Vörös Marianna<br>  Bicskén szálassal tudok segíteni a rászorultoknak.Vörös Marianna 06 20 92 88 536','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(63,1,67,0,'Átmeneti szállás','ÁMK Fekete István Általános Iskola és Alapfokú Művészeti Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(64,1,68,0,'64-es út, Enying előtt 30 km.','Észlelőnk segélykérése:<br>  &quot;Valaki segítsen!!! Osszátok meg!! 16 órája várunk, hogy kimentsenek egy 2éves kislányal minket többi 20bajba jutottal! Akárkihez fordulok,nem jönnek segíteni (mentő,rendőrség,tűzoltó,katasztrófavédelem)<br>  64es úton Enying elött kb. 30kmre&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(65,1,69,0,'csór-melegedő','Csór Ifjúsági Ház Csór, Főtér 9. 22/433-109','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(66,1,70,0,'seregélyes-melegedő','Seregélyes Horváth Gáborné (Kis Vendéglő) Széchenyi u. 1. 0622/447-014','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(67,1,71,0,'szabadbattyán-melegedő','Szabadbattyán ÁMK Iskola Szabadbattyán Iskola u 7. 22/363-022','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(68,1,72,0,'Átmeneti szállás','Székesfehérvári Civil Központ (volt Technika Háza)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(69,1,73,0,'fehérvár-melegedők','Székesfehérvár Civil Ház Rákóczi út<br>  Székesfehérvár Kodály Zoltán Isk. Béke tér<br>  Székesfehérvár Teleki Blanka Gimnázium és Általános Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(70,1,74,0,'autómentés','Demeter Zsolt 30/397 81 48','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(71,1,75,0,'sárosd- tűzoltók-','A TELEFONSZÁMUNK: 0630 676 7344 Takács István: &quot;Tisztelt sárosdi lakótársaim ha valaki bajban van bátran hívja a sárosdi önkéntes tűzoltó egyesületet, megyünk és segítünk, mi előbb ki érünk mint Sárbogárd nem beszélve arról ,hogy őnekik van munkájuk   bőven. .HA BAJ VAN SEGÍTÜNK.&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(72,1,76,0,'pécs-szállás','Én menteni nem tudok, mert nincs traktorom:) ,de megszállni megszállhat nálam aki Pécsett ragadt a hó miatt. Pécs-kertváros, 70-2528822 Gyenese Andrea','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(73,1,77,0,'BALATONAKARATTYA segítségre lenne szükség.','Annamária Zsadányi - https://www.facebook.com/zsannamaria<br>  <br>  Én is segítséget szeretnék kérni...<br>  <br>  VALAKI van Balatonakarattyán aki tudna segíteni? Párom ott ragadt tegnap délután óta, nincs nála már sem étel, sem pénz...ha van valaki onnan vagy ismerősötök, tudna segíteni? A MOL kútnál áll, a kocsit nem tudja otthagyni ADR-es. Ha valaki oda tudna menni/vinni   valami ennivalót, némi aprót, vagy bármi módon tudna segíteni nagy segítség lenne, egyenlőre a hírek szerint a mai éjszakát is ott kell tölteni valószínűleg, ez a tegnapi hosszú munkanapra sikerült :-) .Hátha lesz segítőkész jelentkező arról is. KÖSZI előre   is.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(74,1,78,0,'autómentés','30/665 1514','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(75,1,79,0,'autómentés','30/670 1242','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(76,1,80,0,'autómentés','30/348 51 54','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(77,1,81,0,'autómentés','70/538 8077','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(78,1,82,0,'autómentés','20/316 0560','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(79,1,83,0,'Átmeneti szállás','8060 Mór, Táncsics Mihály utca 25<br>  Wekerle Sándor Szabadidőközpont,<br>  06-22/ 407-161, 06-20/ 511-0462','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(80,1,84,0,'Kaposváron ragadtaknak','Ha itt ragadtál, nem mersz vagy nem tudsz továbbmenni, várlak szeretettel otthonomban, meleg tea, ennivaló, alvási, fürdési lehetőség van: 06-70-637-0773 Ági','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(81,1,85,0,'30/6826408 vagy 30/949 3292','Szücs Gáborék 96-os kmnél Győrhöz közel, étel-ital nélkül, tegnap duán óta egy helyben!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(82,1,86,0,'Egy kis család, két pici gyerekkel','KERESNEK TITEKET? DE LEMERÜLT A TELEFON? ÉS NEM TALÁLJÁK A KOCSIT! TEGYETEK KI VALAMI ÉLÉNK RONGYOT A KOCSIRA!  <br>  Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy tud infot a hírekben   elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(83,1,87,0,'Átmeneti szállás','Sziasztok!<br>  <br>  Ha valaki esetleg a Mátrában akadt el, Mátraszentistván környékén, akkor a Mátraszíve apartmanházban meleg teát és ételt biztosítunk minden úton rekedt embernek.  <br>  <br>  Pontos cím és térkép: <br>  <br>  <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">http://www.matraszive.hu/kapcsolat</a><br>  <br>  Telefonszám: &#43;36 20 932 03 34<br>Click <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">here</a> for more information.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(84,1,88,0,'Szállás','Pécs, 3-4 fő elfér, szállás: Kinga Pécsről 30/385-1230','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(85,1,89,0,'TRAKTOROSOK!!!!!!!!','&#43;36-70/5579-770<br>  Közel egy napja veszteglünk a 81 főúton.Mi és<br>  még sokan mások az elakadt kamionok<br>  között.Tegnap mi még tudtunk segíteni árokba<br>  csúszott autósokon,de mára már a<br>  vontatókötelünk is elszakadt és mi is segítségre<br>  szorulunk már.Az autókat betemeti a hó,már<br>  lassan az ajtót sem lehet kinyittani belülről<br>  jegesednek az ablakok is.Itt minden autós<br>  hasonló gondokkal küzd.Néha kimegyek és<br>  körbelapátolom az autót,de reménytelen harc a<br>  hóval. Fehérvárcsurgó és a Bodajki elágazó<br>  között vagyunk mi elakadva .Mellettünk a<br>  mezőn járnak a traktorok,tűzoltóautó,de senki<br>  nem néz ránk,hogy megvagyunk-e még.Pedig az<br>  utasaimat elvihetnék egy közeli<br>  melegedőbe.Több segítséget is próbáltunk<br>  igénybe venni,de csak türelemre intenek<br>  minket. Kérnék mindenkit,akinek itt a környéken<br>  van még nem dolgozó traktoros ismerőse vagy<br>  ha valaki el tudná vinni az utasaimat,bármilyen<br> &hellip;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(86,1,90,0,'Vörösmarty Általános Iskola','Helyiek küldtek be oda ételt és innivalót.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(87,1,91,0,'Ácsi Márk','Hólapátolás, kézi erővel elvégezhető mentés.<br>  &#43; 36 70 326 46 98','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(88,1,92,0,'Ha valaki elakadt!','Ha valaki a hó miatt elvan akadva Esztergom környékén,vagy tud ilyenről hívjon hajnali 2-ig tudok menni segíteni 4x4-es autóval,06204461053 telszám','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(89,1,93,0,'Két gyerekes család, elfogyott élelem','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(90,1,94,0,'Hunyadi utca 45','2462 Martonvásár, Magyarország','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(91,1,95,0,'Graf-Starhemberg-Gasse 47','2-3 főt el tudok szállásolni, ha valakinek közelebb van és / vagy nem tud hazajutni! Meleg tea, enni való van! Pásztor János &#43;36-30-265-6467','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(92,1,96,0,'Segítség!','06 20 5733578<br>  SOS Segítsetek fiaméknak 11 hónapos kisfiúkkal - akik Várpalotán rekedtek - egy kiadó szobát, v. szállást találni éjszakára. Részben a fagyos országúton töltötték az éjszakát majd kivezették őket a 7-es útról és egy enyingi benzinkútnál töltötték az éjszakát.   Onnan ma elvergődtek Várpaloltára, ahonnan nincs tovább!!!! De nincs sehol egy kiadó szoba és a telefonjaik lemerülőben. Így, engem értesítsetek, ha lenne valaki befogadná őket, míg szükséges. Megfizetnék, csak végre a kicsi fiúkat rendbe tudnák tenni!!!<br>  06 20 5733578','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(93,1,97,0,'Szállás és étel 2-4 fő részére Székesfehérváron','2-4 fő részére átmeneti szállást és meleg ételt tudunk biztosítani.<br>  <br>  Kontakt:<br>  Zsida Ágoston<br>  Székesfehérvár, Szent Gellért utca 105/A<br>  Telefon: 30/756-4885','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(94,1,98,0,'Hajléktalanok Éjjeli Menedékhelye és Nappali Melegedő',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(95,1,99,0,'Fáklya utca','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával&nbsp;és   szendviccsel várjuk a szélsőséges időjárás miatt bajba kerülteket!&nbsp;<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(96,1,100,0,'szoba, tea, szendvics','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával és szendviccsel várják a szélsőséges időjárás miatt bajba kerülteket!<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(97,1,101,0,'kávé, tea','Érd M7 lejáratnál teát, kávét mi is tudunk felajánlani otthonunkban. 203157093','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(98,1,102,0,'szendvics, tea, víz','Szendviccsel, teával, friss vízzel, petpalackkal... amivel csak tudok hozzájárulok a segítséghez, ha valaki megy ki az autópályára, vagy a közelben van (M1, ménfőcsanaki lehajtó). Autós telefontöltőt is tudok   felajánlani, ha valaki lemerült volna! 30-515-15-87','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(99,1,103,0,'Placemark 49','Balatonfüred, szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 063036567','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(100,1,104,0,'Golgota Teológiai Főiskola',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:00:42'),(101,1,105,0,'6 tagú család kocsiban','M1 80-as km-nél 6 tagú család, gyerekek 4-5-8-11 évesek, nem működik az akkumulátor hajnal 1 óta.<br>  A 80-as km nagyon közel van a komáromi leágazáshoz.<br>  Információ és meleg étel ital amire most a leginkább szükségük lenne. Kérek mindenkit, aki tud segítsen.<br>  Bikázó kábel pedig arra az esetre, ha elindulna a forgalom.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(102,1,106,0,'Átmeneti szállás','AUCHAN Székesfehérvár megnyitva.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(103,1,107,0,'M1, 100-as km Gönyü környéke','A 100-as km környékén az M1-en Gönyü környékén hallgatók hívtak minket, hogy derékig ér a hó, a benzin kifogyott és senki nem jár arra, hogy segítsen és esélytelen a mentés. Az autókat hátrahagyva melegedőre lenne szükségük ill akinek van munkagépe   közelítse meg őket és vigyenek forró teát, némi élelmet mert még egy éjszakát nem bírnak ki.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(104,1,108,0,'kávé, tea','Bakonyszentlászlón lakunk szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 06302944634','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(105,1,109,0,'Átmeneti szállás','Enyingi művelődési ház','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(106,1,110,0,'SOS','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(107,1,111,0,'MELEGEDŐ!','Budaörsi Tesco megnyitva! (eredetileg rossz helyen volt a jelzés)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(108,1,112,0,'Lidl parkolóban elakadt Ford','Székesfehérváron a Várpalota felőli bevezető úton a nagy körforgalom melletti Lidl parkolóba rostokol tegnap óta egy (Ford Transit KHG 378-as rendszámú autóban)két jó barátom, kérem, aki ott lakik a közelben legalább egy kis meleg teát vigyen   oda nekik és esetleg némi harapni valót!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(109,1,113,0,'Átmeneti szállás','Gondozási központ - Batthyány utca 134.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(110,1,114,0,'lellei segítség','Traktor beizzítva, ha kell valakinek segítség az utakon Balatonlelle környékén! Bátran hívjon: 20/ 383 57 75!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(111,1,115,0,'Átmeneti szállás',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(112,1,116,0,'bicskei szállás','Vörös Marianna<br>  Bicskén szálassal tudok segíteni a rászorultoknak.Vörös Marianna 06 20 92 88 536','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(113,1,117,0,'Átmeneti szállás','ÁMK Fekete István Általános Iskola és Alapfokú Művészeti Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(114,1,118,0,'64-es út, Enying előtt 30 km.','Észlelőnk segélykérése:<br>  &quot;Valaki segítsen!!! Osszátok meg!! 16 órája várunk, hogy kimentsenek egy 2éves kislányal minket többi 20bajba jutottal! Akárkihez fordulok,nem jönnek segíteni (mentő,rendőrség,tűzoltó,katasztrófavédelem)<br>  64es úton Enying elött kb. 30kmre&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(115,1,119,0,'csór-melegedő','Csór Ifjúsági Ház Csór, Főtér 9. 22/433-109','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(116,1,120,0,'seregélyes-melegedő','Seregélyes Horváth Gáborné (Kis Vendéglő) Széchenyi u. 1. 0622/447-014','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(117,1,121,0,'szabadbattyán-melegedő','Szabadbattyán ÁMK Iskola Szabadbattyán Iskola u 7. 22/363-022','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(118,1,122,0,'Átmeneti szállás','Székesfehérvári Civil Központ (volt Technika Háza)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(119,1,123,0,'fehérvár-melegedők','Székesfehérvár Civil Ház Rákóczi út<br>  Székesfehérvár Kodály Zoltán Isk. Béke tér<br>  Székesfehérvár Teleki Blanka Gimnázium és Általános Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(120,1,124,0,'autómentés','Demeter Zsolt 30/397 81 48','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(121,1,125,0,'sárosd- tűzoltók-','A TELEFONSZÁMUNK: 0630 676 7344 Takács István: &quot;Tisztelt sárosdi lakótársaim ha valaki bajban van bátran hívja a sárosdi önkéntes tűzoltó egyesületet, megyünk és segítünk, mi előbb ki érünk mint Sárbogárd nem beszélve arról ,hogy őnekik van munkájuk   bőven. .HA BAJ VAN SEGÍTÜNK.&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(122,1,126,0,'pécs-szállás','Én menteni nem tudok, mert nincs traktorom:) ,de megszállni megszállhat nálam aki Pécsett ragadt a hó miatt. Pécs-kertváros, 70-2528822 Gyenese Andrea','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(123,1,127,0,'BALATONAKARATTYA segítségre lenne szükség.','Annamária Zsadányi - https://www.facebook.com/zsannamaria<br>  <br>  Én is segítséget szeretnék kérni...<br>  <br>  VALAKI van Balatonakarattyán aki tudna segíteni? Párom ott ragadt tegnap délután óta, nincs nála már sem étel, sem pénz...ha van valaki onnan vagy ismerősötök, tudna segíteni? A MOL kútnál áll, a kocsit nem tudja otthagyni ADR-es. Ha valaki oda tudna menni/vinni   valami ennivalót, némi aprót, vagy bármi módon tudna segíteni nagy segítség lenne, egyenlőre a hírek szerint a mai éjszakát is ott kell tölteni valószínűleg, ez a tegnapi hosszú munkanapra sikerült :-) .Hátha lesz segítőkész jelentkező arról is. KÖSZI előre   is.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(124,1,128,0,'autómentés','30/665 1514','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(125,1,129,0,'autómentés','30/670 1242','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(126,1,130,0,'autómentés','30/348 51 54','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(127,1,131,0,'autómentés','70/538 8077','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(128,1,132,0,'autómentés','20/316 0560','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(129,1,133,0,'Átmeneti szállás','8060 Mór, Táncsics Mihály utca 25<br>  Wekerle Sándor Szabadidőközpont,<br>  06-22/ 407-161, 06-20/ 511-0462','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(130,1,134,0,'Kaposváron ragadtaknak','Ha itt ragadtál, nem mersz vagy nem tudsz továbbmenni, várlak szeretettel otthonomban, meleg tea, ennivaló, alvási, fürdési lehetőség van: 06-70-637-0773 Ági','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(131,1,135,0,'30/6826408 vagy 30/949 3292','Szücs Gáborék 96-os kmnél Győrhöz közel, étel-ital nélkül, tegnap duán óta egy helyben!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:04'),(132,1,136,0,'Egy kis család, két pici gyerekkel','KERESNEK TITEKET? DE LEMERÜLT A TELEFON? ÉS NEM TALÁLJÁK A KOCSIT! TEGYETEK KI VALAMI ÉLÉNK RONGYOT A KOCSIRA!  <br>  Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy tud infot a hírekben   elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(133,1,137,0,'Átmeneti szállás','Sziasztok!<br>  <br>  Ha valaki esetleg a Mátrában akadt el, Mátraszentistván környékén, akkor a Mátraszíve apartmanházban meleg teát és ételt biztosítunk minden úton rekedt embernek.  <br>  <br>  Pontos cím és térkép: <br>  <br>  <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">http://www.matraszive.hu/kapcsolat</a><br>  <br>  Telefonszám: &#43;36 20 932 03 34<br>Click <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">here</a> for more information.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(134,1,138,0,'Szállás','Pécs, 3-4 fő elfér, szállás: Kinga Pécsről 30/385-1230','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(135,1,139,0,'TRAKTOROSOK!!!!!!!!','&#43;36-70/5579-770<br>  Közel egy napja veszteglünk a 81 főúton.Mi és<br>  még sokan mások az elakadt kamionok<br>  között.Tegnap mi még tudtunk segíteni árokba<br>  csúszott autósokon,de mára már a<br>  vontatókötelünk is elszakadt és mi is segítségre<br>  szorulunk már.Az autókat betemeti a hó,már<br>  lassan az ajtót sem lehet kinyittani belülről<br>  jegesednek az ablakok is.Itt minden autós<br>  hasonló gondokkal küzd.Néha kimegyek és<br>  körbelapátolom az autót,de reménytelen harc a<br>  hóval. Fehérvárcsurgó és a Bodajki elágazó<br>  között vagyunk mi elakadva .Mellettünk a<br>  mezőn járnak a traktorok,tűzoltóautó,de senki<br>  nem néz ránk,hogy megvagyunk-e még.Pedig az<br>  utasaimat elvihetnék egy közeli<br>  melegedőbe.Több segítséget is próbáltunk<br>  igénybe venni,de csak türelemre intenek<br>  minket. Kérnék mindenkit,akinek itt a környéken<br>  van még nem dolgozó traktoros ismerőse vagy<br>  ha valaki el tudná vinni az utasaimat,bármilyen<br> &hellip;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(136,1,140,0,'Vörösmarty Általános Iskola','Helyiek küldtek be oda ételt és innivalót.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(137,1,141,0,'Ácsi Márk','Hólapátolás, kézi erővel elvégezhető mentés.<br>  &#43; 36 70 326 46 98','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(138,1,142,0,'Ha valaki elakadt!','Ha valaki a hó miatt elvan akadva Esztergom környékén,vagy tud ilyenről hívjon hajnali 2-ig tudok menni segíteni 4x4-es autóval,06204461053 telszám','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(139,1,143,0,'Két gyerekes család, elfogyott élelem','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(140,1,144,0,'Hunyadi utca 45','2462 Martonvásár, Magyarország','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(141,1,145,0,'Graf-Starhemberg-Gasse 47','2-3 főt el tudok szállásolni, ha valakinek közelebb van és / vagy nem tud hazajutni! Meleg tea, enni való van! Pásztor János &#43;36-30-265-6467','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(142,1,146,0,'Segítség!','06 20 5733578<br>  SOS Segítsetek fiaméknak 11 hónapos kisfiúkkal - akik Várpalotán rekedtek - egy kiadó szobát, v. szállást találni éjszakára. Részben a fagyos országúton töltötték az éjszakát majd kivezették őket a 7-es útról és egy enyingi benzinkútnál töltötték az éjszakát.   Onnan ma elvergődtek Várpaloltára, ahonnan nincs tovább!!!! De nincs sehol egy kiadó szoba és a telefonjaik lemerülőben. Így, engem értesítsetek, ha lenne valaki befogadná őket, míg szükséges. Megfizetnék, csak végre a kicsi fiúkat rendbe tudnák tenni!!!<br>  06 20 5733578','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(143,1,147,0,'Szállás és étel 2-4 fő részére Székesfehérváron','2-4 fő részére átmeneti szállást és meleg ételt tudunk biztosítani.<br>  <br>  Kontakt:<br>  Zsida Ágoston<br>  Székesfehérvár, Szent Gellért utca 105/A<br>  Telefon: 30/756-4885','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(144,1,148,0,'Hajléktalanok Éjjeli Menedékhelye és Nappali Melegedő',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(145,1,149,0,'Fáklya utca','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával&nbsp;és   szendviccsel várjuk a szélsőséges időjárás miatt bajba kerülteket!&nbsp;<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(146,1,150,0,'szoba, tea, szendvics','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával és szendviccsel várják a szélsőséges időjárás miatt bajba kerülteket!<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(147,1,151,0,'kávé, tea','Érd M7 lejáratnál teát, kávét mi is tudunk felajánlani otthonunkban. 203157093','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(148,1,152,0,'szendvics, tea, víz','Szendviccsel, teával, friss vízzel, petpalackkal... amivel csak tudok hozzájárulok a segítséghez, ha valaki megy ki az autópályára, vagy a közelben van (M1, ménfőcsanaki lehajtó). Autós telefontöltőt is tudok   felajánlani, ha valaki lemerült volna! 30-515-15-87','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(149,1,153,0,'Placemark 49','Balatonfüred, szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 063036567','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(150,1,154,0,'Golgota Teológiai Főiskola',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 19:01:05'),(151,1,155,0,'6 tagú család kocsiban','M1 80-as km-nél 6 tagú család, gyerekek 4-5-8-11 évesek, nem működik az akkumulátor hajnal 1 óta.<br>  A 80-as km nagyon közel van a komáromi leágazáshoz.<br>  Információ és meleg étel ital amire most a leginkább szükségük lenne. Kérek mindenkit, aki tud segítsen.<br>  Bikázó kábel pedig arra az esetre, ha elindulna a forgalom.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(152,1,156,0,'Átmeneti szállás','AUCHAN Székesfehérvár megnyitva.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(153,1,157,0,'M1, 100-as km Gönyü környéke','A 100-as km környékén az M1-en Gönyü környékén hallgatók hívtak minket, hogy derékig ér a hó, a benzin kifogyott és senki nem jár arra, hogy segítsen és esélytelen a mentés. Az autókat hátrahagyva melegedőre lenne szükségük ill akinek van munkagépe   közelítse meg őket és vigyenek forró teát, némi élelmet mert még egy éjszakát nem bírnak ki.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(154,1,158,0,'kávé, tea','Bakonyszentlászlón lakunk szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 06302944634','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(155,1,159,0,'Átmeneti szállás','Enyingi művelődési ház','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(156,1,160,0,'SOS','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(157,1,161,0,'MELEGEDŐ!','Budaörsi Tesco megnyitva! (eredetileg rossz helyen volt a jelzés)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(158,1,162,0,'Lidl parkolóban elakadt Ford','Székesfehérváron a Várpalota felőli bevezető úton a nagy körforgalom melletti Lidl parkolóba rostokol tegnap óta egy (Ford Transit KHG 378-as rendszámú autóban)két jó barátom, kérem, aki ott lakik a közelben legalább egy kis meleg teát vigyen   oda nekik és esetleg némi harapni valót!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(159,1,163,0,'Átmeneti szállás','Gondozási központ - Batthyány utca 134.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(160,1,164,0,'lellei segítség','Traktor beizzítva, ha kell valakinek segítség az utakon Balatonlelle környékén! Bátran hívjon: 20/ 383 57 75!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(161,1,165,0,'Átmeneti szállás',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(162,1,166,0,'bicskei szállás','Vörös Marianna<br>  Bicskén szálassal tudok segíteni a rászorultoknak.Vörös Marianna 06 20 92 88 536','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(163,1,167,0,'Átmeneti szállás','ÁMK Fekete István Általános Iskola és Alapfokú Művészeti Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(164,1,168,0,'64-es út, Enying előtt 30 km.','Észlelőnk segélykérése:<br>  &quot;Valaki segítsen!!! Osszátok meg!! 16 órája várunk, hogy kimentsenek egy 2éves kislányal minket többi 20bajba jutottal! Akárkihez fordulok,nem jönnek segíteni (mentő,rendőrség,tűzoltó,katasztrófavédelem)<br>  64es úton Enying elött kb. 30kmre&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(165,1,169,0,'csór-melegedő','Csór Ifjúsági Ház Csór, Főtér 9. 22/433-109','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(166,1,170,0,'seregélyes-melegedő','Seregélyes Horváth Gáborné (Kis Vendéglő) Széchenyi u. 1. 0622/447-014','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(167,1,171,0,'szabadbattyán-melegedő','Szabadbattyán ÁMK Iskola Szabadbattyán Iskola u 7. 22/363-022','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(168,1,172,0,'Átmeneti szállás','Székesfehérvári Civil Központ (volt Technika Háza)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(169,1,173,0,'fehérvár-melegedők','Székesfehérvár Civil Ház Rákóczi út<br>  Székesfehérvár Kodály Zoltán Isk. Béke tér<br>  Székesfehérvár Teleki Blanka Gimnázium és Általános Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(170,1,174,0,'autómentés','Demeter Zsolt 30/397 81 48','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(171,1,175,0,'sárosd- tűzoltók-','A TELEFONSZÁMUNK: 0630 676 7344 Takács István: &quot;Tisztelt sárosdi lakótársaim ha valaki bajban van bátran hívja a sárosdi önkéntes tűzoltó egyesületet, megyünk és segítünk, mi előbb ki érünk mint Sárbogárd nem beszélve arról ,hogy őnekik van munkájuk   bőven. .HA BAJ VAN SEGÍTÜNK.&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(172,1,176,0,'pécs-szállás','Én menteni nem tudok, mert nincs traktorom:) ,de megszállni megszállhat nálam aki Pécsett ragadt a hó miatt. Pécs-kertváros, 70-2528822 Gyenese Andrea','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(173,1,177,0,'BALATONAKARATTYA segítségre lenne szükség.','Annamária Zsadányi - https://www.facebook.com/zsannamaria<br>  <br>  Én is segítséget szeretnék kérni...<br>  <br>  VALAKI van Balatonakarattyán aki tudna segíteni? Párom ott ragadt tegnap délután óta, nincs nála már sem étel, sem pénz...ha van valaki onnan vagy ismerősötök, tudna segíteni? A MOL kútnál áll, a kocsit nem tudja otthagyni ADR-es. Ha valaki oda tudna menni/vinni   valami ennivalót, némi aprót, vagy bármi módon tudna segíteni nagy segítség lenne, egyenlőre a hírek szerint a mai éjszakát is ott kell tölteni valószínűleg, ez a tegnapi hosszú munkanapra sikerült :-) .Hátha lesz segítőkész jelentkező arról is. KÖSZI előre   is.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(174,1,178,0,'autómentés','30/665 1514','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(175,1,179,0,'autómentés','30/670 1242','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(176,1,180,0,'autómentés','30/348 51 54','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(177,1,181,0,'autómentés','70/538 8077','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(178,1,182,0,'autómentés','20/316 0560','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(179,1,183,0,'Átmeneti szállás','8060 Mór, Táncsics Mihály utca 25<br>  Wekerle Sándor Szabadidőközpont,<br>  06-22/ 407-161, 06-20/ 511-0462','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(180,1,184,0,'Kaposváron ragadtaknak','Ha itt ragadtál, nem mersz vagy nem tudsz továbbmenni, várlak szeretettel otthonomban, meleg tea, ennivaló, alvási, fürdési lehetőség van: 06-70-637-0773 Ági','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(181,1,185,0,'30/6826408 vagy 30/949 3292','Szücs Gáborék 96-os kmnél Győrhöz közel, étel-ital nélkül, tegnap duán óta egy helyben!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(182,1,186,0,'Egy kis család, két pici gyerekkel','KERESNEK TITEKET? DE LEMERÜLT A TELEFON? ÉS NEM TALÁLJÁK A KOCSIT! TEGYETEK KI VALAMI ÉLÉNK RONGYOT A KOCSIRA!  <br>  Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy tud infot a hírekben   elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(183,1,187,0,'Átmeneti szállás','Sziasztok!<br>  <br>  Ha valaki esetleg a Mátrában akadt el, Mátraszentistván környékén, akkor a Mátraszíve apartmanházban meleg teát és ételt biztosítunk minden úton rekedt embernek.  <br>  <br>  Pontos cím és térkép: <br>  <br>  <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">http://www.matraszive.hu/kapcsolat</a><br>  <br>  Telefonszám: &#43;36 20 932 03 34<br>Click <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">here</a> for more information.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(184,1,188,0,'Szállás','Pécs, 3-4 fő elfér, szállás: Kinga Pécsről 30/385-1230','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(185,1,189,0,'TRAKTOROSOK!!!!!!!!','&#43;36-70/5579-770<br>  Közel egy napja veszteglünk a 81 főúton.Mi és<br>  még sokan mások az elakadt kamionok<br>  között.Tegnap mi még tudtunk segíteni árokba<br>  csúszott autósokon,de mára már a<br>  vontatókötelünk is elszakadt és mi is segítségre<br>  szorulunk már.Az autókat betemeti a hó,már<br>  lassan az ajtót sem lehet kinyittani belülről<br>  jegesednek az ablakok is.Itt minden autós<br>  hasonló gondokkal küzd.Néha kimegyek és<br>  körbelapátolom az autót,de reménytelen harc a<br>  hóval. Fehérvárcsurgó és a Bodajki elágazó<br>  között vagyunk mi elakadva .Mellettünk a<br>  mezőn járnak a traktorok,tűzoltóautó,de senki<br>  nem néz ránk,hogy megvagyunk-e még.Pedig az<br>  utasaimat elvihetnék egy közeli<br>  melegedőbe.Több segítséget is próbáltunk<br>  igénybe venni,de csak türelemre intenek<br>  minket. Kérnék mindenkit,akinek itt a környéken<br>  van még nem dolgozó traktoros ismerőse vagy<br>  ha valaki el tudná vinni az utasaimat,bármilyen<br> &hellip;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(186,1,190,0,'Vörösmarty Általános Iskola','Helyiek küldtek be oda ételt és innivalót.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(187,1,191,0,'Ácsi Márk','Hólapátolás, kézi erővel elvégezhető mentés.<br>  &#43; 36 70 326 46 98','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(188,1,192,0,'Ha valaki elakadt!','Ha valaki a hó miatt elvan akadva Esztergom környékén,vagy tud ilyenről hívjon hajnali 2-ig tudok menni segíteni 4x4-es autóval,06204461053 telszám','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(189,1,193,0,'Két gyerekes család, elfogyott élelem','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(190,1,194,0,'Hunyadi utca 45','2462 Martonvásár, Magyarország','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(191,1,195,0,'Graf-Starhemberg-Gasse 47','2-3 főt el tudok szállásolni, ha valakinek közelebb van és / vagy nem tud hazajutni! Meleg tea, enni való van! Pásztor János &#43;36-30-265-6467','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(192,1,196,0,'Segítség!','06 20 5733578<br>  SOS Segítsetek fiaméknak 11 hónapos kisfiúkkal - akik Várpalotán rekedtek - egy kiadó szobát, v. szállást találni éjszakára. Részben a fagyos országúton töltötték az éjszakát majd kivezették őket a 7-es útról és egy enyingi benzinkútnál töltötték az éjszakát.   Onnan ma elvergődtek Várpaloltára, ahonnan nincs tovább!!!! De nincs sehol egy kiadó szoba és a telefonjaik lemerülőben. Így, engem értesítsetek, ha lenne valaki befogadná őket, míg szükséges. Megfizetnék, csak végre a kicsi fiúkat rendbe tudnák tenni!!!<br>  06 20 5733578','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(193,1,197,0,'Szállás és étel 2-4 fő részére Székesfehérváron','2-4 fő részére átmeneti szállást és meleg ételt tudunk biztosítani.<br>  <br>  Kontakt:<br>  Zsida Ágoston<br>  Székesfehérvár, Szent Gellért utca 105/A<br>  Telefon: 30/756-4885','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(194,1,198,0,'Hajléktalanok Éjjeli Menedékhelye és Nappali Melegedő',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(195,1,199,0,'Fáklya utca','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával&nbsp;és   szendviccsel várjuk a szélsőséges időjárás miatt bajba kerülteket!&nbsp;<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(196,1,200,0,'szoba, tea, szendvics','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával és szendviccsel várják a szélsőséges időjárás miatt bajba kerülteket!<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(197,1,201,0,'kávé, tea','Érd M7 lejáratnál teát, kávét mi is tudunk felajánlani otthonunkban. 203157093','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(198,1,202,0,'szendvics, tea, víz','Szendviccsel, teával, friss vízzel, petpalackkal... amivel csak tudok hozzájárulok a segítséghez, ha valaki megy ki az autópályára, vagy a közelben van (M1, ménfőcsanaki lehajtó). Autós telefontöltőt is tudok   felajánlani, ha valaki lemerült volna! 30-515-15-87','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(199,1,203,0,'Placemark 49','Balatonfüred, szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 063036567','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(200,1,204,0,'Golgota Teológiai Főiskola',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:15'),(201,1,205,0,'6 tagú család kocsiban','M1 80-as km-nél 6 tagú család, gyerekek 4-5-8-11 évesek, nem működik az akkumulátor hajnal 1 óta.<br>  A 80-as km nagyon közel van a komáromi leágazáshoz.<br>  Információ és meleg étel ital amire most a leginkább szükségük lenne. Kérek mindenkit, aki tud segítsen.<br>  Bikázó kábel pedig arra az esetre, ha elindulna a forgalom.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(202,1,206,0,'Átmeneti szállás','AUCHAN Székesfehérvár megnyitva.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(203,1,207,0,'M1, 100-as km Gönyü környéke','A 100-as km környékén az M1-en Gönyü környékén hallgatók hívtak minket, hogy derékig ér a hó, a benzin kifogyott és senki nem jár arra, hogy segítsen és esélytelen a mentés. Az autókat hátrahagyva melegedőre lenne szükségük ill akinek van munkagépe   közelítse meg őket és vigyenek forró teát, némi élelmet mert még egy éjszakát nem bírnak ki.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(204,1,208,0,'kávé, tea','Bakonyszentlászlón lakunk szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 06302944634','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(205,1,209,0,'Átmeneti szállás','Enyingi művelődési ház','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(206,1,210,0,'SOS','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(207,1,211,0,'MELEGEDŐ!','Budaörsi Tesco megnyitva! (eredetileg rossz helyen volt a jelzés)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(208,1,212,0,'Lidl parkolóban elakadt Ford','Székesfehérváron a Várpalota felőli bevezető úton a nagy körforgalom melletti Lidl parkolóba rostokol tegnap óta egy (Ford Transit KHG 378-as rendszámú autóban)két jó barátom, kérem, aki ott lakik a közelben legalább egy kis meleg teát vigyen   oda nekik és esetleg némi harapni valót!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(209,1,213,0,'Átmeneti szállás','Gondozási központ - Batthyány utca 134.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(210,1,214,0,'lellei segítség','Traktor beizzítva, ha kell valakinek segítség az utakon Balatonlelle környékén! Bátran hívjon: 20/ 383 57 75!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(211,1,215,0,'Átmeneti szállás',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(212,1,216,0,'bicskei szállás','Vörös Marianna<br>  Bicskén szálassal tudok segíteni a rászorultoknak.Vörös Marianna 06 20 92 88 536','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(213,1,217,0,'Átmeneti szállás','ÁMK Fekete István Általános Iskola és Alapfokú Művészeti Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(214,1,218,0,'64-es út, Enying előtt 30 km.','Észlelőnk segélykérése:<br>  &quot;Valaki segítsen!!! Osszátok meg!! 16 órája várunk, hogy kimentsenek egy 2éves kislányal minket többi 20bajba jutottal! Akárkihez fordulok,nem jönnek segíteni (mentő,rendőrség,tűzoltó,katasztrófavédelem)<br>  64es úton Enying elött kb. 30kmre&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(215,1,219,0,'csór-melegedő','Csór Ifjúsági Ház Csór, Főtér 9. 22/433-109','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(216,1,220,0,'seregélyes-melegedő','Seregélyes Horváth Gáborné (Kis Vendéglő) Széchenyi u. 1. 0622/447-014','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(217,1,221,0,'szabadbattyán-melegedő','Szabadbattyán ÁMK Iskola Szabadbattyán Iskola u 7. 22/363-022','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(218,1,222,0,'Átmeneti szállás','Székesfehérvári Civil Központ (volt Technika Háza)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(219,1,223,0,'fehérvár-melegedők','Székesfehérvár Civil Ház Rákóczi út<br>  Székesfehérvár Kodály Zoltán Isk. Béke tér<br>  Székesfehérvár Teleki Blanka Gimnázium és Általános Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(220,1,224,0,'autómentés','Demeter Zsolt 30/397 81 48','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(221,1,225,0,'sárosd- tűzoltók-','A TELEFONSZÁMUNK: 0630 676 7344 Takács István: &quot;Tisztelt sárosdi lakótársaim ha valaki bajban van bátran hívja a sárosdi önkéntes tűzoltó egyesületet, megyünk és segítünk, mi előbb ki érünk mint Sárbogárd nem beszélve arról ,hogy őnekik van munkájuk   bőven. .HA BAJ VAN SEGÍTÜNK.&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(222,1,226,0,'pécs-szállás','Én menteni nem tudok, mert nincs traktorom:) ,de megszállni megszállhat nálam aki Pécsett ragadt a hó miatt. Pécs-kertváros, 70-2528822 Gyenese Andrea','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(223,1,227,0,'BALATONAKARATTYA segítségre lenne szükség.','Annamária Zsadányi - https://www.facebook.com/zsannamaria<br>  <br>  Én is segítséget szeretnék kérni...<br>  <br>  VALAKI van Balatonakarattyán aki tudna segíteni? Párom ott ragadt tegnap délután óta, nincs nála már sem étel, sem pénz...ha van valaki onnan vagy ismerősötök, tudna segíteni? A MOL kútnál áll, a kocsit nem tudja otthagyni ADR-es. Ha valaki oda tudna menni/vinni   valami ennivalót, némi aprót, vagy bármi módon tudna segíteni nagy segítség lenne, egyenlőre a hírek szerint a mai éjszakát is ott kell tölteni valószínűleg, ez a tegnapi hosszú munkanapra sikerült :-) .Hátha lesz segítőkész jelentkező arról is. KÖSZI előre   is.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(224,1,228,0,'autómentés','30/665 1514','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(225,1,229,0,'autómentés','30/670 1242','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(226,1,230,0,'autómentés','30/348 51 54','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(227,1,231,0,'autómentés','70/538 8077','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(228,1,232,0,'autómentés','20/316 0560','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(229,1,233,0,'Átmeneti szállás','8060 Mór, Táncsics Mihály utca 25<br>  Wekerle Sándor Szabadidőközpont,<br>  06-22/ 407-161, 06-20/ 511-0462','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(230,1,234,0,'Kaposváron ragadtaknak','Ha itt ragadtál, nem mersz vagy nem tudsz továbbmenni, várlak szeretettel otthonomban, meleg tea, ennivaló, alvási, fürdési lehetőség van: 06-70-637-0773 Ági','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(231,1,235,0,'30/6826408 vagy 30/949 3292','Szücs Gáborék 96-os kmnél Győrhöz közel, étel-ital nélkül, tegnap duán óta egy helyben!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(232,1,236,0,'Egy kis család, két pici gyerekkel','KERESNEK TITEKET? DE LEMERÜLT A TELEFON? ÉS NEM TALÁLJÁK A KOCSIT! TEGYETEK KI VALAMI ÉLÉNK RONGYOT A KOCSIRA!  <br>  Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy tud infot a hírekben   elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(233,1,237,0,'Átmeneti szállás','Sziasztok!<br>  <br>  Ha valaki esetleg a Mátrában akadt el, Mátraszentistván környékén, akkor a Mátraszíve apartmanházban meleg teát és ételt biztosítunk minden úton rekedt embernek.  <br>  <br>  Pontos cím és térkép: <br>  <br>  <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">http://www.matraszive.hu/kapcsolat</a><br>  <br>  Telefonszám: &#43;36 20 932 03 34<br>Click <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">here</a> for more information.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(234,1,238,0,'Szállás','Pécs, 3-4 fő elfér, szállás: Kinga Pécsről 30/385-1230','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(235,1,239,0,'TRAKTOROSOK!!!!!!!!','&#43;36-70/5579-770<br>  Közel egy napja veszteglünk a 81 főúton.Mi és<br>  még sokan mások az elakadt kamionok<br>  között.Tegnap mi még tudtunk segíteni árokba<br>  csúszott autósokon,de mára már a<br>  vontatókötelünk is elszakadt és mi is segítségre<br>  szorulunk már.Az autókat betemeti a hó,már<br>  lassan az ajtót sem lehet kinyittani belülről<br>  jegesednek az ablakok is.Itt minden autós<br>  hasonló gondokkal küzd.Néha kimegyek és<br>  körbelapátolom az autót,de reménytelen harc a<br>  hóval. Fehérvárcsurgó és a Bodajki elágazó<br>  között vagyunk mi elakadva .Mellettünk a<br>  mezőn járnak a traktorok,tűzoltóautó,de senki<br>  nem néz ránk,hogy megvagyunk-e még.Pedig az<br>  utasaimat elvihetnék egy közeli<br>  melegedőbe.Több segítséget is próbáltunk<br>  igénybe venni,de csak türelemre intenek<br>  minket. Kérnék mindenkit,akinek itt a környéken<br>  van még nem dolgozó traktoros ismerőse vagy<br>  ha valaki el tudná vinni az utasaimat,bármilyen<br> &hellip;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(236,1,240,0,'Vörösmarty Általános Iskola','Helyiek küldtek be oda ételt és innivalót.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(237,1,241,0,'Ácsi Márk','Hólapátolás, kézi erővel elvégezhető mentés.<br>  &#43; 36 70 326 46 98','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(238,1,242,0,'Ha valaki elakadt!','Ha valaki a hó miatt elvan akadva Esztergom környékén,vagy tud ilyenről hívjon hajnali 2-ig tudok menni segíteni 4x4-es autóval,06204461053 telszám','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(239,1,243,0,'Két gyerekes család, elfogyott élelem','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(240,1,244,0,'Hunyadi utca 45','2462 Martonvásár, Magyarország','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(241,1,245,0,'Graf-Starhemberg-Gasse 47','2-3 főt el tudok szállásolni, ha valakinek közelebb van és / vagy nem tud hazajutni! Meleg tea, enni való van! Pásztor János &#43;36-30-265-6467','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(242,1,246,0,'Segítség!','06 20 5733578<br>  SOS Segítsetek fiaméknak 11 hónapos kisfiúkkal - akik Várpalotán rekedtek - egy kiadó szobát, v. szállást találni éjszakára. Részben a fagyos országúton töltötték az éjszakát majd kivezették őket a 7-es útról és egy enyingi benzinkútnál töltötték az éjszakát.   Onnan ma elvergődtek Várpaloltára, ahonnan nincs tovább!!!! De nincs sehol egy kiadó szoba és a telefonjaik lemerülőben. Így, engem értesítsetek, ha lenne valaki befogadná őket, míg szükséges. Megfizetnék, csak végre a kicsi fiúkat rendbe tudnák tenni!!!<br>  06 20 5733578','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(243,1,247,0,'Szállás és étel 2-4 fő részére Székesfehérváron','2-4 fő részére átmeneti szállást és meleg ételt tudunk biztosítani.<br>  <br>  Kontakt:<br>  Zsida Ágoston<br>  Székesfehérvár, Szent Gellért utca 105/A<br>  Telefon: 30/756-4885','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(244,1,248,0,'Hajléktalanok Éjjeli Menedékhelye és Nappali Melegedő',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(245,1,249,0,'Fáklya utca','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával&nbsp;és   szendviccsel várjuk a szélsőséges időjárás miatt bajba kerülteket!&nbsp;<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(246,1,250,0,'szoba, tea, szendvics','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával és szendviccsel várják a szélsőséges időjárás miatt bajba kerülteket!<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(247,1,251,0,'kávé, tea','Érd M7 lejáratnál teát, kávét mi is tudunk felajánlani otthonunkban. 203157093','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(248,1,252,0,'szendvics, tea, víz','Szendviccsel, teával, friss vízzel, petpalackkal... amivel csak tudok hozzájárulok a segítséghez, ha valaki megy ki az autópályára, vagy a közelben van (M1, ménfőcsanaki lehajtó). Autós telefontöltőt is tudok   felajánlani, ha valaki lemerült volna! 30-515-15-87','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(249,1,253,0,'Placemark 49','Balatonfüred, szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 063036567','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(250,1,254,0,'Golgota Teológiai Főiskola',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:24'),(251,1,255,0,'6 tagú család kocsiban','M1 80-as km-nél 6 tagú család, gyerekek 4-5-8-11 évesek, nem működik az akkumulátor hajnal 1 óta.<br>  A 80-as km nagyon közel van a komáromi leágazáshoz.<br>  Információ és meleg étel ital amire most a leginkább szükségük lenne. Kérek mindenkit, aki tud segítsen.<br>  Bikázó kábel pedig arra az esetre, ha elindulna a forgalom.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(252,1,256,0,'Átmeneti szállás','AUCHAN Székesfehérvár megnyitva.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(253,1,257,0,'M1, 100-as km Gönyü környéke','A 100-as km környékén az M1-en Gönyü környékén hallgatók hívtak minket, hogy derékig ér a hó, a benzin kifogyott és senki nem jár arra, hogy segítsen és esélytelen a mentés. Az autókat hátrahagyva melegedőre lenne szükségük ill akinek van munkagépe   közelítse meg őket és vigyenek forró teát, némi élelmet mert még egy éjszakát nem bírnak ki.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(254,1,258,0,'kávé, tea','Bakonyszentlászlón lakunk szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 06302944634','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(255,1,259,0,'Átmeneti szállás','Enyingi művelődési ház','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(256,1,260,0,'SOS','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(257,1,261,0,'MELEGEDŐ!','Budaörsi Tesco megnyitva! (eredetileg rossz helyen volt a jelzés)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(258,1,262,0,'Lidl parkolóban elakadt Ford','Székesfehérváron a Várpalota felőli bevezető úton a nagy körforgalom melletti Lidl parkolóba rostokol tegnap óta egy (Ford Transit KHG 378-as rendszámú autóban)két jó barátom, kérem, aki ott lakik a közelben legalább egy kis meleg teát vigyen   oda nekik és esetleg némi harapni valót!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(259,1,263,0,'Átmeneti szállás','Gondozási központ - Batthyány utca 134.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(260,1,264,0,'lellei segítség','Traktor beizzítva, ha kell valakinek segítség az utakon Balatonlelle környékén! Bátran hívjon: 20/ 383 57 75!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(261,1,265,0,'Átmeneti szállás',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(262,1,266,0,'bicskei szállás','Vörös Marianna<br>  Bicskén szálassal tudok segíteni a rászorultoknak.Vörös Marianna 06 20 92 88 536','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(263,1,267,0,'Átmeneti szállás','ÁMK Fekete István Általános Iskola és Alapfokú Művészeti Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(264,1,268,0,'64-es út, Enying előtt 30 km.','Észlelőnk segélykérése:<br>  &quot;Valaki segítsen!!! Osszátok meg!! 16 órája várunk, hogy kimentsenek egy 2éves kislányal minket többi 20bajba jutottal! Akárkihez fordulok,nem jönnek segíteni (mentő,rendőrség,tűzoltó,katasztrófavédelem)<br>  64es úton Enying elött kb. 30kmre&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(265,1,269,0,'csór-melegedő','Csór Ifjúsági Ház Csór, Főtér 9. 22/433-109','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(266,1,270,0,'seregélyes-melegedő','Seregélyes Horváth Gáborné (Kis Vendéglő) Széchenyi u. 1. 0622/447-014','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(267,1,271,0,'szabadbattyán-melegedő','Szabadbattyán ÁMK Iskola Szabadbattyán Iskola u 7. 22/363-022','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(268,1,272,0,'Átmeneti szállás','Székesfehérvári Civil Központ (volt Technika Háza)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(269,1,273,0,'fehérvár-melegedők','Székesfehérvár Civil Ház Rákóczi út<br>  Székesfehérvár Kodály Zoltán Isk. Béke tér<br>  Székesfehérvár Teleki Blanka Gimnázium és Általános Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(270,1,274,0,'autómentés','Demeter Zsolt 30/397 81 48','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(271,1,275,0,'sárosd- tűzoltók-','A TELEFONSZÁMUNK: 0630 676 7344 Takács István: &quot;Tisztelt sárosdi lakótársaim ha valaki bajban van bátran hívja a sárosdi önkéntes tűzoltó egyesületet, megyünk és segítünk, mi előbb ki érünk mint Sárbogárd nem beszélve arról ,hogy őnekik van munkájuk   bőven. .HA BAJ VAN SEGÍTÜNK.&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(272,1,276,0,'pécs-szállás','Én menteni nem tudok, mert nincs traktorom:) ,de megszállni megszállhat nálam aki Pécsett ragadt a hó miatt. Pécs-kertváros, 70-2528822 Gyenese Andrea','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(273,1,277,0,'BALATONAKARATTYA segítségre lenne szükség.','Annamária Zsadányi - https://www.facebook.com/zsannamaria<br>  <br>  Én is segítséget szeretnék kérni...<br>  <br>  VALAKI van Balatonakarattyán aki tudna segíteni? Párom ott ragadt tegnap délután óta, nincs nála már sem étel, sem pénz...ha van valaki onnan vagy ismerősötök, tudna segíteni? A MOL kútnál áll, a kocsit nem tudja otthagyni ADR-es. Ha valaki oda tudna menni/vinni   valami ennivalót, némi aprót, vagy bármi módon tudna segíteni nagy segítség lenne, egyenlőre a hírek szerint a mai éjszakát is ott kell tölteni valószínűleg, ez a tegnapi hosszú munkanapra sikerült :-) .Hátha lesz segítőkész jelentkező arról is. KÖSZI előre   is.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(274,1,278,0,'autómentés','30/665 1514','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(275,1,279,0,'autómentés','30/670 1242','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(276,1,280,0,'autómentés','30/348 51 54','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(277,1,281,0,'autómentés','70/538 8077','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(278,1,282,0,'autómentés','20/316 0560','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(279,1,283,0,'Átmeneti szállás','8060 Mór, Táncsics Mihály utca 25<br>  Wekerle Sándor Szabadidőközpont,<br>  06-22/ 407-161, 06-20/ 511-0462','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(280,1,284,0,'Kaposváron ragadtaknak','Ha itt ragadtál, nem mersz vagy nem tudsz továbbmenni, várlak szeretettel otthonomban, meleg tea, ennivaló, alvási, fürdési lehetőség van: 06-70-637-0773 Ági','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(281,1,285,0,'30/6826408 vagy 30/949 3292','Szücs Gáborék 96-os kmnél Győrhöz közel, étel-ital nélkül, tegnap duán óta egy helyben!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(282,1,286,0,'Egy kis család, két pici gyerekkel','KERESNEK TITEKET? DE LEMERÜLT A TELEFON? ÉS NEM TALÁLJÁK A KOCSIT! TEGYETEK KI VALAMI ÉLÉNK RONGYOT A KOCSIRA!  <br>  Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy tud infot a hírekben   elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(283,1,287,0,'Átmeneti szállás','Sziasztok!<br>  <br>  Ha valaki esetleg a Mátrában akadt el, Mátraszentistván környékén, akkor a Mátraszíve apartmanházban meleg teát és ételt biztosítunk minden úton rekedt embernek.  <br>  <br>  Pontos cím és térkép: <br>  <br>  <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">http://www.matraszive.hu/kapcsolat</a><br>  <br>  Telefonszám: &#43;36 20 932 03 34<br>Click <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">here</a> for more information.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(284,1,288,0,'Szállás','Pécs, 3-4 fő elfér, szállás: Kinga Pécsről 30/385-1230','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(285,1,289,0,'TRAKTOROSOK!!!!!!!!','&#43;36-70/5579-770<br>  Közel egy napja veszteglünk a 81 főúton.Mi és<br>  még sokan mások az elakadt kamionok<br>  között.Tegnap mi még tudtunk segíteni árokba<br>  csúszott autósokon,de mára már a<br>  vontatókötelünk is elszakadt és mi is segítségre<br>  szorulunk már.Az autókat betemeti a hó,már<br>  lassan az ajtót sem lehet kinyittani belülről<br>  jegesednek az ablakok is.Itt minden autós<br>  hasonló gondokkal küzd.Néha kimegyek és<br>  körbelapátolom az autót,de reménytelen harc a<br>  hóval. Fehérvárcsurgó és a Bodajki elágazó<br>  között vagyunk mi elakadva .Mellettünk a<br>  mezőn járnak a traktorok,tűzoltóautó,de senki<br>  nem néz ránk,hogy megvagyunk-e még.Pedig az<br>  utasaimat elvihetnék egy közeli<br>  melegedőbe.Több segítséget is próbáltunk<br>  igénybe venni,de csak türelemre intenek<br>  minket. Kérnék mindenkit,akinek itt a környéken<br>  van még nem dolgozó traktoros ismerőse vagy<br>  ha valaki el tudná vinni az utasaimat,bármilyen<br> &hellip;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(286,1,290,0,'Vörösmarty Általános Iskola','Helyiek küldtek be oda ételt és innivalót.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(287,1,291,0,'Ácsi Márk','Hólapátolás, kézi erővel elvégezhető mentés.<br>  &#43; 36 70 326 46 98','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(288,1,292,0,'Ha valaki elakadt!','Ha valaki a hó miatt elvan akadva Esztergom környékén,vagy tud ilyenről hívjon hajnali 2-ig tudok menni segíteni 4x4-es autóval,06204461053 telszám','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(289,1,293,0,'Két gyerekes család, elfogyott élelem','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(290,1,294,0,'Hunyadi utca 45','2462 Martonvásár, Magyarország','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(291,1,295,0,'Graf-Starhemberg-Gasse 47','2-3 főt el tudok szállásolni, ha valakinek közelebb van és / vagy nem tud hazajutni! Meleg tea, enni való van! Pásztor János &#43;36-30-265-6467','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(292,1,296,0,'Segítség!','06 20 5733578<br>  SOS Segítsetek fiaméknak 11 hónapos kisfiúkkal - akik Várpalotán rekedtek - egy kiadó szobát, v. szállást találni éjszakára. Részben a fagyos országúton töltötték az éjszakát majd kivezették őket a 7-es útról és egy enyingi benzinkútnál töltötték az éjszakát.   Onnan ma elvergődtek Várpaloltára, ahonnan nincs tovább!!!! De nincs sehol egy kiadó szoba és a telefonjaik lemerülőben. Így, engem értesítsetek, ha lenne valaki befogadná őket, míg szükséges. Megfizetnék, csak végre a kicsi fiúkat rendbe tudnák tenni!!!<br>  06 20 5733578','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(293,1,297,0,'Szállás és étel 2-4 fő részére Székesfehérváron','2-4 fő részére átmeneti szállást és meleg ételt tudunk biztosítani.<br>  <br>  Kontakt:<br>  Zsida Ágoston<br>  Székesfehérvár, Szent Gellért utca 105/A<br>  Telefon: 30/756-4885','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(294,1,298,0,'Hajléktalanok Éjjeli Menedékhelye és Nappali Melegedő',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(295,1,299,0,'Fáklya utca','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával&nbsp;és   szendviccsel várjuk a szélsőséges időjárás miatt bajba kerülteket!&nbsp;<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(296,1,300,0,'szoba, tea, szendvics','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával és szendviccsel várják a szélsőséges időjárás miatt bajba kerülteket!<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(297,1,301,0,'kávé, tea','Érd M7 lejáratnál teát, kávét mi is tudunk felajánlani otthonunkban. 203157093','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(298,1,302,0,'szendvics, tea, víz','Szendviccsel, teával, friss vízzel, petpalackkal... amivel csak tudok hozzájárulok a segítséghez, ha valaki megy ki az autópályára, vagy a közelben van (M1, ménfőcsanaki lehajtó). Autós telefontöltőt is tudok   felajánlani, ha valaki lemerült volna! 30-515-15-87','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(299,1,303,0,'Placemark 49','Balatonfüred, szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 063036567','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(300,1,304,0,'Golgota Teológiai Főiskola',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 20:08:31'),(301,1,305,0,'Átmeneti szállás','AUCHAN Székesfehérvár megnyitva.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(302,1,306,0,'M1, 100-as km Gönyü környéke','A 100-as km környékén az M1-en Gönyü környékén hallgatók hívtak minket, hogy derékig ér a hó, a benzin kifogyott és senki nem jár arra, hogy segítsen és esélytelen a mentés. Az autókat hátrahagyva melegedőre lenne szükségük ill akinek van munkagépe   közelítse meg őket és vigyenek forró teát, némi élelmet mert még egy éjszakát nem bírnak ki.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(303,1,307,0,'kávé, tea','Bakonyszentlászlón lakunk szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 06302944634','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(304,1,308,0,'Átmeneti szállás','Enyingi művelődési ház','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(305,1,309,0,'SOS','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(306,1,310,0,'MELEGEDŐ!','Budaörsi Tesco megnyitva! (eredetileg rossz helyen volt a jelzés)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(307,1,311,0,'Lidl parkolóban elakadt Ford','Székesfehérváron a Várpalota felőli bevezető úton a nagy körforgalom melletti Lidl parkolóba rostokol tegnap óta egy (Ford Transit KHG 378-as rendszámú autóban)két jó barátom, kérem, aki ott lakik a közelben legalább egy kis meleg teát vigyen   oda nekik és esetleg némi harapni valót!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(308,1,312,0,'Átmeneti szállás','Gondozási központ - Batthyány utca 134.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(309,1,313,0,'lellei segítség','Traktor beizzítva, ha kell valakinek segítség az utakon Balatonlelle környékén! Bátran hívjon: 20/ 383 57 75!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(310,1,314,0,'Átmeneti szállás',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(311,1,315,0,'bicskei szállás','Vörös Marianna<br>  Bicskén szálassal tudok segíteni a rászorultoknak.Vörös Marianna 06 20 92 88 536','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(312,1,316,0,'Átmeneti szállás','ÁMK Fekete István Általános Iskola és Alapfokú Művészeti Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(313,1,317,0,'64-es út, Enying előtt 30 km.','Észlelőnk segélykérése:<br>  &quot;Valaki segítsen!!! Osszátok meg!! 16 órája várunk, hogy kimentsenek egy 2éves kislányal minket többi 20bajba jutottal! Akárkihez fordulok,nem jönnek segíteni (mentő,rendőrség,tűzoltó,katasztrófavédelem)<br>  64es úton Enying elött kb. 30kmre&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(314,1,318,0,'csór-melegedő','Csór Ifjúsági Ház Csór, Főtér 9. 22/433-109','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(315,1,319,0,'seregélyes-melegedő','Seregélyes Horváth Gáborné (Kis Vendéglő) Széchenyi u. 1. 0622/447-014','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(316,1,320,0,'szabadbattyán-melegedő','Szabadbattyán ÁMK Iskola Szabadbattyán Iskola u 7. 22/363-022','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(317,1,321,0,'Átmeneti szállás','Székesfehérvári Civil Központ (volt Technika Háza)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(318,1,322,0,'fehérvár-melegedők','Székesfehérvár Civil Ház Rákóczi út<br>  Székesfehérvár Kodály Zoltán Isk. Béke tér<br>  Székesfehérvár Teleki Blanka Gimnázium és Általános Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(319,1,323,0,'autómentés','Demeter Zsolt 30/397 81 48','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(320,1,324,0,'sárosd- tűzoltók-','A TELEFONSZÁMUNK: 0630 676 7344 Takács István: &quot;Tisztelt sárosdi lakótársaim ha valaki bajban van bátran hívja a sárosdi önkéntes tűzoltó egyesületet, megyünk és segítünk, mi előbb ki érünk mint Sárbogárd nem beszélve arról ,hogy őnekik van munkájuk   bőven. .HA BAJ VAN SEGÍTÜNK.&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(321,1,325,0,'pécs-szállás','Én menteni nem tudok, mert nincs traktorom:) ,de megszállni megszállhat nálam aki Pécsett ragadt a hó miatt. Pécs-kertváros, 70-2528822 Gyenese Andrea','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(322,1,326,0,'BALATONAKARATTYA segítségre lenne szükség.','Annamária Zsadányi - https://www.facebook.com/zsannamaria<br>  <br>  Én is segítséget szeretnék kérni...<br>  <br>  VALAKI van Balatonakarattyán aki tudna segíteni? Párom ott ragadt tegnap délután óta, nincs nála már sem étel, sem pénz...ha van valaki onnan vagy ismerősötök, tudna segíteni? A MOL kútnál áll, a kocsit nem tudja otthagyni ADR-es. Ha valaki oda tudna menni/vinni   valami ennivalót, némi aprót, vagy bármi módon tudna segíteni nagy segítség lenne, egyenlőre a hírek szerint a mai éjszakát is ott kell tölteni valószínűleg, ez a tegnapi hosszú munkanapra sikerült :-) .Hátha lesz segítőkész jelentkező arról is. KÖSZI előre   is.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(323,1,327,0,'autómentés','30/665 1514','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(324,1,328,0,'autómentés','30/670 1242','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(325,1,329,0,'autómentés','30/348 51 54','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(326,1,330,0,'autómentés','70/538 8077','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(327,1,331,0,'autómentés','20/316 0560','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(328,1,332,0,'Átmeneti szállás','8060 Mór, Táncsics Mihály utca 25<br>  Wekerle Sándor Szabadidőközpont,<br>  06-22/ 407-161, 06-20/ 511-0462','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(329,1,333,0,'Kaposváron ragadtaknak','Ha itt ragadtál, nem mersz vagy nem tudsz továbbmenni, várlak szeretettel otthonomban, meleg tea, ennivaló, alvási, fürdési lehetőség van: 06-70-637-0773 Ági','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(330,1,334,0,'30/6826408 vagy 30/949 3292','Szücs Gáborék 96-os kmnél Győrhöz közel, étel-ital nélkül, tegnap duán óta egy helyben!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(331,1,335,0,'Átmeneti szállás','Sziasztok!<br>  <br>  Ha valaki esetleg a Mátrában akadt el, Mátraszentistván környékén, akkor a Mátraszíve apartmanházban meleg teát és ételt biztosítunk minden úton rekedt embernek.  <br>  <br>  Pontos cím és térkép: <br>  <br>  <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">http://www.matraszive.hu/kapcsolat</a><br>  <br>  Telefonszám: &#43;36 20 932 03 34<br>Click <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">here</a> for more information.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(332,1,336,0,'Szállás','Pécs, 3-4 fő elfér, szállás: Kinga Pécsről 30/385-1230','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(333,1,337,0,'TRAKTOROSOK!!!!!!!!','&#43;36-70/5579-770<br>  Közel egy napja veszteglünk a 81 főúton.Mi és<br>  még sokan mások az elakadt kamionok<br>  között.Tegnap mi még tudtunk segíteni árokba<br>  csúszott autósokon,de mára már a<br>  vontatókötelünk is elszakadt és mi is segítségre<br>  szorulunk már.Az autókat betemeti a hó,már<br>  lassan az ajtót sem lehet kinyittani belülről<br>  jegesednek az ablakok is.Itt minden autós<br>  hasonló gondokkal küzd.Néha kimegyek és<br>  körbelapátolom az autót,de reménytelen harc a<br>  hóval. Fehérvárcsurgó és a Bodajki elágazó<br>  között vagyunk mi elakadva .Mellettünk a<br>  mezőn járnak a traktorok,tűzoltóautó,de senki<br>  nem néz ránk,hogy megvagyunk-e még.Pedig az<br>  utasaimat elvihetnék egy közeli<br>  melegedőbe.Több segítséget is próbáltunk<br>  igénybe venni,de csak türelemre intenek<br>  minket. Kérnék mindenkit,akinek itt a környéken<br>  van még nem dolgozó traktoros ismerőse vagy<br>  ha valaki el tudná vinni az utasaimat,bármilyen<br> &hellip;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(334,1,338,0,'Vörösmarty Általános Iskola','Helyiek küldtek be oda ételt és innivalót.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(335,1,339,0,'Ácsi Márk','Hólapátolás, kézi erővel elvégezhető mentés.<br>  &#43; 36 70 326 46 98','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(336,1,340,0,'Ha valaki elakadt!','Ha valaki a hó miatt elvan akadva Esztergom környékén,vagy tud ilyenről hívjon hajnali 2-ig tudok menni segíteni 4x4-es autóval,06204461053 telszám','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(337,1,341,0,'Két gyerekes család, elfogyott élelem','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(338,1,342,0,'Hunyadi utca 45','2462 Martonvásár, Magyarország','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(339,1,343,0,'Graf-Starhemberg-Gasse 47','2-3 főt el tudok szállásolni, ha valakinek közelebb van és / vagy nem tud hazajutni! Meleg tea, enni való van! Pásztor János &#43;36-30-265-6467','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(340,1,344,0,'Segítség!','06 20 5733578<br>  SOS Segítsetek fiaméknak 11 hónapos kisfiúkkal - akik Várpalotán rekedtek - egy kiadó szobát, v. szállást találni éjszakára. Részben a fagyos országúton töltötték az éjszakát majd kivezették őket a 7-es útról és egy enyingi benzinkútnál töltötték az éjszakát.   Onnan ma elvergődtek Várpaloltára, ahonnan nincs tovább!!!! De nincs sehol egy kiadó szoba és a telefonjaik lemerülőben. Így, engem értesítsetek, ha lenne valaki befogadná őket, míg szükséges. Megfizetnék, csak végre a kicsi fiúkat rendbe tudnák tenni!!!<br>  06 20 5733578','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(341,1,345,0,'Szállás és étel 2-4 fő részére Székesfehérváron','2-4 fő részére átmeneti szállást és meleg ételt tudunk biztosítani.<br>  <br>  Kontakt:<br>  Zsida Ágoston<br>  Székesfehérvár, Szent Gellért utca 105/A<br>  Telefon: 30/756-4885','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(342,1,346,0,'Hajléktalanok Éjjeli Menedékhelye és Nappali Melegedő',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(343,1,347,0,'Fáklya utca','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával&nbsp;és   szendviccsel várjuk a szélsőséges időjárás miatt bajba kerülteket!&nbsp;<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(344,1,348,0,'szoba, tea, szendvics','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával és szendviccsel várják a szélsőséges időjárás miatt bajba kerülteket!<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(345,1,349,0,'kávé, tea','Érd M7 lejáratnál teát, kávét mi is tudunk felajánlani otthonunkban. 203157093','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(346,1,350,0,'szendvics, tea, víz','Szendviccsel, teával, friss vízzel, petpalackkal... amivel csak tudok hozzájárulok a segítséghez, ha valaki megy ki az autópályára, vagy a közelben van (M1, ménfőcsanaki lehajtó). Autós telefontöltőt is tudok   felajánlani, ha valaki lemerült volna! 30-515-15-87','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(347,1,351,0,'Placemark 49','Balatonfüred, szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 063036567','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(348,1,352,0,'Golgota Teológiai Főiskola',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(349,1,353,0,'szállás 4 főnek','Törökbálinton 4 főnek szállást, meleg teát, ételt biztosítunk.<br>  Szerettel várjuk (leginkább) a kisgyerekes családokat.<br>  Amíg járhatók az utak, addig értük tudunk menni.<br>  Érdeklődni: 0630/9-520-955<br>  &nbsp;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(350,1,354,0,'Garay János utca 2','7095 Iregszemcse, Magyarország','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:01:55'),(351,1,355,0,'Átmeneti szállás','AUCHAN Székesfehérvár megnyitva.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(352,1,356,0,'M1, 100-as km Gönyü környéke','A 100-as km környékén az M1-en Gönyü környékén hallgatók hívtak minket, hogy derékig ér a hó, a benzin kifogyott és senki nem jár arra, hogy segítsen és esélytelen a mentés. Az autókat hátrahagyva melegedőre lenne szükségük ill akinek van munkagépe   közelítse meg őket és vigyenek forró teát, némi élelmet mert még egy éjszakát nem bírnak ki.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(353,1,357,0,'kávé, tea','Bakonyszentlászlón lakunk szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 06302944634','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(354,1,358,0,'Átmeneti szállás','Enyingi művelődési ház','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(355,1,359,0,'SOS','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(356,1,360,0,'MELEGEDŐ!','Budaörsi Tesco megnyitva! (eredetileg rossz helyen volt a jelzés)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(357,1,361,0,'Lidl parkolóban elakadt Ford','Székesfehérváron a Várpalota felőli bevezető úton a nagy körforgalom melletti Lidl parkolóba rostokol tegnap óta egy (Ford Transit KHG 378-as rendszámú autóban)két jó barátom, kérem, aki ott lakik a közelben legalább egy kis meleg teát vigyen   oda nekik és esetleg némi harapni valót!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(358,1,362,0,'Átmeneti szállás','Gondozási központ - Batthyány utca 134.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(359,1,363,0,'lellei segítség','Traktor beizzítva, ha kell valakinek segítség az utakon Balatonlelle környékén! Bátran hívjon: 20/ 383 57 75!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(360,1,364,0,'Átmeneti szállás',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(361,1,365,0,'bicskei szállás','Vörös Marianna<br>  Bicskén szálassal tudok segíteni a rászorultoknak.Vörös Marianna 06 20 92 88 536','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(362,1,366,0,'Átmeneti szállás','ÁMK Fekete István Általános Iskola és Alapfokú Művészeti Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(363,1,367,0,'64-es út, Enying előtt 30 km.','Észlelőnk segélykérése:<br>  &quot;Valaki segítsen!!! Osszátok meg!! 16 órája várunk, hogy kimentsenek egy 2éves kislányal minket többi 20bajba jutottal! Akárkihez fordulok,nem jönnek segíteni (mentő,rendőrség,tűzoltó,katasztrófavédelem)<br>  64es úton Enying elött kb. 30kmre&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(364,1,368,0,'csór-melegedő','Csór Ifjúsági Ház Csór, Főtér 9. 22/433-109','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(365,1,369,0,'seregélyes-melegedő','Seregélyes Horváth Gáborné (Kis Vendéglő) Széchenyi u. 1. 0622/447-014','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(366,1,370,0,'szabadbattyán-melegedő','Szabadbattyán ÁMK Iskola Szabadbattyán Iskola u 7. 22/363-022','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:03'),(367,1,371,0,'Átmeneti szállás','Székesfehérvári Civil Központ (volt Technika Háza)','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(368,1,372,0,'fehérvár-melegedők','Székesfehérvár Civil Ház Rákóczi út<br>  Székesfehérvár Kodály Zoltán Isk. Béke tér<br>  Székesfehérvár Teleki Blanka Gimnázium és Általános Iskola','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(369,1,373,0,'autómentés','Demeter Zsolt 30/397 81 48','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(370,1,374,0,'sárosd- tűzoltók-','A TELEFONSZÁMUNK: 0630 676 7344 Takács István: &quot;Tisztelt sárosdi lakótársaim ha valaki bajban van bátran hívja a sárosdi önkéntes tűzoltó egyesületet, megyünk és segítünk, mi előbb ki érünk mint Sárbogárd nem beszélve arról ,hogy őnekik van munkájuk   bőven. .HA BAJ VAN SEGÍTÜNK.&quot;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(371,1,375,0,'pécs-szállás','Én menteni nem tudok, mert nincs traktorom:) ,de megszállni megszállhat nálam aki Pécsett ragadt a hó miatt. Pécs-kertváros, 70-2528822 Gyenese Andrea','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(372,1,376,0,'BALATONAKARATTYA segítségre lenne szükség.','Annamária Zsadányi - https://www.facebook.com/zsannamaria<br>  <br>  Én is segítséget szeretnék kérni...<br>  <br>  VALAKI van Balatonakarattyán aki tudna segíteni? Párom ott ragadt tegnap délután óta, nincs nála már sem étel, sem pénz...ha van valaki onnan vagy ismerősötök, tudna segíteni? A MOL kútnál áll, a kocsit nem tudja otthagyni ADR-es. Ha valaki oda tudna menni/vinni   valami ennivalót, némi aprót, vagy bármi módon tudna segíteni nagy segítség lenne, egyenlőre a hírek szerint a mai éjszakát is ott kell tölteni valószínűleg, ez a tegnapi hosszú munkanapra sikerült :-) .Hátha lesz segítőkész jelentkező arról is. KÖSZI előre   is.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(373,1,377,0,'autómentés','30/665 1514','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(374,1,378,0,'autómentés','30/670 1242','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(375,1,379,0,'autómentés','30/348 51 54','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(376,1,380,0,'autómentés','70/538 8077','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(377,1,381,0,'autómentés','20/316 0560','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(378,1,382,0,'Átmeneti szállás','8060 Mór, Táncsics Mihály utca 25<br>  Wekerle Sándor Szabadidőközpont,<br>  06-22/ 407-161, 06-20/ 511-0462','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(379,1,383,0,'Kaposváron ragadtaknak','Ha itt ragadtál, nem mersz vagy nem tudsz továbbmenni, várlak szeretettel otthonomban, meleg tea, ennivaló, alvási, fürdési lehetőség van: 06-70-637-0773 Ági','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(380,1,384,0,'30/6826408 vagy 30/949 3292','Szücs Gáborék 96-os kmnél Győrhöz közel, étel-ital nélkül, tegnap duán óta egy helyben!','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(381,1,385,0,'Átmeneti szállás','Sziasztok!<br>  <br>  Ha valaki esetleg a Mátrában akadt el, Mátraszentistván környékén, akkor a Mátraszíve apartmanházban meleg teát és ételt biztosítunk minden úton rekedt embernek.  <br>  <br>  Pontos cím és térkép: <br>  <br>  <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">http://www.matraszive.hu/kapcsolat</a><br>  <br>  Telefonszám: &#43;36 20 932 03 34<br>Click <a rel=\"nofollow\" target=\"_blank\" href=\"http://www.matraszive.hu/kapcsolat\">here</a> for more information.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(382,1,386,0,'Szállás','Pécs, 3-4 fő elfér, szállás: Kinga Pécsről 30/385-1230','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(383,1,387,0,'TRAKTOROSOK!!!!!!!!','&#43;36-70/5579-770<br>  Közel egy napja veszteglünk a 81 főúton.Mi és<br>  még sokan mások az elakadt kamionok<br>  között.Tegnap mi még tudtunk segíteni árokba<br>  csúszott autósokon,de mára már a<br>  vontatókötelünk is elszakadt és mi is segítségre<br>  szorulunk már.Az autókat betemeti a hó,már<br>  lassan az ajtót sem lehet kinyittani belülről<br>  jegesednek az ablakok is.Itt minden autós<br>  hasonló gondokkal küzd.Néha kimegyek és<br>  körbelapátolom az autót,de reménytelen harc a<br>  hóval. Fehérvárcsurgó és a Bodajki elágazó<br>  között vagyunk mi elakadva .Mellettünk a<br>  mezőn járnak a traktorok,tűzoltóautó,de senki<br>  nem néz ránk,hogy megvagyunk-e még.Pedig az<br>  utasaimat elvihetnék egy közeli<br>  melegedőbe.Több segítséget is próbáltunk<br>  igénybe venni,de csak türelemre intenek<br>  minket. Kérnék mindenkit,akinek itt a környéken<br>  van még nem dolgozó traktoros ismerőse vagy<br>  ha valaki el tudná vinni az utasaimat,bármilyen<br> &hellip;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(384,1,388,0,'Vörösmarty Általános Iskola','Helyiek küldtek be oda ételt és innivalót.','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(385,1,389,0,'Ácsi Márk','Hólapátolás, kézi erővel elvégezhető mentés.<br>  &#43; 36 70 326 46 98','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(386,1,390,0,'Ha valaki elakadt!','Ha valaki a hó miatt elvan akadva Esztergom környékén,vagy tud ilyenről hívjon hajnali 2-ig tudok menni segíteni 4x4-es autóval,06204461053 telszám','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(387,1,391,0,'Két gyerekes család, elfogyott élelem','Egy kis család, két pici gyerekkel (1 és 4 éves), továbbra is egy helyben vesztegel az M1-en Budapestről-Győrre a 98-100 km kő között, most már 18 órája, és most már nagyon éhesek. Ha valaki a közelben van, és egy kicsit is tud segíteni, vagy   tud infot a hírekben elhangzott 20 melegedő buszról, keresse meg őket. szürke toyota corolla: KNK-398. Tel: 06 30 657 8091','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(388,1,392,0,'Hunyadi utca 45','2462 Martonvásár, Magyarország','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(389,1,393,0,'Graf-Starhemberg-Gasse 47','2-3 főt el tudok szállásolni, ha valakinek közelebb van és / vagy nem tud hazajutni! Meleg tea, enni való van! Pásztor János &#43;36-30-265-6467','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(390,1,394,0,'Segítség!','06 20 5733578<br>  SOS Segítsetek fiaméknak 11 hónapos kisfiúkkal - akik Várpalotán rekedtek - egy kiadó szobát, v. szállást találni éjszakára. Részben a fagyos országúton töltötték az éjszakát majd kivezették őket a 7-es útról és egy enyingi benzinkútnál töltötték az éjszakát.   Onnan ma elvergődtek Várpaloltára, ahonnan nincs tovább!!!! De nincs sehol egy kiadó szoba és a telefonjaik lemerülőben. Így, engem értesítsetek, ha lenne valaki befogadná őket, míg szükséges. Megfizetnék, csak végre a kicsi fiúkat rendbe tudnák tenni!!!<br>  06 20 5733578','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(391,1,395,0,'Szállás és étel 2-4 fő részére Székesfehérváron','2-4 fő részére átmeneti szállást és meleg ételt tudunk biztosítani.<br>  <br>  Kontakt:<br>  Zsida Ágoston<br>  Székesfehérvár, Szent Gellért utca 105/A<br>  Telefon: 30/756-4885','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(392,1,396,0,'Hajléktalanok Éjjeli Menedékhelye és Nappali Melegedő',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(393,1,397,0,'Fáklya utca','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával&nbsp;és   szendviccsel várjuk a szélsőséges időjárás miatt bajba kerülteket!&nbsp;<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(394,1,398,0,'szoba, tea, szendvics','Az Öreg-tó Kempingben még körülbelül 10 szabad szoba van, forró teával és szendviccsel várják a szélsőséges időjárás miatt bajba kerülteket!<br>  <br>  Cím: Tata, Fáklya utca 2.<br>  Telefon: 06307477750','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(395,1,399,0,'kávé, tea','Érd M7 lejáratnál teát, kávét mi is tudunk felajánlani otthonunkban. 203157093','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(396,1,400,0,'szendvics, tea, víz','Szendviccsel, teával, friss vízzel, petpalackkal... amivel csak tudok hozzájárulok a segítséghez, ha valaki megy ki az autópályára, vagy a közelben van (M1, ménfőcsanaki lehajtó). Autós telefontöltőt is tudok   felajánlani, ha valaki lemerült volna! 30-515-15-87','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(397,1,401,0,'Placemark 49','Balatonfüred, szívesen segítünk forró teával vagy kávéval ha valaki erre rekedt 063036567','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(398,1,402,0,'Golgota Teológiai Főiskola',NULL,'http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(399,1,403,0,'szállás 4 főnek','Törökbálinton 4 főnek szállást, meleg teát, ételt biztosítunk.<br>  Szerettel várjuk (leginkább) a kisgyerekes családokat.<br>  Amíg járhatók az utak, addig értük tudunk menni.<br>  Érdeklődni: 0630/9-520-955<br>  &nbsp;','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04'),(400,1,404,0,'Garay János utca 2','7095 Iregszemcse, Magyarország','http://www.bing.com/maps/?mapurl=https://maps.google.com/maps/ms?ie=UTF8&amp;authuser=0&amp;msa=0&amp;output=kml&amp;msid=214097956251705172248.0004d7f42a7e1afbb0b36','2013-03-15 21:02:04');
/*!40000 ALTER TABLE `feed_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `form` (
  `id` int(11) NOT NULL auto_increment,
  `form_title` varchar(200) NOT NULL,
  `form_description` text,
  `form_active` tinyint(4) default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores all report submission forms created(default+custom)';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
INSERT INTO `form` VALUES (1,'Default Form','Default form, for report entry',1);
/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_field`
--

DROP TABLE IF EXISTS `form_field`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `form_field` (
  `id` int(11) NOT NULL auto_increment,
  `form_id` int(11) NOT NULL default '0',
  `field_name` varchar(200) default NULL,
  `field_type` tinyint(4) NOT NULL default '1' COMMENT '1 - TEXTFIELD, 2 - TEXTAREA (FREETEXT), 3 - DATE, 4 - PASSWORD, 5 - RADIO, 6 - CHECKBOX',
  `field_required` tinyint(4) default '0',
  `field_options` text,
  `field_position` tinyint(4) NOT NULL default '0',
  `field_default` varchar(200) default NULL,
  `field_maxlength` int(11) NOT NULL default '0',
  `field_width` smallint(6) NOT NULL default '0',
  `field_height` tinyint(4) default '5',
  `field_isdate` tinyint(4) NOT NULL default '0',
  `field_ispublic_visible` tinyint(4) NOT NULL default '0',
  `field_ispublic_submit` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `fk_form_id` (`form_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all custom form fields created by users';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `form_field`
--

LOCK TABLES `form_field` WRITE;
/*!40000 ALTER TABLE `form_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_field_option`
--

DROP TABLE IF EXISTS `form_field_option`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `form_field_option` (
  `id` int(11) NOT NULL auto_increment,
  `form_field_id` int(11) NOT NULL default '0',
  `option_name` varchar(200) default NULL,
  `option_value` text,
  PRIMARY KEY  (`id`),
  KEY `form_field_id` (`form_field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Options related to custom form fields';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `form_field_option`
--

LOCK TABLES `form_field_option` WRITE;
/*!40000 ALTER TABLE `form_field_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_field_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_response`
--

DROP TABLE IF EXISTS `form_response`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `form_response` (
  `id` bigint(20) NOT NULL auto_increment,
  `form_field_id` int(11) NOT NULL,
  `incident_id` bigint(20) unsigned NOT NULL,
  `form_response` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_form_field_id` (`form_field_id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores responses to custom form fields';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `form_response`
--

LOCK TABLES `form_response` WRITE;
/*!40000 ALTER TABLE `form_response` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `geometry`
--

DROP TABLE IF EXISTS `geometry`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `geometry` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `incident_id` bigint(20) unsigned NOT NULL,
  `geometry` geometry NOT NULL,
  `geometry_label` varchar(150) default NULL,
  `geometry_comment` varchar(255) default NULL,
  `geometry_color` varchar(20) default NULL,
  `geometry_strokewidth` varchar(5) default NULL,
  PRIMARY KEY  (`id`),
  SPATIAL KEY `geometry` (`geometry`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores map geometries i.e polygons, lines etc';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `geometry`
--

LOCK TABLES `geometry` WRITE;
/*!40000 ALTER TABLE `geometry` DISABLE KEYS */;
/*!40000 ALTER TABLE `geometry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident`
--

DROP TABLE IF EXISTS `incident`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `incident` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `location_id` bigint(20) unsigned NOT NULL,
  `form_id` int(11) NOT NULL default '1',
  `locale` varchar(10) NOT NULL default 'en_US',
  `user_id` int(11) unsigned default NULL,
  `incident_title` varchar(255) default NULL,
  `incident_description` longtext,
  `incident_date` datetime default NULL,
  `incident_mode` tinyint(4) NOT NULL default '1' COMMENT '1 - WEB, 2 - SMS, 3 - EMAIL, 4 - TWITTER',
  `incident_active` tinyint(4) NOT NULL default '0',
  `incident_verified` tinyint(4) NOT NULL default '0',
  `incident_dateadd` datetime default NULL,
  `incident_dateadd_gmt` datetime default NULL,
  `incident_datemodify` datetime default NULL,
  `incident_alert_status` tinyint(4) NOT NULL default '0' COMMENT '0 - Not Tagged for Sending, 1 - Tagged for Sending, 2 - Alerts Have Been Sent',
  `incident_zoom` tinyint(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `location_id` (`location_id`),
  KEY `incident_active` (`incident_active`),
  KEY `incident_date` (`incident_date`),
  KEY `form_id` (`form_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores reports submitted';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `incident`
--

LOCK TABLES `incident` WRITE;
/*!40000 ALTER TABLE `incident` DISABLE KEYS */;
INSERT INTO `incident` VALUES (2,2,1,'en_US',NULL,'Próba','Próba','2013-03-15 13:34:00',1,1,0,'2013-03-15 13:35:24',NULL,'2013-03-15 21:33:01',2,8),(3,3,0,'en_US',NULL,'valami','valami','2013-03-15 13:06:00',1,1,0,'2013-03-15 15:06:51',NULL,NULL,2,8);
/*!40000 ALTER TABLE `incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident_category`
--

DROP TABLE IF EXISTS `incident_category`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `incident_category` (
  `id` int(11) NOT NULL auto_increment,
  `incident_id` bigint(20) unsigned NOT NULL default '0',
  `category_id` int(11) unsigned NOT NULL default '5',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `incident_category_ids` (`incident_id`,`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Stores submitted reports categories';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `incident_category`
--

LOCK TABLES `incident_category` WRITE;
/*!40000 ALTER TABLE `incident_category` DISABLE KEYS */;
INSERT INTO `incident_category` VALUES (6,2,1),(4,3,1),(7,2,5);
/*!40000 ALTER TABLE `incident_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident_lang`
--

DROP TABLE IF EXISTS `incident_lang`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `incident_lang` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `incident_id` bigint(20) unsigned NOT NULL,
  `locale` varchar(10) default NULL,
  `incident_title` varchar(255) default NULL,
  `incident_description` longtext,
  PRIMARY KEY  (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds translations for report titles and descriptions';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `incident_lang`
--

LOCK TABLES `incident_lang` WRITE;
/*!40000 ALTER TABLE `incident_lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `incident_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident_person`
--

DROP TABLE IF EXISTS `incident_person`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `incident_person` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `incident_id` bigint(20) unsigned default NULL,
  `person_first` varchar(200) default NULL,
  `person_last` varchar(200) default NULL,
  `person_email` varchar(120) default NULL,
  `person_phone` varchar(60) default NULL,
  `person_ip` varchar(50) default NULL,
  `person_date` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Holds information provided by people who submit reports';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `incident_person`
--

LOCK TABLES `incident_person` WRITE;
/*!40000 ALTER TABLE `incident_person` DISABLE KEYS */;
INSERT INTO `incident_person` VALUES (4,2,'zuzmo','','',NULL,NULL,'2013-03-15 21:33:01'),(2,3,'','','',NULL,NULL,'2013-03-15 15:06:51');
/*!40000 ALTER TABLE `incident_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `layer`
--

DROP TABLE IF EXISTS `layer`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `layer` (
  `id` int(11) NOT NULL auto_increment,
  `layer_name` varchar(255) default NULL,
  `layer_url` varchar(255) default NULL,
  `layer_file` varchar(100) default NULL,
  `layer_color` varchar(20) default NULL,
  `layer_visible` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds static layer information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `layer`
--

LOCK TABLES `layer` WRITE;
/*!40000 ALTER TABLE `layer` DISABLE KEYS */;
/*!40000 ALTER TABLE `layer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `level`
--

DROP TABLE IF EXISTS `level`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `level` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `level_title` varchar(200) default NULL,
  `level_description` varchar(200) default NULL,
  `level_weight` tinyint(4) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Stores level of trust assigned to reporters of the platform';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `level`
--

LOCK TABLES `level` WRITE;
/*!40000 ALTER TABLE `level` DISABLE KEYS */;
INSERT INTO `level` VALUES (1,'SPAM + Delete','SPAM + Delete',-2),(2,'SPAM','SPAM',-1),(3,'Untrusted','Untrusted',0),(4,'Trusted','Trusted',1),(5,'Trusted + Verify','Trusted + Verify',2);
/*!40000 ALTER TABLE `level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `location` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `location_name` varchar(255) default NULL,
  `country_id` int(11) NOT NULL default '0',
  `latitude` double NOT NULL default '0',
  `longitude` double NOT NULL default '0',
  `location_visible` tinyint(4) NOT NULL default '1',
  `location_date` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=MyISAM AUTO_INCREMENT=405 DEFAULT CHARSET=utf8 COMMENT='Stores location information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (6,'Unknown',0,47.179913,18.470764,1,'2013-03-15 19:00:39'),(2,'tatabánya ...',100,47.502579,18.583031,1,'2013-03-15 21:33:01'),(3,'budapest',100,47.498868,19.044456,1,'2013-03-15 15:06:51'),(5,'Unknown',0,47.674637,18.094482,1,'2013-03-15 19:00:39'),(7,'Unknown',0,47.68365,17.809868,1,'2013-03-15 19:00:39'),(8,'Unknown',0,47.743015,18.086243,1,'2013-03-15 19:00:39'),(9,'Unknown',0,47.35185,16.504211,1,'2013-03-15 19:00:39'),(10,'Unknown',0,47.68342,17.87201,1,'2013-03-15 19:00:39'),(11,'Unknown',0,47.450417,18.96474,1,'2013-03-15 19:00:39'),(12,'Unknown',0,47.204643,18.384247,1,'2013-03-15 19:00:39'),(13,'Unknown',0,48.261257,19.324951,1,'2013-03-15 19:00:39'),(14,'Unknown',0,46.63435,17.83081,1,'2013-03-15 19:00:39'),(15,'Unknown',0,47.351616,18.711433,1,'2013-03-15 19:00:39'),(16,'Unknown',0,47.483803,18.605347,1,'2013-03-15 19:00:39'),(17,'Unknown',0,46.99571,18.241425,1,'2013-03-15 19:00:39'),(18,'Unknown',0,46.93901,18.220825,1,'2013-03-15 19:00:39'),(19,'Unknown',0,46.99899,18.198853,1,'2013-03-15 19:00:39'),(20,'Unknown',0,47.113132,18.57788,1,'2013-03-15 19:00:39'),(21,'Unknown',0,47.1164,18.368454,1,'2013-03-15 19:00:39'),(22,'Unknown',0,47.205574,18.411713,1,'2013-03-15 19:00:39'),(23,'Unknown',0,47.3351,17.914581,1,'2013-03-15 19:00:39'),(24,'Unknown',0,47.543163,18.497543,1,'2013-03-15 19:00:39'),(25,'Unknown',0,47.048603,18.634872,1,'2013-03-15 19:00:39'),(26,'Unknown',0,46.0618,18.196106,1,'2013-03-15 19:00:39'),(27,'Unknown',0,47.01116,18.17276,1,'2013-03-15 19:00:39'),(28,'Unknown',0,47.21024,18.404846,1,'2013-03-15 19:00:39'),(29,'Unknown',0,46.080853,18.270264,1,'2013-03-15 19:00:39'),(30,'Unknown',0,47.30531,17.558899,1,'2013-03-15 19:00:39'),(31,'Unknown',0,47.556602,18.483124,1,'2013-03-15 19:00:39'),(32,'Unknown',0,47.2932,17.965393,1,'2013-03-15 19:00:39'),(33,'Unknown',0,47.381615,18.205032,1,'2013-03-15 19:00:39'),(34,'Unknown',0,46.35925,17.793732,1,'2013-03-15 19:00:39'),(35,'Unknown',0,47.680183,17.836304,1,'2013-03-15 19:00:39'),(36,'Unknown',0,47.68388,17.878876,1,'2013-03-15 19:00:39'),(37,'Unknown',0,47.967857,20.028076,1,'2013-03-15 19:00:39'),(38,'Unknown',0,45.981693,18.259277,1,'2013-03-15 19:00:39'),(39,'Unknown',0,46.98025,17.841797,1,'2013-03-15 19:00:39'),(40,'Unknown',0,49.16734,18.500977,1,'2013-03-15 19:00:39'),(41,'Unknown',0,47.712536,18.002472,1,'2013-03-15 19:00:39'),(42,'Unknown',0,47.790092,18.742676,1,'2013-03-15 19:00:39'),(43,'Unknown',0,47.684227,17.825317,1,'2013-03-15 19:00:39'),(44,'Unknown',0,46.255848,17.050781,1,'2013-03-15 19:00:39'),(45,'Unknown',0,48.188065,16.347656,1,'2013-03-15 19:00:39'),(46,'Unknown',0,47.68573,18.27301,1,'2013-03-15 19:00:39'),(47,'Unknown',0,47.171043,18.393173,1,'2013-03-15 19:00:39'),(48,'Unknown',0,47.637173,18.338928,1,'2013-03-15 19:00:39'),(49,'Unknown',0,47.637634,18.296356,1,'2013-03-15 19:00:39'),(50,'Unknown',0,47.635784,18.318329,1,'2013-03-15 19:00:39'),(51,'Unknown',0,47.40346,18.878632,1,'2013-03-15 19:00:39'),(52,'Unknown',0,47.271774,15.490723,1,'2013-03-15 19:00:39'),(53,'Unknown',0,47.017715,17.979126,1,'2013-03-15 19:00:39'),(54,'Unknown',0,46.976505,19.11621,1,'2013-03-15 19:00:39'),(55,'Unknown',0,47.674637,18.094482,1,'2013-03-15 19:00:42'),(56,'Unknown',0,47.179913,18.470764,1,'2013-03-15 19:00:42'),(57,'Unknown',0,47.68365,17.809868,1,'2013-03-15 19:00:42'),(58,'Unknown',0,47.743015,18.086243,1,'2013-03-15 19:00:42'),(59,'Unknown',0,47.35185,16.504211,1,'2013-03-15 19:00:42'),(60,'Unknown',0,47.68342,17.87201,1,'2013-03-15 19:00:42'),(61,'Unknown',0,47.450417,18.96474,1,'2013-03-15 19:00:42'),(62,'Unknown',0,47.204643,18.384247,1,'2013-03-15 19:00:42'),(63,'Unknown',0,48.261257,19.324951,1,'2013-03-15 19:00:42'),(64,'Unknown',0,46.63435,17.83081,1,'2013-03-15 19:00:42'),(65,'Unknown',0,47.351616,18.711433,1,'2013-03-15 19:00:42'),(66,'Unknown',0,47.483803,18.605347,1,'2013-03-15 19:00:42'),(67,'Unknown',0,46.99571,18.241425,1,'2013-03-15 19:00:42'),(68,'Unknown',0,46.93901,18.220825,1,'2013-03-15 19:00:42'),(69,'Unknown',0,46.99899,18.198853,1,'2013-03-15 19:00:42'),(70,'Unknown',0,47.113132,18.57788,1,'2013-03-15 19:00:42'),(71,'Unknown',0,47.1164,18.368454,1,'2013-03-15 19:00:42'),(72,'Unknown',0,47.205574,18.411713,1,'2013-03-15 19:00:42'),(73,'Unknown',0,47.3351,17.914581,1,'2013-03-15 19:00:42'),(74,'Unknown',0,47.543163,18.497543,1,'2013-03-15 19:00:42'),(75,'Unknown',0,47.048603,18.634872,1,'2013-03-15 19:00:42'),(76,'Unknown',0,46.0618,18.196106,1,'2013-03-15 19:00:42'),(77,'Unknown',0,47.01116,18.17276,1,'2013-03-15 19:00:42'),(78,'Unknown',0,47.21024,18.404846,1,'2013-03-15 19:00:42'),(79,'Unknown',0,46.080853,18.270264,1,'2013-03-15 19:00:42'),(80,'Unknown',0,47.30531,17.558899,1,'2013-03-15 19:00:42'),(81,'Unknown',0,47.556602,18.483124,1,'2013-03-15 19:00:42'),(82,'Unknown',0,47.2932,17.965393,1,'2013-03-15 19:00:42'),(83,'Unknown',0,47.381615,18.205032,1,'2013-03-15 19:00:42'),(84,'Unknown',0,46.35925,17.793732,1,'2013-03-15 19:00:42'),(85,'Unknown',0,47.680183,17.836304,1,'2013-03-15 19:00:42'),(86,'Unknown',0,47.68388,17.878876,1,'2013-03-15 19:00:42'),(87,'Unknown',0,47.967857,20.028076,1,'2013-03-15 19:00:42'),(88,'Unknown',0,45.981693,18.259277,1,'2013-03-15 19:00:42'),(89,'Unknown',0,46.98025,17.841797,1,'2013-03-15 19:00:42'),(90,'Unknown',0,49.16734,18.500977,1,'2013-03-15 19:00:42'),(91,'Unknown',0,47.712536,18.002472,1,'2013-03-15 19:00:42'),(92,'Unknown',0,47.790092,18.742676,1,'2013-03-15 19:00:42'),(93,'Unknown',0,47.684227,17.825317,1,'2013-03-15 19:00:42'),(94,'Unknown',0,46.255848,17.050781,1,'2013-03-15 19:00:42'),(95,'Unknown',0,48.188065,16.347656,1,'2013-03-15 19:00:42'),(96,'Unknown',0,47.68573,18.27301,1,'2013-03-15 19:00:42'),(97,'Unknown',0,47.171043,18.393173,1,'2013-03-15 19:00:42'),(98,'Unknown',0,47.637173,18.338928,1,'2013-03-15 19:00:42'),(99,'Unknown',0,47.637634,18.296356,1,'2013-03-15 19:00:42'),(100,'Unknown',0,47.635784,18.318329,1,'2013-03-15 19:00:42'),(101,'Unknown',0,47.40346,18.878632,1,'2013-03-15 19:00:42'),(102,'Unknown',0,47.271774,15.490723,1,'2013-03-15 19:00:42'),(103,'Unknown',0,47.017715,17.979126,1,'2013-03-15 19:00:42'),(104,'Unknown',0,46.976505,19.11621,1,'2013-03-15 19:00:42'),(105,'Unknown',0,47.674637,18.094482,1,'2013-03-15 19:01:04'),(106,'Unknown',0,47.179913,18.470764,1,'2013-03-15 19:01:04'),(107,'Unknown',0,47.68365,17.809868,1,'2013-03-15 19:01:04'),(108,'Unknown',0,47.743015,18.086243,1,'2013-03-15 19:01:04'),(109,'Unknown',0,47.35185,16.504211,1,'2013-03-15 19:01:04'),(110,'Unknown',0,47.68342,17.87201,1,'2013-03-15 19:01:04'),(111,'Unknown',0,47.450417,18.96474,1,'2013-03-15 19:01:04'),(112,'Unknown',0,47.204643,18.384247,1,'2013-03-15 19:01:04'),(113,'Unknown',0,48.261257,19.324951,1,'2013-03-15 19:01:04'),(114,'Unknown',0,46.63435,17.83081,1,'2013-03-15 19:01:04'),(115,'Unknown',0,47.351616,18.711433,1,'2013-03-15 19:01:04'),(116,'Unknown',0,47.483803,18.605347,1,'2013-03-15 19:01:04'),(117,'Unknown',0,46.99571,18.241425,1,'2013-03-15 19:01:04'),(118,'Unknown',0,46.93901,18.220825,1,'2013-03-15 19:01:04'),(119,'Unknown',0,46.99899,18.198853,1,'2013-03-15 19:01:04'),(120,'Unknown',0,47.113132,18.57788,1,'2013-03-15 19:01:04'),(121,'Unknown',0,47.1164,18.368454,1,'2013-03-15 19:01:04'),(122,'Unknown',0,47.205574,18.411713,1,'2013-03-15 19:01:04'),(123,'Unknown',0,47.3351,17.914581,1,'2013-03-15 19:01:04'),(124,'Unknown',0,47.543163,18.497543,1,'2013-03-15 19:01:04'),(125,'Unknown',0,47.048603,18.634872,1,'2013-03-15 19:01:04'),(126,'Unknown',0,46.0618,18.196106,1,'2013-03-15 19:01:04'),(127,'Unknown',0,47.01116,18.17276,1,'2013-03-15 19:01:04'),(128,'Unknown',0,47.21024,18.404846,1,'2013-03-15 19:01:04'),(129,'Unknown',0,46.080853,18.270264,1,'2013-03-15 19:01:04'),(130,'Unknown',0,47.30531,17.558899,1,'2013-03-15 19:01:04'),(131,'Unknown',0,47.556602,18.483124,1,'2013-03-15 19:01:04'),(132,'Unknown',0,47.2932,17.965393,1,'2013-03-15 19:01:04'),(133,'Unknown',0,47.381615,18.205032,1,'2013-03-15 19:01:04'),(134,'Unknown',0,46.35925,17.793732,1,'2013-03-15 19:01:04'),(135,'Unknown',0,47.680183,17.836304,1,'2013-03-15 19:01:04'),(136,'Unknown',0,47.68388,17.878876,1,'2013-03-15 19:01:04'),(137,'Unknown',0,47.967857,20.028076,1,'2013-03-15 19:01:05'),(138,'Unknown',0,45.981693,18.259277,1,'2013-03-15 19:01:05'),(139,'Unknown',0,46.98025,17.841797,1,'2013-03-15 19:01:05'),(140,'Unknown',0,49.16734,18.500977,1,'2013-03-15 19:01:05'),(141,'Unknown',0,47.712536,18.002472,1,'2013-03-15 19:01:05'),(142,'Unknown',0,47.790092,18.742676,1,'2013-03-15 19:01:05'),(143,'Unknown',0,47.684227,17.825317,1,'2013-03-15 19:01:05'),(144,'Unknown',0,46.255848,17.050781,1,'2013-03-15 19:01:05'),(145,'Unknown',0,48.188065,16.347656,1,'2013-03-15 19:01:05'),(146,'Unknown',0,47.68573,18.27301,1,'2013-03-15 19:01:05'),(147,'Unknown',0,47.171043,18.393173,1,'2013-03-15 19:01:05'),(148,'Unknown',0,47.637173,18.338928,1,'2013-03-15 19:01:05'),(149,'Unknown',0,47.637634,18.296356,1,'2013-03-15 19:01:05'),(150,'Unknown',0,47.635784,18.318329,1,'2013-03-15 19:01:05'),(151,'Unknown',0,47.40346,18.878632,1,'2013-03-15 19:01:05'),(152,'Unknown',0,47.271774,15.490723,1,'2013-03-15 19:01:05'),(153,'Unknown',0,47.017715,17.979126,1,'2013-03-15 19:01:05'),(154,'Unknown',0,46.976505,19.11621,1,'2013-03-15 19:01:05'),(155,'Unknown',0,47.674637,18.094482,1,'2013-03-15 20:08:15'),(156,'Unknown',0,47.148975,18.432602,1,'2013-03-15 20:08:15'),(157,'Unknown',0,47.68388,17.812958,1,'2013-03-15 20:08:15'),(158,'Unknown',0,47.390446,17.801285,1,'2013-03-15 20:08:15'),(159,'Unknown',0,46.927757,18.240738,1,'2013-03-15 20:08:15'),(160,'Unknown',0,47.683304,17.871838,1,'2013-03-15 20:08:15'),(161,'Unknown',0,47.450417,18.96474,1,'2013-03-15 20:08:15'),(162,'Unknown',0,47.219566,18.061523,1,'2013-03-15 20:08:15'),(163,'Unknown',0,48.261257,19.324951,1,'2013-03-15 20:08:15'),(164,'Unknown',0,46.779373,17.679749,1,'2013-03-15 20:08:15'),(165,'Unknown',0,47.41322,18.93219,1,'2013-03-15 20:08:15'),(166,'Unknown',0,47.483803,18.605347,1,'2013-03-15 20:08:15'),(167,'Unknown',0,46.99571,18.241425,1,'2013-03-15 20:08:15'),(168,'Unknown',0,46.93901,18.220825,1,'2013-03-15 20:08:15'),(169,'Unknown',0,46.890232,18.204346,1,'2013-03-15 20:08:15'),(170,'Unknown',0,47.189713,18.632812,1,'2013-03-15 20:08:15'),(171,'Unknown',0,47.119934,18.373432,1,'2013-03-15 20:08:15'),(172,'Unknown',0,47.195282,18.418987,1,'2013-03-15 20:08:15'),(173,'Unknown',0,47.062637,18.544922,1,'2013-03-15 20:08:15'),(174,'Unknown',0,47.543163,18.497543,1,'2013-03-15 20:08:15'),(175,'Unknown',0,47.048603,18.634872,1,'2013-03-15 20:08:15'),(176,'Unknown',0,46.0618,18.196106,1,'2013-03-15 20:08:15'),(177,'Unknown',0,47.01116,18.17276,1,'2013-03-15 20:08:15'),(178,'Unknown',0,47.21024,18.404846,1,'2013-03-15 20:08:15'),(179,'Unknown',0,46.080853,18.270264,1,'2013-03-15 20:08:15'),(180,'Unknown',0,47.30531,17.558899,1,'2013-03-15 20:08:15'),(181,'Unknown',0,47.587643,18.573761,1,'2013-03-15 20:08:15'),(182,'Unknown',0,47.2932,17.965393,1,'2013-03-15 20:08:15'),(183,'Unknown',0,47.295998,18.207092,1,'2013-03-15 20:08:15'),(184,'Unknown',0,46.35925,17.793732,1,'2013-03-15 20:08:15'),(185,'Unknown',0,47.678333,17.837677,1,'2013-03-15 20:08:15'),(186,'Unknown',0,47.68388,17.878876,1,'2013-03-15 20:08:15'),(187,'Unknown',0,47.967857,20.028076,1,'2013-03-15 20:08:15'),(188,'Unknown',0,45.981693,18.259277,1,'2013-03-15 20:08:15'),(189,'Unknown',0,53.755207,17.720947,1,'2013-03-15 20:08:15'),(190,'Unknown',0,47.256863,17.424316,1,'2013-03-15 20:08:15'),(191,'Unknown',0,47.712536,18.002472,1,'2013-03-15 20:08:15'),(192,'Unknown',0,47.790092,18.742676,1,'2013-03-15 20:08:15'),(193,'Unknown',0,47.684227,17.825317,1,'2013-03-15 20:08:15'),(194,'Unknown',0,46.255848,17.050781,1,'2013-03-15 20:08:15'),(195,'Unknown',0,48.188065,16.347656,1,'2013-03-15 20:08:15'),(196,'Unknown',0,47.198112,18.135681,1,'2013-03-15 20:08:15'),(197,'Unknown',0,47.195908,18.398539,1,'2013-03-15 20:08:15'),(198,'Unknown',0,47.637173,18.338928,1,'2013-03-15 20:08:15'),(199,'Unknown',0,47.637634,18.296356,1,'2013-03-15 20:08:15'),(200,'Unknown',0,47.635784,18.318329,1,'2013-03-15 20:08:15'),(201,'Unknown',0,47.4253,18.792114,1,'2013-03-15 20:08:15'),(202,'Unknown',0,47.271774,15.490723,1,'2013-03-15 20:08:15'),(203,'Unknown',0,47.017715,17.979126,1,'2013-03-15 20:08:15'),(204,'Unknown',0,46.77373,18.684998,1,'2013-03-15 20:08:15'),(205,'Unknown',0,47.674637,18.094482,1,'2013-03-15 20:08:24'),(206,'Unknown',0,47.148975,18.432602,1,'2013-03-15 20:08:24'),(207,'Unknown',0,47.68388,17.812958,1,'2013-03-15 20:08:24'),(208,'Unknown',0,47.390446,17.801285,1,'2013-03-15 20:08:24'),(209,'Unknown',0,46.927757,18.240738,1,'2013-03-15 20:08:24'),(210,'Unknown',0,47.683304,17.871838,1,'2013-03-15 20:08:24'),(211,'Unknown',0,47.450417,18.96474,1,'2013-03-15 20:08:24'),(212,'Unknown',0,47.219566,18.061523,1,'2013-03-15 20:08:24'),(213,'Unknown',0,48.261257,19.324951,1,'2013-03-15 20:08:24'),(214,'Unknown',0,46.779373,17.679749,1,'2013-03-15 20:08:24'),(215,'Unknown',0,47.41322,18.93219,1,'2013-03-15 20:08:24'),(216,'Unknown',0,47.483803,18.605347,1,'2013-03-15 20:08:24'),(217,'Unknown',0,46.99571,18.241425,1,'2013-03-15 20:08:24'),(218,'Unknown',0,46.93901,18.220825,1,'2013-03-15 20:08:24'),(219,'Unknown',0,46.890232,18.204346,1,'2013-03-15 20:08:24'),(220,'Unknown',0,47.189713,18.632812,1,'2013-03-15 20:08:24'),(221,'Unknown',0,47.119934,18.373432,1,'2013-03-15 20:08:24'),(222,'Unknown',0,47.195282,18.418987,1,'2013-03-15 20:08:24'),(223,'Unknown',0,47.062637,18.544922,1,'2013-03-15 20:08:24'),(224,'Unknown',0,47.543163,18.497543,1,'2013-03-15 20:08:24'),(225,'Unknown',0,47.048603,18.634872,1,'2013-03-15 20:08:24'),(226,'Unknown',0,46.0618,18.196106,1,'2013-03-15 20:08:24'),(227,'Unknown',0,47.01116,18.17276,1,'2013-03-15 20:08:24'),(228,'Unknown',0,47.21024,18.404846,1,'2013-03-15 20:08:24'),(229,'Unknown',0,46.080853,18.270264,1,'2013-03-15 20:08:24'),(230,'Unknown',0,47.30531,17.558899,1,'2013-03-15 20:08:24'),(231,'Unknown',0,47.587643,18.573761,1,'2013-03-15 20:08:24'),(232,'Unknown',0,47.2932,17.965393,1,'2013-03-15 20:08:24'),(233,'Unknown',0,47.295998,18.207092,1,'2013-03-15 20:08:24'),(234,'Unknown',0,46.35925,17.793732,1,'2013-03-15 20:08:24'),(235,'Unknown',0,47.678333,17.837677,1,'2013-03-15 20:08:24'),(236,'Unknown',0,47.68388,17.878876,1,'2013-03-15 20:08:24'),(237,'Unknown',0,47.967857,20.028076,1,'2013-03-15 20:08:24'),(238,'Unknown',0,45.981693,18.259277,1,'2013-03-15 20:08:24'),(239,'Unknown',0,53.755207,17.720947,1,'2013-03-15 20:08:24'),(240,'Unknown',0,47.256863,17.424316,1,'2013-03-15 20:08:24'),(241,'Unknown',0,47.712536,18.002472,1,'2013-03-15 20:08:24'),(242,'Unknown',0,47.790092,18.742676,1,'2013-03-15 20:08:24'),(243,'Unknown',0,47.684227,17.825317,1,'2013-03-15 20:08:24'),(244,'Unknown',0,46.255848,17.050781,1,'2013-03-15 20:08:24'),(245,'Unknown',0,48.188065,16.347656,1,'2013-03-15 20:08:24'),(246,'Unknown',0,47.198112,18.135681,1,'2013-03-15 20:08:24'),(247,'Unknown',0,47.195908,18.398539,1,'2013-03-15 20:08:24'),(248,'Unknown',0,47.637173,18.338928,1,'2013-03-15 20:08:24'),(249,'Unknown',0,47.637634,18.296356,1,'2013-03-15 20:08:24'),(250,'Unknown',0,47.635784,18.318329,1,'2013-03-15 20:08:24'),(251,'Unknown',0,47.4253,18.792114,1,'2013-03-15 20:08:24'),(252,'Unknown',0,47.271774,15.490723,1,'2013-03-15 20:08:24'),(253,'Unknown',0,47.017715,17.979126,1,'2013-03-15 20:08:24'),(254,'Unknown',0,46.77373,18.684998,1,'2013-03-15 20:08:24'),(255,'Unknown',0,47.674637,18.094482,1,'2013-03-15 20:08:31'),(256,'Unknown',0,47.148975,18.432602,1,'2013-03-15 20:08:31'),(257,'Unknown',0,47.68388,17.812958,1,'2013-03-15 20:08:31'),(258,'Unknown',0,47.390446,17.801285,1,'2013-03-15 20:08:31'),(259,'Unknown',0,46.927757,18.240738,1,'2013-03-15 20:08:31'),(260,'Unknown',0,47.683304,17.871838,1,'2013-03-15 20:08:31'),(261,'Unknown',0,47.450417,18.96474,1,'2013-03-15 20:08:31'),(262,'Unknown',0,47.219566,18.061523,1,'2013-03-15 20:08:31'),(263,'Unknown',0,48.261257,19.324951,1,'2013-03-15 20:08:31'),(264,'Unknown',0,46.779373,17.679749,1,'2013-03-15 20:08:31'),(265,'Unknown',0,47.41322,18.93219,1,'2013-03-15 20:08:31'),(266,'Unknown',0,47.483803,18.605347,1,'2013-03-15 20:08:31'),(267,'Unknown',0,46.99571,18.241425,1,'2013-03-15 20:08:31'),(268,'Unknown',0,46.93901,18.220825,1,'2013-03-15 20:08:31'),(269,'Unknown',0,46.890232,18.204346,1,'2013-03-15 20:08:31'),(270,'Unknown',0,47.189713,18.632812,1,'2013-03-15 20:08:31'),(271,'Unknown',0,47.119934,18.373432,1,'2013-03-15 20:08:31'),(272,'Unknown',0,47.195282,18.418987,1,'2013-03-15 20:08:31'),(273,'Unknown',0,47.062637,18.544922,1,'2013-03-15 20:08:31'),(274,'Unknown',0,47.543163,18.497543,1,'2013-03-15 20:08:31'),(275,'Unknown',0,47.048603,18.634872,1,'2013-03-15 20:08:31'),(276,'Unknown',0,46.0618,18.196106,1,'2013-03-15 20:08:31'),(277,'Unknown',0,47.01116,18.17276,1,'2013-03-15 20:08:31'),(278,'Unknown',0,47.21024,18.404846,1,'2013-03-15 20:08:31'),(279,'Unknown',0,46.080853,18.270264,1,'2013-03-15 20:08:31'),(280,'Unknown',0,47.30531,17.558899,1,'2013-03-15 20:08:31'),(281,'Unknown',0,47.587643,18.573761,1,'2013-03-15 20:08:31'),(282,'Unknown',0,47.2932,17.965393,1,'2013-03-15 20:08:31'),(283,'Unknown',0,47.295998,18.207092,1,'2013-03-15 20:08:31'),(284,'Unknown',0,46.35925,17.793732,1,'2013-03-15 20:08:31'),(285,'Unknown',0,47.678333,17.837677,1,'2013-03-15 20:08:31'),(286,'Unknown',0,47.68388,17.878876,1,'2013-03-15 20:08:31'),(287,'Unknown',0,47.967857,20.028076,1,'2013-03-15 20:08:31'),(288,'Unknown',0,45.981693,18.259277,1,'2013-03-15 20:08:31'),(289,'Unknown',0,53.755207,17.720947,1,'2013-03-15 20:08:31'),(290,'Unknown',0,47.256863,17.424316,1,'2013-03-15 20:08:31'),(291,'Unknown',0,47.712536,18.002472,1,'2013-03-15 20:08:31'),(292,'Unknown',0,47.790092,18.742676,1,'2013-03-15 20:08:31'),(293,'Unknown',0,47.684227,17.825317,1,'2013-03-15 20:08:31'),(294,'Unknown',0,46.255848,17.050781,1,'2013-03-15 20:08:31'),(295,'Unknown',0,48.188065,16.347656,1,'2013-03-15 20:08:31'),(296,'Unknown',0,47.198112,18.135681,1,'2013-03-15 20:08:31'),(297,'Unknown',0,47.195908,18.398539,1,'2013-03-15 20:08:31'),(298,'Unknown',0,47.637173,18.338928,1,'2013-03-15 20:08:31'),(299,'Unknown',0,47.637634,18.296356,1,'2013-03-15 20:08:31'),(300,'Unknown',0,47.635784,18.318329,1,'2013-03-15 20:08:31'),(301,'Unknown',0,47.4253,18.792114,1,'2013-03-15 20:08:31'),(302,'Unknown',0,47.271774,15.490723,1,'2013-03-15 20:08:31'),(303,'Unknown',0,47.017715,17.979126,1,'2013-03-15 20:08:31'),(304,'Unknown',0,46.77373,18.684998,1,'2013-03-15 20:08:31'),(305,'Unknown',0,47.148975,18.432602,1,'2013-03-15 21:01:55'),(306,'Unknown',0,47.68631,17.813301,1,'2013-03-15 21:01:55'),(307,'Unknown',0,47.33882,17.753906,1,'2013-03-15 21:01:55'),(308,'Unknown',0,46.927757,18.240738,1,'2013-03-15 21:01:55'),(309,'Unknown',0,47.684113,17.868576,1,'2013-03-15 21:01:55'),(310,'Unknown',0,47.450417,18.96474,1,'2013-03-15 21:01:55'),(311,'Unknown',0,47.20477,18.385996,1,'2013-03-15 21:01:55'),(312,'Unknown',0,47.94211,21.714478,1,'2013-03-15 21:01:55'),(313,'Unknown',0,46.779373,17.679749,1,'2013-03-15 21:01:55'),(314,'Unknown',0,47.41322,18.93219,1,'2013-03-15 21:01:55'),(315,'Unknown',0,47.483803,18.605347,1,'2013-03-15 21:01:55'),(316,'Unknown',0,46.99571,18.241425,1,'2013-03-15 21:01:55'),(317,'Unknown',0,46.93901,18.220825,1,'2013-03-15 21:01:55'),(318,'Unknown',0,47.201492,18.246918,1,'2013-03-15 21:01:55'),(319,'Unknown',0,47.109085,18.583223,1,'2013-03-15 21:01:55'),(320,'Unknown',0,47.119934,18.373432,1,'2013-03-15 21:01:55'),(321,'Unknown',0,47.195282,18.418987,1,'2013-03-15 21:01:55'),(322,'Unknown',0,47.062637,18.544922,1,'2013-03-15 21:01:55'),(323,'Unknown',0,47.74117,18.308716,1,'2013-03-15 21:01:55'),(324,'Unknown',0,47.049072,18.634186,1,'2013-03-15 21:01:55'),(325,'Unknown',0,46.0618,18.196106,1,'2013-03-15 21:01:55'),(326,'Unknown',0,47.01116,18.17276,1,'2013-03-15 21:01:55'),(327,'Unknown',0,47.21024,18.404846,1,'2013-03-15 21:01:55'),(328,'Unknown',0,46.080853,18.270264,1,'2013-03-15 21:01:55'),(329,'Unknown',0,47.563553,17.363892,1,'2013-03-15 21:01:55'),(330,'Unknown',0,47.587643,18.573761,1,'2013-03-15 21:01:55'),(331,'Unknown',0,47.2932,17.965393,1,'2013-03-15 21:01:55'),(332,'Unknown',0,47.361618,18.211212,1,'2013-03-15 21:01:55'),(333,'Unknown',0,46.35925,17.793732,1,'2013-03-15 21:01:55'),(334,'Unknown',0,47.678333,17.837677,1,'2013-03-15 21:01:55'),(335,'Unknown',0,47.967857,20.028076,1,'2013-03-15 21:01:55'),(336,'Unknown',0,45.981693,18.259277,1,'2013-03-15 21:01:55'),(337,'Unknown',0,47.30531,18.248291,1,'2013-03-15 21:01:55'),(338,'Unknown',0,47.344406,17.484741,1,'2013-03-15 21:01:55'),(339,'Unknown',0,47.712536,18.002472,1,'2013-03-15 21:01:55'),(340,'Unknown',0,47.805775,18.753662,1,'2013-03-15 21:01:55'),(341,'Unknown',0,47.684227,17.825317,1,'2013-03-15 21:01:55'),(342,'Unknown',0,46.255848,17.050781,1,'2013-03-15 21:01:55'),(343,'Unknown',0,47.994057,16.539574,1,'2013-03-15 21:01:55'),(344,'Unknown',0,47.197178,18.134308,1,'2013-03-15 21:01:55'),(345,'Unknown',0,47.195908,18.398539,1,'2013-03-15 21:01:55'),(346,'Unknown',0,47.637173,18.338928,1,'2013-03-15 21:01:55'),(347,'Unknown',0,47.637634,18.296356,1,'2013-03-15 21:01:55'),(348,'Unknown',0,47.635784,18.318329,1,'2013-03-15 21:01:55'),(349,'Unknown',0,47.4253,18.792114,1,'2013-03-15 21:01:55'),(350,'Unknown',0,47.62653,17.60559,1,'2013-03-15 21:01:55'),(351,'Unknown',0,46.960106,17.891235,1,'2013-03-15 21:01:55'),(352,'Unknown',0,46.822617,18.737183,1,'2013-03-15 21:01:55'),(353,'Unknown',0,47.455486,18.962402,1,'2013-03-15 21:01:55'),(354,'Unknown',0,47.062637,18.424072,1,'2013-03-15 21:01:55'),(355,'Unknown',0,47.148975,18.432602,1,'2013-03-15 21:02:03'),(356,'Unknown',0,47.68631,17.813301,1,'2013-03-15 21:02:03'),(357,'Unknown',0,47.33882,17.753906,1,'2013-03-15 21:02:03'),(358,'Unknown',0,46.927757,18.240738,1,'2013-03-15 21:02:03'),(359,'Unknown',0,47.684113,17.868576,1,'2013-03-15 21:02:03'),(360,'Unknown',0,47.450417,18.96474,1,'2013-03-15 21:02:03'),(361,'Unknown',0,47.20477,18.385996,1,'2013-03-15 21:02:03'),(362,'Unknown',0,47.94211,21.714478,1,'2013-03-15 21:02:03'),(363,'Unknown',0,46.779373,17.679749,1,'2013-03-15 21:02:03'),(364,'Unknown',0,47.41322,18.93219,1,'2013-03-15 21:02:03'),(365,'Unknown',0,47.483803,18.605347,1,'2013-03-15 21:02:03'),(366,'Unknown',0,46.99571,18.241425,1,'2013-03-15 21:02:03'),(367,'Unknown',0,46.93901,18.220825,1,'2013-03-15 21:02:03'),(368,'Unknown',0,47.201492,18.246918,1,'2013-03-15 21:02:03'),(369,'Unknown',0,47.109085,18.583223,1,'2013-03-15 21:02:03'),(370,'Unknown',0,47.119934,18.373432,1,'2013-03-15 21:02:03'),(371,'Unknown',0,47.195282,18.418987,1,'2013-03-15 21:02:03'),(372,'Unknown',0,47.062637,18.544922,1,'2013-03-15 21:02:04'),(373,'Unknown',0,47.74117,18.308716,1,'2013-03-15 21:02:04'),(374,'Unknown',0,47.049072,18.634186,1,'2013-03-15 21:02:04'),(375,'Unknown',0,46.0618,18.196106,1,'2013-03-15 21:02:04'),(376,'Unknown',0,47.01116,18.17276,1,'2013-03-15 21:02:04'),(377,'Unknown',0,47.21024,18.404846,1,'2013-03-15 21:02:04'),(378,'Unknown',0,46.080853,18.270264,1,'2013-03-15 21:02:04'),(379,'Unknown',0,47.563553,17.363892,1,'2013-03-15 21:02:04'),(380,'Unknown',0,47.587643,18.573761,1,'2013-03-15 21:02:04'),(381,'Unknown',0,47.2932,17.965393,1,'2013-03-15 21:02:04'),(382,'Unknown',0,47.361618,18.211212,1,'2013-03-15 21:02:04'),(383,'Unknown',0,46.35925,17.793732,1,'2013-03-15 21:02:04'),(384,'Unknown',0,47.678333,17.837677,1,'2013-03-15 21:02:04'),(385,'Unknown',0,47.967857,20.028076,1,'2013-03-15 21:02:04'),(386,'Unknown',0,45.981693,18.259277,1,'2013-03-15 21:02:04'),(387,'Unknown',0,47.30531,18.248291,1,'2013-03-15 21:02:04'),(388,'Unknown',0,47.344406,17.484741,1,'2013-03-15 21:02:04'),(389,'Unknown',0,47.712536,18.002472,1,'2013-03-15 21:02:04'),(390,'Unknown',0,47.805775,18.753662,1,'2013-03-15 21:02:04'),(391,'Unknown',0,47.684227,17.825317,1,'2013-03-15 21:02:04'),(392,'Unknown',0,46.255848,17.050781,1,'2013-03-15 21:02:04'),(393,'Unknown',0,47.994057,16.539574,1,'2013-03-15 21:02:04'),(394,'Unknown',0,47.197178,18.134308,1,'2013-03-15 21:02:04'),(395,'Unknown',0,47.195908,18.398539,1,'2013-03-15 21:02:04'),(396,'Unknown',0,47.637173,18.338928,1,'2013-03-15 21:02:04'),(397,'Unknown',0,47.637634,18.296356,1,'2013-03-15 21:02:04'),(398,'Unknown',0,47.635784,18.318329,1,'2013-03-15 21:02:04'),(399,'Unknown',0,47.4253,18.792114,1,'2013-03-15 21:02:04'),(400,'Unknown',0,47.62653,17.60559,1,'2013-03-15 21:02:04'),(401,'Unknown',0,46.960106,17.891235,1,'2013-03-15 21:02:04'),(402,'Unknown',0,46.822617,18.737183,1,'2013-03-15 21:02:04'),(403,'Unknown',0,47.455486,18.962402,1,'2013-03-15 21:02:04'),(404,'Unknown',0,47.062637,18.424072,1,'2013-03-15 21:02:04');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `maintenance` (
  `allowed_ip` varchar(15) NOT NULL,
  PRIMARY KEY  (`allowed_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Puts a site in maintenance mode if data exists in this table';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `maintenance`
--

LOCK TABLES `maintenance` WRITE;
/*!40000 ALTER TABLE `maintenance` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `location_id` bigint(20) unsigned default NULL,
  `incident_id` bigint(20) unsigned default NULL,
  `checkin_id` bigint(20) unsigned default NULL,
  `message_id` bigint(20) unsigned default NULL,
  `badge_id` int(11) default NULL,
  `media_type` tinyint(4) default NULL COMMENT '1 - IMAGES, 2 - VIDEO, 3 - AUDIO, 4 - NEWS, 5 - PODCAST',
  `media_title` varchar(255) default NULL,
  `media_description` longtext,
  `media_link` varchar(255) default NULL,
  `media_medium` varchar(255) default NULL,
  `media_thumb` varchar(255) default NULL,
  `media_date` datetime default NULL,
  `media_active` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `location_id` (`location_id`),
  KEY `checkin_id` (`checkin_id`),
  KEY `badge_id` (`badge_id`),
  KEY `message_id` (`message_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores any media submitted along with a report/checkin';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'banner_1363343582.jpg','banner_1363343582_m.jpg','banner_1363343582_t.jpg','2013-03-15 10:33:02',1),(2,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'banner_1363343888.jpg','banner_1363343888_m.jpg','banner_1363343888_t.jpg','2013-03-15 10:38:08',1),(3,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'banner_1363344906.jpg','banner_1363344906_m.jpg','banner_1363344906_t.jpg','2013-03-15 10:55:06',1);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `message` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `parent_id` bigint(20) default '0',
  `incident_id` bigint(20) unsigned default '0',
  `user_id` int(11) unsigned default '0',
  `reporter_id` bigint(20) unsigned default NULL,
  `service_messageid` varchar(100) default NULL,
  `message_from` varchar(100) default NULL,
  `message_to` varchar(100) default NULL,
  `message` text,
  `message_detail` text,
  `message_type` tinyint(4) default '1' COMMENT '1 - INBOX, 2 - OUTBOX (From Admin), 3 - DELETED',
  `message_date` datetime default NULL,
  `message_level` tinyint(4) default '0' COMMENT '0 - UNREAD, 1 - READ, 99 - SPAM',
  `latitude` double default NULL,
  `longitude` double default NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `incident_id` (`incident_id`),
  KEY `reporter_id` (`reporter_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores tweets, emails and SMS messages';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,0,0,0,1,NULL,'36209221595','','Test5',NULL,1,'2013-03-15 21:35:18',0,NULL,NULL);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexmo`
--

DROP TABLE IF EXISTS `nexmo`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `nexmo` (
  `id` int(11) NOT NULL auto_increment,
  `nexmo_api_secret` varchar(50) NOT NULL,
  `nexmo_api_key` varchar(50) NOT NULL,
  `nexmo_phone_no` varchar(25) default NULL,
  `delivery_receipt_key` varchar(255) default NULL,
  `inbound_message_key` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `nexmo`
--

LOCK TABLES `nexmo` WRITE;
/*!40000 ALTER TABLE `nexmo` DISABLE KEYS */;
INSERT INTO `nexmo` VALUES (1,'bb293675','4ba3890b','36707177179','4ba3890b','4ba3890b');
/*!40000 ALTER TABLE `nexmo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexmo_message_log`
--

DROP TABLE IF EXISTS `nexmo_message_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `nexmo_message_log` (
  `id` int(11) NOT NULL auto_increment,
  `message_id` varchar(255) NOT NULL,
  `message_recipient` varchar(25) default NULL,
  `message_sender` varchar(25) default NULL,
  `message_type` tinyint(4) NOT NULL default '0',
  `delivery_status` tinyint(4) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `message_id` (`message_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `nexmo_message_log`
--

LOCK TABLES `nexmo_message_log` WRITE;
/*!40000 ALTER TABLE `nexmo_message_log` DISABLE KEYS */;
INSERT INTO `nexmo_message_log` VALUES (1,'0300000010C9A702',NULL,'36209221595',1,NULL);
/*!40000 ALTER TABLE `nexmo_message_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `openid`
--

DROP TABLE IF EXISTS `openid`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `openid` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `openid` varchar(255) NOT NULL,
  `openid_email` varchar(127) NOT NULL,
  `openid_server` varchar(255) NOT NULL,
  `openid_date` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `openid` (`openid`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores usersâ€™ openid information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `openid`
--

LOCK TABLES `openid` WRITE;
/*!40000 ALTER TABLE `openid` DISABLE KEYS */;
/*!40000 ALTER TABLE `openid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `page` (
  `id` int(11) NOT NULL auto_increment,
  `page_title` varchar(255) NOT NULL,
  `page_description` longtext,
  `page_tab` varchar(100) NOT NULL,
  `page_active` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores user created pages';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `page`
--

LOCK TABLES `page` WRITE;
/*!40000 ALTER TABLE `page` DISABLE KEYS */;
/*!40000 ALTER TABLE `page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `permissions` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COMMENT='Stores permissions used for access control';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'reports_view'),(2,'reports_edit'),(4,'reports_comments'),(5,'reports_download'),(6,'reports_upload'),(7,'messages'),(8,'messages_reporters'),(9,'stats'),(10,'settings'),(11,'manage'),(12,'users'),(13,'manage_roles'),(14,'checkin'),(15,'checkin_admin'),(16,'reports_verify'),(17,'reports_approve'),(18,'admin_ui'),(19,'member_ui');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_roles`
--

DROP TABLE IF EXISTS `permissions_roles`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `permissions_roles` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`role_id`,`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Stores permissions assigned to roles';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `permissions_roles`
--

LOCK TABLES `permissions_roles` WRITE;
/*!40000 ALTER TABLE `permissions_roles` DISABLE KEYS */;
INSERT INTO `permissions_roles` VALUES (1,14),(2,1),(2,2),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,14),(2,15),(2,16),(2,17),(2,18),(3,1),(3,2),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),(3,11),(3,12),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(4,19);
/*!40000 ALTER TABLE `permissions_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `plugin` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `plugin_name` varchar(100) NOT NULL,
  `plugin_url` varchar(250) default NULL,
  `plugin_description` text,
  `plugin_priority` tinyint(4) default '0',
  `plugin_active` tinyint(4) default '0',
  `plugin_installed` tinyint(4) default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `plugin_name` (`plugin_name`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Holds a list of all plugins installed on a deployment';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `plugin`
--

LOCK TABLES `plugin` WRITE;
/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
INSERT INTO `plugin` VALUES (1,'frontlinesms',NULL,NULL,0,0,0),(2,'clickatell',NULL,NULL,0,1,1),(3,'smssync',NULL,NULL,0,0,1),(4,'sharing',NULL,NULL,0,0,0),(5,'viddler',NULL,NULL,0,0,1),(6,'Ushahidi-plugin-nexmo',NULL,NULL,0,1,1),(7,'facebook-social',NULL,NULL,0,1,1),(8,'mobile',NULL,NULL,0,1,1);
/*!40000 ALTER TABLE `plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_message`
--

DROP TABLE IF EXISTS `private_message`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `private_message` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) NOT NULL default '0',
  `user_id` int(11) unsigned NOT NULL,
  `from_user_id` int(11) default '0',
  `private_subject` varchar(255) NOT NULL,
  `private_message` text NOT NULL,
  `private_message_date` datetime NOT NULL,
  `private_message_new` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores private messages sent between Members';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `private_message`
--

LOCK TABLES `private_message` WRITE;
/*!40000 ALTER TABLE `private_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `private_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `rating` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned default '0',
  `incident_id` bigint(20) unsigned default NULL,
  `comment_id` bigint(20) unsigned default NULL,
  `rating` tinyint(4) default '0',
  `rating_ip` varchar(100) default NULL,
  `rating_date` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `incident_id` (`incident_id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores credibility ratings for reports and comments';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporter`
--

DROP TABLE IF EXISTS `reporter`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `reporter` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `location_id` bigint(20) unsigned default NULL,
  `user_id` int(11) unsigned default NULL,
  `service_id` int(10) unsigned default NULL,
  `level_id` int(11) unsigned default NULL,
  `service_account` varchar(255) default NULL,
  `reporter_first` varchar(200) default NULL,
  `reporter_last` varchar(200) default NULL,
  `reporter_email` varchar(120) default NULL,
  `reporter_phone` varchar(60) default NULL,
  `reporter_ip` varchar(50) default NULL,
  `reporter_date` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  KEY `location_id` (`location_id`),
  KEY `service_id` (`service_id`),
  KEY `level_id` (`level_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Information on report submitters via email, twitter and sms';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `reporter`
--

LOCK TABLES `reporter` WRITE;
/*!40000 ALTER TABLE `reporter` DISABLE KEYS */;
INSERT INTO `reporter` VALUES (1,NULL,NULL,1,3,'36209221595',NULL,NULL,NULL,NULL,NULL,'2013-03-15 00:00:00');
/*!40000 ALTER TABLE `reporter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `roles` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `access_level` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uniq_name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Defines user access levels and privileges on a deployment';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'login','Login privileges, granted after account confirmation',0),(2,'admin','Administrative user, has access to almost everything.',90),(3,'superadmin','Super administrative user, has access to everything.',100),(4,'member','Regular user with access only to the member area',10);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `roles_users` (
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`user_id`,`role_id`),
  KEY `fk_role_id` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores roles assigned to users registered on a deployment';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
INSERT INTO `roles_users` VALUES (1,1),(1,2),(1,3),(2,1),(2,4),(3,1),(3,3),(4,1),(4,3),(5,1),(5,2),(6,1),(6,2),(7,1),(7,2),(8,1),(8,2),(9,1),(9,3);
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler`
--

DROP TABLE IF EXISTS `scheduler`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `scheduler` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `scheduler_name` varchar(100) NOT NULL,
  `scheduler_last` int(10) unsigned NOT NULL default '0',
  `scheduler_weekday` smallint(6) NOT NULL default '-1',
  `scheduler_day` smallint(6) NOT NULL default '-1',
  `scheduler_hour` smallint(6) NOT NULL default '-1',
  `scheduler_minute` smallint(6) NOT NULL,
  `scheduler_controller` varchar(100) NOT NULL,
  `scheduler_active` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Stores schedules for cron jobs';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `scheduler`
--

LOCK TABLES `scheduler` WRITE;
/*!40000 ALTER TABLE `scheduler` DISABLE KEYS */;
INSERT INTO `scheduler` VALUES (1,'Feeds',1363381324,-1,-1,-1,0,'s_feeds',1),(2,'Alerts',1363384684,-1,-1,-1,-1,'s_alerts',1),(3,'Email',1363381324,-1,-1,-1,0,'s_email',1),(4,'Twitter',1363381324,-1,-1,-1,0,'s_twitter',1),(5,'Cleanup',1363381324,-1,-1,-1,0,'s_cleanup',1);
/*!40000 ALTER TABLE `scheduler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_log`
--

DROP TABLE IF EXISTS `scheduler_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `scheduler_log` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `scheduler_id` int(10) unsigned NOT NULL,
  `scheduler_status` varchar(20) default NULL,
  `scheduler_date` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `scheduler_id` (`scheduler_id`)
) ENGINE=MyISAM AUTO_INCREMENT=448 DEFAULT CHARSET=utf8 COMMENT='Stores a log of scheduler actions';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `scheduler_log`
--

LOCK TABLES `scheduler_log` WRITE;
/*!40000 ALTER TABLE `scheduler_log` DISABLE KEYS */;
INSERT INTO `scheduler_log` VALUES (1,1,'200',1363341776),(2,2,'200',1363341776),(3,3,'200',1363341776),(4,4,'200',1363341776),(5,5,'200',1363341776),(6,2,'200',1363341787),(7,2,'200',1363342009),(8,2,'200',1363342118),(9,2,'200',1363342148),(10,2,'200',1363342321),(11,2,'200',1363342428),(12,2,'200',1363342462),(13,2,'200',1363342501),(14,2,'200',1363343035),(15,2,'200',1363343050),(16,2,'200',1363343136),(17,2,'200',1363343170),(18,2,'200',1363343362),(19,2,'200',1363343536),(20,2,'200',1363343582),(21,2,'200',1363343646),(22,2,'200',1363343731),(23,2,'200',1363343844),(24,2,'200',1363343883),(25,2,'200',1363343986),(26,2,'200',1363344019),(27,2,'200',1363344133),(28,2,'200',1363344228),(29,2,'200',1363344447),(30,2,'200',1363344523),(31,2,'200',1363344545),(32,2,'200',1363344610),(33,2,'200',1363344667),(34,2,'200',1363344726),(35,2,'200',1363344781),(36,2,'200',1363344847),(37,2,'200',1363344901),(38,2,'200',1363344979),(39,2,'200',1363345021),(40,2,'200',1363345111),(41,2,'200',1363345185),(42,1,'200',1363345305),(43,2,'200',1363345305),(44,3,'200',1363345305),(45,4,'200',1363345305),(46,5,'200',1363345305),(47,2,'200',1363345328),(48,2,'200',1363345583),(49,2,'200',1363345633),(50,2,'200',1363345683),(51,2,'200',1363345743),(52,2,'200',1363345802),(53,2,'200',1363345889),(54,2,'200',1363345933),(55,2,'200',1363346065),(56,2,'200',1363346210),(57,2,'200',1363346221),(58,2,'200',1363346280),(59,2,'200',1363346302),(60,2,'200',1363346340),(61,2,'200',1363346353),(62,2,'200',1363346401),(63,2,'200',1363346524),(64,2,'200',1363346684),(65,2,'200',1363346702),(66,2,'200',1363346809),(67,2,'200',1363346836),(68,2,'200',1363347070),(69,2,'200',1363347126),(70,2,'200',1363347183),(71,2,'200',1363347245),(72,2,'200',1363347354),(73,2,'200',1363347385),(74,2,'200',1363347484),(75,2,'200',1363347592),(76,2,'200',1363347611),(77,2,'200',1363347661),(78,2,'200',1363347754),(79,2,'200',1363347850),(80,2,'200',1363347925),(81,2,'200',1363347964),(82,2,'200',1363348102),(83,2,'200',1363348153),(84,2,'200',1363348442),(85,2,'200',1363348512),(86,2,'200',1363348572),(87,2,'200',1363348630),(88,2,'200',1363348690),(89,1,'200',1363348840),(90,2,'200',1363348840),(91,3,'200',1363348840),(92,4,'200',1363348840),(93,5,'200',1363348840),(94,2,'200',1363348867),(95,2,'200',1363348925),(96,2,'200',1363348984),(97,2,'200',1363349059),(98,2,'200',1363349247),(99,2,'200',1363349381),(100,2,'200',1363349411),(101,2,'200',1363349502),(102,2,'200',1363349575),(103,2,'200',1363349670),(104,2,'200',1363350061),(105,2,'200',1363350161),(106,2,'200',1363350197),(107,2,'200',1363350445),(108,2,'200',1363350908),(109,2,'200',1363351500),(110,2,'200',1363351509),(111,2,'200',1363351565),(112,2,'200',1363351832),(113,2,'200',1363351914),(114,2,'200',1363352018),(115,2,'200',1363352135),(116,2,'200',1363352180),(117,1,'200',1363352483),(118,2,'200',1363352483),(119,3,'200',1363352483),(120,4,'200',1363352483),(121,5,'200',1363352483),(122,2,'200',1363352562),(123,2,'200',1363352640),(124,2,'200',1363352644),(125,2,'200',1363352733),(126,2,'200',1363352777),(127,2,'200',1363352833),(128,2,'200',1363352884),(129,2,'200',1363352991),(130,2,'200',1363353012),(131,2,'200',1363353186),(132,2,'200',1363353448),(133,2,'200',1363353493),(134,2,'200',1363353726),(135,2,'200',1363353799),(136,2,'200',1363353917),(137,2,'200',1363354129),(138,2,'200',1363354159),(139,2,'200',1363354230),(140,2,'200',1363354264),(141,2,'200',1363354338),(142,2,'200',1363354427),(143,2,'200',1363354458),(144,2,'200',1363354510),(145,2,'200',1363354659),(146,2,'200',1363354984),(147,2,'200',1363355057),(148,2,'200',1363355403),(149,2,'200',1363355577),(150,2,'200',1363355836),(151,2,'200',1363355960),(152,1,'200',1363356071),(153,2,'200',1363356071),(154,3,'200',1363356071),(155,4,'200',1363356071),(156,5,'200',1363356071),(157,2,'200',1363356125),(158,2,'200',1363356186),(159,2,'200',1363356313),(160,2,'200',1363356364),(161,2,'200',1363356450),(162,2,'200',1363356501),(163,2,'200',1363356565),(164,2,'200',1363356608),(165,2,'200',1363356743),(166,2,'200',1363356869),(167,2,'200',1363356900),(168,2,'200',1363356907),(169,2,'200',1363356966),(170,2,'200',1363357026),(171,2,'200',1363357296),(172,2,'200',1363357321),(173,2,'200',1363357443),(174,2,'200',1363357880),(175,2,'200',1363357941),(176,2,'200',1363358001),(177,2,'200',1363358078),(178,2,'200',1363358143),(179,2,'200',1363358423),(180,2,'200',1363358638),(181,2,'200',1363358687),(182,2,'200',1363358845),(183,2,'200',1363358911),(184,2,'200',1363359234),(185,2,'200',1363359384),(186,2,'200',1363359422),(187,2,'200',1363359482),(188,2,'200',1363359553),(189,1,'200',1363359803),(190,2,'200',1363359803),(191,3,'200',1363359803),(192,4,'200',1363359803),(193,5,'200',1363359803),(194,2,'200',1363359859),(195,2,'200',1363359953),(196,2,'200',1363359974),(197,2,'200',1363360121),(198,2,'200',1363360151),(199,2,'200',1363360202),(200,2,'200',1363360517),(201,2,'200',1363360642),(202,2,'200',1363360705),(203,2,'200',1363361184),(204,2,'200',1363361435),(205,2,'200',1363361465),(206,2,'200',1363361596),(207,2,'200',1363361641),(208,2,'200',1363361787),(209,2,'200',1363361830),(210,2,'200',1363361882),(211,2,'200',1363362056),(212,2,'200',1363362061),(213,2,'200',1363362125),(214,2,'200',1363362215),(215,2,'200',1363362250),(216,2,'200',1363362365),(217,2,'200',1363362427),(218,2,'200',1363362708),(219,2,'200',1363362725),(220,2,'200',1363362809),(221,2,'200',1363362847),(222,2,'200',1363362902),(223,2,'200',1363362962),(224,2,'200',1363363046),(225,2,'200',1363363140),(226,2,'200',1363363149),(227,1,'200',1363363243),(228,2,'200',1363363243),(229,3,'200',1363363244),(230,4,'200',1363363244),(231,5,'200',1363363244),(232,2,'200',1363363275),(233,2,'200',1363363333),(234,2,'200',1363363390),(235,2,'200',1363363468),(236,2,'200',1363363520),(237,2,'200',1363363560),(238,2,'200',1363363562),(239,2,'200',1363363629),(240,2,'200',1363363687),(241,2,'200',1363363790),(242,2,'200',1363364015),(243,2,'200',1363364050),(244,2,'200',1363364101),(245,2,'200',1363364286),(246,2,'200',1363364364),(247,2,'200',1363364433),(248,2,'200',1363365000),(249,2,'200',1363365063),(250,2,'200',1363365962),(251,2,'200',1363366360),(252,2,'200',1363366383),(253,2,'200',1363366555),(254,2,'200',1363366604),(255,2,'200',1363366632),(256,2,'200',1363366687),(257,2,'200',1363366788),(258,1,'200',1363366817),(259,2,'200',1363366817),(260,3,'200',1363366818),(261,3,'200',1363366818),(262,4,'200',1363366818),(263,4,'200',1363366818),(264,5,'200',1363366818),(265,5,'200',1363366818),(266,2,'200',1363366864),(267,2,'200',1363366940),(268,2,'200',1363367038),(269,2,'200',1363367115),(270,2,'200',1363367170),(271,2,'200',1363367453),(272,2,'200',1363367461),(273,2,'200',1363367527),(274,2,'200',1363367731),(275,2,'200',1363367760),(276,2,'200',1363368002),(277,2,'200',1363368253),(278,2,'200',1363368305),(279,2,'200',1363368461),(280,2,'200',1363368939),(281,2,'200',1363368995),(282,2,'200',1363369237),(283,2,'200',1363369304),(284,2,'200',1363369365),(285,2,'200',1363369382),(286,2,'200',1363369654),(287,2,'200',1363370142),(288,1,'200',1363370534),(289,2,'200',1363370534),(290,3,'200',1363370535),(291,4,'200',1363370535),(292,5,'200',1363370535),(293,2,'200',1363370584),(294,2,'200',1363370809),(295,2,'200',1363371167),(296,2,'200',1363371411),(297,2,'200',1363371424),(298,2,'200',1363371500),(299,2,'200',1363371541),(300,2,'200',1363371973),(301,2,'200',1363372023),(302,2,'200',1363372081),(303,2,'200',1363372155),(304,2,'200',1363372200),(305,2,'200',1363372204),(306,2,'200',1363372347),(307,2,'200',1363372385),(308,2,'200',1363373601),(309,2,'200',1363373774),(310,1,'200',1363374039),(311,2,'200',1363374039),(312,3,'200',1363374039),(313,4,'200',1363374039),(314,5,'200',1363374039),(315,1,'200',1363374042),(316,2,'200',1363374042),(317,3,'200',1363374042),(318,4,'200',1363374042),(319,5,'200',1363374042),(320,1,'200',1363374065),(321,2,'200',1363374065),(322,3,'200',1363374065),(323,4,'200',1363374065),(324,5,'200',1363374065),(325,2,'200',1363374290),(326,2,'200',1363374349),(327,2,'200',1363374362),(328,2,'200',1363374422),(329,2,'200',1363374485),(330,2,'200',1363374554),(331,2,'200',1363374610),(332,2,'200',1363374691),(333,2,'200',1363374797),(334,2,'200',1363374840),(335,2,'200',1363374863),(336,2,'200',1363374909),(337,2,'200',1363375001),(338,2,'200',1363375025),(339,2,'200',1363375084),(340,2,'200',1363375164),(341,2,'200',1363375214),(342,2,'200',1363375325),(343,2,'200',1363375427),(344,2,'200',1363375443),(345,2,'200',1363375556),(346,2,'200',1363375580),(347,2,'200',1363375674),(348,2,'200',1363375685),(349,2,'200',1363375805),(350,2,'200',1363376002),(351,2,'200',1363376262),(352,2,'200',1363376814),(353,2,'200',1363376858),(354,2,'200',1363376991),(355,2,'200',1363377041),(356,2,'200',1363377104),(357,2,'200',1363377134),(358,2,'200',1363377182),(359,2,'200',1363377443),(360,2,'200',1363377535),(361,2,'200',1363377548),(362,1,'200',1363378095),(363,2,'200',1363378095),(364,3,'200',1363378095),(365,4,'200',1363378095),(366,5,'200',1363378095),(367,1,'200',1363378104),(368,2,'200',1363378104),(369,3,'200',1363378104),(370,4,'200',1363378104),(371,5,'200',1363378104),(372,1,'200',1363378111),(373,2,'200',1363378111),(374,3,'200',1363378111),(375,4,'200',1363378111),(376,5,'200',1363378111),(377,2,'200',1363378293),(378,2,'200',1363378471),(379,2,'200',1363378539),(380,2,'200',1363378561),(381,2,'200',1363378622),(382,2,'200',1363378686),(383,2,'200',1363378772),(384,2,'200',1363379471),(385,2,'200',1363379842),(386,2,'200',1363379880),(387,2,'200',1363379881),(388,2,'200',1363379955),(389,2,'200',1363380033),(390,2,'200',1363380279),(391,2,'200',1363380408),(392,2,'200',1363380478),(393,2,'200',1363380482),(394,2,'200',1363380756),(395,2,'200',1363381067),(396,2,'200',1363381179),(397,1,'200',1363381315),(398,2,'200',1363381315),(399,3,'200',1363381315),(400,4,'200',1363381315),(401,5,'200',1363381315),(402,1,'200',1363381324),(403,2,'200',1363381324),(404,3,'200',1363381324),(405,4,'200',1363381324),(406,5,'200',1363381324),(407,2,'200',1363381538),(408,2,'200',1363381660),(409,2,'200',1363381689),(410,2,'200',1363381791),(411,2,'200',1363381801),(412,2,'200',1363381969),(413,2,'200',1363381985),(414,2,'200',1363382084),(415,2,'200',1363382190),(416,2,'200',1363382220),(417,2,'200',1363382224),(418,2,'200',1363382293),(419,2,'200',1363382348),(420,2,'200',1363382455),(421,2,'200',1363382541),(422,2,'200',1363382599),(423,2,'200',1363382690),(424,2,'200',1363382702),(425,2,'200',1363382836),(426,2,'200',1363382903),(427,2,'200',1363382944),(428,2,'200',1363383054),(429,2,'200',1363383066),(430,2,'200',1363383131),(431,2,'200',1363383183),(432,2,'200',1363383244),(433,2,'200',1363383317),(434,2,'200',1363383377),(435,2,'200',1363383440),(436,2,'200',1363383576),(437,2,'200',1363383613),(438,2,'200',1363383664),(439,2,'200',1363383732),(440,2,'200',1363383804),(441,2,'200',1363383848),(442,2,'200',1363383909),(443,2,'200',1363384311),(444,2,'200',1363384347),(445,2,'200',1363384411),(446,2,'200',1363384629),(447,2,'200',1363384684);
/*!40000 ALTER TABLE `scheduler_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `service` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `service_name` varchar(100) default NULL,
  `service_description` varchar(255) default NULL,
  `service_url` varchar(255) default NULL,
  `service_api` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Info on input sources i.e SMS, Email, Twitter';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'SMS','Text messages from phones',NULL,NULL),(2,'Email','Email messages sent to your deployment',NULL,NULL),(3,'Twitter','Tweets tweets tweets','http://twitter.com',NULL);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sessions` (
  `session_id` varchar(127) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY  (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores session information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('44fead94e84e55e6464e6d4c772188a6',1363380710,'2doLVOGDyo2yUsfsqdgVsdAOu3ONJELDcfuK/niib3ojDSxEqmJLtZCyTlNqnnAFZGBCmoVcRzbMqI/U6scXqERvTulwM6oWCJXIgmUGw0seco9Et1XJzrxf/uldz59DtwEVS3WPhodUQaMVDqmnoQfNMZ+4e1+7B1xWC77Zwij/s6WTatoZeL6qnnHKlLK64aDtNaGVBQ1kFwg/jd8xN5e+gfw4puIID1fFduEyxjRj0bt+DSZOsoHqo9pnLDazutljvbD7ie0F+wXd59rm7VIlf054cIumZA38TjaZMN3rpGqjFLFr9zP1np3sGuuDCFksdxnXO3w='),('d902b8f5e26e8a83714e1924f6c536b4',1363380798,'BB2+Rz7MHrXfAJWgNKqFNLagLNKMa3L14yhpbKknxy8MnExYktu22SI4MV5drQPN5A54zaPz/Vz13yoTUwuk4TNECJZOglenzgROG79ftEsi0b2FjENf20w3hN96UfOAFeJcYl9CCLk8Mu/CT8+Ddc7C+njCkA7r4GIKBwLJR5Rc+xCSGI4aumr42UEqyeEU1oa705WUBzp6tKDoSqpT8c5BQPwSdxfE9J0o7oTrJaW1E7GLI3O3BYFjf/0NAw+uUwQq2b2mGmlolIyTaWswQx0BsPMlwBPysSbx1h2MB8Mv9lVdnDtK7QcHgQGP+Ln0RJ5BtEHfOts7P7vCBMEZ2FKH9KzB44B1jsGrsrnTB2vXlJlW4oNA6ZF5D1NmZKU1sVFGELhFqzWxfflf6Q7lEHq76o9CP/pFhFbHXIysib2vhU8hanRJquwvOQ=='),('b43c11829aad14116120ae2844fd2cf0',1363379485,'yJK1H4oL2zYymWLLGKK6PAT5O820CxEateovBP6gTB6uQgjRnL3AMNKV/LiifL/x32Ip3RCXZPuIluRxCSvPA3Ndh2Vy9KI9/wFcJYWdPRf9++TiM+CpjvGPKkN8B4Bugl3hFtP/+f+XSrnQu9AVWfaiWe0BWKy+skIjgvMbvvrkEYKN+jRvcktU8AfKj5iluhaUzztXbOD2FYm4WYwzEhgpT61dkZjP7VQd2zaGIREdcfeZHFKvyaaquazrU11ttsjlYum/EnHz6/5lFSoKylOfdIi3thTrz2x/7Z0lsr1/4pp2xuf4LPXndZvjdj9YtsFCkLBOdNijBoYCMh6xwGqaLMRRT8yE/wKo21w2JFYjtoJu/FyE/vIWDVFF1ZrRpBefgupAOpdC6eUKBU0OkFRic0ZCv9LnAC/nJweoJ86mlDYVBYkX6PE23Tg8BIygsxyMQFnt7+NlF8a2zafIaGpouZnVU1vM2DPD16nz5PW2nzCgIRj9j84r2562wkNhuz3Okc25mJBykPW3FVGkNa5XuAoRncmvJ/QrNKqaVPpqkJR4LRAMuC6vyyqctXdLMgs5t/LtDHWk3LpSVK2hWBqWnRho+dZamUaMkIm2LtvOLxCAnus+52Pj48cENRO/wYLbM03tg9e/W7hCp9x+0IWaiGRgsgu2Vo1x4gG7jxDENGxAy6IhxkwaJ4SlfAO6gCIFj9OFBq6PgTE9WljQf4dP3VfZ9OBxmjnEYpwihENRNYYw2jIwzVX68wTWPzVRhpFgoMINBS7g2NMZSTey68MN4BJZ7w5pmPNJs2HsLr8lSIX4rcoXebQ63LYhARG/fS2ALN5voNEScMnmYggO8VIgVSXhye4M5IDGjk9kzxUaNxYWMnaX5obglmzQoDeVZmCqr2D/RGmVOex1LYOs5wfyy6c8nbc0eCta0tPUZUhBP8XQeu3JB5iikKAxvi5YrK1rYxbbkCgJbWT3U4cpLq5GHHa2sMlWUOC259E1NqQeDmR+DFeSuv3Z91h8LR6UNme+jbJqhokXdRrDsnv4/E5nmKc1xCjWUVsSzbgSparCtnyHCTplDzdfINQZ5TPMrEXs6m/teRJ+23fuGO9/6DFivF2cLK+wTk6YF7ri8u3WgaKWHkAkPhD5uJ/mZmM77KHHq+xt13NR7K/AUgXXiuuVGOfgj/5J/Y8SyJaGT6h2QmnLvtPF0jOzTBMQcn1D0ljiPNxbD8rAvwYv1PaFUKsXZ+Mwp6a9gB6QFeCRpW3CILIlg619S6mJswOaJ8bkj2VyJUYAlpxKy2UifRA57ClOdg4Z6ADDKJWQqLRd1aMzH0qFzZpbzObSVo6+nND0kjZCphK/Lb128EBVUf+sLkmorvPV9jJjb/JpyJfT15pA98uSInvfq0xhdz2RNrorU/xIsJMvJrRlDRe5k07ImvTeQJV3gtjadEGjQrCVA+Xc49IQPU714ic7JAPrwAR2jgNq0t2w'),('f0244b17a92c3d95b591a6c2cbffc8ae',1363383624,'0JyHh9YZJfMIu2Mrgnzy6/V+Ux/mr6TEUTDm6uu55QWP2p72yd0GV8eUYewVFS+hKCpVv2TJiEB/5cN3dUW8db6wY2tRSgi5NHpayLXsb782cVOzbnpiqmL4gAXE1I7iww6+3BBhqP2GLUwkKP/sGKyEF0QRK+tB07h6BacBX0Z8s4QsLzrjxbaDgTTkX7OtUwP2nUV2B3D0cUpBlL1f+bMqlrmCLQ9lTxxt923nZBa2tPHhvpZdBY0Av4Nzs282WrN7+aQ0ZdZbRihJHvHaYCaSYd4fLUiJcDBa4vZ2ZLp3axWjuxPIX3fofImlZ5lLw9kXIdpsnSjcAR/8KPCn0/u+63TX0WGAvNeCPiibb+p5/rvakUxRWaFR5SGkbdYftP6TL7oCjGlZqzGiRmm1Cf4UZHhivteR5rjckRLa4M7vGWMlvY8xbjZJbk4wnFdaWFQ8zIuzzXlJT34/FDnY2df6F0DMUeDyJNOgU8Kkkv09w11d5O5jkztF9vJHqwef+CrHH/ADrZM5L+eb/WGXX5Y3opiBbwivWKlG+QePpUx7ZoCjfrI4nyr1ZwuP4NDTif62msWBhOotNqoTOddDJ/HqdDKput4V6y1VtOwBfl6lkK3+lYZeMkDpwlnHvMlZv9mfXKIFrjdvDVaQNnWiC4lTk9XAObokw9dC3Vj+v5uiAZ2q+cctZ+B7n7p0WN2rUS2n2Rc6oKUIQAt67gPCcjl49tx20RN7lSM+IFZRBPxFgreGB8SIC1vqy12cvmqfKGR4mI0OsaScULT68LGRMDPJUG/fzCR4j1APQH/HM8eGGvwr2EeMS/yzjYLNiQdW9BkT20PjIpnYrmSOv/XHgYN00ijPM0cvMaRM5pt0j4w2bpoo+HH38mOn10pGI9hVo3RO2yGEREXAYoWS/PACWX7+iHKFGV5uGR7V1TzyHcOMF9mjUz571XdG02Fs+7nK5eWGH5vP8zdpUygpPGe9fz1frWSVtMVfM9GCec2OarWSis5ffZq9JjwdrIUyArJAo3N5OcoJ+5HRqNQLZGzfw1OrTqoE13kIx3FQNvK8mcbIYPT2ki70pFGAHm1PkxpzUaS06pDkRI/tW5qTw5lpbExw7CvOy/Cvm6zKZad0CMKgzsFhX89Dp5v18wS7rl8dLV5jzsKvLAQbjPqRfDEuHRkRiWtwPjYI74SrzykVhMs4Ds6bxOoGmsmsaZTTHtcHBpSZjKAUAiIM2taIz3EwYerX1S7mzNxCyw6yJcxsjhHqLl9BOtpFr0SuI5eMcMf3FRz3FoIklCr2WMDM3Dod6gjHH3KTL+vNGGckQq8b7cuW8uCG0S6+ydRsfGpxbeOK+UhFNSCvwUg='),('c2776065e293a79cce9b6c9406d0b6b8',1363384697,'5nvQn30ln8LFALC0s0Np7RHyQUTeIXCfXP1N76sm3ovlFp7NOZHP1/wYQDeWYB7stpplfl/4s2Sv685jAY2qbXmAkgyQSY4KMvRFRd+NZmX5MOKEXsLnfvs3Gfa1sVHECL8fbn+q3ERy7yNFtlgdb45GyhPuW5mSPJ5+qnj13/P6H1v+Ih8bBdM9geiMF9Pr5EGt9/9O9H8ZRyfdZrwepnoCIBS5mP7TbGXL4UCQf8tLP/pIIv2QEDb7iMQ6s2jXd4IFfXpYQpRYRklaaTZjUoEogS10/akKLhE0GF7gMkGnXsPGGa6nRP7PAYCgettz1Ddn1r2ruVj5wyAUz7MQ9KjaCzfcw0bxFdI5HT9KDZbcwBytX+IshMLWCdGcgYuBB6Tdsfrc6EqZNhHQVh3SWm3GGv1qzeMWFtiSN4AYtWIRoTfAXwt6lUZoilWjDXiZIX1IOj9vvCzU99AN3sA8o28aYNtUwXx+6HIqGL9MNz8SIn559iK7+URG5yVo3svkh0V6rY9Z1QsrBMMUgFD5gSY89o4iXp5E4N71f2l2c7xV96yd6lcHPioZzoroSvDc3wteBFzyGgwe/y0GgOh4lyf4qIpnCF2mmaF9p1pK1Aby5IpUFjz4pai4KATKt3ko2DQvgicmLUmZkJx6e0Te8vl1nIJh1tH3BVyWlMwmgSvs2SkncmndrdvXeSg0cVuX4PKOtzaPLjQyE0Vc1o3syfMSdUhmroBq3+d4FkxumITGhSzyvfySoxeSDVLEuRedg8evztX5wONYPz128nnT0pACH34dzXua3+kvQRijGCum3mmgkZP2O7zEJJ/ePxlwVvC/6es9WwjVGQVIt+lo/ya6HBc0OWgHSSSL6iKvQ2GkJYgaZgWG+pKD1ObvhQZW2oUtchoBQsJAF0iIOvo9RVbKU6YsXwImyV5i7GPW3WytPiPzfFrxWZ6r3Naf/qhF/zF45pWvQnnFz0Df2hPLHpy7KtUkaskj+Kwr2wJlaGZ3GKHm4CVz3eqRFSJfHgubjoH2sfnPXBEmoN/sPwiuZgQa/So4t24H6x7Dv5UtbG1bEOmP6CDRmb5lmo00Mxv0WcDh6WgniOaJdQ8UJ+3A++4L1sj1XsJ5fiZPrvdfsTZePURgtZ9uVLOmJBs6fxZjaKK7oiXB4rDzI2/2YjVbmS1fx8IKs61bX9XZrjRsd97VVIIVMtWbKtCC1UYQjt+aJ/KHIu0HCHtirwqPhxKJcRkE/C2rf69OzP+nlQ1tWwbEjlJEe/Gbo0dGOWgwUGPlTUktZ+/prXxaCnDip0jveDVV2pwOw11qOirlLpgV8cTvKZP/sC/MnnU3WJROZRUYZVFMUG+ZV9/H6KcuErjtPQ=='),('cf209144c2051fe3f5e315d04d305376',1363379648,'2sogefbc1IzP8tgchaWu/9jyLvo76gPC9nPYd79C9j4aiiN4roJKgBDGqja3kHXIe5eufv46iq0aNVKWNBJPxeWOS54zWlHZBICMkUrDa25IN0trmWrj4kPrSUlogAMmhsAg52eTI+McuP/7ERKy7gj9PBBTs0tQi/AQlkS2TPoen2AWOVcJSbiyC+dREYbxuvCb3CbsTZesj1qp93kh+JWUCON5da/r4D5YqJGUZioXd8Dvl3jEJpWaLiLmwQ=='),('8b80aae1755556ac60f517d4fafd656f',1363379651,'HjXq/J/Nvp3UW7Tw08OGIcwAtufCTnbHWm4cYrNqBpj5voWc21wOYRCLabfoy8wUTZ+B5K09loovcWT/8QbzkbMz98RhEbR1dGMdtHna0UcnRCoH0kz5m+ZP4PVSiARHcNuOTNLIHQZXBkYlVRoykHuIe8rQnmgQtsPMDW+Px7o96Iu5415vbaT6ura0hRpETCrqyldJjAD479siZIbMs40qG8Hww+A1oDbh+XYBA5T7PIOvmj6pPo49336+Tg=='),('6f9dcf0ed9b33d8549ccae1f6d792dcb',1363383318,'60u+mt3josL9Tcz6YHgLehOFS7gufRqUlA2bkFWuyc05lFxahltTJnDIW3mNEL1SHr7tQ/xlITmV0or0RseVSkfeaxhMVl+VTgURsuPdIwbXbMp95U+kJX8wE/sDDkLQ+ZRhhfIfzC8TzCJFbmH4CeO1d1evRrJIyyzfqPxvlrLVf6kJ3486LUIndQP6AxZuipfJm22LNS01Gk74+ZrytEpT6TUgvIxuKW2Vux8Ffkz9W2i4ynxeQ5LWO+H8Y3p+63HdUHH7jW992PrdjCyYDZo7XQcETbQKVdMnwMnE5TKtw25/h8tBuS7iwMVRnco+0NrWwGNaXkCpqe4x6fBzKh08rqovKZdnBoCUTL5kX4JAR6t+emDGCxCQ0xR06xV/q0fZ9g=='),('8c879470f294c0ed5707ab91fd9e63ed',1363379901,'kHSE2wQw/XNilWXXnBjSUF77uO8e4WievfY7DwOPshM3VwEiIBtmsYlXpflLrvEhjErcrPige3FbKaJWgcWHJPyGA/XO+gqpL034tTqb6MehMIQq8VEJSPejbDrrKbpympBR0LR6iebMG20ODlR78n01EL2h+FnxNV9fxt1m6aHeoE6s9RBjk+4qAKR9fLP+hU8spaPd+0O/m05+7IZM9crsh+l9g/SlBWFs3sl2W7qs/C6F6rE9/4l5/9ioo5S24aMpgqVL9oKTiombzjbVwAHkvsH73lTUwOPlcCjqytnubJ6RlCqVarsAOM8P1NdqCDMstIH3/orzJkf9QSmin0gpqZATW9DLmdTR3E3A+j+p7w4Cl4OKByRqA/Zt936pS7opE1fk7kV1fCgIC8KBt1xB1HMtcfDfAvBrf7+trgI5UbBa+MA71L4M9VDfnpLPL53UuOFy7byiIUOmFHrd'),('997d3ca7989894b4732e269422bd92d2',1363383666,'TlbWJp9+TH96Kyjz4A/o54fkLv3ttNuokCB1C7rHUUZK/goJBZLGMoZy1/C67+Y+bbSXNxpkaS7cP4mJyA0h6zbfJeqLlKR8bxZjBH/JfIbSwGvmc++qD0v4/WA6hCcHmBApV7PrQWm8sCAUBix5IYE2rNmrU04+o+FGGR2nR1nvv4Jk7LcvSM1Cm0GDGtv236PsGg/IDncDGEuPvm2eTSRgB2uAwF+bN4KuCmajvA7RFrBgBlIf7g16S/SNRyLb9Q5DCYUKlm7YOd2o86+2nvAvPEhYgNcPYIGB71n1no6bZHVVUtRbnXN3mZlDAJUCpDPE2vzMb7sDnapJ0cHFw9GF/o9eeU8bGxwiI1On7NJn+U7lIPSSH9/kYIq+kz//X1K6dpDvbtcPor86TdVEpgre54mMseGOpaMQe1NHMR7iih+JuAoeKg2GuEPqcYddCEwcxEBmkiGoeuSlI9IQIm0keZzjHxDQpo+1+lr2xp6SQJW6++sme96VobBKhjamPCFT7Vdb9ZDx2qvOSK0='),('bd224f7f789efb494e5862ca4c45b0ef',1363383871,'HsGgyGfQ1WM6ELuGXyhLwSY3tqsEhKppvntXIhAOSqhgR9ZH7Sg2g2jScitO8dXWSNd1tWQ9qXkOC2hDLCeDvqPDKzfUl4PZYAQI22QWkbZOMip9CFqyahcV4zjgDbDfPOOCSv6ohLUI06Z2JFqudd2E8iByoUyip1lOA+AIREt5VQPioxg4SohzvLkYfHjrEj9P/xD9f+lJ7jMXzMzJwIiw2EmUWGxM1Jvqg6YOEilOFmENcTviwd/W+yWol1FynSnAabGbuOtQ+OqmeE8AeM2k/j+puFHiML5MFfu1z6zQgf3CJJnW6dl6fbPeDGwfEuT+CGF0GdhHbqi8fkxhkUXJnRZzaDWuPEoEcRQ9/QSVPh6lHHaDe6jpZ5t+DxYttbGWrVoKK5ZJx98Eq5LSOaxzELca4Covf4I+Kxomvj22Wndo6XBorbOZ3Nxw0Ic0UsWTM4azDonDaklvmGWycmI4LbNQ/MTdrQAXQ9lQkKQmDyglKJTBYIwz/f6kJMzYZe/jUjfX/g+HJZOIchBmlbFzADCu/HQeu/zrkTTjKL6IwfZR9W+yAn4mfjO9cm6VOBFmVcy5Oh1d9CM5yWKKOtylWLizLIPTeh32D0km6rf649ndzMHuZZrcERXY/Qt0bNq9kPU+Clp/o/WiT95Y58pcjnt36whChdfzAHuUstlR+dVCeJhIaCfGF22NgFKgkNGnTRzkkvWrt3ug+CVaxD9wv71bcm5s0zJkFESPvfKzYf+i/ZHnuWw/ZTob2+TtWRlxe+byxYMv1kzsvjDYBfNZ3BFAsWwtMDEwHKCbGID9nYscCtxiNuNI0WnkjPlKccXq5BGm8faN6Hnuzb7E6kyRU8PjqC4HhrkqVWLnft9tAVWrjfTDY0FgKJcR2F0OCyZpGPcKL7/OKRZiAij6NYoQQeexLpuK04TBsjXiLFQCA4No2ROm8tT9GQTHosTew92Jv6uEWAg6nyi798UVFurvo9dTRycGqFCm9HF3cmYEWvvCeNzrKalGwSezASj6AfGbYNqP5KI/iBVQsJQcGZsDQDjyKkqp98xNbu8a32OYUnyVrMft1zriI0fKwuJ9mBv65+VFAbeiKv1zRCPhj3+bCzeM7tuczYX6fmd1ZjVJyeqgAlZnkwcsGuYnf/U6hHSKIzXbcO6syAYdXFsd7I8YZi+7vboMeEDXgr1RLk6lV26KrTsJhJwtQzfBZOgNgDNqPYIRMusbqrYldvdFXGmiKqkPJGfkELPIm35MyUV/PSNUBPH1gcjHvsrZ5eI3dsxwwUEH2mSU4Ri8yX16ahiRlIdJ4X/KuAocv15iraO5rHacQfuqnGia1jsnWj3vMszdmyuFRzsxV3rIdlSwde/f+JqIK5szMIPSHbL4i2lApev2rAL9eDmv'),('ef7c8f9cb5a0c6eb8e88fe44a5745b6a',1363382228,'nRjXHsuekzUGDv3V/d6G/2XICUeU3Z++Cx9h5GuAaTKpzC/Vhae+YxsNIevU1kfG4vyBw1No1G8ARfhTjEozxKvtwNYB5o4J9xrxmvRskq9lA8sSZJmscTLrwLwNVuhBYNKdbYYQqZ4rrsiq51FtQkGavOycK/NeX34Vuz/Mnihrt/BYKhu9cuOlJCrBxVm7zVCXQKe8eURL1ucvR8JQUZ/eRJ5yuKH8wo6nGrXUNVzHTj60kjf6rghFYi9OSl1I8ApQQGZEF/38ZT6AhXNr9SocWHa8BdBTyG8WWhrMApQAiwbwRlgtuF3xhgc1LIqNsT8tRUmhAjFV0iqToz7FItD+TKI+sHp43D2+wyYSNXF1DU+T3wvJSTRYqlohQN4gmSH1nC6v1HSAYEU3rt5euZcsyNWFD/HXtc+te9WVrAwWMZ8+3JeCmFESf28u3jacuEdNZDvF8+J4iXVFKehR5wmWHjHA2dq7swOCnVRXvcJyRw+3b8360cDfqbvumQ=='),('726c680d040529f9bbdaa509f5cf6157',1363383108,'QKOq1j4jzn755jO8HEbLjPCIFJyI4JX0SwCEDAj5o78OM565/upsZj3Gh3Ed5apinC73M1cBSSHP7Gw1AjAkbQD5UU1yEWZLp1z6CBQu5PBWABDodXwJMstEE4aMnITYDOYAwBvUVTaIi5JNfD2ZPLqBDBvfrunJftADvRghnF7MTnMWwEeFQTjPpYRZOaZ36OQyjOR2KIyA8CrOM4kfYhONrmem+VaQRq4uzydIaIaQQBzxwh3h/hJlzRmiIgB4P6WMD6b8mz9A9L05E/AXLBWSXC2uo+PHBN9gPzvY7Jxb3vb5NStPyGCR5XQqjRJqwIHZJ9vUNct5A4y3kB6tfiEe0vdcyIUvdJfjFObkUBpaEyrIHSJLWX5LOxbvqAszt4aSbAFtAKwXr51KnOvYcIs36qt4GJ9MTApBFNWoY/MG6K/06W3THtWlFgQFePhKpedG5qyxtddydNS709nk+A99tWaLL7qPoTdVllom9Blbwhij/y7rAQyd24nB8/9/RPFng2YjveSxMGwLZ/X1ShHmL5wuXk3Z2TX79dUffes='),('cec65c82d71d6793e09348bf91b354e2',1363379014,'5wg9D93XudPpZVwSpRxfSsh8pIIiWkwADnYANc2OYBEuT/1wgLIVVPF4KOlLR/LGm+lqB+BWCsy9+ruDYa3vIaAIB8GhKaj2B5lxv7/GSNzssRuWb18j9M7W5febhumYFN3SidmfzT4MudzDwYigjg8uamqAmc2Q4XQni/Xw3NLKW42FFYH3vIlCkP17fc+y3VkZfT0dyno5jM9vTOY0EqxOoUNR1039x62NM1nPef9Dnut9r828xOaTk9tjpnwkFNmsoDOmrfCjOvBlaIZIxWTQe1ILaC7dnLQOWB9PyCGa8mHaDUe06M314fgu9LYxYATe5WNMcOtIDl1IzI9+sxOsUgQQ'),('9b428315aa557eaf64de1aaa53875d3b',1363377145,'z9umgAvBHz57JD6CEqGSrOgxi4z+ZP2wa+sAedrIj0cIkVp+qb4wu2liTCYMnGKO8kow99+qoJO7l511wnCYONZBAyqXFq7N08jUene4IXqMSztQhd/qXKFWA0kntt2PqzX56AkNmxQDZt6kIYTga8RmCs2JSV18aI1dBSXB7LKmDvJVBPcGYWFsdaaK//r107sU8GVNw4MX/roHjEKtzujgy0+qIByaMKLH6zIKV2kfQVCnkGrdx4B9FyRVPVB8u+csubDQvGK4Nj2Co5MEWWfObmogeyv7r0N2W3616K5PZeSJEAeVo5kFpENfUgd9tUMzXNWJ25oSzDF7JSZxJXWa9PBOW9+4/V+ZJG7saMoHZqw3xpKqRUhBHd4JKa+2ojRf5P7z9VF5osHGdd1Tj1lkrtjMp6h1cfoPLlW5S1eG0/+lGhozJZq/AKoAHVnQGgs1A7GMTdsS4mbMuPuC4AarjfOiarjb+lykKZvDA+DN35U6b0AgS9mDw2dPxf9pq64jWpUSXIRYJMnQcjfKQBp6Y1N0t/7ZlH9FkN9C'),('072d97ebedce49681e5fb3401e4c0adc',1363378008,'MbG5JYXxt9S7ILIBqLrPFDNc81FYdc2aFh2bz3PtEvSOpJAgpasl+cKM3IrtQEItlNk5MJy2ir84HiZ5aFO5/iyrdSBSC4LnM7/nD0UmPgVVa/8sN7kOlhIRI2i/M+WqgXbUdDTWlOdzF501T4NMAoJ2ycXBaj3sr6P/x5AfaXGnpBNfYUa38x8HD2b4Vw64umUvyaOUhINCkqU5cUr216dnvKX/lngUr1ahE/aiRKFKYDqCw8aJCK7gIdRxVEBpLPy3nGkjOZ1Eypib7nTbi5Ctxd7czHO9vtQeh0MgZ1kkRexentAjPij+k36Qnxv33/a8gh+aw/n1Zsrl2xirGt45K9vh/Zs7gcZRA7SaUY8v56o76UM='),('4bbf21086ae868c6b23925f7cd0ab2e4',1363380281,'n55ZqJVM035pBufzRdq2tIbWUZSkC1v4rTfV5ZAoWYKusr/Xgt0TTR4BA9NiSnrONCIv0JvhRkQ9ZCx+FAwYWiIcsHb7bntLVulAaHqBoD5Pj+LPOyMvlk7mtdSwuc/v+JJFzDlOGOO6VjMx2XyDk1LdfSm+6HUhoNISJaP4FhwnuYTEHpjK81XpUKfsdy6nHl8AT3nuJdwz4Fcs55bEL/61ykEaa5QAfq5msuGYNOG4WXfv5FUxQQFgySKtRYM4J7mTrvOBKfOLkZ+UmpaSqjE1+DssOd4cKuzrT486SW0/nRHdtrFrw/7FYdlfICsPs9hzE5ozMVG26ZTWZJV/03Sp+5B4DHDxM5VM2t6Uvk0JFGGLmSdPSw2xRCKZdHBnYfgjbEOrpnucQBYomhSB2hB25X5sUQc9XD/DEVTMCuZmCI13C+x+uElCa65gMURB1J6Mrj5yZGOY76vBEs0HjV5RAN6aTbT7B7nmgQ=='),('e4750464b2c48674948169dfead74c5c',1363380409,'niaFPPGOU9dqfd+6aHONDKk/E4f7q1GriCaSifoD+TN9hkSjc8MXvyCFkkbKmxK2z6eU/wJm7mYUwS1BvZQfPZT9clLtsnLEfgcwGPS6ANKeWnDS+TemJQ+rYKuNEDzY3hSWTxun5Ztm4286DKrfxxH2bULOZoU2L4MGwHKpDbf0tPlMH+kTvl+HJ4Bci+G5xeoJddejps/gmw6VSSJobX2TPqQKvq3K19k7xkiKObV8Jd6cmYF7gY+NQNZ0q0KfHWwx1TTAbChajM4ZXWRa9h/yc/TUIkNkhJtdsDzZ+n/V3Bn2tbDaxqsMZ8lVUDCPJ5IGjZsmtIdA4xIpLy2vy8h3js4srpgL2jM+p2qgVNocZqpVqs0NnLcu27pmlS7Pr9XPARnTxvfdLxM+OfUKgrreUx0WI6d9m6qcJZ7YKDIMAr4GxkXphEKcCCvDIK+pjTvKWeq3+CsODTlpBhBpUjdkecTqGQM3yoWuL6lrXyrq/r2G/2/q4LM7Ug/q'),('99ed403bc1da59d30c6ed7c7be3f793b',1363383131,'RKz23WEuNYpidE/I8SozDCjPpu9BQpORoqAzuuqTR6WfslyNCYUUUBC4laCJuCTINAcYaS1i34b04Ywiyx+mu6zcw3RWIKrTk4kUT8nNNLZVe5Zp9dM+5siYsxpPwexxAP2D8Gcy3sSQLEB7JQiHt9/VhblN0nEz3m97XO1CpCPjmfmN7KxH+Nv7V1rc4wGTMkdFl9LN+MjNI+tfRAW3HR8JwE3QS94lx98YF9M8J5x6Im/IXDMYPgV24VaoWII88hVJOQLkWWHam34vJMfRPuzFsq3hA0luUkRnOUcbf3PzQZbnFA1t1Gk3FIKdrKEIDUe0CnybtbxnNPKjDxC+xfHoPDwoUo5L2UKZcV+RwO+GATXQxTuYoFQXsu48CWD4m5m/tqe8MHSGjzV3ZF+Ob8Tw0ykGEJFd1BYLi0k41Q1A7PLKwi++MX4vHM/GvB9+EDkxHMe7yO5Q34vzI0mKhh3yli4fMJyTda4='),('6cf415e0b3ce9b3599baa8f503263420',1363379412,'ozQ5LuIaexoBQ5FZszTpwND6B6Bd/Q91AGayiFYoJgbvFwKV2c2QsVcAmU5PargBmn3bs72OyaEVS/k0QcEHopX40cPFffjed89g2eRI/X89I8yfdV5LUTAPavwHrv9uM6a5XAdT7TTyscOWW9Wy2DmrwzCQ8JdK7DyCXXtobxrfmwqWqLY8WJ172effKJT2SjlVdBsXRMlcYOAASPbdvFg9mYQ+FOwdPoSAlPOyH2XubQqhqPAkqI9ccWWpWQAJ9d/vhKBfS5R6IqwrHMydLtZRqh1OM4wP/0dbVzzQo8Wt0nhnw0QR5iWTWgEuBirH9fNzyKxRyouwnagwxTXHacCtjtO3QVI9IWFb+Ld5sK6F3bxMhFY/DEhUWLpQ0DTWRL+VaTFOb7XX5urnmdnJYehq2XenAxNM42qovv6kn1xPav2qAbRxM88DjEMWSTWIThB1g9QgqLgvbCzWWLKN3+Pm0gWoC2aTrF0rPljB493hj02/kJeqZ7n5DB2Gio6CTXuYhwzWHT1luxoPejG+9ZJSRM0d7LDwwn+9gbh+ELVyTQxqraLSSKN2F5LfFCutdkOqNCOa1doDYgJh7Kv8k4FxFRYYfwmKDlNahc4HxAe0vz59LMGZWyB7/YGAvqVb'),('1077e72b95650ac4784bfa1db0f0c49d',1363382348,'aGsI+MMpGPnu/5HjVCzZFmJ4HwuJadyBypejZbv6hWtRbGFjjP7sFceRxA13wA9+gKnTpunZSUkSvnaoRCAZEn2Jvnlmujv5wk+bIz7tvNZLRKdeGaJIC92PxvEVHoVktjzNxngL8YVFoa2rFFl+pdyazNjZB/y52LxqT2Ju9886S9acWDLIO9k7Rsixd87TNbPvaHf78tug8LyZAjSg0f9YN/aytetJKsBDaZw5J6OYWlDTCZcqKkhcIZw77ue0UerE1yIrMGeuzac+s4OemyHXrOjP6008OtOzVG3Sy6WqgKFyY27/f5/gOum6cHPjH8XQokOZWW4fs78q7TaqzQaCFb3tZUCVktQumWHg8GSLnQUxsKgUZd0Jex8OSfLhTntiPfkryLo+sSMCs28gjdataFXft9iiU3KgFwQM7Py0ylw/V2hxFVKVAmWVlRXGdbNV2GvJ7G1j77L/+ANva+R6EtgYnDtAjXSzD29xd7kkW+Ipn4rJBJ5uLubj+HTImFQENsRicOua9wVbpIz18+ixGxJEcCudeR6n5uNmqJFhVnkWb5CjpZ1Mng=='),('1cd6d580099b150bc82a3c9152f6ebde',1363382278,'w05uOTXpazgCTdETaSpK70Abi+z+wO69UKTO6cviioFAfT+Q5axgA4HE89ZFQ6RGe+UsqyUu5pf3dBu26h/fq/hTZYY0+BEu9+qF/9eC4vgvBYxibvVIHXMB5oska5XJD9rFfsg4JadSFkj1H5R7ivp9pW7NDrro8gEdL8QEIktJEMDjk0pynKBq4piSGZGA4x0S5Qinohnqm9YI/tYlRZS/32k0sEv5O8DIe/1t1uCrO3iE8zlQZcwYSYGnG2Xsbt3nY51JoJixis4I3+VrglWydLISlE6TVKVBZn5MCOAYZS5BtuGU5FFvzn+23rbxF9U4/lAmmh61upOWuNy8saRFjFN40C3j+gHoo55jSQEKnV+U8FWnuQsdxXahlc145s3wn34uNYC/gjJGRjQ3UDXj9aHNYBnOJDJuf3wfEMnbn/NWYUBsE+Rks5XDPQchK9ILWa4/xW+4HE1hXjnoZtuv8zFu0u3wht4VNnbHx7O1Ty/buSnJ5ZqjETZE'),('470cfb8a86aed94f4f4edfb1906e979b',1363382529,'EEI/2ko7oxpAmBWxui3B0qWT4gjymSXh3VIWUWfCPmEn7VrpbjqheM4p4vNOOlnfnp0dmvZXkQlz5RJ/+eeWGN77lM887Mo9Vg7M67RjmiVrT7jEHF0yl1yCzJPRfJhhkrylLVYC+e7SXidkZ3av7LHoKF3sfl3DU3Jc5NfyGwHiictaEHulDBqazZxn9kMHjXBOcdLiy349p71Bfg6nFt1V3SN9Zx0WcyBYty6R0ejxagIZIuij06xDDtow71HsAszaE8xTaHto00LI/xg4cUq5rfLQYJLMF0yK3svT3qnzWrOmMfnT04+E//t9bWULr7sQW5/x4vlTuwMy9FSqLBvqvnZq'),('aa95fa09c2829d714e62421264df8e1b',1363382392,'EcgU4/VQAHsvd8JS85jCMyslYaPfgL5H4wl1O44SsyK+a5vrgVorsxlVLjnYFGjZ3Q0VLVoJMPzfSbtUy4UUkrbdV1vHds9e30I3Ajl9UA/gDuCBLD1yE6gVx+0v8PZL2254/KwvFEZUm90zxDq67BS4/OyAM35RbWoloNyODzuJ0o5HLd7NSaZT8/qN3l2f42PrfZLA0b8VHdCVPy9TvkhNBEdNhJDdxQALI5HAkHmb30u/UVXYM1Yeey7mq2vKHVlBA9l7qAPf8X0ioQhFtA=='),('37eb323972fe5be19887d899a0a9ce8b',1363382457,'WL2fFl8ETgNevOp6CgHJ/PQWteZdphugfmD9ezumpMWUy4rTPOoHkBibsmjKtl5YYjvLIP7WNYuUzv4nooOtdjGBgPF/5vlxEgiKfuZRZKItyxapDXO9aPV7V4sT8bw2+dd1zxTKpCVBrFjAwnF1CPjTDonWBIgtkUckY6qH77SuXBOSkfPY6RO/DOi8UkToqR1hyRctLio9dXnT9DSWGPeG5X53mWO6ko5zLW9c9iEZGegGdwFNdwY639eq/g5u5FCUWxUQksJbsxJ0/1+zcsU46rLaVsqAau+PCBN+lobYomICzDu+Nmk7yrETb9cNmVxrnjZ0VZ+6Skl3E1gRVVgYo/lDgti/bnRffR6TU1+RkOyPwSmnF5zIlmNp7SL0PuPNuRJ7CYGYvbueLQhtLSBBfr0FWj5RC/r6Nmggibpt8vW2yjefNf2gWfjYN9uMlpqnlYO/twrG2zsThi0WRflODgfi/V0Eqjot5dp1s3XZ8qKyxA3Y1GKxk9cZ'),('bb71d9ef81cc0500e3de2de6bf9a552d',1363382377,'Kyu02+lEUtMmsI0+fW3gR1/0GtrFUMal8TvOTL7kxG0sk/pmBFJZ2HkBj/eFC9tE0r6D2r74DdRdjIMzIac8z67u3jnCwNVXAGMRzBrEQezm4u/eH4TaXFxDEH92LH9ILbKFEkBnUcT/EsBv7JNtXKHnkA8OyBvlhOFeDs9UmALbUNq0i1aiOr66offrUNR0LU2bdUkEaWGhZYNNTJ2FZu8iYiX0dUKi5PQbZLzxBTl84biIvPJIc8azHTKz9g=='),('71aaace1cbeff523a15fd29a27cbf562',1363382391,'C2GYAeLe7T5loDNWeLvgcsbYgb8f/TccNuNycsHDQe+A/q1kUbHiSmwLAYhs6I3dwmRTRKs2upzGe54OsJwxXn/XfdQ4CFiaZIr3RuXc8cak2+lF+xJT5qz1AX5vaT8IcxrQB6BqG8OLc6+jgb0T09eLOrnLnju9OUZjaCBRJQC4TFIbc91LDETZT0FUqypyO/h6P6Ql70yIwQevSoKrprpREKx4KG7IAsKtB1w66AAnAOXIc1+D+IRwxPPrUNaHEtCUI6u2/dxID5xhl0Ccow=='),('4ecef8e2add8bc8e60fa17a12967d9ea',1363384648,'LBMb4IQdAxAdIPCXP8GQiMtbr73vXJQC9NG1jkHqg6FmsUYZ6aj1C3tb1yM+uNExupyfsl5Iuq1F1091K2+hDBKqCERUC+Fyerxl2oJrh7I9IykRcl941dMPuq6k5m2EdGwS9XewfmKntZjttrqb/nvH/nopBgh/oIDXo77UzgL8kuky3wMEC7gFei5DcVZvepLwknuV2PUD6rDo5QwJ/u9JccH+9aPFE5N+1DogRfjMlPfH0A7YsFxJifDehzjHemaMLA4dZQs5bEflC9k+14nAJXFRTMxyOh56av515lC12OBQOuapF6a7aqETjbtEaNpd8Oo1rsHLN6JJSBVK6iaY7BQPXbftwF1NBD7ZxTIUA+2okrkYxQYKQX9iV/lCW2JUd2uuKzgjHHR/RJVStniN/RcoQeH2p8ykw6twpJjMUjSlKDXcg5JbSH8bgga3rNwFQaskfNmlmx2YvejU2CnyXncYg2ZBbUwY42iI4Vv2A6G394IqysvWnij/l0Q6GHGTIO0wCSyPXy9NcHvJFFOLiYLgKlaSvjKPI6j+HFLTlv9ztFzLTkMYjCw9SxTQM0iJEr3YNC9dch3YFS4Ie1XCq7YRmH5qHJqNvSDcVYGlm/bLhc+bQAv0cPPrCJKzVvtFHUygKk3GfuOkJcfvIM9u1IutG6kb0YbSMIOeEAahBNup3wOgy8TOylZrD62Xo7ydIyx2dFgvWS0TIs24y230GdeW0B+bGHw2fHz0sof/bj+9uY/GEUriGLivDx/gRDHGPcELi/UeiuaJHMFRbDEOWzxam6wbBmTkpq+UxJmkC+z/XFIuAtDRrldZk4kxg5Kl5Arr6EdOVh5TS5hWpo8wbrFm5kfXpJRx+XjzSObl/s2/yYV91EpsIEglABzfRIx+1gLRmuilIs+G7VdsEPkxbF2Li/6W+PcoYLC3lsH7a4dLwiltm7df2n6ySHrBeECu8Fhd3+tIahEU2xeqT0dJ7k5KCuVrus2EKHw6x6qb0XqcJHisrAyE2wXEVmZezC1yzGc0kYFhBTWdlrA4RT1qD7s71wml0DzmhVqgguFX6Mle1ZEz4B/udwVGsay2nnFGNAyvNmEq8fik5EZSx/dj7ywHANpkKHqZ846OBhblR/TzMnhCgWK7GoepB14oGBoWmzUzJUgJznO1d2IMa1badmT2XKPIgl/kcyzLtxgnRGbWWZYBkWd5ku8uMqPZ9pSTYsndBwK6sP/sWjQIGBakVoBAUDMqzUSEhswzr6l0dqTlXNgXyiF9G1xTWM29U8V6nVGmQSBgiGusaadX4mV3Gu7tY1G7tw3QwrNW4AYjny6oKJk/4+wXxgakN5x3AMXceFVdyB9UnEapPIHwQr7pfsu8rgC+e0fGeHo3ASS97ZJwJqjuzo6Lug=='),('152f36864ec2974578dcc2ff8045ebf6',1363381577,'0P10oVphSewfqUB6b50cIH+YPS/h464FaY4B8wMwLtJAX7cRY2vjNaCUykkyapIL9LZTYuYN7Da81U0J6/HPdunw5jBG7jliMIF9ZLqwa1+fZ/ya0JazHiu5kOHKabTkppOpsFjICa7smMox+UwN5eiYkxJRBfDfoy4N3rtRJQ2csioNvzuqAOjr0Le7DQUB2XYDwJy0p0hIkIMCvz4RBhBFyErvNXs2us+b9QC6nx5rwcJpN3OSLfVZc3pSUZH8ufAlqYyhQBVsEkY88fm/PZEFqUhvgP4FQiWBNGF0nNQLgbEe8Hb6OzwQV61tH22tNYV9U1PmwzULsd3SRo3z8iQuy4QJ2hZBnpNrX2TwFFgkEPStXwGsKs4HK39cDr7klk7hv1qxlJkYpt61pNDty2Ds/vCCDV3PuBhwujP+01r+yyjT8Cg862N3SENN'),('3301e3477d38ee9daa6d592e8d85466c',1363383910,'olH5Dk/s5pxl1L6ChoHwW4QPQhg6LR+YMoKqMfxJ2I2Mld48AqWfGtCbFgp/RWy0BSzuqRoy/nWKy0f5h2VBpLTabu+FH6Gg0zBODx1zRcPTegIvk57Fdz/FMso9tZ8i2C437y0cs73Vy/BQLNlnLLmF5KsIxoxeaeNyY56Uu+o6JW9oYbh5RrGo32JKOxSRWkgxov8l8Z2UM0/nzfeG1yUT8cGZFUC6kO87eatgV7wageLZRLtmelkkmZRh+/stxVplvEopRjAcEFLyk2qe1J0zHqBq/cKwysN/MMnwYU1Vn8aPLsh4GE6MzUSA7buELFu/yMPca25IU4dqC0U0BaGnQlip/eO9nMnEWfbjnxls7M5LUxMAVhraMhhIejqRYtr1o3SR0bkBuKbJIGV8qZb/twvykzrOKBg3DI+qr8ztUg2+ppHHJleUEOUUzLyROpFGGf/t30jTSvth3jZV77ZbvW5gFc5T9HHSsWdKAxC6Gg=='),('320616d896acbeff744de1e4d013a8f1',1363384638,'aIOu31wuTssj0109+LiPZ6fYRUD9+/yPgtzHA4jIyK+zXm1wTKAHTq+jjeF4ZSBFDuhPPSSLcINKePd7Jp51lNiDhSLRBRWQboCDXRS7B2yfYxp3EqBvAi/aZGVQ5X8obP1K/eyl3cTZQBhmdF4Y803GcEV7D6QZF/JuGzG1VRQMB4+uiPwAWuqktRaybgplXAfD/YM1uNfi/iHJ4DJJFD5BvIRxK7cnyMCjj/jwSywWaYbT1NYHZQ51P25z07KGcxclwg3HJ4sx9Who9kqkLrKOkPTHM/eFnqWodPur41klkDuMldj0oAmO4jFrnWTAfuMufNWsr7cMm0nYLkK2HA/pTEB+m8bjctVUFlRIQ+v3cFuBiJi/sCtgFXzWQt9EW39aF3cmM6ATkVN5kqetpcFp2WOE9et4zQhvWbxuVyefKu/GSVk0zLZ2D1vEw7ZGLJuxVb7xb7o563dvwCekv1b7gF7Q1ncgqZwiPoaUb1x+Ri1HA8moj2thBYS4g6m7JlZ8iHZOerYO9/VaFvb5OFeBM1y0Fhbfps+cMQKhRc2+XZzhCZdI5obBQp8dugGDVaD7nGIqn7B/kTxM4uMU3Hv7ot0kYb+mYMthLEuo+E7xJ2pUwxM9XlNuz6uq8966JOdKrXhcdR4doZjjWMfKKy3ihYt2isMUtDDwXY3gPEroJudDd9HomElQ+BQZNlPvXzPBUoDktDONXbLIV3DyhNW5MOZRynCprpdbU3JwDsnVHcyYayvSvudJO+PBFxLuhLj8HqAMbbBTfB2MFEJn9VonEQAS5j6Pf1dAFa5xV9jrhU1Wwbi5x9eaXljZtg5aDrCwp2OxaQTJ8yetwaCEFhcXifxsHRGes29ZzqjH90xOlzsOaWzJjnl9fJEsRe0t7bFaiP6tU/lCYYEtwP1L0cV1BAVtret6vshWFNufp3tCfgaCKT9IwuTr/n2dd81yWP54S4268o8pOZy8BIHF7yafsQMfscYNkJrBgT8TvFwoirOdmSzpEHoeG8bId/z6Ex6BqJBZeXAxAJ9KuM1lxJhQ8HNM0I59Kim0lbyxVoVLF2NkdgjRVhl4yVo9Iux7aUoHoJX89ocS6kYr9IC9R6li+9z9mD86FkiC17rOS8BTRXUoMmGVmmWh3aDKWg9d+Ktzg+lLKZLNAfR9XYKUhMjh6xTYBV8UjsZsO+P5gPHCUWCuDjBKBAwNqUVrD1Q1Q6JjStEllQ2kTW2InfNbYEj+Ik3qhA0Zmw6tqyxb5W4oPJbk9SFZysLZP6C3OQj+j9HgmRyWW5k7GFHyrDGknDHCRBxc2fBD96eOfJqlL3LRYLxZ1+LfFs07NoG8c7iXkNsgYHR3Gnw/kY2obtBo'),('0905299d56240262b480587f975a3f0e',1363384349,'eFlbjuzv1qXiaqvxw1c9xcGGJk8huls1jI0Qa20y9MG9D6Uq59rIInXuDkLoQoqMKN6iRxKAttFPHTCMr3mM8C7D0Z6FG3ZkFDDb59TWLmMjxa/AFjlrjkWWG8YJKHP7t88d03tquMzJC7o7CLG+IY6uhD8zje/FaN9HL3UqJCu7BDDVC2GtwWmthfTjTppI2hFuphb+AsP+v/f8APqERIeRbK8atV8ps/G/3pwgQvjm8GcFZ34oPBrkyJBpp4YGDhD6WE8YSh1YCcU6BAw4kgk8fV1AR9n0yvEOY7BIcQ6PPfYsfk5bo1mygBjj589DcH8jKekpwFMREGef1LM3TG1TTghqYY6lXuLewstjrHzzOE8f78cMRzzH7cxnxcnKks3Bkncq3+BR+jDdpTbqwZPv+EUx1zjE2JKUE3zyBEFyztzI1AExHpPbvNsfP/o4oRuXiuJq7PL4BX0xqt4nRPy0dvdJ/MKLK91NivvjT2MijODcPUx70Rir6QyNUD+hMdr632QyecCOWX3g9MqGf8dlEMy92qMzGP1eOD6Wk+RHSoPD3oiTik7T3NIF9qez'),('3e28d3c563aad8a1ccd852bfd2f6a964',1363383697,'u17gGByZfjf5pBzlqLTS5bsziPn8NXgjMEsNL2mXZztdbejsWYoXOBVjU+X0t1fA48cGIvLkR8t4K/a09lYEwZu+koAYH73CuJeHvp3JFe7SErlMFR2qMrzY5IqELamtr8DE7o77Hv0XwG3FCJzLR6LuBSd73KM1iCu2OXBdohgBIh5bSehNLK2mGQu1VT9FSUS1V7tqKw2QWIng2mrdAuAvuX3cZwbt+J3jVB0aFz5TPcTRADdmlHcKmYf/zUuYuSpHS/5+UhOuP15vSN+/rgOkv+u8k5GoU1J5b6ccdsNTgllODvErvAp8chub8C0ROLmo2SmyqNfLFcv+7HkFGeQCl8Xy0aB6jrY4KF0bGsmnk09nO5yocuBlEqBh8bnqoanNGdvz1YlabFZAhkwqsDN/ZDuKMAXce7vKrLYh3OgX84sdbDLPWsDNLh1xCVyQQHQLsP5AoonYLvkPLD6Tq0eSM+5HTjaogZKNLmgBC3rB9GwOZ0P9bRJkVGNj+gJQvPEpPnPpO6gjW97KMfYe5K6B4NAdqaBDEj9BzVu5K7eKLPDHaVXCVHLJT+SL9bUGHoKzWIdSgJaUqvDWqt/V6GPwVwU3+/NNLAEg+x5H5is3bNRWMroFXc3JBaTDiTBQedVsXpWvaOpe65dojG1c6P8gD6OQ0pZH3jUmvMBs9erVysuGV2x/AKBz0TWTpWDwtm0Lb1h0cluOmlA2G0vYWVKR1XGNdNd36FERpCbujBIZkTLVNmR4m1s9HbFXsoInWbRmCSmL6MN4hF3XOvhRcRztOlj7oF5bF0m2u490XhQA0xukYOfMgeCqwehxl2IdYcmABZgjEVnGMyuUPF5dyOWSM8WRlWsQ+1xMxZehO1wbx0A3fWuUjjUSkms4PCL2VBXCdRiokqFuqRWdmWyAAcUsepWzKggu/cRaebRpJivPx5J3nwrWvw3Mc7Tf9WABCNdN6UDbYUSLBTlGQ3W91FxKJIdLdd7bqyDucuYm2+pKFvXF5iZ50+ydSjpqmf8zKZilePMOEJPJ0vhUHa6JJNBxnO9NodpwSDGtehuxFHFVNfW6tcGOm/Y7SzMjjOmIzS866rpX9MEyubW7qUdQD4CERnT4hTx+JLA5h+yNPKkHPGsa77ExoS1iD/J/uptOQ/HKOyClMV7FSz1nei6nGkm8ONMlvhK0+GSonXn/9Ud7ESwukEOvQnZfqzTb097+u0VqftWlsMoz5uu6KpcR1jM35kgx+LR+TU8M2JSvX36sUKy/h+iKD26zMoXPqMlTymqNn9TuemxUhbH4MQwGCd7ZieFB6FYZR38S+XfB8KwdUT/zGVq4IQv3YcRIjpbIKfF5ctcc6bE='),('d5c20256cc2ae84b4e8990c30bfbc444',1363383829,'Pt4SZKgdUsxH38WpuRT6o6/6HmFH6AhWWdZVU6J+g94oy52q9L1HcEv8YNQjMYBAfNjnqWZjLCh+9GZjBR7J8GXmR9uCu5wXQJiF2xmmdVbZZwLicSuxfUTgQJ4ssIci6hvNm5+4QilFtykqCJZreMMGbbYCFWEf3prPuYb0hPuhQsYe9Rlqd5dOz8XHqwnnFWgvFef0JyFfdD91ZFHpmZd2Q9JNW8DQUR3GJ/bBZfSLMrg1kY+Uq87fHFdKmwhxNUxWsnPsHjqm3Sk4On8Jdn1wnVINtlGRPswIBfuN46x1M8b6G2GFnpaJ4ZfvhmQKCvPPZQ/Yg8CxKbTV6ZKKFVx2wuF+RU0iaSuKywjbwqdM+6J+4xoYPxf+2cI/Vcqas2BID40bOezqAJv/MyP4SjmeG1GIWmRAqUQ8vPW1ehlxNLXPnU4rHcwgpXP+WcZ/MZnOB1KyNKKRqI5bfOj6JY3pJpFdj3MepVbKvopSJ4db69bpBN8OuuIkkoWn5J+xuDug'),('34bf3195f48f9c5771a14ada46eded14',1363384729,'J3YmKZItU8eAhp+eCsvmfQeRirNE2p4Ig3NGQMlAoKUq2Cyy912hP1MtnrK6Hcobm9Lavt6aiHGnZEPFdGZV7N/+mnLq/W6/9QxxyCHt3O/PhnzY/LjkpdnGodpAO7rYGAgNeLuCoEi7Jn9CdwUTovhFU73JgmxVdkHzDL+cdO3MexEeFG5bqKz7gxMidLXT9L+2b97ydbnzg8WqUyGRH1Tew9+Vr+ZWCHwvklEGiLNP5yOhONcpvm21ukVFXXyylqaIquNqPybAUBVPsZpOGztAT/PdIqzilSqJySZoAsusbI3k3ic4Ov2W5JLPQWrT1x4wx+GBODt6jIR3J62EhNT1cUYxN95QqzXhAMkATYJL/NFbu5NFs4EHpRrrDIZCdvSL2Ex6cSAjkfEzlNOKkjElQwELIE+s0u+Zw8I4nRO2dtaXpWeIqqLsHZQ23nd0AZbDcg=='),('e4fc33d35fd19af1433ac89d2f84fda8',1363378111,'lbQlOflC6APUQNTNXz6t9sT9L22IZ7DLbfC8oZ9XWGtCb1i+A15/+ei3jIx7o/0VsL4VVtf3WzoV1s506M90HM4RNI/xwJ6kDFLsh34ewSw05KjJk0/BIAsr/96Rp3jbQK66nqoWsmVCBOGzPKjEtCnKPBqzXumJKg5mFTE76CJhJ8QSNXkZoCFrG3SVUcbZaoYmYiLk7Yc2g3ht5PNq+tBenqPWU7HGrrXZBydqaeUpq5YduMuG4Tkf6fMu7L2ILzSaQR1jm1E5lQsFu8dO04H4cYpyn1WOfuxW/OdrzfYaSeuZjhM+rnmdBuYy3bZrN+rH1R4o+wqJqJ/TFNE16XOPFZnAgl3BZP19g90tFZVf3NlLciJVC376CoiE4/sffR7n/agYhftDfNxPSSpmwbNkifgSlaFDfLWNkFySCRF6uHLbUh9ZduGzRvGr1dqv3ZZWZue67p1p5CW634JGNdOgWPe7TZrVqhXweoo6pVG8MAQnKCEJTvYch9qtSiMgtUxJWxMNBEy+GMlY5AcJ2Zt4njskn0ZngyvVg0iR5b1cak1osdGYySztEpVrRn6NyNlCZNwwCIvIXRSVS81XW5B2lEWX6I9Btj+IglCVougeG5aOmU8HXj1a/Rfdj/bMKZMv8AQ7hZYQdhoVFqu3jihUn0cIB9LIt3bw2vqcfhaoSXxESdP/NmeIQ3j8TaKgtjI4gQ4WkZ8l8/GbkLl/VTv8fxrHP00d1XLTWp5PZ2xFJl7nQ8DFueuO/dBuu/yuvvnPRTTIZrWSk1cfpqevIPBiRAfZx5cu3MjmHCe/zbJL3ZAWoqY0hg/RisXHB35V3CFwyT+y+n/n1vuSq/OXVJ7pvk7rCJgdHSbKI/Dj83sVDkUDbaSaVz1EHT7ZMtQwAOLdtu8ZsV+FO9hzTTLVvxN+V/g/0A02Up4aDGxW1mfTr9MB4LTeygEGvdZwYylEacotxR7d2L89NychwxvT3zilg+RB55rUHb5dmNLhXC/A4yl42RQHU+FxwRpc7wWhSNPAjE0VdvY3Lh3LJUT1tKPz9iP4KTArKCEjYhi34smeI5Jvlek9cOWSWueaESbvYsjCsxA1mdTAPHDVzpLu7Smmqm3mHNX+P5OZjXSCMdqhlrnAXjb8qGDZ+txe3ZmiYs7hR+O65w7BToAtdmsU7v9Vo7he5DJ8nRMtKUWSRzwEvBZDB2lVxrsqlB3LPt97nI6wQsU+uIUgFgAfd1Jf8HKoeLHaT8U3VncwHUmma8TnKCkG78FLt8Xy3cNkm8386mEQ73gTsmdHbVxeQt+KJJNmn4Ty3MKEgzCaF6Q4F/FpVdOQDG7bBvDmeKiWqEzHMzcRaoFnwgYdi9Kim/1eE49b'),('9e9f1033413d5386911c6f232209b7c5',1363381375,'LK7S71pShvRuuWJ35OUasxGuhMaJzO+u1GtmOB4mCo1ckz6Clnr4RQnmpf+v1WSYlj0VYph9u4/rp9GT7+nNhrlXWGlxbMTZ0sJYoMP0pcSvB/DoA3MwWB7W30dtNtowQ04w4zU4Ejmt/z6+NA+B0FQ6nRjdS5VSxVlClGhusKYD+saVeUfS0J+aqqSiDHUzHxp4sUSCVMMJ2rgPLvhGywCGdl7Lyf7jqxgKcFhwTNuSl3O88piKzBKPPC3eT8bTKs5jy9XZWXRr/KqEgSvc4oB+uuffN8gzegMa4/G74u6RAEZIFUjBde53aFoaQ+9YlL9FzZx467ehKddcrGflUzTaK20YbmjcpA/U2mtUcYI4cJaNJ8a4FyhcKGORr/5c4I8gDUqnmtf9MucB9cT3X68fG7p3j2Cjms3dqbkWjaeK5Vkic6tn3eXzcZr3vh909sxOpQhjtGkrWXozTiMkIaQ8KpB4R6YQsBNa');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `settings` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `key` varchar(100) NOT NULL default '' COMMENT 'Unique identifier for the configuration parameter',
  `value` text COMMENT 'Value for the settings parameter',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uq_settings_key` (`key`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'site_name','Jószolgálat.hu'),(2,'site_tagline','jót, jókor, jól'),(3,'site_banner_id','3'),(4,'site_email','info@joszolgalat.hu'),(5,'site_key',NULL),(6,'site_language','hu_HU'),(7,'site_style','unicorn'),(8,'site_timezone','0'),(9,'site_contact_page','1'),(10,'site_help_page','1'),(11,'site_message',''),(12,'site_copyright_statement',''),(13,'site_submit_report_message',''),(14,'allow_reports','1'),(15,'allow_comments','1'),(16,'allow_feed','1'),(17,'allow_stat_sharing','1'),(18,'allow_clustering','1'),(19,'cache_pages','0'),(20,'cache_pages_lifetime','1800'),(21,'private_deployment','0'),(22,'default_map','osm_mapnik'),(23,'default_map_all','CC0000'),(24,'default_map_all_icon_id',NULL),(25,'api_google',''),(26,'api_live','Apumcka0uPOF2lKLorq8aeo4nuqfVVeNRqJjqOcLMJ9iMCTsnMsNd9_OvpA8gR0i'),(27,'api_akismet',''),(28,'default_country','100'),(29,'multi_country','0'),(30,'default_city','nairobi'),(31,'default_lat','47.498868116865'),(32,'default_lon','19.044456481933'),(33,'default_zoom','8'),(34,'items_per_page','5'),(35,'items_per_page_admin','20'),(36,'sms_provider','nexmo'),(37,'sms_no1','36707177179'),(38,'sms_no2',''),(39,'sms_no3',''),(40,'google_analytics',''),(41,'twitter_hashtags',''),(42,'blocks','news_block|reports_block'),(43,'blocks_per_row','2'),(44,'date_modify','2013-03-15 21:36:50'),(45,'stat_id','51527'),(46,'stat_key','b230d25bc3d2be05013512cbddaa91'),(47,'email_username','riasztas@joszolgalat.hu'),(48,'email_password','r14szt4s'),(49,'email_port','993'),(50,'email_host','mail.ppt.eu'),(51,'email_servertype','imap'),(52,'email_ssl','1'),(53,'ftp_server',NULL),(54,'ftp_user_name',NULL),(55,'alerts_email','riasztas@joszolgalat.hu'),(56,'checkins','0'),(57,'facebook_appid','477036919016098'),(58,'facebook_appsecret','dc2c5b84577a5153ac540e015c0f50de'),(59,'db_version','97'),(60,'ushahidi_version','2.5'),(61,'allow_alerts','1'),(62,'require_email_confirmation','0'),(63,'manually_approve_users','0'),(64,'enable_timeline','0');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smssync_message`
--

DROP TABLE IF EXISTS `smssync_message`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `smssync_message` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `smssync_to` varchar(100) default NULL,
  `smssync_from` varchar(100) default NULL,
  `smssync_message` text,
  `smssync_message_date` datetime default NULL,
  `smssync_sent` tinyint(4) NOT NULL default '0',
  `smssync_sent_date` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `smssync_message`
--

LOCK TABLES `smssync_message` WRITE;
/*!40000 ALTER TABLE `smssync_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `smssync_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smssync_settings`
--

DROP TABLE IF EXISTS `smssync_settings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `smssync_settings` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `smssync_secret` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `smssync_settings`
--

LOCK TABLES `smssync_settings` WRITE;
/*!40000 ALTER TABLE `smssync_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `smssync_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_devices`
--

DROP TABLE IF EXISTS `user_devices`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `user_devices` (
  `id` varchar(255) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Works with checkins';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `user_devices`
--

LOCK TABLES `user_devices` WRITE;
/*!40000 ALTER TABLE `user_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tokens`
--

DROP TABLE IF EXISTS `user_tokens`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `user_tokens` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `user_agent` varchar(40) NOT NULL,
  `token` varchar(64) NOT NULL,
  `created` int(10) unsigned NOT NULL,
  `expires` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uniq_token` (`token`),
  KEY `fk_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='Stores browser tokens assigned to users';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `user_tokens`
--

LOCK TABLES `user_tokens` WRITE;
/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
INSERT INTO `user_tokens` VALUES (1,1,'69a446b9a894d8042284af656d11e503abd87413','NALyD5QycdTMpT6oqmIfWk8o3MpNfUci',1363341774,1364551374),(2,2,'0577c057dca0867e18628f62654f56ed6d3d5f6c','qOOaVAyGS1mYcqPjpNyOZi6qsP9uHsHR',1363343782,1364553382),(3,1,'a6a09e95abdc56bc160ef56cb5bb72087c7baab7','yqtcSLIjST0DdLpCci0uB0cHw2x85FgU',1363345326,1364554926),(4,1,'3436bcb34c7fd95b33a5800388906d53c89d82bf','XAxYcF0Q2MpbWIZYMZVOQZL8oCu2xEgF',1363361786,1364571386),(5,1,'0577c057dca0867e18628f62654f56ed6d3d5f6c','DEAo3zLb8kYEBr2HHCu2WCQfAs5QfZAX',1363372006,1364581606),(6,6,'7e4e9cd3d03cacf48173e9ba841c1e1223b4f2e1','Najhv2tEg0iRhL2YJUABxMTjnv7ZfE1w',1363374655,1364584255),(7,7,'3a50d2c9ffcf03959181988aa35f3d15cee75c89','AGvxmwcXNr4bbWR1WIF54lIOpKbX4qTo',1363374696,1364584296),(8,8,'7653edb74ee64b1799cbcb9698248a5fa3859a36','e455oDudU7ABoNjeSXPozhIKhbbMcAPo',1363374870,1364584470),(9,7,'3a50d2c9ffcf03959181988aa35f3d15cee75c89','ZRCPJEe8OPjQ6W7L0ql9oEfIcDK9DY8g',1363375243,1364584843),(10,6,'7e4e9cd3d03cacf48173e9ba841c1e1223b4f2e1','hIaBCcuQYnvDUNDC0w6Y7mMxZHAtfqLI',1363375247,1364584847),(11,7,'3a50d2c9ffcf03959181988aa35f3d15cee75c89','tkuXvzWiBV7qmk4NCMWPMkf1QYV9wVeV',1363375578,1364585178),(12,1,'0577c057dca0867e18628f62654f56ed6d3d5f6c','A3nlEqXIXn4gNU0PlO8MROs11krIW1lF',1363383685,1364593285),(13,4,'69a446b9a894d8042284af656d11e503abd87413','29aLfbehCpPQOjS6M2modpV5PZHjE7CZ',1363384679,1364594279);
/*!40000 ALTER TABLE `user_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `riverid` varchar(128) NOT NULL,
  `name` varchar(200) default NULL,
  `email` varchar(127) NOT NULL,
  `username` varchar(100) NOT NULL default '',
  `password` char(50) NOT NULL,
  `logins` int(10) unsigned NOT NULL default '0',
  `last_login` int(10) unsigned default NULL,
  `notify` tinyint(1) NOT NULL default '0' COMMENT 'Flag incase admin opts in for email notifications',
  `updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `color` varchar(6) NOT NULL default 'FF0000',
  `code` varchar(30) default NULL,
  `confirmed` tinyint(1) NOT NULL default '0',
  `public_profile` tinyint(1) NOT NULL default '1',
  `approved` tinyint(1) NOT NULL default '1',
  `needinfo` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uniq_username` (`username`),
  UNIQUE KEY `uniq_email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Stores registered usersâ€™ information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'','Administrator','adminisztrator@joszolgalat.hu','admin','e4a2a574ae9f29f69f2f5bf4d0682e9cd684ef6af784ea1e45',10,1363383685,0,'2013-03-15 21:26:02','FF0000',NULL,1,0,1,0),(2,'','zuzmo','gabor.nagymajtenyi@gmail.com','593437438','d3241438eabf82f0fe2fc26e22677aedb5d35bd1f2d3e042e6',1,1363343782,0,'2013-03-15 10:20:59','FF0000',NULL,0,1,1,0),(3,'','kiazami','madarasz.csaba@gmail.com','863647461','68d25accaaa7c24c675283a710ec3a2b157788f91b23ce2360',0,NULL,1,'2013-03-15 18:52:25','FF0000',NULL,0,1,1,0),(4,'','Gabor Grosschmid','gabor.grosschmid@ppt.eu','grosschmid','7a8effb7d92b919cff90834742686fc037cf09f5f455969c54',1,1363384679,1,'2013-03-15 21:42:35','FF0000',NULL,0,1,1,0),(5,'','turcsantamas','turcsantamas@gmail.com','897084341','fb8fc048b7503aa4adb1645d2ce5cada88652b49e90d3a5ff9',0,NULL,0,'2013-03-15 18:52:58','FF0000',NULL,0,1,1,0),(6,'','Zsuzsa','toth.zsuzsa@gmail.com','1031375410','48fdb9ad76ddcb01b0f765276ba4ee9b344a08642489388d36',2,1363375247,0,'2013-03-15 19:05:24','FF0000',NULL,0,1,1,0),(7,'','Szegedi Eszter','szegedi.eszter@gmail.com','966709493','70f856a6d74ddffc0129b0515573d0cb6202115bf5ebf4498e',3,1363375578,0,'2013-03-15 19:10:55','FF0000',NULL,0,1,1,0),(8,'','dalia','dora@ppt.eu','685707517','15bc7642e47fe6418d52b676d2a7c0805a47e7467a009153e7',2,1363378069,0,'2013-03-15 19:52:26','FF0000',NULL,0,1,1,0),(9,'','Breznyanszky Gabor','brezy@ppt.eu','brezy','dc1582600da3674a5c35db3d8278dda093d436a9f1abb708da',1,1363382188,1,'2013-03-15 21:01:05','FF0000',NULL,0,1,1,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verified`
--

DROP TABLE IF EXISTS `verified`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `verified` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `incident_id` bigint(20) unsigned default NULL,
  `user_id` int(11) default NULL,
  `verified_date` datetime default NULL,
  `verified_status` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores all verified reports';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `verified`
--

LOCK TABLES `verified` WRITE;
/*!40000 ALTER TABLE `verified` DISABLE KEYS */;
INSERT INTO `verified` VALUES (1,3,1,'2013-03-15 15:36:40',1),(2,4,1,'2013-03-15 15:36:42',1),(3,2,1,'2013-03-15 15:36:44',1),(4,2,1,'2013-03-15 21:33:01',1);
/*!40000 ALTER TABLE `verified` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viddler`
--

DROP TABLE IF EXISTS `viddler`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `viddler` (
  `viddler_id` varchar(16) NOT NULL,
  `incident_id` int(11) default NULL,
  `checkin_id` int(11) default NULL,
  `url` varchar(255) default NULL,
  `embed` text,
  `embed_small` text,
  PRIMARY KEY  (`viddler_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `viddler`
--

LOCK TABLES `viddler` WRITE;
/*!40000 ALTER TABLE `viddler` DISABLE KEYS */;
/*!40000 ALTER TABLE `viddler` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-03-15 22:00:33
