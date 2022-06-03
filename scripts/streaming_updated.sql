-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: streaming
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `age_ratings`
--

DROP TABLE IF EXISTS `age_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `age_ratings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `age_rating` varchar(5) COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='Age ratings for movies and series ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `film_genders`
--

DROP TABLE IF EXISTS `film_genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `film_genders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_gender` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The gender of the movies';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movie_countries`
--

DROP TABLE IF EXISTS `movie_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_countries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `country_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `movie_countries_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `movie_countries_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `origin_countries` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4254 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movie_countries_tmp`
--

DROP TABLE IF EXISTS `movie_countries_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_countries_tmp` (
  `title` varchar(150) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movie_genders`
--

DROP TABLE IF EXISTS `movie_genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_genders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `film_gender_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `film_gender_id` (`film_gender_id`),
  CONSTRAINT `movie_genders_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `movie_genders_ibfk_2` FOREIGN KEY (`film_gender_id`) REFERENCES `film_genders` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8308 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movie_genres_tmp`
--

DROP TABLE IF EXISTS `movie_genres_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_genres_tmp` (
  `title` varchar(150) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `genre` varchar(70) COLLATE utf8_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_name` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `duration` int DEFAULT NULL,
  `movie_year` int NOT NULL,
  `age_rating_id` int NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `age_rating_id` (`age_rating_id`),
  CONSTRAINT `movies_ibfk_3` FOREIGN KEY (`age_rating_id`) REFERENCES `age_ratings` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3036 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movies_streamings`
--

DROP TABLE IF EXISTS `movies_streamings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies_streamings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `movie_id` int NOT NULL,
  `streaming_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `streaming_id` (`streaming_id`),
  CONSTRAINT `movies_streamings_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `movies_streamings_ibfk_2` FOREIGN KEY (`streaming_id`) REFERENCES `streaming_services` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3337 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movies_tmp`
--

DROP TABLE IF EXISTS `movies_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies_tmp` (
  `title` varchar(150) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `netflix` int DEFAULT NULL,
  `prime` int DEFAULT NULL,
  `disney` int DEFAULT NULL,
  `genres` varchar(70) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `country` varchar(220) COLLATE utf8_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `origin_countries`
--

DROP TABLE IF EXISTS `origin_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `origin_countries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `origin_country` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `iso_code` char(3) COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The countries of origin of movies or series with ISO 3166-1 code';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serie_countries`
--

DROP TABLE IF EXISTS `serie_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serie_countries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `serie_id` int NOT NULL,
  `country_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `serie_id` (`serie_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `serie_countries_ibfk_1` FOREIGN KEY (`serie_id`) REFERENCES `series` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `serie_countries_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `origin_countries` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serie_countries_tmp`
--

DROP TABLE IF EXISTS `serie_countries_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serie_countries_tmp` (
  `title` varchar(105) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `country` varchar(83) COLLATE utf8_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serie_genders`
--

DROP TABLE IF EXISTS `serie_genders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serie_genders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `serie_id` int NOT NULL,
  `film_gender_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `serie_id` (`serie_id`),
  KEY `film_gender_id` (`film_gender_id`),
  CONSTRAINT `serie_genders_ibfk_1` FOREIGN KEY (`serie_id`) REFERENCES `series` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `serie_genders_ibfk_2` FOREIGN KEY (`film_gender_id`) REFERENCES `film_genders` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serie_genres_tmp`
--

DROP TABLE IF EXISTS `serie_genres_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serie_genres_tmp` (
  `title` varchar(105) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `listed_in` varchar(70) COLLATE utf8_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `series`
--

DROP TABLE IF EXISTS `series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `series` (
  `id` int NOT NULL AUTO_INCREMENT,
  `serie_name` varchar(150) COLLATE utf8_spanish2_ci NOT NULL,
  `seasons` smallint NOT NULL DEFAULT '1',
  `serie_year` int NOT NULL,
  `age_rating_id` int NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `age_rating_id` (`age_rating_id`),
  CONSTRAINT `series_ibfk_3` FOREIGN KEY (`age_rating_id`) REFERENCES `age_ratings` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `series_streamings`
--

DROP TABLE IF EXISTS `series_streamings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `series_streamings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `serie_id` int NOT NULL,
  `streaming_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `serie_id` (`serie_id`),
  KEY `streaming_id` (`streaming_id`),
  CONSTRAINT `series_streamings_ibfk_1` FOREIGN KEY (`serie_id`) REFERENCES `series` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `series_streamings_ibfk_2` FOREIGN KEY (`streaming_id`) REFERENCES `streaming_services` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `series_tmp`
--

DROP TABLE IF EXISTS `series_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `series_tmp` (
  `title` varchar(105) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `country` varchar(83) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `listed_in` varchar(70) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `type` varchar(7) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `rating` varchar(5) COLLATE utf8_spanish2_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `streaming_services`
--

DROP TABLE IF EXISTS `streaming_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `streaming_services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `streaming_service` varchar(15) COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The service of streamings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_movies`
--

DROP TABLE IF EXISTS `user_movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_viewed` tinyint(1) NOT NULL DEFAULT '0',
  `movie_id` int NOT NULL,
  `user_id` int NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_movies_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `user_movies_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=823 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The play lists with movies for the users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_series`
--

DROP TABLE IF EXISTS `user_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_series` (
  `id` int NOT NULL AUTO_INCREMENT,
  `serie_id` int NOT NULL,
  `serie_viewed` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `user_series_ibfk_1` (`serie_id`),
  CONSTRAINT `user_series_ibfk_1` FOREIGN KEY (`serie_id`) REFERENCES `series` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `user_series_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=772 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The play list with series for the users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `pass` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `user_name` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-03  2:42:14
