Use UNIVERSITY;
-----------------ZAPYTANIA-----------------
-- Zapytanie 1. Odnale�� imi�, nazwisko dat� urodzenia, numer telefonu oraz nazw� grupy tych student�w, kt�rzy studiuj� zaocznie fizyk�.
SELECT DISTINCT students.first_name+' '+ students.last_name  AS 'Student', students.birth_date AS 'Birth Date', 
students.phone_number AS 'Phone Number', group_name AS 'Group',
group_type AS 'Type', field_of_study_name AS 'Field of study'
FROM students, groups, group_types,field_of_study
WHERE students.group_id = groups.group_id 
AND group_types.group_id = groups.group_id
AND field_of_study.field_of_study_id = group_types.field_of_study_id
AND group_types.group_type = 'PART TIME'
AND field_of_study.field_of_study_name = 'Physics';

-- Zapytanie 2. Odnale�� imi�, nazwisko, przedmioty z prowadz�cymi oraz budynki i klasy, w kt�rych si� odbywaj� dla ucznia o nazwisku 'Raskolnikov'.
SELECT students. first_name+' '+ students.last_name  AS 'Student', 
subject_name AS 'Subject',teachers.first_name +' '+ teachers.last_name AS 'Teacher' ,
classroom_name AS 'Classrooms', building_name AS 'Buildings'
FROM students, timetables, subjects,teachers, classrooms, buildings
WHERE students.student_id = timetables.student_id AND timetables.subject_id = subjects.subject_id 
AND teachers.teacher_id = timetables.teacher_id
AND timetables.classroom_id = classrooms.classroom_id
AND buildings.building_id = classrooms.building_id
AND students.last_name = 'Raskolnikov';

-- Zapytanie 3. Odnale�� imi�, nazwisko prowadz�cych przedmioty wraz z liczb� zapisanych na nie student�w. Wynik uporz�dkowa� rosn�co po liczbie student�w.
SELECT DISTINCT subject_name AS 'Taught Subject' , teachers.first_name +' '+ teachers.last_name AS 'Main Teacher',
count(students.student_id) AS 'Number Of Students' 
FROM students, timetables, subjects, teachers
WHERE students.student_id = timetables.student_id AND timetables.subject_id = subjects.subject_id
AND teachers.teacher_id = subjects.main_teacher_id
GROUP BY subject_name, teachers.first_name,teachers.last_name
ORDER BY 'Number Of Students' ASC;

-- Zapytanie  4. Odnale�� imi�, nazwisko, przedmioty  i notatki do ocen wraz z dat� ich wstawienia dla tych student�w, kt�rzy dostali ocen� cz�stkow� '5'.
SELECT students.student_id, students. first_name+' '+ students.last_name  AS 'Student', 
grade_name AS 'Grade', subject_name AS 'Subject', note AS 'Note', grade_date AS 'Date'
FROM students, grades, subjects
WHERE students.student_id = grades.student_id 
AND subjects.subject_id=grades.subject_id
AND grade_name='5';

-- Zapytanie  5. Wyznaczy� �redni� ocen w przedmiocie dla student�w na podstawie ich ocen cz�stkowych.
SELECT students. first_name+' '+ students.last_name  AS 'Student', 
 ROUND(AVG(CAST(grades.grade_name AS FLOAT)), 2)  AS 'Average Grade', subject_name AS 'Subject'
FROM students, grades, subjects
WHERE students.student_id = grades.student_id 
AND subjects.subject_id=grades.subject_id
GROUP BY subject_name, students. first_name, students.last_name, students.student_id
ORDER BY students.last_name , students.student_id , subject_name;

-- Zapytanie  6. Odnale�� imi� i nazwisko studenta z najwy�sz� �redni� ocen na podstawie ocen ko�cowych.
SELECT TOP 1 students.student_id AS 'Id', students. first_name+' '+ students.last_name  AS 'Student', 
 ROUND(AVG(CAST(final_grades.final_grade AS FLOAT)), 2)  AS 'Student Average'
FROM students, albums,final_grades
WHERE students.student_id = albums.student_id AND  albums.album_id =final_grades.album_id
GROUP BY students. first_name, students.last_name, students.student_id
ORDER BY avg(final_grades.final_grade) DESC;


-- Zapytanie  7. Wyznaczy� �redni� ocen dla przedmiotu na podstawie ocen ko�cowych. Wynik posortowa� malej�co.
SELECT subject_name AS 'Subject', ROUND(AVG(CAST(final_grades.final_grade AS FLOAT)), 2) AS 'Subject Average Grade'
FROM students, albums,final_grades, subjects
WHERE students.student_id = albums.student_id  AND  albums.album_id =final_grades.album_id
AND subjects.subject_id=final_grades.subject_id
GROUP BY subject_name
ORDER BY 'Subject Average Grade' DESC;


-- Zapytanie  8. Wyznaczy� �redni� ocen dla ka�dej z grup w przedmiocie 'Sysopy' na podstawie ocen ko�cowych. Wynik posortowa� malej�co.
SELECT subject_name AS 'Subject',groups.group_id AS 'Group', ROUND(AVG(CAST(final_grades.final_grade AS FLOAT)), 2) AS 'Subject Average Grade'
FROM students, albums,final_grades, subjects, groups
WHERE students.student_id = albums.student_id  AND  albums.album_id =final_grades.album_id
AND subjects.subject_id=final_grades.subject_id AND students.group_id = groups.group_id
AND subject_name = 'Sysopy'
GROUP BY groups.group_id, subject_name
ORDER BY 'Subject Average Grade' DESC;


-- Zapytanie  9. Wyznaczy� liczb� student�w w ka�dej z grup dzieka�skich.
SELECT group_name AS 'Group', count(student_id) AS 'Number of students' 
FROM students, groups , group_types
WHERE students.group_id = groups.group_id 
AND group_types.group_id = groups.group_id 
GROUP BY  group_types. group_name, groups.group_id
ORDER BY groups.group_id ;

-- Odnale�� imi� i nazwisko, nr telefonu, email, dat� zatrudnienia i pensj� wyk�adowc�w zatrudnionych po '1995/01/01'.
SELECT first_name +' '+ last_name AS 'Teacher' , phone_number AS 'Phone Number' , 
email AS 'Email', hire_date AS 'Hire Date' , salary AS 'Salary' 
FROM teachers
WHERE hire_date > '1995/01/01'
ORDER BY first_name, last_name;

-- 11. Odnale�� najwcze�niej zatrudnionego wyk�adowc�.
SELECT first_name +' '+ last_name AS 'First Hired Teacher' , hire_date AS 'Hire Date' 
FROM teachers
WHERE hire_date= (SELECT min (hire_date)FROM teachers );

-- 12. Odnale�� najp�niej zatrudnionego wyk�adowc�.
SELECT first_name +' '+ last_name AS 'Last Hired Teacher' , hire_date AS 'Hire Date' 
FROM teachers
WHERE hire_date= (SELECT max(hire_date)FROM teachers );

-- Zapytanie  13. Odnale�� student�w nie zapisanych na �aden przedmiot.
SELECT DISTINCT students.student_id AS 'Student id', students.first_name+' '+ students.last_name  AS 'Student'
FROM students
EXCEPT
	(
		SELECT DISTINCT students.student_id,students.first_name+' '+ students.last_name  AS 'Student'
		FROM students, timetables 
		WHERE students.student_id = timetables.student_id 
	)
	
-- Zapytanie  14. Odnale�� oceny ko�cowe studenta o nazwisku 'Baer'.
SELECT  students. first_name+' '+ students.last_name  AS 'Student',subject_name AS 'Subject', 
final_grades.final_grade AS 'Final Grade'
FROM students, albums,final_grades, subjects
WHERE students.student_id = albums.student_id  AND  albums.album_id =final_grades.album_id
AND subjects.subject_id=final_grades.subject_id
AND students.last_name = 'Baer'
GROUP BY subject_name,students. first_name,students.last_name , final_grades.final_grade
ORDER BY 'Final Grade' DESC;


--Zapytanie  15.  Odnale�� imi�, nazwisko prowadz�cych przedmioty wraz z liczb� prowadzonych przez nich przedmiot�w.
SELECT  teachers.first_name +' '+ teachers.last_name AS 'Teacher',
count(DISTINCT timetables.subject_id) AS 'Number Of Subjects' 
FROM timetables, subjects, teachers
WHERE teachers.teacher_id = timetables.teacher_id AND timetables.subject_id = subjects.subject_id
GROUP BY  teachers.first_name,teachers.last_name
ORDER BY 'Number Of Subjects' ASC;

-- Zapytanie  16. Odnale�� wyk�adowc�w, kt�rzy nie ucz� �adnych przedmiot�w.
SELECT DISTINCT teachers.teacher_id AS 'Teachers id', teachers.first_name+' '+ teachers.last_name   AS 'Teachers'
FROM teachers
EXCEPT
	(
		SELECT DISTINCT teachers.teacher_id,teachers.first_name+' '+ teachers.last_name 
		FROM teachers, timetables 
		WHERE teachers.teacher_id = timetables.teacher_id 
	)


-- Zapytanie  17. Zapytanie  17. Wypisa� nazwiska wszystkich student�w z grupy '20' oraz poda� liczb� urodzonych przed rokiem 1997.
DECLARE @imi� varchar(40), @nazwisko varchar(40), @student_id int, @group_id int, @num int, @licz int , @birth_date datetime;
set @num=20
set @licz=0
DECLARE kursor_studenci_w_grupie CURSOR FOR
SELECT first_name, last_name, student_id, group_id, birth_date FROM students;
OPEN kursor_studenci_w_grupie  
        FETCH NEXT FROM kursor_studenci_w_grupie   
        INTO @imi�, @nazwisko ,@student_id,@group_id,@birth_date

        WHILE @@FETCH_STATUS = 0  
        BEGIN  
                IF (@group_id = @num)
				BEGIN
                PRINT 'Id: '  + CAST(@student_id AS VARCHAR) + '  Imi�: '  + CAST(@imi� AS VARCHAR) + '   Nazwisko: '  + @nazwisko 
						+ '   Urodziny: '  + CAST(@birth_date AS VARCHAR) 
					IF (@birth_date < '1997/01/01')
					BEGIN
					set @licz = @licz + 1
					END
				END	
                FETCH NEXT FROM kursor_studenci_w_grupie   
                INTO @imi�, @nazwisko ,@student_id,@group_id,@birth_date
				END		
				PRINT 'Liczba osob w grupie urodzonych przed 1997: '  + CAST(@licz AS VARCHAR)
       
CLOSE kursor_studenci_w_grupie;
DEALLOCATE kursor_studenci_w_grupie;