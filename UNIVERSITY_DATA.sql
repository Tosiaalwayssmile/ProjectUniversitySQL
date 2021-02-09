 USE UNIVERSITY;
/************************************ Teacher table INSERT  ************************************/
/********* Fields: TeacherId(identity), FirstName, LastName, Email, PhoneNumber, HireDate, Salary *********/
INSERT INTO UNIVERSITY..Teachers VALUES ('Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', CAST('17-AUG-1994'AS DATE), 1700);
INSERT INTO UNIVERSITY..Teachers VALUES ('Daniel', 'Faviet', 'DFAVIET', '515.364.4169', CAST('16-AUG-1994'AS DATE), 2300);		
INSERT INTO UNIVERSITY..Teachers VALUES ('John', 'Chen', 'JCHEN', '515.564.4269', CAST('28-SEP-1997'AS DATE), 2100);	
INSERT INTO UNIVERSITY..Teachers VALUES ('Luis', 'Popp', 'LPOPP', '515.764.4567', CAST('07-DEC-1999'AS DATE), 3670);
INSERT INTO UNIVERSITY..Teachers VALUES ('Anastasia', 'Grey', 'AGREY', '515.994.3213', CAST('17-JAN-1999'AS DATE), 2250);
INSERT INTO UNIVERSITY..Teachers VALUES ('Katniss', 'Everdeen', 'KEVER', 'NULL', CAST('12-FEB-1989'AS DATE), 2670);
INSERT INTO UNIVERSITY..Teachers VALUES ('Not', 'Working', 'NWORK', 'NULL', '12-09-1999', 5460);
UPDATE Teachers SET PhoneNumber ='515.124.3222' WHERE TeacherId = 150;

SELECT * FROM Teachers;
/************************************ Groups table INSERT  ************************************/
/********************* Fields: GroupId, MinNrOfStudents, MaxNrOfStudents **********************/
INSERT INTO UNIVERSITY..Groups VALUES (10, 1, 250);  
INSERT INTO UNIVERSITY..Groups VALUES (11, 1, 250);
INSERT INTO UNIVERSITY..Groups VALUES (12, 1, 250);
INSERT INTO UNIVERSITY..Groups VALUES (13, 1, 250);
INSERT INTO UNIVERSITY..Groups VALUES (14, 1, 250);
INSERT INTO UNIVERSITY..Groups VALUES (15, 1, 250);
INSERT INTO UNIVERSITY..Groups VALUES (16, 1, 250);
INSERT INTO UNIVERSITY..Groups VALUES (17, 1, 250);
INSERT INTO UNIVERSITY..Groups VALUES (18, 1, 250);

INSERT INTO UNIVERSITY..Groups VALUES (20, 1, 250); 
INSERT INTO UNIVERSITY..Groups VALUES (30, 1, 250); 
INSERT INTO UNIVERSITY..Groups VALUES (40, 1, 250); 

SELECT * FROM Groups;
/************************************ FieldOfStudy table INSERT  ************************************/
/*************************** Fields: FieldOfStudyId(identity), FieldOfStudyName *********************/
INSERT INTO UNIVERSITY..FieldOfStudy VALUES ('IT');
INSERT INTO UNIVERSITY..FieldOfStudy VALUES ('Mathematics');
INSERT INTO UNIVERSITY..FieldOfStudy VALUES ('Physics');

SELECT * FROM FieldOfStudy;
/************************************ AcademicYear table INSERT  ************************************/
/***************************** Fields: AcademicYearId(identity), AcademicYearName *****************************/
INSERT INTO UNIVERSITY..AcademicYear VALUES ('2017/11/10');

SELECT * FROM AcademicYear;
/************************************ GroupTypes table INSERT  ************************************/
/************** Fields: GroupId, GroupName, StudyMode, AcademicYearId, FieldOfStudyId *************/
INSERT INTO UNIVERSITY..GroupTypes VALUES ( 10, '10', 'FULL TIME', 1, 1);    
INSERT INTO UNIVERSITY..GroupTypes VALUES ( 11, '11', 'FULL TIME', 1, 1);  
INSERT INTO UNIVERSITY..GroupTypes VALUES ( 12, '12', 'PART TIME', 1, 1); 

INSERT INTO UNIVERSITY..GroupTypes VALUES ( 13, '13', 'FULL TIME', 1, 1); 
INSERT INTO UNIVERSITY..GroupTypes VALUES ( 14, '14', 'FULL TIME', 1, 1); 
INSERT INTO UNIVERSITY..GroupTypes VALUES ( 15, '15', 'PART TIME', 1, 1); 

INSERT INTO UNIVERSITY..GroupTypes VALUES ( 16, '16', 'FULL TIME', 1, 1);  
INSERT INTO UNIVERSITY..GroupTypes VALUES ( 17, '17', 'FULL TIME', 1, 1); 
INSERT INTO UNIVERSITY..GroupTypes VALUES ( 18, '18', 'PART TIME', 1, 1);  

INSERT INTO UNIVERSITY..GroupTypes VALUES ( 20, '20', 'FULL TIME', 1, 2); 
INSERT INTO UNIVERSITY..GroupTypes VALUES ( 30, '30', 'FULL TIME', 1, 3); 
INSERT INTO UNIVERSITY..GroupTypes VALUES ( 40, '40', 'PART TIME', 1, 3); 

SELECT * FROM GroupTypes;
/************************************ Students table INSERT  ************************************/
/********* Fields: StudentId, FirstName, LastName, PhoneNumber, BirthDate, GroupId *********/
INSERT INTO UNIVERSITY..Students VALUES ( 600, 'Susan', 'Mavris', '516.124.4567', CAST('13-DEC-1996'AS DATE), 10);
INSERT INTO UNIVERSITY..Students VALUES ( 610, 'Hermann', 'Baer', '516.125.4547', CAST('01-JUL-1996'AS DATE), 10);
INSERT INTO UNIVERSITY..Students VALUES ( 620, 'Shelley', 'Higgins', '513.124.4190', CAST('07-JUN-1997'AS DATE), 10);
INSERT INTO UNIVERSITY..Students VALUES ( 630, 'William', 'Gietz', '519.128.4257', CAST('22-OCT-1998'AS DATE), 10);
INSERT INTO UNIVERSITY..Students VALUES ( 640, 'Lilly', 'Collins', '516.125.1247', CAST('01-SEP-1998'AS DATE), 10);

INSERT INTO UNIVERSITY..Students VALUES ( 650, 'Nastya', 'Kasnikov', '517.145.6747', CAST('19-SEP-1998'AS DATE), 11);
INSERT INTO UNIVERSITY..Students VALUES ( 660, 'Rodion', 'Raskolnikov', '512.325.5555', CAST('30-MAR-1999'AS DATE), 11);
INSERT INTO UNIVERSITY..Students VALUES ( 670, 'Harry', 'Potter', '511.225.6666', CAST('05-APR-1999'AS DATE), 11);
INSERT INTO UNIVERSITY..Students VALUES ( 680, 'Peter', 'Parker', '516.725.7777', CAST('03-MAY-1999'AS DATE), 11);

INSERT INTO UNIVERSITY..Students VALUES ( 690, 'Alexander', 'Grayson', '546.325.7757', CAST('09-FEB-1998'AS DATE), 12);
INSERT INTO UNIVERSITY..Students VALUES ( 700, 'Bronagh', 'Murphy', '546.376.7457', CAST('18-OCT-1997'AS DATE), 12);		
INSERT INTO UNIVERSITY..Students VALUES ( 710, 'Tony', 'Stark', '946.325.7370', CAST('11-OCT-1997'AS DATE), 12);
INSERT INTO UNIVERSITY..Students VALUES ( 720, 'Neal', 'Caffrey', '846.325.8757', CAST('23-JUN-1998'AS DATE), 12); 

INSERT INTO UNIVERSITY..Students VALUES ( 730, 'Geralt', 'Zrivii', '511.325.7757', CAST('09-JUN-1998'AS DATE), 13);
INSERT INTO UNIVERSITY..Students VALUES ( 740, 'Jaskier', 'Bard', '512.325.7757', CAST('01-JUL-1998'AS DATE), 13);
INSERT INTO UNIVERSITY..Students VALUES ( 750, 'Yennefer', 'Vengerberg', '513.325.7755', CAST('01-DEC-1998'AS DATE), 13);
INSERT INTO UNIVERSITY..Students VALUES ( 760, 'Tris', 'Merigold', '514.325.7757', CAST('19-MAY-1998'AS DATE), 13);
INSERT INTO UNIVERSITY..Students VALUES ( 770, 'Cirilla', 'Riannon', '516.325.7757', CAST('15-SEP-1998'AS DATE), 13);

INSERT INTO UNIVERSITY..Students VALUES ( 780, 'Daenerys', 'Targaryen', '516.325.7157', CAST('11-JUN-1997'AS DATE), 14);
INSERT INTO UNIVERSITY..Students VALUES ( 790, 'Jon', 'Snow', '516.325.7337', CAST('18-AUG-1997'AS DATE), 14);
INSERT INTO UNIVERSITY..Students VALUES ( 800, 'Arya', 'Stark', '516.325.7227', CAST('20-FEB-1997'AS DATE), 14);
INSERT INTO UNIVERSITY..Students VALUES ( 810, 'Tyrion', 'Lannister', '516.325.7057', CAST('22-SEP-1997'AS DATE), 14);
INSERT INTO UNIVERSITY..Students VALUES ( 820, 'Cersei', 'Lannister', '516.325.7887', CAST('05-MAR-1997'AS DATE), 14);
INSERT INTO UNIVERSITY..Students VALUES ( 830, 'Sansa', 'Stark', '516.325.0007', CAST('09-APR-1997'AS DATE), 14);
INSERT INTO UNIVERSITY..Students VALUES ( 840, 'Khal', 'Drogo', '516.325.5557', CAST('26-JUL-1997'AS DATE), 14);

INSERT INTO UNIVERSITY..Students VALUES ( 850, 'Joffrey', 'Baratheon', '516.005.5557', CAST('26-OCT-1996'AS DATE), 15);
INSERT INTO UNIVERSITY..Students VALUES ( 860, 'Petyr', 'Baelish', '516.895.5557', CAST('22-JUL-1996'AS DATE), 15);
INSERT INTO UNIVERSITY..Students VALUES ( 870, 'Sandor', 'Clegane', '516.355.5557', CAST('24-SEP-1998'AS DATE), 15);
INSERT INTO UNIVERSITY..Students VALUES ( 880, 'Melisandre', 'Red', '516.225.5557', CAST('13-JUL-1994'AS DATE), 15);
INSERT INTO UNIVERSITY..Students VALUES ( 890, 'Margaery', 'Tyrell', '516.995.5557', CAST('07-AUG-1997'AS DATE), 15);

INSERT INTO UNIVERSITY..Students VALUES ( 900, 'Theon', 'Greyjoy', '516.325.1157', CAST('21-OCT-1997'AS DATE), 16);
INSERT INTO UNIVERSITY..Students VALUES ( 910, 'Brienne', 'Tarthu', '516.325.5117', CAST('22-DEC-1997'AS DATE), 16);
INSERT INTO UNIVERSITY..Students VALUES ( 920, 'Jaime', 'Lannister', '516.325.5511', CAST('25-DEC-1997'AS DATE), 16);
INSERT INTO UNIVERSITY..Students VALUES ( 930, 'Ygritte', 'Wildone', '516.325.1117', CAST('06-JUL-1997'AS DATE), 16);

INSERT INTO UNIVERSITY..Students VALUES ( 940, 'Robb', 'Stark', '516.325.1122', CAST('05-MAY-1996'AS DATE), 17);
INSERT INTO UNIVERSITY..Students VALUES ( 950, 'Daario', 'Naharis', '333.325.1117', CAST('06-AUG-1996'AS DATE), 17);
INSERT INTO UNIVERSITY..Students VALUES ( 960, 'Oberyn', 'Martell', '446.325.1117', CAST('13-DEC-1997'AS DATE), 17);
INSERT INTO UNIVERSITY..Students VALUES ( 970, 'Patrick', 'Jane', '555.325.1117', CAST('15-SEP-1998'AS DATE), 17);
INSERT INTO UNIVERSITY..Students VALUES ( 980, 'Teresa', 'Lisbon', '566.325.1117', CAST('24-JUL-1996'AS DATE), 17);

INSERT INTO UNIVERSITY..Students VALUES ( 990, 'Grace', 'Van Pelt', '999.325.1117', CAST('06-JUL-1998'AS DATE), 18);
INSERT INTO UNIVERSITY..Students VALUES ( 1000, 'Kimball', 'Cho', '589.325.1117', CAST('11-AUG-1998'AS DATE), 18);
INSERT INTO UNIVERSITY..Students VALUES ( 1010, 'Wayne', 'Rigsby', '578.325.1117', CAST('27-FEB-1998'AS DATE), 18);
INSERT INTO UNIVERSITY..Students VALUES ( 1020, 'Erica', 'Flynn', '515.325.1117', CAST('30-APR-1998'AS DATE), 18);

INSERT INTO UNIVERSITY..Students VALUES ( 1030, 'Sherlock', 'Holmes', '515.742.1117', CAST('30-APR-1998'AS DATE), 20);
INSERT INTO UNIVERSITY..Students VALUES ( 1040, 'Oliver', 'Queen', '515.722.1117', CAST('30-APR-1997'AS DATE), 20);
INSERT INTO UNIVERSITY..Students VALUES ( 1050, 'Felicity', 'Smoak', '515.244.1117', CAST('30-APR-1999'AS DATE), 20);
INSERT INTO UNIVERSITY..Students VALUES ( 1060, 'Roy', 'Harper', '515.888.1117', CAST('30-APR-1996'AS DATE), 20);
INSERT INTO UNIVERSITY..Students VALUES ( 1070, 'Thea', 'Queen', '515.555.1117', CAST('30-APR-1996'AS DATE), 20);
INSERT INTO UNIVERSITY..Students VALUES ( 1080, 'John', 'Diggle', '515.000.1117', CAST('30-APR-1998'AS DATE), 20);


INSERT INTO UNIVERSITY..Students VALUES ( 1090, 'Sara', 'Lance', '515.355.1117', CAST('30-APR-1997'AS DATE), 30);
INSERT INTO UNIVERSITY..Students VALUES ( 1100, 'Malcolm', 'Merlyn', '515.222.1117', CAST('30-APR-1997'AS DATE), 30);
INSERT INTO UNIVERSITY..Students VALUES ( 1110, 'Slade', 'Wilson', '525.775.1117', CAST('30-APR-1996'AS DATE), 30);
INSERT INTO UNIVERSITY..Students VALUES ( 1120, 'Isabel', 'Rochev', '515.835.1117', CAST('30-APR-1996'AS DATE), 30);
INSERT INTO UNIVERSITY..Students VALUES ( 1130, 'Liv', 'Moore', '522.382.1117', CAST('30-APR-1999'AS DATE), 30);
INSERT INTO UNIVERSITY..Students VALUES ( 1140, 'Blaine', 'DeBeers', '555.245.1117', CAST('30-APR-1999'AS DATE), 30);

INSERT INTO UNIVERSITY..Students VALUES ( 1150, 'Ed', 'Sheeran', '524.177.7217', CAST('20-MAY-1997'AS DATE), 40);
INSERT INTO UNIVERSITY..Students VALUES ( 1160, 'Selena', 'Gomez', '523.137.7217', CAST('22-JUL-1992'AS DATE), 40);

SELECT * FROM Students;
/************************************ Subjects table INSERT  ************************************/
/***************************** Fields: SubjectId(identity), SubjectName, MainTeacherId *****************************/
INSERT INTO UNIVERSITY..Subjects VALUES ('SYSOPY', 100);
INSERT INTO UNIVERSITY..Subjects VALUES ('ZSBD', 110);
INSERT INTO UNIVERSITY..Subjects VALUES ('TP', 120);
INSERT INTO UNIVERSITY..Subjects VALUES ('WDI', 100);
INSERT INTO UNIVERSITY..Subjects VALUES ('PROKOMP', 130);
INSERT INTO UNIVERSITY..Subjects VALUES ('POBI', 130);
INSERT INTO UNIVERSITY..Subjects VALUES ('ENGLISH', 140);
INSERT INTO UNIVERSITY..Subjects VALUES ('PE', 140);
INSERT INTO UNIVERSITY..Subjects VALUES ('EMBEDDED', 120);
INSERT INTO UNIVERSITY..Subjects VALUES ('CAD', 150);

SELECT * FROM Subjects;
/************************************** Buildings table INSERT  ***************************************/
/***************************** Fields: BuildingId(identity), BuildingName *****************************/
INSERT INTO UNIVERSITY..Buildings VALUES ('B9');
INSERT INTO UNIVERSITY..Buildings VALUES ('CTI');
INSERT INTO UNIVERSITY..Buildings VALUES ('B14');

SELECT * FROM Buildings;
/******************************************* Classrooms table INSERT  ************88*********************************/
/***************************** Fields: ClassroomId(identity), ClassroomName, BuildingId *****************************/
INSERT INTO UNIVERSITY..Classrooms VALUES ('F10', 1);
INSERT INTO UNIVERSITY..Classrooms VALUES ('AULA', 3);
INSERT INTO UNIVERSITY..Classrooms VALUES ('F.04', 3);
INSERT INTO UNIVERSITY..Classrooms VALUES ('409', 2);

SELECT * FROM Classrooms;
/***************************************** Timetables table INSERT  ********************************************/
/***************************** Fields:SubjectId, StudentId, TeacherId, ClassroomId *****************************/
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 600, 100, 1);
INSERT INTO UNIVERSITY..Timetables VALUES ( 2, 600, 110, 1);
INSERT INTO UNIVERSITY..Timetables VALUES ( 3, 600, 120, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 4, 600, 130, 3);

INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 610, 100, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 5, 610, 150, 3);
INSERT INTO UNIVERSITY..Timetables VALUES ( 6, 610, 140, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 7, 610, 130, 1);

INSERT INTO UNIVERSITY..Timetables VALUES ( 8, 620, 100, 1);
INSERT INTO UNIVERSITY..Timetables VALUES ( 10, 620, 110, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 9, 620, 120, 3);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 620, 130, 2);

INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 630, 100, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 2, 630, 110, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 3, 630, 120, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 4, 630, 130, 2);

INSERT INTO UNIVERSITY..Timetables VALUES (10, 640, 150, 1);
INSERT INTO UNIVERSITY..Timetables VALUES ( 9, 640, 140, 1);
INSERT INTO UNIVERSITY..Timetables VALUES ( 3, 640, 130, 1);
INSERT INTO UNIVERSITY..Timetables VALUES ( 4, 640, 120, 1);

INSERT INTO UNIVERSITY..Timetables VALUES ( 8, 650, 110, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 7, 650, 100, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 3, 650, 120, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 4, 650, 130, 2);

INSERT INTO UNIVERSITY..Timetables VALUES ( 6, 660, 150, 3);
INSERT INTO UNIVERSITY..Timetables VALUES ( 5, 660, 140, 3);
INSERT INTO UNIVERSITY..Timetables VALUES ( 3, 660, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 4, 660, 120, 1);

INSERT INTO UNIVERSITY..Timetables VALUES ( 5, 670, 100, 1);
INSERT INTO UNIVERSITY..Timetables VALUES ( 2, 670, 110, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 3, 670, 120, 3);
INSERT INTO UNIVERSITY..Timetables VALUES ( 4, 670, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 680, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 690, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 710, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 720, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 730, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 740, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 750, 130, 2);

INSERT INTO UNIVERSITY..Timetables VALUES ( 2, 760, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 2, 770, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 2, 780, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 2, 790, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 2, 800, 130, 2); 

INSERT INTO UNIVERSITY..Timetables VALUES ( 3, 860, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 4, 870, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 4, 800, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 6, 880, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 7, 890, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 900, 110, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 5, 910, 120, 2);

INSERT INTO UNIVERSITY..Timetables VALUES ( 8, 920, 120, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 9, 930, 150, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 10, 940, 140, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 950, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 960, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 970, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 980, 130, 2);

INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 990, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1000, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1010, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1020, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1040, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1050, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1060, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1070, 130, 2);

INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1080, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1090, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1100, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1110, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1120, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1130, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1140, 130, 2);
INSERT INTO UNIVERSITY..Timetables VALUES ( 1, 1070, 130, 2);

SELECT * FROM Timetables;
/******************************************* Grades table INSERT  ************88*********************************/
/******************* Fields: GradeId(identity), GradeValue, GradeDate, SubjectId, StudentId, Note ***************/
INSERT INTO UNIVERSITY..Grades VALUES (3.5, '2017/11/10', 1, 600, 'For Homework'); 
INSERT INTO UNIVERSITY..Grades VALUES (3, '2017/12/14', 1, 600, 'Test');
INSERT INTO UNIVERSITY..Grades VALUES (2, '2018/02/01', 5, 610, 'Mid test');
INSERT INTO UNIVERSITY..Grades VALUES (3, '2017/12/19', 8, 620, 'Speech');
INSERT INTO UNIVERSITY..Grades VALUES (4, '2017/11/10', 1, 630, 'For Homework');
INSERT INTO UNIVERSITY..Grades VALUES (5, '2017/12/17', 10, 640, 'For Homework');
INSERT INTO UNIVERSITY..Grades VALUES (3, '2018/02/01', 4, 640, 'Mid test');
INSERT INTO UNIVERSITY..Grades VALUES (4.5, '2017/12/03', 4, 640, 'For Homework');
INSERT INTO UNIVERSITY..Grades VALUES (5, '2018/02/01', 3, 650, 'Mid test');
INSERT INTO UNIVERSITY..Grades VALUES (4, '2018/02/01', 3, 660, 'Mid test');
INSERT INTO UNIVERSITY..Grades VALUES (3, '2018/02/01', 3, 670, 'Mid test');
INSERT INTO UNIVERSITY..Grades VALUES (5, '2018/06/01', 5, 670, 'For Homework');
INSERT INTO UNIVERSITY..Grades VALUES (4, '2018/05/30', 3, 670, 'Project');

SELECT * FROM Grades;
/******************************************* Albums table INSERT  *********************************************/
/**************************************** Fields: AlbumId, StudentId ********************************/
INSERT INTO UNIVERSITY..Albums VALUES (1, 600);
INSERT INTO UNIVERSITY..Albums VALUES (2, 610);
INSERT INTO UNIVERSITY..Albums VALUES (3, 620);
INSERT INTO UNIVERSITY..Albums VALUES (4, 630);
INSERT INTO UNIVERSITY..Albums VALUES (5, 640);
INSERT INTO UNIVERSITY..Albums VALUES (6, 650);
INSERT INTO UNIVERSITY..Albums VALUES (7, 660);
INSERT INTO UNIVERSITY..Albums VALUES (8, 670);
INSERT INTO UNIVERSITY..Albums VALUES (9, 680);
INSERT INTO UNIVERSITY..Albums VALUES (10, 690);
INSERT INTO UNIVERSITY..Albums VALUES (11, 700);
INSERT INTO UNIVERSITY..Albums VALUES (12, 710);
INSERT INTO UNIVERSITY..Albums VALUES (13, 720);
INSERT INTO UNIVERSITY..Albums VALUES (14, 730);
INSERT INTO UNIVERSITY..Albums VALUES (15, 740);
INSERT INTO UNIVERSITY..Albums VALUES (16, 750);
INSERT INTO UNIVERSITY..Albums VALUES (17, 760);
INSERT INTO UNIVERSITY..Albums VALUES (18, 770);
INSERT INTO UNIVERSITY..Albums VALUES (19, 780);
INSERT INTO UNIVERSITY..Albums VALUES (20, 790);
INSERT INTO UNIVERSITY..Albums VALUES (21, 800);
INSERT INTO UNIVERSITY..Albums VALUES (22, 810);
INSERT INTO UNIVERSITY..Albums VALUES (23, 820);
INSERT INTO UNIVERSITY..Albums VALUES (24, 830);
INSERT INTO UNIVERSITY..Albums VALUES (25, 840);
INSERT INTO UNIVERSITY..Albums VALUES (26, 850);
INSERT INTO UNIVERSITY..Albums VALUES (27, 860);
INSERT INTO UNIVERSITY..Albums VALUES (28, 870);
INSERT INTO UNIVERSITY..Albums VALUES (29, 880);
INSERT INTO UNIVERSITY..Albums VALUES (30, 890);
INSERT INTO UNIVERSITY..Albums VALUES (31, 900);
INSERT INTO UNIVERSITY..Albums VALUES (32, 910);
INSERT INTO UNIVERSITY..Albums VALUES (33, 920);
INSERT INTO UNIVERSITY..Albums VALUES (34, 930);
INSERT INTO UNIVERSITY..Albums VALUES (35, 940);
INSERT INTO UNIVERSITY..Albums VALUES (36, 950);
INSERT INTO UNIVERSITY..Albums VALUES (37, 960);
INSERT INTO UNIVERSITY..Albums VALUES (38, 970);
INSERT INTO UNIVERSITY..Albums VALUES (39, 980);
INSERT INTO UNIVERSITY..Albums VALUES (40, 990);
INSERT INTO UNIVERSITY..Albums VALUES (41, 1000);
INSERT INTO UNIVERSITY..Albums VALUES (42, 1010);
INSERT INTO UNIVERSITY..Albums VALUES (43, 1020);
INSERT INTO UNIVERSITY..Albums VALUES (44, 1030);
INSERT INTO UNIVERSITY..Albums VALUES (45, 1040);
INSERT INTO UNIVERSITY..Albums VALUES (46, 1050);
INSERT INTO UNIVERSITY..Albums VALUES (47, 1060);
INSERT INTO UNIVERSITY..Albums VALUES (48, 1070);
INSERT INTO UNIVERSITY..Albums VALUES (49, 1080);
INSERT INTO UNIVERSITY..Albums VALUES (50, 1090);
INSERT INTO UNIVERSITY..Albums VALUES (51, 1100);
INSERT INTO UNIVERSITY..Albums VALUES (52, 1110);
INSERT INTO UNIVERSITY..Albums VALUES (53, 1120);
INSERT INTO UNIVERSITY..Albums VALUES (54, 1130);
INSERT INTO UNIVERSITY..Albums VALUES (55, 1140);
INSERT INTO UNIVERSITY..Albums VALUES (56, 1150);
INSERT INTO UNIVERSITY..Albums VALUES (57, 1160); 

SELECT * FROM Albums;
/******************************************* FinalGrades table INSERT  *********************************************/
/********************************* Fields: AlbumId, FinalGrade, SubjectId, AcademicYearId **************************/
INSERT INTO UNIVERSITY..FinalGrades VALUES (1, 5, 1, 1);
INSERT INTO UNIVERSITY..FinalGrades VALUES (1, 4, 3, 1);
INSERT INTO UNIVERSITY..FinalGrades VALUES (1, 4, 2, 1);

INSERT INTO UNIVERSITY..FinalGrades VALUES (2, 4, 1, 1);
INSERT INTO UNIVERSITY..FinalGrades VALUES (2, 5, 2, 1);

INSERT INTO UNIVERSITY..FinalGrades VALUES (2, 4, 3, 1);

INSERT INTO UNIVERSITY..FinalGrades VALUES (3, 1, 1, 1);

SELECT * FROM FinalGrades;







