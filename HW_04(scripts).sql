-- i. Заполнить все таблицы БД vk данными (по 10-100 записей в каждой таблице)
-- см. файл `HW_04(CreateDataBase).sql`

-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
SELECT DISTINCT `firstname`
FROM `users`
ORDER BY `firstname`;

-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
-- Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (0 или 1)

-- добавляем колонку
ALTER TABLE `profiles`
    ADD `is_active` BIT DEFAULT true NOT NULL;

-- показать тех, кто старше 16
select *
from `profilres`
where (year(current_timestamp) - year(`birthday`)) > 16;

update profiles
set `is_active` = false
where (year(current_timestamp) - year(`birthday`)) > 16;

-- iv. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)
delete
from `messages`
where `create_at` > current_timestamp;
-- v. Написать название темы курсового проекта (в комментарии)