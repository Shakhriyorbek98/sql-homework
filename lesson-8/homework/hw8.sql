/*   1. Using Products table, find the total number of products available in each category.*/

	select category,
		count(StockQuantity) as total_products_number
		from Products
	group by category

/*  2. Using Products table, get the average price of products in the 'Electronics' category. */

	select Category,
		avg(Price) as avg_price
		from Products
	group by Category
	having category='Electronics'

	/*3. Using Customers table, list all customers from cities that start with 'L'.*/

	select City,
		COUNT(CustomerID) as customer_numbers
		from customers 
	group by city
	having city like 'l%'

	/*4. Using Products table, get all product names that end with 'er'.*/

	select *from Products where productname like '%er'


	/* 5. Using Customers table, list all customers from countries ending in 'A'. */
	
	select Country,
		count(CustomerID) as all_customers
		from Customers
	group by Country
	having Country like '%a'


	/* 6. Using Products table, show the highest price among all products. */

	select MAX(Price) as price_max from Products

	/* 7. Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'. */

	select *, 
		 case when StockQuantity<30 then 'Low Stock' 
			else 'Sufficient' 
		 end as stock_status
	from Products

	/* 8. Using Customers table, find the total number of customers in each country. */

	select Country,
		COUNT(CustomerID) as total_number_customers
		from Customers
	group by Country

	/* 9. Using Orders table, find the minimum and maximum quantity ordered. */
		
		select min(quantity) min_order, max(quantity) max_order from orders

	/* 10. Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January 
	to find those who did not have invoices. */

	select  orderid, orders.CustomerID,orderdate, invoiceid from orders join invoices on orders.customerid=invoices.customerid 
	group by orderid, orders.CustomerID,orderdate, invoiceid 

	
	/* 11. Using Products and Products_Discounted table, 
	Combine all product names from Products and Products_Discounted including duplicates. */

	SELECT ProductName FROM Products
		UNION ALL
	SELECT ProductName FROM Products_Discounted;

	/* 12. Using Products and Products_Discounted table, 
	Combine all product names from Products and Products_Discounted without duplicates.*/

	select ProductName from products
	union
	select productname from Products_Discounted;


	/*13. Using Orders table, find the average order amount by year. */

	select year(orderdate),
	avg(quantity) as avg_order from orders
	group by year(orderdate)

	/*14.Using Products table, group products based on price: 
	'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.*/

	select *, case 
			when price < 100 then 'low'
			when price between 100 and 500 then 'mid'
			else 'high'
		end aspricegroup from products

		/*15. Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) 
		and copy results to a new Population_Each_Year table.*/


		SELECT *
INTO Population_Each_Year
FROM (
    SELECT 
        district_name,
        Year,
        Population
    FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population)
    FOR Year IN ([2012], [2013])
) AS PivotTable;

/*16. Using Sales table, find total sales per product Id.*/

	select productid,
		sum(saleamount) as total_sales
		from sales
	group by productid

	/*17. Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.*/

	select *from products where ProductName like'%oo%'

	/*18. Using City_Population table, use Pivot to show values of City column in seperate columns 
	(Bektemir, Chilonzor, Yakkasaroy) and copy results to a new Population_Each_City table.*/

	
	SELECT *
INTO Population_Each_City
FROM (
    SELECT Year, district_name, Population
    FROM City_Population
    WHERE district_name IN ('Bektemir', 'Chilonzor', 'Yakkasaroy')
) AS SourceTable
PIVOT (
    SUM(Population)
    FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;


/*19. Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.*/

	select top 3 customerid,
		sum(TotalAmount) as total_invoice_amount
		from invoices
	group by customerid
	order by total_invoice_amount desc

/*20.Transform Population_Each_Year table to its original format (City_Population).*/

SELECT 
    district_name
    [Year],
    Population
INTO City_Population
FROM (
    SELECT 
        district_name,
        [2012],
        [2013]
    FROM Population_Each_Year
) AS SourceTable
UNPIVOT (
    Population FOR [Year] IN ([2012], [2013])
) AS UnpivotedTable;


/*21.Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)*/
SELECT 
    p.ProductName,
    COUNT(o.OrderID) AS TimesSold
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductName
ORDER BY TimesSold DESC;

/*22.
Transform Population_Each_City table to its original format (City_Population).*/

SELECT 
    Year,
    district_name
    Population
INTO City_Population
FROM 
    Population_Each_City
UNPIVOT (
    Population FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS unpvt;
