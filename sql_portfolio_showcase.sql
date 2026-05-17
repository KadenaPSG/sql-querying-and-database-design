-- SQL Database Analytics Portfolio
-- Author: Gilbert Morgan
-- Purpose: Demonstrate core SQL skills for GitHub language detection and portfolio review.
-- Skills shown: table creation, filtering, joins, aggregation, CASE logic, subqueries, CTEs, and window functions.

-- ------------------------------------------------------------
-- 1. Create sample tables
-- ------------------------------------------------------------

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    state VARCHAR(2),
    signup_date DATE
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    order_total DECIMAL(10, 2),
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ------------------------------------------------------------
-- 2. Basic filtering and sorting
-- ------------------------------------------------------------

SELECT
    customer_id,
    first_name,
    last_name,
    state,
    signup_date
FROM customers
WHERE state = 'MD'
ORDER BY signup_date DESC;

-- ------------------------------------------------------------
-- 3. Inner join for customer order analysis
-- ------------------------------------------------------------

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.state,
    o.order_id,
    o.order_date,
    o.order_total,
    o.order_status
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed';

-- ------------------------------------------------------------
-- 4. Aggregation and GROUP BY
-- ------------------------------------------------------------

SELECT
    c.state,
    COUNT(o.order_id) AS total_orders,
    SUM(o.order_total) AS total_revenue,
    AVG(o.order_total) AS average_order_value
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY total_revenue DESC;

-- ------------------------------------------------------------
-- 5. HAVING clause for grouped filtering
-- ------------------------------------------------------------

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS number_of_orders,
    SUM(o.order_total) AS lifetime_value
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(o.order_id) >= 2
ORDER BY lifetime_value DESC;

-- ------------------------------------------------------------
-- 6. CASE statement for customer segmentation
-- ------------------------------------------------------------

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.order_total) AS lifetime_value,
    CASE
        WHEN SUM(o.order_total) >= 1000 THEN 'High Value'
        WHEN SUM(o.order_total) >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY lifetime_value DESC;

-- ------------------------------------------------------------
-- 7. Subquery example
-- ------------------------------------------------------------

SELECT
    order_id,
    customer_id,
    order_date,
    order_total
FROM orders
WHERE order_total > (
    SELECT AVG(order_total)
    FROM orders
)
ORDER BY order_total DESC;

-- ------------------------------------------------------------
-- 8. Common Table Expression, also called CTE
-- ------------------------------------------------------------

WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(order_total) AS total_revenue,
        COUNT(order_id) AS order_count
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    cr.order_count,
    cr.total_revenue
FROM customers AS c
INNER JOIN customer_revenue AS cr
    ON c.customer_id = cr.customer_id
ORDER BY cr.total_revenue DESC;

-- ------------------------------------------------------------
-- 9. Window function for ranking customers
-- ------------------------------------------------------------

WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.state,
        SUM(o.order_total) AS total_revenue
    FROM customers AS c
    INNER JOIN orders AS o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Completed'
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        c.state
)
SELECT
    customer_id,
    first_name,
    last_name,
    state,
    total_revenue,
    RANK() OVER (
        PARTITION BY state
        ORDER BY total_revenue DESC
    ) AS state_revenue_rank
FROM customer_revenue
ORDER BY state, state_revenue_rank;

-- ------------------------------------------------------------
-- 10. Data quality check
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN order_total IS NULL THEN 1 ELSE 0 END) AS missing_order_total,
    SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS missing_order_status
FROM orders;
