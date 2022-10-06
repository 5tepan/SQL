use medicine


/* 3.1 INSERT */

/* a.Без указания списка полей INSERT INTO table_name VALUES (value1, value2, value3, ...);  
INSERT INTO medicine.dbo.drug VALUES (1, 'insulin aspartum', 'РинФаст', 'not included', 'fridge');
INSERT INTO medicine.dbo.drug VALUES (2, 'insulin ampire', 'МедПракт', 'included', 'fridge');
INSERT INTO medicine.dbo.drug VALUES (3, 'insulin alit', 'РинФаст', 'included', 'room');
INSERT INTO medicine.dbo.drug VALUES (4, 'insulin log', 'ЛистНад', 'not included', 'fridge');
INSERT INTO medicine.dbo.drug VALUES (5, 'insulin dolni', 'РинФаст', 'included', 'room'); 


/* */
INSERT INTO medicine.dbo.patient VALUES (1, 'Иван Иванов', '1', 'диабет', '20000211 10:34:09 AM');
INSERT INTO medicine.dbo.patient VALUES (2, 'Андрей Пертов', '1', 'растройство желудка', '20010402 11:34:09 AM');
INSERT INTO medicine.dbo.patient VALUES (3, 'Василий Поцелуев', '1', 'простуда', '20020517 10:25:09 AM');
INSERT INTO medicine.dbo.patient VALUES (4, 'Олег Сидоров', '1', 'грипп', '20050220 09:57:09 AM');
INSERT INTO medicine.dbo.patient VALUES (5, 'Александр Матвеев', '1', 'ангина', '19990425 12:12:09 AM');   

INSERT INTO medicine.dbo.hospital(id_hospital) VALUES (1);
INSERT INTO medicine.dbo.hospital(id_hospital) VALUES (2);
INSERT INTO medicine.dbo.hospital(id_hospital) VALUES (3);
INSERT INTO medicine.dbo.hospital(id_hospital) VALUES (4);
INSERT INTO medicine.dbo.hospital(id_hospital) VALUES (5);

/* */
INSERT INTO medicine.dbo.doctor VALUES (1, 'Артур Иванов', 'Невролог', 'Специалист 1 категории', '+71276567890', 1);
INSERT INTO medicine.dbo.doctor VALUES (2, 'Алекс Андреев', 'Ортопед', 'Специалист 2 категории', '+71234532890', 2);
INSERT INTO medicine.dbo.doctor VALUES (3, 'Альфред Романов', 'Гастроэнтеролог', 'Специалист 1 категории', '+71290567890', 3);
INSERT INTO medicine.dbo.doctor VALUES (4, 'Али Иванов', 'Хирург', 'Специалист 3 категории', '+71234567490', 4);
INSERT INTO medicine.dbo.doctor VALUES (5, 'Иван Валеев', 'Терапевт', 'Специалист 1 категории', '+71211567890', 5); 

/* */
INSERT INTO medicine.dbo.appointment VALUES (1, '5', '20210211 10:00:00 AM', 1, 1, 1, 1);
INSERT INTO medicine.dbo.appointment VALUES (2, '10', '20210211 10:00:00 AM', 2, 2, 2, 2);
INSERT INTO medicine.dbo.appointment VALUES (3, '3', '20210211 10:00:00 AM', 3, 3, 3, 3);
INSERT INTO medicine.dbo.appointment VALUES (4, '6', '20210211 10:00:00 AM', 4, 4, 4, 4);
INSERT INTO medicine.dbo.appointment VALUES (5, '15', '20210211 10:00:00 AM', 5, 5, 5, 5); */


/* b.С указанием списка полей INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...); 
INSERT INTO medicine.dbo.drug (id_drug, title, manufacturer_company, Instruction_manual, storage_location) 
VALUES (6, 'insulin hum', 'РинKаст', 'included', 'fridge'); */

/* c.С чтением значения из другой таблицы INSERT INTO table2 (column_name(s)) SELECT column_name(s) FROM table1;
INSERT INTO medicine.dbo.drug (id_drug) SELECT (id_drug) FROM medicine.dbo.appointment; */

/* 3.2. DELETE */

/* a.Всех записей 
DELETE FROM medicine.dbo.appointment */

/* b.По условию DELETE FROM table_name WHERE condition; 
DELETE FROM medicine.dbo.drug WHERE title = 'insulin log'; */

/* 3.3. UPDATE */

/* a.Всех записей
UPDATE medicine.dbo.drug SET title = 'insulin'; */

/* b.По условию обновляя один атрибут UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition ; 
UPDATE medicine.dbo.drug SET title = 'insulin aspartum' WHERE id_drug = '1'; */

/* c.По условию обновляя несколько атрибутов UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition; 
UPDATE medicine.dbo.drug SET title = 'insulin aspartum', instruction_manual = 'not included' WHERE id_drug = '1'; */

/* 3.4.SELECT */

/* a.С набором извлекаемых атрибутов (SELECT atr 1, atr 2 FROM ...) 
SELECT title, instruction_manual FROM medicine.dbo.drug */

/* b.Со всеми атрибутами (SELECT * FROM ...) 
SELECT * FROM medicine.dbo.drug */

/* c.С условием по атрибуту (SELECT * FROM ... WHERE atr1 = value ) 
SELECT * FROM medicine.dbo.drug WHERE id_drug = '2' */

/* 3.5. SELECT ORDER BY + TOP (LIMIT) */

/* a.С сортировкой по возрастанию ASC + ограничение вывода количества записей 
SELECT TOP (3) * FROM medicine.dbo.drug ORDER BY id_drug ASC */

/* b.С сортировкой по убыванию DESC 
SELECT * FROM medicine.dbo.drug ORDER BY id_drug DESC */

/* c.С сортировкой по двум атрибутам + ограничение вывода количества записей 
SELECT TOP (3) title, instruction_manual FROM medicine.dbo.drug */

/* d.С сортировкой по первому атрибуту, из списка извлекаемых 
SELECT TOP (3) title, instruction_manual * FROM medicine.dbo.drug ORDER BY title */

/* 3.6. Работа с датами */

/* a.WHERE по дате 
SELECT * FROM medicine.dbo.patient WHERE date_of_birth = '20000211 10:34:09 AM' */

/* b.WHERE дата в диапазоне 
SELECT * FROM medicine.dbo.patient WHERE date_of_birth BETWEEN '20000211 10:34:09 AM' AND '20020517 10:25:09 AM' */

/* c.Извлечь из таблицы не всю дату, а только год. Например, год рождения автора.
Для этого используется функция YEAR ( https://docs.microsoft.com/en-us/sql/t-sql/functions/year-transact-sql?view=sql-server-2017 ) 
SELECT YEAR(2000) FROM medicine.dbo.patient */

/* 3.7.Функции агрегации */

/* a.Посчитать количество записей в таблице 
SELECT COUNT(*) FROM medicine.dbo.drug */

/* b.Посчитать количество уникальных записей в таблице 
SELECT COUNT(DISTINCT manufacturer_company) FROM medicine.dbo.drug */

/* c.Вывести уникальные значения столбца 
SELECT DISTINCT manufacturer_company FROM medicine.dbo.drug */

/* d.Найти максимальное значение столбца 
SELECT MAX(id_drug) as max FROM medicine.dbo.drug */

/* e.Найти минимальное значение столбца 
SELECT MIN(id_drug) as min FROM medicine.dbo.drug */

 --f.Написать запрос COUNT() + GROUP BY 
SELECT manufacturer_company, COUNT(*) as count FROM medicine.dbo.drug GROUP BY manufacturer_company 

/* 3.8.SELECT GROUP BY + HAVING
a.
Написать 3 разных запроса с использованием GROUP BY + HAVING.
Для каждого запроса написать комментарий с пояснением, какую информацию извлекает запрос. 
Запрос должен быть осмысленным, т.е. находить информацию,которую можно использовать */

--Запрос извлекает информацию о том, сколько пациентов были на приеме меньше 3 раз
SELECT id_patient, COUNT(*) AS count FROM medicine.dbo.appointment GROUP BY id_patient HAVING COUNT(*) <3
--Запрос извлекает информацию о том, какое количество пациентов принимет больше 5 доз лекарств
SELECT id_patient, SUM(dose) AS dose FROM medicine.dbo.appointment GROUP BY id_patient HAVING SUM(dose) >5
--Запрос извлекает информацию о лекарствах у которых максимальное количество пиемов в день не = 0 (если = 0 то это ошибочная запись)
SELECT id_drug, MAX(number_of_appointments_per_day) AS per_day FROM medicine.dbo.appointment GROUP BY id_drug HAVING MAX(number_of_appointments_per_day) <> 0

/* 3.9. SELECT JOIN */

/* a.LEFT JOIN двух таблиц и WHERE по одному из атрибутов  
SELECT * FROM medicine.dbo.drug 
LEFT JOIN medicine.dbo.appointment ON medicine.dbo.drug.id_drug = medicine.dbo.appointment.id_drug
WHERE manufacturer_company = 'РинФаст' */
/* a.LEFT JOIN двух таблиц и WHERE по одному из атрибутов  
SELECT * FROM medicine.dbo.appointment 
RIGHT JOIN medicine.dbo.drug ON medicine.dbo.appointment.id_drug = medicine.dbo.drug.id_drug WHERE manufacturer_company = 'РинФаст' */

/* c.LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы 
SELECT * FROM medicine.dbo.drug 
LEFT JOIN medicine.dbo.appointment ON medicine.dbo.drug.id_drug = medicine.dbo.appointment.id_drug 
LEFT JOIN medicine.dbo.patient ON medicine.dbo.appointment.id_patient = medicine.dbo.patient.id_patient
WHERE manufacturer_company = 'РинФаст' */

/* d.INNER JOIN двух таблиц */
--SELECT * FROM medicine.dbo.drug INNER JOIN medicine.dbo.appointment ON medicine.dbo.drug.id_drug = medicine.dbo.appointment.id_drug

/* 3.10. Подзапросы
a.Написать запрос с условием WHERE IN (подзапрос) */
--SELECT * FROM medicine.dbo.drug WHERE medicine.dbo.drug.id_drug IN (SELECT id_drug FROM medicine.dbo.appointment)

/* b.Написать запрос SELECT atr1, atr2, (подзапрос) FROM .. 
SELECT number_of_appointments_per_day, (SELECT MIN(manufacturer_company) FROM medicine.dbo.drug) FROM medicine.dbo.appointment */

/*c. Написать запрос вида SELECT * FROM(подзапрос) 
SELECT * FROM(SELECT*FROM medicine.dbo.patient WHERE medicine.dbo.patient.full_name LIKE 'Олег%') AS NewTable */

/* d.Написать запрос вида SELECT * FROM table JOIN (подзапрос)ON */
--SELECT * FROM medicine.dbo.appointment JOIN medicine.dbo.drug ON medicine.dbo.appointment.id_drug = medicine.dbo.drug.id_drug 