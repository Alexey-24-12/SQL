--SQLQuery3-SELECT Students.sql
USE PV_522_Import;

PRINT CAST(DATEDIFF(DAY, N'2003-03-07', GETDATE())/365.25 AS TINYINT)

SELECT
		[Студент]	=	FORMATMESSAGE(N'%s %s %s', last_name, first_name, middle_name),
		[Дата рождения]=birth_date,
		[Возраст]	=	CAST(DATEDIFF(DAY, [birth_date], GETDATE())/365.25 AS TINYINT),
		[Группа]	=	group_name,
		[Специальность]=direction_name
FROM	Students, Groups, Directions
WHERE	[group]		=	group_id
AND		direction	=	direction_id
ORDER BY[Возраст]	DESC	
--		ASC  - Ascending (по возрастанию)
--		DESC - Descending(по убыванию)
;