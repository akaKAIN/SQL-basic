CREATE database example;
use example;

CREATE TABLE users(
id INT auto_increment not null, primary key,
name varchar(50) not null
);

-- ALTER TABLE users ADD COLUMN sex varchar (1);
-- ALTER TABLE users DROP COLUMN sex;

INSERT INTO users (name)
VALUES ("Noah Olivia"),
("Mason Ava"),
("Ethan Sophia"),
("Logan Isabella")
("Lucas Mia"),
("Jackson	Charlotte");

create database sample;

-- снаружи клиента MySQL запускаем дамп существующей базы
mysqldump example > example_dump.sql

-- и разворачиваем ее в новую базу "sample"
mysql sample < example_dump.sql