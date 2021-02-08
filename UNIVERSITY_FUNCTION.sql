USE UNIVERSITY;
----------------------- FUNCTION 1-----------------------------------
-- Funkcja podaj¹ca dla ka¿dej grupy, ile procent wszystkich studentów znajduje siê w tej grupie.
IF OBJECT_ID ('group_perc') IS NOT NULL  
drop function group_perc;
go
create function group_perc (@group_id varchar(15)) returns float
as
begin
	declare @percentage float
	declare @in_group float
	declare @all float
	select @all = count(*) from students
	select @in_group = count (*) from students as s
						where group_id in (select g.group_id from groups as g
											  where g.group_id = @group_id)

set @percentage = 100 * @in_group / @all
return @percentage 
end
go

select distinct gt.group_name AS 'Group',cast(round(dbo.group_perc(g.group_id), 1) as varchar)
+ '%' as 'Percentage' from groups g, group_types gt where g.group_id = gt.group_id AND g.group_id =10 group by gt.group_name, g.group_id;

select distinct gt.group_name AS 'Group',cast(round(dbo.group_perc(g.group_id), 1) as varchar)
+ '%' as 'Percentage' from groups g, group_types gt where g.group_id = gt.group_id group by gt.group_name, g.group_id;
