USE UNIVERSITY;
/***************************************** FUNCTION #1 ********************************************/
-- EN: Function returning percentage of all students in each group.
-- PL: Funkcja podajaca dla kazdej grupy, ile procent wszystkich studentów znajduje sie w tej grupie.

IF OBJECT_ID ('PercentageOfStudentsInGroup') IS NOT NULL  
DROP FUNCTION PercentageOfStudentsInGroup;
GO
CREATE FUNCTION PercentageOfStudentsInGroup (@GroupId INT) 
RETURNS FLOAT AS
BEGIN
    DECLARE @Percentage FLOAT
    DECLARE @NumberOfStudentsInGroup INT
    DECLARE @AllStudents INT
    SELECT @AllStudents = COUNT(*) FROM Students
    SELECT @NumberOfStudentsInGroup = COUNT (*) FROM Students AS s
    WHERE GroupId IN (SELECT g.GroupId FROM Groups AS g WHERE g.GroupId = @GroupId)
    SET @Percentage = 100.0 * @NumberOfStudentsInGroup / @AllStudents
    RETURN @Percentage 
END
GO

/****************** #1 Query  ******************/
SELECT DISTINCT GroupName AS 'Group Number', CAST(ROUND(dbo.PercentageOfStudentsInGroup(Groups.GroupId), 1) AS VARCHAR) + '%' as 'Percentage Of Students In Group' 
FROM Groups, GroupTypes 
WHERE Groups.GroupId = GroupTypes.GroupId AND Groups.GroupId = 10 
GROUP BY GroupTypes.GroupName, Groups.GroupId;

/****************** #2 Query  ******************/
SELECT  GroupTypes.GroupName AS 'Group Number', CAST(ROUND(dbo.PercentageOfStudentsInGroup(Groups.GroupId), 1) AS VARCHAR) + '%' as 'Percentage Of Students In Group' 
FROM Groups   
INNER JOIN GroupTypes ON Groups.GroupId = GroupTypes.GroupId 
GROUP BY GroupTypes.GroupName, Groups.GroupId;

/****************** #2 Query (Version without "INNER JOIN") ******************/
/*
SELECT DISTINCT GroupTypes.GroupName AS 'Group', CAST(ROUND(dbo.PercentageOfStudentsInGroup(Groups.GroupId), 2) AS VARCHAR) + '%' as 'Percentage' 
FROM Groups, GroupTypes  
WHERE Groups.GroupId = GroupTypes.GroupId 
GROUP BY GroupTypes.GroupName, Groups.GroupId;
*/
