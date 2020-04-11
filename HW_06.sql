-- 1. Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения
--    (JOIN пока не применять).
# Думаю можно сократить длину запросов, добавляя именам столбцов имена таблиц, как в решениях ниже.
# Так же дополнительно можно использовать переменные, избежим в какой-то степени
# хардкода, но добавится доп. код и необходимость держать в голове имена переменых.


-- 2. Пусть задан некоторый пользователь.
--    Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- Пререфразировал:
-- Найти друга заданного пользователя
-- с самым большим количеством отправленых сообщений заданному пользователю.

select msg.from_user_id,
       msg.to_user_id,
       count(*)
from messages as msg,
     friend_requests as fr
where fr.initiator_user_id = msg.from_user_id
  and fr.target_user_id = msg.to_user_id -- тут у нас "заданный пользователь"
  and fr.status = 'approved'
group by msg.to_user_id, msg.from_user_id;

-- 3. Подсчитать общее количество лайков,
-- которые получили 10 самых молодых пользователей.

-- 10 самых молодых пользователей
select user_id
from profiles
order by birthday desc
limit 10;
-- -----------------------
select count(*)
from profiles as prof,
     likes
where prof.user_id in (select user_id
from profiles
order by birthday desc
limit 10);


-- а. Количество лайков поставленных медии
select count(id) as count_likes, media_id
from likes
group by media_id
order by count_likes desc
limit 1;

-- Или media с самым большим кол-вом лайков
select media_id
from (
         select count(id) as count_likes, media_id
         from likes
         group by media_id
         order by count_likes desc
         limit 1) as max_like;



select media.user_id,
       count(*) as count_like
from profiles as prof,
     likes,
     media
where likes.user_id = media.user_id
  and likes.media_id = media.id
group by media.user_id;



-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?


-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.


-- Списов друзьяшек
select *
from friend_requests
where status = 'approved'
  and requested_at < confirmed_at;