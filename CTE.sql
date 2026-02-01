--- CTE (Common Table Expression); is a temporary, named result set that exists only for the duration of a single query.
---It improves readability, reduces reptition and allows you to break complex logic into clean and logical steps

----cte syntax---
WITH cte_name AS(
     SELECT.....
)
SELECT...
FROM cte_name;

---CTE is essentially a query that runs before your main query and expose 
--its output as if it were a temporary table or view--

----key note---
---1) It lives only for statment (not stored in the database)
---2) it makes long queries easier to read
---3) You can define mutiple CTEs 



---- CTE for "films and the languages they were produced in"
--Normal join (NO CTE)
SELECT f.film_id, f.title, l.name AS language
FROM film AS f
JOIN language AS l
ON f.language_id = l.language_id 
ORDER BY f.title

---same thing using a CTE---
WITH film_language AS(
     SELECT f.film_id,
	        f.title,
			l.name AS language
     FROM film AS f
	 JOIN language AS l
	   ON f.language_id = l.language_id 
)
SELECT * 
FROM film_language 
ORDER BY title;

----what changed---
- Inside WITH film_language AS (...) we build the result once
---in thr mian SELECT we just read from film_langauage like a table
---Now it's easy to re-use or filter 




---EXAMPLE 2: EACH CUSTOMERS AND TOTAL AMOUNT THEY HAVE PAID--

WITH customer_payment AS (
      SELECT c.customer_id,
	         c.first_name,
			 c.last_name,
			 p.amount
	  FROM customer AS c
	  JOIN payment AS p
	     ON c.customer_id = p.customer_id		
),
totals AS (
      SELECT customer_id,
	         first_name,
			 last_name,
			 SUM(amount) AS total_paid
	 FROM customer_payment
	 GROUP BY customer_id,first_name,last_name
)
SELECT customer_id,
       first_name || ''|| last_name AS full_name,
	   total_paid
FROM totals 
ORDER BY total_paid  DESC





WITH customer_payment AS (
      SELECT c.customer_id,
	         c.first_name,
			 c.last_name,
			 p.amount
	  FROM customer AS c
	  JOIN payment AS p
	     ON c.customer_id = p.customer_id		
),
totals AS (
      SELECT customer_id,
	         first_name,
			 last_name,
			 SUM(amount) AS total_paid
	 FROM customer_payment
	 GROUP BY customer_id,first_name,last_name
)
SELECT *
FROM totals 
ORDER BY total_paid  DESC







WITH customer_payment AS (
      SELECT c.customer_id,
	         c.first_name,
			 c.last_name,
			 sum(p.amount) AS total_paid
	  FROM customer AS c
	  JOIN payment AS p
	     ON c.customer_id = p.customer_id	
		 GROUP BY c.customer_id,c.first_name,c.last_name
)
SELECT *
FROM customer_payment
ORDER BY total_paid  DESC



