CREATE DATABASE  IF NOT EXISTS `pamperspa_dw` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pamperspa_dw`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pamperspa_dw
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `calendar_dim`
--

DROP TABLE IF EXISTS `calendar_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_dim` (
  `Calendar Key` int DEFAULT NULL,
  `FullDate` datetime DEFAULT NULL,
  `Month` varchar(30) DEFAULT NULL,
  `Dayoftheweek` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Quarter` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Weekday` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_dim`
--

LOCK TABLES `calendar_dim` WRITE;
/*!40000 ALTER TABLE `calendar_dim` DISABLE KEYS */;
INSERT INTO `calendar_dim` VALUES (1,'2018-01-01 00:00:00','January','Monday','1','Yes'),(2,'2018-01-02 00:00:00','January','Tuesday','1','Yes'),(3,'2018-01-03 00:00:00','January','Wednesday','1','Yes'),(4,'2018-01-04 00:00:00','January','Thursday','1','Yes'),(5,'2018-01-05 00:00:00','January','Friday','1','Yes'),(6,'2018-01-13 00:00:00','January','Saturday','1','No'),(7,'2018-02-24 00:00:00','February','Saturday','1','No'),(8,'2018-03-03 00:00:00','March','Saturday','1','No'),(9,'2018-03-14 00:00:00','March','Wednesday','1','Yes'),(10,'2018-03-15 00:00:00','March','Thursday','1','Yes'),(11,'2018-03-18 00:00:00','March','Sunday','1','No'),(12,'2018-03-21 00:00:00','March','Wednesday','1','Yes'),(13,'2018-04-24 00:00:00','April','Tuesday','2','Yes'),(14,'2018-04-29 00:00:00','April','Sunday','2','No'),(15,'2018-05-16 00:00:00','May','Wednesday','2','Yes'),(16,'2018-05-30 00:00:00','May','Wednesday','2','Yes'),(17,'2018-06-13 00:00:00','June','Wednesday','2','Yes'),(18,'2018-06-28 00:00:00','June','Thursday','2','Yes'),(19,'2018-07-14 00:00:00','July','Saturday','3','No'),(20,'2018-07-15 00:00:00','July','Sunday','3','No'),(21,'2018-07-19 00:00:00','July','Thursday','3','Yes'),(22,'2018-07-27 00:00:00','July','Friday','3','Yes'),(23,'2018-08-09 00:00:00','August','Thursday','3','Yes'),(24,'2018-08-28 00:00:00','August','Tuesday','3','Yes'),(25,'2018-09-24 00:00:00','September','Monday','3','Yes'),(26,'2018-10-06 00:00:00','October','Saturday','4','No'),(27,'2018-10-24 00:00:00','October','Wednesday','4','Yes'),(28,'2018-10-27 00:00:00','October','Saturday','4','No'),(29,'2018-11-01 00:00:00','November','Thursday','4','Yes'),(30,'2018-11-03 00:00:00','November','Saturday','4','No'),(31,'2018-11-10 00:00:00','November','Saturday','4','No'),(32,'2018-11-22 00:00:00','November','Thursday','4','Yes'),(33,'2018-12-23 00:00:00','December','Sunday','4','No'),(34,'2018-12-24 00:00:00','December','Monday','4','Yes'),(35,'2018-12-30 00:00:00','December','Sunday','4','No');
/*!40000 ALTER TABLE `calendar_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_employee`
--

DROP TABLE IF EXISTS `dim_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_employee` (
  `Employee_Key` int DEFAULT NULL,
  `Employee_Name` varchar(45) DEFAULT NULL,
  `Employee_Yearofhire` char(4) DEFAULT NULL,
  `Employee_ID` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_employee`
--

LOCK TABLES `dim_employee` WRITE;
/*!40000 ALTER TABLE `dim_employee` DISABLE KEYS */;
INSERT INTO `dim_employee` VALUES (1,'Claire','2000','SE1'),(2,'Jamie','2008','SE2'),(3,'Laura','2010','SE3'),(4,'Tom','2015','SE4'),(5,'Andrew','2018','SE5');
/*!40000 ALTER TABLE `dim_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_patron`
--

DROP TABLE IF EXISTS `dim_patron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_patron` (
  `PatronKey` int NOT NULL,
  `PatronID` char(4) DEFAULT NULL,
  `PatronZip` varchar(45) DEFAULT NULL,
  `PatronSex` varchar(10) DEFAULT NULL,
  `PatronTitle` varchar(50) DEFAULT NULL,
  `PatronAge` double DEFAULT NULL,
  `PatronEthnicity` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`PatronKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_patron`
--

LOCK TABLES `dim_patron` WRITE;
/*!40000 ALTER TABLE `dim_patron` DISABLE KEYS */;
INSERT INTO `dim_patron` VALUES (1,'PT1','23185','Female','Mrs',41,'Black Hispanic'),(2,'PT10','23185','Female','Mrs',38,'White Hispanic'),(3,'PT11','23139','Male','Honorable',39,'Black'),(4,'PT12','23146','Female','Mrs',41,'Asian'),(5,'PT13','23147','Male','Ms',40,'Black'),(6,'PT14','22031','Male','Rev',63,'Black'),(7,'PT15','23185','Female','Rev',43,'Black Hispanic'),(8,'PT16','23139','Male','Rev',58,'Black Hispanic'),(9,'PT17','23146','Female','Mrs',53,'Mixed'),(10,'PT18','23147','Male','Dr',32,'Black'),(11,'PT19','22031','Female','Mr',61,'Black Hispanic'),(12,'PT2','23185','Female','Dr',61,'White Hispanic'),(13,'PT20','23185','Male','Mr',20,'White'),(14,'PT21','23139','Female','Rev',40,'Black'),(15,'PT22','23146','Male','Mr',29,'Mixed'),(16,'PT23','23147','Male','Mr',47,'Asian'),(17,'PT24','22031','Male','Mr',54,'Black'),(18,'PT25','23185','Female','Honorable',38,'Black Hispanic'),(19,'PT26','23139','Female','Mrs',64,'White'),(20,'PT27','23146','Female','Mr',62,'White'),(21,'PT3','23185','Female','Mrs',30,'Mixed'),(22,'PT4','60650','Female','Mrs',51,'White Hispanic'),(23,'PT5','23185','Female','Mrs',30,'White'),(24,'PT6','23139','Female','Mrs',37,'White Hispanic'),(25,'PT7','23146','Female','Mrs',28,'Black Hispanic'),(26,'PT8','23147','Female','Dr',60,'White'),(27,'PT9','22031','Male','Mr',42,'NA');
/*!40000 ALTER TABLE `dim_patron` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_procedure`
--

DROP TABLE IF EXISTS `dim_procedure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_procedure` (
  `ProcedureKey` int NOT NULL,
  `ProcedureName` varchar(45) DEFAULT NULL,
  `ProcedureID` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`ProcedureKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_procedure`
--

LOCK TABLES `dim_procedure` WRITE;
/*!40000 ALTER TABLE `dim_procedure` DISABLE KEYS */;
INSERT INTO `dim_procedure` VALUES (1,'Botox','PR1'),(2,'Facial','PR2'),(3,'Mani','PR3'),(4,'Massage','PR4'),(5,'Pedi','PR5');
/*!40000 ALTER TABLE `dim_procedure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_time`
--

DROP TABLE IF EXISTS `dim_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_time` (
  `TimeKey` int NOT NULL,
  `PartOfDay` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`TimeKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_time`
--

LOCK TABLES `dim_time` WRITE;
/*!40000 ALTER TABLE `dim_time` DISABLE KEYS */;
INSERT INTO `dim_time` VALUES (1,'10:30 AM'),(2,'10:40 AM'),(3,'11:09 AM'),(4,'11:38 AM'),(5,'11:50 AM'),(6,'12:05 PM'),(7,'12:19 PM'),(8,'12:22 PM'),(9,'12:40 PM'),(10,'12:46 PM'),(11,'12:56 PM'),(12,'1:30 PM'),(13,'1:33 PM'),(14,'1:36 PM'),(15,'1:58 PM'),(16,'1:59 PM'),(17,'2:10 PM'),(18,'2:33 PM'),(19,'2:46 PM'),(20,'2:51 PM'),(21,'3:31 PM'),(22,'3:38 PM'),(23,'3:48 PM'),(24,'3:57 PM'),(25,'4:20 PM'),(26,'4:40 PM'),(27,'4:41 PM'),(28,'8:00 AM'),(29,'8:05 AM'),(30,'8:13 AM'),(31,'8:14 AM'),(32,'8:26 AM'),(33,'8:29 AM'),(34,'8:30 AM'),(35,'8:57 AM'),(36,'9:13 AM');
/*!40000 ALTER TABLE `dim_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pamperspa_facttable`
--

DROP TABLE IF EXISTS `pamperspa_facttable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pamperspa_facttable` (
  `AmountCharged` int DEFAULT NULL,
  `PatronKey` int DEFAULT NULL,
  `Employee_Key` int DEFAULT NULL,
  `ProcedureKey` int DEFAULT NULL,
  `Calendar Key` int DEFAULT NULL,
  `TimeKey` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pamperspa_facttable`
--

LOCK TABLES `pamperspa_facttable` WRITE;
/*!40000 ALTER TABLE `pamperspa_facttable` DISABLE KEYS */;
INSERT INTO `pamperspa_facttable` VALUES (20,7,2,2,5,1),(100,7,2,3,5,1),(200,7,2,4,5,1),(13,6,4,1,15,2),(200,6,4,4,15,2),(50,6,4,5,15,2),(10,15,4,1,16,3),(20,15,4,2,16,3),(100,15,4,3,16,3),(100,25,2,3,28,4),(200,25,2,4,28,4),(50,25,2,5,28,4),(10,8,3,1,32,5),(20,8,3,2,32,5),(50,8,3,5,32,5),(110,26,5,3,12,6),(215,26,5,4,12,6),(65,26,5,5,12,6),(10,20,4,1,13,7),(20,20,4,2,13,7),(100,20,4,3,13,7),(100,14,3,3,26,8),(200,14,3,4,26,8),(50,14,3,5,26,8),(10,13,2,1,22,9),(20,13,2,2,22,9),(50,13,2,5,22,9),(10,3,1,1,34,10),(20,3,1,2,34,10),(50,3,1,5,34,10),(13,23,2,1,11,11),(215,23,2,4,11,11),(65,23,2,5,11,11),(100,4,2,3,30,12),(200,4,2,4,30,12),(50,4,2,5,30,12),(20,17,1,2,29,13),(100,17,1,3,29,13),(200,17,1,4,29,13),(110,8,1,3,33,13),(215,8,1,4,33,13),(65,8,1,5,33,13),(10,10,5,1,31,14),(20,10,5,2,31,14),(100,10,5,3,31,14),(100,19,3,3,10,15),(200,19,3,4,10,15),(50,19,3,5,10,15),(10,3,3,1,19,16),(20,3,3,2,19,16),(50,3,3,5,19,16),(10,5,5,1,17,17),(20,5,5,2,17,17),(100,5,5,3,17,17),(10,27,4,1,20,18),(200,27,4,4,20,18),(50,27,4,5,20,18),(10,18,2,1,7,19),(20,18,2,2,7,19),(50,18,2,5,7,19),(10,26,3,1,33,20),(20,26,3,2,33,20),(100,26,3,3,33,20),(10,16,5,1,35,21),(200,16,5,4,35,21),(50,16,5,5,35,21),(20,2,2,2,27,22),(100,2,2,3,27,22),(200,2,2,4,27,22),(20,2,5,2,25,23),(100,2,5,3,25,23),(200,2,5,4,25,23),(23,7,5,2,18,24),(110,7,5,3,18,24),(215,7,5,4,18,24),(10,23,5,1,9,25),(200,23,5,4,9,25),(50,23,5,5,9,25),(10,24,1,1,6,26),(20,24,1,2,6,26),(50,24,1,5,6,26),(10,27,1,1,21,27),(200,27,1,4,21,27),(50,27,1,5,21,27),(10,1,1,1,1,28),(20,1,1,2,1,28),(100,1,1,3,1,28),(13,1,2,1,3,28),(23,1,2,2,3,28),(65,1,2,5,3,28),(13,22,1,1,4,28),(23,22,1,2,4,28),(110,22,1,3,4,28),(13,25,4,1,8,29),(23,25,4,2,8,29),(65,25,4,5,8,29),(23,24,3,2,24,30),(110,24,3,3,24,30),(215,24,3,4,24,30),(100,4,4,3,28,31),(200,4,4,4,28,31),(50,4,4,5,28,31),(100,9,4,3,23,32),(200,9,4,4,23,32),(50,9,4,5,23,32),(10,6,1,1,14,33),(200,6,1,4,14,33),(50,6,1,5,14,33),(10,12,2,1,2,34),(200,12,2,4,2,34),(50,12,2,5,2,34),(20,21,1,2,3,34),(100,21,1,3,3,34),(200,21,1,4,3,34),(20,11,1,2,29,35),(100,11,1,3,29,35),(200,11,1,4,29,35),(10,5,3,1,26,36),(20,5,3,2,26,36),(100,5,3,3,26,36);
/*!40000 ALTER TABLE `pamperspa_facttable` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-02 19:00:13
