/* 1. Find Employees with Minimum Salary 
Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary) */ 

select * from employees
where salary=(select min(salary) as min_salary from employees )


/* 2.  Find Products Above Average Price
Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)	 */

select *from products p
where price > (select avg(price) from products)

/* 3. Nested Subqueries with Conditions
3. Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. 
Tables: employees (columns: id, name, department_id), departments (columns: id, department_name) */

select e.id, name, department_id, department_name from employees e left join departments d on e.id=d.id
where department_name = 'sales'


/* 4. Find Customers with No Orders
Task: Retrieve customers who have not placed any orders. 
Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id) */

select * from customers c left join orders o on c.customer_id=o.customer_id
where order_id is null


/* 5. Aggregation and Grouping in Subqueries
	Find Products with Max Price in Each Category */
	
	select *from products p
	where price= (select max(price) as max_price from products where products.category_id=p.category_id)




/* 6. Find Employees in Department with Highest Average Salary
Task: Retrieve employees working in the department with the highest average salary. 
Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name) */


select *from employees e join departments d on e.department_id=d.id
where salary>(select avg(salary) from employees)



/* 7. Correlated Subqueries
Find Employees Earning Above Department Average */

select *from employees e
where salary>(select avg(salary) from employees where employees.department_id=e.department_id )

/*8. Find Students with Highest Grade per Course
Task: Retrieve students who received the highest grade in each course. 
Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade) */

select *from students s join grades g on s.student_id=g.student_id
where grade = (select max(grade) from grades where grades.course_id=g.course_id)

/*9.  Subqueries with Ranking and Complex Conditions
	Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. 
	Tables: products (columns: id, product_name, price, category_id) */

WITH RankedProducts AS (
    SELECT
        id,
        product_name,
        price,
        category_id,
        DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS price_rank
    FROM products
)
SELECT
    id,
    product_name,
    price,
    category_id
FROM RankedProducts
WHERE price_rank = 3;

/* 10. Find Employees whose Salary Between Company Average and Department Max Salary
	Task: Retrieve employees with salaries above the company average but below the maximum in their department. 
	Tables: employees (columns: id, name, salary, department_id)*/

	select *from employees e
	where salary between (select avg(salary) from employees) and
	(select max(salary) from employees where employees.department_id=e.department_id)
