
/* 1. You need to write a query that outputs "100-Steven King", 
meaning emp_id + first_name + last_name in that format using employees table.*/


select concat(employee_id, '-', FIRST_NAME, space(1), LAST_NAME) as output from employees
where EMPLOYEE_ID=100

/* 2. Update the portion of the phone_number in the employees table, 
within the phone number the substring '124' will be replaced by '999' */

update employees
set phone_number=REPLACE (phone_number, '124', '999') 

/* 3. That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 
'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.(Employees) */

select first_name, len(first_name) as length_name from employees
where ascii(first_name)=65 or ascii(first_name)=74 or ascii(first_name)=77
order by first_name asc

/* 4. Write an SQL query to find the total salary for each manager ID.(Employees table) */

	select MANAGER_ID,
		sum(salary) as total_salary
		from employees
	group by MANAGER_ID

/*5. Write a query to retrieve the year and the highest value from the columns 
Max1, Max2, and Max3 for each row in the TestMax table*/


SELECT 
    Year1,
    CASE 
        WHEN Max1 >= Max2 AND Max1 >= Max3 THEN Max1
        WHEN Max2 >= Max1 AND Max2 >= Max3 THEN Max2
        ELSE Max3
    END AS HighestValue
FROM TestMax;

/*6. Find me odd numbered movies and description is not boring.(cinema)*/

	select *from cinema
	where id%2=1 and description<>'boring';

/* 7. You have to sort data based on the Id but Id with 0 should always be the last row. 
Now the question is can you do that with a single order by column.(SingleOrder)*/


	select *,
	case when id=0 then 1 else 0 end as column_filter from SingleOrder
	order by column_filter

/*8. Write an SQL query to select the first non-null value from a set of columns. 
If the first column is null, move to the next, and so on. 
If all columns are null, return null.(person) */

select coalesce(ssn, passportid, itin) as resul_coalesce
from person
--------------------------Medium task--
/* 1. Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)*/

select *from students
SELECT 
  StudentID,
  
  -- Firstname: from start to first space
  LEFT(FullName, CHARINDEX(' ', FullName) - 1) AS FirstName,
  
  -- Middlename: between first and last space
  SUBSTRING(
    FullName,
    CHARINDEX(' ', FullName) + 1,
    CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1
  ) AS MiddleName,
  
  -- Lastname: from last space to end
  RIGHT(
    FullName,
    LEN(FullName) - CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1)
  ) AS LastName

FROM Students;

/*2. For every customer that had a delivery to California, 
provide a result set of the customer orders that were delivered to Texas. (Orders Table)*/

select *from orders
where DeliveryState ='CA'


SELECT *
FROM Orders
WHERE DeliveryState = 'TX'
  AND CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
    WHERE DeliveryState = 'CA'
);

/*3. Write an SQL statement that can group concatenate the following values.(DMLTable)*/
SELECT STRING_AGG(String, ' ') WITHIN GROUP (ORDER BY SequenceNumber) AS ConcatenatedQuery
FROM DMLTable;

/*4. Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.*/
SELECT *
FROM Employees
WHERE LEN(LOWER(FirstName + LastName)) - LEN(REPLACE(LOWER(FirstName + LastName), 'a', '')) >= 3;


/*5. The total number of employees in each department and the percentage of 
those employees who have been with the company for more than 3 years(Employees)*/

	select DEPARTMENT_ID,
		count(EMPLOYEE_ID)
		from employees
	group by DEPARTMENT_ID

	/*6. Write an SQL statement that determines the most and least experienced 
	Spaceman ID by their job description.(Personal)*/
	
	select jobdescription,
		min(sum(MissionCount)) as min_sum,
		max(sum(MissionCount)) as max_sum
		from personal
	group by JobDescription



	/*Difficult task*/
	/*1. Write an SQL query that separates the uppercase letters, 
	lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.*/

	-- Declare input string
DECLARE @input VARCHAR(100) = 'tf56sd#%OqH';

-- Recursive CTE to split characters
WITH Chars AS (
    SELECT 
        1 AS pos,
        SUBSTRING(@input, 1, 1) AS ch
    UNION ALL
    SELECT 
        pos + 1,
        SUBSTRING(@input, pos + 1, 1)
    FROM Chars
    WHERE pos + 1 <= LEN(@input)
)

-- Select categorized characters
SELECT
    STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch END, '') AS UppercaseLetters,
    STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch END, '') AS LowercaseLetters,
    STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch END, '') AS Numbers,
    STRING_AGG(CASE WHEN ch NOT LIKE '[a-zA-Z0-9]' THEN ch END, '') AS OtherCharacters
FROM Chars;


/*Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)*/
SELECT 
  StudentID,
  FullName,
  Grade,
  SUM(Grade) OVER (ORDER BY StudentID) AS CumulativeGrade
FROM Students;


/* You are given the following table, which contains a VARCHAR column that contains mathematical equations. 
Sum the equations and provide the answers in the output.(Equations)*/



DECLARE @eqn VARCHAR(200), @sql NVARCHAR(300), @result INT;

DECLARE equation_cursor CURSOR FOR
SELECT Equation FROM Equations;

OPEN equation_cursor;
FETCH NEXT FROM equation_cursor INTO @eqn;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Dynamic SQL to evaluate the equation
    SET @sql = N'SELECT @resOUT = ' + @eqn;

    BEGIN TRY
        EXEC sp_executesql 
            @sql,
            N'@resOUT INT OUTPUT',
            @resOUT = @result OUTPUT;

        -- Update the table with the result
        UPDATE Equations
        SET TotalSum = @result
        WHERE Equation = @eqn;
    END TRY
    BEGIN CATCH
        -- If the equation is invalid (e.g., malformed), set TotalSum to NULL
        UPDATE Equations
        SET TotalSum = NULL
        WHERE Equation = @eqn;
    END CATCH;

    FETCH NEXT FROM equation_cursor INTO @eqn;
END

CLOSE equation_cursor;
DEALLOCATE equation_cursor;

-- View the results
SELECT * FROM Equations;

/* You have a table with two players (Player A and Player B) and their scores. 
If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. 
Write an SQL query to calculate the total score for each unique player pair(PlayerScores)*/



SELECT 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;
