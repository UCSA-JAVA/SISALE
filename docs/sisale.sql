-- MySQL dump 10.13  Distrib 5.5.31, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: bd_sisale
-- ------------------------------------------------------
-- Server version	5.5.31-0ubuntu0.12.04.1

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
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresa` (
  `ruc` int(11) NOT NULL,
  `razon_social` longtext,
  `direccion` longtext,
  `telefono` text,
  `actividad` longtext,
  PRIMARY KEY (`ruc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estados` (
  `id` int(11) NOT NULL,
  `nombre` text,
  `descripcion` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico`
--

DROP TABLE IF EXISTS `historico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historico` (
  `id` int(11) NOT NULL,
  `incidencias_id` int(11) NOT NULL,
  `descripcion` longtext,
  `id_tipo_operacion` int(11) DEFAULT NULL,
  `usuario_creacion` varchar(45) DEFAULT NULL,
  `usuario_designado` varchar(45) DEFAULT NULL,
  `tiempo_estimado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comentarios_FKIndex1` (`incidencias_id`),
  KEY `IFK_incidencias_comentarios` (`incidencias_id`),
  KEY `fk_historico_1_idx` (`id_tipo_operacion`),
  CONSTRAINT `fk_historico_1` FOREIGN KEY (`id_tipo_operacion`) REFERENCES `tipo_operaciones` (`idtipo_operacion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico`
--

LOCK TABLES `historico` WRITE;
/*!40000 ALTER TABLE `historico` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencias`
--

DROP TABLE IF EXISTS `incidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incidencias` (
  `id` int(11) NOT NULL,
  `estados_id` int(11) NOT NULL,
  `prioridad_id` int(11) NOT NULL,
  `recursos_id` int(11) NOT NULL,
  `modulos_id` int(11) NOT NULL,
  `nombre` text,
  `descripcion` longtext,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incidencias_FKIndex1` (`modulos_id`),
  KEY `incidencias_FKIndex2` (`recursos_id`),
  KEY `incidencias_FKIndex3` (`prioridad_id`),
  KEY `incidencias_FKIndex4` (`estados_id`),
  KEY `IFK_modulos_incidencias` (`modulos_id`),
  KEY `IFK_recursos_incidencias` (`recursos_id`),
  KEY `IFK_incidencias_prioridad` (`prioridad_id`),
  KEY `IFK_incidencias_estados` (`estados_id`),
  CONSTRAINT `incidencias_ibfk_1` FOREIGN KEY (`modulos_id`) REFERENCES `modulos` (`id`),
  CONSTRAINT `incidencias_ibfk_2` FOREIGN KEY (`recursos_id`) REFERENCES `recursos` (`id`),
  CONSTRAINT `incidencias_ibfk_3` FOREIGN KEY (`prioridad_id`) REFERENCES `prioridad` (`id`),
  CONSTRAINT `incidencias_ibfk_4` FOREIGN KEY (`estados_id`) REFERENCES `estados` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencias`
--

LOCK TABLES `incidencias` WRITE;
/*!40000 ALTER TABLE `incidencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `incidencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencias_has_niveles_de_bloqueo`
--

DROP TABLE IF EXISTS `incidencias_has_niveles_de_bloqueo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incidencias_has_niveles_de_bloqueo` (
  `incidencias_id` int(11) NOT NULL,
  `niveles_de_bloqueo_id` int(11) NOT NULL,
  `incidencias_has_niveles_id` int(11) NOT NULL,
  PRIMARY KEY (`incidencias_has_niveles_id`),
  UNIQUE KEY `incidencias_id_UNIQUE` (`incidencias_id`,`niveles_de_bloqueo_id`),
  KEY `incidencias_has_niveles_de_bloqueo_FKIndex1` (`incidencias_id`),
  KEY `incidencias_has_niveles_de_bloqueo_FKIndex2` (`niveles_de_bloqueo_id`),
  KEY `IFK_incidencias_bloqueo` (`incidencias_id`),
  KEY `IFK_bloqueo_incidencias` (`niveles_de_bloqueo_id`),
  CONSTRAINT `incidencias_has_niveles_de_bloqueo_ibfk_1` FOREIGN KEY (`incidencias_id`) REFERENCES `incidencias` (`id`),
  CONSTRAINT `incidencias_has_niveles_de_bloqueo_ibfk_2` FOREIGN KEY (`niveles_de_bloqueo_id`) REFERENCES `niveles_de_bloqueo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencias_has_niveles_de_bloqueo`
--

LOCK TABLES `incidencias_has_niveles_de_bloqueo` WRITE;
/*!40000 ALTER TABLE `incidencias_has_niveles_de_bloqueo` DISABLE KEYS */;
/*!40000 ALTER TABLE `incidencias_has_niveles_de_bloqueo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modulos`
--

DROP TABLE IF EXISTS `modulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulos` (
  `id` int(11) NOT NULL,
  `proyectos_id` int(11) NOT NULL,
  `nombre` longtext,
  `descripcion` longtext,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `fecha_limite` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `modulos_FKIndex1` (`proyectos_id`),
  KEY `IFK_proyectos_modulos` (`proyectos_id`),
  CONSTRAINT `modulos_ibfk_1` FOREIGN KEY (`proyectos_id`) REFERENCES `proyectos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulos`
--

LOCK TABLES `modulos` WRITE;
/*!40000 ALTER TABLE `modulos` DISABLE KEYS */;
/*!40000 ALTER TABLE `modulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modulos_has_recursos`
--

DROP TABLE IF EXISTS `modulos_has_recursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulos_has_recursos` (
  `modulos_id` int(11) NOT NULL,
  `recursos_id` int(11) NOT NULL,
  `modulos_recursos_id` int(11) NOT NULL,
  PRIMARY KEY (`modulos_recursos_id`),
  UNIQUE KEY `modulos_id_UNIQUE` (`modulos_id`,`recursos_id`),
  KEY `modulos_has_recursos_FKIndex1` (`modulos_id`),
  KEY `modulos_has_recursos_FKIndex2` (`recursos_id`),
  KEY `IFK_modulos_recursos` (`modulos_id`),
  KEY `IFK_recursos_modulos` (`recursos_id`),
  CONSTRAINT `modulos_has_recursos_ibfk_1` FOREIGN KEY (`modulos_id`) REFERENCES `modulos` (`id`),
  CONSTRAINT `modulos_has_recursos_ibfk_2` FOREIGN KEY (`recursos_id`) REFERENCES `recursos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulos_has_recursos`
--

LOCK TABLES `modulos_has_recursos` WRITE;
/*!40000 ALTER TABLE `modulos_has_recursos` DISABLE KEYS */;
/*!40000 ALTER TABLE `modulos_has_recursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `niveles_de_bloqueo`
--

DROP TABLE IF EXISTS `niveles_de_bloqueo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `niveles_de_bloqueo` (
  `id` int(11) NOT NULL,
  `nombre` text,
  `descripcion` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `niveles_de_bloqueo`
--

LOCK TABLES `niveles_de_bloqueo` WRITE;
/*!40000 ALTER TABLE `niveles_de_bloqueo` DISABLE KEYS */;
/*!40000 ALTER TABLE `niveles_de_bloqueo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prioridad`
--

DROP TABLE IF EXISTS `prioridad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prioridad` (
  `id` int(11) NOT NULL,
  `nombre` text,
  `descripcion` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prioridad`
--

LOCK TABLES `prioridad` WRITE;
/*!40000 ALTER TABLE `prioridad` DISABLE KEYS */;
/*!40000 ALTER TABLE `prioridad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyectos`
--

DROP TABLE IF EXISTS `proyectos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proyectos` (
  `id` int(11) NOT NULL,
  `empresa_ruc` int(11) NOT NULL,
  `titulo` longtext,
  `descripcion` longtext,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `fecha_limite` datetime DEFAULT NULL,
  `version_mayor` int(11) DEFAULT NULL,
  `version_menor` int(11) DEFAULT NULL,
  `version_micro` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proyecto_FKIndex1` (`empresa_ruc`),
  KEY `IFK_empresa_proyecto` (`empresa_ruc`),
  CONSTRAINT `proyectos_ibfk_1` FOREIGN KEY (`empresa_ruc`) REFERENCES `empresa` (`ruc`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyectos`
--

LOCK TABLES `proyectos` WRITE;
/*!40000 ALTER TABLE `proyectos` DISABLE KEYS */;
/*!40000 ALTER TABLE `proyectos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recursos`
--

DROP TABLE IF EXISTS `recursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recursos` (
  `id` int(11) NOT NULL,
  `nombre` text,
  `descripcion` longtext,
  `tipo` text,
  `costo_x_hora` double DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recursos`
--

LOCK TABLES `recursos` WRITE;
/*!40000 ALTER TABLE `recursos` DISABLE KEYS */;
/*!40000 ALTER TABLE `recursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` text,
  `descripcion` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_has_recursos`
--

DROP TABLE IF EXISTS `roles_has_recursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_has_recursos` (
  `roles_id` int(11) NOT NULL,
  `recursos_id` int(11) NOT NULL,
  PRIMARY KEY (`roles_id`,`recursos_id`),
  KEY `roles_has_recursos_FKIndex1` (`roles_id`),
  KEY `roles_has_recursos_FKIndex2` (`recursos_id`),
  KEY `IFK_roles_recursos` (`roles_id`),
  KEY `IFK_recursos_roles` (`recursos_id`),
  CONSTRAINT `roles_has_recursos_ibfk_1` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `roles_has_recursos_ibfk_2` FOREIGN KEY (`recursos_id`) REFERENCES `recursos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_has_recursos`
--

LOCK TABLES `roles_has_recursos` WRITE;
/*!40000 ALTER TABLE `roles_has_recursos` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_has_recursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_operaciones`
--

DROP TABLE IF EXISTS `tipo_operaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_operaciones` (
  `idtipo_operacion` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idtipo_operacion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_operaciones`
--

LOCK TABLES `tipo_operaciones` WRITE;
/*!40000 ALTER TABLE `tipo_operaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_operaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `cedula` int(11) NOT NULL,
  `recursos_id` int(11) NOT NULL,
  `nombres` longtext,
  `apellidos` longtext,
  `direccion` longtext,
  `usuario_acceso` text,
  `contrasena_acceso` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cedula`),
  KEY `usuarios_FKIndex1` (`recursos_id`),
  KEY `IFK_recursos_usuarios` (`recursos_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`recursos_id`) REFERENCES `recursos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-05-28 21:19:22
