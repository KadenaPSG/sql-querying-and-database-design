--------------------------------------------------------------------------------
/*				                 Create Database         	 		          */
--------------------------------------------------------------------------------

CREATE DATABASE holy_grounds;

--------------------------------------------------------------------------------
/*				             Connect to Database        		  	          */
--------------------------------------------------------------------------------

-- **DO NOT DELETE OR ALTER THE CODE BELOW!**
-- **THIS IS NEEDED FOR CODEGRADE TO RUN YOUR ASSIGNMENT**

\connect holy_grounds;

--------------------------------------------------------------------------------
/*				          Create Table Statements              	    	      */
--------------------------------------------------------------------------------

-- Table: coffee_inventory
CREATE TABLE coffee_inventory (
    sku VARCHAR(20),
    name VARCHAR(100),
    roast_type VARCHAR(10),
    lbs_on_hand NUMERIC(6,2),
    organic BOOLEAN,
    price_per_lb NUMERIC(6,2)
);

-- Table: sales_transactions
CREATE TABLE sales_transactions (
    receipt_id BIGSERIAL,
    sale_amount NUMERIC(10,2),
    sale_type VARCHAR(10),
    transaction_date TIMESTAMP
);

-- Table: stores
CREATE TABLE stores (
    store_id SERIAL,
    store_manager VARCHAR(100),
    store_phone CHAR(14),
    store_address VARCHAR(100),
    city VARCHAR(50),
    zip CHAR(5),
    state CHAR(2)
);