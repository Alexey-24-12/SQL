--SQLQuery2-SELECT.sql
USE PV_522_Import;

--ALTER TABLE		Groups
--ALTER COLUMN	start_time TIME(0) NOT NULL;

SELECT
		group_name		AS	N'Группа',
		direction_name	AS	N'Направление обучения'
FROM	Groups,Directions
WHERE	direction=direction_id
;