insert into `km_nums` (`number`)
values ('800'),
       ('801'),
       ('802'),
       ('803'),
       ('804'),
       ('805');

insert into `weld_nums` (`number`)
values ('100'),
       ('110'),
       ('120'),
       ('130'),
       ('140'),
       ('150'),
       ('160'),
       ('170'),
       ('180'),
       ('190'),
       ('200'),
       ('210'),
       ('220'),
       ('230'),
       ('240'),
       ('250'),
       ('260'),
       ('270'),
       ('280'),
       ('290'),
       ('300');

insert into `interface_types` (`suffix`, `description`)
values ('LS', 'Pipline weld'),
       ('BP', 'After cut'),
       ('ZX', 'Overwhelming junction');

insert into `weld_types` (`type`)
values ('PD + М300'),
       ('М300'),
       ('InnerSheld');

insert into `verdicts` (`verdict`)
values ('-not controlled-'),
       ('DONE'),
       ('Repeat control'),
       ('Need repair'),
       ('CUT IT');

insert into `welders_marks` (`mark`)
values ('C1N0'),
       ('LF2R'),
       ('12F4');


insert into joints (`km_num_id`,
                    `weld_num_id`,
                    `interface_type_id`,
                    `weld_type_id`,
                    `welder_mark_id`)
values ('1', '1', '1', '2', '1'),
       ('1', '2', '1', '2', '1'),
       ('1', '3', '1', '2', '1'),
       ('1', '4', '1', '2', '1'),
       ('1', '5', '1', '2', '1'),
       ('1', '6', '1', '2', '1'),
       ('2', '1', '1', '2', '1'),
       ('2', '2', '1', '2', '1'),
       ('2', '3', '3', '1', '2'),
       ('2', '4', '1', '2', '1'),
       ('3', '1', '1', '2', '1'),
       ('3', '2', '1', '2', '1'),
       ('4', '1', '1', '2', '1'),
       ('4', '2', '1', '2', '1'),
       ('4', '3', '1', '2', '1'),
       ('4', '4', '1', '2', '1'),
       ('4', '5', '1', '2', '1');


