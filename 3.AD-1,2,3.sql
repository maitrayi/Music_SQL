/*Advance */
/* Q1- Find how much amount spent by EACH customer on artists?
write a quert to return customer name , artist name and total spent */
	with best_selling_artist as (
		 select
			artist.artist_id as A_id,
			artist.name as A_name, 
			sum(invoice_line.unit_price*invoice_line.quantity) as total_sale
		 from invoice_line  
		 join track on invoice_line.track_id = track.track_id
		 join album on track.album_id= album.album_id
					 join artist on artist.artist_id=album.artist_id
					 group by 1 
					 order by 3 desc
					 limit 1 
				 )
	select 
		customer.customer_id,
		customer.first_name,
		customer.last_name,
		best_selling_artist.a_name,
		sum(invoice_line.unit_price*invoice_line.quantity) 
	from customer
	join  invoice on customer.customer_id =invoice.customer_id 
	join  invoice_line on invoice_line.invoice_id =invoice.invoice_id
	join track on track.track_id= invoice_line.track_id
	join album on track.album_id=album.album_id
	join best_selling_artist on best_selling_artist.A_id= album.artist_id
	group by 1,2,3,4
	order by 5 desc
 /*Q2- we want to find out the most popular music genre for each country. 
 we setermine the most popular genre as the teh genre with the highest amount of purchase.
 write a query that returns each country along with the top genre. for countries where the max number of purchase
 IS SHARED RETURN ALL GENRES*/
	 
	 with   country_purchase as ( 
		select 
			count(invoice_line.quantity) as purchase,
			customer.country as country, 
			genre.genre_id, 
			genre.name as genre,
			row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as row_num
		from invoice_line  
		join invoice on invoice.invoice_id = invoice_line.invoice_id 
		join customer on customer.customer_id= invoice.customer_id
		join track on track.track_id = invoice_line.track_id
		join genre on genre.genre_id =track.genre_id
		group by 2,3,4 
		order by 2 asc,1 desc 
	)
							  
	select *
	from country_purchase
	where row_num <= 1 





/*METHOD -2 */



with recursive  country_purchase as ( 
	select 
		count(*) as purchase,
 		customer.country as country, 
		genre.genre_id, 
		genre.name as genre
 	from invoice_line  
 	join invoice on invoice.invoice_id = invoice_line.invoice_id 
	join customer on customer.customer_id= invoice.customer_id
 	join track on track.track_id = invoice_line.track_id
 	join genre on genre.genre_id =track.genre_id
 	group by 2,3,4 
 	order by 2  
),
max_genre_country as (
	select 
		max(purchase) as max_purchase,
		country
	from country_purchase
	group by 2 
	order by 2 )
select 
	country_purchase.* 
from country_purchase
join max_genre_country on country_purchase.country= max_genre_country.country
where country_purchase.purchase = max_genre_country.max_purchase


/* Q3- WRITE a query that determine the customer hat has spent the most on music for each country.
 writea querythat reurns the country along with the top customer and how much they spent. 
 for countries where the top amount spent a shared all customer who spent this amount*/

/* Q3- WRITE a query that determine the customer hat has spent the most on music for each country.
 write a querythat reurns the country along with the top customer and how much they spent. 
 for countries where the top amount spent a shared all customer who spent this amount*/
with country_customer as (
select 
 	invoice.billing_country as country ,
	customer.first_name,
	customer.last_name,
	sum(invoice.total) as amount,
	row_number() over(partition by invoice.billing_country  order by sum(invoice.total) desc ) as row_num
 from invoice
 join customer on invoice.customer_id= customer.customer_id
 group by invoice.billing_country, customer.first_name,customer.last_name
 order by invoice.billing_country , row_num
	)
select * from country_customer 
where row_num <=1

     