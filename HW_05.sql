-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
drop table if exists `users`;
create table `users`
(
    `id`         serial,
    `name`       varchar(50) not null,
    `birthday`   date        not null,
    `created_at` datetime default null, -- создано для простоты выполнения условий
    `updated_at` datetime default null  -- создано для простоты выполнения условий
);
-- добавляем данные в поля:
update `users`
set `created_at`=now(),
    `updated_at`=now()
where `updated_at` is null
  and `created_at` is null;


-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR
-- и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу
-- DATETIME, сохранив введеные ранее значения.
drop table if exists `users`;
create table `users`
(
    `id`         serial,
    `name`       varchar(50) not null,
    `created_at` varchar(50) default '20.10.2017', -- создано для простоты выполнения условий
    `updated_at` varchar(50) default '20.10.2017'  -- создано для простоты выполнения условий
);

-- Добавляем пару записей в таблицу
insert into `users`(`name`)
values ('Ivan'),
       ('Bob');

-- Меняем тип поля
alter table `users`
    change `created_at` `created_at` datetime default now(),
    change `updated_at` `updated_at` datetime default current_timestamp on update current_timestamp;

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0,
-- если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом,
-- чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце,
-- после всех записей.

drop table if exists `products`;
create table `products`
(
    `id`       serial,
    `category` varchar(50)  not null,
    `value`    int unsigned not null
);

insert into `products`(`category`, `value`)
values ('computers', 5),
       ('cord', 20),
       ('processors', 0),
       ('cleaner', 2);

select * from `products` order by `value`=0 asc, `value` asc;

