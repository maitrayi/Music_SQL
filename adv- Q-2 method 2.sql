 /*we want to find out the most popular music genre for each country. we determine the most popular 
 genre as the teh genre with the highest amount of purchase.write a query that returns each country 
 along with the top genre. for countries where the max number of purchase IS SHARED RETURN ALL GENRES*/
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