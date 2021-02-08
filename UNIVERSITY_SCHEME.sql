if exists(select 1 from master.dbo.sysdatabases where name = 'UNIVERSITY') drop database UNIVERSITY
GO
CREATE DATABASE UNIVERSITY
GO

CREATE TABLE UNIVERSITY..teachers
    ( teacher_id    INT NOT NULL
	, CONSTRAINT     teacher_id_uk UNIQUE (teacher_id)
    , first_name     VARCHAR(20)
    , last_name      VARCHAR(25)
	 CONSTRAINT     teacher_last_name_nn  NOT NULL
    , email          VARCHAR(25)
	  CONSTRAINT     teacher_email_nn  NOT NULL
    , phone_number   VARCHAR(20)
    , hire_date      DATETIME
    , salary         MONEY
    , CONSTRAINT     teacher_salary_min CHECK (salary > 0) 
    , CONSTRAINT     teacher_email_uk UNIQUE (email)
	
	,CONSTRAINT PKTeacher_id PRIMARY KEY (teacher_id)
    ) ;
GO


CREATE TABLE UNIVERSITY..students
    ( student_id    INT NOT NULL
	, CONSTRAINT     student_id_uk UNIQUE (student_id)
    , first_name     VARCHAR(20)
    , last_name      VARCHAR(25)
	  CONSTRAINT     student_last_name_nn  NOT NULL
    , phone_number   VARCHAR(20)
    , birth_date      DATETIME
	  CONSTRAINT     student_birth_date_nn  NOT NULL
	, CONSTRAINT student_id_pk PRIMARY KEY (student_id)
	, group_id    INT
	) ;
GO

CREATE TABLE UNIVERSITY..subjects
    ( subject_id    INT NOT NULL
	, CONSTRAINT     subject_id_uk UNIQUE (subject_id)
    , subject_name  VARCHAR(30)
	, main_teacher_id       INT	
	  CONSTRAINT  subject_name_nn  NOT NULL
	, CONSTRAINT PKSubject PRIMARY KEY (subject_id) 
	, CONSTRAINT main_teacher_id_fk FOREIGN KEY (main_teacher_id) REFERENCES teachers (teacher_id)
    ) ;
GO

CREATE TABLE UNIVERSITY..buildings
    ( building_id   INT NOT NULL
    , building_name   VARCHAR(20) NOT NULL
	, CONSTRAINT building_id_pk PRIMARY KEY (building_id )

    ) ;
GO

CREATE TABLE UNIVERSITY..classrooms
    ( classroom_id    INT NOT NULL
    , classroom_name  VARCHAR(20) NOT NULL
	, building_id   INT NOT NULL
	, CONSTRAINT classroom_id_pk PRIMARY KEY (classroom_id )
	, CONSTRAINT FKClassroomBuildings FOREIGN KEY (building_id ) REFERENCES buildings(building_id )
    ) ;
GO

CREATE TABLE UNIVERSITY..timetables
    ( subject_id    INT NOT NULL
    , student_id  INT NOT NULL
	, teacher_id  INT NOT NULL
	, classroom_id    INT NOT NULL
	,CONSTRAINT FKStudentTimeTable FOREIGN KEY (student_id) REFERENCES students(student_id)
	,CONSTRAINT FKSubjectTimeTable FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
	,CONSTRAINT FKTeacher FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
	,CONSTRAINT FKTimeTableClassroom FOREIGN KEY (classroom_id) REFERENCES classrooms(classroom_id)
    ) ;
GO

GO
CREATE TABLE UNIVERSITY..groups
    ( group_id    INT NOT NULL
	, min_nr    INT NOT NULL
	, max_nr    INT NOT NULL
	, CONSTRAINT    group_id_uk UNIQUE (group_id)
    ) ;
GO


ALTER TABLE UNIVERSITY..students ADD CONSTRAINT FKStudentGroup FOREIGN KEY (group_id) REFERENCES groups (group_id);
GO

CREATE TABLE UNIVERSITY..field_of_study
    ( field_of_study_id     INT NOT NULL 
	, field_of_study_name  VARCHAR(30)
	, CONSTRAINT field_of_study_id_pk PRIMARY KEY (field_of_study_id )

    ) ;
GO

CREATE TABLE UNIVERSITY..academic_year
    ( academic_year_id INT
	, academic_year_name   Datetime NOT NULL
	, constraint PKAcademicYear PRIMARY key (academic_year_id)
	) ;
GO
CREATE TABLE UNIVERSITY..group_types
    ( group_id    INT NOT NULL 
	, group_name  VARCHAR(30)
	  CONSTRAINT  group_name_nn  NOT NULL
	, group_type   VARCHAR(30) 	
	, academic_year INT NOT NULL
	, field_of_study_id INT NOT NULL
	, CONSTRAINT FKGroupTypeGroup FOREIGN KEY (group_id) REFERENCES groups (group_id)
	, CONSTRAINT TYPE_check_ CHECK(group_type IN('FULL TIME','PART TIME'))
	, CONSTRAINT FKGroupTypesAcademicYear foreign key (academic_year) references academic_year(academic_year_id)
    ) ;
GO
ALTER TABLE UNIVERSITY..group_types ADD CONSTRAINT FKGroupTypesFieldOfStudy FOREIGN KEY (field_of_study_id ) REFERENCES field_of_study(field_of_study_id );


CREATE TABLE UNIVERSITY..grades (
	grade_id int NOT NULL IDENTITY(1,1),
	grade_name  int NOT NULL,
	grade_date DATETIME,
    subject_id  int NOT NULL,
	student_id  int NOT NULL,
	note VARCHAR(30) NOT NULL,
	constraint PKGrade PRIMARY key (grade_id),
	constraint FKSubjectG foreign key (subject_id) references subjects(subject_id),
	constraint FKStudentG foreign key (student_id) references students(student_id),
	CONSTRAINT grade_check_name CHECK(grade_name IN ('1', '2', '3', '4','5','6'))
);

GO

CREATE TABLE UNIVERSITY..albums
    ( album_id INT
	, student_id   INT 
	, constraint PKAlbum PRIMARY key (album_id)
	,constraint FKAlbumsStudent foreign key (student_id) references students(student_id)
	) ;
GO

CREATE TABLE UNIVERSITY..final_grades (
	album_id int NOT NULL,
	final_grade  int,
    subject_id  int NOT NULL,
	academic_year int NOT NULL,
	constraint FKFinalGradesSubject foreign key (subject_id) references subjects(subject_id),
	constraint FKFinalGradesAlbums foreign key (album_id) references albums(album_id),
	constraint FKFinalGradesAcademicYear foreign key (academic_year) references academic_year(academic_year_id)
);

GO





