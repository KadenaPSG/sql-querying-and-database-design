/*
    Name: Gilbert Morgan
    DTSC660: Data and Database Management with SQL
    Assignment 3

Place your SQL code where indicated below. 
DO NOT remove the  Query number headers as CodeGrade uses this for grading!!
*/

--------------------------------------------------------------------------------
/*                                  Query 1                                      */
--------------------------------------------------------------------------------
SELECT trans_date, 
       code_size / transactions::numeric AS difficulty
FROM bitcoin;

--------------------------------------------------------------------------------
/*                                  Query 2                                      */
--------------------------------------------------------------------------------
SELECT trans_date, 
       median_transaction_fee * transactions AS daily_cost
FROM bitcoin
WHERE median_transaction_fee > 0.5;

--------------------------------------------------------------------------------
/*                                  Query 3                                      */
--------------------------------------------------------------------------------
SELECT trans_date, 
       sent_in_usd / transactions::numeric AS avg_transaction
FROM bitcoin
WHERE transactions > 400000;

--------------------------------------------------------------------------------
/*                                  Query 4                                      */
--------------------------------------------------------------------------------
SELECT ROUND(AVG(price_usd), 2)::MONEY AS avg_price,
       ROUND(SUM(sent_in_usd), 2)::MONEY AS total_transaction_amount
FROM bitcoin
WHERE trans_date BETWEEN '2015-05-01' AND '2015-05-31';

--------------------------------------------------------------------------------
/*                                  Query 5                                      */
--------------------------------------------------------------------------------
SELECT MIN(market_cap)::BIGINT AS low_cap,
       MAX(market_cap)::BIGINT AS high_cap,
       ROUND(MIN(price_usd), 2) AS low_price_usd,
       ROUND(MAX(price_usd), 2) AS high_price_usd
FROM bitcoin;

--------------------------------------------------------------------------------
/*                                  Query 6                                      */
--------------------------------------------------------------------------------
SELECT MIN(median_transaction_fee) AS lowest_fee,
       MAX(median_transaction_fee) AS highest_fee,
       ROUND(AVG(transaction_fees), 5) AS avg_fee
FROM bitcoin
WHERE trans_date BETWEEN '2017-08-10' AND '2019-08-10';

--------------------------------------------------------------------------------
/*                                  Query 7                                      */
--------------------------------------------------------------------------------
SELECT 
  AVG(transactions::numeric) AS avg_transactions,
  AVG(sent_by_address::numeric) AS avg_sent_addresses
FROM bitcoin
WHERE transactions > 350000;

--------------------------------------------------------------------------------
/*                                  Query 8                                      */
--------------------------------------------------------------------------------
SELECT ROUND(AVG(google_trends)) AS avg_google_trends,
       SUM(tweets) AS total_tweets
FROM bitcoin;

--------------------------------------------------------------------------------
/*                                  Query 9                                      */
--------------------------------------------------------------------------------
SELECT MIN(confirmation_time) AS min_confirmation_time,
       MAX(confirmation_time) AS max_confirmation_time,
       ROUND(AVG(confirmation_time), 3) AS avg_confirmation_time
FROM bitcoin;

--------------------------------------------------------------------------------
/*                                  Query 10                                     */
--------------------------------------------------------------------------------
SELECT ROUND(AVG(price_usd), 2) AS avg_price_usd,
       ROUND(AVG(mining_profitability), 2) AS avg_mining_profitability,
       ROUND(AVG(transaction_fees), 2) AS avg_transaction_fees
FROM bitcoin
WHERE trans_date BETWEEN '2020-03-01' AND '2020-11-30';
