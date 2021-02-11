Use UNIVERSITY;
/***************************************** TRIGGER #1 ********************************************/
-- EN: Trigger CHECK_INSERTED_GRADE does not allow inserting a grade when student is not attending 
-- selected course (subject)
IF OBJECT_ID ('CHECK_INSERTED_GRADE' , 'TR') IS NOT NULL  
    DROP TRIGGER CHECK_INSERTED_GRADE ;
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
 INSERT INTO UNIVERSITY..Grades VALUES (5, '2021/02/11', 3, 640, 'Project');  -- should  assign grade
 --SELECT * FROM Grades WHERE StudentId = 640 AND GradeDate = '2021/02/11' AND GradeValue = 5 AND SubjectId = 3
 GO

 -----------------------TRIGGER 2-----------------------------------
-- Wyzwalacz TEACHER_HIRE_DATE, który po wstawieniu nauczyciela bez daty zatrudnienia, wstawia aktualn¹.
--IF OBJECT_ID (TEACHER_HIRE_DATE , 'TR') IS NOT NULL  
-- DROP TRIGGER TEACHER_HIRE_DATE ;
GO
CREATE TRIGGER TEACHER_HIRE_DATE
on teachers
after insert
as
DECLARE @teacher_id INT
set @teacher_id = (SELECT teacher_id FROM INSERTED)
IF (SELECT teachers.hire_date FROM teachers WHERE teachers.teacher_id =
@teacher_id) is null
BEGIN
update teachers
set hire_date = GETDATE() 
WHERE teachers.teacher_id = @teacher_id
END
GO
SELECT * FROM teachers
INSERT INTO UNIVERSITY..teachers VALUES ( 2010, 'Niemam', 'Dgaty', '','515.124.4567', NULL, 2670);
SELECT * FROM teachers WHERE teachers.teacher_id = 2010

-----------------------TRIGGER 3-----------------------------------


-----------------------TRIGGER 3-----------------------------------
--Wyzwalacz ENTER_FINAL_GRADES, który po dodaniu do tabeli academic_year noweGO roku akademickieGO 
--wprowadza 'final grade' jako zaokr¹glon¹ œredni¹ ocen cz¹stkowych.

 IF OBJECT_ID ('ENTER_FINAL_GRADES' , 'TR') IS NOT NULL
 DROP TRIGGER ENTER_FINAL_GRADES ;
GO
CREATE TRIGGER ENTER_FINAL_GRADES
ON academic_year
INSTEAD OF INSERT
AS
BEGIN
	--start kursor_studenci
	DECLARE  @student_id INT
	DECLARE kursor_studenci CURSOR FOR
	SELECT student_id FROM students;
	OPEN kursor_studenci
		FETCH NEXT FROM kursor_studenci
		INTO @student_id
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--start kursor_przedmioty
			DECLARE @subject_id INT 
			DECLARE kursor_przedmioty CURSOR FOR
			SELECT subject_id FROM subjects;
			OPEN kursor_przedmioty
				FETCH NEXT FROM kursor_przedmioty
				INTO @subject_id
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF EXISTS (SELECT student_id FROM grades WHERE @student_id = student_id AND @subject_id = subject_id)
					BEGIN
						DECLARE @final_grade INT,
						@album_id INT = (SELECT album_id FROM albums WHERE student_id = @student_id),
						@academic_year INT = (SELECT TOP 1 academic_year_id FROM academic_year ORDER BY academic_year_id DESC);

						SELECT @final_grade = ROUND(AVG(grade_name),0) FROM grades 
							WHERE @student_id = student_id AND @subject_id = subject_id
					
						INSERT INTO final_grades VALUES (@album_id, @final_grade, @subject_id,@academic_year);
					END

					FETCH NEXT FROM kursor_przedmioty
					INTO @subject_id
				END

			CLOSE kursor_przedmioty;
			DEALLOCATE kursor_przedmioty;
			--koniec kursor_przedmioty

			FETCH NEXT FROM kursor_studenci
			INTO @student_id
		END

	CLOSE kursor_studenci;
	DEALLOCATE kursor_studenci;
	--koniec kursor_studenci

	DECLARE @academic_year_id INT = (SELECT academic_year_id FROM INSERTED),
			@academic_year_name DATETIME = (SELECT academic_year_name FROM INSERTED);
	INSERT INTO academic_year VALUES(@academic_year_id, @academic_year_name);
END
GO
	INSERT INTO academic_year VALUES(2, '2018/10/15');

	SELECT* FROM final_grades
	SELECT* FROM academic_year








	--Wyzwalacz DELETE_STUDENT, który przy próbie usuniêcia studenta w pierwszej kolejnoœci
--wypisuje GO ze wszystkich przedmiotów na które jest zapisany, a nastêpnie trwale usuwa GO z listy studentów.
 SELECT* FROM students WHERE student_id = 600
 IF OBJECT_ID ('DELETE_STUDENT' , 'TR') IS NOT NULL
 DROP TRIGGER DELETE_STUDENT ;
GO
CREATE TRIGGER DELETE_STUDENT
ON students
INSTEAD OF DELETE
AS
BEGIN

	DECLARE @student_id INT = (SELECT student_id FROM deleted),
			@ilosc INT,
			@first_name VARCHAR(20) = (SELECT first_name FROM deleted),
			@last_name VARCHAR(25) = (SELECT last_name FROM deleted)
	
	SET @ilosc = (SELECT count(subject_id) 
	FROM timetables	WHERE student_id = @student_id)

	DELETE FROM timetables
	WHERE student_id = @student_id

	DELETE FROM final_grades
	WHERE album_id = (SELECT album_id FROM albums WHERE student_id = @student_id)
	
	DELETE FROM grades
	WHERE student_id = @student_id

	DELETE FROM albums
	WHERE student_id = @student_id

	DELETE FROM students 
	WHERE student_id = @student_id

	PRINT 'Studenta ' + @first_name + ' ' + @last_name + ' wypisano z ' + cast(@ilosc as VARCHAR) + ' przedmiotów, a nastepnie usuniêto z listy studentów.'

END
GO
	DELETE FROM students
	WHERE student_id = 600;

	SELECT* FROM students WHERE student_id = 600

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
