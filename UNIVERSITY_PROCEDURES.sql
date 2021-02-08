USE UNIVERSITY;
------------------------------ PROCEDURA NUMER 1 -------------------------------
-- Procedura ADD_STUDENT przypisuje losowo wybrany numer przy dodawaniu nowego studenta.          
select* from students
GO;
if exists(select 1 from sys.objects where TYPE='P' and name = 'ADD_STUDENT')
drop procedure ADD_STUDENT;
go
create procedure ADD_STUDENT
        @first_name varchar(25),
		@last_name varchar(25),
		@phone_number varchar(15),
		@birth_date DATETIME,
		@group_id int

as
begin
	declare @student_id varchar(4) = 1;
		declare @numer int, @flaga int = 1;
				
		while(@flaga = 1)
		begin
			SELECT @numer = (600+ CONVERT(INT, (700 - 600 +1) * RAND()))
			set @flaga = 0

			DECLARE kursor CURSOR FOR
			SELECT @student_id FROM students
			OPEN kursor 
			FETCH NEXT FROM kursor INTO @student_id
			WHILE @@FETCH_STATUS = 0
			   BEGIN 
				  if(cast(@numer as varchar) = @student_id)
				  begin
					set @flaga = 1;
					break;
				  end
				  FETCH NEXT FROM kursor INTO @student_id
			   END 
			CLOSE kursor 
			DEALLOCATE kursor

			if(@flaga = 0)
				set @student_id = cast(@numer as varchar);
		end

	insert into students values(@student_id, @first_name, @last_name, @phone_number, @birth_date, @group_id);
end
go

begin
	exec UNIVERSITY..ADD_STUDENT 'John', 'Green', '0-22-111-7532', '03-FEB-1998', '13' --id, f.name, l.name, phone nr,b.date, group_id
end

select* from students where last_name = 'Green'
go



------------------------------ PROCEDURA NUMER 2 -------------------------------
-- Procedura MODIFY_SALARY wprowadza podwy¿kê pensji o dany procent wyk³adowcy o podanym id.

if exists(select 1 from sys.objects where TYPE='P' and name = 'MODIFY_SALARY')
drop procedure MODIFY_SALARY
go
create procedure MODIFY_SALARY
        @teacher_id  int = 100,
		@percentage int = 10
as
begin
	if(@teacher_id IN (select teacher_id  from teachers))
	begin
		update teachers
                set salary += salary *(@percentage)/100
				where teacher_id = @teacher_id
				print ( 'Wprowadzono podwyzke o ' + cast(@percentage as varchar) + ' procent' + ' dla wyk³adowcy '+ cast(@teacher_id as varchar))					
	end
	else
	print('Nieprawidlowe id nauczyciela')

end
go

select* from teachers
begin
	exec UNIVERSITY..MODIFY_SALARY 
	exec UNIVERSITY..MODIFY_SALARY 150, 50
end

select* from teachers
go

------------------------------ PROCEDURA NUMER 3 -------------------------------
-- Procedura DELETE_TEACHER usuwa wyk³adowców, którzy nie ucz¹ ¿adnych przedmiotów. 
-- Niemo¿liwe jest usuniêcie wyk³adowcy, który uczy jakiegoœ przedmiotu.
select* from teachers
GO;
if exists(select 1 from sys.objects where TYPE='P' and name = 'DELETE_TEACHER')
drop procedure DELETE_TEACHER;
go
create procedure DELETE_TEACHER 
@teacher_id int = 530
as
begin
		 if(@teacher_id IN (select teacher_id from teachers) 
		 AND @teacher_id NOT IN (SELECT DISTINCT teachers.teacher_id 
								 FROM timetables, teachers 
								 WHERE teachers.teacher_id = timetables.teacher_id )
								)
		 begin
		 delete from teachers where teacher_id = @teacher_id
		 print('Teacher '+ cast(@teacher_id as varchar) +' was deleted')
		 end
		 else print('Teacher '+ cast(@teacher_id as varchar) +' cannot be deleted')
end
go
begin
	exec UNIVERSITY..DELETE_TEACHER 160
	exec UNIVERSITY..DELETE_TEACHER 150
end
go
select* from teachers


------------------------------ PROCEDURA NUMER 4 -------------------------------
-- Procedura ADD_ TEACHER przypisuje losowo wybrany numer przy dodawaniu nowego studenta.          
select * from teachers
GO;

if exists(select 1 from sys.objects where TYPE='P' and name = 'ADD_TEACHER')
drop procedure ADD_TEACHER
go
create procedure ADD_TEACHER
        @first_name varchar(25),
		@last_name varchar(25),
		@email  varchar(25),
		@phone_number varchar(15),
		@hire_date DATETIME,
		@salary money

as
begin
	declare @teacher_id int = 1;
		declare @numer int, @flaga int = 1;		
		while(@flaga = 1)
		begin
			SELECT @numer = (100+ CONVERT(INT, (200 - 100 +1) * RAND()))
			set @flaga = 0

			DECLARE kursor CURSOR FOR
			SELECT teacher_id FROM teachers
			OPEN kursor 
			FETCH NEXT FROM kursor INTO @teacher_id
			WHILE @@FETCH_STATUS = 0
			   BEGIN 
				  if(cast(@numer as varchar) = @teacher_id)
				  begin
					set @flaga = 1;
					break;
				  end
				  FETCH NEXT FROM kursor INTO @teacher_id
			   END 
			CLOSE kursor 
			DEALLOCATE kursor

			if(@flaga = 0)
				set @teacher_id = cast(@numer as varchar)
		end

	insert into teachers values(@teacher_id, @first_name, @last_name, @email, @phone_number, @hire_date, @salary);
end
go

begin
	exec UNIVERSITY..ADD_TEACHER 'Tomasz', 'Makowski', 'TMAK', '0-98-457 7532', '22-FEB-2018', '2000'
end

select * from teachers where last_name='Makowski'
go

