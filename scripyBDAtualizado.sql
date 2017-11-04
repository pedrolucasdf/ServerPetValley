CREATE DATABASE `petvalley` /*!40100 DEFAULT CHARACTER SET latin1 */;
CREATE TABLE `address` (
  `ID_ADDRESS` int(11) NOT NULL AUTO_INCREMENT,
  `POSTAL_CODE` varchar(8) NOT NULL,
  `LOCATION` varchar(255) NOT NULL,
  `TYPE_LOCATION` varchar(45) NOT NULL,
  `NEIGHBORHOOD` varchar(255) NOT NULL,
  `CITY` varchar(255) NOT NULL,
  `STATE` varchar(2) NOT NULL,
  `NUMBER_HOUSE` int(11) NOT NULL,
  `COMPLEMENT` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_ADDRESS`),
  UNIQUE KEY `ID_ADDRESS_UNIQUE` (`ID_ADDRESS`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

CREATE TABLE `adoption` (
  `ID_USER_FK` int(11) NOT NULL,
  `ID_ANIMAL_FK` int(11) NOT NULL,
  `ADOPTION_DATE` datetime NOT NULL,
  PRIMARY KEY (`ID_USER_FK`,`ID_ANIMAL_FK`),
  UNIQUE KEY `ID_ANIMAL_FK_UNIQUE` (`ID_ANIMAL_FK`),
  KEY `fk_EXTERNAL_USER_has_ANIMAL_ANIMAL1_idx` (`ID_ANIMAL_FK`),
  KEY `fk_EXTERNAL_USER_has_ANIMAL_EXTERNAL_USER1_idx` (`ID_USER_FK`),
  CONSTRAINT `fk_EXTERNAL_USER_has_ANIMAL_ANIMAL1` FOREIGN KEY (`ID_ANIMAL_FK`) REFERENCES `animal` (`ID_ANIMAL`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EXTERNAL_USER_has_ANIMAL_EXTERNAL_USER1` FOREIGN KEY (`ID_USER_FK`) REFERENCES `external_user` (`ID_USER_FK`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `animal` (
  `ID_ANIMAL` int(11) NOT NULL AUTO_INCREMENT,
  `SIZE` varchar(7) NOT NULL,
  `COAT` varchar(5) NOT NULL,
  `AGE` varchar(8) NOT NULL,
  `NEUTERED` tinyint(4) NOT NULL,
  `VERMIFUGES` tinyint(4) NOT NULL,
  `NAME` varchar(45) NOT NULL,
  `DESCRIPTION` varchar(256) NOT NULL,
  `SPECIES` varchar(10) DEFAULT NULL,
  `SEX` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID_ANIMAL`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE `document` (
  `ID_DOCUMENT` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE_DOCUMENT` varchar(45) NOT NULL,
  `IMAGE_DOCUMENT` blob NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  `ID_USER_FK` int(11) NOT NULL,
  PRIMARY KEY (`ID_DOCUMENT`),
  UNIQUE KEY `ID_DOCUMENT_UNIQUE` (`ID_DOCUMENT`),
  KEY `fk_DOCUMENT_EXTERNAL_USER1_idx` (`ID_USER_FK`),
  CONSTRAINT `fk_DOCUMENT_EXTERNAL_USER1` FOREIGN KEY (`ID_USER_FK`) REFERENCES `external_user` (`ID_USER_FK`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `external_user` (
  `ID_USER_FK` int(11) NOT NULL,
  `ID_QUESTIONNAIRE_FK` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_USER_FK`),
  UNIQUE KEY `ID_USER_FK_UNIQUE` (`ID_USER_FK`),
  KEY `fk_EXTERNAL_USER_QUESTIONNAIRE1_idx` (`ID_QUESTIONNAIRE_FK`),
  CONSTRAINT `fk_EXTERNAL_USER_QUESTIONNAIRE1` FOREIGN KEY (`ID_QUESTIONNAIRE_FK`) REFERENCES `questionnaire` (`ID_QUESTIONNAIRE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EXTERNAL_USER_USER1` FOREIGN KEY (`ID_USER_FK`) REFERENCES `user` (`ID_USER`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `immunization` (
  `ID_IMMUNIZATION` int(11) NOT NULL AUTO_INCREMENT,
  `NAME_VACCINE` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  `EXPIRATION_DATE` datetime NOT NULL,
  PRIMARY KEY (`ID_IMMUNIZATION`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `immunization_card` (
  `IMMUNIZATION_DATE` int(11) NOT NULL AUTO_INCREMENT,
  `ID_ANIMAL_FK` int(11) NOT NULL,
  `ID_IMMUNIZATION_FK` int(11) NOT NULL,
  PRIMARY KEY (`IMMUNIZATION_DATE`,`ID_ANIMAL_FK`,`ID_IMMUNIZATION_FK`),
  KEY `fk_IMMUNIZATION_CARD_ANIMAL1_idx` (`ID_ANIMAL_FK`),
  KEY `fk_IMMUNIZATION_CARD_IMMUNIZATION1_idx` (`ID_IMMUNIZATION_FK`),
  CONSTRAINT `fk_IMMUNIZATION_CARD_ANIMAL1` FOREIGN KEY (`ID_ANIMAL_FK`) REFERENCES `animal` (`ID_ANIMAL`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_IMMUNIZATION_CARD_IMMUNIZATION1` FOREIGN KEY (`ID_IMMUNIZATION_FK`) REFERENCES `immunization` (`ID_IMMUNIZATION`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `internal_user` (
  `POST` varchar(45) NOT NULL,
  `ADMISSION_DATE` datetime NOT NULL,
  `SHIFT` varchar(8) NOT NULL,
  `IS_VOLUNTEER` tinyint(4) NOT NULL,
  `WORK_DAYS` varchar(255) NOT NULL,
  `DEMISSION_DATE` datetime DEFAULT NULL,
  `CRMV` varchar(10) DEFAULT NULL,
  `CRMV_UF` varchar(2) DEFAULT NULL,
  `ID_USER_FK` int(11) NOT NULL,
  `ID_USER_GROUPS_FK` int(11) NOT NULL,
  PRIMARY KEY (`ID_USER_FK`),
  KEY `fk_INTERNAL_USER_USER_GROUPS1_idx` (`ID_USER_GROUPS_FK`),
  CONSTRAINT `fk_INTERNAL_USER_USER1` FOREIGN KEY (`ID_USER_FK`) REFERENCES `user` (`ID_USER`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_INTERNAL_USER_USER_GROUPS1` FOREIGN KEY (`ID_USER_GROUPS_FK`) REFERENCES `user_groups` (`ID_USER_GROUPS`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `pet_images` (
  `ID_PET_IMAGES` int(11) NOT NULL AUTO_INCREMENT,
  `IMAGE` varchar(16000) DEFAULT NULL,
  `ID_ANIMAL_FK` int(11) NOT NULL,
  PRIMARY KEY (`ID_PET_IMAGES`),
  KEY `fk_PET_IMAGES_ANIMAL1_idx` (`ID_ANIMAL_FK`),
  CONSTRAINT `fk_PET_IMAGES_ANIMAL1` FOREIGN KEY (`ID_ANIMAL_FK`) REFERENCES `animal` (`ID_ANIMAL`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `questionnaire` (
  `ID_QUESTIONNAIRE` int(11) NOT NULL AUTO_INCREMENT,
  `QUESTION_1` int(11) NOT NULL,
  `QUESTION_2` varchar(3) NOT NULL,
  `QUESTION_3` varchar(16) NOT NULL,
  `QUESTION_3-1` varchar(12) NOT NULL,
  `QUESTION_4` varchar(3) NOT NULL,
  `QUESTION_4-1` varchar(8) NOT NULL,
  `QUESTION_4-2` varchar(3) NOT NULL,
  `QUESTION_5` varchar(3) NOT NULL,
  `QUESTION_5_COMPLEMENT` varchar(50) NOT NULL,
  `QUESTION_6` decimal(9,0) NOT NULL,
  `QUESTION_7` varchar(3) NOT NULL,
  `QUESTION_7-1` varchar(50) NOT NULL,
  `QUESTION_7-2` varchar(50) NOT NULL,
  `QUIZ_DATE` datetime NOT NULL,
  `QUESTIONS_FILE` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_QUESTIONNAIRE`),
  UNIQUE KEY `ID_QUESTIONNAIRE_UNIQUE` (`ID_QUESTIONNAIRE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `service_proposal` (
  `ID_SERVICE_PROPOSAL` int(11) NOT NULL AUTO_INCREMENT,
  `DATE_SERVICE` datetime NOT NULL,
  `APPROVED` tinyint(4) NOT NULL,
  `ID_TYPE_SERVICE_FK` int(11) NOT NULL,
  `ID_USER_FK` int(11) NOT NULL,
  PRIMARY KEY (`ID_SERVICE_PROPOSAL`),
  UNIQUE KEY `ID_SERVICE_PROPOSAL_UNIQUE` (`ID_SERVICE_PROPOSAL`),
  KEY `fk_SERVICE_PROPOSAL_TYPE_SERVICE1_idx` (`ID_TYPE_SERVICE_FK`),
  KEY `fk_SERVICE_PROPOSAL_EXTERNAL_USER1_idx` (`ID_USER_FK`),
  CONSTRAINT `fk_SERVICE_PROPOSAL_EXTERNAL_USER1` FOREIGN KEY (`ID_USER_FK`) REFERENCES `external_user` (`ID_USER_FK`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_SERVICE_PROPOSAL_TYPE_SERVICE1` FOREIGN KEY (`ID_TYPE_SERVICE_FK`) REFERENCES `type_service` (`ID_TYPE_SERVICE`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `supply` (
  `ID_SUPPLY` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(255) NOT NULL,
  `EXPIRATION_DATE` datetime NOT NULL,
  `ENTRY_DATE` datetime NOT NULL,
  `QUANTITY` int(11) NOT NULL,
  `UPTADE_DATE` datetime DEFAULT NULL,
  `ID_USER_FK` int(11) NOT NULL,
  `ID_TYPE_SUPPLY` int(11) NOT NULL,
  PRIMARY KEY (`ID_SUPPLY`),
  UNIQUE KEY `ID_SUPPLY_UNIQUE` (`ID_SUPPLY`),
  KEY `fk_SUPPLY_INTERNAL_USER1_idx` (`ID_USER_FK`),
  KEY `fk_SUPPLY_TYPE_SUPPLY1_idx` (`ID_TYPE_SUPPLY`),
  CONSTRAINT `fk_SUPPLY_INTERNAL_USER1` FOREIGN KEY (`ID_USER_FK`) REFERENCES `internal_user` (`ID_USER_FK`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_SUPPLY_TYPE_SUPPLY1` FOREIGN KEY (`ID_TYPE_SUPPLY`) REFERENCES `type_supply` (`ID_TYPE_SUPPLY`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `type_service` (
  `ID_TYPE_SERVICE` int(11) NOT NULL AUTO_INCREMENT,
  `NAME_SERVICE` varchar(45) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_TYPE_SERVICE`),
  UNIQUE KEY `ID_TYPE_SERVICE_UNIQUE` (`ID_TYPE_SERVICE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `type_supply` (
  `ID_TYPE_SUPPLY` int(11) NOT NULL AUTO_INCREMENT,
  `NAME_SUPPLY` varchar(45) NOT NULL,
  `UNIT` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_TYPE_SUPPLY`),
  UNIQUE KEY `ID_TYPE_SUPPLY_UNIQUE` (`ID_TYPE_SUPPLY`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user` (
  `ID_USER` int(11) NOT NULL AUTO_INCREMENT,
  `CODE_CPF` varchar(11) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `SURNAME` varchar(45) NOT NULL,
  `BIRTHDATE` datetime NOT NULL,
  `SEX` varchar(9) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `PASSWORD` varchar(32) NOT NULL,
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CELLPHONE` varchar(11) NOT NULL,
  `PHONE_NUMBER` varchar(11) DEFAULT NULL,
  `IMAGE` varchar(16000) DEFAULT NULL,
  `ID_ADDRESS_FK` int(11) NOT NULL,
  PRIMARY KEY (`ID_USER`),
  UNIQUE KEY `ID_USER_UNIQUE` (`ID_USER`),
  KEY `fk_USER_ADDRESS_idx` (`ID_ADDRESS_FK`),
  CONSTRAINT `fk_USER_ADDRESS` FOREIGN KEY (`ID_ADDRESS_FK`) REFERENCES `address` (`ID_ADDRESS`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

CREATE TABLE `user_groups` (
  `ID_USER_GROUPS` int(11) NOT NULL AUTO_INCREMENT,
  `NAME_GROUP` varchar(15) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_USER_GROUPS`),
  UNIQUE KEY `ID_USER_GROUPS_UNIQUE` (`ID_USER_GROUPS`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `visit_animal` (
  `ID_VISIT_ANIMAL` int(11) NOT NULL AUTO_INCREMENT,
  `VISIT_DATE` datetime NOT NULL,
  `ID_USER_FK` int(11) NOT NULL,
  PRIMARY KEY (`ID_VISIT_ANIMAL`),
  UNIQUE KEY `ID_VISIT_ANIMAL_UNIQUE` (`ID_VISIT_ANIMAL`),
  KEY `fk_VISIT_ANIMAL_EXTERNAL_USER1_idx` (`ID_USER_FK`),
  CONSTRAINT `fk_VISIT_ANIMAL_EXTERNAL_USER1` FOREIGN KEY (`ID_USER_FK`) REFERENCES `external_user` (`ID_USER_FK`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `visit_house` (
  `ID_VISIT_HOUSE` int(11) NOT NULL AUTO_INCREMENT,
  `VISIT_DATE` datetime NOT NULL,
  `IS_VISIT` tinyint(4) NOT NULL,
  `DESCRIPTION` varchar(255) NOT NULL,
  `INTERNAL_ID_USER_FK` int(11) NOT NULL,
  `EXTERNAL_ID_USER_FK` int(11) NOT NULL,
  PRIMARY KEY (`ID_VISIT_HOUSE`),
  UNIQUE KEY `ID_VISIT_HOUSE_UNIQUE` (`ID_VISIT_HOUSE`),
  KEY `fk_VISIT_HOUSE_INTERNAL_USER1_idx` (`INTERNAL_ID_USER_FK`),
  KEY `fk_VISIT_HOUSE_EXTERNAL_USER1_idx` (`EXTERNAL_ID_USER_FK`),
  CONSTRAINT `fk_VISIT_HOUSE_EXTERNAL_USER1` FOREIGN KEY (`EXTERNAL_ID_USER_FK`) REFERENCES `external_user` (`ID_USER_FK`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_VISIT_HOUSE_INTERNAL_USER1` FOREIGN KEY (`INTERNAL_ID_USER_FK`) REFERENCES `internal_user` (`ID_USER_FK`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
