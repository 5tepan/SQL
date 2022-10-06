USE Lab7;



--1. Добавить внешние ключи
ALTER TABLE student
ADD FOREIGN KEY (id_group)
REFERENCES [group](id_group);

ALTER TABLE mark
ADD FOREIGN KEY (id_lesson)
REFERENCES lesson(id_lesson);

ALTER TABLE mark
ADD FOREIGN KEY (id_student)
REFERENCES student(id_student);

ALTER TABLE lesson
ADD FOREIGN KEY (id_teacher)
REFERENCES teacher(id_teacher);

ALTER TABLE lesson
ADD FOREIGN KEY (id_subject)
REFERENCES subject(id_subject);

ALTER TABLE lesson
ADD FOREIGN KEY (id_group)
REFERENCES [group](id_group);

--2. Выдать оценки студентов по информатике, если они обучаются по данному предмету. Оформить выдачу данных с использованием view
CREATE OR ALTER VIEW informatic_marks (id_student, student_name, subject_name, mark, [date]) AS
SELECT student.id_student , student.[name] , [subject].[name], mark.mark, lesson.[date] FROM mark
JOIN lesson ON lesson.id_lesson = mark.id_lesson
JOIN student ON student.id_student = mark.id_student
JOIN [subject] ON lesson.id_subject = [subject].id_subject
WHERE [subject].[name] = N'Информатика';

SELECT * FROM informatic_marks;



--3. Дать информацию о должниках с указанием фамилии студента и названия предмета.
-- Должниками считаются студенты, не имеющие оценки по предмету, который ведется в группе.
-- Оформить в виде процедуры, на входе идентификатор группы

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  GetDebtorsInfo @groupName NVARCHAR(50)
AS
BEGIN
	 SELECT DISTINCT student.[name] AS student_name, subject.name AS subject_name FROM student
	 LEFT JOIN mark ON mark.id_student = student.id_student
	 LEFT JOIN [group] ON student.id_group = [group].id_group
 	 LEFT JOIN lesson ON lesson.id_group = [group].id_group
	 LEFT JOIN [subject] ON [subject].id_subject = lesson.id_subject
	 WHERE mark.[mark] IS NULL AND [group].name = @groupName
	 END
GO

EXEC GetDebtorsInfo N'ПС'
EXEC GetDebtorsInfo N'ИВТ'
EXEC GetDebtorsInfo N'ВМ'
EXEC GetDebtorsInfo N'БИ'

--4. Дать среднюю оценку студентов по каждому предмету для тех предметов, по которым занимается не менее 35 студентов
SELECT COUNT(mark.id_student) AS student_count, subject.name AS subject_name, AVG(mark.mark) as average_mark FROM mark
JOIN lesson ON mark.id_lesson = lesson.id_lesson
JOIN student ON mark.id_student = student.id_student
JOIN subject ON lesson.id_subject = subject.id_subject
GROUP BY subject.name
HAVING COUNT(mark.id_student) >= 35;

--5. Дать оценки студентов по специальности ВМ по всем проводимым предметам с указанием группы, фамилии, предмета, даты. 
--При отсутствии оценки заполнить значениями NULL поля оценки
SELECT subject.name AS subject_name, lesson.date, mark.mark, student.name AS student_name, [group].name AS group_name FROM student
LEFT JOIN [group] ON [group].id_group = student.id_group
LEFT JOIN mark ON student.id_student = mark.id_student
LEFT JOIN lesson ON lesson.id_lesson = mark.id_lesson
LEFT JOIN subject ON lesson.id_subject = subject.id_subject
WHERE [group].name = 'ВМ';

--6. Всем студентам специальности ПС, получившим оценки меньшие 5 по предмету БД до 12.05, повысить эти оценки на 1балл.
UPDATE mark
SET mark = mark + 1
WHERE mark < 5 AND mark.id_lesson IN (SELECT id_lesson FROM lesson WHERE date < N'2019-05-12')
AND mark.id_student IN (SELECT id_student FROM student WHERE id_group = (SELECT id_group FROM [group] WHERE name = N'ПС'));

--7. Добавить необходимые индексы
CREATE INDEX SubName ON subject(name);
CREATE INDEX GrName ON [group](name);
CREATE INDEX LessDate ON lesson(date);