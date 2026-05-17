/*
    Name: Gilbert Morgan
    DTSC660: Data and Database Management with SQL
    Assignment 3

Place your SQL code where indicated below. 
DO NOT remove the  Query number headers as CodeGrade uses this for grading!!
*/

--------------------------------------------------------------------------------
/*                                  Query 1                                      */
--------------------------------------------------------------------------------
SELECT category,
       SUM(revenue) AS total_revenue
FROM customer_spending
WHERE sale_year = 2016
GROUP BY category
ORDER BY category;

--------------------------------------------------------------------------------
/*                                  Query 2                                      */
--------------------------------------------------------------------------------
SELECT sub_category,
       ROUND(AVG(unit_price), 2) AS avg_unit_price,
       ROUND(AVG(unit_cost), 2) AS avg_unit_cost,
       ROUND(AVG(unit_price) - AVG(unit_cost), 2) AS margin
FROM customer_spending
WHERE sale_year = 2015
GROUP BY sub_category
ORDER BY sub_category;

--------------------------------------------------------------------------------
/*                                  Query 3                                      */
--------------------------------------------------------------------------------
SELECT sale_year,
       COUNT(*) AS total_female_buyers
FROM customer_spending
WHERE gender = 'F'
  AND category = 'Clothing'
GROUP BY sale_year
ORDER BY sale_year;

--------------------------------------------------------------------------------
/*                                  Query 4                                      */
--------------------------------------------------------------------------------
SELECT age, 
       sub_category, 
       ROUND(AVG(quantity)) AS avg_quantity, 
       ROUND(AVG(cost), 2) AS avg_cost
FROM customer_spending
GROUP BY age, sub_category
ORDER BY age DESC, sub_category ASC;

--------------------------------------------------------------------------------
/*                                  Query 5                                      */
--------------------------------------------------------------------------------
SELECT country
FROM customer_spending
WHERE age BETWEEN 18 AND 25
GROUP BY country
HAVING COUNT(*) > 900
ORDER BY country;

--------------------------------------------------------------------------------
/*                                  Query 6                                      */
--------------------------------------------------------------------------------
SELECT sale_year,
       category,
       SUM(revenue) AS total_revenue,
       SUM(cost) AS total_cost,
       SUM(revenue - cost) AS profit
FROM customer_spending
GROUP BY sale_year, category
HAVING SUM(revenue - cost) > 0
ORDER BY profit DESC;

--------------------------------------------------------------------------------
/*                                  Query 7                                      */
--------------------------------------------------------------------------------
SELECT age,
       ROUND(AVG(unit_price * quantity), 2) AS avg_spending
FROM customer_spending
WHERE gender = 'M'
GROUP BY age
ORDER BY avg_spending DESC;

--------------------------------------------------------------------------------
/*                                  Query 8                                      */
--------------------------------------------------------------------------------
SELECT gender,
       category,
       MAX(unit_cost) AS high_cost,
       MIN(unit_cost) AS low_cost,
       AVG(unit_cost) AS avg_cost
FROM customer_spending
GROUP BY gender, category
ORDER BY gender, category;

--------------------------------------------------------------------------------
/*                                  Query 9                                      */
--------------------------------------------------------------------------------
SELECT category,
       country,
       MIN(age) AS youngest_customer,
       MAX(age) AS oldest_customer,
       ROUND(AVG(age), 1) AS avg_customer_age
FROM customer_spending
WHERE sale_year = 2016
GROUP BY category, country
ORDER BY category, avg_customer_age;

--------------------------------------------------------------------------------
/*                                  Query 10                                     */
--------------------------------------------------------------------------------
SELECT country,
       ROUND(AVG(revenue), 2) AS high_sales
FROM customer_spending
GROUP BY country
ORDER BY high_sales DESC
LIMIT 1;
