-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pay_assistant_db
-- -----------------------------------------------------
-- Autores: Efraim Cuevas Aguilary Jose Julián Monge Brenes

-- -----------------------------------------------------
-- Schema pay_assistant_db
--
-- Autores: Efraim Cuevas Aguilary Jose Julián Monge Brenes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pay_assistant_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `pay_assistant_db` ;

-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_users` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(80) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `password` VARBINARY(250) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_media_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_media_types` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_media_types` (
  `media_type_id` TINYINT(1) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`media_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_media_files`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_media_files` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_media_files` (
  `media_file_id` INT NOT NULL AUTO_INCREMENT,
  `URL` VARCHAR(200) NOT NULL,
  `deleted` BIT(1) NOT NULL DEFAULT 0,
  `media_type_id` TINYINT(1) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`media_file_id`),
  INDEX `fk_pay_media_files_pay_media_types_idx` (`media_type_id` ASC) VISIBLE,
  INDEX `fk_pay_media_files_pay_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_media_files_pay_media_types`
    FOREIGN KEY (`media_type_id`)
    REFERENCES `pay_assistant_db`.`pay_media_types` (`media_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_media_files_pay_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_roles` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_roles` (
  `role_id` TINYINT(1) NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_modules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_modules` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_modules` (
  `module_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`module_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_permissions` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_permissions` (
  `permission_id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(200) NOT NULL,
  `code` VARCHAR(10) NOT NULL,
  `module_id` INT NOT NULL,
  PRIMARY KEY (`permission_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE,
  INDEX `fk_pay_permissions_pay_modules1_idx` (`module_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_permissions_pay_modules1`
    FOREIGN KEY (`module_id`)
    REFERENCES `pay_assistant_db`.`pay_modules` (`module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_role_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_role_permissions` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_role_permissions` (
  `role_permission_id` INT NOT NULL AUTO_INCREMENT,
  `role_id` TINYINT(1) NOT NULL,
  `permission_id` INT NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `deleted` BIT(1) NOT NULL DEFAULT 0,
  `last_perm_update` DATETIME NOT NULL DEFAULT NOW(),
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  PRIMARY KEY (`role_permission_id`),
  INDEX `fk_pay_role_permissions_pay_roles1_idx` (`role_id` ASC) VISIBLE,
  INDEX `fk_pay_role_permissions_pay_permissions1_idx` (`permission_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_role_permissions_pay_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `pay_assistant_db`.`pay_roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_role_permissions_pay_permissions1`
    FOREIGN KEY (`permission_id`)
    REFERENCES `pay_assistant_db`.`pay_permissions` (`permission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_user_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_user_permissions` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_user_permissions` (
  `user_permission_id` INT NOT NULL AUTO_INCREMENT,
  `permission_id` INT NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `deleted` BIT(1) NOT NULL DEFAULT 0,
  `last_perm_update` DATETIME NOT NULL DEFAULT NOW(),
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`user_permission_id`),
  INDEX `fk_pay_role_permissions_pay_permissions1_idx` (`permission_id` ASC) VISIBLE,
  INDEX `fk_pay_user_permissions_pay_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_role_permissions_pay_permissions10`
    FOREIGN KEY (`permission_id`)
    REFERENCES `pay_assistant_db`.`pay_permissions` (`permission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_user_permissions_pay_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_user_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_user_roles` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_user_roles` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `role_id` TINYINT(1) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `deleted` BIT(1) NOT NULL DEFAULT 0,
  `last_update` DATETIME NOT NULL DEFAULT NOW(),
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  INDEX `fk_pay_users_has_pay_roles_pay_roles1_idx` (`role_id` ASC) VISIBLE,
  INDEX `fk_pay_users_has_pay_roles_pay_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_users_has_pay_roles_pay_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_users_has_pay_roles_pay_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `pay_assistant_db`.`pay_roles` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`api_integrations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`api_integrations` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`api_integrations` (
  `api_integration_id` SMALLINT(1) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `provider_name` VARCHAR(80) NOT NULL,
  `public_key` VARCHAR(200) NULL,
  `private_key` VARCHAR(200) NULL,
  `url` VARCHAR(250) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `creation_date` DATETIME NOT NULL,
  `last_update` DATETIME NOT NULL,
  PRIMARY KEY (`api_integration_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_pay_method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_pay_method` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_pay_method` (
  `pay_method_id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `api_url` VARCHAR(200) NOT NULL,
  `secret_key` VARBINARY(255) NOT NULL,
  `key` VARCHAR(255) NOT NULL,
  `logo_icon_url` VARCHAR(200) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `api_integration_id` SMALLINT(1) NOT NULL,
  PRIMARY KEY (`pay_method_id`),
  INDEX `fk_pay_pay_method_api_integrations1_idx` (`api_integration_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_pay_method_api_integrations1`
    FOREIGN KEY (`api_integration_id`)
    REFERENCES `pay_assistant_db`.`api_integrations` (`api_integration_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_available_pay_methods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_available_pay_methods` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_available_pay_methods` (
  `available_method_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `user_id` INT NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `expToken` DATE NOT NULL,
  `mask_account` VARCHAR(50) NOT NULL,
  `method_id` INT NOT NULL,
  PRIMARY KEY (`available_method_id`),
  INDEX `fk_pay_available_media_pay_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_pay_available_media_pay_pay_method1_idx` (`method_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_available_media_pay_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_available_media_pay_pay_method1`
    FOREIGN KEY (`method_id`)
    REFERENCES `pay_assistant_db`.`pay_pay_method` (`pay_method_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_countries` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_countries` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_currencies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_currencies` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_currencies` (
  `currency_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `acronym` VARCHAR(5) NOT NULL,
  `symbol` VARCHAR(5) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`currency_id`),
  INDEX `fk_pay_currencies_pay_countries1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_currencies_pay_countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `pay_assistant_db`.`pay_countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_payments` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `available_method_id` INT NOT NULL,
  `currency_id` INT NOT NULL,
  `amount` DECIMAL(9,2) NOT NULL,
  `date_pay` DATE NOT NULL,
  `confirmed` BIT(1) NOT NULL DEFAULT 0,
  `result` VARCHAR(200) NOT NULL DEFAULT 'En proceso',
  `auth` VARCHAR(60) NOT NULL,
  `reference` VARCHAR(100) NOT NULL,
  `charge_token` VARBINARY(255) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `error` VARCHAR(200) NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `method_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_pay_pays_pay_pay_method1_idx` (`method_id` ASC) VISIBLE,
  INDEX `fk_pay_payments_pay_available_pay_methods1_idx` (`available_method_id` ASC) VISIBLE,
  INDEX `fk_pay_payments_pay_currency1_idx` (`currency_id` ASC) VISIBLE,
  UNIQUE INDEX `method_id_UNIQUE` (`method_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_pays_pay_pay_method1`
    FOREIGN KEY (`method_id`)
    REFERENCES `pay_assistant_db`.`pay_pay_method` (`pay_method_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_payments_pay_available_pay_methods1`
    FOREIGN KEY (`available_method_id`)
    REFERENCES `pay_assistant_db`.`pay_available_pay_methods` (`available_method_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_payments_pay_currency1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `pay_assistant_db`.`pay_currencies` (`currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_transaction_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_transaction_types` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_transaction_types` (
  `transaction_type_id` INT NOT NULL AUTO_INCREMENT,
  `name(45)` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`transaction_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_transaction_subtypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_transaction_subtypes` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_transaction_subtypes` (
  `transaction_subtype_id` INT NOT NULL AUTO_INCREMENT,
  `name(45)` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`transaction_subtype_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_transactions` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_transactions` (
  `transactions_id` INT NOT NULL AUTO_INCREMENT,
  `payment_id` INT NULL,
  `date` DATETIME NOT NULL,
  `post_time` DATETIME NOT NULL,
  `ref_number` VARCHAR(50) NOT NULL,
  `user_id` INT NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `exchange_rate` DECIMAL(12,3) NOT NULL,
  `converted_amount` DECIMAL(12,2) NOT NULL,
  `transaction_types_id` INT NOT NULL,
  `transaction_subtypes_id` INT NOT NULL,
  `amount` DECIMAL(12,2) NULL,
  PRIMARY KEY (`transactions_id`),
  INDEX `fk_pay_transactions_pay_pays1_idx` (`payment_id` ASC) VISIBLE,
  INDEX `fk_pay_transactions_pay_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_pay_transactions_pay_transaction_types1_idx` (`transaction_types_id` ASC) VISIBLE,
  INDEX `fk_pay_transactions_pay_transaction_subtypes1_idx` (`transaction_subtypes_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_transactions_pay_pays1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `pay_assistant_db`.`pay_payments` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_transactions_pay_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_transactions_pay_transaction_types1`
    FOREIGN KEY (`transaction_types_id`)
    REFERENCES `pay_assistant_db`.`pay_transaction_types` (`transaction_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_transactions_pay_transaction_subtypes1`
    FOREIGN KEY (`transaction_subtypes_id`)
    REFERENCES `pay_assistant_db`.`pay_transaction_subtypes` (`transaction_subtype_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_contact_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_contact_type` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_contact_type` (
  `contact_type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`contact_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_contact_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_contact_info` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_contact_info` (
  `contact_info_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `value` VARCHAR(100) NOT NULL,
  `enable` BIT(1) NOT NULL DEFAULT 1,
  `last_update` DATETIME NOT NULL DEFAULT NOW(),
  `contact_type_id` INT NOT NULL,
  PRIMARY KEY (`contact_info_id`),
  INDEX `fk_pay_contact_info_pay_contact_type1_idx` (`contact_type_id` ASC) VISIBLE,
  INDEX `fk_pay_contact_info_pay_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_contact_info_pay_contact_type1`
    FOREIGN KEY (`contact_type_id`)
    REFERENCES `pay_assistant_db`.`pay_contact_type` (`contact_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_contact_info_pay_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_schedules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_schedules` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_schedules` (
  `schedule_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  `repit` BIT(1) NOT NULL,
  `repetitions` TINYINT NOT NULL,
  `recurrencyType` TINYINT(3) NOT NULL,
  `endDate` DATETIME NULL,
  `startDate` DATETIME NOT NULL,
  PRIMARY KEY (`schedule_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_schedules_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_schedules_details` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_schedules_details` (
  `schedules_details_id` INT NOT NULL AUTO_INCREMENT,
  `deleted` BIT(1) NOT NULL DEFAULT 0,
  `schedule_id` INT NOT NULL,
  `baseDate` DATETIME NOT NULL,
  `datePart` DATE NOT NULL,
  `last_execute` DATETIME NULL,
  `next_execute` DATETIME NOT NULL,
  `description` VARCHAR(100) CHARACTER SET 'armscii8' NOT NULL,
  `detail` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`schedules_details_id`),
  INDEX `fk_pay_schedules_details_pay_schedules1_idx` (`schedule_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_schedules_details_pay_schedules1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `pay_assistant_db`.`pay_schedules` (`schedule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_exchange_currencies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_exchange_currencies` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_exchange_currencies` (
  `exchange_currency_id` INT NOT NULL AUTO_INCREMENT,
  `source_id` INT NOT NULL,
  `destiny_id` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `exchange_rate` DECIMAL(12,3) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `current_exchange` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`exchange_currency_id`),
  INDEX `fk_pay_exchange_currency_pay_currency1_idx` (`source_id` ASC) VISIBLE,
  INDEX `fk_pay_exchange_currency_pay_currency2_idx` (`destiny_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_exchange_currency_pay_currency1`
    FOREIGN KEY (`source_id`)
    REFERENCES `pay_assistant_db`.`pay_currencies` (`currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_exchange_currency_pay_currency2`
    FOREIGN KEY (`destiny_id`)
    REFERENCES `pay_assistant_db`.`pay_currencies` (`currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_subscriptions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_subscriptions` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_subscriptions` (
  `subscription_id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`subscription_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_plan_prices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_plan_prices` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_plan_prices` (
  `plan_prices_id` INT NOT NULL AUTO_INCREMENT,
  `subscrition_Id` INT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `currency_id` INT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `endDate` DATE NOT NULL,
  `current` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`plan_prices_id`),
  INDEX `fk_pay_plan_prices_pay_subscriptions1_idx` (`subscrition_Id` ASC) VISIBLE,
  INDEX `fk_pay_plan_prices_pay_currency1_idx` (`currency_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_plan_prices_pay_subscriptions1`
    FOREIGN KEY (`subscrition_Id`)
    REFERENCES `pay_assistant_db`.`pay_subscriptions` (`subscription_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_plan_prices_pay_currency1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `pay_assistant_db`.`pay_currencies` (`currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_users_plan_prices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_users_plan_prices` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_users_plan_prices` (
  `user_plan_price_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `plan_prices_id` INT NOT NULL,
  `adquision` DATE NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `schedule_id` INT NOT NULL,
  INDEX `fk_pay_users_has_pay_plan_prices_pay_plan_prices1_idx` (`plan_prices_id` ASC) VISIBLE,
  INDEX `fk_pay_users_has_pay_plan_prices_pay_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_pay_users_plan_prices_pay_schedules1_idx` (`schedule_id` ASC) VISIBLE,
  PRIMARY KEY (`user_plan_price_id`),
  CONSTRAINT `fk_pay_users_has_pay_plan_prices_pay_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_users_has_pay_plan_prices_pay_plan_prices1`
    FOREIGN KEY (`plan_prices_id`)
    REFERENCES `pay_assistant_db`.`pay_plan_prices` (`plan_prices_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_users_plan_prices_pay_schedules1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `pay_assistant_db`.`pay_schedules` (`schedule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_plan_features`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_plan_features` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_plan_features` (
  `plan_features_id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(50) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `dataType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`plan_features_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_plan_features_subscriptions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_plan_features_subscriptions` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_plan_features_subscriptions` (
  `plan_features_id` INT NOT NULL AUTO_INCREMENT,
  `subscription_id` INT NOT NULL,
  `value` VARCHAR(75) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`plan_features_id`, `subscription_id`),
  INDEX `fk_pay_plan_features_has_pay_subscriptions_pay_subscription_idx` (`subscription_id` ASC) VISIBLE,
  INDEX `fk_pay_plan_features_has_pay_subscriptions_pay_plan_feature_idx` (`plan_features_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_plan_features_has_pay_subscriptions_pay_plan_features1`
    FOREIGN KEY (`plan_features_id`)
    REFERENCES `pay_assistant_db`.`pay_plan_features` (`plan_features_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_plan_features_has_pay_subscriptions_pay_subscriptions1`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `pay_assistant_db`.`pay_subscriptions` (`subscription_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_logs_severity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_logs_severity` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_logs_severity` (
  `log_severity_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`log_severity_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_log_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_log_types` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_log_types` (
  `log_types_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `reference1_description` VARCHAR(75) NULL,
  `reference2_description` VARCHAR(75) NULL,
  `value1_description` VARCHAR(75) NULL,
  `value2_description` VARCHAR(75) NULL,
  PRIMARY KEY (`log_types_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_log_sources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_log_sources` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_log_sources` (
  `log_sources_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`log_sources_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_logs` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_logs` (
  `log_id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(200) NOT NULL,
  `postTime` DATETIME NOT NULL,
  `computer` VARCHAR(75) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `trace` VARCHAR(100) NOT NULL,
  `referenceId1` BIGINT NULL,
  `referenceId2` BIGINT NULL,
  `value1` VARCHAR(180) NULL,
  `value2` VARCHAR(180) NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `log_severity_id` INT NOT NULL,
  `log_types_id` INT NOT NULL,
  `log_sources_id` INT NOT NULL,
  PRIMARY KEY (`log_id`),
  INDEX `fk_pay_logs_pay_log_severity1_idx` (`log_severity_id` ASC) VISIBLE,
  INDEX `fk_pay_logs_pay_log_types1_idx` (`log_types_id` ASC) VISIBLE,
  INDEX `fk_pay_logs_pay_log_sources1_idx` (`log_sources_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_logs_pay_log_severity1`
    FOREIGN KEY (`log_severity_id`)
    REFERENCES `pay_assistant_db`.`pay_logs_severity` (`log_severity_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_logs_pay_log_types1`
    FOREIGN KEY (`log_types_id`)
    REFERENCES `pay_assistant_db`.`pay_log_types` (`log_types_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_logs_pay_log_sources1`
    FOREIGN KEY (`log_sources_id`)
    REFERENCES `pay_assistant_db`.`pay_log_sources` (`log_sources_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_languages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_languages` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_languages` (
  `language_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `culture` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_translations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_translations` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_translations` (
  `translations_id` INT NOT NULL AUTO_INCREMENT,
  `module_id` INT NOT NULL,
  `code` VARCHAR(100) NOT NULL,
  `caption` VARCHAR(100) NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `language_id` INT NOT NULL,
  PRIMARY KEY (`translations_id`),
  INDEX `fk_pay_translations_pay_modules1_idx` (`module_id` ASC) VISIBLE,
  INDEX `fk_pay_translations_pay_languages1_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_translations_pay_modules1`
    FOREIGN KEY (`module_id`)
    REFERENCES `pay_assistant_db`.`pay_modules` (`module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_translations_pay_languages1`
    FOREIGN KEY (`language_id`)
    REFERENCES `pay_assistant_db`.`pay_languages` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_states` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_states` (
  `state_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`state_id`),
  INDEX `fk_pay_states_pay_countries1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_states_pay_countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `pay_assistant_db`.`pay_countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_city` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `state_id` INT NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_pay_city_pay_states1_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_city_pay_states1`
    FOREIGN KEY (`state_id`)
    REFERENCES `pay_assistant_db`.`pay_states` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_addresses` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_addresses` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `line1` VARCHAR(200) NOT NULL,
  `line2` VARCHAR(200) NULL,
  `zipcode` VARCHAR(9) NOT NULL,
  `geoposition` POINT NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_pay_Addresses_pay_city1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_Addresses_pay_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `pay_assistant_db`.`pay_city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_users_adresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_users_adresses` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_users_adresses` (
  `user_address_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_address_id`),
  INDEX `fk_pay_users_adresses_pay_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_pay_users_adresses_pay_addresses1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_users_adresses_pay_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_users_adresses_pay_addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `pay_assistant_db`.`pay_addresses` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_notification_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_notification_types` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_notification_types` (
  `notification_type_id` TINYINT(3) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`notification_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_communication_channels`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_communication_channels` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_communication_channels` (
  `communication_channel_id` INT NOT NULL,
  `channel` VARCHAR(50) NOT NULL,
  `api_integration_id` SMALLINT(1) NOT NULL,
  PRIMARY KEY (`communication_channel_id`),
  INDEX `fk_pay_channel_types_api_integrations1_idx` (`api_integration_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_channel_types_api_integrations1`
    FOREIGN KEY (`api_integration_id`)
    REFERENCES `pay_assistant_db`.`api_integrations` (`api_integration_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_notifications` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_notifications` (
  `notification_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `notification_type_id` TINYINT(1) NOT NULL,
  `message` VARCHAR(300) NOT NULL,
  `sentTime` DATETIME NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `communication_channel_id` INT NOT NULL,
  PRIMARY KEY (`notification_id`),
  INDEX `fk_pay_notifications_pay_notification_types1_idx` (`notification_type_id` ASC) VISIBLE,
  INDEX `fk_pay_notifications_pay_channel_types1_idx` (`communication_channel_id` ASC) VISIBLE,
  INDEX `fk_pay_notifications_pay_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_notifications_pay_notification_types1`
    FOREIGN KEY (`notification_type_id`)
    REFERENCES `pay_assistant_db`.`pay_notification_types` (`notification_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_notifications_pay_channel_types1`
    FOREIGN KEY (`communication_channel_id`)
    REFERENCES `pay_assistant_db`.`pay_communication_channels` (`communication_channel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_notifications_pay_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`notification_configurations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`notification_configurations` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`notification_configurations` (
  `configuration_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `notification_type_id` TINYINT(3) NOT NULL,
  `communication_channel_id` INT NOT NULL,
  `settings` JSON NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`configuration_id`),
  INDEX `fk_notification_configurations_pay_notification_types1_idx` (`notification_type_id` ASC) VISIBLE,
  INDEX `fk_notification_configurations_pay_communication_channels1_idx` (`communication_channel_id` ASC) VISIBLE,
  INDEX `fk_notification_configurations_pay_users2_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_notification_configurations_pay_notification_types1`
    FOREIGN KEY (`notification_type_id`)
    REFERENCES `pay_assistant_db`.`pay_notification_types` (`notification_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notification_configurations_pay_communication_channels1`
    FOREIGN KEY (`communication_channel_id`)
    REFERENCES `pay_assistant_db`.`pay_communication_channels` (`communication_channel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notification_configurations_pay_users2`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_recurrent_payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_recurrent_payments` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_recurrent_payments` (
  `recurrent_payment_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `schedule_id` INT NOT NULL,
  `currency_id` INT NOT NULL,
  `amount` DECIMAL(10,4) NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `operation` VARCHAR(150) NOT NULL,
  `creationTime` DATETIME NOT NULL DEFAULT NOW(),
  `method_id` INT NOT NULL,
  `available_method_id` INT NOT NULL,
  PRIMARY KEY (`recurrent_payment_id`),
  INDEX `fk_pay_recurrent_payments_pay_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_pay_recurrent_payments_pay_schedules1_idx` (`schedule_id` ASC) VISIBLE,
  INDEX `fk_pay_recurrent_payments_pay_currency1_idx` (`currency_id` ASC) VISIBLE,
  INDEX `fk_pay_recurrent_payments_pay_available_pay_methods1_idx` (`available_method_id` ASC) VISIBLE,
  INDEX `fk_pay_recurrent_payments_pay_pay_method1_idx` (`method_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_recurrent_payments_pay_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pay_assistant_db`.`pay_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_recurrent_payments_pay_schedules1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `pay_assistant_db`.`pay_schedules` (`schedule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_recurrent_payments_pay_currency1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `pay_assistant_db`.`pay_currencies` (`currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_recurrent_payments_pay_available_pay_methods1`
    FOREIGN KEY (`available_method_id`)
    REFERENCES `pay_assistant_db`.`pay_available_pay_methods` (`available_method_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_recurrent_payments_pay_pay_method1`
    FOREIGN KEY (`method_id`)
    REFERENCES `pay_assistant_db`.`pay_pay_method` (`pay_method_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_transcription_jobs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_transcription_jobs` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_transcription_jobs` (
  `job_id` INT NOT NULL AUTO_INCREMENT,
  `account_id` VARCHAR(255) NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `language_id` INT NOT NULL,
  `creationDate` DATETIME NOT NULL DEFAULT NOW(),
  `completionDate` VARCHAR(45) NULL,
  `media_file_id` INT NOT NULL,
  PRIMARY KEY (`job_id`),
  INDEX `fk_pay_transcription_jobs_pay_languages1_idx` (`language_id` ASC) VISIBLE,
  INDEX `fk_pay_transcription_jobs_pay_media_files1_idx` (`media_file_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_transcription_jobs_pay_languages1`
    FOREIGN KEY (`language_id`)
    REFERENCES `pay_assistant_db`.`pay_languages` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_transcription_jobs_pay_media_files1`
    FOREIGN KEY (`media_file_id`)
    REFERENCES `pay_assistant_db`.`pay_media_files` (`media_file_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_transcripts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_transcripts` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_transcripts` (
  `transcript_id` INT NOT NULL AUTO_INCREMENT,
  `job_id` INT NOT NULL,
  `full_text` VARCHAR(355) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `recurrent_payment_id` INT NOT NULL,
  PRIMARY KEY (`transcript_id`),
  INDEX `fk_pay_transcripts_pay_transcription_jobs1_idx` (`job_id` ASC) VISIBLE,
  INDEX `fk_pay_transcripts_pay_recurrent_payments1_idx` (`recurrent_payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_transcripts_pay_transcription_jobs1`
    FOREIGN KEY (`job_id`)
    REFERENCES `pay_assistant_db`.`pay_transcription_jobs` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_transcripts_pay_recurrent_payments1`
    FOREIGN KEY (`recurrent_payment_id`)
    REFERENCES `pay_assistant_db`.`pay_recurrent_payments` (`recurrent_payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`transcription_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`transcription_items` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`transcription_items` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `job_id` INT NOT NULL,
  `startTime` DECIMAL(10,3) NOT NULL,
  `endTime` DECIMAL(10,3) NOT NULL,
  `word` VARCHAR(150) NOT NULL,
  `confidence` DECIMAL(5,4) NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `fk_transcription_items_pay_transcription_jobs1_idx` (`job_id` ASC) VISIBLE,
  CONSTRAINT `fk_transcription_items_pay_transcription_jobs1`
    FOREIGN KEY (`job_id`)
    REFERENCES `pay_assistant_db`.`pay_transcription_jobs` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_analyzed_texts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_analyzed_texts` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_analyzed_texts` (
  `text_id` INT NOT NULL AUTO_INCREMENT,
  `transcript_id` INT NOT NULL,
  `source_type` VARCHAR(50) NOT NULL,
  `creationDate` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`text_id`),
  INDEX `fk_pay_analyzed_texts_pay_transcripts1_idx` (`transcript_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_analyzed_texts_pay_transcripts1`
    FOREIGN KEY (`transcript_id`)
    REFERENCES `pay_assistant_db`.`pay_transcripts` (`transcript_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_entity_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_entity_types` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_entity_types` (
  `entity_type_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`entity_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_detected_entities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_detected_entities` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_detected_entities` (
  `entity_id` INT NOT NULL AUTO_INCREMENT,
  `text_id` INT NOT NULL,
  `entity_text` VARCHAR(255) NOT NULL,
  `entity_type_id` INT NOT NULL,
  `confidence` DECIMAL(5,4) NOT NULL,
  `start_offset` INT NOT NULL,
  `end_offset` INT NOT NULL,
  `accepted` BIT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`entity_id`),
  INDEX `fk_pay_detected_entities_pay_analyzed_texts1_idx` (`text_id` ASC) VISIBLE,
  INDEX `fk_pay_detected_entities_pay_entity_types1_idx` (`entity_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_detected_entities_pay_analyzed_texts1`
    FOREIGN KEY (`text_id`)
    REFERENCES `pay_assistant_db`.`pay_analyzed_texts` (`text_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pay_detected_entities_pay_entity_types1`
    FOREIGN KEY (`entity_type_id`)
    REFERENCES `pay_assistant_db`.`pay_entity_types` (`entity_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pay_assistant_db`.`pay_key_phrases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pay_assistant_db`.`pay_key_phrases` ;

CREATE TABLE IF NOT EXISTS `pay_assistant_db`.`pay_key_phrases` (
  `phrase_id` INT NOT NULL AUTO_INCREMENT,
  `text_id` INT NOT NULL,
  `phrase_text` VARCHAR(255) NOT NULL,
  `confidence` DECIMAL(5,4) NOT NULL,
  `start_offset` INT NOT NULL,
  `end_offset` INT NOT NULL,
  PRIMARY KEY (`phrase_id`),
  INDEX `fk_pay_key_phrases_pay_analyzed_texts1_idx` (`text_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_key_phrases_pay_analyzed_texts1`
    FOREIGN KEY (`text_id`)
    REFERENCES `pay_assistant_db`.`pay_analyzed_texts` (`text_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
