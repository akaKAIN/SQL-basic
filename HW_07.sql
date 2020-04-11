-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select id, name
from users
where id in (select user_id from orders);

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
select products.name as product, catalogs.name as category
from products,
     catalogs
where products.catalog_id = catalogs.id;

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
drop table if exists `flights`;
create table `flights`
(
    `id`   serial,
    `from` varchar(50),
    `to`   varchar(50)
);

drop table if exists `cities`;
create table `cities`
(
    `id`    serial,
    `label` varchar(50),
    `name`  varchar(50)
);

insert into `flights` (`from`, `to`)
values ('moskow', 'omsk'),
       ('omsk', 'novosibirsk'),
       ('kaluga', 'kiev'),
       ('omsk', 'vlad');

insert into `cities` (`label`, `name`)
values ('moskow', 'MOSKOW'),
       ('omsk', 'OMSK'),
       ('kaluga', 'KALUGA'),
       ('novosibirsk', 'NOVOSIB'),
       ('kiev', 'KIEV'),
       ('vlad', 'VLAD');


select flights.id,
       cities.name as `from`,
       cities.name as `to`
from flights,
     cities
where flights.from = cities.label and flights.to = cities.label;