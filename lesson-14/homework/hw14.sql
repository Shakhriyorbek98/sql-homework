/*1. Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)*/

Select *, RIGHT(Name, LEN(name)-charindex(',', name)) as Surname from [TestMultipleColumns]

/*2. Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)*/

Select * from TestPercent
where strs like '%[%]%'

/*3. In this puzzle you will have to split a string based on dot(.).(Splitter)*/

select *, RIGHT(vals, len(vals)-charindex('.', vals)) from splitter

SELECT 
    s.Id,
    x.value('.', 'VARCHAR(100)') AS Part
FROM Splitter s
CROSS APPLY (
    SELECT CAST('<x>' + REPLACE(s.Vals, '.', '</x><x>') + '</x>' AS XML)
) AS A(xmlval)
CROSS APPLY xmlval.nodes('/x') AS Split(x);



/*4. Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)*/

DECLARE @str VARCHAR(100) = '1234ABC123456XYZ1234567890ADS';

SELECT REPLACE(TRANSLATE(@str, '0123456789', 'XXXXXXXXXX'), ' ', '') AS result;




/*5. Write a SQL query to return all rows where the value in the Vals column 
contains more than two dots (.).(testDots) */

	select *from testDots
	where len(Vals) - len(replace(Vals, '.', '')) > 2;

/*6. Write a SQL query to count the spaces present in the string.(CountSpaces) */


select *, LEN(texts)- len(replace(texts, ' ', '')) as space_count from CountSpaces

/*7. write a SQL query that finds out employees who earn more than their managers.(Employee) */

select e.Name as EmployeeName from Employee e join employee m on e.managerid=m.id 
where e.salary >m.salary;

select * from Employee e join employee m on e.managerid=m.id 
where e.salary >m.salary;


/* 8. Find the employees who have been with the company for more than 10 years, but less than 15 years. 
Display their Employee ID, First Name, Last Name, 
Hire Date, and the Years of Service (calculated as the number of years 
between the current date and the hire date).(Employees)*/

select EMPLOYEE_ID, FIRST_NAME,LAST_NAME, HIRE_DATE from employees
where (year(GETDATE())-year(HIRE_DATE)) >10 and (year(GETDATE())-year(HIRE_DATE))<15


/*1. Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)*/

DECLARE @input VARCHAR(100) = 'rtcfvty34redt';

SELECT
    @input AS Original_String,
    TRANSLATE(@input, 'abcdefghijklmnopqrstuvwxyz', REPLICATE(' ', 26)) AS Only_Digits,
    TRANSLATE(@input, '0123456789', REPLICATE(' ', 10)) AS Only_Chars;

/*2. write a SQL query to find all dates' Ids with higher temperature compared 
to its previous (yesterday's) dates.(weather)*/


select w1.id from weather w1 join weather w2 on datediff(day, w2.recorddate, w1.recorddate)=1
where w1.temperature>w2.Temperature

/*3. Write an SQL query that reports the first login date for each player.(Activity)*/
	
	SELECT 
    player_id, 
    MIN(event_date) AS first_login
FROM 
    Activity
GROUP BY 
    player_id;


/*4. Your task is to return the third item from that list.(fruits)*/

select *, right(fruit_list, len(right(fruit_list, len(fruit_list)-charindex(',', fruit_list)-1))-charindex(',', fruit_list)) 
from fruits

SELECT
    x.value('.', 'VARCHAR(100)') AS ThirdFruit
FROM (
    SELECT CAST('<x>' + REPLACE(fruit_list, ',', '</x><x>') + '</x>' AS XML) AS fruit_xml
    FROM fruits
) AS f
CROSS APPLY fruit_xml.nodes('/x[3]') AS x(x);

/*5. Write a SQL query to create a table where each character from the 
string will be converted into a row.(sdgfhsdgfhs@121313131)*/

DECLARE @str VARCHAR(100) = 'sdgfhsdgfhs@121313131';

WITH Numbers AS (
    SELECT TOP (LEN(@str))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM master.dbo.spt_values  -- built-in system table with many rows
)
SELECT 
    n AS position,
    SUBSTRING(@str, n, 1) AS character
FROM 
    Numbers;

/* 6. You are given two tables: p1 and p2. Join these tables on the id column. 
The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)*/

	select  p1.id, 
		case when p1.code=0 then p2.code else p1.code 
		end as final_code  
	from p1 join p2 on p1.id=p2.id 


/*7. Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. 
	The stages are defined as follows:
		If the employee has worked for less than 1 year → 'New Hire'
		If the employee has worked for 1 to 5 years → 'Junior'
		If the employee has worked for 5 to 10 years → 'Mid-Level'
		If the employee has worked for 10 to 20 years → 'Senior'
		If the employee has worked for more than 20 years → 'Veteran'(Employees)*/
	SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Years_Worked,
    CASE 
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 4 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 9 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 19 THEN 'Senior'
        ELSE 'Veteran'
    END AS Employment_Stage
FROM 
    Employees;


/*8. Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.
(GetIntegers)*/

SELECT 
    Id,
    VALS,
    CASE 
        WHEN PATINDEX('%[0-9]%', VALS) = 1
        THEN LEFT(VALS, 
                  PATINDEX('%[^0-9]%', VALS + 'X') - 1
             )
        ELSE NULL
    END AS Start_Integer
FROM 
    GetIntegers;


	/*1. In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)*/

	select *, right(vals, len(right(vals, len(vals)-charindex(',', vals)))-charindex(',', vals)) from MultipleVals

	/*2. Write a SQL query that reports the device that is first logged in for each player.(Activity)*/
	SELECT 
    player_id, 
    MIN(event_date) AS first_login
FROM 
    Activity
GROUP BY 
    player_id;


	/*3. You are given a sales table. 
	Calculate the week-on-week percentage of sales per area for each financial week. 
	For each week, the total sales will be considered 100%, and the percentage sales 
	for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)*/


	WITH sales_with_week AS (
    SELECT
        sale_date,
        area,
        amount,
        DATEPART(WEEK, sale_date) AS week_num,       -- For SQL Server
        DATEPART(YEAR, sale_date) AS year_num         -- To separate same week number in different years
    FROM WeekPercentagePuzzle
),
weekly_totals AS (
    SELECT
        area,
        year_num,
        week_num,
        SUM(amount) AS total_week_sales
    FROM sales_with_week
    GROUP BY area, year_num, week_num
),
daily_with_percentage AS (
    SELECT
        s.sale_date,
        s.area,
        s.amount,
        s.week_num,
        s.year_num,
        w.total_week_sales,
        ROUND((s.amount * 100.0) / w.total_week_sales, 2) AS daily_percentage
    FROM sales_with_week s
    JOIN weekly_totals w
      ON s.area = w.area AND s.week_num = w.week_num AND s.year_num = w.year_num
)
SELECT 
    sale_date,
    area,
    week_num,
    year_num,
    amount,
    total_week_sales,
    daily_percentage
FROM 
    daily_with_percentage
ORDER BY 
    area, year_num, week_num, sale_date;
