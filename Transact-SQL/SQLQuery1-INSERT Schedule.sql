--SQLQuery1-INSERT Schedule.sql
USE PV_522_Import;
SET DATEFIRST 1;	--Первый день недели - Понедельник
SET LANGUAGE RUSSIAN;

--DELETE FROM Schedule;	--Удаляет все записи из таблицы с Расписанием

DECLARE @group				AS	INT		=(SELECT group_id			FROM Groups			WHERE group_name=N'PV_522');
DECLARE @discipline			AS	SMALLINT=(SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%ADO.NET');
DECLARE @number_of_lessons	AS	TINYINT	=(SELECT number_of_lessons	FROM Disciplines	WHERE discipline_name LIKE N'%ADO.NET');
DECLARE @lesson_number		AS	TINYINT	=0;	--Номер занятия
DECLARE @teacher			AS	SMALLINT=(SELECT teacher_id			FROM Teachers		WHERE first_name=N'Олег');
DECLARE @start_date			AS	DATE	=N'2026-03-03';
DECLARE @start_time			AS	TIME(0)	=N'18:30';
DECLARE @date				AS	DATE	=@start_date;
DECLARE @time				AS	TIME(0)	=@start_time;

PRINT @group;
PRINT @discipline;
PRINT @number_of_lessons;
PRINT @teacher;
PRINT @start_date;
PRINT @start_time;
PRINT N'===============================================================';

WHILE @lesson_number < @number_of_lessons
BEGIN
	SET @time = @start_time;
	PRINT FORMATMESSAGE(N'%i, %s %s %s', @lesson_number, CAST(@date AS NVARCHAR(12)), DATENAME(WEEKDAY, @date), CAST(@time AS NVARCHAR(12)));
	IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@date AND [time]=@time)
		INSERT Schedule
					([group],	discipline,	teacher,	[date], [time], spent)
		VALUES		(@group,	@discipline,@teacher,	@date,	@time,	IIF(@date<GETDATE(), 1, 0));
	SET @time = DATEADD(MINUTE, 95, @time);
	SET @lesson_number += 1;
	PRINT FORMATMESSAGE(N'%i, %s %s %s', @lesson_number, CAST(@date AS NVARCHAR(12)), DATENAME(WEEKDAY, @date), CAST(@time AS NVARCHAR(12)));
	IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@date AND [time]=@time)
		INSERT Schedule
					([group],	discipline,	teacher,	[date], [time], spent)
		VALUES		(@group,	@discipline,@teacher,	@date,	@time,	IIF(@date<GETDATE(), 1, 0));
	SET @lesson_number += 1;
	SET @date = DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date)=6, 3 , 2), @date);
	--						DATEPART(WEEKDAY, @date) == 6  ? 3 : 2
END

--	CAST(value AS TYPE);	Явное преобразование значения (value) в желаемый тип (TYPE);	(type)value;
--	DATENAME(PART, date);	Возвращает название фрагмента даты (месяца, дня недели);
--	DATEPART(PART, date);	Возвращает числовое значение фрагмента даты (месяца, дня недели);
--	DATEADD(UNIT, amount, date OR time); Добавляет заданное количество (amount) единиц времени (UNIT) к дате либо времени (date OR time);
--	IIF(CONDITION, value_1, value_2); Conditional Ternary Operator: 
--	Если условие (CONDITION) вернуло TRUE, то IIF возращает значение 'value_1',в противном случае - 'value_2';


SELECT 
		[Группа]		=	group_name,
		[Дисциплина]	=	discipline_name,
		[Преподаватель]	=	FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
		[Дата]			=	[date],
		[День недели]	=	DATENAME(WEEKDAY, [date]),
		[Время]			=	[time],
		[Статус]		=	IIF(spent=1, N'Проведено', N'Запланировано')
FROM	Schedule,Groups,Teachers,Disciplines
WHERE	[group]			=	group_id
AND		discipline		=	discipline_id
AND		teacher			=	teacher_id
;