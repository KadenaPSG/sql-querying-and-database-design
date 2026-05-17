/*
    Name: Gilbert Morgan
    DTSC660: Data and Database Managment with SQL
    Assignment 5- PART 2
*/

--------------------------------------------------------------------------------
/*				                 Query 8            		  		          */
--------------------------------------------------------------------------------

SELECT course_id
FROM course
EXCEPT
SELECT course_id
FROM prereq
ORDER BY course_id;

--------------------------------------------------------------------------------
/*				                  Query 9           		  		          */
--------------------------------------------------------------------------------

SELECT dept_name
FROM department
INTERSECT
SELECT dept_name
FROM instructor
ORDER BY dept_name;

--------------------------------------------------------------------------------
/*				                  Query 10           		  		          */
--------------------------------------------------------------------------------

(
    SELECT dept_name FROM department WHERE budget < 50000
)
UNION
(
    SELECT dept_name FROM instructor WHERE salary > 100000
)
UNION
(
    SELECT dept_name
    FROM student
    WHERE tot_cred = (
        SELECT MAX(tot_cred) FROM student
    )
)
ORDER BY dept_name;

--------------------------------------------------------------------------------
/*				                  Query 11           		  		          */
--------------------------------------------------------------------------------

SELECT 
    c1.course_id,
    c1.title AS course_name,
    c2.course_id AS prereq_id,
    c2.title AS prereq_name
FROM 
    prereq p
JOIN 
    course c1 ON p.course_id = c1.course_id
JOIN 
    course c2 ON p.prereq_id = c2.course_id
ORDER BY 
    c1.course_id;

--------------------------------------------------------------------------------
/*				                  Query 12           		  		          */
--------------------------------------------------------------------------------

SELECT s.ID
FROM student s
LEFT JOIN takes t ON s.ID = t.ID
WHERE t.course_id IS NULL;
