/*
    Name: Gilbert Morgan
    DTSC660: Data and Database Managment with SQL
    Assignment 5- PART 1
*/

--------------------------------------------------------------------------------
/*				                 Query 1            		  		          */
--------------------------------------------------------------------------------

SELECT 
    b.cust_ID,
    d.account_number,
    b.loan_number
FROM 
    borrower b
JOIN 
    depositor d ON b.cust_ID = d.cust_ID
ORDER BY 
    b.cust_ID;

--------------------------------------------------------------------------------
/*				                  Query 2           		  		          */
--------------------------------------------------------------------------------

SELECT 
    c.cust_ID,
    c.customer_city,
    b.branch_name,
    b.branch_city,
    a.account_number
FROM 
    customer c
JOIN 
    depositor d ON c.cust_ID = d.cust_ID
JOIN 
    account a ON d.account_number = a.account_number
JOIN 
    branch b ON a.branch_name = b.branch_name
WHERE 
    c.customer_city = b.branch_city;

--------------------------------------------------------------------------------
/*				                  Query 3           		  		          */
--------------------------------------------------------------------------------

SELECT 
    cust_ID,
    customer_name
FROM 
    customer
WHERE 
    cust_ID IN (
        SELECT cust_ID
        FROM borrower
        EXCEPT
        SELECT cust_ID
        FROM depositor
    )
ORDER BY 
    cust_ID;
   
--------------------------------------------------------------------------------
/*				                  Query 4           		  		          */
--------------------------------------------------------------------------------

SELECT DISTINCT 
    a.branch_name
FROM 
    customer c
JOIN 
    depositor d ON c.cust_ID = d.cust_ID
JOIN 
    account a ON d.account_number = a.account_number
WHERE 
    c.customer_city = 'Harrison'
ORDER BY 
    a.branch_name;

--------------------------------------------------------------------------------
/*				                  Query 5           		  		          */
--------------------------------------------------------------------------------

SELECT 
    cust_ID,
    customer_name
FROM 
    customer
WHERE 
    (customer_street, customer_city) IN (
        SELECT customer_street, customer_city
        FROM customer
        WHERE cust_ID = '12345'
    )
    AND cust_ID <> '12345'
ORDER BY 
    cust_ID;
    
--------------------------------------------------------------------------------
/*				                  Query 6           		  		          */
--------------------------------------------------------------------------------

SELECT 
    c.cust_ID,
    c.customer_name
FROM 
    customer c
JOIN 
    depositor d ON c.cust_ID = d.cust_ID
JOIN 
    account a ON d.account_number = a.account_number
JOIN 
    branch b ON a.branch_name = b.branch_name
WHERE 
    b.branch_city = 'Brooklyn'
GROUP BY 
    c.cust_ID, c.customer_name
HAVING 
    COUNT(DISTINCT b.branch_name) = (
        SELECT COUNT(DISTINCT branch_name)
        FROM branch
        WHERE branch_city = 'Brooklyn'
    );

--------------------------------------------------------------------------------
/*				                  Query 7           		  		          */
--------------------------------------------------------------------------------

SELECT 
    l.loan_number,
    c.customer_name,
    l.branch_name
FROM 
    loan l
JOIN 
    borrower b ON l.loan_number = b.loan_number
JOIN 
    customer c ON b.cust_ID = c.cust_ID
WHERE 
    l.branch_name = 'Yonkahs Bankahs'
    AND CAST(l.amount AS NUMERIC) > (
        SELECT CAST(AVG(CAST(amount AS NUMERIC)) AS NUMERIC)
        FROM loan
        WHERE branch_name = 'Yonkahs Bankahs'
    );
	