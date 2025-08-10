/*1. Stored Procedure Tasks*/
/*Create a stored procedure that:

Creates a temp table #EmployeeBonus
Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
(BonusAmount = Salary * BonusPercentage / 100)
Then, selects all data from the temp table.
*/

select *from employees e left join DepartmentBonus db on e.Department=db.Department

create table #EmployeeBonus (EmployeeID int, FirstName varchar(50), 
LastName varchar(50), Department varchar(50), Salary decimal (10, 2), BonusAmount decimal (10, 2))

insert into #EmployeeBonus (EmployeeID, Firstname, Department, Salary, BonusAmount)
select e.EmployeeID, (e.FirstName+''+e.LastName) as FullName, e.Department, e.Salary, e.Salary*db.BonusPercentage/100 as BonusAmount
from employees e inner join DepartmentBonus db on e.Department=db.Department

/*Task 2. Create a stored procedure that:

Accepts a department name and an increase percentage as parameters
Update salary of all employees in the given department by the given percentage
Returns updated employees from that department.*/



			CREATE PROCEDURE UpdateDepartmentSalary
    @Department NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    -- Update salaries
    UPDATE Employees
    SET Salary = Salary * (1 + @IncreasePercent / 100)
    WHERE Department = @Department;

    -- Return updated employees from that department
    SELECT *
    FROM Employees
    WHERE Department = @Department;
END;

/*3. Perform a MERGE operation that:

Updates ProductName and Price if ProductID matches
Inserts new products if ProductID does not exist
Deletes products from Products_Current if they are missing in Products_New
Return the final state of Products_Current after the MERGE. */

merge into products_current as target
using products_new as source
on target.productid=source.productid
when not matched by target then
insert (productID, ProductName, price) values (source.productID, source.ProductName, Source.price)
when matched then
update set target.price=source.price
when not matched  by source then 
delete;

/*4. Tree Node

Each node in the tree can be one of three types:

"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write a solution to report the type of each node in the tree.*/

SELECT 
    t.id,
    CASE
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN t.id IN (SELECT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree t;


/*5. Confirmation Rate

Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.*/

SELECT 
    s.user_id,
    ROUND(
        CAST(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) AS DECIMAL(10,2)) /
        NULLIF(COUNT(c.user_id), 0), 
        2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;


/*6. Find employees with the lowest salary*/

select *from employees e1
where salary=(select min(salary) from employees)

/*7. Get Product Sales Summary*/
CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s 
        ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END
GO

EXEC GetProductSalesSummary @ProductID = 1;
EXEC GetProductSalesSummary @ProductID = 20;
