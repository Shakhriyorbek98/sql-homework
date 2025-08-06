/*1. Combine Two Tables*/

	select firstname, lastname, city, state from  person p left join address a on p.personid=a.personid

/*2. Employees Earning More Than Their Managers */

	select e1.name as employee from employee e1 full join employee e2 on e1.managerid=e2.id
	where e1.salary>e2.salary 

/*3. Duplicate Emails*/

	select distinct p1.email from person p1 join person p2 on p1.email=p2.email and p1.id<>p2.id

/*4. Delete Duplicate Emails */
	
	select email, count(email) from person
	group by email

	delete from person
	where id not in (select min(id) from person
	group by email)
 
/*5. Find those parents who has only girls.*/

	select distinct g.parentname from girls g left join boys b on g.parentname=b.ParentName
	where b.id is null

/*6. Total over 50 and least*/


/*7. You have the tables below, write a query to get the expected output */

	select isnull(c1.item, '') as [Item Cart 1], 
		   isnull(c2.item, '') as [Item Cart 2]
	from cart1 c1 full join cart2 c2  on c1.item=c2.item

/*8. Customers Who Never Order */

	select name as customers from customers c left join orders o on o.customerid=c.id
	where customerid is null

/*9.  Students and Examinations */

	select s.student_id, student_name, sb.subject_name, count(e.subject_name) attended_exams from students s cross join subjects sb 
	left join 
	Examinations e on s.student_id=e.student_id and 
	sb.subject_name=e.subject_name
	group by s.student_id, student_name, sb.subject_name
	order by s.student_id, sb.subject_name
