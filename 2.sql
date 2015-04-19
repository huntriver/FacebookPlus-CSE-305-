-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: fb+
-- ------------------------------------------------------
-- Server version	5.6.23-log

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `Account_Number` int(11) NOT NULL DEFAULT '0',
  `Account_Creation_Date` datetime NOT NULL,
  `Credit_Card_Number` int(11) DEFAULT NULL,
  `Account_Status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Account_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addedto`
--

DROP TABLE IF EXISTS `addedto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addedto` (
  `User_Id` int(11) NOT NULL DEFAULT '0',
  `Circle_Id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`User_Id`,`Circle_Id`),
  KEY `Circle_Id` (`Circle_Id`),
  CONSTRAINT `addedto_ibfk_1` FOREIGN KEY (`User_Id`) REFERENCES `user` (`User_Id`),
  CONSTRAINT `addedto_ibfk_2` FOREIGN KEY (`Circle_Id`) REFERENCES `circle` (`Circle_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addedto`
--

LOCK TABLES `addedto` WRITE;
/*!40000 ALTER TABLE `addedto` DISABLE KEYS */;
/*!40000 ALTER TABLE `addedto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advertisement`
--

DROP TABLE IF EXISTS `advertisement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advertisement` (
  `Advertisement_Id` int(11) NOT NULL DEFAULT '0',
  `Employee` int(11) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Date` datetime NOT NULL,
  `Company` varchar(50) DEFAULT NULL,
  `Item_Name` varchar(50) DEFAULT NULL,
  `Content` varchar(50) DEFAULT NULL,
  `Unit_Price` int(11) DEFAULT NULL,
  `Availabe_Units` int(11) DEFAULT NULL,
  PRIMARY KEY (`Advertisement_Id`),
  KEY `Employee` (`Employee`),
  CONSTRAINT `advertisement_ibfk_1` FOREIGN KEY (`Employee`) REFERENCES `employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertisement`
--

LOCK TABLES `advertisement` WRITE;
/*!40000 ALTER TABLE `advertisement` DISABLE KEYS */;
/*!40000 ALTER TABLE `advertisement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circle`
--

DROP TABLE IF EXISTS `circle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circle` (
  `Circle_Id` int(11) NOT NULL DEFAULT '0',
  `Circle_NAME` varchar(100) DEFAULT NULL,
  `Owner_Of_Circle` int(11) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Circle_Id`),
  KEY `Owner_Of_Circle` (`Owner_Of_Circle`),
  CONSTRAINT `circle_ibfk_1` FOREIGN KEY (`Owner_Of_Circle`) REFERENCES `user` (`User_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `circle`
--

LOCK TABLES `circle` WRITE;
/*!40000 ALTER TABLE `circle` DISABLE KEYS */;
/*!40000 ALTER TABLE `circle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `Comment_Id` int(11) NOT NULL DEFAULT '0',
  `Date` datetime NOT NULL,
  `Content` varchar(50) DEFAULT NULL,
  `Post` int(11) DEFAULT NULL,
  `Author` int(11) DEFAULT NULL,
  PRIMARY KEY (`Comment_Id`),
  KEY `Post` (`Post`),
  KEY `Author` (`Author`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`Post`) REFERENCES `post` (`Post_Id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`Author`) REFERENCES `user` (`User_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `SSN` int(11) NOT NULL DEFAULT '0',
  `Start_Date` datetime NOT NULL,
  `Hourly_Rate` int(11) DEFAULT NULL,
  `Manager` int(11) DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  KEY `Manager` (`Manager`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`Manager`) REFERENCES `manager` (`SSN`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`SSN`) REFERENCES `person` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager` (
  `SSN` int(11) NOT NULL DEFAULT '0',
  `Start_Date` datetime NOT NULL,
  `Hourly_Rate` int(11) DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `person` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `Message_Id` int(11) NOT NULL DEFAULT '0',
  `Date` datetime NOT NULL,
  `Subject` varchar(50) DEFAULT NULL,
  `Content` varchar(1000) DEFAULT NULL,
  `Sender` int(11) DEFAULT NULL,
  `Receiver` int(11) DEFAULT NULL,
  PRIMARY KEY (`Message_Id`),
  KEY `Sender` (`Sender`),
  KEY `Receiver` (`Receiver`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`Sender`) REFERENCES `user` (`User_Id`),
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`Receiver`) REFERENCES `user` (`User_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owns`
--

DROP TABLE IF EXISTS `owns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `owns` (
  `User_Id` int(11) NOT NULL DEFAULT '0',
  `Circle_ID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`User_Id`,`Circle_ID`),
  KEY `Circle_ID` (`Circle_ID`),
  CONSTRAINT `owns_ibfk_1` FOREIGN KEY (`User_Id`) REFERENCES `user` (`User_Id`),
  CONSTRAINT `owns_ibfk_2` FOREIGN KEY (`Circle_ID`) REFERENCES `circle` (`Circle_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owns`
--

LOCK TABLES `owns` WRITE;
/*!40000 ALTER TABLE `owns` DISABLE KEYS */;
/*!40000 ALTER TABLE `owns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `SSN` int(11) NOT NULL DEFAULT '0',
  `Last_Name` varchar(50) DEFAULT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `Zip_Code` int(11) DEFAULT NULL,
  `Telephone` int(11) DEFAULT NULL,
  `Email_Address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `Post_Id` int(11) NOT NULL DEFAULT '0',
  `Date` datetime NOT NULL,
  `Content` varchar(50) DEFAULT NULL,
  `Comment_Count` int(11) DEFAULT NULL,
  `Circle` int(11) DEFAULT NULL,
  `Author` int(11) DEFAULT NULL,
  PRIMARY KEY (`Post_Id`),
  KEY `Circle` (`Circle`),
  KEY `Author` (`Author`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`Circle`) REFERENCES `circle` (`Circle_Id`),
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`Author`) REFERENCES `user` (`User_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase` (
  `Transaction_Id` int(11) NOT NULL DEFAULT '0',
  `Date` datetime NOT NULL,
  `Advertisement` int(11) DEFAULT NULL,
  `Number_Of_Units` int(11) DEFAULT NULL,
  `Account` int(11) DEFAULT NULL,
  `User` int(11) DEFAULT NULL,
  PRIMARY KEY (`Transaction_Id`),
  KEY `Advertisement` (`Advertisement`),
  KEY `User` (`User`,`Account`),
  CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`Advertisement`) REFERENCES `advertisement` (`Advertisement_Id`),
  CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`User`, `Account`) REFERENCES `user_has_account` (`User_Id`, `Account_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

LOCK TABLES `purchase` WRITE;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `SSN` int(11) DEFAULT NULL,
  `User_Id` int(11) NOT NULL DEFAULT '0',
  `Account_Creation_Date` datetime NOT NULL,
  `Rating` int(11) DEFAULT NULL,
  PRIMARY KEY (`User_Id`),
  KEY `SSN` (`SSN`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `person` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_account`
--

DROP TABLE IF EXISTS `user_has_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_account` (
  `User_Id` int(11) NOT NULL DEFAULT '0',
  `Account_Number` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`User_Id`,`Account_Number`),
  KEY `Account_Number` (`Account_Number`),
  CONSTRAINT `user_has_account_ibfk_1` FOREIGN KEY (`Account_Number`) REFERENCES `account` (`Account_Number`),
  CONSTRAINT `user_has_account_ibfk_2` FOREIGN KEY (`User_Id`) REFERENCES `user` (`User_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_account`
--

LOCK TABLES `user_has_account` WRITE;
/*!40000 ALTER TABLE `user_has_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_has_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_likes_comment`
--

DROP TABLE IF EXISTS `user_likes_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_likes_comment` (
  `User` int(11) NOT NULL DEFAULT '0',
  `Comment` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`User`,`Comment`),
  KEY `Comment` (`Comment`),
  CONSTRAINT `user_likes_comment_ibfk_1` FOREIGN KEY (`User`) REFERENCES `user` (`User_Id`),
  CONSTRAINT `user_likes_comment_ibfk_2` FOREIGN KEY (`Comment`) REFERENCES `comment` (`Comment_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_likes_comment`
--

LOCK TABLES `user_likes_comment` WRITE;
/*!40000 ALTER TABLE `user_likes_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_likes_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_likes_post`
--

DROP TABLE IF EXISTS `user_likes_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_likes_post` (
  `User` int(11) NOT NULL DEFAULT '0',
  `Post` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`User`,`Post`),
  KEY `Post` (`Post`),
  CONSTRAINT `user_likes_post_ibfk_1` FOREIGN KEY (`User`) REFERENCES `user` (`User_Id`),
  CONSTRAINT `user_likes_post_ibfk_2` FOREIGN KEY (`Post`) REFERENCES `post` (`Post_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_likes_post`
--

LOCK TABLES `user_likes_post` WRITE;
/*!40000 ALTER TABLE `user_likes_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_likes_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_preferences` (
  `Id` int(11) NOT NULL DEFAULT '0',
  `Preference` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`,`Preference`),
  CONSTRAINT `user_preferences_ibfk_1` FOREIGN KEY (`Id`) REFERENCES `user` (`User_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_preferences`
--

LOCK TABLES `user_preferences` WRITE;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` char(20) NOT NULL,
  `pwd` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'fb+'
--

--
-- Dumping routines for database 'fb+'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-18 20:01:51
