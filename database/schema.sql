CREATE DATABASE IF NOT EXISTS moneymate CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE moneymate;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  phone_number VARCHAR(20) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS accounts (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  account_name VARCHAR(80) NOT NULL,
  account_type ENUM('Cash','Bank Account','Card') NOT NULL DEFAULT 'Cash',
  opening_balance DECIMAL(14,2) NOT NULL DEFAULT 0.00,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  archived_at DATETIME NULL,
  CONSTRAINT fk_accounts_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE KEY uq_user_account_name (user_id, account_name),
  INDEX idx_accounts_user (user_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS transactions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  transaction_type ENUM('income','expense','transfer') NOT NULL,
  amount DECIMAL(14,2) NOT NULL,
  category VARCHAR(40) NOT NULL,
  account_id BIGINT UNSIGNED NULL,
  from_account_id BIGINT UNSIGNED NULL,
  to_account_id BIGINT UNSIGNED NULL,
  description VARCHAR(255) NULL,
  note TEXT NULL,
  transaction_datetime DATETIME NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT chk_transaction_amount CHECK (amount > 0),
  CONSTRAINT fk_transactions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_transactions_account FOREIGN KEY (account_id) REFERENCES accounts(id) ON DELETE RESTRICT,
  CONSTRAINT fk_transactions_from FOREIGN KEY (from_account_id) REFERENCES accounts(id) ON DELETE RESTRICT,
  CONSTRAINT fk_transactions_to FOREIGN KEY (to_account_id) REFERENCES accounts(id) ON DELETE RESTRICT,
  INDEX idx_tx_user_date (user_id, transaction_datetime),
  INDEX idx_tx_user_type (user_id, transaction_type),
  INDEX idx_tx_user_category (user_id, category),
  INDEX idx_tx_account (account_id),
  INDEX idx_tx_from (from_account_id),
  INDEX idx_tx_to (to_account_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS notes (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  transaction_id BIGINT UNSIGNED NULL,
  title VARCHAR(120) NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_notes_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_notes_transaction FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE SET NULL,
  INDEX idx_notes_user_updated (user_id, updated_at)
) ENGINE=InnoDB;
