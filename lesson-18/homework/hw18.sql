/*1. Create a temporary table named MonthlySales to store the total quantity sold and 
total revenue for each product in the current month. */

	create table #MonthlySales (
		productID varchar(50),
		ProductName varchar(50),
		TotalQuantity int,
		TotalRevenue decimal(10, 2)
	)

	Insert into #MonthlySales (productID, ProductName, TotalQuantity, TotalRevenue);
		
		SELECT 
    p.ProductID,
    p.ProductName,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) = YEAR(GETDATE())
  AND MONTH(s.SaleDate) = MONTH(GETDATE())
GROUP BY p.ProductID, p.ProductName;

	/*2. Create a view named vw_ProductSalesSummary that returns product info along with 
	total sales quantity across all time.*/

CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    p.Price,
    COALESCE(SUM(s.Quantity), 0) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s
    ON p.ProductID = s.ProductID
GROUP BY 
    p.ProductID,
    p.ProductName,
    p.Category,
    p.Price;

/*3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)*/

CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18, 2);

    SELECT 
        @TotalRevenue = SUM(oi.Quantity * p.Price)
    FROM OrderItems oi
    INNER JOIN Products p
        ON oi.ProductID = p.ProductID
    WHERE oi.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;


/*4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))*/

CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18, 2);

    SELECT 
        @TotalRevenue = SUM(oi.Quantity * p.Price)
    FROM OrderItems oi
    INNER JOIN Products p
        ON oi.ProductID = p.ProductID
    WHERE p.Category = @Category;

    RETURN ISNULL(@TotalRevenue, 0);
END;
 /*5. You have to create a function that get one argument as input from user and the function should return 
 'Yes' if the input number is a prime number 
 and 'No' otherwise. You can start it like this: */

 Create function dbo.fn_IsPrime (@Number INT)
Returns ...
CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @Result VARCHAR(3) = 'Yes';
    DECLARE @i INT = 2;

    -- Handle numbers less than 2 (not prime)
    IF @Number < 2
        SET @Result = 'No';
    ELSE
    BEGIN
        WHILE @i <= SQRT(@Number)
        BEGIN
            IF @Number % @i = 0
            BEGIN
                SET @Result = 'No';
                BREAK;
            END
            SET @i = @i + 1;
        END
    END

    RETURN @Result;
END;

/*6. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:*/

@Start INT
@End INT



	CREATE FUNCTION dbo.fn_GetNumbersBetween
(
    @Start INT,
    @End INT
)
RETURNS @Numbers TABLE
(
    Number INT
)
AS
BEGIN
    DECLARE @i INT = @Start;

    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers (Number)
        VALUES (@i);

        SET @i = @i + 1;
    END

    RETURN;
END;

/*7. Write a SQL query to return the Nth highest distinct salary from the Employee table. 
If there are fewer than N distinct salaries, return NULL.*/

DECLARE @N INT = 2;

SELECT 
    CASE 
        WHEN COUNT(DISTINCT salary) < @N THEN NULL
        ELSE (
            SELECT DISTINCT salary
            FROM Employee
            ORDER BY salary DESC
            OFFSET (@N - 1) ROWS FETCH NEXT 1 ROWS ONLY
        )
    END AS HighestNSalary
FROM Employee;

/*8. Write a SQL query to find the person who has the most friends.*/

SELECT TOP 1
    id,
    COUNT(*) AS num
FROM (
    -- requester_id is friend with accepter_id
    SELECT requester_id AS id, accepter_id AS friend_id
    FROM RequestAccepted
    UNION ALL
    -- accepter_id is friend with requester_id
    SELECT accepter_id AS id, requester_id AS friend_id
    FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY num DESC;

/*9. Create a View for Customer Order Summary.*/
CREATE VIEW vw_CustomerOrderSummary AS
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name;

/*10. Write an SQL statement to fill in the missing gaps. 
You have to write only select statement, no need to modify the table.*/


SELECT 
    RowNumber,
    MAX(TestCase) OVER (ORDER BY RowNumber ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Workflow
FROM Gaps;
