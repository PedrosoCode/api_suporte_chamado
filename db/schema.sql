CREATE DATABASE  IF NOT EXISTS `app_suporte` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `app_suporte`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: app_suporte
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `tb_cad_empresa`
--

DROP TABLE IF EXISTS `tb_cad_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_cad_empresa` (
  `codigo` int NOT NULL,
  `nome_fantasia` varchar(255) DEFAULT NULL,
  `razao_social` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cad_empresa`
--

LOCK TABLES `tb_cad_empresa` WRITE;
/*!40000 ALTER TABLE `tb_cad_empresa` DISABLE KEYS */;
INSERT INTO `tb_cad_empresa` VALUES (1,'fant 1','raz 1'),(2,'fant 2','raz 2');
/*!40000 ALTER TABLE `tb_cad_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cad_usuario`
--

DROP TABLE IF EXISTS `tb_cad_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_cad_usuario` (
  `codigo` int NOT NULL,
  `codigo_empresa` int NOT NULL,
  `usuario` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `senha` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codigo`,`codigo_empresa`),
  KEY `fK_usuario_empresa` (`codigo_empresa`),
  CONSTRAINT `fK_usuario_empresa` FOREIGN KEY (`codigo_empresa`) REFERENCES `tb_cad_empresa` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cad_usuario`
--

LOCK TABLES `tb_cad_usuario` WRITE;
/*!40000 ALTER TABLE `tb_cad_usuario` DISABLE KEYS */;
INSERT INTO `tb_cad_usuario` VALUES (1,1,'teste',NULL,'$2b$10$iw.i0UtDfgvM8NL5X0957uo/AOrshDMv6Kj0odyZOhkyG9WJJE9/.','mail@teste'),(1,2,'pedroso',NULL,'$2b$10$Y0p/GpRxjN.kpuPoAbdNaenpAdJDCIJfgtNYFPi8sG59o6ORixPCK','mail@pedroso'),(2,2,'teste',NULL,'a','mail@teste');
/*!40000 ALTER TABLE `tb_cad_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_chat_sessao`
--

DROP TABLE IF EXISTS `tb_chat_sessao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_chat_sessao` (
  `codigo` bigint NOT NULL,
  `codigo_empresa` int NOT NULL,
  `assunto` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codigo`,`codigo_empresa`),
  KEY `fk_chat_empresa` (`codigo_empresa`),
  CONSTRAINT `fk_chat_empresa` FOREIGN KEY (`codigo_empresa`) REFERENCES `tb_cad_empresa` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_chat_sessao`
--

LOCK TABLES `tb_chat_sessao` WRITE;
/*!40000 ALTER TABLE `tb_chat_sessao` DISABLE KEYS */;
INSERT INTO `tb_chat_sessao` VALUES (1,2,'chat 1'),(2,2,'teste'),(3,2,'oi');
/*!40000 ALTER TABLE `tb_chat_sessao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_chat_sessao_mensagem`
--

DROP TABLE IF EXISTS `tb_chat_sessao_mensagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_chat_sessao_mensagem` (
  `codigo` bigint NOT NULL,
  `codigo_chat` bigint NOT NULL,
  `codigo_empresa` int NOT NULL,
  `texto` varchar(500) DEFAULT NULL,
  `codigo_remetente` int DEFAULT NULL,
  `data_input` datetime DEFAULT NULL,
  PRIMARY KEY (`codigo`,`codigo_chat`,`codigo_empresa`),
  KEY `fk_mensagem_usuario` (`codigo_empresa`,`codigo_remetente`),
  KEY `fk_mensagem_chat` (`codigo_chat`,`codigo_empresa`),
  CONSTRAINT `fk_mensagem_chat` FOREIGN KEY (`codigo_chat`, `codigo_empresa`) REFERENCES `tb_chat_sessao` (`codigo`, `codigo_empresa`),
  CONSTRAINT `fk_mensagem_usuario` FOREIGN KEY (`codigo_empresa`, `codigo_remetente`) REFERENCES `tb_cad_usuario` (`codigo_empresa`, `codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_chat_sessao_mensagem`
--

LOCK TABLES `tb_chat_sessao_mensagem` WRITE;
/*!40000 ALTER TABLE `tb_chat_sessao_mensagem` DISABLE KEYS */;
INSERT INTO `tb_chat_sessao_mensagem` VALUES (1,3,2,'um',1,'2025-04-09 23:57:27'),(2,3,2,'dois',2,'2025-04-09 23:57:30'),(3,3,2,'tres',1,'2025-04-09 23:57:34'),(4,3,2,'quatro',2,'2025-04-09 23:57:38'),(5,3,2,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam lacinia laoreet odio, et pulvinar lorem rutrum non. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; In vitae odio ac magna accumsan tristique. Nulla lobortis nibh in dolor fermentum, eu consequat nisl volutpat. Quisque pharetra metus ac risus congue consectetur. Donec efficitur ultricies dignissim. Praes',1,'2025-04-09 23:59:20');
/*!40000 ALTER TABLE `tb_chat_sessao_mensagem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'app_suporte'
--

--
-- Dumping routines for database 'app_suporte'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_chat_novo_suporte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_chat_novo_suporte`(
    IN p_codigo_empresa INT,  
    IN p_codigo_usuario INT,
    IN p_assunto VARCHAR(500)
)
BEGIN
    DECLARE p_acesso INT;

    SELECT COALESCE(MAX(codigo), 0) + 1 
    INTO p_acesso
    FROM tb_chat_sessao
    WHERE codigo_empresa = p_codigo_empresa;


    INSERT INTO tb_chat_sessao (
        codigo,
        codigo_empresa,
        assunto
    ) VALUES (
        p_acesso,
        p_codigo_empresa,
        p_assunto
    );
    
    SELECT p_acesso AS descricao;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_chat_sessao_mensagem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_chat_sessao_mensagem`(
	IN p_codigo_chat		INT,
    IN p_codigo_empresa 	INT,  
    IN p_codigo_remetente 	INT,
    IN p_texto_mensagem 	VARCHAR(500)
)
BEGIN

    DECLARE p_codigo INT;

    SELECT COALESCE(MAX(codigo), 0) + 1 
    INTO p_codigo
    FROM tb_chat_sessao_mensagem
    WHERE codigo_empresa = p_codigo_empresa
    AND	codigo_chat = p_codigo_chat;


    INSERT INTO `app_suporte`.`tb_chat_sessao_mensagem`
		(codigo,
		 codigo_chat,
		 codigo_empresa,
		 texto,
		 codigo_remetente,
		 data_input
         )
	VALUES
		(p_codigo,
		 p_codigo_chat,
		 p_codigo_empresa,
		 p_texto_mensagem,
		 p_codigo_remetente,
		 now()
        );
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_login_signup_cadastro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_login_signup_cadastro`(
	p_codigo_empresa 	INT,  
	p_nome_usuario 		VARCHAR(255),
    p_email 			VARCHAR(255),
    p_senha 			VARCHAR(255)
)
BEGIN

	DECLARE v_codigo INT;

	SET v_codigo = (
					SELECT 
						COALESCE(MAX(codigo), 0) + 1
					FROM tb_cad_usuario 
					WHERE codigo_empresa = p_codigo_empresa
				   );

	INSERT INTO tb_cad_usuario
		(codigo,
		usuario,
		email,
		senha,
		codigo_empresa)
	VALUES
		(v_codigo,
		p_nome_usuario,  
		p_email,
		p_senha,
		p_codigo_empresa);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_chat_sessao_mensagem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_chat_sessao_mensagem`(
	IN p_codigo_chat 	INT,
    IN p_codigo_empresa INT
)
BEGIN

	SELECT 
		tb_chat_sessao_mensagem.codigo AS nCodigoMensagem,
        tb_chat_sessao_mensagem.codigo_chat AS nCodigoChat,
        tb_chat_sessao_mensagem.codigo_empresa AS nCodigoEmpresa,
        tb_chat_sessao_mensagem.codigo_remetente AS nRemetente,
        tb_chat_sessao_mensagem.data_input AS dDataEnvio,
        tb_chat_sessao_mensagem.texto AS sTexto,
        tb_cad_usuario.usuario AS sNomeUsuario
    FROM tb_chat_sessao_mensagem
    INNER JOIN tb_cad_usuario
    ON tb_cad_usuario.codigo = tb_chat_sessao_mensagem.codigo_remetente
    AND tb_cad_usuario.codigo_empresa = tb_chat_sessao_mensagem.codigo_empresa
    WHERE tb_chat_sessao_mensagem.codigo_chat = p_codigo_chat
    AND	tb_chat_sessao_mensagem.codigo_empresa = p_codigo_empresa
    ORDER BY data_input ASC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_select_login_signup_combo_empresa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_login_signup_combo_empresa`()
BEGIN

	SELECT * from tb_cad_empresa;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_validate_login_signup_senha_hash` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_login_signup_senha_hash`(
	p_codigo_empresa 	INT,  
	p_nome_usuario 		VARCHAR(255)
)
BEGIN

	SELECT 
		senha,
        codigo
	FROM tb_cad_usuario
    WHERE usuario = p_nome_usuario
    AND   codigo_empresa = p_codigo_empresa;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-09 21:26:03
