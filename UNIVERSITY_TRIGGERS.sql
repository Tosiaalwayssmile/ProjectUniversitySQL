Use UNIVERSITY;
/***************************************************** TRIGGER #1 ********************************************************/
-- EN: Trigger CHECK_INSERTED_GRADE does not allow inserting a grade when student is not attending selected course (subject)
IF OBJECT_ID ('CHECK_INSERTED_GRADE' , 'TR') IS NOT NULL  
    DROP TRIGGER CHECK_INSERTED_GRADE;
GO
CREATE TRIGGER CHECK_INSERTED_GRADE 
ON Grades INSTEAD OF INSERT
AS
BEGIN
    DECLARE @StudentId INT = (SELECT StudentId FROM INSERTED);
    DECLARE @InsertedSubjectId INT = (SELECT SubjectId FROM INSERTED);
    DECLARE @AttendendSubjectId INT = (SELECT t.SubjectId FROM Students s INNER JOIN Timetables t
    ON s.StudentId = t.StudentId
    WHERE @StudentId = t.StudentId AND @InsertedSubjectId = t.SubjectId)
    DECLARE @Note VARCHAR(30) = (SELECT Note FROM INSERTED),
    @GradeValue INT = (SELECT GradeValue FROM INSERTED),
    @GradeDate DATE = (SELECT GradeDate FROM INSERTED),
    @StudentName VARCHAR(55) = (SELECT FirstName + ' ' + LastName FROM Students WHERE StudentId = @StudentId),
    @SubjectName VARCHAR(30) = (SELECT SubjectName FROM Subjects WHERE SubjectId = @InsertedSubjectId)
            
    IF(@InsertedSubjectId = @AttendendSubjectId)
        BEGIN
            INSERT INTO UNIVERSITY..Grades VALUES (@GradeValue, @GradeDate, @InsertedSubjectId, @StudentId, @Note)
            PRINT 'Student ' + @StudentName + ' got a ' + CAST(@GradeValue AS VARCHAR) + ' in ' + @SubjectName + '.';
        END
    ELSE
        PRINT 'Student ' + @StudentName + ' does not attend course: ' + @SubjectName + '.'
END
GO

 INSERT INTO UNIVERSITY..Grades VALUES (2, '2018/02/01', 1, 640, 'Test'); -- should not assign grade
 INSERT INTO UNIVERSITY..Grades VALUES (5, '2018/02/01', 1, 660, 'Test'); -- should not assign grade
 INSERT INTO UNIVERSITY..Grades VALUES (5, '2021/02/11', 3, 640, 'Project');  -- should assign grade
 --SELECT * FROM Grades WHERE StudentId = 640 AND GradeDate = '2021/02/11' AND GradeValue = 5 AND SubjectId = 3
 GO

/***************************************************** TRIGGER #2 ********************************************************/
-- EN: Trigger TEACHER_HIRE_DATE inserts current date when new teacher is employed (inserted).
IF OBJECT_ID ('TEACHER_HIRE_DATE' , 'TR') IS NOT NULL  
    DROP TRIGGER TEACHER_HIRE_DATE;
GO
CREATE TRIGGER TEACHER_HIRE_DATE
ON Teachers
AFTER INSERT
AS
DECLARE @TeacherId INT
SET @TeacherId = (SELECT TeacherId FROM INSERTED)
IF (SELECT Teachers.HireDate FROM Teachers WHERE Teachers.TeacherId = @TeacherId) IS NULL
    BEGIN
        UPDATE Teachers
        SET HireDate = GETDATE() 
        WHERE Teachers.TeacherId = @TeacherId
    END
GO
SELECT * FROM Teachers
/********* Columns: TeacherId(identity), FirstName, LastName, Email, PhoneNumber, HireDate, Salary *********/
INSERT INTO UNIVERSITY..Teachers VALUES ('DontHave', 'Date', '','305.124.4567', NULL, 2670);
SELECT * FROM Teachers WHERE Teachers.PhoneNumber = '305.124.4567'

/***************************************************** TRIGGER #3 ********************************************************/
-- EN: Trigger ENTER_FINAL_GRADES inserts 'final grade' as AVG of all grades when new academic year starts.
IF OBJECT_ID ('ENTER_FINAL_GRADES' , 'TR') IS NOT NULL
    DROP TRIGGER ENTER_FINAL_GRADES;
GO
CREATE TRIGGER ENTER_FINAL_GRADES
ON AcademicYear
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @StudentId INT
    DECLARE Cursor_Student CURSOR FOR
    SELECT StudentId FROM Students;
    OPEN Cursor_Student
    FETCH NEXT FROM Cursor_Student
    INTO @StudentId
    WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @SubjectId INT 
            DECLARE Cursor_Subjects CURSOR FOR
            SELECT SubjectId FROM Subjects;
            OPEN Cursor_Subjects
            FETCH NEXT FROM Cursor_Subjects
            INTO @SubjectId
            WHILE @@FETCH_STATUS = 0
                BEGIN
                    IF EXISTS (SELECT StudentId FROM Grades WHERE @StudentId = StudentId AND @SubjectId = SubjectId)
                        BEGIN
                            DECLARE @FinalGrade INT,
                            @AlbumId INT = (SELECT AlbumId FROM Albums WHERE StudentId = @StudentId),
                            @AcademicYearId INT = (SELECT TOP 1 AcademicYearId FROM AcademicYear ORDER BY AcademicYearName DESC);
                            SELECT @FinalGrade = ROUND(AVG(GradeValue),0) FROM Grades 
                            WHERE @StudentId = StudentId AND @SubjectId = SubjectId
                            INSERT INTO FinalGrades VALUES (@AlbumId, @FinalGrade, @SubjectId, @AcademicYearId);
                        END
                    FETCH NEXT FROM Cursor_Subjects
                    INTO @SubjectId
            END
            CLOSE Cursor_Subjects;
            DEALLOCATE Cursor_Subjects;
            FETCH NEXT FROM Cursor_Student
            INTO @StudentId
        END
    CLOSE Cursor_Student;
    DEALLOCATE Cursor_Student;
    DECLARE @AcademicYearName DATE = (SELECT AcademicYearName FROM INSERTED);
    INSERT INTO AcademicYear VALUES(@AcademicYearName);
END
GO
--SELECT* FROM FinalGrades
INSERT INTO AcademicYear VALUES('2021/10/15');
--SELECT* FROM FinalGrades
--SELECT* FROM AcademicYear

/***************************************************** TRIGGER #4 ********************************************************/
-- EN: Trigger DELETE_STUDENT deletes student as well as all references to this student.
SELECT* FROM Students WHERE StudentId = 600
IF OBJECT_ID ('DELETE_STUDENT' , 'TR') IS NOT NULL
    DROP TRIGGER DELETE_STUDENT;
GO
CREATE TRIGGER DELETE_STUDENT
ON Students
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @StudentId INT = (SELECT StudentId FROM DELETED),
    @NumberOfSubjects INT,
    @LastName VARCHAR(25) = (SELECT LastName FROM DELETED)
    SET @NumberOfSubjects = (SELECT COUNT(SubjectId) 
    FROM Timetables WHERE StudentId = @StudentId)
    
    DELETE FROM Timetables
    WHERE StudentId = @StudentId
    
    DELETE FROM FinalGrades
    WHERE AlbumId = (SELECT AlbumId FROM albums WHERE StudentId = @StudentId)
    
    DELETE FROM Grades
    WHERE StudentId = @StudentId
    
    DELETE FROM Albums
    WHERE StudentId = @StudentId
    
    DELETE FROM Students 
    WHERE StudentId = @StudentId
    
    PRINT 'Student ' + @FirstName + ' ' + @LastName + ' was deleted from ' + cast(@NumberOfSubjects as VARCHAR) + ' subjects and then deleted from student list.'
END
GO
DELETE FROM Students WHERE StudentId = 600;
--SELECT * FROM Students WHERE StudentId = 600
SELECT * FROM Students INNER JOIN Timetables ON Students.StudentId = Timetables.StudentId WHERE Timetables.StudentId = 600

/***************************************************** TRIGGER #5 ********************************************************/
-- EN:
	--Wyzwalacz UPDATE_GRADE, który po ka¿dej modyfikacji w tabeli "grades"
--wprowadza aktualn¹ dat¹ modyfikacji do pola "grade_date".
 SELECT* FROM grades WHERE grade_id = 5
 IF OBJECT_ID ('UPDATE_GRADE' , 'TR') IS NOT NULL
 DROP TRIGGER UPDATE_GRADE ;
GO
CREATE TRIGGER UPDATE_GRADE
ON grades
AFTER UPDATE
AS
BEGIN
	DECLARE @grade_id INT = (SELECT grade_id FROM INSERTED)

	UPDATE grades
	SET grade_date = GETDATE()
	WHERE @grade_id = grade_id;
END
GO
	UPDATE grades
	SET grade_name = 1
	WHERE grade_id = 5;

	SELECT* FROM grades WHERE grade_id = 5
