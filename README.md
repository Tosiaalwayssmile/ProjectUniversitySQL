# Project 'University' - SQL
SQL Server project with **triggers**, stored **procedures** and **functions** and **own database project**. Project University simulates database for real university where students belong to different groups, have timetables with courses that they enrolled in and classrooms where the lessons take place. Also each subject has assinged main teacher.

**What can you find here:**
File | Content | 
:---:  | :---: |
[**UNIVERSITY_SCHEMA.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_SCHEMA.sql) |  Own database schema including 13 tables with **relations one-to-many and many-to-many**. |
[**UNIVERSITY_DATA.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_DATA.sql) | A bunch of **INSERT** and some **UPDATE** examples to test out the project as well as **SELECT** queries to see the results.|
[**UNIVERSITY_FUNCTION.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_FUNCTION.sql)| **User Defined Function** returning percentage of all students in each group. |
[**UNIVERSITY_PROCEDURES.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_PROCEDURES.sql)| Three **User Defined Procedures**. E.g. procedure ADD_STUDENT assigns random ID when new student is inserted. It uses **cursor** to go through every student and check if new ID is not already in database. |
[**UNIVERSITY_QUERIES.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_QUERIES.sql) | Content is being updated.
[**UNIVERSITY_TRIGGERS.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_TRIGGERS.sql) | 5 **Triggers**. E.g. trigger DELETE_STUDENT acts instead of delete so when student is deleted it deletes student as well as all references to this student.
[**DatabaseModel.png**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/DatabaseModel.png) | Database model from the **SQL diagram** tool.
[**Sprawozdanie.pdf**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/Sprawozdanie.pdf) | Project report for this project. It presents **results for** all the **queries**, **functions**, **procedures** and **triggers**. It also includes SQL diagram in better quality. 
