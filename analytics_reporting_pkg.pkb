/*
  Oracle PL/SQL Package Body
  Author: Gilbert Morgan
  Demonstrates stored procedures, joins, aggregation, filtering,
  CTEs, CASE logic, and reusable analytics reporting.
*/

CREATE OR REPLACE PACKAGE BODY analytics_reporting_pkg AS

  PROCEDURE customer_revenue_summary IS
  BEGIN
    FOR rec IN (
      SELECT
        c.customer_id,
        c.customer_name,
        c.state,
        SUM(o.order_total) AS total_revenue,
        COUNT(o.order_id) AS total_orders,
        CASE
          WHEN SUM(o.order_total) >= 1000 THEN 'High Value'
          WHEN SUM(o.order_total) >= 500 THEN 'Medium Value'
          ELSE 'Low Value'
        END AS revenue_segment
      FROM customers c
      INNER JOIN orders o
        ON c.customer_id = o.customer_id
      GROUP BY
        c.customer_id,
        c.customer_name,
        c.state
      ORDER BY total_revenue DESC
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(
        rec.customer_name || ' | ' ||
        rec.state || ' | Revenue: ' ||
        rec.total_revenue || ' | Segment: ' ||
        rec.revenue_segment
      );
    END LOOP;
  END customer_revenue_summary;


  PROCEDURE state_revenue_summary IS
  BEGIN
    FOR rec IN (
      SELECT
        c.state,
        COUNT(o.order_id) AS total_orders,
        SUM(o.order_total) AS total_revenue,
        AVG(o.order_total) AS average_order_value
      FROM customers c
      INNER JOIN orders o
        ON c.customer_id = o.customer_id
      GROUP BY c.state
      HAVING SUM(o.order_total) > 0
      ORDER BY total_revenue DESC
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(
        rec.state || ' | Orders: ' ||
        rec.total_orders || ' | Revenue: ' ||
        rec.total_revenue || ' | Average Order: ' ||
        ROUND(rec.average_order_value, 2)
      );
    END LOOP;
  END state_revenue_summary;


  PROCEDURE high_value_customers(
    p_min_revenue IN NUMBER
  ) IS
  BEGIN
    FOR rec IN (
      WITH customer_revenue AS (
        SELECT
          c.customer_id,
          c.customer_name,
          c.state,
          SUM(o.order_total) AS total_revenue
        FROM customers c
        INNER JOIN orders o
          ON c.customer_id = o.customer_id
        GROUP BY
          c.customer_id,
          c.customer_name,
          c.state
      )
      SELECT
        customer_id,
        customer_name,
        state,
        total_revenue
      FROM customer_revenue
      WHERE total_revenue >= p_min_revenue
      ORDER BY total_revenue DESC
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(
        rec.customer_name || ' | ' ||
        rec.state || ' | Revenue: ' ||
        rec.total_revenue
      );
    END LOOP;
  END high_value_customers;

END analytics_reporting_pkg;
/
