-- Advanced SQL Analytics Portfolio
-- Gilbert Morgan
-- Demonstrates advanced SQL querying and analytics skills.

-- ============================================================
-- DATABASE SETUP
-- ============================================================

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INTEGER,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

CREATE TABLE projects (
    project_id INTEGER PRIMARY KEY,
    project_name VARCHAR(100),
    project_budget DECIMAL(12, 2)
);

CREATE TABLE employee_projects (
    employee_id INTEGER,
    project_id INTEGER,
    hours_worked DECIMAL(8, 2),
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),
    FOREIGN KEY (project_id)
        REFERENCES projects(project_id)
);

-- ============================================================
-- BASIC QUERYING
-- ============================================================

SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM employees
WHERE salary > 75000
ORDER BY salary DESC;

-- ============================================================
-- JOINS
-- ============================================================

SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name,
    e.salary
FROM employees AS e
INNER JOIN departments AS d
    ON e.department_id = d.department_id
ORDER BY e.salary DESC;

-- ============================================================
-- AGGREGATION
-- ============================================================

SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    AVG(e.salary) AS average_salary,
    MAX(e.salary) AS highest_salary
FROM departments AS d
LEFT JOIN employees AS e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY average_salary DESC;

-- ============================================================
-- CASE STATEMENTS
-- ============================================================

SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary >= 120000 THEN 'Executive'
        WHEN salary >= 90000 THEN 'Senior'
        WHEN salary >= 60000 THEN 'Mid-Level'
        ELSE 'Entry-Level'
    END AS salary_band
FROM employees
ORDER BY salary DESC;

-- ============================================================
-- SUBQUERY
-- ============================================================

SELECT
    first_name,
    last_name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- ============================================================
-- COMMON TABLE EXPRESSIONS
-- ============================================================

WITH department_salary AS (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT
    d.department_name,
    ds.avg_salary
FROM department_salary AS ds
INNER JOIN departments AS d
    ON ds.department_id = d.department_id
ORDER BY ds.avg_salary DESC;

-- ============================================================
-- WINDOW FUNCTIONS
-- ============================================================

SELECT
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank
FROM employees;

-- ============================================================
-- DATA QUALITY CHECKS
-- ============================================================

SELECT
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN salary IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_salary_values,
    SUM(
        CASE
            WHEN department_id IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_department_values
FROM employees;

-- ============================================================
-- ADVANCED ANALYTICS
-- ============================================================

WITH project_summary AS (
    SELECT
        ep.employee_id,
        SUM(ep.hours_worked) AS total_hours
    FROM employee_projects AS ep
    GROUP BY ep.employee_id
)
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    ps.total_hours,
    DENSE_RANK() OVER (
        ORDER BY ps.total_hours DESC
    ) AS productivity_rank
FROM employees AS e
INNER JOIN project_summary AS ps
    ON e.employee_id = ps.employee_id
ORDER BY productivity_rank;
