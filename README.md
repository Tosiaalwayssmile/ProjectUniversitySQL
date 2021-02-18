# ProjectUniversitySQL
SQL Server project with **triggers**, stored **procedures** and **functions** and **own database project**. Project University simulates database for real university where students belong to different groups, have timetables with courses that they enrolled in and classrooms where the lessons take place. Also each subject has assinged main teacher.

**What can you find here:**
1) In [**UNIVERSITY_SCHEMA.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_SCHEMA.sql) you can find my own database schema including 13 tables with **relations one-to-many and many-to-many**.
2) In [**UNIVERSITY_DATA.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_DATA.sql) you can find a bunch of **INSERT** and some **UPDATE** examples to test out the project as well as **SELECT** queries to see the results.
3) In [**UNIVERSITY_FUNCTION.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_FUNCTION.sql) you can find a **User Defined Function** returning percentage of all students in each group.
4) In [**UNIVERSITY_PROCEDURES.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_PROCEDURES.sql) you can find three **User Defined Procedures**. E.g. procedure ADD_STUDENT assigns random ID when new student is inserted. It uses **cursor** to go through every student and check if new ID is not already in database.

5) [**UNIVERSITY_QUERIES.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_QUERIES.sql) is being updated.
6) In [**UNIVERSITY_TRIGGERS.sql**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/UNIVERSITY_TRIGGERS.sql) there are 5 **Triggers**. E.g. trigger DELETE_STUDENT acts instead of delete so when student is deleted it deletes student as well as all references to this student.

7) [**DatabaseModel.png**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/DatabaseModel.png) shows a database model from the **SQL diagram** tool.
8) [**Sprawozdanie.pdf**](https://github.com/Tosiaalwayssmile/ProjectUniversitySQL/blob/main/Sprawozdanie.pdf) is a project report for this project. It presents **results for** all the **queries**, **functions**, **procedures** and **triggers**. It also includes SQL diagram in better quality. 
