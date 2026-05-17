--------------------------------------------------------------------------------
/*				                 Create Database         	 		          */
--------------------------------------------------------------------------------

CREATE DATABASE auto_parts_unlimited;

--------------------------------------------------------------------------------
/*				             Connect to Database        		  	          */
--------------------------------------------------------------------------------

-- **DO NOT DELETE OR ALTER THE CODE BELOW!**
-- **THIS IS NEEDED FOR CODEGRADE TO RUN YOUR ASSIGNMENT**

\connect auto_parts_unlimited;

--------------------------------------------------------------------------------
/*				          Create Table Statements              	    	      */
--------------------------------------------------------------------------------

-- Table: customers
CREATE TABLE customers (
    cust_id SERIAL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number CHAR(14), -- (xxx) xxx-xxxx = 14 characters
    email VARCHAR(100),
    street_address VARCHAR(100),
    city VARCHAR(50),
    zip CHAR(5),
    state CHAR(2)
);

-- Table: employees
CREATE TABLE employees (
    employee_id SERIAL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number CHAR(14),
    email VARCHAR(100),
    street_address VARCHAR(100),
    city VARCHAR(50),
    zip CHAR(5),
    state CHAR(2),
    hire_date DATE,
    salary NUMERIC(10,2),
    probation BOOLEAN
);

-- Table: parts_inventory
CREATE TABLE parts_inventory (
    part_number VARCHAR(20),
    manufacturer VARCHAR(50),
    quantity INTEGER,
    price NUMERIC(10,2)
);