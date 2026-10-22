-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: quizz
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Current Database: `quizz`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `quizz` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `quizz`;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `options` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `option_text` varchar(200) NOT NULL,
  `correct_answer` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `options`
--

LOCK TABLES `options` WRITE;
/*!40000 ALTER TABLE `options` DISABLE KEYS */;
INSERT INTO `options` VALUES (1,1,'O(n)',0),(2,1,'O(log n)',1),(3,1,'O(n log n)',0),(4,1,'O(1)',0),(5,2,'Queue',0),(6,2,'Stack',1),(7,2,'Tree',0),(8,2,'Graph',0),(9,3,'Stack',0),(10,3,'Queue',1),(11,3,'Heap',0),(12,3,'Tree',0),(13,4,'O(n log n)',0),(14,4,'O(log n)',0),(15,4,'O(n^2)',1),(16,4,'O(1)',0),(17,5,'Preorder',0),(18,5,'Postorder',0),(19,5,'Inorder',1),(20,5,'Level order',0),(21,6,'Stack',0),(22,6,'Queue',1),(23,6,'Binary Search Tree',0),(24,6,'Hash Table',0),(25,7,'O(n)',0),(26,7,'O(log n)',0),(27,7,'O(1)',1),(28,7,'O(n log n)',0),(29,8,'Prim\'s Algorithm',0),(30,8,'Dijkstra\'s Algorithm',1),(31,8,'Kruskal\'s Algorithm',0),(32,8,'Binary Search',0),(33,9,'Queue',0),(34,9,'Stack',1),(35,9,'Graph',0),(36,9,'Array only',0),(37,10,'O(n^2)',0),(38,10,'O(log n)',0),(39,10,'O(n log n)',1),(40,10,'O(1)',0);
/*!40000 ALTER TABLE `options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(300) NOT NULL,
  `category` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'What is the time complexity of binary search in a sorted array?','Searching'),(2,'Which data structure follows LIFO order?','Stack'),(3,'Which data structure follows FIFO order?','Queue'),(4,'What is the worst-case time complexity of Quick Sort?','Sorting'),(5,'Which traversal of a Binary Search Tree gives sorted order?','Trees'),(6,'Which data structure is commonly used in BFS?','Graphs'),(7,'What is the time complexity of accessing an array element by index?','Arrays'),(8,'Which algorithm finds the shortest path in a graph with non-negative edge weights?','Graphs'),(9,'Which data structure is used to implement recursion internally?','Stack'),(10,'What is the worst-case time complexity of Merge Sort?','Sorting');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_results`
--

DROP TABLE IF EXISTS `quiz_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `enrollno` varchar(30) NOT NULL,
  `score` int NOT NULL,
  `total` int NOT NULL,
  `submitted_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enrollno` (`enrollno`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_results`
--

LOCK TABLES `quiz_results` WRITE;
/*!40000 ALTER TABLE `quiz_results` DISABLE KEYS */;
INSERT INTO `quiz_results` VALUES (1,'Aditya Roy','aditya231@gmail.com','12218002724',6,10,'2026-10-21 13:25:38');
/*!40000 ALTER TABLE `quiz_results` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-21 19:01:36
