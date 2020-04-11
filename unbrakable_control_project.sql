-- В рамках курсового проекта (а так же для личного проекта) база данных по ведению исполнительной документации
-- на нефтегазовых

drop database if exists lnk;
create database lnk;
use lnk;


drop table if exists km_nums;
create table km_nums
(
    `id`     serial primary key,
    `number` varchar(10) unique comment 'Текущая маркировка километра по проекту'
);

drop table if exists weld_nums;
create table weld_nums
(
    `id`     serial primary key,
    `number` varchar(10) unique comment 'Текущая маркировка номера стыка в километре'
);

drop table if exists interface_types;
create table interface_types
(
    `id`          serial primary key,
    `suffix`      varchar(10) unique comment 'Текущая маркировка типа сварного соединения',
    `description` varchar(200) comment 'Описание'
);

drop table if exists weld_types;
create table weld_types
(
    `id`   serial primary key,
    `type` varchar(50) unique comment 'Наименование типа сварки'
);

drop table if exists verdicts;
create table verdicts
(
    `id`      serial primary key,
    `verdict` varchar(20) unique comment 'Результат контроля'
);

drop table if exists welders_marks;
create table welders_marks
(
    `id`          serial primary key,
    `mark`        varchar(4) not null comment 'Шифр клейма сварщика',
    `created_at`  timestamp default current_timestamp comment 'Дата регистрации в базе',
    `description` varchar(300) comment 'Данные о сварщике'
);

drop table if exists joints;
create table joints
(
    `id`                serial primary key,
    `km_num_id`         bigint unsigned not null comment 'Маркировка километра',
    `weld_num_id`       bigint unsigned not null comment 'Маркировка сварного стыка',
    `interface_type_id` bigint unsigned not null comment 'Маркировка типа сварного шва',
    `weld_type_id`      bigint unsigned not null comment 'Тип сварки',
    `welder_mark_id`    bigint unsigned not null comment 'Клеймо сварщика/бригады',
    `created_at`        date default current_date comment 'Дата сварки',

    foreign key (`km_num_id`) references `km_nums` (`id`),
    foreign key (`weld_num_id`) references `weld_nums` (`id`),
    foreign key (`interface_type_id`) references `interface_types` (`id`),
    foreign key (`weld_type_id`) references `weld_types` (`id`),
    foreign key (`welder_mark_id`) references `welders_marks` (`id`),
    unique (`km_num_id`, `weld_num_id`, `interface_type_id`)
) comment 'Сварочные работы';


drop table if exists conclusions;
create table conclusions
(
    `id`             serial primary key,
    `joint_id`       bigint unsigned not null,
    `vik_opinion_id` bigint unsigned comment 'Заключение по ВИК',
    `pk_opinion_id`  bigint unsigned comment 'Заключение по РК',
    `uzk_opinion_id` bigint unsigned comment 'Заключение по УЗК',

    foreign key (`vik_opinion_id`) references `vik_opinions` (`id`),
    foreign key (`pk_opinion_id`) references `rk_opinions` (`id`),
    foreign key (`uzk_opinion_id`) references `uzk_opinions` (`id`)
) comment 'Итоговые заключения';


-- Раздел ВИК ------------------------------------------------------------------------

drop table if exists vik_defects;
create table vik_defects
(
    `id`         serial primary key,
    `joint_id`   bigint unsigned not null comment 'Контролируемый элемент',
    `position`   varchar(20)     not null comment 'Коррдинаты контроля',
    `encryption` varchar(200) default 'No defects found' comment 'Расшифровка дефекта',
    `verdict_id` bigint unsigned not null comment 'Заключение по проконтролированному участку',
    `notation`   varchar(200) comment 'Примечание к дефекту',

    index (`joint_id`),
    index (`verdict_id`),
    foreign key (`joint_id`) references `joints` (`id`)
) comment 'Дефекты по ВИК';


drop table if exists vik_opinions;
create table vik_opinions
(
    `id`                 serial primary key,
    `joint_id`           bigint unsigned not null comment 'Контролируемый элемент',
    `vik_created_at`     date default current_date comment 'Дата выдачи заключения по ВИК',
    `opinion_verdict_id` bigint unsigned not null comment 'Результат заключения по ВИК',

    index (`joint_id`),
    index (`opinion_verdict_id`),
    unique (`joint_id`),
    foreign key (`joint_id`) references `joints` (`id`)
) comment 'Заключение по ВИК';


-- Раздел РК ------------------------------------------------------------------------

drop table if exists rk_defects;
create table rk_defects
(
    `id`         serial primary key,
    `joint_id`   bigint unsigned not null comment 'Контролируемый элемент',
    `position`   varchar(20)     not null comment 'Коррдинаты контроля',
    `encryption` varchar(500) default 'No defects found' comment 'Расшифровка дефекта',
    `verdict_id` bigint unsigned not null comment 'Заключение по проконтролированному участку',
    `notation`   varchar(300) comment 'Примечание к дефекту',

    index (`joint_id`),
    index (`verdict_id`),
    foreign key (`joint_id`) references `joints` (`id`)
) comment 'Дефекты по РК';


drop table if exists rk_opinions;
create table rk_opinions
(
    `id`                 serial primary key,
    `joint_id`           bigint unsigned not null comment 'Контролируемый элемент',
    `rk_created_at`     date default current_date comment 'Дата выдачи заключения по РК',
    `opinion_verdict_id` bigint unsigned not null comment 'Результат заключения по РК',

    index (`joint_id`),
    index (`opinion_verdict_id`),
    unique (`joint_id`),
    foreign key (`joint_id`) references `joints` (`id`)
) comment 'Заключение по РК';



-- Раздел УЗК ------------------------------------------------------------------------

drop table if exists uzk_defects;
create table uzk_defects
(
    `id`         serial primary key,
    `joint_id`   bigint unsigned not null comment 'Контролируемый элемент',
    `position`   varchar(20)     not null comment 'Коррдинаты контроля',
    `encryption` varchar(100) default 'No defects found' comment 'Расшифровка дефекта',
    `verdict_id` bigint unsigned not null comment 'Заключение по проконтролированному участку',
    `notation`   varchar(100) comment 'Примечание к дефекту',

    index (`joint_id`),
    index (`verdict_id`),
    foreign key (`joint_id`) references `joints` (`id`)
) comment 'Дефекты по УЗК';


drop table if exists uzk_opinions;
create table uzk_opinions
(
    `id`                 serial primary key,
    `joint_id`           bigint unsigned not null comment 'Контролируемый элемент',
    `uzk_created_at`     date default current_date comment 'Дата выдачи заключения по УЗК',
    `opinion_verdict_id` bigint unsigned not null comment 'Результат заключения по УЗК',

    index (`joint_id`),
    index (`opinion_verdict_id`),
    unique (`joint_id`),
    foreign key (`joint_id`) references `joints` (`id`)
) comment 'Заключение по УЗК';