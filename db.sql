-- MySQL Script generated by MySQL Workbench
-- 03/12/15 10:56:34
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema calendar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema calendar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `calendar` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `calendar` ;

-- -----------------------------------------------------
-- Table `calendar`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendar`.`roles` (
  `id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendar`.`user` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` CHAR(128) NOT NULL,
  `roles_id` INT NOT NULL,
  PRIMARY KEY (`id`, `roles_id`),
  INDEX `fk_user_roles1_idx` (`roles_id` ASC),
  CONSTRAINT `fk_user_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `calendar`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar`.`event_repetition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendar`.`event_repetition` (
  `id` INT NOT NULL,
  `intervall` INT NULL,
  `repetiton_stop` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendar`.`event` (
  `id` INT NOT NULL,
  `description` VARCHAR(255) NULL,
  `start` DATETIME NOT NULL,
  `end` DATETIME NOT NULL,
  `event_repetition_id` INT NOT NULL,
  `created_by` INT NOT NULL,
  `last_modifyed` DATETIME NULL,
  `last_modifyed_by` INT NULL,
  PRIMARY KEY (`id`, `event_repetition_id`),
  INDEX `fk_event_event_repetition1_idx` (`event_repetition_id` ASC),
  CONSTRAINT `fk_event_event_repetition1`
    FOREIGN KEY (`event_repetition_id`)
    REFERENCES `calendar`.`event_repetition` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar`.`reminder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendar`.`reminder` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `minutes_before` INT NULL,
  `user_id` INT NOT NULL,
  `user_roles_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  `event_event_repetition_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`, `user_roles_id`, `event_id`, `event_event_repetition_id`),
  INDEX `fk_reminder_user1_idx` (`user_id` ASC, `user_roles_id` ASC),
  INDEX `fk_reminder_event1_idx` (`event_id` ASC, `event_event_repetition_id` ASC),
  CONSTRAINT `fk_reminder_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `calendar`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reminder_event1`
    FOREIGN KEY (`event_id` , `event_event_repetition_id`)
    REFERENCES `calendar`.`event` (`id` , `event_repetition_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar`.`family`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendar`.`family` (
  `id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar`.`family_has_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendar`.`family_has_event` (
  `family_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  `event_event_repetition_id` INT NOT NULL,
  PRIMARY KEY (`family_id`, `event_id`, `event_event_repetition_id`),
  INDEX `fk_family_has_event_event1_idx` (`event_id` ASC, `event_event_repetition_id` ASC),
  INDEX `fk_family_has_event_family1_idx` (`family_id` ASC),
  CONSTRAINT `fk_family_has_event_family1`
    FOREIGN KEY (`family_id`)
    REFERENCES `calendar`.`family` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_family_has_event_event1`
    FOREIGN KEY (`event_id` , `event_event_repetition_id`)
    REFERENCES `calendar`.`event` (`id` , `event_repetition_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `calendar`.`user_has_family`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calendar`.`user_has_family` (
  `user_id` INT NOT NULL,
  `user_roles_id` INT NOT NULL,
  `family_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `user_roles_id`, `family_id`),
  INDEX `fk_user_has_family_family1_idx` (`family_id` ASC),
  INDEX `fk_user_has_family_user1_idx` (`user_id` ASC, `user_roles_id` ASC),
  CONSTRAINT `fk_user_has_family_user1`
    FOREIGN KEY (`user_id` , `user_roles_id`)
    REFERENCES `calendar`.`user` (`id` , `roles_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_family_family1`
    FOREIGN KEY (`family_id`)
    REFERENCES `calendar`.`family` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
