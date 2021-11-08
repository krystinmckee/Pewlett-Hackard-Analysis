-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
ORDER BY _____, _____ DESC;

-- Create retirement_titles table
--RETIREMENT_TITLES
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
	ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
--UNIQUE_TITLES
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;


-- RETIRING_TITLES
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;


-- MENTORSHIP_ELIGIBILITY
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
e.first_name, 
e.last_name, 
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
	ON de.emp_no = e.emp_no
INNER JOIN titles AS t
	ON t.emp_no = e.emp_no
WHERE (e.birth_date between '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;


-- RETIRING DEPARTMENTS 
SELECT DISTINCT ON (de.emp_no) de.emp_no, de.dept_no, de.from_date, de.to_date, ut.first_name, ut.last_name, ut.title
INTO retiring_departments
FROM dept_emp AS de
INNER JOIN unique_titles as ut ON ut.emp_no = de.emp_no
ORDER BY de.emp_no, de.to_date DESC;

SELECT COUNT(rd.emp_no), rd.dept_no, d.dept_name
FROM retiring_departments as rd
INNER JOIN departments as d on d.dept_no = rd.dept_no
GROUP BY rd.dept_no, d.dept_name
ORDER BY COUNT(rd.dept_no) DESC;


-- RETIRING SALARIES BY TITLE
SELECT AVG(s.salary), ut.title  FROM unique_titles AS ut
LEFT JOIN salaries AS s on ut.emp_no = s.emp_no
GROUP BY ut.title;
