select * from [dbo].[organizations]


select * from [dbo].[patients]
select * from dbo.encounters

select * from [dbo].[payers]


select * from [dbo].[procedures]




with  s as (
select e.[START] , e.STOP , p.Id , p.[FIRST] , p.DEATHDATE , p.COUNTY

from dbo.encounters e 
join dbo.patients p 
on e.PATIENT = p.Id and p.DEATHDATE is not NULL

) select id from s


































































