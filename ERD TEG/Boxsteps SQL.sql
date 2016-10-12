-- MySQL Script generated by MySQL Workbench
-- 10/11/16 23:13:26
-- Model: ERD Boxsteps    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema boxsteps
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema boxsteps
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `boxsteps` DEFAULT CHARACTER SET utf8 ;
USE `boxsteps` ;

-- -----------------------------------------------------
-- Table `boxsteps`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`roles` (
  `id` INT(10) UNSIGNED NOT NULL,
  `role` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`));

CREATE UNIQUE INDEX `uq_role` ON `boxsteps`.`roles` (`role` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`users` (
  `id` INT(10) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `second_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `role_id` INT(10) UNSIGNED NOT NULL,
  `user_id` INT(10) UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_users_roles`
    FOREIGN KEY (`role_id`)
    REFERENCES `boxsteps`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `boxsteps`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE UNIQUE INDEX `uq_email` ON `boxsteps`.`users` (`email` ASC);

CREATE INDEX `fk_users_roles_idx` ON `boxsteps`.`users` (`role_id` ASC);

CREATE INDEX `fk_users_users_idx` ON `boxsteps`.`users` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`messages` (
  `id` INT(10) UNSIGNED NOT NULL,
  `message` TEXT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `user_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_messages_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `boxsteps`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_messages_users_idx` ON `boxsteps`.`messages` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`periods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`periods` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `period` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `boxsteps`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`students` (
  `id` INT(10) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `second_name` VARCHAR(255) NOT NULL,
  `address` TEXT NOT NULL,
  `dni` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `mobile` VARCHAR(255) NULL,
  `phone` VARCHAR(255) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `boxsteps`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`courses` (
  `id` INT(10) UNSIGNED NOT NULL,
  `grade` VARCHAR(255) NOT NULL,
  `section` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `period_id` INT(10) UNSIGNED NOT NULL,
  `student_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_courses_periods`
    FOREIGN KEY (`period_id`)
    REFERENCES `boxsteps`.`periods` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_students`
    FOREIGN KEY (`student_id`)
    REFERENCES `boxsteps`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_courses_periods_idx` ON `boxsteps`.`courses` (`period_id` ASC);

CREATE INDEX `fk_courses_students_idx` ON `boxsteps`.`courses` (`student_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`knowledge_areas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`knowledge_areas` (
  `id` INT(10) UNSIGNED NOT NULL,
  `knowledge_area` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `boxsteps`.`conceptual_sections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`conceptual_sections` (
  `id` INT(10) UNSIGNED NOT NULL,
  `conceptual_section` VARCHAR(100) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `knowledge_area_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_conc_sect_know_area`
    FOREIGN KEY (`knowledge_area_id`)
    REFERENCES `boxsteps`.`knowledge_areas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_conc_sect_know_area_idx` ON `boxsteps`.`conceptual_sections` (`knowledge_area_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`plans` (
  `id` INT(10) UNSIGNED NOT NULL,
  `procedimental_section` TEXT NOT NULL,
  `actitudinal_section` TEXT NOT NULL,
  `competences` TEXT NOT NULL,
  `indicators` TEXT NOT NULL,
  `teaching_strategy` TEXT NOT NULL,
  `teaching_sequence` TEXT NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `score` VARCHAR(255) NULL,
  `completion_time` VARCHAR(255) NULL,
  `observations` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `period_id` INT(10) UNSIGNED NOT NULL,
  `course_id` INT(10) UNSIGNED NOT NULL,
  `conceptual_section_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_plans_periods`
    FOREIGN KEY (`period_id`)
    REFERENCES `boxsteps`.`periods` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plans_courses`
    FOREIGN KEY (`course_id`)
    REFERENCES `boxsteps`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plans_conc_sect`
    FOREIGN KEY (`conceptual_section_id`)
    REFERENCES `boxsteps`.`conceptual_sections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_plans_periods_idx` ON `boxsteps`.`plans` (`period_id` ASC);

CREATE INDEX `fk_plans_courses_idx` ON `boxsteps`.`plans` (`course_id` ASC);

CREATE INDEX `fk_plans_conc_sect_idx` ON `boxsteps`.`plans` (`conceptual_section_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`resources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`resources` (
  `id` INT(10) UNSIGNED NOT NULL,
  `resource` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `plan_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_resources_plans`
    FOREIGN KEY (`plan_id`)
    REFERENCES `boxsteps`.`plans` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_resources_plans_idx` ON `boxsteps`.`resources` (`plan_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`states` (
  `id` INT(10) UNSIGNED NOT NULL,
  `state` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`));

CREATE UNIQUE INDEX `uq_state` ON `boxsteps`.`states` (`state` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`notifications` (
  `id` INT(10) UNSIGNED NOT NULL,
  `notification` TEXT NOT NULL,
  `url` TEXT NULL,
  `icon` VARCHAR(255) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `boxsteps`.`conditions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`conditions` (
  `id` INT(10) UNSIGNED NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `state_id` INT(10) UNSIGNED NOT NULL,
  `plan_id` INT(10) UNSIGNED NULL,
  `user_id` INT(10) UNSIGNED NULL,
  `message_id` INT(10) UNSIGNED NULL,
  `notification_id` INT(10) UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_conditions_messages`
    FOREIGN KEY (`message_id`)
    REFERENCES `boxsteps`.`messages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conditions_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `boxsteps`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conditions_states`
    FOREIGN KEY (`state_id`)
    REFERENCES `boxsteps`.`states` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conditions_plans`
    FOREIGN KEY (`plan_id`)
    REFERENCES `boxsteps`.`plans` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cond_noti`
    FOREIGN KEY (`notification_id`)
    REFERENCES `boxsteps`.`notifications` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_conditions_messages_idx` ON `boxsteps`.`conditions` (`message_id` ASC);

CREATE INDEX `fk_conditions_users_idx` ON `boxsteps`.`conditions` (`user_id` ASC);

CREATE INDEX `fk_conditions_states_idx` ON `boxsteps`.`conditions` (`state_id` ASC);

CREATE INDEX `fk_conditions_plans_idx` ON `boxsteps`.`conditions` (`plan_id` ASC);

CREATE INDEX `fk_cond_noti_idx` ON `boxsteps`.`conditions` (`notification_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`evaluation_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`evaluation_types` (
  `id` INT(10) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `evaluation_type` VARCHAR(255) NOT NULL,
  `maximum_qualification` VARCHAR(255) NOT NULL,
  `minimum_qualification` VARCHAR(255) NOT NULL,
  `approved_qualification` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `boxsteps`.`evaluations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`evaluations` (
  `id` INT(10) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `representative_percentage` VARCHAR(255) NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `course_id` INT(10) UNSIGNED NOT NULL,
  `evaluation_type_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_evaluations_courses`
    FOREIGN KEY (`course_id`)
    REFERENCES `boxsteps`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evaluations_eval_type`
    FOREIGN KEY (`evaluation_type_id`)
    REFERENCES `boxsteps`.`evaluation_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_evaluations_courses_idx` ON `boxsteps`.`evaluations` (`course_id` ASC);

CREATE INDEX `fk_evaluations_eval_type_idx` ON `boxsteps`.`evaluations` (`evaluation_type_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`evaluation_contents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`evaluation_contents` (
  `id` INT(10) UNSIGNED NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `evaluation_id` INT(10) UNSIGNED NOT NULL,
  `conceptual_section_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_eval_cont_conc_sect`
    FOREIGN KEY (`conceptual_section_id`)
    REFERENCES `boxsteps`.`conceptual_sections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eval_cont_evaluations`
    FOREIGN KEY (`evaluation_id`)
    REFERENCES `boxsteps`.`evaluations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_eval_cont_conc_sect_idx` ON `boxsteps`.`evaluation_contents` (`conceptual_section_id` ASC);

CREATE INDEX `fk_eval_cont_evaluations_idx` ON `boxsteps`.`evaluation_contents` (`evaluation_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`evaluation_scales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`evaluation_scales` (
  `id` INT(10) UNSIGNED NOT NULL,
  `notation` VARCHAR(255) NOT NULL,
  `maximum_equivalent` VARCHAR(255) NULL,
  `minimum_equivalent` VARCHAR(255) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `evaluation_type_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_eval_scal_eval_type`
    FOREIGN KEY (`evaluation_type_id`)
    REFERENCES `boxsteps`.`evaluation_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_eval_scal_eval_type_idx` ON `boxsteps`.`evaluation_scales` (`evaluation_type_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`qualifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`qualifications` (
  `id` INT(10) UNSIGNED NOT NULL,
  `qualification` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `evaluation_id` INT(10) UNSIGNED NOT NULL,
  `student_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_qual_eval`
    FOREIGN KEY (`evaluation_id`)
    REFERENCES `boxsteps`.`evaluations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_qual_stud`
    FOREIGN KEY (`student_id`)
    REFERENCES `boxsteps`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_qual_eval_idx` ON `boxsteps`.`qualifications` (`evaluation_id` ASC);

CREATE INDEX `fk_qual_stud_idx` ON `boxsteps`.`qualifications` (`student_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`features` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `feature` VARCHAR(255) NOT NULL,
  `url` TEXT NOT NULL,
  `icon` VARCHAR(255) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `feature_id` INT(10) UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_features_features`
    FOREIGN KEY (`feature_id`)
    REFERENCES `boxsteps`.`features` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_features_features_idx` ON `boxsteps`.`features` (`feature_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`permissions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `feature_id` INT(10) UNSIGNED NOT NULL,
  `role_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_permissions_features`
    FOREIGN KEY (`feature_id`)
    REFERENCES `boxsteps`.`features` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissions_roles`
    FOREIGN KEY (`role_id`)
    REFERENCES `boxsteps`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_permissions_features_idx` ON `boxsteps`.`permissions` (`feature_id` ASC);

CREATE INDEX `fk_permissions_roles_idx` ON `boxsteps`.`permissions` (`role_id` ASC);


-- -----------------------------------------------------
-- Table `boxsteps`.`institutions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boxsteps`.`institutions` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `institution` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(255) NOT NULL,
  `address` TEXT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
