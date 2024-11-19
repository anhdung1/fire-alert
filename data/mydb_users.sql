-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `roles_id` int NOT NULL,
  `api_key` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`roles_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `apikey_UNIQUE` (`api_key`),
  KEY `fk_users_roles_idx` (`roles_id`),
  CONSTRAINT `fk_users_roles` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'dung','$2a$2a$12$rEojc.uArZ8kurrb1yNCfuQq/SXOfWnaHtZBfRHdpuX8DCzaYKAbO',2,'abcdefgh'),(2,'dung1','$2a$10$MBakXMTjH8ujhNIMqBOcxeQnnM5b7oOyKHpGdjYXBDi7TvFmn59dC',2,'ff2858dc-5ecc-41ca-be8b-254423fd0d45'),(3,'dung11','$2a$10$qzWxmvzMMkSJw9TJTbVbpOG2jwQSGLpxkLN/Q9lBxkxQ4piaH8CWK',2,'9c24a9a7-7e9a-40dc-9bd5-2d5b19e7143f'),(5,'dung1111','$2a$10$0T7TtpaHnIkT3YhrJmJrju9aYGZd0fc1bEOfo4mVY40IW9bVnQ6lu',2,'9772c0eb-4fae-4f96-80a6-c3b6c4644112'),(6,'dungvl75','$2a$10$SHmA4/2JIyZLW6eoac6/ueRPwt.LMyA9pJ0CQ.Qm88w.toEI0/EK6',2,'62d409e4-864e-4cea-8b0a-e76c4d44cedc'),(7,'dungdung','$2a$10$SHmA4/2JIyZLW6eoac6/ueRPwt.LMyA9pJ0CQ.Qm88w.toEI0/EK6',1,'c843bf49-4327-4aaa-b495-14ffbbf34641');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-15 12:06:04
