EASY QUESTIONS 
 /*Q1 - Who is the senior most employee based on job title?*/
	select first_name, last_name 
	from employee 
	order by levels desc
	limit 1;
 /*Q2 - Which countries have the most Invoice?*/
	select count(*) as c , billing_country 
	from invoice
	group by billing_country
	order by c desc;	
 /*Q3 - What are top 3 values of total Invoice?*/
	select total
	from invoice
	order by total desc
	limit 3;
/*Q4 - Which city has the  best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
write a query that returns one city that has the highest sum of invoice totals . 
return both the city and the sum of all invoice   */
	select billing_city, sum(total) as t 
	from invoice
	group by billing_city
	order by t desc
	limit 1 ;	
/* Q5 - who is the best customer ? the custome who has spent the most money 
will be declared the best customer. 
write a query that returns that person who has spent the most */	
	select customer.customer_id, customer.first_name, customer.last_name ,sum(invoice.total) as t
	from customer  join invoice 
	on customer.customer_id = invoice.customer_id
	group by customer.customer_id
	order by t desc 
	limit 1;
	

