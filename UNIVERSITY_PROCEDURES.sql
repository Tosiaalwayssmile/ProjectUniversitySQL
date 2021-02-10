USE UNIVERSITY;
/***************************************** PROCEDURE #1 ********************************************/
-- EN: Procedure ADD_STUDENT assigns random number when new student is INSERTED.
-- PL: Procedura ADD_STUDENT przypisuje losowo wybrany numer przy dodawaniu nowego studenta.          
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
        SET @Number = (600 + CONVERT(INT, (700 - 600 + 1) * RAND())) --Return a random int number >= 600 and <=700
		SET @isNumberTaken = 'FALSE'

		DECLARE Cursor_Student CURSOR FOR 
		SELECT @StudentId FROM Students
		OPEN Cursor_Student 
		FETCH NEXT FROM Cursor_Student INTO @StudentId
		WHILE @@FETCH_STATUS = 0
		BEGIN 
		    IF(@Number = @StudentId)
		    BEGIN
			    SET @isNumberTaken = 'TRUE';
				BREAK;
			END
			FETCH NEXT FROM Cursor_Student INTO @StudentId
	    END 
		CLOSE Cursor_Student 
		DEALLOCATE Cursor_Student

		IF(@isNumberTaken = 'FALSE')
		SET @StudentId = @Number;
	END
	INSERT INTO students VALUES(@StudentId, @FirstName, @LastName, @PhoneNumber, @BirthDate, @GroupId);
END
GO

/********* Columns in dbo.Students: StudentId, FirstName, LastName, PhoneNumber, BirthDate, GroupId *********/
BEGIN
    EXEC UNIVERSITY..ADD_STUDENT 'John', 'Green', '0-22-111-7532', '03-FEB-1998', '13' 
END

SELECT * FROM Students WHERE LastName = 'Green'
GO

/***************************************** PROCEDURE #2 ********************************************/
-- EN: Procedure MODIFY_SALARY calculates raise in salary by given percentage and assigns this value 
-- EN: to the teacher with a given id.
-- PL: Procedura MODIFY_SALARY wprowadza podwy¿kê pensji o dany procent wyk³adowcy o podanym id.
DROP PROCEDURE IF EXISTS MODIFY_SALARY;
GO
CREATE PROCEDURE MODIFY_SALARY
    @TeacherId  int = 100,
    @Percentage int = 10
AS
BEGIN
	IF(@TeacherId IN (SELECT TeacherId  FROM Teachers))
	BEGIN
	    UPDATE Teachers
        SET Salary += Salary * (@Percentage) / 100
        WHERE @TeacherId = @TeacherId
        PRINT ('Teacher with id number: ' + CAST(@TeacherId AS VARCHAR) + ' got a ' 
        + CAST(@percentage AS VARCHAR) + '% raise in salary.')					
	END
	ELSE
	PRINT('Incorrect teacher id.')
END
GO

SELECT* FROM Teachers
BEGIN
    EXEC UNIVERSITY..MODIFY_SALARY 
    EXEC UNIVERSITY..MODIFY_SALARY 150, 50
END
SELECT* FROM Teachers
GO

/***************************************** PROCEDURE #3 ********************************************/
-- EN: Procedure DELETE_TEACHER deletes teacher with no assigned subjects. 
-- EN: Deleting teachers with assigned subjects is not possible.
-- PL: Procedura DELETE_TEACHER usuwa wyk³adowców, którzy nie ucz¹ ¿adnych przedmiotów. 
-- PL: Niemo¿liwe jest usuniêcie wyk³adowcy, który uczy jakiegoœ przedmiotu.
DROP PROCEDURE IF EXISTS DELETE_TEACHER;
GO
CREATE PROCEDURE DELETE_TEACHER 
    @TeacherId INT = 530
AS
BEGIN
    IF(@TeacherId IN (SELECT TeacherId FROM Teachers) 
    AND @TeacherId NOT IN (SELECT DISTINCT Teachers.TeacherId FROM Timetables, Teachers 
    WHERE Teachers.TeacherId = Timetables.TeacherId))
    BEGIN
        DELETE FROM Teachers WHERE TeacherId = @TeacherId
		PRINT('Teacher '+ CAST(@TeacherId AS VARCHAR) + ' was deleted.')
	END
	ELSE PRINT('Teacher '+ CAST(@TeacherId AS VARCHAR) + ' cannot be deleted.')
END
GO
SELECT* FROM Teachers
BEGIN
    EXEC UNIVERSITY..DELETE_TEACHER 160
    EXEC UNIVERSITY..DELETE_TEACHER 150
END
SELECT* FROM Teachers


