-- Get employees born between 1952 and 1955.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Get employees born in 1952.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Get employees born in 1953.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Get employees born in 1954.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Get employees born in 1955.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Get employees between 1952 and 1955 who were hired between 1985 and 1988.
-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create retirement_info table for retirement eligibility information.
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Drop retirement_info table.
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no=dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables with table nicknames.
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining departments and dept_manager tables with table nicknames.
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables.
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_count_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

-- Create emp_info table.
SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');
	
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-- Create dept_info table
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- Create a query that will return only employees in the Sales department.
SELECT emp_no,
first_name,
last_name,
dept_name
FROM dept_info
WHERE dept_name = 'Sales';

-- Create a query that will return employees in the Sales and Development departments.
SELECT emp_no,
first_name,
last_name,
dept_name
FROM dept_info
WHERE dept_name IN ('Sales', 'Development');






-- CHALLENGE PART 1 QUERIES BELOW

-- Retrive the emp_no, first_name, and last_name columns of Employees table.
SELECT emp_no, first_name, last_name
FROM employees

-- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title, from_date, to_date
FROM titles

-- Create retirement_titles table by joining employees and titles.
SELECT  e.emp_no,
        e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM employees AS e
    INNER JOIN titles AS t
        ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;
-- Check retirement_titles table
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;
-- Check unique_titles table
SELECT * FROM unique_titles;

-- Retrieve the number of employees by their most recent job title who are about to retire.
-- Number of employees retiring
SELECT COUNT(title), title
-- INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;
-- Check retiring_titles table.
SELECT * FROM retiring_titles;

-- Create a mentorship eligibility table.
SELECT DISTINCT ON (e.emp_no)
e.emp_no, 
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
-- INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
	INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY emp_no ASC;
-- Check mentorship_eligibility table.
SELECT * FROM mentorship_eligibility;

-- Challenge Summary: Count & group by title for mentorship-eligible employees.
SELECT COUNT (emp_no), title
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC;

-- Challenge Summary: How long have those retiring been with the company.
SELECT * FROM retirement_titles;
SELECT COUNT (emp_no), from_date
FROM retirement_titles
GROUP BY from_date
ORDER BY from_date ASC;

-- Create new retirement_tenure table for binning of start year.
CREATE TABLE retirement_tenure
AS
SELECT * 
FROM retirement_titles;

ALTER TABLE retirement_tenure
  ADD COLUMN from_date_bins text;
  
SELECT * FROM retirement_tenure;
  
UPDATE retirement_tenure
	SET from_date_bins = '1985' WHERE (from_date BETWEEN '1985-01-01' AND '1985-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1986' WHERE (from_date BETWEEN '1986-01-01' AND '1986-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1987' WHERE (from_date BETWEEN '1987-01-01' AND '1987-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1988' WHERE (from_date BETWEEN '1988-01-01' AND '1988-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1989' WHERE (from_date BETWEEN '1989-01-01' AND '1989-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1990' WHERE (from_date BETWEEN '1990-01-01' AND '1990-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1991' WHERE (from_date BETWEEN '1991-01-01' AND '1991-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1992' WHERE (from_date BETWEEN '1992-01-01' AND '1992-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1993' WHERE (from_date BETWEEN '1993-01-01' AND '1993-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1994' WHERE (from_date BETWEEN '1994-01-01' AND '1994-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1995' WHERE (from_date BETWEEN '1995-01-01' AND '1995-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1996' WHERE (from_date BETWEEN '1996-01-01' AND '1996-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1997' WHERE (from_date BETWEEN '1997-01-01' AND '1997-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1998' WHERE (from_date BETWEEN '1998-01-01' AND '1998-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '1999' WHERE (from_date BETWEEN '1999-01-01' AND '1999-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '2000' WHERE (from_date BETWEEN '2000-01-01' AND '2000-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '2001' WHERE (from_date BETWEEN '2001-01-01' AND '2001-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '2002' WHERE (from_date BETWEEN '2002-01-01' AND '2002-12-31');
UPDATE retirement_tenure
	SET from_date_bins = '2003' WHERE (from_date BETWEEN '2003-01-01' AND '2003-12-31');

SELECT * FROM retirement_tenure;
	
-- Count retiring employees by starting year.
SELECT COUNT (emp_no), from_date_bins
FROM retirement_tenure
GROUP BY from_date_bins
ORDER BY from_date_bins ASC;