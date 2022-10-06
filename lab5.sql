USE Lab5;

--1.Добавить внешние ключи
ALTER TABLE booking
ADD FOREIGN KEY (id_client)
REFERENCES client(id_client);

ALTER TABLE room
ADD FOREIGN KEY (id_hotel)
REFERENCES hotel(id_hotel);

ALTER TABLE room
ADD FOREIGN KEY (id_room_category)
REFERENCES room_category(id_room_category);

ALTER TABLE room_in_booking
ADD FOREIGN KEY (id_booking)
REFERENCES booking(id_booking);

ALTER TABLE room_in_booking
ADD FOREIGN KEY (id_room)
REFERENCES room(id_room);


--2.Выдать информацию о клиентах гостиницы "Космос", проиживающих в номерах категории "Люкс" на 1 апреля 2019

SELECT c.* FROM dbo.client AS c
JOIN booking AS b ON c.id_client = b.id_client
JOIN room_in_booking AS rb ON b.id_booking = rb.id_booking
JOIN room AS ro ON ro.id_room = rb.id_room
JOIN hotel AS h ON ro.id_hotel = h.id_hotel
JOIN room_category AS rc ON ro.id_room_category = rc.id_room_category
WHERE h.name = N'Космос' AND rb.checkin_date <=  '2019-04-01' AND rb.checkout_date > '2019-04-01' AND rc.name = N'Люкс';


--(SELECT id_client FROM dbo.booking WHERE id_booking IN 
--(SELECT id_booking FROM room_in_booking WHERE id_room IN 
--(SELECT id_room FROM dbo.room WHERE id_room_category IN 
--(SELECT id_room_category FROM dbo.room_category WHERE name = 'Люкс') AND id_hotel IN 
--(SELECT id_hotel FROM dbo.hotel WHERE name = 'Космос')) AND checkin_date <=  '2019-04-01' AND checkout_date > '2019-04-01'));


--3.Дать список свободных номеров всех гостиниц на 22 апреля
-- BETWEEN  change to >= <
SELECT room.id_room, room.number, room.id_hotel FROM room
WHERE room.id_room NOT IN 
(SELECT id_room FROM room_in_booking WHERE room_in_booking.checkin_date >= '2019-04-22' AND room_in_booking.checkout_date < '2019-04-22')
ORDER BY room.id_hotel, room.id_room;


--4.Дать количество проживающих в гостинице "Космос" на 23 марта по каждой категории номеров
-- BETWEEN  change to >= <
-- Если одинаковое название категории, то выборка неверная

SELECT COUNT(*) AS resident_count, room_category.name FROM booking
JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking
JOIN room ON room_in_booking.id_room = room.id_room
JOIN hotel ON room.id_hotel = hotel.id_hotel
JOIN room_category ON room.id_room_category = room_category.id_room_category
WHERE hotel.name = N'Космос' AND room_in_booking.checkin_date < '2019-03-23' AND room_in_booking.checkout_date >= '2019-03-23'
GROUP BY room_category.id_room_category, room_category.name;


--5.Дать список последних проживавших клиентов по всем комнатам гостиницы "Космос", выехавшим в апреле с указанием даты выезда.
-- где условие про имя гостиницы?
SELECT client.*, rib.id_room, rib.checkout_date, hotel.* FROM room_in_booking AS rib 
JOIN (SELECT MAX(checkout_date) AS chd, id_room FROM room_in_booking WHERE MONTH(checkout_date) = 4 
GROUP BY id_room) AS f ON rib.id_room = f.id_room AND rib.checkout_date = f.chd
JOIN booking ON booking.id_booking = rib.id_booking
JOIN client ON client.id_client = booking.id_client
JOIN room ON room.id_room = rib.id_room
JOIN hotel ON hotel.id_hotel = room.id_hotel
WHERE hotel.name = N'Космос';


--6.Продлить на 2 дня дату проживания в гостинице "Космос" всем клиентам комнат категории "Бизнес", которые заселились 10 мая.
SELECT room_in_booking.checkout_date, room_in_booking.id_room FROM room_in_booking
JOIN room ON room_in_booking.id_room = room.id_room
JOIN hotel ON room.id_hotel = hotel.id_hotel
JOIN room_category ON room.id_room_category = room_category.id_room_category
WHERE hotel.name = 'Космос' AND room_in_booking.checkin_date = '2019-05-10' AND room_category.name = 'Бизнес';

UPDATE room_in_booking 
SET room_in_booking.checkout_date = DATEADD(DD, 2, checkout_date)
FROM room_in_booking
JOIN room ON room_in_booking.id_room = room.id_room
JOIN hotel ON room.id_hotel = hotel.id_hotel
JOIN room_category ON room.id_room_category = room_category.id_room_category
WHERE hotel.name = 'Космос' AND room_in_booking.checkin_date = '2019-05-10' AND room_category.name = 'Бизнес';


--7.Найти все пересекающиеся варианты проживания. Правильное состояние: не может быть забронирован один номер на одну дату несколько раз, т.к нельзя
--заселиться нескольким клиентам в один номер. Записи в таблице room_in_booking с id_room_in_booking = 5 и 2154 являются примером
--неправильного состояния, которые необходимо найти. Результирующий кортеж выборки должен содержать информацию о двух конфликтующих номерах.
-- BET 
SELECT room_in_booking.id_booking, sec_rib.id_booking FROM room_in_booking
JOIN (SELECT * FROM room_in_booking) AS sec_rib ON room_in_booking.id_room = sec_rib.id_room AND room_in_booking.checkout_date > sec_rib.checkin_date
AND room_in_booking.checkin_date <= sec_rib.checkin_date AND room_in_booking.id_booking <> sec_rib.id_booking

--WHERE (room_in_booking.checkin_date BETWEEN sec_rib.checkin_date AND sec_rib.checkout_date OR sec_rib.checkin_date 
--BETWEEN room_in_booking.checkin_date AND room_in_booking.checkout_date) AND room_in_booking.id_booking <> sec_rib.id_booking
--ORDER BY room_in_booking.id_room_in_booking;


--8.Создать бронирование в транзакции
-- MAX неправильно IDENTITY
BEGIN TRANSACTION;
INSERT INTO booking (id_client, booking_date) VALUES(1, '2021-05-23');
INSERT INTO room_in_booking (id_booking, id_room, checkin_date, checkout_date) 
VALUES(@@IDENTITY , 5, '2021-05-25', '2021-05-30');
--VALUES((SELECT MAX(id_booking) FROM booking), 5, '2021-05-25', '2021-05-30');
COMMIT TRANSACTION;

--select MAX(id_booking) FROM booking
--select * FROM room_in_booking
--where id_booking = '2012'


--9.Добавить необходимые индексы для всех таблиц
CREATE INDEX HName ON hotel(name);
CREATE INDEX RIBDate ON room_in_booking(checkin_date, checkout_date);
CREATE INDEX RCName ON room_category(name);