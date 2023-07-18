/* Q3 Retrn aLL the track names that have song length longer than the avg song length.
return the name and millisec for each track. order by the song 
length with the loongest songs listed first */
select name, milliseconds from track
where milliseconds > ( select  avg(milliseconds) as avg_millisec from track ) 
order by milliseconds desc