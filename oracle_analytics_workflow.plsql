/*
  Oracle PL/SQL Analytics Script
  Author: Gilbert Morgan
  Demonstrates executable PL/SQL blocks, variables, loops,
  SELECT INTO logic, and analytical reporting.
*/

SET SERVEROUTPUT ON;

DECLARE
  v_total_customers NUMBER;
  v_total_orders NUMBER;
  v_total_revenue NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO v_total_customers
  FROM customers;

  SELECT COUNT(*), SUM(order_total)
  INTO v_total_orders, v_total_revenue
  FROM orders;

  DBMS_OUTPUT.PUT_LINE('Customer Count: ' || v_total_customers);
  DBMS_OUTPUT.PUT_LINE('Order Count: ' || v_total_orders);
  DBMS_OUTPUT.PUT_LINE('Total Revenue: ' || v_total_revenue);
END;
/

DECLARE
  CURSOR revenue_cursor IS
    SELECT
      c.state,
      COUNT(o.order_id) AS order_count,
      SUM(o.order_total) AS state_revenue
    FROM customers c
    INNER JOIN orders o
      ON c.customer_id = o.customer_id
    GROUP BY c.state
    ORDER BY state_revenue DESC;
BEGIN
  FOR rec IN revenue_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(
      rec.state || ' | Orders: ' ||
      rec.order_count || ' | Revenue: ' ||
      rec.state_revenue
    );
  END LOOP;
END;
/
