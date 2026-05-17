-- advanced_sql_analytics_examples.sql
-- SQL portfolio file for GitHub language detection.
-- Demonstrates advanced SQL analytics skills:
-- schema design, INSERT statements, joins, CTEs, aggregations,
-- CASE logic, date functions, subqueries, and window functions.

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100),
    state VARCHAR(2),
    customer_segment VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);

CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    sale_date DATE,
    quantity INTEGER,
    discount_rate DECIMAL(5, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Avery Johnson', 'MD', 'Healthcare', '2023-01-15'),
(2, 'Jordan Smith', 'VA', 'Education', '2023-02-10'),
(3, 'Taylor Brown', 'DC', 'Government', '2023-03-22'),
(4, 'Morgan Davis', 'MD', 'Retail', '2023-04-18');

INSERT INTO products VALUES
(101, 'Analytics Dashboard', 'Software', 499.00),
(102, 'Data Integration Tool', 'Software', 799.00),
(103, 'Training Workshop', 'Services', 1200.00),
(104, 'Reporting Template', 'Services', 250.00);

INSERT INTO sales VALUES
(1001, 1, 101, '2024-01-05', 2, 0.10),
(1002, 1, 103, '2024-02-14', 1, 0.00),
(1003, 2, 102, '2024-03-03', 1, 0.05),
(1004, 3, 101, '2024-03-18', 3, 0.15),
(1005, 4, 104, '2024-04-20', 5, 0.00),
(1006, 2, 103, '2024-05-11', 1, 0.10),
(1007, 3, 102, '2024-06-09', 2, 0.05),
(1008, 4, 101, '2024-06-25', 1, 0.00);

-- 1. Revenue by customer using joins and calculated fields
SELECT
    c.customer_id,
    c.customer_name,
    c.state,
    c.customer_segment,
    SUM(s.quantity * p.unit_price * (1 - s.discount_rate)) AS net_revenue
FROM customers AS c
INNER JOIN sales AS s
    ON c.customer_id = s.customer_id
INNER JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.state,
    c.customer_segment
ORDER BY net_revenue DESC;

-- 2. Category-level performance summary
SELECT
    p.category,
    COUNT(s.sale_id) AS number_of_sales,
    SUM(s.quantity) AS units_sold,
    ROUND(SUM(s.quantity * p.unit_price * (1 - s.discount_rate)), 2) AS net_revenue,
    ROUND(AVG(s.quantity * p.unit_price * (1 - s.discount_rate)), 2) AS average_sale_value
FROM products AS p
INNER JOIN sales AS s
    ON p.product_id = s.product_id
GROUP BY p.category
HAVING SUM(s.quantity * p.unit_price * (1 - s.discount_rate)) > 1000
ORDER BY net_revenue DESC;

-- 3. Customer segmentation with CASE logic
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(s.quantity * p.unit_price * (1 - s.discount_rate)) AS total_revenue
    FROM customers AS c
    INNER JOIN sales AS s
        ON c.customer_id = s.customer_id
    INNER JOIN products AS p
        ON s.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_revenue,
    CASE
        WHEN total_revenue >= 2000 THEN 'High Value'
        WHEN total_revenue >= 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS revenue_segment
FROM customer_revenue
ORDER BY total_revenue DESC;

-- 4. Window function for customer ranking by state
WITH state_revenue AS (
    SELECT
        c.state,
        c.customer_name,
        SUM(s.quantity * p.unit_price * (1 - s.discount_rate)) AS total_revenue
    FROM customers AS c
    INNER JOIN sales AS s
        ON c.customer_id = s.customer_id
    INNER JOIN products AS p
        ON s.product_id = p.product_id
    GROUP BY c.state, c.customer_name
)
SELECT
    state,
    customer_name,
    total_revenue,
    RANK() OVER (
        PARTITION BY state
        ORDER BY total_revenue DESC
    ) AS state_rank
FROM state_revenue
ORDER BY state, state_rank;

-- 5. Subquery to find above-average sales
SELECT
    s.sale_id,
    c.customer_name,
    p.product_name,
    s.quantity,
    p.unit_price,
    s.quantity * p.unit_price * (1 - s.discount_rate) AS net_sale_amount
FROM sales AS s
INNER JOIN customers AS c
    ON s.customer_id = c.customer_id
INNER JOIN products AS p
    ON s.product_id = p.product_id
WHERE s.quantity * p.unit_price * (1 - s.discount_rate) > (
    SELECT AVG(s2.quantity * p2.unit_price * (1 - s2.discount_rate))
    FROM sales AS s2
    INNER JOIN products AS p2
        ON s2.product_id = p2.product_id
)
ORDER BY net_sale_amount DESC;

-- 6. Data validation checks
SELECT
    COUNT(*) AS total_sales_records,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN quantity <= 0 THEN 1 ELSE 0 END) AS invalid_quantity,
    SUM(CASE WHEN discount_rate < 0 OR discount_rate > 1 THEN 1 ELSE 0 END) AS invalid_discount_rate
FROM sales;
