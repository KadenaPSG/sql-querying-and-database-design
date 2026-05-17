--------------------------------------------------------------------------------
/*				                 Create Database         	 		          */
--------------------------------------------------------------------------------

CREATE DATABASE banking;

--------------------------------------------------------------------------------
/*				             Connect to Database        		  	          */
--------------------------------------------------------------------------------

-- **DO NOT DELETE OR ALTER THE CODE BELOW!**
-- **THIS IS NEEDED FOR CODEGRADE TO RUN YOUR ASSIGNMENT**

\connect banking;

--------------------------------------------------------------------------------
/*				                 Banking DDL           		  		          */
--------------------------------------------------------------------------------

-- Branch Table
CREATE TABLE branch (
    branch_name varchar(40) PRIMARY KEY,
    branch_city varchar(40) NOT NULL CHECK (branch_city IN ('Brooklyn', 'Bronx', 'Manhattan', 'Yonkers')),
    assets money NOT NULL CHECK (assets >= '0.00')
);

-- Customer Table
CREATE TABLE customer (
    cust_ID varchar(40) PRIMARY KEY,
    customer_name varchar(40) NOT NULL,
    customer_street varchar(40) NOT NULL,
    customer_city varchar(40)
);

-- Loan Table
CREATE TABLE loan (
    loan_number varchar(40) PRIMARY KEY,
    branch_name varchar(40) REFERENCES branch(branch_name) ON UPDATE CASCADE ON DELETE CASCADE,
    amount money NOT NULL DEFAULT '0.00',
    CHECK (amount >= '0.00')
);

-- Borrower Table
CREATE TABLE borrower (
    cust_ID varchar(40) REFERENCES customer(cust_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    loan_number varchar(40) REFERENCES loan(loan_number) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (cust_ID, loan_number)
);

-- Account Table
CREATE TABLE account (
    account_number varchar(40) PRIMARY KEY,
    branch_name varchar(40) REFERENCES branch(branch_name) ON UPDATE CASCADE ON DELETE CASCADE,
    balance money NOT NULL DEFAULT '0.00'
);

-- Depositor Table
CREATE TABLE depositor (
    cust_ID varchar(40) REFERENCES customer(cust_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    account_number varchar(40) REFERENCES account(account_number) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (cust_ID, account_number)
);
