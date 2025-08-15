---------------------------homeworks_20-------------
	/*1. Find customers who purchased at least one item in March 2024 using EXISTS*/

	select * from #sales s
	where exists(
	select * from #Sales sub where sub.CustomerName=s.CustomerName
	and sub.saledate>='2024-03-01'
	and sub.saledate<='2024-04-01');


	/*2. Find the product with the highest total sales revenue using a subquery.*/
	

	SELECT Product, TotalRevenue
FROM (
    SELECT 
        Product,
        SUM(Quantity * Price) AS TotalRevenue
    FROM #Sales
    GROUP BY Product
) AS revenue_per_product
WHERE TotalRevenue = (
    SELECT MAX(TotalRevenue)
    FROM (
        SELECT SUM(Quantity * Price) AS TotalRevenue
        FROM #Sales
        GROUP BY Product
    ) AS sub
);

/*3. Find the second highest sale amount using a subquery*/
	
	select max(saleamount) as scndhgst from 
		(select quantity*price as saleamount from #sales) as amounts
			where saleamount<(select max(quantity*price) from #sales);

/*4. Find the total quantity of products sold per month using a subquery*/

	select monthname, totalquantity from 
			(select FORMAT(saledate, 'yyyy-MM') as monthname,
					sum(quantity) as totalquantity
			from #sales group by FORMAT(saledate, 'yyyy-MM')) as month_total
		order by monthname
	
/*5. Find customers who bought same products as another customer using EXISTS*/

	select *from #sales s1
		where exists (select 1 from #Sales s2 where s2.product=s1.product and s2.customername<>s1.customername);

/*6. Return how many fruits does each person have in individual fruit level */



	SELECT Name, 
       ISNULL([Apple], 0) AS Apple, 
       ISNULL([Orange], 0) AS Orange, 
       ISNULL([Banana], 0) AS Banana
FROM (
    SELECT Name, Fruit
    FROM Fruits
) AS src
PIVOT (
    COUNT(Fruit) 
    FOR Fruit IN ([Apple], [Orange], [Banana])
) AS p;


/*7. Return older people in the family with younger ones*/
1 Oldest person in the family --grandfather 2 Father 3 Son 4 Grandson
select *from 

WITH FamilyTree AS (
    -- Boshlang'ich daraja: mavjud ota-bola juftlari
    SELECT ParentId, ChildId
    FROM Family
    
    UNION ALL
    
    -- Rekursiya: bolaning o'zi ham ota bo'lishi mumkin
    SELECT f.ParentId, ft.ChildId
    FROM Family f
    JOIN FamilyTree ft
        ON f.ChildId = ft.ParentId
)
SELECT ParentId AS PID, ChildId AS CHID
FROM FamilyTree
ORDER BY PID, CHID;

/*8. Write an SQL statement given the following requirements. For every customer that had a delivery to California, 
provide a result set of the customer orders that were delivered to Texas */

	select *from #Orders o
		where DeliveryState = 'tx'
			and exists (select * from #Orders o2 where o2.customerid=o.customerid and o2.DeliveryState='ca');


/*9. Insert the names of residents if they are missing*/

	update #residents
	set fullname=
		  LTRIM(RTRIM(
        SUBSTRING(
            address,
            CHARINDEX('name=', address) + 5,
            CHARINDEX(' age=', address) - (CHARINDEX('name=', address) + 5)
        )
    ))
WHERE fullname IS NULL 
  OR fullname = '';


  /*10. Write a query to return the route to reach from Tashkent to Khorezm. 
  The result should include the cheapest and the most expensive routes*/
  
  ;WITH RoutePaths AS
(
    -- Boshlang'ich nuqta: Tashkentdan boshlangan marshrutlar
    SELECT 
        DepartureCity,
        ArrivalCity,
        Cost,
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    -- Keyingi shaharlarni qo'shish
    SELECT 
        rp.DepartureCity,
        r.ArrivalCity,
        rp.Cost + r.Cost AS Cost,
        CAST(rp.Route + ' - ' + r.ArrivalCity AS VARCHAR(MAX)) AS Route
    FROM RoutePaths rp
    JOIN #Routes r
        ON rp.ArrivalCity = r.DepartureCity
    WHERE rp.ArrivalCity <> 'Khorezm'
)
SELECT Route, Cost
FROM RoutePaths
WHERE ArrivalCity = 'Khorezm'
AND (Cost = (SELECT MIN(Cost) FROM RoutePaths WHERE ArrivalCity = 'Khorezm')
     OR Cost = (SELECT MAX(Cost) FROM RoutePaths WHERE ArrivalCity = 'Khorezm'))
ORDER BY Cost;


/*11. Rank products based on their order of insertion.*/

;WITH Groups AS
(
    SELECT *,
           SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
               OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS ProductGroup
    FROM #RankingPuzzle
)
SELECT 
    ID,
    Vals,
    ROW_NUMBER() OVER (PARTITION BY ProductGroup ORDER BY ID) AS ProductRank
FROM Groups
WHERE Vals <> 'Product';

/*12. Find employees whose sales were higher than the average sales in their department*/

SELECT e.EmployeeName,
       e.Department,
       e.SalesAmount
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);


/*13. Find employees who had the highest sales in any given month using EXISTS*/

SELECT e.EmployeeName,
       e.Department,
       e.SalesAmount,
       e.SalesMonth,
       e.SalesYear
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales s
    WHERE s.SalesMonth = e.SalesMonth
      AND s.SalesYear = e.SalesYear
    GROUP BY s.SalesMonth, s.SalesYear
    HAVING e.SalesAmount = MAX(s.SalesAmount)
);


/*14.  Find employees who made sales in every month using NOT EXISTS*/

SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT DISTINCT SalesMonth
    FROM #EmployeeSales
    WHERE SalesMonth NOT IN (
        SELECT SalesMonth
        FROM #EmployeeSales s
        WHERE s.EmployeeName = e.EmployeeName
    )
);

/*15.Retrieve the names of products that are more expensive than the average price of all products.*/

SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
);

/*16. Find the products that have a stock count lower than the highest stock count.*/

SELECT Name, Stock
FROM Products
WHERE Stock < (
    SELECT MAX(Stock)
    FROM Products
);

/*17. Get the names of products that belong to the same category as 'Laptop'.*/
SELECT Name
FROM Products
WHERE Category = (
    SELECT Category
    FROM Products
    WHERE Name = 'Laptop'
);

/*18.  Retrieve products whose price is greater than the lowest price in the Electronics category.*/

SELECT Name, Category, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);

/*19.  Find the products that have a higher price than the average price of their respective category.*/
SELECT Name, Category, Price
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);

/*20. Find the products that have been ordered at least once.*/

SELECT DISTINCT p.ProductID, p.Name
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);

/*21. Retrieve the names of products that have been ordered more than the average quantity ordered.*/

SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o 
    ON p.ProductID = o.ProductID
WHERE o.Quantity > (
    SELECT AVG(Quantity)
    FROM Orders
);

/*22. Find the products that have never been ordered.*/
SELECT p.Name
FROM Products p
LEFT JOIN Orders o 
    ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;


/*23. Retrieve the product with the highest total quantity ordered.*/

SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o 
    ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY TotalQuantity DESC;
