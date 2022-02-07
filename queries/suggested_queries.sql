--Suggested Queries

--Find the count of mentorship_eligibility by title
SELECT COUNT(emp_no), title FROM mentorship_eligibility
GROUP BY title
ORDER BY COUNT(emp_no) DESC

--Find the count of retiring employees by department
SELECT d.dept_name, COUNT(d.dept_no)
FROM retirement_info as ri
JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no
GROUP BY dept_name
ORDER BY COUNT(d.dept_no) DESC

--Find the count of mentorship eligibility by department
SELECT d.dept_name, COUNT(d.dept_no)
FROM mentorship_eligibility as me
JOIN dept_emp AS de
ON me.emp_no = de.emp_no
JOIN departments AS d
ON de.dept_no = d.dept_no
GROUP BY dept_name
ORDER BY COUNT(d.dept_no) DESC