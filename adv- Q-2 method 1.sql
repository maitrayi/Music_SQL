/*we want to find out the most popular music genre for each country. 
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
