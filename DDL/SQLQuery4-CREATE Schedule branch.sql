--SQLQuery4-CREATE Schedule branch.sql
USE PV_522_DDL;

--CREATE TABLE Schedule
--(
--	lesson_id	BIGINT		PRIMARY KEY	IDENTITY(1,1),--IDENTITY - Autoincrement
--	[group]		INT			NOT NULL
--	CONSTRAINT	FK_Schedule_Groups		FOREIGN KEY REFERENCES Groups(group_id),
--	discipline	SMALLINT	NOT NULL
--	CONSTRAINT	FK_Schedule_Disciplines	FOREIGN KEY REFERENCES Disciplines(discipline_id),
--	teacher		INT			NOT NULL
--	CONSTRAINT	FK_Schedule_Teachers	FOREIGN KEY REFERENCES Teachers(teacher_id),
--	date		DATE		NOT NULL,
--	time		TIME(0)		NOT NULL,
--	[subject]	NVARCHAR(256)	NULL,
--	spent		BIT			NOT NULL
--);
--CREATE TABLE Grades
--(
--	PRIMARY KEY(student,lesson),
--	student		INT		NOT NULL
--	CONSTRAINT FK_Grades_Students FOREIGN KEY REFERENCES Students(student_id),
--	lesson		BIGINT	NOT NULL
--	CONSTRAINT FK_Grades_Schedule FOREIGN KEY REFERENCES Schedule(lesson_id),

--	--Check Constraint
--	grade_1		TINYINT	CONSTRAINT CK_Grade_1 CHECK	(grade_1 > 0 AND grade_1 <= 12),
--	grade_2		TINYINT,
--	CONSTRAINT CK_Grade_2 CHECK (grade_2 > 0 AND grade_2 <= 12)
--);
--CREATE TABLE HomeWorks
--(
--	PRIMARY KEY([group],lesson),
--	[group]			INT		CONSTRAINT FK_HW_Groups		FOREIGN KEY REFERENCES Groups(group_id),
--	lesson			BIGINT	CONSTRAINT FK_HW_Schedule	FOREIGN KEY REFERENCES Schedule(lesson_id),
--	[description]	NVARCHAR(256),
--	[data]			VARBINARY(2000),
--	CONSTRAINT	CK_HW_Payload	CHECK([description] IS NOT NULL OR [data] IS NOT NULL)
--);
CREATE TABLE HWResults
(
	student			INT,
	[group]			INT,
	lesson			BIGINT,
	[description]	NVARCHAR(256),
	[data]			VARBINARY(2000),
	CONSTRAINT	CK_HWR_Payload	CHECK([description] IS NOT NULL OR [data] IS NOT NULL),
	upload			DATETIME2(0),
	PRIMARY KEY(student, [group], lesson),
	CONSTRAINT FK_HWR_Students FOREIGN KEY (student) REFERENCES Students(student_id),
	CONSTRAINT FK_HWR_HW FOREIGN KEY ([group],lesson) REFERENCES HomeWorks([group],lesson)
);
--CREATE TABLE Exams
--(
--	student		INT			CONSTRAINT FK_Exams_Students	FOREIGN KEY REFERENCES	Students(student_id),
--	discipline	SMALLINT	CONSTRAINT FK_Exams_Disciplines FOREIGN KEY REFERENCES	Disciplines(discipline_id),
--	teacher		INT			CONSTRAINT FK_Exams_Teachers	FOREIGN KEY REFERENCES	Teachers(teacher_id),
--	PRIMARY KEY(student, teacher, discipline),
--	grade		TINYINT,
--	CONSTRAINT	CK_Grade	CHECK (grade > 0 AND grade <= 12),
--	completed	DATETIME2(0)
--);