USE lesson_4;

/* Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет */

CREATE OR REPLACE VIEW users_20 AS
SELECT id, firstname, lastname, hometown, gender
FROM users, profiles WHERE users.id = profiles.user_id AND
(TIMESTAMPDIFF(YEAR, birthday, NOW()) < 20);

/* Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователей, указав имя и фамилию
пользователя, количество отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным количеством сообщений).
Используйте DENSE_RANK */

SELECT firstname, lastname, COUNT(from_user_id) AS 'count msg',
DENSE_RANK() 
	OVER (order BY COUNT(from_user_id) DESC) AS 'rating'
FROM messages, users WHERE from_user_id = users.id
GROUP BY users.id;

/* Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) и найдите разницу дат отправления между
соседними сообщениями, получившегося списка. Используйте LEAD или LAG */

SELECT *,
TIMESTAMPDIFF(SECOND, LAG(created_at, 1, 0) OVER w, created_at) AS lag_data1,
created_at - LAG(created_at, 1, 0) OVER w AS lag_data, 
LAG(created_at, 1, 0) OVER w AS lag_created_at,
LEAD (created_at) OVER w AS lead_created_at
FROM messages
WINDOW w AS (ORDER BY created_at);
