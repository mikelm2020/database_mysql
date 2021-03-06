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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='Age ratings for movies and series ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `movie_genres`
--

DROP TABLE IF EXISTS `movie_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_genres` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_genre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The genre of the movies';
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
  `duration` time NOT NULL,
  `movie_year` int NOT NULL,
  `streaming_service_id` int NOT NULL,
  `movie_genre_id` int NOT NULL,
  `age_rating_id` int NOT NULL,
  `origin_country_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `streaming_service_id` (`streaming_service_id`),
  KEY `movie_genre_id` (`movie_genre_id`),
  KEY `age_rating_id` (`age_rating_id`),
  KEY `origin_country_id` (`origin_country_id`),
  CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`streaming_service_id`) REFERENCES `streaming_services` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `movies_ibfk_2` FOREIGN KEY (`movie_genre_id`) REFERENCES `movie_genres` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `movies_ibfk_3` FOREIGN KEY (`age_rating_id`) REFERENCES `age_ratings` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `movies_ibfk_4` FOREIGN KEY (`origin_country_id`) REFERENCES `origin_countries` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The countries of origin of movies or series with ISO 3166-1 code';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seasons`
--

DROP TABLE IF EXISTS `seasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seasons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `season` smallint NOT NULL DEFAULT '1',
  `chapters` smallint NOT NULL DEFAULT '8',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The seasons of the series by number of chapters';
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
  `chapters` smallint NOT NULL,
  `streaming_service_id` int NOT NULL,
  `movie_genre_id` int NOT NULL,
  `age_rating_id` int NOT NULL,
  `origin_country_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `streaming_service_id` (`streaming_service_id`),
  KEY `movie_genre_id` (`movie_genre_id`),
  KEY `age_rating_id` (`age_rating_id`),
  KEY `origin_country_id` (`origin_country_id`),
  CONSTRAINT `series_ibfk_1` FOREIGN KEY (`streaming_service_id`) REFERENCES `streaming_services` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `series_ibfk_2` FOREIGN KEY (`movie_genre_id`) REFERENCES `movie_genres` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `series_ibfk_3` FOREIGN KEY (`age_rating_id`) REFERENCES `age_ratings` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `series_ibfk_4` FOREIGN KEY (`origin_country_id`) REFERENCES `origin_countries` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `series_seasons`
--

DROP TABLE IF EXISTS `series_seasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `series_seasons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `serie_id` int NOT NULL,
  `season_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `serie_id` (`serie_id`),
  KEY `season_id` (`season_id`),
  CONSTRAINT `series_seasons_ibfk_1` FOREIGN KEY (`serie_id`) REFERENCES `series` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `series_seasons_ibfk_2` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='All seasons of the series actually ';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The service of streamings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_movies`
--

DROP TABLE IF EXISTS `user_movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movie_view` tinyint NOT NULL DEFAULT '0',
  `seasons` smallint NOT NULL DEFAULT '1',
  `movie_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_movies_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `user_movies_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The play lists with movies for the users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_series`
--

DROP TABLE IF EXISTS `user_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_series` (
  `id` int NOT NULL,
  `serie_view` tinyint NOT NULL DEFAULT '0',
  `serie_season_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `serie_season_id` (`serie_season_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_series_ibfk_1` FOREIGN KEY (`serie_season_id`) REFERENCES `series_seasons` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `user_series_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci COMMENT='The play list with series for the users';
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-14 20:13:40
