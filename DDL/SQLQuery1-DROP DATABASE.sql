--SQLQuery1-DROP DATABASE.sql
USE master;
--https://stackoverflow.com/questions/7469130/cannot-drop-database-because-it-is-currently-in-use
ALTER	DATABASE PV_522_DDL	SET SINGLE_USER WITH ROLLBACK IMMEDIATE;--ALTER - изменить
DROP	DATABASE PV_522_DDL;