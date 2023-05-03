USE lesson_4;

/* Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой можно переместить любого (одного)
пользователя из таблицы users в таблицу users_old. (использование транзакции с выбором commit или rollback – обязательно) */

CREATE TABLE users_old (
id INT PRIMARY KEY, 
firstname VARCHAR(50),
lastname VARCHAR(50),
email VARCHAR(120));

DELIMITER //
CREATE PROCEDURE move_user(user_id INT)
BEGIN
INSERT INTO users_old SELECT * FROM users 
WHERE id = user_id;
DELETE FROM users WHERE id = user_id;
END // DELIMITER ;
SET AUTOCOMMIT = false;
CALL move_user(1); -- перемещение
COMMIT;            -- сохранение
ROLLBACK;          -- отмена

/* Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи" */

DELIMITER //
CREATE FUNCTION hello()
RETURNS TEXT READS SQL DATA
BEGIN
DECLARE time INT;
SET time = HOUR(NOW());
CASE
	WHEN time BETWEEN 6 AND 11 THEN RETURN "Доброе утро";
	WHEN time BETWEEN 12 AND 17 THEN RETURN "Добрый день";
	WHEN time BETWEEN 18 AND 23 THEN RETURN "Добрый вечер";
    WHEN time BETWEEN 0 AND 5 THEN RETURN "Доброй ночи";
END CASE;
END // DELIMITER ;
SELECT hello();

/* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, communities и messages
в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа */

CREATE TABLE logs (
created_at DATETIME NOT NULL,
table_name VARCHAR(50) NOT NULL,
item_id BIGINT(20) NOT NULL,
name_value VARCHAR(50) NOT NULL) 
ENGINE = ARCHIVE;

DELIMITER //
CREATE TRIGGER logs_users AFTER INSERT ON users FOR EACH ROW
BEGIN
INSERT INTO logs (created_at, table_name, item_id, name_value)
VALUES (NOW(), 'users', NEW.id, NEW.firstname);
END // DELIMITER ;

DELIMITER //
CREATE TRIGGER logs_messages AFTER INSERT ON messages FOR EACH ROW
BEGIN
INSERT INTO logs (created_at, table_name, item_id, name_value)
VALUES (NOW(), 'messages', NEW.id, NEW.body);
END // DELIMITER ;

DELIMITER //
CREATE TRIGGER logs_communities AFTER INSERT ON communities FOR EACH ROW
BEGIN
INSERT INTO logs (created_at, table_name, item_id, name_value)
VALUES (NOW(), 'communities', NEW.id, NEW.name);
END // DELIMITER ;

INSERT INTO users (firstname, lastname, email) VALUES ('Ivan', 'Petrov', 'ip@example.ru');

SELECT * FROM logs;
