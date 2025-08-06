/*1.  Show all orders placed after 2022 along with the names of the customers who placed them.*/

select o.customerid, firstname+' '+lastname as customername, orderdate from orders o join customers c on o.customerid=c.customerid
where year(orderdate)>2022

/*2. Task: Display the names of employees who work in either the Sales or Marketing department. */

select name, departmentname from employees e left join departments d on e.DepartmentID=d.DepartmentID
where departmentname in ('sales', 'marketing')

/*3. Show the highest salary for each department.*/


select d.DepartmentName as departments, max(salary) as maxsalary from employees e 
join departments d on e.DepartmentID=d.DepartmentID
group by d.DepartmentName

/*4.  List all customers from the USA who placed orders in the year 2023.*/

select  concat(firstname, ' ', lastname) as customername, orderid, orderdate from Customers c left join orders o on c.CustomerID=o.CustomerID
where year(orderdate) = 2023

/*5. Show how many orders each customer has placed.*/
 

select  firstname +' '+lastname as customers, sum(quantity) as orders from orders o
full join customers c on o.customerid=c.customerid group by firstname +' '+lastname

/*6. Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.*/

select *from products p left join suppliers s on p.SupplierID=s.SupplierID
where SupplierName in('gadget Supplies','Clothing Mart')

/*7.  For each customer, show their most recent order. Include customers who haven't placed any orders.*/

select * from customers c left join (select *from (select *, row_number()over (partition by customerid 
order by orderdate desc) as rn from orders ) sub where rn=1 )	o on c.customerid=o.customerid

/*8.  Show the customers who have placed an order where the total amount is greater than 500.*/

select concat(firstname, ' ' , lastname) CustomerName, totalamount from customers c left join orders o on c.customerid=o.customerid
where totalamount>500

/*9. List product sales where the sale was made in 2022 or the sale amount exceeded 400.*/
select *from products p join sales s on p.productid=s.productid
where year(saledate)=2022 and saleamount>400

/*10. Display each product along with the total amount it has been sold for.*/

select productname, sum(saleamount) from sales s 
select *from products p left join sales s on p.productid=s.productid

select p.productname, sum(saleamount) as totalsalesamount from sales s left join products p on s.productid=p.productid
group by  p.productname

/*11. Show the employees who work in the HR department and earn a salary greater than 60000.*/

select name as employeename, departmentname, salary from employees e
 left join departments d on e.departmentid=d.departmentid
where salary>60000  and departmentname='human resources'

/*12. List the products that were sold in 2023 and had more than 100 units in stock at the time.*/

select productname, saledate, stockquantity from products p left join sales s on p.productid=s.productid
where year(saledate)=2023 and stockquantity>100


/*13. Show employees who either work in the Sales department or were hired after 2020. */

select name as employeename, departmentname, hiredate from employees e left join departments d on e.departmentid=d.departmentid
where departmentname = 'sales' or year(hiredate) > 2020

/*14.  List all orders made by customers in the USA whose address starts with 4 digits.*/

select concat(firstname, ' ', lastname) as customername, orderid, address, orderdate from customers c 
left join orders o on c.customerid=o.customerid
where country='USA' and address like '[0-9][0-9][0-9][0-9]%'

/*15.	Display product sales for items in the Electronics category or where the sale amount exceeded 350.*/

select productname, category, saleamount from products p left join sales s on p.productid=s.productid
where category='electronics' or saleamount>350

/*16. Show the number of products available in each category. */ 

select category as CategoryName,
	sum(stockquantity) as ProductCount from products p
	left join categories c on p.category=c.categoryname
group by category

/*17. List orders where the customer is from Los Angeles and the order amount is greater than 300.*/

	select *from customers c left join orders o on c.customerid=o.customerid
	where city='Los Angeles' and totalamount>300

/*18. Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.*/

	select name, departmentname from employees e  join departments d on e.departmentid=d.departmentid
	where departmentname = 'HR' or departmentname='Finance' or 
	(
       LENGTH(LOWER(Name)) 
       - LENGTH(REPLACE(LOWER(Name), 'a', ''))
       + LENGTH(LOWER(Name)) 
       - LENGTH(REPLACE(LOWER(Name), 'e', ''))
       + LENGTH(LOWER(Name)) 
       - LENGTH(REPLACE(LOWER(Name), 'i', ''))
       + LENGTH(LOWER(Name)) 
       - LENGTH(REPLACE(LOWER(Name), 'o', ''))
       + LENGTH(LOWER(Name)) 
       - LENGTH(REPLACE(LOWER(Name), 'u', ''))
   ) >= 4;


 /*19. Show employees who are in the Sales or Marketing department and have a salary above 60000.*/

		select name as employeename, departmentname, salary from employees e 
	left join departments d on e.departmentid=d.departmentid
	where departmentname in ('sales', 'marketing') and salary >60000

