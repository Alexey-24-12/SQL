--SQLQuery3-CREATE Disciplines branch.sql
USE PV_522_DDL;

CREATE TABLE Disciplines
(
	discipline_id		SMALLINT		PRIMARY KEY,
	discipline_name		NVARCHAR(150)	NOT NULL,
	number_of_lessons	TINYINT			NOT NULL
);

--PJT - Pure Join Table
CREATE TABLE TeachersDisciplinesRelation
(
	teacher		INT,
	discipline	SMALLINT,
	PRIMARY KEY	(teacher,discipline),
	CONSTRAINT	FK_TDR_Teachers		FOREIGN KEY (teacher)	REFERENCES	Teachers(teacher_id),
	CONSTRAINT	FK_TDR_Discipline	FOREIGN KEY (discipline)REFERENCES	Disciplines(discipline_id)
);
CREATE TABLE DisciplinesDirectionRelation
(
	discipline	SMALLINT,
	direction	SMALLINT,
	PRIMARY KEY	(discipline,direction),
	CONSTRAINT	FK_DDR_Discipline	FOREIGN KEY	(discipline)REFERENCES	Disciplines(discipline_id),
	CONSTRAINT	FK_DDR_Directions	FOREIGN KEY	(direction)	REFERENCES	Directions(direction_id)
);