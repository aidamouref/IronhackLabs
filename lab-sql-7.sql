/* Lab | SQL Subqueries 7
AIDA MOURE FERNANDEZ
Date: 14-03-2024 
DB: sakila*/

use sakila;

-- 1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?
select count(film_id) as Nfilms from sakila.inventory where film_id=(
select film_id from sakila.film where title="Hunchback Impossible");

-- 2. List all films whose length is longer than the average of all the films.
select film_id, title, length from sakila.film where length>(
select avg(length) from sakila.film)
order by length
;

-- 3. Use subqueries to display all actors who appear in the film _Alone Trip_.
select first_name, last_name from sakila.actor where actor_id in (
select actor_id from sakila.film_actor where film_id=(
select film_id from sakila.film where title="Alone Trip"));

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select f.film_id, title from sakila.film f  where film_id in (
select film_id from sakila.film_category where category_id=(
select category_id from sakila.category where name="Family"));

-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

-- with joins
select c.address_id, email, first_name, last_name, country from sakila.customer c join sakila.address a on c.address_id=a.address_id
left join sakila.city ci on a.city_id=ci.city_id
left join sakila.country co on ci.country_id=co.country_id
where country="Canada";


-- with subqueries

select first_name, last_name, email from sakila.customer where address_id in (select address_id from sakila.address where city_id in (select city_id from sakila.city where country_id=(select country_id from sakila.country where country="Canada"))) ;


-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select title from sakila.film where film_id in (select film_id from sakila.film_actor where actor_id in(select actor_id from sakila.film_actor group by actor_id having count(film_id) = (select max(films) from (select actor_id, count(film_id) as films from sakila.film_actor
group by actor_id)sub1)))
;


-- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
select title from sakila.film where film_id in(select film_id from sakila.inventory where inventory_id in (select inventory_id from sakila.rental where customer_id in (select customer_id from sakila.payment group by customer_id having sum(amount)=(select max(totalamount) from(select customer_id, sum(amount) as totalamount from sakila.payment
 group by customer_id)sub1))))
;

-- 8. Get the `client_id` and the `total_amount_spent` of those clients who spent more than the average of the `total_amount` spent by each client
select customer_id as customer_id , sum(amount) as total_amount_spent from sakila.payment group by customer_id having total_amount_spent > (select avg(sumamount) from (select customer_id, sum(amount) as sumamount from sakila.payment 
group by customer_id)sub1);


