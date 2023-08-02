select * from [Portfolio Project SQL].dbo.[Above 35 HA]
select * from [Portfolio Project SQL].dbo.[Below 35 HA]

---Fields used to characterise the class(heart attack)

select age,gender,impulse,[high BP],glucose,class from [Portfolio Project SQL].dbo.[Above 35 HA]
order by 1 

---Looking at high BP, low BP, class
---Shows likehood of gender female

select gender,[high BP],[low BP],class,([high BP]/[low BP]) as heartrate
from [Portfolio Project SQL].dbo.[Above 35 HA]
where gender like '%0%'
order by 1
---Shows likehood of gender male
select gender,[high BP],[low BP],class,([high BP]/[low BP]) as heartrate
from [Portfolio Project SQL].dbo.[Above 35 HA]
where gender like '%1%'
order by 1

---looking at how many are positive and negative of heart attack compared with age,glucose

select age,gender,glucose,class
from [Portfolio Project SQL].dbo.[Above 35 HA]
where (class = 'positive' and gender = 0) OR (class = 'negative' and gender = 1)
order by 2

---Group By how many negative and positive as per gender
select gender,class,count(*) as Total
from [Portfolio Project SQL].dbo.[Above 35 HA]
group by gender,class
order by 1

---Joining two tables
select * from
[Portfolio Project SQL].dbo.[Above 35 HA]
FULL OUTER JOIN [Portfolio Project SQL].dbo.[Below 35 HA]
ON [Above 35 HA].age = [Below 35 HA].age

---Left join

select * from
[Portfolio Project SQL].dbo.[Above 35 HA]
left join [Portfolio Project SQL].dbo.[Below 35 HA]
ON [Above 35 HA].age = [Below 35 HA].age

---right join

select * from
[Portfolio Project SQL].dbo.[Above 35 HA]
right join [Portfolio Project SQL].dbo.[Below 35 HA]
ON [Above 35 HA].age = [Below 35 HA].age

---Clubbing tables together by insert into
Insert into [Portfolio Project SQL].dbo.[Above 35 HA](age,gender,impulse,[high BP],[low BP],glucose,kcm,troponin,class)
select age,gender,impulse,[high BP],[low BP],glucose,kcm,troponin,class
from [Portfolio Project SQL].dbo.[Below 35 HA]
select * from [Portfolio Project SQL].dbo.[Above 35 HA]

---Removing duplicate values using CTE (common table expression)

select DISTINCT age,gender,impulse,[high BP],[low BP],glucose,kcm,troponin,class
from [Portfolio Project SQL].dbo.[Above 35 HA];

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY age, gender, impulse, [high BP], [low BP], glucose, kcm, troponin, class ORDER BY age) AS rn
    FROM [Above 35 HA]
)
DELETE FROM CTE
WHERE rn > 1;

---Temp table
Drop table if exists #demo2
create table #demo2
(age varchar(50),
gender varchar(50),
impulse int,
[high BP] int,
[low BP] int,
glucose int,
kcm int,
troponin float,
class varchar(50))

Insert into #demo2
select age,gender,impulse,[high BP],[low BP],glucose,kcm,troponin,class
from [Portfolio Project SQL].dbo.[Below 35 HA]
SELECT *,
           ROW_NUMBER() OVER (PARTITION BY age, gender, impulse, [high BP], [low BP], glucose, kcm, troponin, class ORDER BY age) as result
    FROM [Above 35 HA]
