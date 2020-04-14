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
values ('LS', 'Pipeline weld'),
       ('BP', 'After cut'),
       ('ZX', 'Overwhelming junction');

insert into `weld_types` (`type`)
values ('PD + M300'),
       ('M300'),
       ('InnerSheld');


insert into `verdicts` (`verdict`)
values ('-not controlled-'),
       ('DONE'),
       ('Need repair'),
       ('Repeat control'),
       ('CUT IT');

insert into `welders_marks` (`mark`, `description`)
values ('C1N0', 'auto-welder group'),
       ('LF2R', 'single hand-made. Ivanov Nick'),
       ('12F4', 'repair expert - Petrovich');


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

insert into vik_defects (`joint_id`,
                         `position`,
                         `encryption`,
                         `verdict_id`,
                         notation)
values ('1', '100-120', 'Fc-2,0<0,5', '2', ''),
       ('1', '150-290', 'Fa-90>75', '4', 'To many defects'),
       ('1', '310-315', 'Fc-1,5<0,5', '2', ''),
       ('2', '0-0', '', '2', ''),
       ('2', '230-250', 'Ff-1,0<1,0', '2', ''),
       ('3', '230-250', 'Aa-4,5>2,5', '3', 'Требуется подтверждение результата'),
       ('4', '0-0', '', '2', ''),
       ('5', '0-0', '', '2', '');

insert into vik_opinions (`joint_id`,
                          `vik_created_at`,
                          `opinion_verdict_id`)
values ('1', '2020-01-01', '2'),       ('2', '2020-01-02', '4'),
       ('3', '2020-01-03', '3'),
       ('4', '2020-01-04', '2'),
       ('5', '2020-01-05', '2');



