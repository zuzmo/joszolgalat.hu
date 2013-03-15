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
INSERT INTO `category` VALUES (1,0,'en_US',0,'Category 1','Category 1','9900CC',NULL,NULL,1,0),(2,0,'en_US',1,'Category 2','Category 2','3300FF',NULL,NULL,1,0),(3,0,'en_US',2,'Category 3','Category 3','663300',NULL,NULL,1,0),(4,0,'en_US',3,'Trusted Reports','Reports from trusted reporters','339900',NULL,NULL,1,1),(5,0,'en_US',4,'NONE','Holds uncategorized reports','009887',NULL,NULL,1,1);
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores reports submitted';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `incident`
--

LOCK TABLES `incident` WRITE;
/*!40000 ALTER TABLE `incident` DISABLE KEYS */;
INSERT INTO `incident` VALUES (1,1,1,'en_US',1,'Hello Ushahidi!','Welcome to Ushahidi. Please replace this report with a valid incident','2012-04-04 12:54:31',1,1,1,NULL,NULL,NULL,0,NULL);
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores submitted reports categories';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `incident_category`
--

LOCK TABLES `incident_category` WRITE;
/*!40000 ALTER TABLE `incident_category` DISABLE KEYS */;
INSERT INTO `incident_category` VALUES (1,1,1);
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds information provided by people who submit reports';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `incident_person`
--

LOCK TABLES `incident_person` WRITE;
/*!40000 ALTER TABLE `incident_person` DISABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores location information';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Nairobi',115,-1.28730007070501,36.8214511820082,1,'2009-06-30 00:00:00');
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Holds a list of all plugins installed on a deployment';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `plugin`
--

LOCK TABLES `plugin` WRITE;
/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
INSERT INTO `plugin` VALUES (1,'frontlinesms',NULL,NULL,0,0,0),(2,'clickatell',NULL,NULL,0,0,0),(3,'smssync',NULL,NULL,0,0,0),(4,'sharing',NULL,NULL,0,0,0),(5,'viddler',NULL,NULL,0,0,0);
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
INSERT INTO `scheduler` VALUES (1,'Feeds',1363345305,-1,-1,-1,0,'s_feeds',1),(2,'Alerts',1363345633,-1,-1,-1,-1,'s_alerts',1),(3,'Email',1363345305,-1,-1,-1,0,'s_email',1),(4,'Twitter',1363345305,-1,-1,-1,0,'s_twitter',1),(5,'Cleanup',1363345305,-1,-1,-1,0,'s_cleanup',1);
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
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='Stores a log of scheduler actions';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `scheduler_log`
--

LOCK TABLES `scheduler_log` WRITE;
/*!40000 ALTER TABLE `scheduler_log` DISABLE KEYS */;
INSERT INTO `scheduler_log` VALUES (1,1,'200',1363341776),(2,2,'200',1363341776),(3,3,'200',1363341776),(4,4,'200',1363341776),(5,5,'200',1363341776),(6,2,'200',1363341787),(7,2,'200',1363342009),(8,2,'200',1363342118),(9,2,'200',1363342148),(10,2,'200',1363342321),(11,2,'200',1363342428),(12,2,'200',1363342462),(13,2,'200',1363342501),(14,2,'200',1363343035),(15,2,'200',1363343050),(16,2,'200',1363343136),(17,2,'200',1363343170),(18,2,'200',1363343362),(19,2,'200',1363343536),(20,2,'200',1363343582),(21,2,'200',1363343646),(22,2,'200',1363343731),(23,2,'200',1363343844),(24,2,'200',1363343883),(25,2,'200',1363343986),(26,2,'200',1363344019),(27,2,'200',1363344133),(28,2,'200',1363344228),(29,2,'200',1363344447),(30,2,'200',1363344523),(31,2,'200',1363344545),(32,2,'200',1363344610),(33,2,'200',1363344667),(34,2,'200',1363344726),(35,2,'200',1363344781),(36,2,'200',1363344847),(37,2,'200',1363344901),(38,2,'200',1363344979),(39,2,'200',1363345021),(40,2,'200',1363345111),(41,2,'200',1363345185),(42,1,'200',1363345305),(43,2,'200',1363345305),(44,3,'200',1363345305),(45,4,'200',1363345305),(46,5,'200',1363345305),(47,2,'200',1363345328),(48,2,'200',1363345583),(49,2,'200',1363345633);
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
INSERT INTO `sessions` VALUES ('51ca3a59bc98a419928f754d658b862f',1363345185,'gmmowlpHmMkcNtjnS9kxSrvDigXbxu92q9sxrt6HAQ54qV0Z/kgKw0pnB6gnm6p3UASJaQQB6HfV5hHD5iUpGAD92Aya792ewtDMKNWZHWRo4j/9y8cO9PJOgH6aX+xZHfawN30OgZMmwwUCFtP1nFlo7Eo77yk3yU9I0iPSTqqHPzmdDW7AFHDt/bp5Uo26uOC7IjCxsNSQkLqrzaZby8Kgi/snG6SYZWLjEl5eVyO/8/7t3FIUNntq/5bOP2iMHefVA1ynhzZy3xLggrQwCcVjRCFWB5SgtDQdue2QmPBGKzmk6J+jZBZoK7DA6XgvLuDSiV9po/JxlPAk70chvI+zODJD+ERcs4dJML0cLCKtks1hiPjIYvxosdyEu3Ol4EIgQ7WBvcWXgMUvePjPCt/XSb7+GnGCQeLXpt0v3M0r4KYlF02/2Y2Ur8DmhlUrO7qNDLzQZGBBBPfLR/xdKw9gEyUATxzlpOdnpvRZz73h1IXBvuEZCb75QqVBHT4XBbsSZiTekPt+bBeJ+pZv5w5gn810sHs7dDfv5qjPfBK74wqU/k/1JKi1Wxqxhk7KDQ9SMUFH4NBDO8sXDezuwLx73TElDnbaPBpI0/hkecSvKMbOaKPh/eOYHGkW8LIwooAPrDRDbkyg1RZvAilfzFTum01j1m30wMTRdrA6jp1M7s5t0NKpo5J4OmWpL3J+DWIYe5QiNiuLG9fK/LNE7iZK8cQncvz4tuamaD2mh9waj/GazyyY6qJrGsxWCK1p1fiP5WQm6zNarZX399w/Wt9BVrplac9CzDShI9I9JLxBtxUDJZVqOt2XvCqZ9Nz3+jtbBK2RKYqEGsddiF1J7MAzOTRmtpq/6gcfz8kon7MI125YJaRnPAV7BMmxqe3I4po34dqV/pflTa880yrMoNO5p5d456b17LUjraYBXH30y10eRwpQ9pFn6MAGCWoe19IhyDQh2Fx210UmPsXYmGiT5uMBh3K8Pl85a/CAu77MWRXut1dfOKql6RvmW5Ph9wkqr5RQKq/TXaxnw5oMxd3qEJJxnKpXbThzL/S69880zs7yKoSC1EVnEd2GtkP8NCiDhi4EHcYRO9ti+S8HBcjaqcPzv9HqYgeacOJW6dlA+tubGnkJTmVE+gwuoZyToUkZW36vVJWYhdU63JwNZ/yO5rlzpeQJu5HTnKVQXTnnsgZ4b4HlCPgptOg3IuPgM298ClHTe/f1Dqy+7X+EKKErmWAnet7dJQn3369ehwuF5EHPcxIV3CkS+ht4UatoOkm9AE+cHzdvZDW5A4ya8xIaRd57Cl2EM5RXMGhN/K9+HxJbq/JHMPXp2FaDCLg5IjC2ENIZSWdZ1Qt7gI0='),('1960342268e64be4aeee1bb7990ef564',1363344179,'DEnAjIFuimIPjtFkA6zTaZawJTP8TbFno4UIOIlutpnpaF5VaJM5NcH5mqL6bpV53jLkSxFaiWWInyZTEoEYoC27DwvnPH1cvnK8Vn19SaF3hr+pBgGngRoqVpvfEMgkPTO7rSX8MrfxFN9DD21TBt+kXyQb/m48Ke1A4NkidwE2p20bnp/6mLf/QoHAz2hPXayGXgOtwkJkg3HwzC3JiFqD7Hk1jy1+tRkj4KtreFWc4uDa9dCnphqOV0YPMUP1PDUpNjlVkdYM/v4HU3y+RMJre6An8p/4xajoEdemokhyjLyUJSiXoLnKMnQjXiU3QDwQpSKM0YiExu3gFwYNrdUqd/04q2IiKbElythR9XG39L2ZTuxJVaESFHdgSsu/aHr9CH6xvEJtZoXgU2252aO3dWQCXXmSdzPff3NYNLKYLKJczuy9qbBvIWie4MRWC3b0bbSSP+envWM2WKMxlpFKpxhtX1A2kB9aHHrA3LF8hqEIDt0WFham5XOHfXvcV2evXkjkAad0oNDU8MUxqAzhEv43YaWBWEe6RwFWhsk9QFyTZO71Z9gkU5Z1bYXl8x2MdzPtEHONfZPpDkDAI/SEeed3/6ZpHdRPYYkk2do/KXTxrhNBqovcRgPyytGl4iUTeOyWlyECCaJ+8c3k5DmGUAfYbjAHsvgrnXOoHpCY+HgMYKbQR0VvLX5TbFUt/+dompi0FgVVqG56pKpq6PajzUPL97TMwHx3T+4Fv6hvFDn7jDUfuY0oRqQc0n5HaAKWRY2MVGj4M4Du4mBEgYzp4gW3wRnoShBM0EUEeuGUakB4lgXLeRB0GBejCDJ0JFBL4yfBY0dv/zqvB7RXm7jAWQCgPAkbJOYNWg+SbM64K6ZZwNkJ1Q6qLeChaDWNH8V9f7gWk7QFWMsj9hpRUlG44bzlIyFrbKj2qEiLFInfGlXLnrwLtW8fwifO0rgIvQNJLhdPsQb2aKa2RFv1a/n2DnsnifgT9lsMZLHCiRAeJLAJL9SlNo0lKsjDxWhiU0rbnANp6rYpOc12rb/PlKPJWO3t05gRgeoO++HpvkMmoQ8lmZDBzLfrjcQFxIv2aW8Mp516VwCP4rfi4nTiitm91BpK3jPlo8zbs8r2fHtzEfjZLO1/OVjON6Vj9o7G6MUJv1MF9JYT4cCD91i8mSCxKUQLr8NDZE4qcqpYzqFLkVhZSS94oe8URph65dK8xZnLU2bsnuaZya9MoiTkAwzGpw4rvGxNSWzuCt7wNQe5b3+mI18CsABxZLJlwODia7ZJjg=='),('2f3c7d1d35c587dbd27d738f73cb8806',1363344640,'zI6ln8owPp7i2SGJS/+f/hlppOOKpIpQ0LKtwCy43NEd8BR++rrxHWXhxL/hgYE7QxktYGjSWH3lhLCjHlJgPzEi32Na7XCTUjS7FUo7LOex0Wb0LzfvZzK1XnN3MoHzWWCqKBAvOEh+w+N4tQHMhxvCk6r2XZ9x1/fi7JorDmpk2t8Igd/KtldS7GYMH89b4aJRVUiO6cmAEEzXFbxf0SbZk7i3t4t490VFOXKdQN8KcdEJMpZ3Mm84SrbAzciD9YO7VFoa/ssIJNWYtjaFFpHVRz84J1PjERiWJtKS73o4ovmOq0H2JW53y29I/9cBhxhWdTJ6JwDE+55bVsxDzcPZ6jGuv6i2x6KrwVv0P/KSe/rJv2yuzEn8r4g+GFe6i8AiJ9YFEVYHxleTPm/oWfz3LMa3uVW3cO/Wr4RwNJ46TuMZ0uWy7bfmHsE2rpxPC70TFHbL4F8trhozlmzJidBUhx2ppT7vheeb6eQ='),('7c35df55a351558797a4e03cce292c4d',1363343604,'XL5453XOLV6iKZ2rQdAQ0FYj0Xk4NB67XPwzQj4sfLmlZNMTeNW8ePV9OxxQW4Rf8CVc7H/D9H/AaA/6YTypPbIdljqPOu8jj3NXxvXoQUJjBC+ZPhUaUe+VsiNH1SsxdOiYvZ+zUFvvrvhKxKGkDGHtrM+r5014+8cbUWhhAiGbWoLqtZ84PoIZ0lIyIfkvY4P5zZPQuPWoexcUIEtPNxMxduU5IeCxrM7WTQXcSbwW9X0xRGBWgwL0BH6s+AEHizXa/h5ll9qNO2cem/8NoeAlgU5IrjTGQRzYB5WCQZF5gwzTgtTjtYqT+JlUr1ZofJ25957WvV28ehR/DGVDr1BIXvZgeNBVf6BZ4AHrjYorVKSGW4oyBQqSadc7YPEpZrDw1cHPBuMY8Kg9xvFtNafAO4DGN1C+SZwMHUtau1oYI2sn7vS+k51bK4giIQ=='),('8e1b8614bab0bb3bad017b63436a3693',1363344535,'6G9eqU6PJ/M8gCE+8kMp59V1cVJ43cwNJGGGgWSGTGc4DlqHl4foDq7Z23L3D6O1kzVcfIJxQQT7QBbcW+KTSMH9eRmQ+XOHP1kVKNohxHHI3Q6UbEIJWwPOHNbkLGzSW33BVG1W+gfy7r2i/4bzfOJZIgvQwh/GF4rDsIcG38PsbImhTNlMAgm/varuC9v3N+n2gcuG2BGMkDMHlgvOyUB/ftxrTBnl1LWyfVagsV1oq69J8kd3hllQkoXSn0mbuab7Stj2DG9sN2rNvxcYGzfJkaK3Ul5NENK8K6iRR9VRJSobhnFhjmc+dP1nz62mB7DEaAk0zPy8XapCb3j63vDJRNTDnCVe1K4jM3JZprNO1xQdaqC5aIjAk7zekprqt6GYzUdK+3lk19V1A+rFO1MFE1+QNoBVNSe+7huqEZtITDOt0C8bc82UcxL0Mrr//YWvd0Ye4qQ3yrbs/rNnYwErSto0eGj9SWih/YfHm7vid84='),('62acb7e82179a4fdbd10e9fac6008a68',1363343693,'oGJPi++c9lM9+Cc6WqaNB9LqmVZdZDQBxm9h/EAfJCXQvq/QDHPf795oEghMq5CC5txnUl5dBts861uBRw3KNQu+vuuOhyqIdSI0e/5AQ9MtEQaCk38g9mCk5a2kmZiq6khlDh6UuKOOuKgih/IqpAE+My8lEzlIGoDJBVjX4aophQ8Ous4LtfvL70U44mwo7JLoXN38+tYCUwt17kLUecmuh8LI6yIvxqeomrkySzqgc+lKvSypuCpwOs6oV4KW3Y4Akvqy32N6H1P/f9rO0qoDobdSexVxOrBoYhY12elUg/2po8gVCsn0pKZEOHTtBLrAUaICU/2pdnlcyg7S6rOYvP3lLRks+8DgY4fKf82OfItf25ub5zyJBWujqYHccMW6oXbb/xgRSfuSiuztKdnpu4PoM7yRH2yxjouAGUfKWptdMEo='),('c6f6d114e8eafeb781ffe468890eaf83',1363343698,'ypGiPmlnOX9yBgSXA8Cz2RJlLogp9nI1/miiRQjtu+KZ57teMn0hG4tkzZYcXw31mrs5gS2iGgbQud/DAVqbbz0OalUXMrhJg+i0dP1Qbka1b+XOk2cK+2IY90LXIbBdYOKRV7Ypk9PaX+XZWlMfRtETWuIA06Jd89qB/eP7OZHniS/JHUswM+EK3QOTaa5XETpguoCsFYjTEAA+EBouw650MYXnEgc/SuQ3ommVBGh5GYFQd7mWGxoIKSQ1DKI5uOTb+e+UcwSnEdvpzcksImHwdDDSy4iGSiVyUnvKyYOAC9nWl5Rs4QnbjXBBYyy+i+tWw0gHDPG811TKbuaKbbsbuKmd1KYI1mj0vrQz0L2crCSkQAe2ECAunHjWQjZ6QR7WiLih/Jp+aLkr9EgTy5wdqCLjSFVyqVKcIfwvHKdXMO3h/15HS+X1qjpFk1Ro4sXzydsO3+OoIXGZG6xwOkJ/bjAyXYq+KjX45Qy7RJW5X/xs'),('a5e0defb6f3901f11f135d4d372ff87b',1363343686,'8Z4x5XklI9naPqizMX2nPO/VDMuDUbHsSRM80ZGzD3zr2/H/dwz6Z577JEPKBZEP+fcmBW8QWUvpZIO+TCZ5KHpEPqmoaKSCevuYgOAKGJVCG9e/iCrkIQfb7rkb+pb2D/t/MARxNlH8NJyOJCYkXzuGoB5THoAbVJEgUSS1qkMFRyAP0Bz82xwYVbxlZIhbMU0XiAf4sG0ok2trU0vdwyhoAkl3yKO5MZNVnlBq42nFaKTiaExdA3CTMLabUyWTtu7gwSD8kvJQVL0ZnteHeNTcS/PPss9L30POpccb+Q/oRFA7yuhls0qdtq8y172RLiOS1M8r8nx/5WgpEdJEdt43MMrQH5NptcdG5TqEVcDc+PokdjpTxTavUqpWWLX24ILDzV5nj0HV1RbXQ9sDSM1tJkGAkgyXIYXVrVBUzjkDhktV75UpWBhsWgTFZT/JI2YyxVD6Ukjt4NF51j1Z6itgrMLGOw=='),('92026e8358029dc6a303a053bbad8028',1363344682,'uK5FSiq0Hp5vdjreVuadGzqR5zhk/0oKIi/3RAmJprNmtzaThZ3y+OSzpXz8iXTibfWwROa9xL/Wv3RuOPNPuZm0rx9K8Q9JBm0s3NGmdCHo1CemNXH3roao4rtp8jEh1a52IPpG8P+DGKKx4AYLe3WrJQ9msw2WMSoTFbHe2lBWjUIzldaZXtgI8NK8IUEQ+gTJIM43n2DcJpoBQ4gyqz5X6AsNA0uDyMyhAY0paUsX+j618kuPGW3vTf2FDzNIExFWp1Jtwd6RgJIEihqCxps0Ppgbb20DtbgROMTDE2g/2EpZZXZFd71vRXKc1B3h3/cI9v/RxLZSUgMKO4ycQiAWRkgmWF/lKvZ2x17D9N7HuJgiuPBK0pvmAax8vdmu6CS1/4VJd8kQIjtBNyyMgYF0NAiievjhTCtTVryiVNpndT6k3nzb+tS6EsMdYeL2bkne/spU3iy6gtB0ZZspneivB0C8UemQTS9VGARrWfFRYRhpQPPMIopY42eesfbSB8BH56KW5RP8TgcpFQ=='),('d4cfb12de67b22face540fa07e39cba0',1363344941,'5HG3JfHdOnXt40mhN2/3SFtxQLh5Apfv01lF3tdgQi9hV1JikmmV+jI0QqYw3iXK6KPAuPHcXctH1VisO+naF7Wa1ZSslmiJSkEcNuUNp7QmSCmAYqsAWqODSCIyMlxiPk5xzsxC5oZ1WDa868mX7+rcu8XUCNs7rMoOXIdCfawbLPSYdmJTSGZswbFpIfUC9SpBB0lpVIPL8C3/bzb5wwi5BPNPltKHWoFqVxpHreyV0xx1Fxznl8GAPu1950uAiaeijRUOdZWb9AnWlELbheOxuwoq0fBf/voWh7imqudCh9ZWSL29VDuD13OeIGAp/ZWugnGZWomEgNRMyEFwp0xzaPk6iU1iJ26CosJ+S4vxGEQJR3vhskWahsyrGbLMSIAs5uspb7QdQO/sheCSjAkZ/6jmBCRBS63Kvp+4w7CLG7S3TrApnNXYaG2gi/YPm6fso6qILyrGaSCbOQ5rd9aiGZKKnevJPmK//a/Ue0CkWq9EVHx28IA727M='),('44b6c086f600cb326fb58ca33fc72589',1363344172,'k2km4VOf9QCPdaLSxkJPNSJRSAo9p848bhAbh6LKjtyrz2jtS3tICqoUZdcv9cb8Y4b4llY00xSvZiMRPRjEO7IRzwbySp27MiTjCemG4YsXIG8gu5WEmqmy5DNfLvbMC79TLy5d46wlTrnbJQgqErAgRKlFw99uIJ+gA/h6j3oEjubYqlaBRZpBCF8ScZz5jdnwf0z4rENKe+V+u0Gdf+hDYjw21DRBHrWuqO6/WDztYB7/RhFnhepj+J62rz5ydK5xwtwkmn4zlZDPQCLTml7h404h+PaRnw8hqxoST7R0wLKnTY9F2nPjX/FQDL7X606Jspas/Jnf1I0chhQnbja82YMqHJP0z5ItNUMQKCJzeJdVp/RX/Irtw1ExtivvWV5uKF4uCpOSFtLYAmM1kVM4drHae9wBb+xo19KfqTItBW0MNbq2z74eugR2OP+gvElrHztu0eay962stG1M8k7+Sg2Dp/iaA7Im+RRUS8c='),('b99cfd3871b38aea788bb98d390efddd',1363344468,'HYk36PJzh85fOV77B2vQV94f0BeIlwHPpIqtg4kqR1G4N4KpDui0yc6GgTCYWIiaAricmLZ6p7vj37krV7ZUNKmn/cvkqXXecM8sQLnKrISMVNbRE91FKUvYECzjJhQyr4DFyToyApEfxaIi8tw1W3mPX4E6//MwiP8bOPGD1CXRpZ3HMKv/Z0KJ5i6+Ww/C5ooWbvZNrKyfYBgdn0GBfyvXDEcOqgfGlLxr4aXMvQuZHMkb0nXYCF+hijzNLKPRSxUujsBzayS1KKQTwskTTjKGgBx05VNDRy85do/XomstKqarXKV4RbgYpzVA+gGjdoZMJrY9p8Dy2FLpScbgSOSAxLsm9TUuzPqTB19bfhfRUU+wb3xJI6s1lThjW+hzLkVCCsAWxD3jD1AEbfuzG41Q6r6wh+yjaPetFbouycgNvXMiP1UXe3WGWv/66NO1TJnVO5yaEaWcSjK0cUFGnkCkG4s2MQvsB2CtSjr/bGWV/n/GzUZVqHSCXA=='),('3f1a837350f087bd9a165e02f3f37fd8',1363344566,'hCwV0L1WowM8bvkmcI4Xe0mM3nDYhzRoI1BAVwkNYumBVbwKacOkmhfBFAXow4NGsJe8wFT+LrXF3vw6tRR9VDlBns3Xw9c4wHdE+tAWBwC/1Z23cVP3VQII4oBr8IazS2GNHu8hidrXfNaS1dL75Svw7LqebIaz+P45z5o4BUh7CNdGhL5+4AXyBcq1iIwfHTNJ6YP1h5d7jDICHmWsLtbPouBLZdkNnaXK/1OvznsTDs6m3H2d6OLQoSLsYMi6oJmO+iSftOZh0LEE/foj1d1pHY33S47aSg4KdNyzS+cy8XUUuK7tADwo8zx84am9K7IZ8XbeIQJVgbj/WlrUqYcvnZXOsu2S58hQUOKHDaapevO/AcfS0epeze0Bo3MqbtQicsn+EqtJZxm65IbG0ZL3Vook5rsMy1WPsq+hVnJYk6mM52jwHPLHralGEw=='),('3b5dd16c7e7cb8e12abafb0a1cbf98a0',1363345198,'19ApUmaKt+S8y6qyl214poGZjILb/P1X+Wqf1I6yM8mudKgqoXqgw12pWh6HW4oReqEpQjRF0PvtX2fcw95LC8XSdw1GGiQjPkP2W6KhEL2RiPpXkpRcP6IPnFXGtHPFOoXCENr3F11PlPslpo9V9VS4MJ6jFTvrp+S9Tbas+HJ+QmgZU9UAiO5qkX410SEMWY70xY4qH+bHKRz+uUPWl4iUcDtyJrNFSYE48elSRp9j1M9X2Pw81Jz5sacgCa8dGjeVhICWnzMHmmTis7gn0Sqie+ngccOjkQgXKr15k0CA99sXr6gCmVC6F7sSwaodbAQ2tePVuEAh10kr0t8Q9SBan/bsw5YOHWmSpjs5aKVIaWsth1nb01cp/DI7NCuQCG559n7ZJkEL4xk/uYGYhPpwmgTeN8yLeI2kftlhOWabzb1oiAqleU1cq3+CYSB5kGXAOIhGeRL5pPdOw70JYgfB0sUpmP7DQVUMcBqFi2+mUtiahjKt9emP5w=='),('b2990484c63e8e968c599bdb1609f97b',1363344939,'3XYPmUx5G8hcxZcwDeukmP9RX53k7KEgM7ehD/HoEO9nROofREz0gwBlrMZezrFAB6/coIZ/mfwHTtoXopI2I3Mhe9IVf2ewUMBKjPzkXKJ1HD2SPMcerPfDluyjaYggDZdyG0Y7TF8KH4FpEfc0DysKFRiqMgSND4ww32aMVu3+TzHxtY7QtOAbQNIiTLeyt6FIQl5bGGq8XqruoWrvdB0CSg0nIzLvcrilcet8ERUFtsyD6EAD0MTBRQ5KqMc6Ya1YE2dHATSMikhO7L+rJchIzJbH+G0ml2UFwO1BG7/ajDPrFcPGpvxDAq44Db6z5vqo/tgkbUwy1Bj0GJAZaRP97Emd8HrvO9VdcBasWtV3+T+WXfEO7ZEQ3OITLWrBjMgYsDsToG/woE1F/26obradEYePVdzHe/X6zvebA3PsXLY6lSFZgdhRBelh'),('1d461dc83c5f6ed3622e74246ff37806',1363344628,'2Zn6m5ZrnAQ0iHX3MDFMfKfV8JFITqvW3DgVdyuP5+sy8q4+bGr3ppXlvpTsMap++APVzoBiLLuNL+FeD2hLA/e0v+ZfZm7hpOO/0sKjsym+bm8QpeDWQGMeFj5rVneJ9w9FadqKOttA2dfr2ITMAW9tekJkFK/3Rf05xI7i9fxV52GHw46BVMzCEsX0dCxK9/pd6YX47EqAc4p4JkaCQGAy7ClRxpO441V9m6iOM5eGjiHgfvYDqUTHvHFX6pQDdjAg+9Ta+pbJJKgBg8e/0G8Ef7KU8HqdgPyVr1Ky53N/+a/SzFKPj3ebupuoLluWIEKl9XmFu1J0NRqn/FJ84AL++GATUV0M3EMOddh3zVVab68ivOOPsQZemULkttYdQnkFMJXLeCQYbQWXM3BOu0EXVnLEgi9fdzar1LRhILZ/KvZOMMH/2KwliP+B'),('a3af02422f4aedb76f1ffe193e4eacb9',1363344634,'CbTDQ0Q86pUxRVIN+M6q6zaZi06uCl+CIWEj8NPXeIFI9w6vTeRZxqfKvZfeqpjFvCDUVvM7b1/7EUqz/hHwXWWDiBz/vxZEGCJDdSsOII1kg6XRt6Ffuf9/1pSd4SkpU4T0DhMEw6vEpDCNBaLkCeSiF0dG6mbsklQunDdqEwr6bRPNQFNFa8bg03p7HYyI2t8wKPId0I4PYaCj5I8KHsOfl8szD2kKQowJNXTQ07ZFiHmPPb+EvX4qkbhsL9DvrTH1sc40AWcS03b7LDc/44cvCcAVlThW5cKWMIzitvtZZ1kRAYeKNPR/esEs+2bxM9j646QmE87FURddYOX6nZs1RVFBAPXvEHhR2AfiInk1iDDr79uKVhT7u3nWS8MWYYi/0ijD4qR1yGTZV/w7WPzk5E+9Ut0jSNbOMI7EsHOwK12peSoJi75AvuCseZBz3ZM2tDBForpLG9a/rfNx2qtyko5UBV+uu7dE5tuj5j6T0Wf9reaN75sL8YY='),('ed2463d0d088fde0010709967377671a',1363344677,'0XDGtgJlMCTg/TjMSbqeg2Hc190EfK4AHWFf48dwu689qsrrkLO04meZQboP+dW8BCIET6U6TRpzQ/5ILJgz+JNWBrhjEyAasZiTDG073VwKG5/8bdL2Ajz8+3zGU4yadxhyMh/xFSWeK+Kgw/4Owv8kxmtG2gTU/iKhQpVSpV9ucOfhYdsrnVftkc7iBzCSz63/BmaoOl/YAe7KEfdqJtk5JpVz1HGPnEy3eWE1ehQrlU7gCVuJ/UPQOJjFSZnpp+x/wqOFKkivvI0knd3lppLS4v6Dr1ZexpE5G43IyU43UInJgufIBuuYgWjYZIFGLMCK5x3HFdlP6wj2idVTGJIDiWHtFHccNw1MQF5F9aNGIerjt20UvJcmHqyxo2FkXTJ9V9d+x/uiDAXd5wR0I3ZtoNklnI08COpxB79ZImS8vT0ylb+gM3UHkE2lAYR7Q5wxsGlEza/YOVvYgPRLY8heMPlXy+dX9urLYs9+c6P9QXn2h0ZZ3NI='),('323b4795f1e710c35fa41c5f98c966ce',1363344679,'bbUbHLAMNXqyCHBhRnwabg7nuqW5a2BBIYeR3L1yC23VDhDBMT8efv7qJh+A1MIJ77r1NnS7HPf0Oe1Nn6DS89iWH36fHqgmdJwXaM9fxVtF/3lj/qFFjcomsaSsC7zrKNu1CE2DqKlD93PanP77TMP6ewWk8iM+a6RdLtWLg8v50+5wJQTwgv9aedHbUwOLbIri01vUayCAYNlH0JwoQXPWfbOW+8aSBaD/BoDYIiaLtD+ZbcVxsHPr2Yp2fNHPL+e6h8NNzHnO91HM6xg/REFqYVWRvcMpSDOxBhK0yhXvYMQLj2/h1yDobOhiEVp3JzHkeXYNjfb201EZBsRgHxmT/3sFSrvrkw2S4QutzMIn2OjMnG42LqcS5zC1k4t3EJ3l0l5y1kd2KfnoKVfIX+fUYGfZzlHaCgeDLTe/1+aor1pUGgRmUae6zjuyrv5RCreR3fxw448Ci2JlNWEUeJzyoK2dCSpVBUf5wP7nE8Tx'),('bf75c048b106535def06de3b62354ce1',1363344699,'953q5LXUkMtnxXqA0vxpKn7iWZNiQaPksoP3vH/nkP5H0W6xcr6lDC4I59/k8X4SoU8P1iln8QDFPzyqvUMT9i8knB/kK11Xgl3OHW5MKQQkIr7ZgWyCaFHUwnp8c/WbGxfWBbBECcv6yI0C95DSO/A7fl1A7RURoBAHhUXtexk5NRfV+It+b9KYIXBO86T07wTPNdbRgDZf3YRY1cVKwv66PyAtu408+WvWbmM67x1RHFL3uN2FEKvpLHGR/TIZOJRsmdqYo1KoW96TaICPc9H8d7bq9CYeinZl4b4WrHMvtmQgQncGpuh92zPgX7A+xBJFZksmJy2UMb/zt/rEhuLot5Lh0TgtuVUHvUxYiTWPHyEkZ1ceYA/cMeziXkueSdk9S70kTrw115hNB/mOBsSGElq4JpNcmbS/PEi0KObnJ+P9Ami7bIXnJfucfRuYIie8W3hAAM/zOKaMuzKGuREPi1wr4uXS4cVhqeXD+hgdSw=='),('c0a1f88e47e87e9144b2f8dd12f90135',1363344774,'jdmSt7p4RpTw+ieTtGjsaCi203yhGkBvo8hGYgnO1Jj2yN8ppq+jDn81vspwdPBMYCXIYP669A7Xe1ubRE8hHYddB9SPlpLmJLko4VvozyTPSdQQ4r1lSOP+BLyDHrISBnbmPzvTdx+7+edw2aN0tz/wgSRIulHN67pRJLNreZdmQa99BMDE92eWGNMwjAVEWGiXjtqQvFsiAbRsAhv9lwKIFN0CM0Lj/USQIAsNbT4apItc5+YV78l8vm/fzh0gmIRE0xLdxd0akq1Whf//DAMzfzAqWs0fFi7zC/lMo+wXHSBtqk5+EU5YgmWs1PdKFk3z8rH4QmTW+e0PM5tMm6EvKUGRbkVj0oKsxvYjlMGmk34S9R50XV7FTlqzQ6IDf0hlZxfkBO/Qyu+PNoqWs0ceiTq7DsqHLCz9ea2qvu7NCkdBPA8TNr/VWceD7g=='),('7990e37e1557ab95124cd2310534d77e',1363344747,'VCE9eTOjbx/KdH9vfbPZfZtltuP5h9i5CfhWAp6i0e4cITX/FQfHfwX8/Rj7rJSxTyG/Vr7RU9Hanna4OlyHwzdczlBaVyXSKMAFQhyY7W9jGukye1en91FK5XTwS2tsSMfh44xqqb4bL2hgYl7c++nCcjUnQfkMM2TFH4tr9IHJjwxPI7MLy2oyJ74m5ZaUyjr0NMByic6IcooZdqlDF2PYMd8j/C7cMofyzgeWocbfXdffcTJus4hVAZH5puLh8+RCBPdKUxwzmSHscHXAXVs6qHwrurJOyTkdVb9cG5QTvaFWbhTgTHF/7SJeMHunOiZuyp2JulvsntJ/WFGytDQvGxI+Au3NnrlpuKHlqfjKHy+sFVbHlUWhReqHZkbc4KB+NNBaL4bTxL4dX1+fjP1Ix6jKBd9VTylkbvgNZb5gbiWO5azUr/RGtGU='),('6f0f24e806c1fbf3df882bab03886ccc',1363345127,'dUXS0Y+80+WrwnYB35rePMcBbLvEypo5BalvS89tY5AdRw/pkhwkiRtt6t28akiFNWIp2WahVfPUzoVgQMMG9m/RxvR2NZvv3j4xsSC2+dvGAPq+83B7mdVhV0eyQhCmSGOuvJiU4ibFqH/cwivBzALhYgAWyz9FzsGhsPaweXYKCH5YSm12BxrsVxnUxlF+fqfJhguDmPEi68xcXI0FFdGnqer9pXda2WnxrTqcEQXQABXnCp5cXwTqx/cmZlJMyERSbB0dArDKIqAeJT1eW0xhCy+MqOs5NARKg59Y/PAIc1YCdbCrl8R2HKVcmzEeoCx2nn5ZhN7c9MDOdnQr5Ic4dW6lFzgYso3d7GW1USXPaqt/kVF3YcFP5JFXS5dazchx8Me/LrUZgjff8F8Yp40SpSuuefvUp3cTJ6Q2d8rqDp21Nw8GAmnkXAYRYDiXIr2XTYzsfAw8yeSdxnSjXacMhthsZJJT4dKN83jq+4Gh8CzXznEcHc9OIm6yDagKS4yKdquwA3R1Ps4IpQMQ'),('a95f3614e39d62fc07f28d4d4ec4944f',1363344874,'fAlYMTO6541MZqPIPAFJlyA5kMXjDu84mmR1ERzQ3bNslVlEL7mP0fv7hymt9X82Ray3vAEBtdzK34MQi/LMXxkTmcMzA96UaBWMIMfAWqZN4eehOsFcOMqhmWN/GzbMjBrXT00NfY+Vp3BbAp3l3nz/zsPFSgXjQnerRWlN1BSHh96qc9O+ps1k9NwabxUtdGWcOhIgPQJTZkj9X9XMfTy9PPuvxL1CGIQ0jh+Rm15R9UUh9DNO2qamP98vNiJj8Oilxe/tZDBqJRrX9T1DGKbQTKeNefXuAk2sAwGjmy1eG7U7vOcP3dMNGLIJBG/sh3QHof9p+DiJ7rzkL4yV9850EKAzl8B9vBg/8Ub0ujo2nOtxnG5rkKHwvB4UaIx74LnRcTYEKSYTvOcTSACGQqInSUkc+RMktmHJVdBzl7/h1cZ1WlKPgRn12zhbeVkyhfQOIQ95B4z1IupLxIaaY41Kfk3N7Py6LoRe6HQtTezoQZ1c2UAjYS3kPmFG3yzQsl9TW0cVxMxoZgcvfBd7G4jHMtfKkd9oatq5MK2sM7EHTv+l1S5ZmQcrwhlYbwjXEVst'),('b4cab80ada0649ab2394560753729cb3',1363344799,'jIu/J1oropV4nVKpfpRVeQLa3VyFmWVIKfWm7wn3JYnLTNjj64MuqRdWEfO8/pG2UcQxg6yC4HuZ1mnw3vZ/t9nO9yX3ZYZ2JjogDMajlCACQ1FXfX4Qgp83pk6TajBfFDxQ2tREqQHg67EDwFZ3xwQxUGtuk/Pg1ShmhSzJH0Cy06mXbIDOPhm2UyYuAC7zZSluU8NvB+Z8O7eyucy6Cawi1r9wZ8Rh0jDEetaLjiz2ftV8awqKmGx9D2hF4n7nQnjG0kGnbFJSq2M4hqQ7Vrri8/zZuSWg2evHF/TjIOfCaPXUv4oMK5ybN4gR9oQoWINLUM4sdUnAnHbPdm7+4VAh2ISaxnL/dTU0B2tlRef0OsjGcCXttZ+HaAilRQue+7fUQLsVqeDFG/VECCHKWvyfSWV6uHWU2e263N5O2LSh7w5SaEeHWVw9mcU='),('5cba302a7ea9dac70a8b9cd9df5a5c38',1363344856,'M2ASvx3gAex43bFU3wyfLgBKCRGJFNqXkG6eN3J+epcAko/CC+S1YITJUtlaAtFQgF7pwOQVTmWX000Z2cS+4CCl+wQkFkOC6Vqr3WegLgDWH+s6/C72k2zZLI9sidM1quaoOY/G+B9BObC5aIoLqa43tdGw+Ie59vvPtMPycZrFY+HB2Zq/Vt4uIVNELp90iLjZGnokejSAKu3nCwsW4LpomJ556Uc1VIuO0+FR0EOuydDIc4kNLWwBoDuGW2a5sb8arGxNE4WmP3TsMtsCxLHbC25MGdwPXPOXm72JSIzPqfGtOr4VmDF3cwnpaFGUW3q/PxftCqj4DzPVnJBybJ49Zkzd0WFcZs+Q+aJkwtcOapcXFWQ5aqNyj+hkML6rxIEPiPg/MLzE1+mbkkwiSUMiUEBejJlxI765IZ3VypDajtERKU1DSyun4s+e1Ym2xMIj5EWwEZdYuwcG2iQEkHYRs3fBB/XiVMtFFTOcystyGhj1npKswlbWMVEh8ak9EnAjP0jY8Gt2yoPDoq6/OjAmk9s4AhOuXw1/l2V6wMF+7/ir5KmIo7Orgy5jXUsB'),('08ae79d72ddbeca43e7767948d54f85f',1363344861,'uTRkkXQ11vikwxabXlBTX3OsHIFk2eT0uC1NfKHFnZfKfah0o9s2LjS7of1X19iIUYN4bydezYAMHO6YLM3vLs7wQJjYK0kAVQQL6X3IQhv5EmeMQeZVIw9oeCBy1erYU5nlV3wZxHld3iAlVd1q9LfvimQ41AR6CnmT6oVQeEb1r9pS+/ry49poGWDNbw6fZQr7bnGqlK4M+asFq0/l4oZGa6a4fRjLwIchuqyU4ECJhV/Dbc26GvTcwNB/pSfAB2lSKTmthqpYaWeE+LWYjdklMfyzeCelHrS7jrpQP0PeVZDesPkCKkY2zNu34vMH78KFdLT2wYir/PiZl7TYcGhmh+10DFce0OPWzOgmGPwRY5zAfLbTLlJSEFf+O3Phk0MaJ5S6BSYVghb3EAxH3oVyPGNnvBDCrZuhUlor4Wpo/4GUKA3hhhcdCm/RYr+ixT7H2hKUEY8kGlmoytH5lQmAndrrCwUknLKGd6UoqWJBOi5aKDaXgJ+B/mIIR+lep+X/idPr'),('e32e4ce6d44d56c2dd62059cf11af28a',1363344864,'KPXIM6amnFwYbI0BJ1CKo5co7EAJ+yB4H4hX0m0KGTCAIToV90r89V6lA6AVF0MmQnrskj6vzAn823npzeCrfyM+/iTomZDJHUumT3I5vEqnqseEPtnE3x2Y45Mi7eanPG3tCO4AEwb9OcxXtD0ZCvEM5Km2VGcNtdtSk6xc7GNg2zrMRAP5VFDeRiuh3EXNt6xYoLntvqyVUTZXUt8/54wP2N8diJvNYPBsGZITxRMomkjeMCiuKmU4V0sqWb0IHk2sZyYEE5gutmgSV4qp7e7uSMvHdhJWN1IgdWM+8+DlwLtztNNf39+tVw1GuCT3yOTKohfI/sQ3bxsnFM8poXSh9hhvRuOfilxVgjwn3faEtMHbOGf/CHDJSvRf/MUL3ntYVaEyKUnpvksFm78HESYxOfNZUwwJEPWDXz/wvljWp3eGUA=='),('9ee400832615fa9c6325d88cd0390a8b',1363344889,'pZGtuHkcoI08n9GqC74RpD6gMFhKwOizf+QozTaiD7CUTcPVKC4HYDfwv9WSYGsg+z/qsrTjJgpZRkl+33UrpoNUsXDpXjbKKzPqXu0Ojofut7oKkwQaSZrpmMy+tezudsFSzZ3gIuVmcT28v/sN7NMp3+hryXNpVq9qj+IwWx+nBcOSk3m6qqK1iKh2EIM4hQpv7yxxk/3wYVCi3VrG94pj5whESoC2YcCM1fSVlsT7RYz0Go7/F2rzFc+PoCdgmVcm+tkajz+giMAzVt/+II0+HHB3xn1aaFQiX/2mbCS7OT7pxQalz5UoCL6kAZunqvIPGeOG7vInLWK6D2zLbBJloHf+ERJiKS7fw/FuXOnmRYg49IPY0hgi1ngKhCdwBDFl+S/uroIH5wJyErUMf8/s1ySEdi0lCHHKvxPnEbtcwEMqiTjKYPT6r6+Zb1PKh7nRtI3qfvhu3xamx0UUEXz7y4XR8Q43eG0='),('70b2ea2b4906332f54d33dceaaa759f6',1363344924,'EjJQGMP51U8TbPzJP52oGo0krn/fLIEoilfkkFodz9T2CepQiEAhcuqNYC8tvAMfYPr6WY9zKKupGYdQbEQ5qONE5QJ+g7/Edu88WDgxRnL8hrm/c6frIU4spQbrCAho54tSlu3vo/YobUkl/2HFK2jp5MnIr5BMDOwUnDqUCzf2bNzS1ZdnD1VZi4ufAp7FsvEJNbEw2g+V/M+B4CHThjjqqQcLlXxd7ElOPu1N5wrGDZ0cep08hMtZ5utMw/CZV6j8LeZ7aAl2zuIZE+YVRQbwMBVANNGAVVeSN2xwjIictNboJdfZVZ7GdqGmsesGlk7NK/Q3UFpGCuBiuGD686uOe0jzqKzMELUbJ9B6XVgIyMGn6aKYW7DQhjkQGjdRl7LO++frEFZoenywU1FoDRs0t2oFAC9rTIpsxnpwshmJalnHT2HEhlDtwQ=='),('940f3187ab489bcd560f6b9abd141067',1363344931,'PN4x87zaOvDDSLaaTljAPkpEnPsUftUltpY8PZqKBbU7wsAzeWFE1nqvVzQLY5OyHDr6aiEi9g431Wb4bNAS63swUrwdQ3Zx/7IfNQ4KjasbZ80MV7fIlKjfrBVwr1UJoPLb4pYjUMq2fnC2Men3gK5wiP3NpLsqR4+jjslf/2/sl4NlR4SnBELLxf+om4ZWZDeaftF9c709uSPpmElkE3RpdoSY7wv5gtTvjDkYPPekokJXvBRBBxpM58y6XppIK/kMH7faiA/ozF+TjKGTWC+bHvUiNpL47zJoxaU/V4QOe+09rqFGp1OQtglG/MyF2ac8nHt1XrHJn4c7j3fIkHZ5S99B6firhFfXQ2QLLS58KpkV2ffGuqvhfHUxUSxJuhHucsmDsNRU6zPtvsidVLewbYK6+FiIWUIdEECrdh4nS7yjEU7FvqTgVIABySsQOnQgZdhfQu88R4CT6qc3YhEB70MHaiwMUhRJrfe0B+310W7OhbnVlPKzWQ=='),('995a1a6a3d60a78e0655a4322cc06662',1363345351,'QmUzS8OTxUpFhTggx51jVk4uci+AIFY7InpzbibvCN1GYAi6ZkIfJk5KIN2LW0KJX0oDd/Ss1EoWLbZjBbhyACzG6YZABAuwsUa7auS4Pbf2cO9sKVtg01rOokjUl3KlhngbDp3DNrsWAb1/kOnS0wYeRnQ/nAE51FD6YVW/yWgiGX7wLKRLMAI6YNQnY+SziBHX0b7krzGxc4eD/PF09UdvaOVl/fILY387iVQWiaG+yGQ4Hg4IqrzLR/Rsiuk2W82nnllxnDczrTn8t6d5g/MpfFmRIVYaDHeHD5gfs/cyg9AfC7WFnBu4j/jphiNcboV+MJNI/eaTk1cTdMuWhAq+TjQ/1gpntdrJ4oyu4B8vPpsBIKmj2e1f7QUwgY675zFhl0F89Q/s6zKrrIx3OSQlAymSo5mbkwmA/mLSjAjvCFOGs3kqvDfy/iskL3Hrp6byYlZ5Uxfx8ydfnrj3/IBSJYHmDyghG2SwDavtxoFezfd6GQx9bea9ygV6ZgeXjJII8msoaFLoCzGIY4NZonNlJUEGz8yIkkgRWg5RkAvKn9rPgsybW7138TmX22e58gbXyYIR0jeXCLki9oIvSQ7yaeERjUoMKEIerZuLBqu5d6yLY6HNsvhD0+A9vbWAi74bjg2ugtzisL9bIvcwhJPMOW+TF8V46S2JHT4CfESeJk+gJaWyjiJarqghTKs+LNCPGf7DZwfvOx6KJwGTaxe5XmqFJ91mVJ0/MXd9uR+q6cvNNSfYfduOgbPzHJhPle22veR7KDoN9IJMmYvUHN91dQ3HrQgMkJyOZhFLM/nZZ5XH8nIoyX6QhGInjHCn6MhRxFUP5w9Q973zYg95lYrXTuoci5tj6loRH1ONc9iC+Cd/FLzmIHJOY80h+SY2pucxuuAqveiMvljcD56tXi7gmSKhll3lyuDcwdYJQX+7WthmMIyF+HbayHKWb3h9ROo9PqegTxXezDReidJkNLbT0BptXqzHpmFSxNJPkCtbS7mK/wUvu0DqxEmEix1Le/DZbBGJHhHBZugGUP78qkItVsoJRKf9Twpqh3xq4hi5FU8UjVpAl7VLoOIVAHS7h7vX25te4uHFswHw/ltm5hzPzxB0PdFZi/P0mskJXoRl+EKyou1KjgsHmU3PZ8turNXGd6Taw8JXJ1Z71rxz/EnWI4XZeAWL7WQBd2eg+lolvgxEDLpxv3XMyZF2ZB90+GI8+iwjZW1Llzk15gJWn/6AvWjmqt03QLFzKKKCoNt8/GX0hdovGe8Axx/LgE2FiGl2RWauyJjd+Dnt4mKXYVVtmOhTNzA8ogCdIpAqROuStoGfSc2lxrv/I6434M8Jn8gxbYNte9MMfpu1Jvz++BoJVCoka8POG36Q5fyG6sVUeg=='),('805f4e333c7249f372845bb93df8a4cd',1363345064,'FoewmePAYtdvAlinlB0P7qsdL5092mdW1AaRYey/eyhokkpbVNd2xq7yxeOWDDuBsd1hwmly1UktGC7oN8MngdfENPtioMi4N1QXfB9w30fT4s8D5rvIQ9RciJlQjd3Ntc8rR8glXO5FWt0penrlJ2viFrzpd6bnKxoUdLcpIcH5uL+btGXSDpcGtBSXEP3uz2Kd8GAXlMt6vZAhDuek+mAkG4kMjuoRqaapsjHon1HcBMjEwQ5lmAsV6T5gXRFScn9f2sQDsUowj7iyO+KO80sxwfpUNGxnmyYrGDI43J0IaHJo7dG+yc0BT7QPxjGcvE06tooo4mrprjpi5qZ3Np4zYZG/o8om/oqNJKcWVPkssP9XOwb2uJovFp0F2nvAy8jslTYaBtKeqG5CHu9oJi38rJFeH/nGOaLLlrKBoianAiijuCyYHTbur+pjXUXFkLmJsENilms0bz1Tk7lg6/U8VEsMEYec6NtuRYC/Y+8NWY/CEsfy90nyEdzDQFTJgqsw6DZB8sq32Du+Dg=='),('cc89cf39c42dc006d098ceaa9f9d03e2',1363344945,'DXRviLt7vhkWNmsVCb5WUXj3Hs+PDOu/jlFaKTfMbObnEf+2QqM8fQIXGfJ0VcKObKPeCrUKQ4TimGOteynqhyjvCRmxsNuGCvSSCJrYOYiEqh7csSqAWmo1ehxxNZ5D2Uo988SXJjUocDXhO8YJ+SnI/feY0RvPJDY3aOR4iovxiTVoFWO2ich5+slLOAHVNaU9F/q2BoSZ/gKPRep8snzdjhD34vl74NY9tT93pevap4ssM/AYhotCqgh+5jWm2fOedN9Oal0fEvsB0fi3Kwpg6WTJt2MarlKSdNjtBNRXV9I9R6aYJUkSq7Y6ZNSJRdWPfLL/J+xvE5GNYaauoMGbGRCuIe3XGwyWpcj6F8EeY88gDOr5LICaIWNSPNP+4idiw1+NhPefLA1OS1vImas1LB3pdw=='),('41e3a7760ad170f7069979303aa2e61c',1363344968,'K8zJ6ZOq+yXYyg7C1dhy+VQT0XjgYVpXrQ3xQjiNNIGQJPUc4+tAtCfdrCEJZ7JTFEN0IF7/5XHzs944x0DymFKml1WfxAHs4qtkKHTzyDpgFCqP/Nnlveqpuk7evHQnbKghXhnl4+zjw9TjQlyZ2bZETmz8c8XBFxLNUZzvNl+fI7lIYhAH/YYZn3Pnmp3tVajVjzruSDCD8aCI2GFt1wHSau2h5nLNNdidGAVqQjFsu8HGhaSupHoA1z9E8wr1FRf9caIWhDmJmhJ8Hg1ohL7UIT8Uzpv0ZUmrj085WFfd8/BM+6ERCNvg310+/59Ds/esaDUy854J3ElIcpWRoG8yIkQ7W9T4icqkyh9cExVth3f93i7nZWM='),('7329a0adb8f0242a77470f022a34c608',1363345334,'UeEg9tvCR+mQh6tYZP8HBC6Mkbil1y+doZQD2Zpyw5ZVVimzvxNw+SUNiwC/yC3iJPTXFqLtnBKGLIWx1hGzectpT29oHgAktw05mOLobgFTghaquHjz4av1tFTzAuA8KukKQHII9hm7HvS/n8AyI/ZavwQp4ENTdnzvezYDMovXIPhqV/8SPrhbII0848nfCEQYL0lvBzUp38lZleQ38jkWcT47wy9mFf66gsHpyN4Dkhqv/1Le79OPPOuurM1Us2Aij1KxTYu4PzLM4/yD2futbb6JnaVzqHq2iUQIaZljy4KCC5VamBHJugIkQLWhtIHu66C3yT/YWJelL/bxNn+ObhMx8FhZeezmvdvE3JhjK0XfFBfkwR5vmVobBYlZ2kFnv6Y0vcTQjKhJCB/0x4/3lIi2rTEftIr9TJqHB4g2MuiSPyz4pXETvsT1hMv0ck3j2jCWWPPz13UzhFNqNfOE1dQfXc4vbATOrqvx7+8ruSl6uHV1CP0a3V97e5im'),('95b806ea9d80cbc2ef145d97e926932b',1363344991,'2Wq2S1GPAZHmdlHFAEH7yc7MWP5j46sTtURpGTzT07iyYrKRLJ61wez+Dh5aHirdcnwOzEaNiHDAmHfjizzLN7OM2L/HulwCABJ00cfLp0u6CaIWWxBTG32h0Q3sixQVnuI799oIsrSwjugYMrHYPKBnrhGby4mzqo9sgtQBcmc4DpN/0i5NBIrh1yf3oYnZLLeJZ+Eurx6LQWqNS57DHOPD+NpKhXweqWExZV2WWUF8redYWnOk18rqvQj3T7NSXQZZMN7WqzpoF4JW1PLh0ekUNX8PwxOpaDrWpT4rkMM+ZH11b65jZyTTOL89bM/y/87n4LNqn6BgV2RFlw1l7WezU9Nd4NdMeQXx8zkE/UTMwFYFLoei0qEMwxQNTUhZS1MCwy/fS8XawEyK8DINcwAIuN0nb4oVMCPBg73p/1kwK7DMbIlE+8UMGX6exdh1Kk2MGdMvtYCR3rkxYpUNjboMl6dEXvwHipaDrhl6mTa7UhkcwFdJtRyFIfStKA=='),('43c2f1d180cfa26539deb8b29e5426cd',1363345034,'ha7xTXQmntaYZT6OOCW+0KDNvw/1Aj6Z/pmFuzGc1burMhhka9kljP6XGAEiIWLKEuskPriFplysmJyKk8pkJqRmHMgCMQuQ0Vbp3BGlpfIDj7ZsEX5J/vJayMZ4VI+WGUSl8JqZ/gL+xfOYS4mKD6ZBEDGGeOBeuvClxJbj0G2b2FUuPTpzpRCL8oJAA5/ZB5uOyzcLtm9LtGDYvYYgFgASei57LehGgt9oBAZN8ehkzSOpA0gJI7Ig5vEF9HjM6MnPAMk+QmCs+wwKsRm+MyvT+6fbAY6X7a1jJ3TLkBN8glxAquq4zKfQohEoYsXbUOwnAe9NkoKP9TFViJajgUAIlV3juSUo66XRhQv4lRLh1i5cI+AY4PUKhDOAWfEAhhy8PmBa1bR+/J8L35JIU3EzOKWPEJPjC3HDx//W1v9yzEGLlwIVh1vzgd1dAqXy/6ZuNM/osg8XB3jhkCmkmDi7Fc31XWxc1czp0JkXLW6GhNQHd0IwJE+9IMBd'),('f880f93cd4861917be36fa3591b606d7',1363345583,'d7Dc5zGKRFzeemFqGJFsKwr5e0zPN9i/ikC6DupHXFyQvZ8BjOfaNTB709C+RUQrbSZ4oVIkIW5+/VSJPbt8bMSFGYR8FF9JcpaQy2h4+9yBwBQWBZeJ+FbXoIbMpDb2FpdsbCCuTKli5kAK8oP7oWuVf5CYkDiNQOCAiiEWobfGS3NSryjWHqYCU5hHvDACUqgY+WTkW/u3vK64rz1lh5r1Zo1XQXmSBk7Thk6axOGooa09gGhzO1+WkUxVozU61ebit2ujongtXAAbrxlFTLKCDvn/C20vE9qFyxBhdtu+8azh0n80JmKCcjcT9O0vSwo7Yd71hUOUjpHvBprJ67pPgCmMVx2k/O0P3WGMmqQOQxkqiGNhc1JP6T/d3hk3bh+4CVmLsXr6NZ5xC2f9+Syhmp2qtmCDmCVpuQD53Gxit4PPjjD5fV5rDgRuhNolN3FrpdTePZDjnKXfiDTvHPgE7PyGyWuQl0s0vR5VEcswoyjkwsFTMqX+g8Me+0/DCKR1UFi3IDX+LB8OTXS+VHPnKFnxqEWEPUT7R5Aq/azvWpVf2jFUt2Ot5rJP5x+onAOdy3ttTZLxTBn1Jsn0Gw=='),('d10b27c2dca24d21a1d798f3e1f7a098',1363345060,'KiZFSBiDdklBy0KCozS9cNiqZD4m+spBSn1Lq4ANhWIPbGvTjq/M/k0jEg45QTkYXy+3xm+Ub+Dxvskvt0ERSjb7mcruqQONRpFwF4vGD2XsTfhlbMcDJw2mWJ9VKJ+yFcd6ijkvp+Py/qPuuBQAds3+mPWTfCQdoVboZQ5YYqi2HDC/RxsMM2yprkRjXP5TScB6KVDuvkRUIQniYd8eeBXuMQeKPVcrZeF7bnt4ouT14tzEiY+3eF0wTqyev9TEjeFmK+k0c+IJraDtyWNAoSi0EUS49l0daoskWxhlvfU/F3wxebA20f+Zsa/BHv/Y6kLTvOMuyhw2DapTEXP6qpy9bu9tYnFXr8R+DW+WP2Bb1t8VW36DRRgbr163+XArYs3/6I5OBoKVV+Muqc412gMY89A0lyXwoTt68vZlgpis+Gxk44WuwbuWCnV1OcI/dbNmpomdTurcHAavN9iBN1lW6yzapOTimlUkvZ9hWhmjAy9FL3zmtLSZJ53ebCnRMAAlaZ5QqGRVwCpHr+XI7abgHKAuowBWZNm0g7g02NQzGZveODTrcFFHoBPWPXoZrspA'),('eaa3ae7276390f3bfda5338d011872b5',1363345133,'iK5v3wffpBOWBRecnOrNzrNl/JKbSdT+2ISwoOuaL4lrItBdowEe7GYgfpWR7Sn9cvt8nXie7bX1KBFGoVYkJ55k1phpV9R6+fXmok1FL6VWYPbf6d3Y1NLP6kJHL4okZHA9Y2ShWR8UJs+c6iRYWII7aIv526D11EcPz2rbsbsy8TND3MhWnacEmtwknT6PbiLqdNFasAfIsX30ZwXvrc77REDaM+zBf+/siQGUnXIp7Wechjx2zodLvAriGRhtQjSMbyZXeM5QYABrJzi+ZpffMOiSCIyQwZOPam0FqDab2pjZ+UPZzGnDN0KWxcjbMpnkrTwej10E415RQjgXHpdIPPnGdhLihQVOkObcsb5fUhZjfyBS9FcECfAUVp+nvk+WuCaliBe9wQ3pVZgUrc1hMh+we2Q='),('300eefa3adbeb1462f3ac7b4c588b20d',1363345155,'K5RrULleAz21/aqGYQZhh8gbgNaqb7UZ29CvuvJ2n6F4glXIAae0T+7xzTultZTaebDOplO3ffqY5EZ9WqwgVgPxTeigyZlNt8pXC6oSFZNZvkuaM8bMeZ6n3uMujCzOqCyd8ZI6GI54a+wKRRkORbmOHaF+IrJpiNEpQN9ohwnD/LWkECVkY7U+aQbnnEWd26Bb6JZJtsUuvPWnf5Uj6MLeJCaySkMWGq5eLwrYzN9QNxQbu0hiRQtbpRphN22HnqMpFMpH9RlamaoDndoCfs9qwpwqwTnxx66shYllmzyjV8ND'),('850e63f334abbac75d3d48f75b3f41bd',1363345237,'2N3M+4nB6/XuvZf9yRzXYQ7BDHTUn2j+GeoJzYQDHURhMfLhQtlznVDo8Ra5XobSyTcFffcUQ9gW+NiKenBJyZEODNDfstcVeq3g499f+1VrHOwhvcq/EwEJysjvYB0UjLI0YP2axy1s66G143jzHp7nljXn4022Ar+rNswYWyZa2W8ppKMQnSef0nsX2vWZkJ0b/Ud9QAOkrbir9S5bZuZeVWRp9j+YUv/t61cRfFsOf5yaBtQ9D0+BeW08XOtGX8lqPHowEcX73awRUH6GoM2dVes8r6JEu941H+hcJolbXmhZ4FzRu8RAMO0Vg/eHpjEWymsFDpCk+tl0MlB5lwlerAA+msprlClU0aYhwkcX3k0Rh8Ig7T3thKdUvP43RJ0IRsrpXp2uX3jC9JkgGJc='),('1fb3979a0106ebda1d1ebb6938a4db03',1363345355,'nmxoW9H6LD5z0mh4/EToHZfAuoI/+eNUi99ieteDUN2An90UMsQYbRcIcgAfE7GZvTCYhf5k5h/GUt5PaBQDmCDdfAFAKtogOGO+AC1A2GZbgkLTaoUhQUZSPUfT59HBKF3Xh5mRNr7Cli+m0gtjDvLv6IDYaP1+xEprN4STYb7JYxZGfoeWqNLunvRuyWUPpLRlQdFpqGFjtLkPPtB0LF0joPIxdi4figD2Tq9h9dcZ3ne2yWMK1vQxLgS/PP2nKHEiHEDxdCcGuij2pzGz71Jl6dTL0pZ25Q+HBcqsyHx5ArCBjgeTbXJRoqYFkefhP9FPxegE2UpKWeMelEIEzCaf6jH0h0HJgSOoiyt5BB5lVi78EDnNHI/yo8jUbUZawaMqupt+4jeGi15iNWY4u4rjiVvZ7kdKKQTMlxJ/cpvrbWeGrdHYWlUChiSf49/W/pFgdRZBbiZN7mQwojakJ3PrV0YG/pk886iBXUYw1hCvxMnVLB3FhQERCys/4ZbZMPODyX4bsocKCY7qEJN4HEMs35xMrmY='),('03e557974fc32de0c70e22abee015228',1363345675,'eme8/QFOvdr2Tj4whkQWt9FMUccKIv1+Tgb7M3Zhsv6ZXpaEngfWzelwPGJM/0E/zIw+mTQIgeSmzOH3lvNsqK4ApRuRAn2i68YD/+aFmJG5bO1gHu/Bve9b1drLYJuN6SzH8ie7TNiOFNhQ8ZwaV6a9oFPjCJ9mCRFgOP5SLxpNlYie5Pxoxl5Kv7jAjp/JfUovXrsOiHBc0bndZmlNDMxqI3Z/YYmj2WRD2DY0pi1Cg/M1gMcgCyEFSF86kYBfaU+F03MjciEf8pZRA2fRCfldSRuuknoOyMjUDiglh5R94A/o/1F/0OqjVVdVGD0+UltBNm6ppflGpXy2nrWmz711S9gj8enrhy/283JwLSrVWE2f2wl4LOkR0E1TVZazjuOaH10bjEtiEHz14HlPVpUlNOSFomekq7wzD6eAHCL7fCkX8+tE35DMOvCll+TmgRBMkGFZuZlv+GtoYNMrPrm+YFTYZsgV8EbIJOilpspnAxKti00cdWQcRtKHCo7OvqgNSrZ6a0Uv5CE6KeME4rgbcd/IZjhHehcRuIlL7TVYQLyg8EMttgeYhqI='),('5d31791a5c3fa7d1fbf92cfc88875630',1363345654,'pgrPsuhQq4Sr2GVrvo2xShSNLjgnlZhyS5iCxAn2ALW6UWHnRsssTVpn8crOULqYvKWUwfbPMfyP3Zk7sk/VGiqDc0j+wwAOW38PCfetqg6N4lFWINqkgQpI4vjadrUFkIq2UQETO7FCLM8gWdMm/UNTAQ3yixX1vras9WOc8qh/WFRAZdDaLVt7taNmDQe7S001otJBKxa0DCeQyLCwlVh5G4C8UNOiqhXBAkvGpRh+fH/8DSMi5h7Fbgr2Y2gafUfP9wyBnEMhI0SY859+Ws0eQKgLO5bI4i+LNt856DnwYzlfBRP8qbO9uNqjTE7mbEcMdqPbRROfVGgnORjsP2zD3ueZ5IaTAHqTmz9F4aZO6jhdD1OLonFUTudy4JgWwx3LuK9sySD/ApoAUZfa6qKbbiXZGfLb5XmoIZOvhD5hVnYY/mNnpHm4iQDNT2wza44+u6cOYwppBxRqs0vZQeQy2vEkIvfhs8Rkhg=='),('fc4e5c8ccca19986c94f78307490d761',1363345669,'mCBhkt1n5Y1GSct0mDgAu4KU2Qh8gYcEIUOn8eSnfHDFvu0Jdbz4ZZFsGH9dhagKCdIh/h54kHnsXEO08d5MbxzYkRFhhldiCc5Ts45UBnsbVtvhcxSY21hn9y4M6C6mvAeskJ2VVK/55Xc4UAuvray8PwcjwzXaxOma4nI+PJcp00nSc9YPTzNuEp4+gl5bHDsFJ9A7U3tgAKByJutskHQeUipil29V9oGvXAki4X8kXtrCwhqFmp9d30DKls8aqhjhPyc+ARWYcW9bmBf9tNTcyhGHq9REvVOHxOf2PxfHkinv/g4eAHijmhwqeo+iIJNau1LUPYJ/ezZEXTyWh96Te+zFHpeKo5ylHnjh4uB22XONmmdFK+7KD90c7Hd6LlqhzJR29BCi7COytntXFXSMt885DCzVRMhHvIu/lsNNEycVsJ/dfO6k5Nu+9i9l06WVFZU1Z1DvxlHBFAN9ZwreTJZyc1wV5B9jpD0bx54a');
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
INSERT INTO `settings` VALUES (1,'site_name','Jószolgálat.hu'),(2,'site_tagline','jót, jókor, jól'),(3,'site_banner_id','3'),(4,'site_email','info@joszolgalat.hu'),(5,'site_key',NULL),(6,'site_language','hu_HU'),(7,'site_style','unicorn'),(8,'site_timezone','0'),(9,'site_contact_page','1'),(10,'site_help_page','1'),(11,'site_message',''),(12,'site_copyright_statement',''),(13,'site_submit_report_message',''),(14,'allow_reports','1'),(15,'allow_comments','1'),(16,'allow_feed','1'),(17,'allow_stat_sharing','1'),(18,'allow_clustering','1'),(19,'cache_pages','0'),(20,'cache_pages_lifetime','1800'),(21,'private_deployment','0'),(22,'default_map','osm_mapnik'),(23,'default_map_all','CC0000'),(24,'default_map_all_icon_id',NULL),(25,'api_google',''),(26,'api_live','Apumcka0uPOF2lKLorq8aeo4nuqfVVeNRqJjqOcLMJ9iMCTsnMsNd9_OvpA8gR0i'),(27,'api_akismet',''),(28,'default_country','100'),(29,'multi_country','0'),(30,'default_city','nairobi'),(31,'default_lat','47.498868116865'),(32,'default_lon','19.044456481933'),(33,'default_zoom','8'),(34,'items_per_page','5'),(35,'items_per_page_admin','20'),(36,'sms_provider',''),(37,'sms_no1',NULL),(38,'sms_no2',NULL),(39,'sms_no3',NULL),(40,'google_analytics',''),(41,'twitter_hashtags',''),(42,'blocks','news_block|reports_block'),(43,'blocks_per_row','2'),(44,'date_modify','2013-03-15 10:55:06'),(45,'stat_id',NULL),(46,'stat_key',NULL),(47,'email_username','riasztas@joszolgalat.hu'),(48,'email_password','r14szt4s'),(49,'email_port','993'),(50,'email_host',''),(51,'email_servertype','imap'),(52,'email_ssl','1'),(53,'ftp_server',NULL),(54,'ftp_user_name',NULL),(55,'alerts_email','riasztas@joszolgalat.hu'),(56,'checkins','0'),(57,'facebook_appid',NULL),(58,'facebook_appsecret',NULL),(59,'db_version','97'),(60,'ushahidi_version','2.5'),(61,'allow_alerts','1'),(62,'require_email_confirmation','0'),(63,'manually_approve_users','0'),(64,'enable_timeline','0');
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores browser tokens assigned to users';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `user_tokens`
--

LOCK TABLES `user_tokens` WRITE;
/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
INSERT INTO `user_tokens` VALUES (1,1,'69a446b9a894d8042284af656d11e503abd87413','NALyD5QycdTMpT6oqmIfWk8o3MpNfUci',1363341774,1364551374),(2,2,'0577c057dca0867e18628f62654f56ed6d3d5f6c','qOOaVAyGS1mYcqPjpNyOZi6qsP9uHsHR',1363343782,1364553382),(3,1,'a6a09e95abdc56bc160ef56cb5bb72087c7baab7','yqtcSLIjST0DdLpCci0uB0cHw2x85FgU',1363345326,1364554926);
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
INSERT INTO `users` VALUES (1,'','Administrator','adminisztrator@joszolgalat.hu','admin','e4a2a574ae9f29f69f2f5bf4d0682e9cd684ef6af784ea1e45',2,1363345326,0,'2013-03-15 10:46:43','FF0000',NULL,1,0,1,0),(2,'','zuzmo','gabor.nagymajtenyi@gmail.com','593437438','d3241438eabf82f0fe2fc26e22677aedb5d35bd1f2d3e042e6',1,1363343782,0,'2013-03-15 10:20:59','FF0000',NULL,0,1,1,0),(3,'','kiazami','madarasz.csaba@gmail.com','863647461','68d25accaaa7c24c675283a710ec3a2b157788f91b23ce2360',0,NULL,0,'2013-03-15 10:40:24','FF0000',NULL,0,1,1,0);
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all verified reports';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `verified`
--

LOCK TABLES `verified` WRITE;
/*!40000 ALTER TABLE `verified` DISABLE KEYS */;
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

-- Dump completed on 2013-03-15 11:07:56
