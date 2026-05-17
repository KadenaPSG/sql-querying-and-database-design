/*
  Oracle Database Analytics Portfolio
  Author: Gilbert Morgan

  Purpose:
  Demonstrates Oracle SQL and PL/SQL skills for database querying,
  stored procedures, package specifications, package bodies, joins,
  aggregation, CASE logic, CTEs, and reusable reporting workflows.

  Skills demonstrated:
  - PL/SQL programming
  - Oracle package development
  - Stored procedures
  - Relational database querying
  - Joins and aggregations
  - CASE logic
  - CTEs
  - Reusable database analytics workflows
*/

CREATE OR REPLACE PACKAGE analytics_reporting_pkg AS

  PROCEDURE customer_revenue_summary;

  PROCEDURE state_revenue_summary;

  PROCEDURE high_value_customers(
    p_min_revenue IN NUMBER
  );

END analytics_reporting_pkg;
/
