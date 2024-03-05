
/* Lab | SQL Queries 7
AIDA MOURE FERNANDEZ
Date: 04-03-2024 
DB: sakila*/

-- 1. In the table actor, which are the actors whose last names are not repeated?  
select last_name, count(actor_id) 
from sakila.actor
group by last_name
having count(actor_id)=1
order by last_name asc;
-- we have 66 rows (actors) whose last names are not repeated


-- 2. Which last names appear more than once? 
select last_name, count(actor_id) as N
from sakila.actor
group by last_name
having count(actor_id)>1
order by N, last_name asc;
-- we have 55 rows (actors) whose last names are repeated

-- 3. Using the rental table, find out how many rentals were processed by each employee.
select staff_id, count(rental_id)
from sakila.rental
group by staff_id
order by staff_id;
-- employee 1 processed 8,040 rentals; employee 2 8,004 rentals.

-- 4. Using the film table, find out how many films were released each year.
select release_year, count(film_id)
from sakila.film
group by release_year
order by release_year;
-- 2006 was the only release year and this includes 1,000 films

-- 5. Using the film table, find out for each rating how many films were there.
select rating, count(film_id)
from sakila.film
group by rating
order by count(film_id);
-- rating G included 178 films; rating PG included 194 films, and so on.

-- 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places 
select rating, round(avg(length),2) as avg_len
from sakila.film
group by rating
order by avg_len;
-- mean length goes from 111.05 mins (rating G) to 120.44 mins (rating PG-13)

-- 7. Which kind of movies (rating) have a mean duration of more than two hours? 
select rating, round(avg(length),2) as avg_len
from sakila.film
group by rating
having avg_len>120;
-- movies with rating PG-13 are the only ones having an average length of more than 2 hours (120 mins)