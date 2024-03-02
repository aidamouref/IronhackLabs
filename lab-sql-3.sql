/* LAB 4 SQL 
AIDA MOURE FERNANDEZ
Date: 02-03-2024 */

use sakila;

-- 1. Get film ratings.
select title, rating from sakila.film;
select distinct rating from sakila.film; -- there are 5 different rating categories: PG, G, NC-17, PG-13, R

-- 2. Get release years.
select title, release_year from sakila.film;
select distinct release_year from sakila.film; -- all movies were released in 2006

-- 3. Get all films with ARMAGEDDON in the title.
select title from sakila.film
where title regexp 'armageddon'; -- there are 6 different titles of movies with the word armaggedon included in the title

-- 4.Get all films with APOLLO in the title
select title from sakila.film
where title regexp 'apollo'; -- there are 6 different titles of movies with the word apollo included in the title

-- 5. Get all films which title ends with APOLLO.
select title from sakila.film
where title regexp 'apollo$'; -- there are 5 different titles of movies with the word apollo as the last word in the title

-- 6. Get all films with word DATE in the title.
select title from sakila.film
where title  like 'date %' or title like '% date'; -- there are 5 different titles of movies with the word date included in the title

-- 7. Get 10 films with the longest title.
select title, length(title) as titlelength from sakila.film order by length(title) desc
limit 10; 
-- the first one from these 10 longest titles is ARACHNOPHOBIA ROLLERCOASTER (27 char) while the tenth one is DELIVERANCE MULHOLLAND (22 char)

-- 8. Get 10 the longest films.
select title, length from sakila.film order by length desc
limit 10; 
-- the longest movies shown go from DARN FORRESTER to CONTROL ANTHEM, the ten of them last 185 mins each

-- 9. How many films include **Behind the Scenes** content?
select count(*) from sakila.film
where special_features regexp 'behind the scenes';
--  we have 538 films including behind the scenes content

-- 10. List films ordered by release year and title in alphabetical order.
select title, description, release_year from sakila.film
order by release_year, title;
