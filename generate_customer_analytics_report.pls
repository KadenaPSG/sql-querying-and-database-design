/*
  Oracle PL/SQL Stored Procedure
  Author: Gilbert Morgan
  Demonstrates a reusable reporting procedure using SQL joins,
  aggregation, CASE logic, and DBMS_OUTPUT.
*/

CREATE OR REPLACE PROCEDURE generate_customer_analytics_report AS
BEGIN
  FOR rec IN (
    SELECT
      c.customer_id,
      c.customer_name,
      c.state,
      COUNT(o.order_id) AS total_orders,
      SUM(o.order_total) AS total_revenue,
      AVG(o.order_total) AS average_order_value,
      CASE
        WHEN SUM(o.order_total) >= 1000 THEN 'High Value'
        WHEN SUM(o.order_total) >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
      END AS customer_segment
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
      rec.state || ' | Orders: ' ||
      rec.total_orders || ' | Revenue: ' ||
      rec.total_revenue || ' | Segment: ' ||
      rec.customer_segment
    );
  END LOOP;
END generate_customer_analytics_report;
/
