/*1. Write a query to assign a row number to each sale based on the SaleDate.*/

	select *, DENSE_RANK() over(order by saledate desc) row_number from ProductSales;

/*2. Write a query to rank products based on the total quantity sold. 
give the same rank for the same amounts without skipping numbers*/

	select ProductName,
		sum(quantity) as total_quantity,
		dense_rank () over(order by sum(quantity) desc) as product_rank
	from ProductSales
	group by ProductName
	order by product_rank;

/*3. Write a query to identify the top sale for each customer based on the SaleAmount.*/


	select *from(
	select *,
		ROW_NUMBER () over(partition by (customerid) order by saleamount desc) as rank_customerid
	from ProductSales
	) as ranked
	where rank_customerid=1;
		
/*4. Write a query to display each sale's amount along with the next sale amount in the order of SaleDate.*/

	select *,
		lead(saleamount) over(order by saledate) as nextsales
 	from ProductSales;

/*5. Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate.*/

	select *,
		lag(saleamount) over(order by saledate) as nextsales
 	from ProductSales;

/*6. Write a query to identify sales amounts that are greater than the previous sale's amount*/

with cte as (
	select *,
		lag(saleamount) over(order by saledate) as previous_sale
	from ProductSales
	) select *from cte
	where SaleAmount > previous_sale;

/*7. Write a query to calculate the difference in sale amount from the previous sale for every product*/

	with cte as (
		select *,
			lag(saleamount) over(order by saledate) as previous_sale
		from ProductSales
		) select SaleAmount-previous_sale from cte;

/*8. Write a query to compare the current sale amount with the next sale amount in terms of percentage change.*/

with cte as (
	 select *,
		lead(saleamount) over (order by saledate) as next_sale
	from ProductSales
	) select (100-(next_sale*100)/saleamount) as changing_percentage
	from cte;

	/*9. Write a query to calculate the ratio of the current sale amount to the previous sale amount 
	within the same product.*/

	select *,
		lag(saleamount) over (partition by productname order by saledate) as previous_sales,
		(saleamount*1.0)/(lag(saleamount) over (partition by productname order by saledate)) as ratio
	from ProductSales
	order by ProductName, saledate;

	/*10. Write a query to calculate the difference in sale amount from the very first sale of that product.*/
	
	select *,
		first_value(saleamount) over(partition by productname order by saledate) as first_sale,
		saleamount-(first_value(saleamount) over(partition by productname order by saledate)) as df
	from ProductSales;

	/*11. Write a query to find sales that have been increasing continuously for a product 
	(i.e., each sale amount is greater than the previous sale amount for that product).*/

with inc_continiously as (
	select *,
		lag(saleamount) over(partition by productname order by saledate) as previous_sale,
		saleamount-(lag(saleamount) over(partition by productname order by saledate)) df_amount
	from ProductSales
	)
	select *from inc_continiously
	where df_amount>0;

	/*12. Write a query to calculate a "closing balance"(running total) for sales amounts 
	which adds the current sale amount to a running total of previous sales.*/

	select*, 
		sum(saleamount) over(order by saledate rows between unbounded preceding and current row) as closing_balance
	from ProductSales order by SaleDate

	/*13. Write a query to calculate the moving average of sales amounts over the last 3 sales*/

		select*, 
			avg(saleamount) over(order by saledate rows 3 preceding ) as closing_balance
		from ProductSales order by SaleDate

	/*14. Write a query to show the difference between each sale amount and the average sale amount */

	with cte as(
	select *,
		avg(saleamount) over() as avg_sale
	from ProductSales
	)
	select*, saleamount- avg(saleamount) over() as df_sa_avgsale from cte;


	/*15. Find Employees Who Have the Same Salary Rank*/

	WITH SalaryRanks AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
)
SELECT *
FROM SalaryRanks
WHERE SalaryRank IN (
    SELECT SalaryRank
    FROM SalaryRanks
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)
ORDER BY SalaryRank, Name;


	/*16. Identify the Top 2 Highest Salaries in Each Department*/

	with cte as(
	select *,
		rank() over(partition by department order by salary desc) as rnk
 	from employees1
	)
	select *from cte 
	where rnk in(1, 2)
	

	/*17. Find the Lowest-Paid Employee in Each Department*/

	with cte as (
	select *,
		rank() over(partition by department order by salary asc) as rnk
	from employees1
	)
	 select *from cte
	 where rnk=1

	 /*18. Calculate the Running Total of Salaries in Each Department*/

	 select *,
		sum(salary) over(partition by department order by hiredate rows between unbounded preceding and current row) 
		as total_running
	 from employees1

	 /*19. Find the Total Salary of Each Department Without GROUP BY*/

	
	select *,
		sum(salary) over(partition by department) 
		as total_running
	 from employees1

	 /*20. Calculate the Average Salary in Each Department Without GROUP BY*/

	 select *,
		avg(salary) over(partition by department) 
		as total_running
	 from employees1
	 
	 /*21. Find the Difference Between an Employee’s Salary and Their Department’s Average*/

	 with cte as (
	 select *,
		avg(salary) over(partition by department) as avg_dep
	 from employees1
	 )
	 select *,
		salary-avg(salary) over(partition by department) as df_sal_avg
	 from cte 

	 /*22. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)*/
	 
	 select *,
		avg(salary) over(partition by department order by hiredate rows between 1 preceding and 1 following) 
		as avg_3_category
	 from employees1

	 /*3. Find the Sum of Salaries for the Last 3 Hired Employees*/

	 select *,
		sum(salary) over(partition by department order by hiredate desc rows between curr and 2 following) as sum_3_lasthire
	 from employees1

	 with cte as (
	 select *,
		row_number() over(partition by department order by hiredate desc) as rnk
	 from employees1
	 )
	 select department, sum(salary)  from cte
	 group by department
	 having rnk<3
