/*1.You must provide a report of all distributors and their sales by region. 
If a distributor did not have any sales for a region, provide a zero-dollar value for that day. 
Assume there is at least one sale for each region*/

	select r1.region, r2.distributor, ISNULL(r0.sales, 0) as sales
	from 
		(select distinct(region) from #RegionSales) r1
			cross join 
		(select distinct(Distributor) from #RegionSales) r2
			left join #RegionSales r0
				on r0.region=r1.region and r0.distributor=r2.distributor
				order by r2.distributor, r1.region


/*2. Find managers with at least five direct reports*/
SELECT 
    m.name AS Name,
    COUNT(e.id) AS ReportCount
FROM 
    Employee e
JOIN 
    Employee m ON e.managerId = m.id
GROUP BY 
    m.id, m.name
HAVING 
    COUNT(e.id) >= 5;


/*3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.*/

	
	
/*4. Write an SQL statement that returns the vendor from which each customer has placed the most orders*/


	WITH VendorOrderCounts AS (
    SELECT 
        CustomerID,
        Vendor,
        COUNT(*) AS OrderCount,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY COUNT(*) DESC) AS rn
    FROM 
        Orderss
    GROUP BY 
        CustomerID, Vendor
)
SELECT 
    CustomerID,
    Vendor,
    OrderCount
FROM 
    VendorOrderCounts
WHERE 
    rn = 1;


	/*5.You will be given a number as a variable called @Check_Prime check if this number is prime then return 
	'This number is prime' else eturn 'This number is not prime'*/


	DECLARE @Check_Prime INT = 29;  -- Replace with any number
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;

IF @Check_Prime < 2
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

/*6. Write an SQL query to return the number of locations,in which location most signals sent, 
and total number of signal for each device from the given table.*/



WITH SignalCounts AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SignalCount
    FROM Device
    GROUP BY Device_id, Locations
),
TopLocation AS (
    SELECT 
        Device_id,
        Locations AS Most_Signals_Location,
        SignalCount,
        RANK() OVER (PARTITION BY Device_id ORDER BY SignalCount DESC) AS rnk
    FROM SignalCounts
),
DeviceSummary AS (
    SELECT 
        Device_id,
        COUNT(*) AS TotalSignals,
        COUNT(DISTINCT Locations) AS LocationCount
    FROM Device
    GROUP BY Device_id
)
SELECT 
    ds.Device_id,
    ds.LocationCount,
    tl.Most_Signals_Location,
    ds.TotalSignals
FROM DeviceSummary ds
JOIN TopLocation tl ON ds.Device_id = tl.Device_id
WHERE tl.rnk = 1
ORDER BY ds.Device_id;

/*7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. 
Return EmpID, EmpName,Salary in your output*/

	select empid, empname, salary from employee e
	where salary > (select avg(salary) from employee where deptid=e.deptid)

	


/*8. You are part of an office lottery pool where you keep a table of the winning lottery numbers 
along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, 
you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.*/

WITH WinningCount AS (
    SELECT COUNT(*) AS TotalWinningNumbers FROM WinningNumbers
),
Matched AS (
    SELECT 
        t.TicketID,
        COUNT(DISTINCT t.Number) AS TotalPicked,
        COUNT(DISTINCT CASE WHEN w.Number IS NOT NULL THEN t.Number END) AS MatchCount
    FROM 
        Tickets t
    LEFT JOIN 
        WinningNumbers w ON t.Number = w.Number
    GROUP BY 
        t.TicketID
),
Winnings AS (
    SELECT 
        TicketID,
        CASE 
            WHEN MatchCount = wc.TotalWinningNumbers THEN 100
            WHEN MatchCount > 0 THEN 10
            ELSE 0
        END AS Prize
    FROM 
        Matched m
    CROSS JOIN 
        WinningCount wc
)
SELECT 
    SUM(Prize) AS TotalWinnings
FROM 
    Winnings;
``
/*9. The Spending table keeps the logs of the spendings history of users that make purchases from 
an online shopping website which has a desktop and a mobile devices.
Write an SQL query to find the total number of users and the total amount spent using mobile only, 
desktop only and both mobile and desktop together for each date.*/
WITH UserPlatformSummary AS (
  SELECT
    User_id,
    Spend_date,
    SUM(CASE WHEN Platform = 'Mobile' THEN Amount ELSE 0 END) AS MobileAmount,
    SUM(CASE WHEN Platform = 'Desktop' THEN Amount ELSE 0 END) AS DesktopAmount
  FROM Spending
  GROUP BY User_id, Spend_date
),
CategoryTagged AS (
  SELECT
    Spend_date,
    CASE
      WHEN MobileAmount > 0 AND DesktopAmount = 0 THEN 'Mobile Only'
      WHEN DesktopAmount > 0 AND MobileAmount = 0 THEN 'Desktop Only'
      WHEN MobileAmount > 0 AND DesktopAmount > 0 TH


	  /*10. Write an SQL Statement to de-group the following data.
Input Table: 'Grouped'*/
WITH Numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1
  FROM Numbers
  WHERE n < (SELECT MAX(Quantity) FROM Grouped)
)
SELECT 
  g.Product
FROM Grouped g
JOIN Numbers n ON n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 0);
