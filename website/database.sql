-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: santosj0
-- ------------------------------------------------------
-- Server version	5.7.24

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
-- Temporary table structure for view `all_profile_pictures`
--

DROP TABLE IF EXISTS `all_profile_pictures`;
/*!50001 DROP VIEW IF EXISTS `all_profile_pictures`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `all_profile_pictures` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `email`,
 1 AS `photo_id`,
 1 AS `file_path`,
 1 AS `profile_pic_id`,
 1 AS `is_active`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `commenter` varchar(45) NOT NULL,
  `photo` int(11) NOT NULL,
  `comment_text` varchar(255) NOT NULL,
  `comment_date` datetime NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `fk_photo_id_idx` (`photo`),
  CONSTRAINT `fk_comments_photo_id` FOREIGN KEY (`photo`) REFERENCES `photos` (`photo_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (8,'sith_lord',39,'Needs more lightsabers...','2019-11-30 11:55:44'),(11,'sith_lord',38,'The Car is still pretty!!!!','2019-11-30 12:11:54'),(22,'sith_lord',37,'Gregggggg!','2019-11-30 13:59:32'),(26,'sith_lord',33,'All hail darth vader!','2019-12-02 12:46:41'),(27,'zeta',33,'Obi wan kenobi for the win!','2019-12-02 12:47:03'),(28,'math',33,'Ashoka Tano is better!','2019-12-02 12:47:28'),(32,'[deleted]',38,'Yes. Yes it is','2019-12-02 20:25:57'),(33,'zeta',37,'test','2019-12-04 17:32:26'),(35,'zeta',35,'Yeah buddy!','2019-12-07 09:42:12'),(36,'[deleted]',49,'Needs more flowers','2019-12-07 14:42:46'),(39,'[deleted]',39,'comment is odne','2019-12-08 14:35:05'),(40,'math',49,'Look at that guy','2019-12-09 15:00:12'),(41,'hrs',62,'Why are we showing the description and not the title of each pic on the home page?','2019-12-09 15:49:06'),(42,'hrs',62,'Ok, I see what&#39;s happening.  The title is displayed on the enlarged view page.  I guess I&#39;ll accept that. :-)','2019-12-09 15:51:10'),(43,'hrs',62,'Watch your ass, young man!!','2019-12-09 15:51:36'),(45,'math',61,'No women!!!!','2019-12-09 16:46:13');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `comments_with_profile_picture`
--

DROP TABLE IF EXISTS `comments_with_profile_picture`;
/*!50001 DROP VIEW IF EXISTS `comments_with_profile_picture`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `comments_with_profile_picture` AS SELECT 
 1 AS `photo_id`,
 1 AS `comment_id`,
 1 AS `uploader`,
 1 AS `commenter`,
 1 AS `comment_text`,
 1 AS `comment_date`,
 1 AS `commenter_profile_pic`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `default_profile_pics`
--

DROP TABLE IF EXISTS `default_profile_pics`;
/*!50001 DROP VIEW IF EXISTS `default_profile_pics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `default_profile_pics` AS SELECT 
 1 AS `photo_id`,
 1 AS `file_path`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `login_register`
--

DROP TABLE IF EXISTS `login_register`;
/*!50001 DROP VIEW IF EXISTS `login_register`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `login_register` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `password`,
 1 AS `email`,
 1 AS `is_verified`,
 1 AS `verified_sent`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `photo_id` int(11) NOT NULL AUTO_INCREMENT,
  `pic_name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `upload_date` datetime NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploader` int(11) NOT NULL,
  `is_prof_pic` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `file_path_UNIQUE` (`file_path`),
  KEY `fk_users_photo_idx` (`uploader`),
  CONSTRAINT `fk_users_photo` FOREIGN KEY (`uploader`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,'profile pic',NULL,'2019-11-09 22:08:37','/defaults/default01.png',1,NULL),(2,'profile pic',NULL,'2019-11-09 22:21:53','/defaults/default02.png',1,NULL),(3,'profile pic',NULL,'2019-11-09 22:21:59','/defaults/default03.png',1,NULL),(4,'profile pic',NULL,'2019-11-09 22:22:05','/defaults/default04.png',1,NULL),(5,'profile pic',NULL,'2019-11-09 22:22:09','/defaults/default05.png',1,NULL),(6,'profile pic',NULL,'2019-11-09 22:22:12','/defaults/default06.png',1,NULL),(7,'profile pic',NULL,'2019-11-09 22:22:15','/defaults/default07.png',1,NULL),(8,'profile pic',NULL,'2019-11-09 22:22:18','/defaults/default08.png',1,NULL),(21,'C','Stuff C','2019-11-18 20:38:00','static/images/users/alpha/uploads/alpha_2019-11-18T203801_default08.png',27,NULL),(22,'Barry','Barry had a little lamb','2019-11-19 08:53:03','static/images/users/alpha/uploads/alpha_2019-11-19T085302_default06.png',27,NULL),(27,'profile pic','','2019-11-19 10:31:49','static/images/users/alpha/profile_pic/alpha_2019-11-19T103149_default05.png',27,NULL),(28,'profile pic','','2019-11-21 07:47:02','static/images/users/math/profile_pic/math_2019-11-21T074701_default06.png',37,NULL),(30,'profile pic','','2019-11-21 07:56:22','static/images/users/math/profile_pic/math_2019-11-21T075621_default01.png',37,NULL),(32,'Star Wars','Due to the mandalorian, I love this little guy.','2019-11-26 21:13:24','static/images/users/math/uploads/math_2019-11-26T211323_yodal.jpg',37,NULL),(33,'Darth Vader','This man brought balance to the force.','2019-11-26 21:39:30','static/images/users/sith_lord/uploads/sith_lord_2019-11-26T213929_darth.jpg',40,NULL),(34,'Star Wars Space Ships','Look at those space ships.','2019-11-26 21:46:22','static/images/users/sith_lord/uploads/sith_lord_2019-11-26T214622_space.jpg',40,NULL),(35,'&lt;h1&gt;All good!&lt;/h1&gt;','Hope your day goes well!','2019-11-27 10:07:08','static/images/users/sith_lord/uploads/sith_lord_2019-11-27T100707_thumbsup.gif',40,NULL),(36,'Gotta catch them all!','POKEMON! GOTTA CATCH THEM ALL!!!! THAT&#39;S THE REAL TEST!','2019-11-27 10:16:43','static/images/users/pokemon/uploads/pokemon_2019-11-27T101642_pokemon.jpg',49,NULL),(37,'Red Ball','Look at that red ball... You know... It makes you think.','2019-11-27 17:58:18','static/images/users/future/uploads/future_2019-11-27T175817_future.png',50,NULL),(38,'New Tesla Truck','Apparently the windshields are bullet proof...\r\n\r\nNOT!','2019-11-27 18:56:09','static/images/users/future/uploads/future_2019-11-27T185608_teslatruck.jpg',50,NULL),(39,'LETS GOOOO!','This is the army of a thousand!','2019-11-30 11:07:40','static/images/users/math/uploads/math_2019-11-30T110739_that_army.jpg',37,NULL),(44,'profile pic','','2019-12-04 18:26:14','static/images/users/xxxx/profile_pic/xxxx_2019-12-04T182613_gow.jpg',67,NULL),(45,'profile pic','','2019-12-04 18:28:10','static/images/users/xxxx/profile_pic/xxxx_2019-12-04T182809_candy.jpg',67,NULL),(47,'profile pic','','2019-12-04 18:33:14','static/images/users/xxxx/profile_pic/xxxx_2019-12-04T183313_darth.jpg',67,NULL),(49,'Elvis','Little penguin elvis!','2019-12-07 09:41:23','static/images/users/zeta/uploads/zeta_2019-12-07T094123_elvis.png',36,NULL),(59,'profile pic','','2019-12-08 14:54:16','static/images/users/math/profile_pic/math_2019-12-08T145416_fantasy-hd-wallpaper-80.jpg',37,NULL),(60,'Tranquility','My Backyard!','2019-12-09 15:45:14','static/images/users/hrs/uploads/hrs_2019-12-09T154512_vtRzA8.jpg',70,NULL),(61,'The answer is yes!  No matter the question!!','None needed.','2019-12-09 15:46:30','static/images/users/hrs/uploads/hrs_2019-12-09T154630_red.jpg',70,NULL),(62,'Home away from home','Fresh air is important','2019-12-09 15:47:28','static/images/users/hrs/uploads/hrs_2019-12-09T154728_Fantasy_wallpapers_49.jpg',70,NULL);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `photos_with_comments`
--

DROP TABLE IF EXISTS `photos_with_comments`;
/*!50001 DROP VIEW IF EXISTS `photos_with_comments`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `photos_with_comments` AS SELECT 
 1 AS `photo_id`,
 1 AS `pic_name`,
 1 AS `description`,
 1 AS `upload_date`,
 1 AS `file_path`,
 1 AS `uploader`,
 1 AS `comment_id`,
 1 AS `commenter`,
 1 AS `comment_text`,
 1 AS `comment_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `photos_with_tags`
--

DROP TABLE IF EXISTS `photos_with_tags`;
/*!50001 DROP VIEW IF EXISTS `photos_with_tags`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `photos_with_tags` AS SELECT 
 1 AS `photo_id`,
 1 AS `picture_name`,
 1 AS `description`,
 1 AS `upload_date`,
 1 AS `path`,
 1 AS `uploader`,
 1 AS `tags`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `profile_picture`
--

DROP TABLE IF EXISTS `profile_picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_picture` (
  `profile_pic_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  PRIMARY KEY (`profile_pic_id`),
  KEY `fk_profile_pic_photos_idx` (`photo_id`),
  KEY `fk_profile_pic_users_idx` (`user_id`),
  CONSTRAINT `fk_profile_pic_photos` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`photo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_profile_pic_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_picture`
--

LOCK TABLES `profile_picture` WRITE;
/*!40000 ALTER TABLE `profile_picture` DISABLE KEYS */;
INSERT INTO `profile_picture` VALUES (1,1,1,1),(2,1,2,0),(3,1,3,0),(4,1,4,1),(5,1,5,0),(6,1,6,0),(7,1,7,0),(8,1,8,0),(9,2,1,0),(10,2,2,0),(11,2,3,0),(12,2,4,0),(13,2,5,0),(14,2,6,0),(15,2,7,1),(16,2,8,0),(19,21,1,0),(20,21,2,0),(21,21,3,1),(22,21,4,0),(23,21,5,0),(24,21,6,0),(25,21,7,0),(26,21,8,0),(27,22,1,0),(28,22,2,1),(29,22,3,0),(30,22,4,0),(31,22,5,0),(32,22,6,0),(33,22,7,0),(34,22,8,0),(35,23,1,0),(36,23,2,0),(37,23,3,0),(38,23,4,0),(39,23,5,0),(40,23,6,0),(41,23,7,0),(42,23,8,1),(67,27,1,0),(68,27,2,0),(69,27,3,0),(70,27,4,0),(71,27,5,0),(72,27,6,0),(73,27,7,0),(74,27,8,0),(75,29,1,0),(76,29,2,0),(77,29,3,1),(78,29,4,0),(79,29,5,0),(80,29,6,0),(81,29,7,0),(82,29,8,0),(83,30,1,0),(84,30,2,0),(85,30,3,0),(86,30,4,0),(87,30,5,0),(88,30,6,0),(89,30,7,0),(90,30,8,1),(91,31,1,0),(92,31,2,0),(93,31,3,0),(94,31,4,0),(95,31,5,0),(96,31,6,0),(97,31,7,0),(98,31,8,1),(99,32,1,0),(100,32,2,1),(101,32,3,0),(102,32,4,0),(103,32,5,0),(104,32,6,0),(105,32,7,0),(106,32,8,0),(107,33,1,1),(108,33,2,0),(109,33,3,0),(110,33,4,0),(111,33,5,0),(112,33,6,0),(113,33,7,0),(114,33,8,0),(115,34,1,1),(116,34,2,0),(117,34,3,0),(118,34,4,0),(119,34,5,0),(120,34,6,0),(121,34,7,0),(122,34,8,0),(123,35,1,1),(124,35,2,0),(125,35,3,0),(126,35,4,0),(127,35,5,0),(128,35,6,0),(129,35,7,0),(130,35,8,0),(131,36,1,0),(132,36,2,0),(133,36,3,1),(134,36,4,0),(135,36,5,0),(136,36,6,0),(137,36,7,0),(138,36,8,0),(143,27,27,1),(144,37,1,0),(145,37,2,0),(146,37,3,0),(147,37,4,0),(148,37,5,0),(149,37,6,0),(150,37,7,0),(151,37,8,0),(152,37,28,0),(153,37,30,0),(154,38,1,0),(155,38,2,1),(156,38,3,0),(157,38,4,0),(158,38,5,0),(159,38,6,0),(160,38,7,0),(161,38,8,0),(162,39,1,0),(163,39,2,0),(164,39,3,0),(165,39,4,0),(166,39,5,1),(167,39,6,0),(168,39,7,0),(169,39,8,0),(170,40,1,0),(171,40,2,0),(172,40,3,0),(173,40,4,1),(174,40,5,0),(175,40,6,0),(176,40,7,0),(177,40,8,0),(186,42,1,0),(187,42,2,0),(188,42,3,0),(189,42,4,1),(190,42,5,0),(191,42,6,0),(192,42,7,0),(193,42,8,0),(194,47,1,0),(195,47,2,0),(196,47,3,0),(197,47,4,0),(198,47,5,0),(199,47,6,0),(200,47,7,0),(201,47,8,1),(202,48,1,0),(203,48,2,0),(204,48,3,1),(205,48,4,0),(206,48,5,0),(207,48,6,0),(208,48,7,0),(209,48,8,0),(210,49,1,1),(211,49,2,0),(212,49,3,0),(213,49,4,0),(214,49,5,0),(215,49,6,0),(216,49,7,0),(217,49,8,0),(218,50,1,0),(219,50,2,0),(220,50,3,1),(221,50,4,0),(222,50,5,0),(223,50,6,0),(224,50,7,0),(225,50,8,0),(226,51,1,1),(227,51,2,0),(228,51,3,0),(229,51,4,0),(230,51,5,0),(231,51,6,0),(232,51,7,0),(233,51,8,0),(234,53,1,1),(235,53,2,0),(236,53,3,0),(237,53,4,0),(238,53,5,0),(239,53,6,0),(240,53,7,0),(241,53,8,0),(243,59,1,0),(244,59,2,0),(245,59,3,0),(246,59,4,0),(247,59,5,0),(248,59,6,0),(249,59,7,0),(250,59,8,0),(251,61,1,0),(252,61,2,0),(253,61,3,0),(254,61,4,0),(255,61,5,0),(256,61,6,0),(257,61,7,0),(258,61,8,0),(259,62,1,0),(260,62,2,0),(261,62,3,0),(262,62,4,0),(263,62,5,0),(264,62,6,0),(265,62,7,0),(266,62,8,0),(267,63,1,0),(268,63,2,0),(269,63,3,0),(270,63,4,0),(271,63,5,0),(272,63,6,0),(273,63,7,0),(274,63,8,0),(275,64,1,0),(276,64,2,0),(277,64,3,0),(278,64,4,0),(279,64,5,0),(280,64,6,0),(281,64,7,0),(282,64,8,0),(283,65,1,0),(284,65,2,0),(285,65,3,0),(286,65,4,0),(287,65,5,0),(288,65,6,0),(289,65,7,0),(290,65,8,0),(299,67,1,0),(300,67,2,0),(301,67,3,0),(302,67,4,0),(303,67,5,0),(304,67,6,0),(305,67,7,0),(306,67,8,0),(307,67,44,0),(308,67,45,0),(310,67,47,1),(328,37,59,1),(329,70,1,0),(330,70,2,0),(331,70,3,0),(332,70,4,0),(333,70,5,0),(334,70,6,0),(335,70,7,1),(336,70,8,0),(337,71,1,0),(338,71,2,0),(339,71,3,1),(340,71,4,0),(341,71,5,0),(342,71,6,0),(343,71,7,0),(344,71,8,0);
/*!40000 ALTER TABLE `profile_picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(45) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `tag_name_UNIQUE` (`tag_name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (17,'&lt;h1&gt;robot&lt;/h1&gt;'),(4,'animal'),(2,'cartoon'),(12,'food'),(3,'gif'),(1,'landscape'),(13,'math'),(8,'movie'),(10,'photo'),(9,'png'),(5,'pony'),(16,'robot'),(6,'selfie'),(15,'space'),(14,'stars'),(11,'tea'),(18,'test comment 4');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_photos`
--

DROP TABLE IF EXISTS `tags_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags_photos` (
  `tags_photos_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL,
  PRIMARY KEY (`tags_photos_id`),
  KEY `fk_tag_id_idx` (`tag_id`),
  KEY `fk_photo_id_idx` (`photo_id`),
  CONSTRAINT `fk_photo_id` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`photo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_photos`
--

LOCK TABLES `tags_photos` WRITE;
/*!40000 ALTER TABLE `tags_photos` DISABLE KEYS */;
INSERT INTO `tags_photos` VALUES (1,2,1),(3,4,1),(4,5,1),(5,8,1),(6,1,1),(14,1,22);
/*!40000 ALTER TABLE `tags_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user_profile_pictures`
--

DROP TABLE IF EXISTS `user_profile_pictures`;
/*!50001 DROP VIEW IF EXISTS `user_profile_pictures`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `user_profile_pictures` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `email`,
 1 AS `photo_id`,
 1 AS `file_path`,
 1 AS `profile_pic_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(45) NOT NULL,
  `date_joined` datetime NOT NULL,
  `is_verified` tinyint(4) NOT NULL,
  `verified_sent` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','password','admin@admin.net','2019-11-09 21:27:53',0,'2019-11-09 21:27:53'),(2,'cake','password','cake@cake.net','2019-11-09 21:37:06',0,'2019-11-09 21:37:06'),(21,'john','password','john','2019-11-09 23:31:11',0,'2019-11-09 23:31:11'),(22,'fred','password','fred','2019-11-09 23:33:30',0,'2019-11-09 23:33:30'),(23,'george','password','george@george.net','2019-11-09 23:34:39',0,'2019-11-09 23:34:39'),(27,'alpha','$2b$12$1uN2rVN49rze/dE4zyWH8ezy0bLUeUaVc/3KUmGnyLY0T6ulLJzkG','photosharingrowanuniversity@gmail.com','2019-11-11 23:06:44',0,'2019-11-11 23:06:44'),(29,'beta','$2b$12$qYXFlkxs5KDeji8iv4DC5eLvJm3z/uNgjfWXDTEDPkgVZOgZO9qAu','photosharingrowanuniversity@gmail.com','2019-11-12 09:34:20',0,'2019-11-12 09:34:20'),(30,'gamma','$2b$12$33brv2CJeOQGgM.d.TsKyunqbnO3HLt.4rLZ4cVG0D7subSW2hv66','photosharingrowanuniversity@gmail.com','2019-11-12 09:35:22',0,'2019-11-12 09:35:22'),(31,'epsilon','$2b$12$g.1uiUFEt/J39P1mWnL0nuScmOMIMr7QYdBkCvMacSsCLwQi/8ofO','photosharingrowanuniversity@gmail.com','2019-11-12 10:51:38',0,'2019-11-12 10:51:38'),(32,'delta','$2b$12$W/j/UDzrCFxuClD6NIVCFeBLcnHQFue5TrlKtXSLBzeVRDbMr9BCm','photosharingrowanuniversity@gmail.com','2019-11-12 11:13:15',1,'2019-11-12 11:13:15'),(33,'greggy','$2b$12$XEhsExhMYHc5flHwexUyCOFnOl2UIEkNiJCTMhsdiu/WzO4s3hCBm','photosharingrowanuniversity@gmail.com','2019-11-13 08:09:01',1,'2019-11-13 08:09:01'),(34,'dalas','$2b$12$xDUCxEfPtrbDeuhqpAiZZ.B64UytMBFlohs4tbS84m99BgYsuzgDS','photosharingrowanuniversity@gmail.com','2019-11-13 08:10:19',1,'2019-11-13 08:10:19'),(35,'texas','$2b$12$mh.1vYu2cuYotjWjgN8mDeqnYiFf6iphqu8uYcd086QMfCtAX9v5.','photosharingrowanuniversity@gmail.com','2019-11-13 08:17:36',1,'2019-11-13 08:17:36'),(36,'zeta','$2b$12$FT4tp4ckPG4KyhjKoVMIIuY1F7vAcV1aHFRA6ClNLDu3VQTxryrU.','photosharingrowanuniversity@gmail.com','2019-11-18 17:50:29',1,'2019-11-18 17:50:29'),(37,'math','$2b$12$N6XM0YTJMB64WPGAe7rH8OHIVHu2gTJ81GKKdDpG/wO8per2.m4Cu','photosharingrowanuniversity@gmail.com','2019-11-21 07:45:07',1,'2019-11-21 07:45:07'),(38,'manga','$2b$12$9.nD5dZLTlq8NFzKzBDJAua5V5hpTucId7JCx0IWabZk3Yi4em77G','photosharingrowanuniversity@gmail.com','2019-11-24 15:17:01',1,'2019-11-24 15:17:01'),(39,'jedi','$2b$12$W3bglAG7ix63QbiJcl0FM.OcBpg/afvg9E1HOkEqfzoxYHFqoY6nm','photosharingrowanuniversity@gmail.com','2019-11-24 15:36:24',1,'2019-11-24 15:36:24'),(40,'sith_lord','$2b$12$dEaiYkxpIoFIAm3BXED6Fes5/Vux7KHoLwVTQsGsxS5DEtzmpzTEe','photosharingrowanuniversity@gmail.com','2019-11-24 15:52:11',1,'2019-11-24 15:52:11'),(42,'xbox','$2b$12$EyBdnQL0Vp5/wmDdZyHn3e8XxMKWvZEHwTjhME9RQPjNcCF0Tnzh.','photosharingrowanuniversity@gmail.com','2019-11-26 12:22:15',1,'2019-11-26 12:22:15'),(47,'3ds','$2b$12$iN.NNbdnQBnUuUjnhddpYep6WN4Nv065WYrnf7PJCcP/2/Ji088W6','photosharingrowanuniversity@gmail.com','2019-11-26 12:28:26',1,'2019-11-26 12:28:26'),(48,'controller','$2b$12$8c0EELrVsEV5I1GcqbtaBuIUeoGuUw4iVQ7rTDEzSEOLl12wTJ/OG','photosharingrowanuniversity@gmail.com','2019-11-26 12:34:23',1,'2019-11-26 12:34:23'),(49,'pokemon','$2b$12$SLFWMWesTYR./BYrbNjuYe.R65LgIi3FmnXSuJjAYjqoy18A5L9di','photosharingrowanuniversity@gmail.com','2019-11-27 10:15:03',1,'2019-11-27 10:15:03'),(50,'future','$2b$12$KrOD5cy9vJHATRe3OOv/1eiVSVa6BZUpxqURqoo1uHbtaKcxDqv1K','photosharingrowanuniversity@gmail.com','2019-11-27 17:56:23',1,'2019-11-27 17:56:23'),(51,'daguv','$2b$12$vpcqPWJoKhxJOZEM4Cugm.NfhQwdOoRuMijkzAnIHiUCDXjs7XU5G','urayz165@gmail.com','2019-11-30 08:18:52',0,'2019-11-30 08:18:52'),(53,'governor','$2b$12$OBHMOyvp2BMaQZ.yp61XTOkkAeQaFT6habeUmN4jMfzi1Br8xmGi6','photosharingrowanuniversity@gmail.com','2019-11-30 08:26:25',1,'2019-11-30 08:26:25'),(59,'Hera','$2b$12$Hh21wAKVdaW5YUMEZUoIP.GwQkRJshx3xd6tMyObHk5RP/5tvxvl6','h@x.com','2019-12-03 13:07:11',0,'2019-12-03 13:07:11'),(61,'howie','$2b$12$Qu.7u63RiyZwWihb/UyAb.V8758uasLBRP03HvLQEa1.IW1voOamW','santosj0@students.rowan.edu','2019-12-04 17:54:20',1,'2019-12-04 17:54:20'),(62,'test','$2b$12$F.QVjS7wIJHUPN7nTgaHhOxOe71DU3Jvj0QSKREOtuB1o4i.txvyW','santosj0@students.rowan.edu','2019-12-04 18:07:48',0,'2019-12-04 18:07:48'),(63,'test2','$2b$12$KK1wxg9dzfGqEI4kxUnhG.iKthPgzDSQ0acYD0K/CrQT5gmbQB2d.','santosj0@students.rowan.edu','2019-12-04 18:09:30',0,'2019-12-04 18:09:30'),(64,'jim','$2b$12$fNGvKbz9gW4wwpPTcVvEG.a0xsJ9XuZDYgD2iXygNzLDdKs7RzZv6','photosharingrowanuniversity@gmail.com','2019-12-04 18:13:42',1,'2019-12-04 18:13:42'),(65,'mmmm','$2b$12$cplSahrbbOSvcEAGI0N7te3bppRhg7wme/bRqueaBE.tuWzmSjKmG','photosharingrowanuniversity@gmail.com','2019-12-04 18:20:08',1,'2019-12-04 18:20:08'),(67,'xxxx','$2b$12$lxhujZ9ZzMcZoCo.94UwB.GNFGkP2Ii/zexWSLtRbFs2byD.eFMxi','photosharingrowanuniversity@gmail.com','2019-12-04 18:24:23',1,'2019-12-04 18:24:23'),(70,'hrs','$2b$12$pvmv7RW.KG6YxtS5Lk34PeHugmz2.1jErj.7hCUPDyO3P88mbbIiC','urayz165@gmail.com','2019-12-09 15:42:04',1,'2019-12-09 15:42:04'),(71,'ray','$2b$12$n0lpL2Ry940EEl1VFaFwAejNZR7hBy1dMXjhg7XddXO0jZU40OiS2','urayz165@gmail.com','2019-12-09 18:00:00',0,'2019-12-09 18:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `verified_users`
--

DROP TABLE IF EXISTS `verified_users`;
/*!50001 DROP VIEW IF EXISTS `verified_users`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `verified_users` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `email`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'santosj0'
--
/*!50003 DROP PROCEDURE IF EXISTS `App_Photos_AddTagToPhoto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Photos_AddTagToPhoto`(
	IN pid INT,
    IN tname VARCHAR(45)
)
BEGIN
	DECLARE texist TINYINT;
    DECLARE tid INT;
    DECLARE tnum INT;
    DECLARE confirmation VARCHAR(45);
    
    SET tname = LOWER(tname);
    
    -- Determine if tag exists
	SELECT COUNT(tag_name) INTO texist FROM tags WHERE tag_name = tname;

	-- Insert tag into table if it does not exist
	IF texist = 0 THEN
		INSERT INTO tags(tag_name) VALUES(tname);
        SET tid = LAST_INSERT_ID();
	ELSE
		SELECT tag_id INTO tid FROM tags WHERE tag_name = tname;
	END IF;
    
    -- Check to make sure that photo has only 5 tags set to it
	SELECT COUNT(tag_id) into tnum FROM tags_photos WHERE photo_id = pid;
    
    -- Check to make sure photo does not already have tag
    SELECT COUNT(tag_id) INTO texist FROM tags_photos WHERE tag_id = tid AND photo_id = pid;
    
    -- Photo Has tag
    IF texist = 1 THEN
		SET confirmation = "Photo already has tag";
	END IF;
    
    -- Photo has 5 tags
    IF tnum > 4 THEN
		SET confirmation = "Tag Limit Reached";
    END IF;
    
    -- Photo can add the tag
    IF tnum < 5 AND texist = 0 THEN
		INSERT INTO tags_photos(tag_id, photo_id) VALUES(tid, pid);
        SET confirmation = "Tag Added to Database";
    END IF;
		
	SELECT confirmation;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Photos_DeletePhoto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Photos_DeletePhoto`(
	IN uname VARCHAR(45),
    IN pid INT
)
BEGIN
	DECLARE u_exist INT;
    DECLARE p_exist INT;
    DECLARE confirmation VARCHAR(255);
    
    -- Determine if user exists
    SELECT COUNT(user_id) INTO u_exist FROM users WHERE username = uname;
    
    -- Determine if comment exists
    SELECT COUNT(photo_id) INTO p_exist FROM photos_with_tags WHERE photo_id = pid AND uploader = uname;
    
    -- Try to remove comment from database
    IF u_exist = 1 AND p_exist = 1 THEN
		SELECT path INTO confirmation FROM photos_with_tags WHERE photo_id = pid; 
		DELETE FROM photos WHERE photo_id = pid;
	ELSEIF u_exist != 1 THEN
		SET confirmation = "User does not exist";
	ELSE
		SET confirmation = "Photo does not exist/User is not uploader";
	END IF;
    
    SELECT confirmation;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Photos_InsertPhoto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Photos_InsertPhoto`(
 IN pname VARCHAR(45),
 IN dcript VARCHAR(255),
 IN fpath VARCHAR(255),
 IN uname VARCHAR(45)
)
BEGIN
    DECLARE uid INT;
    
    -- Get user's user_id
    SELECT user_id INTO uid FROM users WHERE username = uname;
    
    -- Insert new photo
    INSERT INTO photos(pic_name, description, upload_date, file_path, uploader) 
		VALUES(pname, dcript, NOW(), fpath, uid);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Photos_InsertTag` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Photos_InsertTag`(
	IN tname VARCHAR(45)
)
BEGIN
	-- Adds the new tag name
    INSERT INTO tags(tag_name) VALUES(tname);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_AddDefaultProfilePics` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_AddDefaultProfilePics`(
	IN uid INT
)
BEGIN
	DECLARE counter INT;
    SET counter = 1;
    
    counter_1_to_8: REPEAT
		INSERT INTO profile_picture(user_id, photo_id, is_active) VALUES(uid, counter, 0);
        SET counter = counter + 1;
	UNTIL counter > 8
    END REPEAT counter_1_to_8;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_CommentPhoto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_CommentPhoto`(
	IN uname VARCHAR(45),
    IN comtext VARCHAR(255),
    IN pid INT
)
BEGIN
	DECLARE u_exist INT;
    DECLARE p_exist INT;
    DECLARE confirmation VARCHAR(45);
    
    -- Determine if user exists
    SELECT COUNT(user_id) INTO u_exist FROM users WHERE username = uname;
    
    -- Determine if photo exists
    SELECT COUNT(photo_id) INTO p_exist FROM photos_with_tags WHERE photo_id = pid;
    
    -- Try to add comment to database
    IF u_exist = 1 AND p_exist = 1 THEN
		INSERT INTO comments(commenter, photo, comment_text, comment_date)
			VALUES(uname, pid, comtext, NOW());
		SET confirmation = "Comment Added";
	ELSEIF u_exist != 1 THEN
		SET confirmation = "User does not exist";
	ELSE
		SET confirmation = "Photo does not exist";
	END IF;
    
    -- Return result
    SELECT confirmation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_DeleteComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_DeleteComment`(
	IN uname VARCHAR(45),
    IN cid INT
)
BEGIN
	DECLARE u_exist INT;
    DECLARE c_exist INT;
    DECLARE confirmation VARCHAR(75);
    
    -- Determine if user exists
    SELECT COUNT(user_id) INTO u_exist FROM users WHERE username = uname;
    
    -- Determine if comment exists
    SELECT COUNT(comment_id) INTO c_exist FROM photos_with_comments WHERE comment_id = cid AND (commenter = uname OR uploader = uname);
    
    -- Try to remove comment from database
    IF u_exist = 1 AND c_exist = 1 THEN
		DELETE FROM comments WHERE comment_id = cid;
		SET confirmation = "Comment has been removed";
	ELSEIF u_exist != 1 THEN
		SET confirmation = "User does not exist";
	ELSE
		SET confirmation = "Comment does not exist/user neither commentor or uploader";
	END IF;
    
    SELECT confirmation;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_DeleteUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_DeleteUser`(
	IN uname VARCHAR(45)
)
BEGIN
	-- Turn off MySql Safe Mode for the following update statement
    SET SQL_SAFE_UPDATES = 0;

	-- Updates comments table with [deleted] commenter
    UPDATE comments SET commenter = "[deleted]" WHERE commenter = uname;
    
    -- Turn back on MySql Safe Mode
    SET SQL_SAFE_UPDATES = 1;
    
    -- Remove the user from the database
    DELETE FROM users WHERE username = uname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_InsertNewProfilePic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_InsertNewProfilePic`(
	IN fpath VARCHAR(255),
    IN uname VARCHAR(45)
)
BEGIN
	DECLARE newpid INT;
    DECLARE uid INT;
    
    -- Get user's user_id
    SELECT user_id INTO uid FROM users WHERE username = uname;
    
    
	-- Add new profile picture to photos
    INSERT INTO photos(pic_name, description, upload_date, file_path, uploader) 
		VALUES('profile pic', '', NOW(), fpath, uid);

	-- Retrieve new photo id
    SET newpid = LAST_INSERT_ID();

	-- Add photo to ProfilePic
    CALL `santosj0`.`App_Users_InsertProfilePic`(uid, newpid);
    
    -- Update profile picture
    CALL `santosj0`.`App_Users_RegisterProfilePic`(uid, newpid);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_InsertProfilePic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_InsertProfilePic`(
 IN uid INT,
 IN pid INT
)
BEGIN
	-- Add profile picture for user
	INSERT INTO profile_picture(user_id, photo_id, is_active) VALUES(uid, pid, 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_InsertUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_InsertUser`(
	IN uname VARCHAR(45), 
	IN pword VARCHAR(60), 
	IN eaddress VARCHAR(45),
	IN pic_num INT
)
BEGIN
	DECLARE confirmation TINYINT;
    DECLARE newuid INT;
    
	-- Exit if duplicate key occurs
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
		ROLLBACK;
        SET confirmation = 0;
        SELECT confirmation;
	END;
    
    -- Insert new user
    INSERT INTO users(username, password, email, date_joined, is_verified, verified_sent)
	VALUES(uname, pword, eaddress, NOW(), 0, NOW());
    
    -- Gets the new user id
    SET newuid = LAST_INSERT_ID();
    
    -- Insert default profile pics for user
    CALL `santosj0`.`App_Users_AddDefaultProfilePics`(newuid);
    
    -- Set Active Profile Pic
    CALL `santosj0`.`App_Users_RegisterProfilePic`(newuid, pic_num);
    
    -- Everything completed successfully
    SET confirmation = 1;
    
    -- Return response
    SELECT confirmation;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_RegisterProfilePic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_RegisterProfilePic`(
	IN uid INT,
    IN pid INT
)
BEGIN
	-- Update's current profile_picture to 0
	UPDATE profile_picture SET is_active = 0 WHERE user_id = uid AND is_active = 1;

	-- Update New Profile Picture
	UPDATE profile_picture SET is_active = 1 WHERE user_id = uid AND photo_id = pid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_ResetPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_ResetPassword`(
	IN uname VARCHAR(45),
    IN pword VARCHAR(60)
)
BEGIN
	DECLARE u_exist TINYINT;
    DECLARE confirmation VARCHAR(45);
    
	-- Verifies that user exist
    SELECT COUNT(user_id) INTO u_exist FROM users WHERE username = uname;
    
    IF u_exist = 1 THEN
		UPDATE users SET password = pword WHERE username = uname;
		SET confirmation = "Password Updated";
	ELSE
		SET confirmation = "User does not exist";
	END IF;
    
    SELECT confirmation;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_UpdateEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_UpdateEmail`(
	IN uname VARCHAR(45),
    IN n_email VARCHAR(45)
)
BEGIN
	DECLARE u_exist TINYINT;
    DECLARE confirmation VARCHAR(45);
    
    -- Makes sure user exist
    SELECT COUNT(user_id) INTO u_exist FROM users WHERE username = uname;
    
    IF u_exist = 1 THEN
		UPDATE users SET email = n_email WHERE username = uname;
        SET confirmation = "Email has been updated";
	ELSE
		SET confirmation = "User does not exist";
	END IF;
    
    SELECT confirmation;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_UpdateProfilePic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_UpdateProfilePic`(
	IN uname VARCHAR(45),
    IN prof_id INT
)
BEGIN
	DECLARE u_exist TINYINT;
    DECLARE p_exist TINYINT;
    DECLARE confirmation VARCHAR(45);
    DECLARE u_id INT;
	
    -- Check to make sure user exist
    SELECT COUNT(user_id) INTO u_exist FROM users WHERE username = uname;
    
    -- Check to make sure prof_id exist
    SELECT COUNT(profile_pic_id) INTO p_exist FROM profile_picture WHERE profile_pic_id = prof_id;
    
    -- Update profile picture table
    IF u_exist = 1 AND p_exist = 1 THEN
		-- Retrieve user_id
        SELECT user_id INTO u_id FROM users WHERE username = uname;
    
		-- Update's current profile_picture to 0
		UPDATE profile_picture SET is_active = 0 WHERE user_id = u_id AND is_active = 1;
        
		-- Update New Profile Picture
		UPDATE profile_picture SET is_active = 1 WHERE profile_pic_id = prof_id;
        
        SET confirmation = "Profile Picture Updated";
	ELSEIF u_exist = 0 THEN
		SET confirmation = "User does not exist";
	ELSE
		SET confirmation = "Profile Picture does not exist";
    END IF;
    
    SELECT confirmation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `App_Users_UpdateVerification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`santosj0`@`%` PROCEDURE `App_Users_UpdateVerification`(
	IN user VARCHAR(45)
)
exit_condition: BEGIN
	DECLARE verified TINYINT;
	-- Get user's verification
	SELECT is_verified INTO verified FROM login_register WHERE username = user;
    -- See if user is already verified
    IF verified = 1 THEN
		SELECT 'Already Verified';
        LEAVE exit_condition;
	END IF;
    -- If not verified, update his status
    UPDATE users SET is_verified = 1 WHERE username = user;
    -- Return the result
    SELECT 'Verified';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `all_profile_pictures`
--

/*!50001 DROP VIEW IF EXISTS `all_profile_pictures`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`santosj0`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `all_profile_pictures` AS select `u`.`user_id` AS `user_id`,`u`.`username` AS `username`,`u`.`email` AS `email`,`p`.`photo_id` AS `photo_id`,`p`.`file_path` AS `file_path`,`pp`.`profile_pic_id` AS `profile_pic_id`,`pp`.`is_active` AS `is_active` from ((`profile_picture` `pp` left join `users` `u` on((`pp`.`user_id` = `u`.`user_id`))) left join `photos` `p` on((`pp`.`photo_id` = `p`.`photo_id`))) where (`u`.`is_verified` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `comments_with_profile_picture`
--

/*!50001 DROP VIEW IF EXISTS `comments_with_profile_picture`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`santosj0`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `comments_with_profile_picture` AS select `pwc`.`photo_id` AS `photo_id`,`pwc`.`comment_id` AS `comment_id`,`pwc`.`uploader` AS `uploader`,`pwc`.`commenter` AS `commenter`,`pwc`.`comment_text` AS `comment_text`,`pwc`.`comment_date` AS `comment_date`,`p`.`file_path` AS `commenter_profile_pic` from (((`photos_with_comments` `pwc` left join `users` `u` on((`pwc`.`commenter` = `u`.`username`))) left join `profile_picture` `pp` on((`u`.`user_id` = `pp`.`user_id`))) left join `photos` `p` on((`pp`.`photo_id` = `p`.`photo_id`))) where (`pp`.`is_active` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `default_profile_pics`
--

/*!50001 DROP VIEW IF EXISTS `default_profile_pics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`santosj0`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `default_profile_pics` AS select `photos`.`photo_id` AS `photo_id`,`photos`.`file_path` AS `file_path` from `photos` where (`photos`.`photo_id` in (1,2,3,4,5,6,7,8)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `login_register`
--

/*!50001 DROP VIEW IF EXISTS `login_register`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`santosj0`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `login_register` AS select `users`.`user_id` AS `user_id`,`users`.`username` AS `username`,`users`.`password` AS `password`,`users`.`email` AS `email`,`users`.`is_verified` AS `is_verified`,`users`.`verified_sent` AS `verified_sent` from `users` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `photos_with_comments`
--

/*!50001 DROP VIEW IF EXISTS `photos_with_comments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`santosj0`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `photos_with_comments` AS select `p`.`photo_id` AS `photo_id`,`p`.`pic_name` AS `pic_name`,`p`.`description` AS `description`,`p`.`upload_date` AS `upload_date`,`p`.`file_path` AS `file_path`,`u`.`username` AS `uploader`,`c`.`comment_id` AS `comment_id`,`c`.`commenter` AS `commenter`,`c`.`comment_text` AS `comment_text`,`c`.`comment_date` AS `comment_date` from ((`photos` `p` join `users` `u` on((`u`.`user_id` = `p`.`uploader`))) join `comments` `c` on((`p`.`photo_id` = `c`.`photo`))) where (not(`p`.`photo_id` in (select distinct `pp`.`photo_id` from `profile_picture` `pp`))) order by `p`.`photo_id`,`c`.`comment_date` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `photos_with_tags`
--

/*!50001 DROP VIEW IF EXISTS `photos_with_tags`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`santosj0`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `photos_with_tags` AS select `p`.`photo_id` AS `photo_id`,`p`.`pic_name` AS `picture_name`,`p`.`description` AS `description`,`p`.`upload_date` AS `upload_date`,`p`.`file_path` AS `path`,`u`.`username` AS `uploader`,group_concat(`t`.`tag_name` separator ',') AS `tags` from (((`photos` `p` left join `tags_photos` `tp` on((`p`.`photo_id` = `tp`.`photo_id`))) left join `users` `u` on((`u`.`user_id` = `p`.`uploader`))) left join `tags` `t` on((`tp`.`tag_id` = `t`.`tag_id`))) where (not(`p`.`photo_id` in (select distinct `pp`.`photo_id` from `profile_picture` `pp`))) group by `p`.`photo_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_profile_pictures`
--

/*!50001 DROP VIEW IF EXISTS `user_profile_pictures`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`santosj0`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `user_profile_pictures` AS select `u`.`user_id` AS `user_id`,`u`.`username` AS `username`,`u`.`email` AS `email`,`p`.`photo_id` AS `photo_id`,`p`.`file_path` AS `file_path`,`pp`.`profile_pic_id` AS `profile_pic_id` from ((`profile_picture` `pp` join `users` `u` on((`pp`.`user_id` = `u`.`user_id`))) join `photos` `p` on((`pp`.`photo_id` = `p`.`photo_id`))) where ((`pp`.`is_active` = 1) and (`u`.`is_verified` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `verified_users`
--

/*!50001 DROP VIEW IF EXISTS `verified_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`santosj0`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `verified_users` AS select `login_register`.`user_id` AS `user_id`,`login_register`.`username` AS `username`,`login_register`.`email` AS `email` from `login_register` where (`login_register`.`is_verified` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-11 11:37:39
