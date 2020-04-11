drop procedure if exists sp_friendships_offers;
delimiter $$

create procedure sp_friendships_offers(in for_user_id bigint)
begin
    #     из одного города
    select p1.user_id, p2.user_id
    from profiles p1
             join profiles p2 on p1.hometown = p2.hometown
    where p1.user_id = for_user_id
      and p2.user_id <> for_user_id;
end $$
delimiter ;


-- Функия получения вол-ва дней с момента регистрации пользователя.
drop function if exists user_in_db;
delimiter $$

create function user_in_db(in_user_id bigint)
    returns float
    READS SQL DATA
begin
    declare online int;
    set online = (
        select datediff(curdate(), created_at) as all_time
        from profiles
        where user_id = in_user_id
    );
    return online;
end $$
delimiter ;


-- Транзакция добавления пользователя в базу.

drop procedure if exists add_user;
delimiter $$
create procedure add_user(in user_firstname varchar(50),
                          in user_lastname varchar(50),
                          in user_email varchar(50),
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

    insert into users (`firstname`, `lastname`, `email`)
    values (user_firstname, user_lastname, user_email);

    set @new_user := last_insert_id();

    insert into profiles (`user_id`)
    values (@new_user);
    if `__rollback` then
        rollback ;
    else
        set result = 'Good';
        commit;
    end if;

end $$

delimiter ;

