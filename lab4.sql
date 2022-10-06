use medicine


/* 3.1 INSERT */

/* a.��� �������� ������ ����� INSERT INTO table_name VALUES (value1, value2, value3, ...);  
INSERT INTO medicine.dbo.drug VALUES (1, 'insulin aspartum', '�������', 'not included', 'fridge');
INSERT INTO medicine.dbo.drug VALUES (2, 'insulin ampire', '��������', 'included', 'fridge');
INSERT INTO medicine.dbo.drug VALUES (3, 'insulin alit', '�������', 'included', 'room');
INSERT INTO medicine.dbo.drug VALUES (4, 'insulin log', '�������', 'not included', 'fridge');
INSERT INTO medicine.dbo.drug VALUES (5, 'insulin dolni', '�������', 'included', 'room'); 


/* */
INSERT INTO medicine.dbo.patient VALUES (1, '���� ������', '1', '������', '20000211 10:34:09 AM');
INSERT INTO medicine.dbo.patient VALUES (2, '������ ������', '1', '����������� �������', '20010402 11:34:09 AM');
INSERT INTO medicine.dbo.patient VALUES (3, '������� ��������', '1', '��������', '20020517 10:25:09 AM');
INSERT INTO medicine.dbo.patient VALUES (4, '���� �������', '1', '�����', '20050220 09:57:09 AM');
INSERT INTO medicine.dbo.patient VALUES (5, '��������� �������', '1', '������', '19990425 12:12:09 AM');   

INSERT INTO medicine.dbo.hospital(id_hospital) VALUES (1);
INSERT INTO medicine.dbo.hospital(id_hospital) VALUES (2);
INSERT INTO medicine.dbo.hospital(id_hospital) VALUES (3);
INSERT INTO medicine.dbo.hospital(id_hospital) VALUES (4);
INSERT INTO medicine.dbo.hospital(id_hospital) VALUES (5);

/* */
INSERT INTO medicine.dbo.doctor VALUES (1, '����� ������', '��������', '���������� 1 ���������', '+71276567890', 1);
INSERT INTO medicine.dbo.doctor VALUES (2, '����� �������', '�������', '���������� 2 ���������', '+71234532890', 2);
INSERT INTO medicine.dbo.doctor VALUES (3, '������� �������', '���������������', '���������� 1 ���������', '+71290567890', 3);
INSERT INTO medicine.dbo.doctor VALUES (4, '��� ������', '������', '���������� 3 ���������', '+71234567490', 4);
INSERT INTO medicine.dbo.doctor VALUES (5, '���� ������', '��������', '���������� 1 ���������', '+71211567890', 5); 

/* */
INSERT INTO medicine.dbo.appointment VALUES (1, '5', '20210211 10:00:00 AM', 1, 1, 1, 1);
INSERT INTO medicine.dbo.appointment VALUES (2, '10', '20210211 10:00:00 AM', 2, 2, 2, 2);
INSERT INTO medicine.dbo.appointment VALUES (3, '3', '20210211 10:00:00 AM', 3, 3, 3, 3);
INSERT INTO medicine.dbo.appointment VALUES (4, '6', '20210211 10:00:00 AM', 4, 4, 4, 4);
INSERT INTO medicine.dbo.appointment VALUES (5, '15', '20210211 10:00:00 AM', 5, 5, 5, 5); */


/* b.� ��������� ������ ����� INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...); 
INSERT INTO medicine.dbo.drug (id_drug, title, manufacturer_company, Instruction_manual, storage_location) 
VALUES (6, 'insulin hum', '���K���', 'included', 'fridge'); */

/* c.� ������� �������� �� ������ ������� INSERT INTO table2 (column_name(s)) SELECT column_name(s) FROM table1;
INSERT INTO medicine.dbo.drug (id_drug) SELECT (id_drug) FROM medicine.dbo.appointment; */

/* 3.2. DELETE */

/* a.���� ������� 
DELETE FROM medicine.dbo.appointment */

/* b.�� ������� DELETE FROM table_name WHERE condition; 
DELETE FROM medicine.dbo.drug WHERE title = 'insulin log'; */

/* 3.3. UPDATE */

/* a.���� �������
UPDATE medicine.dbo.drug SET title = 'insulin'; */

/* b.�� ������� �������� ���� ������� UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition ; 
UPDATE medicine.dbo.drug SET title = 'insulin aspartum' WHERE id_drug = '1'; */

/* c.�� ������� �������� ��������� ��������� UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition; 
UPDATE medicine.dbo.drug SET title = 'insulin aspartum', instruction_manual = 'not included' WHERE id_drug = '1'; */

/* 3.4.SELECT */

/* a.� ������� ����������� ��������� (SELECT atr 1, atr 2 FROM ...) 
SELECT title, instruction_manual FROM medicine.dbo.drug */

/* b.�� ����� ���������� (SELECT * FROM ...) 
SELECT * FROM medicine.dbo.drug */

/* c.� �������� �� �������� (SELECT * FROM ... WHERE atr1 = value ) 
SELECT * FROM medicine.dbo.drug WHERE id_drug = '2' */

/* 3.5. SELECT ORDER BY + TOP (LIMIT) */

/* a.� ����������� �� ����������� ASC + ����������� ������ ���������� ������� 
SELECT TOP (3) * FROM medicine.dbo.drug ORDER BY id_drug ASC */

/* b.� ����������� �� �������� DESC 
SELECT * FROM medicine.dbo.drug ORDER BY id_drug DESC */

/* c.� ����������� �� ���� ��������� + ����������� ������ ���������� ������� 
SELECT TOP (3) title, instruction_manual FROM medicine.dbo.drug */

/* d.� ����������� �� ������� ��������, �� ������ ����������� 
SELECT TOP (3) title, instruction_manual * FROM medicine.dbo.drug ORDER BY title */

/* 3.6. ������ � ������ */

/* a.WHERE �� ���� 
SELECT * FROM medicine.dbo.patient WHERE date_of_birth = '20000211 10:34:09 AM' */

/* b.WHERE ���� � ��������� 
SELECT * FROM medicine.dbo.patient WHERE date_of_birth BETWEEN '20000211 10:34:09 AM' AND '20020517 10:25:09 AM' */

/* c.������� �� ������� �� ��� ����, � ������ ���. ��������, ��� �������� ������.
��� ����� ������������ ������� YEAR ( https://docs.microsoft.com/en-us/sql/t-sql/functions/year-transact-sql?view=sql-server-2017 ) 
SELECT YEAR(2000) FROM medicine.dbo.patient */

/* 3.7.������� ��������� */

/* a.��������� ���������� ������� � ������� 
SELECT COUNT(*) FROM medicine.dbo.drug */

/* b.��������� ���������� ���������� ������� � ������� 
SELECT COUNT(DISTINCT manufacturer_company) FROM medicine.dbo.drug */

/* c.������� ���������� �������� ������� 
SELECT DISTINCT manufacturer_company FROM medicine.dbo.drug */

/* d.����� ������������ �������� ������� 
SELECT MAX(id_drug) as max FROM medicine.dbo.drug */

/* e.����� ����������� �������� ������� 
SELECT MIN(id_drug) as min FROM medicine.dbo.drug */

 --f.�������� ������ COUNT() + GROUP BY 
SELECT manufacturer_company, COUNT(*) as count FROM medicine.dbo.drug GROUP BY manufacturer_company 

/* 3.8.SELECT GROUP BY + HAVING
a.
�������� 3 ������ ������� � �������������� GROUP BY + HAVING.
��� ������� ������� �������� ����������� � ����������, ����� ���������� ��������� ������. 
������ ������ ���� �����������, �.�. �������� ����������,������� ����� ������������ */

--������ ��������� ���������� � ���, ������� ��������� ���� �� ������ ������ 3 ���
SELECT id_patient, COUNT(*) AS count FROM medicine.dbo.appointment GROUP BY id_patient HAVING COUNT(*) <3
--������ ��������� ���������� � ���, ����� ���������� ��������� �������� ������ 5 ��� ��������
SELECT id_patient, SUM(dose) AS dose FROM medicine.dbo.appointment GROUP BY id_patient HAVING SUM(dose) >5
--������ ��������� ���������� � ���������� � ������� ������������ ���������� ������ � ���� �� = 0 (���� = 0 �� ��� ��������� ������)
SELECT id_drug, MAX(number_of_appointments_per_day) AS per_day FROM medicine.dbo.appointment GROUP BY id_drug HAVING MAX(number_of_appointments_per_day) <> 0

/* 3.9. SELECT JOIN */

/* a.LEFT JOIN ���� ������ � WHERE �� ������ �� ���������  
SELECT * FROM medicine.dbo.drug 
LEFT JOIN medicine.dbo.appointment ON medicine.dbo.drug.id_drug = medicine.dbo.appointment.id_drug
WHERE manufacturer_company = '�������' */
/* a.LEFT JOIN ���� ������ � WHERE �� ������ �� ���������  
SELECT * FROM medicine.dbo.appointment 
RIGHT JOIN medicine.dbo.drug ON medicine.dbo.appointment.id_drug = medicine.dbo.drug.id_drug WHERE manufacturer_company = '�������' */

/* c.LEFT JOIN ���� ������ + WHERE �� �������� �� ������ ������� 
SELECT * FROM medicine.dbo.drug 
LEFT JOIN medicine.dbo.appointment ON medicine.dbo.drug.id_drug = medicine.dbo.appointment.id_drug 
LEFT JOIN medicine.dbo.patient ON medicine.dbo.appointment.id_patient = medicine.dbo.patient.id_patient
WHERE manufacturer_company = '�������' */

/* d.INNER JOIN ���� ������ */
--SELECT * FROM medicine.dbo.drug INNER JOIN medicine.dbo.appointment ON medicine.dbo.drug.id_drug = medicine.dbo.appointment.id_drug

/* 3.10. ����������
a.�������� ������ � �������� WHERE IN (���������) */
--SELECT * FROM medicine.dbo.drug WHERE medicine.dbo.drug.id_drug IN (SELECT id_drug FROM medicine.dbo.appointment)

/* b.�������� ������ SELECT atr1, atr2, (���������) FROM .. 
SELECT number_of_appointments_per_day, (SELECT MIN(manufacturer_company) FROM medicine.dbo.drug) FROM medicine.dbo.appointment */

/*c. �������� ������ ���� SELECT * FROM(���������) 
SELECT * FROM(SELECT*FROM medicine.dbo.patient WHERE medicine.dbo.patient.full_name LIKE '����%') AS NewTable */

/* d.�������� ������ ���� SELECT * FROM table JOIN (���������)ON */
--SELECT * FROM medicine.dbo.appointment JOIN medicine.dbo.drug ON medicine.dbo.appointment.id_drug = medicine.dbo.drug.id_drug 