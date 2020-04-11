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