-- Примеры вставки данных в БД

-- Пример 1
use vk;
INSERT ignore INTO `users` (`firstname`, `lastname`, `email`, `phone`)
values ("Ivan", "Savinov", "ivaniya@mail.ru", null),
       ("Sonya", "Johnson", "sj@gmail.com", 91231231234),
       ("Bran", "Stark", "king@ia.org", 33332223333);

-- Пример 2
INSERT ignore INTO `users`
set `firstname` = "Bob",
    `lastname`  = "Marlye",
    `email`     = "relax@rest.yap";

-- Пример 3
INSERT INTO `users` (`firstname`, `lastname`, `email`, `password_hash`, `phone`)
select "Lara",
       "Croft",
       "noname@thief.ru",
       d12d213123wd,
       1231232233;


create table `agr`
(
    `id`     serial,
    `name`   varchar(50),
    `age`    int unsigned,
    `person` varchar(55) as (`name` + `age`)
);

