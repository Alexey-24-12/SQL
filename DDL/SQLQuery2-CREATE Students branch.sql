--SQLQuery2-CREATE Students branch.sql
USE PV_522_DDL;

CREATE TABLE Directions
(
	direction_id	SMALLINT	PRIMARY KEY,
	direction_name	NVARCHAR(50)NOT NULL
);

CREATE TABLE Groups
(
	group_id		INT			PRIMARY KEY,
	group_name		NVARCHAR(24)NOT NULL,
	start_date		DATE		NOT NULL,
	start_time		TIME		NOT NULL,
	learning_days	INT			NOT NULL,
	direction		SMALLINT	NOT NULL
	CONSTRAINT	FK_Groups_Directions	FOREIGN KEY REFERENCES Directions(direction_id)
);

CREATE TABLE Students
(
	student_id	INT			PRIMARY KEY,
	last_name	NVARCHAR(50)NOT NULL,
	first_name	NVARCHAR(50)NOT NULL,
	middle_name	NVARCHAR(50)	NULL,
	birth_date	DATE		NOT NULL,
	[group]		INT			NOT NULL
	CONSTRAINT	FK_Students_Groups	FOREIGN KEY REFERENCES	Groups(group_id)
);
CREATE TABLE Teachers
(
	teacher_id	INT			PRIMARY KEY,
	last_name	NVARCHAR(50)NOT NULL,
	first_name	NVARCHAR(50)NOT NULL,
	middle_name	NVARCHAR(50)	NULL,
	birth_date	DATE		NOT NULL,
	rate		MONEY		NOT NULL	DEFAULT 50
);