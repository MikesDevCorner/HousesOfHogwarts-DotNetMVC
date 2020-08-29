CREATE DATABASE  IF NOT EXISTS `hogwarts` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `hogwarts`;
-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: hogwarts
-- ------------------------------------------------------
-- Server version	5.7.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `antworten`
--

DROP TABLE IF EXISTS `antworten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `antworten` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_frage` int(11) DEFAULT NULL,
  `antworttext` text NOT NULL,
  `id_haus` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hausinfo_idx` (`id_haus`),
  KEY `fk_frage_idx` (`id_frage`),
  CONSTRAINT `fk_frage` FOREIGN KEY (`id_frage`) REFERENCES `fragen` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_hausinfo` FOREIGN KEY (`id_haus`) REFERENCES `hausinfos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antworten`
--

LOCK TABLES `antworten` WRITE;
/*!40000 ALTER TABLE `antworten` DISABLE KEYS */;
INSERT INTO `antworten` VALUES (1,1,'Diesenteil',1),(2,1,'Hierteil',2),(3,1,'Fürteil',3),(4,1,'Mitteil',4),(5,2,'Werden dort erschaffen',2),(6,2,'Werden wie bei \"Mission Impossible\" von oben abgeseilt',1),(7,2,'Die scheißen einfach drauf',4),(8,2,'Werden per Bogen von einem qualifizierten Schützen dort hingeschossen',3),(9,3,'Das Universum endet',4),(10,3,'Man hat keinen Hunger mehr',1),(11,3,'Man bekommt Flitzekacke',2),(12,3,'Frag nicht so eine Scheiße du Idiot!',3),(13,4,'Mehrzahli',2),(14,4,'Mehrzahlen',1),(15,4,'Multizahl',3),(16,4,'Noch Mehrzahl',4),(17,5,'Ahhhhh!!',2),(18,5,'OOOOHHHHH!!',1),(19,5,'NICHT AUFHÖREN! JAAA!',3),(20,5,'TIEFER. TIEFER. OMG!!',4);
/*!40000 ALTER TABLE `antworten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fragen`
--

DROP TABLE IF EXISTS `fragen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fragen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fragentext` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fragen`
--

LOCK TABLES `fragen` WRITE;
/*!40000 ALTER TABLE `fragen` DISABLE KEYS */;
INSERT INTO `fragen` VALUES (1,'Beispielfrage 1 - Was ist das Gegenteil von Gegenteil?'),(2,'Beispielfrage 2 - Wie kommen die \'nicht betreten\' Schilder in die Mitte des Rasens'),(3,'Beispielfrage 3 - Was passiert wenn man Pasta und Antipasti gemeinsam isst?'),(4,'Beispielfrage 4 - Was ist die Mehrzahl von Mehrzahl?'),(5,'Beispielfrage 5 - Was bedeutet ein \"befriedigend\" von Stiftung Warentests bei Vibratoren?');
/*!40000 ALTER TABLE `fragen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hausinfos`
--

DROP TABLE IF EXISTS `hausinfos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `hausinfos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hausname` varchar(255) DEFAULT NULL,
  `infotext` text,
  `hintergrundfarbe` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hausinfos`
--

LOCK TABLES `hausinfos` WRITE;
/*!40000 ALTER TABLE `hausinfos` DISABLE KEYS */;
INSERT INTO `hausinfos` VALUES (1,'Gryffindor','Gryffindor ist eines der vier Häuser der Hogwartsschule für Hexerei und Zauberei und wurde von Godric Gryffindor gegründet. Sein Wappentier ist der Löwe und seine Farben sind Scharlachrot und Gold. Minerva McGonagall ist die Hauslehrerin Gryffindors. Sir Nicholas de Mimsy-Porpington, auch bekannt als \"Der Fast Kopflose Nick\", ist der Hausgeist von Gryffindor. Die besonderen Eigenschaften der Schüler dieses Hauses sind Mut und Ritterlichkeit. Traditionell hat Gryffindor eine besondere Rivalität mit dem Haus Slytherin.','#E83707'),(2,'Hufflepuff','Hufflepuff ist eines der vier Häuser der Hogwartsschule für Hexerei und Zauberei und wurde von Helga Hufflepuff gegründet. Das Wappentier ist der Dachs und die Farben sind schwarz und gelb. Hufflepuff zeichnet sich besonders durch treue Freunde aus, aber auch Schüler, die willig sind, zu lernen. Auch steht Gerechtigkeit bei ihnen hoch im Kurs. Obwohl Hufflepuff oft bei den anderen Häusern um sein Ansehen kämpfen muss, haben sie viele erfolgreiche und berühmte Hexen und Zauberer hervorgebracht. Hufflepuff ist das Haus mit den wenigsten dunklen Zauberern. Bei der Schlacht von Hogwarts hat Hufflepuff abermals seine Loyalität und Treue bewiesen, als sie sich ohne zu zögern sofort auf die Seite der Schule gestellt haben und neben Gryffindor die zweitgrößte Anzahl von Schülern, die mitkämpften.','#FFE22A'),(3,'Ravenclaw','In Ravenclaw sind besonders kluge und gelehrte Köpfe. Nur die Intelligentesten kommen nach Ravenclaw. Die Vertrauensschülerin Gemma Farley sagt über sie, dass sie ein so ausgeprägtes Konkurrenzdenken besitzen, dass sie Leuten in den Rücken fallen oder verraten, wenn es um Leistungen geht. Sie wollen stets die Besten sein. ','#5EA9FF'),(4,'Slytherin','Slytherin ist eines der vier Häuser der Hogwartsschule für Hexerei und Zauberei und beherbergt vor allem Schüler, die Eigenschaften wie List, Einfallsreichtum und Ehrgeiz aufweisen. Sein Wappentier ist die Schlange und seine Farben sind Grün und Silber. Der Hausgeist Slytherins ist der Blutige Baron. Das Haus besteht, aufgrund des Misstrauens des Gründers Salazar Slytherin gegenüber muggelstämmigen Hexen und Zauberern, größtenteils aus reinblütigen, teils aber auch halbblütigen Schülern. Das Haus Slytherin hat einen schlechten Ruf, da viele behaupten, es wäre die Quelle einer Vielzahl dunkler Magier in Großbritannien. Zauberer wie Tom Riddle, sowie viele seiner Todesser untermauern dieses Vorurteil. Slytherin pflegt eine sehr große Rivalität mit dem Hause Gryffindor.','#15C558');
/*!40000 ALTER TABLE `hausinfos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `id_letzte_frage` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_letzteFrage_idx` (`id_letzte_frage`),
  CONSTRAINT `fk_letzteFrage` FOREIGN KEY (`id_letzte_frage`) REFERENCES `fragen` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_antworten`
--

DROP TABLE IF EXISTS `users_antworten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users_antworten` (
  `id_user` int(11) NOT NULL,
  `id_antwort` int(11) NOT NULL,
  PRIMARY KEY (`id_user`,`id_antwort`),
  KEY `antwort_fk_idx` (`id_antwort`),
  KEY `user_fk_idx` (`id_user`),
  CONSTRAINT `antwort_fk` FOREIGN KEY (`id_antwort`) REFERENCES `antworten` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `user_fk` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_antworten`
--

LOCK TABLES `users_antworten` WRITE;
/*!40000 ALTER TABLE `users_antworten` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_antworten` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-07-01  1:35:33
