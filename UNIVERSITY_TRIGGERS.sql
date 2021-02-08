Use UNIVERSITY;
-----------------------TRIGGER 1-----------------------------------
--Wyzwalacz GRADE_ADD_CHECK uniemo¿liwia wprowadzenie oceny cz¹stkowej z przedmiotu, na który dany student nie chodzi.
IF OBJECT_ID ('GRADE_ADD_CHECK' , 'TR') IS NOT NULL  
   DROP trigger GRADE_ADD_CHECK ;
go
create trigger GRADE_ADD_CHECK 
 on grades instead of insert
as
begin
	declare @student_id int = (select student_id from inserted);
	declare @subject_id int = (select subject_id from inserted);
	declare @sub_id int = (SELECT  t.subject_id FROM students s, timetables t
						   WHERE s.student_id = t.student_id AND @student_id = t.student_id AND @subject_id = t.subject_id)
	declare @note VARCHAR(30) = (select note from inserted),
			@grade int = (select grade_name from inserted),
		    @date datetime = (select grade_date from inserted),
			@name VARCHAR(45) = (select first_name + ' ' + last_name from students where student_id = @student_id),
			@subject_name VARCHAR(30) = (select subject_name from subjects where subject_id = @subject_id)

	if(@subject_id = @sub_id)
		begin
		INSERT INTO UNIVERSITY..grades VALUES (@grade,@date,@subject_id,@student_id,@note)
		print 'Zapisano ' + 'Student ' + @name + ' na przedmiot: ' + @subject_name + '.';
		end
		else
		print 'Student ' + @name + ' nie jest zapisany na przedmiot: ' + @subject_name + '.'
end

go

 INSERT INTO UNIVERSITY..grades VALUES (2,'2018/02/01',1,640,'Test'); -- nie jest zapisany 
 INSERT INTO UNIVERSITY..grades VALUES (5,'2018/02/01',1,660,'Test'); -- nie jest zapisany
 INSERT INTO UNIVERSITY..grades VALUES (5,'2018/02/01',3,640,'Project');  -- jest zapisany
 --select* from grades
 go

 -----------------------TRIGGER 2-----------------------------------
-- Wyzwalacz TEACHER_HIRE_DATE, który po wstawieniu nauczyciela bez daty zatrudnienia, wstawia aktualn¹.
--IF OBJECT_ID (TEACHER_HIRE_DATE , 'TR') IS NOT NULL  
-- DROP trigger TEACHER_HIRE_DATE ;
go
create trigger TEACHER_HIRE_DATE
on teachers
after insert
as
declare @teacher_id int
set @teacher_id = (select teacher_id from inserted)
if (select teachers.hire_date from teachers where teachers.teacher_id =
@teacher_id) is null
begin
update teachers
set hire_date = GETDATE() 
where teachers.teacher_id = @teacher_id
end
go
select * from teachers
INSERT INTO UNIVERSITY..teachers VALUES ( 2010, 'Niemam', 'Dgaty', '','515.124.4567', NULL, 2670);
select * from teachers where teachers.teacher_id = 2010

-----------------------TRIGGER 3-----------------------------------


-----------------------TRIGGER 3-----------------------------------
--Wyzwalacz ENTER_FINAL_GRADES, który po dodaniu do tabeli academic_year nowego roku akademickiego 
--wprowadza 'final grade' jako zaokr¹glon¹ œredni¹ ocen cz¹stkowych.

 IF OBJECT_ID ('ENTER_FINAL_GRADES' , 'TR') IS NOT NULL
 DROP trigger ENTER_FINAL_GRADES ;
go
CREATE TRIGGER ENTER_FINAL_GRADES
ON academic_year
INSTEAD OF INSERT
AS
BEGIN
	--start kursor_studenci
	DECLARE  @student_id int
	DECLARE kursor_studenci CURSOR FOR
	SELECT student_id FROM students;
	OPEN kursor_studenci
		FETCH NEXT FROM kursor_studenci
		INTO @student_id
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--start kursor_przedmioty
			DECLARE @subject_id int 
			DECLARE kursor_przedmioty CURSOR FOR
			SELECT subject_id FROM subjects;
			OPEN kursor_przedmioty
				FETCH NEXT FROM kursor_przedmioty
				INTO @subject_id
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF EXISTS (SELECT student_id FROM grades WHERE @student_id = student_id AND @subject_id = subject_id)
					BEGIN
						DECLARE @final_grade int,
						@album_id int = (SELECT album_id FROM albums WHERE student_id = @student_id),
						@academic_year int = (SELECT TOP 1 academic_year_id FROM academic_year ORDER BY academic_year_id DESC);

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

	DECLARE @academic_year_id INT = (SELECT academic_year_id FROM inserted),
			@academic_year_name DATETIME = (SELECT academic_year_name FROM inserted);
	INSERT INTO academic_year VALUES(@academic_year_id, @academic_year_name);
END
go
	INSERT INTO academic_year VALUES(2, '2018/10/15');

	SELECT* from final_grades
	SELECT* from academic_year








	--Wyzwalacz DELETE_STUDENT, który przy próbie usuniêcia studenta w pierwszej kolejnoœci
--wypisuje go ze wszystkich przedmiotów na które jest zapisany, a nastêpnie trwale usuwa go z listy studentów.
 SELECT* from students WHERE student_id = 600
 IF OBJECT_ID ('DELETE_STUDENT' , 'TR') IS NOT NULL
 DROP trigger DELETE_STUDENT ;
go
CREATE TRIGGER DELETE_STUDENT
ON students
INSTEAD OF DELETE
AS
BEGIN

	DECLARE @student_id int = (SELECT student_id FROM deleted),
			@ilosc int,
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

	print 'Studenta ' + @first_name + ' ' + @last_name + ' wypisano z ' + cast(@ilosc as VARCHAR) + ' przedmiotów, a nastepnie usuniêto z listy studentów.'

END
go
	DELETE FROM students
	WHERE student_id = 600;

	SELECT* from students WHERE student_id = 600

	--Wyzwalacz UPDATE_GRADE, który po ka¿dej modyfikacji w tabeli "grades"
--wprowadza aktualn¹ dat¹ modyfikacji do pola "grade_date".
 SELECT* from grades WHERE grade_id = 5
 IF OBJECT_ID ('UPDATE_GRADE' , 'TR') IS NOT NULL
 DROP trigger UPDATE_GRADE ;
go
CREATE TRIGGER UPDATE_GRADE
ON grades
AFTER UPDATE
AS
BEGIN
	DECLARE @grade_id int = (SELECT grade_id FROM inserted)

	UPDATE grades
	SET grade_date = GETDATE()
	WHERE @grade_id = grade_id;
END
go
	UPDATE grades
	SET grade_name = 1
	WHERE grade_id = 5;

	SELECT* from grades WHERE grade_id = 5
