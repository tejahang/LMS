-- MySQL dump 10.13  Distrib 8.0.37, for Linux (x86_64)
--
-- Host: localhost    Database: LMS
-- ------------------------------------------------------
-- Server version	8.0.37-0ubuntu0.24.04.1

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
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Book` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(100) NOT NULL,
  `ISBN` varchar(13) NOT NULL,
  `genre` varchar(100) NOT NULL,
  `publication_year` year NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `ISBN` (`ISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book`
--

LOCK TABLES `Book` WRITE;
/*!40000 ALTER TABLE `Book` DISABLE KEYS */;
INSERT INTO `Book` VALUES (1,'Harry Potter and the Sorcerer\'s Stone','J.K. Rowling','9780747532743','Fantasy',1997),(2,'The Fellowship of the Ring','J.R.R. Tolkien','9780261102354','Fantasy',1954),(3,'A Game of Thrones','George R. R. Martin','9780553103540','Fantasy',1996),(4,'1984','George Orwell','9780451524935','Dystopian',1949),(5,'To Kill a Mockingbird','Harper Lee','9780060935467','Historical Fiction',1960),(6,'The Great Gatsby','F. Scott Fitzgerald','9780743273565','Literary Fiction',1925),(7,'Moby-Dick','Herman Melville','9780142437247','Adventure',1951),(8,'Pride and Prejudice','Jane Austen','9780679783268','Romance',1913),(9,'The Catcher in the Rye','J.D. Salinger','9780316769488','Literary Fiction',1951),(10,'Sherlock Holmes: The Complete Novels and Stories','Sir Arthur Conan Doyle','9780553212419','Mystery',1987);
/*!40000 ALTER TABLE `Book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Copy`
--

DROP TABLE IF EXISTS `Copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Copy` (
  `copy_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `availability_status` varchar(20) NOT NULL,
  PRIMARY KEY (`copy_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `Copy_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `Book` (`book_id`),
  CONSTRAINT `Copy_chk_1` CHECK ((`availability_status` in (_utf8mb4'Available',_utf8mb4'Not Available')))
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Copy`
--

LOCK TABLES `Copy` WRITE;
/*!40000 ALTER TABLE `Copy` DISABLE KEYS */;
INSERT INTO `Copy` VALUES (15,6,'Available'),(16,6,'Not Available'),(17,6,'Available'),(18,1,'Available'),(19,1,'Available'),(20,2,'Not Available'),(21,2,'Available'),(22,4,'Available'),(23,4,'Not Available'),(24,4,'Available'),(25,5,'Available'),(26,8,'Not Available'),(27,8,'Not Available'),(28,8,'Not Available');
/*!40000 ALTER TABLE `Copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fine`
--

DROP TABLE IF EXISTS `Fine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fine` (
  `fine_id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` varchar(10) NOT NULL,
  PRIMARY KEY (`fine_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `Fine_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `Loan` (`loan_id`),
  CONSTRAINT `Fine_chk_1` CHECK ((`amount` > 0)),
  CONSTRAINT `Fine_chk_2` CHECK ((`payment_status` in (_utf8mb4'Paid',_utf8mb4'Due')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fine`
--

LOCK TABLES `Fine` WRITE;
/*!40000 ALTER TABLE `Fine` DISABLE KEYS */;
INSERT INTO `Fine` VALUES (1,17,10.00,'Paid'),(2,18,5.00,'Due'),(3,19,20.00,'Due'),(4,20,15.00,'Due'),(5,21,30.23,'Due');
/*!40000 ALTER TABLE `Fine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Loan`
--

DROP TABLE IF EXISTS `Loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Loan` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `copy_id` int NOT NULL,
  `loan_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `return_date` date DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `member_id` (`member_id`),
  KEY `copy_id` (`copy_id`),
  CONSTRAINT `Loan_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`MemberID`),
  CONSTRAINT `Loan_ibfk_2` FOREIGN KEY (`copy_id`) REFERENCES `Copy` (`copy_id`),
  CONSTRAINT `chk_date_order` CHECK ((`return_date` >= `loan_date`))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Loan`
--

LOCK TABLES `Loan` WRITE;
/*!40000 ALTER TABLE `Loan` DISABLE KEYS */;
INSERT INTO `Loan` VALUES (15,4,20,'2024-06-19 00:54:00','2024-06-20'),(16,3,15,'2024-06-19 00:54:00','2024-06-20'),(17,5,17,'2024-06-19 00:54:00','2024-07-14'),(18,1,24,'2024-06-19 00:54:00','2024-06-20'),(19,6,26,'2024-06-19 00:54:00','2024-08-22'),(20,2,27,'2024-06-19 00:54:00','2024-07-27'),(21,7,28,'2024-06-19 00:54:00','2024-06-20');
/*!40000 ALTER TABLE `Loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Member`
--

DROP TABLE IF EXISTS `Member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Member` (
  `MemberID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(100) NOT NULL,
  `Last_Name` varchar(100) NOT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Membership_Type` varchar(50) NOT NULL,
  PRIMARY KEY (`MemberID`),
  KEY `Membership_Type` (`Membership_Type`),
  CONSTRAINT `Member_ibfk_1` FOREIGN KEY (`Membership_Type`) REFERENCES `Membership_Type` (`Membership_Type`),
  CONSTRAINT `chk_email_format` CHECK (regexp_like(`Email`,_utf8mb4'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$')),
  CONSTRAINT `chk_phone_number` CHECK ((`Phone_Number` like _utf8mb4'+44%'))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Member`
--

LOCK TABLES `Member` WRITE;
/*!40000 ALTER TABLE `Member` DISABLE KEYS */;
INSERT INTO `Member` VALUES (1,'John','Smith','+44 20 7946 0958','john.smith@example.com','Gold'),(2,'Jane','Doe','+44 7700 900002','jane.doe@example.com','Silver'),(3,'Alice','Johnson','+44 7700 900003','alice.johnson@example.com','Diamond'),(4,'Bob','Brown','+44 20 7946 0959','bob.brown@example.com','Gold'),(5,'Anil','Gurung','+44 7700 900005','anil.gurung@example.com','Silver'),(6,'Irina','Petrova','+44 20 7946 0960','irina.petrova@example.com','Diamond'),(7,'Ethan','White','+44 7700 900007','ethan.white@example.com','Gold');
/*!40000 ALTER TABLE `Member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Membership_Type`
--

DROP TABLE IF EXISTS `Membership_Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Membership_Type` (
  `Membership_Type` varchar(50) NOT NULL,
  `Membership_Fee` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Membership_Type`),
  CONSTRAINT `Membership_Type_chk_1` CHECK ((`Membership_Fee` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Membership_Type`
--

LOCK TABLES `Membership_Type` WRITE;
/*!40000 ALTER TABLE `Membership_Type` DISABLE KEYS */;
INSERT INTO `Membership_Type` VALUES ('Diamond',50.00),('Gold',25.00),('Silver',10.00);
/*!40000 ALTER TABLE `Membership_Type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reservation`
--

DROP TABLE IF EXISTS `Reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reservation` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `copy_id` int NOT NULL,
  `reservation_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reservation_status` varchar(100) NOT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `member_id` (`member_id`),
  KEY `copy_id` (`copy_id`),
  CONSTRAINT `Reservation_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `Member` (`MemberID`),
  CONSTRAINT `Reservation_ibfk_2` FOREIGN KEY (`copy_id`) REFERENCES `Copy` (`copy_id`),
  CONSTRAINT `Reservation_chk_1` CHECK ((`reservation_status` in (_utf8mb4'Active',_utf8mb4'Cancelled')))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reservation`
--

LOCK TABLES `Reservation` WRITE;
/*!40000 ALTER TABLE `Reservation` DISABLE KEYS */;
INSERT INTO `Reservation` VALUES (1,7,19,'2024-06-19 00:57:14','Active'),(2,3,25,'2024-06-19 00:57:14','Active'),(3,2,19,'2024-06-19 00:57:14','Cancelled'),(4,6,22,'2024-06-19 00:57:14','Active'),(5,4,26,'2024-06-19 00:57:14','Active'),(6,5,28,'2024-06-19 00:57:14','Active');
/*!40000 ALTER TABLE `Reservation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-19  1:17:44
