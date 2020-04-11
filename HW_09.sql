# В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
# Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

start transaction;
insert into sample.users
select *
from shop.users
where shop.users.id = 1;

delete
from shop.users
where id = 1;

commit;


# Создайте представление, которое выводит название name товарной позиции из таблицы products и
# соответствующее название каталога name из таблицы catalogs.

create view Names_catalogs (product, catalog) as
select products.name, catalogs.name
where product.catalog = catalog.name
group by products.name


# Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
# С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать
# фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".


drop function if exists hello;

delimiter //
create function hello()
    returns varchar(20)
    deterministic
begin
    declare answer varchar(20);
    SET @time = hour(NOW());
    if (@time >= 6 and @time < 12) then
        SET answer = 'Good morning';
    elseif (@time >= 12 and @time < 18) then
        SET answer = 'Good day';
    elseif (@time >= 18) then
        SET answer = 'Good evening';
    else
        set answer = 'Good night';
    end if;
    return answer;
end//
delimiter ;