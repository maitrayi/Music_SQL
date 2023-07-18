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