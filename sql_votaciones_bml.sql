-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.31-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para bd_votaciones_bml
CREATE DATABASE IF NOT EXISTS `bd_votaciones_bml` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bd_votaciones_bml`;

-- Volcando estructura para tabla bd_votaciones_bml.candidatos
CREATE TABLE IF NOT EXISTS `candidatos` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE_APELLIDOS` varchar(250) NOT NULL,
  `ORDEN` varchar(20) NOT NULL,
  `ID_PARTIDO` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_candidatos_partidos` (`ID_PARTIDO`),
  CONSTRAINT `FK_candidatos_partidos` FOREIGN KEY (`ID_PARTIDO`) REFERENCES `partidos` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_votaciones_bml.candidatos: ~16 rows (aproximadamente)
DELETE FROM `candidatos`;
/*!40000 ALTER TABLE `candidatos` DISABLE KEYS */;
INSERT INTO `candidatos` (`ID`, `NOMBRE_APELLIDOS`, `ORDEN`, `ID_PARTIDO`) VALUES
	(1, 'Carmen Navarro Lacoba', '1', 1),
	(2, 'Francisco Molinero Hoyos', '2', 1),
	(3, 'Fermin Gómez Sarrión', '3', 1),
	(4, 'Maria Gil Martinez', '4', 1),
	(5, 'Manuel Gabriel Gonzalez Ramos', '1', 2),
	(6, 'Soledad Velasco Baidez', '2', 2),
	(7, 'Francisco Tierraseca Galdón', '3', 2),
	(8, 'Milagros Vazquez Torres', '4', 2),
	(9, 'Onesimo E. Gonzalez Martinez', '1', 4),
	(10, 'Mª Llanos Prieto Martinez', '2', 4),
	(11, 'Marco Moreno Montejano', '3', 4),
	(12, 'Ana Martinez Molino', '4', 4),
	(13, 'Maria Teresa Arevalo Caraballo', '1', 3),
	(14, 'Javier Sanchez Gutierrez', '2', 3),
	(15, 'Diana Carol Paredes Choquehuanca', '3', 3),
	(16, 'José Antonio Peñaranda Gómez ', '4', 3);
/*!40000 ALTER TABLE `candidatos` ENABLE KEYS */;

-- Volcando estructura para tabla bd_votaciones_bml.configuracion
CREATE TABLE IF NOT EXISTS `configuracion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `situacion_escrutinio` int(11) NOT NULL DEFAULT '0',
  `tipo_eleccion` varchar(200) DEFAULT NULL,
  `provincia` varchar(200) DEFAULT NULL,
  `n_escanos` int(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_votaciones_bml.configuracion: ~1 rows (aproximadamente)
DELETE FROM `configuracion`;
/*!40000 ALTER TABLE `configuracion` DISABLE KEYS */;
INSERT INTO `configuracion` (`id`, `situacion_escrutinio`, `tipo_eleccion`, `provincia`, `n_escanos`) VALUES
	(1, 1, NULL, NULL, 5);
/*!40000 ALTER TABLE `configuracion` ENABLE KEYS */;

-- Volcando estructura para tabla bd_votaciones_bml.escanos
CREATE TABLE IF NOT EXISTS `escanos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPartido` int(11) NOT NULL,
  `idCandidato` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idPartido` (`idPartido`,`idCandidato`),
  KEY `FK_escanos_candidatos` (`idCandidato`),
  CONSTRAINT `FK_escanos_candidatos` FOREIGN KEY (`idCandidato`) REFERENCES `candidatos` (`ID`),
  CONSTRAINT `FK_escanos_partidos` FOREIGN KEY (`idPartido`) REFERENCES `partidos` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_votaciones_bml.escanos: ~0 rows (aproximadamente)
DELETE FROM `escanos`;
/*!40000 ALTER TABLE `escanos` DISABLE KEYS */;
/*!40000 ALTER TABLE `escanos` ENABLE KEYS */;

-- Volcando estructura para tabla bd_votaciones_bml.partidos
CREATE TABLE IF NOT EXISTS `partidos` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(200) NOT NULL,
  `LOGO` varchar(200) NOT NULL,
  `VOTOS` int(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_votaciones_bml.partidos: ~5 rows (aproximadamente)
DELETE FROM `partidos`;
/*!40000 ALTER TABLE `partidos` DISABLE KEYS */;
INSERT INTO `partidos` (`ID`, `NOMBRE`, `LOGO`, `VOTOS`) VALUES
	(1, 'PP', 'pp.png', 258020),
	(2, 'PSOE', 'psoe.jpg', 168030),
	(3, 'CIUDADANOS', 'ciudadanos.jpg', 114040),
	(4, 'PODEMOS', 'podemos.jpg', 60050),
	(5, 'VOX', 'vox.jpg', 17481);
/*!40000 ALTER TABLE `partidos` ENABLE KEYS */;

-- Volcando estructura para tabla bd_votaciones_bml.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dni` varchar(25) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `domicilio` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `password` varbinary(200) NOT NULL,
  `rol` varchar(20) NOT NULL,
  `votado` varchar(10) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_votaciones_bml.usuarios: ~5 rows (aproximadamente)
DELETE FROM `usuarios`;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `dni`, `nombre`, `apellidos`, `domicilio`, `email`, `fechaNacimiento`, `password`, `rol`, `votado`) VALUES
	(2, '4444', 'ADMIN', 'ADMIN', 'c/la piruleta', 'admin@admin.com', '1998-06-05', _binary 0x6A41BEFE9BDC3A5819B919009484CC4F, 'A', 'S'),
	(4, '48258022c', 'BORJA', 'MATEO', 'c/cantarranas', 'b@b.com', '1995-01-01', _binary 0x6A41BEFE9BDC3A5819B919009484CC4F, 'V', 'N'),
	(5, '48', 'PERICO', 'SANCHEZ', 'calle', 'b@b.com', '1998-01-01', _binary 0x6A41BEFE9BDC3A5819B919009484CC4F, 'V', 'N'),
	(6, '46', 'PABLO', 'CUARTERO', 'cantarranas', 'p@p.com', '1555-01-01', _binary 0x6A41BEFE9BDC3A5819B919009484CC4F, 'V', 'N'),
	(8, '123456', 'SANDRA', 'MATEO', 'C/ ISABEL', 's@s.com', '1991-05-05', _binary 0x6A41BEFE9BDC3A5819B919009484CC4F, 'V', 'N');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
