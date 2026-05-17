/*
    Name: Gilbert Morgan
    DTSC660: Data and Database Management with SQL
    Assignment 6
*/

--------------------------------------------------------------------------------
/*				    Chosen Data Set and Reason for Selecting		          */
--------------------------------------------------------------------------------

/*
I selected the Data Science Salaries dataset because it directly relates to my future career path. 
Since I am getting a MS in Data Science I thought it would make sense to do some salary research. 
This data may help me better understand what compensation might look like after graduation and what roles to target.
*/

--------------------------------------------------------------------------------
/*				                 Select Statement      		  		          */
--------------------------------------------------------------------------------

SELECT * FROM salaries LIMIT 5;

--------------------------------------------------------------------------------
/*				                   Backup Table     		  		          */
--------------------------------------------------------------------------------

DROP TABLE IF EXISTS salaries_backup;

CREATE TABLE salaries_backup AS
SELECT * FROM salaries;

--------------------------------------------------------------------------------
/*				                 Duplicate Column      		  		          */
--------------------------------------------------------------------------------

ALTER TABLE salaries
ADD COLUMN total_yearly_compensation_duplicate NUMERIC;

UPDATE salaries
SET total_yearly_compensation_duplicate = total_yearly_compensation;

--------------------------------------------------------------------------------
/*		              Question 1 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT DISTINCT tag FROM salaries
WHERE tag ILIKE 'NA';

--------------------------------------------------------------------------------
/*				          Question 1 - Update query                           */
--------------------------------------------------------------------------------

UPDATE salaries
SET tag = NULL
WHERE tag ILIKE 'NA';

--------------------------------------------------------------------------------
/*				        Question 1 - Validation query                         */
--------------------------------------------------------------------------------

SELECT * FROM salaries
WHERE tag IS NULL;

--------------------------------------------------------------------------------
/*				        Question 1 - Rationale Comment                        */
--------------------------------------------------------------------------------

/*
I originally checked for 'NA' in the location column but realized it didn’t apply. Instead,
I found 'NA' in the tag column — likely a placeholder for missing job focus info.
I replaced it with NULL so SQL treats it properly, especially in filtering or grouping by tag.
*/

--------------------------------------------------------------------------------
/*		              Question 2 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT * FROM salaries
WHERE total_yearly_compensation = 0;

--------------------------------------------------------------------------------
/*				          Question 2 - Update query                           */
--------------------------------------------------------------------------------

UPDATE salaries
SET total_yearly_compensation = (
    SELECT ROUND(AVG(total_yearly_compensation)::NUMERIC, 2)
    FROM salaries
    WHERE total_yearly_compensation > 0
)
WHERE total_yearly_compensation = 0;

--------------------------------------------------------------------------------
/*				        Question 2 - Validation query                         */
--------------------------------------------------------------------------------

SELECT * FROM salaries
WHERE total_yearly_compensation = 0;

--------------------------------------------------------------------------------
/*				        Question 2 - Rationale Comment                        */
--------------------------------------------------------------------------------

/*
Some of the entries had a salary of 0, which doesn’t make much sense for a job listing.
That’s probably a mistake or missing data. I replaced those with the average salary from the dataset
so the numbers are more realistic and don’t throw off any future analysis or comparisons.
*/

--------------------------------------------------------------------------------
/*		              Question 3 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT DISTINCT title FROM salaries
WHERE title ILIKE '%sr%';

--------------------------------------------------------------------------------
/*				          Question 3 - Update query                           */
--------------------------------------------------------------------------------

UPDATE salaries
SET title = 'Senior Data Scientist'
WHERE title ILIKE 'sr%';

--------------------------------------------------------------------------------
/*				        Question 3 - Validation query                         */
--------------------------------------------------------------------------------

SELECT DISTINCT title FROM salaries
WHERE title = 'Senior Data Scientist';

--------------------------------------------------------------------------------
/*				        Question 3 - Rationale Comment                        */
--------------------------------------------------------------------------------

/*
There were a bunch of slightly different versions of the same job title — like 'Sr.', 'Sr', and 'Sr Data Scientist'.
Even though they all mean the same thing, having them written differently can mess up analysis.
So I standardized them all to 'Senior Data Scientist' to keep things clean and make grouping more accurate.
*/

--------------------------------------------------------------------------------
/*		              Question 4 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT total_yearly_compensation, NULL AS compensation_tier FROM salaries LIMIT 10;

--------------------------------------------------------------------------------
/*				          Question 4 - Update query                           */
--------------------------------------------------------------------------------

ALTER TABLE salaries
ADD COLUMN compensation_tier TEXT;

UPDATE salaries
SET compensation_tier = CASE
    WHEN total_yearly_compensation < 50000 THEN 'Low'
    WHEN total_yearly_compensation BETWEEN 50000 AND 100000 THEN 'Mid'
    ELSE 'High'
END;

--------------------------------------------------------------------------------
/*				        Question 4 - Validation query                         */
--------------------------------------------------------------------------------

SELECT total_yearly_compensation, compensation_tier FROM salaries LIMIT 10;

--------------------------------------------------------------------------------
/*				        Question 4 - Rationale Comment                        */
--------------------------------------------------------------------------------

/*
I added a new column called compensation_tier to break salaries into simple categories like Low, Mid, and High.
This makes it way easier to spot trends and compare different roles or locations without digging through a bunch of numbers.
It also helps when you want to quickly group people based on how much they’re making.
*/
