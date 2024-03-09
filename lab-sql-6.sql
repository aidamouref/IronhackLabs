/* Lab | SQL Queries 8
AIDA MOURE FERNANDEZ
Date: 09-03-2024 
DB: sakila*/

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, rank() over(order by length asc) as 'Rank',
dense_rank() over(order by length asc) as 'Dense Rank'
from sakila.film
where length <> ' ';

-- 2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select title, length, rating, rank() over(partition by rating order by length asc) as 'RANK'
from sakila.film
where length <> ' ';

-- 3. How many films are there for each of the categories in the category table?
select category_id, count(distinct(f.film_id)) as films from sakila.film f
left join sakila.film_category fc
on f.film_id = fc.film_id
group by category_id;

-- 4. Which actor has appeared in the most films?
 select first_name,last_name, count(distinct(film_id)) as numberfilms
 from sakila.actor a  left join sakila.film_actor fa on a.actor_id=fa.actor_id
 group by first_name,last_name
 order by numberfilms desc;
   
 -- 5. Which is the most active customer (the customer that has rented the most number of films)?
 select first_name, last_name, count(rental_id) as nfilms_rent
 from sakila.customer c right join sakila.rental r on c.customer_id=r.customer_id
 group by first_name, last_name
 order by nfilms_rent desc;
  
 -- 6. List the number of films per category.
 select category_id, count(film_id) as nfilms from sakila.film_category
 group by category_id;
 
 -- 7. Display the first and the last names, as well as the address, of each staff member.
 select staff_id, first_name, last_name, address_id from sakila.staff
 order by staff_id;
 
 -- 8. Display the total amount rung up by each staff member in August 2005. 
select s.staff_id, first_name, last_name, sum(amount) as $, left(rental_date, 7) as rental_fecha  from sakila.payment p 
join sakila.rental r on p.rental_id=r.rental_id
join sakila.staff s on p.staff_id=s.staff_id
group by s.staff_id, first_name, last_name, rental_fecha
having rental_fecha='2005-08';

-- 9. List all films and the number of actors who are listed for each film.
select fa.film_id, title, count(distinct(actor_id)) as num_actors from sakila.film_actor fa
join sakila.film f on fa.film_id=f.film_id
group by fa.film_id, title;

-- 10. Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.
select p.customer_id, first_name, last_name, sum(amount) as paid from sakila.payment p
join sakila.customer c on p.customer_id=c.customer_id
group by p.customer_id, first_name, last_name
order by last_name;

-- 11. Write a query to display for each store its store ID, city, and country.
select store_id, city, country  from sakila.city c
join sakila.country co on c.country_id=co.country_id
join sakila.address a on c.city_id=a.city_id
join sakila.store s on a.address_id = s.address_id;

-- 12. Write a query to display how much business, in dollars, each store brought in.
select store_id, sum(amount) as $ from sakila.payment p 
join sakila.customer c on p.customer_id= c.customer_id
group by store_id;

-- 13. What is the average running time of films by category?
select category_id, round(avg(length),2) as avg_running from sakila.film_category fc 
right join sakila.film f on fc.film_id=f.film_id
group by category_id;

-- 14. Which film categories are longest?
select category_id, round(avg(length),2) as avg_running from sakila.film_category fc 
right join sakila.film f on fc.film_id=f.film_id
group by category_id
order by avg_running desc;

-- 15. Display the most frequently rented movies in descending order. 
select  f.film_id, title, count(rental_id) as n_rentals from sakila.film f 
join sakila.inventory i on f.film_id=i.film_id
join sakila.rental r on i.inventory_id=r.inventory_id
group by  f.film_id, title
order by n_rentals desc;

-- 16. List the top five genres in gross revenue in descending order.
select c.name, sum(amount) as gross_rev from sakila.category c
join sakila.film_category fc on c.category_id = fc.category_id
join sakila.inventory i on fc.film_id=i.film_id
join sakila.rental r on i.inventory_id=r.inventory_id
join sakila.payment p on r.rental_id=p.rental_id
group by c.name
order by gross_rev desc
limit 5;

-- 17. Is "Academy Dinosaur" available for rent from Store 1?
select store_id, title from sakila.film f 
join sakila.inventory i on f.film_id=i.film_id
having title="Academy Dinosaur"; -- yes, it is!!
