USE UNIVERSITY;
/***************************************** PROCEDURE #1 ********************************************/
-- Procedure ADD_STUDENT assigns random number when new student is INSERTed.
-- Procedura ADD_STUDENT przypisuje losowo wybrany numer przy dodawaniu noweGO studenta.          
DROP PROCEDURE IF EXISTS ADD_STUDENT;
GO

CREATE PROCEDURE ADD_STUDENT
    @FirstName VARCHAR(25),
	@LastName VARCHAR(25),
	@PhoneNumber VARCHAR(15),
	@BirthDate DATE,
	@GroupId INT

AS BEGIN
    DECLARE @StudentId INT;
    DECLARE @Number int, @isNumberTaken BIT = 'TRUE';
	WHILE(@isNumberTaken = 'TRUE')
    BEGIN
			SELECT @Number = (600 + CONVERT(INT, (700 - 600 + 1) * RAND()))
			SET @isNumberTaken = 'FALSE'

			DECLARE kursor CURSOR FOR
			SELECT @StudentId FROM Students
			OPEN kursor 
			FETCH NEXT FROM kursor INTO @StudentId
			WHILE @@FETCH_STATUS = 0
			   BEGIN 
				  IF(CAST(@Number as VARCHAR) = @StudentId)
				  BEGIN
					SET @isNumberTaken = 'TRUE';
					BREAK;
				  END
				  FETCH NEXT FROM kursor INTO @StudentId
			   END 
			CLOSE kursor 
			DEALLOCATE kursor

			IF(@isNumberTaken = 'FALSE')
			SET @StudentId = CAST(@Number as VARCHAR);
	END
	INSERT INTO students VALUES(@StudentId, @FirstName, @LastName, @PhoneNumber, @BirthDate, @GroupId);
END
GO

BEGIN
    /********* Fields: StudentId, FirstName, LastName, PhoneNumber, BirthDate, GroupId *********/
	EXEC UNIVERSITY..ADD_STUDENT 'John', 'Green', '0-22-111-7532', '03-FEB-1998', '13' 
END

SELECT * FROM Students WHERE LastName = 'Green'
GO



------------------------------ PROCEDURA NUMER 2 -------------------------------
-- Procedura MODIFY_SALARY wprowadza podwy¿kê pensji o dany procent wyk³adowcy o podanym id.

IF exists(SELECT 1 FROM sys.objects WHERE TYPE='P' and name = 'MODIFY_SALARY')
drop PROCEDURE MODIFY_SALARY
GO
create PROCEDURE MODIFY_SALARY
        @teacher_id  int = 100,
		@percentage int = 10
as
BEGIN
	IF(@teacher_id IN (SELECT teacher_id  FROM teachers))
	BEGIN
		update teachers
                SET salary += salary *(@percentage)/100
				WHERE teacher_id = @teacher_id
				print ( 'Wprowadzono podwyzke o ' + CAST(@percentage as VARCHAR) + ' procent' + ' dla wyk³adowcy '+ CAST(@teacher_id as varchar))					
	END
	else
	print('Nieprawidlowe id nauczyciela')

END
GO

SELECT* FROM teachers
BEGIN
	EXEC UNIVERSITY..MODIFY_SALARY 
	EXEC UNIVERSITY..MODIFY_SALARY 150, 50
END

SELECT* FROM teachers
GO

------------------------------ PROCEDURA NUMER 3 -------------------------------
-- Procedura DELETE_TEACHER usuwa wyk³adowców, którzy nie ucz¹ ¿adnych przedmiotów. 
-- Niemo¿liwe jest usuniêcie wyk³adowcy, który uczy jakieGOœ przedmiotu.
SELECT* FROM teachers
GO;
IF exists(SELECT 1 FROM sys.objects WHERE TYPE='P' and name = 'DELETE_TEACHER')
drop PROCEDURE DELETE_TEACHER;
GO
create PROCEDURE DELETE_TEACHER 
@teacher_id int = 530
as
BEGIN
		 IF(@teacher_id IN (SELECT teacher_id FROM teachers) 
		 AND @teacher_id NOT IN (SELECT DISTINCT teachers.teacher_id 
								 FROM timetables, teachers 
								 WHERE teachers.teacher_id = timetables.teacher_id )
								)
		 BEGIN
		 delete FROM teachers WHERE teacher_id = @teacher_id
		 print('Teacher '+ CAST(@teacher_id as VARCHAR) +' was deleted')
		 END
		 else print('Teacher '+ CAST(@teacher_id as VARCHAR) +' cannot be deleted')
END
GO
BEGIN
	EXEC UNIVERSITY..DELETE_TEACHER 160
	EXEC UNIVERSITY..DELETE_TEACHER 150
END
GO
SELECT* FROM teachers


------------------------------ PROCEDURA NUMER 4 -------------------------------
-- Procedura ADD_ TEACHER przypisuje losowo wybrany numer przy dodawaniu noweGO studenta.          
SELECT * FROM teachers
GO;

IF exists(SELECT 1 FROM sys.objects WHERE TYPE='P' and name = 'ADD_TEACHER')
drop PROCEDURE ADD_TEACHER
GO
create PROCEDURE ADD_TEACHER
        @first_name VARCHAR(25),
		@last_name VARCHAR(25),
		@email  VARCHAR(25),
		@phone_number VARCHAR(15),
		@hire_date DATETIME,
		@salary money

as
BEGIN
	DECLARE @teacher_id int = 1;
		DECLARE @numer int, @flaga int = 1;		
		while(@flaga = 1)
		BEGIN
			SELECT @numer = (100+ CONVERT(INT, (200 - 100 +1) * RAND()))
			SET @flaga = 0

			DECLARE kursor CURSOR FOR
			SELECT teacher_id FROM teachers
			OPEN kursor 
			FETCH NEXT FROM kursor INTO @teacher_id
			WHILE @@FETCH_STATUS = 0
			   BEGIN 
				  IF(CAST(@numer as VARCHAR) = @teacher_id)
				  BEGIN
					SET @flaga = 1;
					BREAK;
				  END
				  FETCH NEXT FROM kursor INTO @teacher_id
			   END 
			CLOSE kursor 
			DEALLOCATE kursor

			IF(@flaga = 0)
				SET @teacher_id = CAST(@numer as VARCHAR)
		END

	INSERT INTO teachers VALUES(@teacher_id, @first_name, @last_name, @email, @phone_number, @hire_date, @salary);
END
GO

BEGIN
	EXEC UNIVERSITY..ADD_TEACHER 'Tomasz', 'Makowski', 'TMAK', '0-98-457 7532', '22-FEB-2018', '2000'
END

SELECT * FROM teachers WHERE last_name='Makowski'
GO

