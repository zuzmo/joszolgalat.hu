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
INSERT INTO `category` VALUES (1,0,'en_US',0,'Hózárlat','2013. március 15-i hóakadályok','a3cbfa',NULL,NULL,1,0),(4,0,'en_US',3,'Trusted Reports','Reports from trusted reporters','339900',NULL,NULL,1,1),(5,0,'en_US',4,'NONE','Holds uncategorized reports','009887',NULL,NULL,1,1);
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information about RSS Feeds a deployment subscribes to';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `feed`
--

LOCK TABLES `feed` WRITE;
/*!40000 ALTER TABLE `feed` DISABLE KEYS */;
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores feed items pulled from each RSS Feed';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `feed_item`
--

LOCK TABLES `feed_item` WRITE;
/*!40000 ALTER TABLE `feed_item` DISABLE KEYS */;
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
INSERT INTO `incident` VALUES (2,2,0,'en_US',NULL,'Próba','Próba','2013-03-15 13:34:00',1,1,0,'2013-03-15 13:35:24',NULL,NULL,2,8),(3,3,0,'en_US',NULL,'valami','valami','2013-03-15 13:06:00',1,1,0,'2013-03-15 15:06:51',NULL,NULL,2,8);
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Stores submitted reports categories';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `incident_category`
--

LOCK TABLES `incident_category` WRITE;
/*!40000 ALTER TABLE `incident_category` DISABLE KEYS */;
INSERT INTO `incident_category` VALUES (2,2,1),(4,3,1);
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Holds information provided by people who submit reports';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `incident_person`
--

LOCK TABLES `incident_person` WRITE;
/*!40000 ALTER TABLE `incident_person` DISABLE KEYS */;
INSERT INTO `incident_person` VALUES (1,2,'zuzmo','','',NULL,NULL,'2013-03-15 13:35:24'),(2,3,'','','',NULL,NULL,'2013-03-15 15:06:51');
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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores location information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (2,'tatabánya ...',100,47.502579,18.583031,1,'2013-03-15 13:35:24'),(3,'budapest',100,47.498868,19.044456,1,'2013-03-15 15:06:51');
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores tweets, emails and SMS messages';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
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
INSERT INTO `permissions_roles` VALUES (1,14),(2,1),(2,2),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,11),(2,12),(2,14),(2,15),(2,16),(2,17),(2,18),(3,1),(3,2),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),(3,11),(3,12),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(4,19);
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Holds a list of all plugins installed on a deployment';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `plugin`
--

LOCK TABLES `plugin` WRITE;
/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
INSERT INTO `plugin` VALUES (1,'frontlinesms',NULL,NULL,0,0,0),(2,'clickatell',NULL,NULL,0,0,0),(3,'smssync',NULL,NULL,0,0,0),(4,'sharing',NULL,NULL,0,0,0),(5,'viddler',NULL,NULL,0,0,0),(6,'Ushahidi-plugin-nexmo',NULL,NULL,0,1,1);
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information on report submitters via email, twitter and sms';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `reporter`
--

LOCK TABLES `reporter` WRITE;
/*!40000 ALTER TABLE `reporter` DISABLE KEYS */;
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
INSERT INTO `roles_users` VALUES (1,1),(1,2),(1,3),(2,1),(2,4),(3,1),(3,4);
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
INSERT INTO `scheduler` VALUES (1,'Feeds',1363363243,-1,-1,-1,0,'s_feeds',1),(2,'Alerts',1363365962,-1,-1,-1,-1,'s_alerts',1),(3,'Email',1363363244,-1,-1,-1,0,'s_email',1),(4,'Twitter',1363363244,-1,-1,-1,0,'s_twitter',1),(5,'Cleanup',1363363244,-1,-1,-1,0,'s_cleanup',1);
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
) ENGINE=MyISAM AUTO_INCREMENT=251 DEFAULT CHARSET=utf8 COMMENT='Stores a log of scheduler actions';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `scheduler_log`
--

LOCK TABLES `scheduler_log` WRITE;
/*!40000 ALTER TABLE `scheduler_log` DISABLE KEYS */;
INSERT INTO `scheduler_log` VALUES (1,1,'200',1363341776),(2,2,'200',1363341776),(3,3,'200',1363341776),(4,4,'200',1363341776),(5,5,'200',1363341776),(6,2,'200',1363341787),(7,2,'200',1363342009),(8,2,'200',1363342118),(9,2,'200',1363342148),(10,2,'200',1363342321),(11,2,'200',1363342428),(12,2,'200',1363342462),(13,2,'200',1363342501),(14,2,'200',1363343035),(15,2,'200',1363343050),(16,2,'200',1363343136),(17,2,'200',1363343170),(18,2,'200',1363343362),(19,2,'200',1363343536),(20,2,'200',1363343582),(21,2,'200',1363343646),(22,2,'200',1363343731),(23,2,'200',1363343844),(24,2,'200',1363343883),(25,2,'200',1363343986),(26,2,'200',1363344019),(27,2,'200',1363344133),(28,2,'200',1363344228),(29,2,'200',1363344447),(30,2,'200',1363344523),(31,2,'200',1363344545),(32,2,'200',1363344610),(33,2,'200',1363344667),(34,2,'200',1363344726),(35,2,'200',1363344781),(36,2,'200',1363344847),(37,2,'200',1363344901),(38,2,'200',1363344979),(39,2,'200',1363345021),(40,2,'200',1363345111),(41,2,'200',1363345185),(42,1,'200',1363345305),(43,2,'200',1363345305),(44,3,'200',1363345305),(45,4,'200',1363345305),(46,5,'200',1363345305),(47,2,'200',1363345328),(48,2,'200',1363345583),(49,2,'200',1363345633),(50,2,'200',1363345683),(51,2,'200',1363345743),(52,2,'200',1363345802),(53,2,'200',1363345889),(54,2,'200',1363345933),(55,2,'200',1363346065),(56,2,'200',1363346210),(57,2,'200',1363346221),(58,2,'200',1363346280),(59,2,'200',1363346302),(60,2,'200',1363346340),(61,2,'200',1363346353),(62,2,'200',1363346401),(63,2,'200',1363346524),(64,2,'200',1363346684),(65,2,'200',1363346702),(66,2,'200',1363346809),(67,2,'200',1363346836),(68,2,'200',1363347070),(69,2,'200',1363347126),(70,2,'200',1363347183),(71,2,'200',1363347245),(72,2,'200',1363347354),(73,2,'200',1363347385),(74,2,'200',1363347484),(75,2,'200',1363347592),(76,2,'200',1363347611),(77,2,'200',1363347661),(78,2,'200',1363347754),(79,2,'200',1363347850),(80,2,'200',1363347925),(81,2,'200',1363347964),(82,2,'200',1363348102),(83,2,'200',1363348153),(84,2,'200',1363348442),(85,2,'200',1363348512),(86,2,'200',1363348572),(87,2,'200',1363348630),(88,2,'200',1363348690),(89,1,'200',1363348840),(90,2,'200',1363348840),(91,3,'200',1363348840),(92,4,'200',1363348840),(93,5,'200',1363348840),(94,2,'200',1363348867),(95,2,'200',1363348925),(96,2,'200',1363348984),(97,2,'200',1363349059),(98,2,'200',1363349247),(99,2,'200',1363349381),(100,2,'200',1363349411),(101,2,'200',1363349502),(102,2,'200',1363349575),(103,2,'200',1363349670),(104,2,'200',1363350061),(105,2,'200',1363350161),(106,2,'200',1363350197),(107,2,'200',1363350445),(108,2,'200',1363350908),(109,2,'200',1363351500),(110,2,'200',1363351509),(111,2,'200',1363351565),(112,2,'200',1363351832),(113,2,'200',1363351914),(114,2,'200',1363352018),(115,2,'200',1363352135),(116,2,'200',1363352180),(117,1,'200',1363352483),(118,2,'200',1363352483),(119,3,'200',1363352483),(120,4,'200',1363352483),(121,5,'200',1363352483),(122,2,'200',1363352562),(123,2,'200',1363352640),(124,2,'200',1363352644),(125,2,'200',1363352733),(126,2,'200',1363352777),(127,2,'200',1363352833),(128,2,'200',1363352884),(129,2,'200',1363352991),(130,2,'200',1363353012),(131,2,'200',1363353186),(132,2,'200',1363353448),(133,2,'200',1363353493),(134,2,'200',1363353726),(135,2,'200',1363353799),(136,2,'200',1363353917),(137,2,'200',1363354129),(138,2,'200',1363354159),(139,2,'200',1363354230),(140,2,'200',1363354264),(141,2,'200',1363354338),(142,2,'200',1363354427),(143,2,'200',1363354458),(144,2,'200',1363354510),(145,2,'200',1363354659),(146,2,'200',1363354984),(147,2,'200',1363355057),(148,2,'200',1363355403),(149,2,'200',1363355577),(150,2,'200',1363355836),(151,2,'200',1363355960),(152,1,'200',1363356071),(153,2,'200',1363356071),(154,3,'200',1363356071),(155,4,'200',1363356071),(156,5,'200',1363356071),(157,2,'200',1363356125),(158,2,'200',1363356186),(159,2,'200',1363356313),(160,2,'200',1363356364),(161,2,'200',1363356450),(162,2,'200',1363356501),(163,2,'200',1363356565),(164,2,'200',1363356608),(165,2,'200',1363356743),(166,2,'200',1363356869),(167,2,'200',1363356900),(168,2,'200',1363356907),(169,2,'200',1363356966),(170,2,'200',1363357026),(171,2,'200',1363357296),(172,2,'200',1363357321),(173,2,'200',1363357443),(174,2,'200',1363357880),(175,2,'200',1363357941),(176,2,'200',1363358001),(177,2,'200',1363358078),(178,2,'200',1363358143),(179,2,'200',1363358423),(180,2,'200',1363358638),(181,2,'200',1363358687),(182,2,'200',1363358845),(183,2,'200',1363358911),(184,2,'200',1363359234),(185,2,'200',1363359384),(186,2,'200',1363359422),(187,2,'200',1363359482),(188,2,'200',1363359553),(189,1,'200',1363359803),(190,2,'200',1363359803),(191,3,'200',1363359803),(192,4,'200',1363359803),(193,5,'200',1363359803),(194,2,'200',1363359859),(195,2,'200',1363359953),(196,2,'200',1363359974),(197,2,'200',1363360121),(198,2,'200',1363360151),(199,2,'200',1363360202),(200,2,'200',1363360517),(201,2,'200',1363360642),(202,2,'200',1363360705),(203,2,'200',1363361184),(204,2,'200',1363361435),(205,2,'200',1363361465),(206,2,'200',1363361596),(207,2,'200',1363361641),(208,2,'200',1363361787),(209,2,'200',1363361830),(210,2,'200',1363361882),(211,2,'200',1363362056),(212,2,'200',1363362061),(213,2,'200',1363362125),(214,2,'200',1363362215),(215,2,'200',1363362250),(216,2,'200',1363362365),(217,2,'200',1363362427),(218,2,'200',1363362708),(219,2,'200',1363362725),(220,2,'200',1363362809),(221,2,'200',1363362847),(222,2,'200',1363362902),(223,2,'200',1363362962),(224,2,'200',1363363046),(225,2,'200',1363363140),(226,2,'200',1363363149),(227,1,'200',1363363243),(228,2,'200',1363363243),(229,3,'200',1363363244),(230,4,'200',1363363244),(231,5,'200',1363363244),(232,2,'200',1363363275),(233,2,'200',1363363333),(234,2,'200',1363363390),(235,2,'200',1363363468),(236,2,'200',1363363520),(237,2,'200',1363363560),(238,2,'200',1363363562),(239,2,'200',1363363629),(240,2,'200',1363363687),(241,2,'200',1363363790),(242,2,'200',1363364015),(243,2,'200',1363364050),(244,2,'200',1363364101),(245,2,'200',1363364286),(246,2,'200',1363364364),(247,2,'200',1363364433),(248,2,'200',1363365000),(249,2,'200',1363365063),(250,2,'200',1363365962);
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
INSERT INTO `sessions` VALUES ('92026e8358029dc6a303a053bbad8028',1363362139,'BqloXRS+1ZRvboRe8dM0mYewkKlPoG1hUReA0NldeFbYh6aYwN5X9x7PaF+YCcpiI0EenFLVucZ4D8l1g5EN9EvXmsJ4yc/9gimPwjyFYrkEGc4wcf3UflzYMmqm3dvu4UDbDowKX/qg2y8vl4OSJ6ctseifBGqioovJC69KDBhW0e4FR90Qaqd0cUHJXEWMSSvmBgVQVxAst13Jt17/54+J56BRNysTiZQC75/2aAGYIEEnoLje+QRh17cDe3V670f85/goFs0GGiEUGU5X9Qgteq89MFoiAJJjafIMb6KZFem/Mo2FAd6XgGe31C6MTA7JIRp65kA8maUj8zfkO+hVpewfLi9vEZvgjwrwW7+qfDA7szFhgK1Ge1jupa+QTgLMIcjG8vs6Avb1s49tsZP18GddioGYRUPMrZb5JrNCdEGc0W4fLOxEjN6gKWmmbeaGSIao+FWlvjWPAQdNJMWKUwuFDY8oZ4MsgJjyFMD2RgebdAD/Oe7E3M3qST90lVC5T9sZOky4dcRL5w=='),('c89fff36ebefdce84d0947a3be4952c9',1363358127,'lxv/t1TrY6JTLNOxiZXwoq0sRMiYgw6gz8LZtXjbXw65EdyrmmdFC9K2CmOH20dHrmuOPFGVY+/Oig/xoo36ppBRiGum3d/lnX5eVY/MwLH2pP8ovYsVmBnyUoaAwlc9LGwtbiH8OUBipqIA9BBDHwTfFjZJ66Xx1n3bIhA7fNR8kI+l4RPircUJ4vk3bv0RqigAIaECVFv587Fi3D3EqQKFCYhUhkzamX5amvK+xf21SP4q97bH2pcp74z+BJRANW3l5tSXfINtivfKO+7DmroaD2L5nAff97LcF+05QTZF4PgBHNJKtgDtQxuqPUlfxDja6agS5jw='),('5b651b1923dcebd4d8d55f871594dfa4',1363358127,'kIXmtN1Ct+ZgnTbntipnDrFnz/pzP+Ym7KthDzvIkZN8dAOMuq7Bfsud8uKVDV4in6ZCX364yz0a9ruQ59LIUolgdFJRI9kApbHtOA2Q0k7r6nEh9N1Sx8cBEINjbWU8FaWY41oxhpKPbNtpe28bIUyCgrOGIE2vObLcIQ0yWunopkXeEEFapZLH/Gl1hzI7kcBgeStUxdKzPClsHjFG5EbSsCYMbd9RyNBXc1s1j/U3MUyzGCSlkAQaLgl+KbAzokUBDH1SjnmWFk6FoI7dYLnp/dxTsbMICaKXPYal2c2NMxKhTrpFRf9VbyzW5X/i5YY2nbdn2b8='),('1eb952642f6b4f4d2b0c4f4eed629a64',1363358129,'I8N19oIgAHrRQpmxfGCow5umKRNJo9dReogmhbgzs5YFCQi5wlHN9fz92LuvJuIe5nUWuRWXetcNDB6WNk/TNKGfJ7Vziu0osqfUG9892qorl5Yidej8oopICp8cpqH1iokJ+cUCQDFYHkeYIJbRwOK7+h+SwEfAZYgd8amc5JWoqEPPZt57Ggb8twe03uZnag/8NZB0ZsMNrjUvrRTMWbnVuNjfgZk0TG5M/InEYPEMyTrnIGslWhd028Y5/KfWzmXk3FUjv2fc/p7pov7Jy1jdiZ+UuVMVWyjeGQfHWAZMtgCIoIGlkcLsdYPTY+WqJ7DTpOJT2uY='),('8d1253f6cf0423d4407e468cc098bbcb',1363358127,'14lzl8u5JX/OoaGtcKM9vbZScM+AEnsdYPIcwPYYh/AGwagkT2wfYHTg7w50IO5BIrwP2CvalBEZBSck087+q+ZMeP9Ketzc8VaPxaIzmxEIpYMngKvWDjNByjIV5sOjLUkCp9aPlKjeR0sarB4V7QGUMIRTG36l0dDzc+3EZVQp6sz7c3qA4EGZrZq2Iq+R5Q/GRgA/rh4MJhI4MPlIyHLIugRepTyTIHifgfwCzJa8zu/ZUkEuca0MroNBYqLIuvjIrpxTrElg2r2mUq0RPUsXjTa7qNmc2WZ+2Oyl7F2SO68p+S/HK+vd95XLfkT0gh0YB6vw9kQ='),('4248ccdb348d098e55fdc963a597b79f',1363358175,'DSynwHWCwivZosg9tmliWjqUxPQ+rQeSeqb7JhLNgCMDFOJZLRFH/4p/tk4HZ9a0Fr8Zj81wioJa4XXW2ucUTjHJFQXRRiP1vY5invJBKnhKzabHOuGxL7BgH7edOZeTBXDiV2yATbn18KBPn2gYPGbdIVSyWAD4wYxYFabZQnLz9bl/8nS3ruSIaiLQzJwidQcMLOIx3Dtm4j0wyRztdJqwrjUjMFEN381pB+fqyBgKVPiRFWZSNNiNpyr+v2Gkuka0J1AzgGSsZBL6loOdZF98M1V5fcEsIIQPxPhMR+tTUoH29jFinDVOCDxojVEZ1Qk80RgWb+eJy4rKCIWErVY9gOzj/3xIh7ykjUJwDF8yIWYUzsl2J7G3M0wMx4Y/mClu8wxuh3a/0Os0vbFhKo0vfHVsMm9alOKoCgO5LlXCgYXJ/dEbUjeREQ=='),('52383d50335257fc06ab4bd7f8ef5eb5',1363359559,'NBXShhnE2gu2zb0++ATiCYgvc5BlTDEA0kkup58DPEsm/FWTMguyotssSj6xS2WraudU60nP300RthmxWLItp2MlNSp2bytzOR847+LROyswXvgLbzyGEDY24S7J9ZuqnAp2DVYZ4QmO3FXhQXi9r9a0fezN+s+jAxUyQKXCBSaZtx7BFgpUSdWpTT522Nz057ZKX6e/Z4Th5zBPnhLh1DoEAxcWPiVrm1L45w3ydhjLTFIIR9tBfCdlk9j7a9YJgOZkltJCZ3ATRnXwTtCO5rEGvca8c6W4FucQAxVZt05x5/EXmaHEHmSmZHpSF80nLDuFAkKwCW9qOnHWlmrGXToLVIU='),('f947ce2312e2969edc64a8f884389003',1363361891,'CEEDvhsSRox6AP8g2ompbH1erXdhgycRCrdOgHm5hNcTmoPPWNcMu2l4nAGybU1RhmoB4MHqUIpAaaNHdhDcQM89nGfnQQGYANpnv3sYxZnqW/wNnGlkYZi2RqcLLaVqoqQGm7VpzYyx0vBp4hmqaLTC2uaL6FsHRB9/lBD7Ps4qCjEMgvAGKgVwDs0gzfOHKah4eFOL4nWKn8PmKqZ+9UflxB7M8yLnqNRNwhqFMIjG0fJlVD3b8I5c6s4CrQo+gmzY3tppROwiZZFX0Ve6d7yZ2MN/mq0cph6jxVksxcy+7OqTpW+WnjooZG67rDPk3K7tbxamQzMFYSLwvdU8LCibVRTf5Ab2JFxDEmDKiCIB+3m+qxEt26WFO/nhrO9s84CFb74y0o7LE/FYHsW54rQ/nuTf2ZWn2E3oXyxKsyDtn9thu4L3qHlkVo9UGk6hvLTK2uKvN74LwBXDb1an061DaaDslrRZ0WUB8DSKGREhBq8G3D6qHzIKh720CqjsmyOcRWOVixoey4rYcRbLW89TL0d5qoNFLSdyYp8LrXkAvyEk4PiKazz4EyfRoty0VDM6s0kjHF4yY/2dDQ=='),('c656e2af2e13d84aed596da37b57d2f5',1363361887,'gHzHmT4qqF8L8h/7TXBvsQz6+lzOh7ssSPhjj97OEVlHdR0/XReGyf0QbTFmnXWMJOF/Qo7LxEf8NIBWnLkIXykMCb8C34FCoEiul9OjWUaxEVqLwD7kJFeRt+S/axL9a6k1sx47Sx+/PvnhnxxnN/vCK50gLI28OPLvLLipMnGWikfp7StjlPFVK+3DalKuRT7nUBa4wx4bFD1HKfITVrC/Bu/h0/DBzaWCjuz5gG0QhZ5UXwz2gZvoRacRkDyo3+zshf1ai5iXLjjsx5LI/NHzhv0xDTijkMPrwIAGB54325fkouxzuylKNr/ogpMa6Df4kprxXuDYlb5skYLy5vewjvup+MM8Z+xnNHSZyyBlxgXU+vlblkTRhlD6u/bxQScIRO0oFesLMRhExdV5oWErlZfw4YXpPvlORHTH1f8zS4nchc7Eg4/Yn5UHoLvjOCNJ0QLA6exKyMnzjzhlzJwYmNtJkfyi17ksLWuu8LmtKBUXeDBmkjHs/5Y='),('c406a68e51cd259c1b150826064e32fe',1363358425,'+HMX9eVsuWU+ndGO/v/uJpbNe1d0N8G+2zxXZEolPbQiPoA03TIaQ5lmLBqJPoh4d8uTMxS28JxHA+L6bCY6bVVvCn9znQWaHDjM+Z6FXZNgUZexCk/+tCcske83FwMHXphsPV1ekQ83zLsjEiK7uVvSw2zxkJlGdgBqw23vg4g5g4SCivw4vTZNyL6xKsXltFLF5GkFVSWqtzUHZXH6rr9IpU+WKy9ADKkmJk2ZUIibtV/aCvTWlz/Ow285PcuQIOgIqgTaOWnmTW4XJMsM9JWjuPhCE3jXbsMXSPEz1Rar3qxYKMEWNZgBpS/VIMyeynYaS8nRM6dTU4f+XyxpjkjLSeV5yoXQRsGznHEQhOXcEjDAhqJpCW98fqYs/EkUzlAh+dBlRfYypEPCOO+JcS6TFSgwokoYnrW6UxHwVeDACcA3g3vjlVcF2yhHd2dTR4slmoQN6mbYysS+u9UrDgiBHPKNQq2uZInmGaADS6ZNzBfI4MEH45R/2A=='),('152fe24ec4d93faaa66fd884146d94d8',1363358638,'8/EBs44xxo70uELZXnuBkGL4oRAGO9g0d/d6tenDXOKufhqLrJZzb2RgHFnGeh0Qfm3xMbv02Tp8WbZetMiNO000UQjO84Hkna8CCXt814j0mYcvtL3KOpsK671MavwPw37YmQEv2SC4Xz8FzGGsPgqMkueLRk9nPUEgIA0TVFnSNkzusH9SaK4DXUrw7mVg8NzXaZmNkp84FrYtV5pLBTXp2bdioC2JzRcGYHCMSi5RcrrY7jon5ZQ0NLNn4M7VEm7F0mmFXebDbT6SveS3uP/r4pbkt7KkrrYcjoRmUJShFZEQhiOIml0KdSxjOX+6ZjK/WCq9BUI10VPkoKNmBnfxYmmHaQRpBjc2+LRx5XYJZewuTArePKmDCmn2bhj9ch1HR1FPlawfnVkHoqIWsXzEyTbbxyQqfc2DvuF/7DF5L3pCxB7U+AVObdJeLHUb6uSaUBKTrK3nKfMigzGNH0IKq0N2Bc7SJTquOVQXf2nrHX0pA6iBxoirLiofO9BF6KfMsS9Gkx1mNnTiQzPFGBcPyBOEwrMi'),('93dd04ebdabfb108bca3033e6edbfd28',1363358697,'XrlHiILwppYw4plCfX1CXXEYAV6O8JzEDYiegmYvmLsvXABuDyPChTVYwPmfpQZzCZQSq8Clny6zVp3JgctTgnUCf878f3mRI9k/DxtzWyXhhlN2XpeDoYnCzhA/zwQMMJ9WY6GfbLCHxsHYVJIWeLrHEeqioi5jnnoE85SeJlsBwtMxIHNg59M4yjcqWdtGrwtBwK4Mv703sXp2ganUZcD7r8X4pXAye8zWBtEWF1Zulj/3RRMcI9/rv9rb4KjT4PTBKYJKC3d+W5jU3AVlBpjjllPPLuxReCFBdSxJTD2anv0HNoiumOr5O+DqNTKOXwRwwGLTMtccVvrvU0Y/1T0M7ITCH6Kux9gK4wyCU7xKPG5m7mX+/82oKRniGadYBubZzhaghgIu9f4PsyhM5N5wXkRP7HLdgTGiSaeujRPHKUShXEVp+ipV1rjs5svpMnfsWy4KeGEv14AOp7gTIDAR3l1awbusU8iAN2QgHd8+nW6bpuqTOwotGm/nDccBJ5VBtll7LnY='),('e095c507f29f9fee13b5e96d5c95cc0e',1363358871,'Y9L1N6PTzknncLGDXq/bnnwZB1X+9M+qz2qD/4VBBWC+9vjN20sB0SKUSZXGnQIK74v7qZ7zyVTGVocQPDCkKTd2dloBypjG96AU7sF/bvO7s9XtK8NbszPN/Z8AYL19qxZU5zNOhWEWvRMGBr1hjNfCXmuwsHNS0RdBe5tpNDgj3SAy1lxjnQ3mxqF9OdzPnTnKz+s73Gfr5NjM4gfZm308gOkfGCOoDg6sXsm9MkKAbXdYGlXTzl0PGvEYoi3f8Q2RTCo1+Aidj/IkvcyUDvLKr9IH9ycu3UINcIu+7pKcDyxhLmXU1VhN2odunu+NHCKdbRuglK26/HysXnGlTV/aVgqpJluhnsfKVHSboyQQJTfsWgUyVEEafmfL49tojdIPTEeISzHeXX4IVJqYmZqTvxfv1J67Xe56/N6KILYBXcgg+YaR8m4xP8+7SweHYlRphE1xbouD8DER8MeUnv0tN78Nf19Y+OVJDJFM61ceeandmujzC7FnIbVQbSBjScM77OJd/jHSCpsq'),('997d3ca7989894b4732e269422bd92d2',1363365113,'vePP0lAXjx2wlRhLAQNc262D2q77q+DoRzklCYmKeKOSUMHlTGOtF7FEn0NDUrdYwACT9swRC5y5txor/bPj/xnPiqKusqq3BrGSdV1XptgyzRD6LFDof6vML+9Hs5ALQfD9DGJb/45w81+rdsDrNsPHEPOfG89N/kaQLqP4m6944IcqblfBvpvNYWRwQz2PvmtmwxtaxUbML2g688/My4Cqfl/fDcXk9o4iCxe8WwqcDSR2N+b9em9CCNiMyCNsmajPk4OtrAwnMvBW75bms0aHqYdBXBSyAawdoC194G5IWtr60hdXZsge3KRC2FguBZfuSFHCc5NrKHtnbYO/Z1B3DwfMC9bqdNoBSvDa0E5I6cMV18obElifxgOawS1a4XHb1YdaD97JPnFg4oT+KBxmsxUSETthKwt6sKJog3l/WnLKyz0MFCBX/dspQtylXHB6wKXADeCw3Owo/mVDjg5l1qPBjmxdB9PcX7isrbSyP4cAFaI9pmEOhPv255rDB4j5SPgjkB5AIxQ4kA=='),('4de0837e2e206ee94e65ef9a69444650',1363363341,'LwKeY8uMzJ+68q8qKb0rGshr+W4vvuIHnZpy/7HO7HDY8tug77ClD66MnZ0lBIzZ5P3bTf1FT+B1ZMWMPqnVmOudYELr3OMuVCgIxy0HLjRX8eA5XZl8TQCXqGgCBdip883zLC/zn3TrWFQiAJqLEmeGHEhq7sPNOM6YZgurcwC2nqJRXExSosha4Dirdtaq60g04EnwMXVBuSNh6TTwUIs9p4QdDKSHr7HcgUudWP1P4Hff02EOOqnN6rl3Gf4sMGU5O2HkddmFyC2LKW1MeAqoVcc9sIiOU49+NAvRgoigUk4Cj63pZUXDizkf1ioWznXq9sxWIGOl+VriArT517m95SdXHgq7IC+DOVkLv9RBiOifYi+LfROfFHoba1YcK9vM4DkpsI0v+ET/ypHquUK4L5jlY7j/rNHSv4bmR84bNyKbDgpL4ifejpLC5VMUNH90NrOO8LFWI63+DstUaYfTaMbV14bqBsTqJCoT+wYPbbV/fBhj+kaExep8stqLpKA23BJk75V1YxtD4hZrPljAKlNr8Pvt+BqKm2y9+iq0kV1Tyhet8oGBoKOaYsuM+2U='),('6ecc918c0d46c477d5a9ff1846228895',1363357443,'6/Xznv5ebtG4LD9gED262EkGJrybscSBIf46s/eW/9eiiZRA2Q91W+0EoUTsywrvpIgLLqwSh/9ypSn1LABqQNFJRM6ra8dnR6knpzSpIud4ryg674v4G5qwvKr4+SbFXP/q7LTOSdsfRF/UnDcgxr2mP8OYPSmSL40kImtE5rub6OyMUnw7373/TPA4D7w6BD2ccCzWuW+V2gNKqn9Hb42PTsuxNRjRE2FietrB5wV4B2io0hO5CGW7tcLa/xuMddtk8C4boM07k0aRt5YA0nk1pkiQsQcRzbtGFaTEUGczx3GohJbVRlIzvW8l9nMZ3kWLYY9dMSdcG/Wq6c50c3YIvyxY25Eh50zQdTHZeiOaiaSF9Rq74vi7/uxRiucuXyHxcVC5Vfd8XlrOLhpf/FVDuQGPV0Q7BGPwsfhW6/+7zMxFYtcMf2f6F4ufw4UfTKZZu3up/jSVTmHrKtWlnf/ldoM00wqQmwVje2ixt+nt'),('659575d372d6c20bfebb26b95b28d5d7',1363357381,'6UaxFZBDTMiWNtVzXNQ8iMkIjgzEOQc54ezM/slCj0t7qxBkkPN/nyEogDFAXZkZVQpbiroZk3IzLCF8SXjnp4u1oabDBsdGn17kWS1721pFLlF3tZK2ziHAr7wbHqzGl7S8LQHiJBbI1cJOXiTzrpEHOrswSglOb3GTejvu3AiAR1BkM8WfnG3UpDcByOtlNIr9QSfPP6U5VTMy4wKF/VKOVI7yGX/HLkZwC4IUr2dSCyNttX/c7mmcNwGArl2qPcs4ttZhEx+uVPmxhv+//D4To46LjA0Mi/orv4EN6Kd8m2+Yq6d96ZrrKVmPvDXYgcyx06yBfcpQxAX+B00vR0NbfdJCd7FJkTfySaPsZ+KZU9r/p7d+x04VtTTsEokxLk9m8R+QGn/lGq/PP9yMkHL+bP5mEDfdd2jgQW2agrQ/7+K0I4OgriQtUXUHJRk4KKTpYo3lxd1FyVMAExPmDZxcQjlGSIYACgcuVQTNcaV/F05rEc3RhTg6DsXXrEuqzF/2IcWQpH0BgV0Q+4xLEcU5YfVPQypbtNFhkwVb+ZfFbJF9zj5zug/DdmZunTASQ6phv1Ct'),('c0515981fc3186ab56723d8f787c9534',1363364108,'+rta+ueEVCObuQ4DWSyszf0j1wVqmchsxaB2IssEkI6s9vGQdG/E2cH+SrgyPVnIhfx4gDqJYwERvN050kj0bhSeAd8jEgQQtbVXb++xfq1CMKeeCIPq9rhnJmXyofpj3/bdYvnPIGPQ1t8hyeHJnMbVQ0i5DEFfECOOl/gGEZNk4thAi1PEWu4MEcZdTkWmKM7RNnsk3p3nc73tiNuKt+owaHzw8JcLQ315tYlt9Nqj+99dHW39+HOhe79zfXns1Ji+9m7RtCQblodW1rUoc1NMjeGuYMjbGjfXVy2XXHQVIBJC/ySAwCpPudV9TqPk9p7XCDdQbAq5GmLHwB+sfN8Uv5qJtgTY8e3uwNLnuQZUTIBuFQKNDFPxmT+MMG98JiUJDJw2T8lIihjipH/1lq8Bm9bhyGNOStjssPOGE3LgtCh3fhFKZa9kfL9q'),('a2df3a765b4cb3862716eced64435189',1363363791,'musqts6WU2VdUNuOwFCU8Fg/ObR/nC/TXdnRyQMvS9dJ1F87WHInnUFeX9qjFcRNlHngqsIL2H27+j5CVd8tRNrPyTIaYdnsI52KKT7iKdvmX6UhYtrJPYtH1sSLHNk6nz6w8ZDEbEVGwFcOm58IYbk1PReHDfhi6DisO9xPRnpEqpByFPpG5+K9Nj0tvAM7lO95Kvf3hjLEVf8tqLl1dnYrWYDGE0WXMfqgIYpQx8Wkkp+09OmAIEEtjhRUKMfCwJMoN1pUKxQgumvTVso8LE7GC+tORn9EoSSBjmhcS+iXbsFh7YOEs51A8FO+5oDKqe/e4BaPUR0NzdaOFhEJvvgnU6v5VfHEV7ZrYIKh8YPmWszc+C9K9TiZS5+GonGaAnYGLAkzastv+AFN7Wz8ZvdsC2n65idDxeH50499OT1wuKRokBeub0SYqYcDSg=='),('739a18cdd4167aa045725f5c60793998',1363363645,'WYYqNOCdoEGoz+NYnrXQzgT3BQvMDoMI2GUMSbeBmSEWK5BcUUyVFDwq0haHM45ng1jiS1S5qR4zuqxpZnJQa0XD2b91YqIy1m1QIDIWsv/ZivSASQsxNWiJFYiFL2THJSGGcCBvOZGUkw4JOg9rYvHtYXadJq7J+t/dSPUSRdvTkqLKyQyvsVrbXk0EGvdsLl7XjRPmqEKFXkbgRzVpgqG5sU5rYSfRGRTjX/L0KdWGZRsRmQKoev4STmlG2B4K+/ya/sUWrOyzAgrtmzY4oBphRutdoiYLtADI5D9ZUkmRVd9hijfB3W1SekpNbPWzjNCbFFxZtSxqJp3yXnJhlvLb5rlIS8wg8KNiLoitN8RgK3cS6g8NUDrhlUaeRDc14rQtabSbIT6Jha5C4ejY8t97cZeHlovRob6LokRReGFymLHJ3C8Z0Q=='),('de57bf10aaa4cdacac9aeba49b88684e',1363360571,'xPs4evMyvp73549AdgoyC6SPx7hYQzjIaovxXd9t6a4pOfv35RH+N82mj73hKff6CjuVfqMYbClb+1eoYIG1ZcKnesl2PoYnP955j64QpVun6FKJea9Qm1oJASh+1I22dprzdpB3IlHTBCDgIPJMRL45aWgKVGyGHWX0a3badKMiskc918op/QNd/zoSbBHsXoIoOReECZARTnyIieLaP19UqW+m1fplQRZwNNv8XQsHIIFmK6U/1x2lOUxRYMvVTZVHhWmu6d1IF8xMx2Cb7kt5RnOvyYodI3IRqPRGBrT/FITp/CcNpnKV3W38Un+lLDMYMKFioTFDVS4ou5mSY6Fsdk764IcivRLZ9JRsaIz5ohBO62mj9aW8/UATYqHvtkA5cfNdxYYLFL89GwU3UeDX9YhbTfqZklZNW8/cAepekFAO/+18AqNvvSzXTtAt856SHS4IkQLSX4sj2tputWdUVyXwPki7a5gXj+7sGg760InQBzbUz8WGghsNq0R6JFXupid6YrIXoA=='),('1ca439dfaa3c4b38568688fa87b6123d',1363363696,'vREV7xiIpjD9XH8PvCuvnwT87fBOy4MByQNBm8cjZQ2v9YTFjzeg7A8UW1P2NYZtq8O3JSqoasd/03y5GODapP40pKxkMrhCJpkRjPinu7rhML8ESsVqlzXSb/6nMlCrc6FFApuEHo1pfxTKGPEDSy5RmFApIAgT7ibsz0PPK+mD2Gz+2mxl2B7U6OZywQDZ1WGTqHUfIDN7bIBGao9zxl8CriHrolXdQQ+7RPS0ay9vUfmJ+23f9OXNVFeCfSbsqfifq6vjjJcvtPfZYEHhggD7PEmIsWf/nf8tIvT0H4JEYK/42mDUBFGxsmz2UBhRV7feKA4Z8oOZz+JulKimAOjKigBDOpxJfVmfz3scIxGa3nzU+jyfHmt8DOyyWambeN/HJ8qeE8RIa5iBQ2nB/O/2f65R8VvGEsHqcQ/ENvbR0Oy0I5FsyRT8KHYv5QOU6/HpAZWvRAeprPyfkBbrBiYXF4OcrA9Sh5ZCZxGzpFk2NR2zRPZto1BdbRZPDUkM78ihb06bHfVadLsn9sOGxGnfFyGyNw=='),('3eff83c67a8bee55675e0642941c4758',1363363729,'DFwUO7MlxGVGqfKqEOfX9oostg2nttYJwli5sQTd28DP+3BksPcMuxeOJpK3v5WRySopqEar1vdbS7HMyEch+avAEsAIG0zBwI/NBEQMk3fbw8NjyudeQ0kPPUOz+f6PnewTDbWaGwGGZ6jCNDO73S1nfBNmm9B24LlKcpTLNcwKvr+AGUDdpB+Q8ZSHv97Gd1b6UoFdENalUG++xtE5cJOFfqi/LbZY2em9q0yCpyNDCWPu51Emj9w3P5Meow15xdIPyRk1pgqQVBMfwoiFRPSYb37SxZTcCmlYOIEMgzcPLB/Egp2lIjeyFJI+8kit258hcJDi3GtzlECrnla+g+nQ90dtU/x0HikiJR4awCj+cJQpD1+mkuWbIMT3xT3pb0XNeX2mn7UTxB6JVwxse5WwE8dJn4bB8j12IeuDJnpioUDsJDWT4IqbvIRoH316sMXXofS5D5/bodFJ1iTSjRgRtCUP9omGJlVvx/kJ7sy5UA=='),('2ddd370a806ec23ec6b75d212eaaccbb',1363356944,'6CXZ1AojIoRk2jGkCdTqwBDERlf/3J7lXcEwZa+Io3ndmiq1Bjm9a8/qqO83J7zZ8GGBNg9D+vxo8fCzsHt9Ri8kFkTD3BLFwmQ5IJez29UvgXV9d4kQy0Li1nXQqEnw/bp8e1edG5tlIVuC36UJAla1slOPMGaTfaY0ys+TdSwNLEMxHue2WyHwpKf42ru+38RffjMR0vIGxYAeM6XkfL9IUjJQriY/Ifc0pKGnCLO6HbxskF7QXYiH3DZ72/q+9fQoRNuwtv+lObqDd6s09mKhuDp5mpyA1+XKXoG1zSai4guFtY+Y6CkWIhxhZVpgITiHbiwd3XltHpr0XXihkX7NA5Z5DUMe9r9Z6Ib+ofELy7AgKk8vX8rJ/y6ZzZGvx81qgstYsa4g3uohh9A9Pg1Rc/ehl/OJvVHI8Y5nuizwYIxSi++oailxGVNoSakLlPyp3yn6XREuXFm460FVM67WYX/Wr2zIwzSOGyRhytfuGQhQu8uCNPxdsq84A2CoTtd+i4FnGR0='),('489c4c7f1276306c65a99bda82a6cbda',1363362446,'JZEXY7yPK8XuraKOaGH6RWLkWSZY5JXHRrMTz9uXi0jRWgh+BB6Tjx/AhW+ZozuA3ya1BtGWvNSgKO6D+gOFNfykrliTysl5vbx+M++YnQ1r2mpb2XWT7WpmwG0lZy+USCgeDc4WkUukTcNhnCfWjfZR00deH9BexxBDrSnGwItEfzvqakdMXyA9sqfvtdkfBKqqaSCcOo+fxM+GwT4sfOYqhp+83J1btU5YDchwfWXqzwYJVgstEoQgKE/AQOpJVhOImCJf3YKPr/gOaRWug3SDXE/F/e6AOGbt8pBUcYM9qFdi6Xdwl6jq6wei7z04rF9gxpdCPfuQ1HG6Zm8PDmCIlCDPl9voy9ktGgNGzxvN4PEPmSl3SDp55hqFY8peUaan8ZWroWOP+bc7CWTuFnNg+HzGhlR2u71a2GRZH6lazY+9/SmUSBPNKZ3xtWWKASao7UQGKzSILHwQrJzoIJ/ZF4XP9+IaNTRffCJMEZTR'),('9c3a3422d472713465b9fbee8133982d',1363364221,'fLourZtcz9OKsd/4/2AJ1MA5E9lKKzxJsdRzXJMGBwOlnzzbLoKTjYdcOieeGEjH1C345GLPN5UdNImEBLSTUc+psv1kiZpM/SJpSpCNZ1nDiJOzOVGK28Bkn45AfZBvTgoSXv4eaoBtPrC6985cWY4AiQFzW5gXNiD0Vi9TLxarKhkd1PvqOjbFHKqlWTGuH7JuyaYmasoUvZaUFZZknQM9cqcxTA2JPhm/+3jNhUrICMLHShAgLK7sbuw9i1OiiMYSZZQpgL7tFsx2H6W5WlsXG6sXEHIEDKgiHK6BQhAX7C2SRBpkR7GhVCLFUCCLXiGWvgCcHRt/LOCH4QsGNYFLTYzWtWxeBBcnnqzosOMFVsmgryVWf6MI2lGD1Pu+bbPXZAEBoDPknOVQQ9/2gdn6vRBdfMp8SxQoKkSPrBvSWKYeczsCOcRCO0Bkf09m7H9aEblg3k7xp6h9mr/xxJDqUyq1G61YHUptphu44FVDFHJdH7hlPMy0FPZquw=='),('ea8c0d3fa3fe303c49b82f0e873108a2',1363356921,'M7pCIp+BsdFj2sHNuaH5rvQqjZpZH+EXldeyCw7clJwsDFLA2M2OUkLbAYW1LaWtUJcpYZHbb6tz+kwWu/5Vm+WoKe+ZAfJ1zRwQSAGuqcVUYM+FwI9nfvQgLLZVzQ0apzUCyh/EYxI+iywAXLPve9W6EJ1fyEcECpyJ8yvtdqdHo7o9kNqyp8hMDLjVyLZmabVPElxQnnFIXPUk+3Wm50KvfDMijiPvpRT+m2h0681S6QCmdeSgzAr1mleu8EhW3iMC8iLSyIQF6kxmdUPTRNmHuNjMW7Fgsw6Dx5ioZYB4XWWnyaxX6vog48VS5b8vJTLZb/qfJr5ihX96Bu3UuByug4hlDjw3tmFc+/IAqx8JjY08QUiPQve2i1Xag75gmbdG3bazrTbEwzezf5gKoP3ug2Bmm7PEXT8pEF9Vn5+HTgNnfsda3fZK3H3R6F31MNB6nCPS1oFGlu/MTp1Dcyw6PGFJwO0CqFKZ7A8uVzBN15Y5VXiWS9cAirj/'),('3f5e5a961ef19b6b1e5833da87df3a84',1363356938,'1dI7Hf0vlOSuOcKEX8fqg6qx3U29wpIyPd9YJodhqgTqVguId5YtGsQSTJ02zUUfmQ7iAq6AU1qK3NmCCM0fivFTig2lttQhI/GUvQRTvEnm22CElETzTcFMVVyv3AuZXYBprSoeHQ8OS7cxJ7t7PlHo9N2Juh0F3P2A9SMxoQP6G0PwwcaeJj/ivGJ2x2ncLkrBxCcwdpk4BqgRuiAsBvZMLBRRvsKT2Twi2HvDKwVP/6szXYSuyopuNuQS1mS5oaie5n0jgtI6hBdxAtMRtuaHhMUwfPveafWjEypTgbX3/AD/h4eYUECsE4IzEg8pspHJnolOhBoLTBzh+Evf8U/6Od1gWKyQ1n8V21BpYWrlqCF4GuejzxCupvewXV3s4qkQZdnm0gV3vpbAAeJ6uYfZNnmpSSfWamX83kaVUVEyhtq/fyCAOHGHbjqe+sDsGhx9pjSj'),('63be77e321a00d6d103bfac5f6178feb',1363356984,'YIqpwtrzFw3ZCLJCQ87aGje/a+EorTwa2qj4AUihd1I3SnRXOKGXvTCKCQ1xbjk53SuLURZ9/DSF/+sU8y/9igO9SpDsbGP6KiSRHfbWq7p+PtHGZOTb04gLY3TQZYHWg10IYQx3MkdRntkEnSmTZsvC5yWD4kBeXh83a9A4hzAfEdc6BGqSq48SAKD6gYBKMOMSV4fy3x7dY7CvrUInxa8ZVnsK/Q8NKhrqf6ARXaJhb7zQR6dSbO6rJ72TZ5WgW9sUlGgOL9KbHtHQvj2GFGbYc9LVldSclc50ddARnzj/5R+C6G59aweactNEZj6e+6dGvOucpPUXD/LyOh4Nc+VfHDacokwa/zQX//sEpbQ2sIDN3LQhLDylaD3m8DH44SD04ZhYM9hALAZqegoEhjnoPr1emCp102hu5s7IbAq1h66chU6i156Aqw9YemFRt7f096YeFpUZ7c6hTzAoZpF7ZMSTXshvqMw2/HAjPlII3HSoUSX9+A0W+WXTh8M0xrJm7HaBJaEohLGmIQ=='),('d7c25a3d6c406e4388f8ce0a0ffaad32',1363363585,'NlCoFLe2vE9tXkGdic9A6L6iOHlVdPm1qMo0OxXF3Ka02vzaeWfQWC4+vVuwNkuA9xZkYweKTbQ/JB3cBE0JRtPN8VmMXrZWya0sLicjvb9hjsqzq/gbRxPyfBTb9Hrd2po/IksT3j709mKeizzmZqI4iG1GsybGSFA36rx88gPFx56rETo7AJHYJ9J9XnNg5kIhaHJ4Bex3A/iGCZ5KShH42mxAPuCmBSFAN4bcCG4rUcYTdBaWUWp9cNcAJkKFsn0k1puVZqfyicuBUvbjUCgQMBJ4pl6T8H3J2mZ4dxPBQhfks2W95E1565OJL0CE/TGC6Mg1CEiKERFHV5LqhzNXc2+SxTsjsV7cPQ0UW3mWx4taj34ciVsctk0fB6YgGQG+uQmz9viDewA9fJq8WM+iiyXkj478f7oy6cvjwXNWN7hdrIhp53thdqsGZ+liOiF2+6ZuEOPf03scZrLAE+CXFloX7xTM87khVFZGJ5MnzTCQFw5bo13otqJ1erV8Ql7YqhF32Pe1aa3t2xkgPWz3MF5ubbmJJ5i1iHiODqF6gGPtL+C3B7tR95V/OvWvGysf76yQOLL0o4a1aaprULv7ns9MAXqXoCPirju5ho7DqozZ5XwsjJ4EZDn3durAhqRqDCRNsctSarEbvisaVndgoDiu/vcFjwxTKVXRYG0yxm2zjW5FEZ3MliAp4c6TgedgPwSXX8xyWKSU+tu/+X6Ptvu3s5tcmpQfyLW2G1lNjeZS2wTKKeg+fmLUPXf4UOuOB08h7ozk4H0yeaPf1wK7Dxve84AANkNpRoFu8zg1Jf+tAa3dKwUEWlEK6GTdUq72EXWzfNwnME4CBVEzCPEulS/hn/hPJ2jWsSv9KO3FTO8ngZda1wwtt3FG7f8yC4pI6hqns05oUYxk3D7ll35rJJ4au8e998zN6ZQgVO7CBnTMec9SbqSod30JrpUu2GL2yVn8yks9TqykE57ZOF5fiND7KqP4UGT4HHkt3Nhc44zA9evy9gMePmQB7XzO8h+WAmHBlBG//fhpJnpByQ2pkpydm4Q/RMGdyggrFKe+AvpVuyK2A9a7nS9QBGTmQE5Rj6nMd/RBwfYIAGd8y4SB+EQzta5VVpDPzp85bZP+2xiVSI8MIPO23e1h8vl+GSq3z6H2rfuHZrtggWvisPXHXVdgRgCEozMoDI36jFqfIuvOnTAy3isC+tM7YNQ1m8hKDjPyRBbycpUbUAlme99oJNhXIWWWcllIDTztjU675Ri62xA6qYjRwjqhbGVAH9GF+qW/tmpYBTlyfin6lDJxtSpwjSIxKuocvBIVMHFcX0D4L6xv9lKv0mqr2K31kvXtIvs9+E70Zk4='),('ac9a7d08c36968f2b31c33c318673dca',1363356900,'rLrj954U8QiPBoNKTCQMjNxqyg63BxYnnim+XSqDpFJB2Z0jIkQBqogc3N8kGkJ/EHoadV4Voqx6bnYAeHLfx4HP34Eu6xRX33yZCVSf8cn251Nge1h9N8kWs7uVmofm7vqEma9BEb4cS72fSi7rVjp0upH5Re8vfxBlRE/YOtCOOl551HR58bDRFPmWXNzKTfcePtfAnsdUt8Gzx3h7sMZ1A3ZS3QYZSjTxzbrMHMtw/AhyCzdBgnA6g0wmH0do0S7g3dMd4xYQu0gjXscS7jcBxQf++Vm59r2RMZz0QkcVd60ygZcDGjcxaT1JZqvirbyq295qUrrZZWgRin2KqQuiR4WR6AdPcG8aY/Hso8ya7cuxLGAIFTbRwlAzgX+CYFets/NIYnKnGHuvLwAOgF6Ba/Q8L0UGNVA3+1N9WofFQuEK37bfE/J8rP+q4kMpL9jPUTvOltRvTb5Gtujw4aEfHXj3SHTs6h8ET4/wFq5Q'),('40fe150608181d15d5434ea569e1f38b',1363359953,'mtdtz4iVHjvZWEsjo4sUH6e9JK8c0D6ZUDzu7g60pB42JArq3OA0uOvMiXovwcEZd6q3u608fGtyod5mRqZGKtZd1K8YAE1y8cobrXFt/ZkpJsUmFDyMIg8XuXpT7mPwBWn5pcZ9JhZwQQ8zMCxDfM8JfkUtsHi7PYT1zhz4cL1P2G3OHEsntvdAAPppjlXB1OeowEwCZbYSDJS8WJHBTJl9t+hisAc/uD2qaUmYT9yrtUIklLWfTc26X18c/aVftdGi5IBP0OmIV5q1IvKc9wGZ2CrjYsly5MtZWshOjRCXgZdWoZzmD4kXy9PLQXIGGjqPWqdBbC8RMl7nIgVdajRKFmLCl0qkKQ8pY4nQ0jy9QNehLnR0VS6ZPM8/opoel20+YHmI/u0etXh7aMubrbRlT1KWcyAxujshYdhrR+2jFMOcGxaSatWOOE6OTmd0AB2sNtbO/8tMo2LQ6VaqU1jOwqFMM2TnwwONR8qvCHvEb+Ql'),('a8d32c9f96196e4e4b9279aa04352096',1363357315,'74e7mo7jbA3IYuqQt7kj/taEwN0uvSKubad9kEDhWVYerDMMhU76/euBs4xUD3oq3Nv5Bcs6gjlrSnuQnNezOjjuh6guoLkl9VeTu7qarVsjNKz8QQtx3tiHsfwyg02In/YbkjAbDWkIBdNpPvRqBCd31NiPm1/AnjtmItAMnBvCYcUjY/66Af+mGEUrNkpBL40M5ldwcmhb4ew0PSYyQbwaVonhIK7Fm/Kpg9X6ytEJ1SnVA5Z92H0bbKLCLR29ykdn0zaHgHlZ+7GvmVazrtEjRLNyGJI8YgK+2FDo4DwzL+6Xsfpvp3CA7dScBLJxf0L6e4S9u1+iCsRa9YIJmAucXBuMjN91Yrkf7cOiALWY7seinXhiP5TS5kvc4zXqA5oQvbWjWzeWOyogzByWABx+A1j7FNg6HOGAmY0ffU0HVlzwEZqD8XPdRqe1R7LR2uc5xzT7fPZszEE+6E+0R+mjDf412xcszNxDDNWBYRtT0R1rddIt21X3fOwF0jp3bMfLObFmjHmiuUPF0Vk6s9Sjlk+r9GFuxAB4UqIPSPBt96AFLzwmJXJX3tb61PjUJpP4sNSWZSkDMT360+V7ug=='),('35ab279f68fb5a9a57ed0881d2586cf2',1363359556,'B4AX+RRoZfSM15WGLarL1YQ1vtqD7D8MiEzXhPrAAV1rqyY+K+o3mQLbRLRTXtzykxOIYzpsAksm64BHP2aoVfXTpiIHe4Y3+NUCE/RAfpMNxIDmRqbg+kKXzElvoUl8Bf2sOU/1u5tnGxc2Lw8+4rA4vBsbJOXbikJfVH8Z2MeTL1LyYrFaGTRGuLKi/f/bN891Tn7orRBkFjX+PpGs2VfxbP+K632i6Otbb8YVS9ugKyYFycNJJD/xEQZnTQbcqvrfLCLCv55bG9wzqZ7zOMRQe2HSaPz+lWhnGqR4Owjf88QtVVwcMg30UYOufCH1oODeVRMRIfqHYBE4nmED/rdikpcUXdQqTp3TP9oTEZXOIRv/8XHqF82SzVJyz61nlJ+Qt//DWlcgxUHkDeupuqp2OILOBWRMe2V4xg6qhFYQrY10MdGFA4dlhiwecPiFm5CT9DylDGBOPfxLXakUYUxZioYS6eFZPTPWXua6E2X71hkYUi+37/Wb/sL2wBVH96UGkN1befxabi7Y/Q0='),('7fa754f29b5af0f05c485bbdb578cef9',1363359459,'bU4f8f66wBZdgjIAv1M4BCM45sQAPpGSNx6grboWzSFfFDSLvHfckUeeJ0qR1T0o1mz4GWQE71/udctjYF1FRHHQysqhyw30sg8hFRfrzg4HMukfq4ln9l/OYyx4CHtf5rifVky2PLYSzpKOENbrTRvUB02r4/O1u7mK/8XifG/NP8qRAWFcvHByo2vTXSgYWTs7fEoGGt9FOhOjOMlTir6Rm3LKZqID3dAFAkPvnCcmOxwmnwdzQexm1kHv9lM6aF8XqSp4vg1B9FjHV35FRBKWsAPsoCSEgwUTaWfsfqh7kYW5y4MlEW9X2mk/HuAVWlBxMmRgBkQkeYTxxfW7ZPedJj44RAyXbuXcfYaWOPiZAgxa15Z5rv7oHBgAHeSo2XcamdGRwcW7pzT8TyR/cPS29BBKQTBsycSf5CUnmobxag7CQD4='),('176b2def399b9101d447681a36a1ddc6',1363359505,'+4z0R6P/7onYmCjiruQzU1kWHSK8CnEjQ42QmSwQP770Ny6pj0EpQgbn3vpbSTkdy0+AaaOOM/EZzB37q8lecmvMjuNdAkOw+h7bekhzmJeTyxa6sMraldyYCgscv8hQjN/w0e5TSU6QQCFHjS9Kq0xUqlujRRiK0w0UEa+8mfAJwx4q/uDPxn7y9jolmHGSBiOEY6lcwwANHNGf+a9dmsFgxiMrVe3yiT5j1VDEHgZM3ETzSIP09v+2W3+1NXKtHtF7jGdJMEg7AKbGBRZrdashE5JJViabhmcX3Cvc0zgV7JEmBqg3XHshWrpgMjYaLEsxpYsFpHql6J2OKQY361TR+rh5E7NSOW4xDniwEHbAreEpmAU6S0c0ZTMdDY+atVg9giuJ8Q+WDYp3suNdhmfHdow6kSInSuVa769ZiYrWI+xd6PfXhimGNNEzm2b4yl8VAs7abOD0e0/5yf+gD37kba+hu5kKiJ+4iN9g0rTWfeK5zYuPWptfGtUoMaCI3yDmu29v3zg='),('c0cb87204d7d5918234508e51410a836',1363359426,'2O3/Iy4QrSs19txzerbJbP9SMTE7RYD9nOL51COhZthNXi23XgBnnqksJXBvQlXclLiGXvEfxvnlWN9g9AYj4nk7VC2Kc0w5G8TkMdWiwqP9r49VhLTxY4BxxLC0aBtiZwWuNljIVZprLxezurT8zaQrKmg0c0EoR5R1QenccgvUtXYNPfjEejpmXXHtNS0Je3o7fqiDqqF0xn6xsFkOIxYGWo11Qf+YFVKlh/tGF608AyEHQ/bb5/vJv0lf9bZVe/3GkPI/gUSyZ/A9AseGeq9ewZLpkE9sXC96dIzboEWBAn3WMzLbNwiYi4/YzYHocAZP2SxG/9IssaTj0/DJmFFzddN/AtQOuoJoZmtzYQmrRU3RiR9u24VB/4u751iGZvQHq0DcsoshggXcZzN4C7/gO2FkOs0p2AdHjpOsHGDhPHEEzzV52K/PbFEe+vBPA1HN8r3eQ2xXLw4hlpvHfh0nn1b2/YcACAffFiQrIFzcVqHTMYyVZg6OiUk5HJBtlg7EbjrbDUvIJjZUkeFGKBxZIupcIwJYGHNnv7mSaqrRFuF20RXQ50TmZ7jyCv09EYvgcS/LufWOI1s='),('c08b27006c4fcdad45291345a01169c6',1363359235,'0xYWDg2+DryHylBi4sTcpJIWCGZh9Q6WEqp5WCia+X0IvlXJFgTyNeF99J8KPzZD//T6kbmJtaI04UU97MiBLORnMZJa4t8OcgAKH5Cd8iA1ELfKZjseK19tcA/msF01B8eckcdXWCwxGTwIjaOL/AcLs5+x88gf4VuJQNsQD6sNSxTWroqoVhiVn9cyx9UpmqAyAFw07iVxKwS3p5KyZ4L7oTfiVUSUsoqQtwIdyt+qw5skZBD/eXesUaypv6YOXIqMvkq1T7xoDXn4vV122te7BszuSVw9hM1+dMNWwV1l/CkOEK7o1+czIQOu9fXuyLm26cPVOFiHgRfg5Xt2inElUdVFZDE6lLkiRX9bXxV/T6aBr3IKPsV/ZRk7mBiR9+lihqdWbP+dUBWFOfWYUYjXWwXW73OWuGME2xTL0T0WjolyKS827BQ7qNmOMJgjVoa3MJCLxeYB9ubF9iilZy1cg0mk/2H63U1rZwyvgD7ju8U='),('ad5da9ab984cab863f36bf030e580acd',1363362251,'QXe0p5WidT1zvT7Sr5G3P0DUz3/GRTDe1d2ykzwCWETQBsr6iLogyjJvhExeconV3AqlsoJ5mf15WtQ/AVU3pFLohMWHLORSvKTfl7kw3ensa0ioH1KqlI46gTVoSwGfvGNuX6XoQ0yAvYxE1CeDJyYDqv3Qj75vKGBhkXCgznYxESSwlnuxOSjU4ppjPU79CPFcCOpCgyZDL1QeOmed8P9AOo4n/YIVK3I1JR4hUfQlpyvPrMLGCAh9SAeT3c03i2NriJpboMOqXbO68E00yBASb9+z7q4ViO+1vdoAPYK66nFGKqBbQZTsfp3RRY2OrDu8ZKux1dRn9vzUdm52CjUGOhWyiwcrp0704+rS7ZvaAjBr7l4MBrcOR8A29pQxfuImLnqfn+LXxuNsml/1zX2U/oeHrSMxxBwfARiypQn4Yv91nDHz8p+rf+Rg+Ql2Lk0icmoIXPD8LEX4H+BfaiBGPDF5WWioe73uoNNVZkBlRoCsbc0w4PkGbjjoHLU7'),('6d1b1004635f2d20db018a8272ae95c0',1363361465,'pvlBwguhoG4e6UkR04H4qwJEFLt4p3q92e/YyqGA30eLvbNDlHamaYD3HQwrl1EwJ9mv9FlEn4yRtEYs4Bv2Aiw4U5F69kdYEy7j9gwLQa9WZAqlPM38KggRHYZAyykUTtWoEbPPQlipr7CAfaIHPqI8JVEbtCLlz2fHjt0+oX5i2rwx4UhV1g27YatZkC5iQYwDvqokTJmW0IFo3XFgzDudW4DDI4eKRNIwA/7vrIZE09JbLeqt9N2LXNEIf2bqgiVc2XLKdEuKAu23SoaLgpMW5/DwL4/pXGOmaykDajSIsZVMdt8X28wZdhYb8gQjM/LIPKogrT29p5O7110p0F+57xUDwpulnuzaakw3Qsx1wqDBQPMDhx8xBsJqjVudF0Pvylbr0ydS9owiyTRsdXPsObaaMt/sT9WKt63USNCHNssmAGBGhtfoRxSmSdZIFC1zo5pidoB7rseWEOHXqgnlr97uRzHjyk3DezHMuSWN'),('9c632fb327a17110698db6ea638b2a2a',1363361409,'BPQdTWmK9TMYZL6dx8Hkx8DJoIKfJDIjHXueWIUY67z3u5DaSuNwzl/zDoYdkbVYP6RM3a3U0aUkHS+tGk2BkV7/mTpaKPGexE4z8REpTfjD0g21VYp8L/oHFbi10HlLW5pZsB9MQySuC1gQPd7g9VRn7zsJCXpj/oevXmQ6ZNRn6ar+hl3jBrHn8HpPDhKFTU86/5yj11nHd4UU6E22/59OKUTmS4KgA26OTAMOUbQKaB8bseEEE6NSmr1ecC41V36sIXy/imbdWCo+/SMQzvN59jEkF+4rNghMSZtElOEe7OrqMnP7vZWHYgF6Z6T5PMrrgP1MzNLNkQQK0k6iSgGzHlahQs5cPAZstwMAJGU82fzuD8gxldxlqXzQpQVc/gtroEdKnLf7Oyp6xqchqYGonLpjSC21DcY='),('042077341e95e8c964a9e1a346b70a0b',1363361185,'3qOkk1vErvdPQNhbaHcQe3TJd9kCfa3rq3wULrOKp0oct2jj3p5WNqLoW27ELnF5y3vh3jkwBH3SRgvrSU8f6PpOomizRN+RqTTdxATrZS+JYxMDQCEOEElJfSLjOX0/0+BxC9ofoUXDbDLub7PrByZAnlqipAKcV2TNaMhkk0rjQIW77SX03Gju+VVwnBPM8EMlGL0riGviFkVlTTlSpamnrpFmJm1iljF17we5D0gGtRuMHOxwx0tmGBt2p4oTDdHSl3Ljh67bo+HnBlaxjxs+s/rxJyOe1n4zVaZseqKSjEDxxV8wBE/GBJbZ5f8NX7PNeaC/Q4xB3q1K53qmhDAAlKEv8SLhzuMo3+LmxbnNvAAClzja8JbskINenqTnGkd50mX1fon6oIdxa6rgD6SbxYtYE3Qr17HsezmLGUYYjYOIdv6XbdtQEvGzoaSFK2CbTF4r12IcyH7tlLRTO4aWHEVACDt2xQLosraUGuCDtrM='),('557070c1778584016876c7663d16ca72',1363361130,'XAirEfwnZxpOD4x8D5dl1LihDOW2ml2KznUnF/YMMeye7Lkhb6YEfnQ5dEX7r4DtmmmkoVF9pn7IUqYAMl2qHg9ubvYLBQDXn3hsWgcq0+yYig1uMpun+UWep2CTGbEOH5TWlg+5m496kn0azJQM/sMtrdsMKkmlx37i1A2tQJngYA8OX+yI0AGMZ8moS2rSQLloMyzo2IPMGMqi+ikxSJ1J61UwGeHP6rPKo6NeqzG0nrOuBxA3O9ZXc8LIU/rNvI1IsFqORfSp3WbFjJ5COwvZcN0EOFwLv4JKi5EJ039EG7R/mEXVCyApK4SgXuRJC9WIHz5kpcjYoprJvg=='),('f8eb5334bee3bfb36193e0ce2a360785',1363364448,'hW6L9mbVQcDjvgjKJeXDli1bVYVMJtnV1JIyBVuC5Jiva9Cz12/0NnXEIkgsBQimaA3UnMdySK1A0xbUbn3W2yLccXoeX0Zf11oKo3BTzAYKopQ1sconyW92NTMe4LV4ph3K+hXM1dLd8Ni/kS3kotT83SIWbkbysgDYZ56sLv697jFCvUEJNRPpvhGryBFS9No8uDoWjb5uKwjaeAvGcEyWda4mL2dHLqv5JdlS2p5ONPdBYzquH/6T8+k9oDfSQId23wh11tYMNVoImvgzF0speFHLhbyzQOZTBiL+zKmvPEJgh5lr3aOyOTTmu+1vxlt7CpyA+OZURsbw5sKWAVE1gfL2vO7PlhGOuLUg3d5cztyUa7Fir0FTzhIY2KzBOYQ/EdE2ct3lHeIhFI8R7BSzTPVc6kg/6NpEGp7CFt1yR89cRjPGgaz41YDR/k2b66fZdtQYBSV0rQCNrgO8NZhZCMIHuIg1g1/cBAc4r5I3BwHL1TB4e6CtgTATM51i6ZtaVlT3abakeAOTfvPhUQ26dCSojbPK84OoyrDDF1GCb7pnlHL4xhrERHM/PxerI+fDEupSIR2MhzSW0Wv/5yXguKhsXdbQDV5onYaTkVTZ83qrjY0pq1et9eopmWRy+jXGGUSnf+rre97x6n4nGFxcAHhEQg7x1x9U92YxP0DtQ0YNTbIj6D3SomeRdHH8X54gBZlqCPVxmsHyneq0ePFT27TYU3NNPHKakIaqUYTScyCkIwzHcmGTN9OIedPAPGALaJ7d0iQCenDLUpIzPIzSoa9uneEVmNqjgtNiFvcbZnz15K5sJbgHv0ZaUQADCEr4APJpm/XYB+KZ4lyAdTgV5qrFa7yvNodqx/J8JuI3ZFHe6e1r/Kyogd8pIjqrRB7PurkcW5iYMuxzP82UqvutN5s84Pdr+UeUtCQMTqN72wtsqsInOpRoHXw4JxMk3zgsTfaP5KZLtDR0pwFghsRvhqbSESFYw9tvgKCqX6Rk5awT2X+N3Y2QQ1ImS4uqypYzNvJ3rhnyzaoYOkqoVqqdgNVrvsX8EFBqvHPL6dwaSJnXqW4WiSssl7dFFns4sVREv2C+zXv7EOB+o84kOepeK966GNInk1R0cnMDZv+BipGQxbL3h5vquK836Nn+Uh04W1NpV68tF2gkpQrCeIUxLOBW8no7ohqV1PLorKJY04++NY0vnPTNV5jz6rvyhWgTYLjd0urPpjw0Bm62YNSe/dsXjjUyPnUr3OLX77FBaMj+OTMFQhIKEWqoDeDIqcp2CLl/zt02MCRHYQVBQhXkCje0+C1c0Lb5q5bY8ZHJBi1ptq6qrOEtTXQGxQhL4SNnwa2mcA5Y1g=='),('8a159edd99bc8279e1b7ce623e70fc37',1363361069,'xBzUQyUMXmKgANP5EfTFjy3tA5nDypZHUvLpSxBLpgnLdzqbCSAiysJnaoEIMUq8vJfDEhCcYUPEoq4u1p+UKysDFHE1UVrEUeZTM0VWN1AZIAQRCGsiweC6/9qujqxirD6L+p1wyZsBT9I6Ij54amMDLOKnu5ox0w2XTyC1Ksc6duAy8j7vVUW50efTCbnZyEj7On1Aq4tdJwx0ytdxHLXjjLZSlX1CgezxUhEmp1ALrVS6IpyRdvOUa5YydWx3xPv/EU4yzCIeJGi53tFrwVcMCcIGXTDvX6AQ9E2i2jT9FywqYE1KuCO5J+4yBsYkb+TWNFb6EXx5TM7nnQa5KXU2eqpHH/eChgfCA/ystHyq0XQ8gKYIr9lvG4/vuz6kN1bJzaKWiG+W9dhhOSQw87fUvqGE9dY8/iB1935A4UyXlZap'),('70ea053cafc1a26d2d1b419fc2778a29',1363360520,'g/MKuvrmj8sk6ew2V1UOczugQTHI/UuulEBpdCCKOwrgGG2Zuz/oHcAhJzIuoPLj3/L8wz+dyTI4eg03uHanyGG+rjkdPdDE3kGOs6dnE3H8Aj1BM37GBz7urXPY/iQ1YBByqtvcGHZl2IIanjs13rieB31YTOZwK78g7mzyELU+lO3FT89fsnFSgAg4ODYzYS4BOnrPVhZQmLdSPQlYCm+Dv7/2al/sM/a4eYlGGaO1jgmcZX8LKNyrULZEVINmx76XBe52FxfATm7D99AuDfJMFn4HBDvTpnGmUCjj8DeUg6/wjCbWnTC/GLi7m8A9pB9axowtz12ByRivHpUngooNe3p0TLDpiVkdyDX9kCJDJqB5Hm6+IqSNSwrcKxiYS4gKaI6iEMbOe0aYR7XGUdzSAaaiKx07kOGE4lKGldxPXcC2kY3IbFphZ9ji0wXiFfKtIPRP'),('cc2574bf0563adce33819f00c0ce3f42',1363360172,'kUOfHedfIIGnB2QvXIdDp9NwxHJT8ei8k5eqSJGFKlsz8c7Tphpnlbhgk8ocPTmjqQL2hNeNbG1wAiMdclboLJ2XAOufx+zf3n3wE7rnlbfpwmAq6TWe22bVCusLXdKF3Uuf/iTQt3adRCD6Ove9BV9+RITQdo63+Db4kxGcBNyjp7t/ieau+yZqqwv64vTW4X3vTxl3GMNnJK0UeCVmDYXFzUgHITpvCY+huGPpdolC1i8RLEYJBKNBUndOJWqcp3azvKqeFbmYxtJyy+QHCxnGkcNk+raoRK5lhk5+tGN7AMzsiNyccDdTJAc5YI9mta+OdWRO4VFnbVrzdON/raBWtpugioDbe76Jk49ug/KRi2jjomkUHt1Td/bdSPU8XbI+X6yDMyXX/oL+crc2rIw4NkOZUjGNwlc+g6LLAEhfBXw5J3DvafPcPoRniWre0QxVL+97FCavvfYfP/ueVdGAshrNDJzj2r1EycBc79Y9OcfFywqyKpxFYU2NrsBBtVWkMD1rbttf7TQz'),('9046854d2dde3bb7169b08f5e277e7dc',1363365114,'XW5ow3EtmfFCZ1dBExDOCyRr5539BKwq5thlAS6qZNh7qWuAAYY/GlshgdtvtqxbqxRLzgLnWeK8FRvFYT/GQBo8EpHWd9ToBmf6mnQ0FN/W/yxbDGFV5+LcmWsbmM0eAmmvX+ZkZtHYUgnodIXSaWWRFgPBgaprVIZODo/MJoNCNdRictU05XEBAEsjnh1zg5jQ6lKqXVPqvT8dQVNrCnn1uFw3jyKkCQyDspG5PwtuaYtK2bv8Zmfw6vVBNDGtoyYW3GB76UJ4cEt05n21ymK/8onHBOtQKBtgEmHgTLyS4wN9PGNBTvWkHWeeuJlAXuhbYCQ5bn76PUesCctItDHF2fowGgVVlNblL1u/0zc1qJfezcSbmNWIYWK1H6up8CgiIRBGIIxuLBbyZKbwmrlNMwMxd7QBB9ynveyFhvU7EKs9UjRfVos/2cS4Rkt97vrLaJ6XNbTts2B/UkYOlhWfQ+HJwVbq9JrZ8hl1PpELdE0='),('d4e4eb66b581d71101bdfa71c1d16811',1363365962,'0EGxDImGygTKDK+/m1uj6Z0SSNXKIt7ZUiuYosHvSZaUrSecVBbJZ3RZ10r3/IEiyjjSKx4P7Fw+XYQsYIYkA8/uCrc1Dqar5IS4E1aHJFViZz+xT2ZvkTTxYcHZZIOitVQwPYWmDGdnRgis4t2ucT0qwOZy1R+2P5YNVd+vdXtqt4abK4fs1UoDedJbEyf4/wGcC9tKKJX+1jH9ACp+tk2IGPeuVFqLmPqwktGP5FLS+8LiEK8E1fHqWOoQnOTLYV4BhZAvSwd+Tz9UryA3Lt9ZXIqWGdJoulVT93O6mobEU2fmf/Go+U1J9jLk68DleUBAx4vs7KRWtv1yADGID3cC8MDW6wAY3yhY9zGBiOVSlNCGHT4/ejsdPLm88ESErTfKMFj8R08zwoXgkL9P3+jf/xYFLV+3avCJldi1N+MJSBZrijoSNCHVUDJv5tzy6UfREbBFyk7ThBBBRce275JKU1A4s+7/Sg=='),('2228d7af649bbd25ad86eaa2fee7bd8e',1363360019,'QfDMaIkTv6iDKac71DlxdgLQrOyLb8exl9Wlo8YYUWdHOePwsajc0/6TVBc8FiQSizNzEB8w2Mt4IJ2YyCqAf7tNnFgxWRC9IBXO00sw57bMveOrAroArpGtGklFbPvq61K0Yl2iqcx++GYJOE1Mn5VfRoH09VwAIrAiNm/gG85uirNApsa6f3PYVqj0k+OElVw6ViePtcbDFu38C+SLa/t3b9ETg+2bq9aeU4q5VMipEdcF7AxbiW/dIQV6wEzddra5Gd6+OYEyQtm3UBAr+JQecnLabBE9HpPy402pe2CkXzUZ856tXJ0NAAlYXuasuDBkv6RbnAavJlDn4pbk2vU8XqCumNJvgnnREO1oqmMHSvk5gwBC5i1EJ+vdD+kzvif8ZFvTfpnugzU82OcrasuowxDkMpPuTdt3lyq3dn2lXiuUVu3BXGcJIFnZ');
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
INSERT INTO `settings` VALUES (1,'site_name','Jószolgálat.hu'),(2,'site_tagline','jót, jókor, jól'),(3,'site_banner_id','3'),(4,'site_email','info@joszolgalat.hu'),(5,'site_key',NULL),(6,'site_language','hu_HU'),(7,'site_style','unicorn'),(8,'site_timezone','0'),(9,'site_contact_page','1'),(10,'site_help_page','1'),(11,'site_message',''),(12,'site_copyright_statement',''),(13,'site_submit_report_message',''),(14,'allow_reports','1'),(15,'allow_comments','1'),(16,'allow_feed','1'),(17,'allow_stat_sharing','1'),(18,'allow_clustering','1'),(19,'cache_pages','0'),(20,'cache_pages_lifetime','1800'),(21,'private_deployment','0'),(22,'default_map','osm_mapnik'),(23,'default_map_all','CC0000'),(24,'default_map_all_icon_id',NULL),(25,'api_google',''),(26,'api_live','Apumcka0uPOF2lKLorq8aeo4nuqfVVeNRqJjqOcLMJ9iMCTsnMsNd9_OvpA8gR0i'),(27,'api_akismet',''),(28,'default_country','100'),(29,'multi_country','0'),(30,'default_city','nairobi'),(31,'default_lat','47.498868116865'),(32,'default_lon','19.044456481933'),(33,'default_zoom','8'),(34,'items_per_page','5'),(35,'items_per_page_admin','20'),(36,'sms_provider','nexmo'),(37,'sms_no1','36707177179'),(38,'sms_no2',''),(39,'sms_no3',''),(40,'google_analytics',''),(41,'twitter_hashtags',''),(42,'blocks','news_block|reports_block'),(43,'blocks_per_row','2'),(44,'date_modify','2013-03-15 15:59:16'),(45,'stat_id',NULL),(46,'stat_key',NULL),(47,'email_username','riasztas@joszolgalat.hu'),(48,'email_password','r14szt4s'),(49,'email_port','993'),(50,'email_host','mail.ppt.eu'),(51,'email_servertype','imap'),(52,'email_ssl','1'),(53,'ftp_server',NULL),(54,'ftp_user_name',NULL),(55,'alerts_email','riasztas@joszolgalat.hu'),(56,'checkins','0'),(57,'facebook_appid','477036919016098'),(58,'facebook_appsecret','dc2c5b84577a5153ac540e015c0f50de'),(59,'db_version','97'),(60,'ushahidi_version','2.5'),(61,'allow_alerts','1'),(62,'require_email_confirmation','0'),(63,'manually_approve_users','0'),(64,'enable_timeline','0');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores browser tokens assigned to users';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `user_tokens`
--

LOCK TABLES `user_tokens` WRITE;
/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
INSERT INTO `user_tokens` VALUES (1,1,'69a446b9a894d8042284af656d11e503abd87413','NALyD5QycdTMpT6oqmIfWk8o3MpNfUci',1363341774,1364551374),(2,2,'0577c057dca0867e18628f62654f56ed6d3d5f6c','qOOaVAyGS1mYcqPjpNyOZi6qsP9uHsHR',1363343782,1364553382),(3,1,'a6a09e95abdc56bc160ef56cb5bb72087c7baab7','yqtcSLIjST0DdLpCci0uB0cHw2x85FgU',1363345326,1364554926),(4,1,'3436bcb34c7fd95b33a5800388906d53c89d82bf','XAxYcF0Q2MpbWIZYMZVOQZL8oCu2xEgF',1363361786,1364571386);
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores registered usersâ€™ information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'','Administrator','adminisztrator@joszolgalat.hu','admin','e4a2a574ae9f29f69f2f5bf4d0682e9cd684ef6af784ea1e45',5,1363362705,0,'2013-03-15 15:36:22','FF0000',NULL,1,0,1,0),(2,'','zuzmo','gabor.nagymajtenyi@gmail.com','593437438','d3241438eabf82f0fe2fc26e22677aedb5d35bd1f2d3e042e6',1,1363343782,0,'2013-03-15 10:20:59','FF0000',NULL,0,1,1,0),(3,'','kiazami','madarasz.csaba@gmail.com','863647461','68d25accaaa7c24c675283a710ec3a2b157788f91b23ce2360',0,NULL,0,'2013-03-15 10:40:24','FF0000',NULL,0,1,1,0);
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores all verified reports';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `verified`
--

LOCK TABLES `verified` WRITE;
/*!40000 ALTER TABLE `verified` DISABLE KEYS */;
INSERT INTO `verified` VALUES (1,3,1,'2013-03-15 15:36:40',1),(2,4,1,'2013-03-15 15:36:42',1),(3,2,1,'2013-03-15 15:36:44',1);
/*!40000 ALTER TABLE `verified` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-03-15 16:46:03
