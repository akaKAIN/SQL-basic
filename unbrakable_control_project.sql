-- Создание базы данных в рамках курсового проекта (а так же для личного проекта) база данных по ведению исполнительной документации
-- на нефтегазовых

drop database if exists lnk;
create database lnk;
use lnk;


drop table if exists km_nums;
create table km_nums
(
    `id`          serial primary key,
    `number`      varchar(10) unique comment 'Текущая маркировка километра по проекту',
    `description` varchar(200) comment 'Описание'
);

drop table if exists weld_nums;
create table weld_nums
(
    `id`          serial primary key,
    `number`      varchar(10) unique comment 'Текущая маркировка номера стыка в километре',
    `description` varchar(200) comment 'Описание'
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
    `id`          serial primary key,
    `type`        varchar(50) unique comment 'Наименование типа сварки',
    `description` varchar(200) comment 'Описание'
);

drop table if exists verdicts;
create table verdicts
(
    `id`          serial primary key,
    `verdict`     varchar(20) unique comment 'Результат контроля',
    `description` varchar(200) comment 'Описание'
);

drop table if exists welders_marks;
create table welders_marks
(
    `id`          serial primary key,
    `mark`        varchar(4) not null comment 'Шифр клейма сварщика',
    `created_at`  timestamp default current_timestamp comment 'Дата регистрации в базе',
    `description` varchar(300) comment 'Данные о сварщике',

    unique (`mark`)
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
    `created_at`        timestamp default current_timestamp comment 'Дата сварки',

    foreign key (`km_num_id`) references `km_nums` (`id`),
    foreign key (`weld_num_id`) references `weld_nums` (`id`),
    foreign key (`interface_type_id`) references `interface_types` (`id`),
    foreign key (`weld_type_id`) references `weld_types` (`id`),
    foreign key (`welder_mark_id`) references `welders_marks` (`id`),
    unique (`km_num_id`, `weld_num_id`, `interface_type_id`)
) comment 'Сварочные работы';


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
    foreign key (`joint_id`) references `joints` (`id`) on UPDATE CASCADE,
    foreign key (`verdict_id`) references `verdicts` (`id`)
) comment 'Дефекты по ВИК';


drop table if exists vik_opinions;
create table vik_opinions
(
    `id`                 serial primary key,
    `joint_id`           bigint unsigned not null comment 'Контролируемый элемент',
    `vik_created_at`     timestamp default current_timestamp comment 'Дата выдачи заключения по ВИК',
    `opinion_verdict_id` bigint unsigned not null comment 'Результат заключения по ВИК',

    index (`joint_id`),
    index (`opinion_verdict_id`),
    unique (`joint_id`),
    foreign key (`joint_id`) references `joints` (`id`) on UPDATE CASCADE
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
    foreign key (`joint_id`) references `joints` (`id`) on UPDATE CASCADE
) comment 'Дефекты по РК';


drop table if exists rk_opinions;
create table rk_opinions
(
    `id`                 serial primary key,
    `joint_id`           bigint unsigned not null comment 'Контролируемый элемент',
    `rk_created_at`      timestamp default current_timestamp comment 'Дата выдачи заключения по РК',
    `opinion_verdict_id` bigint unsigned not null comment 'Результат заключения по РК',

    index (`joint_id`),
    index (`opinion_verdict_id`),
    unique (`joint_id`),
    foreign key (`joint_id`) references `joints` (`id`) on UPDATE CASCADE
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
    foreign key (`joint_id`) references `joints` (`id`) on UPDATE CASCADE,
    foreign key (`verdict_id`) references `verdicts` (`id`)
) comment 'Дефекты по УЗК';


drop table if exists uzk_opinions;
create table uzk_opinions
(
    `id`                 serial primary key,
    `joint_id`           bigint unsigned not null comment 'Контролируемый элемент',
    `uzk_created_at`     timestamp default current_timestamp comment 'Дата выдачи заключения по УЗК',
    `opinion_verdict_id` bigint unsigned not null comment 'Результат заключения по УЗК',

    index (`joint_id`),
    index (`opinion_verdict_id`),
    unique (`joint_id`),
    foreign key (`joint_id`) references `joints` (`id`) on UPDATE CASCADE
) comment 'Заключение по УЗК';

# __Итоговый результат по видам контроля____________________________________________________________

drop table if exists conclusions;
create table conclusions
(
    `id`               serial primary key,
    `joint_id`         bigint unsigned not null,
    `vik_opinion_id`   bigint unsigned comment 'Заключение по ВИК',
    `pk_opinion_id`    bigint unsigned comment 'Заключение по РК',
    `uzk_opinion_id`   bigint unsigned comment 'Заключение по УЗК',
    `final_verdict_id` bigint unsigned comment 'Итоговый результат по всем видам контроля',

    foreign key (`vik_opinion_id`) references `vik_opinions` (`id`) on UPDATE CASCADE,
    foreign key (`pk_opinion_id`) references `rk_opinions` (`id`) on UPDATE CASCADE,
    foreign key (`uzk_opinion_id`) references `uzk_opinions` (`id`) on UPDATE CASCADE,
    foreign key (`final_verdict_id`) references `verdicts` (`id`),
    unique (`joint_id`),
    unique (`vik_opinion_id`),
    unique (`pk_opinion_id`),
    unique (`uzk_opinion_id`)
) comment 'Все виды контроля на каждый стык';
-- ###################################################################################


# Показ рабочего наименования сварного соединения.
drop view if exists `title_joints`;
create view `title_joints` as
select joints.id, CONCAT(kn.number, '-', wn.number, it.suffix) as title
from joints
         left join interface_types as it on joints.interface_type_id = it.id
         left join weld_nums wn on joints.weld_num_id = wn.id
         left join km_nums kn on joints.km_num_id = kn.id;

# Представление для просмотра результатов по каждому участку выбранных стыков по ВИК
drop view if exists `vik`;
create view vik as
select tj.id, tj.title, vd.id as p_id, vd.position as position, vd.encryption, v.verdict
from joints as j,
     vik_defects as vd,
     title_joints as tj,
     verdicts as v

where tj.id = j.id
  and vd.joint_id = j.id
  and verdict_id = v.id;

# Представление для просмотра результатов по каждому участку выбранных стыков по РК
drop view if exists `rk`;
create view rk as
select tj.id, tj.title, rd.id as p_id, rd.position as position, rd.encryption, v.verdict
from joints as j,
     rk_defects as rd,
     title_joints as tj,
     verdicts as v

where tj.id = j.id
  and rd.joint_id = j.id
  and verdict_id = v.id;

# Представление для просмотра результатов по каждому участку выбранных стыков по УЗК
drop view if exists `uzk`;
create view uzk as
select tj.id, tj.title, ud.id as p_id, ud.position as position, ud.encryption, v.verdict
from joints as j,
     uzk_defects as ud,
     title_joints as tj,
     verdicts as v

where tj.id = j.id
  and ud.joint_id = j.id
  and verdict_id = v.id;
####################################################################################################################

drop procedure if exists add_joint;
delimiter $$
create procedure add_joint(in km_num varchar(50),
                           in weld_num varchar(50),
                           in suffix varchar(50),
                           in weld_type varchar(50),
                           in mark varchar(50),
                           out result varchar(100))
begin
    declare `__rollback` bit default 0;
    declare `code` varchar(50);
    declare `error_text` varchar(100);

    declare continue HANDLER for sqlexception
        begin
            set `__rollback` = 1;
            GET stacked DIAGNOSTICS CONDITION 1
                `code` = RETURNED_SQLSTATE , `error_text` = MESSAGE_TEXT;
            set `result` = concat('Error code: ', `code`, '. Text: ', `error_text`);

        end;

    start transaction;

    set @km_num_id = (select id from km_nums where km_num = km_nums.number);
    set @weld_num_id = (select id from weld_nums where weld_num = weld_nums.number);
    set @suffix_id = (select id from interface_types where suffix = interface_types.suffix);
    set @weld_type_id = (select id from weld_types where weld_type = weld_types.type);
    set @mark_id = (select id from welders_marks where mark = welders_marks.mark);

    if (@km_num_id is null) then
        set result = 'No km number in base.';
        rollback;
    elseif (@weld_num_id is null) then
        set result = 'No weld number in base.';
        rollback;
    elseif (@suffix_id is null) then
        set result = 'No suffix of interface type in base.';
        rollback;
    elseif (@weld_type_id is null) then
        set result = 'No weld type in base.';
        rollback;
    elseif (@mark_id is null) then
        set result = 'No welder mark type in base.';
        rollback;
    else
        insert into joints(`km_num_id`, `weld_num_id`, `interface_type_id`, `weld_type_id`, `welder_mark_id`)
        values (@km_num_id, @weld_num_id, @suffix_id, @weld_type_id, @mark_id);
        set @new_joint := last_insert_id();
        set @added = (select title from title_joints where id = @new_joint);
        set result = concat(@added, ' was added.');
        commit;
    end if;
end;
$$

delimiter ;
