drop database if exists `vk`;

create database `vk`;
use `vk`;

drop table if exists `users`;
create table `users`
(
    `id`            SERIAL PRIMARY KEY, -- bigint unsigned not null auto_increment unique,
    `firstname`     varchar(100) comment 'Имя',
    `lastname`      varchar(100) comment 'Фамилия',
    `email`         varchar(50) unique NOT NULL comment 'Адрес электронной почты',
    `password_hash` varchar(200)       NOT NULL,
    `phone`         bigint unique,

    index (`phone`),
    index `users_firstname_lastname_idx` (`firstname`, `lastname`)
) comment 'Таблица данных пользователей';


-- One-to-One
drop table if exists `profiles`;
create table `profiles`
(
    `user_id`    SERIAL PRIMARY KEY,
    `gender`     CHAR(1) comment 'Половая принадлежность',
    `birthday`   DATE comment 'Дата рождения',
    `photo_id`   bigint unsigned null comment 'ID фотографии',
    `hometown`   varchar(100) comment 'Домашний город',
    `created_at` DATETIME default now() comment 'Дата создания записи'

);

alter table `profiles`
    add constraint `fk_profiles_user_id`
        foreign key (`user_id`) references `users` (`id`)
            on update cascade
            on delete restrict;


-- One-To-Many
drop table if exists `messages`;
create table `messages`
(
    `id`           SERIAL PRIMARY KEY,
    `body`         TEXT,
    `create_at`    DATETIME default now(),
    `from_user_id` BIGINT unsigned not null,
    `to_user_id`   BIGINT unsigned not null,

    index (`from_user_id`),
    index (`to_user_id`),
    foreign key (`from_user_id`) references `users` (`id`)
);

drop table if exists `friend_request`;
create table `friend_request`
(
    -- `id` SERIAL PRIMARY KEY,
    `initiator_user_id` BIGINT unsigned not null,
    `target_user_id`    BIGINT unsigned not null,
    `status`            ENUM ('requested', 'approved', 'declined', 'unfriended'),
    `requested_at`      DATETIME default now(),
    `updated_at`        DATETIME on update current_timestamp,

    primary key (`initiator_user_id`, `target_user_id`),
    foreign key (`initiator_user_id`) references `users` (`id`),
    foreign key (`target_user_id`) references `users` (`id`)
);

drop table if exists `communities`;
create table `communities`
(
    `id`   SERIAL primary key,
    `name` varchar(200)
);

-- Many-To-Many
drop table if exists `users_communities`;
create table `users_communities`
(
    `user_id`        BIGINT unsigned not null,
    `communities_id` BIGINT unsigned not null,

    primary key (`user_id`, `communities_id`),
    foreign key (`user_id`) references `users` (`id`),
    foreign key (`communities_id`) references `communities` (`id`)
);

drop table if exists `media_types`;
create table `media_types`
(
    `id`   SERIAL primary key,
    `name` varchar(100)
);

drop table if exists `media`;
create table `media`
(
    `id`            SERIAL PRIMARY KEY,
    `media_type_id` BIGINT UNSIGNED NOT NULL,
    `user_id`       BIGINT UNSIGNED NOT NULL,
    `body`          TEXT,
    `filename`      varchar(255),
    `size`          INT,
    `metadata`      JSON,
    `created_at`    DATETIME default now(),
    `updated_at`    DATETIME default current_timestamp on update current_timestamp,

    index (`user_id`),
    foreign key (`user_id`) references `users` (`id`),
    foreign key (`media_type_id`) references `media_types` (`id`)
);

drop table if exists `likes`;
create table `likes`
(
    `id`        SERIAL primary key,
    `user_id`   BIGINT UNSIGNED NOT NULL,
    `media_id`  BIGINT UNSIGNED NOT NULL,
    `create_at` DATETIME default now(),

    foreign key (`user_id`) references `users` (`id`),
    foreign key (`media_id`) references `media` (`id`)
);

drop table if exists `photo_albums`;
create table `photo_albums`
(
    `id`      SERIAL primary key,
    `name`    varchar(255) default 'No_name',
    `user_id` BIGINT UNSIGNED NOT NULL,

    foreign key (`user_id`) references `users` (`id`)
);

drop table if exists `photos`;
create table `photos`
(
    `id`       SERIAL PRIMARY KEY,
    `album_id` BIGINT UNSIGNED NULL,
    `media_id` BIGINT UNSIGNED NOT NULL,

    foreign key (`album_id`) references `photo_albums` (`id`),
    foreign key (`media_id`) references `media` (`id`)
);

drop table if exists `friend_list`;
create table `friend_list`
(
    `id`      SERIAL PRIMARY KEY,
    `user_id` BIGINT UNSIGNED NULL,

    foreign key (`user_id`) references `users` (`id`)
);

drop table if exists `statuses`;
create table `statuses`
(
    `id`      SERIAL primary key,
    `user_id` BIGINT UNSIGNED UNIQUE,

    foreign key (`user_id`) references `users` (`id`)
);


drop table if exists `news`;
create table `news`
(
    `id`         SERIAL PRIMARY KEY,
    `created_at` DATETIME default now(),
    `author`     BIGINT UNSIGNED NOT NULL,


    foreign key (`author`) references `users` (`id`)
);

drop table if exists `news_feeds`;
create table `news_feeds`
(
    `id`      SERIAL PRIMARY KEY,
    `news_id` BIGINT UNSIGNED NOT NULL,

    index (`news_id`),
    foreign key (`news_id`) references `news` (`id`)
);
