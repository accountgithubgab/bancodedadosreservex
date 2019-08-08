-- MySQL Script generated by MySQL Workbench
-- Thu Aug  8 12:26:36 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ReservApp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ReservApp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ReservApp` DEFAULT CHARACTER SET utf8 ;
USE `ReservApp` ;

-- -----------------------------------------------------
-- Table `ReservApp`.`Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReservApp`.`Professor` ;

CREATE TABLE IF NOT EXISTS `ReservApp`.`Professor` (
  `idProfessor` INT NOT NULL AUTO_INCREMENT,
  `NOME_PROFESSOR` VARCHAR(45) NOT NULL,
  `DISCIPLINA` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProfessor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ReservApp`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReservApp`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `ReservApp`.`Usuario` (
  `IDUSUARIO` INT NOT NULL,
  `TIPO_USER` INT NOT NULL,
  `USER` VARCHAR(45) NOT NULL,
  `Professor_idProfessor` INT NOT NULL,
  PRIMARY KEY (`IDUSUARIO`, `Professor_idProfessor`),
  INDEX `fk_Usuario_Professor1_idx` (`Professor_idProfessor` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `ReservApp`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ReservApp`.`Telefone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReservApp`.`Telefone` ;

CREATE TABLE IF NOT EXISTS `ReservApp`.`Telefone` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT,
  `TIPO` ENUM('F', 'C', 'R') NOT NULL,
  `NUMERO` VARCHAR(20) NOT NULL,
  `Professor_idProfessor` INT NOT NULL,
  PRIMARY KEY (`idTelefone`, `Professor_idProfessor`),
  INDEX `fk_Telefone_Professor1_idx` (`Professor_idProfessor` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `ReservApp`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ReservApp`.`Empresas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReservApp`.`Empresas` ;

CREATE TABLE IF NOT EXISTS `ReservApp`.`Empresas` (
  `IDEMPRESAS` INT NOT NULL AUTO_INCREMENT,
  `NOME_EMPRESA` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(20) NOT NULL,
  `TIPO_CADASTRO` ENUM('F', 'J', 'O') NOT NULL,
  `Usuario_IDUSUARIO` INT NOT NULL,
  `Telefone_idTelefone` INT NOT NULL,
  PRIMARY KEY (`IDEMPRESAS`, `Usuario_IDUSUARIO`, `Telefone_idTelefone`),
  INDEX `fk_Empresas_Usuario1_idx` (`Usuario_IDUSUARIO` ASC) VISIBLE,
  INDEX `fk_Empresas_Telefone1_idx` (`Telefone_idTelefone` ASC) VISIBLE,
  CONSTRAINT `fk_Empresas_Usuario1`
    FOREIGN KEY (`Usuario_IDUSUARIO`)
    REFERENCES `ReservApp`.`Usuario` (`IDUSUARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresas_Telefone1`
    FOREIGN KEY (`Telefone_idTelefone`)
    REFERENCES `ReservApp`.`Telefone` (`idTelefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ReservApp`.`Turma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReservApp`.`Turma` ;

CREATE TABLE IF NOT EXISTS `ReservApp`.`Turma` (
  `IDTURMA` INT NOT NULL AUTO_INCREMENT,
  `TURMA` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`IDTURMA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ReservApp`.`Sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReservApp`.`Sala` ;

CREATE TABLE IF NOT EXISTS `ReservApp`.`Sala` (
  `IDSALA` INT NOT NULL AUTO_INCREMENT,
  `NUMERO_SALA` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`IDSALA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ReservApp`.`Turma_has_Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReservApp`.`Turma_has_Professor` ;

CREATE TABLE IF NOT EXISTS `ReservApp`.`Turma_has_Professor` (
  `Turma_IDTURMA` INT NOT NULL,
  `Professor_idProfessor` INT NOT NULL,
  PRIMARY KEY (`Turma_IDTURMA`, `Professor_idProfessor`),
  INDEX `fk_Turma_has_Professor_Professor1_idx` (`Professor_idProfessor` ASC) VISIBLE,
  INDEX `fk_Turma_has_Professor_Turma1_idx` (`Turma_IDTURMA` ASC) VISIBLE,
  CONSTRAINT `fk_Turma_has_Professor_Turma1`
    FOREIGN KEY (`Turma_IDTURMA`)
    REFERENCES `ReservApp`.`Turma` (`IDTURMA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turma_has_Professor_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `ReservApp`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ReservApp`.`Empresas_has_Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReservApp`.`Empresas_has_Professor` ;

CREATE TABLE IF NOT EXISTS `ReservApp`.`Empresas_has_Professor` (
  `Empresas_IDEMPRESAS` INT NOT NULL,
  `Empresas_Usuario_IDUSUARIO` INT NOT NULL,
  `Empresas_Telefone_idTelefone` INT NOT NULL,
  `Professor_idProfessor` INT NOT NULL,
  PRIMARY KEY (`Empresas_IDEMPRESAS`, `Empresas_Usuario_IDUSUARIO`, `Empresas_Telefone_idTelefone`, `Professor_idProfessor`),
  INDEX `fk_Empresas_has_Professor_Professor1_idx` (`Professor_idProfessor` ASC) VISIBLE,
  INDEX `fk_Empresas_has_Professor_Empresas1_idx` (`Empresas_IDEMPRESAS` ASC, `Empresas_Usuario_IDUSUARIO` ASC, `Empresas_Telefone_idTelefone` ASC) VISIBLE,
  CONSTRAINT `fk_Empresas_has_Professor_Empresas1`
    FOREIGN KEY (`Empresas_IDEMPRESAS` , `Empresas_Usuario_IDUSUARIO` , `Empresas_Telefone_idTelefone`)
    REFERENCES `ReservApp`.`Empresas` (`IDEMPRESAS` , `Usuario_IDUSUARIO` , `Telefone_idTelefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresas_has_Professor_Professor1`
    FOREIGN KEY (`Professor_idProfessor`)
    REFERENCES `ReservApp`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ReservApp`.`RESERVA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReservApp`.`RESERVA` ;

CREATE TABLE IF NOT EXISTS `ReservApp`.`RESERVA` (
  `IDRESERVA` INT NOT NULL AUTO_INCREMENT,
  `HORARIO` VARCHAR(10) NOT NULL,
  `DATA` DATE NOT NULL,
  `TIME` VARCHAR(45) NOT NULL,
  `DESCRIÇÃO` LONGTEXT NOT NULL,
  `Sala_IDSALA` INT NOT NULL,
  PRIMARY KEY (`IDRESERVA`, `Sala_IDSALA`),
  INDEX `fk_RESERVA_Sala1_idx` (`Sala_IDSALA` ASC) VISIBLE,
  CONSTRAINT `fk_RESERVA_Sala1`
    FOREIGN KEY (`Sala_IDSALA`)
    REFERENCES `ReservApp`.`Sala` (`IDSALA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
