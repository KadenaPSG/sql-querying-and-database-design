/*
Database Analytics Queries
Author: Gilbert Morgan
Purpose: Demonstrates SQL skills in table creation, filtering, joins, aggregation,
subqueries, CASE statements, and relational database analysis.
*/

-- 1. Create an example table structure
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    program VARCHAR(100),
    enrollment_year INT
);

CREATE TABLE course_enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(100),
    grade DECIMAL(4,2),
    credits INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 2. Select and filter records
SELECT
    student_id,
    first_name,
    last_name,
    program,
    enrollment_year
FROM students
WHERE enrollment_year >= 2022
ORDER BY enrollment_year DESC;

-- 3. Join tables for multi-table analysis
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    s.program,
    c.course_name,
    c.grade,
    c.credits
FROM students AS s
INNER JOIN course_enrollments AS c
    ON s.student_id = c.student_id;

-- 4. Aggregate results by program
SELECT
    s.program,
    COUNT(DISTINCT s.student_id) AS total_students,
    COUNT(c.enrollment_id) AS total_course_enrollments,
    AVG(c.grade) AS average_grade
FROM students AS s
LEFT JOIN course_enrollments AS c
    ON s.student_id = c.student_id
GROUP BY s.program
ORDER BY average_grade DESC;

-- 5. Use CASE logic to classify student performance
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    c.grade,
    CASE
        WHEN c.grade >= 90 THEN 'Excellent'
        WHEN c.grade >= 80 THEN 'Good'
        WHEN c.grade >= 70 THEN 'Satisfactory'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM students AS s
INNER JOIN course_enrollments AS c
    ON s.student_id = c.student_id;

-- 6. Subquery to identify above-average grades
SELECT
    student_id,
    course_name,
    grade
FROM course_enrollments
WHERE grade > (
    SELECT AVG(grade)
    FROM course_enrollments
);

-- 7. HAVING clause for grouped filtering
SELECT
    s.program,
    AVG(c.grade) AS average_grade,
    COUNT(c.enrollment_id) AS course_count
FROM students AS s
INNER JOIN course_enrollments AS c
    ON s.student_id = c.student_id
GROUP BY s.program
HAVING COUNT(c.enrollment_id) >= 3
ORDER BY average_grade DESC;
