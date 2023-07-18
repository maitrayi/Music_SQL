/*MODERATE */
/* Q1 - wrie a query  to return an  email , first name , last name &  genre of all rock music listener. 
	reurn your list order alphabtically by email starting with A*/	
	select 
		distinct email,
		first_name,
		last_name
	from invoice_line 
	join invoice on invoice.invoice_id=invoice_line.invoice_id 
	join customer on customer.customer_id =invoice.customer_id 
	where track_id in (
		select track_id
		from track 
		join genre on track.genre_id= genre.genre_id 	
		where genre.name like 'Rock'
		)
	order by customer.email	
/* Q2 lets invite the artists who have written the most  
rock music in our dataset write a query that returns the artist 
name and total track count of the top 10 bands */	
	select count(track_id) as num_track , artist.artist_id , artist.name
	from track 
	join genre on track.genre_id= genre.genre_id
	join album on track.album_id= album.album_id
	join artist on album.artist_id= artist.artist_id
	where genre.name like 'Rock'
	group by artist.artist_id
	order by num_track desc
	limit 10	
/* Q3 Retrn aLL the track names that have song length longer than the avg song length.
return the name and millisec for each track. order by the song 
length with the loongest songs listed first */
	select name, milliseconds from track
	where milliseconds > ( select  avg(milliseconds) as avg_millisec from track ) 
	order by milliseconds desc
	
	
	
	