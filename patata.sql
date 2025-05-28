-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.40 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para skycompare
CREATE DATABASE IF NOT EXISTS `skycompare` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `skycompare`;

-- Volcando estructura para tabla skycompare.airports
CREATE TABLE IF NOT EXISTS `airports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `IATA` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Índice 2` (`IATA`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla skycompare.airports: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
REPLACE INTO `airports` (`id`, `name`, `location`, `IATA`) VALUES
	(1, 'Leon', 'La Virgen del Camino', 'LEN'),
	(2, 'Madrid-Barajas Adolfo Suárez', 'Barajas', 'MAD'),
	(3, 'Josep Tarradella Barcelona-El Prat', 'El Prat de LLobregat', 'BCN'),
	(4, 'Dublin Airport', 'Dublin', 'DUB'),
	(5, 'Düsseldorff International', 'Düsseldorff', 'DUS'),
	(6, 'Düsseldorff Weeze Airport', 'Weeze', 'NRN'),
	(7, 'Bruselas-National Airport', 'Bruselas', 'BRU'),
	(8, 'Helsinki-Vantaa Airport', 'Vantaa', 'HEL'),
	(9, 'Paris-Orly', 'Orly', 'ORY'),
	(10, 'Paris-Charles de Gaulle', 'Roissy', 'CDG');
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;

-- Volcando estructura para tabla skycompare.company
CREATE TABLE IF NOT EXISTS `company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `multiply` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla skycompare.company: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
REPLACE INTO `company` (`id`, `name`, `multiply`) VALUES
	(1, 'Ryanair', 0.8),
	(2, 'Iberia', 1.3),
	(3, 'Easyjet', 0.9),
	(4, 'Vueling', 1),
	(5, 'Brittish Airwais', 1.3),
	(6, 'Lufthansa', 1.4),
	(7, 'Fly Emirates', 2.5);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;

-- Volcando estructura para tabla skycompare.routes
CREATE TABLE IF NOT EXISTS `routes` (
  `id` int NOT NULL,
  `departure` varchar(3) NOT NULL DEFAULT '',
  `destination` varchar(3) NOT NULL DEFAULT '',
  `duration` int NOT NULL DEFAULT '0',
  `state` varchar(50) NOT NULL DEFAULT 'On time',
  `avg_price` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_routes_airports` (`departure`),
  KEY `FK_routes_airports_2` (`destination`),
  CONSTRAINT `FK_routes_airports` FOREIGN KEY (`departure`) REFERENCES `airports` (`IATA`),
  CONSTRAINT `FK_routes_airports_2` FOREIGN KEY (`destination`) REFERENCES `airports` (`IATA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla skycompare.routes: ~17 rows (aproximadamente)
/*!40000 ALTER TABLE `routes` DISABLE KEYS */;
REPLACE INTO `routes` (`id`, `departure`, `destination`, `duration`, `state`, `avg_price`) VALUES
	(1, 'BCN', 'BRU', 125, 'On time', 70),
	(2, 'LEN', 'BRU', 130, 'On time', 120),
	(3, 'MAD', 'BRU', 135, 'On time', 95),
	(4, 'BCN', 'DUB', 170, 'On time', 100),
	(5, 'LEN', 'DUB', 145, 'On time', 115),
	(6, 'MAD', 'DUB', 150, 'On time', 70),
	(7, 'BCN', 'DUS', 135, 'On time', 60),
	(8, 'BCN', 'NRN', 120, 'On time', 120),
	(9, 'LEN', 'NRN', 135, 'On time', 120),
	(10, 'MAD', 'DUS', 120, 'On time', 110),
	(11, 'MAD', 'NRN', 140, 'On time', 130),
	(12, 'BCN', 'HEL', 240, 'On time', 100),
	(13, 'MAD', 'HEL', 245, 'On time', 200),
	(14, 'BCN', 'CDG', 120, 'On time', 40),
	(15, 'MAD', 'CDG', 125, 'On time', 40),
	(16, 'BCN', 'ORY', 120, 'On time', 40),
	(17, 'MAD', 'ORY', 120, 'On time', 40);
/*!40000 ALTER TABLE `routes` ENABLE KEYS */;

-- Volcando estructura para tabla skycompare.routes_probed
CREATE TABLE IF NOT EXISTS `routes_probed` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `id_ruta1` int NOT NULL,
  `Precio 1` double NOT NULL,
  `id_ruta2` int NOT NULL,
  `Precio 2` double NOT NULL,
  `id_ruta3` int DEFAULT NULL,
  `Precio 3` double DEFAULT NULL,
  `id_ruta4` int DEFAULT NULL,
  `Precio 4` double DEFAULT NULL,
  `id_ruta5` int DEFAULT NULL,
  `Precio 5` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_routes_probed_users` (`id_user`),
  KEY `FK_routes_probed_routes` (`id_ruta1`),
  KEY `FK_routes_probed_routes_2` (`id_ruta2`),
  KEY `FK_routes_probed_routes_3` (`id_ruta3`),
  KEY `FK_routes_probed_routes_4` (`id_ruta4`),
  KEY `FK_routes_probed_routes_5` (`id_ruta5`),
  CONSTRAINT `FK_routes_probed_routes` FOREIGN KEY (`id_ruta1`) REFERENCES `routes` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_routes_probed_routes_2` FOREIGN KEY (`id_ruta2`) REFERENCES `routes` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_routes_probed_routes_3` FOREIGN KEY (`id_ruta3`) REFERENCES `routes` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_routes_probed_routes_4` FOREIGN KEY (`id_ruta4`) REFERENCES `routes` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_routes_probed_routes_5` FOREIGN KEY (`id_ruta5`) REFERENCES `routes` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_routes_probed_users` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla skycompare.routes_probed: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `routes_probed` DISABLE KEYS */;
/*!40000 ALTER TABLE `routes_probed` ENABLE KEYS */;

-- Volcando estructura para tabla skycompare.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `full_name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pass` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fav_airport` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_users_airports` (`fav_airport`),
  CONSTRAINT `FK_users_airports` FOREIGN KEY (`fav_airport`) REFERENCES `airports` (`IATA`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla skycompare.users: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
REPLACE INTO `users` (`id`, `nickname`, `full_name`, `email`, `pass`, `fav_airport`) VALUES
	(1, 'Juanito', 'Rasputin Robespierre', 'Rarararara@rasputin.es', '1234', 'MAD'),
	(2, 'Raposo', 'Raposo Zorro Gallino', 'rrz@es.es', '1234', 'NRN'),
	(3, 'e', 'e', 'e', 'e', NULL),
	(4, 'f', 'f', 'f', 'f', NULL),
	(5, 'g', 'g', 'g', 'g', NULL),
	(6, 'h', 'h', 'h', 'h', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
