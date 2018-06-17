USE testtask;

#--Users table--
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  email    VARCHAR(100) NOT NULL PRIMARY KEY,
  name     VARCHAR(50)  NOT NULL,
  password VARCHAR(255) NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

#--Cards table--
DROP TABLE IF EXISTS cards;
CREATE TABLE cards (
  id      INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
  owner   VARCHAR(100) NOT NULL,
  number  LONG         NOT NULL,
  name    VARCHAR(50)  NOT NULL,
  balance INT          NOT NULL,
  pincode VARCHAR(255) NOT NULL

  #   FOREIGN KEY (owner) REFERENCES users(email),
  #
  #   UNIQUE (owner)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

#--Transactions table--
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
  id        INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cardId    INT         NOT NULL,
  type      VARCHAR(50) NOT NULL,
  amount    INT         NOT NULL
)
  ENGINE = "InnoDB"
  DEFAULT CHARACTER SET = utf8;

