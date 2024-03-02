/* LAB 3 SQL 
AIDA MOURE FERNANDEZ
Date: 02-03-2024 */

use sakila;
-- 1. How many distinct (different) actors' last names are there?
select count(distinct(last_name)) from sakila.actor; -- we have 121 actors with different last names
select distinct(last_name) from sakila.actor;

-- 2. In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
select count(distinct language_id) from sakila.film; -- only 1

-- 3. How many movies were released with `"PG-13"` rating?
select count(rating) from sakila.film -- there are 223 movies with PG-13 rating
where rating='PG-13';

-- 4. Get 10 the longest movies from 2006.
select title, length from sakila.film
where release_year=2006 order by length desc
limit 10; 
-- the longest movies shown go from DARN FORRESTER to CONTROL ANTHEM, the ten of them last 185 mins each

-- 5. How many days has been the company operating (check `DATEDIFF()` function)?
select  datediff(max(payment_date),min(payment_date)) from sakila.payment;
-- it was operating 266 days

-- 6. Show rental info with additional columns month and weekday. Get 20.
select *, month(rental_date) as mes, weekday(rental_date) as weekday from sakila.rental
limit 20;

-- 7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.
select *,
case
	when weekday(rental_date) in (1,2,3,4,5)  then 'workday'
	else 'weekend'
end as 'day_type'
from sakila.rental;

-- 8. How many rentals were in the last month of activity?

select count(rental_id) from sakila.rental GROUP BY MONTH(rental_date) 
order by month(rental_date) desc
limit 1; -- there were 5,686 rentals the last month

-- just to check--
select distinct month(rental_date) from sakila.rental; -- last month is 8
select count(rental_id) from sakila.rental
where month(rental_date)=8; -- we are getting the same result so the above command should be ok