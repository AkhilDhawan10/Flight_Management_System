CREATE DATABASE  IF NOT EXISTS `project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `project`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `Airport_ID` int NOT NULL,
  `AirportName` varchar(100) DEFAULT NULL,
  `AirportCity` varchar(100) DEFAULT NULL,
  `AirportCountry` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Airport_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar` (
  `Day_Date` date NOT NULL,
  `Business_Day_YN` char(1) DEFAULT NULL,
  PRIMARY KEY (`Day_Date`),
  CONSTRAINT `check_character_Business_Day_YN` CHECK ((`Business_Day_YN` in (_cp850'Y',_cp850'N')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar`
--

LOCK TABLES `calendar` WRITE;
/*!40000 ALTER TABLE `calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_details`
--

DROP TABLE IF EXISTS `flight_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_details` (
  `Flight_ID` int NOT NULL,
  `Source_Airport_ID` int NOT NULL,
  `Destination_Airport_ID` int NOT NULL,
  `Departure_Date_Time` datetime DEFAULT NULL,
  `Arrival_Date_time` datetime DEFAULT NULL,
  `Airplane_Type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Flight_ID`),
  KEY `Flight_Details_Source_FK1` (`Source_Airport_ID`),
  KEY `Flight_Details_Destination_FK2` (`Destination_Airport_ID`),
  CONSTRAINT `Flight_Details_Destination_FK2` FOREIGN KEY (`Destination_Airport_ID`) REFERENCES `airport` (`Airport_ID`),
  CONSTRAINT `Flight_Details_Source_FK1` FOREIGN KEY (`Source_Airport_ID`) REFERENCES `airport` (`Airport_ID`),
  CONSTRAINT `airplane_check` CHECK ((`Airplane_Type` in (_cp850'Airbus A380',_cp850'Boeing 747'))),
  CONSTRAINT `airport_chk` CHECK ((`Source_Airport_ID` <> `Destination_Airport_ID`)),
  CONSTRAINT `Date_check_FD` CHECK ((`Departure_Date_Time` < `Arrival_Date_Time`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_details`
--

LOCK TABLES `flight_details` WRITE;
/*!40000 ALTER TABLE `flight_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `flight_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_service`
--

DROP TABLE IF EXISTS `flight_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_service` (
  `Service_ID` int NOT NULL,
  `Service_Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Service_ID`),
  CONSTRAINT `Service_chk` CHECK ((`Service_Name` in (_cp850'Food',_cp850'French Wine',_cp850'Wifi',_cp850'Entertainment',_cp850'Lounge')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_service`
--

LOCK TABLES `flight_service` WRITE;
/*!40000 ALTER TABLE `flight_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `flight_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `Passenger_ID` int NOT NULL,
  `P_FirstName` varchar(100) DEFAULT NULL,
  `P_LastName` varchar(100) DEFAULT NULL,
  `P_Email` varchar(100) DEFAULT NULL,
  `P_PhoneNumber` bigint NOT NULL,
  `P_Address` varchar(100) DEFAULT NULL,
  `P_City` varchar(100) DEFAULT NULL,
  `P_State` varchar(100) DEFAULT NULL,
  `P_Zipcode` varchar(5) DEFAULT NULL,
  `P_Country` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Passenger_ID`),
  CONSTRAINT `email_check` CHECK (regexp_like(`P_Email`,_cp850'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$')),
  CONSTRAINT `Ph_length_check` CHECK ((char_length(`P_PhoneNumber`) = 10)),
  CONSTRAINT `zip_chk` CHECK ((char_length(`P_Zipcode`) = 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat_details`
--

DROP TABLE IF EXISTS `seat_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat_details` (
  `Seat_ID` varchar(100) NOT NULL,
  `Travel_Class_ID` int NOT NULL,
  `Flight_ID` int NOT NULL,
  PRIMARY KEY (`Seat_ID`),
  KEY `Seat_Details_TravelClassID_FK1` (`Travel_Class_ID`),
  KEY `Seat_Details_FlightID_FK2` (`Flight_ID`),
  CONSTRAINT `Seat_Details_FlightID_FK2` FOREIGN KEY (`Flight_ID`) REFERENCES `flight_details` (`Flight_ID`),
  CONSTRAINT `Seat_Details_TravelClassID_FK1` FOREIGN KEY (`Travel_Class_ID`) REFERENCES `travel_class` (`Travel_Class_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_details`
--

LOCK TABLES `seat_details` WRITE;
/*!40000 ALTER TABLE `seat_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `travel_class`
--

DROP TABLE IF EXISTS `travel_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `travel_class` (
  `Travel_Class_ID` int NOT NULL,
  `Travel_Class_Name` varchar(100) DEFAULT NULL,
  `Travel_Class_Capacity` bigint DEFAULT NULL,
  PRIMARY KEY (`Travel_Class_ID`),
  CONSTRAINT `name_list_chk` CHECK ((`Travel_Class_Name` in (_cp850'First Class',_cp850'Business Class',_cp850'Premium Economy',_cp850'Economy Class',_cp850'Basic Economy')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `travel_class`
--

LOCK TABLES `travel_class` WRITE;
/*!40000 ALTER TABLE `travel_class` DISABLE KEYS */;
/*!40000 ALTER TABLE `travel_class` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-24  9:43:52
