/********************************	DIFferent way of checking IF database exists and creating it	********************************/
/*
IF NOT EXISTS(
    SELECT * FROM master.dbo.sysdatabases 
    WHERE NAME = 'UNIVERSITY'
    )
CREATE DATABASE UNIVERSITY
GO
*/
IF EXISTS(
    SELECT 1 FROM master.dbo.sysdatabases 
    WHERE NAME = 'UNIVERSITY'
    ) 
DROP DATABASE UNIVERSITY
GO

CREATE DATABASE UNIVERSITY
GO

CREATE TABLE UNIVERSITY..Teachers(
    TeacherId		INT	IDENTITY(100,10) 
    CONSTRAINT PK_TeacherId PRIMARY KEY (TeacherId),
    FirstName		VARCHAR(20),
    LastName		VARCHAR(25) NOT NULL,
    Email          VARCHAR(25)
    CONSTRAINT     NN_TeacherEmail  NOT NULL,
    PhoneNumber   VARCHAR(20),
    HireDate      DATE,
    Salary         MONEY
    CONSTRAINT     CHK_TeacherSalaryMin CHECK (Salary > 500), 
    CONSTRAINT     CHK_TeacherEmailUnique UNIQUE (Email)
);
GO

CREATE TABLE UNIVERSITY..Students(
    StudentId    INT
    CONSTRAINT PK_StudentId PRIMARY KEY (StudentId),
    FirstName     VARCHAR(25),
    LastName      VARCHAR(25) NOT NULL,
    PhoneNumber   VARCHAR(20),
    BirthDate      DATE NOT NULL,
    GroupId    INT
);
GO

CREATE TABLE UNIVERSITY..Subjects(
    SubjectId    INT IDENTITY(1,1) 
    CONSTRAINT PK_SubjectId PRIMARY KEY (SubjectId), 
    SubjectName  VARCHAR(30) NOT NULL,
    MainTeacherId	INT	
    CONSTRAINT FK_Subjects_MainTeacherId FOREIGN KEY (MainTeacherId) REFERENCES Teachers (TeacherId)
);
GO

CREATE TABLE UNIVERSITY..Buildings(
    BuildingId   INT IDENTITY(1,1),
    BuildingName   VARCHAR(20) NOT NULL
    CONSTRAINT PK_BuildingId PRIMARY KEY (BuildingId)
);
GO

CREATE TABLE UNIVERSITY..Classrooms(
    ClassroomId    INT IDENTITY(1,1),
    CONSTRAINT PK_ClassroomId PRIMARY KEY (ClassroomId),
    ClassroomName  VARCHAR(20) NOT NULL,
    BuildingId   INT NOT NULL
    CONSTRAINT FK_Classrooms_BuildingId FOREIGN KEY (BuildingId) REFERENCES Buildings(BuildingId)
);
GO

CREATE TABLE UNIVERSITY..Timetables(
    SubjectId    INT NOT NULL,
    StudentId  INT NOT NULL,
    TeacherId  INT NOT NULL,
    ClassroomId    INT NOT NULL,
    CONSTRAINT FK_Timetables_StudentId FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
    CONSTRAINT FK_Timetables_SubjectId FOREIGN KEY (SubjectId) REFERENCES Subjects(SubjectId),
    CONSTRAINT FK_Timetables_TeacherId FOREIGN KEY (TeacherId) REFERENCES Teachers(TeacherId),
    CONSTRAINT FK_Timetables_ClassroomId FOREIGN KEY (ClassroomId) REFERENCES Classrooms(ClassroomId)
);
GO

CREATE TABLE UNIVERSITY..Groups(
    GroupId    INT NOT NULL UNIQUE,
    MinNrOfStudents   INT NOT NULL,
    MaxNrOfStudents   INT NOT NULL
);
GO

ALTER TABLE UNIVERSITY..Students ADD CONSTRAINT FK_Students_StudentGroup FOREIGN KEY (GroupId) REFERENCES Groups (GroupId);
GO

CREATE TABLE UNIVERSITY..FieldOfStudy(
    FieldOfStudyId     INT IDENTITY(1,1)
    CONSTRAINT PK_FieldOfStudyId PRIMARY KEY (FieldOfStudyId),
    FieldOfStudyName  VARCHAR(30) NOT NULL
);
GO

CREATE TABLE UNIVERSITY..AcademicYear(
    AcademicYearId	INT IDENTITY(1,1)
    CONSTRAINT PK_AcademicYearId PRIMARY KEY (AcademicYearId),
    AcademicYearName	Date NOT NULL
);
GO

CREATE TABLE UNIVERSITY..GroupTypes(
    GroupId    INT NOT NULL, 
    GroupName  VARCHAR(30)  NOT NULL,
    StudyMode   VARCHAR(30)	NOT NULL,	
    AcademicYearId INT NOT NULL,
    FieldOfStudyId INT NOT NULL,
    CONSTRAINT FK_GroupTypes_AcademicYearId FOREIGN KEY (AcademicYearId) REFERENCES AcademicYear(AcademicYearId),
    CONSTRAINT FK_GroupTypes_FieldOfStudyId FOREIGN KEY (FieldOfStudyId ) REFERENCES FieldOfStudy(FieldOfStudyId), 
    CONSTRAINT FK_GroupTypes_GroupId FOREIGN KEY (GroupId) REFERENCES Groups (GroupId),
    CONSTRAINT CHK_StudyModeIn CHECK(StudyMode IN('FULL TIME', 'PART TIME'))
);
GO

CREATE TABLE UNIVERSITY..Grades (
    GradeId int NOT NULL IDENTITY(1,1)
    CONSTRAINT PK_GradeId PRIMARY key (GradeId),
    GradeValue  FLOAT NOT NULL,
    GradeDate DATE,
    SubjectId  INT NOT NULL,
    StudentId  INT NOT NULL,
    Note VARCHAR(30) NOT NULL,
    CONSTRAINT FK_Grades_SubjectId FOREIGN KEY (SubjectId) REFERENCES Subjects(SubjectId),
    CONSTRAINT FK_Grades_StudentId FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
    CONSTRAINT CHK_GradeValueIn CHECK(GradeValue IN ('2', '3', '3.5', '4', '4.5', '5'))
);

GO

CREATE TABLE UNIVERSITY..Albums( 
    AlbumId INT 
    CONSTRAINT PK_AlbumId PRIMARY KEY (AlbumId),
    StudentId	INT 
    CONSTRAINT FK_Albums_StudentId FOREIGN KEY (StudentId) REFERENCES Students(StudentId)
);
GO

CREATE TABLE UNIVERSITY..FinalGrades (
    AlbumId INT NOT NULL,
    FinalGrade  INT,    
    SubjectId  INT NOT NULL,
    AcademicYearId INT NOT NULL,
    CONSTRAINT FK_FinalGrades_SubjectId FOREIGN KEY (SubjectId) REFERENCES Subjects(SubjectId),
    CONSTRAINT FK_FinalGrades_AlbumId FOREIGN KEY (AlbumId) REFERENCES Albums(AlbumId),
    CONSTRAINT FK_FinalGrades_AcademicYearId FOREIGN KEY (AcademicYearId) REFERENCES AcademicYear(AcademicYearId)
);
GO





